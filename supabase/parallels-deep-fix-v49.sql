-- =============================================================================
-- parallels-deep-fix-v49.sql
-- One set corrected:
--
-- 1. Panini Donruss Optic Basketball
--    (brand='Panini', set_name='Donruss Optic', sport='basketball')
--    10 rows — DB years 2016-2025
--
-- Season start year convention:
--   DB 2016 = 2016-17, DB 2017 = 2017-18, ... DB 2024 = 2024-25 (last Panini NBA)
--   DB 2025 = 2025-26 — no product (Fanatics/Topps took over NBA license)
--
-- Parallel eras:
--   - 2016-17:  Debut. Checkerboard/Holo/Purple unnumb; 7-tier numbered ladder
--   - 2017-18:  Lime Green /175 + Black Velocity /39 + Purple Stars FOTL /13 added
--   - 2018-19:  Major expansion; Pink Velocity /79; Blue Velocity; Choice sub-product
--   - 2019-20:  Purple Shock; Lucky Envelopes /8; Blue /59 (from /49)
--   - 2020-21:  Photon (Hobby SSP) introduced; same core ladder
--   - 2021-22:  Pulsar/Wave unnumb retail variants; Gold Pulsar /10
--   - 2022-23:  Sparkle/Glitter numbered parallels explosion; Blue Sparkle /180;
--                Two Tone /15; 32 entries
--   - 2023-24:  Choice + Fast Break sub-format parallels counted in rainbow;
--                International sub-set; over 50 entries
--   - 2024-25:  Final Panini NBA season. Massive 60+ parallel rainbow;
--                Shimmer/Velocity/Seismic texture variants; FOTL/Black 1/1 expansions
--   - 2025-26:  Placeholder (Panini NBA license expired)
--
-- Sources: Cardboard Connection, Checklist Insider, Beckett
-- =============================================================================

-- ─── 2016-17: Debut — Checkerboard/Holo/Purple + 7-tier ladder ───────────────

-- 2016-17 Donruss Optic Basketball (debut).
-- 4 unnumbered variants. Numbered ladder: Orange /199, Red /99, Blue /49,
-- Aqua /25, Pink /25, Gold /10, Green /5. Black 1/1 + Gold Vinyl 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Aqua /25","ebay_kw":"Aqua"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2016;

-- ─── 2017-18: Lime Green /175; Black Velocity /39; Purple Stars FOTL /13 ──────

-- 2017-18 Donruss Optic Basketball.
-- Lime Green /175 added (between Orange /199 and Red /99).
-- Black Velocity /39 added. Purple Stars FOTL /13 (new ultra-short FOTL tier).
-- Blue stays /49. White Sparkle continues.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /175","ebay_kw":"Lime Green"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Aqua /25","ebay_kw":"Aqua"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Purple Stars FOTL /13","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2017;

-- ─── 2018-19: Pink Velocity /79; multi-format exclusives; Choice sub-product ──

