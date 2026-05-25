-- =============================================================================
-- parallels-deep-fix-v21.sql
-- Topps Series 2 Baseball — year-accurate parallels
-- brand='Topps', set_name='Series 2', sport='baseball'
-- Covers DB years 1992–2025 (34 rows → 32 after deletes)
--
-- NOTE: "Series 2" as a distinct split product began in 1994 (same year
-- as Series 1). Years 1992–1993 in this table are phantom rows with no
-- actual product → DELETE.
--
-- Series 1 and Series 2 share identical parallel structures for each
-- calendar year, with the following exceptions:
--   • 2025 S2: Traditional Black /74 re-appears (S1 used Black foil /10 only)
--   • 2025 S2: Clear Variation /10 instead of Black Diamante /10
--   • 2025 S2: Diamante Foil variants absent (Holo/Rainbow only)
--
-- BONUS FIX included in this file:
--   Topps Series 1 2024 was deployed in v20 without Black /73 — corrected here.
--
-- ACTIONS:
--   DELETE  — 2 rows (years 1992, 1993 — no Series 2 product)
--   UPDATE  — 32 rows (1994–2025) + 1 Series 1 correction (2024)
-- =============================================================================

-- ---------------------------------------------------------------------------
-- BONUS FIX — Topps Series 1 2024: add Black /73 (missed in v20)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = parallels || '[{"name":"Black","numbered":true,"print_run":73}]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2024
  AND NOT (parallels @> '[{"name":"Black"}]'::jsonb);

-- ---------------------------------------------------------------------------
-- SECTION 1 — DELETE phantom years 1992–1993 (no Topps Series 2 product)
-- ---------------------------------------------------------------------------
DELETE FROM card_sets
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball'
  AND year IN (1992, 1993);

-- ---------------------------------------------------------------------------
-- SECTION 2 — 1994: Gold (unnumbered) — same as Series 1
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 1994;

-- ---------------------------------------------------------------------------
-- SECTION 3 — 1995–1997: No full-set parallels
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball'
  AND year IN (1995, 1996, 1997);

-- ---------------------------------------------------------------------------
-- SECTION 4 — 1998: Minted in Cooperstown (bronze stamp, 1:8 packs)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Minted in Cooperstown","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 1998;

-- ---------------------------------------------------------------------------
-- SECTION 5 — 1999–2000: MVP Promotion (~100/card, partial set)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"MVP Promotion","numbered":false,"print_run":100}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball'
  AND year IN (1999, 2000);

-- ---------------------------------------------------------------------------
-- SECTION 6 — 2001: Gold /2001 (50th Anniversary) + factory set parallels
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2001},
  {"name":"Limited Edition","numbered":false,"print_run":null},
  {"name":"Home Team Advantage","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2001;

-- ---------------------------------------------------------------------------
-- SECTION 7 — 2002: Gold /2002 only
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2002}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2002;

-- ---------------------------------------------------------------------------
-- SECTION 8 — 2003: Gold /2003 + Black /52
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2003},
  {"name":"Black","numbered":true,"print_run":52}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2003;

-- ---------------------------------------------------------------------------
-- SECTION 9 — 2004: Gold /2004 + Black /53
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2004},
  {"name":"Black","numbered":true,"print_run":53}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2004;

-- ---------------------------------------------------------------------------
-- SECTION 10 — 2005: Gold /2005 + Black /54
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2005},
  {"name":"Black","numbered":true,"print_run":54}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2005;

-- ---------------------------------------------------------------------------
-- SECTION 11 — 2006: Gold /2006 + Black /55
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2006},
  {"name":"Black","numbered":true,"print_run":55}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2006;

-- ---------------------------------------------------------------------------
-- SECTION 12 — 2007: Gold /2007 + Black /56
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2007},
  {"name":"Black","numbered":true,"print_run":56}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2007;

-- ---------------------------------------------------------------------------
-- SECTION 13 — 2008: Gold /2008 + Black /57
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2008},
  {"name":"Black","numbered":true,"print_run":57}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2008;

