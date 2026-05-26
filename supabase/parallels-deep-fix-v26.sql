-- =============================================================================
-- parallels-deep-fix-v26.sql
-- One set corrected:
--
-- 1. Bowman's Best Baseball (29 rows, 1994-2009 and 2013-2025)
--    Note: 2010-2012 are absent from DB (correct — product discontinued
--          those years). The DB rows that never had a real product:
--          2006 (1-year hiatus), 2008-2009, 2013-2014 → all set to [Base].
--
--    Actual release years:
--    • 1994-1995  : Base + Refractor (unnumbered chrome)
--    • 1996-1997  : + Atomic Refractor (both unnumbered)
--    • 1998-1999  : Refractor /400 + Atomic Refractor /100 (first numbered)
--    • 2000-2001  : Base set IS on chrome/refractor stock; no separate parallel
--    • 2002       : Chrome era ends; Blue /300, Red /200, Gold /50
--    • 2003       : Blue /100, Red /50
--    • 2004       : Green /100, Red /20
--    • 2005       : Largest early rainbow: Green–Black 1/1 + Plates
--    • 2006       : No product (1-year hiatus) → [Base]
--    • 2007       : Return: Green /249, Blue /99, Gold /50, Red 1/1, Plates
--    • 2008-2009  : No product (discontinued) → [Base]
--    • 2013-2014  : No product (still discontinued; revival was 2015) → [Base]
--    • 2015       : Revival: Atomic + Blue /150 … SuperFractor 1/1 + Plates
--    • 2016       : Atomic + Blue /250, Green /99, Gold /50, Orange /35, Red /5
--    • 2017-2020  : Refractor + Atomic + Purple /250 … Red /10 + SuperFractor
--    • 2021       : + Aqua Lava /199, Gold Lava /75, Red Lava /5 (Lava era begins)
--    • 2022       : + Mini-Diamond /299 + Green Mini-Diamond /99; Atomic retained
--    • 2023       : Atomic out; Wave Refractor in (unnumbered)
--    • 2024       : + Purple Mojo /250, Blue X-Fractor /150, Yellow Lazer /75,
--                    Gold Lava /50, Black /10; Red drops to /5
--    • 2025       : Lazer family explodes (Lazer /350, Purple Lazer, Blue Lazer,
--                    Yellow, Aqua /199 variants added)
--
-- Total: 29 rows updated
-- Sources: BaseballCardPedia, CardboardConnection, Beckett, ChecklistInsider
-- =============================================================================

-- ─── BOWMAN'S BEST BASEBALL ─────────────────────────────────────────────────

-- 1994: Debut year. Full set on chrome stock; one unnumbered Refractor parallel.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1994;

-- 1995: Same structure as 1994 (no Atomic yet).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1995;

-- 1996: Atomic Refractor introduced (unnumbered). Both Refractor and Atomic
--   are present; neither is serial-numbered.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1996;

-- 1997: Same two unnumbered parallels as 1996.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1997;

-- 1998: First year with numbered parallels.
--   Refractor /400 + Atomic Refractor /100 (both serial-numbered for first time).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /400","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor /100","ebay_kw":"Atomic Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1998;

-- 1999: Same numbered structure as 1998.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor /400","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor /100","ebay_kw":"Atomic Refractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 1999;

-- 2000: Entire base set is printed on chrome/refractor stock.
--   "All 200 base cards are Refractors" — no separate parallel exists.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2000;

-- 2001: Same situation as 2000 — all base cards are printed on refractor stock.
--   No distinct parallel structure documented.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2001;

