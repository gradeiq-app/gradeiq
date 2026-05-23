-- parallels-deep-fix-v8.sql
-- Fixes: NT Basketball 2015-2019, NT Football 2015-2018
-- Sources: CardboardConnection, ChecklistCenter

-- =====================================================================
-- NT BASKETBALL 2015-16 (year=2015)
-- Base /99 serialized; RPA Silver /25 (no Orange/Bronze/Pink)
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Silver /25", "ebay_kw": "NT RPA Silver"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Platinum /1", "ebay_kw": "NT RPA Platinum"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2015;

-- =====================================================================
-- NT BASKETBALL 2016-17 (year=2016)
-- Bronze /25 base parallel introduced; no FOTL yet
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Bronze /25", "ebay_kw": "NT Bronze"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Bronze /25", "ebay_kw": "NT RPA Bronze"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2016;

-- =====================================================================
-- NT BASKETBALL 2017-18 (year=2017)
-- Bronze /25 base; RPA adds FOTL Limited Edition /15
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Bronze /25", "ebay_kw": "NT Bronze"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Bronze /25", "ebay_kw": "NT RPA Bronze"},
  {"label": "RPA FOTL /15", "ebay_kw": "NT RPA FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2017;

-- =====================================================================
-- NT BASKETBALL 2018-19 (year=2018)
-- Bronze /39; FOTL /20 introduced; Blue FOTL /3
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Bronze /39", "ebay_kw": "NT Bronze"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA FOTL /20", "ebay_kw": "NT RPA FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA Blue FOTL /3", "ebay_kw": "NT RPA Blue FOTL"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2018;

-- =====================================================================
-- NT BASKETBALL 2019-20 (year=2019)
-- Bronze /49; FOTL Stars & Stripes /30 + Stars & Stripes Blue /3
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Bronze /49", "ebay_kw": "NT Bronze"},
  {"label": "Gold /10", "ebay_kw": "NT Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA FOTL Stars and Stripes /30", "ebay_kw": "NT RPA Stars Stripes FOTL"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Emerald /5", "ebay_kw": "NT RPA Emerald"},
  {"label": "RPA FOTL Stars and Stripes Blue /3", "ebay_kw": "NT RPA Stars Stripes Blue FOTL"},
  {"label": "RPA Logoman /1", "ebay_kw": "NT RPA Logoman"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"},
  {"label": "Shield /1", "ebay_kw": "NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'basketball' AND year = 2019;

-- =====================================================================
-- NT FOOTBALL 2015 (year=2015)
-- Jersey Number Red /88; no Purple; RPA Silver /25
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /88", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Gold /49", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Numbers Green /88", "ebay_kw": "NT RPA Numbers Green"},
  {"label": "RPA Silver /25", "ebay_kw": "NT RPA Silver"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Laundry Tag Red /3", "ebay_kw": "NT RPA Laundry Tag"},
  {"label": "RPA Brand Logo Red /2", "ebay_kw": "NT RPA Brand Logo"},
  {"label": "RPA NFL Shield /1", "ebay_kw": "NT RPA NFL Shield"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2015;

-- =====================================================================
-- NT FOOTBALL 2016 (year=2016)
-- Jersey Number Red /99; no Purple; 10th Anniversary RPA variants
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Gold /49", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Numbers Green /99", "ebay_kw": "NT RPA Numbers Green"},
  {"label": "RPA Silver /25", "ebay_kw": "NT RPA Silver"},
  {"label": "RPA Gold /10", "ebay_kw": "NT RPA Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Brand Logo Red /2", "ebay_kw": "NT RPA Brand Logo"},
  {"label": "RPA Red /1", "ebay_kw": "NT RPA Red"},
  {"label": "RPA Laundry Tag Red /1", "ebay_kw": "NT RPA Laundry Tag"},
  {"label": "RPA NFL Shield /1", "ebay_kw": "NT RPA NFL Shield"},
  {"label": "RPA 10th Anniversary /10", "ebay_kw": "NT RPA 10th Anniversary"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2016;

-- =====================================================================
-- NT FOOTBALL 2017 (year=2017)
-- Purple /75 added; Stars and Stripes FOTL /13 in RPA
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Purple /75", "ebay_kw": "NT Purple"},
  {"label": "Gold /49", "ebay_kw": "NT Gold"},
  {"label": "Silver /25", "ebay_kw": "NT Silver"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /88", "ebay_kw": "NT RPA Green Jersey"},
  {"label": "RPA Holo Silver /25", "ebay_kw": "NT RPA Holo Silver"},
  {"label": "RPA Stars and Stripes FOTL /13", "ebay_kw": "NT RPA Stars Stripes FOTL"},
  {"label": "RPA Holo Gold /10", "ebay_kw": "NT RPA Holo Gold"},
  {"label": "RPA Black /5", "ebay_kw": "NT RPA Black"},
  {"label": "RPA Red Brand Logo /2", "ebay_kw": "NT RPA Red Brand Logo"},
  {"label": "RPA Red Laundry Tag /2", "ebay_kw": "NT RPA Red Laundry Tag"},
  {"label": "RPA Platinum Shield /1", "ebay_kw": "NT RPA Platinum Shield"},
  {"label": "RPA Red /2", "ebay_kw": "NT RPA Red"},
  {"label": "Dual RPA", "ebay_kw": "NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures'
  AND sport = 'football' AND year = 2017;

-- =====================================================================
-- NT FOOTBALL 2018 (year=2018)
-- Purple /75; Midnight /20 + Stars & Stripes /20 in RPA; Hidden Treasure
-- =====================================================================
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "NT"},
  {"label": "Jersey Number Red /99", "ebay_kw": "NT Jersey Number Red"},
  {"label": "Purple /75", "ebay_kw": "NT Purple"},
  {"label": "Gold /49", "ebay_kw": "NT Gold"},
  {"label": "Holo Silver /25", "ebay_kw": "NT Holo Silver"},
  {"label": "Holo Gold /10", "ebay_kw": "NT Holo Gold"},
  {"label": "Emerald /5", "ebay_kw": "NT Emerald"},
  {"label": "Platinum /1", "ebay_kw": "NT Platinum"},
  {"label": "Printing Plate /1", "ebay_kw": "NT Printing Plate"},
  {"label": "Signature /99", "ebay_kw": "NT Signature"},
  {"label": "Signature Gold /10", "ebay_kw": "NT Signature Gold"},
  {"label": "Signature Black /1", "ebay_kw": "NT Signature Black"},
  {"label": "RPA /99", "ebay_kw": "NT RPA"},
  {"label": "RPA Green Jersey /86", "ebay_kw": "NT RPA Green Jersey"},
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
  AND sport = 'football' AND year = 2018;
