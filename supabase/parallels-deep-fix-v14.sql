-- ============================================================
-- parallels-deep-fix-v14.sql
-- Bowman Chrome Baseball 1997–2025: Replace uniform 27-parallel
-- template with historically accurate per-year parallel structures.
-- No phantom year deletions needed (all 29 years are real products).
-- Sources: BaseballCardPedia.com per-year checklists
-- ============================================================
-- NOTE: brand = 'Bowman', set_name = 'Chrome', sport = 'baseball'

-- 1997: First Bowman Chrome — Refractor (unnumb) + International parallels
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "International", "ebay_kw": "Bowman Chrome International"},
  {"label": "International Refractor", "ebay_kw": "Bowman Chrome International Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1997;

-- 1998: International Refractor /100, Gold Refractor /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "International", "ebay_kw": "Bowman Chrome International"},
  {"label": "Gold Refractor /25", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "International Refractor /100", "ebay_kw": "Bowman Chrome International Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1998;

-- 1999: International, Gold, International Refractor /100, Gold Refractor /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "International", "ebay_kw": "Bowman Chrome International"},
  {"label": "Gold", "ebay_kw": "Bowman Chrome Gold"},
  {"label": "International Refractor /100", "ebay_kw": "Bowman Chrome International Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Bowman Chrome Gold Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1999;

-- 2000: Retro/Future era — Retro/Future, Refractor, Retro/Future Refractor (all unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Retro/Future", "ebay_kw": "Bowman Chrome Retro Future"},
  {"label": "Retro/Future Refractor", "ebay_kw": "Bowman Chrome Retro Future Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2000;

-- 2001: First numbered parallel — Gold Refractor /99; X-Fractor (unnumbered)
--       Auto RCs are Refractor only (/500, single version)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Gold Refractor /99", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2001;

-- 2002: Refractor /500, X-Fractor /250, Gold /50; + Uncirculated /350 box topper
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Uncirculated /350", "ebay_kw": "Bowman Chrome Uncirculated"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2002;

-- 2003: Refractor /500, X-Fractor /250, Gold /170 (box topper); Auto Gold /50
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Gold Refractor /170", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2003;

-- 2004: Refractor (unnumb), X-Fractor /172, Gold /50; Blue /290 (First Year prospects only)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /172", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /290", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2004;

-- 2005: Adds Blue /150 and Red /5; no Orange yet
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /225", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /225", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2005;

-- 2006: Orange /25 added; full rainbow (X-Fractor /250, Blue /150, Gold /50, Orange /25, Red /5, SF /1)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /225", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2006;

-- 2007: Same as 2006; X-Fractor /250 for base, /225 for prospect autos
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /225", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2007;

-- 2008: Same as 2007 (X-Fractor /250 both base and auto)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2008;

-- 2009: Same as 2008
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "Bowman Chrome X-Fractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto X-Fractor /250", "ebay_kw": "Bowman Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2009;

-- 2010: X-Fractor dropped; Red drops to /5; Refractor now numbered /500;
--       Prospect-exclusive Purple /899
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /899", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2010;

-- 2011: Canary Diamond /1 added; Purple /799 (retail prospects);
--       Bryce Harper and Mike Trout prospect auto year (the modern key set)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /799", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "Canary Diamond /1", "ebay_kw": "Bowman Chrome Canary Diamond"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2011;

-- 2012: Blue bumps to /250; Purple /199 added; Auto: Blue Wave /50, Purple /10 added
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Blue Refractor /250", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Purple Refractor /199", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue Wave /50", "ebay_kw": "Bowman Chrome Rookie Auto Blue Wave"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Purple /10", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2012;

-- 2013: Most tiers ever — Magenta /35, Black /15, Yellow /10 added
--       (Mike Trout, Yasiel Puig, and Kris Bryant's first Bowman Chrome year)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Blue Refractor /250", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Purple Refractor /199", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Magenta Refractor /35", "ebay_kw": "Bowman Chrome Magenta Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Black Refractor /15", "ebay_kw": "Bowman Chrome Black Refractor"},
  {"label": "Yellow Refractor /10", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Purple /10", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2013;

-- 2014: Most complex Bowman Chrome ever — Bubble /99, Shimmer /15, Carbon Fiber /10,
--       plus many HTA Shimmer/Wave auto parallels
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /500", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Blue Refractor /250", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Purple Refractor /150", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Bubble Refractor /99", "ebay_kw": "Bowman Chrome Bubble Refractor"},
  {"label": "Green Refractor /75", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Black Static /35", "ebay_kw": "Bowman Chrome Black Static"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Shimmer Refractor /15", "ebay_kw": "Bowman Chrome Shimmer Refractor"},
  {"label": "Carbon Fiber /10", "ebay_kw": "Bowman Chrome Carbon Fiber"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /75", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Purple /10", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2014;

-- 2015: Simplified clean rainbow — Purple /250, Blue /150, Green /99, Gold /50, Orange /25, Red /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2015;

-- 2016: Same rainbow; adds Shimmer auto variants (Orange /10, Red /10)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Bowman Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Orange Shimmer /10", "ebay_kw": "Bowman Chrome Rookie Auto Orange Shimmer"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2016;

-- 2017: Stable rainbow + Blue Mega /150 and Gold Shimmer /50 HTA variants for autos
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2017;

-- 2018: Same as 2017 (Gold dropped from base, Shimmer prospects)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2018;

-- 2019: Same core rainbow; adds Wave/Atomic HTA auto variants
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Orange Wave /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange Wave"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2019;

-- 2020: Same as 2019 (Shimmer Prospects introduced)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2020;

-- 2021: MAJOR EXPANSION — Fuchsia /299 and Yellow /75 added to base;
--       Auto adds Speckle /299, Atomic /100, Yellow /75
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Fuchsia Refractor /299", "ebay_kw": "Bowman Chrome Fuchsia Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Bowman Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Speckle /299", "ebay_kw": "Bowman Chrome Rookie Auto Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Atomic /100", "ebay_kw": "Bowman Chrome Rookie Auto Atomic"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Yellow /75", "ebay_kw": "Bowman Chrome Rookie Auto Yellow"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2021;

-- 2022: Adds B&W Mini-Diamond /199 and Aqua RayWave /199 to base;
--       Auto adds Blue RayWave /150 alongside Blue Refractor
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Fuchsia Refractor /299", "ebay_kw": "Bowman Chrome Fuchsia Refractor"},
  {"label": "B&W Mini-Diamond /199", "ebay_kw": "Bowman Chrome Mini Diamond"},
  {"label": "Aqua RayWave /199", "ebay_kw": "Bowman Chrome Aqua RayWave"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Speckle /299", "ebay_kw": "Bowman Chrome Rookie Auto Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue RayWave /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue RayWave"},
  {"label": "RC Auto Atomic /100", "ebay_kw": "Bowman Chrome Rookie Auto Atomic"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Yellow /75", "ebay_kw": "Bowman Chrome Rookie Auto Yellow"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2022;

-- 2023: Wave /100 added to base; Auto adds Green Lava /99 (HTA)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Fuchsia Refractor /299", "ebay_kw": "Bowman Chrome Fuchsia Refractor"},
  {"label": "Aqua RayWave /199", "ebay_kw": "Bowman Chrome Aqua RayWave"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Wave Refractor /100", "ebay_kw": "Bowman Chrome Wave Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Speckle /299", "ebay_kw": "Bowman Chrome Rookie Auto Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue RayWave /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue RayWave"},
  {"label": "RC Auto Atomic /100", "ebay_kw": "Bowman Chrome Rookie Auto Atomic"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Yellow /75", "ebay_kw": "Bowman Chrome Rookie Auto Yellow"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2023;

-- 2024: Auto adds Black /10 tier; Pearl /12 base insert
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Fuchsia Refractor /299", "ebay_kw": "Bowman Chrome Fuchsia Refractor"},
  {"label": "Aqua RayWave /199", "ebay_kw": "Bowman Chrome Aqua RayWave"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Wave Refractor /100", "ebay_kw": "Bowman Chrome Wave Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Pearl Refractor /12", "ebay_kw": "Bowman Chrome Pearl Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Speckle /299", "ebay_kw": "Bowman Chrome Rookie Auto Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Mini-Diamond /100", "ebay_kw": "Bowman Chrome Rookie Auto Mini Diamond"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Yellow /75", "ebay_kw": "Bowman Chrome Rookie Auto Yellow"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Black /10", "ebay_kw": "Bowman Chrome Rookie Auto Black"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2024;

-- 2025: Pulsar /399 added; Black /10 fully integrated; Fuchsia Wave added
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Bowman Chrome Baseball"},
  {"label": "Refractor /499", "ebay_kw": "Bowman Chrome Refractor"},
  {"label": "Pulsar Refractor /399", "ebay_kw": "Bowman Chrome Pulsar Refractor"},
  {"label": "Fuchsia Refractor /299", "ebay_kw": "Bowman Chrome Fuchsia Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Bowman Chrome Blue Refractor"},
  {"label": "Wave Refractor /100", "ebay_kw": "Bowman Chrome Wave Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Bowman Chrome Green Refractor"},
  {"label": "Yellow Refractor /75", "ebay_kw": "Bowman Chrome Yellow Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Bowman Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Bowman Chrome Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Bowman Chrome Black Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Bowman Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Bowman Chrome SuperFractor"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Bowman Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Speckle /299", "ebay_kw": "Bowman Chrome Rookie Auto Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Bowman Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Bowman Chrome Rookie Auto Blue"},
  {"label": "RC Auto Mini-Diamond /100", "ebay_kw": "Bowman Chrome Rookie Auto Mini Diamond"},
  {"label": "RC Auto Green /99", "ebay_kw": "Bowman Chrome Rookie Auto Green"},
  {"label": "RC Auto Yellow /75", "ebay_kw": "Bowman Chrome Rookie Auto Yellow"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Bowman Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Bowman Chrome Rookie Auto Orange"},
  {"label": "RC Auto Black /10", "ebay_kw": "Bowman Chrome Rookie Auto Black"},
  {"label": "RC Auto Red /5", "ebay_kw": "Bowman Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Bowman Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2025;
