-- 013a_pop_reports_tables.sql
-- Phase 1 of pop-report schema: NEW TABLES ONLY, with FKs to other NEW
-- tables only (graders). FKs to existing tables (cards, parallels, sets)
-- are DEFERRED to 013c.
--
-- Lock-conflict history:
--   - Initial 013 with all FKs failed 6x on 55P03 (lock_timeout) ─ blamed
--     it on cards.psa_spec_id ALTER, split to 013b.
--   - 013a with FKs to cards/parallels/sets still failed 6x ─ root cause
--     is `REFERENCES parallels(id)` and `REFERENCES sets(id)`, which need
--     ShareRowExclusive on those tables. ShareRowExclusive conflicts with
--     RowExclusive (parallel backfill INSERTs into parallels) and Share
--     (some sets reads), so the constraint-add waits for a full chunk
--     gap — and PID 24540's chunks run continuously.
--
-- Three companion files DEFERRED until PID 24540 exits cleanly:
--   013b_cards_psa_spec_id.sql        — cards.psa_spec_id column + index
--   013c_pop_reports_fks.sql          — re-add FKs to cards, parallels, sets
--
-- Multi-grader rationale: schema is grader-agnostic from day one. PSA seeds
-- here; BGS/SGC/CGC seed too so future grader scrapers slot in without DDL.

BEGIN;

SET LOCAL lock_timeout = '4s';

-- ── graders ──────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.graders (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name             text NOT NULL UNIQUE,
  slug             text NOT NULL UNIQUE,
  full_name        text,
  website          text,
  uses_subgrades   boolean NOT NULL DEFAULT false,
  uses_half_points boolean NOT NULL DEFAULT true,
  max_grade        numeric(3,1) NOT NULL DEFAULT 10.0,
  is_active        boolean NOT NULL DEFAULT true,
  created_at       timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.graders ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read graders" ON public.graders;
CREATE POLICY "Public read graders"
  ON public.graders FOR SELECT USING (true);

INSERT INTO public.graders (name, slug, full_name, website, uses_subgrades, uses_half_points, max_grade)
VALUES
  ('PSA', 'psa', 'Professional Sports Authenticator', 'https://www.psacard.com', false, true,  10.0),
  ('BGS', 'bgs', 'Beckett Grading Services',          'https://www.beckett.com', true,  true,  10.0),
  ('SGC', 'sgc', 'Sportscard Guaranty Company',       'https://www.gosgc.com',   false, true,  10.0),
  ('CGC', 'cgc', 'CGC Cards',                          'https://www.cgccards.com', false, true,  10.0)
ON CONFLICT (slug) DO NOTHING;

-- ── pop_reports ──────────────────────────────────────────────────────────────
-- card_id and parallel_id are typed uuid but NOT FK-constrained yet — the
-- constraints land in 013c after PID 24540 finishes (FK creation needs
-- ShareRowExclusive on the referenced table, which conflicts with the
-- backfill's RowExclusive on parallels).
CREATE TABLE IF NOT EXISTS public.pop_reports (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  card_id          uuid NOT NULL,
  grader_id        uuid NOT NULL REFERENCES public.graders(id),
  parallel_id      uuid,
  grade            numeric(3,1) NOT NULL,
  qualifier        text,
  count            integer NOT NULL DEFAULT 0,
  source           text NOT NULL,
  source_url       text,
  last_scraped_at  timestamptz NOT NULL DEFAULT now(),
  created_at       timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT pop_reports_unique_grade
    UNIQUE (card_id, grader_id, parallel_id, grade, qualifier)
);

ALTER TABLE public.pop_reports ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read pop_reports" ON public.pop_reports;
CREATE POLICY "Public read pop_reports"
  ON public.pop_reports FOR SELECT USING (true);

CREATE INDEX IF NOT EXISTS pop_reports_card_idx
  ON public.pop_reports (card_id);
CREATE INDEX IF NOT EXISTS pop_reports_grader_card_idx
  ON public.pop_reports (grader_id, card_id);

-- ── grader_service_tiers ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.grader_service_tiers (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  grader_id            uuid NOT NULL REFERENCES public.graders(id),
  tier_name            text NOT NULL,
  declared_value_max   numeric(10,2),
  base_price           numeric(10,2) NOT NULL,
  turnaround_days      integer,
  effective_from       date NOT NULL,
  effective_to         date,
  CONSTRAINT grader_service_tiers_unique
    UNIQUE (grader_id, tier_name, effective_from)
);

ALTER TABLE public.grader_service_tiers ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read grader_service_tiers" ON public.grader_service_tiers;
CREATE POLICY "Public read grader_service_tiers"
  ON public.grader_service_tiers FOR SELECT USING (true);

-- ── psa_set_mappings ─────────────────────────────────────────────────────────
-- Despite the name, this is the generic external-grader set-mapping table
-- (PSA-named because PSA is the first integration; rows for BGS/SGC/CGC
-- will live here too via grader_id).
-- rawiq_set_id is typed uuid but NOT FK-constrained yet (lands in 013c).
CREATE TABLE IF NOT EXISTS public.psa_set_mappings (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rawiq_set_id      uuid NOT NULL,
  grader_id         uuid NOT NULL REFERENCES public.graders(id),
  external_set_id   text NOT NULL,
  external_set_url  text,
  match_confidence  text,
  created_at        timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT psa_set_mappings_unique
    UNIQUE (rawiq_set_id, grader_id)
);

ALTER TABLE public.psa_set_mappings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read psa_set_mappings" ON public.psa_set_mappings;
CREATE POLICY "Public read psa_set_mappings"
  ON public.psa_set_mappings FOR SELECT USING (true);

-- cards.psa_spec_id ALTER + index moved to 013b_cards_psa_spec_id.sql.

COMMIT;