-- 2018-19 Donruss Optic Basketball.
-- Pink Velocity /79 added. Blue Velocity (unnumb, multi-pack/retail).
-- Lime Green now /149 (from /175). Blue stays /49. Black Velocity /39.
-- Choice sub-product adds Dragon (unnumb), Red /88, Black Gold /8, Nebula 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Velocity","ebay_kw":"Blue Velocity"},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Shock","ebay_kw":"Shock"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Purple Stars FOTL /13","ebay_kw":"Purple Stars"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Choice Dragon","ebay_kw":"Choice Dragon"},
  {"label":"Choice Red /88","ebay_kw":"Choice Red"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2018;

-- ─── 2019-20: Purple Shock; Lucky Envelopes /8; Blue /59; FOTL /29 ────────────

-- 2019-20 Donruss Optic Basketball.
-- Purple Shock (unnumb) added. Blue changed to /59 (from /49). Aqua removed.
-- Purple Stars FOTL bumped to /29. Lucky Envelopes /8 (hobby insert rate).
-- No Choice sub-product this year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Purple Shock","ebay_kw":"Purple Shock"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Blue /59","ebay_kw":"Blue"},
  {"label":"Purple Stars FOTL /29","ebay_kw":"Purple Stars"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020-21: Photon SSP (Hobby); Purple Stars FOTL /13; same core ladder ─────

-- 2020-21 Donruss Optic Basketball.
-- Photon (Hobby-only super short print, unnumb) introduced.
-- Purple Stars FOTL back to /13. Otherwise same ladder as 2019-20.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Photon","ebay_kw":"Photon"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Purple Shock","ebay_kw":"Purple Shock"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Blue /59","ebay_kw":"Blue"},
  {"label":"Purple Stars FOTL /13","ebay_kw":"Purple Stars"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021-22: Pulsar + Wave unnumb retail variants; Gold Pulsar /10 ────────────

-- 2021-22 Donruss Optic Basketball.
-- Major retail parallel expansion: Blue Pulsar, Blue Velocity, Gold Wave,
--   Green Shock, Red Pulsar, Red Wave (all unnumb). Gold Pulsar /10 added.
-- Pink Velocity /79 returns. Black Velocity /39 continues.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Pulsar","ebay_kw":"Blue Pulsar"},
  {"label":"Blue Velocity","ebay_kw":"Blue Velocity"},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Gold Wave","ebay_kw":"Gold Wave"},
  {"label":"Green Shock","ebay_kw":"Green Shock"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Photon","ebay_kw":"Photon"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Red Pulsar","ebay_kw":"Red Pulsar"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Blue /59","ebay_kw":"Blue"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Purple Stars FOTL /13","ebay_kw":"Purple Stars"},
  {"label":"Gold Pulsar /10","ebay_kw":"Gold Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2021;

-- ─── 2022-23: Sparkle/Glitter numbered explosion; Blue Sparkle /180 ────────────

-- 2022-23 Donruss Optic Basketball.
-- New unnumbered: Basketball, Hyper Green, Red Sparkle.
-- New numbered: Blue Sparkle /180, Copper Glitter /99, Red & Gold Wave /99,
--   Gold Sparkle /24, Purple Stars FOTL /17, Two Tone /15, Gold Wave /10,
--   Green Sparkle /8. Blue now /49 (from /59).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Basketball","ebay_kw":"Basketball"},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Green Shock","ebay_kw":"Green Shock"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Green","ebay_kw":"Hyper Green"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Photon","ebay_kw":"Photon"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Purple Shock","ebay_kw":"Purple Shock"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue Sparkle /180","ebay_kw":"Blue Sparkle"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Copper Glitter /99","ebay_kw":"Copper Glitter"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Red & Gold Wave /99","ebay_kw":"Red Gold Wave"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Purple Stars FOTL /17","ebay_kw":"Purple Stars"},
  {"label":"Two Tone /15","ebay_kw":"Two Tone"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2022;

-- ─── 2023-24: International sub-set; Fast Break; Choice; 50+ parallel rainbow ─

-- 2023-24 Donruss Optic Basketball.
-- Choice + Fast Break sub-product parallels counted in rainbow.
-- International parallels (Red International unnumb; Red & Gold International /99;
--   Green International /65; Gold International /10).
-- New: Jazz (unnumb), Red Velocity /299, Aqua /249, Flex/Seismic textures,
--   Shield-style patterns, Blue Glitter /15, multiple Fast Break tiers.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Velocity","ebay_kw":"Blue Velocity"},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Choice Dragon","ebay_kw":"Choice Dragon"},
  {"label":"Choice Red & Green","ebay_kw":"Choice Red Green"},
  {"label":"Fast Break Holo","ebay_kw":"Fast Break Holo"},
  {"label":"Green Shock","ebay_kw":"Green Shock"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Green","ebay_kw":"Hyper Green"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"Photon","ebay_kw":"Photon"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Purple Shock","ebay_kw":"Purple Shock"},
  {"label":"Red International","ebay_kw":"Red International"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red Velocity /299","ebay_kw":"Red Velocity"},
  {"label":"Aqua /249","ebay_kw":"Aqua"},
  {"label":"Blue Seismic /249","ebay_kw":"Blue Seismic"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red Seismic /130","ebay_kw":"Red Seismic"},
  {"label":"Copper Glitter /99","ebay_kw":"Copper Glitter"},
  {"label":"Fast Break Purple /99","ebay_kw":"Fast Break Purple"},
  {"label":"Hyper Orange /99","ebay_kw":"Hyper Orange"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Red & Gold International /99","ebay_kw":"Red Gold International"},
  {"label":"Choice Red /88","ebay_kw":"Choice Red"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Green Glitter /77","ebay_kw":"Green Glitter"},
  {"label":"Fast Break Red /75","ebay_kw":"Fast Break Red"},
  {"label":"Red Glitter /75","ebay_kw":"Red Glitter"},
  {"label":"Green International /65","ebay_kw":"Green International"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Fast Break Blue /49","ebay_kw":"Fast Break Blue"},
  {"label":"Green Velocity /49","ebay_kw":"Green Velocity"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Fast Break Pink /25","ebay_kw":"Fast Break Pink"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Choice Blue Mojo /24","ebay_kw":"Choice Blue Mojo"},
  {"label":"Purple Stars FOTL /17","ebay_kw":"Purple Stars"},
  {"label":"Blue Glitter /15","ebay_kw":"Blue Glitter"},
  {"label":"Fast Break Gold /10","ebay_kw":"Fast Break Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold International /10","ebay_kw":"Gold International"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Fast Break Red & Yellow /7","ebay_kw":"Fast Break Red Yellow"},
  {"label":"Fast Break Neon Green /5","ebay_kw":"Fast Break Neon Green"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Fast Break Black 1/1","ebay_kw":"Fast Break Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2023;

-- ─── 2024-25: Final Panini NBA year; 60+ parallel mega-rainbow ───────────────

-- 2024-25 Donruss Optic Basketball (final Panini NBA season).
-- Massive parallel expansion: Shimmer/Velocity/Seismic texture families,
-- FOTL-exclusive tiers (Green FOTL /14, Black FOTL /3), International sub-set,
-- Choice + Fast Break sub-product parallels, Bronze Velocity /125.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Velocity","ebay_kw":"Blue Velocity"},
  {"label":"Checkerboard","ebay_kw":"Checkerboard"},
  {"label":"Choice Dragon","ebay_kw":"Choice Dragon"},
  {"label":"Fast Break Holo","ebay_kw":"Fast Break Holo"},
  {"label":"Green Seismic","ebay_kw":"Green Seismic"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Hyper Pink","ebay_kw":"Hyper Pink"},
  {"label":"Jazz","ebay_kw":"Jazz"},
  {"label":"Photon","ebay_kw":"Photon"},
  {"label":"Purple","ebay_kw":"Purple"},
  {"label":"Purple Shimmer","ebay_kw":"Purple Shimmer"},
  {"label":"Purple Shock","ebay_kw":"Purple Shock"},
  {"label":"Red International","ebay_kw":"Red International"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"Red Stars International","ebay_kw":"Red Stars International"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Hyper Orange /299","ebay_kw":"Hyper Orange"},
  {"label":"Red Velocity /299","ebay_kw":"Red Velocity"},
  {"label":"Pink Glitter /275","ebay_kw":"Pink Glitter"},
  {"label":"Hyper Green /249","ebay_kw":"Hyper Green"},
  {"label":"Aqua /225","ebay_kw":"Aqua"},
  {"label":"Orange Shock /225","ebay_kw":"Orange Shock"},
  {"label":"Blue Sparkle /180","ebay_kw":"Blue Sparkle"},
  {"label":"Hyper Blue /175","ebay_kw":"Hyper Blue"},
  {"label":"Orange /175","ebay_kw":"Orange"},
  {"label":"Green Shock /149","ebay_kw":"Green Shock"},
  {"label":"Lime Green /149","ebay_kw":"Lime Green"},
  {"label":"Red Seismic /149","ebay_kw":"Red Seismic"},
  {"label":"Bronze Velocity /125","ebay_kw":"Bronze Velocity"},
  {"label":"Copper Glitter /99","ebay_kw":"Copper Glitter"},
  {"label":"Fast Break Purple /99","ebay_kw":"Fast Break Purple"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Red & Gold International /99","ebay_kw":"Red Gold International"},
  {"label":"Choice Red /88","ebay_kw":"Choice Red"},
  {"label":"Pink Velocity /79","ebay_kw":"Pink Velocity"},
  {"label":"Blue Shimmer /75","ebay_kw":"Blue Shimmer"},
  {"label":"Electricity International /75","ebay_kw":"Electricity International"},
  {"label":"Fast Break Red /75","ebay_kw":"Fast Break Red"},
  {"label":"Red Glitter /75","ebay_kw":"Red Glitter"},
  {"label":"White Velocity /59","ebay_kw":"White Velocity"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Fast Break Blue /49","ebay_kw":"Fast Break Blue"},
  {"label":"Green Velocity /49","ebay_kw":"Green Velocity"},
  {"label":"Choice White /48","ebay_kw":"Choice White"},
  {"label":"Black Velocity /39","ebay_kw":"Black Velocity"},
  {"label":"Cracked Ice /25","ebay_kw":"Cracked Ice"},
  {"label":"Fast Break Pink /25","ebay_kw":"Fast Break Pink"},
  {"label":"Green International /25","ebay_kw":"Green International"},
  {"label":"Pink /25","ebay_kw":"Pink"},
  {"label":"Choice Blue /24","ebay_kw":"Choice Blue"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Black Pandora /15","ebay_kw":"Black Pandora"},
  {"label":"Blue Glitter /15","ebay_kw":"Blue Glitter"},
  {"label":"White International /15","ebay_kw":"White International"},
  {"label":"Green FOTL /14","ebay_kw":"Green FOTL"},
  {"label":"Purple Velocity /12","ebay_kw":"Purple Velocity"},
  {"label":"Fast Break Gold /10","ebay_kw":"Fast Break Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold International /10","ebay_kw":"Gold International"},
  {"label":"Gold Velocity /10","ebay_kw":"Gold Velocity"},
  {"label":"Black Gold Velocity /8","ebay_kw":"Black Gold Velocity"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelopes"},
  {"label":"Fast Break Red & Yellow /7","ebay_kw":"Fast Break Red Yellow"},
  {"label":"Fast Break Neon Green /5","ebay_kw":"Fast Break Neon Green"},
  {"label":"Green /5","ebay_kw":"Green"},
  {"label":"Green Glitter /5","ebay_kw":"Green Glitter"},
  {"label":"Black FOTL /3","ebay_kw":"Black FOTL"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Fast Break Black 1/1","ebay_kw":"Fast Break Black"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2024;

-- ─── 2025-26: Placeholder (Panini NBA license expired) ───────────────────────

-- No 2025-26 Panini Donruss Optic Basketball product exists.
-- Fanatics/Topps reclaimed the NBA license starting with the 2025-26 season.
UPDATE card_sets SET parallels = '[{"label":"Base","ebay_kw":""}]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball'
  AND year = 2025;
