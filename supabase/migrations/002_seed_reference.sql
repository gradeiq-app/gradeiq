-- ============================================================
-- RawIQ — Reference Data Seed
-- Migration 002: sports, leagues, manufacturers
-- Run after 001_new_schema.sql
-- ============================================================

-- ── Sports ────────────────────────────────────────────────────────────────────
INSERT INTO public.sports (name, slug) VALUES
  ('Baseball',    'baseball'),
  ('Basketball',  'basketball'),
  ('Football',    'football'),
  ('Hockey',      'hockey'),
  ('Soccer',      'soccer')
ON CONFLICT (slug) DO NOTHING;

-- ── Leagues ───────────────────────────────────────────────────────────────────
INSERT INTO public.leagues (name, slug, sport_id) VALUES
  ('Major League Baseball',          'mlb', (SELECT id FROM public.sports WHERE slug = 'baseball')),
  ('National Basketball Association','nba', (SELECT id FROM public.sports WHERE slug = 'basketball')),
  ('National Football League',       'nfl', (SELECT id FROM public.sports WHERE slug = 'football')),
  ('National Hockey League',         'nhl', (SELECT id FROM public.sports WHERE slug = 'hockey')),
  ('Major League Soccer',            'mls', (SELECT id FROM public.sports WHERE slug = 'soccer'))
ON CONFLICT (slug) DO NOTHING;

-- ── Manufacturers ─────────────────────────────────────────────────────────────
-- Names must exactly match the `brand` column values in card_sets_legacy
-- so 003_migrate_sets.sql can JOIN on m.name = cs.brand
INSERT INTO public.manufacturers (name, slug) VALUES
  ('Topps',       'topps'),
  ('Panini',      'panini'),
  ('Bowman',      'bowman'),
  ('Upper Deck',  'upper-deck'),
  ('O-Pee-Chee',  'o-pee-chee'),
  ('Fleer',       'fleer'),
  ('Donruss',     'donruss'),
  ('Score',       'score'),
  ('Pro Set',     'pro-set'),
  ('Fanatics',    'fanatics'),
  ('Leaf',        'leaf')
ON CONFLICT (slug) DO NOTHING;
