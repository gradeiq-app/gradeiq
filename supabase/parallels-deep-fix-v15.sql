-- ============================================================
-- parallels-deep-fix-v15.sql
-- Bowman Draft Chrome Baseball 1997-2025: Replace uniform 19-parallel
-- template with historically accurate per-year parallel structures.
-- Sources: CardboardConnection.com per-year checklists, Beckett
-- NOTE: brand = 'Bowman', set_name = 'Draft Chrome', sport = 'baseball'
-- Key difference from main Bowman Chrome: NO International parallels
-- (1997-1999), NO Retro/Future (2000); 2012-2025 structure diverges
-- significantly from regular Bowman Chrome (different print runs)
-- ============================================================

-- 1997: First Bowman Chrome Draft Picks — Refractor only (no International)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 1997;

-- 1998: Gold Refractor /25 added
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Bowman Chrome Draft Gold Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 1998;

-- 1999: Same — Refractor (unnumb), Gold Refractor /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Bowman Chrome Draft Gold Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 1999;

-- 2000: Refractor only (no Retro/Future — that was base Bowman Chrome)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2000;

-- 2001: X-Fractor (unnumb), Gold Refractor /99; Draft Auto: Refractor /500
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Gold Refractor /99", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2001;

-- 2002: Refractor /500, X-Fractor /250, Gold /50; auto versions same
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Draft Auto X-Fractor"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2002;

-- 2003: Same as 2002
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Draft Auto X-Fractor"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2003;

-- 2004: Refractor (unnumb), X-Fractor /172, Blue /290, Gold /50
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /172", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /290", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Draft Auto X-Fractor"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2004;

-- 2005: X-Fractor /225, Blue /150, Gold /50, Red /5, SuperFractor /1 debut
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /225", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2005;

-- 2006: Orange /25 added to rainbow; full tier structure established
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2006;

-- 2007: Same rainbow as 2006
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2007;

-- 2008: Same as 2007
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2008;

-- 2009: Same as 2008
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome Draft X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2009;

-- 2010: Refractor /500 (numbered), Blue /150, Gold /50, Orange /25, Red /5
--       (Purple /899 was retail-exclusive in regular Chrome; not in Draft Chrome)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2010;

-- 2011: Same as 2010 (Harper/Trout draft class year)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /500", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2011;

-- 2012: Base Refractor /300 (numbered); Blue /250; no Purple on base; auto Blue /150
--       (First year as major standalone product post-2012 reorganization)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor /300", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Blue Refractor /250", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2012;

