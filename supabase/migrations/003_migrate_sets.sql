-- ============================================================
-- RawIQ — Sets Migration
-- Migration 003: rename card_sets → card_sets_legacy,
--                create compat VIEW so all existing routes keep working,
--                populate new relational `sets` table from legacy data.
-- Run after 002_seed_reference.sql
-- ============================================================

-- ── 1. Rename card_sets → card_sets_legacy ────────────────────────────────────
-- All data, policies, constraints, and indexes carry over automatically.
-- Existing policy names (e.g. "Anyone can read card_sets") are unchanged —
-- they are labels only and do not affect functionality.
ALTER TABLE public.card_sets RENAME TO card_sets_legacy;

-- Rename the sport/year index for clarity
ALTER INDEX IF EXISTS card_sets_sport_year RENAME TO card_sets_legacy_sport_year;

-- ── 2. Compatibility VIEW: card_sets → card_sets_legacy ───────────────────────
-- A simple single-table view is auto-updatable in PostgreSQL:
-- INSERT / UPDATE / DELETE through this view go straight to card_sets_legacy.
-- The underlying table's RLS policies apply (service_role bypasses them; anon/
-- authenticated users get read-only access as before).
-- All existing API routes (GET /api/cards, admin sets, sets-queue approval)
-- continue to work with zero code changes.
CREATE VIEW public.card_sets AS
  SELECT * FROM public.card_sets_legacy;

-- ── 3. Populate new `sets` table from legacy data ─────────────────────────────
-- Maps sport text → sports.id and brand text → manufacturers.id.
-- Rows whose brand has no matching manufacturer row are silently skipped.
-- After applying this migration you can audit skipped rows with:
--   SELECT DISTINCT brand FROM card_sets_legacy
--   WHERE brand NOT IN (SELECT name FROM manufacturers);
INSERT INTO public.sets (sport_id, year, manufacturer_id, name, created_at)
SELECT
  s.id   AS sport_id,
  cs.year,
  m.id   AS manufacturer_id,
  cs.set_name AS name,
  cs.created_at
FROM public.card_sets_legacy cs
JOIN public.sports       s ON s.slug = cs.sport
JOIN public.manufacturers m ON m.name  = cs.brand
ON CONFLICT (sport_id, year, manufacturer_id, name) DO NOTHING;
