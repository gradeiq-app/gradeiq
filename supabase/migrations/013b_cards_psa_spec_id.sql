-- 013b_cards_psa_spec_id.sql — DEFERRED. DO NOT APPLY WHILE PID 24540 RUNS.
--
-- Adds cards.psa_spec_id + partial index. Requires AccessExclusive on
-- public.cards, which conflicts with the parallel backfill's continuous
-- AccessShare. Apply this only after PID 24540 logs `=== SUMMARY ===`
-- and the DB has settled (no chunks running for ~30s).
--
-- The split from 013a was forced by six failed retries on 55P03 lock_timeout
-- while the backfill was on set 65/121 with chunks failing on
-- statement_timeout every ~2 minutes. See scripts/_psa-scrape-notes-2026-05-27.md.
--
-- After the ALTER lands, backfill the column using the SpecID journal
-- accumulated by the Phase 1 scraper:
--   scripts/_psa_specs_2024_topps_chrome_fb.jsonl
-- Each line: {"card_id": "<uuid>", "psa_spec_id": "<int>"}
-- Backfill via scripts/apply_013b_journal_backfill.py (writes UPDATE
-- statements from the journal in batches).
--
-- This file contains only the schema change. The per-card UPDATE values
-- come from the journal — they're not embedded here because the journal
-- doesn't exist until Phase 1C runs.

BEGIN;

SET LOCAL lock_timeout = '4s';

ALTER TABLE public.cards
  ADD COLUMN IF NOT EXISTS psa_spec_id text;

CREATE INDEX IF NOT EXISTS cards_psa_spec_id_idx
  ON public.cards (psa_spec_id) WHERE psa_spec_id IS NOT NULL;

COMMIT;
