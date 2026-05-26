-- ============================================================
-- RawIQ — Full database audit + pre-2018 expansion
-- Run date: 2026-05-22
-- ============================================================

-- ── SECTION 1: CLEANUP PHANTOM FUTURE YEARS ──────────────────

-- Football 2026 (2026 NFL season hasn't been played)
DELETE FROM card_sets WHERE sport = 'football' AND year = 2026;

-- Hockey 2026 (2026-27 NHL season not started until Oct 2026)
DELETE FROM card_sets WHERE sport = 'hockey' AND year = 2026;

-- ── SECTION 2: CLEANUP INCORRECT SETS ────────────────────────

-- Topps Chrome Football 2018-2022: Panini had exclusive NFL license 2016-2024.
-- Topps had NO NFL deal during this window — these cards never existed.
DELETE FROM card_sets
WHERE sport = 'football' AND brand = 'Topps' AND set_name = 'Chrome'
  AND year BETWEEN 2018 AND 2022;

-- Panini Gold Standard Basketball: standalone set discontinued after 2016-17.
-- Was folded into Chronicles starting 2017-18. All 2018+ entries are phantoms.
DELETE FROM card_sets
WHERE sport = 'basketball' AND brand = 'Panini' AND set_name = 'Gold Standard';

-- ── SECTION 3: TARGETED 2018-2025 FIXES ──────────────────────

-- Basketball 2018-19: Hoops, Select, Court Kings, Obsidian, Status all existed
-- but were missing from our 2018 row (present in 2019+ correctly).
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 2018, 'Panini', 'Court Kings',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('basketball', 2018, 'Panini', 'Hoops',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('basketball', 2018, 'Panini', 'Obsidian',
   '[{"label":"Base","ebay_kw":""},{"label":"Electric Etch /99","ebay_kw":"Electric"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('basketball', 2018, 'Panini', 'Select',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver"},{"label":"Gold Prizm /10","ebay_kw":"Gold"},{"label":"Black Prizm /1","ebay_kw":"Black"}]'),
  ('basketball', 2018, 'Panini', 'Status',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Football 2024 Topps Chrome (unlicensed but a real product people submit for grading)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('football', 2024, 'Topps', 'Chrome',
   '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Hockey 2025-26: Parkhurst confirmed released for 2025-26 season
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('hockey', 2025, 'Upper Deck', 'Parkhurst',
   '[{"label":"Base","ebay_kw":""},{"label":"Emerald /99","ebay_kw":"Emerald"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── SECTION 4: PRE-2018 BASEBALL (2010–2017) ─────────────────

-- Core Topps flagship sets — all years 2010-2017
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2010, 2017) AS y
CROSS JOIN (VALUES
  ('Topps','Series 1',     '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Black /63","ebay_kw":"Black"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Topps','Series 2',     '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Black /63","ebay_kw":"Black"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Topps','Update',       '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Black /63","ebay_kw":"Black"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Topps','Heritage',     '[{"label":"Base","ebay_kw":""},{"label":"Chrome","ebay_kw":"Chrome"},{"label":"Black Refractor /67","ebay_kw":"Black"},{"label":"Red /10","ebay_kw":"Red"}]'),
  ('Topps','Allen & Ginter','[{"label":"Base","ebay_kw":""},{"label":"Mini","ebay_kw":"Mini"},{"label":"Black /50","ebay_kw":"Black"},{"label":"Printing Plate /1","ebay_kw":"Printing Plate"}]'),
  ('Topps','Finest',       '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold Refractor /50","ebay_kw":"Gold"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'),
  ('Topps','Triple Threads','[{"label":"Base","ebay_kw":""},{"label":"Gold /9","ebay_kw":"Gold"},{"label":"White Whale /1","ebay_kw":"White Whale"}]'),
  ('Topps','Opening Day',  '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"}]'),
  ('Topps','Pro Debut',    '[{"label":"Base","ebay_kw":""},{"label":"Blue /250","ebay_kw":"Blue"},{"label":"Gold /99","ebay_kw":"Gold"}]'),
  ('Topps','Holiday',      '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Topps','Five Star',    '[{"label":"Base Auto","ebay_kw":""},{"label":"Gold Auto /10","ebay_kw":"Gold"},{"label":"Black Auto /1","ebay_kw":"Black"}]'),
  ('Topps','Tier One',     '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Chrome (all 2010-2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(2010, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Gypsy Queen (relaunched 2011)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Gypsy Queen',
  '[{"label":"Base","ebay_kw":""},{"label":"Mini","ebay_kw":"Mini"},{"label":"Black /199","ebay_kw":"Black"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'
FROM generate_series(2011, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Archives (relaunched 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Archives',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Black /63","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Museum Collection (launched 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Museum Collection',
  '[{"label":"Base","ebay_kw":""},{"label":"Copper /299","ebay_kw":"Copper"},{"label":"Silver /99","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Prizm Baseball (2012-2017; Panini had MLBPA license)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Panini', 'Prizm',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini Diamond Kings (2013-2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Panini', 'Diamond Kings',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2013, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Inception (relaunched 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Inception',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Stadium Club (relaunched 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Stadium Club',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Black /50","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman's Best (relaunched 2013)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Best',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /25","ebay_kw":"Black"}]'
FROM generate_series(2013, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Big League (launched 2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Big League',
  '[{"label":"Base","ebay_kw":""},{"label":"Blue","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"}]'
FROM generate_series(2015, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Gold Label (relaunched 2016)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Gold Label',
  '[{"label":"Class 1","ebay_kw":""},{"label":"Class 2","ebay_kw":"Class 2"},{"label":"Class 3","ebay_kw":"Class 3"},{"label":"Black /10","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Dynasty (launched 2016)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Dynasty',
  '[{"label":"Base /5","ebay_kw":""},{"label":"Gold /3","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Transcendent (launched 2016, ultra-premium VIP box set)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Transcendent',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Gallery (modern relaunch 2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('baseball', 2017, 'Topps', 'Gallery',
   '[{"label":"Base","ebay_kw":""},{"label":"Blue /250","ebay_kw":"Blue"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Fire (launched 2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('baseball', 2017, 'Topps', 'Fire',
   '[{"label":"Base","ebay_kw":""},{"label":"Blue Chip","ebay_kw":"Blue"},{"label":"Gold Minted /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman core sets (all 2010-2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2010, 2017) AS y
CROSS JOIN (VALUES
  ('Bowman','Base',         '[{"label":"Base","ebay_kw":""},{"label":"Blue /500","ebay_kw":"Blue"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /25","ebay_kw":"Black"}]'),
  ('Bowman','Chrome',       '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'),
  ('Bowman','Draft Chrome', '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'),
  ('Bowman','Sterling',     '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Bowman','Platinum',     '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── SECTION 5: PRE-2018 BASKETBALL ───────────────────────────
-- Convention: year = start of NBA season (2009 = 2009-10, 2017 = 2017-18)
-- Panini holds NBA license from 2009-10 onward.
-- Key years: 2009 (Curry RC), 2012 (Prizm debut + Davis/Lillard/Kawhi/Klay),
--            2013 (Giannis RC), 2017 (Tatum/Mitchell RCs)

-- National Treasures (flagship RPA set — every year from 2009)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'National Treasures',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2009, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Hoops (mass market, every year from 2009)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Hoops',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2009, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Prizm (debuted 2012-13 season — the most important modern basketball set)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Prizm',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Contenders (Rookie Ticket autos, from 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Contenders',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Sets active from 2012-2017 (Panini's full portfolio expansion era)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2012, 2017) AS y
CROSS JOIN (VALUES
  ('Panini','Absolute',       '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Certified',      '[{"label":"Base","ebay_kw":""},{"label":"Mirror Red /299","ebay_kw":"Red"},{"label":"Mirror Gold /25","ebay_kw":"Gold"},{"label":"Mirror Black /1","ebay_kw":"Black"}]'),
  ('Panini','Immaculate',     '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Spectra',        '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Prizm Draft Picks','[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Gold Standard (through 2016-17 season = year 2016; standalone discontinued after)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Gold Standard',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2016) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Select (from 2014-15 = year 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Select',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver Prizm","ebay_kw":"Silver"},{"label":"Gold Prizm /10","ebay_kw":"Gold"},{"label":"Black Prizm /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Noir (from 2014-15 = year 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Noir',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Flawless (from 2014-15 = year 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Flawless',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss (from 2014-15 = year 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Donruss',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Contenders Draft Picks (from 2015-16 = year 2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Contenders Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2015, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Court Kings (from 2015-16 = year 2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Court Kings',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2015, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Illusions (from 2015-16 = year 2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Illusions',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2015, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Revolution (from 2016-17 = year 2016)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Revolution',
  '[{"label":"Base","ebay_kw":""},{"label":"Cosmic","ebay_kw":"Cosmic"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss Optic (from 2016-17 = year 2016)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Donruss Optic',
  '[{"label":"Base","ebay_kw":""},{"label":"Holo","ebay_kw":"Holo"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Impeccable (from 2017-18 = year 2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 2017, 'Panini', 'Impeccable',
   '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Status (from 2017-18 = year 2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 2017, 'Panini', 'Status',
   '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── SECTION 6: PRE-2018 FOOTBALL (2010–2017) ─────────────────
-- Convention: year = NFL season year (2017 = 2017 NFL season / cards released 2017-18)
-- CRITICAL YEARS: 2017 (Mahomes!), 2012 (Luck/Wilson), 2014 (OBJ), 2016 (Prescott/Wentz)
-- Topps Chrome: had NFL license through 2015 season; Panini exclusive from 2016.

-- Topps Chrome Football (2010-2015 — last year of Topps NFL license)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(2010, 2015) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini core sets — all years 2010-2017
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2010, 2017) AS y
CROSS JOIN (VALUES
  ('Panini',  'National Treasures','[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Contenders',        '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Score',             '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Panini',  'Absolute',          '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Certified',         '[{"label":"Base","ebay_kw":""},{"label":"Mirror Red /299","ebay_kw":"Red"},{"label":"Mirror Gold /25","ebay_kw":"Gold"},{"label":"Mirror Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Donruss',           '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Limited',           '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Threads',           '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini',  'Rookies & Stars',   '[{"label":"Base","ebay_kw":""},{"label":"Gold","ebay_kw":"Gold"},{"label":"Platinum /1","ebay_kw":"Platinum"}]'),
  ('Donruss', 'Elite',             '[{"label":"Base","ebay_kw":""},{"label":"Gold /500","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Prizm Football (from 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Prizm',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Select (from 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Select',
  '[{"label":"Base","ebay_kw":""},{"label":"Prizm","ebay_kw":"Prizm"},{"label":"Gold Prizm /10","ebay_kw":"Gold"},{"label":"Black Prizm /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Spectra (from 2012)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Spectra',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2012, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Immaculate Football (from ~2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Immaculate',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Flawless Football (from ~2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Flawless',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Prizm Draft Picks Football (from ~2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Prizm Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2015, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Contenders Draft Picks Football (from ~2016)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Panini', 'Contenders Draft Picks',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2016, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Panini sets that debuted 2016 season
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2016, 2017) AS y
CROSS JOIN (VALUES
  ('Panini','Chronicles',    '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Donruss Optic', '[{"label":"Base","ebay_kw":""},{"label":"Holo","ebay_kw":"Holo"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Origins',       '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Phoenix',       '[{"label":"Base","ebay_kw":""},{"label":"Purple /99","ebay_kw":"Purple"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Panini','Revolution',    '[{"label":"Base","ebay_kw":""},{"label":"Cosmic","ebay_kw":"Cosmic"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Black Football (from ~2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('football', 2017, 'Panini', 'Black',
   '[{"label":"Base /99","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Impeccable Football (from ~2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('football', 2017, 'Panini', 'Impeccable',
   '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── SECTION 7: PRE-2018 HOCKEY (2009–2017) ────────────────────
-- Convention: year = start of NHL season (2015 = 2015-16 = Connor McDavid RC!)
-- Upper Deck holds exclusive NHL + NHLPA license throughout this period.

-- Core Upper Deck sets — all years 2009-2017
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, t.brand, t.set_name, t.parallels::jsonb
FROM generate_series(2009, 2017) AS y
CROSS JOIN (VALUES
  ('Upper Deck','Series 1',           '[{"label":"Base","ebay_kw":""},{"label":"Young Guns","ebay_kw":"Young Guns"},{"label":"UD Canvas","ebay_kw":"Canvas"},{"label":"High Gloss /10","ebay_kw":"High Gloss"}]'),
  ('Upper Deck','Series 2',           '[{"label":"Base","ebay_kw":""},{"label":"Young Guns","ebay_kw":"Young Guns"},{"label":"UD Canvas","ebay_kw":"Canvas"},{"label":"High Gloss /10","ebay_kw":"High Gloss"}]'),
  ('Upper Deck','SP Authentic',       '[{"label":"Base","ebay_kw":""},{"label":"Sign of the Times Auto","ebay_kw":"Auto"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','The Cup',            '[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','Artifacts',          '[{"label":"Base","ebay_kw":""},{"label":"Teal /99","ebay_kw":"Teal"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','Ice',                '[{"label":"Base","ebay_kw":""},{"label":"Gold /9","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','Black Diamond',      '[{"label":"Base","ebay_kw":""},{"label":"Double Diamond","ebay_kw":"Double"},{"label":"Triple Diamond","ebay_kw":"Triple"},{"label":"Quad Diamond /1","ebay_kw":"Quad"}]'),
  ('Upper Deck','Ultimate Collection','[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Autograph","ebay_kw":"Auto"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','SPx',                '[{"label":"Base","ebay_kw":""},{"label":"Silver /199","ebay_kw":"Silver"},{"label":"Gold /99","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','Trilogy',            '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','O-Pee-Chee',         '[{"label":"Base","ebay_kw":""},{"label":"Retro","ebay_kw":"Retro"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'),
  ('Upper Deck','MVP',                '[{"label":"Base","ebay_kw":""},{"label":"Silver Script","ebay_kw":"Silver"},{"label":"Gold Script /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
) AS t(brand, set_name, parallels)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- O-Pee-Chee Platinum (chromium, all years 2009-2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'O-Pee-Chee', 'Platinum',
  '[{"label":"Base","ebay_kw":""},{"label":"Rainbow","ebay_kw":"Rainbow"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2009, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Portfolio (from 2014-15 = year 2014)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'Portfolio',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver","ebay_kw":"Silver"},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2014, 2017) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Credentials (debuted 2017-18 = year 2017)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('hockey', 2017, 'Upper Deck', 'Credentials',
   '[{"label":"Base","ebay_kw":""},{"label":"Gold /99","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;