-- ---------------------------------------------------------------------------
-- SECTION 14 — 2009: + retail exclusives + Platinum 1/1
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2009},
  {"name":"Black","numbered":true,"print_run":58},
  {"name":"Walmart All-Black","numbered":false,"print_run":null},
  {"name":"Target Throwbacks","numbered":false,"print_run":null},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2009;

-- ---------------------------------------------------------------------------
-- SECTION 15 — 2010: + Copper /399
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2010},
  {"name":"Copper","numbered":true,"print_run":399},
  {"name":"Black","numbered":true,"print_run":59},
  {"name":"Walmart All-Black","numbered":false,"print_run":null},
  {"name":"Target Throwbacks","numbered":false,"print_run":null},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2010;

-- ---------------------------------------------------------------------------
-- SECTION 16 — 2011: 60th Anniversary edition
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Platinum Diamond Anniversary","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2011},
  {"name":"Black","numbered":true,"print_run":60},
  {"name":"Walmart All-Black","numbered":false,"print_run":null},
  {"name":"Target Throwbacks","numbered":false,"print_run":null},
  {"name":"Canary Diamond Anniversary","numbered":true,"print_run":1},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2011;

-- ---------------------------------------------------------------------------
-- SECTION 17 — 2012
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Golden Moments","numbered":false,"print_run":null},
  {"name":"Black","numbered":true,"print_run":61},
  {"name":"Orange","numbered":true,"print_run":190},
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Red","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Platinum","numbered":true,"print_run":1},
  {"name":"Wood","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2012;

-- ---------------------------------------------------------------------------
-- SECTION 18 — 2013
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Silver Slate","numbered":false,"print_run":null},
  {"name":"Emerald Foil","numbered":false,"print_run":null},
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Red","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2013},
  {"name":"Desert Camo Foil","numbered":true,"print_run":99},
  {"name":"Black","numbered":true,"print_run":62},
  {"name":"Silk","numbered":true,"print_run":50},
  {"name":"Pink","numbered":true,"print_run":50},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2013;

-- ---------------------------------------------------------------------------
-- SECTION 19 — 2014
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Red","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Green","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Red Hot Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2014},
  {"name":"Camo","numbered":true,"print_run":99},
  {"name":"Black","numbered":true,"print_run":63},
  {"name":"Pink","numbered":true,"print_run":50},
  {"name":"Clear Stock","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2014;

-- ---------------------------------------------------------------------------
-- SECTION 20 — 2015
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Clear","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2015},
  {"name":"Snow Camo","numbered":true,"print_run":99},
  {"name":"Black","numbered":true,"print_run":64},
  {"name":"Pink","numbered":true,"print_run":50},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2015;

-- ---------------------------------------------------------------------------
-- SECTION 21 — 2016
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Negative","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2016},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Black","numbered":true,"print_run":65},
  {"name":"Pink","numbered":true,"print_run":50},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2016;

-- ---------------------------------------------------------------------------
-- SECTION 22 — 2017
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Negative","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2017},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Black","numbered":true,"print_run":66},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Powder Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2017;

-- ---------------------------------------------------------------------------
-- SECTION 23 — 2018
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Negative","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2018},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":67},
  {"name":"Mother''s Day Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2018;

-- ---------------------------------------------------------------------------
-- SECTION 24 — 2019
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2019},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":68},
  {"name":"Father''s Day Blue","numbered":true,"print_run":50},
  {"name":"Mother''s Day Pink","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2019;

-- ---------------------------------------------------------------------------
-- SECTION 25 — 2020
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold Foil","numbered":false,"print_run":null},
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2020},
  {"name":"Advanced Stat","numbered":true,"print_run":300},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":69},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2020;

