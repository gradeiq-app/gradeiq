-- =============================================================================
-- parallels-deep-fix-v35.sql
-- One set corrected:
--
-- 1. Upper Deck Series 2 Hockey (36 rows, 1990-2025)
--    Series 1/2 split began in 1994-95 (DB year 1994).
--    DB rows 1990-1993 are placeholders (no Series 2 product existed).
--    DB year 2004 = 2004-05 NHL lockout (no product released).
--
--    Series 2 shares the same parallel program as Series 1 each year;
--    only the card numbers differ (Series 2 continues from Series 1).
--    All era breakpoints, parallel types, and print runs are identical
--    to parallels-deep-fix-v34.sql (Series 1).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 1990-1993:  No Series 2 product. Placeholder rows.
--
--    • 1994:      First Series 2. Electric Ice foil parallel
--                 (same as Series 1; confirmed 1994-95 TCDB)
--
--    • 1995:      Electric Ice + Electric Ice Gold (1-per-box)
--                 (1995-96 confirmed; same as Series 1)
--
--    • 1996-2003:  Exclusives /100 (serial-numbered full-set parallel)
--                 (same as Series 1; no separate High Gloss /10 yet)
--
--    • 2004:      NHL lockout — no Upper Deck Series 2 released.
--
--    • 2005-2009:  High Gloss /10 only (post-lockout, same as S1)
--
--    • 2010:      20th Anniversary + Exclusives /100 + High Gloss /10
--                 (20th Anniversary applies to both Series products)
--
--    • 2011-2019:  Canvas era. UD Canvas confirmed in both Series 1
--                 and Series 2 from 2011-12 onward (TCDB confirmed
--                 "Upper Deck Series 2 UD Canvas 2011-12" separately).
--                 Exclusives /100 + High Gloss /10 throughout.
--
--    • 2020-2022:  + Clear Cut acetate + French variant
--                 (same as Series 1; confirmed via Beckett)
--
--    • 2023-2025:  + Outburst Silver/Red /25/Gold 1/1 + Deluxe /250
--                 (same as Series 1; confirmed via Beckett/CC)
--
-- Total: 36 rows updated
-- Sources: TCDB, Cardboard Connection, Beckett, HockeyDB, BreakNinja
-- =============================================================================

-- ─── 1990-1993: No Series 2 product ─────────────────────────────────────────

-- Upper Deck Hockey was a unified set; no Series 2 existed before 1994-95.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 1993;

-- ─── 1994: Series 2 debut — Electric Ice ─────────────────────────────────────

-- First year of Series 2 (1994-95 season split). Electric Ice foil parallel
-- present in both Series 1 and Series 2.
-- (DB year 1994 = 1994-95 season; confirmed TCDB)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Electric Ice","ebay_kw":"Electric Ice"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year = 1994;

-- ─── 1995: Electric Ice + Electric Ice Gold ──────────────────────────────────

-- Electric Ice second/final year; Electric Ice Gold 1-per-box premium tier.
-- (DB year 1995 = 1995-96 season; same structure as Series 1)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Electric Ice","ebay_kw":"Electric Ice"},
  {"label":"Electric Ice Gold","ebay_kw":"Electric Ice Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year = 1995;

-- ─── 1996-2003: Exclusives /100 era ──────────────────────────────────────────

-- Same parallel structure as Series 1: Exclusives /100 is the sole
-- serial-numbered parallel. No separate High Gloss /10 in this era.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 1996 AND 2003;

-- ─── 2004: NHL Lockout ───────────────────────────────────────────────────────

-- No Upper Deck Series 2 Hockey released in 2004-05.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year = 2004;

-- ─── 2005-2009: Post-lockout High Gloss era ──────────────────────────────────

-- High Gloss /10 is the primary (sole) serial-numbered base parallel.
-- Same structure as Series 1 for these years.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2009;

-- ─── 2010: 20th Anniversary special year ─────────────────────────────────────

-- 20th Anniversary foil (1:5 packs), Exclusives /100, Spectrum /10 reinstated.
-- Both Series 1 and Series 2 shared the 20th Anniversary parallel program.
-- (DB year 2010 = 2010-11 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"20th Anniversary","ebay_kw":"20th Anniversary"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year = 2010;

-- ─── 2011-2019: Canvas era ───────────────────────────────────────────────────

-- UD Canvas present in Series 2 (confirmed via TCDB: separate
-- "Upper Deck Series 2 UD Canvas 2011-12" checklist).
-- Exclusives /100 + High Gloss /10 throughout this era.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2019;

-- ─── 2020-2022: Clear Cut + French era ──────────────────────────────────────

-- Clear Cut acetate (Hobby, 1:96 packs) + French variant added.
-- Same structure as Series 1 for these years (confirmed Beckett).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"French","ebay_kw":"French"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"},
  {"label":"Clear Cut","ebay_kw":"Clear Cut"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 2020 AND 2022;

-- ─── 2023-2025: Outburst era ─────────────────────────────────────────────────

-- Outburst Silver (1:30 packs), Outburst Red /25, Outburst Gold 1/1,
-- Deluxe /250. Same parallel program as Series 1.
-- (2023-24 and 2024-25 confirmed; 2025-26 mirrors 2024-25)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Deluxe /250","ebay_kw":"Deluxe"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"Outburst Silver","ebay_kw":"Outburst Silver"},
  {"label":"Outburst Red /25","ebay_kw":"Outburst Red"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"},
  {"label":"Outburst Gold 1/1","ebay_kw":"Outburst Gold"},
  {"label":"Clear Cut","ebay_kw":"Clear Cut"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey'
  AND year BETWEEN 2023 AND 2025;
