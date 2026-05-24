-- ============================================================
-- parallels-deep-fix-v11.sql
-- Topps Finest Basketball 1996-2007: Replace modern template with
-- historically accurate refractor parallel structures per year.
-- Also deletes phantom 2001-02 season (no product released).
-- ============================================================
-- NOTE: set_name = 'Finest Basketball' (not 'Finest') in card_sets

-- STEP 1: DELETE phantom year (no 2001-02 Finest Basketball released)
DELETE FROM card_sets
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2001;

-- STEP 2: FIX PARALLELS BY YEAR
-- Source: CardboardConnection, Sports Card Pro, eBay sold comps

-- 1996-97: Bronze/Silver/Gold Refractor tiers (all unnumbered)
-- No numbered parallels existed yet; tiered by insertion rate (1:12 / 1:48 / 1:288)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Bronze Refractor", "ebay_kw": "Topps Finest Bronze Refractor"},
  {"label": "Silver Refractor", "ebay_kw": "Topps Finest Silver Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 1996;

-- 1997-98: Silver Refractor /1090, Gold Refractor /289 (first numbered Finest Basketball)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Bronze Refractor", "ebay_kw": "Topps Finest Bronze Refractor"},
  {"label": "Silver Refractor /1090", "ebay_kw": "Topps Finest Silver Refractor"},
  {"label": "Gold Refractor /289", "ebay_kw": "Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 1997;

-- 1998-99: Transition era; Refractor (unnumbered), Gold Refractor (unnumbered or /50)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 1998;

-- 1999-00: Same era structure
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 1999;

-- 2000-01: Gold Refractor confirmed /100
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor /100", "ebay_kw": "Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2000;

-- 2001-02: DELETED ABOVE (no product released)

-- 2002-03: Refractor /250, Gold Refractor /25, X-Fractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor /250", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "X-Fractor /1", "ebay_kw": "Topps Finest X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2002;

-- 2003-04: Refractor /250, Gold Refractor /25, X-Fractor /1 + Rookie Auto section
-- (LeBron, Carmelo, D-Wade, Bosh rookies)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor /250", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "X-Fractor /1", "ebay_kw": "Topps Finest X-Fractor"},
  {"label": "Printing Plates /1", "ebay_kw": "Topps Finest Printing Plates"},
  {"label": "Rookie Auto", "ebay_kw": "Topps Finest Rookie Auto"},
  {"label": "Rookie Auto Refractor /250", "ebay_kw": "Topps Finest Rookie Auto Refractor"},
  {"label": "Rookie Auto Gold /25", "ebay_kw": "Topps Finest Rookie Auto Gold"},
  {"label": "Rookie Auto X-Fractor /1", "ebay_kw": "Topps Finest Rookie Auto X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2003;

-- 2004-05: Tiered Gold (12-25 by tier), X-Fractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "X-Fractor /1", "ebay_kw": "Topps Finest X-Fractor"},
  {"label": "Rookie Auto", "ebay_kw": "Topps Finest Rookie Auto"},
  {"label": "Rookie Auto Refractor", "ebay_kw": "Topps Finest Rookie Auto Refractor"},
  {"label": "Rookie Auto Gold /25", "ebay_kw": "Topps Finest Rookie Auto Gold"},
  {"label": "Rookie Auto X-Fractor /1", "ebay_kw": "Topps Finest Rookie Auto X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2004;

-- 2005-06: Refractor /249, Red /169, Green /89, Gold /39, Black /19, White /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor /249", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Red Refractor /169", "ebay_kw": "Topps Finest Red Refractor"},
  {"label": "Green Refractor /89", "ebay_kw": "Topps Finest Green Refractor"},
  {"label": "Gold Refractor /39", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "Black Refractor /19", "ebay_kw": "Topps Finest Black Refractor"},
  {"label": "White Frame Refractor /1", "ebay_kw": "Topps Finest White Refractor"},
  {"label": "Rookie Auto Refractor /249", "ebay_kw": "Topps Finest Rookie Auto Refractor"},
  {"label": "Rookie Auto Gold /59", "ebay_kw": "Topps Finest Rookie Auto Gold"},
  {"label": "Rookie Auto White /1", "ebay_kw": "Topps Finest Rookie Auto White"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2005;

-- 2006-07: Blue /299, Green /199, Black /99, Gold /50, X-Fractor /25, SuperFractor /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Blue Refractor /299", "ebay_kw": "Topps Finest Blue Refractor"},
  {"label": "Green Refractor /199", "ebay_kw": "Topps Finest Green Refractor"},
  {"label": "Black Refractor /99", "ebay_kw": "Topps Finest Black Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "X-Fractor /25", "ebay_kw": "Topps Finest X-Fractor"},
  {"label": "White Frame X-Fractor /1", "ebay_kw": "Topps Finest White X-Fractor"},
  {"label": "SuperFractor /1", "ebay_kw": "Topps Finest SuperFractor"},
  {"label": "Rookie Auto Refractor", "ebay_kw": "Topps Finest Rookie Auto Refractor"},
  {"label": "Rookie Auto Gold /50", "ebay_kw": "Topps Finest Rookie Auto Gold"},
  {"label": "Rookie Auto SuperFractor /1", "ebay_kw": "Topps Finest Rookie Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2006;

-- 2007-08: Refractor (unnumb), Blue /199, Green /149, Black /75, Gold /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "Topps Finest Basketball"},
  {"label": "Refractor", "ebay_kw": "Topps Finest Refractor"},
  {"label": "Blue Refractor /199", "ebay_kw": "Topps Finest Blue Refractor"},
  {"label": "Green Refractor /149", "ebay_kw": "Topps Finest Green Refractor"},
  {"label": "Black Refractor /75", "ebay_kw": "Topps Finest Black Refractor"},
  {"label": "Gold Refractor /25", "ebay_kw": "Topps Finest Gold Refractor"},
  {"label": "Rookie Auto Refractor", "ebay_kw": "Topps Finest Rookie Auto Refractor"},
  {"label": "Rookie Auto Gold /25", "ebay_kw": "Topps Finest Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND year = 2007;
