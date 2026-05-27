-- 015a_card_reference_image.sql
-- Adds reference_image_* columns to cards for the eBay Browse API
-- Phase 1 prototype. Schema is grader/source-agnostic from day one —
-- the source column will hold 'ebay' in Phase 1, but 'psa', 'tcdb',
-- 'user-upload', etc. slot in without DDL.
--
-- Lock-conflict context: pure ALTER on cards. PID 24540 (parallel
-- backfill) INSERTs only into parallels, so it should not block this
-- ALTER. Using the SET LOCAL lock_timeout = '4s' pattern from 013a as
-- defense-in-depth; if the ALTER fails repeatedly (55P03), defer to
-- 015b and let the scraper journal images to JSONL until the column
-- lands.
--
-- The partial index targets "cards that already have a reference
-- image" — useful for refresh-by-age sweeps and for skipping already-
-- populated rows in re-scrape runs.

BEGIN;

SET LOCAL lock_timeout = '4s';

ALTER TABLE public.cards ADD COLUMN IF NOT EXISTS reference_image_url         TEXT;
ALTER TABLE public.cards ADD COLUMN IF NOT EXISTS reference_image_source      TEXT;
ALTER TABLE public.cards ADD COLUMN IF NOT EXISTS reference_image_listing_url TEXT;
ALTER TABLE public.cards ADD COLUMN IF NOT EXISTS reference_image_fetched_at  TIMESTAMPTZ;

CREATE INDEX IF NOT EXISTS cards_reference_image_idx
  ON public.cards (id) WHERE reference_image_url IS NOT NULL;

COMMIT;
