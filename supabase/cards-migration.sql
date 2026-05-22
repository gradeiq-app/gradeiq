-- ─────────────────────────────────────────────────────────────────────────────
-- Card Sets + Parallels
-- One row per (sport, year, brand, set_name).
-- The `parallels` JSONB array is the key: each entry has a display label and
-- the exact eBay keyword suffix to append to the search string.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists card_sets (
  id         uuid    primary key default gen_random_uuid(),
  sport      text    not null check (sport in ('baseball','basketball','football','hockey')),
  year       integer not null,
  brand      text    not null,
  set_name   text    not null,
  parallels  jsonb   not null default '[]',
  created_at timestamptz default now(),
  unique (sport, year, brand, set_name)
);

create index if not exists card_sets_sport_year on card_sets (sport, year);

-- Public read only — admins manage via admin panel
alter table card_sets enable row level security;
create policy "Anyone can read card_sets"
  on card_sets for select using (true);
create policy "Admins can manage card_sets"
  on card_sets for all
  using (exists (
    select 1 from profiles where id = auth.uid() and is_admin = true
  ));

-- ─── Seed parallel templates + rows ──────────────────────────────────────────
do $$
declare
  chrome_parallels      jsonb;
  bowman_parallels      jsonb;
  prizm_parallels       jsonb;
  optic_parallels       jsonb;
  mosaic_parallels      jsonb;
  select_parallels      jsonb;
  topps_base_parallels  jsonb;
  heritage_parallels    jsonb;
  finest_parallels      jsonb;
  contenders_parallels  jsonb;
  opc_platinum_parallels jsonb;
  ud_parallels          jsonb;
  donruss_parallels     jsonb;
  hoops_parallels       jsonb;
  court_kings_parallels jsonb;
  spectra_parallels     jsonb;
