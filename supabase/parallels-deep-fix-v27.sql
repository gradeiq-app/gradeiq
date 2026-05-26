-- =============================================================================
-- parallels-deep-fix-v27.sql
-- One set corrected:
--
-- 1. Topps Five Star Baseball (27 rows, 1999-2025)
--    • 1999-2011  : No baseball product existed; DB rows are placeholders
--                  (Five Star launched in football first; baseball debut = 2012)
--    • 2012       : Non-auto base /80 + Rainbow /10
--    • 2013       : Non-auto base /75 + Rainbow Foil /10 + Five Star 1/1
--    • 2014       : All-auto format begins; base auto (unnumbered) + Rainbow /25
--                  + Five Star 1/1
--    • 2015-2016  : Base auto (unnumbered) + Gold /50, Rainbow /25, Emerald /5,
--                  Five Star 1/1
--    • 2017-2021  : Base auto (unnumbered) + Purple /50, Blue /25, Green /15,
--                  Gold /10, Orange /5, Red 1/1
--    • 2022-2024  : + Aqua /75 added at top of rainbow
--    • 2025       : Non-auto base cards return (numbered /50 or less) with their
--                  own parallel rainbow; autos continue with same Aqua-Red ladder
--
-- Total: 27 rows updated
-- Sources: BaseballCardPedia, CardboardConnection, Beckett, ChecklistInsider
-- =============================================================================

-- ─── TOPPS FIVE STAR BASEBALL ────────────────────────────────────────────────

-- 1999-2011: No baseball Five Star product. Football-only until 2012 baseball debut.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year BETWEEN 1999 AND 2011;

-- 2012: Debut year for baseball. Non-auto base set numbered to 80 per card.
--   Rainbow parallel serial-numbered to 10.
UPDATE card_sets SET parallels = '[
  {"label":"Base /80","ebay_kw":""},
  {"label":"Rainbow /10","ebay_kw":"Rainbow"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2012;

-- 2013: Base drops to /75; Five Star 1/1 introduced.
UPDATE card_sets SET parallels = '[
  {"label":"Base /75","ebay_kw":""},
  {"label":"Rainbow Foil /10","ebay_kw":"Rainbow"},
  {"label":"Five Star 1/1","ebay_kw":"Five Star"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2013;

-- 2014: Product shifts to all-autograph format. Base auto is unnumbered.
--   Rainbow /25 and Five Star 1/1 are the only parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Rainbow /25","ebay_kw":"Rainbow"},
  {"label":"Five Star 1/1","ebay_kw":"Five Star"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2014;

-- 2015: Gold /50 tier added; base auto remains unnumbered.
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Rainbow /25","ebay_kw":"Rainbow"},
  {"label":"Emerald /5","ebay_kw":"Emerald"},
  {"label":"Five Star 1/1","ebay_kw":"Five Star"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2015;

-- 2016: Same structure as 2015 (Gold/Rainbow/Emerald/Five Star).
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Gold /50","ebay_kw":"Gold"},
  {"label":"Rainbow /25","ebay_kw":"Rainbow"},
  {"label":"Emerald /5","ebay_kw":"Emerald"},
  {"label":"Five Star 1/1","ebay_kw":"Five Star"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2016;

-- 2017: New parallel structure replaces Gold/Rainbow/Emerald with a
--   color-coded ladder: Purple /50, Blue /25, Green /15, Gold /10, Orange /5, Red 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Green /15","ebay_kw":"Green"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Orange /5","ebay_kw":"Orange"},
  {"label":"Red 1/1","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2017;

-- 2018-2021: Same six-color structure as 2017.
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Green /15","ebay_kw":"Green"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Orange /5","ebay_kw":"Orange"},
  {"label":"Red 1/1","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year BETWEEN 2018 AND 2021;

-- 2022: Aqua /75 added at the top of the auto rainbow.
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Aqua /75","ebay_kw":"Aqua"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Green /15","ebay_kw":"Green"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Orange /5","ebay_kw":"Orange"},
  {"label":"Red 1/1","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2022;

-- 2023-2024: Same structure as 2022 (Aqua /75 retained).
UPDATE card_sets SET parallels = '[
  {"label":"Base (Auto)","ebay_kw":""},
  {"label":"Aqua /75","ebay_kw":"Aqua"},
  {"label":"Purple /50","ebay_kw":"Purple"},
  {"label":"Blue /25","ebay_kw":"Blue"},
  {"label":"Green /15","ebay_kw":"Green"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Orange /5","ebay_kw":"Orange"},
  {"label":"Red 1/1","ebay_kw":"Red"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year BETWEEN 2023 AND 2024;

-- 2025: Non-auto base cards return (first time since 2013), numbered /50 or less.
--   Base card parallels: Orange /25, Emerald /15, Black /10, Red /5, FoilFractor 1/1.
--   Autograph parallels continue with same Aqua–Red ladder.
--   Labels prefixed with "Auto" to distinguish auto parallels from base parallels.
UPDATE card_sets SET parallels = '[
  {"label":"Base /50","ebay_kw":""},
  {"label":"Orange /25","ebay_kw":"Orange"},
  {"label":"Emerald /15","ebay_kw":"Emerald"},
  {"label":"Black /10","ebay_kw":"Black"},
  {"label":"Red /5","ebay_kw":"Red"},
  {"label":"FoilFractor 1/1","ebay_kw":"FoilFractor"},
  {"label":"Base Auto","ebay_kw":"Auto"},
  {"label":"Aqua Auto /75","ebay_kw":"Aqua Auto"},
  {"label":"Purple Auto /50","ebay_kw":"Purple Auto"},
  {"label":"Blue Auto /25","ebay_kw":"Blue Auto"},
  {"label":"Green Auto /15","ebay_kw":"Green Auto"},
  {"label":"Gold Auto /10","ebay_kw":"Gold Auto"},
  {"label":"Orange Auto /5","ebay_kw":"Orange Auto"},
  {"label":"Red Auto 1/1","ebay_kw":"Red Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Five Star' AND sport = 'baseball'
  AND year = 2025;
