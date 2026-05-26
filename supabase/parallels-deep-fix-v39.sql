-- =============================================================================
-- parallels-deep-fix-v39.sql
-- One set corrected:
--
-- 1. Panini Prizm Basketball
--    (brand='Panini', set_name='Prizm', sport='basketball')
--    14 rows, DB years 2012-2025 (= 2012-13 through 2024-25 seasons)
--
--    The flagship NBA Prizm product; debuted 2012-13.
--    Panini's NBA license ran through 2024-25; no 2025-26 Prizm exists.
--    DB year 2025 = placeholder row only.
--
--    NOTE: "Prizm Fast Break" is a SEPARATE DB set_name entry.
--    Fast Break-EXCLUSIVE parallels (Fast Break Base, FB Blue/Red/Purple etc.)
--    are intentionally excluded here. Choice box parallels ARE included
--    since Choice shares the base-set checklist and has no separate DB entry.
--    FOTL (First Off The Line) Shimmer parallels are included as they are
--    hobby-tier premium variants of the main product, not a separate set.
--
-- Parallel era summary by DB year (= season start year):
--
--   2012  Debut — 4 entries (Base + Green + Gold /10)
--   2013  Early die-cut era — 12 entries
--   2014  Mosaic + die-cut era — 18 entries (17 documented parallels)
--   2015  Wave / Mojo / Hyper /10 debut — 15 entries
--   2016  5th Anniversary /5 + Teal Wave /25 era — 14 entries
--   2017  Blue Ice /99 + Red Shimmer /8 FOTL — 17 entries
--   2018  Full ice/wave/pulsar suite — 22 entries (36 total across all SKUs)
--   2019  Ice sub-series + Pulsar sub-series — 21 core entries
--   2020  Wave/Ice pattern explosion — 32 entries
--   2021  NBA 75th Anniversary variants — 38 entries
--   2022  Modern wave/ice/shimmer era — 34 entries
--   2023  Seismic + Teal Ice + simplified numbered; ~60 total parallels
--   2024  Final Panini NBA; Dragon Year + Lotus Flower + Jade Dragon exclusives
--   2025  Placeholder (no Panini product released)
--
-- Total: 14 rows updated
-- Sources: Cardboard Connection, Beckett, Checklist Insider, TCDB, Beckett Rainbow
-- =============================================================================

-- ─── 2012: Debut year ────────────────────────────────────────────────────────

-- 2012-13 Prizm debut. Only 3 documented parallels beyond the base card.
-- Silver = the standard Prizm refractor (IS the base product; no non-chrome base).
-- Green = retail-only parallel. Gold /10 = hobby serial-numbered.
-- No Black 1/1 or die-cuts in year 1. No documented print run for Silver.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Gold /10","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2012;

-- ─── 2013: Early die-cut expansion ───────────────────────────────────────────

