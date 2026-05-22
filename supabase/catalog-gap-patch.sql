-- ─────────────────────────────────────────────────────────────────────────────
-- Catalog gap patch — fills remaining holes after wnba-sport-inserts.sql
-- All inserts are ON CONFLICT DO NOTHING — safe to re-run
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- WNBA — extend existing sets to 2025 + add early historical years
-- ═══════════════════════════════════════════════════════════════════════════════

-- Prizm WNBA 2025 (Fanatics era — still Panini brand on packaging)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('wnba', 2025, 'Panini', 'Prizm WNBA',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Red /149","ebay_kw":"Red Prizm"},{"label":"Blue /99","ebay_kw":"Blue Prizm"},{"label":"Purple /49","ebay_kw":"Purple Prizm"},{"label":"Orange /25","ebay_kw":"Orange Prizm"},{"label":"Gold /10","ebay_kw":"Gold Prizm"},{"label":"Black /1","ebay_kw":"Black Prizm"},{"label":"Rookie Auto","ebay_kw":"Rookie Auto"},{"label":"Auto Silver","ebay_kw":"Auto Silver Prizm"},{"label":"Auto Gold /10","ebay_kw":"Auto Gold Prizm"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss WNBA 2025
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('wnba', 2025, 'Panini', 'Donruss WNBA',
   '[{"label":"Base","ebay_kw":""},{"label":"Rated Rookie","ebay_kw":"Rated Rookie"},{"label":"Bronze /199","ebay_kw":"Bronze"},{"label":"Blue /99","ebay_kw":"Blue"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"},{"label":"Rated Rookie Auto","ebay_kw":"Rated Rookie Auto"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Historical Panini WNBA sets (pre-2019 — early Panini WNBA era)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'wnba', y, 'Panini', 'Prizm WNBA',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Gold /10","ebay_kw":"Gold Prizm"},{"label":"Black /1","ebay_kw":"Black Prizm"}]'::jsonb
FROM generate_series(2017, 2018) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'wnba', y, 'Panini', 'Donruss WNBA',
  '[{"label":"Base","ebay_kw":""},{"label":"Rated Rookie","ebay_kw":"Rated Rookie"},{"label":"Bronze /199","ebay_kw":"Bronze"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018, 2019) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Hoops WNBA (budget set, every year)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'wnba', y, 'Panini', 'Hoops WNBA',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver /149","ebay_kw":"Silver"},{"label":"Blue /99","ebay_kw":"Blue"},{"label":"Purple /49","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019, 2025) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Select WNBA (2020-2025)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'wnba', y, 'Panini', 'Select WNBA',
  '[{"label":"Concourse","ebay_kw":"Concourse"},{"label":"Premier Level","ebay_kw":"Premier Level"},{"label":"Courtside","ebay_kw":"Courtside"},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Gold Prizm /10","ebay_kw":"Gold Prizm"},{"label":"Black Prizm /1","ebay_kw":"Black Prizm"}]'::jsonb
FROM generate_series(2020, 2025) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Obsidian WNBA (2020-2024)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'wnba', y, 'Panini', 'Obsidian WNBA',
  '[{"label":"Base","ebay_kw":""},{"label":"Electric Etch /99","ebay_kw":"Electric Etch"},{"label":"Flash /49","ebay_kw":"Flash"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2020, 2024) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- BASKETBALL — Fanatics/Topps era (2025-26 season = year 2025)
-- ═══════════════════════════════════════════════════════════════════════════════

-- Topps Chrome Basketball 2025 (Fanatics)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Chrome Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2025, 2026) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Finest Basketball 2025-26
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Finest Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2025, 2026) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Prizm Basketball 2025 (last Panini season before full Fanatics)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 2025, 'Panini', 'Prizm',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Hyper Prizm","ebay_kw":"Hyper Prizm"},{"label":"Red /99","ebay_kw":"Red Prizm"},{"label":"Purple /49","ebay_kw":"Purple Prizm"},{"label":"Gold /10","ebay_kw":"Gold Prizm"},{"label":"Black /1","ebay_kw":"Black Prizm"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Mosaic Basketball 2025
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 2025, 'Panini', 'Mosaic',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Green /199","ebay_kw":"Green Mosaic"},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- HOCKEY — 2025 missing sets
-- ═══════════════════════════════════════════════════════════════════════════════

-- Upper Deck Series 1 & 2 for 2025 (2025-26 season)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', 2025, 'Upper Deck', s,
  '[{"label":"Base","ebay_kw":""},{"label":"Young Guns","ebay_kw":"Young Guns"},{"label":"UD Canvas","ebay_kw":"Canvas"},{"label":"Exclusives /100","ebay_kw":"Exclusives"},{"label":"High Gloss /10","ebay_kw":"High Gloss"}]'::jsonb
FROM (VALUES ('Series 1'), ('Series 2')) AS t(s)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- O-Pee-Chee Platinum 2025
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('hockey', 2025, 'O-Pee-Chee', 'Platinum',
   '[{"label":"Base","ebay_kw":""},{"label":"Marquee Rookies","ebay_kw":"Marquee Rookies"},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Rainbow /1","ebay_kw":"Rainbow"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck SP Authentic 2025
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('hockey', 2025, 'Upper Deck', 'SP Authentic',
   '[{"label":"Base","ebay_kw":""},{"label":"Future Watch Auto /999","ebay_kw":"Future Watch"},{"label":"Silver Spectrum /50","ebay_kw":"Silver Spectrum"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Limited Auto /100","ebay_kw":"Limited Auto"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- FOOTBALL — Immaculate + Black + Noir (2018-2024, if missing)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Immaculate',
  '[{"label":"Base","ebay_kw":""},{"label":"Emerald /25","ebay_kw":"Emerald"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Sapphire /5","ebay_kw":"Sapphire"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018, 2024) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Black',
  '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /10","ebay_kw":"Platinum"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018, 2024) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Noir',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018, 2024) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Origins',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018, 2024) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════════════
-- BASEBALL — Topps Chrome Sapphire 2025 + Bowman Chrome Auto 2025
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('baseball', 2025, 'Topps', 'Chrome Sapphire Edition',
   '[{"label":"Base","ebay_kw":""},{"label":"Blue /150","ebay_kw":"Blue Refractor"},{"label":"Gold /50","ebay_kw":"Gold Refractor"},{"label":"Orange /25","ebay_kw":"Orange Refractor"},{"label":"Red /5","ebay_kw":"Red Refractor"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'::jsonb),
  ('baseball', 2025, 'Bowman', 'Chrome Prospect Auto',
   '[{"label":"Base Auto","ebay_kw":"Auto"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor Auto"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor Auto"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor Auto"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor Auto"},{"label":"Superfractor /1","ebay_kw":"Superfractor Auto"}]'::jsonb),
  ('baseball', 2025, 'Topps', 'Chrome',
   '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"Superfractor"}]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;
