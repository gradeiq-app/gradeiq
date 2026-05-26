-- ============================================================
-- RawIQ — 2025-26 Basketball + 2025 Football Completeness Patch
-- Source: Beckett release calendar + ChecklistInsider (May 2026)
-- ============================================================

-- ═══════════════════════════════════════════════════════════
-- BASKETBALL 2025 (= 2025-26 season, Topps/Fanatics era)
-- ═══════════════════════════════════════════════════════════

-- Topps NBA Hoops (Topps revived the classic brand)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'NBA Hoops',
 '[{"label":"Base","ebay_kw":""},{"label":"Holofoil /699","ebay_kw":"Holofoil"},{"label":"Silver /149","ebay_kw":"Silver"},{"label":"Blue /99","ebay_kw":"Blue"},{"label":"Red /75","ebay_kw":"Red"},{"label":"Purple /49","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"},{"label":"Teal Explosion","ebay_kw":"Teal Explosion"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Cosmic Chrome Basketball (released April 29, 2026)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Cosmic Chrome',
 '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Cosmic Refractor","ebay_kw":"Cosmic Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Purple Refractor /75","ebay_kw":"Purple Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Chrome Sapphire Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Chrome Sapphire',
 '[{"label":"Base","ebay_kw":"Sapphire"},{"label":"Blue /150","ebay_kw":"Blue Sapphire"},{"label":"Gold /50","ebay_kw":"Gold Sapphire"},{"label":"Red /25","ebay_kw":"Red Sapphire"},{"label":"Black /10","ebay_kw":"Black Sapphire"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor Sapphire"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Signature Class Basketball (autograph-focused, May 28 2026)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Signature Class',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps 3 Basketball (premium 3-card hobby format)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Topps 3',
 '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Midnight Basketball (dark-theme premium)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Midnight',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Holiday Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Topps', 'Holiday',
 '[{"label":"Base","ebay_kw":""},{"label":"Metallic Snowflake /25","ebay_kw":"Metallic Snowflake"},{"label":"Red /10","ebay_kw":"Red"},{"label":"Gold /5","ebay_kw":"Gold"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman Basketball (Fanatics/Topps Bowman brand for NBA prospects)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Bowman', 'Basketball',
 '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Green Refractor /99","ebay_kw":"Green Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman Sapphire Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Bowman', 'Sapphire',
 '[{"label":"Base","ebay_kw":"Sapphire"},{"label":"Blue /150","ebay_kw":"Blue Sapphire"},{"label":"Gold /50","ebay_kw":"Gold Sapphire"},{"label":"Red /25","ebay_kw":"Red Sapphire"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Donruss Basketball 2025-26 (Fanatics-era Donruss)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Donruss', 'Basketball',
 '[{"label":"Base","ebay_kw":""},{"label":"Press Proof /99","ebay_kw":"Press Proof"},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Purple /49","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Holo Gold","ebay_kw":"Holo Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Noir Basketball 2025-26 (NBPA-licensed, still collector-popular)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('basketball', 2025, 'Panini', 'Noir',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /125","ebay_kw":"Blue"},{"label":"Purple /75","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"White Gold /15","ebay_kw":"White Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- BASKETBALL — Missing historic Panini sets (2018-2024)
-- ═══════════════════════════════════════════════════════════

