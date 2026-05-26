-- =============================================================================
-- parallels-deep-fix-v48.sql
-- One set corrected:
--
-- 1. Panini Donruss Optic Football
--    (brand='Panini', set_name='Donruss Optic', sport='football')
--    10 rows — DB years 2016-2025
--
-- Donruss Optic Football uses Panini Optichrome technology (refractor-style)
-- on the classic Donruss card design including "Rated Rookie" cards.
--
-- Parallel eras:
--   - 2016:      Debut — Holo (unnumb) + 9-tier numbered ladder (Aqua /299…
--                Carolina Blue /50…Gold Vinyl 1/1); 10 parallels + Base
--   - 2017:      White Sparkle added; Carolina Blue → Purple /50; Black /25
--   - 2018:      Dual /25 tier: Purple Stars FOTL /25 + Black Velocity /25
--   - 2019:      Orange Scope /79 added; Black Pandora /25 + Purple Stars /25
--   - 2020:      Explosion — Wave /199, Silver Circles /125, Pink Velocity /79,
--                Lime Green /35; 3 unnumb retail variants (Holo/RedStars/Sparkle)
--   - 2021:      8 unnumbered retail variants; Ice /15 + Purple Stars /15 added
--   - 2022:      Jazz replaces Freedom; Electricity /65 added; 8 unnumb
--   - 2023:      Bronze Mojo (unnumb) + /35; Flex /149; Shield /32; Lime Green /20;
--                30 total parallels + Base
--   - 2024:      Creative pattern parallels (Team Logo /32, Dragon /24, Footballs /16);
--                Blue Mojo /5; Nebula 1/1; 33 total parallels + Base
--   - 2025:      Final Panini NFL year. Streamlined numbered ladder; Neon Blue /399;
--                Gold Vinyl + Nebula 1/1 as 1/1 SSPs
--
-- Sources: Cardboard Connection, Checklist Insider, Beckett
-- =============================================================================

-- ─── 2016: Debut — Holo + 9-tier numbered ladder ─────────────────────────────

-- 2016 Donruss Optic Football (debut).
-- Holo (unnumbered) hobby parallel.
-- Numbered ladder: Aqua /299, Orange /199, Blue /149, Red /99, Carolina Blue /50,
--   Black /25, Gold /10, Green /5, Gold Vinyl 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /149","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Carolina Blue /50","ebay_kw":"Carolina Blue"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2016;

-- ─── 2017: White Sparkle added; Carolina Blue → Purple /50 ───────────────────

-- 2017 Donruss Optic Football.
-- White Sparkle (unnumbered retail) added. Carolina Blue /50 replaced by Purple /50.
-- Black /25 continues. New: Bronze (unnumbered, Rated Rookies), Pink (Blaster),
--   Lime (Hanger) — but base-set tier identical to listed parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /149","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2017;

-- ─── 2018: Dual /25 tier — Purple Stars FOTL + Black Velocity ─────────────────

