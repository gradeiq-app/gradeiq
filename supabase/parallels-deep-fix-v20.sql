-- =============================================================================
-- parallels-deep-fix-v20.sql
-- Topps Series 1 Baseball — year-accurate parallels
-- brand='Topps', set_name='Series 1', sport='baseball'
-- Covers DB years 1951–2026 (76 rows total)
--
-- NOTE ON PRE-1994 ROWS:
--   "Series 1" as a distinct split-series product began in 1994.
--   Years 1951–1993 in this table represent the original unified Topps
--   Baseball annual sets (not a "Series 1" split). Parallels are set
--   to the historically accurate structure for the full Topps flagship
--   set of each year. No rows are deleted since the original Topps set
--   DID exist every year 1951–2026.
--
-- PARALLEL HISTORY SUMMARY:
--   1951–1991: No parallels — base set only
--   1992:      Gold (unnumbered, 1/box) + Gold Winner (contest parallel)
--   1993:      Gold (unnumbered, 1/pack)
--   1994:      Gold (unnumbered) — last year before parallel gap
--   1995–1997: No parallels (Spectralite was promo-only; Team Topps was partial)
--   1998:      Minted in Cooperstown (unnumbered, 1:8 packs, bronze stamp)
--   1999:      MVP Promotion (unnumbered, ~100 copies each, partial set)
--   2000:      MVP Promotion (unnumbered, ~100 copies each, partial set)
--   2001:      Gold /2001 (50th Anniversary) + factory set parallels
--   2002:      Gold /2002 only (Black parallel not yet introduced)
--   2003:      Gold /2003 + Black /52 (Topps' 52nd year, first Black)
--   2004–2008: Gold /YEAR + Black /YY (incrementing: /53, /54, /55, /56, /57)
--   2009–2011: Gold /YEAR + Black /YY + retail exclusives + Platinum 1/1
--   2012:      Golden Moments parallel (unnumbered) + Black /61 + retail exclusives
--   2013–2015: Multi-tier: Emerald/Rainbow + Gold/YEAR + Camo/Snow /99 + Black + Pink + Clear + Platinum
--   2016–2019: Rainbow Foil + Gold /YEAR + Vintage Stock /99 + Black + holiday parallels /25-/76 + Clear /10
--   2020–2023: + Foilboard color tiers (/499, /299, /199) + Advanced Stats /300
--   2024:      + Blue Foilboard /999 + Purple Foilboard /799
--   2025:      Multi-foil era (Rainbow, Holo, Diamante) × 6 colors
--   2026:      Expanded foil system + 75 Years of Topps /75 + Black Border /75
--
-- ACTIONS:
--   DELETE  — 0 rows
--   UPDATE  — all 76 rows
-- =============================================================================

-- ---------------------------------------------------------------------------
-- SECTION 1 — 1951–1991: No parallels (41 years)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball'
  AND year BETWEEN 1951 AND 1991;

-- ---------------------------------------------------------------------------
-- SECTION 2 — 1992: Gold (1/box, unnumbered) + Gold Winner (contest)
-- First modern parallel in baseball cards; Gold Winner was prize redemption.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null},
  {"name":"Gold Winner","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 1992;

-- ---------------------------------------------------------------------------
-- SECTION 3 — 1993: Gold only (1/pack, unnumbered)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 1993;

-- ---------------------------------------------------------------------------
-- SECTION 4 — 1994: Gold only (unnumbered) — last of first Gold era
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 1994;

-- ---------------------------------------------------------------------------
-- SECTION 5 — 1995–1997: No full-set parallels
-- 1995: Spectralite was promo-card only (9 pre-production cards), not a base parallel.
-- 1996: Team Topps was a partial subset for 3 teams, not a full parallel.
-- 1997: No parallels.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball'
  AND year IN (1995, 1996, 1997);

-- ---------------------------------------------------------------------------
-- SECTION 6 — 1998: Minted in Cooperstown (503 cards, bronze stamp, 1:8 packs)
-- Printed on-site at the Baseball Hall of Fame via portable press; unnumbered.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Minted in Cooperstown","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 1998;

-- ---------------------------------------------------------------------------
-- SECTION 7 — 1999: MVP Promotion (~400-card partial parallel, unnumbered, ~100/card)
-- Distributed via in-pack contest; fans won cards at ballpark promotions.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"MVP Promotion","numbered":false,"print_run":100}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 1999;

-- ---------------------------------------------------------------------------
-- SECTION 8 — 2000: MVP Promotion (400-card partial parallel, unnumbered, ~100/card)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"MVP Promotion","numbered":false,"print_run":100}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2000;

