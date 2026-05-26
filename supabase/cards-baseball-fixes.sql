-- ============================================================
-- RawIQ — Baseball / Basketball cleanup + missing set additions
-- Run date: 2026-05-22
-- ============================================================

-- ── 1. DELETE basketball 2026-27 (no cards released yet) ──────────────
DELETE FROM card_sets WHERE sport = 'basketball' AND year = 2026;

-- ── 2. DELETE baseball 2026 sets NOT yet released as of May 2026 ──────
--    Keep: Series 1 (Feb 11), Heritage (Mar 18), Bowman Base (May 13), Gypsy Queen (April)
--    Remove: Allen & Ginter (Jul), Chrome (Sep), Finest (Jul/Aug), Series 2 (Jun 10),
--            Stadium Club (Aug), Update (Oct), Bowman Chrome (Aug), Bowman Draft Chrome (Nov)
DELETE FROM card_sets
WHERE sport = 'baseball' AND year = 2026
  AND (brand, set_name) IN (
    ('Topps',  'Allen & Ginter'),
    ('Topps',  'Chrome'),
    ('Topps',  'Finest'),
    ('Topps',  'Series 2'),
    ('Topps',  'Stadium Club'),
    ('Topps',  'Update'),
    ('Bowman', 'Chrome'),
    ('Bowman', 'Draft Chrome')
  );

-- ── 3. DELETE Panini baseball 2024+ (license expired July 31, 2023) ───
DELETE FROM card_sets WHERE sport = 'baseball' AND brand = 'Panini' AND year >= 2024;

-- ── 4. ADD missing 2026 baseball (released but not in DB) ─────────────
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('baseball', 2026, 'Topps', 'Opening Day',  '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"}]'),
('baseball', 2026, 'Topps', 'Big League',   '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"}]'),
('baseball', 2026, 'Topps', 'Pro Debut',    '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 5. ADD missing premium Topps baseball sets (2018-2025) ────────────
-- Topps Five Star (annual ultra-premium autograph set)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT
  'baseball', y, 'Topps', 'Five Star',
  '[{"label":"Base Auto","ebay_kw":""},{"label":"Gold Auto /10","ebay_kw":"Gold"},{"label":"Black Auto /1","ebay_kw":"Black"}]'
FROM generate_series(2018, 2025) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Museum Collection (annual premium)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT
  'baseball', y, 'Topps', 'Museum Collection',
  '[{"label":"Base","ebay_kw":""},{"label":"Copper /299","ebay_kw":"Copper"},{"label":"Silver /99","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2018, 2025) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Dynasty (annual ultra-low-numbered premium)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT
  'baseball', y, 'Topps', 'Dynasty',
  '[{"label":"Base /5","ebay_kw":""},{"label":"Gold /3","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2018, 2025) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Cosmic Chrome Baseball (2024-2025)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('baseball', 2024, 'Topps', 'Cosmic Chrome',
 '[{"label":"Base","ebay_kw":""},{"label":"Green /99","ebay_kw":"Green"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]'),
('baseball', 2025, 'Topps', 'Cosmic Chrome',
 '[{"label":"Base","ebay_kw":""},{"label":"Green /99","ebay_kw":"Green"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Cosmic Chrome x Cactus Jack (2025 Fanatics Fest exclusive — Travis Scott collab)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('baseball', 2025, 'Topps', 'Cosmic Chrome x Cactus Jack',
 '[{"label":"Base","ebay_kw":"Cactus Jack"},{"label":"Gold /25","ebay_kw":"Gold Cactus Jack"},{"label":"Black /1","ebay_kw":"Black Cactus Jack"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Luminaries (2024)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('baseball', 2024, 'Topps', 'Luminaries',
 '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Gilded Collection (2025)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
('baseball', 2025, 'Topps', 'Gilded Collection',
 '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;
