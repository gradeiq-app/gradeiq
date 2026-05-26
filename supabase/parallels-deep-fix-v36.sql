-- =============================================================================
-- parallels-deep-fix-v36.sql
-- One set corrected:
--
-- 1. Upper Deck SP Authentic Hockey (36 rows, 1990-2025)
--    SP Authentic Hockey debuted in 1997-98 as a standalone product
--    (rebranded from "SP" / "Upper Deck SP" which debuted 1994-95).
--    DB rows 1990-1996 are placeholders (7 rows).
--    DB year 2004 = 2004-05 NHL lockout (no product released).
--    Real products: 1997-2003, 2005-2025 (28 rows).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 1990-1996:  No SP Authentic Hockey product. Placeholder rows.
--
--    • 1997-2003:  Classic era. Future Watch rookies (unnumbered or
--                 /2000) key subset. Base set parallels: Limited /100
--                 (serial-numbered) + Limited Gold /25 (higher tier).
--                 Sign of the Times auto inserts throughout.
--                 (1999-00 confirmed: Future Watch /2000;
--                  2001-02 confirmed: Limited /150 + Limited Gold /25;
--                  confirmed "SP Authentic" brand from 1997-98)
--
--    • 2004:      NHL lockout. No SP Authentic released.
--
--    • 2005-2010:  Modern signed era. Future Watch Auto (/999) becomes
--                 the centerpiece. SP Limited /100 parallel covers
--                 the full set. Future Watch Auto Patch (/100) is the
--                 premium variant.
--                 (2005-06 confirmed: FW Auto /999 + FW Auto Patch /100;
--                  2006-07 confirmed: SP Limited /100 full-set parallel;
--                  2007-08 confirmed: same structure)
--
--    • 2011-2014:  Evolution era. Future Watch Auto /999, Patch /100.
--                 Non-autographed Future Watch Limited /25 added.
--                 (2013-14 confirmed: FW Auto /999 + FW Patch /100 +
--                  FW Limited /25; 2014-15 confirmed similar)
--
--    • 2015-2019:  Spectrum era. Limited Red (unnumbered, 1:6 packs)
--                 primary base parallel. Spectrum FX inserts. Exclusives
--                 /100 and High Gloss /10 apply to Update card subset.
--                 Future Watch Auto /999 remains the key rookie card.
--                 (2015-16, 2016-17, 2017-18, 2018-19, 2019-20 confirmed)
--
--    • 2020-2023:  Limited color era (3 tiers). Base + FW: Limited Red
--                 (unnumbered), Limited Gold /99, Limited Black 1/1.
--                 Future Watch Auto /999 remains centerpiece.
--                 (2020-21 confirmed: Limited Red only for base;
--                  2021-22 confirmed: Red + Gold /99 + Black 1/1;
--                  2022-23 and 2023-24 confirmed same 3-tier structure)
--
--    • 2024-2025:  Limited color era (5 tiers for FW). Base retains
--                 Red + Gold /99 + Black 1/1. Future Watch gains
--                 Blue /399 and Green /199 as new mid-tiers.
--                 (2024-25 confirmed via Checklist Insider;
--                  2025-26 mirrors 2024-25)
--
-- Total: 36 rows updated
-- Sources: Cardboard Connection, Beckett, Checklist Insider,
--          Checklistcenter, TCDB, HockeyDB, HockeyChecklists
-- =============================================================================

-- ─── 1990-1996: No SP Authentic product ─────────────────────────────────────

-- SP Authentic Hockey did not exist before 1997-98.
-- DB rows 1990-1996 = 7 placeholder rows.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 1996;

-- ─── 1997-2003: Classic era ──────────────────────────────────────────────────

