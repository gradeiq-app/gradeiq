-- =============================================================================
-- parallels-deep-fix-v32.sql
-- One set corrected:
--
-- 1. Upper Deck Black Diamond Hockey (36 rows, 1990-2025)
--    Black Diamond Hockey debuted in the 1996-97 NHL season (DB year = 1996).
--    DB rows 1990-1995 are placeholders (no product existed).
--    Black Diamond was NOT released in 2001-02, 2002-03, or 2004-05 (lockout).
--    Those 3 DB years (2001, 2002, 2004) are also placeholders.
--    Total placeholders: 9 rows (1990-1995, 2001, 2002, 2004).
--    Real products: 27 rows (1996-2000, 2003, 2005-2025)
--    — matches the "27th release" reference for 2025-26 season.
--
--    Parallel structure by era (DB year = season start year):
--
--    • 1996:         Single Diamond, Double Diamond, Triple Diamond, Gold
--                   (debut year; no Quad Diamond yet in 180-card set)
--    • 1997-2000,    Single Diamond, Double Diamond, Triple Diamond,
--      2003:        Quad Diamond, Gold
--                   (1997-98 confirmed Triple Diamond + Premium Cut inserts;
--                    2000-01 confirmed Diamond Skills inserts;
--                    2003-04 confirmed on TCDB)
--    • 2005-2013:    Single Diamond, Double Diamond, Triple Diamond,
--                   Quad Diamond, Ruby /100, Gold /10, Diamond 1/1
--                   (2006-07 confirmed Ruby/Gold/Black tiers;
--                    2008-09 confirmed Ruby /100, Gold /10, Diamond 1/1;
--                    2010-11 confirmed Ruby + Gold + Onyx (all low-numbered);
--                    2012-13 confirmed Triple/Quad Diamond parallels)
--    • 2014-2015:    Base /199, Pure Black /99
--                   (2014-15: 50 stars + 5 legends each /199; Pure Black /99)
--    • 2016-2019:    Base /249, Pure Black /99
--                   (2016-17, 2017-18, 2018-19 confirmed /249 + Pure Black /99)
--    • 2020-2021:    Base /299, Pure Black /99
--                   (2019-20 /249 confirmed; 2020-21 bumped to /299)
--    • 2022-2023:    Base /349, Red /75, Blue /25, Green /10, Gold 1/1
--                   (2022-23 confirmed; 2023-24 similar structure)
--    • 2024-2025:    Base /349, Green /10, Gold 1/1
--                   (2024-25 confirmed; 2025-26 mirrored as placeholder)
--
--    Note: "Diamond Relic" cards (embedded lab diamonds) are a separate
--    insert/subset in Black Diamond, not parallels of the base set.
--    DB year = start year of the NHL season (1996 = 1996-97, etc.)
--
-- Total: 36 rows updated
-- Sources: Beckett, Cardboard Connection, Checklistcenter.com, TCDB,
--          HockeyDB, Sports Card Radio, Sports Collectors Daily
-- =============================================================================

-- ─── PLACEHOLDERS ────────────────────────────────────────────────────────────

-- Black Diamond Hockey did not exist before 1996-97.
-- 2001-02, 2002-03, and 2004-05 (lockout) also had no Black Diamond release.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year IN (1990, 1991, 1992, 1993, 1994, 1995, 2001, 2002, 2004);

-- ─── REAL PRODUCTS ───────────────────────────────────────────────────────────

-- 1996: Debut year (1996-97 season). 180 cards.
--   Three diamond tiers (no Quad Diamond in first year).
--   Gold parallel exists. DB year 1996 = 1996-97 season.
UPDATE card_sets SET parallels = '[
  {"label":"Single Diamond","ebay_kw":"Single Diamond"},
  {"label":"Double Diamond","ebay_kw":"Double Diamond"},
  {"label":"Triple Diamond","ebay_kw":"Triple Diamond"},
  {"label":"Gold","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year = 1996;

-- 1997-2000, 2003: Full four-tier Diamond era.
--   Quad Diamond added in 1997-98. Gold parallel throughout.
--   (Confirmed via TCDB and HockeyDB for 1997-98, 1999-00, 2000-01, 2003-04)
UPDATE card_sets SET parallels = '[
  {"label":"Single Diamond","ebay_kw":"Single Diamond"},
  {"label":"Double Diamond","ebay_kw":"Double Diamond"},
  {"label":"Triple Diamond","ebay_kw":"Triple Diamond"},
  {"label":"Quad Diamond","ebay_kw":"Quad Diamond"},
  {"label":"Gold","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year IN (1997, 1998, 1999, 2000, 2003);

-- 2005-2013: Diamond tiers + color parallels era.
--   Each card (regardless of diamond tier) available in Ruby /100,
--   Gold /10, and Diamond 1/1. (2006-07 confirmed Ruby/Gold/Black 1/1;
--   2008-09 confirmed Ruby /100, Gold /10, Diamond 1/1; 2010-11 Ruby + Gold
--   + Onyx; 2012-13 confirmed Triple/Quad Diamond parallels still exist.)
UPDATE card_sets SET parallels = '[
  {"label":"Single Diamond","ebay_kw":"Single Diamond"},
  {"label":"Double Diamond","ebay_kw":"Double Diamond"},
  {"label":"Triple Diamond","ebay_kw":"Triple Diamond"},
  {"label":"Quad Diamond","ebay_kw":"Quad Diamond"},
  {"label":"Ruby /100","ebay_kw":"Ruby"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Diamond 1/1","ebay_kw":"Diamond"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2013;

-- 2014-2015: Shift to fully serial-numbered base set.
--   50 veterans + 5 legends each /199. Pure Black parallel /99.
--   (DB year 2014 = 2014-15 season; 2015 = 2015-16 season; both confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base /199","ebay_kw":""},
  {"label":"Pure Black /99","ebay_kw":"Pure Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2014 AND 2015;

-- 2016-2019: Base drops to /249. Pure Black /99 continues.
--   (DB year 2016 = 2016-17 through 2019 = 2019-20; all confirmed /249 base)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Pure Black /99","ebay_kw":"Pure Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2016 AND 2019;

-- 2020-2021: Base bumped to /299. Pure Black /99 retained.
--   (DB year 2020 = 2020-21 season; 2021 = 2021-22 season; confirmed /299)
UPDATE card_sets SET parallels = '[
  {"label":"Base /299","ebay_kw":""},
  {"label":"Pure Black /99","ebay_kw":"Pure Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2020 AND 2021;

-- 2022-2023: Major expansion to four color parallels.
--   Base /349; Red /75, Blue /25, Green /10, Gold 1/1.
--   (DB year 2022 = 2022-23 season confirmed; 2023 = 2023-24 season similar)
UPDATE card_sets SET parallels = '[
  {"label":"Base /349","ebay_kw":""},
  {"label":"Red /75","ebay_kw":"Red"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Green /10","ebay_kw":"Green"},
  {"label":"Gold 1/1","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2022 AND 2023;

-- 2024-2025: Mid-tier Blue /25 dropped; Green /10 and Gold 1/1 retained.
--   (DB year 2024 = 2024-25 season confirmed; 2025 = 2025-26 mirrored)
UPDATE card_sets SET parallels = '[
  {"label":"Base /349","ebay_kw":""},
  {"label":"Green /10","ebay_kw":"Green"},
  {"label":"Gold 1/1","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond' AND sport = 'hockey'
  AND year BETWEEN 2024 AND 2025;
