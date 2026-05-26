-- =============================================================================
-- parallels-schema-fix.sql
-- Convert parallels rows written with {name, numbered, print_run} schema
-- (v17–v21) back to the correct {label, ebay_kw} schema the app expects.
--
-- Affected sets:
--   Bowman Base Baseball       ~31 rows with non-empty parallels
--   O-Pee-Chee Hockey           ~2 rows
--   Panini Hoops Basketball    ~15 rows
--   Topps Series 1 Baseball    ~32 rows
--   Topps Series 2 Baseball    ~29 rows
--
-- Conversion rules:
--   label   = name + " /" + print_run  (if print_run is not null)
--           = name                     (if print_run is null)
--   ebay_kw = name
--
-- A {"label":"Base","ebay_kw":""} entry is prepended to every
-- converted non-empty array so users can select the base card.
--
-- Rows with [] (empty array) are already correct — not touched.
-- =============================================================================

UPDATE card_sets
SET parallels =
  '[{"label":"Base","ebay_kw":""}]'::jsonb ||
  (
    SELECT jsonb_agg(
      jsonb_build_object(
        'label',
        CASE
          WHEN elem->>'print_run' IS NOT NULL
            THEN (elem->>'name') || ' /' || (elem->>'print_run')
          ELSE elem->>'name'
        END,
        'ebay_kw', elem->>'name'
      )
    )
    FROM jsonb_array_elements(parallels) AS elem
  )
WHERE parallels::text LIKE '%"name"%'
  AND parallels::text NOT LIKE '%"label"%'
  AND jsonb_array_length(parallels) > 0;
