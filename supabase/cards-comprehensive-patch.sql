-- ============================================================
-- GradeIQ — Comprehensive Missing Card Sets Patch
-- Run after: cards-migration.sql + cards-2025-2026-patch.sql
-- Every INSERT uses ON CONFLICT DO NOTHING — fully idempotent
-- ============================================================

-- ═══════════════════════════════════════════════════════════
-- BASKETBALL — ADDITIONAL PANINI SETS (2018-2024)
-- ═══════════════════════════════════════════════════════════

-- Panini Chronicles Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Chronicles',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Pink /25","ebay_kw":"Pink"},{"label":"Orange /10","ebay_kw":"Orange"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Illusions Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Illusions',
  '[{"label":"Base","ebay_kw":""},{"label":"Trophy Collection Blue","ebay_kw":"Trophy Collection Blue"},{"label":"Pink /149","ebay_kw":"Pink"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Emerald /75","ebay_kw":"Emerald"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Gold Standard Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Gold Standard',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /149","ebay_kw":"Gold"},{"label":"Premium /99","ebay_kw":"Premium"},{"label":"Midas /49","ebay_kw":"Midas"},{"label":"Gold Vinyl /10","ebay_kw":"Gold Vinyl"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Revolution Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Revolution',
  '[{"label":"Base","ebay_kw":""},{"label":"Aqua /199","ebay_kw":"Aqua"},{"label":"Purple /149","ebay_kw":"Purple"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Pink /25","ebay_kw":"Pink"},{"label":"Cosmic /15","ebay_kw":"Cosmic"},{"label":"Gold /1","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Flux Basketball (debut 2019-20 season)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Flux',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Absolute Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Absolute',
  '[{"label":"Base","ebay_kw":""},{"label":"Spectrum Blue","ebay_kw":"Spectrum Blue"},{"label":"Spectrum Green /149","ebay_kw":"Spectrum Green"},{"label":"Spectrum Red /99","ebay_kw":"Spectrum Red"},{"label":"Spectrum Gold /25","ebay_kw":"Spectrum Gold"},{"label":"Spectrum Platinum /1","ebay_kw":"Spectrum Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Certified Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Certified',
  '[{"label":"Base","ebay_kw":""},{"label":"Mirror Blue /149","ebay_kw":"Mirror Blue"},{"label":"Mirror Red /99","ebay_kw":"Mirror Red"},{"label":"Mirror Green /75","ebay_kw":"Mirror Green"},{"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},{"label":"Mirror Black /1","ebay_kw":"Mirror Black"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Contenders Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Contenders',
  '[{"label":"Base","ebay_kw":""},{"label":"Playoff Ticket /199","ebay_kw":"Playoff Ticket"},{"label":"Championship Ticket /99","ebay_kw":"Championship Ticket"},{"label":"All Star Ticket /25","ebay_kw":"All Star Ticket"},{"label":"MVP Ticket /1","ebay_kw":"MVP Ticket"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Contenders Draft Picks Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Contenders Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"College Ticket /199","ebay_kw":"College Ticket"},{"label":"Draft Ticket /99","ebay_kw":"Draft Ticket"},{"label":"Cracked Ice /25","ebay_kw":"Cracked Ice"},{"label":"Gold Cracked Ice /5","ebay_kw":"Gold Cracked Ice"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini National Treasures Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'National Treasures',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /15","ebay_kw":"Platinum"},{"label":"Black /10","ebay_kw":"Black"},{"label":"Ruby /5","ebay_kw":"Ruby"},{"label":"Logoman /1","ebay_kw":"Logoman"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Status Basketball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Status',
  '[{"label":"Base","ebay_kw":""},{"label":"Red /199","ebay_kw":"Red"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Blue /25","ebay_kw":"Blue"},{"label":"Gold /15","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Donruss Optic Basketball (if not already present — uses Prizm-style parallels)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Prizm Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Blue Prizm /199","ebay_kw":"Blue Prizm"},{"label":"Red Prizm /149","ebay_kw":"Red Prizm"},{"label":"Green Prizm /99","ebay_kw":"Green Prizm"},{"label":"Purple Prizm /49","ebay_kw":"Purple Prizm"},{"label":"Orange Prizm /25","ebay_kw":"Orange Prizm"},{"label":"Gold Prizm /10","ebay_kw":"Gold Prizm"},{"label":"Black Prizm /1","ebay_kw":"Black Prizm"}]'::jsonb
