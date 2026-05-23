-- =====================================================================
-- parallels-deep-fix-v5.sql
-- National Treasures Basketball 2022-2024 (FOTL + new base structure)
-- National Treasures Football 2024 (completely different 2024 NFL structure)
-- Donruss Basketball 2024-25 expanded parallel rainbow
-- Donruss Basketball 2025-26 (brand=Donruss fix)
-- =====================================================================

-- ===================================================================
-- 1. NT BASKETBALL year=2022 (2022-23 season)
-- Fix: Add FOTL variants to RPA section
-- Real: Gold FOTL /24, Purple FOTL /8, Blue FOTL /3
-- Note: 2022-23 does NOT have RPA Orange /75 — starts at Bronze /49
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Holo Silver /99","ebay_kw":"NT Holo Silver"},
  {"label":"Holo Gold /25","ebay_kw":"NT Holo Gold"},
  {"label":"Holo Black /5","ebay_kw":"NT Holo Black"},
  {"label":"Logoman /1","ebay_kw":"NT Logoman"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Bronze /49","ebay_kw":"NT RPA Bronze"},
  {"label":"RPA Pink /25","ebay_kw":"NT RPA Pink"},
  {"label":"RPA Gold FOTL /24","ebay_kw":"NT RPA Gold FOTL"},
  {"label":"RPA Gold /10","ebay_kw":"NT RPA Gold"},
  {"label":"RPA Purple FOTL /8","ebay_kw":"NT RPA Purple FOTL"},
  {"label":"RPA Emerald /5","ebay_kw":"NT RPA Emerald"},
  {"label":"RPA Blue FOTL /3","ebay_kw":"NT RPA Blue FOTL"},
  {"label":"RPA Logoman /1","ebay_kw":"NT RPA Logoman"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"},
  {"label":"Shield /1","ebay_kw":"NT Shield"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'basketball'
  AND year = 2022;

-- ===================================================================
-- 2. NT BASKETBALL year=2023 (2023-24 season)
-- Fix: New base card structure (no Holo Silver/Gold/Black)
--      New base parallels: International /33, Pink /15, Gold /10, etc.
-- Fix: RPA adds International /24, International Red /8, FOTL variants
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"International /33","ebay_kw":"NT International"},
  {"label":"Pink /15","ebay_kw":"NT Pink"},
  {"label":"Gold /10","ebay_kw":"NT Gold"},
  {"label":"International Red /8","ebay_kw":"NT International Red"},
  {"label":"Emerald /5","ebay_kw":"NT Emerald"},
  {"label":"Amethyst /3","ebay_kw":"NT Amethyst"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA Orange /75","ebay_kw":"NT RPA Orange"},
  {"label":"RPA Bronze /49","ebay_kw":"NT RPA Bronze"},
  {"label":"RPA Pink /25","ebay_kw":"NT RPA Pink"},
  {"label":"RPA International /24","ebay_kw":"NT RPA International"},
  {"label":"RPA Gold /10","ebay_kw":"NT RPA Gold"},
  {"label":"RPA International Red /8","ebay_kw":"NT RPA International Red"},
  {"label":"RPA Emerald /5","ebay_kw":"NT RPA Emerald"},
  {"label":"RPA Gold FOTL /15","ebay_kw":"NT RPA Gold FOTL"},
  {"label":"RPA Purple FOTL /5","ebay_kw":"NT RPA Purple FOTL"},
  {"label":"RPA Black /3","ebay_kw":"NT RPA Black"},
  {"label":"RPA Blue FOTL /3","ebay_kw":"NT RPA Blue FOTL"},
  {"label":"RPA Logoman /1","ebay_kw":"NT RPA Logoman"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"},
  {"label":"Shield /1","ebay_kw":"NT Shield"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'basketball'
  AND year = 2023;

-- ===================================================================
-- 3. NT BASKETBALL year=2024 (2024-25 season)
-- Complete rebuild — new base card structure + expanded FOTL RPA
-- Base: Royal /25, International /24, Pink /15, Gold /10, Int Red /8, Emerald /5, Amethyst /3, Platinum /1
-- RPA: /99, Orange /75, Bronze /49, Pink /25, International /24,
--      Gold FOTL /20, Gold /10, Int Red /8, Emerald /5, Purple FOTL /5,
--      Black /3, Blue FOTL /3, Logoman /1
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Royal /25","ebay_kw":"NT Royal"},
  {"label":"International /24","ebay_kw":"NT International"},
  {"label":"Pink /15","ebay_kw":"NT Pink"},
  {"label":"Gold /10","ebay_kw":"NT Gold"},
  {"label":"International Red /8","ebay_kw":"NT International Red"},
  {"label":"Emerald /5","ebay_kw":"NT Emerald"},
  {"label":"Amethyst /3","ebay_kw":"NT Amethyst"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Orange /75","ebay_kw":"NT RPA Orange"},
  {"label":"RPA Bronze /49","ebay_kw":"NT RPA Bronze"},
  {"label":"RPA Pink /25","ebay_kw":"NT RPA Pink"},
  {"label":"RPA International /24","ebay_kw":"NT RPA International"},
  {"label":"RPA Gold FOTL /20","ebay_kw":"NT RPA Gold FOTL"},
  {"label":"RPA Gold /10","ebay_kw":"NT RPA Gold"},
  {"label":"RPA International Red /8","ebay_kw":"NT RPA International Red"},
  {"label":"RPA Emerald /5","ebay_kw":"NT RPA Emerald"},
  {"label":"RPA Purple FOTL /5","ebay_kw":"NT RPA Purple FOTL"},
  {"label":"RPA Black /3","ebay_kw":"NT RPA Black"},
  {"label":"RPA Blue FOTL /3","ebay_kw":"NT RPA Blue FOTL"},
  {"label":"RPA Logoman /1","ebay_kw":"NT RPA Logoman"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"},
  {"label":"Shield /1","ebay_kw":"NT Shield"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'basketball'
  AND year = 2024;

-- ===================================================================
-- 4. NT FOOTBALL year=2024 (2024 NFL season)
-- Complete rebuild — real 2024 NFL NT structure is completely different
-- from old "Holo Silver /99, Holo Gold /25, Holo Black /5"
-- Real base: Jersey Number Red /99, Purple /75, Gold /35, Holo Silver /25,
--            Midnight /20, Holo Gold /15, Stars & Stripes /13, Premium Gold /10, Platinum /1
-- Real RPA: Base /25, Green Jersey /97, Purple /49, Holo Silver /25,
--           Holo Gold /10, Black /5, Platinum Shield /1
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Jersey Number Red /99","ebay_kw":"NT Jersey Number Red"},
  {"label":"Purple /75","ebay_kw":"NT Purple"},
  {"label":"Gold /35","ebay_kw":"NT Gold"},
  {"label":"Holo Silver /25","ebay_kw":"NT Holo Silver"},
  {"label":"Midnight /20","ebay_kw":"NT Midnight"},
  {"label":"Holo Gold /15","ebay_kw":"NT Holo Gold"},
  {"label":"Stars and Stripes /13","ebay_kw":"NT Stars Stripes"},
  {"label":"Premium Gold /10","ebay_kw":"NT Premium Gold"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /25","ebay_kw":"NT RPA"},
  {"label":"RPA Green Jersey /97","ebay_kw":"NT RPA Green Jersey"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'football'
  AND year = 2024;

-- ===================================================================
-- 5. DONRUSS BASKETBALL 2024-25 (brand=Panini, set_name=Donruss, year=2024)
-- 2024-25 product massively expanded the parallel rainbow
-- From old 17-parallel Press Proof structure to 40+ named variants
-- Includes Choice, Holo Laser, Crystals, Dots, Explosion, Lava, Swirlorama
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"International","ebay_kw":"Donruss International"},
  {"label":"Storm /299","ebay_kw":"Donruss Storm"},
  {"label":"Press Proof Purple /199","ebay_kw":"Donruss Press Proof Purple"},
  {"label":"Holo Laser /149","ebay_kw":"Donruss Holo Laser"},
  {"label":"Teal Explosion /149","ebay_kw":"Donruss Teal Explosion"},
  {"label":"Crystals /125","ebay_kw":"Donruss Crystals"},
  {"label":"Holo Orange Laser /125","ebay_kw":"Donruss Holo Orange Laser"},
  {"label":"Hyper /125","ebay_kw":"Donruss Hyper"},
  {"label":"Choice Red /99","ebay_kw":"Donruss Choice Red"},
  {"label":"Holo Red Laser /99","ebay_kw":"Donruss Holo Red Laser"},
  {"label":"Dots /85","ebay_kw":"Donruss Dots"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Holo Pink Laser /50","ebay_kw":"Donruss Holo Pink Laser"},
  {"label":"Checkerboard /49","ebay_kw":"Donruss Checkerboard"},
  {"label":"Choice Blue /49","ebay_kw":"Donruss Choice Blue"},
  {"label":"Holo Blue Laser /49","ebay_kw":"Donruss Holo Blue Laser"},
  {"label":"Blue Explosion /45","ebay_kw":"Donruss Blue Explosion"},
  {"label":"Holo Blue & Green Laser /30","ebay_kw":"Donruss Holo Blue Green Laser"},
  {"label":"Holo Teal Laser /25","ebay_kw":"Donruss Holo Teal Laser"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Lava /15","ebay_kw":"Donruss Lava"},
  {"label":"Choice Gold /10","ebay_kw":"Donruss Choice Gold"},
  {"label":"Holo Gold Laser /10","ebay_kw":"Donruss Holo Gold Laser"},
  {"label":"Choice Black Gold /8","ebay_kw":"Donruss Choice Black Gold"},
  {"label":"International Green Scope /5","ebay_kw":"Donruss International Green Scope"},
  {"label":"Swirlorama /5","ebay_kw":"Donruss Swirlorama"},
  {"label":"Holo Black Laser /1","ebay_kw":"Donruss Holo Black Laser"},
  {"label":"Choice Black /1","ebay_kw":"Donruss Choice Black"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Choice Red /99","ebay_kw":"Donruss Rated Rookie Auto Choice Red"},
  {"label":"Rated Rookie Auto Holo Laser /99","ebay_kw":"Donruss Rated Rookie Auto Holo Laser"},
  {"label":"Rated Rookie Auto Holo Frame /75","ebay_kw":"Donruss Rated Rookie Auto Holo Frame"},
  {"label":"Rated Rookie Auto Choice Blue /49","ebay_kw":"Donruss Rated Rookie Auto Choice Blue"},
  {"label":"Rated Rookie Auto Holo Red Laser /49","ebay_kw":"Donruss Rated Rookie Auto Holo Red Laser"},
  {"label":"Rated Rookie Auto Holo Purple Laser /30","ebay_kw":"Donruss Rated Rookie Auto Holo Purple Laser"},
  {"label":"Rated Rookie Auto Holo Blue Laser /25","ebay_kw":"Donruss Rated Rookie Auto Holo Blue Laser"},
  {"label":"Rated Rookie Auto Holo Yellow Laser /15","ebay_kw":"Donruss Rated Rookie Auto Holo Yellow Laser"},
  {"label":"Rated Rookie Auto Choice Gold /10","ebay_kw":"Donruss Rated Rookie Auto Choice Gold"},
  {"label":"Rated Rookie Auto Holo Gold Laser /10","ebay_kw":"Donruss Rated Rookie Auto Holo Gold Laser"},
  {"label":"Rated Rookie Auto Choice Black Gold /8","ebay_kw":"Donruss Rated Rookie Auto Choice Black Gold"},
  {"label":"Rated Rookie Auto International Green Scope /5","ebay_kw":"Donruss Rated Rookie Auto International Green Scope"},
  {"label":"Rated Rookie Auto Choice Black /1","ebay_kw":"Donruss Rated Rookie Auto Choice Black"},
  {"label":"Rated Rookie Auto Holo Black Laser /1","ebay_kw":"Donruss Rated Rookie Auto Holo Black Laser"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'Donruss'
  AND sport = 'basketball'
  AND year = 2024;

-- ===================================================================
-- 6. DONRUSS BASKETBALL 2025-26 (brand=Panini, set_name=Donruss, year=2025)
-- 2025-26 has new structure: Diamond Red /75, Holo Blue Laser /49, Hyper /125
-- Press Proof Purple /199 still present, Holo Black Laser /1 is rarest
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"International","ebay_kw":"Donruss International"},
  {"label":"Press Proof Purple /199","ebay_kw":"Donruss Press Proof Purple"},
  {"label":"Hyper /125","ebay_kw":"Donruss Hyper"},
  {"label":"Diamond Red /75","ebay_kw":"Donruss Diamond Red"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Holo Blue Laser /49","ebay_kw":"Donruss Holo Blue Laser"},
  {"label":"Checkerboard /49","ebay_kw":"Donruss Checkerboard"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Holo Gold Laser /10","ebay_kw":"Donruss Holo Gold Laser"},
  {"label":"Press Proof Gold /10","ebay_kw":"Donruss Press Proof Gold"},
  {"label":"Holo Black Laser /1","ebay_kw":"Donruss Holo Black Laser"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Holo Gold Laser /10","ebay_kw":"Donruss Rated Rookie Auto Holo Gold Laser"},
  {"label":"Rated Rookie Auto Holo Black Laser /1","ebay_kw":"Donruss Rated Rookie Auto Holo Black Laser"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'Donruss'
  AND sport = 'basketball'
  AND year = 2025;

-- ===================================================================
-- 7. DONRUSS BASKETBALL brand=Donruss, set_name=Basketball, year=2025
-- This entry has wrong parallels (Press Proof /99, Blue /149, Red /99, etc.)
-- Fix to represent 2025-26 Donruss Basketball properly
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"International","ebay_kw":"Donruss International"},
  {"label":"Press Proof Purple /199","ebay_kw":"Donruss Press Proof Purple"},
  {"label":"Hyper /125","ebay_kw":"Donruss Hyper"},
  {"label":"Diamond Red /75","ebay_kw":"Donruss Diamond Red"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Holo Blue Laser /49","ebay_kw":"Donruss Holo Blue Laser"},
  {"label":"Checkerboard /49","ebay_kw":"Donruss Checkerboard"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Holo Gold Laser /10","ebay_kw":"Donruss Holo Gold Laser"},
  {"label":"Press Proof Gold /10","ebay_kw":"Donruss Press Proof Gold"},
  {"label":"Holo Black Laser /1","ebay_kw":"Donruss Holo Black Laser"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Holo Gold Laser /10","ebay_kw":"Donruss Rated Rookie Auto Holo Gold Laser"},
  {"label":"Rated Rookie Auto Holo Black Laser /1","ebay_kw":"Donruss Rated Rookie Auto Holo Black Laser"}
]'::jsonb
WHERE brand = 'Donruss'
  AND set_name = 'Basketball'
  AND sport = 'basketball'
  AND year = 2025;
