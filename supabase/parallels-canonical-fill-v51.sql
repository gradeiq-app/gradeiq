-- ─────────────────────────────────────────────────────────────────────────────
-- v51: Fill canonical Prizm parallels (Silver / Gold /10 / Black 1/1)
--
-- Adds the three canonical "must-have" Panini Prizm flagship parallels to
-- every card in every Panini Prizm flagship set that's missing them. All
-- three were absent from the seeding template, so /analyze couldn't surface
-- Silver Prizm (the most-chased common parallel) at all.
--
-- Match regex treats "Gold /10" and "Gold Prizm /10" as the same flagship
-- parallel — modern Prizm drops "Prizm" from the label since the whole set
-- is Prizm, so the bare-color form is canonical. Excludes "Gold Shimmer",
-- "Gold Wave", etc. via anchored regex.
--
-- Scope (from preview before this ran):
--   1,816 Panini Prizm flagship cards
--     → 1,212 missing Silver Prizm
--     →   134 missing Gold /10
--     →   678 missing Black /1
--
-- Topps Chrome was already fully seeded (Refractor + SuperFractor /1 on all
-- 812 cards) — no work needed.
-- ─────────────────────────────────────────────────────────────────────────────

-- Silver Prizm (unlimited) — skip if any "silver" parallel already exists
INSERT INTO public.parallels (card_id, label, ebay_kw, print_run)
SELECT c.id, 'Silver Prizm', 'Silver Prizm', NULL
FROM public.cards c
JOIN public.sets s          ON s.id = c.set_id
JOIN public.manufacturers m ON m.id = s.manufacturer_id
WHERE m.name = 'Panini'
  AND s.name = 'Prizm'
  AND NOT EXISTS (
    SELECT 1 FROM public.parallels p
    WHERE p.card_id = c.id AND p.label ~* 'silver'
  );

-- Gold Prizm /10 — skip if a flagship gold /10 already exists in any spelling
INSERT INTO public.parallels (card_id, label, ebay_kw, print_run)
SELECT c.id, 'Gold Prizm /10', 'Gold Prizm', 10
FROM public.cards c
JOIN public.sets s          ON s.id = c.set_id
JOIN public.manufacturers m ON m.id = s.manufacturer_id
WHERE m.name = 'Panini'
  AND s.name = 'Prizm'
  AND NOT EXISTS (
    SELECT 1 FROM public.parallels p
    WHERE p.card_id = c.id
      AND COALESCE(p.print_run, 0) = 10
      AND p.label ~* '^gold( prizm)?( ?(/10|10/10))?$'
  );

-- Black Prizm 1/1 — skip if a flagship black /1 already exists in any spelling
INSERT INTO public.parallels (card_id, label, ebay_kw, print_run)
SELECT c.id, 'Black Prizm 1/1', 'Black Prizm', 1
FROM public.cards c
JOIN public.sets s          ON s.id = c.set_id
JOIN public.manufacturers m ON m.id = s.manufacturer_id
WHERE m.name = 'Panini'
  AND s.name = 'Prizm'
  AND NOT EXISTS (
    SELECT 1 FROM public.parallels p
    WHERE p.card_id = c.id
      AND COALESCE(p.print_run, 0) = 1
      AND p.label ~* '^black( prizm)?( ?(1/?1|/1))?$'
  );
