-- =============================================================================
-- parallels-deep-fix-v24.sql
-- Two sets corrected:
--
-- 1. Topps Opening Day Baseball (24 rows, 2003-2026)
--    • 2003-2009  : base only (no numbered parallels; 2009 was not released
--                  as a standalone product but row is kept as placeholder)
--    • 2010-2012  : Blue /YEAR + Printing Plates 1/1
--    • 2013-2014  : + Purple (Toys R Us exclusive, unnumbered)
--    • 2015       : Blue (announced /2015 but unstamped) + Purple (TRU)
--                  + Opening Day 1/1 Edition + Printing Plates 1/1
--    • 2016-2022  : Blue /YEAR + Black 1/1 + Printing Plates 1/1
--    • 2023-2026  : base only (product discontinued/on hiatus after 2022)
--
-- 2. Topps Traded Baseball (24 rows, 1981-2004)
--    • 1981-1983  : base only (Tiffany had not yet been introduced)
--    • 1984-1991  : + Tiffany (high-gloss factory set parallel)
--    • 1992-2004  : base only (Tiffany discontinued after 1991)
--
-- Total: 48 rows updated
-- Sources: CardboardConnection, BaseballCardPedia, Beckett, Cardlines
-- =============================================================================

-- ─── TOPPS OPENING DAY BASEBALL ──────────────────────────────────────────────

-- 2003-2009: Early retail sets with no numbered or foil parallels.
--   (2009 was not released as a standalone product; row kept as placeholder.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year BETWEEN 2003 AND 2009;

-- 2010: Blue /2010 debuts (first serial-numbered parallel).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2010","ebay_kw":"Blue"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2010;

-- 2011: Same structure, year-coded Blue.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2011","ebay_kw":"Blue"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2011;

-- 2012: Same.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2012","ebay_kw":"Blue"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2012;

-- 2013: Purple (Toys R Us exclusive) added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2013","ebay_kw":"Blue"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2013;

-- 2014: Same.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2014","ebay_kw":"Blue"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2014;

-- 2015: Blue released unstamped (announced as /2015 but no serial number on card);
--   Opening Day 1/1 Edition (foil 1/1) introduced.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Opening Day 1/1","ebay_kw":"Opening Day 1/1"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2015;

-- 2016-2022: Black 1/1 Edition replaces the Opening Day 1/1 branding;
--   Purple TRU dropped (Toys R Us closed 2018); Blue remains year-coded.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2016","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2016;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2017","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2017;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2018","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2018;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2019","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2019;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2020","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2020;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2021","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2021;

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2022","ebay_kw":"Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year = 2022;

-- 2023-2026: Product discontinued/on hiatus after 2022 season.
--   Rows kept as placeholders with base only.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day' AND sport = 'baseball'
  AND year BETWEEN 2023 AND 2026;

-- ─── TOPPS TRADED BASEBALL ───────────────────────────────────────────────────

-- 1981-1983: First three years of Topps Traded.  Tiffany had not yet been
--   introduced (Topps Tiffany started in 1984 for both base and Traded).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Traded' AND sport = 'baseball'
  AND year BETWEEN 1981 AND 1983;

-- 1984-1991: Tiffany high-gloss factory-set parallel exists for all 8 years.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Tiffany","ebay_kw":"Tiffany"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Traded' AND sport = 'baseball'
  AND year BETWEEN 1984 AND 1991;

-- 1992-2004: Tiffany discontinued after 1991; no card-level parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Traded' AND sport = 'baseball'
  AND year BETWEEN 1992 AND 2004;
