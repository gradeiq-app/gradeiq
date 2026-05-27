-- 012_card_count_backfill.sql
-- Phase 2 of card_count denormalization: backfill existing rows.
--
-- Apply AFTER:
--   1. 011_card_count_denormalization.sql has run (column + trigger exist).
--   2. scripts/seed_parallels_all.py has logged === SUMMARY === — running
--      this against a DB that's already IO-saturated will compound the load
--      and likely time out.
--
-- Why a single GROUP BY instead of per-set subqueries:
--   The previous draft did `SET card_count = (SELECT COUNT(*) FROM cards
--   WHERE set_id = s.id)` which fires ~5000 indexed COUNTs in one statement.
--   The single-pass aggregate below scans cards once and joins. Cheaper and
--   stays inside a sensible statement_timeout.
--
-- Why SET LOCAL statement_timeout:
--   The default Supabase statement_timeout is too short for a full-table
--   aggregate on millions of cards. LOCAL scope dies at COMMIT — no leak
--   into other sessions or autovacuum.
--
-- Idempotent: re-running just rewrites the same values. The trigger from
-- 011 keeps any concurrent INSERT/DELETE accurate, so the result is correct
-- as of COMMIT time.

BEGIN;

SET LOCAL statement_timeout = '30min';

WITH actual AS (
  SELECT s.id AS set_id, COALESCE(COUNT(c.id), 0)::int AS n
  FROM public.sets s
  LEFT JOIN public.cards c ON c.set_id = s.id
  GROUP BY s.id
)
UPDATE public.sets s
SET card_count = a.n
FROM actual a
WHERE a.set_id = s.id;

COMMIT;
