-- =============================================================================
-- parallels-deep-fix-v30.sql
-- One set corrected:
--
-- 1. Upper Deck Ultimate Collection Hockey (36 rows, 1990-2025)
--    UC Hockey debuted in 2004-05 (DB year = 2004).
--    DB rows 1990-2003 are placeholders (14 rows → [Base]).
--    Real products: 2004-2025 (22 rows).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 2004-2006: Base /299, Gold /35, Black 1/1
--                (all cards serial-numbered; Gold is secondary tier)
--    • 2007-2010: Base /499, Gold /35, Black 1/1
--                (higher base print run; confirmed 2007-08 = /499)
--    • 2011-2013: Base /399, Gold /35, Black 1/1
--                (confirmed 2011-12 = /399)
--    • 2014-2015: Base /299, Gold Spectrum /35, Blue /25, Black /2
--                (confirmed 2014-15 structure; 2015-16 similar)
--    • 2016:      Base /99, Onyx Black /10
--                (confirmed 2016-17 structure)
--    • 2017:      Base (unnumbered), Onyx Black /10
--                (confirmed 2017-18 structure)
--    • 2018:      Base /149, Onyx Black /10
--                (confirmed 2018-19 structure)
--    • 2019:      Base (unnumbered), Veterans Onyx Black /10, Legends /5
--                (confirmed 2019-20 structure)
--    • 2020:      Gold /49, Onyx Black /25, Purple /5
--                (confirmed 2020-21 unsigned parallels)
--    • 2021-2022: Gold /49, Platinum /5
--                (2021-22 confirmed; 2022-23 similar transition)
--    • 2023:      Blue /99, Gold /35, Purple /15, Black /5
--                (confirmed 2023-24 structure)
--    • 2024-2025: Base /149, Gold /99, Purple /35, Platinum /5, Black 1/1
--                (confirmed 2024-25 and 2025-26)
--
-- Total: 36 rows updated
-- Sources: Cardboard Connection, Beckett, Checklistinsider, TCDB
-- =============================================================================

-- ─── PLACEHOLDERS: 1990-2003 ─────────────────────────────────────────────────

-- Ultimate Collection Hockey did not exist before 2004-05.
-- These DB rows are placeholders.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 2003;

-- ─── REAL PRODUCTS ───────────────────────────────────────────────────────────

-- 2004-2006: Debut era. All base cards serial-numbered to 299.
--   Gold parallel (secondary tier, ~35 copies). Black 1/1 one-of-ones.
--   (DB year 2004 = 2004-05 season; etc.)
UPDATE card_sets SET parallels = '[
  {"label":"Base /299","ebay_kw":""},
  {"label":"Gold /35","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2004 AND 2006;

-- 2007-2010: Higher base print run era (/499).
--   Confirmed for 2007-08 season (DB year 2007).
UPDATE card_sets SET parallels = '[
  {"label":"Base /499","ebay_kw":""},
  {"label":"Gold /35","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2007 AND 2010;

-- 2011-2013: Base print run drops to /399.
--   Confirmed for 2011-12 season (DB year 2011).
UPDATE card_sets SET parallels = '[
  {"label":"Base /399","ebay_kw":""},
  {"label":"Gold /35","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2013;

-- 2014-2015: Base drops to /299; Gold Spectrum /35 + Blue /25 + Black /2
--   added for the memorabilia base subset. Confirmed for 2014-15 season.
--   (DB year 2014 = 2014-15; 2015 = 2015-16)
UPDATE card_sets SET parallels = '[
  {"label":"Base /299","ebay_kw":""},
  {"label":"Gold Spectrum /35","ebay_kw":"Gold Spectrum"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Black /2","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2014 AND 2015;

-- 2016: Major change — base drops to just 99 copies. Onyx Black /10.
--   (DB year 2016 = 2016-17 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base /99","ebay_kw":""},
  {"label":"Onyx Black /10","ebay_kw":"Onyx Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2016;

-- 2017: Base becomes unnumbered; Onyx Black /10 is only parallel.
--   (DB year 2017 = 2017-18 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Onyx Black /10","ebay_kw":"Onyx Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2017;

-- 2018: Base re-numbered to /149; Onyx Black /10 continues.
--   (DB year 2018 = 2018-19 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base /149","ebay_kw":""},
  {"label":"Onyx Black /10","ebay_kw":"Onyx Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2018;

-- 2019: Base becomes unnumbered again. Veterans Onyx Black /10, Legends /5.
--   (DB year 2019 = 2019-20 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Onyx Black /10","ebay_kw":"Onyx Black"},
  {"label":"Legends Onyx Black /5","ebay_kw":"Onyx Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2019;

-- 2020: Color-coded parallel system begins. Gold /49, Onyx Black /25,
--   Purple /5 for unsigned base parallels.
--   (DB year 2020 = 2020-21 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Onyx Black /25","ebay_kw":"Onyx Black"},
  {"label":"Purple /5","ebay_kw":"Purple"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2020;

-- 2021-2022: Stable color era. Gold /49, Platinum /5.
--   (DB year 2021 = 2021-22; 2022 = 2022-23; both follow same structure)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Platinum /5","ebay_kw":"Platinum"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2021 AND 2022;

-- 2023: New four-tier color system: Blue /99, Gold /35, Purple /15, Black /5.
--   Base is unnumbered. (DB year 2023 = 2023-24 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Gold /35","ebay_kw":"Gold"},
  {"label":"Purple /15","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year = 2023;

-- 2024-2025: Base re-numbered to /149; Gold expands to /99; Purple /35,
--   Platinum /5, Black 1/1. Confirmed for 2024-25 and 2025-26 seasons.
UPDATE card_sets SET parallels = '[
  {"label":"Base /149","ebay_kw":""},
  {"label":"Gold /99","ebay_kw":"Gold"},
  {"label":"Purple /35","ebay_kw":"Purple"},
  {"label":"Platinum /5","ebay_kw":"Platinum"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey'
  AND year BETWEEN 2024 AND 2025;
