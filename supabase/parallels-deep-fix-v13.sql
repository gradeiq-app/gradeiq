-- ============================================================
-- parallels-deep-fix-v13.sql
-- Topps Chrome Football 1996–2025: Replace uniform 2023-era
-- template with historically accurate per-year parallel structures.
-- No phantom year deletions needed (all 22 years in DB are real).
-- NOTE: 2016-2022 are correctly absent (Panini NFL exclusive period).
-- NOTE: 2023 was "Topps Composite Football" (Chrome-branded cards within).
-- Sources: CardboardConnection, SportscardRadio, TCDB per-year checklists
-- ============================================================
-- NOTE: brand = 'Topps', set_name = 'Chrome', sport = 'football'

-- 1996: First year of Topps Chrome Football — Refractor only (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 1996;

-- 1997: Refractor only
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 1997;

-- 1998: Refractor only
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 1998;

-- 1999: Refractor only
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 1999;

-- 2000: Refractor only
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2000;

-- 2001: Refractor only
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2001;

-- 2002: First numbered parallels — Gold Refractor + Black Refractor /50
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Black Refractor /50", "ebay_kw": "Topps Chrome Football Black Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2002;

-- 2003: Fully numbered Refractors; Refractor /599, Gold /449, Black /199
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor /599", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Gold Refractor /449", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Black Refractor /199", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome Football X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2003;

-- 2004: Three-tier structure — Refractor, Black Refractor, Gold X-Fractor
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Black Refractor", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Gold X-Fractor", "ebay_kw": "Topps Chrome Football Gold X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2004;

-- 2005: Black /225, Red X-Fractor /25, Gold SuperFractor /1, Printing Plates
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Black Refractor /225", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Red X-Fractor /25", "ebay_kw": "Topps Chrome Football Red X-Fractor"},
  {"label": "Gold SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2005;

-- 2006: Blue (unnumb), Black /549, Red /90, Gold SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome Football X-Fractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Black Refractor /549", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Red Refractor /90", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "Gold SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2006;

-- 2007: White /869 (football-specific, different from baseball /660),
--       Red and Blue unnumbered; RC Auto Refractor /50, Gold SuperFractor /10, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Red Refractor", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "White Refractor /869", "ebay_kw": "Topps Chrome Football White Refractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /50", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Gold SuperFractor /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2007;

-- 2008: Copper /699, Red /25, SuperFractor /1; RC Auto: White /50
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome Football X-Fractor"},
  {"label": "Blue Refractor", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Copper Refractor /699", "ebay_kw": "Topps Chrome Football Copper Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "RC Auto White /50", "ebay_kw": "Topps Chrome Football Rookie Auto White"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2008;

-- 2009: Copper /699, Red /25, SuperFractor /1, X-Fractor;
--       RC Auto: Gold /10, Black /50, SuperFractor /1 (football-specific auto tiers)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome Football X-Fractor"},
  {"label": "Copper Refractor /699", "ebay_kw": "Topps Chrome Football Copper Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Black /50", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2009;

-- 2010: Blue /199, Gold /50, Red /25, SuperFractor /1;
--       RC Auto: Refractor /50 (much lower than baseball!), Black /25, Gold /10, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /50", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2010;

-- 2011: Purple /499, Black /299, Blue /199, Crystal Atomic (1/box), Sepia /99, Gold /50, Red /25, SF /1
--       RC Auto: Refractor /99, Crystal Atomic /50, Black /25, Gold /10, Red /5, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "X-Fractor", "ebay_kw": "Topps Chrome Football X-Fractor"},
  {"label": "Orange Refractor", "ebay_kw": "Topps Chrome Football Orange Refractor"},
  {"label": "Purple Refractor /499", "ebay_kw": "Topps Chrome Football Purple Refractor"},
  {"label": "Black Refractor /299", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Crystal Atomic", "ebay_kw": "Topps Chrome Football Crystal Atomic"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Football Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /99", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Crystal Atomic /50", "ebay_kw": "Topps Chrome Football Rookie Auto Atomic"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2011;

-- 2012: Military Camo /499, BCA Pink /399, Prism (hobby), Black /299, Blue /199, Sepia /99,
--       Gold /50, Red /25, SF /1 (football-specific: Military & BCA parallels, Black at /299)
--       RC Auto: Refractor /150, Military /99, BCA /75, Prism /50, Black /25, Gold /10, Red /5, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Military Camo Refractor /499", "ebay_kw": "Topps Chrome Football Camo Refractor"},
  {"label": "BCA Pink Refractor /399", "ebay_kw": "Topps Chrome Football Pink Refractor"},
  {"label": "Prism Refractor", "ebay_kw": "Topps Chrome Football Prism Refractor"},
  {"label": "Black Refractor /299", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Football Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /150", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Military /99", "ebay_kw": "Topps Chrome Football Rookie Auto Camo"},
  {"label": "RC Auto BCA Pink /75", "ebay_kw": "Topps Chrome Football Rookie Auto Pink"},
  {"label": "RC Auto Prism /50", "ebay_kw": "Topps Chrome Football Rookie Auto Prism"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2012;

-- 2013: Military Camo /499, BCA Pink /399, Prism /260, Black /299, Blue /199, Sepia /99,
--       Gold /50, Red /25, SF /1
--       RC Auto: Refractor /150, Military /99, BCA /75, Blue Wave /50, Black /25, Prism /15, Gold /10, Red /5, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Military Camo Refractor /499", "ebay_kw": "Topps Chrome Football Camo Refractor"},
  {"label": "BCA Pink Refractor /399", "ebay_kw": "Topps Chrome Football Pink Refractor"},
  {"label": "Prism Refractor /260", "ebay_kw": "Topps Chrome Football Prism Refractor"},
  {"label": "Black Refractor /299", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Football Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /150", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Military /99", "ebay_kw": "Topps Chrome Football Rookie Auto Camo"},
  {"label": "RC Auto BCA Pink /75", "ebay_kw": "Topps Chrome Football Rookie Auto Pink"},
  {"label": "RC Auto Blue Wave /50", "ebay_kw": "Topps Chrome Football Rookie Auto Blue Wave"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Prism /15", "ebay_kw": "Topps Chrome Football Rookie Auto Prism"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2013;

-- 2014: STS Camo replaces Military Camo; same numbered tier structure
--       RC Auto: Refractor /150, STS /99, BCA /75, Black /25, Pulsar /15, Gold /10, Red /5, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "STS Camo Refractor /499", "ebay_kw": "Topps Chrome Football STS Camo Refractor"},
  {"label": "BCA Pink Refractor /399", "ebay_kw": "Topps Chrome Football Pink Refractor"},
  {"label": "Black Refractor /299", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Football Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor /150", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto STS Camo /99", "ebay_kw": "Topps Chrome Football Rookie Auto STS"},
  {"label": "RC Auto BCA Pink /75", "ebay_kw": "Topps Chrome Football Rookie Auto Pink"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Pulsar /15", "ebay_kw": "Topps Chrome Football Rookie Auto Pulsar"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2014;

-- 2015: Final year before Panini NFL exclusive (2016-2022)
--       STS Camo /499, BCA Pink /399, Black /299, Blue /199, Sepia /99, Gold /50, Red /25, SF /1
--       RC Auto: Gold Sepia /100, Blue /50, Black /25, Pulsar /15, Gold /10, Red /5, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "STS Camo Refractor /499", "ebay_kw": "Topps Chrome Football STS Camo Refractor"},
  {"label": "BCA Pink Refractor /399", "ebay_kw": "Topps Chrome Football Pink Refractor"},
  {"label": "Black Refractor /299", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Sepia Refractor /99", "ebay_kw": "Topps Chrome Football Sepia Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Gold Sepia /100", "ebay_kw": "Topps Chrome Football Rookie Auto Gold Sepia"},
  {"label": "RC Auto Blue /50", "ebay_kw": "Topps Chrome Football Rookie Auto Blue"},
  {"label": "RC Auto Black /25", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Pulsar /15", "ebay_kw": "Topps Chrome Football Rookie Auto Pulsar"},
  {"label": "RC Auto Gold /10", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2015;

-- 2023: "Topps Composite Football" — Chrome-branded cards returned after 8-year absence
--       Magenta /399, Purple /275, Purple Speckle /250, Aqua /199, Blue /150, Green /99,
--       Blue Wave /75, Gold /50, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Composite Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Composite Chrome Refractor"},
  {"label": "Magenta Refractor /399", "ebay_kw": "Topps Composite Chrome Magenta"},
  {"label": "Purple Refractor /275", "ebay_kw": "Topps Composite Chrome Purple"},
  {"label": "Purple Speckle /250", "ebay_kw": "Topps Composite Chrome Purple Speckle"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Composite Chrome Aqua"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Composite Chrome Blue"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Composite Chrome Green"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Composite Chrome Blue Wave"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Composite Chrome Gold"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Composite Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2023;

-- 2024: Standalone Topps Chrome Football (unlicensed/NFLPA) — simplified structure
--       Green /99, Blue Wave /75, Gold /50, Orange /25, Red /10, SF /1
--       RC Auto: Gold /50, Orange /25, Red /10, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Prism Refractor", "ebay_kw": "Topps Chrome Football Prism Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Football Green Refractor"},
  {"label": "Blue Wave Refractor /75", "ebay_kw": "Topps Chrome Football Blue Wave Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Football Orange Refractor"},
  {"label": "Red Refractor /10", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Football Rookie Auto Orange"},
  {"label": "RC Auto Red /10", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2024;

-- 2025: First fully licensed Topps Chrome Football since 2015 (Fanatics/Topps return)
--       Neon Pulse /400, Teal /299, Pink /250, Aqua /199, Blue /150, Green /99,
--       Purple /75, Gold /50, White /30, Orange /25, Black /10, Red /5, SF /1
--       RC Auto: same numbered structure
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Chrome Football"},
  {"label": "Refractor", "ebay_kw": "Topps Chrome Football Refractor"},
  {"label": "Neon Pulse /400", "ebay_kw": "Topps Chrome Football Neon Pulse"},
  {"label": "Teal Refractor /299", "ebay_kw": "Topps Chrome Football Teal Refractor"},
  {"label": "Pink Refractor /250", "ebay_kw": "Topps Chrome Football Pink Refractor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "Topps Chrome Football Aqua Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "Topps Chrome Football Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "Topps Chrome Football Green Refractor"},
  {"label": "Purple Refractor /75", "ebay_kw": "Topps Chrome Football Purple Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Chrome Football Gold Refractor"},
  {"label": "White Refractor /30", "ebay_kw": "Topps Chrome Football White Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "Topps Chrome Football Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "Topps Chrome Football Black Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "Topps Chrome Football Red Refractor"},
  {"label": "FrozenFractor /5", "ebay_kw": "Topps Chrome Football FrozenFractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Chrome Football SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Chrome Football Printing Plates"},
  {"label": "RC Auto Refractor", "ebay_kw": "Topps Chrome Football Rookie Auto Refractor"},
  {"label": "RC Auto Teal /299", "ebay_kw": "Topps Chrome Football Rookie Auto Teal"},
  {"label": "RC Auto Pink /250", "ebay_kw": "Topps Chrome Football Rookie Auto Pink"},
  {"label": "RC Auto Aqua Wave /199", "ebay_kw": "Topps Chrome Football Rookie Auto Aqua Wave"},
  {"label": "RC Auto Blue /150", "ebay_kw": "Topps Chrome Football Rookie Auto Blue"},
  {"label": "RC Auto Green /99", "ebay_kw": "Topps Chrome Football Rookie Auto Green"},
  {"label": "RC Auto Gold /50", "ebay_kw": "Topps Chrome Football Rookie Auto Gold"},
  {"label": "RC Auto Orange /25", "ebay_kw": "Topps Chrome Football Rookie Auto Orange"},
  {"label": "RC Auto Black /10", "ebay_kw": "Topps Chrome Football Rookie Auto Black"},
  {"label": "RC Auto Red /5", "ebay_kw": "Topps Chrome Football Rookie Auto Red"},
  {"label": "RC Auto SuperFractor /1", "ebay_kw": "Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football' AND year = 2025;
