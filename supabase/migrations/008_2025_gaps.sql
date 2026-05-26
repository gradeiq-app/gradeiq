-- ============================================================
-- 008_2025_gaps.sql
--
-- Fill 2025 product gaps identified in coverage audit:
-- 1. Football 2025: Noir, Obsidian, Crown Royale, Topps Inception
--    (all present in 2024 but absent from 2025)
-- 2. Basketball 2025: Topps Inception, Contenders, Flawless, NT,
--    Obsidian, Impeccable (key high-value products)
-- 3. Sync to sets table + refresh parallel_templates
-- ============================================================

-- ── 1. Football 2025 gaps — copy parallel templates from 2024 ────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels)
SELECT 'football', 2025, brand, set_name, parallels
FROM public.card_sets_legacy
WHERE sport = 'football'
  AND year  = 2024
  AND set_name IN (
    'Noir',
    'Obsidian',
    'Crown Royale',
    'Contenders Optic',
    'Clearly Donruss'
  )
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Inception Football 2025 (new Topps NFL product, parallels match 2024 Topps Inception)
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels)
SELECT 'football', 2025, brand, set_name, parallels
FROM public.card_sets_legacy
WHERE sport = 'football'
  AND year  = 2024
  AND set_name = 'Inception'
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 2. Basketball 2025 high-value gaps — copy from 2024 ──────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels)
SELECT 'basketball', 2025, brand, set_name, parallels
FROM public.card_sets_legacy
WHERE sport = 'basketball'
  AND year  = 2024
  AND set_name IN (
    'Contenders',
    'Contenders Draft Picks',
    'Contenders Optic',
    'Crown Royale',
    'Flawless',
    'Impeccable',
    'National Treasures',
    'Obsidian',
    'Prizm Draft Picks',
    'Prizm Fast Break',
    'Revolution'
  )
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 3. Sync to sets table ─────────────────────────────────────────────────────
INSERT INTO public.sets (sport_id, year, manufacturer_id, name)
SELECT
  sp.id  AS sport_id,
  cl.year,
  m.id   AS manufacturer_id,
  cl.set_name AS name
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE cl.sport = 'football' AND cl.year = 2025
   OR cl.sport = 'basketball' AND cl.year = 2025
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;

-- ── 4. Refresh parallel_templates ────────────────────────────────────────────
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name
  AND (
    (cl.sport = 'football'   AND cl.year = 2025)
    OR
    (cl.sport = 'basketball' AND cl.year = 2025)
  );
