-- =============================================================================
-- parallels-deep-fix-v33.sql
-- One set corrected:
--
-- 1. Upper Deck Ice Hockey (36 rows, 1990-2025)
--    Upper Deck Ice debuted in 1996-97 as a standalone premium product.
--    Not every season had a release:
--    • Placeholder rows: 1990-1995 (no product), 1998, 1999, 2002, 2004
--      (lockout), 2006 — 11 total placeholder rows.
--    • Real products: 25 rows (1996-1997, 2000-2001, 2003, 2005,
--      2007-2025 minus confirmed gaps above).
--
--    Parallel/tier structure by era (DB year = season start year):
--
--    • 1996-1997:  Bronze "Ice Performers", Silver "Ice Phenoms",
--                 Gold "Ice Legends" — three-tier acetate set
--                 (1996-97 confirmed 115 cards; 1997-98 similar)
--    • 2000-2003:  Base veterans (unnumbered), Fresh Faces/Ice Premieres
--                 rookies in tiers /1999, /999, /499, /99
--                 (2000-01 confirmed: Fresh Faces /1500;
--                  2001-02: Fresh Faces /1500, others /1000;
--                  2003-04 TCDB confirmed)
--    • 2005-2018:  Base veterans, Ice Premieres rookie tiers /1999→/99;
--                 Gold Patch (/25 or /15), Autograph (/99 or /49)
--                 (2007-08: /1999/999/499/99 confirmed;
--                  2015-16 confirmed /1999/999/499/99;
--                  2016-17 and 2019 confirmed structure)
--    • 2019-2020:  Base + Ice Cube/Red /5/Black 1/1 for vets;
--                 Ice Premieres /999 tiers, Gold Patch /15
--                 (2019-20 confirmed Green/Orange/Red /5/Black 1/1)
--    • 2021-2022:  Royal Blue /99 + Black 1/1 base parallels added;
--                 Ice Premieres: Green /799, Red /399, Gold /25, Black 1/1
--                 (2021-22 confirmed)
--    • 2023-2025:  Base Blue /599, Green /399, Gold /25, Black 1/1
--                 (2023-24 and 2024-25 confirmed Blue/Green/Gold/Black)
--
-- Total: 36 rows updated
-- Sources: Beckett, Cardboard Connection, TCDB, HockeyDB, BreakNinja
-- =============================================================================

-- ─── PLACEHOLDERS ────────────────────────────────────────────────────────────

-- Upper Deck Ice did not exist before 1996-97. 1998-99, 1999-00, 2002-03,
-- 2004-05 (lockout), and 2006-07 also had no standalone UD Ice release.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year IN (1990, 1991, 1992, 1993, 1994, 1995, 1998, 1999, 2002, 2004, 2006);

-- ─── REAL PRODUCTS ───────────────────────────────────────────────────────────

-- 1996-1997: Debut era. Three-tier acetate design.
--   Ice Performers (Bronze, 1:9 packs), Ice Phenoms (Silver, 1:47 packs),
--   Ice Legends (Gold, 1:325 packs). 115-card standalone premium set.
--   (DB year 1996 = 1996-97 season; 1997 = 1997-98 season; both confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Ice Performers (Bronze)","ebay_kw":"Ice Performers"},
  {"label":"Ice Phenoms (Silver)","ebay_kw":"Ice Phenoms"},
  {"label":"Ice Legends (Gold)","ebay_kw":"Ice Legends"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year BETWEEN 1996 AND 1997;

-- 2000-2003: Fresh Faces / early Ice Premieres era.
--   Base veteran cards unnumbered. Rookie Ice Premieres in numbered tiers.
--   (2000-01: Fresh Faces /1500; 2001-02: Fresh Faces /1500 + /1000;
--    2003-04 confirmed on TCDB; 2005-06 confirmed on TCDB)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ice Premieres /1999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /499","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /99","ebay_kw":"Ice Premieres"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year IN (2000, 2001, 2003);

-- 2005-2018: Established Ice Premieres tier structure.
--   Veteran cards unnumbered with memorabilia parallels.
--   Ice Premieres rookie tiers /1999→/99 plus Gold Patch /25 and
--   Autograph parallels. (2007-08, 2015-16, 2016-17 confirmed structures)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Ice Premieres /1999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /499","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /99","ebay_kw":"Ice Premieres"},
  {"label":"Gold Patch /25","ebay_kw":"Gold Patch"},
  {"label":"Autograph /99","ebay_kw":"Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year IN (2005, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018);

-- 2019-2020: Color parallels introduced for base veteran cards.
--   Ice Cube, Red /5, Black 1/1 add PSA-relevant value tiers.
--   Ice Premieres rookies retain four numbered tiers.
--   Gold Patch drops to /15.
--   (DB year 2019 = 2019-20 season; 2020 = 2020-21 season; both confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Orange","ebay_kw":"Orange"},
  {"label":"Red /5","ebay_kw":"Red"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Ice Premieres /999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /499","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /249","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /99","ebay_kw":"Ice Premieres"},
  {"label":"Gold Patch /15","ebay_kw":"Gold Patch"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year BETWEEN 2019 AND 2020;

-- 2021-2022: Royal Blue /99 added for base cards. Ice Premieres gain
--   Green /799, Red /399, Gold /25 in addition to Black 1/1.
--   (DB year 2021 = 2021-22 season; 2022 = 2022-23 season; both confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Royal Blue /99","ebay_kw":"Royal Blue"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Ice Premieres /999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /799","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /499","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /399","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /99","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres Gold /25","ebay_kw":"Ice Premieres Gold"},
  {"label":"Ice Premieres Black 1/1","ebay_kw":"Ice Premieres Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year BETWEEN 2021 AND 2022;

-- 2023-2025: Base color parallels Blue /599, Green /399, Gold /25, Black 1/1.
--   (2023-24 and 2024-25 confirmed Blue/Green/Gold/Black structure;
--    2025-26 mirrored as placeholder)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /599","ebay_kw":"Blue"},
  {"label":"Green /399","ebay_kw":"Green"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Ice Premieres /999","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /799","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /499","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /249","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres /99","ebay_kw":"Ice Premieres"},
  {"label":"Ice Premieres Gold /25","ebay_kw":"Ice Premieres Gold"},
  {"label":"Ice Premieres Black 1/1","ebay_kw":"Ice Premieres Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey'
  AND year BETWEEN 2023 AND 2025;
