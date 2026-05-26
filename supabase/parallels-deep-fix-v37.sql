-- =============================================================================
-- parallels-deep-fix-v37.sql
-- One set corrected:
--
-- 1. Upper Deck SPx Hockey (30 rows, 1996-2025)
--    SPx Hockey debuted in 1996-97 as a die-cut holofoil premium product.
--    All 30 DB rows have actual products EXCEPT DB year 2004 (lockout).
--    SPx is a HIT-FOCUSED product; base cards are usually serial-numbered.
--
--    Parallel structure by era (DB year = season start year):
--
--    • 1996:       Debut. 50-card die-cut holofoil set. No rookies.
--                 No serial-numbered parallels; the die-cut IS the parallel.
--                 Special inserts: Gretzky tribute, Great Futures.
--
--    • 1997:       Gold foil parallel of 50-card base (1:17 packs).
--                 (1997-98 confirmed: SPx Gold as separate parallel)
--
--    • 1998:       Radiance and Spectrum parallels (hot packs only).
--                 (1998-99 SPx confirmed: Radiance + Spectrum via hot packs)
--                 Note: 1998-99 SPx Finite is a SEPARATE premium product.
--
--    • 1999:       Base rookies numbered to /1500. Radiance /100.
--                 Spectrum 1/1 (the ultra-rare 1/1 parallel).
--                 (1999-00 confirmed: rookies /1500, Radiance /100, Spectrum 1/1)
--
--    • 2000-2003:  Winning Materials era. Base numbered to /1500 (or similar).
--                 Spectrum /50 parallel (2000-01 confirmed).
--                 2002-03: Spectrum Silver /199 for subset cards.
--                 Winning Materials jersey relic inserts added.
--
--    • 2004:       NHL lockout — no SPx released. Placeholder.
--
--    • 2005-2009:  Numbered base era. Cards /999, Spectrum parallel /99.
--                 (2006-07 confirmed: base /999 + Spectrum /99;
--                  2007-08: Spectrum /25 for some tiers)
--                 Winning Materials autos and RC Auto inserts.
--
--    • 2010-2015:  Color spectrum era. Base /499 or similar; color
--                 parallels (Red /249, Blue /50, Green /10) for RC Autos.
--                 (2014-15 confirmed: Red /249, Blue /50, Green /10;
--                  2015-16: Red /50, Green /10 for Acetate RC Autos)
--                 Winning Materials and RC Autos are the primary hits.
--
--    • 2016-2022:  Extended color spectrum. Base /299 (serial-numbered).
--                 Spectrum /299, Gold /199, Blue /100, Purple /50,
--                 Green /25, Black 1/1 for base tiers.
--                 (2021-22 confirmed: base set /299; Finite Rookies
--                  Gold /299 → Platinum Spectrum 1/1 tiered system)
--                 Winning Materials Autos + RC Auto Jerseys.
--
--    • 2023-2025:  Modern era. Silver (odds), Gold (odds) unnumbered;
--                 Radiance /100, Grand Finale /50, Silver Spectrum /25,
--                 Gold Spectrum 1/1.
--                 Rookie Holograms: Blue /25, Red /10, Gold 1/1.
--                 (2024-25 confirmed via Checklist Insider;
--                  2025-26 mirrors 2024-25)
--
-- Total: 30 rows updated
-- Sources: Cardboard Connection, Beckett, Checklist Insider,
--          Checklistcenter, HockeyDB, TCDB
-- =============================================================================

-- ─── 1996: Debut die-cut era ─────────────────────────────────────────────────