begin

  -- ── Topps / Bowman Chrome Refractors ─────────────────────────────────────
  chrome_parallels := '[
    {"label":"Base",                     "ebay_kw":""},
    {"label":"Refractor",                "ebay_kw":"Refractor"},
    {"label":"Negative Refractor",       "ebay_kw":"Negative Refractor"},
    {"label":"X-Fractor",                "ebay_kw":"X-Fractor"},
    {"label":"Prism Refractor",          "ebay_kw":"Prism Refractor"},
    {"label":"Speckle Refractor /299",   "ebay_kw":"Speckle Refractor"},
    {"label":"Pink Refractor /199",      "ebay_kw":"Pink Refractor"},
    {"label":"Blue Wave Refractor /150", "ebay_kw":"Blue Wave Refractor"},
    {"label":"Green Refractor /99",      "ebay_kw":"Green Refractor"},
    {"label":"Sepia Refractor /75",      "ebay_kw":"Sepia Refractor"},
    {"label":"Gold Refractor /50",       "ebay_kw":"Gold Refractor"},
    {"label":"Orange Refractor /25",     "ebay_kw":"Orange Refractor"},
    {"label":"Red Refractor /5",         "ebay_kw":"Red Refractor"},
    {"label":"SuperFractor /1",          "ebay_kw":"Superfractor"},
    {"label":"Black Refractor",          "ebay_kw":"Black Refractor"}
  ]'::jsonb;

  bowman_parallels := '[
    {"label":"Base",                    "ebay_kw":""},
    {"label":"Refractor",               "ebay_kw":"Refractor"},
    {"label":"Negative Refractor",      "ebay_kw":"Negative Refractor"},
    {"label":"X-Fractor",               "ebay_kw":"X-Fractor"},
    {"label":"Scouts Top 100",          "ebay_kw":"Scouts Top 100"},
    {"label":"Speckle Refractor /299",  "ebay_kw":"Speckle Refractor"},
    {"label":"Pink Refractor /250",     "ebay_kw":"Pink Refractor"},
    {"label":"Blue Refractor /150",     "ebay_kw":"Blue Refractor"},
    {"label":"Green Refractor /99",     "ebay_kw":"Green Refractor"},
    {"label":"Gold Refractor /50",      "ebay_kw":"Gold Refractor"},
    {"label":"Orange Refractor /25",    "ebay_kw":"Orange Refractor"},
    {"label":"Red Refractor /5",        "ebay_kw":"Red Refractor"},
    {"label":"SuperFractor /1",         "ebay_kw":"Superfractor"}
  ]'::jsonb;

  -- ── Panini Prizm ─────────────────────────────────────────────────────────
  prizm_parallels := '[
    {"label":"Base",                      "ebay_kw":""},
    {"label":"Silver Prizm",              "ebay_kw":"Silver Prizm"},
    {"label":"Hyper Prizm",               "ebay_kw":"Hyper Prizm"},
    {"label":"Scope Prizm",               "ebay_kw":"Scope Prizm"},
    {"label":"Fast Break Prizm",          "ebay_kw":"Fast Break Prizm"},
    {"label":"Ice Prizm",                 "ebay_kw":"Ice Prizm"},
    {"label":"Disco Prizm",               "ebay_kw":"Disco Prizm"},
    {"label":"Tiger Stripe Prizm",        "ebay_kw":"Tiger Stripe Prizm"},
    {"label":"Red White Blue Prizm",      "ebay_kw":"Red White Blue Prizm"},
    {"label":"Luck of the Irish",         "ebay_kw":"Luck of the Irish"},
    {"label":"Blue Ice Prizm /225",       "ebay_kw":"Blue Ice Prizm"},
    {"label":"Blue Prizm /199",           "ebay_kw":"Blue Prizm"},
    {"label":"Red Prizm /99",             "ebay_kw":"Red Prizm"},
    {"label":"Green Prizm /75",           "ebay_kw":"Green Prizm"},
    {"label":"Purple Prizm /49",          "ebay_kw":"Purple Prizm"},
    {"label":"Pink Prizm /35",            "ebay_kw":"Pink Prizm"},
    {"label":"Gold Prizm /10",            "ebay_kw":"Gold Prizm"},
    {"label":"Black Prizm /1",            "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  -- ── Panini Optic / Donruss Optic ─────────────────────────────────────────
  optic_parallels := '[
    {"label":"Base",              "ebay_kw":""},
    {"label":"Holo",              "ebay_kw":"Holo"},
    {"label":"Blue /149",         "ebay_kw":"Blue"},
    {"label":"Orange /199",       "ebay_kw":"Orange"},
    {"label":"Pink /149",         "ebay_kw":"Pink"},
    {"label":"Red /99",           "ebay_kw":"Red"},
    {"label":"Purple /75",        "ebay_kw":"Purple"},
    {"label":"Gold /10",          "ebay_kw":"Gold"},
    {"label":"Black /1",          "ebay_kw":"Black"},
    {"label":"Aqua",              "ebay_kw":"Aqua"},
    {"label":"Lime Green /149",   "ebay_kw":"Lime Green"},
    {"label":"Shock",             "ebay_kw":"Shock"}
  ]'::jsonb;

  -- ── Panini Mosaic ─────────────────────────────────────────────────────────
  mosaic_parallels := '[
    {"label":"Base",               "ebay_kw":""},
    {"label":"Silver Prizm",       "ebay_kw":"Silver Prizm"},
    {"label":"Mosaic Camo",        "ebay_kw":"Mosaic Camo"},
    {"label":"Pink Camo",          "ebay_kw":"Pink Camo"},
    {"label":"Reactive Blue",      "ebay_kw":"Reactive Blue"},
    {"label":"Reactive Orange",    "ebay_kw":"Reactive Orange"},
    {"label":"Reactive Yellow",    "ebay_kw":"Reactive Yellow"},
    {"label":"Green /199",         "ebay_kw":"Green Mosaic"},
    {"label":"Blue /149",          "ebay_kw":"Blue"},
    {"label":"Red /99",            "ebay_kw":"Red"},
    {"label":"Purple /49",         "ebay_kw":"Purple"},
    {"label":"Gold /10",           "ebay_kw":"Gold"},
    {"label":"Black /1",           "ebay_kw":"Black"}
  ]'::jsonb;

  -- ── Panini Select ─────────────────────────────────────────────────────────
  select_parallels := '[
    {"label":"Base (Premier Level)", "ebay_kw":"Premier Level"},
    {"label":"Silver Prizm",         "ebay_kw":"Silver Prizm"},
    {"label":"Concourse Level",      "ebay_kw":"Concourse Level"},
    {"label":"Field Level",          "ebay_kw":"Field Level"},
    {"label":"Blue /249",            "ebay_kw":"Blue"},
    {"label":"Orange /199",          "ebay_kw":"Orange"},
    {"label":"Red /99",              "ebay_kw":"Red"},
    {"label":"Green /75",            "ebay_kw":"Green"},
    {"label":"Purple /49",           "ebay_kw":"Purple"},
    {"label":"Pink /35",             "ebay_kw":"Pink"},
    {"label":"Gold /25",             "ebay_kw":"Gold"},
    {"label":"Black /1",             "ebay_kw":"Black"}
  ]'::jsonb;

  -- ── Topps Base / Series 1-2 / Update ─────────────────────────────────────
  topps_base_parallels := '[
    {"label":"Base",                   "ebay_kw":""},
    {"label":"Gold (year varies)",     "ebay_kw":"Gold"},
    {"label":"Rainbow Foil",           "ebay_kw":"Rainbow Foil"},
    {"label":"Clear",                  "ebay_kw":"Clear"},
    {"label":"Blue /250",              "ebay_kw":"Blue"},
    {"label":"Black /63",              "ebay_kw":"Black"},
    {"label":"Independence Day /76",   "ebay_kw":"Independence Day"},
    {"label":"Memorial Day Camo /25",  "ebay_kw":"Memorial Day Camo"},
    {"label":"Father''s Day /50",      "ebay_kw":"Father Day"},
    {"label":"Orange /75",             "ebay_kw":"Orange"},
    {"label":"Red /10",                "ebay_kw":"Red"},
    {"label":"Platinum /1",            "ebay_kw":"Platinum"}
  ]'::jsonb;

  -- ── Topps Heritage ────────────────────────────────────────────────────────
  heritage_parallels := '[
    {"label":"Base",                        "ebay_kw":""},
    {"label":"Chrome",                      "ebay_kw":"Chrome"},
    {"label":"Chrome Refractor",            "ebay_kw":"Chrome Refractor"},
    {"label":"Chrome Pink Refractor /570",  "ebay_kw":"Chrome Pink Refractor"},
    {"label":"Chrome Blue Refractor /99",   "ebay_kw":"Chrome Blue Refractor"},
    {"label":"Chrome Gold Refractor /50",   "ebay_kw":"Chrome Gold Refractor"},
    {"label":"Chrome Red Refractor /5",     "ebay_kw":"Chrome Red Refractor"},
    {"label":"Chrome SuperFractor /1",      "ebay_kw":"Chrome Superfractor"},
    {"label":"Short Print",                 "ebay_kw":"Short Print SP"}
  ]'::jsonb;

  -- ── Topps Finest ──────────────────────────────────────────────────────────
  finest_parallels := '[
    {"label":"Base",                 "ebay_kw":""},
    {"label":"Refractor",            "ebay_kw":"Refractor"},
    {"label":"Blue Refractor /99",   "ebay_kw":"Blue Refractor"},
    {"label":"Gold Refractor /50",   "ebay_kw":"Gold Refractor"},
    {"label":"Orange Refractor /25", "ebay_kw":"Orange Refractor"},
    {"label":"Red Refractor /25",    "ebay_kw":"Red Refractor"},
    {"label":"Black Refractor /5",   "ebay_kw":"Black Refractor"},
    {"label":"SuperFractor /1",      "ebay_kw":"Superfractor"}
  ]'::jsonb;

  -- ── Panini Contenders ─────────────────────────────────────────────────────
  contenders_parallels := '[
    {"label":"Base",                    "ebay_kw":""},
    {"label":"Playoff Ticket /99",      "ebay_kw":"Playoff Ticket"},
    {"label":"Wild Card Ticket /49",    "ebay_kw":"Wild Card Ticket"},
    {"label":"Championship Ticket /25", "ebay_kw":"Championship Ticket"},
    {"label":"Super Bowl Ticket /10",   "ebay_kw":"Super Bowl Ticket"},
    {"label":"Cracked Ice /21",         "ebay_kw":"Cracked Ice"},
    {"label":"Variation",               "ebay_kw":"Variation"},
    {"label":"Optic /50",               "ebay_kw":"Optic"},
    {"label":"Optic Pink /25",          "ebay_kw":"Optic Pink"},
    {"label":"Optic Blue /10",          "ebay_kw":"Optic Blue"}
  ]'::jsonb;

  -- ── O-Pee-Chee Platinum ───────────────────────────────────────────────────
  opc_platinum_parallels := '[
    {"label":"Base",                  "ebay_kw":""},
    {"label":"Marquee Rookies",       "ebay_kw":"Marquee Rookies"},
    {"label":"Retro",                 "ebay_kw":"Retro"},
    {"label":"Blue /199",             "ebay_kw":"Blue"},
    {"label":"Red /99",               "ebay_kw":"Red"},
    {"label":"Teal /75",              "ebay_kw":"Teal"},
    {"label":"Purple /50",            "ebay_kw":"Purple"},
    {"label":"Gold /25",              "ebay_kw":"Gold"},
    {"label":"Black /5",              "ebay_kw":"Black"},
    {"label":"Rainbow /1",            "ebay_kw":"Rainbow"}
  ]'::jsonb;

  -- ── Upper Deck ────────────────────────────────────────────────────────────
  ud_parallels := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Young Guns",       "ebay_kw":"Young Guns"},
    {"label":"High Gloss /10",   "ebay_kw":"High Gloss"},
    {"label":"Canvas",           "ebay_kw":"Canvas"},
    {"label":"French /100",      "ebay_kw":"French"},
    {"label":"Exclusives /100",  "ebay_kw":"Exclusives"}
  ]'::jsonb;

  -- ── Panini Donruss ────────────────────────────────────────────────────────
  donruss_parallels := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Press Proof /99",  "ebay_kw":"Press Proof"},
    {"label":"Pink /149",        "ebay_kw":"Pink"},
    {"label":"Blue /149",        "ebay_kw":"Blue"},
    {"label":"Red /99",          "ebay_kw":"Red"},
    {"label":"Purple /49",       "ebay_kw":"Purple"},
    {"label":"Gold /25",         "ebay_kw":"Gold"},
    {"label":"Holo Gold",        "ebay_kw":"Holo Gold"},
    {"label":"Black /1",         "ebay_kw":"Black"}
  ]'::jsonb;

  -- ── Panini Hoops ──────────────────────────────────────────────────────────
  hoops_parallels := '[
    {"label":"Base",               "ebay_kw":""},
    {"label":"Premium Stock",      "ebay_kw":"Premium Stock"},
    {"label":"Holofoil /699",      "ebay_kw":"Holofoil"},
    {"label":"Silver /149",        "ebay_kw":"Silver"},
    {"label":"Blue /149",          "ebay_kw":"Blue"},
    {"label":"Red /99",            "ebay_kw":"Red"},
    {"label":"Purple /49",         "ebay_kw":"Purple"},
    {"label":"Gold /10",           "ebay_kw":"Gold"},
    {"label":"Black /1",           "ebay_kw":"Black"},
    {"label":"Teal Explosion",     "ebay_kw":"Teal Explosion"}
  ]'::jsonb;

  -- ── Panini Court Kings ────────────────────────────────────────────────────
  court_kings_parallels := '[
    {"label":"Base",           "ebay_kw":""},
    {"label":"Artist Proof",   "ebay_kw":"Artist Proof"},
    {"label":"Pink /199",      "ebay_kw":"Pink"},
    {"label":"Blue /149",      "ebay_kw":"Blue"},
    {"label":"Red /99",        "ebay_kw":"Red"},
    {"label":"Purple /49",     "ebay_kw":"Purple"},
    {"label":"Gold /10",       "ebay_kw":"Gold"},
    {"label":"Black /1",       "ebay_kw":"Black"}
  ]'::jsonb;

  -- ── Panini Spectra (high-end football/basketball) ─────────────────────────
  spectra_parallels := '[
    {"label":"Base",                "ebay_kw":""},
    {"label":"Light Blue /199",     "ebay_kw":"Light Blue"},
    {"label":"Red /99",             "ebay_kw":"Red"},
    {"label":"Green /49",           "ebay_kw":"Green"},
    {"label":"Gold /25",            "ebay_kw":"Gold"},
    {"label":"Neon Green /5",       "ebay_kw":"Neon Green"},
    {"label":"Carolina Blue /25",   "ebay_kw":"Carolina Blue"},
    {"label":"Black /1",            "ebay_kw":"Black"}
  ]'::jsonb;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- BASEBALL
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Chrome', chrome_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Series 1', topps_base_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Series 2', topps_base_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Update', topps_base_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Heritage', heritage_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Finest', finest_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Stadium Club', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Chrome","ebay_kw":"Chrome"},
      {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"},
      {"label":"Gold /50","ebay_kw":"Gold"},
      {"label":"Red Foil","ebay_kw":"Red Foil"},
      {"label":"Black /50","ebay_kw":"Black"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Gypsy Queen', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Mini","ebay_kw":"Mini"},
      {"label":"Green /99","ebay_kw":"Green"},
      {"label":"Blue /50","ebay_kw":"Blue"},
      {"label":"Black /1","ebay_kw":"Black"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Allen & Ginter', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Mini","ebay_kw":"Mini"},
      {"label":"Mini Black Border","ebay_kw":"Mini Black"},
      {"label":"Mini A&G Back","ebay_kw":"Mini A&G Back"},
      {"label":"Mini Wood","ebay_kw":"Mini Wood"},
      {"label":"Chrome","ebay_kw":"Chrome"},
      {"label":"Chrome Refractor","ebay_kw":"Chrome Refractor"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Bowman', 'Chrome', bowman_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Bowman', 'Draft Chrome', bowman_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Bowman', 'Base', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Blue /500","ebay_kw":"Blue"},
      {"label":"Gold /50","ebay_kw":"Gold"},
      {"label":"Orange /25","ebay_kw":"Orange"},
      {"label":"Red /5","ebay_kw":"Red"},
      {"label":"Purple /1","ebay_kw":"Purple"},
      {"label":"Walmart Blue Refractor","ebay_kw":"Walmart Blue Refractor"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Panini', 'Prizm', prizm_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Panini', 'Select', select_parallels
    from generate_series(2020, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- BASKETBALL
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Prizm', prizm_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Mosaic', mosaic_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Select', select_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Donruss Optic', optic_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Donruss', donruss_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Hoops', hoops_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Court Kings', court_kings_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Spectra', spectra_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Immaculate', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Emerald /25","ebay_kw":"Emerald"},
      {"label":"Ruby /15","ebay_kw":"Ruby"},
      {"label":"Sapphire /10","ebay_kw":"Sapphire"},
      {"label":"Gold /10","ebay_kw":"Gold"},
      {"label":"Black /1","ebay_kw":"Black"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- FOOTBALL
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Prizm', prizm_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Select', select_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Mosaic', mosaic_parallels
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Donruss Optic', optic_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Donruss', donruss_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Contenders', contenders_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Spectra', spectra_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  -- Topps Chrome NFL (licensing ended after 2023)
  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Topps', 'Chrome', chrome_parallels
    from generate_series(2018, 2023) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'National Treasures', '[
      {"label":"Base /99","ebay_kw":""},
      {"label":"Gold /25","ebay_kw":"Gold"},
      {"label":"Platinum /5","ebay_kw":"Platinum"},
      {"label":"Black /1","ebay_kw":"Black"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- HOCKEY
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'O-Pee-Chee', 'Platinum', opc_platinum_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'Series 1', ud_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'Series 2', ud_parallels
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'SP Authentic', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Future Watch Auto","ebay_kw":"Future Watch"},
      {"label":"Silver Spectrum /50","ebay_kw":"Silver Spectrum"},
      {"label":"Rainbow /100","ebay_kw":"Rainbow"},
      {"label":"Gold /50","ebay_kw":"Gold"},
      {"label":"Red /25","ebay_kw":"Red"},
      {"label":"Black /10","ebay_kw":"Black"},
      {"label":"Purple /1","ebay_kw":"Purple"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'Parkhurst', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Spring Expo","ebay_kw":"Spring Expo"},
      {"label":"Gold","ebay_kw":"Gold"},
      {"label":"Ice Blue /199","ebay_kw":"Ice Blue"}
    ]'::jsonb
    from generate_series(2021, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'Artifacts', '[
      {"label":"Base","ebay_kw":""},
      {"label":"Teal /99","ebay_kw":"Teal"},
      {"label":"Purple /50","ebay_kw":"Purple"},
      {"label":"Gold /25","ebay_kw":"Gold"},
      {"label":"Red /10","ebay_kw":"Red"},
      {"label":"Black /5","ebay_kw":"Black"},
      {"label":"Rainbow /1","ebay_kw":"Rainbow"}
    ]'::jsonb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do update set parallels = excluded.parallels;

end $$;
