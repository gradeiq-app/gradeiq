-- =============================================================================
-- parallels-deep-fix-v50.sql
-- One set corrected:
--
-- 1. Panini Contenders Optic Basketball
--    (brand='Panini', set_name='Contenders Optic', sport='basketball')
--    7 rows — DB years 2018-2024
--
-- Season start year convention:
--   DB 2018 = 2018-19, DB 2019 = 2019-20, ... DB 2023 = 2023-24 (last confirmed)
--   DB 2024 = 2024-25 — placeholder (no confirmed product release found)
--
-- Contenders Optic Basketball uses Optichrome technology on the classic
-- Contenders "Season Ticket" and "Rookie Ticket" card designs.
--
-- Parallel eras:
--   - 2018-19:  Debut. Silver/Red unnumb + Blue /99, Orange /49, Gold /10,
--                Gold Vinyl 1/1, Printing Plates 1/1
--   - 2019-20:  Same structure as 2018-19
--   - 2020-21:  Black Pandora/Gold Wave/Red Wave unnumb added; Green Pulsar /25
--   - 2021-22:  75th Anniversary unnumb (NBA centennial); Blue Wave /45; Gold Wave /10
--   - 2022-23:  Pink /75 added; Purple /15; Gold Wave /10 continues
--   - 2023-24:  International sub-set (Red International, Blue /45, Black & White /25,
--                Gold /10, Jade Cracked Ice /5, Red Pandora 1/1); Cracked Ice /23;
--                Purple FOTL /18; Black FOTL /3; Gold Lazer /2
--   - 2024-25:  Placeholder (no confirmed product release)
--
-- Sources: Cardboard Connection, Checklist Insider
-- =============================================================================

-- ─── 2018-19: Debut — Silver/Red unnumb + 4-tier numbered ladder ──────────────

-- 2018-19 Panini Contenders Optic Basketball (debut).
-- Silver and Red are unnumbered hobby parallels.
-- Blue /99, Orange /49, Gold /10, Gold Vinyl 1/1, Printing Plates 1/1.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2018;

-- ─── 2019-20: Same structure as 2018-19 ──────────────────────────────────────

-- 2019-20 Panini Contenders Optic Basketball.
-- Same parallel structure as debut year. Silver/Red unnumb, Blue /99, Orange /49.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2019;

-- ─── 2020-21: Black Pandora + Gold Wave + Red Wave unnumb; Green Pulsar /25 ───

-- 2020-21 Panini Contenders Optic Basketball.
-- Three new unnumbered variants: Black Pandora (SSP), Gold Wave, Red Wave.
-- Green Pulsar /25 added as new ultra-short numbered tier.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Pandora","ebay_kw":"Black Pandora"},
  {"label":"Gold Wave","ebay_kw":"Gold Wave"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2020;

-- ─── 2021-22: 75th Anniversary unnumb; Blue Wave /45; Gold Wave /10 ────────────

-- 2021-22 Panini Contenders Optic Basketball (NBA 75th Anniversary season).
-- 75th Anniversary unnumbered parallel added (NBA centennial celebration).
-- Blue Wave /45 new tier. Gold Wave /10 added alongside base Gold /10.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"75th Anniversary","ebay_kw":"75th Anniversary"},
  {"label":"Black Pandora","ebay_kw":"Black Pandora"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Blue Wave /45","ebay_kw":"Blue Wave"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2021;

-- ─── 2022-23: Pink /75 added; Purple /15 new ─────────────────────────────────

-- 2022-23 Panini Contenders Optic Basketball.
-- Pink /75 added (between Blue /99 and Orange /49). Purple /15 new ultra-short tier.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Pandora","ebay_kw":"Black Pandora"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Red Wave","ebay_kw":"Red Wave"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Pink /75","ebay_kw":"Pink"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"Blue Wave /45","ebay_kw":"Blue Wave"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"Purple /15","ebay_kw":"Purple"},
  {"label":"Gold Wave /10","ebay_kw":"Gold Wave"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2022;

-- ─── 2023-24: International sub-set; Cracked Ice /23; FOTL tiers ─────────────

-- 2023-24 Panini Contenders Optic Basketball.
-- International variants: Red International (unnumb), Blue /45, Black & White /25,
--   Gold /10, Jade Cracked Ice /5, Red Pandora 1/1 (all International sub-set).
-- New: Cracked Ice /23, Purple FOTL /18, Purple /15, Black FOTL /3, Gold Lazer /2.
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":""},
  {"label":"Black Pandora","ebay_kw":"Black Pandora"},
  {"label":"International Red","ebay_kw":"International Red"},
  {"label":"Red","ebay_kw":"Red"},
  {"label":"Silver","ebay_kw":"Silver"},
  {"label":"Blue /99","ebay_kw":"Blue"},
  {"label":"Pink /75","ebay_kw":"Pink"},
  {"label":"Orange /49","ebay_kw":"Orange"},
  {"label":"International Blue /45","ebay_kw":"International Blue"},
  {"label":"Green Pulsar /25","ebay_kw":"Green Pulsar"},
  {"label":"International Black & White /25","ebay_kw":"International Black White"},
  {"label":"Cracked Ice /23","ebay_kw":"Cracked Ice"},
  {"label":"Purple FOTL /18","ebay_kw":"Purple FOTL"},
  {"label":"Purple /15","ebay_kw":"Purple"},
  {"label":"Gold /10","ebay_kw":"Gold"},
  {"label":"International Gold /10","ebay_kw":"International Gold"},
  {"label":"International Jade Cracked Ice /5","ebay_kw":"International Jade"},
  {"label":"Black FOTL /3","ebay_kw":"Black FOTL"},
  {"label":"Gold Lazer /2","ebay_kw":"Gold Lazer"},
  {"label":"Gold Vinyl 1/1","ebay_kw":"Gold Vinyl"},
  {"label":"International Red Pandora 1/1","ebay_kw":"International Red Pandora"},
  {"label":"Printing Plates 1/1","ebay_kw":"Printing Plates"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2023;

-- ─── 2024-25: Placeholder (no confirmed product release) ─────────────────────

-- No confirmed 2024-25 Panini Contenders Optic Basketball release found.
-- The Panini NBA license expired after the 2024-25 season; Contenders Optic
-- may not have been produced for this final season.
UPDATE card_sets SET parallels = '[{"label":"Base","ebay_kw":""}]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball'
  AND year = 2024;
