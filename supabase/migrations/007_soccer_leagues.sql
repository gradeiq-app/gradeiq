-- ============================================================
-- 007_soccer_leagues.sql
--
-- Fill remaining soccer gaps:
-- 1. Panini Mosaic Soccer 2024 (missed in 006)
-- 2. Panini Revolution Soccer 2024 (missed in 006)
-- 3. Topps Chrome UCL 2025
-- 4. Topps Chrome Premier League 2019-2025 (new league)
-- 5. Topps Chrome Bundesliga 2020-2025 (new league)
-- 6. Sync to sets table + refresh parallel_templates
-- ============================================================

-- ── 1. Panini Mosaic Soccer 2024 (missed in 006) ─────────────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2024, 'Panini', 'Mosaic Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Pink Prizm /49","ebay_kw":"Pink Prizm 49"},
  {"label":"Purple Prizm /25","ebay_kw":"Purple Prizm 25"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 2. Panini Revolution Soccer 2024 ─────────────────────────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2024, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 3. Topps Chrome UCL 2025 ─────────────────────────────────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2025, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 4. Topps Chrome Premier League 2019-2025 ─────────────────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2019, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2020, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2021, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2022, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2023, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2024, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2025, 'Topps', 'Chrome Premier League', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 5. Topps Chrome Bundesliga 2020-2025 ─────────────────────────────────────
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2020, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2021, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2022, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2023, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2024, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2025, 'Topps', 'Chrome Bundesliga', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ── 6. Sync new rows into sets table ─────────────────────────────────────────
INSERT INTO public.sets (sport_id, year, manufacturer_id, name)
SELECT
  sp.id  AS sport_id,
  cl.year,
  m.id   AS manufacturer_id,
  cl.set_name AS name
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE cl.sport = 'soccer'
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;

-- ── 7. Refresh parallel_templates for all soccer sets ────────────────────────
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name
  AND cl.sport          = 'soccer';
