-- ============================================================
-- RawIQ — New Relational Schema
-- Migration 001: Core reference tables + hierarchical card data model
-- Run after all existing migrations (profiles, admin, promo-codes, etc.)
-- ============================================================

-- Trigram extension for player name fuzzy-search
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- ── 1. Sports ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.sports (
  id    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name  text NOT NULL,
  slug  text NOT NULL UNIQUE   -- baseball | basketball | football | hockey | soccer
);

ALTER TABLE public.sports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read sports"
  ON public.sports FOR SELECT USING (true);

-- ── 2. Leagues ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.leagues (
  id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name      text NOT NULL,
  slug      text NOT NULL UNIQUE,   -- mlb | nba | nfl | nhl | mls
  sport_id  uuid NOT NULL REFERENCES public.sports(id) ON DELETE CASCADE
);

ALTER TABLE public.leagues ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read leagues"
  ON public.leagues FOR SELECT USING (true);

CREATE INDEX IF NOT EXISTS leagues_sport_id ON public.leagues (sport_id);

-- ── 3. Manufacturers ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.manufacturers (
  id    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name  text NOT NULL,
  slug  text NOT NULL UNIQUE   -- topps | panini | bowman | upper-deck | etc.
);

ALTER TABLE public.manufacturers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read manufacturers"
  ON public.manufacturers FOR SELECT USING (true);

-- ── 4. Players ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.players (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name           text NOT NULL,
  sport_id       uuid REFERENCES public.sports(id) ON DELETE SET NULL,
  position       text,
  active         boolean NOT NULL DEFAULT true,
  -- Generated tsvector for full-text search on player name
  search_vector  tsvector GENERATED ALWAYS AS (to_tsvector('english', name)) STORED,
  created_at     timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.players ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read players"
  ON public.players FOR SELECT USING (true);
CREATE POLICY "Admins manage players"
  ON public.players FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true
  ));

CREATE INDEX IF NOT EXISTS players_sport_id ON public.players (sport_id);
-- GIN index for full-text search via search_vector
CREATE INDEX IF NOT EXISTS players_search_vector_gin ON public.players USING GIN (search_vector);
-- GIN trigram index for prefix/partial matching (autocomplete)
CREATE INDEX IF NOT EXISTS players_name_trgm ON public.players USING GIN (name gin_trgm_ops);

-- ── 5. Sets ───────────────────────────────────────────────────────────────────
-- Relational replacement for card_sets JSONB table.
-- One row per (sport, year, manufacturer, set_name).
-- parallels live on individual cards — this is just the set-level catalog.
CREATE TABLE IF NOT EXISTS public.sets (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sport_id         uuid NOT NULL REFERENCES public.sports(id) ON DELETE RESTRICT,
  year             integer NOT NULL,
  manufacturer_id  uuid NOT NULL REFERENCES public.manufacturers(id) ON DELETE RESTRICT,
  name             text NOT NULL,
  is_active        boolean NOT NULL DEFAULT true,
  created_at       timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT sets_sport_year_manufacturer_name_key
    UNIQUE (sport_id, year, manufacturer_id, name)
);

ALTER TABLE public.sets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read sets"
  ON public.sets FOR SELECT USING (true);
CREATE POLICY "Admins manage sets"
  ON public.sets FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true
  ));

CREATE INDEX IF NOT EXISTS sets_sport_year ON public.sets (sport_id, year DESC);
CREATE INDEX IF NOT EXISTS sets_manufacturer ON public.sets (manufacturer_id);

-- ── 6. Cards ──────────────────────────────────────────────────────────────────
-- Individual cards within a set (not seeded yet — populated later via admin).
CREATE TABLE IF NOT EXISTS public.cards (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  set_id       uuid NOT NULL REFERENCES public.sets(id) ON DELETE CASCADE,
  player_id    uuid REFERENCES public.players(id) ON DELETE SET NULL,
  card_number  text,
  name         text,   -- display name e.g. "Patrick Mahomes #15"
  created_at   timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read cards"
  ON public.cards FOR SELECT USING (true);
CREATE POLICY "Admins manage cards"
  ON public.cards FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true
  ));

CREATE INDEX IF NOT EXISTS cards_set_id ON public.cards (set_id);
CREATE INDEX IF NOT EXISTS cards_player_id ON public.cards (player_id);

-- ── 7. Parallels (card-level) ─────────────────────────────────────────────────
-- Parallel variants for individual cards (not seeded yet).
CREATE TABLE IF NOT EXISTS public.parallels (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  card_id    uuid NOT NULL REFERENCES public.cards(id) ON DELETE CASCADE,
  label      text NOT NULL,          -- display label e.g. "Gold Refractor /50"
  ebay_kw    text NOT NULL DEFAULT '',  -- eBay keyword suffix
  print_run  integer,                -- null = unnumbered
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.parallels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read parallels"
  ON public.parallels FOR SELECT USING (true);
CREATE POLICY "Admins manage parallels"
  ON public.parallels FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true
  ));

CREATE INDEX IF NOT EXISTS parallels_card_id ON public.parallels (card_id);
