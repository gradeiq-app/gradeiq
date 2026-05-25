-- =============================================================================
-- parallels-deep-fix-v19.sql
-- Bowman Base Baseball — year-accurate parallels
-- brand='Bowman', set_name='Base', sport='baseball'
-- Covers DB years 1948–1955 + 1989–2026 (46 rows total)
--
-- HISTORY:
--   1948–1955: Original Bowman era (no parallels — base design only)
--   1956–1988: Gap years — Bowman brand was dormant (NOT in DB)
--   1989–1995: Modern era restart — no full-set parallels
--              (1993–1994 foil cards are subset inserts, NOT base parallels;
--               1995 Gold Foil only covers the 54-card Silver Foil subset)
--   1996:      First full-set parallel — Full Foil (1:1, unnumbered)
--   1997:      International (flag-background foil, 1:1, unnumbered)
--   1998:      International + Golden Anniversary /50
--   1999:      International + Gold /99
--   2000:      Retro/Future + Gold /99
--   2001:      Gold only (unnumbered, 1:1)
--   2002:      Gold + Uncirculated (factory set, unnumbered)
--   2003:      Gold + Uncirculated Silver /245 + Uncirculated Gold /210
--   2004:      Gold + 1st Edition + Uncirculated Silver /245 + Uncirculated Gold /210
--   2005:      Gold + White /240 + Red 1/1
--   2006:      Gold + Blue /500 + White /120 + Red 1/1
--   2007–2009: Gold + Blue /500 + Orange /250 + Red 1/1
--   2010:      Gold + Blue /520 + Orange /250 + Red 1/1
--   2011:      Gold + International + Purple (blister) + Blue /500 + Green /450 + Orange /250 + Red 1/1
--   2012:      Gold + International + Silver Ice + Blue /500 + Orange /250 + Red Ice /25 + Red 1/1
--   2013:      Gold + State & Hometown + Silver Ice + Blue /500 + Orange /250 +
--              Red Ice /25 + Purple Ice /10 + White Ice 1/1 + Red 1/1
--   2014:      Nine color borders (Blue /500 → Purple /10 → Red 1/1) +
--              Ice parallels (Silver Ice unnumbered, Red Ice /25, Purple Ice /10, White Ice 1/1)
--   2015:      Silver /499 + Purple /250 + Blue /150 + Gold /50 + Orange /25 + Red /5 + Black 1/1
--   2016:      Silver (unnumb) + Purple /250 + Blue /150 + Green /99 + Gold /50 + Orange /25 + Red /5 + Metallic 1/1
--   2017:      Yellow (unnumb, retail) + Silver /499 + Purple /250 + Blue /150 +
--              Green /99 + Gold /50 + Orange /25 + Red /5 + Black 1/1
--   2018–2019: Sky Blue /499 + Purple /250 + Blue /150 + Green /99 + Gold /50 + Orange /25 + Red /5 + Platinum 1/1
--   2020:      + Yellow /75 added
--   2021:      + Camo (unnumb) + Neon Green /399 + Fuchsia /299 added
--   2022:      + Purple Pattern /199 + Blue Pattern /150 + Green Pattern /99 added
--   2023:      + Pink /175 + Black /15; Blue Pattern drops to /125
--   2024:      Blue Pattern back to /150; Orange dropped; Green Pattern /99 (retail)
--   2025:      + Yellow Pattern /75 + Black /10 + Black Pattern /10; Blue Pattern /125; no Green /99
--   2026:      Purple Pattern /250; + Gold Pattern /50 + Black (at /25); no Green /99; Blue Pattern /150
--
-- ACTIONS:
--   DELETE  — 0 rows (all 46 years are legitimate Bowman Baseball products)
--   UPDATE  — all 46 rows
-- =============================================================================

-- ---------------------------------------------------------------------------
-- SECTION 1 — Original Bowman era 1948–1955 (no parallels)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball'
  AND year BETWEEN 1948 AND 1955;

-- ---------------------------------------------------------------------------
-- SECTION 2 — Modern era early years 1989–1995 (no full-set parallels)
-- 1989–1992: Pure base design; no parallel versions existed.
-- 1993–1994: Foil cards (#339-374 + #693-704 in '93; #337-388 in '94) were
--            specific-prospect subsets within the set, NOT parallels of every card.
-- 1995:      Gold Foil parallel only covered the 54-card Silver Foil subset
--            (cards #221-#274), not the full 440-card base set.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball'
  AND year BETWEEN 1989 AND 1995;

-- ---------------------------------------------------------------------------
-- SECTION 3 — 1996: First full-set parallel — Full Foil (all cards, 1:1, unnumbered)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Full Foil","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 1996;

-- ---------------------------------------------------------------------------
-- SECTION 4 — 1997: International (foil-board with national flag, 1:1, unnumbered)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"International","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 1997;

-- ---------------------------------------------------------------------------
-- SECTION 5 — 1998: International + Golden Anniversary /50
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"International","numbered":false,"print_run":null},
  {"name":"Golden Anniversary","numbered":true,"print_run":50}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 1998;

-- ---------------------------------------------------------------------------
-- SECTION 6 — 1999: International + Gold /99
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"International","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":99}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 1999;

