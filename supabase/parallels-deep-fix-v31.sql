-- =============================================================================
-- parallels-deep-fix-v31.sql
-- One set corrected:
--
-- 1. Upper Deck Artifacts Hockey (36 rows, 1990-2025)
--    Artifacts Hockey debuted in the 2005-06 NHL season (DB year = 2005).
--    DB rows 1990-2004 are placeholders (15 rows → [Base]).
--    Real products: 2005-2025 (21 rows).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 2005-2006: Base, Pewter /100, Blue /75, Red /50, Green /25,
--                Gold Spectrum 1/1
--                (debut era; 2005-06 confirmed; 2006-07 same structure)
--    • 2007:     Base, Silver /100, Gold /50, Blue /25, Bronze /10,
--                Rainbow Silver 1/1
--                (2007-08 season; color palette redesign)
--    • 2008:     Base, Silver /100, Gold /75, Blue /50,
--                Copper Spectrum /25, Silver Spectrum /10,
--                Gold Spectrum /5, Black Rainbow 1/1
--                (2008-09 season; expanded spectrum tier)
--    • 2009:     Base, Silver /75, Gold /50, Silver Spectrum /25,
--                Gold Spectrum /10, Black /5
--                (2009-10 season)
--    • 2010:     Base /125, Silver /75, Emerald /35, Gold /10, Black 1/1
--                (2010-11 season; base set serial-numbered /125)
--    • 2011:     Base, Emerald /99, Spectrum /25, Black /5
--                (2011-12 season; Emerald era begins)
--    • 2012:     Base, Emerald /99, Sapphire /85, Gold Spectrum /25
--                (2012-13 season; Sapphire added)
--    • 2013:     Base, Ruby /399, Emerald /99, Sapphire /85,
--                Spectrum /25, Black /5
--                (2013-14 season; Ruby era begins)
--    • 2014:     Base, Ruby /599, Emerald /99, Sapphire /85,
--                Spectrum /25, Black /5
--                (2014-15 season; Ruby bumped to /599)
--    • 2015:     Base, Ruby /399, Emerald /99, Sapphire /85,
--                Gold Spectrum /25, Black /5
--                (2015-16 season)
--    • 2016:     Base, Ruby /299, Emerald /99, Orange /55,
--                Gold Spectrum /25, Black /5
--                (2016-17 season; Sapphire replaced by Orange /55)
--    • 2017:     Base, Ruby /299, Emerald /99, Orange /55,
--                Purple /20, Black /5
--                (2017-18 season; Purple /20 added)
--    • 2018:     Base, Ruby /299, Emerald /99, Aqua /45,
--                Purple /20, Black /5
--                (2018-19 season; Aqua /45 replaces Orange)
--    • 2019:     Base, Copper /299, Emerald /99, Aqua /45,
--                Purple /20, Black /5
--                (2019-20 season; Copper replaces Ruby)
--    • 2020:     Base, Blue Sapphire /499, Ruby /399, Copper /299,
--                Emerald /99, Autumn /75, Aqua /45, Pink /30, Purple /20
--                (2020-21 season; major expansion, 8 parallels)
--    • 2021:     Base, Ruby /499, Silver Spectrum /299, Royal Blue /199,
--                Emerald /99, Light Blue Steel /85, Autumn /75,
--                Rose /65, Yellow /50, Pink /35
--                (2021-22 season; another expansion)
--    • 2022:     Base, Ruby /499, Copper /299, Royal Blue /199,
--                Emerald /99, Light Blue Steel /85, Autumn /75,
--                Rose /65, Yellow /50, Pink /35, Purple /25, Indigo /10
--                (2022-23 season; 11 serial-numbered parallels)
--    • 2023:     Base, Ruby /499, Copper /299, Royal Blue /199,
--                Emerald /99, Light Blue Steel /85, Autumn /75,
--                Polychrome /65, Yellow /50, Pink /35, Purple /25,
--                Party Time /10
--                (2023-24 season; Polychrome/Party Time replace Rose/Indigo)
--    • 2024-2025: Base, Ruby /499, Emerald /149, Copper /75, Orange /65,
--                Yellow /50, Pink /35, Purple /25, Spectrum Jungle /15,
--                Seafoam Green /10, Black /5
--                (2024-25 confirmed; 2025-26 mirrored as placeholder)
--
-- Total: 36 rows updated
-- Sources: Beckett, Cardboard Connection, Checklistcenter.com, TCDB, BreakNinja
-- =============================================================================

