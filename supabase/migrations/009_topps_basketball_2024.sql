-- ============================================================
-- 009_topps_basketball_2024.sql
--
-- Gap fill: Topps/Bowman/Fanatics NBA basketball sets for
-- DB year 2024 (= 2023-24 NBA season, calendar releases 2024).
--
-- Background: Topps/Fanatics won the NBA trading card license
-- starting with the 2023-24 season.  The DB already contains
-- these brands at year=2025 (2024-25 season).  The entire
-- 2023-24 product slate (year=2024) was missing.
--
-- Sets added (13):
--   Topps: Basketball, Chrome Basketball, Chrome Sapphire,
--          Cosmic Chrome, Finest Basketball, Holiday, Midnight,
--          NBA Hoops, Signature Class, Topps 3
--   Bowman: Basketball, Sapphire
--   Donruss: Basketball  (Topps-era Donruss, brand = 'Donruss')
--
-- Parallel templates cloned from matching year=2025 sets.
-- ============================================================

-- ── 1. Insert 2024 sets — clone parallel_templates from 2025 ─────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels)
SELECT 'basketball', 2024, brand, set_name, parallels
FROM public.card_sets_legacy
WHERE sport = 'basketball'
  AND year  = 2025
  AND brand IN ('Topps', 'Bowman', 'Donruss')
  AND set_name IN (
    'Basketball',
    'Chrome Basketball',
    'Chrome Sapphire',
    'Cosmic Chrome',
    'Finest Basketball',
    'Holiday',
    'Midnight',
    'NBA Hoops',
    'Signature Class',
    'Topps 3',
    'Sapphire'
  )
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 2. Sync to sets table ─────────────────────────────────────────────────────
INSERT INTO public.sets (sport_id, year, manufacturer_id, name)
SELECT
  sp.id,
  cl.year,
  m.id,
  cl.set_name
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE cl.sport = 'basketball'
  AND cl.year  = 2024
  AND cl.brand IN ('Topps', 'Bowman', 'Donruss')
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;

-- ── 3. Refresh parallel_templates for the new sets ────────────────────────────
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name
  AND cl.sport          = 'basketball'
  AND cl.year           = 2024
  AND cl.brand IN ('Topps', 'Bowman', 'Donruss');