-- ---------------------------------------------------------------------------
-- SECTION 7 — 2000: Retro/Future (unnumbered, 1:1) + Gold /99
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Retro/Future","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":99}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2000;

-- ---------------------------------------------------------------------------
-- SECTION 8 — 2001: Gold only (unnumbered, approximately 1:1 hobby)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2001;

-- ---------------------------------------------------------------------------
-- SECTION 9 — 2002: Gold (unnumbered) + Uncirculated (factory set, unnumbered)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Uncirculated","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2002;

-- ---------------------------------------------------------------------------
-- SECTION 10 — 2003: Gold + Uncirculated Silver /245 + Uncirculated Gold /210
-- Uncirculated numbered variants were exclusive to hobby factory sets;
-- applied primarily to rookies and prospects.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Uncirculated Silver","numbered":true,"print_run":245},
  {"name":"Uncirculated Gold","numbered":true,"print_run":210}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2003;

-- ---------------------------------------------------------------------------
-- SECTION 11 — 2004: Gold + 1st Edition + Uncirculated Silver /245 + Uncirculated Gold /210
-- 1st Edition was an early-release parallel of the full set with distinct foil stamp.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"1st Edition","numbered":false,"print_run":null},
  {"name":"Uncirculated Silver","numbered":true,"print_run":245},
  {"name":"Uncirculated Gold","numbered":true,"print_run":210}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2004;

-- ---------------------------------------------------------------------------
-- SECTION 12 — 2005: Gold + White /240 + Red 1/1
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"White","numbered":true,"print_run":240},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2005;

-- ---------------------------------------------------------------------------
-- SECTION 13 — 2006: Gold + Blue /500 + White /120 + Red 1/1
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"White","numbered":true,"print_run":120},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2006;

-- ---------------------------------------------------------------------------
-- SECTION 14 — 2007–2009: Gold + Blue /500 + Orange /250 + Red 1/1
-- Orange replaced White; consistent structure across these three years.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball'
  AND year IN (2007, 2008, 2009);

-- ---------------------------------------------------------------------------
-- SECTION 15 — 2010: Gold + Blue /520 + Orange /250 + Red 1/1
-- Blue print run increased to 520 (covering a larger base set).
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":520},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2010;

-- ---------------------------------------------------------------------------
-- SECTION 16 — 2011
-- International (flag background) and Purple (blister pack exclusive) added;
-- Green /450 introduced as retail parallel.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"International","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"Green","numbered":true,"print_run":450},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2011;

-- ---------------------------------------------------------------------------
-- SECTION 17 — 2012
-- Silver Ice (unnumbered, Ice design) and Red Ice /25 introduced.
-- International returns; Gold continues.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"International","numbered":false,"print_run":null},
  {"name":"Silver Ice","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Red Ice","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2012;

-- ---------------------------------------------------------------------------
-- SECTION 18 — 2013
-- State & Hometown (alternate design showing player hometown) replaces International.
-- Purple Ice /10 and White Ice 1/1 added to Ice parallel tier.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"State & Hometown","numbered":false,"print_run":null},
  {"name":"Silver Ice","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Red Ice","numbered":true,"print_run":25},
  {"name":"Purple Ice","numbered":true,"print_run":10},
  {"name":"White Ice","numbered":true,"print_run":1},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2013;

