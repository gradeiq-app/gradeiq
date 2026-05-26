-- =============================================================================
-- parallels-deep-fix-v46.sql
-- One set corrected:
--
-- 1. Panini Certified Football
--    (brand='Panini', set_name='Certified', sport='football')
--    16 rows — DB years 2010-2025
--
-- Signature feature: "Mirror" parallels on holographic foil stock.
-- All parallels are serial-numbered; no unnumbered base parallels except
-- "Mirror Silver" in 2015 (unnumbered within its tier).
--
-- Parallel eras:
--   - 2010-2013: Simple 5-tier Mirror Red/Blue/Gold/Emerald/Black
--                (Mirror Red /250, Blue /100, Gold /25, Emerald /5, Black 1/1)
--   - 2014:      Mirror Red /249, Blue /99, Gold /25, Green /5, Black 1/1
--                + Camo hot box variants
--   - 2015:      Mirror Silver /499 added as base tier; Purple /10 added
--   - 2016:      Mirror /499 replaces Silver; Orange /225 added
--   - 2017:      Orange now /299 (up from /225); same 8-tier structure
--   - 2018:      Orange back to /225; otherwise same as 2017
--   - 2019:      Teal /35 added; Red bumped to /199; Blue to /99 (9 tiers)
--   - 2020:      Orange /199, Teal /50, Blue /75; Mirror at /450
--   - 2021:      Bronze /249 + Pink /199 added; 11-tier ladder; Mirror at /299
--   - 2022:      Mirror at /349; Bronze /275; otherwise same 11-tier
--   - 2023:      Same 11-tier + FOTL Etch variants (Teal /20, Gold /15, etc.)
--   - 2024:      Mirror /349; Pink /225, Orange /150, Red /100; 11-tier
--   - 2025:      Major expansion: 13-tier incl. FOTL Bronze /17 + Lime Green /15
--                + Silver FOTL /13; Mirror at /399
--
-- Sources: Cardboard Connection, Checklist Insider, PSA Registry
-- =============================================================================

-- ─── 2010-2013: Simple 5-tier Mirror ladder ───────────────────────────────────

-- 2010-2013 Panini Certified Football (4 years, same structure).
-- Mirror Red /250 (hobby, 3 per box), Mirror Blue /100, Mirror Gold /25,
-- Mirror Emerald /5, Mirror Black 1/1. No unnumbered Mirror.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Red /250","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /100","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Emerald /5","ebay_kw":"Mirror Emerald"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year BETWEEN 2010 AND 2013;

-- ─── 2014: Mirror Red /249; Camo hot box variants ─────────────────────────────