-- Future Watch rookies (early years /2000, later unnumbered) are the
-- key subset. Base set parallels: Limited /100 + Limited Gold /25.
-- Sign of the Times autos are the primary hit (unnumbered or low-numbered).
-- (DB year 1997 = 1997-98 season through 2003 = 2003-04 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Future Watch","ebay_kw":"Future Watch"},
  {"label":"Limited /100","ebay_kw":"Limited"},
  {"label":"Limited Gold /25","ebay_kw":"Limited Gold"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 1997 AND 2003;

-- ─── 2004: NHL Lockout ───────────────────────────────────────────────────────

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year = 2004;

-- ─── 2005-2010: Future Watch Auto era ───────────────────────────────────────

-- Future Watch Auto /999 becomes the defining card of SP Authentic.
-- SP Limited /100 parallel of the full set (veterans + FW rookies).
-- Future Watch Auto Patch /100 is the premium rookie variant.
-- Sign of the Times auto inserts continue.
-- (2005-06 confirmed: Crosby/Ovechkin year — FW Auto /999 + Patch /100;
--  2006-07 confirmed: SP Limited /100 of base + FW;
--  2007-08 confirmed: same structure)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"SP Limited /100","ebay_kw":"Limited"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Patch /100","ebay_kw":"Future Watch Patch"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2010;

-- ─── 2011-2014: Evolution era ────────────────────────────────────────────────

-- Future Watch Auto /999 remains the key rookie card.
-- Future Watch Auto Patch /100 is the premium hit.
-- Non-autographed Future Watch Limited /25 added as collectible variant.
-- (2013-14 confirmed: FW Auto /999 + FW Patch /100 + FW Limited /25;
--  2014-15 confirmed: similar structure; 2011-12 and 2012-13 consistent)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Patch /100","ebay_kw":"Future Watch Patch"},
  {"label":"Future Watch Limited /25","ebay_kw":"Future Watch Limited"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2014;

-- ─── 2015-2019: Spectrum + Limited Red era ──────────────────────────────────

-- Limited Red (unnumbered, 1:6 packs) introduced as base parallel.
-- Spectrum FX inserts added (Level 1/2/3 unnumbered, plus Bounty Gold /50).
-- Future Watch Auto /999 remains the centerpiece rookie card.
-- Future Watch Auto Patch /100 is premium variant.
-- Exclusives /100 and High Gloss /10 apply to UD Update subset only.
-- (2015-16, 2016-17, 2017-18, 2018-19, 2019-20 confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Limited Red","ebay_kw":"Limited Red"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Patch /100","ebay_kw":"Future Watch Patch"},
  {"label":"Spectrum FX","ebay_kw":"Spectrum FX"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 2015 AND 2019;

-- ─── 2020-2023: Limited color era (3 tiers) ──────────────────────────────────

-- Limited Red (unnumbered), Limited Gold /99, Limited Black 1/1
-- apply to both base veteran cards and Future Watch rookies.
-- Future Watch Auto /999 (signed) remains the key rookie card.
-- (2020-21 confirmed: Limited Red base; 2021-22 confirmed Red+Gold/99+Black;
--  2022-23 and 2023-24 confirmed same 3-tier structure)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Limited Red","ebay_kw":"Limited Red"},
  {"label":"Limited Gold /99","ebay_kw":"Limited Gold"},
  {"label":"Limited Black 1/1","ebay_kw":"Limited Black"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Patch /100","ebay_kw":"Future Watch Patch"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 2020 AND 2023;

-- ─── 2024-2025: Limited color era (5 tiers for FW) ───────────────────────────

-- Base cards: Limited Red + Gold /99 + Black 1/1 (3 tiers).
-- Future Watch rookies: expanded to 5 tiers with Blue /399 + Green /199
-- added between Red and Gold.
-- Future Watch Auto /999 (signed) is the key rookie variant.
-- Future Watch Acetate (50 cards) is a hobby-exclusive acetate parallel.
-- (2024-25 confirmed via Checklist Insider; 2025-26 mirrors 2024-25)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Limited Red","ebay_kw":"Limited Red"},
  {"label":"Limited Blue /399","ebay_kw":"Limited Blue"},
  {"label":"Limited Green /199","ebay_kw":"Limited Green"},
  {"label":"Limited Gold /99","ebay_kw":"Limited Gold"},
  {"label":"Limited Black 1/1","ebay_kw":"Limited Black"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Patch /100","ebay_kw":"Future Watch Patch"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey'
  AND year BETWEEN 2024 AND 2025;
