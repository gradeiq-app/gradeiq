-- =============================================================================
-- parallels-deep-fix-v29.sql
-- One set corrected:
--
-- 1. Upper Deck The Cup Hockey (36 rows, 1990-2025)
--    The Cup debuted in the 2005-06 NHL season (DB year = 2005).
--    DB rows 1990-2004 are placeholders (15 rows → [Base]).
--    Real products: 2005-2025 (21 rows).
--
--    The base set is ALWAYS numbered /249. Parallels are foil versions.
--    Non-auto parallel structure by era:
--
--    • 2005-2010: Gold /25, Black 1/1, Printing Plates 1/1
--                (DB year 2005 = 2005-06 season)
--    • 2011-2013: Gold Spectrum /25, Black 1/1, Printing Plates 1/1
--                (Gold renamed to Gold Spectrum ~2010-11 season)
--    • 2014:      Gold Foil /10, Gold Spectrum /5, Red Foil /3,
--                Black Foil 1/1, Black Shield 1/1, Plates 1/1
--    • 2015-2016: Gold Spectrum /12, Gold Patch /8, Red Tag /4,
--                Black Foil 1/1, Black Shield 1/1, Plates 1/1
--    • 2017-2022: + Green Foil /3 added (2016-17 season debut)
--    • 2023:      Gold Spectrum /36, Gold Foil /24, Red /4, Green /3,
--                Black 1/1, Black Shield 1/1, Plates 1/1
--    • 2024:      Gold /12, Gold Foil /8, Red /4, Green /3, Black 1/1
--    • 2025:      Same structure as 2024 (2025-26 season, if released)
--
--    Note: Not all players appear in every parallel tier.
--    DB year = start year of the NHL season (2005 = 2005-06, etc.)
--
-- Total: 36 rows updated
-- Sources: Cardboard Connection, Beckett, Checklistinsider, TCDB, hockeydb.com
-- =============================================================================

-- ─── PLACEHOLDERS: 1990-2004 ─────────────────────────────────────────────────

-- The Cup did not exist until 2005-06. These are placeholder rows.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 2004;

-- ─── REAL PRODUCTS ───────────────────────────────────────────────────────────

-- 2005-2010: Debut era. Base /249 is the standard card.
--   Gold parallel limited to 25 copies. Black 1/1. Printing Plates 1/1.
--   (DB year 2005 = 2005-06 season; 2006 = 2006-07; etc.)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2010;

-- 2011-2013: Gold rebranded to "Gold Spectrum" (approx. 2010-11 season).
--   Print run remains /25. Structure otherwise identical to prior era.
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Spectrum /25","ebay_kw":"Gold Spectrum"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2013;

-- 2014: Gold Spectrum drops to /5; Gold Foil /10 tier added; Red Foil /3 debuts.
--   Black Foil Shield is a separate 1/1 from plain Black Foil.
--   (DB year 2014 = 2014-15 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Foil /10","ebay_kw":"Gold Foil"},
  {"label":"Gold Spectrum Foil /5","ebay_kw":"Gold Spectrum"},
  {"label":"Red Foil /3","ebay_kw":"Red Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Black Foil Shield 1/1","ebay_kw":"Black Shield"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2014;

-- 2015-2016: Gold Spectrum rises to /12; Gold Patch /8 added; Red Tag /4.
--   (DB year 2015 = 2015-16 season; 2016 = 2016-17 season)
--   Green Foil /3 debuts in the 2016-17 season (DB year 2016).
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Spectrum Foil /12","ebay_kw":"Gold Spectrum"},
  {"label":"Gold Foil Patch /8","ebay_kw":"Gold Foil Patch"},
  {"label":"Red Foil Tag /4","ebay_kw":"Red Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Black Foil Shield 1/1","ebay_kw":"Black Shield"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2015;

-- 2016: Green Foil Button /3 debuts (2016-17 season).
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Spectrum Foil /12","ebay_kw":"Gold Spectrum"},
  {"label":"Gold Foil Patch /8","ebay_kw":"Gold Foil Patch"},
  {"label":"Red Foil Tag /4","ebay_kw":"Red Foil"},
  {"label":"Green Foil Button /3","ebay_kw":"Green Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Black Foil Shield 1/1","ebay_kw":"Black Shield"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2016;

-- 2017-2022: Stable era. Gold Spectrum /12, Gold Patch /8, Red /4, Green /3.
--   (2017 = 2017-18 through 2022 = 2022-23 seasons)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Spectrum Foil /12","ebay_kw":"Gold Spectrum"},
  {"label":"Gold Foil Patch /8","ebay_kw":"Gold Foil Patch"},
  {"label":"Red Foil /4","ebay_kw":"Red Foil"},
  {"label":"Green Foil /3","ebay_kw":"Green Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Black Foil Shield 1/1","ebay_kw":"Black Shield"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year BETWEEN 2017 AND 2022;

-- 2023: Gold Spectrum bumped to /36; Gold Foil /24 tier added.
--   (DB year 2023 = 2023-24 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Spectrum Foil /36","ebay_kw":"Gold Spectrum"},
  {"label":"Gold Foil /24","ebay_kw":"Gold Foil"},
  {"label":"Red Foil /4","ebay_kw":"Red Foil"},
  {"label":"Green Foil /3","ebay_kw":"Green Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Black Foil Shield 1/1","ebay_kw":"Black Shield"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2023;

-- 2024: Gold tiers shift: /12, /8, /3.
--   (DB year 2024 = 2024-25 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Foil /12","ebay_kw":"Gold Foil"},
  {"label":"Gold Foil Patch /8","ebay_kw":"Gold Foil Patch"},
  {"label":"Green Foil /3","ebay_kw":"Green Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2024;

-- 2025: 2025-26 season placeholder (not yet released as of this writing).
--   Structure mirrored from 2024 as best estimate.
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":""},
  {"label":"Gold Foil /12","ebay_kw":"Gold Foil"},
  {"label":"Gold Foil Patch /8","ebay_kw":"Gold Foil Patch"},
  {"label":"Green Foil /3","ebay_kw":"Green Foil"},
  {"label":"Black Foil 1/1","ebay_kw":"Black Foil"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey'
  AND year = 2025;
