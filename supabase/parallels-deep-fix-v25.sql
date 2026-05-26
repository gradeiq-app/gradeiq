-- =============================================================================
-- parallels-deep-fix-v25.sql
-- One set corrected:
--
-- 1. Bowman Sterling Baseball (30 rows, 1996-2025)
--    • 1996-2003  : No product existed; DB rows are placeholders → [Base]
--    • 2004-2005  : First two years: Refractor /199, Black /25, Red 1/1
--    • 2006       : + Gold Refractor /10 (box topper) + Printing Plates 1/1
--    • 2007       : Refractor /199, Black /25, Red 1/1 (Gold/Plates dropped)
--    • 2008-2009  : + Gold Refractor /50 + Printing Plates 1/1
--    • 2010       : + Purple Refractor /10
--    • 2011       : + Canary Diamond 1/1 (no SuperFractor this year)
--    • 2012       : + SuperFractor 1/1 (Canary Diamond retained)
--    • 2013       : Blue /25 replaces Black; Japan Fractor /5 added;
--                  Canary Diamond → /3; SuperFractor 1/1 retained
--    • 2014       : Largest rainbow (14 entries); Green/Orange unnumbered;
--                  Japan-Fractor /25 + Japan Atomic 1/1 (Asia-exclusive)
--    • 2015-2018  : Product on hiatus → [Base]
--    • 2019       : Revival; Speckle /99, Black Atomic /10, Red /5, SuperFractor
--    • 2020-2021  : + Magenta Refractor /75 (same structure both years)
--    • 2022       : + Mini-Diamond Refractor /150
--    • 2023       : + Sterling Silver Refractor /100; Black Atomic → Black Lava /10
--    • 2024       : + Blue Scintillate /25, Copper /15, Red Scintillate /5
--    • 2025       : No product released → [Base]
--
-- Total: 30 rows updated
-- Sources: BaseballCardPedia, CardboardConnection, Beckett, Cardsmithbreaks
-- =============================================================================

-- ─── BOWMAN STERLING BASEBALL ────────────────────────────────────────────────

-- 1996-2003: Product did not exist. First Bowman Sterling released in 2004.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year BETWEEN 1996 AND 2003;

-- 2004: Inaugural year. Refractor /199 + Black /25 + Red 1/1.
--   (Black Refractor on non-auto base cards was /16; /25 is the auto tier.
--    Using /25 as the standard hobby reference.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2004;

-- 2005: Same structure as 2004.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2005;

-- 2006: Gold Refractor /10 and Printing Plates added (both box-topper exclusive).
--   Gold was limited to the 50 rookie cards only, numbered to 10 copies.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Gold Refractor /10","ebay_kw":"Gold Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2006;

-- 2007: Simplified back to three refractor tiers; Gold and Printing Plates not confirmed.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2007;

-- 2008: Gold Refractor /50 and Printing Plates return as full-set parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2008;

-- 2009: Same as 2008.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2009;

-- 2010: Purple Refractor /10 added (listed as "Purple Reverse Image Refractor" in some sources).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Purple Refractor /10","ebay_kw":"Purple Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2010;

-- 2011: Canary Diamond 1/1 introduced. No SuperFractor this year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Purple Refractor /10","ebay_kw":"Purple Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Canary Diamond 1/1","ebay_kw":"Canary Diamond"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2011;

-- 2012: SuperFractor 1/1 added alongside Canary Diamond 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Black Refractor /25","ebay_kw":"Black Refractor"},
  {"label":"Purple Refractor /10","ebay_kw":"Purple Refractor"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Canary Diamond 1/1","ebay_kw":"Canary Diamond"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2012;

-- 2013: Blue Refractor /25 replaces Black; Japan Fractor /5 added;
--   Canary Diamond drops to /3; SuperFractor retained.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Purple Refractor /10","ebay_kw":"Purple Refractor"},
  {"label":"Japan Fractor /5","ebay_kw":"Japan Fractor"},
  {"label":"Canary Diamond Refractor /3","ebay_kw":"Canary Diamond"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2013;

-- 2014: Largest rainbow (14 parallels). Green and Orange are unnumbered.
--   Japan-Fractor /25 and Japan Atomic 1/1 are Asia-exclusive but tradeable on eBay.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Green Refractor","ebay_kw":"Green Refractor"},
  {"label":"Magenta Refractor /50","ebay_kw":"Magenta Refractor"},
  {"label":"Orange Refractor","ebay_kw":"Orange Refractor"},
  {"label":"Purple Refractor /50","ebay_kw":"Purple Refractor"},
  {"label":"Japan-Fractor /25","ebay_kw":"Japan Fractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Atomic Refractor /10","ebay_kw":"Black Atomic Refractor"},
  {"label":"Canary Diamond Refractor /3","ebay_kw":"Canary Diamond"},
  {"label":"Red Refractor 1/1","ebay_kw":"Red Refractor"},
  {"label":"Japan Atomic Refractor 1/1","ebay_kw":"Japan Atomic Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2014;

-- 2015-2018: Product on hiatus after 2014; no Bowman Sterling released.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year BETWEEN 2015 AND 2018;

-- 2019: Revival after 5-year hiatus. New structure: Speckle /99, Blue /25,
--   Black Atomic /10, Red /5 (no longer Red 1/1).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Atomic Refractor /10","ebay_kw":"Black Atomic Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2019;

-- 2020: Magenta Refractor /75 added between Speckle and Gold.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Magenta Refractor /75","ebay_kw":"Magenta Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Atomic Refractor /10","ebay_kw":"Black Atomic Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2020;

-- 2021: Same structure as 2020 (Magenta retained).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Magenta Refractor /75","ebay_kw":"Magenta Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Atomic Refractor /10","ebay_kw":"Black Atomic Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2021;

-- 2022: Mini-Diamond Refractor /150 added between Refractor and Speckle.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Mini-Diamond Refractor /150","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Magenta Refractor /75","ebay_kw":"Magenta Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Atomic Refractor /10","ebay_kw":"Black Atomic Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2022;

-- 2023: Sterling Silver Refractor /100 added; Black Atomic → Black Lava /10.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Mini-Diamond Refractor /150","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Sterling Silver Refractor /100","ebay_kw":"Sterling Silver Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Magenta Refractor /75","ebay_kw":"Magenta Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Black Lava Refractor /10","ebay_kw":"Black Lava Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2023;

-- 2024: Blue Sterling Scintillate /25, Copper /15, and Red Sterling Scintillate /5 added.
--   Two Blue parallels (/25 each) and two Red parallels (/5 each) exist this year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /199","ebay_kw":"Refractor"},
  {"label":"Mini-Diamond Refractor /150","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Sterling Silver Refractor /100","ebay_kw":"Sterling Silver Refractor"},
  {"label":"Speckle Refractor /99","ebay_kw":"Speckle Refractor"},
  {"label":"Magenta Refractor /75","ebay_kw":"Magenta Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Blue Refractor /25","ebay_kw":"Blue Refractor"},
  {"label":"Blue Sterling Scintillate Refractor /25","ebay_kw":"Blue Sterling Scintillate"},
  {"label":"Copper Refractor /15","ebay_kw":"Copper Refractor"},
  {"label":"Black Lava Refractor /10","ebay_kw":"Black Lava Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"Red Sterling Scintillate Refractor /5","ebay_kw":"Red Sterling Scintillate"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2024;

-- 2025: No Bowman Sterling product released for 2025.
--   (2025 Topps Sterling is a separate Topps-branded product, not Bowman Sterling.)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling' AND sport = 'baseball'
  AND year = 2025;
