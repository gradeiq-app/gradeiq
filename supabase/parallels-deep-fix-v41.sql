-- =============================================================================
-- parallels-deep-fix-v41.sql
-- One set corrected:
--
-- 1. Panini Mosaic Basketball
--    (brand='Panini', set_name='Mosaic', sport='basketball')
--    7 rows, DB years 2019-2025 (= 2019-20 through 2024-25 seasons + placeholder)
--
--    Panini Mosaic Basketball debuted 2019-20.
--    Panini's NBA license ended after 2024-25; DB year 2025 = placeholder.
--
--    The "Mosaic" pattern is the base pattern of this brand — all cards
--    feature a mosaic tile background. "Parallels" here are color/pattern
--    variations of that mosaic design.
--
--    NOTE: Choice box and Fast Break box parallels are included here since
--    no separate DB entries exist for "Mosaic Choice" or "Mosaic Fast Break"
--    basketball. FOTL (First Off The Line) Swirl parallels are also included.
--
-- Parallel era summary:
--   2019  Debut — 6 parallels (simple; Green + Reactive Blue + 3 Fluorescent)
--   2020  First expansion — ~30 parallels (Choice + FB sub-products added)
--   2021  NBA 75th Anniversary variants — ~19 parallels
--   2022  Wave + Glitter era — ~22 parallels
--   2023  International + multiple sub-products — ~42 parallels
--   2024  Final Panini NBA — ~48 parallels (Honeycomb + Snakeskin + Spectris)
--   2025  Placeholder (no Panini NBA product)
--
-- Sources: Cardboard Connection, Checklist Insider, Beckett
-- =============================================================================

-- ─── 2019: Debut year ────────────────────────────────────────────────────────

