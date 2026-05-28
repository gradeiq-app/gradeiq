-- 013d_parallels_psa_spec_id.sql
-- Companion to 013b. Mirrors that file's shape on the `parallels` table.
--
-- Why this exists: the Phase 1 PSA pop scraper journal contains 107 PSA
-- SpecIDs for 2024 Topps Chrome Football — 14 base cards + 93 parallel
-- varieties (Blue/Gold/Pink/Sepia/Prism/Purple/Refractor variants etc.).
-- 013b's `cards.psa_spec_id` correctly holds the 14 base specs but cannot
-- hold the 93 parallel-specific ones (one card has many parallels, each
-- with its own PSA SpecID). Add the same column shape to `parallels`.
--
-- ADD COLUMN IF NOT EXISTS … text — metadata-only (nullable, no default).
-- Instant; no table rewrite on the 12M+ parallels rows.
--
-- Partial index on (psa_spec_id) WHERE NOT NULL — on an all-NULL column
-- this indexes zero rows, also instant.
--
-- Backfill lives in scripts/apply_psa_spec_backfill.py (writes UPDATEs
-- for both cards (14 rows) and parallels (93 rows) from the journal).
--
-- Per-grader-column pattern is interim. When a second grader (BGS/SGC)
-- lands, both this column and cards.psa_spec_id should migrate into a
-- grader-agnostic external_spec_ids table.

BEGIN;

SET LOCAL lock_timeout = '4s';

ALTER TABLE public.parallels
  ADD COLUMN IF NOT EXISTS psa_spec_id text;

CREATE INDEX IF NOT EXISTS parallels_psa_spec_id_idx
  ON public.parallels (psa_spec_id) WHERE psa_spec_id IS NOT NULL;

COMMIT;