-- 2018 Donruss Optic Football.
-- Two separate /25 parallels: Purple Stars (FOTL exclusive) and Black Velocity
-- (regular hobby). Same unnumbered (Holo, White Sparkle) and upper ladder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /149","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Purple Stars FOTL /25","ebay_kw":"Purple Stars"},
  {"label":"Black Velocity /25","ebay_kw":"Black Velocity"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2018;

-- ─── 2019: Orange Scope /79; Black Pandora /25; Purple Stars /25 ─────────────

-- 2019 Donruss Optic Football.
-- Blue changed to /150 (from /149). Orange Scope /79 new premium tier.
-- Black Pandora /25 replaces plain Black. Purple Stars FOTL /25 continues.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /150","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Orange Scope /79","ebay_kw":"Orange Scope"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Purple Stars FOTL /25","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2019;

-- ─── 2020: Parallel explosion — Wave, Silver Circles, Pink Velocity, Lime Green

-- 2020 Donruss Optic Football.
-- Major expansion. 3 unnumbered retail variants: Holo, Red Stars, White Sparkle.
-- Wave /199 and Blue /179 (new mid-tier). Silver Circles /125 new.
-- Pink Velocity /79 new. Lime Green /35 new. Black → Black Pandora /25.
-- Black 1/1 added (separate from Gold Vinyl 1/1 — both are 1/1 now).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Wave /199","ebay_kw":"Wave"},
  {"label":"Blue /179","ebay_kw":"Blue"},
  {"label":"Silver Circles /125","ebay_kw":"Silver Circles"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Orange Scope /79","ebay_kw":"Orange Scope"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Lime Green /35","ebay_kw":"Lime Green"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Purple Stars /25","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2020;

-- ─── 2021: 8 unnumbered variants; Ice /15 + Purple Stars /15 added ────────────

-- 2021 Donruss Optic Football.
-- 8 unnumbered retail variants: Fire, Freedom, Holo, One Hundred, Red Stars,
--   Rocket, Stars, White Sparkle. Ice /15 and Purple Stars /15 added as
--   new ultra-short hobby tiers. Same numbered mid-ladder as 2020.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Fire","ebay_kw":"Fire"},
  {"label":"Freedom","ebay_kw":"Freedom"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"One Hundred","ebay_kw":"One Hundred"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"Rocket","ebay_kw":"Rocket"},
  {"label":"Stars","ebay_kw":"Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /179","ebay_kw":"Blue"},
  {"label":"Silver Circles /125","ebay_kw":"Silver Circles"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Orange Scope /79","ebay_kw":"Orange Scope"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Lime Green /35","ebay_kw":"Lime Green"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Ice /15","ebay_kw":"Ice"},
  {"label":"Purple Stars /15","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2021;

-- ─── 2022: Jazz replaces Freedom; Electricity /65 added ──────────────────────

-- 2022 Donruss Optic Football.
-- Jazz (unnumb) replaces Freedom. Electricity /65 new mid-tier (between Red /99
--   and Pink Velocity /79). Purple Stars FOTL /15 (was Purple Stars /15 in 2021).
-- Otherwise same 8 unnumbered + expanded numbered ladder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Fire","ebay_kw":"Fire"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"One Hundred","ebay_kw":"One Hundred"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"Rocket","ebay_kw":"Rocket"},
  {"label":"Stars","ebay_kw":"Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /179","ebay_kw":"Blue"},
  {"label":"Silver Circles /125","ebay_kw":"Silver Circles"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Electricity /65","ebay_kw":"Electricity"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Lime Green /35","ebay_kw":"Lime Green"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Ice /15","ebay_kw":"Ice"},
  {"label":"Purple Stars FOTL /15","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2022;

-- ─── 2023: Bronze Mojo unnumb + /35; Flex /149; Shield /32; Lime Green /20 ────

-- 2023 Donruss Optic Football.
-- Bronze Mojo added in two versions: unnumbered (H2 exclusive) and /35 (hobby).
-- New: Flex /149, Shield /32, Lime Green /20. Freedom returns alongside Jazz.
-- Electricity updated to /69. Wave /300 added at high end.
-- Aqua stays /299; Orange drops to /249 (from /299); Blue /199 (from /179).
-- 30 parallels + Base = 31 entries.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Bronze Mojo","ebay_kw":"Bronze Mojo"},
  {"label":"Fire","ebay_kw":"Fire"},
  {"label":"Freedom","ebay_kw":"Freedom"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"One Hundred","ebay_kw":"One Hundred"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"Rocket","ebay_kw":"Rocket"},
  {"label":"Stars","ebay_kw":"Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Wave /300","ebay_kw":"Wave"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Flex /149","ebay_kw":"Flex"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Orange Scope /79","ebay_kw":"Orange Scope"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Electricity /69","ebay_kw":"Electricity"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Bronze Mojo /35","ebay_kw":"Bronze Mojo"},
  {"label":"Shield /32","ebay_kw":"Shield"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Lime Green /20","ebay_kw":"Lime Green"},
  {"label":"Ice /15","ebay_kw":"Ice"},
  {"label":"Purple Stars /15","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2023;

-- ─── 2024: Pattern parallels; Blue Mojo /5; Nebula 1/1 ───────────────────────

-- 2024 Panini Donruss Optic Football.
-- Creative pattern parallels new: Team Logo /32, Dragon /24, Footballs /16.
-- Red drops to /125; Pink Velocity /80; Electricity /75; Purple /60; Lime Green /50.
-- Blue Mojo /5 (H2 exclusive). Nebula 1/1 added alongside Gold Vinyl 1/1.
-- 33 parallels + Base = 34 entries.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Fire","ebay_kw":"Fire"},
  {"label":"Freedom","ebay_kw":"Freedom"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"One Hundred","ebay_kw":"One Hundred"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"Rocket","ebay_kw":"Rocket"},
  {"label":"Stars","ebay_kw":"Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Wave /300","ebay_kw":"Wave"},
  {"label":"Aqua /299","ebay_kw":"Aqua"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Flex /149","ebay_kw":"Flex"},
  {"label":"Red /125","ebay_kw":"Red"},
  {"label":"Pink Velocity /80","ebay_kw":"Pink Velocity"},
  {"label":"Orange Scope /79","ebay_kw":"Orange Scope"},
  {"label":"Electricity /75","ebay_kw":"Electricity"},
  {"label":"Purple /60","ebay_kw":"Purple"},
  {"label":"Lime Green /50","ebay_kw":"Lime Green"},
  {"label":"Team Logo /32","ebay_kw":"Team Logo"},
  {"label":"Black Pandora /25","ebay_kw":"Black Pandora"},
  {"label":"Dragon /24","ebay_kw":"Dragon"},
  {"label":"Footballs /16","ebay_kw":"Footballs"},
  {"label":"Ice /15","ebay_kw":"Ice"},
  {"label":"Purple Stars /15","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Blue Mojo /5","ebay_kw":"Blue Mojo"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2024;

-- ─── 2025: Final Panini NFL year; streamlined ladder; Neon Blue /399 ──────────

-- 2025 Donruss Optic Football (final Panini NFL licensed year).
-- Back to cleaner structure: 9 unnumbered retail variants.
-- New: Neon Blue /399 as high-volume entry numbered tier.
-- Aqua /349, Wave /300, Orange /299, Blue /249, Flex /199, Red /149, Purple /60.
-- Gold /10, Black 1/1. 1/1 SSPs: Gold Vinyl + Nebula. No Green /5.
-- 22 parallels + Base = 23 entries.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Fire","ebay_kw":"Fire"},
  {"label":"Freedom","ebay_kw":"Freedom"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"One Hundred","ebay_kw":"One Hundred"},
  {"label":"Red Stars","ebay_kw":"Red Stars"},
  {"label":"Rocket","ebay_kw":"Rocket"},
  {"label":"Stars","ebay_kw":"Stars"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Neon Blue /399","ebay_kw":"Neon Blue"},
  {"label":"Aqua /349","ebay_kw":"Aqua"},
  {"label":"Wave /300","ebay_kw":"Wave"},
  {"label":"Orange /299","ebay_kw":"Orange"},
  {"label":"Blue /249","ebay_kw":"Blue"},
  {"label":"Flex /199","ebay_kw":"Flex"},
  {"label":"Red /149","ebay_kw":"Red"},
  {"label":"Purple /60","ebay_kw":"Purple"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football'
  AND year = 2025;
