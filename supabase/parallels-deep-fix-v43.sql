-- =============================================================================
-- parallels-deep-fix-v43.sql
-- One set corrected:
--
-- 1. Upper Deck O-Pee-Chee Platinum Hockey
--    (brand='Upper Deck', set_name='O-Pee-Chee Platinum', sport='hockey')
--    16 rows — DB years 2010-2025
--
--    OPC Platinum debuted in 2014-15 season. DB years 2010-2013 are placeholders.
--    Actual product years: 2014 (2014-15) through 2025 (2025-26).
--
-- Key parallel eras:
--   - 2014:   Debut — Rainbow + Black /100 + Red unnumbered (3 parallels, simple)
--   - 2015:   Full launch — 11 parallels incl. White Ice /199, Printing Plates /4
--   - 2016:   Ice Blue Traxx replaces Traxx; Orange Rainbow /25 (hobby)
--   - 2017:   Violet Pixels (unnumbered) replaces Traxx; Orange Checkers /25 debut
--   - 2018:   Arctic Freeze /79 replaces Royal Blue Cubes /99
--   - 2019:   Sunset + Matte Pink introduced (unnumbered); Violet Pixels → /399
--   - 2020:   Rainbow returns; Aquamarine /499 + Yellow Traxx /249 + Cosmic /65 added
--   - 2021:   Retail exclusives (Blue/Neon Yellow/Red Surge); Hot Magma /499
--   - 2022:   Unnumbered Cosmic; Liquid Metal /349 added; print runs tightened
--   - 2023:   Blue Fragment /125 + Bioluminescence /5 added; Cosmic → /65 numbered
--   - 2024:   Pink Magma replaces Matte Pink; Liquid Metal dropped
--   - 2025:   Turquoise Fragments /249 replaces Blue Fragments
--
-- Sources: Cardboard Connection, Beckett, Upper Deck e-Pack checklists,
--          PSA Set Registry, TCDB
-- =============================================================================

-- ─── 2010-2013: Placeholder (OPC Platinum did not exist) ─────────────────────

-- OPC Platinum debuted 2014-15. DB years 2010-2013 carry uniform-template data.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year BETWEEN 2010 AND 2013;

-- ─── 2014: Debut year — simple 3-parallel structure ──────────────────────────

