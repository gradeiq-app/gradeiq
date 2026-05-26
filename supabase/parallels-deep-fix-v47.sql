-- =============================================================================
-- parallels-deep-fix-v47.sql
-- One set corrected:
--
-- 1. Panini Certified Basketball
--    (brand='Panini', set_name='Certified', sport='basketball')
--    13 rows — DB years 2012-2024
--
-- Naming history:
--   2012-2017: "Totally Certified Basketball" (Panini/Donruss brand)
--   2018-2020: "Certified Basketball" (rebranded, streamlined parallels)
--   2021-2023: No product released (season disruption / license transition)
--   2024:      "Totally Certified Basketball" relaunched as retail product
--
-- Parallel eras:
--   - 2012-2013: "Totally" prefix on all parallels; 5-tier numbered ladder
--                2012: Red /499, Blue /299, Gold /25, Green /5, Black 1/1
--                2013: Tighter runs: Red /99, Blue /49, Gold /25, Green /5, Black 1/1
--   - 2014:      Renamed to "Certified"; Platinum base parallels (Red /279…)
--                + Mirror Platinum die-cut tier (Red /135, Blue /74…)
--   - 2015-2017: Mirror-branded color parallels; Holo Blue 1/1 replaces Black 1/1
--                2015: 7-tier (Red /149 … Holo Blue 1/1)
--                2016: 7-tier (Red /199 … Holo Blue 1/1)
--                2017: 6-tier (Purple unnumb … Holo Blue 1/1)
--   - 2018-2020: Mirror (unnumb) + 7-tier color ladder; Black 1/1 returns
--   - 2021-2023: Placeholder (no product released)
--   - 2024:      Totally Certified relaunch — 4 unnumbered Mirror color variants
--                + 8-tier numbered ladder + Platinum 1/1 variants
--
-- Sources: Cardboard Connection, Beckett, PSA Registry
-- =============================================================================

-- ─── 2012: Totally Certified Basketball debut ─────────────────────────────────