-- 2019-20 Panini Mosaic Basketball debut. Simple parallel structure.
-- Only 6 parallels documented: Base Mosaic, Green (retail), Reactive Blue /99,
-- Orange Fluorescent /25, Blue Fluorescent /15, Pink Fluorescent /10.
-- No Black 1/1 or Gold /10 in the debut release.
-- (Source: Cardboard Connection 2019-20 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Reactive Blue /99","ebay_kw":"Reactive Blue"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020: First major expansion ─────────────────────────────────────────────

-- 2020-21 Panini Mosaic Basketball. First full-product expansion.
-- Unnumbered: Base (Mosaic), Camo Pink, Genesis, Gold Wave, Green, Green Ice,
--   Red, Red Wave, Silver.
-- Numbered: Blue /99, Purple /49, Orange Fluorescent /25, White /25,
--   Blue Fluorescent /15, Green Fluorescent /10, Gold /10, Green Swirl FOTL /10,
--   Pink Fluorescent /10, Lucky Envelopes /8, Black 1/1.
-- Choice: Peacock (unnumbered SSP), Fusion Red & Yellow /88, Black Gold /8, Nebula 1/1.
-- Fast Break: Silver (unnumbered), Blue /85, Purple /50, Pink /20, Gold /10, Black 1/1.
-- (Source: Cardboard Connection 2020-21 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Gold Wave","ebay_kw":"Gold Wave"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Swirl /10","ebay_kw":"Green Swirl"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Peacock","ebay_kw":"Peacock"},
  {"label":"Choice Fusion Red Yellow /88","ebay_kw":"Fusion Red Yellow"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Fast Break Silver","ebay_kw":"Fast Break Silver"},
  {"label":"Fast Break Blue /85","ebay_kw":"Fast Break Blue"},
  {"label":"Fast Break Purple /50","ebay_kw":"Fast Break Purple"},
  {"label":"Fast Break Pink /20","ebay_kw":"Fast Break Pink"},
  {"label":"Fast Break Gold /10","ebay_kw":"Fast Break Gold"},
  {"label":"Fast Break Black 1/1","ebay_kw":"Fast Break Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021: NBA 75th Anniversary variants ─────────────────────────────────────

-- 2021-22 Panini Mosaic Basketball. 30 total parallels per Cardboard Connection.
-- New: Anniversary Edition (unnumbered), NBA 75th Anniversary (unnumbered),
--   White Sparkle (unnumbered Panini Rewards/promo).
-- Pink Swirl FOTL /11 = new FOTL exclusive (was Green Swirl /10 in 2020-21).
-- Orange Fluorescent /25 added back (was missing in 2020-21 main list).
-- (Source: Cardboard Connection + Beckett 2021-22 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Anniversary Edition","ebay_kw":"Anniversary"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Gold Wave","ebay_kw":"Gold Wave"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"NBA 75th","ebay_kw":"75th"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Pink Swirl /11","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Swirl /10","ebay_kw":"Green Swirl"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2021;

-- ─── 2022: Wave + Glitter + Reactive era ─────────────────────────────────────

-- 2022-23 Panini Mosaic Basketball. Wave patterns + Glitter added.
-- Unnumbered: Base, Blue Wave, Genesis, Glitter, Green, Green Ice,
--   Reactive Blue, Reactive Yellow, Red, Red Wave.
-- Numbered: Blue /199, Pink /149, Purple /99, Orange Fluorescent /25, White /25,
--   Pink Swirl FOTL /20, Gold /10, Gold Wave /10, Green Fluorescent /10,
--   Pink Fluorescent /10, Green Swirl FOTL /5, Black 1/1.
-- (Source: search-confirmed 2022-23 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Wave","ebay_kw":"Blue Wave"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Glitter","ebay_kw":"Glitter"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Pink /149","ebay_kw":"Pink"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Pink Swirl /20","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Green Swirl /5","ebay_kw":"Green Swirl"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2022;

-- ─── 2023: International + multi-sub-product era ─────────────────────────────

-- 2023-24 Panini Mosaic Basketball. ~42 parallels across all configurations.
-- New: Red Seismic /299, International sub-set parallels (Red /75, Blue /25,
--   Green /15, Gold /10), Teal /75, Ice /125, Gold Glitter /5, Green Swirl /3.
-- Choice: Peacock, Red & Green, Fusion Red/Yellow /75, Fusion Green /18,
--   Black Gold /8, Nebula 1/1.
-- Fast Break: Silver, Blue /85, Purple /50, Pink /20, Gold /10, Black 1/1.
-- Pink Swirl FOTL now /18 (was /20).
-- (Source: Beckett/search-confirmed 2023-24 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Choice Peacock","ebay_kw":"Peacock"},
  {"label":"Fast Break Silver","ebay_kw":"Fast Break Silver"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Glitter","ebay_kw":"Glitter"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"International","ebay_kw":"International"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Red Seismic /299","ebay_kw":"Red Seismic"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Pink /149","ebay_kw":"Pink"},
  {"label":"Ice /125","ebay_kw":"Ice"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Fast Break Blue /85","ebay_kw":"Fast Break Blue"},
  {"label":"Choice Fusion Red Yellow /75","ebay_kw":"Fusion Red Yellow"},
  {"label":"International Red /75","ebay_kw":"International Red"},
  {"label":"Teal /75","ebay_kw":"Teal"},
  {"label":"Fast Break Purple /50","ebay_kw":"Fast Break Purple"},
  {"label":"International Blue /25","ebay_kw":"International Blue"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Fast Break Pink /20","ebay_kw":"Fast Break Pink"},
  {"label":"Choice Fusion Green /18","ebay_kw":"Fusion Green"},
  {"label":"Pink Swirl /18","ebay_kw":"Pink Swirl"},
  {"label":"International Green /15","ebay_kw":"International Green"},
  {"label":"Fast Break Gold /10","ebay_kw":"Fast Break Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold International /10","ebay_kw":"Gold International"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Gold Glitter /5","ebay_kw":"Gold Glitter"},
  {"label":"Green Swirl /3","ebay_kw":"Green Swirl"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Fast Break Black 1/1","ebay_kw":"Fast Break Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2023;

-- ─── 2024: Final Panini NBA — Honeycomb + Snakeskin + Spectris ───────────────

-- 2024-25 Panini Mosaic Basketball. ~48 parallels. Final Panini NBA release.
-- New: Honeycomb (unnumbered), Year of the Snake (unnumbered),
--   Purple Fluorescent /249, Pink /175, Blue Seismic /149, Orange Ice /49,
--   Spectris Blue FOTL /25, Purple Snakeskin /24, Tessellation /15,
--   Spectris Gold FOTL /10, Gold Snakeskin /8, Spectris Green FOTL /5,
--   Fast Break Gold Black /3, International Black 1/1, Spectris Gold Vinyl FOTL 1/1.
-- (Source: Checklist Insider 2024-25 Mosaic Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Choice Peacock","ebay_kw":"Peacock"},
  {"label":"Fast Break Silver","ebay_kw":"Fast Break Silver"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Glitter","ebay_kw":"Glitter"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Green Ice","ebay_kw":"Green Ice"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"International","ebay_kw":"International"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Year of the Snake","ebay_kw":"Year of the Snake"},
  {"label":"Red Seismic /299","ebay_kw":"Red Seismic"},
  {"label":"Orange /249","ebay_kw":"Orange"},
  {"label":"Purple Fluorescent /249","ebay_kw":"Purple Fluorescent"},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Pink /175","ebay_kw":"Pink"},
  {"label":"Blue Seismic /149","ebay_kw":"Blue Seismic"},
  {"label":"Ice /125","ebay_kw":"Ice"},
  {"label":"Fast Break Red /99","ebay_kw":"Fast Break Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Fast Break Blue /85","ebay_kw":"Fast Break Blue"},
  {"label":"Blue Fluorescent /75","ebay_kw":"Blue Fluorescent"},
  {"label":"Bronze /75","ebay_kw":"Bronze"},
  {"label":"Choice Fusion Red Yellow /75","ebay_kw":"Fusion Red Yellow"},
  {"label":"International Red /75","ebay_kw":"International Red"},
  {"label":"Fast Break Purple /50","ebay_kw":"Fast Break Purple"},
  {"label":"Orange Ice /49","ebay_kw":"Orange Ice"},
  {"label":"Choice Blue /45","ebay_kw":"Choice Blue"},
  {"label":"Choice White /35","ebay_kw":"Choice White"},
  {"label":"Fast Break Blue Camo /35","ebay_kw":"Fast Break Blue Camo"},
  {"label":"International White /25","ebay_kw":"International White"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"Spectris Blue /25","ebay_kw":"Spectris Blue"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Purple Snakeskin /24","ebay_kw":"Purple Snakeskin"},
  {"label":"Choice Cherry Blossom /20","ebay_kw":"Cherry Blossom"},
  {"label":"Fast Break Pink /20","ebay_kw":"Fast Break Pink"},
  {"label":"International Green /15","ebay_kw":"International Green"},
  {"label":"Tessellation /15","ebay_kw":"Tessellation"},
  {"label":"Fast Break Gold /10","ebay_kw":"Fast Break Gold"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold International /10","ebay_kw":"Gold International"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Spectris Gold /10","ebay_kw":"Spectris Gold"},
  {"label":"Lucky Envelopes /8","ebay_kw":"Lucky Envelope"},
  {"label":"Choice Black Gold /8","ebay_kw":"Choice Black Gold"},
  {"label":"Gold Snakeskin /8","ebay_kw":"Gold Snakeskin"},
  {"label":"Fast Break Neon Green /5","ebay_kw":"Fast Break Neon Green"},
  {"label":"Gold Glitter /5","ebay_kw":"Gold Glitter"},
  {"label":"Spectris Green /5","ebay_kw":"Spectris Green"},
  {"label":"Fast Break Gold Black /3","ebay_kw":"Fast Break Gold Black"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Choice Nebula 1/1","ebay_kw":"Choice Nebula"},
  {"label":"Fast Break Black 1/1","ebay_kw":"Fast Break Black"},
  {"label":"International Black 1/1","ebay_kw":"International Black"},
  {"label":"Spectris Gold Vinyl 1/1","ebay_kw":"Spectris Gold Vinyl"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2024;

-- ─── 2025: Placeholder (no Panini NBA product) ───────────────────────────────

-- 2025-26 season: Fanatics/Topps holds exclusive NBA license.
-- No Panini Mosaic Basketball for 2025-26. Placeholder row.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball'
  AND year = 2025;