-- 2013-14 Prizm. First major parallel expansion with die-cut inserts.
-- Green = retail. Blue = Walmart. Red = Target. RWB Pulsar = rack multipack.
-- Light Blue Die-Cut /199 + Orange /60 = Jumbo Hobby.
-- Purple Die-Cut /49 + Gold /10 + Black 1/1 = Hobby.
-- Black Mosaic 1/1 = ultra-rare 1-of-1 pattern variant.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Blue","ebay_kw":"Blue"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red White Blue Pulsar","ebay_kw":"Red White Blue"},
  {"label":"Light Blue Die-Cut /199","ebay_kw":"Light Blue"},
  {"label":"Orange /60","ebay_kw":"Orange"},
  {"label":"Purple Die-Cut /49","ebay_kw":"Purple"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Black Mosaic 1/1","ebay_kw":"Black Mosaic"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2013;

-- ─── 2014: Mosaic + die-cut era ──────────────────────────────────────────────

-- 2014-15 Prizm. 17 documented parallels across hobby/jumbo/retail.
-- Orange Die-Cut /139 + Gold Pulsar /10 + Red Pulsar /25 + Black Pulsar 1/1 = Jumbo.
-- Purple Die-Cut /139 + Blue /99 + Red /49 + Gold /10 + Black 1/1 = Hobby.
-- Light Blue /49 = Jumbo serial-numbered.
-- Green + Blue Wave = basic retail. Blue Mojo = blaster boxes.
-- RWB Pulsar = rack pack (multipack). Blue/Green Mosaic + Yellow/Red Mosaic = hobby/jumbo.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Blue Wave","ebay_kw":"Blue Wave"},
  {"label":"Blue Mojo","ebay_kw":"Blue Mojo"},
  {"label":"Red White Blue Pulsar","ebay_kw":"Red White Blue"},
  {"label":"Blue and Green Mosaic","ebay_kw":"Blue Green Mosaic"},
  {"label":"Yellow and Red Mosaic","ebay_kw":"Yellow Red Mosaic"},
  {"label":"Light Blue /49","ebay_kw":"Light Blue"},
  {"label":"Orange Die-Cut /139","ebay_kw":"Orange"},
  {"label":"Purple Die-Cut /139","ebay_kw":"Purple"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Red /49","ebay_kw":"Red"},
  {"label":"Red Pulsar /25","ebay_kw":"Red Pulsar"},
  {"label":"Gold Pulsar /10","ebay_kw":"Gold Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Pulsar 1/1","ebay_kw":"Black Pulsar"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2014;

-- ─── 2015: Wave / Mojo / Hyper debut era ─────────────────────────────────────

-- 2015-16 Prizm. Introduced the wave and mojo pattern parallels.
-- Hyper /10 = ultra-rare pattern parallel (limited to 10 copies).
-- Flash = hobby pack pattern parallel (unnumbered).
-- Orange Wave = unnumbered wave pattern. Ruby Wave /350 = blaster.
-- White Sparkle = Panini Rewards SSP (extremely rare promo).
-- White = hobby exclusive (unnumbered). Light Blue /199 = Jumbo.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"White","ebay_kw":"White"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Orange Wave","ebay_kw":"Orange Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Ruby Wave /350","ebay_kw":"Ruby Wave"},
  {"label":"Light Blue /199","ebay_kw":"Light Blue"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Orange /65","ebay_kw":"Orange"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Hyper /10","ebay_kw":"Hyper"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2015;

-- ─── 2016: Fifth Anniversary + Teal Wave era ─────────────────────────────────

-- 2016-17 Prizm. Celebrates the 5th Anniversary of the Prizm brand.
-- Fifth Anniversary /5 = special serial-numbered parallel for the milestone year.
-- Teal Wave /25 + Orange Wave /25 = new low-print wave tiers.
-- Starburst = new unnumbered hobby pattern parallel.
-- Ruby Wave = unnumbered pattern. Blue Wave /99 serial-numbered.
-- (Source: Beckett, Cardboard Connection 2016-17 checklist)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Starburst","ebay_kw":"Starburst"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"Blue Wave /99","ebay_kw":"Blue Wave"},
  {"label":"Purple /75","ebay_kw":"Purple"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Orange Wave /25","ebay_kw":"Orange Wave"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Teal Wave /25","ebay_kw":"Teal Wave"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Fifth Anniversary /5","ebay_kw":"Fifth Anniversary"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2016;

-- ─── 2017: Blue Ice /99 + 25-parallel expansion ───────────────────────────────

-- 2017-18 Prizm. 25 total parallels across all configurations.
-- Hyper = new unnumbered hobby pattern (replaces Flash).
-- Blue Ice /99 = new serial-numbered ice pattern tier.
-- Pink Pulsar /42 = retail (Target). Red Pulsar /25 = multipack.
-- Green Pulsar /25 = blaster. Red Shimmer /8 = FOTL (1st Off The Line) exclusive.
-- White Sparkle = online promo (Panini Rewards/app exclusive).
-- (Fast Break exclusives excluded — see "Prizm Fast Break" set entry in DB)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Purple /75","ebay_kw":"Purple"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Red Pulsar /25","ebay_kw":"Red Pulsar"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Red Shimmer /8","ebay_kw":"Red Shimmer"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2017;

-- ─── 2018: Full ice/wave/pulsar pattern suite ────────────────────────────────

-- 2018-19 Prizm. 36 total parallels across all SKUs.
-- Introduced Pink Ice (Walmart Mega), Purple Wave (Blaster), Red Ice (Target Mega).
-- Purple Ice /149 = new mid-range serial-numbered ice tier.
-- Purple Pulsar /35 = Gravity Feed. FOTL Shimmer variants /7 (Blue, Light Blue, Red).
-- Black Gold /5 = new bottom-tier serial-numbered parallel.
-- (Confirmed via Cardboard Connection; FOTL Shimmers /7 confirmed Beckett)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Purple Wave","ebay_kw":"Purple Wave"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Purple /75","ebay_kw":"Purple"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Blue Shimmer /7","ebay_kw":"Blue Shimmer"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2018;

-- ─── 2019: 40-parallel mega era (Ice + Pulsar sub-series) ────────────────────

-- 2019-20 Prizm. 40 total parallels across all configurations.
-- New: White Sparkle (retail SSP). Ice sub-series: Green/Orange/Pink/Red Ice
--   (unnumbered) + Purple Ice /149 + Blue Ice /99 (numbered).
-- Pulsar sub-series: Pink /42 (retail) + Purple /35 + Green /25.
-- Purple Wave + Ruby Wave = new unnumbered wave variants.
-- Black Gold /5 continues. FOTL Shimmer Blue /25 + Gold /10 added.
-- (Choice-exclusive parallels excluded per note above)
-- (Source: Cardboard Connection 2019-20 Prizm BBall)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Purple Wave","ebay_kw":"Purple Wave"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Ice /99","ebay_kw":"Blue Ice"},
  {"label":"Purple /75","ebay_kw":"Purple"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020: Wave/Ice pattern explosion ────────────────────────────────────────

-- 2020-21 Prizm. Major wave/ice pattern expansion vs. 2019-20.
-- New unnumbered: Blue Wave, Gold Wave, Green Wave, Orange Ice, Red/Gold Wave.
-- Black Shimmer 1/1 added alongside standard Black 1/1.
-- New numbered: Purple Ice /175, Blue Ice /125, Purple /99, Orange Wave /60.
-- Blue Shimmer /35 (FOTL). Gold Shimmer /10 (FOTL). Green Shimmer /5 (FOTL).
-- Lucky Envelopes /8 = new bottom-tier serial-numbered.
-- (Source: Cardboard Connection 2020-21 Prizm BBall)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Wave","ebay_kw":"Blue Wave"},
  {"label":"Gold Wave","ebay_kw":"Gold Wave"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Purple Wave","ebay_kw":"Purple Wave"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Purple Ice /175","ebay_kw":"Purple Ice"},
  {"label":"Blue Ice /125","ebay_kw":"Blue Ice"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Blue Shimmer /35","ebay_kw":"Blue Shimmer"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021: NBA 75th Anniversary variants ─────────────────────────────────────

-- 2021-22 Prizm. Celebrates the NBA's 75th Anniversary.
-- NBA 75th (Blue, unnumbered) + NBA 75th Diamond /75 (Red) = anniversary parallels.
-- New: Green Wave (unnumbered), Red/Gold Wave (unnumbered), Pulsar (unnumbered).
-- Ice (unnumbered) added as base pattern. Blue Shimmer now /30 (was /35 in 2020-21).
-- Gold Wave /10 = new FOTL serial-numbered. Choice Blue /39 = Choice box exclusive.
-- (Source: Cardboard Connection 2021-22 Prizm BBall; Checklist Insider)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Wave","ebay_kw":"Blue Wave"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Ice","ebay_kw":"Ice"},
  {"label":"NBA 75th","ebay_kw":"75th"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Pulsar","ebay_kw":"Pulsar"},
  {"label":"Purple Wave","ebay_kw":"Purple Wave"},
  {"label":"Red Gold Wave","ebay_kw":"Red Gold Wave"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Ice /125","ebay_kw":"Blue Ice"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"NBA 75th Diamond /75","ebay_kw":"75th Diamond"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Choice Blue /39","ebay_kw":"Choice Blue"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Blue Shimmer /30","ebay_kw":"Blue Shimmer"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Lucky Envelope /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2021;

-- ─── 2022: Modern wave/ice/shimmer era ───────────────────────────────────────

-- 2022-23 Prizm. Similar to 2020-21; NBA 75th dropped.
-- Red Power /75 replaces NBA 75th Diamond /75.
-- Blue Shimmer FOTL /35, Gold Shimmer FOTL /10, Green Shimmer FOTL /5 confirmed.
-- (Source: confirmed data from prior research session)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Wave","ebay_kw":"Blue Wave"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Ice","ebay_kw":"Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Pulsar","ebay_kw":"Pulsar"},
  {"label":"Purple Wave","ebay_kw":"Purple Wave"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Ice /125","ebay_kw":"Blue Ice"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Red Power /75","ebay_kw":"Red Power"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"Blue Shimmer /35","ebay_kw":"Blue Shimmer"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Lucky Envelope /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2022;

-- ─── 2023: Seismic + Teal Ice + simplified numbered tiers ────────────────────

-- 2023-24 Prizm. ~60+ total parallels across all configurations.
-- New patterns: Seismic (Red /299 + Blue /99), Teal Ice /225, Blue Sparkle /144,
--   Multi Wave /88, White Wave /38, White Ice /35, Gold Sparkle /24,
--   Snakeskin (unnumbered + /15), Glitter (unnumbered), Red Sparkle (unnumbered).
-- White /175 = new hobby serial-numbered tier.
-- Red Power /75 continues. Orange Wave /60 continues.
-- FOTL Shimmer: Blue /35, Gold /10, Green /5, Black 1/1.
-- Choice: RWB, Tiger Stripe, Red /88, Blue /49, Cherry Blossom /20, Green /8, Nebula 1/1.
-- (Source: Checklist Insider 2023-24 Prizm BBall)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Glitter","ebay_kw":"Glitter"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Ice","ebay_kw":"Ice"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Pulsar","ebay_kw":"Pulsar"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Red Seismic /299","ebay_kw":"Red Seismic"},
  {"label":"Teal Ice /225","ebay_kw":"Teal Ice"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"White /175","ebay_kw":"White"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Sparkle /144","ebay_kw":"Blue Sparkle"},
  {"label":"Blue Ice /125","ebay_kw":"Blue Ice"},
  {"label":"Blue Seismic /99","ebay_kw":"Blue Seismic"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Choice Red /88","ebay_kw":"Choice Red"},
  {"label":"Multi Wave /88","ebay_kw":"Multi Wave"},
  {"label":"Red Power /75","ebay_kw":"Red Power"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Choice Blue /49","ebay_kw":"Choice Blue"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"White Wave /38","ebay_kw":"White Wave"},
  {"label":"Blue Shimmer /35","ebay_kw":"Blue Shimmer"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"White Ice /35","ebay_kw":"White Ice"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Choice Cherry Blossom /20","ebay_kw":"Cherry Blossom"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Choice Green /8","ebay_kw":"Choice Green"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2023;

-- ─── 2024: Final Panini NBA — Dragon Year + Asian market exclusives ───────────

-- 2024-25 Prizm. Final NBA-licensed Panini Prizm release (~82 total parallels).
-- Fanatics/Topps takes over NBA license from 2025-26.
-- New vs. 2023-24: Dragon Year /88, Jade Dragon Scale /48, Lotus Flower /18,
--   Plum Blossom /8, Blue Pulsar /99, Red Pulsar /75, Red Lazer /35,
--   Blue Wave /125 (now serial-numbered), Fast Break Orange /125,
--   Gold Ice /10, Gold Lazer /10, White Lazer /275, Orange Seismic /199,
--   Pink /249, Skewed /249, Basketball /225, Black White (unnumbered),
--   Wave (unnumbered), White Tiger Stripe (unnumbered), China Variation.
-- (Source: Checklist Insider 2024-25 Prizm BBall; confirmed ~81-82 parallels)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black White","ebay_kw":"Black White"},
  {"label":"Glitter","ebay_kw":"Glitter"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Wave","ebay_kw":"Green Wave"},
  {"label":"Hyper","ebay_kw":"Hyper"},
  {"label":"Ice","ebay_kw":"Ice"},
  {"label":"Orange Ice","ebay_kw":"Orange Ice"},
  {"label":"Pink Ice","ebay_kw":"Pink Ice"},
  {"label":"Pulsar","ebay_kw":"Pulsar"},
  {"label":"Red Ice","ebay_kw":"Red Ice"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Ruby Wave","ebay_kw":"Ruby Wave"},
  {"label":"Snakeskin","ebay_kw":"Snakeskin"},
  {"label":"Wave","ebay_kw":"Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"White Tiger Stripe","ebay_kw":"White Tiger Stripe"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Red Seismic /299","ebay_kw":"Red Seismic"},
  {"label":"White Lazer /275","ebay_kw":"White Lazer"},
  {"label":"Pink /249","ebay_kw":"Pink"},
  {"label":"Skewed /249","ebay_kw":"Skewed"},
  {"label":"Basketball /225","ebay_kw":"Basketball"},
  {"label":"Teal Ice /225","ebay_kw":"Teal Ice"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Orange Seismic /199","ebay_kw":"Orange Seismic"},
  {"label":"White /175","ebay_kw":"White"},
  {"label":"Blue Wave /125","ebay_kw":"Blue Wave"},
  {"label":"Purple Ice /149","ebay_kw":"Purple Ice"},
  {"label":"Blue Sparkle /144","ebay_kw":"Blue Sparkle"},
  {"label":"Blue Ice /125","ebay_kw":"Blue Ice"},
  {"label":"Blue Seismic /99","ebay_kw":"Blue Seismic"},
  {"label":"Blue Pulsar /99","ebay_kw":"Blue Pulsar"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Choice Red /88","ebay_kw":"Choice Red"},
  {"label":"Dragon Year /88","ebay_kw":"Dragon Year"},
  {"label":"Multi Wave /88","ebay_kw":"Multi Wave"},
  {"label":"Red Power /75","ebay_kw":"Red Power"},
  {"label":"Red Pulsar /75","ebay_kw":"Red Pulsar"},
  {"label":"Orange Wave /60","ebay_kw":"Orange Wave"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Choice Blue /49","ebay_kw":"Choice Blue"},
  {"label":"Jade Dragon Scale /48","ebay_kw":"Jade Dragon"},
  {"label":"Pink Pulsar /42","ebay_kw":"Pink Pulsar"},
  {"label":"White Wave /38","ebay_kw":"White Wave"},
  {"label":"Blue Shimmer /35","ebay_kw":"Blue Shimmer"},
  {"label":"Purple Pulsar /35","ebay_kw":"Purple Pulsar"},
  {"label":"Red Lazer /35","ebay_kw":"Red Lazer"},
  {"label":"White Ice /35","ebay_kw":"White Ice"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Mojo /25","ebay_kw":"Mojo"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Choice Cherry Blossom /20","ebay_kw":"Cherry Blossom"},
  {"label":"Lotus Flower /18","ebay_kw":"Lotus Flower"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Ice /10","ebay_kw":"Gold Ice"},
  {"label":"Gold Lazer /10","ebay_kw":"Gold Lazer"},
  {"label":"Gold Shimmer /10","ebay_kw":"Gold Shimmer"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Choice Green /8","ebay_kw":"Choice Green"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Plum Blossom /8","ebay_kw":"Plum Blossom"},
  {"label":"Black Gold /5","ebay_kw":"Black Gold"},
  {"label":"Green Shimmer /5","ebay_kw":"Green Shimmer"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Black Shimmer 1/1","ebay_kw":"Black Shimmer"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2024;

-- ─── 2025: Placeholder (no Panini NBA product) ───────────────────────────────

-- 2025-26 season: Fanatics/Topps holds the exclusive NBA trading card license.
-- Panini released no NBA Prizm for 2025-26. Placeholder row.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball'
  AND year = 2025;
