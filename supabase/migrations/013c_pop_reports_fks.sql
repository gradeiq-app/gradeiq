-- 013c_pop_reports_fks.sql — DEFERRED. DO NOT APPLY WHILE PID 24540 RUNS.
--
-- Adds the foreign-key constraints that 013a deferred. Each ADD CONSTRAINT
-- needs ShareRowExclusive on its referenced table, which conflicts with
-- the parallel backfill's RowExclusive on `parallels` (and any concurrent
-- writes on cards / sets). Apply after PID 24540 logs `=== SUMMARY ===`
-- and the DB is calm (~30s with no chunks running).
--
-- All three constraints use NOT VALID — skips the scan of existing rows
-- and only acquires the lock briefly to register the trigger. Existing
-- rows are validated separately via VALIDATE CONSTRAINT, which only takes
-- ShareUpdateExclusive (concurrent reads/writes still work) — but Phase 1
-- pop_reports will have only ~3k rows total, so validation is fast and
-- safe to run inline.

BEGIN;

SET LOCAL lock_timeout = '4s';

ALTER TABLE public.pop_reports
  ADD CONSTRAINT pop_reports_card_id_fkey
  FOREIGN KEY (card_id) REFERENCES public.cards(id) ON DELETE CASCADE
  NOT VALID;

ALTER TABLE public.pop_reports
  ADD CONSTRAINT pop_reports_parallel_id_fkey
  FOREIGN KEY (parallel_id) REFERENCES public.parallels(id)
  NOT VALID;

ALTER TABLE public.psa_set_mappings
  ADD CONSTRAINT psa_set_mappings_rawiq_set_id_fkey
  FOREIGN KEY (rawiq_set_id) REFERENCES public.sets(id) ON DELETE CASCADE
  NOT VALID;

-- Validate existing rows. Cheap (~3k rows expected from Phase 1) and uses
-- a lighter lock (ShareUpdateExclusive) than the original ADD CONSTRAINT
-- would have, so concurrent reads/writes on the referenced tables continue.
ALTER TABLE public.pop_reports VALIDATE CONSTRAINT pop_reports_card_id_fkey;
ALTER TABLE public.pop_reports VALIDATE CONSTRAINT pop_reports_parallel_id_fkey;
ALTER TABLE public.psa_set_mappings VALIDATE CONSTRAINT psa_set_mappings_rawiq_set_id_fkey;

COMMIT;
