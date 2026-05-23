-- ============================================================
-- parallels-deep-fix-v2.sql
-- Deep-dive parallel accuracy fixes (round 2)
-- Verified against: ChecklistInsider, Beckett, CardboardConnection, TCDB
-- ============================================================

-- ============================================================
-- 1. BOWMAN CHROME PROSPECT AUTO (all years)
--    Current: only 7 parallels, wrong order, missing ~5 variants
--    Fix: Full refractor rainbow in correct print-run order
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base Auto","ebay_kw":"Bowman Chrome Prospect Auto"},
  {"label":"Refractor /499","ebay_kw":"Prospect Auto Refractor 499"},
  {"label":"Speckle Refractor /299","ebay_kw":"Prospect Auto Speckle 299"},
  {"label":"Purple Refractor /250","ebay_kw":"Prospect Auto Purple Refractor 250"},
  {"label":"Blue Refractor /150","ebay_kw":"Prospect Auto Blue Refractor 150"},
  {"label":"Green Refractor /99","ebay_kw":"Prospect Auto Green Refractor 99"},
  {"label":"Yellow Refractor /75","ebay_kw":"Prospect Auto Yellow Refractor 75"},
  {"label":"Gold Refractor /50","ebay_kw":"Prospect Auto Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Prospect Auto Orange Refractor 25"},
  {"label":"Black Refractor /10","ebay_kw":"Prospect Auto Black Refractor 10"},
  {"label":"Red Refractor /5","ebay_kw":"Prospect Auto Red Refractor 5"},
  {"label":"SuperFractor /1","ebay_kw":"Prospect Auto SuperFractor 1"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome Prospect Auto' AND sport = 'baseball';

-- ============================================================
-- 2. UPPER DECK O-PEE-CHEE PLATINUM HOCKEY (all years)
--    Current: uses Retro subset parallels (Blue Luster /100,
--    Houndstooth /15) — completely wrong for main base card set
--    Fix: Real 2024-25 parallel structure verified from checklist
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"OPC Platinum Hockey Base"},
  {"label":"Neon Yellow Surge","ebay_kw":"OPC Platinum Neon Yellow Surge"},
  {"label":"Rainbow","ebay_kw":"OPC Platinum Rainbow"},
  {"label":"Sunset","ebay_kw":"OPC Platinum Sunset"},
  {"label":"Pink Magma","ebay_kw":"OPC Platinum Pink Magma"},
  {"label":"Violet Pixels /299","ebay_kw":"OPC Platinum Violet Pixels 299"},
  {"label":"Red Prism /199","ebay_kw":"OPC Platinum Red Prism 199"},
  {"label":"Blue Fragments /125","ebay_kw":"OPC Platinum Blue Fragments 125"},
  {"label":"Arctic Freeze /99","ebay_kw":"OPC Platinum Arctic Freeze 99"},
  {"label":"Cosmic /65","ebay_kw":"OPC Platinum Cosmic 65"},
  {"label":"Seismic Gold /50","ebay_kw":"OPC Platinum Seismic Gold 50"},
  {"label":"Orange Checkers /25","ebay_kw":"OPC Platinum Orange Checkers 25"},
  {"label":"Emerald Surge /10","ebay_kw":"OPC Platinum Emerald Surge 10"},
  {"label":"Bioluminescence /5","ebay_kw":"OPC Platinum Bioluminescence 5"},
  {"label":"Golden Treasures /1","ebay_kw":"OPC Platinum Golden Treasures 1"},
  {"label":"Marquee Rookies","ebay_kw":"OPC Platinum Marquee Rookies"},
  {"label":"Rookie Auto","ebay_kw":"OPC Platinum Rookie Auto"},
  {"label":"Rookie Auto Rainbow","ebay_kw":"OPC Platinum Rookie Auto Rainbow"},
  {"label":"Rookie Auto Violet Pixels /65","ebay_kw":"OPC Platinum Rookie Auto Violet Pixels 65"},
  {"label":"Rookie Auto Cosmic /50","ebay_kw":"OPC Platinum Rookie Auto Cosmic 50"},
  {"label":"Rookie Auto Red Prism /30","ebay_kw":"OPC Platinum Rookie Auto Red Prism 30"},
  {"label":"Rookie Auto Seismic Gold /25","ebay_kw":"OPC Platinum Rookie Auto Seismic Gold 25"},
  {"label":"Rookie Auto Orange Checkers /15","ebay_kw":"OPC Platinum Rookie Auto Orange Checkers 15"},
  {"label":"Rookie Auto Emerald Surge /10","ebay_kw":"OPC Platinum Rookie Auto Emerald Surge 10"},
  {"label":"Rookie Auto Golden Treasures /1","ebay_kw":"OPC Platinum Rookie Auto Golden Treasures 1"},
  {"label":"Retro Rainbow","ebay_kw":"OPC Platinum Retro Rainbow"},
  {"label":"Retro Blue Luster /100","ebay_kw":"OPC Platinum Retro Blue Luster 100"},
  {"label":"Retro Houndstooth /15","ebay_kw":"OPC Platinum Retro Houndstooth 15"},
  {"label":"Retro Golden Treasures /1","ebay_kw":"OPC Platinum Retro Golden Treasures 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee Platinum' AND sport = 'hockey';

-- ============================================================
-- 3. TOPPS CHROME BASEBALL (all years)
--    Current errors: "Pink Refractor /199" (Pink is unlim; /199=Aqua),
--    "Blue Wave Refractor /150" (Blue Wave=/75, Blue=/150),
--    "Speckle Refractor /299" (should be Purple Speckle /299)
--    Fix: Correct print runs + add missing Aqua/Purple variants
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Chrome Baseball"},
  {"label":"Refractor","ebay_kw":"Topps Chrome Refractor"},
  {"label":"Prism Refractor","ebay_kw":"Topps Chrome Prism Refractor"},
  {"label":"X-Fractor","ebay_kw":"Topps Chrome X-Fractor"},
  {"label":"Sepia Refractor","ebay_kw":"Topps Chrome Sepia Refractor"},
  {"label":"Negative Refractor","ebay_kw":"Topps Chrome Negative Refractor"},
  {"label":"Pink Refractor","ebay_kw":"Topps Chrome Pink Refractor"},
  {"label":"Magenta Speckle /350","ebay_kw":"Topps Chrome Magenta Speckle 350"},
  {"label":"Purple Speckle /299","ebay_kw":"Topps Chrome Purple Speckle 299"},
  {"label":"Purple Refractor /250","ebay_kw":"Topps Chrome Purple Refractor 250"},
  {"label":"Aqua Refractor /199","ebay_kw":"Topps Chrome Aqua Refractor 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Topps Chrome Blue Refractor 150"},
  {"label":"Blue Sonar /125","ebay_kw":"Topps Chrome Blue Sonar 125"},
  {"label":"Green Refractor /99","ebay_kw":"Topps Chrome Green Refractor 99"},
  {"label":"Blue Wave /75","ebay_kw":"Topps Chrome Blue Wave 75"},
  {"label":"Gold Refractor /50","ebay_kw":"Topps Chrome Gold Refractor 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Topps Chrome Orange Refractor 25"},
  {"label":"Black Refractor /10","ebay_kw":"Topps Chrome Black Refractor 10"},
  {"label":"Red Refractor /5","ebay_kw":"Topps Chrome Red Refractor 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Chrome SuperFractor 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Chrome Printing Plate"},
  {"label":"RC Auto","ebay_kw":"Topps Chrome Rookie Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"Topps Chrome Rookie Auto Refractor"},
  {"label":"RC Auto Blue /150","ebay_kw":"Topps Chrome Rookie Auto Blue 150"},
  {"label":"RC Auto Gold /50","ebay_kw":"Topps Chrome Rookie Auto Gold 50"},
  {"label":"RC Auto Orange /25","ebay_kw":"Topps Chrome Rookie Auto Orange 25"},
  {"label":"RC Auto Red /5","ebay_kw":"Topps Chrome Rookie Auto Red 5"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"Topps Chrome Rookie Auto SuperFractor 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'baseball';

-- ============================================================
-- 4. TOPPS SERIES 1 BASEBALL (all years)
--    Current errors: "Blue /150" (real=/999), "Purple /50" (real=/799),
--    "Sky Blue /99" (doesn't exist - should be Vintage Stock /99)
--    Fix: Correct Holofoil/Crackle parallel names + print runs
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Series 1 Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Series 1 Short Print SP"},
  {"label":"Image Variation SP","ebay_kw":"Topps Series 1 Image Variation"},
  {"label":"Gold Foil","ebay_kw":"Topps Series 1 Gold Foil"},
  {"label":"Rainbow Foil","ebay_kw":"Topps Series 1 Rainbow Foil"},
  {"label":"Gold /2024","ebay_kw":"Topps Series 1 Gold 2024"},
  {"label":"Blue Holofoil /999","ebay_kw":"Topps Series 1 Blue Holofoil 999"},
  {"label":"Purple Holofoil /799","ebay_kw":"Topps Series 1 Purple Holofoil 799"},
  {"label":"Green Crackle /499","ebay_kw":"Topps Series 1 Green Crackle 499"},
  {"label":"Orange Crackle /299","ebay_kw":"Topps Series 1 Orange Crackle 299"},
  {"label":"Red Crackle /199","ebay_kw":"Topps Series 1 Red Crackle 199"},
  {"label":"Vintage Stock /99","ebay_kw":"Topps Series 1 Vintage Stock 99"},
  {"label":"Independence Day /76","ebay_kw":"Topps Series 1 Independence Day 76"},
  {"label":"Black /73","ebay_kw":"Topps Series 1 Black 73"},
  {"label":"Yellow Crackle /50","ebay_kw":"Topps Series 1 Yellow Crackle 50"},
  {"label":"Father Day Powder Blue /50","ebay_kw":"Topps Series 1 Father Day Powder Blue 50"},
  {"label":"Mother Day Hot Pink /50","ebay_kw":"Topps Series 1 Mother Day Hot Pink 50"},
  {"label":"Memorial Day Camo /25","ebay_kw":"Topps Series 1 Memorial Day Camo 25"},
  {"label":"Clear /10","ebay_kw":"Topps Series 1 Clear 10"},
  {"label":"Platinum /1","ebay_kw":"Topps Series 1 Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Series 1 Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Series 1 Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Series 1 Autograph Gold 50"},
  {"label":"Autograph Red /25","ebay_kw":"Topps Series 1 Autograph Red 25"},
  {"label":"Autograph Black /1","ebay_kw":"Topps Series 1 Autograph Black 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1' AND sport = 'baseball';

-- ============================================================
-- 5. TOPPS SERIES 2 BASEBALL (all years)
--    Same print run issues as Series 1
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Series 2 Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Series 2 Short Print SP"},
  {"label":"Image Variation SP","ebay_kw":"Topps Series 2 Image Variation"},
  {"label":"Gold Foil","ebay_kw":"Topps Series 2 Gold Foil"},
  {"label":"Rainbow Foil","ebay_kw":"Topps Series 2 Rainbow Foil"},
  {"label":"Gold /2024","ebay_kw":"Topps Series 2 Gold 2024"},
  {"label":"Blue Holofoil /999","ebay_kw":"Topps Series 2 Blue Holofoil 999"},
  {"label":"Purple Holofoil /799","ebay_kw":"Topps Series 2 Purple Holofoil 799"},
  {"label":"Green Crackle /499","ebay_kw":"Topps Series 2 Green Crackle 499"},
  {"label":"Orange Crackle /299","ebay_kw":"Topps Series 2 Orange Crackle 299"},
  {"label":"Red Crackle /199","ebay_kw":"Topps Series 2 Red Crackle 199"},
  {"label":"Vintage Stock /99","ebay_kw":"Topps Series 2 Vintage Stock 99"},
  {"label":"Independence Day /76","ebay_kw":"Topps Series 2 Independence Day 76"},
  {"label":"Black /73","ebay_kw":"Topps Series 2 Black 73"},
  {"label":"Yellow Crackle /50","ebay_kw":"Topps Series 2 Yellow Crackle 50"},
  {"label":"Father Day Powder Blue /50","ebay_kw":"Topps Series 2 Father Day Powder Blue 50"},
  {"label":"Mother Day Hot Pink /50","ebay_kw":"Topps Series 2 Mother Day Hot Pink 50"},
  {"label":"Memorial Day Camo /25","ebay_kw":"Topps Series 2 Memorial Day Camo 25"},
  {"label":"Clear /10","ebay_kw":"Topps Series 2 Clear 10"},
  {"label":"Platinum /1","ebay_kw":"Topps Series 2 Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Series 2 Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Series 2 Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Series 2 Autograph Gold 50"},
  {"label":"Autograph Red /25","ebay_kw":"Topps Series 2 Autograph Red 25"},
  {"label":"Autograph Black /1","ebay_kw":"Topps Series 2 Autograph Black 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2' AND sport = 'baseball';

-- ============================================================
-- 6. TOPPS BIG LEAGUE BASEBALL (all years)
--    Current: Generic blue/yellow/orange parallels that don't exist
--    Real product: Black Foil /25, FoilFractor /1, Cracked Ice /10
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Big League Baseball"},
  {"label":"Electric Orange Foil","ebay_kw":"Topps Big League Electric Orange Foil"},
  {"label":"Cracked Ice /10","ebay_kw":"Topps Big League Cracked Ice 10"},
  {"label":"Black Foil /25","ebay_kw":"Topps Big League Black Foil 25"},
  {"label":"FoilFractor /1","ebay_kw":"Topps Big League FoilFractor 1"},
  {"label":"Autograph","ebay_kw":"Topps Big League Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Big League Autograph Gold 50"},
  {"label":"Autograph Orange /25","ebay_kw":"Topps Big League Autograph Orange 25"},
  {"label":"Autograph Red /5","ebay_kw":"Topps Big League Autograph Red 5"},
  {"label":"Autograph SuperFractor /1","ebay_kw":"Topps Big League Autograph SuperFractor 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Big League' AND sport = 'baseball';

-- ============================================================
-- 7. PANINI CONTENDERS OPTIC BASKETBALL (all years)
--    Current: "Optic Prizm" and "Optic Gold Prizm" do NOT exist
--    in this product — mixing up terminology from Prizm Optic
--    Fix: Real parallel structure with Season Ticket rainbow
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Contenders Optic Basketball"},
  {"label":"Silver","ebay_kw":"Contenders Optic Silver"},
  {"label":"Red","ebay_kw":"Contenders Optic Red"},
  {"label":"International Red","ebay_kw":"Contenders Optic International Red"},
  {"label":"Blue /99","ebay_kw":"Contenders Optic Blue 99"},
  {"label":"Pink /75","ebay_kw":"Contenders Optic Pink 75"},
  {"label":"Orange /49","ebay_kw":"Contenders Optic Orange 49"},
  {"label":"Green Pulsar /25","ebay_kw":"Contenders Optic Green Pulsar 25"},
  {"label":"Cracked Ice /23","ebay_kw":"Contenders Optic Cracked Ice 23"},
  {"label":"Purple /15","ebay_kw":"Contenders Optic Purple 15"},
  {"label":"Gold /10","ebay_kw":"Contenders Optic Gold 10"},
  {"label":"Jade Cracked Ice /5","ebay_kw":"Contenders Optic Jade Cracked Ice 5"},
  {"label":"Black /3","ebay_kw":"Contenders Optic Black 3"},
  {"label":"Gold Vinyl /1","ebay_kw":"Contenders Optic Gold Vinyl 1"},
  {"label":"Printing Plates /1","ebay_kw":"Contenders Optic Printing Plates"},
  {"label":"Rookie Ticket Auto","ebay_kw":"Contenders Optic Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Red /99","ebay_kw":"Contenders Optic Rookie Ticket Auto Red 99"},
  {"label":"Rookie Ticket Auto Green /75","ebay_kw":"Contenders Optic Rookie Ticket Auto Green 75"},
  {"label":"Rookie Ticket Auto Blue /49","ebay_kw":"Contenders Optic Rookie Ticket Auto Blue 49"},
  {"label":"Rookie Ticket Auto Orange /25","ebay_kw":"Contenders Optic Rookie Ticket Auto Orange 25"},
  {"label":"Rookie Ticket Auto Cracked Ice /23","ebay_kw":"Contenders Optic Rookie Ticket Auto Cracked Ice 23"},
  {"label":"Rookie Ticket Auto Purple /18","ebay_kw":"Contenders Optic Rookie Ticket Auto Purple 18"},
  {"label":"Rookie Ticket Auto Gold /10","ebay_kw":"Contenders Optic Rookie Ticket Auto Gold 10"},
  {"label":"Rookie Ticket Auto Jade Cracked Ice /5","ebay_kw":"Contenders Optic Rookie Ticket Auto Jade 5"},
  {"label":"Rookie Ticket Auto Black /3","ebay_kw":"Contenders Optic Rookie Ticket Auto Black 3"},
  {"label":"Rookie Ticket Auto Gold Vinyl /1","ebay_kw":"Contenders Optic Rookie Ticket Auto Gold Vinyl 1"},
  {"label":"Championship Ticket /1","ebay_kw":"Contenders Optic Championship Ticket 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Optic' AND sport = 'basketball';

-- ============================================================
-- 8. PANINI DONRUSS BASKETBALL — Fix Press Proof Gold /1
--    Current: "Press Proof Gold /1" should be "Press Proof Gold Die-Cut /25"
--    "Press Proof Green /25" doesn't exist — should be Gold Die-Cut /25
--    Real 2024-25 Donruss Basketball key parallels:
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss Basketball Base"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"Press Proof Purple /199","ebay_kw":"Donruss Press Proof Purple 199"},
  {"label":"Holo Laser /149","ebay_kw":"Donruss Holo Laser 149"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut 75"},
  {"label":"Checkerboard /49","ebay_kw":"Donruss Checkerboard 49"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut 25"},
  {"label":"Holo Gold Laser /10","ebay_kw":"Donruss Holo Gold Laser 10"},
  {"label":"Black /1","ebay_kw":"Donruss Black 1"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Silver","ebay_kw":"Donruss Rated Rookie Auto Silver"},
  {"label":"Rated Rookie Auto Purple /199","ebay_kw":"Donruss Rated Rookie Auto Purple 199"},
  {"label":"Rated Rookie Auto Gold Die-Cut /25","ebay_kw":"Donruss Rated Rookie Auto Gold 25"},
  {"label":"Rated Rookie Auto Gold Laser /10","ebay_kw":"Donruss Rated Rookie Auto Gold Laser 10"},
  {"label":"Rated Rookie Auto Black /1","ebay_kw":"Donruss Rated Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss' AND sport = 'basketball';

-- ============================================================
-- 9. PANINI DONRUSS FOOTBALL — same Press Proof structure fix
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Donruss Football Base"},
  {"label":"Rated Rookie","ebay_kw":"Donruss Rated Rookie"},
  {"label":"Press Proof Silver","ebay_kw":"Donruss Press Proof Silver"},
  {"label":"Press Proof Purple /199","ebay_kw":"Donruss Press Proof Purple 199"},
  {"label":"Holo Laser /149","ebay_kw":"Donruss Holo Laser 149"},
  {"label":"Press Proof Silver Die-Cut /75","ebay_kw":"Donruss Press Proof Silver Die-Cut 75"},
  {"label":"Checkerboard /49","ebay_kw":"Donruss Checkerboard 49"},
  {"label":"Press Proof Gold Die-Cut /25","ebay_kw":"Donruss Press Proof Gold Die-Cut 25"},
  {"label":"Holo Gold Laser /10","ebay_kw":"Donruss Holo Gold Laser 10"},
  {"label":"Black /1","ebay_kw":"Donruss Black 1"},
  {"label":"Printing Plate /1","ebay_kw":"Donruss Printing Plate"},
  {"label":"Rated Rookie Auto","ebay_kw":"Donruss Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Bronze /199","ebay_kw":"Donruss Rated Rookie Auto Bronze 199"},
  {"label":"Rated Rookie Auto Blue /99","ebay_kw":"Donruss Rated Rookie Auto Blue 99"},
  {"label":"Rated Rookie Auto Red /49","ebay_kw":"Donruss Rated Rookie Auto Red 49"},
  {"label":"Rated Rookie Auto Gold /25","ebay_kw":"Donruss Rated Rookie Auto Gold 25"},
  {"label":"Rated Rookie Auto Black /1","ebay_kw":"Donruss Rated Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss' AND sport = 'football';

-- ============================================================
-- 10. PANINI SILHOUETTE FOOTBALL — expand from 12 to full 14
--     Current: Missing FOTL tiers, Holo Silver branding, Cracked Ice
--     Real parallels verified from 2024-25 Checklist Insider
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Panini Silhouette Football"},
  {"label":"Holo Silver /149","ebay_kw":"Silhouette Holo Silver 149"},
  {"label":"Purple /125","ebay_kw":"Silhouette Purple 125"},
  {"label":"Blue /99","ebay_kw":"Silhouette Blue 99"},
  {"label":"Red /75","ebay_kw":"Silhouette Red 75"},
  {"label":"Bronze /49","ebay_kw":"Silhouette Bronze 49"},
  {"label":"Pink /35","ebay_kw":"Silhouette Pink 35"},
  {"label":"Cracked Ice /25","ebay_kw":"Silhouette Cracked Ice 25"},
  {"label":"FOTL Red /17","ebay_kw":"Silhouette FOTL Red 17"},
  {"label":"Scope /15","ebay_kw":"Silhouette Scope 15"},
  {"label":"Holo Gold /10","ebay_kw":"Silhouette Holo Gold 10"},
  {"label":"FOTL Black /7","ebay_kw":"Silhouette FOTL Black 7"},
  {"label":"Green /5","ebay_kw":"Silhouette Green 5"},
  {"label":"FOTL Platinum /3","ebay_kw":"Silhouette FOTL Platinum 3"},
  {"label":"Holo Platinum /1","ebay_kw":"Silhouette Holo Platinum 1"},
  {"label":"Rookie Silhouette Auto","ebay_kw":"Silhouette Rookie Auto"},
  {"label":"RSA Holo Silver /149","ebay_kw":"Silhouette Rookie Auto Holo Silver 149"},
  {"label":"RSA Blue /99","ebay_kw":"Silhouette Rookie Auto Blue 99"},
  {"label":"RSA Red /75","ebay_kw":"Silhouette Rookie Auto Red 75"},
  {"label":"RSA Cracked Ice /25","ebay_kw":"Silhouette Rookie Auto Cracked Ice 25"},
  {"label":"RSA Holo Gold /10","ebay_kw":"Silhouette Rookie Auto Holo Gold 10"},
  {"label":"RSA Holo Platinum /1","ebay_kw":"Silhouette Rookie Auto Holo Platinum 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Silhouette' AND sport = 'football';

-- ============================================================
-- 11. NEW SET: PANINI TOTALLY CERTIFIED BASKETBALL (2023-25)
--     Standalone product (was in Chronicles before 2023-24)
--     Verified parallels from 2024-25 ChecklistInsider
-- ============================================================
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', yr, 'Panini', 'Totally Certified',
'[
  {"label":"Base","ebay_kw":"Panini Totally Certified Basketball"},
  {"label":"Mirror","ebay_kw":"Totally Certified Mirror"},
  {"label":"Mirror Neon Orange /299","ebay_kw":"Totally Certified Mirror Neon Orange 299"},
  {"label":"Mirror Blue /199","ebay_kw":"Totally Certified Mirror Blue 199"},
  {"label":"Mirror Red /149","ebay_kw":"Totally Certified Mirror Red 149"},
  {"label":"Mirror Pink /125","ebay_kw":"Totally Certified Mirror Pink 125"},
  {"label":"Mirror Platinum Blue /99","ebay_kw":"Totally Certified Mirror Platinum Blue 99"},
  {"label":"Mirror Platinum Orange /75","ebay_kw":"Totally Certified Mirror Platinum Orange 75"},
  {"label":"Mirror Platinum Silver /75","ebay_kw":"Totally Certified Mirror Platinum Silver 75"},
  {"label":"Mirror Platinum Blue Camo /35","ebay_kw":"Totally Certified Mirror Blue Camo 35"},
  {"label":"Mirror Platinum Camo /25","ebay_kw":"Totally Certified Mirror Platinum Camo 25"},
  {"label":"Mirror Gold /10","ebay_kw":"Totally Certified Mirror Gold 10"},
  {"label":"Mirror Platinum Gold /10","ebay_kw":"Totally Certified Mirror Platinum Gold 10"},
  {"label":"Mirror Platinum Green /5","ebay_kw":"Totally Certified Mirror Platinum Green 5"},
  {"label":"Mirror Platinum Mixorama /5","ebay_kw":"Totally Certified Mirror Mixorama 5"},
  {"label":"Mirror Platinum Black /1","ebay_kw":"Totally Certified Mirror Platinum Black 1"},
  {"label":"Mirror Platinum Nebula /1","ebay_kw":"Totally Certified Mirror Platinum Nebula 1"},
  {"label":"Rookie Auto","ebay_kw":"Totally Certified Rookie Auto"},
  {"label":"Rookie Auto Mirror Blue /199","ebay_kw":"Totally Certified Rookie Auto Mirror Blue 199"},
  {"label":"Rookie Auto Mirror Red /149","ebay_kw":"Totally Certified Rookie Auto Mirror Red 149"},
  {"label":"Rookie Auto Mirror Platinum Camo /25","ebay_kw":"Totally Certified Rookie Auto Mirror Camo 25"},
  {"label":"Rookie Auto Mirror Gold /10","ebay_kw":"Totally Certified Rookie Auto Mirror Gold 10"},
  {"label":"Rookie Auto Mirror Black /1","ebay_kw":"Totally Certified Rookie Auto Mirror Black 1"}
]'::jsonb
FROM generate_series(2023, 2025) AS yr
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ============================================================
-- 12. NEW SET: PANINI SILHOUETTE BASKETBALL (2024-25)
--     Released August 2025 — first standalone basketball Silhouette
--     Verified parallels from 2024-25 ChecklistInsider
-- ============================================================
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
VALUES ('basketball', 2025, 'Panini', 'Silhouette',
'[
  {"label":"Base","ebay_kw":"Panini Silhouette Basketball"},
  {"label":"Holo Silver /149","ebay_kw":"Silhouette Basketball Holo Silver 149"},
  {"label":"Purple /125","ebay_kw":"Silhouette Basketball Purple 125"},
  {"label":"Blue /99","ebay_kw":"Silhouette Basketball Blue 99"},
  {"label":"Red /75","ebay_kw":"Silhouette Basketball Red 75"},
  {"label":"Bronze /49","ebay_kw":"Silhouette Basketball Bronze 49"},
  {"label":"Pink /35","ebay_kw":"Silhouette Basketball Pink 35"},
  {"label":"Cracked Ice /25","ebay_kw":"Silhouette Basketball Cracked Ice 25"},
  {"label":"FOTL Red /17","ebay_kw":"Silhouette Basketball FOTL Red 17"},
  {"label":"Scope /15","ebay_kw":"Silhouette Basketball Scope 15"},
  {"label":"Holo Gold /10","ebay_kw":"Silhouette Basketball Holo Gold 10"},
  {"label":"FOTL Black /7","ebay_kw":"Silhouette Basketball FOTL Black 7"},
  {"label":"Green /5","ebay_kw":"Silhouette Basketball Green 5"},
  {"label":"FOTL Platinum /3","ebay_kw":"Silhouette Basketball FOTL Platinum 3"},
  {"label":"Holo Platinum /1","ebay_kw":"Silhouette Basketball Holo Platinum 1"},
  {"label":"Rookie Auto","ebay_kw":"Silhouette Basketball Rookie Auto"},
  {"label":"Rookie Auto Holo Silver /149","ebay_kw":"Silhouette Basketball Rookie Auto Holo Silver 149"},
  {"label":"Rookie Auto Blue /99","ebay_kw":"Silhouette Basketball Rookie Auto Blue 99"},
  {"label":"Rookie Auto Red /75","ebay_kw":"Silhouette Basketball Rookie Auto Red 75"},
  {"label":"Rookie Auto Cracked Ice /25","ebay_kw":"Silhouette Basketball Rookie Auto Cracked Ice 25"},
  {"label":"Rookie Auto Holo Gold /10","ebay_kw":"Silhouette Basketball Rookie Auto Holo Gold 10"},
  {"label":"Rookie Auto Holo Platinum /1","ebay_kw":"Silhouette Basketball Rookie Auto Holo Platinum 1"}
]'::jsonb)
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ============================================================
-- 13. TOPPS UPDATE SERIES BASEBALL — same holofoil structure fix
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Update Series Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Update Series Short Print SP"},
  {"label":"Gold Foil","ebay_kw":"Topps Update Series Gold Foil"},
  {"label":"Rainbow Foil","ebay_kw":"Topps Update Series Rainbow Foil"},
  {"label":"Gold /2024","ebay_kw":"Topps Update Series Gold 2024"},
  {"label":"Blue Holofoil /999","ebay_kw":"Topps Update Series Blue Holofoil 999"},
  {"label":"Purple Holofoil /799","ebay_kw":"Topps Update Series Purple Holofoil 799"},
  {"label":"Green Crackle /499","ebay_kw":"Topps Update Series Green Crackle 499"},
  {"label":"Orange Crackle /299","ebay_kw":"Topps Update Series Orange Crackle 299"},
  {"label":"Red Crackle /199","ebay_kw":"Topps Update Series Red Crackle 199"},
  {"label":"Vintage Stock /99","ebay_kw":"Topps Update Series Vintage Stock 99"},
  {"label":"Black /73","ebay_kw":"Topps Update Series Black 73"},
  {"label":"Yellow Crackle /50","ebay_kw":"Topps Update Series Yellow Crackle 50"},
  {"label":"Memorial Day Camo /25","ebay_kw":"Topps Update Series Memorial Day Camo 25"},
  {"label":"Clear /10","ebay_kw":"Topps Update Series Clear 10"},
  {"label":"Platinum /1","ebay_kw":"Topps Update Series Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Update Series Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Update Series Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Update Series Autograph Gold 50"},
  {"label":"Autograph Red /25","ebay_kw":"Topps Update Series Autograph Red 25"},
  {"label":"Autograph Black /1","ebay_kw":"Topps Update Series Autograph Black 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Update Series' AND sport = 'baseball';

-- ============================================================
-- 14. UPPER DECK HOCKEY SERIES 1 AND SERIES 2
--     Current: Only 13 parallels, missing some key variants
--     Fix: Add UD Stars, epack-exclusive, French Back
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Hockey Series 1"},
  {"label":"Young Guns","ebay_kw":"Upper Deck Young Guns"},
  {"label":"Canvas","ebay_kw":"Upper Deck Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Upper Deck Young Guns Canvas"},
  {"label":"Outburst Silver","ebay_kw":"Upper Deck Outburst Silver"},
  {"label":"Deluxe /250","ebay_kw":"Upper Deck Deluxe 250"},
  {"label":"French /100","ebay_kw":"Upper Deck French 100"},
  {"label":"Exclusives /100","ebay_kw":"Upper Deck Exclusives 100"},
  {"label":"UD Stars /100","ebay_kw":"Upper Deck Stars 100"},
  {"label":"Clear Cut Young Guns","ebay_kw":"Upper Deck Clear Cut Young Guns"},
  {"label":"Outburst Red /25","ebay_kw":"Upper Deck Outburst Red 25"},
  {"label":"High Gloss /10","ebay_kw":"Upper Deck High Gloss 10"},
  {"label":"YG Oversized /10","ebay_kw":"Upper Deck Young Guns Oversized 10"},
  {"label":"Outburst Gold /1","ebay_kw":"Upper Deck Outburst Gold 1"},
  {"label":"Printing Plate /1","ebay_kw":"Upper Deck Printing Plate"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Series 1 Auto"},
  {"label":"RC Auto Exclusives /100","ebay_kw":"Upper Deck RC Auto Exclusives 100"},
  {"label":"RC Auto High Gloss /10","ebay_kw":"Upper Deck RC Auto High Gloss 10"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 1' AND sport = 'hockey';

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Hockey Series 2"},
  {"label":"Young Guns","ebay_kw":"Upper Deck Young Guns"},
  {"label":"Canvas","ebay_kw":"Upper Deck Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Upper Deck Young Guns Canvas"},
  {"label":"Outburst Silver","ebay_kw":"Upper Deck Outburst Silver"},
  {"label":"Deluxe /250","ebay_kw":"Upper Deck Deluxe 250"},
  {"label":"French /100","ebay_kw":"Upper Deck French 100"},
  {"label":"Exclusives /100","ebay_kw":"Upper Deck Exclusives 100"},
  {"label":"UD Stars /100","ebay_kw":"Upper Deck Stars 100"},
  {"label":"Clear Cut Young Guns","ebay_kw":"Upper Deck Clear Cut Young Guns"},
  {"label":"Outburst Red /25","ebay_kw":"Upper Deck Outburst Red 25"},
  {"label":"High Gloss /10","ebay_kw":"Upper Deck High Gloss 10"},
  {"label":"YG Oversized /10","ebay_kw":"Upper Deck Young Guns Oversized 10"},
  {"label":"Outburst Gold /1","ebay_kw":"Upper Deck Outburst Gold 1"},
  {"label":"Printing Plate /1","ebay_kw":"Upper Deck Printing Plate"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Series 2 Auto"},
  {"label":"RC Auto Exclusives /100","ebay_kw":"Upper Deck RC Auto Exclusives 100"},
  {"label":"RC Auto High Gloss /10","ebay_kw":"Upper Deck RC Auto High Gloss 10"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Series 2' AND sport = 'hockey';

-- ============================================================
-- 15. UPPER DECK HOCKEY (base UD product, aka UD Hockey)
--     14 parallels seems reasonable but verify canvas/exclusives structure
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Hockey Base"},
  {"label":"Young Guns","ebay_kw":"Upper Deck Young Guns"},
  {"label":"Canvas","ebay_kw":"Upper Deck Canvas"},
  {"label":"Young Guns Canvas","ebay_kw":"Upper Deck Young Guns Canvas"},
  {"label":"Exclusives /100","ebay_kw":"Upper Deck Hockey Exclusives 100"},
  {"label":"Clear Cut Young Guns","ebay_kw":"Upper Deck Clear Cut Young Guns"},
  {"label":"High Gloss /10","ebay_kw":"Upper Deck Hockey High Gloss 10"},
  {"label":"Printing Plate /1","ebay_kw":"Upper Deck Hockey Printing Plate"},
  {"label":"Team Canada","ebay_kw":"Upper Deck Team Canada"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Hockey Rookie Auto"},
  {"label":"RC Auto Exclusives /100","ebay_kw":"Upper Deck Hockey RC Auto Exclusives 100"},
  {"label":"RC Auto High Gloss /10","ebay_kw":"Upper Deck Hockey RC Auto High Gloss 10"},
  {"label":"Young Guns Redemption","ebay_kw":"Upper Deck Young Guns Redemption"},
  {"label":"Portrait Auto","ebay_kw":"Upper Deck Hockey Portrait Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Hockey' AND sport = 'hockey';
