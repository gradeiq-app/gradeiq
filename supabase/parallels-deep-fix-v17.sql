-- =============================================================================
-- parallels-deep-fix-v17.sql
-- Panini Hoops Basketball — year-accurate parallels
-- brand='Panini', set_name='Hoops', sport='basketball'
-- Covers DB years 1989–2025 (37 rows total)
--
-- ACTIONS:
--   DELETE  — 12 phantom years with no main Hoops base-set product:
--             2000–2010 (brand transitioned to Hoops Hot Prospects / Hoops Stars,
--             then Fleer bankruptcy gap, then no 2010-11 Panini Hoops existed)
--             2025 (2025-26 is Topps NBA Hoops, not Panini)
--
--   UPDATE  — 25 remaining years with historically accurate parallel structures:
--             Pre-Panini era  1989–1999  (NBA Properties / SkyBox / Fleer)
--             Panini era      2011–2024
-- =============================================================================

-- ---------------------------------------------------------------------------
-- SECTION 1 — DELETE phantom years (no matching main-set product)
-- ---------------------------------------------------------------------------

DELETE FROM card_sets
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball'
  AND year IN (2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2025);

-- ---------------------------------------------------------------------------
-- SECTION 2 — Pre-Panini era (NBA Properties / SkyBox)  1989–1999
-- ---------------------------------------------------------------------------

-- 1989-90 NBA Hoops — pure base set, no parallels
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1989;

-- 1990-91 NBA Hoops — pure base set, no parallels
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1990;

-- 1991-92 NBA Hoops — pure base set, no parallels
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1991;

-- 1992-93 NBA Hoops — pure base set, no parallels
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1992;

