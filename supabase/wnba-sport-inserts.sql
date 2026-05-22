-- ─────────────────────────────────────────────────────────────────────────────
-- Migration: Add WNBA sport + insert sets for all sports
-- Run via: Supabase Dashboard → SQL Editor, or
--          SUPABASE_TOKEN=sbp_... SUPABASE_REF=dcsrpdmhmcboydjsbgsg python supabase/run_patch.py supabase/wnba-sport-inserts.sql
-- ─────────────────────────────────────────────────────────────────────────────

-- 1. Expand the sport CHECK constraint to include wnba
alter table card_sets drop constraint if exists card_sets_sport_check;
alter table card_sets add constraint card_sets_sport_check
  check (sport in ('baseball','basketball','football','hockey','wnba'));

-- 2. Insert all new records
do $$
declare
  prizm_wnba_base    jsonb;
  prizm_wnba_auto    jsonb;
  donruss_wnba       jsonb;
  immaculate_wnba    jsonb;
  flawless_wnba      jsonb;
  nt_wnba            jsonb;
  young_guns         jsonb;
  contenders_rta_bbb jsonb;
  prizm_fast_break   jsonb;
  bowman_prospect_auto jsonb;
  chrome_sapphire    jsonb;
  nt_football_rpa    jsonb;
  contenders_optic   jsonb;
  select_football    jsonb;
