-- =============================================================================
-- parallels-deep-fix-v42.sql
-- One set corrected:
--
-- 1. Topps Chrome Basketball
--    (brand='Topps', set_name='Chrome Basketball', sport='basketball')
--    15 rows — DB years 1996-2008 (classic era) + 2025-2026 (relaunch)
--
--    Topps Chrome Basketball ran 1996-97 through 2008-09, then was discontinued
--    when Panini held the exclusive NBA license (~2009-2024).
--    Fanatics/Topps reclaimed the NBA license from 2025-26 onward.
--    DB year 2026 = 2026-27 season (not yet released) = placeholder.
--
-- Key differences from other Chrome sets:
--   - 1996-2000: Refractor is the ONLY parallel (unnumbered, 1:12 packs)
--   - 2001-02: First year with a serial-numbered parallel (Black Refractor /50)
--   - 2002-03: White Refractor /249 added; Black /99
--   - 2003-05: X-Fractor + Gold tiers; SuperFractor 1/1 from 2004-05
--   - 2006-08: Refractor itself SERIAL-NUMBERED (2006-07 and 2007-08: /999)
--   - 2008-09: Reverted to unnumbered Refractor; Orange /499, X-Fractor /288
--   - 2025-26: Modern relaunch with ~32 parallels (Fanatics era)
--   - 2026-27: Placeholder
--
-- Sources: Cardboard Connection, Beckett, Charm City Cards, Checklist Insider
-- =============================================================================

-- ─── 1996-2000: Single Refractor era ─────────────────────────────────────────

-- 1996-97 through 1999-00 Topps Chrome Basketball.
-- Only ONE parallel: Refractor (unnumbered, 1:12 packs).
-- No serial numbering. Same structure for all four debut years.
-- (Refractor = the rainbow prism version of every base card)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year BETWEEN 1996 AND 1999;

-- ─── 2000: Refractor only (confirmed via PSA registry) ───────────────────────

-- 2000-01 Topps Chrome Basketball.
-- Refractor still the only parallel per PSA Set Registry standalone listing.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2000;

-- ─── 2001: First serial-numbered year ────────────────────────────────────────

-- 2001-02 Topps Chrome Basketball.
-- First year with a serial-numbered parallel per Beckett.
-- Black Refractor serial-numbered to /50 (hobby only).
-- Standard Refractor remains unnumbered (1:4 packs).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Black Refractor /50","ebay_kw":"Black Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2001;

-- ─── 2002: White /249 + Black /99 ─────────────────────────────────────────────

