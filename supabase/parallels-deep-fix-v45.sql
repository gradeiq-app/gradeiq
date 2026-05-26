-- =============================================================================
-- parallels-deep-fix-v45.sql
-- One set corrected:
--
-- 1. Panini Mosaic Football
--    (brand='Panini', set_name='Mosaic', sport='football')
--    7 rows — DB years 2019-2025
--
--    Football Mosaic debuted in 2020 (DB year 2020).
--    DB year 2019 = placeholder (set didn't exist; Mosaic was basketball-only then).
--
-- Sub-products included in same DB entry (no separate rows):
--   - Hobby Choice Mosaic (Peacock, Fusion Red, Black Gold /8, Nebula 1/1)
--   - No Huddle Mosaic (Silver, Blue, Purple, Pink, Gold, Black)
--   - Retail-exclusive fluorescents (Orange /25, Blue /15, Pink /10, etc.)
--   - FOTL-exclusive (Green/Pink Swirl in 2024; Spectris in 2025)
--
-- Key evolution:
--   - 2020:  Debut — Mosaic/Red/Genesis/Green/Reactive unnumbered;
--            hobby Blue/99+Purple/49+White/25+Gold/10; retail fluorescents
--   - 2021:  Silver, Camo Red, Honeycomb, Reactive Yellow added;
--            Gold Wave /17, Red Wave /9, Swirls /11 debut
--   - 2022:  White Sparkle added; Blue /99 back; Tessellation /15 debut
--   - 2023:  Orange /199 new high-volume tier; Blue Sparkle /96,
--            Gold Sparkle /24, Red Sparkle unnumb; No Huddle Blue /75 explicit
--   - 2024:  Green/Pink Swirl move to FOTL /13; overall same structure
--   - 2025:  Orange /199 continues; Silver Knight /149 new; Red Wave /27
--            (from /9!); Spectris FOTL /13; Gold Glitter /5; Cherry Blossom /20
--
-- Sources: Cardboard Connection, Checklist Insider, Beckett
-- =============================================================================

-- ─── 2019: Placeholder (Football Mosaic did not exist yet) ───────────────────

-- Panini Mosaic Football debuted with 2020. 2019 is a DB placeholder.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2019;

-- ─── 2020: Debut year ────────────────────────────────────────────────────────

-- 2020 Panini Mosaic Football. Debut year for the football product.
-- Unnumbered: Mosaic (base mosaic), Mosaic Red (hobby); Camo Pink, Genesis,
--   Green, Reactive Blue, Reactive Green, Reactive Gold, Reactive Orange (retail);
--   Choice Peacock (Choice box); No Huddle Silver (No Huddle box).
-- Numbered Hobby: Blue /99, Purple /49, White /25, Gold /10, Black 1/1.
-- Numbered Choice: Fusion Red /80, Black Gold /10, Nebula 1/1.
-- Numbered No Huddle: Blue /75, Purple /50, Pink /20, Gold /10, Black 1/1.
-- Numbered Retail: Orange Fluorescent /25, Gold Fluorescent /20,
--   Blue Fluorescent /15, Pink Fluorescent /10.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Green","ebay_kw":"Reactive Green"},
  {"label":"Reactive Gold","ebay_kw":"Reactive Gold"},
  {"label":"Reactive Orange","ebay_kw":"Reactive Orange"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Fusion Red /80","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Blue /75","ebay_kw":"No Huddle Blue"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Fluorescent /20","ebay_kw":"Gold Fluorescent"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black Gold /10","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2020;

-- ─── 2021: Silver/Camo Red/Honeycomb/Reactive Yellow; Gold Wave /17 ───────────

-- 2021 Panini Mosaic Football.
-- New unnumbered: Silver, Camo Red, Honeycomb, Reactive Yellow (replaces some Reactive variants).
-- New numbered: Gold Wave /17, Green Swirl /11, Pink Swirl /11, Red Wave /9,
--   Green Fluorescent /10, Pink Fluorescent /10.
-- White /25 continues; Blue /99 dropped from main hobby (no mention in 2021 data).
-- NOTE: Purple /49 confirmed; Orange Fluorescent /25 listed.
-- Choice: Fusion Red & Green (unnumb), Fusion Red & Yellow /80, Black Gold /8, Nebula 1/1.
-- No Huddle: Silver, Blue /75, Purple /50, Pink /20, Gold /10, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Camo Red","ebay_kw":"Camo Red"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Orange","ebay_kw":"Reactive Orange"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"No Huddle Blue /75","ebay_kw":"No Huddle Blue"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Fusion Red & Yellow /80","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Wave /17","ebay_kw":"Gold Wave"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Green Swirl /11","ebay_kw":"Green Swirl"},
  {"label":"Pink Swirl /11","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Red Wave /9","ebay_kw":"Red Wave"},
  {"label":"Black Gold /8","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2021;

-- ─── 2022: White Sparkle; Blue /99 returns; Tessellation /15 ─────────────────

-- 2022 Panini Mosaic Football.
-- New unnumbered: White Sparkle, Honeycomb (confirmed in Hobby).
-- Blue /99 returns to main hobby lineup.
-- Tessellation /15 introduced (replaces one of the Swirl slots).
-- Green Swirl /11, Pink Swirl /11 remain.
-- Choice: Peacock (unnumb), Fusion Red & Yellow /80, Black Gold /8, Nebula 1/1.
-- No Huddle: Silver (unnumb), Blue /75, Purple /50, Pink /20, Gold /10, Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"Reactive Orange","ebay_kw":"Reactive Orange"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Fusion Red & Yellow /80","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Blue /75","ebay_kw":"No Huddle Blue"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Wave /17","ebay_kw":"Gold Wave"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Tessellation /15","ebay_kw":"Tessellation"},
  {"label":"Green Swirl /11","ebay_kw":"Green Swirl"},
  {"label":"Pink Swirl /11","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Red Wave /9","ebay_kw":"Red Wave"},
  {"label":"Black Gold /8","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2022;

-- ─── 2023: Orange /199 new; Blue Sparkle /96; Gold Sparkle /24 ───────────────

-- 2023 Panini Mosaic Football.
-- New: Orange Mosaic /199 (first high-volume numbered tier), Blue Sparkle /96,
--   Gold Sparkle /24, Red Sparkle (unnumb), Reactive Yellow added to unnumb.
-- Camo Red returns.
-- Same core structure: Blue /99, Purple /49, White /25, Swirls /11, Gold /10,
--   Red Wave /9.
-- No Huddle Blue /75 and Purple /50 and Pink /20 and Gold /10 confirmed.
-- Choice: Red & Green (unnumb for rookies), Fusion /80, Black Gold /8, Nebula 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Camo Red","ebay_kw":"Camo Red"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Fusion Red & Yellow /80","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Blue /75","ebay_kw":"No Huddle Blue"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Wave /17","ebay_kw":"Gold Wave"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Tessellation /15","ebay_kw":"Tessellation"},
  {"label":"Green Swirl /11","ebay_kw":"Green Swirl"},
  {"label":"Pink Swirl /11","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Red Wave /9","ebay_kw":"Red Wave"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Black Gold /8","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2023;

-- ─── 2024: Green/Pink Swirl → FOTL /13; same core structure ──────────────────

-- 2024 Panini Mosaic Football.
-- Green Swirl and Pink Swirl move from /11 standard to FOTL-exclusive /13.
-- Reactive Yellow replaces some Reactive Orange; adds Reactive Blue back.
-- Choice Fusion stays at /80. Overall structure mirrors 2023.
-- No Huddle Blue moves back to /75 (consistent with prior years).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Camo Red","ebay_kw":"Camo Red"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Fusion Red & Yellow /80","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Blue /75","ebay_kw":"No Huddle Blue"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Gold Wave /17","ebay_kw":"Gold Wave"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Tessellation /15","ebay_kw":"Tessellation"},
  {"label":"Green Swirl FOTL /13","ebay_kw":"Green Swirl"},
  {"label":"Pink Swirl FOTL /13","ebay_kw":"Pink Swirl"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Red Wave /9","ebay_kw":"Red Wave"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Black Gold /8","ebay_kw":"Black Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2024;

-- ─── 2025: Silver Knight /149; Red Wave /27; Spectris /13; Gold Glitter /5 ────

-- 2025 Panini Mosaic Football.
-- New: Silver Knight /149 (new mid-tier), Red Wave /27 (jumped from /9!),
--   Cherry Blossom /20 (Choice only), Gold Glitter /5 (near 1/1 tier),
--   Spectris FOTL /13 (replaces Swirl), Reactive Purple (replaces Reactive Orange/Gold).
-- New unnumbered: Blue Scope, Purple Scope, Red Scope (scope variants).
-- No Huddle Blue now /99 (up from /75).
-- Choice Fusion Red & Yellow now /89 (was /80).
-- Gold Wave now /10 (was /17).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Mosaic","ebay_kw":"Mosaic"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue Scope","ebay_kw":"Blue Scope"},
  {"label":"Purple Scope","ebay_kw":"Purple Scope"},
  {"label":"Red Scope","ebay_kw":"Red Scope"},
  {"label":"Camo Pink","ebay_kw":"Camo Pink"},
  {"label":"Camo Red","ebay_kw":"Camo Red"},
  {"label":"Genesis","ebay_kw":"Genesis"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Honeycomb","ebay_kw":"Honeycomb"},
  {"label":"Reactive Blue","ebay_kw":"Reactive Blue"},
  {"label":"Reactive Purple","ebay_kw":"Reactive Purple"},
  {"label":"Reactive Yellow","ebay_kw":"Reactive Yellow"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Sparkle","ebay_kw":"Red Sparkle"},
  {"label":"White Sparkle","ebay_kw":"White Sparkle"},
  {"label":"Peacock","ebay_kw":"Peacock"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Silver Knight /149","ebay_kw":"Silver Knight"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"No Huddle Blue /99","ebay_kw":"No Huddle Blue"},
  {"label":"Blue Sparkle /96","ebay_kw":"Blue Sparkle"},
  {"label":"Fusion Red & Yellow /89","ebay_kw":"Fusion Red"},
  {"label":"No Huddle Purple /50","ebay_kw":"No Huddle Purple"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Red Wave /27","ebay_kw":"Red Wave"},
  {"label":"Orange Fluorescent /25","ebay_kw":"Orange Fluorescent"},
  {"label":"White /25","ebay_kw":"White"},
  {"label":"Gold Sparkle /24","ebay_kw":"Gold Sparkle"},
  {"label":"Cherry Blossom /20","ebay_kw":"Cherry Blossom"},
  {"label":"No Huddle Pink /20","ebay_kw":"No Huddle Pink"},
  {"label":"Blue Fluorescent /15","ebay_kw":"Blue Fluorescent"},
  {"label":"Tessellation /15","ebay_kw":"Tessellation"},
  {"label":"Green Spectris FOTL /13","ebay_kw":"Green Spectris"},
  {"label":"Pink Spectris FOTL /13","ebay_kw":"Pink Spectris"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Green Fluorescent /10","ebay_kw":"Green Fluorescent"},
  {"label":"Pink Fluorescent /10","ebay_kw":"Pink Fluorescent"},
  {"label":"Green Sparkle /8","ebay_kw":"Green Sparkle"},
  {"label":"Black Gold /8","ebay_kw":"Black Gold"},
  {"label":"Gold Glitter /5","ebay_kw":"Gold Glitter"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Nebula 1/1","ebay_kw":"Nebula"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football'
  AND year = 2025;