FROM generate_series(2018,2024) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ── BASKETBALL — TOPPS / FANATICS ERA (2025-2026) ──────────────────────────

-- Topps Basketball (base flagship — Fanatics takeover Oct 2025)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver /199","ebay_kw":"Silver"},{"label":"Blue /150","ebay_kw":"Blue"},{"label":"Purple /75","ebay_kw":"Purple"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Orange /25","ebay_kw":"Orange"},{"label":"Red /10","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2025,2026) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Chrome Basketball (Fanatics era)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Chrome Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Purple Refractor /75","ebay_kw":"Purple Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2025,2026) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Finest Basketball (Fanatics era)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Finest Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2025,2026) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- FOOTBALL — ADDITIONAL PANINI SETS (2018-2025)
-- ═══════════════════════════════════════════════════════════

-- Panini Score Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Score',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Platinum Blue /10","ebay_kw":"Platinum Blue"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Chronicles Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Chronicles',
  '[{"label":"Base","ebay_kw":""},{"label":"Pink /199","ebay_kw":"Pink"},{"label":"Green /149","ebay_kw":"Green"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Orange /10","ebay_kw":"Orange"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Contenders Draft Picks Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Contenders Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"College Ticket /199","ebay_kw":"College Ticket"},{"label":"Championship /99","ebay_kw":"Championship"},{"label":"Cracked Ice /25","ebay_kw":"Cracked Ice"},{"label":"Gold Cracked Ice /5","ebay_kw":"Gold Cracked Ice"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Absolute Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Absolute',
  '[{"label":"Base","ebay_kw":""},{"label":"Spectrum Blue","ebay_kw":"Spectrum Blue"},{"label":"Spectrum Green /149","ebay_kw":"Spectrum Green"},{"label":"Spectrum Red /99","ebay_kw":"Spectrum Red"},{"label":"Spectrum Gold /25","ebay_kw":"Spectrum Gold"},{"label":"Spectrum Platinum /1","ebay_kw":"Spectrum Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Certified Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Certified',
  '[{"label":"Base","ebay_kw":""},{"label":"Mirror Blue /149","ebay_kw":"Mirror Blue"},{"label":"Mirror Red /99","ebay_kw":"Mirror Red"},{"label":"Mirror Green /75","ebay_kw":"Mirror Green"},{"label":"Mirror Gold /25","ebay_kw":"Mirror Gold"},{"label":"Mirror Black /1","ebay_kw":"Mirror Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Phoenix Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Phoenix',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Orange /25","ebay_kw":"Orange"},{"label":"Red /10","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Revolution Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Revolution',
  '[{"label":"Base","ebay_kw":""},{"label":"Aqua /199","ebay_kw":"Aqua"},{"label":"Purple /149","ebay_kw":"Purple"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Pink /25","ebay_kw":"Pink"},{"label":"Cosmic /15","ebay_kw":"Cosmic"},{"label":"Gold /1","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Illusions Football (debut 2019)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Illusions',
  '[{"label":"Base","ebay_kw":""},{"label":"Trophy Collection Blue","ebay_kw":"Trophy Collection Blue"},{"label":"Pink /149","ebay_kw":"Pink"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2019,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Flux Football (debut 2020)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Flux',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2020,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Threads Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Threads',
  '[{"label":"Base","ebay_kw":""},{"label":"Prime /199","ebay_kw":"Prime"},{"label":"Gold /99","ebay_kw":"Gold"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Limited Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Limited',
  '[{"label":"Base","ebay_kw":""},{"label":"Monikers /49","ebay_kw":"Monikers"},{"label":"Gold Vinyl /10","ebay_kw":"Gold Vinyl"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Prizm Draft Picks Football
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Prizm Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver Prizm"},{"label":"Blue Prizm /199","ebay_kw":"Blue Prizm"},{"label":"Red Prizm /149","ebay_kw":"Red Prizm"},{"label":"Green Prizm /99","ebay_kw":"Green Prizm"},{"label":"Purple Prizm /49","ebay_kw":"Purple Prizm"},{"label":"Orange Prizm /25","ebay_kw":"Orange Prizm"},{"label":"Gold Prizm /10","ebay_kw":"Gold Prizm"},{"label":"Black Prizm /1","ebay_kw":"Black Prizm"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- ── FOOTBALL — TOPPS / FANATICS ERA (2025) ─────────────────────────────────

-- Topps Chrome Football 2025 (released April 2026 under Fanatics deal)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
VALUES ('football', 2025, 'Topps', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Purple Refractor /75","ebay_kw":"Purple Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Football base 2025
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
VALUES ('football', 2025, 'Topps', 'Football',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver /199","ebay_kw":"Silver"},{"label":"Blue /150","ebay_kw":"Blue"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Orange /25","ebay_kw":"Orange"},{"label":"Red /10","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb)
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- BASEBALL — ADDITIONAL SETS (2018-2025)
-- ═══════════════════════════════════════════════════════════

-- Topps Triple Threads
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Triple Threads',
  '[{"label":"Base","ebay_kw":""},{"label":"Emerald /99","ebay_kw":"Emerald"},{"label":"Ruby /18","ebay_kw":"Ruby"},{"label":"Sapphire /9","ebay_kw":"Sapphire"},{"label":"Gold /3","ebay_kw":"Gold"},{"label":"1/1","ebay_kw":"1/1"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Gold Label
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Gold Label',
  '[{"label":"Class 1","ebay_kw":"Class 1"},{"label":"Class 2","ebay_kw":"Class 2"},{"label":"Class 3","ebay_kw":"Class 3"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Tier One
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Tier One',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Gold Ink /1","ebay_kw":"Gold Ink"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Archives
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Archives',
  '[{"label":"Base","ebay_kw":""},{"label":"1959 Mini /100","ebay_kw":"1959 Mini"},{"label":"Silver /50","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Gallery
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Gallery',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /250","ebay_kw":"Blue"},{"label":"Purple /150","ebay_kw":"Purple"},{"label":"Red /10","ebay_kw":"Red"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman Platinum
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Platinum',
  '[{"label":"Base","ebay_kw":""},{"label":"Aqua /199","ebay_kw":"Aqua"},{"label":"Blue /150","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /5","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman Sterling
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Sterling',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor /199","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Black Refractor /5","ebay_kw":"Black Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Fire
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Fire',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue Chip /199","ebay_kw":"Blue Chip"},{"label":"Yellow /99","ebay_kw":"Yellow"},{"label":"Red Hot /25","ebay_kw":"Red Hot"},{"label":"Gold Minted /5","ebay_kw":"Gold Minted"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Opening Day
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Opening Day',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Purple /199","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Red /1","ebay_kw":"Red"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Holiday
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Holiday',
  '[{"label":"Base","ebay_kw":""},{"label":"Metallic Snowflake /25","ebay_kw":"Metallic Snowflake"},{"label":"Red /10","ebay_kw":"Red"},{"label":"Gold /5","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Pro Debut
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Pro Debut',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /499","ebay_kw":"Blue"},{"label":"Red /199","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Big League (budget set)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Big League',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Total (online exclusive)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Total',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2019,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Inception
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Inception',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /150","ebay_kw":"Blue"},{"label":"Purple /75","ebay_kw":"Purple"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Transcendent (ultra high-end)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Transcendent',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /99","ebay_kw":"Gold"},{"label":"Sapphire /25","ebay_kw":"Sapphire"},{"label":"Framed /5","ebay_kw":"Framed"},{"label":"1/1","ebay_kw":"1/1"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Bowman's Best
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Best',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor /199","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Green Refractor /99","ebay_kw":"Green Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Topps Stadium Club Chrome
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Stadium Club Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},{"label":"Purple Refractor /75","ebay_kw":"Purple Refractor"},{"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},{"label":"Red Refractor /5","ebay_kw":"Red Refractor"},{"label":"SuperFractor /1","ebay_kw":"SuperFractor"}]'::jsonb
FROM generate_series(2020,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Panini Diamond Kings Baseball
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Panini', 'Diamond Kings',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver /299","ebay_kw":"Silver"},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Red /99","ebay_kw":"Red"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2023) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;


-- ═══════════════════════════════════════════════════════════
-- HOCKEY — ADDITIONAL UPPER DECK SETS (2018-2025)
-- ═══════════════════════════════════════════════════════════

-- Upper Deck The Cup
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'The Cup',
  '[{"label":"Base","ebay_kw":""},{"label":"Spectrum /99","ebay_kw":"Spectrum"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Rainbow /15","ebay_kw":"Rainbow"},{"label":"Platinum /5","ebay_kw":"Platinum"},{"label":"Super Script /1","ebay_kw":"Super Script"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Ice
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Ice',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Black Diamond
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Black Diamond',
  '[{"label":"Base","ebay_kw":""},{"label":"Double Diamond /199","ebay_kw":"Double Diamond"},{"label":"Triple Diamond /99","ebay_kw":"Triple Diamond"},{"label":"Quad Diamond /49","ebay_kw":"Quad Diamond"},{"label":"Black Diamond /10","ebay_kw":"Black Diamond"},{"label":"Super Script /1","ebay_kw":"Super Script"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck SPx
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'SPx',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /199","ebay_kw":"Gold"},{"label":"Spectrum /99","ebay_kw":"Spectrum"},{"label":"Ruby /25","ebay_kw":"Ruby"},{"label":"Black /5","ebay_kw":"Black"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Ultimate Collection
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Ultimate Collection',
  '[{"label":"Base","ebay_kw":""},{"label":"Premium /99","ebay_kw":"Premium"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Onyx /10","ebay_kw":"Onyx"},{"label":"Super Script /1","ebay_kw":"Super Script"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck MVP Hockey
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'MVP',
  '[{"label":"Base","ebay_kw":""},{"label":"Ice Blue /199","ebay_kw":"Ice Blue"},{"label":"Gold Script /10","ebay_kw":"Gold Script"},{"label":"Super Script /1","ebay_kw":"Super Script"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck O-Pee-Chee (base, not Platinum)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'O-Pee-Chee',
  '[{"label":"Base","ebay_kw":""},{"label":"Black /100","ebay_kw":"Black"},{"label":"Blue /99","ebay_kw":"Blue"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Allure (debut 2019-20)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Allure',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /49","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2019,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Clear Cut (debut 2020-21)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Clear Cut',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Green /99","ebay_kw":"Green"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Gold /10","ebay_kw":"Gold"}]'::jsonb
FROM generate_series(2020,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Trilogy
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Trilogy',
  '[{"label":"Base","ebay_kw":""},{"label":"Ruby /99","ebay_kw":"Ruby"},{"label":"Gold /49","ebay_kw":"Gold"},{"label":"Platinum /15","ebay_kw":"Platinum"},{"label":"Super Script /1","ebay_kw":"Super Script"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Portfolio
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Portfolio',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver Portraits /199","ebay_kw":"Silver Portraits"},{"label":"Gold Portraits /50","ebay_kw":"Gold Portraits"},{"label":"Black /1","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Overtime (budget set)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Overtime',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /10","ebay_kw":"Red"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Credentials
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Credentials',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Red /25","ebay_kw":"Red"},{"label":"Gold /15","ebay_kw":"Gold"},{"label":"Black /5","ebay_kw":"Black"}]'::jsonb
FROM generate_series(2018,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Upper Deck Stature
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Stature',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue /199","ebay_kw":"Blue"},{"label":"Green /99","ebay_kw":"Green"},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'::jsonb
FROM generate_series(2019,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;

-- Skybox Metal Universe (UD brand)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Metal Universe',
  '[{"label":"Base","ebay_kw":""},{"label":"Titanium","ebay_kw":"Titanium"},{"label":"Precious Metal Gems Blue /50","ebay_kw":"PMG Blue"},{"label":"Precious Metal Gems Red /10","ebay_kw":"PMG Red"}]'::jsonb
FROM generate_series(2020,2025) y
ON CONFLICT (sport,year,brand,set_name) DO NOTHING;