-- 2002: Bowman's Best moves away from chrome; colored parallels replace refractors.
--   Base cards get Blue /300, Red /200, Gold /50.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /300","ebay_kw":"Blue"},
  {"label":"Red /200","ebay_kw":"Red"},
  {"label":"Gold /50","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2002;

-- 2003: Simplified to two parallels: Blue /100 + Red /50.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Blue /100","ebay_kw":"Blue"},
  {"label":"Red /50","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2003;

-- 2004: Green /100 + Red /20.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green /100","ebay_kw":"Green"},
  {"label":"Red /20","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2004;

-- 2005: Largest early rainbow (8 parallels). Green /899 through Black 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green /899","ebay_kw":"Green"},
  {"label":"Blue /499","ebay_kw":"Blue"},
  {"label":"Red /199","ebay_kw":"Red"},
  {"label":"Silver /99","ebay_kw":"Silver"},
  {"label":"Gold /25","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2005;

-- 2006: No Bowman's Best product released (1-year hiatus before 2007 return).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2006;

-- 2007: Return of Bowman's Best. Hybrid Bowman/Finest format with chrome stock.
--   Green /249 only for the 63 non-auto base cards; all 97 base get Blue/Gold/Red.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green /249","ebay_kw":"Green"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Red 1/1","ebay_kw":"Red"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2007;

-- 2008-2009: Product discontinued after 2007; not released again until 2015.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year BETWEEN 2008 AND 2009;

-- 2013-2014: DB rows exist but no Bowman's Best was released 2008-2014.
--   The revival was exclusively in 2015 ("return for the first time in a decade").
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year BETWEEN 2013 AND 2014;

-- 2015: Revival. Chromium base. Atomic Refractor is the case hit (not numbered).
--   Printing Plates 1/1 confirmed for this year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2015;

-- 2016: Blue jumps to /250; Orange drops to /35; no Purple yet.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Blue Refractor /250","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /35","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2016;

-- 2017: Base Refractor (unnumbered, 1 per pack) added alongside Atomic (case hit).
--   Purple /250 joins; Blue back to /150; Red back to /10.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2017;

-- 2018: Same structure as 2017.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2018;

-- 2019: Same structure as 2017-2018.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2019;

-- 2020: Same structure as 2017-2019. Lava parallels not yet introduced.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2020;

-- 2021: Lava parallels debut: Aqua Lava /199, Gold Lava /75, Red Lava /5.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Aqua Lava Refractor /199","ebay_kw":"Aqua Lava Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Gold Lava Refractor /75","ebay_kw":"Gold Lava Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"Red Lava Refractor /5","ebay_kw":"Red Lava Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2021;

-- 2022: Mini-Diamond /299 and Green Mini-Diamond /99 added; Atomic retained.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Atomic Refractor","ebay_kw":"Atomic Refractor"},
  {"label":"Mini-Diamond Refractor /299","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Aqua Lava Refractor /199","ebay_kw":"Aqua Lava Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Green Mini-Diamond Refractor /99","ebay_kw":"Green Mini-Diamond Refractor"},
  {"label":"Gold Lava Refractor /75","ebay_kw":"Gold Lava Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"Red Lava Refractor /5","ebay_kw":"Red Lava Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2022;

-- 2023: Atomic Refractor replaced by Wave Refractor (unnumbered).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Mini-Diamond Refractor /299","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Aqua Lava Refractor /199","ebay_kw":"Aqua Lava Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Green Mini-Diamond Refractor /99","ebay_kw":"Green Mini-Diamond Refractor"},
  {"label":"Gold Lava Refractor /75","ebay_kw":"Gold Lava Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor"},
  {"label":"Red Lava Refractor /5","ebay_kw":"Red Lava Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2023;

-- 2024: Purple Mojo /250, Blue X-Fractor /150, Yellow Lazer /75, Gold Lava /50,
--   Black /10 added; Red drops to /5; two parallels each at /250, /150, /75, /50, /5.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Mini-Diamond Refractor /299","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Purple Mojo Refractor /250","ebay_kw":"Purple Mojo Refractor"},
  {"label":"Aqua Lava Refractor /199","ebay_kw":"Aqua Lava Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Blue X-Fractor /150","ebay_kw":"Blue X-Fractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Green Mini-Diamond Refractor /99","ebay_kw":"Green Mini-Diamond Refractor"},
  {"label":"Yellow Lazer Refractor /75","ebay_kw":"Yellow Lazer Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Gold Lava Refractor /50","ebay_kw":"Gold Lava Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Black Refractor /10","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"Red Lava Refractor /5","ebay_kw":"Red Lava Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2024;

-- 2025: Lazer family expands massively — Lazer /350, Purple Lazer /250,
--   Blue Lazer /150, Yellow /75 (non-lazer), Aqua /199 added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Wave Refractor","ebay_kw":"Wave Refractor"},
  {"label":"Lazer Refractor /350","ebay_kw":"Lazer Refractor"},
  {"label":"Mini-Diamond Refractor /299","ebay_kw":"Mini-Diamond Refractor"},
  {"label":"Purple Refractor /250","ebay_kw":"Purple Refractor"},
  {"label":"Purple Mojo Refractor /250","ebay_kw":"Purple Mojo Refractor"},
  {"label":"Purple Lazer Refractor /250","ebay_kw":"Purple Lazer Refractor"},
  {"label":"Aqua Lava Refractor /199","ebay_kw":"Aqua Lava Refractor"},
  {"label":"Aqua Refractor /199","ebay_kw":"Aqua Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor"},
  {"label":"Blue X-Fractor /150","ebay_kw":"Blue X-Fractor"},
  {"label":"Blue Lazer Refractor /150","ebay_kw":"Blue Lazer Refractor"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor"},
  {"label":"Green Mini-Diamond Refractor /99","ebay_kw":"Green Mini-Diamond Refractor"},
  {"label":"Yellow Lazer Refractor /75","ebay_kw":"Yellow Lazer Refractor"},
  {"label":"Yellow Refractor /75","ebay_kw":"Yellow Refractor"},
  {"label":"Gold Lava Refractor /50","ebay_kw":"Gold Lava Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor"},
  {"label":"Black Refractor /10","ebay_kw":"Black Refractor"},
  {"label":"Red Refractor /5","ebay_kw":"Red Refractor"},
  {"label":"Red Lava Refractor /5","ebay_kw":"Red Lava Refractor"},
  {"label":"SuperFractor 1/1","ebay_kw":"SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Best' AND sport = 'baseball'
  AND year = 2025;