-- 1993-94 NBA Hoops — Fifth Anniversary Gold (full 423-card parallel, unnumbered)
UPDATE card_sets SET parallels = '[
  {"name":"Fifth Anniversary Gold","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1993;

-- 1994-95 NBA Hoops — no base parallel (Gold Mine was an in-set subset #431-450, not a full parallel)
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1994;

-- 1995-96 NBA Hoops — no base parallel (Power Palette paralleled only the SkyView insert)
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1995;

-- 1996-97 NBA Hoops — no full-base parallel (Gold Foil was the "Hoops Rookie" subset, card #3 not base #281)
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1996;

-- 1997-98 NBA Hoops — no base parallel (Autographics was a signed-insert line only)
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1997;

-- 1998-99 NBA Hoops — no base parallel
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1998;

-- 1999-00 NBA Hoops (last SkyBox-era main Hoops base set) — no base parallel
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 1999;

-- ---------------------------------------------------------------------------
-- SECTION 3 — Panini era  2011–2024
-- ---------------------------------------------------------------------------

-- 2011-12 Panini NBA Hoops — first Panini Hoops; 2 unnumbered base parallels
UPDATE card_sets SET parallels = '[
  {"name":"Glossy","numbered":false,"print_run":null},
  {"name":"Artist Proof","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2011;

-- 2012-13 Panini NBA Hoops — added Artist Proof Black 1/1
UPDATE card_sets SET parallels = '[
  {"name":"Glossy","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Artist Proof","numbered":false,"print_run":null},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2012;

-- 2013-14 Panini NBA Hoops — added color (Red, Blue) unnumbered parallels
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Glossy","numbered":false,"print_run":null},
  {"name":"Red","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Artist Proof","numbered":false,"print_run":null},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2013;

-- 2014-15 Panini NBA Hoops — first numbered parallels (Silver /399, Blue /349, Red /299)
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Green","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":399},
  {"name":"Blue","numbered":true,"print_run":349},
  {"name":"Red","numbered":true,"print_run":299},
  {"name":"Artist Proof","numbered":true,"print_run":99},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2014;

-- 2015-16 Panini NBA Hoops — Silver drops to /299; Blue /399 retail
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Green","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Blue","numbered":true,"print_run":399},
  {"name":"Silver","numbered":true,"print_run":299},
  {"name":"Red","numbered":true,"print_run":299},
  {"name":"Artist Proof","numbered":true,"print_run":99},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2015;

-- 2016-17 Panini NBA Hoops — Teal Explosion introduced; Silver drops to /99; retail exclusives added
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Green","numbered":true,"print_run":149},
  {"name":"Silver","numbered":true,"print_run":99},
  {"name":"Blue Checkerboard","numbered":true,"print_run":75},
  {"name":"Orange Explosion","numbered":true,"print_run":75},
  {"name":"Teal","numbered":true,"print_run":49},
  {"name":"Red","numbered":true,"print_run":49},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red Checkerboard","numbered":true,"print_run":15},
  {"name":"Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2016;

-- 2017-18 Panini NBA Hoops — Silver jumps to /199; Teal /125 added; Premium Box Set /199
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Teal","numbered":true,"print_run":125},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Blue Checkerboard","numbered":true,"print_run":75},
  {"name":"Orange Explosion","numbered":true,"print_run":75},
  {"name":"Red","numbered":true,"print_run":49},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Red Checkerboard","numbered":true,"print_run":15},
  {"name":"Gold","numbered":true,"print_run":10}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2017;

-- 2018-19 Panini NBA Hoops — Purple, Winter, Purple Winter debut; Artist Proof Black /1 returns
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Blue Checkerboard","numbered":true,"print_run":75},
  {"name":"Red","numbered":true,"print_run":49},
  {"name":"Teal","numbered":true,"print_run":49},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Checkerboard","numbered":true,"print_run":15},
  {"name":"Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2018;

-- 2019-20 Panini NBA Hoops — Neon Green, Blue Explosion /49; Red /75 replaces Red /49
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Neon Green","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Blue Explosion","numbered":true,"print_run":49},
  {"name":"Teal","numbered":true,"print_run":49},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2019;

-- 2020-21 Panini NBA Hoops — Hyper era begins (Hyper Blue, Hyper Red /99, Hyper Green /25, Hyper Gold /10)
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Hyper Blue","numbered":false,"print_run":null},
  {"name":"Neon Green","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Explosion","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Hyper Red","numbered":true,"print_run":99},
  {"name":"Green Explosion","numbered":true,"print_run":89},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Teal","numbered":true,"print_run":70},
  {"name":"Blue Explosion","numbered":true,"print_run":59},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Hyper Green","numbered":true,"print_run":25},
  {"name":"Orange","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Hyper Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2020;

-- 2021-22 Panini NBA Hoops — 75th Anniversary edition; Green Ice, Anniversary Edition added
UPDATE card_sets SET parallels = '[
  {"name":"Anniversary Edition","numbered":false,"print_run":null},
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Green Ice","numbered":false,"print_run":null},
  {"name":"Hyper Blue","numbered":false,"print_run":null},
  {"name":"Neon Green","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Hyper Red","numbered":true,"print_run":99},
  {"name":"75th Anniversary","numbered":true,"print_run":75},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Blue Explosion","numbered":true,"print_run":59},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Hyper Green","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Hyper Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2021;

-- 2022-23 Panini NBA Hoops — Impulse unnumbered added; Gravity /75 replaces 75th Anniversary
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Hyper Blue","numbered":false,"print_run":null},
  {"name":"Impulse","numbered":false,"print_run":null},
  {"name":"Neon Green","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Hyper Red","numbered":true,"print_run":99},
  {"name":"Gravity","numbered":true,"print_run":75},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Blue Explosion","numbered":true,"print_run":59},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Hyper Green","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Hyper Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2022;

-- 2023-24 Panini NBA Hoops — Premium Box Set /199 added
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Hyper Blue","numbered":false,"print_run":null},
  {"name":"Impulse","numbered":false,"print_run":null},
  {"name":"Neon Green","numbered":false,"print_run":null},
  {"name":"Purple","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Yellow","numbered":false,"print_run":null},
  {"name":"Premium Box Set","numbered":true,"print_run":199},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Hyper Red","numbered":true,"print_run":99},
  {"name":"Gravity","numbered":true,"print_run":75},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Blue Explosion","numbered":true,"print_run":59},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Hyper Green","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Hyper Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2023;

-- 2024-25 Panini NBA Hoops (last Panini NBA Hoops before Topps took over the license)
-- New: Texture, Storm /299, Teal /175, Dragon Year /75; Silver stays /199
UPDATE card_sets SET parallels = '[
  {"name":"Blue","numbered":false,"print_run":null},
  {"name":"Purple Winter","numbered":false,"print_run":null},
  {"name":"Red Backs","numbered":false,"print_run":null},
  {"name":"Teal Explosion","numbered":false,"print_run":null},
  {"name":"Texture","numbered":false,"print_run":null},
  {"name":"Winter","numbered":false,"print_run":null},
  {"name":"Storm","numbered":true,"print_run":299},
  {"name":"Silver","numbered":true,"print_run":199},
  {"name":"Teal","numbered":true,"print_run":175},
  {"name":"Orange","numbered":true,"print_run":149},
  {"name":"Green","numbered":true,"print_run":99},
  {"name":"Red","numbered":true,"print_run":75},
  {"name":"Dragon Year","numbered":true,"print_run":75},
  {"name":"Blue Explosion","numbered":true,"print_run":59},
  {"name":"Artist Proof","numbered":true,"print_run":25},
  {"name":"Orange Explosion","numbered":true,"print_run":25},
  {"name":"Red Explosion","numbered":true,"print_run":15},
  {"name":"Artist Proof Gold","numbered":true,"print_run":10},
  {"name":"Artist Proof Black","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball' AND year = 2024;
