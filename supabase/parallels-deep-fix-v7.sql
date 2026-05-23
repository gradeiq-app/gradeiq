-- parallels-deep-fix-v7.sql
-- Fixes: NT Basketball 2020-22, NT Football 2019-21,
--        NT RPA Football 2019-21, WNBA NT 2023-24
-- Sources: CardboardConnection, ChecklistCenter, ChecklistInsider

-- =====================================================================
-- NT BASKETBALL 2020-21 (year=2020)
-- New structure: Bronze /49 base parallels, FOTL RPA introduced
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Bronze /49", "ebay_kw": "NT Bronze"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Amethyst /3", "ebay_kw": "NT Amethyst"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Gold FOTL /24", "ebay_kw": "NT RPA Gold FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Purple FOTL /8", "ebay_kw": "NT RPA Purple FOTL"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Blue FOTL /3", "ebay_kw": "NT RPA Blue FOTL"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2020;

-- =====================================================================
-- NT BASKETBALL 2021-22 (year=2021)
-- NBA 75th Anniversary parallel, expanded RPA with FOTL
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "NBA 75th /75", "ebay_kw": "NT NBA 75th"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Amethyst /3", "ebay_kw": "NT Amethyst"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA NBA 75th /75", "ebay_kw": "NT RPA NBA 75th"},
  {"label": "RPA Bronze /49", "ebay_kw": "NT RPA Bronze"},
  {"label": "RPA Pink /25", "ebay_kw": "NT RPA Pink"},
  {"label": "RPA Gold FOTL /24", "ebay_kw": "NT RPA Gold FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Purple FOTL /8", "ebay_kw": "NT RPA Purple FOTL"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Blue FOTL /3", "ebay_kw": "NT RPA Blue FOTL"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2021;

-- =====================================================================
-- NT BASKETBALL 2022-23 (year=2022) — COMPLETE REBUILD
-- Red /75 base parallel; Blue FOTL changed to /5 (not /3)
-- Old entry had wrong Holo Silver /99 + wrong Blue FOTL /3
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Red /75", "ebay_kw": "NT Red"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Amethyst /3", "ebay_kw": "NT Amethyst"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Red /75", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Bronze /49", "ebay_kw": "NT RPA Bronze"},
  {"label": "RPA Pink /25", "ebay_kw": "NT RPA Pink"},
  {"label": "RPA Gold FOTL /24", "ebay_kw": "NT RPA Gold FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Purple FOTL /8", "ebay_kw": "NT RPA Purple FOTL"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Blue FOTL /5", "ebay_kw": "NT RPA Blue FOTL"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2022;

-- =====================================================================
-- NT FOOTBALL 2019 (year=2019)
-- Purple /50, no Midnight/Stars & Stripes yet; simpler RPA structure
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Purple /50", "ebay_kw": "NT Purple"},
  {"label": "Gold /35", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Red Brand Logo /1", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2019;

-- =====================================================================
-- NT FOOTBALL 2020 (year=2020)
-- Stars & Stripes /11 introduced; complex RPA with Midnight /20, S&S /20
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Purple /50", "ebay_kw": "NT Purple"},
  {"label": "Gold /35", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Stars and Stripes /11", "ebay_kw": "NT Stars Stripes"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /99", "ebay_kw": "NT RPA Green Jersey"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Midnight /20", "ebay_kw": "NT RPA Midnight"},
  {"label": "RPA Stars and Stripes /20", "ebay_kw": "NT RPA Stars Stripes"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Hidden Treasure /5", "ebay_kw": "NT RPA Hidden Treasure"},
  {"label": "RPA Stars and Stripes Premium /3", "ebay_kw": "NT RPA Stars Stripes Premium"},
  {"label": "RPA Red Brand Logo /2", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2020;

-- =====================================================================
-- NT FOOTBALL 2021 (year=2021)
-- Purple /49, Midnight /20, Stars & Stripes /13; RPA adds S&S Blue /10
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Purple /49", "ebay_kw": "NT Purple"},
  {"label": "Gold /35", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Midnight /20", "ebay_kw": "NT Midnight"},
  {"label": "Stars and Stripes /13", "ebay_kw": "NT Stars Stripes"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /89", "ebay_kw": "NT RPA Green Jersey"},
  {"label": "RPA Purple /49", "ebay_kw": "NT RPA Purple"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Midnight /20", "ebay_kw": "NT RPA Midnight"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Stars and Stripes Blue /10", "ebay_kw": "NT RPA Stars Stripes Blue"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Red Brand Logo /1", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2021;

-- =====================================================================
-- NT RPA FOOTBALL 2019 (separate standalone RPA entry)
-- Simple structure: /99, Holo Silver /25, Holo Gold /10, Black /5, 1/1s
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Red Brand Logo /1", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football' AND year = 2019;

-- =====================================================================
-- NT RPA FOOTBALL 2020 (separate standalone RPA entry)
-- S&S /20, Midnight /20, Hidden Treasure /5, S&S Premium /3
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /99", "ebay_kw": "NT RPA Green Jersey"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Midnight /20", "ebay_kw": "NT RPA Midnight"},
  {"label": "RPA Stars and Stripes /20", "ebay_kw": "NT RPA Stars Stripes"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Hidden Treasure /5", "ebay_kw": "NT RPA Hidden Treasure"},
  {"label": "RPA Stars and Stripes Premium /3", "ebay_kw": "NT RPA Stars Stripes Premium"},
  {"label": "RPA Red Brand Logo /2", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football' AND year = 2020;

-- =====================================================================
-- NT RPA FOOTBALL 2021 (separate standalone RPA entry)
-- Purple /49, S&S Blue /10, Midnight /20; Green Jersey /89
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /89", "ebay_kw": "NT RPA Green Jersey"},
  {"label": "RPA Purple /49", "ebay_kw": "NT RPA Purple"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Midnight /20", "ebay_kw": "NT RPA Midnight"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Stars and Stripes Blue /10", "ebay_kw": "NT RPA Stars Stripes Blue"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Red Brand Logo /1", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Red Laundry Tag /1", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "RPA Printing Plate /1", "ebay_kw": "NT RPA Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football' AND year = 2021;

-- =====================================================================
-- NATIONAL TREASURES WNBA 2023 (year=2023)
-- Based on Rookie Royalty WNBA NT subset structure
-- RPA /49 base + All-Star Patch Auto /24 subset
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "RPA /49", "ebay_kw": "NT WNBA RPA"},
  {"label": "RPA Bronze /25", "ebay_kw": "NT WNBA RPA Bronze"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT WNBA RPA Holo Gold"},
  {"label": "RPA Green /5", "ebay_kw": "NT WNBA RPA Green"},
  {"label": "RPA Holo Platinum Blue /1", "ebay_kw": "NT WNBA RPA Platinum"},
  {"label": "RPA WNBA Logo /1", "ebay_kw": "NT WNBA Logo"},
  {"label": "All-Star Patch Auto /24", "ebay_kw": "NT WNBA All-Star Patch"},
  {"label": "All-Star Patch Auto Holo Gold /10", "ebay_kw": "NT WNBA All-Star Holo Gold"},
  {"label": "All-Star Patch Auto Holo Platinum /1", "ebay_kw": "NT WNBA All-Star Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures WNBA'
  AND sport = 'wnba' AND year = 2023;

-- =====================================================================
-- NATIONAL TREASURES WNBA 2024 (year=2024)
-- Same Rookie Royalty WNBA NT structure as 2023
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "RPA /49", "ebay_kw": "NT WNBA RPA"},
  {"label": "RPA Bronze /25", "ebay_kw": "NT WNBA RPA Bronze"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT WNBA RPA Holo Gold"},
  {"label": "RPA Green /5", "ebay_kw": "NT WNBA RPA Green"},
  {"label": "RPA Holo Platinum Blue /1", "ebay_kw": "NT WNBA RPA Platinum"},
  {"label": "RPA WNBA Logo /1", "ebay_kw": "NT WNBA Logo"},
  {"label": "All-Star Patch Auto /24", "ebay_kw": "NT WNBA All-Star Patch"},
  {"label": "All-Star Patch Auto Holo Gold /10", "ebay_kw": "NT WNBA All-Star Holo Gold"},
  {"label": "All-Star Patch Auto Holo Platinum /1", "ebay_kw": "NT WNBA All-Star Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures WNBA'
  AND sport = 'wnba' AND year = 2024;
