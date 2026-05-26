-- =============================================================================
-- parallels-deep-fix-v22.sql
-- Topps Heritage Baseball — year-accurate parallels
-- brand='Topps', set_name='Heritage', sport='baseball'
-- Covers DB years 2001–2026 (26 rows, 0 deleted)
--
-- Heritage mirrors original Topps design from exactly 52 years prior each year.
-- The Chrome tier numbering follows this mirror relationship:
--   Chrome Refractor  : /5[XX]  where XX = last two digits of mirrored year
--   Chrome Black/Blue : /[XX]   (two-digit mirrored year)
--   Chrome base       : /19[XX] (2004-2012) or /999 (2013-2019, 2021-2024)
--
-- Confirmed sources: BaseballCardPedia.com, CardboardConnection.com,
--   checklistinsider.com, Beckett (for structure), eBay sold listings.
--
-- ACTIONS: UPDATE 26 rows (no deletes — Heritage started in 2001 and every
--   year in the DB corresponds to a real product release).
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 2001 — mirrors 1952
-- Single Chrome Refractor tier (no separate base Chrome in year 1)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome Refractor /552","ebay_kw":"Chrome Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2001;

-- ---------------------------------------------------------------------------
-- 2002 — mirrors 1953
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome Refractor /553","ebay_kw":"Chrome Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2002;

-- ---------------------------------------------------------------------------
-- 2003 — mirrors 1954
-- eBay listing confirmed "Chrome Refractor No 127 of 554"
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome Refractor /554","ebay_kw":"Chrome Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2003;

-- ---------------------------------------------------------------------------
-- 2004 — mirrors 1955
-- Three-tier Chrome structure inferred (2005 confirmed three tiers)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1955","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /555","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /55","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2004;

-- ---------------------------------------------------------------------------
-- 2005 — mirrors 1956
-- CONFIRMED: Chrome /1956, Refractor /556, Black /56 (BaseballCardPedia)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1956","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /556","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /56","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2005;

-- ---------------------------------------------------------------------------
-- 2006 — mirrors 1957
-- Three-tier Chrome inferred from 2005 and 2007 confirmations
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1957","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /557","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /57","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2006;

-- ---------------------------------------------------------------------------
-- 2007 — mirrors 1958
-- CONFIRMED: Chrome /1958, Refractor /558, Black /58 (BaseballCardPedia)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1958","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /558","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /58","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2007;

-- ---------------------------------------------------------------------------
-- 2008 — mirrors 1959
-- CONFIRMED: Chrome /1959, Refractor /559, Black /59 (BaseballCardPedia)
-- Base also had unnumbered Black Backs (skip — unnumbered)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1959","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /559","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /59","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2008;

-- ---------------------------------------------------------------------------
-- 2009 — mirrors 1960
-- Three-tier Chrome inferred from 2008 and 2010 confirmations
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1960","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /560","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /60","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2009;

-- ---------------------------------------------------------------------------
-- 2010 — mirrors 1961
-- CONFIRMED: Chrome /1961, Refractor /561, Black /61 (CardboardConnection)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1961","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /561","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /61","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2010;

-- ---------------------------------------------------------------------------
-- 2011 — mirrors 1962
-- CONFIRMED: Chrome /1962, Refractor /562, Black /62 (BaseballCardPedia)
-- Also has unnumbered Hot Box Green Refractor and retail Blue/Red/Green tint
-- subsets (all unnumbered subsets — excluded)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1962","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /562","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /62","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2011;

-- ---------------------------------------------------------------------------
-- 2012 — mirrors 1963
-- Three-tier Chrome inferred from 2011 and 2013 confirmations
-- Gold /5 likely not yet present (absent from confirmed 2011 data)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /1963","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /563","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /63","ebay_kw":"Chrome Black Refractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2012;

-- ---------------------------------------------------------------------------
-- 2013 — mirrors 1964
-- CONFIRMED: Chrome /999, Refractor /564, Black /64, Gold /5, Mini /100
-- (CardboardConnection)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /564","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /64","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2013;

-- ---------------------------------------------------------------------------
-- 2014 — mirrors 1965
-- CONFIRMED: Chrome /999, Refractor /565, Black /65, Gold /5, Mini /100
-- (CardboardConnection)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /565","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /65","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2014;