-- ─── PLACEHOLDERS: 1990-2004 ─────────────────────────────────────────────────

-- Artifacts Hockey did not exist before 2005-06. These are placeholder rows.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 2004;

-- ─── REAL PRODUCTS ───────────────────────────────────────────────────────────

-- 2005-2006: Debut era. Base cards unnumbered. Five color tiers.
--   (DB year 2005 = 2005-06 season; 2006 = 2006-07 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Pewter /100","ebay_kw":"Pewter"},
  {"label":"Blue /75","ebay_kw":"Blue"},
  {"label":"Red /50","ebay_kw":"Red"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Gold Spectrum 1/1","ebay_kw":"Gold Spectrum"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2006;

-- 2007: Color palette redesign. Silver/Gold/Blue/Bronze ladder.
--   Rainbow Silver 1/1 replaces Gold Spectrum.
--   (DB year 2007 = 2007-08 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver /100","ebay_kw":"Silver"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Bronze /10","ebay_kw":"Bronze"},
  {"label":"Rainbow Silver 1/1","ebay_kw":"Rainbow Silver"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2007;

-- 2008: Expanded spectrum tier. Silver/Gold/Blue base tier; three spectrum tiers.
--   (DB year 2008 = 2008-09 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver /100","ebay_kw":"Silver"},
  {"label":"Gold /75","ebay_kw":"Gold"},
  {"label":"Blue /50","ebay_kw":"Blue"},
  {"label":"Copper Spectrum /25","ebay_kw":"Copper Spectrum"},
  {"label":"Silver Spectrum /10","ebay_kw":"Silver Spectrum"},
  {"label":"Gold Spectrum /5","ebay_kw":"Gold Spectrum"},
  {"label":"Black Rainbow 1/1","ebay_kw":"Black Rainbow"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2008;

-- 2009: Simplified spectrum era. Silver /75, Gold /50, two Spectrum tiers, Black /5.
--   (DB year 2009 = 2009-10 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver /75","ebay_kw":"Silver"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Silver Spectrum /25","ebay_kw":"Silver Spectrum"},
  {"label":"Gold Spectrum /10","ebay_kw":"Gold Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2009;

-- 2010: Base cards serial-numbered to /125 (full set). Silver/Emerald/Gold ladder.
--   (DB year 2010 = 2010-11 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base /125","ebay_kw":""},
  {"label":"Silver /75","ebay_kw":"Silver"},
  {"label":"Emerald /35","ebay_kw":"Emerald"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2010;

-- 2011: Emerald era. Base unnumbered; Emerald /99 + Spectrum /25 + Black /5.
--   (DB year 2011 = 2011-12 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Spectrum /25","ebay_kw":"Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2011;

-- 2012: Sapphire added alongside Emerald. Three-tier: Emerald/Sapphire/Gold Spectrum.
--   (DB year 2012 = 2012-13 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Sapphire /85","ebay_kw":"Sapphire"},
  {"label":"Gold Spectrum /25","ebay_kw":"Gold Spectrum"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2012;

-- 2013: Ruby era begins. Ruby /399 (Veterans), /299 (Rookies/Goalies).
--   Five full parallel tiers.
--   (DB year 2013 = 2013-14 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /399","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Sapphire /85","ebay_kw":"Sapphire"},
  {"label":"Spectrum /25","ebay_kw":"Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2013;

-- 2014: Ruby bumped to /599 (Veterans); /499 (Rookies/Goalies).
--   (DB year 2014 = 2014-15 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /599","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Sapphire /85","ebay_kw":"Sapphire"},
  {"label":"Spectrum /25","ebay_kw":"Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2014;

-- 2015: Ruby back to /399. Gold Spectrum replaces plain Spectrum at /25.
--   (DB year 2015 = 2015-16 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /399","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Sapphire /85","ebay_kw":"Sapphire"},
  {"label":"Gold Spectrum /25","ebay_kw":"Gold Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2015;

-- 2016: Ruby drops to /299. Sapphire replaced by Orange /55.
--   (DB year 2016 = 2016-17 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /299","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Orange /55","ebay_kw":"Orange"},
  {"label":"Gold Spectrum /25","ebay_kw":"Gold Spectrum"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2016;

-- 2017: Purple /20 added between Gold Spectrum and Black.
--   (DB year 2017 = 2017-18 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /299","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Orange /55","ebay_kw":"Orange"},
  {"label":"Purple /20","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2017;

-- 2018: Aqua /45 replaces Orange. Purple /20 retained.
--   (DB year 2018 = 2018-19 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /299","ebay_kw":"Ruby"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Aqua /45","ebay_kw":"Aqua"},
  {"label":"Purple /20","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2018;

-- 2019: Copper /299 replaces Ruby. Aqua /45, Purple /20 retained.
--   (DB year 2019 = 2019-20 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Copper /299","ebay_kw":"Copper"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Aqua /45","ebay_kw":"Aqua"},
  {"label":"Purple /20","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2019;

-- 2020: Major expansion. Blue Sapphire /499 added at top; Ruby /399 returns;
--   Autumn /75, Pink /30 added. Eight serial-numbered parallel tiers.
--   (DB year 2020 = 2020-21 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Sapphire /499","ebay_kw":"Blue Sapphire"},
  {"label":"Ruby /399","ebay_kw":"Ruby"},
  {"label":"Copper /299","ebay_kw":"Copper"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Autumn /75","ebay_kw":"Autumn"},
  {"label":"Aqua /45","ebay_kw":"Aqua"},
  {"label":"Pink /30","ebay_kw":"Pink"},
  {"label":"Purple /20","ebay_kw":"Purple"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2020;

-- 2021: Ruby rises to /499; Silver Spectrum /299; Royal Blue /199;
--   Light Blue Steel /85; Rose /65; Yellow /50; Pink /35 added.
--   (DB year 2021 = 2021-22 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /499","ebay_kw":"Ruby"},
  {"label":"Silver Spectrum /299","ebay_kw":"Silver Spectrum"},
  {"label":"Royal Blue /199","ebay_kw":"Royal Blue"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Light Blue Steel /85","ebay_kw":"Light Blue Steel"},
  {"label":"Autumn /75","ebay_kw":"Autumn"},
  {"label":"Rose /65","ebay_kw":"Rose"},
  {"label":"Yellow /50","ebay_kw":"Yellow"},
  {"label":"Pink /35","ebay_kw":"Pink"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2021;

-- 2022: Copper /299 replaces Silver Spectrum. Purple /25 and Indigo /10 added.
--   Eleven serial-numbered parallel tiers.
--   (DB year 2022 = 2022-23 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /499","ebay_kw":"Ruby"},
  {"label":"Copper /299","ebay_kw":"Copper"},
  {"label":"Royal Blue /199","ebay_kw":"Royal Blue"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Light Blue Steel /85","ebay_kw":"Light Blue Steel"},
  {"label":"Autumn /75","ebay_kw":"Autumn"},
  {"label":"Rose /65","ebay_kw":"Rose"},
  {"label":"Yellow /50","ebay_kw":"Yellow"},
  {"label":"Pink /35","ebay_kw":"Pink"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Indigo /10","ebay_kw":"Indigo"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2022;

-- 2023: Polychrome /65 replaces Rose /65; Party Time /10 replaces Indigo /10.
--   (DB year 2023 = 2023-24 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /499","ebay_kw":"Ruby"},
  {"label":"Copper /299","ebay_kw":"Copper"},
  {"label":"Royal Blue /199","ebay_kw":"Royal Blue"},
  {"label":"Emerald /99","ebay_kw":"Emerald"},
  {"label":"Light Blue Steel /85","ebay_kw":"Light Blue Steel"},
  {"label":"Autumn /75","ebay_kw":"Autumn"},
  {"label":"Polychrome /65","ebay_kw":"Polychrome"},
  {"label":"Yellow /50","ebay_kw":"Yellow"},
  {"label":"Pink /35","ebay_kw":"Pink"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Party Time /10","ebay_kw":"Party Time"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year = 2023;

-- 2024-2025: Major restructure. Emerald drops from /99 to /149; new tiers
--   Spectrum Jungle /15, Seafoam Green /10. Royal Blue/Light Blue Steel/Autumn dropped.
--   (DB year 2024 = 2024-25 season confirmed; 2025 = 2025-26 mirrored as placeholder)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /499","ebay_kw":"Ruby"},
  {"label":"Emerald /149","ebay_kw":"Emerald"},
  {"label":"Copper /75","ebay_kw":"Copper"},
  {"label":"Orange /65","ebay_kw":"Orange"},
  {"label":"Yellow /50","ebay_kw":"Yellow"},
  {"label":"Pink /35","ebay_kw":"Pink"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Spectrum Jungle /15","ebay_kw":"Spectrum Jungle"},
  {"label":"Seafoam Green /10","ebay_kw":"Seafoam Green"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey'
  AND year BETWEEN 2024 AND 2025;