-- ---------------------------------------------------------------------------
-- SECTION 9 — 2001: Gold /2001 (50th Anniversary) + factory set exclusives
-- Pack-inserted: Gold numbered to 2001 (1:17 S1, 1:14 S2).
-- Factory set: Limited Edition (3,805 sets) + Home Team Advantage (unnumbered).
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2001},
  {"name":"Limited Edition","numbered":false,"print_run":null},
  {"name":"Home Team Advantage","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2001;

-- ---------------------------------------------------------------------------
-- SECTION 10 — 2002: Gold /2002 only (Black not yet introduced)
-- Note: Black parallel debuted in 2003; the 2002 set had ONLY Gold numbered /2002.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2002}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2002;

-- ---------------------------------------------------------------------------
-- SECTION 11 — 2003: Gold /2003 + Black /52 (Topps' 52nd year; first Black parallel)
-- Black was jumbo-pack exclusive; Gold was standard hobby/jumbo.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2003},
  {"name":"Black","numbered":true,"print_run":52}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2003;

-- ---------------------------------------------------------------------------
-- SECTION 12 — 2004: Gold /2004 + Black /53
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2004},
  {"name":"Black","numbered":true,"print_run":53}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2004;

-- ---------------------------------------------------------------------------
-- SECTION 13 — 2005: Gold /2005 + Black /54
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2005},
  {"name":"Black","numbered":true,"print_run":54}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2005;

-- ---------------------------------------------------------------------------
-- SECTION 14 — 2006: Gold /2006 + Black /55
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2006},
  {"name":"Black","numbered":true,"print_run":55}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2006;

-- ---------------------------------------------------------------------------
-- SECTION 15 — 2007: Gold /2007 + Black /56
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2007},
  {"name":"Black","numbered":true,"print_run":56}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2007;

-- ---------------------------------------------------------------------------
-- SECTION 16 — 2008: Gold /2008 + Black /57
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2008},
  {"name":"Black","numbered":true,"print_run":57}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2008;

-- ---------------------------------------------------------------------------
-- SECTION 17 — 2009: Gold /2009 + Black /58 + retail exclusives + Platinum 1/1
-- Walmart All-Black and Target Throwbacks introduced as retail exclusives.
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2009},
  {"name":"Black","numbered":true,"print_run":58},
  {"name":"Walmart All-Black","numbered":false,"print_run":null},
  {"name":"Target Throwbacks","numbered":false,"print_run":null},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2009;

-- ---------------------------------------------------------------------------
-- SECTION 18 — 2010: + Copper /399 (Value Box exclusive, August release)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Gold","numbered":true,"print_run":2010},
  {"name":"Copper","numbered":true,"print_run":399},
  {"name":"Black","numbered":true,"print_run":59},
  {"name":"Walmart All-Black","numbered":false,"print_run":null},
  {"name":"Target Throwbacks","numbered":false,"print_run":null},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2010;

-- ---------------------------------------------------------------------------
-- SECTION 19 — 2011: 60th Anniversary edition — Platinum Diamond Anniversary (1:4)
-- Special foil parallel for 60th anniv. Gold continues /2011; Canary Diamond 1/1.
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2011;

-- ---------------------------------------------------------------------------
-- SECTION 20 — 2012: Gold moved to foil/unnumbered format (Golden Moments, 1:4)
-- Traditional year-numbered Gold was shifted to Update Series in 2012.
-- Orange /190 was factory-set exclusive (hobby factory set).
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2012;

-- ---------------------------------------------------------------------------
-- SECTION 21 — 2013: Multi-tier parallel system expanded
-- Silver Slate via wrapper redemption; retail exclusives (Blue, Purple, Red);
-- Gold back to year-numbered (/2013); Desert Camo /99; Silk /50 (partial 100 cards).
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2013;

-- ---------------------------------------------------------------------------
-- SECTION 22 — 2014: Nine parallel tiers + holiday-style retail exclusives
-- Red Hot Foil (1:6); Clear Stock /10 (hobby only, 100-card partial).
-- Sparkle variations are SP photo variants, not parallels — excluded here.
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2014;

-- ---------------------------------------------------------------------------
-- SECTION 23 — 2015: Silver /499 removed; Rainbow Foil introduced; Snow Camo /99
-- Framed (numbered ~1/case) and Clear (hobby, unnumbered) added.
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2015;

-- ---------------------------------------------------------------------------
-- SECTION 24 — 2016: Vintage Stock /99 replaces Snow Camo; Clear now numbered /10;
-- Negative (hobby/jumbo, unnumbered) added; Framed (hobby/jumbo, ~1/case).
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2016;

-- ---------------------------------------------------------------------------
-- SECTION 25 — 2017: Holiday parallels introduced (Mother's Day /50, Father's Day /50,
-- Memorial Day Camo /25). Negative continued. Purple retail exclusive.
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2017;

-- ---------------------------------------------------------------------------
-- SECTION 26 — 2018: Independence Day /76 added to holiday tier
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2018;

-- ---------------------------------------------------------------------------
-- SECTION 27 — 2019: 150th Anniversary year; same core structure as 2018
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2019;

