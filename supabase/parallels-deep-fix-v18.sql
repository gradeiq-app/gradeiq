-- =============================================================================
-- parallels-deep-fix-v18.sql
-- O-Pee-Chee Hockey — year-accurate parallels
-- brand='O-Pee-Chee', set_name='Hockey', sport='hockey'
-- Covers DB years 1958–2007 (50 rows total)
--
-- HISTORY:
--   1958–1992: Original OPC era (Canada-only base sets, no parallels)
--   1993–2003: Transition/Topps-licensed OPC era (base sets, no numbered parallels)
--   2004–2005: DELETE — 2004-05 was the NHL lockout (season cancelled) + end of
--              Topps license; 2005-06 was the gap before Upper Deck acquired OPC.
--   2006:      First Upper Deck OPC — Rainbow parallel (unnumbered)
--   2007:      Second Upper Deck OPC — Micromotion (unnumbered) + Micromotion Black /100
--
-- ACTIONS:
--   DELETE  — 2 phantom years: 2004, 2005
--   UPDATE  — 48 remaining rows
-- =============================================================================

-- ---------------------------------------------------------------------------
-- SECTION 1 — DELETE phantom years (no OPC Hockey product)
-- ---------------------------------------------------------------------------

DELETE FROM card_sets
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year IN (2004, 2005);

-- ---------------------------------------------------------------------------
-- SECTION 2 — Original OPC era 1958–1992 (no parallels)
-- Pure base sets only — Canadian counterpart to Topps Hockey;
-- cards differed in stock and bilingual text but had no parallel versions.
-- ---------------------------------------------------------------------------

UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 1958 AND 1992;

-- ---------------------------------------------------------------------------
-- SECTION 3 — Transition / Topps-licensed era 1993–2003
-- 1993-94 through 1992-93: Final OPC Company years and Topps-licensed products.
-- 1999-00 through 2003-04: Standalone Topps-produced OPC Hockey base sets.
-- These sets did not have separately-issued numbered base-card parallels
-- (the co-released "Topps" variant was distributed inside OPC packs but was
-- not tracked as a distinct numbered parallel set).
-- ---------------------------------------------------------------------------

UPDATE card_sets SET parallels = '[]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 1993 AND 2003;

-- ---------------------------------------------------------------------------
-- SECTION 4 — Upper Deck OPC era 2006–2007
-- ---------------------------------------------------------------------------

-- 2006-07 O-Pee-Chee Hockey (first Upper Deck OPC release)
-- Rainbow was the sole base parallel — a foil/prismatic version of every
-- card in the 700-card set, inserted at hobby box rates, unnumbered.
UPDATE card_sets SET parallels = '[
  {"name":"Rainbow","numbered":false,"print_run":null}
]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey' AND sport = 'hockey' AND year = 2006;

-- 2007-08 O-Pee-Chee Hockey — Micromotion redesign; Black /100 introduced
-- Micromotion: foil parallel of all 600 cards (unnumbered)
-- Micromotion Black: same design with silver/black treatment, each numbered to 100
UPDATE card_sets SET parallels = '[
  {"name":"Micromotion","numbered":false,"print_run":null},
  {"name":"Micromotion Black","numbered":true,"print_run":100}
]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey' AND sport = 'hockey' AND year = 2007;
