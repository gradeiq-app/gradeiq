-- =============================================================================
-- parallels-deep-fix-v38.sql
-- One set corrected:
--
-- 1. Upper Deck Hockey (set_name = 'Hockey', 26 rows, 2000-2025)
--    This represents the unified "Upper Deck Hockey" product (inclusive
--    of Canadian market releases and the Extended Series lineage).
--    Debuted in the DB at 2000 (= 2000-01 NHL season).
--    Shares the same base parallel program as Series 1 and Series 2,
--    with additions: Team Canada insert, Portrait Auto, Young Guns
--    Redemption, and RC Auto variants.
--    DB year 2004 = 2004-05 NHL lockout (no product released).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 2000-2003:  Exclusives /100 era (same as Series 1/2 for this period).
--                 Team Canada insert subset present. Young Guns are the
--                 key rookie cards. No separate High Gloss /10 yet.
--
--    • 2004:      NHL lockout — no product released. Placeholder.
--
--    • 2005-2009:  Post-lockout. High Gloss /10 primary parallel.
--                 (Same structure as Series 1/2; Team Canada insert ongoing)
--
--    • 2010:      20th Anniversary special year.
--                 Exclusives /100 + High Gloss /10 both confirmed.
--                 Plus 20th Anniversary foil (1:5 packs).
--
--    • 2011-2019:  Canvas era. UD Canvas debuted 2011-12.
--                 Exclusives /100 + High Gloss /10 throughout.
--                 Team Canada insert present each year.
--
--    • 2020-2022:  Clear Cut + French era.
--                 (Same structure as Series 1/2)
--
--    • 2023-2025:  Outburst era. Deluxe /250, Outburst Silver/Red/Gold.
--                 (Same structure as Series 1/2)
--
-- Total: 26 rows updated
-- Sources: Cardboard Connection, Beckett, Checklist Insider, TCDB
-- =============================================================================

-- ─── 2000-2003: Exclusives /100 era ──────────────────────────────────────────

-- Same base parallel structure as Series 1/2 in this era.
-- Exclusives /100 is the sole serial-numbered base parallel.
-- Team Canada subset present as a key insert.
-- (DB year 2000 = 2000-01 season through 2003 = 2003-04 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 2000 AND 2003;

-- ─── 2004: NHL Lockout ───────────────────────────────────────────────────────

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year = 2004;

-- ─── 2005-2009: Post-lockout High Gloss era ──────────────────────────────────

-- High Gloss /10 is the primary serial-numbered base parallel.
-- Same structure as Series 1/2. Team Canada insert continues.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2009;

-- ─── 2010: 20th Anniversary special year ─────────────────────────────────────

-- Exclusives /100 reinstated alongside High Gloss /10.
-- 20th Anniversary foil parallel (1:5 packs).
-- (DB year 2010 = 2010-11 season; same as Series 1)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"20th Anniversary","ebay_kw":"20th Anniversary"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year = 2010;

-- ─── 2011-2019: Canvas era ───────────────────────────────────────────────────

-- UD Canvas debuted in 2011-12 (same as Series 1/2).
-- Exclusives /100 + High Gloss /10 throughout.
-- Team Canada insert present each year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2019;

-- ─── 2020-2022: Clear Cut + French era ──────────────────────────────────────

-- Clear Cut acetate (Hobby, 1:96 packs) + French variant added.
-- Same structure as Series 1/2.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"French","ebay_kw":"French"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"},
  {"label":"Clear Cut","ebay_kw":"Clear Cut"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 2020 AND 2022;

-- ─── 2023-2025: Outburst era ─────────────────────────────────────────────────

-- Outburst Silver (1:30), Red /25, Gold 1/1; Deluxe /250 added.
-- Same structure as Series 1/2.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Team Canada","ebay_kw":"Team Canada"},
  {"label":"Deluxe /250","ebay_kw":"Deluxe"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"Outburst Silver","ebay_kw":"Outburst Silver"},
  {"label":"Outburst Red /25","ebay_kw":"Outburst Red"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"},
  {"label":"Outburst Gold 1/1","ebay_kw":"Outburst Gold"},
  {"label":"Clear Cut","ebay_kw":"Clear Cut"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey'
  AND year BETWEEN 2023 AND 2025;
