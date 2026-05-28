-- 014_cards_game_date.sql
-- Adds cards.game_date — the date the card commemorates, for date-driven
-- card products.
--
-- Why this column:
--   A growing class of products attaches cards to specific real-world game
--   dates rather than to a generic "set checklist position". The first
--   one we hit is Upper Deck 2022-23 Series 2 "Monster Season" — 82
--   inserts (MS-1 through MS-82), one card per McDavid game date,
--   numbered in date-order across the 2022-23 NHL season. Other expected
--   products: Topps Now (daily MLB), UD Game Dated Moments, similar
--   live-stat hockey/baseball lines.
--
--   Pre-this-migration, the Beckett scraper captured these dates by
--   creating fake-player rows ("Connor McDavid - 1/11/2023" etc.).
--   That moved date-as-identity into player.name where it shouldn't
--   have lived. Moving it to cards.game_date lets the 82 fake rows
--   collapse onto the canonical Connor McDavid while preserving the
--   per-card date attribution.
--
-- Why nullable:
--   Most cards don't have a date (a base Topps Series #245 just is
--   what it is, no date). Nullable + no default = metadata-only ADD
--   COLUMN on the 12M-row cards table; instant, no rewrite.
--
-- Why NO index (yet):
--   No live query patterns sort or filter by game_date today. Adding the
--   index later, when a query path emerges, is a single CREATE INDEX
--   IF NOT EXISTS — cheap. The 013b/013d partial indexes existed because
--   pop-report lookups query by spec_id; that justification doesn't
--   apply to game_date today.
--
-- Dispositive backfill check for the McDavid set (and any future
-- set with sequential date-numbered cards): ORDER BY game_date ASC
-- must produce the same id sequence as ORDER BY card_number ASC
-- (with MS-N or similar parsed as integer). Phase 0 verified this
-- invariant holds across all 82 McDavid game dates with 0 breaks.

BEGIN;

SET LOCAL lock_timeout = '4s';

ALTER TABLE public.cards
  ADD COLUMN IF NOT EXISTS game_date date;

COMMIT;
