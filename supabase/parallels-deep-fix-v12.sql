-- ============================================================
-- parallels-deep-fix-v12.sql
-- Topps Chrome Baseball 1996–2025: Replace uniform 2023-era
-- template with historically accurate per-year parallel structures.
-- No phantom year deletions needed (all 30 years are real products).
-- Sources: BaseballCardPedia.com per-year checklists
-- ============================================================
-- NOTE: brand = 'Topps', set_name = 'Chrome', sport = 'baseball'

-- 1996: Refractor only (unnumbered). No numbered parallels yet.
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1996;

-- 1997: Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1997;

-- 1998: Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1998;

-- 1999: Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 1999;

-- 2000: Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2000;

-- 2001: Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2001;

-- 2002: First numbered parallels — Gold Refractor (unnumb) + Black Refractor /50
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Black Refractor /50", "ebay_kw": "Topps Chrome Black Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2002;

-- 2003: Fully numbered Refractors debut; Refractor /699, Gold /449, Black /199
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor /699", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Gold Refractor /449", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Black Refractor /199", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Uncirculated X-Fractor", "ebay_kw": "Topps Chrome X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2003;

-- 2004: Refractor, Gold, Black (all unnumbered), Red X-Fractor (player-numbered ~63)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Black Refractor", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Red X-Fractor", "ebay_kw": "Topps Chrome Red X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2004;

