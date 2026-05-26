-- ============================================================
-- RawIQ — Phase 2 & 3 Seed
-- Migration 004:
--   1. Add missing manufacturer entries (Prizm)
--   2. Add Panini Prizm Hockey 2022-2024 to card_sets_legacy
--   3. Add parallel_templates JSONB column to sets
--   4. Copy parallel templates from card_sets_legacy → sets
--   5. Sync new legacy rows into sets table
-- ============================================================

-- ── 1. Missing manufacturer entries ──────────────────────────────────────────
INSERT INTO public.manufacturers (name, slug) VALUES
  ('Prizm', 'prizm')   -- Panini sub-brand; own entry for future catalog filtering
ON CONFLICT (slug) DO NOTHING;

-- ── 2. Panini Prizm Hockey (2022-2024) ───────────────────────────────────────
-- Panini obtained a joint NHL license for the 2022-23 season.
-- DB year convention: DB year = season start year.
-- 2025 placeholder — license status unconfirmed for 2025-26.

DO $$
DECLARE
  prizm_hockey_2022 jsonb := '[
    {"label":"Base",                "ebay_kw":""},
    {"label":"Silver Prizm",        "ebay_kw":"Silver Prizm"},
    {"label":"Ice Prizm",           "ebay_kw":"Ice Prizm"},
    {"label":"Red Prizm /99",       "ebay_kw":"Red Prizm"},
    {"label":"Purple Prizm /75",    "ebay_kw":"Purple Prizm"},
    {"label":"Green Prizm /25",     "ebay_kw":"Green Prizm"},
    {"label":"Gold Prizm /10",      "ebay_kw":"Gold Prizm"},
    {"label":"Black Prizm /1",      "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  prizm_hockey_2023 jsonb := '[
    {"label":"Base",                "ebay_kw":""},
    {"label":"Silver Prizm",        "ebay_kw":"Silver Prizm"},
    {"label":"Ice Prizm",           "ebay_kw":"Ice Prizm"},
    {"label":"Neon Green Prizm /99","ebay_kw":"Neon Green Prizm"},
    {"label":"Red Prizm /99",       "ebay_kw":"Red Prizm"},
    {"label":"Blue Prizm /49",      "ebay_kw":"Blue Prizm"},
    {"label":"Purple Prizm /49",    "ebay_kw":"Purple Prizm"},
    {"label":"Green Prizm /25",     "ebay_kw":"Green Prizm"},
    {"label":"Orange Prizm /15",    "ebay_kw":"Orange Prizm"},
    {"label":"Gold Prizm /10",      "ebay_kw":"Gold Prizm"},
    {"label":"Black Prizm /1",      "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  prizm_hockey_2024 jsonb := '[
    {"label":"Base",                "ebay_kw":""},
    {"label":"Silver Prizm",        "ebay_kw":"Silver Prizm"},
    {"label":"Ice Prizm",           "ebay_kw":"Ice Prizm"},
    {"label":"Hyper Prizm",         "ebay_kw":"Hyper Prizm"},
    {"label":"Neon Green Prizm /99","ebay_kw":"Neon Green Prizm"},
    {"label":"Red Prizm /99",       "ebay_kw":"Red Prizm"},
    {"label":"Blue Prizm /49",      "ebay_kw":"Blue Prizm"},
    {"label":"Purple Prizm /49",    "ebay_kw":"Purple Prizm"},
    {"label":"Green Prizm /25",     "ebay_kw":"Green Prizm"},
    {"label":"Orange Prizm /15",    "ebay_kw":"Orange Prizm"},
    {"label":"Gold Prizm /10",      "ebay_kw":"Gold Prizm"},
    {"label":"Black Prizm /1",      "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  placeholder jsonb := '[{"label":"Base","ebay_kw":""}]'::jsonb;

BEGIN
  INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
    ('hockey', 2022, 'Panini', 'Prizm', prizm_hockey_2022),
    ('hockey', 2023, 'Panini', 'Prizm', prizm_hockey_2023),
    ('hockey', 2024, 'Panini', 'Prizm', prizm_hockey_2024),
    ('hockey', 2025, 'Panini', 'Prizm', placeholder)
  ON CONFLICT (sport, year, brand, set_name) DO UPDATE
    SET parallels = EXCLUDED.parallels;
END $$;

-- ── 3. Add parallel_templates column to sets ──────────────────────────────────
ALTER TABLE public.sets
  ADD COLUMN IF NOT EXISTS parallel_templates jsonb NOT NULL DEFAULT '[]'::jsonb;

-- ── 4. Copy parallel templates from card_sets_legacy → sets ──────────────────
-- Match on (sport_id, year, manufacturer_id, name).
-- After this UPDATE, sets.parallel_templates mirrors card_sets_legacy.parallels.
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name;

-- ── 5. Sync new card_sets_legacy rows into sets ───────────────────────────────
-- Picks up the 4 new Panini Prizm Hockey rows added in step 2.
INSERT INTO public.sets (sport_id, year, manufacturer_id, name, parallel_templates, created_at)
SELECT
  sp.id,
  cl.year,
  m.id,
  cl.set_name,
  cl.parallels,
  cl.created_at
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;

-- ── 6. Verify ─────────────────────────────────────────────────────────────────
SELECT
  'sets with parallel_templates populated' AS metric,
  COUNT(*)::text AS value
FROM public.sets
WHERE jsonb_array_length(parallel_templates) > 0
UNION ALL
SELECT 'total sets', COUNT(*)::text FROM public.sets
UNION ALL
SELECT 'Panini Prizm Hockey rows',
       COUNT(*)::text
FROM public.sets s
JOIN public.sports sp       ON sp.id = s.sport_id
JOIN public.manufacturers m ON m.id  = s.manufacturer_id
WHERE sp.slug = 'hockey' AND m.name = 'Panini' AND s.name = 'Prizm';