-- 2014-15 O-Pee-Chee Platinum Hockey. Debut year.
-- Simple structure: Rainbow (1:20 packs, unnumbered), Black /100,
-- Red (1:160 packs, unnumbered). No Seismic Gold or Emerald Surge yet.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Black /100","ebay_kw":"Black"},
  {"label":"Red","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2014;

-- ─── 2015: Full parallel launch ───────────────────────────────────────────────

-- 2015-16 O-Pee-Chee Platinum Hockey.
-- Major expansion over debut: 11 named parallels.
-- Unnumbered: Rainbow, Traxx (pattern parallel).
-- Numbered: White Ice /199, Red Prism /149, Black Ice /99, Blue Cubes /75,
--   Seismic Gold /50, Purple /25, Emerald Surge /10, Printing Plates /4,
--   Golden Treasures 1/1.
-- NOTE: Veteran print runs used; rookies had tighter print runs on some tiers.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Traxx","ebay_kw":"Traxx"},
  {"label":"White Ice /199","ebay_kw":"White Ice"},
  {"label":"Red Prism /149","ebay_kw":"Red Prism"},
  {"label":"Black Ice /99","ebay_kw":"Black Ice"},
  {"label":"Blue Cubes /75","ebay_kw":"Blue Cubes"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Printing Plates /4","ebay_kw":"Printing Plates"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2015;

-- ─── 2016: Ice Blue Traxx + Orange Rainbow /25 hobby ─────────────────────────

-- 2016-17 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Rainbow, Ice Blue Traxx.
-- Numbered: Red Prism /199, Royal Blue Cubes /99, Seismic Gold /50,
--   Orange Rainbow /25 (hobby exclusive), Emerald Surge /10, Golden Treasures 1/1.
-- White Ice and Black Ice dropped; Blue Cubes → Royal Blue Cubes /99.
-- Purple /25 dropped; Orange Rainbow /25 fills that slot.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Ice Blue Traxx","ebay_kw":"Ice Blue Traxx"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Royal Blue Cubes /99","ebay_kw":"Royal Blue Cubes"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Rainbow /25","ebay_kw":"Orange Rainbow"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2016;

-- ─── 2017: Violet Pixels replaces Traxx; Orange Checkers /25 ─────────────────

-- 2017-18 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Rainbow, Violet Pixels (replaces Ice Blue Traxx).
-- Numbered: Red Prism /199, Royal Blue Cubes /99, Seismic Gold /50,
--   Orange Checkers /25 (hobby; replaces Orange Rainbow), Emerald Surge /10,
--   Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Violet Pixels","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Royal Blue Cubes /99","ebay_kw":"Royal Blue Cubes"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2017;

-- ─── 2018: Arctic Freeze /79 replaces Royal Blue Cubes ───────────────────────

-- 2018-19 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Rainbow, Violet Pixels.
-- Numbered: Red Prism /199, Arctic Freeze /79 (new; replaces Royal Blue Cubes /99),
--   Seismic Gold /50, Orange Checkers /25, Emerald Surge /10, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Violet Pixels","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Arctic Freeze /79","ebay_kw":"Arctic Freeze"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2018;

-- ─── 2019: Sunset + Matte Pink; Violet Pixels → /399 ─────────────────────────

-- 2019-20 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Sunset (1:10 packs), Matte Pink (1:20 packs). Rainbow dropped.
-- Violet Pixels now serial-numbered to /399 (was unnumbered in 2017-18).
-- Arctic Freeze back to /99 (from /79 in 2018).
-- Numbered: Violet Pixels /399, Red Prism /199, Arctic Freeze /99,
--   Seismic Gold /50, Orange Checkers /25, Emerald Surge /10, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Matte Pink","ebay_kw":"Matte Pink"},
  {"label":"Violet Pixels /399","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2019;

-- ─── 2020: Rainbow returns; Aquamarine /499 + Yellow Traxx /249 + Cosmic /65 ──

-- 2020-21 O-Pee-Chee Platinum Hockey (COVID-abbreviated 56-game season).
-- Unnumbered: Rainbow, Sunset, Matte Pink.
-- New numbered tiers: Aquamarine /499, Yellow Traxx /249, Cosmic /65.
-- Violet Pixels now /299 (down from /399).
-- Numbered: Aquamarine /499, Yellow Traxx /249, Violet Pixels /299,
--   Red Prism /199, Arctic Freeze /99, Cosmic /65, Seismic Gold /50,
--   Orange Checkers /25, Emerald Surge /10, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Matte Pink","ebay_kw":"Matte Pink"},
  {"label":"Aquamarine /499","ebay_kw":"Aquamarine"},
  {"label":"Yellow Traxx /249","ebay_kw":"Yellow Traxx"},
  {"label":"Violet Pixels /299","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Cosmic /65","ebay_kw":"Cosmic"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2020;

-- ─── 2021: Retail exclusives (Blue/Neon Yellow/Red Surge); Hot Magma /499 ─────

-- 2021-22 O-Pee-Chee Platinum Hockey.
-- Retail exclusives: Blue Surge (Walmart), Neon Yellow Surge (Mass Retail),
--   Red Surge (Target). All unnumbered.
-- Unnumbered non-retail: Rainbow, Sunset, Matte Pink.
-- Hot Magma /499 replaces Aquamarine /499. Yellow Traxx dropped.
-- Numbered: Hot Magma /499, Violet Pixels /299, Red Prism /199, Arctic Freeze /99,
--   Cosmic /65, Seismic Gold /50, Orange Checkers /25, Emerald Surge /10,
--   Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Surge","ebay_kw":"Blue Surge"},
  {"label":"Neon Yellow Surge","ebay_kw":"Neon Yellow Surge"},
  {"label":"Red Surge","ebay_kw":"Red Surge"},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Matte Pink","ebay_kw":"Matte Pink"},
  {"label":"Hot Magma /499","ebay_kw":"Hot Magma"},
  {"label":"Violet Pixels /299","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Cosmic /65","ebay_kw":"Cosmic"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2021;

-- ─── 2022: Blue Traxx + unnumbered Cosmic; Liquid Metal /349; tighter runs ────

-- 2022-23 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Rainbow, Blue Traxx, Violet Pixels, Matte Pink, Cosmic.
-- Surge retail exclusives dropped vs. 2021.
-- New: Liquid Metal /349. Print runs tightened dramatically:
--   Red Prism /60 (from /199), Seismic Gold /25 (from /50), Orange Checkers /15.
-- Hot Magma, Arctic Freeze dropped vs. 2021.
-- Numbered: Liquid Metal /349, Red Prism /60, Seismic Gold /25,
--   Orange Checkers /15, Emerald Surge /10, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Blue Traxx","ebay_kw":"Blue Traxx"},
  {"label":"Violet Pixels","ebay_kw":"Violet Pixels"},
  {"label":"Matte Pink","ebay_kw":"Matte Pink"},
  {"label":"Cosmic","ebay_kw":"Cosmic"},
  {"label":"Liquid Metal /349","ebay_kw":"Liquid Metal"},
  {"label":"Red Prism /60","ebay_kw":"Red Prism"},
  {"label":"Seismic Gold /25","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /15","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2022;

-- ─── 2023: Blue Fragment /125 + Bioluminescence /5; Cosmic → /65 numbered ─────

-- 2023-24 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Neon Yellow Surge, Rainbow, Sunset, Matte Pink.
-- New: Blue Fragment /125, Bioluminescence /5. Cosmic now /65 (numbered).
-- Violet Pixels /299, Red Prism /199, Arctic Freeze /99 return.
-- Liquid Metal now /399 (higher print run vs. /349 in 2022).
-- Numbered: Liquid Metal /399, Violet Pixels /299, Red Prism /199,
--   Blue Fragment /125, Arctic Freeze /99, Cosmic /65, Seismic Gold /50,
--   Orange Checkers /25, Emerald Surge /10, Bioluminescence /5,
--   Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Neon Yellow Surge","ebay_kw":"Neon Yellow Surge"},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Matte Pink","ebay_kw":"Matte Pink"},
  {"label":"Liquid Metal /399","ebay_kw":"Liquid Metal"},
  {"label":"Violet Pixels /299","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Blue Fragment /125","ebay_kw":"Blue Fragment"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Cosmic /65","ebay_kw":"Cosmic"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Bioluminescence /5","ebay_kw":"Bioluminescence"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2023;

-- ─── 2024: Pink Magma replaces Matte Pink; Liquid Metal dropped ───────────────

-- 2024-25 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Neon Yellow Surge, Rainbow, Sunset, Pink Magma (replaces Matte Pink).
-- Liquid Metal dropped vs. 2023.
-- Numbered: Violet Pixels /299, Red Prism /199, Blue Fragments /125,
--   Arctic Freeze /99, Cosmic /65, Seismic Gold /50, Orange Checkers /25,
--   Emerald Surge /10, Bioluminescence /5, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Neon Yellow Surge","ebay_kw":"Neon Yellow Surge"},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Pink Magma","ebay_kw":"Pink Magma"},
  {"label":"Violet Pixels /299","ebay_kw":"Violet Pixels"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Blue Fragments /125","ebay_kw":"Blue Fragments"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Cosmic /65","ebay_kw":"Cosmic"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Bioluminescence /5","ebay_kw":"Bioluminescence"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2024;

-- ─── 2025: Turquoise Fragments /249 new; Blue Fragments dropped ───────────────

-- 2025-26 O-Pee-Chee Platinum Hockey.
-- Unnumbered: Neon Yellow Surge, Rainbow, Sunset, Pink Magma.
-- New: Turquoise Fragments /249 (replaces Blue Fragments /125).
-- Numbered: Violet Pixels /299, Turquoise Fragments /249, Red Prism /199,
--   Arctic Freeze /99, Cosmic /65, Seismic Gold /50, Orange Checkers /25,
--   Emerald Surge /10, Bioluminescence /5, Golden Treasures 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Neon Yellow Surge","ebay_kw":"Neon Yellow Surge"},
  {"label":"Rainbow","ebay_kw":"Rainbow"},
  {"label":"Sunset","ebay_kw":"Sunset"},
  {"label":"Pink Magma","ebay_kw":"Pink Magma"},
  {"label":"Violet Pixels /299","ebay_kw":"Violet Pixels"},
  {"label":"Turquoise Fragments /249","ebay_kw":"Turquoise Fragments"},
  {"label":"Red Prism /199","ebay_kw":"Red Prism"},
  {"label":"Arctic Freeze /99","ebay_kw":"Arctic Freeze"},
  {"label":"Cosmic /65","ebay_kw":"Cosmic"},
  {"label":"Seismic Gold /50","ebay_kw":"Seismic Gold"},
  {"label":"Orange Checkers /25","ebay_kw":"Orange Checkers"},
  {"label":"Emerald Surge /10","ebay_kw":"Emerald Surge"},
  {"label":"Bioluminescence /5","ebay_kw":"Bioluminescence"},
  {"label":"Golden Treasures 1/1","ebay_kw":"Golden Treasures"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey'
  AND year = 2025;
