-- sets-cleanup-v01.sql
--
-- Cleans up two classes of seeding artifacts in the `sets` table:
--
--   1. Sets literally named after a sport ("Basketball", "Football",
--      "Baseball", "Hockey", "Soccer", "WNBA"). These were created by
--      early roster-seeding scripts as placeholders and contain only
--      stub cards (player_id set, card_number NULL, no parallels).
--      Real sets always have a brand-specific name (e.g. "Topps Series 1",
--      "Panini Prizm", "NBA Hoops"). Cascade-deletes the stub cards.
--
--   2. NBA Hoops mis-attributed to Topps. NBA Hoops is a Panini product;
--      reassign the 2024 + 2025 rows to the Panini manufacturer.

BEGIN;

-- ── 1. Generic sport-name sets ────────────────────────────────────────────
-- FK cards.set_id → sets.id is ON DELETE CASCADE, so cards in these
-- placeholder sets are removed automatically.
DELETE FROM sets
WHERE name IN ('Basketball', 'Football', 'Baseball', 'Hockey', 'Soccer', 'WNBA');

-- ── 2. NBA Hoops: Topps → Panini ──────────────────────────────────────────
UPDATE sets
SET manufacturer_id = (SELECT id FROM manufacturers WHERE name = 'Panini')
WHERE name = 'NBA Hoops'
  AND manufacturer_id = (SELECT id FROM manufacturers WHERE name = 'Topps');

COMMIT;
