-- ============================================================
-- RawIQ — Vintage expansion: 1948–2009 for all 4 sports
-- Run date: 2026-05-22
-- ============================================================
-- Parallel convention:
--   vintage_base  = [{"label":"Base","ebay_kw":""}]
--   tiffany       = [{"label":"Base","ebay_kw":""},{"label":"Tiffany","ebay_kw":"Tiffany"}]
--   finest        = [{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"}]
--   chrome        = [{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]


-- ══════════════════════════════════════════════════════════════
-- BASEBALL (filling 1948–2009; we already have 2010–2026)
-- ══════════════════════════════════════════════════════════════

-- Topps Baseball flagship 1951-1983 (Base only)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Series 1',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1951, 1980) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps also released as a single set pre-Series 1/2 split; label them consistently
-- Topps 1981-1983 (Tiffany version started 1984)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Series 1',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1981, 1983) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps 1984-1991 (Tiffany factory sets produced alongside base)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Series 1',
  '[{"label":"Base","ebay_kw":""},{"label":"Tiffany","ebay_kw":"Tiffany"}]'
FROM generate_series(1984, 1991) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps 1992-2009 (Series 1 + Series 2 split era, base only for flagship)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Series 1',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1992, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Series 2',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1992, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Traded / Update Series (Traded: 1981-2004; Update: 2005-2009)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Traded',
  '[{"label":"Base","ebay_kw":""},{"label":"Tiffany","ebay_kw":"Tiffany"}]'
FROM generate_series(1981, 2004) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Update',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(2005, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Baseball — original run (1948-1955)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Base',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1948, 1955) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Baseball — modern relaunch (1989-2009; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Base',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1989, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Chrome (launched 1997; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(1997, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Draft Chrome (1997-2009; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Draft Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(1997, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman's Best (1994-2009; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Best',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Atomic Refractor","ebay_kw":"Atomic"}]'
FROM generate_series(1994, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Sterling (1996-2009; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Bowman', 'Sterling',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1996, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer Baseball — first run (1960-1963, single-brand baseball sets)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Fleer', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1960, 1963) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer Baseball — main run (1981-1991 with Glossy variants; 1992-2005 base only)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Fleer', 'Baseball',
  '[{"label":"Base","ebay_kw":""},{"label":"Glossy","ebay_kw":"Glossy"}]'
FROM generate_series(1981, 1991) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Fleer', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1992, 2005) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss Baseball (1981-1998)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Donruss', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1981, 1998) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss Baseball (2001-2005 under Playoff license)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Donruss', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(2001, 2005) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Score Baseball (1988-1998)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Score', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1988, 1998) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Baseball (1989-2009; lost MLB license after 2009)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Upper Deck', 'Baseball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1989, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Finest Baseball (launched 1993 — introduced Refractors; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Finest',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"}]'
FROM generate_series(1993, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Chrome Baseball (launched 1996; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(1996, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Stadium Club (1991-2003 original run; 2008 standalone; we have 2014+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Stadium Club',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1991, 2003) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('baseball', 2008, 'Topps', 'Stadium Club',
   '[{"label":"Base","ebay_kw":""}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Heritage (launched 2001; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Heritage',
  '[{"label":"Base","ebay_kw":""},{"label":"Chrome","ebay_kw":"Chrome"},{"label":"Black Refractor /67","ebay_kw":"Black"}]'
FROM generate_series(2001, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Allen & Ginter (launched 2006; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Allen & Ginter',
  '[{"label":"Base","ebay_kw":""},{"label":"Mini","ebay_kw":"Mini"},{"label":"Black /50","ebay_kw":"Black"}]'
FROM generate_series(2006, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Opening Day (launched 2003; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Opening Day',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(2003, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Triple Threads (launched 2006; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Triple Threads',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /9","ebay_kw":"Gold"},{"label":"White Whale /1","ebay_kw":"White Whale"}]'
FROM generate_series(2006, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Gypsy Queen (launched 2011; we have 2011+)
-- Topps Five Star (launched 1999; we have 2010+... adding 1999-2009)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Topps', 'Five Star',
  '[{"label":"Base Auto","ebay_kw":""},{"label":"Gold Auto /10","ebay_kw":"Gold"},{"label":"Black Auto /1","ebay_kw":"Black"}]'
FROM generate_series(1999, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Museum Collection (launched 2012; already have 2012+)
-- No vintage needed.

-- SP Authentic Baseball (1995-2009; Upper Deck brand)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'baseball', y, 'Upper Deck', 'SP Authentic',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1995, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;


-- ══════════════════════════════════════════════════════════════
-- BASKETBALL (filling gaps back to 1957; we have 2009-2025)
-- Convention: year = start of NBA season (1986 = 1986-87)
-- ══════════════════════════════════════════════════════════════

-- Topps Basketball (1957-58 single season; 1969-70 through 2009-10)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 1957, 'Topps', 'Basketball',
   '[{"label":"Base","ebay_kw":""}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Basketball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1969, 1981) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer Basketball (1961-62 first year; gap; 1986-87 Jordan RC; 1988-2001)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 1961, 'Fleer', 'Basketball',
   '[{"label":"Base","ebay_kw":""}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- 1986-87 Fleer — THE most important vintage basketball set ever (Jordan RC #57)
INSERT INTO card_sets (sport, year, brand, set_name, parallels) VALUES
  ('basketball', 1986, 'Fleer', 'Basketball',
   '[{"label":"Base","ebay_kw":""},{"label":"Sticker","ebay_kw":"Sticker"}]')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Fleer', 'Basketball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1987, 1993) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer Ultra Basketball (premium subset of Fleer; 1991-2007)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Fleer', 'Ultra',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold Medallion","ebay_kw":"Gold Medallion"}]'
FROM generate_series(1991, 2007) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- NBA Hoops (1989-90 through 2009-10 across various manufacturers)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Panini', 'Hoops',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1989, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- SkyBox Basketball (1990-91 through 1994-95; merged into Fleer/SkyBox after)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'SkyBox', 'Basketball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1990, 1995) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Basketball (1991-92 through 2008-09; lost license 2010)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Upper Deck', 'Basketball',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1991, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Exquisite Collection Basketball (2003-04 LeBron James RC! — year 2003)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Upper Deck', 'Exquisite Collection',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /25","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2003, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Chrome Basketball (1996-97 through 2008-09; Kobe Bryant RC in 1996)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Chrome Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(1996, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Finest Basketball (1996-97 through 2007-08)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Topps', 'Finest Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"}]'
FROM generate_series(1996, 2007) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Basketball (2002-2009 modern era; Steph Curry 2009 RC!)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Bowman', 'Basketball',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2002, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- SP Authentic Basketball (1995-96 through 2008-09; Upper Deck)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', y, 'Upper Deck', 'SP Authentic',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1995, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;


-- ══════════════════════════════════════════════════════════════
-- FOOTBALL (filling 1948–2009; we have 2010–2025)
-- Convention: year = NFL season year (1985 = 1985 season)
-- ══════════════════════════════════════════════════════════════

-- Bowman Football original run (1948-1955; no 1949 edition was produced)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Bowman', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM unnest(ARRAY[1948, 1950, 1951, 1952, 1953, 1954, 1955]) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Football (started 1951; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1951, 1983) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Football 1984-1991 (Tiffany era)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Football',
  '[{"label":"Base","ebay_kw":""},{"label":"Tiffany","ebay_kw":"Tiffany"}]'
FROM generate_series(1984, 1991) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Football 1992-2009
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1992, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer AFL Football (1960-1963)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Fleer', 'AFL Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1960, 1963) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Score Football (1989-2009; continued post-Panini)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Score', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1989, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Pro Set Football (1989-1993; famous for error cards)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Pro Set', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1989, 1993) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Football (1991-2010)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Upper Deck', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1991, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Chrome Football (1996-2009; Panini exclusive started 2016; we have 2010-2015)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Topps', 'Chrome',
  '[{"label":"Base","ebay_kw":""},{"label":"Refractor","ebay_kw":"Refractor"},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Red /5","ebay_kw":"Red"},{"label":"Superfractor /1","ebay_kw":"Superfractor"}]'
FROM generate_series(1996, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Donruss Football (various years; brand bounced around)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Donruss', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1984, 1998) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Fleer Football (1994-1999 via various licensing)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Fleer', 'Football',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1994, 1999) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Bowman Football modern (2000-2009; proper annual product; we have 2010+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Bowman', 'Football',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(2000, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- SP Authentic Football (1995-2009; Upper Deck)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', y, 'Upper Deck', 'SP Authentic',
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /50","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1995, 2009) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;


-- ══════════════════════════════════════════════════════════════
-- HOCKEY (filling 1951–2008; we have 2009–2025)
-- Convention: year = start of NHL season (1979 = 1979-80 = Gretzky RC!)
-- ══════════════════════════════════════════════════════════════

-- Parkhurst Hockey (1951-52 to 1963-64 = years 1951-1963)
-- Most important vintage hockey brand for Gordie Howe, Jean Beliveau, etc.
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Parkhurst', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1951, 1963) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Topps Hockey (US market; 1954-55 to 1981-82 = years 1954-1981)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Topps', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1954, 1981) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- O-Pee-Chee Hockey (Canadian market; 1958-59 through 2007-08 = years 1958-2007)
-- KEY CARDS: 1979 (#18 Gretzky RC), 1985 (#9 Lemieux RC), 1971 (#259 Ken Dryden RC)
-- Upper Deck acquired OPC trademark in 2006; kept branding continuous
-- NOTE: We have Upper Deck "O-Pee-Chee" for 2009+. Vintage = "O-Pee-Chee" brand, "Hockey" set.
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'O-Pee-Chee', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1958, 2007) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Upper Deck Hockey (launched 1990-91 = year 1990; introduced Young Guns; we have 2018+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', s,
  '[{"label":"Base","ebay_kw":""},{"label":"Young Guns","ebay_kw":"Young Guns"},{"label":"High Gloss /10","ebay_kw":"High Gloss"}]'
FROM generate_series(1990, 2008) AS y
CROSS JOIN unnest(ARRAY['Series 1','Series 2']) AS s
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', s,
  '[{"label":"Base","ebay_kw":""},{"label":"Gold /10","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1990, 2008) AS y
CROSS JOIN unnest(ARRAY['SP Authentic','The Cup','Artifacts','Ice','Black Diamond','Ultimate Collection']) AS s
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Score Hockey (1990-91 through 1997-98 = years 1990-1997)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Score', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1990, 1997) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Pro Set Hockey (1990-91 through 1992-93 = years 1990-1992)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Pro Set', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1990, 1992) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- Pacific Hockey (1994-95 through 2003-04 = years 1994-2003)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Pacific', 'Hockey',
  '[{"label":"Base","ebay_kw":""}]'
FROM generate_series(1994, 2003) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- O-Pee-Chee Platinum Hockey (launched 2009-10 as modern chromium product = year 2009)
-- We already have 2009-2025 from previous patches. Nothing to add here for vintage.

-- Upper Deck SPx Hockey (1996-97 through 2008-09 = years 1996-2008; we have 2018+)
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', y, 'Upper Deck', 'SPx',
  '[{"label":"Base","ebay_kw":""},{"label":"Silver /199","ebay_kw":"Silver"},{"label":"Gold /99","ebay_kw":"Gold"},{"label":"Black /1","ebay_kw":"Black"}]'
FROM generate_series(1996, 2008) AS y
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;
