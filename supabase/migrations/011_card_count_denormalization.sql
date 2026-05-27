-- 011_card_count_denormalization.sql
-- Phase 1 of card_count denormalization: schema + trigger only.
--
-- Adds sets.card_count (default 0) and a per-row INSERT/DELETE trigger on
-- cards that keeps it accurate for NEW writes. Backfill of EXISTING rows
-- lives in 012_card_count_backfill.sql so this phase stays lock-light:
-- no big UPDATE competing for IO with the in-flight parallel backfill,
-- no big UPDATE that risks statement_timeout rolling back the schema add.
--
-- Safe to apply during the parallel backfill — the trigger fires on cards
-- INSERT/DELETE, but the backfill only INSERTs into parallels.
--
-- Behavior between phases:
--   After 011: card_count = 0 on all existing rows; trigger keeps it
--     accurate for any new INSERT/DELETE on cards. Routes that filter on
--     card_count see all rows as "non-contaminated" (since 0 doesn't match
--     any magic signature) — equivalent to no-filter behavior.
--   After 012: card_count matches the real per-set count; filter works.
--
-- Trigger gaps to know about:
--   - INSERT/DELETE only. A bulk UPDATE that moves cards between sets
--     (cards.set_id reassignment) would leave both sides stale. Add an
--     UPDATE branch if that pattern shows up.
--   - TRUNCATE bypasses triggers. A full reload of cards needs re-running
--     012's backfill.

BEGIN;

ALTER TABLE public.sets
  ADD COLUMN IF NOT EXISTS card_count INTEGER NOT NULL DEFAULT 0;

CREATE OR REPLACE FUNCTION public.sync_set_card_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE public.sets SET card_count = card_count + 1 WHERE id = NEW.set_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE public.sets SET card_count = card_count - 1 WHERE id = OLD.set_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS cards_sync_set_card_count ON public.cards;
CREATE TRIGGER cards_sync_set_card_count
  AFTER INSERT OR DELETE ON public.cards
  FOR EACH ROW EXECUTE FUNCTION public.sync_set_card_count();

CREATE INDEX IF NOT EXISTS sets_card_count_idx ON public.sets (card_count);

COMMIT;
