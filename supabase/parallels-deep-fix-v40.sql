-- =============================================================================
-- parallels-deep-fix-v40.sql
-- One set corrected:
--
-- 1. Panini Prizm Football
--    (brand='Panini', set_name='Prizm', sport='football')
--    14 rows, DB years 2012-2025
--
--    The flagship NFL Prizm product; debuted 2012.
--    Panini retains the NFL license through at least 2025-26.
--    DB year 2025 = 2025 season (released Feb 2026 per Checklist Insider).
--
--    NOTE: "Prizm Fast Break" equivalents for football are labeled "No Huddle"
--    but since NO separate DB entry exists for "Prizm No Huddle" football,
--    No Huddle exclusive parallels ARE included here.
--    Choice box parallels are also included (no separate DB entry).
--    FOTL (First Off The Line) Shimmer parallels are included.
--
-- Key differences vs. Prizm Basketball:
--   - Football uses different parallel names per year era
--   - Most numbered parallels are sport-specific (e.g. "Green Scope", "Camo")
--   - Hyper is NUMBERED in football (not unnumbered like basketball)
--   - Gold Vinyl /5 (not Black Gold /5 like basketball)
--   - "Black Finite" is the 1/1 (not "Black" like basketball)
--   - Shimmer FOTL tiers have very low print runs (/2 to /35)
--
-- Sources: Cardboard Connection, Beckett, Checklist Insider, TCDB
-- =============================================================================

-- ─── 2012: Debut year ────────────────────────────────────────────────────────

-- 2012 Panini Prizm Football debut. Only 5 parallels in packs.
-- All base cards are chromium refractors (Silver = the base product).
-- Red Die-Cut = hobby-only stamped die-cut parallel.
-- Pylon 1/1 was sold separately by Panini, not pack-pulled.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Red Die-Cut","ebay_kw":"Red Die-Cut"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2012;

-- ─── 2013: Die-cut + cracked ice era ─────────────────────────────────────────

