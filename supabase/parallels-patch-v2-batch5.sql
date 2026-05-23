-- ─────────────────────────────────────────────────────────────────────────────
-- Batch 5: INSERT missing popular sets + FIX remaining sparse parallels
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Crown Royale Football 2015-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Crown Royale',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Platinum /10","ebay_kw":"Platinum"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Silhouette Patch Auto /99","ebay_kw":"Rookie Silhouette Patch Auto"},
  {"label":"RSPA Blue /49","ebay_kw":"Rookie Silhouette Patch Auto Blue"},
  {"label":"RSPA Purple /25","ebay_kw":"Rookie Silhouette Patch Auto Purple"},
  {"label":"RSPA Gold /10","ebay_kw":"Rookie Silhouette Patch Auto Gold"},
  {"label":"RSPA Black /1","ebay_kw":"Rookie Silhouette Patch Auto Black"},
  {"label":"Rookie Royale Auto","ebay_kw":"Rookie Royale Auto"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"}
]'::jsonb
FROM generate_series(2015,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Crown Royale Basketball 2015-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Crown Royale',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Platinum /10","ebay_kw":"Platinum"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Royale Auto /99","ebay_kw":"Rookie Royale Auto"},
  {"label":"Rookie Royale Auto Blue /49","ebay_kw":"Rookie Royale Auto Blue"},
  {"label":"Rookie Royale Auto Purple /25","ebay_kw":"Rookie Royale Auto Purple"},
  {"label":"Rookie Royale Auto Gold /10","ebay_kw":"Rookie Royale Auto Gold"},
  {"label":"Rookie Royale Auto Black /1","ebay_kw":"Rookie Royale Auto Black"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"}
]'::jsonb
FROM generate_series(2015,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Bowman Chrome Football 2011-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Bowman', 'Chrome',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"RC Auto Refractor"},
  {"label":"RC Auto Blue /150","ebay_kw":"RC Auto Blue Refractor"},
  {"label":"RC Auto Green /99","ebay_kw":"RC Auto Green Refractor"},
  {"label":"RC Auto Gold /50","ebay_kw":"RC Auto Gold Refractor"},
  {"label":"RC Auto Orange /25","ebay_kw":"RC Auto Orange Refractor"},
  {"label":"RC Auto Red /5","ebay_kw":"RC Auto Red Refractor"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"RC Auto Superfractor"}
]'::jsonb
FROM generate_series(2011,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Topps Platinum Football 2010-2015
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Platinum',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Ruby /399","ebay_kw":"Ruby"},
  {"label":"Blue /250","ebay_kw":"Blue"},
  {"label":"Xfractor /199","ebay_kw":"X-Fractor"},
  {"label":"Green /150","ebay_kw":"Green"},
  {"label":"Orange /99","ebay_kw":"Orange"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Blue /250","ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Orange /99","ebay_kw":"RC Auto Orange"},
  {"label":"RC Auto Gold /25","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /1","ebay_kw":"RC Auto Black"}
]'::jsonb
FROM generate_series(2010,2015) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Dominion Basketball 2014-2021
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Dominion',
'[
  {"label":"Base /99","ebay_kw":""},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Red /15","ebay_kw":"Red"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Auto /199","ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Gold /99","ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Blue /49","ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /25","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /49","ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Black /1","ebay_kw":"Rookie Patch Auto Black"}
]'::jsonb
FROM generate_series(2014,2021) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Limited Basketball 2014-2022
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Limited',
'[
  {"label":"Base /199","ebay_kw":""},
  {"label":"Silver /150","ebay_kw":"Silver"},
  {"label":"Gold /99","ebay_kw":"Gold"},
  {"label":"Emerald /49","ebay_kw":"Emerald"},
  {"label":"Sapphire /25","ebay_kw":"Sapphire"},
  {"label":"Ruby /5","ebay_kw":"Ruby"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /49","ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Emerald /25","ebay_kw":"Rookie Patch Auto Emerald"},
  {"label":"RPA Ruby /5","ebay_kw":"Rookie Patch Auto Ruby"},
  {"label":"RPA Black /1","ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Phenoms Jersey Auto","ebay_kw":"Phenoms Jersey Auto"},
  {"label":"Limelight Auto","ebay_kw":"Limelight Auto"}
]'::jsonb
FROM generate_series(2014,2022) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Black Basketball 2014-2022
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Black',
'[
  {"label":"Base /99","ebay_kw":""},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Platinum /10","ebay_kw":"Platinum"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /25","ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Platinum /10","ebay_kw":"Rookie Patch Auto Platinum"},
  {"label":"RPA Black /1","ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Logoman Patch Auto /1","ebay_kw":"Logoman Patch Auto"},
  {"label":"Inking History Auto","ebay_kw":"Inking History Auto"}
]'::jsonb
FROM generate_series(2014,2022) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Upper Deck Chronology Basketball 2018-2023
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Upper Deck', 'Chronology',
'[
  {"label":"Base /299","ebay_kw":""},
  {"label":"Gold /99","ebay_kw":"Gold"},
  {"label":"Blue /49","ebay_kw":"Blue"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Etchings Auto","ebay_kw":"Etchings Auto"},
  {"label":"Etchings Auto Gold /99","ebay_kw":"Etchings Auto Gold"},
  {"label":"Etchings Auto Blue /49","ebay_kw":"Etchings Auto Blue"},
  {"label":"Etchings Auto Green /25","ebay_kw":"Etchings Auto Green"},
  {"label":"Etchings Auto Red /10","ebay_kw":"Etchings Auto Red"},
  {"label":"Etchings Auto Black /1","ebay_kw":"Etchings Auto Black"},
  {"label":"Rookie Etchings Auto","ebay_kw":"Rookie Etchings Auto"}
]'::jsonb
FROM generate_series(2018,2023) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Revolution Hockey 2019-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Panini', 'Revolution',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Astro","ebay_kw":"Astro"},
  {"label":"Cubic","ebay_kw":"Cubic"},
  {"label":"Infinite","ebay_kw":"Infinite"},
  {"label":"Sunburst","ebay_kw":"Sunburst"},
  {"label":"Blue /149","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Galactic /10","ebay_kw":"Galactic"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Auto","ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /149","ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Rookie Auto Black"}
]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Upper Deck Engrained Hockey 2014-2023
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Engrained',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Autumn /225","ebay_kw":"Autumn"},
  {"label":"Winter /99","ebay_kw":"Winter"},
  {"label":"Spring /49","ebay_kw":"Spring"},
  {"label":"Summer /15","ebay_kw":"Summer"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"Rookie Engrained Auto","ebay_kw":"Rookie Engrained Auto"},
  {"label":"RC Auto Winter /99","ebay_kw":"RC Auto Winter"},
  {"label":"RC Auto Spring /49","ebay_kw":"RC Auto Spring"},
  {"label":"RC Auto Summer /15","ebay_kw":"RC Auto Summer"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
FROM generate_series(2014,2023) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Topps Black Baseball 2007-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Black',
'[
  {"label":"Base /100","ebay_kw":"Black Edition"},
  {"label":"1/1 Relic","ebay_kw":"Relic"},
  {"label":"Autograph /25","ebay_kw":"Autograph"},
  {"label":"Dual Autograph /10","ebay_kw":"Dual Autograph"},
  {"label":"Triple Autograph /5","ebay_kw":"Triple Autograph"},
  {"label":"Cut Autograph /1","ebay_kw":"Cut Autograph"}
]'::jsonb
FROM generate_series(2007,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Topps Clearly Authentic Baseball 2019-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Clearly Authentic',
'[
  {"label":"Base Auto /99","ebay_kw":"Clearly Authentic Auto"},
  {"label":"Blue /75","ebay_kw":"Blue"},
  {"label":"Orange /50","ebay_kw":"Orange"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Rookie Auto /99","ebay_kw":"Rookie Auto"},
  {"label":"Clearly Die-Cut","ebay_kw":"Die Cut"}
]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Leaf Metal Baseball 2020-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Leaf', 'Metal',
'[
  {"label":"Base Auto","ebay_kw":"Leaf Metal Auto"},
  {"label":"Prismatic /50","ebay_kw":"Prismatic"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Blue /5","ebay_kw":"Blue"},
  {"label":"Gold /1","ebay_kw":"Gold"},
  {"label":"Pink /10","ebay_kw":"Pink"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Orange /50","ebay_kw":"Orange"}
]'::jsonb
FROM generate_series(2020,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Donruss Elite Football 2000-2022 (not in DB)
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Donruss', 'Elite',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /499","ebay_kw":"Gold"},
  {"label":"Status /100","ebay_kw":"Status"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Ticket Auto /999","ebay_kw":"Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Gold /499","ebay_kw":"Rookie Ticket Auto Gold"},
  {"label":"Rookie Ticket Auto Status /100","ebay_kw":"Rookie Ticket Auto Status"},
  {"label":"Rookie Ticket Auto Green /25","ebay_kw":"Rookie Ticket Auto Green"},
  {"label":"Rookie Ticket Auto Black /1","ebay_kw":"Rookie Ticket Auto Black"},
  {"label":"Passing the Torch Auto","ebay_kw":"Passing the Torch Auto"}
]'::jsonb
FROM generate_series(2000,2022) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Topps Five Star Football 2014-2022
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Five Star',
'[
  {"label":"Base /150","ebay_kw":""},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Green /50","ebay_kw":"Green"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Auto /150","ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /99","ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Green /50","ebay_kw":"Rookie Auto Green"},
  {"label":"Rookie Auto Orange /25","ebay_kw":"Rookie Auto Orange"},
  {"label":"Rookie Auto Red /10","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Autograph Patch /50","ebay_kw":"Rookie Autograph Patch"}
]'::jsonb
FROM generate_series(2014,2022) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Topps Inception Football 2019-2024
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Inception',
'[
  {"label":"Base /250","ebay_kw":""},
  {"label":"Orange /150","ebay_kw":"Orange"},
  {"label":"Green /99","ebay_kw":"Green"},
  {"label":"Blue /75","ebay_kw":"Blue"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Orange /150","ebay_kw":"Rookie Patch Auto Orange"},
  {"label":"RPA Green /99","ebay_kw":"Rookie Patch Auto Green"},
  {"label":"RPA Blue /75","ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"RPA Red /25","ebay_kw":"Rookie Patch Auto Red"},
  {"label":"RPA Gold /10","ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Black /5","ebay_kw":"Rookie Patch Auto Black"},
  {"label":"RPA Platinum /1","ebay_kw":"Rookie Patch Auto Platinum"}
]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- NEW SETS: Panini Preferred Football/Basketball 2013-2016
-- ═══════════════════════════════════════════════════════════════════════════════
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Preferred',
'[
  {"label":"Base","ebay_kw":""},
  {"label":"Rookie Premiere Patch Auto /99","ebay_kw":"Rookie Premiere Patch Auto"},
  {"label":"RPPA Blue /49","ebay_kw":"Rookie Premiere Patch Auto Blue"},
  {"label":"RPPA Gold /25","ebay_kw":"Rookie Premiere Patch Auto Gold"},
  {"label":"RPPA Black /1","ebay_kw":"Rookie Premiere Patch Auto Black"},
  {"label":"Team Colors Booklet","ebay_kw":"Team Colors Booklet"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"}
]'::jsonb
FROM generate_series(2013,2016) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Black Football (sparse)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /99","ebay_kw":""},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Platinum /10","ebay_kw":"Platinum"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /25","ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Platinum /10","ebay_kw":"Rookie Patch Auto Platinum"},
  {"label":"RPA Black /1","ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Logoman Patch Auto /1","ebay_kw":"Logoman Patch Auto"},
  {"label":"Inking History Auto","ebay_kw":"Inking History Auto"},
  {"label":"Dual Rookie Patch Auto","ebay_kw":"Dual Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Black' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Donruss Elite Football (sparse)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /499","ebay_kw":"Gold"},
  {"label":"Status /100","ebay_kw":"Status"},
  {"label":"Green /25","ebay_kw":"Green"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Ticket Auto /999","ebay_kw":"Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Gold /499","ebay_kw":"Rookie Ticket Auto Gold"},
  {"label":"Rookie Ticket Auto Status /100","ebay_kw":"Rookie Ticket Auto Status"},
  {"label":"Rookie Ticket Auto Green /25","ebay_kw":"Rookie Ticket Auto Green"},
  {"label":"Rookie Ticket Auto Black /1","ebay_kw":"Rookie Ticket Auto Black"},
  {"label":"Passing the Torch Auto","ebay_kw":"Passing the Torch Auto"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Contenders Optic Football (only 7 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rookie Ticket Auto","ebay_kw":"Rookie Ticket Auto"},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Blue /149","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket Auto Holo","ebay_kw":"Rookie Ticket Auto Holo"},
  {"label":"Rookie Ticket Auto Orange /199","ebay_kw":"Rookie Ticket Auto Orange"},
  {"label":"Rookie Ticket Auto Blue /149","ebay_kw":"Rookie Ticket Auto Blue"},
  {"label":"Rookie Ticket Auto Red /99","ebay_kw":"Rookie Ticket Auto Red"},
  {"label":"Rookie Ticket Auto Purple /49","ebay_kw":"Rookie Ticket Auto Purple"},
  {"label":"Rookie Ticket Auto Gold /10","ebay_kw":"Rookie Ticket Auto Gold"},
  {"label":"Rookie Ticket Auto Black /1","ebay_kw":"Rookie Ticket Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini NT RPA standalone football
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"RPA /99","ebay_kw":"RPA"},
  {"label":"RPA Holo Silver /49","ebay_kw":"RPA Holo Silver"},
  {"label":"RPA Gold /25","ebay_kw":"RPA Gold"},
  {"label":"RPA Emerald /10","ebay_kw":"RPA Emerald"},
  {"label":"RPA Platinum /5","ebay_kw":"RPA Platinum"},
  {"label":"RPA Black /1","ebay_kw":"RPA Black"},
  {"label":"Shield Patch Auto /1","ebay_kw":"Shield Patch Auto"},
  {"label":"Logoman Patch Auto /1","ebay_kw":"Logoman Patch Auto"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures Rookie Patch Auto';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Honors Football
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Jersey Auto","ebay_kw":"Rookie Jersey Auto"},
  {"label":"Rookie Jersey Auto Blue /199","ebay_kw":"Rookie Jersey Auto Blue"},
  {"label":"Rookie Jersey Auto Red /99","ebay_kw":"Rookie Jersey Auto Red"},
  {"label":"Rookie Jersey Auto Gold /25","ebay_kw":"Rookie Jersey Auto Gold"},
  {"label":"Rookie Jersey Auto Black /1","ebay_kw":"Rookie Jersey Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Honors';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Donruss Downtown Football
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Holo","ebay_kw":"Holo"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Rookie Auto Holo","ebay_kw":"Rookie Auto Holo"},
  {"label":"Rookie Auto Red /199","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Blue /99","ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Gold /10","ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Downtown';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Score Rookie & Traded Football
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Rookie Auto","ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Red /199","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /50","ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /10","ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Score Rookie & Traded';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Contenders Rookie Ticket Auto Basketball (only 4 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Rookie Ticket Auto","ebay_kw":"Rookie Ticket Auto"},
  {"label":"Season Ticket /249","ebay_kw":"Season Ticket"},
  {"label":"Cracked Ice /25","ebay_kw":"Cracked Ice"},
  {"label":"Championship Ticket /10","ebay_kw":"Championship Ticket"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket Auto Cracked Ice /25","ebay_kw":"Rookie Ticket Auto Cracked Ice"},
  {"label":"Rookie Ticket Auto Championship /10","ebay_kw":"Rookie Ticket Auto Championship"},
  {"label":"Rookie Ticket Auto Printing Plate /1","ebay_kw":"Rookie Ticket Auto Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Rookie Ticket Auto';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Chrome Basketball (only 5-7 parallels — needs full refractor tree)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Wave Refractor /150","ebay_kw":"Blue Wave Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"RC Auto Refractor"},
  {"label":"RC Auto Blue /150","ebay_kw":"RC Auto Blue Refractor"},
  {"label":"RC Auto Green /99","ebay_kw":"RC Auto Green Refractor"},
  {"label":"RC Auto Gold /50","ebay_kw":"RC Auto Gold Refractor"},
  {"label":"RC Auto Orange /25","ebay_kw":"RC Auto Orange Refractor"},
  {"label":"RC Auto Red /5","ebay_kw":"RC Auto Red Refractor"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"RC Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Finest Basketball (sparse)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Wave Refractor /150","ebay_kw":"Blue Wave Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"Finest Auto Refractor","ebay_kw":"Finest Auto Refractor"},
  {"label":"Finest Auto Blue /150","ebay_kw":"Finest Auto Blue"},
  {"label":"Finest Auto Gold /50","ebay_kw":"Finest Auto Gold"},
  {"label":"Finest Auto Orange /25","ebay_kw":"Finest Auto Orange"},
  {"label":"Finest Auto Red /5","ebay_kw":"Finest Auto Red"},
  {"label":"Finest Auto SuperFractor /1","ebay_kw":"Finest Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck SP Authentic Baseball (only 3 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /250","ebay_kw":"Gold"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times Auto"},
  {"label":"SOT Auto Gold /100","ebay_kw":"Sign of the Times Auto Gold"},
  {"label":"SOT Auto Blue /25","ebay_kw":"Sign of the Times Auto Blue"},
  {"label":"SOT Auto Black /5","ebay_kw":"Sign of the Times Auto Black"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Gold /250","ebay_kw":"Future Watch Auto Gold"},
  {"label":"Authentic Moments Auto","ebay_kw":"Authentic Moments Auto"},
  {"label":"SPA Chirography Auto","ebay_kw":"Chirography Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck SP Authentic Football (only 3 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /250","ebay_kw":"Gold"},
  {"label":"Limited /100","ebay_kw":"Limited"},
  {"label":"Sign of the Times Auto","ebay_kw":"Sign of the Times Auto"},
  {"label":"SOT Auto Gold /100","ebay_kw":"Sign of the Times Auto Gold"},
  {"label":"SOT Auto Blue /25","ebay_kw":"Sign of the Times Auto Blue"},
  {"label":"SOT Auto Black /5","ebay_kw":"Sign of the Times Auto Black"},
  {"label":"Future Watch Auto /999","ebay_kw":"Future Watch Auto"},
  {"label":"Authentic Moments Auto","ebay_kw":"Authentic Moments Auto"},
  {"label":"SPA Patch Auto /99","ebay_kw":"Patch Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Five Star Baseball (only 3 parallels — premium product)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /150","ebay_kw":""},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Green /50","ebay_kw":"Green"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Autograph /150","ebay_kw":"Autograph"},
  {"label":"Autograph Blue /99","ebay_kw":"Autograph Blue"},
  {"label":"Autograph Green /50","ebay_kw":"Autograph Green"},
  {"label":"Autograph Orange /25","ebay_kw":"Autograph Orange"},
  {"label":"Autograph Red /10","ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /1","ebay_kw":"Autograph Black"},
  {"label":"Patch Auto /50","ebay_kw":"Patch Auto"},
  {"label":"Triple Autograph","ebay_kw":"Triple Autograph"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Dynasty Baseball (only 3 parallels — premium product)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /10","ebay_kw":""},
  {"label":"Gold /5","ebay_kw":"Gold"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Autograph Patch /10","ebay_kw":"Autograph Patch"},
  {"label":"Autograph Patch Gold /5","ebay_kw":"Autograph Patch Gold"},
  {"label":"Autograph Patch Black /1","ebay_kw":"Autograph Patch Black"},
  {"label":"Dual Autograph Patch","ebay_kw":"Dual Autograph Patch"},
  {"label":"Triple Autograph Patch","ebay_kw":"Triple Autograph Patch"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Dynasty' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Transcendent Baseball (ultra-premium)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /25","ebay_kw":""},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Autograph /25","ebay_kw":"Autograph"},
  {"label":"Autograph Red /10","ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /5","ebay_kw":"Autograph Black"},
  {"label":"Autograph Platinum /1","ebay_kw":"Autograph Platinum"},
  {"label":"Cut Signature /1","ebay_kw":"Cut Signature"},
  {"label":"Dual Autograph","ebay_kw":"Dual Autograph"},
  {"label":"Triple Autograph","ebay_kw":"Triple Autograph"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Transcendent';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Archives Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Fan Favorites Auto","ebay_kw":"Fan Favorites Auto"},
  {"label":"Fan Favorites Auto Blue /99","ebay_kw":"Fan Favorites Auto Blue"},
  {"label":"Fan Favorites Auto Gold /50","ebay_kw":"Fan Favorites Auto Gold"},
  {"label":"Fan Favorites Auto Red /25","ebay_kw":"Fan Favorites Auto Red"},
  {"label":"Fan Favorites Auto Black /5","ebay_kw":"Fan Favorites Auto Black"},
  {"label":"1965 Topps Auto","ebay_kw":"1965 Auto"},
  {"label":"Short Print SP","ebay_kw":"SP Short Print"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Archives';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Fire Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue Chip /299","ebay_kw":"Blue Chip"},
  {"label":"Mojo /199","ebay_kw":"Mojo"},
  {"label":"Orange Chip /149","ebay_kw":"Orange Chip"},
  {"label":"Green /99","ebay_kw":"Green"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Gold Mojo /25","ebay_kw":"Gold Mojo"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Auto","ebay_kw":"Autograph"},
  {"label":"Auto Blue Chip /299","ebay_kw":"Auto Blue Chip"},
  {"label":"Auto Green /99","ebay_kw":"Auto Green"},
  {"label":"Auto Gold /25","ebay_kw":"Auto Gold"},
  {"label":"Auto Black /5","ebay_kw":"Auto Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Fire';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Holiday Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Metallic Snowflake","ebay_kw":"Metallic Snowflake"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Autograph","ebay_kw":"Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Autograph Gold"},
  {"label":"Autograph Red /25","ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /10","ebay_kw":"Autograph Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Holiday';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Pro Debut Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /75","ebay_kw":"Red"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Autograph","ebay_kw":"Autograph"},
  {"label":"Autograph Blue /199","ebay_kw":"Autograph Blue"},
  {"label":"Autograph Red /75","ebay_kw":"Autograph Red"},
  {"label":"Autograph Gold /25","ebay_kw":"Autograph Gold"},
  {"label":"Autograph Black /1","ebay_kw":"Autograph Black"},
  {"label":"Prospect Autograph","ebay_kw":"Prospect Autograph"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Pro Debut';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Cosmic Chrome Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue /150","ebay_kw":"Blue Refractor"},
  {"label":"Green /99","ebay_kw":"Green Refractor"},
  {"label":"Gold /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange /25","ebay_kw":"Orange Refractor"},
  {"label":"Red /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"Auto Refractor","ebay_kw":"Auto Refractor"},
  {"label":"Auto Blue /150","ebay_kw":"Auto Blue Refractor"},
  {"label":"Auto Gold /50","ebay_kw":"Auto Gold Refractor"},
  {"label":"Auto Red /5","ebay_kw":"Auto Red Refractor"},
  {"label":"Auto SuperFractor /1","ebay_kw":"Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Cosmic Chrome' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Stadium Club Chrome Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"Auto Refractor","ebay_kw":"Auto Refractor"},
  {"label":"Auto Blue /150","ebay_kw":"Auto Blue Refractor"},
  {"label":"Auto Gold /50","ebay_kw":"Auto Gold Refractor"},
  {"label":"Auto Orange /25","ebay_kw":"Auto Orange Refractor"},
  {"label":"Auto SuperFractor /1","ebay_kw":"Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club Chrome';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Big League Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Yellow /50","ebay_kw":"Yellow"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Autograph","ebay_kw":"Autograph"},
  {"label":"Autograph Blue /199","ebay_kw":"Autograph Blue"},
  {"label":"Autograph Gold /50","ebay_kw":"Autograph Gold"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Big League';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Topps Opening Day Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /2024","ebay_kw":"Blue"},
  {"label":"Red /10","ebay_kw":"Red"},
  {"label":"Yellow /5","ebay_kw":"Yellow"},
  {"label":"Black /1","ebay_kw":"Black"},
  {"label":"Foil","ebay_kw":"Foil"},
  {"label":"Autograph","ebay_kw":"Autograph"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Opening Day';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Panini Diamond Kings Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Artist Canvas /25","ebay_kw":"Artist Canvas"},
  {"label":"Framed /99","ebay_kw":"Framed"},
  {"label":"Holo Gold /25","ebay_kw":"Holo Gold"},
  {"label":"Red /150","ebay_kw":"Red"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"DK Materials Signature","ebay_kw":"DK Materials Signature"},
  {"label":"DK Mat Sig Framed /25","ebay_kw":"DK Materials Signature Framed"},
  {"label":"DK Mat Sig Black /5","ebay_kw":"DK Materials Signature Black"},
  {"label":"Framed Auto","ebay_kw":"Framed Autograph"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Diamond Kings';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Credentials Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Blue /199","ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Red /99","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Gold /49","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Purple /25","ebay_kw":"RC Auto Purple"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Credentials';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Overtime Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Blue /199","ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Red /99","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Gold /25","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Overtime';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Portfolio Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver /99","ebay_kw":"Silver"},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Silver /99","ebay_kw":"RC Auto Silver"},
  {"label":"RC Auto Gold /49","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /10","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Portfolio';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Clear Cut Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /199","ebay_kw":"Blue"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Gold /49","ebay_kw":"Gold"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Blue /199","ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Red /99","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Gold /49","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Clear Cut';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Stature Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green /150","ebay_kw":"Green"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Red /49","ebay_kw":"Red"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Green /150","ebay_kw":"RC Auto Green"},
  {"label":"RC Auto Blue /99","ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Red /49","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Gold /25","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Stature';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Metal Universe Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Turbo /199","ebay_kw":"Turbo"},
  {"label":"Precious Metal Gems Blue /100","ebay_kw":"PMG Blue"},
  {"label":"Precious Metal Gems Red /50","ebay_kw":"PMG Red"},
  {"label":"Precious Metal Gems Green /10","ebay_kw":"PMG Green"},
  {"label":"Precious Metal Gems Gold /5","ebay_kw":"PMG Gold"},
  {"label":"Precious Metal Gems Black /1","ebay_kw":"PMG Black"},
  {"label":"RC Auto","ebay_kw":"RC Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Metal Universe';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck O-Pee-Chee (retro OPC in UD hockey)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Retro /100","ebay_kw":"Retro"},
  {"label":"Black /100","ebay_kw":"Black Border"},
  {"label":"Rainbow /99","ebay_kw":"Rainbow"},
  {"label":"Retro Black /99","ebay_kw":"Retro Black"},
  {"label":"Retro Rainbow /50","ebay_kw":"Retro Rainbow"},
  {"label":"Marquee Rookies","ebay_kw":"Marquee Rookies"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Retro /100","ebay_kw":"RC Auto Retro"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee' AND sport = 'hockey';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Upper Deck Parkhurst Hockey
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /250","ebay_kw":"Gold"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Red /50","ebay_kw":"Red"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Emerald /1","ebay_kw":"Emerald"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Gold /250","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Red /50","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Black /10","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Parkhurst';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: WNBA National Treasures (only 3 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"RPA /99","ebay_kw":"RPA"},
  {"label":"RPA Holo Silver /49","ebay_kw":"RPA Holo Silver"},
  {"label":"RPA Gold /25","ebay_kw":"RPA Gold"},
  {"label":"RPA Emerald /10","ebay_kw":"RPA Emerald"},
  {"label":"RPA Platinum /5","ebay_kw":"RPA Platinum"},
  {"label":"RPA Black /1","ebay_kw":"RPA Black"},
  {"label":"Jersey Auto /99","ebay_kw":"Jersey Auto"},
  {"label":"Logoman Patch Auto /1","ebay_kw":"Logoman Patch Auto"},
  {"label":"Printing Plate /1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: WNBA Immaculate (only 4 parallels)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Auto /49","ebay_kw":"Auto"},
  {"label":"Patch Auto /25","ebay_kw":"Patch Auto"},
  {"label":"Patch Auto Gold /10","ebay_kw":"Patch Auto Gold"},
  {"label":"Patch Auto Platinum /5","ebay_kw":"Patch Auto Platinum"},
  {"label":"Patch Auto Black /1","ebay_kw":"Patch Auto Black"},
  {"label":"Logoman Auto /1","ebay_kw":"Logoman Auto"},
  {"label":"Jersey Auto /49","ebay_kw":"Jersey Auto"},
  {"label":"Premium Patch Auto /25","ebay_kw":"Premium Patch Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Immaculate WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Bowman Basketball (sparse base product)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Rookie Auto","ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Gold /50","ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Red /25","ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Black /5","ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Auto Platinum /1","ebay_kw":"Rookie Auto Platinum"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Bowman Football (sparse)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Red /25","ebay_kw":"Red"},
  {"label":"Black /5","ebay_kw":"Black"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"RC Auto","ebay_kw":"RC Auto"},
  {"label":"RC Auto Gold /50","ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Red /25","ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Black /5","ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Bowman Base Baseball (sparse — many years, basic product)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Blue /150","ebay_kw":"Blue"},
  {"label":"Red /5","ebay_kw":"Red"},
  {"label":"Platinum /1","ebay_kw":"Platinum"},
  {"label":"Prospect Auto","ebay_kw":"Prospect Auto"},
  {"label":"Prospect Auto Blue /150","ebay_kw":"Prospect Auto Blue"},
  {"label":"Prospect Auto Gold /50","ebay_kw":"Prospect Auto Gold"},
  {"label":"Prospect Auto Orange /25","ebay_kw":"Prospect Auto Orange"},
  {"label":"Prospect Auto Red /5","ebay_kw":"Prospect Auto Red"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- FIX: Bowman Best Baseball
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1","ebay_kw":"Superfractor"},
  {"label":"Best of 98 Auto","ebay_kw":"Best of 98 Auto"},
  {"label":"Prospect Auto","ebay_kw":"Prospect Auto"},
  {"label":"Prospect Auto Refractor","ebay_kw":"Prospect Auto Refractor"},
  {"label":"Prospect Auto Blue /150","ebay_kw":"Prospect Auto Blue"},
  {"label":"Prospect Auto Gold /50","ebay_kw":"Prospect Auto Gold"},
  {"label":"Prospect Auto Red /5","ebay_kw":"Prospect Auto Red"},
  {"label":"Prospect Auto SuperFractor /1","ebay_kw":"Prospect Auto Superfractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best';
