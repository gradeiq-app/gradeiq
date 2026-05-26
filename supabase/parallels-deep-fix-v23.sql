-- =============================================================================
-- parallels-deep-fix-v23.sql
-- Topps Stadium Club Baseball + Topps Stadium Club Chrome Baseball
--
-- Stadium Club base  : 26 rows (1991-2003, 2008, 2014-2025)
-- Stadium Club Chrome:  6 rows (2020-2025)
-- Total              : 32 rows updated
--
-- All parallels in {label, ebay_kw} schema.
-- Sources: CardboardConnection, BaseballCardPedia, Beckett, ChecklistInsider
-- =============================================================================

-- ─── STADIUM CLUB (base foil set) ───────────────────────────────────────────

-- 1991-2003: Original era.  Members Only was a stamped boxed-set parallel;
--   no serial-numbered card-level parallels existed.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Members Only","ebay_kw":"Members Only"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year BETWEEN 1991 AND 2003;

-- 2008: One-off revival; Photographer''s Proof tiers replace foil structure.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"First Day Issue /599","ebay_kw":"First Day Issue"},
  {"label":"Blue Photographer''s Proof /99","ebay_kw":"Blue Photographer''s Proof"},
  {"label":"Gold Photographer''s Proof /50","ebay_kw":"Gold Photographer''s Proof"},
  {"label":"Platinum Photographer''s Proof /1","ebay_kw":"Platinum Photographer''s Proof"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2008;

-- 2014: Modern-era reboot.  Only one numbered parallel (Foilboard /25).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Foilboard /25","ebay_kw":"Foilboard"},
  {"label":"Gold Foil","ebay_kw":"Gold Foil"},
  {"label":"Members Only","ebay_kw":"Members Only"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2014;

-- 2015: Black and Black & White foils added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Foilboard /25","ebay_kw":"Foilboard"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Gold Foil","ebay_kw":"Gold Foil"},
  {"label":"Members Only","ebay_kw":"Members Only"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2015;

-- 2016: Renamed to Rainbow Foilboard; First Day Issue /10 added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Gold Foil","ebay_kw":"Gold Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Members Only","ebay_kw":"Members Only"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2016;

-- 2017: First year with Chrome subset (90 cards, 1 per hobby box).
--   2017 foils: Blue + Gold (not Red); Chrome: base, Refractor, Gold Minted 1/1, SuperFractor 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Foil","ebay_kw":"Blue Foil"},
  {"label":"Gold Foil","ebay_kw":"Gold Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"},
  {"label":"Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2017;

-- 2018: Red + Black foil replace Blue + Gold; Members Only and Photographer''s Proof added.
--   Chrome subset identical to 2017 (no Orange yet).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"},
  {"label":"Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2018;

-- 2019: Chrome Orange Refractor /99 introduced in the Chrome subset.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"},
  {"label":"Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Orange Refractor /99","ebay_kw":"Chrome Orange Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2019;

-- 2020: Chrome is now a separate standalone product (Stadium Club Chrome row).
--   Blue Foil /50 debuts in base set.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Blue Foil /50","ebay_kw":"Blue Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2020;

-- 2021: 30th anniversary /30 parallel added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Blue Foil /50","ebay_kw":"Blue Foil"},
  {"label":"30 Years /30","ebay_kw":"30 Years"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2021;

-- 2022: Base-card (non-Chrome) SuperFractor 1/1 introduced.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Blue Foil /50","ebay_kw":"Blue Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2022;

-- 2023: Orange Foil /199 and Purple Foil /75 enter the numbered foil rainbow.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Orange Foil /199","ebay_kw":"Orange Foil"},
  {"label":"Purple Foil /75","ebay_kw":"Purple Foil"},
  {"label":"Blue Foil /50","ebay_kw":"Blue Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2023;

-- 2024: Orange /199 renamed to Green /199; Gold Foil (unnumbered, Hobby) added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Black Foil","ebay_kw":"Black Foil"},
  {"label":"Gold Foil","ebay_kw":"Gold Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Green Foil /199","ebay_kw":"Green Foil"},
  {"label":"Purple Foil /75","ebay_kw":"Purple Foil"},
  {"label":"Blue Foil /50","ebay_kw":"Blue Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"First Day Issue /10","ebay_kw":"First Day Issue"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2024;

-- 2025: Major revamp.  Blue Foil becomes unnumbered; Gold Foil /50 and
--   Turquoise Foil /99 are the new numbered tiers.  Bronze Foil is a new
--   Hobby-exclusive unnumbered tier.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red Foil","ebay_kw":"Red Foil"},
  {"label":"Bronze Foil","ebay_kw":"Bronze Foil"},
  {"label":"Blue Foil","ebay_kw":"Blue Foil"},
  {"label":"Black & White Foil","ebay_kw":"Black & White Foil"},
  {"label":"Members Only","ebay_kw":"Members Only"},
  {"label":"Photographer''s Proof","ebay_kw":"Photographer''s Proof"},
  {"label":"Green Foil /199","ebay_kw":"Green Foil"},
  {"label":"Turquoise Foil /99","ebay_kw":"Turquoise Foil"},
  {"label":"Gold Foil /50","ebay_kw":"Gold Foil"},
  {"label":"Rainbow Foilboard /25","ebay_kw":"Rainbow Foilboard"},
  {"label":"Gold Rainbow Foilboard 1/1","ebay_kw":"Gold Rainbow Foilboard"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club' AND sport = 'baseball'
  AND year = 2025;

-- ─── STADIUM CLUB CHROME ─────────────────────────────────────────────────────

-- 2020: First standalone product.  No Blue /199 or Green /99 yet.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"X-Fractor","ebay_kw":"X-Fractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2020;

-- 2021: Standalone.  X-Fractor not listed; same numbered tier as 2020.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2021;

-- 2022: Standalone (released Apr 2023).  Blue /199 and Green /99 debut.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"X-Fractor","ebay_kw":"X-Fractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Blue Refractor /199","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2022;

-- 2023: Chrome subset (90 cards) within Stadium Club; not a standalone product.
--   Purple /75 and Pearl White /30 debut; no Blue or Green tier here.
UPDATE card_sets SET parallels = '[
  {"label":"Base Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Orange Refractor /99","ebay_kw":"Chrome Orange Refractor"},
  {"label":"Chrome Purple Refractor /75","ebay_kw":"Chrome Purple Refractor"},
  {"label":"Chrome Pearl White Refractor /30","ebay_kw":"Chrome Pearl White Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2023;

-- 2024: Chrome subset now covers all 300 base cards (expanded from 90).
--   Chrome Green Refractor (unnumbered) is new.
UPDATE card_sets SET parallels = '[
  {"label":"Base Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Green Refractor","ebay_kw":"Chrome Green Refractor"},
  {"label":"Chrome Orange Refractor /99","ebay_kw":"Chrome Orange Refractor"},
  {"label":"Chrome Purple Refractor /75","ebay_kw":"Chrome Purple Refractor"},
  {"label":"Chrome Pearl White Refractor /30","ebay_kw":"Chrome Pearl White Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2024;

-- 2025: No standalone Chrome product; Chrome appears as autograph subset only.
--   Minimal structure representing the Chrome auto component.
UPDATE card_sets SET parallels = '[
  {"label":"Base Chrome","ebay_kw":"Chrome"},
  {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Gold Minted 1/1","ebay_kw":"Chrome Gold Minted"},
  {"label":"Chrome SuperFractor 1/1","ebay_kw":"Chrome SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome' AND sport = 'baseball'
  AND year = 2025;