-- 2002-03 Topps Chrome Basketball.
-- White Border Refractor /249 added as mid-tier (1:23 packs).
-- Black Border Refractor now /99 (was /50 in 2001-02).
-- Standard Refractor unnumbered (1:4 packs).
-- (Source: Charm City Cards 2002-03 Topps Chrome Basketball description)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"White Refractor /249","ebay_kw":"White Refractor"},
  {"label":"Black Refractor /99","ebay_kw":"Black Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2002;

-- ─── 2003: X-Fractor + Gold introduced ───────────────────────────────────────

-- 2003-04 Topps Chrome Basketball. LeBron James rookie year.
-- X-Fractor /220 + Gold Refractor /50 + Black Refractor /500 introduced.
-- (Black went from /99 to /500 with the expanded tier structure.)
-- Standard Refractor unnumbered.
-- (Source: PSA/Beckett 2003-04 Chrome Basketball confirmed via LeBron RC data)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Black Refractor /500","ebay_kw":"Black Refractor"},
  {"label":"X-Fractor /220","ebay_kw":"X-Fractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2003;

-- ─── 2004-2005: SuperFractor 1/1 debut ───────────────────────────────────────

-- 2004-05 Topps Chrome Basketball. SuperFractor (1/1) introduced.
-- X-Fractor now /110 (tighter print run vs. /220 in 2003-04).
-- Gold Refractor /50 continues. Black Refractor /500 continues.
-- SuperFractor = 1-of-1 for every card in the set.
-- NOTE: applies to both DB years 2004 and 2005 (same structure confirmed).
-- (Source: Beckett; confirmed SuperFractor debut in 2004 Topps Chrome products)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Black Refractor /500","ebay_kw":"Black Refractor"},
  {"label":"X-Fractor /110","ebay_kw":"X-Fractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year BETWEEN 2004 AND 2005;

-- ─── 2006-2007: Refractor itself serial-numbered to /999 ─────────────────────

-- 2006-07 and 2007-08 Topps Chrome Basketball.
-- Major restructuring: the standard Refractor is NOW serial-numbered to /999.
-- Orange Refractor /199, White Refractor /99 (new numbered tiers).
-- X-Fractor now /50. SuperFractor 1/1 remains.
-- (Source: Charm City Cards 2007-08 Chrome Basketball; confirmed for 2006-07 also)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /999","ebay_kw":"Refractor"},
  {"label":"Orange Refractor /199","ebay_kw":"Orange Refractor"},
  {"label":"White Refractor /99","ebay_kw":"White Refractor"},
  {"label":"X-Fractor /50","ebay_kw":"X-Fractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year BETWEEN 2006 AND 2007;

-- ─── 2008: Revamped structure — Orange /499 + X-Fractor /288 ─────────────────

-- 2008-09 Topps Chrome Basketball. Final year before Panini exclusive era.
-- Refractor reverts to unnumbered (no longer /999).
-- Orange Refractor /499 (higher run vs. /199 in 2006-08).
-- X-Fractor /288 (higher run vs. /50). Gold Refractor /50 returns.
-- Red Refractor /5 = new ultra-rare tier. SuperFractor 1/1 continues.
-- (Source: confirmed via search; Beckett 2008-09 Chrome Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Orange Refractor /499","ebay_kw":"Orange Refractor"},
  {"label":"X-Fractor /288","ebay_kw":"X-Fractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2008;

-- ─── 2025: Modern relaunch — Fanatics/Topps era ──────────────────────────────

-- 2025-26 Topps Chrome Basketball. Fanatics/Topps relaunch after 16-year gap.
-- Major expansion vs. classic era: ~32 parallels across multiple tiers.
-- New patterns: Skylight, Pulsar, RayWave, Basketball, Prism, Negative, Wave,
--   Lightboard Logos, 1st Day Issue.
-- Numbered tiers: Magenta /399, Teal /299, Yellow /275, Aqua /199, Blue /150,
--   Green /99, Purple /75, Gold /50, Orange /25, Silver 1st Day Issue /12,
--   Black /10, Tri-Color 1st Day Issue /8, Red /5, Geometric White /2,
--   SuperFractor 1/1.
-- FrozenFractor = negatively numbered novelty card.
-- (Source: Checklist Insider 2025-26 Topps Chrome Basketball)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"1st Day Issue","ebay_kw":"1st Day Issue"},
  {"label":"Basketball","ebay_kw":"Basketball"},
  {"label":"Lightboard Logos","ebay_kw":"Lightboard Logos"},
  {"label":"Negative","ebay_kw":"Negative"},
  {"label":"Prism","ebay_kw":"Prism"},
  {"label":"Pulsar","ebay_kw":"Pulsar"},
  {"label":"RayWave","ebay_kw":"RayWave"},
  {"label":"Red White Blue","ebay_kw":"Red White Blue"},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Skylight","ebay_kw":"Skylight"},
  {"label":"Wave","ebay_kw":"Wave"},
  {"label":"X-Fractor","ebay_kw":"X-Fractor"},
  {"label":"Magenta /399","ebay_kw":"Magenta"},
  {"label":"Teal /299","ebay_kw":"Teal"},
  {"label":"Yellow /275","ebay_kw":"Yellow"},
  {"label":"Yellow Basketball /275","ebay_kw":"Yellow Basketball"},
  {"label":"RayWave Yellow /275","ebay_kw":"RayWave Yellow"},
  {"label":"Aqua /199","ebay_kw":"Aqua"},
  {"label":"Aqua Basketball /199","ebay_kw":"Aqua Basketball"},
  {"label":"RayWave Aqua /199","ebay_kw":"RayWave Aqua"},
  {"label":"Blue /150","ebay_kw":"Blue"},
  {"label":"Green /99","ebay_kw":"Green"},
  {"label":"Purple /75","ebay_kw":"Purple"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Silver 1st Day Issue /12","ebay_kw":"Silver 1st Day Issue"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Tri-Color 1st Day Issue /8","ebay_kw":"Tri-Color 1st Day Issue"},
  {"label":"Red /5","ebay_kw":"Red"},
  {"label":"Geometric White /2","ebay_kw":"Geometric White"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2025;

-- ─── 2026: Placeholder (2026-27 season not yet released) ─────────────────────

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball'
  AND year = 2026;