-- 2005: Black /225, Red X-Fractor /25, Gold SuperFractor /1 (first SuperFractor in Chrome Baseball)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Black Refractor /225", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Red X-Fractor /25", "ebay_kw": "Topps Chrome Red X-Fractor"},
  {"label": "Gold SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2005;

-- 2006: Blue (unnumb), Black /549, Red /90, Gold SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome X-Fractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Black Refractor /549", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Red Refractor /90", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Gold SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2006;

-- 2007: White /660, Red /99, SuperFractor /1; RC Autos added with own parallel tiers
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome X-Fractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "White Refractor /660", "ebay_kw": "Topps Chrome White Refractor"},
  {"label": "Red Refractor /99", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto White /200", "ebay_kw": "Topps Chrome Rookie Auto White"},
  {"label": "RC Auto Red /99", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2007;

-- 2008: Copper /599, Red /25, SuperFractor /1; RC Auto adds Blue /200, Copper /100
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Copper Refractor /599", "ebay_kw": "Topps Chrome Copper Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "RC Auto Refractor /500", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /200", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Copper /100", "ebay_kw": "Topps Chrome Rookie Auto Copper"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2008;

-- 2009: Blue /199, Gold /50, Red /25, SuperFractor /1; RC Auto Refractor /499
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome X-Fractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2009;

-- 2010: Purple /599 (retail), Blue /199, Gold /50, Red /25, SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome X-Fractor"},
  {"label": "Purple Refractor /599", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2010;

-- 2011: Expanded color lineup — Purple /499, Black /100, Blue /99, Sepia /99, Gold /50, Red /25,
--       Atomic /225, Canary Diamond /1, SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /499", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Atomic Refractor /225", "ebay_kw": "Topps Chrome Atomic Refractor"},
  {"label": "Black Refractor /100", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Blue Refractor /99", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Canary Diamond /1", "ebay_kw": "Topps Chrome Canary Diamond"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Black /100", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Sepia /99", "ebay_kw": "Topps Chrome Rookie Auto Sepia"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto Atomic /10", "ebay_kw": "Topps Chrome Rookie Auto Atomic"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2011;

-- 2012: Blue /199, Black /100, Sepia /75, Gold /50, Red /25, Atomic /10, SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Black Refractor /100", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Sepia Refractor /75", "ebay_kw": "Topps Chrome Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Atomic Refractor /10", "ebay_kw": "Topps Chrome Atomic Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Black /100", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Sepia /75", "ebay_kw": "Topps Chrome Rookie Auto Sepia"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto Atomic /10", "ebay_kw": "Topps Chrome Rookie Auto Atomic"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2012;

-- 2013: Adds Camo /15, Pink /5 (most tiers in Chrome history to this point)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Black Refractor /100", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Sepia Refractor /75", "ebay_kw": "Topps Chrome Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Camouflage Refractor /15", "ebay_kw": "Topps Chrome Camo Refractor"},
  {"label": "Atomic Refractor /10", "ebay_kw": "Topps Chrome Atomic Refractor"},
  {"label": "Pink Refractor /5", "ebay_kw": "Topps Chrome Pink Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Black /100", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Sepia /75", "ebay_kw": "Topps Chrome Rookie Auto Sepia"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto Camo /15", "ebay_kw": "Topps Chrome Rookie Auto Camo"},
  {"label": "RC Auto Atomic /10", "ebay_kw": "Topps Chrome Rookie Auto Atomic"},
  {"label": "RC Auto Pink /5", "ebay_kw": "Topps Chrome Rookie Auto Pink"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2013;

-- 2014: Same as 2012 (Camo/Pink dropped; back to Blue/Black/Sepia/Gold/Red/Atomic)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Black Refractor /100", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Sepia Refractor /75", "ebay_kw": "Topps Chrome Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Atomic Refractor /10", "ebay_kw": "Topps Chrome Atomic Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Blue /199", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Black /100", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Sepia /75", "ebay_kw": "Topps Chrome Rookie Auto Sepia"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Red /25", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto Atomic /10", "ebay_kw": "Topps Chrome Rookie Auto Atomic"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2014;

-- 2015: MAJOR REDESIGN — Color shift from Black/Sepia/Atomic to Green/Orange; Red drops to /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2015;

-- 2016: Purple /275, Blue /150, Green /99, Blue Wave /75, Gold /50, Orange /25, Red /5, SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /275", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2016;

-- 2017: Purple /299, Blue /150, Green /99, Blue Wave /75, Gold /50, Orange /25, Red /5, SuperFractor /1
--       RC Auto adds X-Fractor /20 and Blue Wave /75
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /299", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Blue Wave /75", "ebay_kw": "Topps Chrome Rookie Auto Blue Wave"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto X-Fractor /20", "ebay_kw": "Topps Chrome Rookie Auto X-Fractor"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2017;

-- 2018: Adds Gold Wave /50 and Red Wave /5 variants; structure otherwise same as 2017
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /299", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Red Wave Refractor /5", "ebay_kw": "Topps Chrome Red Wave Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2018;

-- 2019: Green Wave /99 (hobby) and Green /99 (retail); Blue Wave /75, Gold Wave /50, Orange Wave /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /299", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Green Wave Refractor /99", "ebay_kw": "Topps Chrome Green Wave Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue Wave /150", "ebay_kw": "Topps Chrome Rookie Auto Blue Wave"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2019;

-- 2020: Full Wave variants across Gold, Orange, Red tiers
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Purple Refractor /299", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Green Wave Refractor /99", "ebay_kw": "Topps Chrome Green Wave Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Orange Wave Refractor /25", "ebay_kw": "Topps Chrome Orange Wave Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Red Wave Refractor /5", "ebay_kw": "Topps Chrome Red Wave Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue Wave /150", "ebay_kw": "Topps Chrome Rookie Auto Blue Wave"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2020;

-- 2021: Adds Magenta /399, Magenta Speckle /350, Aqua /199 (major expansion of high-number tiers)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Magenta Refractor /399", "ebay_kw": "Topps Chrome Magenta Refractor"},
  {"label": "Magenta Speckle /350", "ebay_kw": "Topps Chrome Magenta Speckle"},
  {"label": "Purple Refractor /299", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Aqua Refractor"},
  {"label": "Aqua Wave Refractor /199", "ebay_kw": "Topps Chrome Aqua Wave Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Orange Wave Refractor /25", "ebay_kw": "Topps Chrome Orange Wave Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Red Wave Refractor /5", "ebay_kw": "Topps Chrome Red Wave Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Aqua /199", "ebay_kw": "Topps Chrome Rookie Auto Aqua"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue Wave /150", "ebay_kw": "Topps Chrome Rookie Auto Blue Wave"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2021;

-- 2022: Adds Purple Speckle /299; Purple drops to /250 (tier splits)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Magenta Refractor /399", "ebay_kw": "Topps Chrome Magenta Refractor"},
  {"label": "Magenta Speckle /350", "ebay_kw": "Topps Chrome Magenta Speckle"},
  {"label": "Purple Speckle /299", "ebay_kw": "Topps Chrome Purple Speckle"},
  {"label": "Purple Refractor /250", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Aqua Refractor"},
  {"label": "Aqua Wave Refractor /199", "ebay_kw": "Topps Chrome Aqua Wave Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Orange Wave Refractor /25", "ebay_kw": "Topps Chrome Orange Wave Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "Red Wave Refractor /5", "ebay_kw": "Topps Chrome Red Wave Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple Speckle /299", "ebay_kw": "Topps Chrome Rookie Auto Purple Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Aqua Wave /199", "ebay_kw": "Topps Chrome Rookie Auto Aqua Wave"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue RayWave /150", "ebay_kw": "Topps Chrome Rookie Auto RayWave"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2022;

-- 2023: Adds Blue Sonar /125, Aqua Lava /199, Purple Sonar /275, Green Sonar /99, FrozenFractor /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Magenta Refractor /399", "ebay_kw": "Topps Chrome Magenta Refractor"},
  {"label": "Magenta Speckle /350", "ebay_kw": "Topps Chrome Magenta Speckle"},
  {"label": "Purple Speckle /299", "ebay_kw": "Topps Chrome Purple Speckle"},
  {"label": "Purple Sonar /275", "ebay_kw": "Topps Chrome Purple Sonar"},
  {"label": "Purple Refractor /250", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Aqua Refractor"},
  {"label": "Aqua Lava /199", "ebay_kw": "Topps Chrome Aqua Lava"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Blue Sonar /125", "ebay_kw": "Topps Chrome Blue Sonar"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Green Wave Refractor /99", "ebay_kw": "Topps Chrome Green Wave Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Orange Wave Refractor /25", "ebay_kw": "Topps Chrome Orange Wave Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "FrozenFractor /5", "ebay_kw": "Topps Chrome FrozenFractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple Speckle /299", "ebay_kw": "Topps Chrome Rookie Auto Purple Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Aqua Wave /199", "ebay_kw": "Topps Chrome Rookie Auto Aqua Wave"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Blue RayWave /150", "ebay_kw": "Topps Chrome Rookie Auto RayWave"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2023;

-- 2024: Adds Black /10 between Orange and Red; Magenta Speckle now at /399
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Magenta Speckle /399", "ebay_kw": "Topps Chrome Magenta Speckle"},
  {"label": "Purple Speckle /299", "ebay_kw": "Topps Chrome Purple Speckle"},
  {"label": "Purple Sonar /275", "ebay_kw": "Topps Chrome Purple Sonar"},
  {"label": "Purple Refractor /250", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Aqua Refractor"},
  {"label": "Aqua Lava /199", "ebay_kw": "Topps Chrome Aqua Lava"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Blue Sonar /125", "ebay_kw": "Topps Chrome Blue Sonar"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Gold Wave Refractor /50", "ebay_kw": "Topps Chrome Gold Wave Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "FrozenFractor /5", "ebay_kw": "Topps Chrome FrozenFractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple Speckle /299", "ebay_kw": "Topps Chrome Rookie Auto Purple Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Aqua Wave /199", "ebay_kw": "Topps Chrome Rookie Auto Aqua Wave"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Black /10", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2024;

-- 2025: Teal /299 replaces Purple Speckle as entry-level numbered; Black /10 retained
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Baseball"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Refractor"},
  {"label": "Teal Refractor /299", "ebay_kw": "Topps Chrome Teal Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "Topps Chrome Purple Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Aqua Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Topps Chrome Black Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Printing Plates"},
  {"label": "RC Auto Refractor /499", "ebay_kw": "Topps Chrome Rookie Auto Refractor"},
  {"label": "RC Auto Purple Speckle /299", "ebay_kw": "Topps Chrome Rookie Auto Purple Speckle"},
  {"label": "RC Auto Purple /250", "ebay_kw": "Topps Chrome Rookie Auto Purple"},
  {"label": "RC Auto Aqua Wave /199", "ebay_kw": "Topps Chrome Rookie Auto Aqua Wave"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Rookie Auto Blue"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Rookie Auto Orange"},
  {"label": "RC Auto Black /10", "ebay_kw": "Topps Chrome Rookie Auto Black"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball' AND year = 2025;