-- ---------------------------------------------------------------------------
-- SECTION 28 — 2020: Advanced Stat /300 added; Gold Foil (jumbo);
-- Yellow (Walgreens) + Purple (Meijer) retail exclusives added
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2020;

-- ---------------------------------------------------------------------------
-- SECTION 29 — 2021: 70th Anniversary — foilboard colors added (Green /499,
-- Orange /299, Red /199); Platinum Anniversary /70; 70th Anniversary 1/1
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2021;

-- ---------------------------------------------------------------------------
-- SECTION 30 — 2022: Orange Foilboard /299 and Red Foilboard /199 debut
-- as distinct names from Update series; Premiere Party (unnumbered event parallel)
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2022;

-- ---------------------------------------------------------------------------
-- SECTION 31 — 2023: Silver Foil (retail super box) added
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
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2023;

-- ---------------------------------------------------------------------------
-- SECTION 32 — 2024: Blue Foilboard /999 and Purple Foilboard /799 added;
-- Yellow Crackle /50 (hanger exclusive); Yellow and Yellow Foil retail parallels
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
  {"name":"Yellow Crackle","numbered":true,"print_run":50},
  {"name":"Mother''s Day Hot Pink","numbered":true,"print_run":50},
  {"name":"Father''s Day Powder Blue","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Platinum","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2024;

-- ---------------------------------------------------------------------------
-- SECTION 33 — 2025: Multi-foil era — Rainbow/Holo/Diamante × 6 color tiers
-- Canvas /50 added; Wood /25; numbered foil variants per color
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Holo Foil","numbered":false,"print_run":null},
  {"name":"Diamante Foil","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2025},
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
  {"name":"Gold Diamante Foil","numbered":true,"print_run":50},
  {"name":"Canvas","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Orange Rainbow Foil","numbered":true,"print_run":25},
  {"name":"Orange Holo Foil","numbered":true,"print_run":25},
  {"name":"Orange Diamante Foil","numbered":true,"print_run":25},
  {"name":"Wood","numbered":true,"print_run":25},
  {"name":"Black Rainbow Foil","numbered":true,"print_run":10},
  {"name":"Black Holo Foil","numbered":true,"print_run":10},
  {"name":"Black Diamante Foil","numbered":true,"print_run":10},
  {"name":"Red Rainbow Foil","numbered":true,"print_run":5},
  {"name":"Red Holo Foil","numbered":true,"print_run":5},
  {"name":"Red Diamante Foil","numbered":true,"print_run":5},
  {"name":"Foilfractor","numbered":true,"print_run":1},
  {"name":"Platinum Holo Foil","numbered":true,"print_run":1},
  {"name":"First Card","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2025;

-- ---------------------------------------------------------------------------
-- SECTION 34 — 2026: Pink Holo Foil /800; Yellow tiers /399; 75 Years of Topps /75;
-- Black Border (new name) /75; Canvas /50; Orange /25; Black /10; Red /5
-- (Green /99 splits into multiple formats; Japan Cherry Blossom /99 excluded)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow Foil","numbered":false,"print_run":null},
  {"name":"Holo Foil","numbered":false,"print_run":null},
  {"name":"Diamante Foil","numbered":false,"print_run":null},
  {"name":"Sandglitter","numbered":false,"print_run":null},
  {"name":"Gold","numbered":true,"print_run":2026},
  {"name":"Pink Holo Foil","numbered":true,"print_run":800},
  {"name":"Yellow Holo Foil","numbered":true,"print_run":399},
  {"name":"Yellow Rainbow Foil","numbered":true,"print_run":399},
  {"name":"Purple Holo Foil","numbered":true,"print_run":250},
  {"name":"Purple Rainbow Foil","numbered":true,"print_run":250},
  {"name":"Blue Holo Foil","numbered":true,"print_run":150},
  {"name":"Blue Rainbow Foil","numbered":true,"print_run":150},
  {"name":"Green Diamante Foil","numbered":true,"print_run":99},
  {"name":"Green Rainbow Foil","numbered":true,"print_run":99},
  {"name":"Vintage Stock","numbered":true,"print_run":99},
  {"name":"Independence Day","numbered":true,"print_run":76},
  {"name":"75 Years of Topps","numbered":true,"print_run":75},
  {"name":"Black Border","numbered":true,"print_run":75},
  {"name":"Canvas","numbered":true,"print_run":50},
  {"name":"Gold Holo Foil","numbered":true,"print_run":50},
  {"name":"Memorial Day Camo","numbered":true,"print_run":25},
  {"name":"Orange Holo Foil","numbered":true,"print_run":25},
  {"name":"Wood","numbered":true,"print_run":25},
  {"name":"Black Holo Foil","numbered":true,"print_run":10},
  {"name":"Red Holo Foil","numbered":true,"print_run":5},
  {"name":"Foilfractor","numbered":true,"print_run":1},
  {"name":"First Card","numbered":true,"print_run":1}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball' AND year = 2026;