-- ---------------------------------------------------------------------------
-- SECTION 26 — 2021: 70th Anniversary foilboard tiers
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Royal Blue","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Gold Foil","numbered":false,"print_run":null},
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2021},
  {"name":"Green","numbered":true,"print_run":499},
  {"name":"Advanced Stat","numbered":true,"print_run":300},
  {"name":"Orange","numbered":true,"print_run":299},
  {"name":"Red","numbered":true,"print_run":199},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":70},
  {"name":"Platinum Anniversary","numbered":true,"print_run":70},
  {"name":"Mother''s Day","numbered":true,"print_run":50},
  {"name":"Father''s Day","numbered":true,"print_run":50},
  {"name":"Memorial Day","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"70th Anniversary","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2021;

-- ---------------------------------------------------------------------------
-- SECTION 27 — 2022
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Gold Foil","numbered":false,"print_run":null},
  {"name":"Royal Blue","numbered":false,"print_run":null},
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2022},
  {"name":"Green Foilboard","numbered":true,"print_run":499},
  {"name":"Advanced Stats","numbered":true,"print_run":300},
  {"name":"Orange Foilboard","numbered":true,"print_run":299},
  {"name":"Red Foilboard","numbered":true,"print_run":199},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":71},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Powder Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2022;

-- ---------------------------------------------------------------------------
-- SECTION 28 — 2023
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold Foil","numbered":false,"print_run":null},
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Royal Blue","numbered":false,"print_run":null},
  {"name":"Silver Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2023},
  {"name":"Green Foilboard","numbered":true,"print_run":499},
  {"name":"Advanced Stats","numbered":true,"print_run":300},
  {"name":"Orange Foilboard","numbered":true,"print_run":299},
  {"name":"Red Foilboard","numbered":true,"print_run":199},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":72},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Powder Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Clear","numbered":true,"print_run":10},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2023;

-- ---------------------------------------------------------------------------
-- SECTION 29 — 2024: Blue Foilboard /999 + Purple Foilboard /799 + Black /73
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Royal Blue","numbered":false,"print_run":null},
  {"name":"Yellow Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2024},
  {"name":"Blue Foilboard","numbered":true,"print_run":999},
  {"name":"Purple Foilboard","numbered":true,"print_run":799},
  {"name":"Green Foilboard","numbered":true,"print_run":499},
  {"name":"Orange Foilboard","numbered":true,"print_run":299},
  {"name":"Red Foilboard","numbered":true,"print_run":199},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Black","numbered":true,"print_run":73},
  {"name":"Yellow Crackle","numbered":true,"print_run":50},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Powder Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2024;

-- ---------------------------------------------------------------------------
-- SECTION 30 — 2025: Multi-foil era; Black /74 returns; Clear /10; no Diamante
-- Series 2 released ~June 2025; includes holiday parallels available mid-year.
-- Note: Aqua Holo/Rainbow Foil are unnumbered retail exclusives.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Holo Foil","numbered":false,"print_run":null},
  {"name":"Aqua Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Aqua Holo Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2025},
  {"name":"Pink Holo Foil","numbered":true,"print_run":800},
  {"name":"Purple Rainbow Foil","numbered":true,"print_run":250},
  {"name":"Purple Holo Foil","numbered":true,"print_run":250},
  {"name":"Blue Rainbow Foil","numbered":true,"print_run":150},
  {"name":"Blue Holo Foil","numbered":true,"print_run":150},
  {"name":"Green Rainbow Foil","numbered":true,"print_run":99},
  {"name":"Green Holo Foil","numbered":true,"print_run":99},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"Gold Rainbow Foil","numbered":true,"print_run":50},
  {"name":"Gold Holo Foil","numbered":true,"print_run":50},
  {"name":"Canvas","numbered":true,"print_run":50},
  {"name":"Orange Rainbow Foil","numbered":true,"print_run":25},
  {"name":"Orange Holo Foil","numbered":true,"print_run":25},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Wood","numbered":true,"print_run":25},
  {"name":"Black","numbered":true,"print_run":74},
  {"name":"Black Rainbow Foil","numbered":true,"print_run":10},
  {"name":"Black Holo Foil","numbered":true,"print_run":10},
  {"name":"Clear Variation","numbered":true,"print_run":10},
  {"name":"Red Rainbow Foil","numbered":true,"print_run":5},
  {"name":"Red Holo Foil","numbered":true,"print_run":5},
  {"name":"Holiday Waves","numbered":true,"print_run":1},
  {"name":"Foilfractor","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball' AND year = 2025;
