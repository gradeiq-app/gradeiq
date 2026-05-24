-- ============================================================
-- parallels-deep-fix-v9.sql
-- Panini Chronicles Basketball (2018–2022) + Football (2019–2022)
-- Removes phantom years that never existed as products
-- ============================================================

-- ============================================================
-- STEP 1: DELETE PHANTOM ENTRIES
-- Chronicles Football did NOT exist until 2019 (NFL debut).
-- No regular-season NFL Chronicles exists for 2023, 2024, or 2025.
-- Chronicles Basketball had no 2023-24 or 2024-25 release.
-- ============================================================

DELETE FROM card_sets
WHERE brand = 'Panini'
  AND set_name = 'Chronicles'
  AND sport = 'football'
  AND year IN (2016, 2017, 2018, 2023, 2024, 2025);

DELETE FROM card_sets
WHERE brand = 'Panini'
  AND set_name = 'Chronicles'
  AND sport = 'basketball'
  AND year IN (2023, 2024);

-- ============================================================
-- STEP 2: FIX CHRONICLES BASKETBALL PARALLELS (2018–2022)
-- Source: CardboardConnection.com per-year checklists
-- Current DB wrong: "Pink /199, Blue /99, Green /75, Gold /25"
-- Actual: Red /149 base, tiered down to Platinum /1
-- ============================================================

-- 2018-19: Red /149, Blue /99, Purple /49, Gold /10, Platinum /1
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /149", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /149", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'basketball' AND year = 2018;

-- 2019-20: same structure
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /149", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /149", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'basketball' AND year = 2019;

-- 2020-21: same structure
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /149", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /149", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'basketball' AND year = 2020;

-- 2021-22: adds 75th Anniversary /75 (NBA 75th anniversary season)
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /149", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "75th Anniversary /75", "ebay_kw": "Chronicles 75th Anniversary"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /149", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto 75th Anniversary /75", "ebay_kw": "Chronicles Rookie Auto 75th"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'basketball' AND year = 2021;

-- 2022-23: adds Orange /75 and Swirl /25 (replaces 75th Anniversary)
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /149", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Orange /75", "ebay_kw": "Chronicles Orange"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Swirl /25", "ebay_kw": "Chronicles Swirl"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /149", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Orange /75", "ebay_kw": "Chronicles Rookie Auto Orange"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Swirl /25", "ebay_kw": "Chronicles Rookie Auto Swirl"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'basketball' AND year = 2022;

-- ============================================================
-- STEP 3: FIX CHRONICLES FOOTBALL PARALLELS (2019–2022)
-- Source: CardboardConnection.com per-year checklists
-- NOTE: 2021 Red is /399 (confirmed, not /199)
-- ============================================================

-- 2019: first year; Red /199, Blue /99, Purple /49, Gold /10, Platinum /1
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /199", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /199", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'football' AND year = 2019;

-- 2020: adds Black /25 between Purple and Gold
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /199", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Black /25", "ebay_kw": "Chronicles Black"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /199", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Black /25", "ebay_kw": "Chronicles Rookie Auto Black"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'football' AND year = 2020;

-- 2021: Red /399 (unusually high print run for this year), Black /25 retained
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /399", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Black /25", "ebay_kw": "Chronicles Black"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /399", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Black /25", "ebay_kw": "Chronicles Rookie Auto Black"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'football' AND year = 2021;

-- 2022: Red /199 (back to /199), Black /25 retained
UPDATE card_sets
SET parallels = '[
  {"label": "Base", "ebay_kw": "Chronicles"},
  {"label": "Red /199", "ebay_kw": "Chronicles Red"},
  {"label": "Blue /99", "ebay_kw": "Chronicles Blue"},
  {"label": "Purple /49", "ebay_kw": "Chronicles Purple"},
  {"label": "Black /25", "ebay_kw": "Chronicles Black"},
  {"label": "Gold /10", "ebay_kw": "Chronicles Gold"},
  {"label": "Platinum /1", "ebay_kw": "Chronicles Platinum"},
  {"label": "Rookie Auto", "ebay_kw": "Chronicles Rookie Auto"},
  {"label": "Rookie Auto Red /199", "ebay_kw": "Chronicles Rookie Auto Red"},
  {"label": "Rookie Auto Blue /99", "ebay_kw": "Chronicles Rookie Auto Blue"},
  {"label": "Rookie Auto Purple /49", "ebay_kw": "Chronicles Rookie Auto Purple"},
  {"label": "Rookie Auto Black /25", "ebay_kw": "Chronicles Rookie Auto Black"},
  {"label": "Rookie Auto Gold /10", "ebay_kw": "Chronicles Rookie Auto Gold"},
  {"label": "Rookie Auto Platinum /1", "ebay_kw": "Chronicles Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles' AND sport = 'football' AND year = 2022;
