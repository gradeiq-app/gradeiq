-- =============================================================================
-- parallels-deep-fix-v34.sql
-- One set corrected:
--
-- 1. Upper Deck Series 1 Hockey (36 rows, 1990-2025)
--    Series 1/2 split began in 1994-95 (DB year 1994).
--    DB rows 1990-1993 represent the unified Upper Deck Hockey set
--    (no Series 1/2 split existed yet; no numbered parallels).
--    DB year 2004 = 2004-05 NHL lockout (no product released).
--
--    Parallel structure by era (DB year = season start year):
--
--    • 1990-1993:  Unified UD Hockey (no Series 1 split, no parallels)
--                 → placeholder [Base] only
--
--    • 1994:      First Series 1. Electric Ice foil parallel introduced
--                 (full-set holographic foil parallel, inserted in packs)
--                 (1994-95 confirmed: Electric Ice present Series 1)
--
--    • 1995:      Electric Ice second/final year. Electric Ice Gold added
--                 as one-per-box premium tier.
--                 (1995-96 confirmed: Electric Ice + Electric Ice Gold)
--
--    • 1996-2003:  Exclusives /100 era. Serial-numbered parallel of the
--                 full base set, ~100 copies per card.
--                 (1996-97 confirmed via Cardboard Connection;
--                  1999-00 confirmed: 170 Exclusives /100 = Series 1 count;
--                  2003-04 confirmed on TCDB)
--                 No separate High Gloss /10 tier in this era.
--
--    • 2004:      NHL lockout — no Upper Deck Series 1 released.
--                 → placeholder [Base]
--
--    • 2005-2009:  Post-lockout. High Gloss /10 is the primary parallel.
--                 (2005-06 Cardboard Connection confirmed: High Gloss /10
--                  + Printing Plates 1/1; no Exclusives /100 listed)
--                 (2006-07: "HG Exclusives" /10 = same /10 tier, renamed)
--
--    • 2010:      20th Anniversary year. Exclusives /100 returns alongside
--                 Spectrum /10 (High Gloss). Special 20th Anniversary foil
--                 insert (1:5 packs) added.
--                 (2010-11 Cardboard Connection confirmed all three tiers)
--
--    • 2011-2019:  Canvas era. UD Canvas debuted 2011-12 as alternate art
--                 insert (120 cards, 1:4 packs). Both Exclusives /100 and
--                 High Gloss /10 confirmed throughout.
--                 (2011-12 confirmed via Cardboard Connection and TCDB;
--                  2012-13: Exclusives /100 + Exclusives Spectrum /10;
--                  2013-14 and 2014-15 confirmed Exclusives /100 + HG /10)
--
--    • 2020-2022:  Clear Cut acetate parallel added (Hobby, 1:96 packs).
--                 French language variant confirmed as hobby insert.
--                 (2020-21 confirmed: Exclusives /100, High Gloss /10,
--                  Clear Cut, French 1:30 packs;
--                  2021-22 and 2022-23 confirmed similar structure)
--
--    • 2023-2025:  Outburst parallels introduced: Outburst Silver (1:30),
--                 Outburst Red /25, Outburst Gold 1/1.
--                 Deluxe /250 added for all base + Young Guns cards.
--                 French variant not confirmed for 2023+.
--                 (2023-24 confirmed via Cardboard Connection;
--                  2024-25 confirmed via Beckett;
--                  2025-26 confirmed via Checklist Insider)
--
-- Total: 36 rows updated
-- Sources: Cardboard Connection, Beckett, Checklist Insider,
--          TCDB, HockeyDB, BreakNinja
-- =============================================================================

-- ─── 1990-1993: Pre-Series 1 era ─────────────────────────────────────────────

-- Upper Deck Hockey was a unified set; no Series 1/2 split.
-- No serial-numbered parallels existed. Young Guns concept was nascent.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 1990 AND 1993;

-- ─── 1994: Electric Ice debut ────────────────────────────────────────────────

-- First true Series 1. Electric Ice foil parallel introduced —
-- holographic/foil treatment applied to every base card in the set.
-- Young Guns rookie subset formally established.
-- (DB year 1994 = 1994-95 season)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Electric Ice","ebay_kw":"Electric Ice"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year = 1994;

