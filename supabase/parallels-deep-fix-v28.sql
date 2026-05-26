-- =============================================================================
-- parallels-deep-fix-v28.sql
-- One set corrected:
--
-- 1. Donruss Elite Football (26 rows, 2000-2025)
--    All rows previously held a generic 11-entry template. Corrected to
--    year-accurate parallels across four distinct product eras:
--
--    ERA 1 — Classic Donruss/Playoff Corp (2000-2001)
--    • Aspirations + Status (jersey-number variable; non-die-cut)
--    • Black 1/1 confirmed for both years
--
--    ERA 2 — Die-Cut Aspirations/Status (2002-2012)
--    • 2002-2010: Aspirations Die-Cut (jersey #) + Status Die-Cut (100-jersey #)
--    • 2011:  Die-cuts capped at /49 (Panini revival year)
--    • 2012:  Panini Elite; partial Aspirations/Status die-cuts + Printing Plates 1/1
--
--    ERA 3 — Panini Elite (2013-2015)
--    • 2013: Turn of Century /199; Gold/Red Status Die-Cuts; Black Die-Cut 1/1
--    • 2014: + Aspirations Die-Cut + Clear + Status Purple added
--    • 2015: NO football product released (baseball/baseball EE only); placeholder
--
--    ERA 4 — Panini Donruss Elite color-coded era (2016-2025)
--    • 2016: Retail Green + color ladder (Black /199 … Gold 1/1)
--    • 2017: Retail Green (Walmart) + color ladder + Aspirations/Status die-cuts
--    • 2018: Green/Pink retail + Red /299 … Gold /5 FOTL + Black 1/1
--    • 2019: + Aspirations/Status /99 + Die-Cuts /24 return
--    • 2020: + Razzle Dazzle (1 per case) + Gold FOTL /10
--    • 2021: + Aspirations Shimmer /499 + Status Explosion /275 + Teal /25
--    • 2022: + Stars/Sparkle /275 + Yellow /75 + Gold /10
--    • 2023: Green Disco + Maroon /149; Black /25; FOTL Pink /11 + Platinum /3
--    • 2024: Shimmer/Explosion /875; Maroon /249; Status Die-Cut /9
--    • 2025: Massive expansion — Lime Green, Metallic Orange, Lavender Pyramids,
--            Teal Matrix, Bronze, Red /99, Aspirations Red/Status Green /99
--
-- Total: 26 rows updated
-- Sources: Beckett, Cardboard Connection, Sports Card Radio, BreakNinja,
--          Cardlines, Checklistinsider, TCDB
-- =============================================================================

-- ─── ERA 1: CLASSIC DONRUSS / PLAYOFF CORP ───────────────────────────────────

-- 2000-2001: Non-die-cut Aspirations and Status (jersey-number variable print
--   runs); Black 1/1 confirmed for both years. Turn of the Century was an
--   autograph insert subset, not a full base parallel.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Aspirations (jersey #)","ebay_kw":"Aspirations"},
  {"label":"Status (100-jersey #)","ebay_kw":"Status"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year BETWEEN 2000 AND 2001;

-- ─── ERA 2: DIE-CUT ASPIRATIONS / STATUS ─────────────────────────────────────

-- 2002-2010: Die-cut Aspirations and Status introduced in 2002.
--   Aspirations = numbered to player's jersey number.
--   Status = numbered to (100 minus player's jersey number).
--   Combined Aspirations + Status per card always totals 100 copies.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Aspirations Die-Cut (jersey #)","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut (100-jersey #)","ebay_kw":"Status Die Cut"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year BETWEEN 2002 AND 2010;

-- 2011: Panini revival year. Die-cuts continue but print run capped at 49 or
--   less per card. Base rookies are numbered /999 (not a parallel).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Aspirations Die-Cut /49","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /49","ebay_kw":"Status Die Cut"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2011;

-- ─── ERA 3: PANINI ELITE ─────────────────────────────────────────────────────

-- 2012: First year branded "Panini Elite." Aspirations and Status Die-Cuts
--   cover a 36-card subset (jersey-number variable print runs). Printing
--   Plates 1/1 are the only full-set base parallel.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Aspirations Die-Cut (jersey #)","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut (100-jersey #)","ebay_kw":"Status Die Cut"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2012;

-- 2013: Turn of the Century /199 debuts as a numbered base parallel.
--   Gold and Red Status Die-Cuts replace the variable jersey-# format.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Turn of the Century /199","ebay_kw":"Turn of the Century"},
  {"label":"Gold Status Die-Cut /49","ebay_kw":"Gold Status Die Cut"},
  {"label":"Red Status Die-Cut /25","ebay_kw":"Red Status Die Cut"},
  {"label":"Black Die-Cut 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2013;

-- 2014: Aspirations Die-Cut, Clear, and Status Purple added. The Clear and
--   Status Purple print runs are variable (jersey-number based).
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Turn of the Century /199","ebay_kw":"Turn of the Century"},
  {"label":"Aspirations Die-Cut (jersey #)","ebay_kw":"Aspirations Die Cut"},
  {"label":"Clear (jersey #)","ebay_kw":"Clear"},
  {"label":"Status Purple (jersey #)","ebay_kw":"Status Purple"},
  {"label":"Gold Status Die-Cut /49","ebay_kw":"Gold Status Die Cut"},
  {"label":"Red Status Die-Cut /25","ebay_kw":"Red Status Die Cut"},
  {"label":"Black Die-Cut 1/1","ebay_kw":"Black"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2014;

-- 2015: No football Elite product was released in 2015.
--   Panini Elite in 2015 was a baseball-only product (and Elite Extra Edition).
--   This DB row is a placeholder. Row kept with base-only entry.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2015;

-- ─── ERA 4: PANINI DONRUSS ELITE — COLOR-CODED ERA ───────────────────────────

-- 2016: First year rebranded as "Donruss Elite." Full color-coded numbered
--   rainbow replaces the Aspirations/Status die-cut system.
--   Retail Green is an unnumbered retail-exclusive parallel.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Retail Green","ebay_kw":"Retail Green"},
  {"label":"Black /199","ebay_kw":"Black"},
  {"label":"Green /99","ebay_kw":"Green"},
  {"label":"Teal /75","ebay_kw":"Teal"},
  {"label":"Red /49","ebay_kw":"Red"},
  {"label":"Purple /25","ebay_kw":"Purple"},
  {"label":"Orange /10","ebay_kw":"Orange"},
  {"label":"Blue /5","ebay_kw":"Blue"},
  {"label":"Gold 1/1","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2016;

-- 2017: Aspirations and Status (variable, jersey-number) re-introduced
--   alongside the color rainbow. Aspirations and Status Die-Cuts /24.
--   Retail Green is a Walmart-exclusive unnumbered parallel.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Retail Green (Walmart)","ebay_kw":"Green"},
  {"label":"Red /149","ebay_kw":"Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Aspirations (jersey #)","ebay_kw":"Aspirations"},
  {"label":"Status (jersey #)","ebay_kw":"Status"},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Aspirations Die-Cut /24","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /24","ebay_kw":"Status Die Cut"},
  {"label":"Blue /15","ebay_kw":"Blue"},
  {"label":"Gold 1/1","ebay_kw":"Gold"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2017;

-- 2018: Retail Green and Pink (unnumbered) debut; Gold shifts from 1/1
--   to /5 FOTL exclusive; Aspirations/Status removed this year.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Blue /10","ebay_kw":"Blue"},
  {"label":"Gold /5","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2018;

-- 2019: Aspirations and Status (/99 or less, jersey-number) return.
--   Aspirations and Status Die-Cuts /24 also return.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red /299","ebay_kw":"Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Aspirations (jersey #)","ebay_kw":"Aspirations"},
  {"label":"Status (jersey #)","ebay_kw":"Status"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Aspirations Die-Cut /24","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /24","ebay_kw":"Status Die Cut"},
  {"label":"Blue /10","ebay_kw":"Blue"},
  {"label":"Gold /5","ebay_kw":"Gold"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2019;

-- 2020: Razzle Dazzle debuts (1 per case SSP). Base rookie cards numbered
--   to /799 (not a parallel). Gold FOTL /10 replaces hobby Gold.
--   Status Die-Cut Red /5 (Asia T-Mall exclusive) added.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Red /399","ebay_kw":"Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Aspirations /99","ebay_kw":"Aspirations"},
  {"label":"Status /99","ebay_kw":"Status"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Aspirations Die-Cut /24","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /24","ebay_kw":"Status Die Cut"},
  {"label":"Blue /10","ebay_kw":"Blue"},
  {"label":"Gold FOTL /10","ebay_kw":"Gold"},
  {"label":"Status Die-Cut Red /5","ebay_kw":"Status Die Cut Red"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2020;

-- 2021: Aspirations Shimmer /499 and Status Explosion /275 debut as new
--   sub-tiers. Teal /25 added to the color rainbow.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Aspirations Shimmer /499","ebay_kw":"Aspirations Shimmer"},
  {"label":"Status Explosion /275","ebay_kw":"Status Explosion"},
  {"label":"Red /399","ebay_kw":"Red"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Aspirations /99","ebay_kw":"Aspirations"},
  {"label":"Status /99","ebay_kw":"Status"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Teal /25","ebay_kw":"Teal"},
  {"label":"Aspirations Die-Cut /24","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /24","ebay_kw":"Status Die Cut"},
  {"label":"Blue /10","ebay_kw":"Blue"},
  {"label":"Status Die-Cut Red /5","ebay_kw":"Status Die Cut Red"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2021;

-- 2022: Aspirations Stars /275 and Status Sparkle /275 added alongside
--   Shimmer/Explosion. Yellow /75 inserted into the color rainbow.
--   Gold /10 (hobby) added. Status Explosion print run rises to /499.
--   Status Die-Cut Red drops to /7.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green","ebay_kw":"Green"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Aspirations Shimmer /499","ebay_kw":"Aspirations Shimmer"},
  {"label":"Status Explosion /499","ebay_kw":"Status Explosion"},
  {"label":"Red /399","ebay_kw":"Red"},
  {"label":"Aspirations Stars /275","ebay_kw":"Aspirations Stars"},
  {"label":"Status Sparkle /275","ebay_kw":"Status Sparkle"},
  {"label":"Yellow /75","ebay_kw":"Yellow"},
  {"label":"Purple /99","ebay_kw":"Purple"},
  {"label":"Aspirations /99","ebay_kw":"Aspirations"},
  {"label":"Status /99","ebay_kw":"Status"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Teal /25","ebay_kw":"Teal"},
  {"label":"Aspirations Die-Cut /24","ebay_kw":"Aspirations Die Cut"},
  {"label":"Status Die-Cut /24","ebay_kw":"Status Die Cut"},
  {"label":"Blue /10","ebay_kw":"Blue"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Status Die-Cut Red /7","ebay_kw":"Status Die Cut Red"},
  {"label":"Black 1/1","ebay_kw":"Black"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2022;

-- 2023: Green Disco replaces plain Green. Maroon /149 joins the rainbow.
--   Black drops to a serial-numbered /25 (no longer 1/1).
--   FOTL Pink /11 and FOTL Platinum /3 added. Elite 1/1 is the rarest.
--   Shimmer/Explosion drop to /625; Stars/Sparkle drop to /299.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green Disco","ebay_kw":"Green Disco"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Aspirations Shimmer /625","ebay_kw":"Aspirations Shimmer"},
  {"label":"Status Explosion /625","ebay_kw":"Status Explosion"},
  {"label":"Orange /399","ebay_kw":"Orange"},
  {"label":"Aspirations Stars /299","ebay_kw":"Aspirations Stars"},
  {"label":"Status Sparkle /299","ebay_kw":"Status Sparkle"},
  {"label":"Maroon /149","ebay_kw":"Maroon"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Aspirations /99","ebay_kw":"Aspirations"},
  {"label":"Status /99","ebay_kw":"Status"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"FOTL Pink /11","ebay_kw":"FOTL Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Status Die-Cut /7","ebay_kw":"Status Die Cut"},
  {"label":"FOTL Platinum /3","ebay_kw":"FOTL Platinum"},
  {"label":"Elite 1/1","ebay_kw":"Elite"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2023;

-- 2024: Shimmer/Explosion print runs expand to /875. Maroon increases to /249.
--   Stars/Sparkle remain /299. FOTL Pink moves to /13. Status Die-Cut /9.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green Disco","ebay_kw":"Green Disco"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Aspirations Shimmer /875","ebay_kw":"Aspirations Shimmer"},
  {"label":"Status Explosion /875","ebay_kw":"Status Explosion"},
  {"label":"Orange /399","ebay_kw":"Orange"},
  {"label":"Aspirations Stars /299","ebay_kw":"Aspirations Stars"},
  {"label":"Status Sparkle /299","ebay_kw":"Status Sparkle"},
  {"label":"Maroon /249","ebay_kw":"Maroon"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Aspirations /99","ebay_kw":"Aspirations"},
  {"label":"Status /99","ebay_kw":"Status"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"FOTL Pink /13","ebay_kw":"FOTL Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Status Die-Cut /9","ebay_kw":"Status Die Cut"},
  {"label":"FOTL Platinum /3","ebay_kw":"FOTL Platinum"},
  {"label":"Elite 1/1","ebay_kw":"Elite"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2024;

-- 2025: Massive expansion of the parallel rainbow. New sub-families:
--   Aspirations Lime Green /999, Status Metallic Orange /849,
--   Lavender Pyramids /649, Teal Matrix /499, Bronze /35.
--   Aspirations Red /99 and Status Green /99 are new jersey-coded variants.
--   Orange drops to /199; Blue drops to /75.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Green Disco","ebay_kw":"Green Disco"},
  {"label":"Pink","ebay_kw":"Pink"},
  {"label":"Razzle Dazzle","ebay_kw":"Razzle Dazzle"},
  {"label":"Aspirations Lime Green /999","ebay_kw":"Aspirations Lime Green"},
  {"label":"Aspirations Shimmer /999","ebay_kw":"Aspirations Shimmer"},
  {"label":"Status Explosion /999","ebay_kw":"Status Explosion"},
  {"label":"Status Metallic Orange /849","ebay_kw":"Status Metallic Orange"},
  {"label":"Lavender Pyramids /649","ebay_kw":"Lavender Pyramids"},
  {"label":"Aspirations Stars /499","ebay_kw":"Aspirations Stars"},
  {"label":"Status Sparkle /499","ebay_kw":"Status Sparkle"},
  {"label":"Teal Matrix /499","ebay_kw":"Teal Matrix"},
  {"label":"Orange /199","ebay_kw":"Orange"},
  {"label":"Red /99","ebay_kw":"Red"},
  {"label":"Aspirations Red /99","ebay_kw":"Aspirations Red"},
  {"label":"Status Green /99","ebay_kw":"Status Green"},
  {"label":"Blue /75","ebay_kw":"Blue"},
  {"label":"Purple /49","ebay_kw":"Purple"},
  {"label":"Bronze /35","ebay_kw":"Bronze"},
  {"label":"Black /25","ebay_kw":"Black"},
  {"label":"FOTL Pink /13","ebay_kw":"FOTL Pink"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Status Die-Cut /9","ebay_kw":"Status Die Cut"},
  {"label":"FOTL Platinum /3","ebay_kw":"FOTL Platinum"},
  {"label":"Elite 1/1","ebay_kw":"Elite"}
]'::jsonb
WHERE brand = 'Donruss' AND set_name = 'Elite' AND sport = 'football'
  AND year = 2025;