begin

  -- ── WNBA Prizm parallels ─────────────────────────────────────────────────
  prizm_wnba_base := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Silver Prizm",     "ebay_kw":"Silver Prizm"},
    {"label":"Red /149",         "ebay_kw":"Red Prizm"},
    {"label":"Blue /99",         "ebay_kw":"Blue Prizm"},
    {"label":"Purple /49",       "ebay_kw":"Purple Prizm"},
    {"label":"Orange /25",       "ebay_kw":"Orange Prizm"},
    {"label":"Gold /10",         "ebay_kw":"Gold Prizm"},
    {"label":"Black /1",         "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  prizm_wnba_auto := prizm_wnba_base || '[
    {"label":"Rookie Auto",      "ebay_kw":"Rookie Auto"},
    {"label":"Auto Silver",      "ebay_kw":"Auto Silver Prizm"},
    {"label":"Auto Gold /10",    "ebay_kw":"Auto Gold Prizm"}
  ]'::jsonb;

  donruss_wnba := '[
    {"label":"Base",              "ebay_kw":""},
    {"label":"Rated Rookie",      "ebay_kw":"Rated Rookie"},
    {"label":"Bronze /199",       "ebay_kw":"Bronze"},
    {"label":"Blue /99",          "ebay_kw":"Blue"},
    {"label":"Red /49",           "ebay_kw":"Red"},
    {"label":"Gold /25",          "ebay_kw":"Gold"},
    {"label":"Black /1",          "ebay_kw":"Black"},
    {"label":"Rated Rookie Auto", "ebay_kw":"Rated Rookie Auto"}
  ]'::jsonb;

  immaculate_wnba := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Auto /49",         "ebay_kw":"Auto"},
    {"label":"Patch Auto /25",   "ebay_kw":"Patch Auto"},
    {"label":"Logoman Auto /1",  "ebay_kw":"Logoman Auto"}
  ]'::jsonb;

  flawless_wnba := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Ruby /15",         "ebay_kw":"Ruby"},
    {"label":"Sapphire /10",     "ebay_kw":"Sapphire"},
    {"label":"Emerald /5",       "ebay_kw":"Emerald"},
    {"label":"Diamond /1",       "ebay_kw":"Diamond"}
  ]'::jsonb;

  nt_wnba := '[
    {"label":"RPA /99",          "ebay_kw":"RPA"},
    {"label":"Gold RPA /25",     "ebay_kw":"Gold RPA"},
    {"label":"Platinum RPA /1",  "ebay_kw":"Platinum RPA"}
  ]'::jsonb;

  -- ── Hockey Young Guns parallels ──────────────────────────────────────────
  young_guns := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Canvas",           "ebay_kw":"Canvas"},
    {"label":"Exclusives /100",  "ebay_kw":"Exclusives"},
    {"label":"High Gloss /10",   "ebay_kw":"High Gloss"},
    {"label":"Clear Cut",        "ebay_kw":"Clear Cut"}
  ]'::jsonb;

  -- ── Basketball insert parallels ─────────────────────────────────────────
  contenders_rta_bbb := '[
    {"label":"Base",                      "ebay_kw":""},
    {"label":"Cracked Ice /25",           "ebay_kw":"Cracked Ice"},
    {"label":"Championship Ticket /10",   "ebay_kw":"Championship Ticket"},
    {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"}
  ]'::jsonb;

  prizm_fast_break := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Silver",           "ebay_kw":"Silver Prizm"},
    {"label":"Blue /149",        "ebay_kw":"Blue Prizm"},
    {"label":"Purple /99",       "ebay_kw":"Purple Prizm"},
    {"label":"Orange /49",       "ebay_kw":"Orange Prizm"},
    {"label":"Gold /10",         "ebay_kw":"Gold Prizm"},
    {"label":"Black /1",         "ebay_kw":"Black Prizm"}
  ]'::jsonb;

  -- ── Baseball insert parallels ───────────────────────────────────────────
  bowman_prospect_auto := '[
    {"label":"Base Auto",             "ebay_kw":"Auto"},
    {"label":"Blue Refractor /150",   "ebay_kw":"Blue Refractor Auto"},
    {"label":"Purple Refractor /250", "ebay_kw":"Purple Refractor Auto"},
    {"label":"Orange Refractor /25",  "ebay_kw":"Orange Refractor Auto"},
    {"label":"Gold Refractor /50",    "ebay_kw":"Gold Refractor Auto"},
    {"label":"Red Refractor /5",      "ebay_kw":"Red Refractor Auto"},
    {"label":"Superfractor /1",       "ebay_kw":"Superfractor Auto"}
  ]'::jsonb;

  chrome_sapphire := '[
    {"label":"Base",             "ebay_kw":""},
    {"label":"Blue /150",        "ebay_kw":"Blue Refractor"},
    {"label":"Gold /50",         "ebay_kw":"Gold Refractor"},
    {"label":"Orange /25",       "ebay_kw":"Orange Refractor"},
    {"label":"Red /5",           "ebay_kw":"Red Refractor"},
    {"label":"Superfractor /1",  "ebay_kw":"Superfractor"}
  ]'::jsonb;

  -- ── Football insert parallels ───────────────────────────────────────────
  nt_football_rpa := '[
    {"label":"RPA /99",          "ebay_kw":"RPA"},
    {"label":"Gold RPA /25",     "ebay_kw":"Gold RPA"},
    {"label":"Platinum RPA /5",  "ebay_kw":"Platinum RPA"},
    {"label":"Black RPA /1",     "ebay_kw":"Black RPA"}
  ]'::jsonb;

  contenders_optic := '[
    {"label":"Base",                   "ebay_kw":""},
    {"label":"Rookie Ticket Auto",     "ebay_kw":"Rookie Ticket Auto"},
    {"label":"Blue /149",              "ebay_kw":"Blue"},
    {"label":"Orange /99",             "ebay_kw":"Orange"},
    {"label":"Red /50",                "ebay_kw":"Red"},
    {"label":"Gold /10",               "ebay_kw":"Gold"},
    {"label":"Black /1",               "ebay_kw":"Black"}
  ]'::jsonb;

  select_football := '[
    {"label":"Concourse",         "ebay_kw":"Concourse"},
    {"label":"Premier Level",     "ebay_kw":"Premier Level"},
    {"label":"Courtside",         "ebay_kw":"Courtside"},
    {"label":"Silver",            "ebay_kw":"Silver"},
    {"label":"Blue /149",         "ebay_kw":"Blue"},
    {"label":"Purple /49",        "ebay_kw":"Purple"},
    {"label":"Gold /10",          "ebay_kw":"Gold"},
    {"label":"Black /1",          "ebay_kw":"Black"}
  ]'::jsonb;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- WNBA
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'wnba', y, 'Panini', 'Prizm WNBA',
      case when y >= 2021 then prizm_wnba_auto else prizm_wnba_base end
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'wnba', y, 'Panini', 'Donruss WNBA', donruss_wnba
    from generate_series(2020, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'wnba', y, 'Panini', 'Immaculate WNBA', immaculate_wnba
    from generate_series(2021, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'wnba', y, 'Panini', 'Flawless WNBA', flawless_wnba
    from generate_series(2022, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'wnba', y, 'Panini', 'National Treasures WNBA', nt_wnba
    from generate_series(2023, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- HOCKEY — Young Guns (most critical missing insert)
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'hockey', y, 'Upper Deck', 'Young Guns', young_guns
    from generate_series(2018, 2025) y
  on conflict (sport, year, brand, set_name) do nothing;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- BASKETBALL inserts
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Contenders Rookie Ticket Auto', contenders_rta_bbb
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'basketball', y, 'Panini', 'Prizm Fast Break', prizm_fast_break
    from generate_series(2020, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- BASEBALL inserts
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Bowman', 'Chrome Prospect Auto', bowman_prospect_auto
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'baseball', y, 'Topps', 'Chrome Sapphire Edition', chrome_sapphire
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  -- ═══════════════════════════════════════════════════════════════════════════
  -- FOOTBALL inserts
  -- ═══════════════════════════════════════════════════════════════════════════

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'National Treasures Rookie Patch Auto', nt_football_rpa
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Contenders Optic', contenders_optic
    from generate_series(2018, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

  insert into card_sets (sport, year, brand, set_name, parallels)
    select 'football', y, 'Panini', 'Select', select_football
    from generate_series(2019, 2024) y
  on conflict (sport, year, brand, set_name) do nothing;

end $$;