-- ---------------------------------------------------------------------------
-- SECTION 19 — 2014
-- Major redesign: nine color-border parallels (Gold transitions to numbered /50)
-- plus separate Ice-design parallels.
-- Color borders: Blue /500, Orange /250, Green /150, Yellow /99, Silver /75,
--                Gold /50, Black /25, Purple /10, Red 1/1
-- Ice parallels: Silver Ice (1-per-hobby-box, unnumbered),
--                Red Ice /25, Purple Ice /10, White Ice 1/1
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":true,"print_run":500},
  {"name":"Orange","numbered":true,"print_run":250},
  {"name":"Green","numbered":true,"print_run":150},
  {"name":"Yellow","numbered":true,"print_run":99},
  {"name":"Silver","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Black","numbered":true,"print_run":25},
  {"name":"Purple","numbered":true,"print_run":10},
  {"name":"Silver Ice","numbered":false,"print_run":null},
  {"name":"Red Ice","numbered":true,"print_run":25},
  {"name":"Purple Ice","numbered":true,"print_run":10},
  {"name":"White Ice","numbered":true,"print_run":1},
  {"name":"Red","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2014;

-- ---------------------------------------------------------------------------
-- SECTION 20 — 2015
-- Streamlined to 7 parallels; Silver re-introduced as numbered /499;
-- rarest parallel is Black 1/1.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Silver","numbered":true,"print_run":499},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2015;

-- ---------------------------------------------------------------------------
-- SECTION 21 — 2016
-- Silver reverts to unnumbered; Green /99 (retail) added; 1/1 renamed Metallic.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Silver","numbered":false,"print_run":null},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Metallic","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2016;

-- ---------------------------------------------------------------------------
-- SECTION 22 — 2017
-- Yellow (unnumbered, retail value pack exclusive) added;
-- Silver numbered again at /499; 1/1 back to Black.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":499},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2017;

-- ---------------------------------------------------------------------------
-- SECTION 23 — 2018–2019: Sky Blue /499 replaces Silver; Platinum 1/1
-- Consistent 8-parallel structure both years.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball'
  AND year IN (2018, 2019);

-- ---------------------------------------------------------------------------
-- SECTION 24 — 2020: Yellow /75 added between Green and Gold
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2020;

-- ---------------------------------------------------------------------------
-- SECTION 25 — 2021: Camo (retail, unnumbered) added; Neon Green /399 and Fuchsia /299 introduced
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Camo","numbered":false,"print_run":null},
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2021;

-- ---------------------------------------------------------------------------
-- SECTION 26 — 2022: Pattern parallels introduced (Purple Pattern /199, Blue Pattern /150, Green Pattern /99)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Purple Pattern","numbered":true,"print_run":199},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Blue Pattern","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Green Pattern","numbered":true,"print_run":99},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2022;

-- ---------------------------------------------------------------------------
-- SECTION 27 — 2023: Pink /175 and Black /15 (hobby) added; Blue Pattern drops to /125
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Purple Pattern","numbered":true,"print_run":199},
  {"name":"Pink","numbered":true,"print_run":175},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Blue Pattern","numbered":true,"print_run":125},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Green Pattern","numbered":true,"print_run":99},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Black","numbered":true,"print_run":15},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2023;

-- ---------------------------------------------------------------------------
-- SECTION 28 — 2024: Blue Pattern back to /150; Orange dropped; Green Pattern /99 (retail)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Purple Pattern","numbered":true,"print_run":199},
  {"name":"Pink","numbered":true,"print_run":175},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Blue Pattern","numbered":true,"print_run":150},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Green Pattern","numbered":true,"print_run":99},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2024;

-- ---------------------------------------------------------------------------
-- SECTION 29 — 2025: Yellow Pattern /75 + Black /10 + Black Pattern /10 added;
-- Blue Pattern /125; Green /99 dropped; Orange /25 returns
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Purple Pattern","numbered":true,"print_run":199},
  {"name":"Pink","numbered":true,"print_run":175},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Blue Pattern","numbered":true,"print_run":125},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Yellow Pattern","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Black","numbered":true,"print_run":10},
  {"name":"Black Pattern","numbered":true,"print_run":10},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2025;

-- ---------------------------------------------------------------------------
-- SECTION 30 — 2026: Purple Pattern /250; Gold Pattern /50 and Black /25 added;
-- no Green /99; Blue Pattern back to /150
-- (Released May 2026)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Sky Blue","numbered":true,"print_run":499},
  {"name":"Neon Green","numbered":true,"print_run":399},
  {"name":"Fuchsia","numbered":true,"print_run":299},
  {"name":"Purple","numbered":true,"print_run":250},
  {"name":"Purple Pattern","numbered":true,"print_run":250},
  {"name":"Pink","numbered":true,"print_run":175},
  {"name":"Blue","numbered":true,"print_run":150},
  {"name":"Blue Pattern","numbered":true,"print_run":150},
  {"name":"Yellow","numbered":true,"print_run":75},
  {"name":"Yellow Pattern","numbered":true,"print_run":75},
  {"name":"Gold","numbered":true,"print_run":50},
  {"name":"Gold Pattern","numbered":true,"print_run":50},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Black","numbered":true,"print_run":25},
  {"name":"Red","numbered":true,"print_run":5},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball' AND year = 2026;