-- 2013 Panini Prizm Football. 12 documented parallels.
-- Green = random retail. Blue = Walmart Blaster. Camouflage = Target.
-- Blue Pulsar = Walmart Rack Packs. Red Pulsar = Target Rack Packs.
-- Light Blue Pulsar = Jumbo (unnumbered). Die-Cut Light Blue Pulsar /15 = Jumbo.
-- Purple Cracked Ice /40 = Jumbo serial-numbered.
-- Orange Die-Cut /50 = Hobby serial-numbered.
-- (Source: Cardboard Connection 2013 Prizm Football Parallels Guide)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Camouflage","ebay_kw":"Camouflage"},
  {"label":"Blue Pulsar","ebay_kw":"Blue Pulsar"},
  {"label":"Red Pulsar","ebay_kw":"Red Pulsar"},
  {"label":"Light Blue Pulsar","ebay_kw":"Light Blue Pulsar"},
  {"label":"Die-Cut Light Blue Pulsar /15","ebay_kw":"Light Blue Die-Cut"},
  {"label":"Purple Cracked Ice /40","ebay_kw":"Purple Cracked Ice"},
  {"label":"Orange Die-Cut /50","ebay_kw":"Orange Die-Cut"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2013;

-- ─── 2014: Mosaic + die-cut expansion ────────────────────────────────────────

-- 2014 Panini Prizm Football. 19 total versions per base card (18 parallels + base).
-- Retail unnumbered: Green, Red, Blue, Purple, RWB.
-- Hobby unnumbered (odds-based): Neon Green-Yellow (1:20), Orange (1:16).
-- Jumbo unnumbered: Pink BCA/Breast Cancer Awareness (1:12), Camo (1:10).
-- Hobby/Jumbo serial-numbered: Light Blue Wave /99, NFL Shield /75,
--   Red Power /125, Team Logo /50, Tie-Dyed /25, Gold /10, Black Finite 1/1.
-- (Source: Cardboard Connection 2014 Prizm Football Parallel Guide)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Neon Green-Yellow","ebay_kw":"Neon Green Yellow"},
  {"label":"Orange","ebay_kw":"Orange"},
  {"label":"Pink BCA","ebay_kw":"Pink"},
  {"label":"Camo","ebay_kw":"Camo"},
  {"label":"Light Blue Wave /99","ebay_kw":"Light Blue Wave"},
  {"label":"Red Power /125","ebay_kw":"Red Power"},
  {"label":"NFL Shield /75","ebay_kw":"NFL Shield"},
  {"label":"Team Logo /50","ebay_kw":"Team Logo"},
  {"label":"Tie-Dyed /25","ebay_kw":"Tie-Dyed"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2014;

-- ─── 2015: Wave / Mojo / Cracked Ice era ─────────────────────────────────────

-- 2015 Panini Prizm Football. 15 Prizm parallels confirmed (Beckett).
-- Violet = Jumbo Hobby exclusive (unnumbered). White Sparkle = Panini Rewards SSP.
-- Blue Wave /150 = serial-numbered (not /199 as in later years).
-- Mojo Red /99 = hobby serial-numbered pattern parallel.
-- Green Crystals (Cracked Ice) /75 = serial-numbered hobby.
-- Violet Mosaic /50 = Jumbo serial-numbered.
-- (Source: Cardboard Connection + Beckett 2015 Prizm Football Parallels)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Violet","ebay_kw":"Violet"},
  {"label":"Blue Wave /150","ebay_kw":"Blue Wave"},
  {"label":"Mojo Red /99","ebay_kw":"Mojo Red"},
  {"label":"Green Crystals /75","ebay_kw":"Green Crystals"},
  {"label":"Violet Mosaic /50","ebay_kw":"Violet Mosaic"},
  {"label":"Tie-Dyed /25","ebay_kw":"Tie-Dyed"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Black Pulsar 1/1","ebay_kw":"Black Pulsar"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2015;

-- ─── 2016: Blue Wave /149 + new named-tier era ───────────────────────────────

-- 2016 Panini Prizm Football. 17 parallels documented.
-- Retail unnumbered: Blue, Flash (Blaster), Green, Pink (Target Premium), Red, RWB Disco.
-- Numbered: Orange /299, Light Blue /199, Blue Wave /149, Purple Scope /99,
--   Red Crystals /75, Green Power /49, Camo /25, Gold /10, Gold Vinyl /5, Black Finite 1/1.
-- (Source: Cardboard Connection 2016 Prizm Football; Beckett 2016 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red White Blue Disco","ebay_kw":"Red White Blue"},
  {"label":"Orange /299","ebay_kw":"Orange"},
  {"label":"Light Blue /199","ebay_kw":"Light Blue"},
  {"label":"Blue Wave /149","ebay_kw":"Blue Wave"},
  {"label":"Purple Scope /99","ebay_kw":"Purple Scope"},
  {"label":"Red Crystals /75","ebay_kw":"Red Crystals"},
  {"label":"Green Power /49","ebay_kw":"Green Power"},
  {"label":"Camo /25","ebay_kw":"Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2016;

-- ─── 2017: Orange /275 debut — 17 parallels ──────────────────────────────────

-- 2017 Panini Prizm Football. 17 total parallels (9 numbered in hobby).
-- Orange /275 = new top serial-numbered tier (later becomes /249).
-- Light Blue /199 serial-numbered. Blue Wave /149 continues.
-- Green Scope /99 + Purple Crystals /75 = new named-scope/crystal tiers.
-- Red Power /49 + Camo /25 + Gold /10 + Gold Vinyl /5 + Black Finite 1/1 = hobby.
-- Retail unnumbered: Blue, Green, Red, Pink, RWB Disco, Flash.
-- (Source: Beckett 2017 Prizm Football; Cardboard Connection 2017 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red White Blue Disco","ebay_kw":"Red White Blue"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Orange /275","ebay_kw":"Orange"},
  {"label":"Light Blue /199","ebay_kw":"Light Blue"},
  {"label":"Blue Wave /149","ebay_kw":"Blue Wave"},
  {"label":"Green Scope /99","ebay_kw":"Green Scope"},
  {"label":"Purple Crystals /75","ebay_kw":"Purple Crystals"},
  {"label":"Red Power /49","ebay_kw":"Red Power"},
  {"label":"Camo /25","ebay_kw":"Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2017;

-- ─── 2018: Hyper /275 (numbered for first time) ──────────────────────────────

-- 2018 Panini Prizm Football. 12 parallels in hobby; more in retail.
-- NOTE: Hyper is SERIAL-NUMBERED /275 in football (unlike basketball where unnumbered).
-- Orange /249 = new top numbered tier (replaces Orange /275).
-- Light Blue /199 → Red Wave /149 → Blue Scope /99 → Green Crystals /75 → Purple Power /49.
-- Retail unnumbered: Blue, Green, Red, Pink, Disco, Lazer, RWB.
-- (Source: Beckett 2018 Prizm Football; Cardboard Connection 2018 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Hyper /275","ebay_kw":"Hyper"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Light Blue /199","ebay_kw":"Light Blue"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Blue Scope /99","ebay_kw":"Blue Scope"},
  {"label":"Green Crystals /75","ebay_kw":"Green Crystals"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Camo /25","ebay_kw":"Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2018;

-- ─── 2019: Modern numbered skeleton established ───────────────────────────────

-- 2019 Panini Prizm Football. Establishes the modern numbered parallel skeleton.
-- Orange /249, Blue Wave /199, Hyper /175, Red Wave /149, Blue Ice /99,
--   Green Scope /75, Purple Power /49, Camo /25, Gold /10, Gold Vinyl /5,
--   Black Finite 1/1 = the standard hobby tiers going forward.
-- FOTL Shimmer parallels: Red Shimmer /15, Blue Shimmer /10, Green Shimmer /2.
-- Unnumbered: Silver (Base), Blue, Disco, Green, Lazer, Neon Green, Pink,
--   Red, Red Ice, RWB, White Sparkle.
-- (Source: Cardboard Connection 2019 Prizm Football NFL)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Neon Green","ebay_kw":"Neon Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue Wave /199","ebay_kw":"Blue Wave"},
  {"label":"Hyper /175","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Camo /25","ebay_kw":"Camo"},
  {"label":"Red Shimmer /15","ebay_kw":"Red Shimmer"},
  {"label":"Blue Shimmer /10","ebay_kw":"Blue Shimmer"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Shimmer /2","ebay_kw":"Green Shimmer"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2019;

-- ─── 2020: Pattern/checker explosion + Purple /125 + Red & Yellow ─────────────

-- 2020 Panini Prizm Football. ~33 parallels across all configurations.
-- New: Purple /125 (between Hyper and Red Wave), Snakeskin (unnumbered),
--   B&W Checker (unnumbered), Orange Ice (unnumbered), Purple Pulsar (unnumbered).
-- Red & Yellow /49 = base + /8 for rookies only.
-- FOTL Shimmer: Red /35, Blue /25, Green /5.
-- No Huddle parallels confirmed for this year.
-- (Source: Cardboard Connection 2020 Prizm Football NFL)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Light Blue","ebay_kw":"Light Blue"},
  {"label":"Neon Green Pulsar","ebay_kw":"Neon Green Pulsar"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Purple Pulsar","ebay_kw":"Purple Pulsar"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue Wave /199","ebay_kw":"Blue Wave"},
  {"label":"Hyper /175","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Yellow /49","ebay_kw":"Red Yellow"},
  {"label":"Red Shimmer /35","ebay_kw":"Red Shimmer"},
  {"label":"Blue Shimmer /25","ebay_kw":"Blue Shimmer"},
  {"label":"Camo /25","ebay_kw":"Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2020;

-- ─── 2021: Full modern era + Orange Wave /60 + dual Camo ─────────────────────

-- 2021 Panini Prizm Football. 37+ parallels across all configurations.
-- New vs. 2020: B&R Checker (unnumbered), Purple Ice /225 (between Orange and Blue Wave),
--   Green Ice (unnumbered), Orange Wave /60 (between Green Scope and Purple Power),
--   Navy Camo /25 (serial-numbered, replaces standard Camo),
--   Forest Camo /15 (new low-print numbered camo tier),
--   Gold Shimmer /10 (FOTL).
-- Red Shimmer moves to /35, Blue Shimmer to /25 (from /10, /15 in 2019).
-- (Source: Beckett 2021 Prizm Football; Cardboard Connection 2021 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and Red Checker","ebay_kw":"Black Red Checker"},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Light Blue","ebay_kw":"Light Blue"},
  {"label":"Neon Green Pulsar","ebay_kw":"Neon Green Pulsar"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Purple Pulsar","ebay_kw":"Purple Pulsar"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Purple Ice /225","ebay_kw":"Purple Ice"},
  {"label":"Blue Wave /199","ebay_kw":"Blue Wave"},
  {"label":"Hyper /175","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Shimmer /35","ebay_kw":"Red Shimmer"},
  {"label":"Blue Shimmer /25","ebay_kw":"Blue Shimmer"},
  {"label":"Navy Camo /25","ebay_kw":"Navy Camo"},
  {"label":"Forest Camo /15","ebay_kw":"Forest Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2021;

-- ─── 2022: Blue Sparkle /96 + Gold Sparkle /24 + Green Sparkle /8 ────────────

-- 2022 Panini Prizm Football. ~35 parallels across all configurations.
-- New vs. 2021: Blue Sparkle /96 (between Blue Ice and Green Scope),
--   Gold Sparkle /24 (between Navy Camo and Forest Camo),
--   Green Sparkle /8 (between Gold Shimmer and Gold Vinyl).
-- Dropped: Disco + Lazer + Red Ice + B&W Checker (some may have returned as retail).
-- Red Sparkle = new unnumbered retail pattern.
-- (Source: confirmed via Beckett/search; Cardboard Connection 2022 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and Red Checker","ebay_kw":"Black Red Checker"},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Light Blue","ebay_kw":"Light Blue"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Purple Ice /225","ebay_kw":"Purple Ice"},
  {"label":"Blue Wave /199","ebay_kw":"Blue Wave"},
  {"label":"Hyper /175","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Shimmer /35","ebay_kw":"Red Shimmer"},
  {"label":"Blue Shimmer /25","ebay_kw":"Blue Shimmer"},
  {"label":"Navy Camo /25","ebay_kw":"Navy Camo"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Forest Camo /15","ebay_kw":"Forest Camo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2022;

-- ─── 2023: Pandora /400 + No Huddle sub-product + White Knight /3 ─────────────

-- 2023 Panini Prizm Football. ~54 parallels across all configurations.
-- New: Pandora /400 (super-high numbered new tier), Purple Wave /99 (new wave tier),
--   Red & Yellow /44, White Knight /3 (extremely rare new tier).
-- No Huddle sub-product parallels: Base (unnumbered), Blue /95, Red /70, Purple /35,
--   Pink /15, Neon Green /5. Included here since no separate DB entry.
-- Gold Wave /10 added (FOTL). Black Shimmer + Black Stars 1/1 added.
-- Press Proof = new unnumbered hobby parallel.
-- (Source: confirmed via Beckett/search 2023 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and Red Checker","ebay_kw":"Black Red Checker"},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Neon Green Pulsar","ebay_kw":"Neon Green Pulsar"},
  {"label":"No Huddle","ebay_kw":"No Huddle"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Press Proof","ebay_kw":"Press Proof"},
  {"label":"Purple Pulsar","ebay_kw":"Purple Pulsar"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Pandora /400","ebay_kw":"Pandora"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Purple Ice /225","ebay_kw":"Purple Ice"},
  {"label":"Blue Wave /199","ebay_kw":"Blue Wave"},
  {"label":"Hyper /175","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Purple Wave /99","ebay_kw":"Purple Wave"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"No Huddle Blue /95","ebay_kw":"No Huddle Blue"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"No Huddle Red /70","ebay_kw":"No Huddle Red"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Yellow /44","ebay_kw":"Red Yellow"},
  {"label":"No Huddle Purple /35","ebay_kw":"No Huddle Purple"},
  {"label":"Red Shimmer /35","ebay_kw":"Red Shimmer"},
  {"label":"Blue Shimmer /25","ebay_kw":"Blue Shimmer"},
  {"label":"Navy Camo /25","ebay_kw":"Navy Camo"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Forest Camo /15","ebay_kw":"Forest Camo"},
  {"label":"No Huddle Pink /15","ebay_kw":"No Huddle Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"No Huddle Neon Green /5","ebay_kw":"No Huddle Neon Green"},
  {"label":"White Knight /3","ebay_kw":"White Knight"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"},
  {"label":"Black Stars 1/1","ebay_kw":"Black Stars"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2023;

-- ─── 2024: Blue Wave now /230; Jade Dragon → Lotus → expanded Choice ─────────

-- 2024 Panini Prizm Football. ~63 parallels across all configurations.
-- New vs. 2023: Blue Wave /230 (was /199), Hyper /180 (was /175), Pink Wave (unnumbered),
--   White /35, Red Shimmer now /35 (was /35), Blue Shimmer /25,
--   No Huddle Blue /99 (was /95), No Huddle Red /75 (was /70),
--   Choice Red /20, Choice Cherry Blossom /15, Choice Blue /14, Choice Gold /10,
--   Choice Nebula 1/1.
-- (Source: Checklist Insider 2024 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and Red Checker","ebay_kw":"Black Red Checker"},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Neon Green Pulsar","ebay_kw":"Neon Green Pulsar"},
  {"label":"No Huddle","ebay_kw":"No Huddle"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Pink Wave","ebay_kw":"Pink Wave"},
  {"label":"Press Proof","ebay_kw":"Press Proof"},
  {"label":"Purple Pulsar","ebay_kw":"Purple Pulsar"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Pandora /400","ebay_kw":"Pandora"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue Wave /230","ebay_kw":"Blue Wave"},
  {"label":"Purple Ice /225","ebay_kw":"Purple Ice"},
  {"label":"Hyper /180","ebay_kw":"Hyper"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"No Huddle Blue /99","ebay_kw":"No Huddle Blue"},
  {"label":"Purple Wave /99","ebay_kw":"Purple Wave"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"No Huddle Red /75","ebay_kw":"No Huddle Red"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"No Huddle Purple /49","ebay_kw":"No Huddle Purple"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Yellow /44","ebay_kw":"Red Yellow"},
  {"label":"Red Shimmer /35","ebay_kw":"Red Shimmer"},
  {"label":"White /35","ebay_kw":"White"},
  {"label":"Blue Shimmer /25","ebay_kw":"Blue Shimmer"},
  {"label":"Navy Camo /25","ebay_kw":"Navy Camo"},
  {"label":"No Huddle Pink /25","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Choice Red /20","ebay_kw":"Choice Red"},
  {"label":"Choice Cherry Blossom /15","ebay_kw":"Cherry Blossom"},
  {"label":"Forest Camo /15","ebay_kw":"Forest Camo"},
  {"label":"Choice Blue /14","ebay_kw":"Choice Blue"},
  {"label":"Choice Gold /10","ebay_kw":"Choice Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"No Huddle Neon Green /10","ebay_kw":"No Huddle Neon Green"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"White Knight /3","ebay_kw":"White Knight"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"},
  {"label":"Black Stars 1/1","ebay_kw":"Black Stars"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2024;

-- ─── 2025: 72 parallels — Pigskin + Kangaroo + Lotus + Plum Blossom ──────────

-- 2025 Panini Prizm Football. ~72 total parallels (released February 2026).
-- New vs. 2024: Pigskin /180 (between Hyper and Red Wave), Kangaroo /61 (new tier),
--   Super Bowl LX /60, Lotus Flower /18, Plum Blossom /8, Panini Logo /20,
--   Purple Shimmer /15, B&B Checker (unnumbered), Green Flash (unnumbered),
--   Red Flash (unnumbered), White Disco (unnumbered).
-- Red Shimmer /49 (was /35), No Huddle Blue /125 (was /99), No Huddle Red /99,
--   Orange Wave /65 (was /60), Hyper /200 (was /180), No Huddle Purple /75.
-- (Source: Checklist Insider 2025 Prizm Football)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black and Blue Checker","ebay_kw":"Black Blue Checker"},
  {"label":"Black and Red Checker","ebay_kw":"Black Red Checker"},
  {"label":"Black and White Checker","ebay_kw":"Black White Checker"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Green Flash","ebay_kw":"Green Flash"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Lazer","ebay_kw":"Lazer"},
  {"label":"Neon Green Pulsar","ebay_kw":"Neon Green Pulsar"},
  {"label":"No Huddle","ebay_kw":"No Huddle"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Pink Wave","ebay_kw":"Pink Wave"},
  {"label":"Press Proof","ebay_kw":"Press Proof"},
  {"label":"Purple Pulsar","ebay_kw":"Purple Pulsar"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Flash","ebay_kw":"Red Flash"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Disco","ebay_kw":"White Disco"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Pandora /400","ebay_kw":"Pandora"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue Wave /230","ebay_kw":"Blue Wave"},
  {"label":"Purple Ice /225","ebay_kw":"Purple Ice"},
  {"label":"Hyper /200","ebay_kw":"Hyper"},
  {"label":"Pigskin /180","ebay_kw":"Pigskin"},
  {"label":"Red Wave /149","ebay_kw":"Red Wave"},
  {"label":"No Huddle Blue /125","ebay_kw":"No Huddle Blue"},
  {"label":"Purple /125","ebay_kw":"Purple"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"No Huddle Red /99","ebay_kw":"No Huddle Red"},
  {"label":"Purple Wave /99","ebay_kw":"Purple Wave"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Green Scope /75","ebay_kw":"Green Scope"},
  {"label":"No Huddle Purple /75","ebay_kw":"No Huddle Purple"},
  {"label":"Orange Wave /65","ebay_kw":"Orange Wave"},
  {"label":"Kangaroo /61","ebay_kw":"Kangaroo"},
  {"label":"Super Bowl LX /60","ebay_kw":"Super Bowl LX"},
  {"label":"Purple Power /49","ebay_kw":"Purple Power"},
  {"label":"Red Shimmer /49","ebay_kw":"Red Shimmer"},
  {"label":"Red Yellow /44","ebay_kw":"Red Yellow"},
  {"label":"Blue Shimmer /35","ebay_kw":"Blue Shimmer"},
  {"label":"White /35","ebay_kw":"White"},
  {"label":"Navy Camo /25","ebay_kw":"Navy Camo"},
  {"label":"No Huddle Pink /25","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Choice Red /20","ebay_kw":"Choice Red"},
  {"label":"Panini Logo /20","ebay_kw":"Panini Logo"},
  {"label":"Lotus Flower /18","ebay_kw":"Lotus Flower"},
  {"label":"Choice Cherry Blossom /15","ebay_kw":"Cherry Blossom"},
  {"label":"Forest Camo /15","ebay_kw":"Forest Camo"},
  {"label":"Purple Shimmer /15","ebay_kw":"Purple Shimmer"},
  {"label":"Choice Blue /14","ebay_kw":"Choice Blue"},
  {"label":"Choice Gold /10","ebay_kw":"Choice Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"No Huddle Neon Green /10","ebay_kw":"No Huddle Neon Green"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Plum Blossom /8","ebay_kw":"Plum Blossom"},
  {"label":"Gold Vinyl /5","ebay_kw":"Gold Vinyl"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"White Knight /3","ebay_kw":"White Knight"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"},
  {"label":"Black Stars 1/1","ebay_kw":"Black Stars"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football'
  AND year = 2025;
