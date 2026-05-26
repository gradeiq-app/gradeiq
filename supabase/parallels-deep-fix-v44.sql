-- =============================================================================
-- parallels-deep-fix-v44.sql
-- One set corrected:
--
-- 1. Panini Select Basketball
--    (brand='Panini', set_name='Select', sport='basketball')
--    12 rows — DB years 2014-2025
--
-- KEY STRUCTURE NOTE:
--   Panini Select has a 3-tier base set: Concourse (#1-100, common),
--   Premier Level (#101-200, uncommon), and Courtside (#201-300, rare).
--   2023-24 added a 4th retail tier: Mezzanine Level.
--   The tiers have different designs; parallels (Silver, Tie-Dye, etc.) are
--   applied within each tier but have different print runs / names per tier.
--   This JSONB uses the most common "cross-tier" label where possible;
--   tier-specific numbered parallels are labeled with tier abbreviation.
--
-- Parallel eras:
--   - 2014:   Debut — Blue/Silver, Purple/White unnumb; Blue/249 Conc,
--             Light Blue Die-Cut /199 PL, Copper /49 CS, Tie-Dye/Gold/Green/Black
--   - 2015:   Pink /20 added; same tier structure
--   - 2016:   Blue /299 Concourse (from /249); Maroon /175 added
--   - 2017:   Scope + Zebra unnumbered added; Maroon /199 Conc, FOTL Pulsar /9
--   - 2018:   Light Blue /299 Conc replaces Blue /299; Pulsar FOTL /13; Copper /60 CS
--   - 2019:   Blue Die-Cut /249 PL; Disco (H2 exclusive); Orange Die-Cut /65 PL
--   - 2020:   Elephant, Tiger, Cosmic, Shimmer, Flash, Cracked Ice, Wave added
--   - 2021:   Disco /49 numbered in Conc; Teal/White/Pink /49
--   - 2022:   Green Wave /50; Copper Plaid /49 Conc; Lucky Envelopes /8
--   - 2023:   Tectonic, White Sparkle, Orange Tectonic; 4th tier Mezzanine (retail);
--             Dragon Scale /8; Bronze Checker /49; many Disco variants numbered
--   - 2024:   Streamlined vs 2023; Green Mojo /35 + Tectonic /15 notable new
--   - 2025:   Placeholder (no Panini NBA license from 2025-26 onward)
--
-- Sources: Cardboard Connection, Checklist Insider, Beckett, PSA Registry
-- =============================================================================

-- ─── 2014: Debut year ─────────────────────────────────────────────────────────

-- 2014-15 Panini Select Basketball. Debut year.
-- 3 base tiers: Concourse (#1-100), Premier Level (#101-200), Courtside (#201-300).
-- Concourse: Blue/Silver (unnumb), Tri-Color (unnumb), Silver (unnumb),
--   Blue /249, Red /149, Orange /60, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Premier Level: Purple/White (unnumb), Silver (unnumb), Tri-Color (unnumb),
--   Light Blue Die-Cut /199, Purple Die-Cut /99, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Courtside: Blue/Silver (unnumb), Purple/White (unnumb), Silver (unnumb),
--   Copper /49, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue/Silver","ebay_kw":"Blue Silver"},
  {"label":"Purple/White","ebay_kw":"Purple White"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Blue /249","ebay_kw":"Blue"},
  {"label":"Light Blue Die-Cut /199","ebay_kw":"Light Blue"},
  {"label":"Red /149","ebay_kw":"Red"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Orange /60","ebay_kw":"Orange"},
  {"label":"Copper /49","ebay_kw":"Copper"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2014;

-- ─── 2015: Pink /20 added ─────────────────────────────────────────────────────

-- 2015-16 Panini Select Basketball.
-- Same tier structure as 2014-15.
-- Concourse: Silver, Tri-Color unnumb; Blue /249, Red /149, Orange /60,
--   Pink /20, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Premier Level: Silver, Tri-Color Die-Cut unnumb; Light Blue Die-Cut /199,
--   Purple Die-Cut /99, Tie-Dye Die-Cut /25, Gold /10, Green /5, Black 1/1.
-- Courtside: Silver unnumb; Copper /49, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Blue /249","ebay_kw":"Blue"},
  {"label":"Light Blue Die-Cut /199","ebay_kw":"Light Blue"},
  {"label":"Red /149","ebay_kw":"Red"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Orange /60","ebay_kw":"Orange"},
  {"label":"Copper /49","ebay_kw":"Copper"},
  {"label":"Pink /20","ebay_kw":"Pink"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2015;

-- ─── 2016: Maroon /175 added; Blue Concourse now /299 ─────────────────────────

-- 2016-17 Panini Select Basketball.
-- Concourse: Silver, Tri-Color unnumb; Blue /299 (up from /249), Maroon /175 (new),
--   White /149, Orange /60, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Premier Level: Silver, Tri-Color unnumb; Light Blue Die-Cut /199, Purple Die-Cut /99,
--   Neon Yellow Die-Cut /75 (new), Tie-Dye Die-Cut /25, Gold /10, Green /5, Black 1/1.
-- Courtside: Silver unnumb; Copper /49, Tie-Dye /25, Gold /10, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Blue /299","ebay_kw":"Blue"},
  {"label":"Light Blue Die-Cut /199","ebay_kw":"Light Blue"},
  {"label":"Maroon /175","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Yellow Die-Cut /75","ebay_kw":"Neon Yellow"},
  {"label":"Orange /60","ebay_kw":"Orange"},
  {"label":"Copper /49","ebay_kw":"Copper"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2016;

-- ─── 2017: Scope + Zebra added; FOTL Pulsar /9; Maroon /199 Conc ─────────────

-- 2017-18 Panini Select Basketball.
-- Concourse: Silver, Scope, Tri-Color, Zebra unnumb; Blue /299, Maroon /199,
--   White /149, Orange /75, Pink /10, Neon Orange Pulsar FOTL /9,
--   Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Premier Level: Silver, Scope, Tri-Color, Zebra unnumb; Light Blue Die-Cut /185,
--   Maroon Die-Cut /135 (was /175), Purple Die-Cut /99, Neon Green Die-Cut /65 (new),
--   Tie-Dye Die-Cut /25, Gold /10, Green /5, Black 1/1.
-- Courtside: Silver, Zebra unnumb; Copper /49, Tie-Dye /25, Gold /10,
--   Neon Orange Pulsar FOTL /9, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Blue /299","ebay_kw":"Blue"},
  {"label":"Light Blue Die-Cut /185","ebay_kw":"Light Blue"},
  {"label":"Maroon /199","ebay_kw":"Maroon"},
  {"label":"Maroon Die-Cut /135","ebay_kw":"Maroon Die-Cut"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Green Die-Cut /65","ebay_kw":"Neon Green"},
  {"label":"Orange /75","ebay_kw":"Orange"},
  {"label":"Copper /49","ebay_kw":"Copper"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /9","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Pink /10","ebay_kw":"Pink"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2017;

-- ─── 2018: Light Blue /299 Conc; Copper /60 CS; FOTL Pulsar /13 ──────────────

-- 2018-19 Panini Select Basketball.
-- Concourse: Silver, Scope, Tri-Color, Zebra unnumb; Light Blue /299 (new pattern),
--   Red /199, White /149, Neon Green /75, Tie-Dye /25, Pulsar FOTL /13,
--   Gold /10, Green /5, Black 1/1.
-- Premier Level: Silver, Scope, Tri-Color, Zebra unnumb; Blue Die-Cut /185,
--   Maroon Die-Cut /135, Purple Die-Cut /99, Orange Die-Cut /65,
--   Tie-Dye Die-Cut /25, Pulsar FOTL /13, Gold /10, Green /5, Black 1/1.
-- Courtside: Silver, Zebra unnumb; Copper /60 (up from /49),
--   Tie-Dye /25, Pulsar FOTL /13, Gold /10, Green /5, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Die-Cut /185","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon Die-Cut /135","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Copper /60","ebay_kw":"Copper"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /13","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2018;

-- ─── 2019: Blue Die-Cut /249 PL; Disco H2 exclusive ──────────────────────────

-- 2019-20 Panini Select Basketball.
-- Concourse: Silver, Scope, Tri-Color, Zebra SP unnumb; Light Blue /299,
--   Red /199, White /149, Neon Green /75, Tie-Dye /25, Gold /10, Black 1/1.
-- Premier Level: Silver, Scope, Tri-Color, Zebra SP unnumb; Blue Die-Cut /249,
--   Maroon Die-Cut /175, Purple Die-Cut /99, Orange Die-Cut /65,
--   Tie-Dye Die-Cut /25, Gold /10, Green /5, Black 1/1.
-- Courtside: Silver, Zebra SP unnumb; Tie-Dye /25, Gold /10, Green /5, Black 1/1.
-- Disco: H2 exclusive across tiers (Red /49, Blue /25, Gold /10, Green /5, Black 1/1).
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Die-Cut /249","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon Die-Cut /175","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Disco Red /49","ebay_kw":"Disco Red"},
  {"label":"Disco Blue /25","ebay_kw":"Disco Blue"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020: Elephant, Tiger, Cosmic, Cracked Ice, Flash, Shimmer, Wave ─────────

-- 2020-21 Panini Select Basketball. Major parallel expansion.
-- New unnumbered patterns across tiers: Elephant, Tiger, Cosmic, Green/White/Purple,
--   Blue Cracked Ice, Red Cracked Ice, Orange Flash, Red/Orange Shimmer,
--   Red/Gold Wave.
-- Same numbered skeleton as 2019-20 but adds Teal/White/Pink /49,
--   Neon Orange Pulsar FOTL /15, Lucky Envelopes /8, Neon Purple Pulsar FOTL /5.
-- Pulsar FOTL come in Neon Orange #/15, Neon Purple #/5, Black Snakeskin 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Elephant","ebay_kw":"Elephant"},
  {"label":"Tiger","ebay_kw":"Tiger"},
  {"label":"Cosmic","ebay_kw":"Cosmic"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Cracked Ice","ebay_kw":"Cracked Ice"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Shimmer","ebay_kw":"Shimmer"},
  {"label":"Wave","ebay_kw":"Wave"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Die-Cut /249","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon Die-Cut /175","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Teal/White/Pink /49","ebay_kw":"Teal White Pink"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /15","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Neon Purple Pulsar FOTL /5","ebay_kw":"Neon Purple Pulsar"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021: Disco now numbered (/49); same large pattern catalog ───────────────

-- 2021-22 Panini Select Basketball.
-- Same broad structure as 2020-21 with Blue (retail, unnumb) added.
-- Notable: Red Disco /49, Blue Disco /25 (Disco variants now numbered for all tiers).
-- Gold variants (Gold, Gold Cracked Ice, Gold Disco, Gold Flash, Gold Shimmer) all /10.
-- Black variants (Black, Black Cracked Ice, Black Disco, Black Flash, Black Shimmer) all 1/1.
-- Using unified Gold /10 and Black 1/1 labels since all variants share print run.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Elephant","ebay_kw":"Elephant"},
  {"label":"Tiger","ebay_kw":"Tiger"},
  {"label":"Cosmic","ebay_kw":"Cosmic"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Cracked Ice","ebay_kw":"Cracked Ice"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Shimmer","ebay_kw":"Shimmer"},
  {"label":"Wave","ebay_kw":"Wave"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Die-Cut /249","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon Die-Cut /175","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Red Disco /49","ebay_kw":"Red Disco"},
  {"label":"Teal/White/Pink /49","ebay_kw":"Teal White Pink"},
  {"label":"Blue Disco /25","ebay_kw":"Blue Disco"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /15","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Neon Purple Pulsar FOTL /5","ebay_kw":"Neon Purple Pulsar"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2021;

-- ─── 2022: Green Wave /50; Copper Plaid /49 Conc; Blue Scope /249 ─────────────

-- 2022-23 Panini Select Basketball.
-- Concourse numbered: Light Blue /299, Blue Scope /249 (new; Conc only),
--   Red /199, White /149, Neon Green /75, Green Wave /50 (new),
--   Copper Plaid /49 (new; Conc only), Teal/White/Pink /49,
--   Tie-Dye /25, Neon Orange Pulsar FOTL /15, Gold /10, Lucky Envelopes /8,
--   Green /5, Neon Purple Pulsar FOTL /5, Black 1/1.
-- Premier Level numbered: Blue Die-Cut /249, Maroon Die-Cut /175, Purple Die-Cut /99,
--   Orange Die-Cut /65, Green Wave /50, Light Green Die-Cut /49,
--   Teal/White/Pink /49, Tie-Dye Die-Cut /25, Gold /10, Green /5, Black Die-Cut 1/1.
-- Courtside numbered: Light Blue Disco /99, White Disco /75, Green Wave /50,
--   Red Disco /49, Teal/White/Pink /49, Blue Disco /25, Tie-Dye /25, Gold /10,
--   Green /5, Black 1/1.
-- Unnumbered (all tiers): Blue, Blue Cracked Ice, Cosmic, Disco, Elephant,
--   Green Ice, Green Shock, Green/White/Purple, Orange Flash, Red Cracked Ice,
--   Red Wave, Scope, Silver, Tiger, Tri-Color, Zebra.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Elephant","ebay_kw":"Elephant"},
  {"label":"Tiger","ebay_kw":"Tiger"},
  {"label":"Cosmic","ebay_kw":"Cosmic"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Cracked Ice","ebay_kw":"Cracked Ice"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Shock","ebay_kw":"Green Shock"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Scope /249","ebay_kw":"Blue Scope"},
  {"label":"Blue Die-Cut /249","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon Die-Cut /175","ebay_kw":"Maroon"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Light Blue Disco /99","ebay_kw":"Light Blue Disco"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple"},
  {"label":"White Disco /75","ebay_kw":"White Disco"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"Green Wave /50","ebay_kw":"Green Wave"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Copper Plaid /49","ebay_kw":"Copper Plaid"},
  {"label":"Light Green Die-Cut /49","ebay_kw":"Light Green"},
  {"label":"Red Disco /49","ebay_kw":"Red Disco"},
  {"label":"Teal/White/Pink /49","ebay_kw":"Teal White Pink"},
  {"label":"Blue Disco /25","ebay_kw":"Blue Disco"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /15","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Neon Purple Pulsar FOTL /5","ebay_kw":"Neon Purple Pulsar"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2022;

-- ─── 2023: Tectonic/Orange Tectonic; Mezzanine 4th tier; Dragon Scale /8 ──────

-- 2023-24 Panini Select Basketball.
-- 4 base tiers: Concourse, Premier Level, Courtside, + Mezzanine Level (retail new).
-- New unnumbered patterns: Tectonic, Orange Tectonic, White Sparkle, Gold Glitter.
-- New numbered: Blue Tectonic /99, Purple Flash /175, Blue Flash /99,
--   Pink Cracked Ice /99, Purple Cracked Ice /99, Blue Wave /75,
--   Bronze Checker /49, Dragon Scale /8 (ultra-short), Maroon /175 back in Conc.
-- Note: All-Gold /10 variants (standard, Cracked Ice, Disco, Flash, Tectonic, Wave)
--   use "Gold /10" label; all Black 1/1 variants use "Black 1/1".
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Base Mezzanine Level","ebay_kw":"Mezzanine"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Tri-Color","ebay_kw":"Tri-Color"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Elephant","ebay_kw":"Elephant"},
  {"label":"Tiger","ebay_kw":"Tiger"},
  {"label":"Cosmic","ebay_kw":"Cosmic"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Gold Glitter","ebay_kw":"Gold Glitter"},
  {"label":"Tectonic","ebay_kw":"Tectonic"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Cracked Ice","ebay_kw":"Cracked Ice"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Green Shock","ebay_kw":"Green Shock"},
  {"label":"Orange Flash","ebay_kw":"Orange Flash"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Light Blue /299","ebay_kw":"Light Blue"},
  {"label":"Blue Scope /249","ebay_kw":"Blue Scope"},
  {"label":"Blue Die-Cut /249","ebay_kw":"Blue Die-Cut"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Maroon /175","ebay_kw":"Maroon"},
  {"label":"Maroon Die-Cut /175","ebay_kw":"Maroon Die-Cut"},
  {"label":"Purple Flash /175","ebay_kw":"Purple Flash"},
  {"label":"White /149","ebay_kw":"White"},
  {"label":"Blue Flash /99","ebay_kw":"Blue Flash"},
  {"label":"Blue Tectonic /99","ebay_kw":"Blue Tectonic"},
  {"label":"Light Blue Disco /99","ebay_kw":"Light Blue Disco"},
  {"label":"Pink Cracked Ice /99","ebay_kw":"Pink Cracked Ice"},
  {"label":"Purple Cracked Ice /99","ebay_kw":"Purple Cracked Ice"},
  {"label":"Purple Die-Cut /99","ebay_kw":"Purple Die-Cut"},
  {"label":"Blue Wave /75","ebay_kw":"Blue Wave"},
  {"label":"Neon Green /75","ebay_kw":"Neon Green"},
  {"label":"White Disco /75","ebay_kw":"White Disco"},
  {"label":"Green Wave /50","ebay_kw":"Green Wave"},
  {"label":"Orange Die-Cut /65","ebay_kw":"Orange"},
  {"label":"Bronze Checker /49","ebay_kw":"Bronze Checker"},
  {"label":"Red Disco /49","ebay_kw":"Red Disco"},
  {"label":"Teal/White/Pink /49","ebay_kw":"Teal White Pink"},
  {"label":"Blue Disco /25","ebay_kw":"Blue Disco"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"Neon Orange Pulsar FOTL /15","ebay_kw":"Neon Orange Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Dragon Scale /8","ebay_kw":"Dragon Scale"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Neon Purple Pulsar FOTL /5","ebay_kw":"Neon Purple Pulsar"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2023;

-- ─── 2024: Final Panini NBA; Green Mojo /35; Tectonic FOTL /15 ───────────────

-- 2024-25 Panini Select Basketball. Final Panini NBA product.
-- Hobby-exclusive parallels: Bronze Checker (unnumb), Gold Glitter (unnumb),
--   Zebra (unnumb), Tie-Dye /25, Gold /10, Green /5, Black Finite 1/1.
-- H2-exclusive Disco: Light Blue Disco /99, White Disco /75, Red Disco /49,
--   Blue Disco /25, Gold Disco /10, Green Disco /5, Black Disco 1/1.
-- Retail parallels: Blue (unnumb), Orange Flash (unnumb), Purple Flash /175,
--   Blue Flash /99, Cracked Ice variants, Red /49 (Green Stars /49 from search),
--   Green Mojo /35 (new), White Cracked Ice /25, Tectonic FOTL /15, Gold /10.
-- Silver and Scope continue as standard parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base Concourse","ebay_kw":"Concourse"},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Courtside","ebay_kw":"Courtside"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Scope","ebay_kw":"Scope"},
  {"label":"Zebra","ebay_kw":"Zebra"},
  {"label":"Bronze Checker","ebay_kw":"Bronze Checker"},
  {"label":"Gold Glitter","ebay_kw":"Gold Glitter"},
  {"label":"Disco","ebay_kw":"Disco"},
  {"label":"Cracked Ice","ebay_kw":"Cracked Ice"},
  {"label":"Flash","ebay_kw":"Flash"},
  {"label":"Light Blue Disco /99","ebay_kw":"Light Blue Disco"},
  {"label":"Purple Flash /175","ebay_kw":"Purple Flash"},
  {"label":"Blue Flash /99","ebay_kw":"Blue Flash"},
  {"label":"White Disco /75","ebay_kw":"White Disco"},
  {"label":"Green Stars /49","ebay_kw":"Green Stars"},
  {"label":"Red Disco /49","ebay_kw":"Red Disco"},
  {"label":"Green Mojo /35","ebay_kw":"Green Mojo"},
  {"label":"Blue Disco /25","ebay_kw":"Blue Disco"},
  {"label":"Tie-Dye /25","ebay_kw":"Tie-Dye"},
  {"label":"White Cracked Ice /25","ebay_kw":"White Cracked Ice"},
  {"label":"Tectonic FOTL /15","ebay_kw":"Tectonic"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black Finite 1/1","ebay_kw":"Black Finite"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2024;

-- ─── 2025: Placeholder (no Panini NBA license) ────────────────────────────────

-- Fanatics/Topps holds NBA license from 2025-26. No Panini Select Basketball.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball'
  AND year = 2025;