-- 2012 Totally Certified Basketball (debut product under Panini license).
-- All parallels use "Totally" prefix. High-volume runs — flagship hobby product.
-- Totally Red /499 (2 per box), Blue /299, Gold /25, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Totally Red /499","ebay_kw":"Totally Red"},
  {"label":"Totally Blue /299","ebay_kw":"Totally Blue"},
  {"label":"Totally Gold /25","ebay_kw":"Totally Gold"},
  {"label":"Totally Green /5","ebay_kw":"Totally Green"},
  {"label":"Totally Black 1/1","ebay_kw":"Totally Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2012;

-- ─── 2013: Tighter print runs ────────────────────────────────────────────────

-- 2013 Totally Certified Basketball.
-- Print runs significantly cut: Red /99 (from /499), Blue /49 (from /299).
-- Gold/Green/Black unchanged at /25, /5, 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Totally Red /99","ebay_kw":"Totally Red"},
  {"label":"Totally Blue /49","ebay_kw":"Totally Blue"},
  {"label":"Totally Gold /25","ebay_kw":"Totally Gold"},
  {"label":"Totally Green /5","ebay_kw":"Totally Green"},
  {"label":"Totally Black 1/1","ebay_kw":"Totally Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2013;

-- ─── 2014: Rebranded as Certified; Platinum parallels + Mirror Platinum die-cuts

-- 2014 Certified Basketball (dropped "Totally" branding).
-- Standard "Platinum" color parallels: Red /279, Blue /149, Purple /49, Gold /10,
--   Green /5, Black 1/1.
-- Separate "Mirror Platinum" die-cut insert (holographic foil die-cuts):
--   Red /135, Blue /74, Purple /25, Gold /10.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Platinum Red /279","ebay_kw":"Platinum Red"},
  {"label":"Platinum Blue /149","ebay_kw":"Platinum Blue"},
  {"label":"Platinum Purple /49","ebay_kw":"Platinum Purple"},
  {"label":"Platinum Gold /10","ebay_kw":"Platinum Gold"},
  {"label":"Platinum Green /5","ebay_kw":"Platinum Green"},
  {"label":"Platinum Black 1/1","ebay_kw":"Platinum Black"},
  {"label":"Mirror Platinum Red /135","ebay_kw":"Mirror Platinum Red"},
  {"label":"Mirror Platinum Blue /74","ebay_kw":"Mirror Platinum Blue"},
  {"label":"Mirror Platinum Purple /25","ebay_kw":"Mirror Platinum Purple"},
  {"label":"Mirror Platinum Gold /10","ebay_kw":"Mirror Platinum Gold"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2014;

-- ─── 2015: Mirror color parallels; 7-tier ladder ─────────────────────────────

-- 2015 Certified Basketball.
-- "Mirror" branding adopted for color parallels (matching football product).
-- Mirror Red /149, Blue /99, Purple /50, Camo /25, Gold /10, Green /5, Holo Blue 1/1.
-- (Holo Blue replaces Black as super-short 1/1.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Red /149","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /99","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Purple /50","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Camo /25","ebay_kw":"Mirror Camo"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Holo Blue 1/1","ebay_kw":"Mirror Holo Blue"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2015;

-- ─── 2016: Red /199; Orange /60 replaces Purple /50 ──────────────────────────

-- 2016 Certified Basketball.
-- Red raised to /199 (from /149). Orange /60 added (Purple /50 removed).
-- Camo /25, Gold /10, Green /5, Holo Blue 1/1 unchanged.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Red /199","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /99","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Orange /60","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Camo /25","ebay_kw":"Mirror Camo"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Holo Blue 1/1","ebay_kw":"Mirror Holo Blue"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2016;

-- ─── 2017: Purple unnumbered as entry-level tier ──────────────────────────────

-- 2017 Totally Certified Basketball (Panini reinstated "Totally" branding).
-- Purple unnumbered (retail-friendly entry-level), Blue /99, Camo /25,
-- Gold /10, Green /5, Holo Blue 1/1. Dropped Red and Orange.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Purple","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Blue /99","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Camo /25","ebay_kw":"Mirror Camo"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Holo Blue 1/1","ebay_kw":"Mirror Holo Blue"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2017;

-- ─── 2018: Rebranded as Certified again; Mirror unnumb + full color ladder ────

-- 2018 Certified Basketball (back to non-"Totally" name).
-- Mirror (unnumbered) as base tier. Full color ladder with Black 1/1 return.
-- Mirror Red /299, Blue /199, Orange /99, Purple /49, Gold /10, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror","ebay_kw":"Mirror"},
  {"label":"Mirror Red /299","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /199","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Orange /99","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Purple /49","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2018;

-- ─── 2019: Mirror Blue unnumb; Red and Orange both /99 ───────────────────────

-- 2019 Certified Basketball.
-- Mirror Blue unnumbered (replaces generic Mirror). Red /99 and Orange /99.
-- Camo /25 returns; Gold /10, Green /5, Black 1/1 unchanged.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Blue","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Orange /99","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Camo /25","ebay_kw":"Mirror Camo"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020: Same structure as 2019 ────────────────────────────────────────────

-- 2020 Certified Basketball.
-- Same parallel structure as 2019 (Mirror Blue unnumb, Red /99, Orange /99,
-- Camo /25, Gold /10, Green /5, Black 1/1). No structural changes.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Blue","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Orange /99","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Camo /25","ebay_kw":"Mirror Camo"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021-2023: No product released (placeholder rows) ───────────────────────

-- No Panini Certified Basketball product in 2021-22, 2022-23, or 2023-24 seasons.
-- (Panini wound down several mid-tier basketball products in this period.)
UPDATE card_sets SET parallels = '[{"label":"Base","ebay_kw":""}]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year BETWEEN 2021 AND 2023;

-- ─── 2024: Totally Certified Basketball relaunch (retail product) ─────────────

-- 2024-25 Totally Certified Basketball (retail-focused relaunch).
-- 4 unnumbered Mirror color variants (hobby exclusive base foils).
-- Numbered ladder: Neon Orange /299, Blue /199, Red /149, Pink /125,
--   Platinum /25, Gold /10.
-- Ultra-short: Mirror Platinum Black 1/1, Mirror Platinum Nebula 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror","ebay_kw":"Mirror"},
  {"label":"Mirror Bronze","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Maroon","ebay_kw":"Mirror Maroon"},
  {"label":"Mirror Purple","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Neon Orange /299","ebay_kw":"Mirror Neon Orange"},
  {"label":"Mirror Blue /199","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Red /149","ebay_kw":"Mirror Red"},
  {"label":"Mirror Pink /125","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Platinum /25","ebay_kw":"Mirror Platinum"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Platinum Black 1/1","ebay_kw":"Mirror Platinum Black"},
  {"label":"Mirror Platinum Nebula 1/1","ebay_kw":"Mirror Platinum Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball'
  AND year = 2024;