-- 2013: Different structure from main Chrome — Blue /99, Green /75 (tighter than main Chrome's /250, /199)
--       Auto adds Purple (unnumb); Ice parallels also exist but are paper-based
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Blue Refractor /99", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /75", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Black Refractor /35", "ebay_kw": "Bowman Chrome Draft Black Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /99", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Green /75", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Black /35", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2013;

-- 2014: Blue /399 (much higher than main Chrome); Green /150; Black /75 (Hobby)
--       Auto tiers compressed: Blue /150, Green /99, Gold /50, Black /35, Shimmer /15, Purple /10
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Blue Refractor /399", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /150", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Black Refractor /75", "ebay_kw": "Bowman Chrome Draft Black Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Black /35", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Shimmer /15", "ebay_kw": "Bowman Chrome Draft Auto Shimmer"},
  {"label": "Draft Auto Purple /10", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2014;

-- 2015: Clean simplified structure; Sky Blue (unnumb); Purple only for autos, not base
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Black Asia /35", "ebay_kw": "Bowman Chrome Draft Auto Black Asia"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2015;

-- 2016: Purple /250 now on base chrome; Sky Blue still unnumbered
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2016;

-- 2017: Sky Blue /399 (Jumbo); 70th Anniversary Logo /200 added; Wave auto variants debut
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor /399", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Bowman 70th Logo /200", "ebay_kw": "Bowman Chrome Draft 70th Anniversary"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto 70th Logo /70", "ebay_kw": "Bowman Chrome Draft Auto 70th"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2017;

-- 2018: Sparkle (unnumb) added; full Wave auto structure same as 2017 minus 70th Logo
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Sparkle Refractor", "ebay_kw": "Bowman Chrome Draft Sparkle Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto Black Wave /1", "ebay_kw": "Bowman Chrome Draft Auto Black Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2018;

-- 2019: Same structure as 2018 (Wave auto tiers continue)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Sparkle Refractor", "ebay_kw": "Bowman Chrome Draft Sparkle Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto Black Wave /1", "ebay_kw": "Bowman Chrome Draft Auto Black Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2019;

-- 2020: Asia Mojo (unnumb); Sky Blue (Jumbo); same Wave auto structure
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Sparkle Refractor", "ebay_kw": "Bowman Chrome Draft Sparkle Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto Black Wave /1", "ebay_kw": "Bowman Chrome Draft Auto Black Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2020;

-- 2021: MAJOR EXPANSION — Lava variants debut; Aqua Lava /199, Yellow Lava /75;
--       Auto: Black Wave /1, Red Lava /5, Red Wave /5, Blue Wave /150 alongside core tiers
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "B&W RayWave Refractor", "ebay_kw": "Bowman Chrome Draft RayWave"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Aqua Lava Refractor /199", "ebay_kw": "Bowman Chrome Draft Aqua Lava Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Green Sparkle Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Sparkle Refractor"},
  {"label": "Yellow Lava Refractor /75", "ebay_kw": "Bowman Chrome Draft Yellow Lava Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "Red Lava Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Aqua Lava /199", "ebay_kw": "Bowman Chrome Draft Auto Aqua Lava"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Lava /5", "ebay_kw": "Bowman Chrome Draft Auto Red Lava"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto Black Wave /1", "ebay_kw": "Bowman Chrome Draft Auto Black Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2021;

-- 2022: Effectively same structure as 2021 Lava/Wave era
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "B&W RayWave Refractor", "ebay_kw": "Bowman Chrome Draft RayWave"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Aqua Lava Refractor /199", "ebay_kw": "Bowman Chrome Draft Aqua Lava Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Green Sparkle Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Sparkle Refractor"},
  {"label": "Yellow Lava Refractor /75", "ebay_kw": "Bowman Chrome Draft Yellow Lava Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "Red Lava Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Aqua Lava /199", "ebay_kw": "Bowman Chrome Draft Auto Aqua Lava"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Lava /5", "ebay_kw": "Bowman Chrome Draft Auto Red Lava"},
  {"label": "Draft Auto Red Wave /5", "ebay_kw": "Bowman Chrome Draft Auto Red Wave"},
  {"label": "Draft Auto Black Wave /1", "ebay_kw": "Bowman Chrome Draft Auto Black Wave"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2022;

-- 2023: Lunar-themed variants debut — Fuchsia Lunar /199, Aqua Lunar /125, Aqua Wave /125,
--       Green Grass /99, Yellow Lunar /75, Rose Gold /10 (most complex Draft Chrome ever)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Sparkle Refractor /200", "ebay_kw": "Bowman Chrome Draft Sparkle Refractor"},
  {"label": "Fuchsia Lunar Refractor /199", "ebay_kw": "Bowman Chrome Draft Fuchsia Lunar"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Aqua Lunar Crater /125", "ebay_kw": "Bowman Chrome Draft Aqua Lunar"},
  {"label": "Aqua Wave Refractor /125", "ebay_kw": "Bowman Chrome Draft Aqua Wave"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Green Grass Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Grass"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Draft Yellow Refractor"},
  {"label": "Yellow Lunar Crater /75", "ebay_kw": "Bowman Chrome Draft Yellow Lunar"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Rose Gold Refractor /10", "ebay_kw": "Bowman Chrome Draft Rose Gold"},
  {"label": "Rose Gold Lava Refractor /10", "ebay_kw": "Bowman Chrome Draft Rose Gold Lava"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "Red Lava Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Aqua Lava /199", "ebay_kw": "Bowman Chrome Draft Auto Aqua Lava"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Black /75", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Lava /5", "ebay_kw": "Bowman Chrome Draft Auto Red Lava"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2023;

-- 2024: Steel Metal /99 added; Black /10 tier added; same Lunar/Wave auto structure
--       Auto: adds Orange Wave /25, Black X-Fractor /10, Red X-Fractor /5, Green Lava /99
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Sky Blue Refractor", "ebay_kw": "Bowman Chrome Draft Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Fuchsia Lunar Refractor /199", "ebay_kw": "Bowman Chrome Draft Fuchsia Lunar"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Aqua Wave Refractor /125", "ebay_kw": "Bowman Chrome Draft Aqua Wave"},
  {"label": "Aqua Lunar Crater /125", "ebay_kw": "Bowman Chrome Draft Aqua Lunar"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Green Grass Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Grass"},
  {"label": "Steel Metal Refractor /99", "ebay_kw": "Bowman Chrome Draft Steel Metal"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Draft Yellow Refractor"},
  {"label": "Yellow Lunar Crater /75", "ebay_kw": "Bowman Chrome Draft Yellow Lunar"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Bowman Chrome Draft Black Refractor"},
  {"label": "Rose Gold Refractor /10", "ebay_kw": "Bowman Chrome Draft Rose Gold"},
  {"label": "Rose Gold Lava Refractor /10", "ebay_kw": "Bowman Chrome Draft Rose Gold Lava"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "Red Lava Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Aqua Lava /199", "ebay_kw": "Bowman Chrome Draft Auto Aqua Lava"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Blue Wave /150", "ebay_kw": "Bowman Chrome Draft Auto Blue Wave"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Green Lava /99", "ebay_kw": "Bowman Chrome Draft Auto Green Lava"},
  {"label": "Draft Auto Yellow /75", "ebay_kw": "Bowman Chrome Draft Auto Yellow"},
  {"label": "Draft Auto Sparkle /71", "ebay_kw": "Bowman Chrome Draft Auto Sparkle"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Gold Wave /50", "ebay_kw": "Bowman Chrome Draft Auto Gold Wave"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Orange Wave /25", "ebay_kw": "Bowman Chrome Draft Auto Orange Wave"},
  {"label": "Draft Auto Black /10", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Black X-Fractor /10", "ebay_kw": "Bowman Chrome Draft Auto Black X-Fractor"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red X-Fractor /5", "ebay_kw": "Bowman Chrome Draft Auto Red X-Fractor"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2024;

-- 2025: Pulsar /399 added; Black /10 on base; Geometric/Reptilian exotic variants on autos
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Draft Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Draft Refractor"},
  {"label": "Pulsar Refractor /399", "ebay_kw": "Bowman Chrome Draft Pulsar Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Draft Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Draft Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Draft Green Refractor"},
  {"label": "Steel Metal Refractor /99", "ebay_kw": "Bowman Chrome Draft Steel Metal"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Draft Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Draft Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Draft Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Bowman Chrome Draft Black Refractor"},
  {"label": "Rose Gold Refractor /10", "ebay_kw": "Bowman Chrome Draft Rose Gold"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Draft Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome Draft SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Draft Printing Plates"},
  {"label": "Draft Auto Refractor /499", "ebay_kw": "Bowman Chrome Draft Auto Refractor"},
  {"label": "Draft Auto Purple /250", "ebay_kw": "Bowman Chrome Draft Auto Purple"},
  {"label": "Draft Auto Blue /150", "ebay_kw": "Bowman Chrome Draft Auto Blue"},
  {"label": "Draft Auto Green /99", "ebay_kw": "Bowman Chrome Draft Auto Green"},
  {"label": "Draft Auto Yellow /75", "ebay_kw": "Bowman Chrome Draft Auto Yellow"},
  {"label": "Draft Auto Gold /50", "ebay_kw": "Bowman Chrome Draft Auto Gold"},
  {"label": "Draft Auto Orange /25", "ebay_kw": "Bowman Chrome Draft Auto Orange"},
  {"label": "Draft Auto Rose Gold /15", "ebay_kw": "Bowman Chrome Draft Auto Rose Gold"},
  {"label": "Draft Auto Black /10", "ebay_kw": "Bowman Chrome Draft Auto Black"},
  {"label": "Draft Auto Red /5", "ebay_kw": "Bowman Chrome Draft Auto Red"},
  {"label": "Draft Auto Red Lava /5", "ebay_kw": "Bowman Chrome Draft Auto Red Lava"},
  {"label": "Draft Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Draft Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball' AND year = 2025;
