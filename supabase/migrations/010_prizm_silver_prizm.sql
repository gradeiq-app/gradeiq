-- ============================================================
-- 010_prizm_silver_prizm.sql
--
-- Data consistency fix: Silver Prizm is present in the parallels
-- table for all basketball Prizm cards (seeded correctly) but was
-- accidentally omitted from the parallel_templates JSONB column on
-- the sets table.
--
-- If the /api/cards/parallels route ever falls back to templates
-- (e.g. when no parallels rows exist for a card), Silver Prizm
-- would silently disappear from the tile list.
--
-- Fix:
--   1. Prepend {"label":"Silver Prizm","ebay_kw":"Silver Prizm"}
--      to parallel_templates for every basketball Prizm set that
--      does not already contain it.
--   2. Backfill the parallels table for any card in a basketball
--      Prizm set that is still missing a Silver Prizm row (idempotent).
-- ============================================================

-- ── 1. Patch parallel_templates ──────────────────────────────────────────────
-- Prepend Silver Prizm as the first element.
-- The route's sortParallels() always puts Base first and PROMOTED_LABELS
-- (which includes 'silver prizm') second, so position in the JSONB array
-- does not affect rendered order — but leading with it makes the template
-- self-documenting.
UPDATE public.sets
SET parallel_templates =
      '[{"label":"Silver Prizm","ebay_kw":"Silver Prizm"}]'::jsonb
      || parallel_templates
WHERE name = 'Prizm'
  AND sport_id      = (SELECT id FROM public.sports        WHERE slug = 'basketball')
  AND manufacturer_id = (SELECT id FROM public.manufacturers WHERE name = 'Panini')
  AND parallel_templates IS NOT NULL
  -- Only update sets that are missing the entry
  AND NOT (parallel_templates @> '[{"label":"Silver Prizm"}]'::jsonb);

-- ── 2. Backfill parallels table ───────────────────────────────────────────────
-- Insert one Silver Prizm row per card for any card in a basketball Prizm set
-- that doesn't already have one.  Uses a CTE to identify the affected cards
-- then bulk-inserts.
INSERT INTO public.parallels (card_id, label, ebay_kw, print_run)
SELECT
  c.id   AS card_id,
  'Silver Prizm' AS label,
  'Silver Prizm' AS ebay_kw,
  NULL           AS print_run
FROM public.cards c
JOIN public.sets  s  ON s.id = c.set_id
JOIN public.sports sp ON sp.id = s.sport_id
JOIN public.manufacturers m ON m.id = s.manufacturer_id
WHERE s.name          = 'Prizm'
  AND sp.slug         = 'basketball'
  AND m.name          = 'Panini'
  AND NOT EXISTS (
    SELECT 1
    FROM public.parallels p
    WHERE p.card_id = c.id
      AND p.label   = 'Silver Prizm'
  );
