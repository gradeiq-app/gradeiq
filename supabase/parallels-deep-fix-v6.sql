-- =====================================================================
-- parallels-deep-fix-v6.sql
-- National Treasures Football 2022/2023/2025 — real NFL NT structures
-- National Treasures Rookie Patch Auto Football 2022/2023/2024 — fix
-- Donruss Football 2022-2025 — fix from basketball structure to football structure
-- =====================================================================

-- ===================================================================
-- 1. NT FOOTBALL year=2022 (2022 NFL season)
-- Real structure: Purple /49, Emerald /10 base; RPA starts at /99
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Jersey Number Red /99","ebay_kw":"NT Jersey Number Red"},
  {"label":"Purple /49","ebay_kw":"NT Purple"},
  {"label":"Gold /35","ebay_kw":"NT Gold"},
  {"label":"Holo Silver /25","ebay_kw":"NT Holo Silver"},
  {"label":"Midnight /20","ebay_kw":"NT Midnight"},
  {"label":"Holo Gold /15","ebay_kw":"NT Holo Gold"},
  {"label":"Stars and Stripes /13","ebay_kw":"NT Stars Stripes"},
  {"label":"Emerald /10","ebay_kw":"NT Emerald"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /99","ebay_kw":"NT RPA"},
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
  AND year = 2022;

-- ===================================================================
-- 2. NT FOOTBALL year=2023 (2023 NFL season)
-- Real structure: Same base as 2022 (Purple /49, Emerald /10)
-- RPA: adds Green Jersey /98, Red Brand Logo /1, Red Laundry Tag /1
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Jersey Number Red /99","ebay_kw":"NT Jersey Number Red"},
  {"label":"Purple /49","ebay_kw":"NT Purple"},
  {"label":"Gold /35","ebay_kw":"NT Gold"},
  {"label":"Holo Silver /25","ebay_kw":"NT Holo Silver"},
  {"label":"Midnight /20","ebay_kw":"NT Midnight"},
  {"label":"Holo Gold /15","ebay_kw":"NT Holo Gold"},
  {"label":"Stars and Stripes /13","ebay_kw":"NT Stars Stripes"},
  {"label":"Emerald /10","ebay_kw":"NT Emerald"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Green Jersey /98","ebay_kw":"NT RPA Green Jersey"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"},
  {"label":"RPA Red Brand Logo /1","ebay_kw":"NT RPA Red Brand Logo"},
  {"label":"RPA Red Laundry Tag /1","ebay_kw":"NT RPA Red Laundry Tag"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'football'
  AND year = 2023;

-- ===================================================================
-- 3. NT FOOTBALL year=2025 (2025 NFL season)
-- Massive RPA expansion with Stars & Stripes variants
-- Base: Purple /75 (up from /49), Jersey Number Red /18 (new)
-- RPA: 20+ parallels including S&S Holo Silver, Premium, Midnight variants
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"NT"},
  {"label":"Purple /75","ebay_kw":"NT Purple"},
  {"label":"Gold /35","ebay_kw":"NT Gold"},
  {"label":"Holo Silver /25","ebay_kw":"NT Holo Silver"},
  {"label":"Midnight /20","ebay_kw":"NT Midnight"},
  {"label":"Jersey Number Red /18","ebay_kw":"NT Jersey Number Red"},
  {"label":"Holo Gold /15","ebay_kw":"NT Holo Gold"},
  {"label":"Stars and Stripes /13","ebay_kw":"NT Stars Stripes"},
  {"label":"Emerald /10","ebay_kw":"NT Emerald"},
  {"label":"Platinum /1","ebay_kw":"NT Platinum"},
  {"label":"Printing Plate /1","ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99","ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10","ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1","ebay_kw":"NT Signature Black"},
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Green Jersey /98","ebay_kw":"NT RPA Green Jersey"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Premium /35","ebay_kw":"NT RPA Premium"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Stars and Stripes Holo Silver /25","ebay_kw":"NT RPA Stars Stripes Holo Silver"},
  {"label":"RPA Midnight /20","ebay_kw":"NT RPA Midnight"},
  {"label":"RPA Stars and Stripes Premium /13","ebay_kw":"NT RPA Stars Stripes Premium"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Premium Gold /10","ebay_kw":"NT RPA Premium Gold"},
  {"label":"RPA Stars and Stripes Blue /10","ebay_kw":"NT RPA Stars Stripes Blue"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Red Brand Logo /2","ebay_kw":"NT RPA Red Brand Logo"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"},
  {"label":"RPA Premium Gold Vinyl /1","ebay_kw":"NT RPA Premium Gold Vinyl"},
  {"label":"RPA Red /1","ebay_kw":"NT RPA Red"},
  {"label":"Dual RPA","ebay_kw":"NT Dual RPA"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures'
  AND sport = 'football'
  AND year = 2025;

-- ===================================================================
-- 4. NT ROOKIE PATCH AUTO FOOTBALL year=2022
-- Fix: Was "RPA Holo Silver /49, Platinum /5" (wrong for NFL NT)
-- Real 2022 NFL RPA structure
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"},
  {"label":"RPA Red /1","ebay_kw":"NT RPA Red"},
  {"label":"RPA Printing Plate /1","ebay_kw":"NT RPA Printing Plate"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football'
  AND year = 2022;

-- ===================================================================
-- 5. NT ROOKIE PATCH AUTO FOOTBALL year=2023
-- Real 2023 NFL RPA: adds Green Jersey /98, Red Brand Logo, Laundry Tag
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"RPA /99","ebay_kw":"NT RPA"},
  {"label":"RPA Green Jersey /98","ebay_kw":"NT RPA Green Jersey"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"},
  {"label":"RPA Red /1","ebay_kw":"NT RPA Red"},
  {"label":"RPA Red Brand Logo /1","ebay_kw":"NT RPA Red Brand Logo"},
  {"label":"RPA Red Laundry Tag /1","ebay_kw":"NT RPA Red Laundry Tag"},
  {"label":"RPA Printing Plate /1","ebay_kw":"NT RPA Printing Plate"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football'
  AND year = 2023;

-- ===================================================================
-- 6. NT ROOKIE PATCH AUTO FOOTBALL year=2024
-- Real 2024 NFL RPA: base starts at /25 (not /99!)
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"RPA /25","ebay_kw":"NT RPA"},
  {"label":"RPA Green Jersey /97","ebay_kw":"NT RPA Green Jersey"},
  {"label":"RPA Purple /49","ebay_kw":"NT RPA Purple"},
  {"label":"RPA Holo Silver /25","ebay_kw":"NT RPA Holo Silver"},
  {"label":"RPA Holo Gold /10","ebay_kw":"NT RPA Holo Gold"},
  {"label":"RPA Black /5","ebay_kw":"NT RPA Black"},
  {"label":"RPA Platinum Shield /1","ebay_kw":"NT RPA Platinum Shield"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'National Treasures Rookie Patch Auto'
  AND sport = 'football'
  AND year = 2024;

-- ===================================================================
-- 7. DONRUSS FOOTBALL years 2022-2023 (brand=Panini, set_name=Donruss)
-- Fix: Was using BASKETBALL structure (Holo Laser /149, Checkerboard /49!)
-- Real football Donruss: Press Proof structure, Season Stat Line /500
-- No laser/holo/choice variants — those are basketball-only
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"Press Proof Blue","ebay_kw":"Donruss Press Proof Blue"},
  {"label":"Press Proof Green","ebay_kw":"Donruss Press Proof Green"},
  {"label":"Press Proof Red","ebay_kw":"Donruss Press Proof Red"},
  {"label":"Press Proof Yellow","ebay_kw":"Donruss Press Proof Yellow"},
  {"label":"Aqueous Test","ebay_kw":"Donruss Aqueous Test"},
  {"label":"Canvas","ebay_kw":"Donruss Canvas"},
  {"label":"Season Stat Line /500","ebay_kw":"Donruss Season Stat Line"},
  {"label":"Press Proof Silver /100","ebay_kw":"Donruss Press Proof Silver 100"},
  {"label":"Jersey Number /99","ebay_kw":"Donruss Jersey Number"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Press Proof Gold /50","ebay_kw":"Donruss Press Proof Gold"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Press Proof Black /10","ebay_kw":"Donruss Press Proof Black"},
  {"label":"Press Proof Black Die-Cut /1","ebay_kw":"Donruss Press Proof Black Die-Cut"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Blue","ebay_kw":"Donruss Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Orange","ebay_kw":"Donruss Rated Rookie Auto Orange"},
  {"label":"Rated Rookie Auto Gold /25","ebay_kw":"Donruss Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /10","ebay_kw":"Donruss Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'Donruss'
  AND sport = 'football'
  AND year IN (2022, 2023);

-- ===================================================================
-- 8. DONRUSS FOOTBALL year=2024 (brand=Panini, set_name=Donruss)
-- Confirmed 2024 NFL Donruss structure: Silver /100, Die-Cut /75
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"Press Proof Blue","ebay_kw":"Donruss Press Proof Blue"},
  {"label":"Press Proof Green","ebay_kw":"Donruss Press Proof Green"},
  {"label":"Press Proof Red","ebay_kw":"Donruss Press Proof Red"},
  {"label":"Press Proof Yellow","ebay_kw":"Donruss Press Proof Yellow"},
  {"label":"Aqueous Test","ebay_kw":"Donruss Aqueous Test"},
  {"label":"Canvas","ebay_kw":"Donruss Canvas"},
  {"label":"Season Stat Line /500","ebay_kw":"Donruss Season Stat Line"},
  {"label":"Press Proof Silver /100","ebay_kw":"Donruss Press Proof Silver 100"},
  {"label":"Jersey Number /99","ebay_kw":"Donruss Jersey Number"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Press Proof Gold /50","ebay_kw":"Donruss Press Proof Gold"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Press Proof Black /10","ebay_kw":"Donruss Press Proof Black"},
  {"label":"Press Proof Black Die-Cut /1","ebay_kw":"Donruss Press Proof Black Die-Cut"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Blue","ebay_kw":"Donruss Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Orange","ebay_kw":"Donruss Rated Rookie Auto Orange"},
  {"label":"Rated Rookie Auto Purple /150","ebay_kw":"Donruss Rated Rookie Auto Purple"},
  {"label":"Rated Rookie Auto Gold /25","ebay_kw":"Donruss Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /10","ebay_kw":"Donruss Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'Donruss'
  AND sport = 'football'
  AND year = 2024;

-- ===================================================================
-- 9. DONRUSS FOOTBALL year=2025 (brand=Panini, set_name=Donruss)
-- 2025 NFL Donruss: Silver is /199 (up from /100), Die-Cut /99 (up from /75)
-- ===================================================================
UPDATE card_sets
SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"Press Proof Blue","ebay_kw":"Donruss Press Proof Blue"},
  {"label":"Press Proof Green","ebay_kw":"Donruss Press Proof Green"},
  {"label":"Press Proof Purple","ebay_kw":"Donruss Press Proof Purple"},
  {"label":"Press Proof Red","ebay_kw":"Donruss Press Proof Red"},
  {"label":"Press Proof Yellow","ebay_kw":"Donruss Press Proof Yellow"},
  {"label":"Aqueous Test","ebay_kw":"Donruss Aqueous Test"},
  {"label":"Canvas","ebay_kw":"Donruss Canvas"},
  {"label":"Season Stat Line /500","ebay_kw":"Donruss Season Stat Line"},
  {"label":"Press Proof Silver /199","ebay_kw":"Donruss Press Proof Silver 199"},
  {"label":"Jersey Number /99","ebay_kw":"Donruss Jersey Number"},
  {"label":"Press Proof Silver Die-Cut /99","ebay_kw":"Donruss Press Proof Silver Die-Cut"},
  {"label":"Press Proof Gold /50","ebay_kw":"Donruss Press Proof Gold"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut"},
  {"label":"Press Proof Black /10","ebay_kw":"Donruss Press Proof Black"},
  {"label":"Press Proof Black Die-Cut /1","ebay_kw":"Donruss Press Proof Black Die-Cut"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Blue","ebay_kw":"Donruss Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Gold /25","ebay_kw":"Donruss Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /10","ebay_kw":"Donruss Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini'
  AND set_name = 'Donruss'
  AND sport = 'football'
  AND year = 2025;