-- 50-card die-cut holofoil set. The die-cut IS the premium element.
-- No traditional serial-numbered parallels. Gretzky tribute inserts.
-- (DB year 1996 = 1996-97 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year = 1996;

-- ─── 1997: Gold parallel era ─────────────────────────────────────────────────

-- Gold foil parallel of the 50-card base set (1:17 packs).
-- (DB year 1997 = 1997-98 season; confirmed via Beckett)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold","ebay_kw":"Gold"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year = 1997;

-- ─── 1998: Radiance + Spectrum hot pack era ──────────────────────────────────

-- Radiance and Spectrum parallels available through special 3-card hot packs.
-- Note: SPx Finite is a SEPARATE premium product from this base SPx set.
-- (DB year 1998 = 1998-99 season; confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Radiance","ebay_kw":"Radiance"},
  {"label":"Spectrum","ebay_kw":"Spectrum"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year = 1998;

-- ─── 1999: Numbered rookies + Radiance /100 + Spectrum 1/1 ──────────────────

-- Rookie cards serial-numbered to /1500. Radiance parallel /100.
-- Spectrum 1/1 = the ultra-rare 1-of-1 parallel.
-- (DB year 1999 = 1999-00 season; confirmed via Checklistcenter)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Radiance /100","ebay_kw":"Radiance"},
  {"label":"Spectrum 1/1","ebay_kw":"Spectrum"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"},
  {"label":"RC Auto","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year = 1999;

-- ─── 2000-2003: Winning Materials era ────────────────────────────────────────

-- Base cards serial-numbered to /1500 (some subsets lower).
-- Spectrum /50 parallel (2000-01 confirmed).
-- 2002-03: Spectrum Silver /199 for base subset.
-- Winning Materials jersey relic cards are the main hit.
-- (DB year 2000 = 2000-01 through 2003 = 2003-04 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base /1500","ebay_kw":""},
  {"label":"Spectrum /50","ebay_kw":"Spectrum"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"},
  {"label":"Winning Materials Auto","ebay_kw":"Winning Materials Auto"},
  {"label":"RC Auto","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year BETWEEN 2000 AND 2003;

-- ─── 2004: NHL Lockout ───────────────────────────────────────────────────────

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year = 2004;

-- ─── 2005-2009: Numbered base + Spectrum parallel era ────────────────────────

-- Base set serial-numbered to /999. Spectrum parallel /99.
-- Some years: multiple Spectrum tiers with /25 or lower for rare subsets.
-- Winning Materials and RC Auto are the key hits every year.
-- (2006-07 confirmed: base /999 + Spectrum /99;
--  2007-08: Spectrum /25 for some tiers)
UPDATE card_sets SET parallels = '[
  {"label":"Base /999","ebay_kw":""},
  {"label":"Spectrum /99","ebay_kw":"Spectrum"},
  {"label":"Spectrum /25","ebay_kw":"Spectrum"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"},
  {"label":"Winning Materials Auto","ebay_kw":"Winning Materials Auto"},
  {"label":"RC Auto","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2009;

-- ─── 2010-2015: Color spectrum RC Auto era ───────────────────────────────────

-- Base numbered sets with color-coded parallel tiers for RC Autos.
-- (2014-15: RC Autos in Red /249, Blue /50, Green /10;
--  2015-16: Acetate RC Auto Jerseys /499 or /349, Red /50, Green /10)
-- Winning Materials and combo relics are key hits.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Spectrum","ebay_kw":"Spectrum"},
  {"label":"Winning Materials","ebay_kw":"Winning Materials"},
  {"label":"Winning Materials Auto","ebay_kw":"Winning Materials Auto"},
  {"label":"RC Auto","ebay_kw":"Auto"},
  {"label":"RC Auto Red /249","ebay_kw":"Auto Red"},
  {"label":"RC Auto Blue /50","ebay_kw":"Auto Blue"},
  {"label":"RC Auto Green /10","ebay_kw":"Auto Green"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year BETWEEN 2010 AND 2015;

-- ─── 2016-2022: Extended color spectrum era ──────────────────────────────────

-- Base set serial-numbered to /299. Full color spectrum for base cards.
-- Winning Materials Autos + RC Auto Jerseys as key hits.
-- 2021-22: Finite Rookies with Gold /299 → Platinum Spectrum 1/1 tiers.
-- (Spectrum /299 → Gold /199 → Blue /100 → Purple /50 → Green /25 → Black 1/1)
UPDATE card_sets SET parallels = '[
  {"label":"Base /299","ebay_kw":""},
  {"label":"Gold /199","ebay_kw":"Gold"},
  {"label":"Blue /100","ebay_kw":"Blue"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Winning Materials Auto","ebay_kw":"Winning Materials Auto"},
  {"label":"RC Auto","ebay_kw":"Auto"},
  {"label":"RC Auto /199","ebay_kw":"Auto"},
  {"label":"RC Auto /25","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year BETWEEN 2016 AND 2022;

-- ─── 2023-2025: Modern Radiance era ──────────────────────────────────────────

-- Silver and Gold parallels (odds-based, unnumbered).
-- Radiance /100, Grand Finale /50, Silver Spectrum /25, Gold Spectrum 1/1.
-- Rookie Holograms: Blue /25, Red /10, Gold 1/1.
-- (2024-25 confirmed via Checklist Insider; 2025-26 mirrors 2024-25)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Gold","ebay_kw":"Gold"},
  {"label":"Radiance /100","ebay_kw":"Radiance"},
  {"label":"Grand Finale /50","ebay_kw":"Grand Finale"},
  {"label":"Silver Spectrum /25","ebay_kw":"Silver Spectrum"},
  {"label":"Gold Spectrum 1/1","ebay_kw":"Gold Spectrum"},
  {"label":"Winning Materials Auto","ebay_kw":"Winning Materials Auto"},
  {"label":"RC Auto","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey'
  AND year BETWEEN 2023 AND 2025;
