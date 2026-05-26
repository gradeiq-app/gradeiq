-- ============================================================
-- 006_gap_fill.sql
--
-- 1. Extend sport CHECK constraint to include 'soccer'
-- 2. Add soccer sets (Prizm, World Cup, Chrome MLS, Chrome UCL,
--    Donruss, Select, Mosaic, Revolution) 2018-2025
-- 3. Add WNBA 2025 high-end sets missing from previous migration
-- 4. Update Topps Chrome Football 2024 with accurate parallels
-- 5. Sync all new card_sets_legacy rows into sets table
-- 6. Refresh parallel_templates on all affected sets
-- ============================================================

-- â”€â”€ 1. Extend sport CHECK constraint â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
ALTER TABLE public.card_sets_legacy
  DROP CONSTRAINT IF EXISTS card_sets_sport_check;

ALTER TABLE public.card_sets_legacy
  ADD CONSTRAINT card_sets_sport_check
    CHECK (sport = ANY (ARRAY[
      'baseball','basketball','football','hockey','wnba','soccer'
    ]));

-- â”€â”€ 2a. Panini Prizm Soccer (domestic) 2018-2024 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2019, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Neon Green Prizm /99","ebay_kw":"Neon Green Prizm"},
  {"label":"Blue Prizm /149","ebay_kw":"Blue Prizm 149"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"},
  {"label":"Mojo Prizm","ebay_kw":"Mojo Prizm"}
]'::jsonb),
('soccer', 2020, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Neon Green Prizm /75","ebay_kw":"Neon Green Prizm 75"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2021, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /99","ebay_kw":"Green Prizm 99"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2023, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /99","ebay_kw":"Green Prizm 99"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2024, 'Panini', 'Prizm Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /99","ebay_kw":"Green Prizm 99"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 2b. Panini Prizm World Cup â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Panini', 'Prizm World Cup', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm World Cup 199"},
  {"label":"Red Prizm /50","ebay_kw":"Red Prizm World Cup 50"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm World Cup 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm World Cup 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Prizm World Cup', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm World Cup 199"},
  {"label":"Green Prizm /99","ebay_kw":"Green Prizm World Cup 99"},
  {"label":"Red Prizm /75","ebay_kw":"Red Prizm World Cup 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm World Cup 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm World Cup 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm World Cup 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 2c. Topps Chrome MLS 2018-2025 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Topps', 'Chrome MLS', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2019, 'Topps', 'Chrome MLS', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2020, 'Topps', 'Chrome MLS', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Pink Refractor /199","ebay_kw":"Pink Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2021, 'Topps', 'Chrome MLS', '[
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
('soccer', 2022, 'Topps', 'Chrome MLS', '[
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
('soccer', 2023, 'Topps', 'Chrome MLS', '[
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
('soccer', 2024, 'Topps', 'Chrome MLS', '[
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
('soccer', 2025, 'Topps', 'Chrome MLS', '[
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

-- â”€â”€ 2d. Topps Chrome UCL 2019-2024 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2019, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2020, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2021, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2022, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2023, 'Topps', 'Chrome UCL', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Refractor","ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150","ebay_kw":"Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Green Refractor 99"},
  {"label":"Prism Refractor","ebay_kw":"Prism Refractor"},
  {"label":"Gold Refractor /50","ebay_kw":"Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Orange Refractor 25"},
  {"label":"Red Refractor /10","ebay_kw":"Red Refractor 10"},
  {"label":"SuperFractor /1","ebay_kw":"SuperFractor"}
]'::jsonb),
('soccer', 2024, 'Topps', 'Chrome UCL', '[
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

-- â”€â”€ 2e. Panini Donruss Soccer 2018-2024 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2019, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2020, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2021, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2023, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb),
('soccer', 2024, 'Panini', 'Donruss Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Press Proof Red /99","ebay_kw":"Press Proof Red 99"},
  {"label":"Press Proof Blue /49","ebay_kw":"Press Proof Blue 49"},
  {"label":"Press Proof Purple /25","ebay_kw":"Press Proof Purple 25"},
  {"label":"Gold Press Proof /10","ebay_kw":"Gold Press Proof 10"},
  {"label":"Black Press Proof /1","ebay_kw":"Black Press Proof 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 2f. Panini Select Soccer 2018-2024 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /99","ebay_kw":"Green Prizm 99"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2019, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2020, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2021, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2023, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2024, 'Panini', 'Select Soccer', '[
  {"label":"Base Concourse","ebay_kw":""},
  {"label":"Base Premier Level","ebay_kw":"Premier Level"},
  {"label":"Base Field Level","ebay_kw":"Field Level"},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Purple Prizm /49","ebay_kw":"Purple Prizm 49"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 2g. Panini Mosaic Soccer 2019-2023 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2019, 'Panini', 'Mosaic Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Pink Prizm /49","ebay_kw":"Pink Prizm 49"},
  {"label":"Purple Prizm /25","ebay_kw":"Purple Prizm 25"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2020, 'Panini', 'Mosaic Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Pink Prizm /49","ebay_kw":"Pink Prizm 49"},
  {"label":"Purple Prizm /25","ebay_kw":"Purple Prizm 25"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2021, 'Panini', 'Mosaic Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Pink Prizm /49","ebay_kw":"Pink Prizm 49"},
  {"label":"Purple Prizm /25","ebay_kw":"Purple Prizm 25"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Mosaic Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Silver Prizm","ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /199","ebay_kw":"Blue Prizm 199"},
  {"label":"Green Prizm /75","ebay_kw":"Green Prizm 75"},
  {"label":"Pink Prizm /49","ebay_kw":"Pink Prizm 49"},
  {"label":"Purple Prizm /25","ebay_kw":"Purple Prizm 25"},
  {"label":"Gold Prizm /10","ebay_kw":"Gold Prizm 10"},
  {"label":"Black Prizm /1","ebay_kw":"Black Prizm 1"}
]'::jsonb),
('soccer', 2023, 'Panini', 'Mosaic Soccer', '[
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

-- â”€â”€ 2h. Panini Revolution Soccer 2018-2023 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels) VALUES
('soccer', 2018, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb),
('soccer', 2019, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb),
('soccer', 2020, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb),
('soccer', 2021, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb),
('soccer', 2022, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb),
('soccer', 2023, 'Panini', 'Revolution Soccer', '[
  {"label":"Base","ebay_kw":""},
  {"label":"Galactic /99","ebay_kw":"Galactic 99"},
  {"label":"Astro /75","ebay_kw":"Astro 75"},
  {"label":"Infinite /25","ebay_kw":"Infinite 25"},
  {"label":"Nebula /10","ebay_kw":"Nebula 10"},
  {"label":"Cosmic /20","ebay_kw":"Cosmic 20"},
  {"label":"SuperNova /1","ebay_kw":"SuperNova 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 3. WNBA 2025 high-end sets (mirror 2024 parallel structure) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO public.card_sets_legacy (sport, year, brand, set_name, parallels)
SELECT 'wnba', 2025, brand, set_name, parallels
FROM public.card_sets_legacy
WHERE sport = 'wnba'
  AND year  = 2024
  AND set_name IN ('Flawless WNBA','Immaculate WNBA','National Treasures WNBA','Obsidian WNBA')
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- â”€â”€ 4. Topps Chrome Football 2024 â€” expand parallels â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
UPDATE public.card_sets_legacy
SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Chrome Football"},
  {"label":"Refractor","ebay_kw":"Topps Chrome Football Refractor"},
  {"label":"Prism Refractor","ebay_kw":"Topps Chrome Football Prism Refractor"},
  {"label":"Black Wave Refractor","ebay_kw":"Topps Chrome Football Black Wave"},
  {"label":"Sepia Refractor /75","ebay_kw":"Topps Chrome Football Sepia Refractor 75"},
  {"label":"Blue Refractor /50","ebay_kw":"Topps Chrome Football Blue Refractor 50"},
  {"label":"Purple Refractor /25","ebay_kw":"Topps Chrome Football Purple Refractor 25"},
  {"label":"Gold Refractor /10","ebay_kw":"Topps Chrome Football Gold Refractor 10"},
  {"label":"Black Refractor /5","ebay_kw":"Topps Chrome Football Black Refractor 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Chrome Football SuperFractor"},
  {"label":"Printing Plates /1","ebay_kw":"Topps Chrome Football Printing Plates"},
  {"label":"Pink Refractor /199","ebay_kw":"Topps Chrome Football Pink Refractor 199"},
  {"label":"RC Auto","ebay_kw":"Topps Chrome Football Rookie Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"Topps Chrome Football Rookie Auto Refractor"},
  {"label":"RC Auto Blue /50","ebay_kw":"Topps Chrome Football Rookie Auto Blue 50"},
  {"label":"RC Auto Purple /25","ebay_kw":"Topps Chrome Football Rookie Auto Purple 25"},
  {"label":"RC Auto Gold /10","ebay_kw":"Topps Chrome Football Rookie Auto Gold 10"},
  {"label":"RC Auto Black /5","ebay_kw":"Topps Chrome Football Rookie Auto Black 5"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"Topps Chrome Football Rookie Auto SuperFractor"}
]'::jsonb
WHERE sport    = 'football'
  AND year     = 2024
  AND brand    = 'Topps'
  AND set_name = 'Chrome';

-- â”€â”€ 5. Sync new soccer rows into sets table â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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

-- Sync new WNBA 2025 rows
INSERT INTO public.sets (sport_id, year, manufacturer_id, name)
SELECT
  sp.id  AS sport_id,
  cl.year,
  m.id   AS manufacturer_id,
  cl.set_name AS name
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE cl.sport = 'wnba'
  AND cl.year  = 2025
  AND cl.set_name IN ('Flawless WNBA','Immaculate WNBA','National Treasures WNBA','Obsidian WNBA')
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;

-- â”€â”€ 6. Refresh parallel_templates â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Soccer sets
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id       = sp.id
  AND s.year           = cl.year
  AND s.manufacturer_id = m.id
  AND s.name           = cl.set_name
  AND cl.sport         = 'soccer';

-- WNBA 2025 new sets
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name
  AND cl.sport          = 'wnba'
  AND cl.year           = 2025
  AND cl.set_name IN ('Flawless WNBA','Immaculate WNBA','National Treasures WNBA','Obsidian WNBA');

-- Topps Chrome Football 2024 (already updated in card_sets_legacy â€” re-sync)
UPDATE public.sets s
SET parallel_templates = cl.parallels
FROM public.card_sets_legacy cl
JOIN public.sports       sp ON sp.slug = cl.sport
JOIN public.manufacturers m  ON m.name  = cl.brand
WHERE s.sport_id        = sp.id
  AND s.year            = cl.year
  AND s.manufacturer_id = m.id
  AND s.name            = cl.set_name
  AND cl.sport          = 'football'
  AND cl.year           = 2024
  AND cl.brand          = 'Topps'
  AND cl.set_name       = 'Chrome';


