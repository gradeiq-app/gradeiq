-- ============================================================
-- parallels-deep-fix-v10.sql
-- NT Basketball 2009-2014 + NT Football 2010-2014
-- Replaces wrong generic "Holo Silver /99, Holo Gold /25, Holo Black /5"
-- with verified year-specific parallel structures.
-- Also deletes phantom NT Basketball 2011 (no product released due to NBA lockout).
-- ============================================================

-- ============================================================
-- STEP 1: DELETE PHANTOM ENTRIES
-- No 2011-12 NBA NT was released (NBA lockout prevented it).
-- ============================================================

DELETE FROM card_sets
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'basketball'
  AND year = 2011;

-- ============================================================
-- STEP 2: NT BASKETBALL 2009-2014
-- Sources: CardboardConnection, SportsCardRadio per-year checklists
-- ============================================================

-- 2009-10 (year=2009): Century Silver /25, Century Gold /10, Century Platinum /1
-- RPA: base /99, Century Signature Prime /25
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Platinum /1", "ebay_kw": "National Treasures Century Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Prime /25", "ebay_kw": "National Treasures RPA Prime"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball' AND year = 2009;

-- 2010-11 (year=2010): Unusually low base parallels; Silver /10, Gold /5, Platinum /1
-- RPA: Gold /25, Platinum /5, Black /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Silver /10", "ebay_kw": "National Treasures Silver"},
  {"label": "Gold /5", "ebay_kw": "National Treasures Gold"},
  {"label": "Platinum /1", "ebay_kw": "National Treasures Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /25", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Black /1", "ebay_kw": "National Treasures RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball' AND year = 2010;

-- year=2011 DELETED above (no product)

-- 2012-13 (year=2012): Silver /25, Gold /10, Platinum /1
-- RPA: Jersey Number /25, Gold Horizontal /5, Logoman /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Silver /25", "ebay_kw": "National Treasures Silver"},
  {"label": "Gold /10", "ebay_kw": "National Treasures Gold"},
  {"label": "Platinum /1", "ebay_kw": "National Treasures Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Jersey Number /25", "ebay_kw": "National Treasures RPA Jersey Number"},
  {"label": "RPA Gold Horizontal /5", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Logoman /1", "ebay_kw": "National Treasures RPA Logoman"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball' AND year = 2012;

-- 2013-14 (year=2013): Gold /25, Platinum /1 (Silver dropped)
-- RPA: Gold Proof /25, Horizontal /10, Platinum /5, Logoman /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Gold /25", "ebay_kw": "National Treasures Gold"},
  {"label": "Platinum /1", "ebay_kw": "National Treasures Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold Proof /25", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Horizontal /10", "ebay_kw": "National Treasures RPA Horizontal"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Logoman /1", "ebay_kw": "National Treasures RPA Logoman"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball' AND year = 2013;

-- 2014-15 (year=2014): Blue /25, Gold /10, Emerald /5, Platinum /1
-- RPA: Gold /25, Horizontal /10, Platinum /5, Horizontal Logoman /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Blue /25", "ebay_kw": "National Treasures Blue"},
  {"label": "Gold /10", "ebay_kw": "National Treasures Gold"},
  {"label": "Emerald /5", "ebay_kw": "National Treasures Emerald"},
  {"label": "Platinum /1", "ebay_kw": "National Treasures Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /25", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Horizontal /10", "ebay_kw": "National Treasures RPA Horizontal"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Horizontal Logoman /1", "ebay_kw": "National Treasures RPA Logoman"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball' AND year = 2014;

-- ============================================================
-- STEP 3: NT FOOTBALL 2010-2014
-- Sources: CardboardConnection, SportsCardRadio per-year checklists
-- ============================================================

-- 2010: Century Silver /25, Century Gold /10, Century Platinum /1
-- RPA: base /99 only (no confirmed numbered parallels for RPA)
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Platinum /1", "ebay_kw": "National Treasures Century Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football' AND year = 2010;

-- 2011: Century Silver /25, Century Gold /10, Century Platinum /1
-- RPA: Gold /49, Black /25, Platinum /5, Red /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Platinum /1", "ebay_kw": "National Treasures Century Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /49", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Black /25", "ebay_kw": "National Treasures RPA Black"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Red /1", "ebay_kw": "National Treasures RPA Red"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football' AND year = 2011;

-- 2012: same structure as 2011
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Platinum /1", "ebay_kw": "National Treasures Century Platinum"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /49", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Black /25", "ebay_kw": "National Treasures RPA Black"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Red /1", "ebay_kw": "National Treasures RPA Red"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football' AND year = 2012;

-- 2013: adds Century Black /5 and Century Blue /1 to base; RPA adds Nike Swoosh /2, NFL Shield /1
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Black /5", "ebay_kw": "National Treasures Century Black"},
  {"label": "Century Blue /1", "ebay_kw": "National Treasures Century Blue"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /49", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Black /25", "ebay_kw": "National Treasures RPA Black"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Nike Swoosh /2", "ebay_kw": "National Treasures RPA Swoosh"},
  {"label": "RPA NFL Shield /1", "ebay_kw": "National Treasures RPA Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football' AND year = 2013;

-- 2014: same as 2013
UPDATE card_sets SET parallels = '[
  {"label": "Base /99", "ebay_kw": "National Treasures"},
  {"label": "Century Silver /25", "ebay_kw": "National Treasures Century Silver"},
  {"label": "Century Gold /10", "ebay_kw": "National Treasures Century Gold"},
  {"label": "Century Black /5", "ebay_kw": "National Treasures Century Black"},
  {"label": "Century Blue /1", "ebay_kw": "National Treasures Century Blue"},
  {"label": "RPA /99", "ebay_kw": "National Treasures RPA"},
  {"label": "RPA Gold /49", "ebay_kw": "National Treasures RPA Gold"},
  {"label": "RPA Black /25", "ebay_kw": "National Treasures RPA Black"},
  {"label": "RPA Platinum /5", "ebay_kw": "National Treasures RPA Platinum"},
  {"label": "RPA Nike Swoosh /2", "ebay_kw": "National Treasures RPA Swoosh"},
  {"label": "RPA NFL Shield /1", "ebay_kw": "National Treasures RPA Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football' AND year = 2014;