-- ─── 1995: Electric Ice + Electric Ice Gold ──────────────────────────────────

-- Electric Ice continues (second and final year). Electric Ice Gold added
-- as a one-per-hobby-box premium tier (gold foil variant of Electric Ice).
-- (DB year 1995 = 1995-96 season; both confirmed)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Electric Ice","ebay_kw":"Electric Ice"},
  {"label":"Electric Ice Gold","ebay_kw":"Electric Ice Gold"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year = 1995;

-- ─── 1996-2003: Exclusives /100 era ──────────────────────────────────────────

-- Exclusives /100: full-set serial-numbered parallel (~100 per card).
-- The sole numbered parallel in this era; no separate High Gloss /10 yet.
-- Young Guns Exclusives /100 also exist as a subset of the Exclusives.
-- (1996-97 confirmed; 1999-00 confirmed 170 Series 1 cards × /100;
--  2003-04 confirmed on TCDB; lockout 2004-05 ends this era)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 1996 AND 2003;

-- ─── 2004: NHL Lockout ───────────────────────────────────────────────────────

-- No Upper Deck Series 1 Hockey released in 2004-05 due to lockout.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year = 2004;

-- ─── 2005-2009: Post-lockout High Gloss era ──────────────────────────────────

-- High Gloss /10 is the primary (sole) serial-numbered base parallel.
-- Exclusives /100 was absent or consolidated; only /10 tier confirmed.
-- 2005-06: High Gloss /10 + Printing Plates 1/1 (per Cardboard Connection).
-- 2006-07: Called "HG Exclusives" /10 — same /10 tier with alternate branding.
-- (DB year 2005 = 2005-06 through 2009 = 2009-10)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 2005 AND 2009;

-- ─── 2010: 20th Anniversary special year ────────────────────────────────────

-- Exclusives /100 reinstated alongside Spectrum /10 (= High Gloss).
-- Special 20th Anniversary foil variant inserted at 1:5 packs.
-- (DB year 2010 = 2010-11 season; all three tiers confirmed via
--  Cardboard Connection 2010-11 review: Exclusive /100, Spectrum /10,
--  20th Anniversary 1:5 packs)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"20th Anniversary","ebay_kw":"20th Anniversary"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year = 2010;

-- ─── 2011-2019: Canvas era ───────────────────────────────────────────────────

-- UD Canvas debuted in 2011-12 Series 1 as alternate art insert
-- (120 cards including YG Canvas rookies; 1:4 hobby packs).
-- Both Exclusives /100 and High Gloss /10 (also called "Spectrum /10"
-- or "Exclusives Spectrum /10" depending on year) confirmed throughout.
-- (2011-12 TCDB and Cardboard Connection confirmed;
--  2012-13: Exclusives /100 + Exclusives Spectrum /10;
--  2013-14 and 2014-15: Exclusives /100 + High Gloss Spectrum /10)
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Young Guns","ebay_kw":"Young Guns"},
  {"label":"Canvas","ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Young Guns Canvas"},
  {"label":"Exclusives /100","ebay_kw":"Exclusives"},
  {"label":"High Gloss /10","ebay_kw":"High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 2011 AND 2019;

-- ─── 2020-2022: Clear Cut + French era ──────────────────────────────────────

-- Clear Cut acetate parallel added (Hobby only, 1:96 packs).
-- French language variant confirmed as hobby insert (1:30 packs base,
-- 1:120 packs Young Guns).
-- (2020-21 confirmed: Exclusives /100, High Gloss /10, Clear Cut, French;
--  2021-22 confirmed; 2022-23 confirmed via Beckett)
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
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 2020 AND 2022;

-- ─── 2023-2025: Outburst era ─────────────────────────────────────────────────

-- Outburst parallels introduced (2023-24): Silver (1:30 packs, unnumbered),
-- Red /25, Gold 1/1. Deluxe /250 added for base + YG cards.
-- French not confirmed for 2023+.
-- (2023-24 confirmed via Cardboard Connection;
--  2024-25 confirmed via Beckett;
--  2025-26 confirmed via Checklist Insider)
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
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey'
  AND year BETWEEN 2023 AND 2025;