-- ---------------------------------------------------------------------------
-- 2015 — mirrors 1966
-- CONFIRMED: Chrome /999, Refractor /566, Black /66, Gold /5, Mini /100
-- (CardboardConnection — Blue Back base parallel was unnumbered, skip)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /566","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /66","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2015;

-- ---------------------------------------------------------------------------
-- 2016 — mirrors 1967
-- CONFIRMED: Refractor /567, Black /67, Gold /5, SuperFractor 1/1, Mini /100
-- Chrome base /999 inferred (confirmed /999 in 2013-2015; 2017 was unnumbered)
-- Hot Box Purple Refractor unnumbered — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /567","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /67","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2016;

-- ---------------------------------------------------------------------------
-- 2017 — mirrors 1968
-- CONFIRMED Chrome: Refractor /568, Blue /68, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Blue Bordered /50, Yellow Backs /25, Gray Backs /10, Flip /5
-- CONFIRMED Mini: /100  (CardboardConnection + Beckett)
-- Hot Box Purple Refractor unnumbered — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Bordered /50","ebay_kw":"Blue Border"},
  {"label":"Yellow Backs /25","ebay_kw":"Yellow Back"},
  {"label":"Gray Backs /10","ebay_kw":"Gray Back"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome Refractor /568","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Blue Refractor /68","ebay_kw":"Chrome Blue Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2017;

-- ---------------------------------------------------------------------------
-- 2018 — mirrors 1969
-- CONFIRMED Chrome: Refractor /569, Black /69, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Black Border /50, 100th Anniversary /25, Magenta Backs /10, Flip /5
-- CONFIRMED Mini: /100 (132 cards)  (CardboardConnection + Beckett parallels guide)
-- Hot Box Chrome unnumbered — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"100th Anniversary /25","ebay_kw":"100th Anniversary"},
  {"label":"Magenta Backs /10","ebay_kw":"Magenta Back"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome Refractor /569","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /69","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2018;

-- ---------------------------------------------------------------------------
-- 2019 — mirrors 1970
-- CONFIRMED Chrome: Chrome /999 (Mega Box excl.), Refractor /570, Black /70, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Black Border /50, Silver Metal Base /70, Flip Stock /5
-- CONFIRMED Mini: /100  (CardboardConnection)
-- Hot Box Chrome unnumbered — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"Silver Metal Base /70","ebay_kw":"Silver Metal"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /570","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Black Refractor /70","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2019;

-- ---------------------------------------------------------------------------
-- 2020 — mirrors 1971
-- CONFIRMED Chrome: Refractor /571, White Border /71 (matches '71 white borders),
--   Gold /5, SuperFractor 1/1
-- CONFIRMED Base: White Border /50, Flip Stock /5, Silver Team Name (unnumbered — skip)
-- CONFIRMED Mini: /100  (CardboardConnection)
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"White Border /50","ebay_kw":"White Border"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome Refractor /571","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome White Refractor /71","ebay_kw":"Chrome White Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2020;

-- ---------------------------------------------------------------------------
-- 2021 — mirrors 1972
-- CONFIRMED Chrome: Chrome /999, Refractor /572, Red Border /372, Black /72, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Black Border /50, Flip Stock /5
-- CONFIRMED Mini: /100 (132 cards)  (CardboardConnection)
-- Blue Sparkle (Walmart Mega, unnumbered) and Hot Box Refractor — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /572","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Red Refractor /372","ebay_kw":"Chrome Red Refractor"},
  {"label":"Chrome Black Refractor /72","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2021;

-- ---------------------------------------------------------------------------
-- 2022 — mirrors 1973  (most Chrome tiers in Heritage history — 6 numbered tiers)
-- CONFIRMED Chrome: /999, Refractor /673, Red /573, Silver /373, Green /273, Black /73, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Black Border /50, Flip Stock /5
-- CONFIRMED Mini: /100 (130 cards)  (CardboardConnection)
-- Blue Sparkle (Walmart Mega, unnumbered) and Hot Box — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /673","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Red Refractor /573","ebay_kw":"Chrome Red Refractor"},
  {"label":"Chrome Silver Refractor /373","ebay_kw":"Chrome Silver Refractor"},
  {"label":"Chrome Green Refractor /273","ebay_kw":"Chrome Green Refractor"},
  {"label":"Chrome Black Refractor /73","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2022;

-- ---------------------------------------------------------------------------
-- 2023 — mirrors 1974  (simplified from 2022 — Red and Green tiers dropped)
-- CONFIRMED Chrome: /999, Refractor /574, Silver /374, Black /74, Gold /5, SuperFractor 1/1
-- CONFIRMED Base: Black Border /50, Flip Stock /5
-- CONFIRMED Mini: /100 (127 cards)  (CardboardConnection)
-- Blue Sparkle (Walmart, unnumbered) and Hot Box — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /574","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Silver Refractor /374","ebay_kw":"Chrome Silver Refractor"},
  {"label":"Chrome Black Refractor /74","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2023;

-- ---------------------------------------------------------------------------
-- 2024 — mirrors 1975
-- CONFIRMED Chrome: /999, Refractor /575, Silver /375, Black /75, Gold /5, SuperFractor 1/1
-- Base Black Border /50 present (hobby excl.); Flip Stock /5 (hobby excl.)
-- CONFIRMED Mini: /100  (CardboardConnection)
-- Purple Hot Box Refractor unnumbered — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Border /50","ebay_kw":"Black Border"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome /999","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor /575","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Silver Refractor /375","ebay_kw":"Chrome Silver Refractor"},
  {"label":"Chrome Black Refractor /75","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /5","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"},
  {"label":"Mini /100","ebay_kw":"Mini"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2024;

-- ---------------------------------------------------------------------------
-- 2025 — mirrors 1976  (MAJOR overhaul — Chrome Refractor becomes UNNUMBERED;
--   new multi-tier numbered Chrome structure; Bicentennial /200 base parallel)
-- CONFIRMED Chrome: Refractor (unnumbered), Blue /150, Green /99, Black /76, Gold /50, Orange /25, Red /5, SuperFractor 1/1
-- CONFIRMED Base: Bicentennial /200, Color of Year /76, Flip Stock /5
-- Unnumbered sparkle Refractors (retail/hobby) and Black Bordered base (no serial) — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Bicentennial /200","ebay_kw":"Bicentennial"},
  {"label":"Color of Year /76","ebay_kw":"Color of Year"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Blue Refractor /150","ebay_kw":"Chrome Blue Refractor"},
  {"label":"Chrome Green Refractor /99","ebay_kw":"Chrome Green Refractor"},
  {"label":"Chrome Black Refractor /76","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /50","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome Orange Refractor /25","ebay_kw":"Chrome Orange Refractor"},
  {"label":"Chrome Red Refractor /5","ebay_kw":"Chrome Red Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2025;

-- ---------------------------------------------------------------------------
-- 2026 — mirrors 1977  (similar to 2025 structure; Black /77 matches mirrored year)
-- CONFIRMED Chrome: Refractor (unnumbered), Blue /150, Green /99, Black /77, Gold /50, Orange /25, Red /5, SuperFractor 1/1
-- CONFIRMED Base: Heritage Orange /77 (Color of Year), Flip Stock /5
-- Unnumbered base bordered parallels and Deckle Edge (no serial) — excluded
-- ---------------------------------------------------------------------------
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Heritage Orange /77","ebay_kw":"Heritage Orange"},
  {"label":"Flip Stock /5","ebay_kw":"Flip Stock"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Blue Refractor /150","ebay_kw":"Chrome Blue Refractor"},
  {"label":"Chrome Green Refractor /99","ebay_kw":"Chrome Green Refractor"},
  {"label":"Chrome Black Refractor /77","ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome Gold Refractor /50","ebay_kw":"Chrome Gold Refractor"},
  {"label":"Chrome Orange Refractor /25","ebay_kw":"Chrome Orange Refractor"},
  {"label":"Chrome Red Refractor /5","ebay_kw":"Chrome Red Refractor"},
  {"label":"Chrome SuperFractor /1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand='Topps' AND set_name='Heritage' AND sport='baseball' AND year=2026;