-- 2014 Panini Certified Football.
-- Standard Mirror: Red /249, Blue /99, Gold /25, Green /5, Black 1/1.
-- Hot box Camo variants (~3 per case): Camo Red (vet unnumb; rookie /149),
--   Camo Blue /100, Camo Gold /25, Camo Green /5, Camo Black 1/1.
-- (Emerald renamed to Green in 2014.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Red /249","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /99","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"},
  {"label":"Camo Red","ebay_kw":"Camo Red"},
  {"label":"Camo Blue /100","ebay_kw":"Camo Blue"},
  {"label":"Camo Gold /25","ebay_kw":"Camo Gold"},
  {"label":"Camo Green /5","ebay_kw":"Camo Green"},
  {"label":"Camo Black 1/1","ebay_kw":"Camo Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2014;

-- ─── 2015: Mirror Silver /499 base tier + Purple /10 added ───────────────────

-- 2015 Panini Certified Football.
-- Mirror Silver /499 introduced as entry-level numbered tier (2-3 per box).
-- New: Mirror Purple /10. Total: 7-tier Mirror ladder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror Silver /499","ebay_kw":"Mirror Silver"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /50","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2015;

-- ─── 2016: Mirror /499 unnumbered replaces Silver; Orange /225 added ──────────

-- 2016 Panini Certified Football.
-- Base Mirror (unnumbered) replaces Mirror Silver /499.
-- Orange /225 added as new low-numbered tier.
-- Total: 8-tier Mirror ladder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /499","ebay_kw":"Mirror"},
  {"label":"Mirror Orange /225","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /50","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2016;

-- ─── 2017: Mirror Orange /299 (up from /225); same 8-tier structure ───────────

-- 2017 Panini Certified Football.
-- Orange increased to /299 (from /225 in 2016). Otherwise identical.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /499","ebay_kw":"Mirror"},
  {"label":"Mirror Orange /299","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /50","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2017;

-- ─── 2018: Mirror Orange back to /225; otherwise same ────────────────────────

-- 2018 Panini Certified Football.
-- Orange back to /225 (same as 2016). No other structural changes.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /499","ebay_kw":"Mirror"},
  {"label":"Mirror Orange /225","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /50","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2018;

-- ─── 2019: Teal /35 added; Red /199; Blue /99; 9-tier ladder ─────────────────

-- 2019 Panini Certified Football.
-- Major restructure: Teal /35 new; Red escalated to /199; Blue to /99.
-- 9-tier Mirror ladder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /499","ebay_kw":"Mirror"},
  {"label":"Mirror Orange /299","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /199","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /99","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /35","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2019;

-- ─── 2020: Mirror /450; Orange /199; Blue /75; Teal /50 ──────────────────────

-- 2020 Panini Certified Football.
-- Mirror base run reduced to /450. Orange drops to /199 (from /299).
-- Blue /75 (from /99). Teal /50 (from /35). 9-tier.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /450","ebay_kw":"Mirror"},
  {"label":"Mirror Orange /199","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /75","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /50","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2020;

-- ─── 2021: Bronze /249 + Pink /199 added; 11-tier; FOTL Etch ─────────────────

-- 2021 Panini Certified Football.
-- Bronze /249 and Pink /199 added as new tiers between base Mirror and Orange.
-- Mirror base run drops to /299. 11-tier ladder + FOTL Etch exclusives
-- (FOTL: Teal /20, Gold /15, Purple /10, Green /5, Black 1/1).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /299","ebay_kw":"Mirror"},
  {"label":"Mirror Bronze /249","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Pink /199","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Orange /149","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /75","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /50","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2021;

-- ─── 2022: Mirror /349; Bronze /275; same 11-tier structure ──────────────────

-- 2022 Panini Certified Football.
-- Mirror run increased to /349 (from /299). Bronze /275. Otherwise same.
-- FOTL Etch exclusives continue (Teal /20, Gold /15, etc.).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /349","ebay_kw":"Mirror"},
  {"label":"Mirror Bronze /275","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Pink /199","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Orange /149","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /75","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /50","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2022;

-- ─── 2023: Same 11-tier + FOTL Teal /20 + Gold /15 ──────────────────────────

-- 2023 Panini Certified Football.
-- Same 11-tier base ladder as 2022 (Mirror /349, Bronze /275, Pink /199...).
-- FOTL Etch parallels: Teal Etch /20, Gold Etch /15, Purple Etch /10,
--   Green Etch /5, Black Etch 1/1 (FOTL-exclusive tier).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /349","ebay_kw":"Mirror"},
  {"label":"Mirror Bronze /275","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Pink /199","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Orange /149","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /75","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /50","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"},
  {"label":"Mirror Teal Etch FOTL /20","ebay_kw":"Mirror Teal Etch"},
  {"label":"Mirror Gold Etch FOTL /15","ebay_kw":"Mirror Gold Etch"},
  {"label":"Mirror Green Etch FOTL /5","ebay_kw":"Mirror Green Etch"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2023;

-- ─── 2024: Mirror /349; Pink /225; Orange /150; Red /100 ─────────────────────

-- 2024 Panini Certified Football.
-- Pink increased to /225 (from /199). Orange /150 (from /149). Red /100 (from /99).
-- Bronze /275 and Mirror /349 unchanged. FOTL Etch parallels continue.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /349","ebay_kw":"Mirror"},
  {"label":"Mirror Bronze /275","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Pink /225","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Orange /150","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /100","ebay_kw":"Mirror Red"},
  {"label":"Mirror Blue /75","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Teal /50","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Purple /10","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Green /5","ebay_kw":"Mirror Green"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2024;

-- ─── 2025: 13-tier with Bronze FOTL /17 + Lime Green /15 + Silver FOTL /13 ───

-- 2025 Panini Certified Football.
-- Mirror raised to /399. Purple /299 now a separate high-volume tier.
-- New FOTL-exclusive ultra-short parallels: Bronze FOTL /17, Lime Green /15,
-- Silver FOTL /13, Mirror Platinum FOTL /2.
-- Standard ladder: /399, Purple /299, Pink /225, Orange /150, Red /99,
--   Teal /75, Blue /50, Green /25, Gold /10, Black 1/1.
-- (Green moves up to /25; Gold drops to /10.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mirror /399","ebay_kw":"Mirror"},
  {"label":"Mirror Purple /299","ebay_kw":"Mirror Purple"},
  {"label":"Mirror Pink /225","ebay_kw":"Mirror Pink"},
  {"label":"Mirror Orange /150","ebay_kw":"Mirror Orange"},
  {"label":"Mirror Red /99","ebay_kw":"Mirror Red"},
  {"label":"Mirror Teal /75","ebay_kw":"Mirror Teal"},
  {"label":"Mirror Blue /50","ebay_kw":"Mirror Blue"},
  {"label":"Mirror Green /25","ebay_kw":"Mirror Green"},
  {"label":"Mirror Gold /10","ebay_kw":"Mirror Gold"},
  {"label":"Mirror Bronze FOTL /17","ebay_kw":"Mirror Bronze"},
  {"label":"Mirror Lime Green FOTL /15","ebay_kw":"Mirror Lime Green"},
  {"label":"Mirror Silver FOTL /13","ebay_kw":"Mirror Silver"},
  {"label":"Mirror Black 1/1","ebay_kw":"Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football'
  AND year = 2025;