-- Panini Noir Basketball (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Noir',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /125","ebay_kw":"Blue"},{"label":"Purple /75","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"White Gold /15","ebay_kw":"White Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Flawless Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Flawless',
 '[{"label":"Base /20","ebay_kw":""},{"label":"Ruby /15","ebay_kw":"Ruby"},{"label":"Sapphire /10","ebay_kw":"Sapphire"},{"label":"Emerald /5","ebay_kw":"Emerald"},{"label":"Diamond /1","ebay_kw":"Diamond"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Obsidian Basketball (dark chrome-style, 2019+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Obsidian',
 '[{"label":"Base","ebay_kw":""},{"label":"Electric Etch Orange /75","ebay_kw":"Electric Etch Orange"},{"label":"Electric Etch Yellow /50","ebay_kw":"Electric Etch Yellow"},{"label":"Electric Etch Green /25","ebay_kw":"Electric Etch Green"},{"label":"Electric Etch Red /15","ebay_kw":"Electric Etch Red"},{"label":"Electric Etch Blue /10","ebay_kw":"Electric Etch Blue"},{"label":"Electric Etch White /5","ebay_kw":"Electric Etch White"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Impeccable Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Impeccable',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Stainless Stars /25","ebay_kw":"Stainless Stars"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Noir Basketball 2025 (already added above, this covers 2018-2024 duplicated intentionally for clarity — ON CONFLICT DO NOTHING is safe)


-- ═══════════════════════════════════════════════════════════
-- FOOTBALL 2025 — New Topps/Fanatics Products
-- ═══════════════════════════════════════════════════════════

-- Topps Cosmic Chrome Football (confirmed release)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Topps', 'Cosmic Chrome',
 '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Cosmic Refractor","ebay_kw":"Cosmic Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Purple Refractor /75","ebay_kw":"Purple Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Chrome Sapphire Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Topps', 'Chrome Sapphire',
 '[{"label":"Base","ebay_kw":"Sapphire"},{"label":"Blue /150","ebay_kw":"Blue Sapphire"},{"label":"Gold /50","ebay_kw":"Gold Sapphire"},{"label":"Red /25","ebay_kw":"Red Sapphire"},{"label":"Black /10","ebay_kw":"Black Sapphire"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Finest Football (first Topps NFL Finest in years)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Topps', 'Finest',
 '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /99","ebay_kw":"Blue Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Signature Class Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Topps', 'Signature Class',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- FOOTBALL 2025 — Missing Panini Products
-- ═══════════════════════════════════════════════════════════

-- Panini Black Football (ultra high-end)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Black',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Laundry Tag /25","ebay_kw":"Laundry Tag"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Flawless Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Flawless',
 '[{"label":"Base /20","ebay_kw":""},{"label":"Ruby /15","ebay_kw":"Ruby"},{"label":"Sapphire /10","ebay_kw":"Sapphire"},{"label":"Emerald /5","ebay_kw":"Emerald"},{"label":"Diamond /1","ebay_kw":"Diamond"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Honors Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Honors',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Immaculate Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Immaculate',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /10","ebay_kw":"Platinum"},{"label":"Black /5","ebay_kw":"Black"},{"label":"Logoman /1","ebay_kw":"Logoman"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Impeccable Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Impeccable',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Stainless Stars /25","ebay_kw":"Stainless Stars"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Luminance Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Luminance',
 '[{"label":"Base","ebay_kw":""},{"label":"Pink /199","ebay_kw":"Pink"},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Origins Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Origins',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Green /99","ebay_kw":"Green"},{"label":"Purple /49","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Rookies & Stars Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Rookies & Stars',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Silhouette Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Panini', 'Silhouette',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Donruss Elite Football (distinct from base Donruss)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Donruss', 'Elite',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /200","ebay_kw":"Blue"},{"label":"Purple /150","ebay_kw":"Purple"},{"label":"Red /100","ebay_kw":"Red"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman University Chrome Football (college prospects, key for early RC grading)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('football', 2025, 'Bowman', 'University Chrome',
 '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Green Refractor /99","ebay_kw":"Green Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- FOOTBALL — Missing historic Panini sets (2018-2024)
-- ═══════════════════════════════════════════════════════════

-- Panini Flawless Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Flawless',
 '[{"label":"Base /20","ebay_kw":""},{"label":"Ruby /15","ebay_kw":"Ruby"},{"label":"Sapphire /10","ebay_kw":"Sapphire"},{"label":"Emerald /5","ebay_kw":"Emerald"},{"label":"Diamond /1","ebay_kw":"Diamond"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Black Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Black',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Laundry Tag /25","ebay_kw":"Laundry Tag"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Immaculate Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Immaculate',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /10","ebay_kw":"Platinum"},{"label":"Black /5","ebay_kw":"Black"},{"label":"Logoman /1","ebay_kw":"Logoman"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Impeccable Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Impeccable',
 '[{"label":"Base /99","ebay_kw":""},{"label":"Stainless Stars /25","ebay_kw":"Stainless Stars"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Origins Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Origins',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Green /99","ebay_kw":"Green"},{"label":"Purple /49","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Luminance Football (historic, started ~2019)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Luminance',
 '[{"label":"Base","ebay_kw":""},{"label":"Pink /199","ebay_kw":"Pink"},{"label":"Blue /149","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Rookies & Stars Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Rookies & Stars',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Silhouette Football (historic, started ~2019)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Silhouette',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Honors Football (started ~2022)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Honors',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2022,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Obsidian Football (dark chrome, started 2019)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Obsidian',
 '[{"label":"Base","ebay_kw":""},{"label":"Electric Etch Orange /75","ebay_kw":"Electric Etch Orange"},{"label":"Electric Etch Yellow /50","ebay_kw":"Electric Etch Yellow"},{"label":"Electric Etch Green /25","ebay_kw":"Electric Etch Green"},{"label":"Electric Etch Red /15","ebay_kw":"Electric Etch Red"},{"label":"Electric Etch Blue /10","ebay_kw":"Electric Etch Blue"},{"label":"Electric Etch White /5","ebay_kw":"Electric Etch White"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Donruss Elite Football (historic)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Donruss', 'Elite',
 '[{"label":"Base","ebay_kw":""},{"label":"Blue /200","ebay_kw":"Blue"},{"label":"Purple /150","ebay_kw":"Purple"},{"label":"Red /100","ebay_kw":"Red"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;
