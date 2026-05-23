-- ─────────────────────────────────────────────────────────────────────────────
-- Parallels Patch v2 — Batch 2: Select, Contenders, Chronicles, Absolute,
--   Certified, Revolution, Donruss (base), Score
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SELECT BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Concourse",                         "ebay_kw":"Concourse"},
  {"label":"Premier Level",                     "ebay_kw":"Premier Level"},
  {"label":"Courtside",                         "ebay_kw":"Courtside"},
  {"label":"Silver Prizm",                      "ebay_kw":"Silver Prizm"},
  {"label":"White Prizm /199",                  "ebay_kw":"White Prizm"},
  {"label":"Blue Prizm /149",                   "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                     "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                   "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",                  "ebay_kw":"Purple Prizm"},
  {"label":"Tie-Dye /25",                       "ebay_kw":"Tie-Dye Prizm"},
  {"label":"Gold Prizm /10",                    "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                    "ebay_kw":"Black Prizm"},
  {"label":"Tri-Color Prizm",                   "ebay_kw":"Tri-Color Prizm"},
  {"label":"Die-Cut",                           "ebay_kw":"Die-Cut"},
  {"label":"Rookie Patch Auto /99",             "ebay_kw":"Rookie Patch Auto"},
  {"label":"Rookie Patch Auto Blue /49",        "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"Rookie Patch Auto Red /35",         "ebay_kw":"Rookie Patch Auto Red"},
  {"label":"Rookie Patch Auto Gold /10",        "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"Rookie Patch Auto Black /1",        "ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Rookie Patch Auto Tri-Color /25",   "ebay_kw":"Rookie Patch Auto Tri-Color"},
  {"label":"Rookie Jersey Auto",                "ebay_kw":"Rookie Jersey Auto"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SELECT FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Concourse",                         "ebay_kw":"Concourse"},
  {"label":"Premier Level",                     "ebay_kw":"Premier Level"},
  {"label":"Courtside",                         "ebay_kw":"Courtside"},
  {"label":"Silver Prizm",                      "ebay_kw":"Silver Prizm"},
  {"label":"White Prizm /199",                  "ebay_kw":"White Prizm"},
  {"label":"Blue Prizm /149",                   "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                     "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                   "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",                  "ebay_kw":"Purple Prizm"},
  {"label":"Tie-Dye /25",                       "ebay_kw":"Tie-Dye Prizm"},
  {"label":"Gold Prizm /10",                    "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                    "ebay_kw":"Black Prizm"},
  {"label":"Tri-Color Prizm",                   "ebay_kw":"Tri-Color Prizm"},
  {"label":"Die-Cut",                           "ebay_kw":"Die-Cut"},
  {"label":"Rookie Patch Auto /99",             "ebay_kw":"Rookie Patch Auto"},
  {"label":"Rookie Patch Auto Blue /49",        "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"Rookie Patch Auto Red /35",         "ebay_kw":"Rookie Patch Auto Red"},
  {"label":"Rookie Patch Auto Gold /10",        "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"Rookie Patch Auto Black /1",        "ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Rookie Patch Auto Tri-Color /25",   "ebay_kw":"Rookie Patch Auto Tri-Color"},
  {"label":"Rookie Jersey Auto",                "ebay_kw":"Rookie Jersey Auto"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SELECT WNBA
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Concourse",                       "ebay_kw":"Concourse"},
  {"label":"Premier Level",                   "ebay_kw":"Premier Level"},
  {"label":"Courtside",                       "ebay_kw":"Courtside"},
  {"label":"Silver Prizm",                    "ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /149",                 "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                   "ebay_kw":"Red Prizm"},
  {"label":"Purple Prizm /49",                "ebay_kw":"Purple Prizm"},
  {"label":"Gold Prizm /10",                  "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                  "ebay_kw":"Black Prizm"},
  {"label":"Rookie Patch Auto",               "ebay_kw":"Rookie Patch Auto"},
  {"label":"Rookie Patch Auto Blue /49",      "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"Rookie Patch Auto Gold /10",      "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"Rookie Patch Auto Black /1",      "ebay_kw":"Rookie Patch Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CONTENDERS BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Rookie Ticket",                         "ebay_kw":"Rookie Ticket"},
  {"label":"Rookie Ticket Auto",                    "ebay_kw":"Rookie Ticket Auto"},
  {"label":"Season Ticket /249",                    "ebay_kw":"Season Ticket"},
  {"label":"Cracked Ice /25",                       "ebay_kw":"Cracked Ice"},
  {"label":"Championship Ticket /10",               "ebay_kw":"Championship Ticket"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",    "ebay_kw":"Rookie Ticket Auto Cracked Ice"},
  {"label":"Rookie Ticket Auto Championship /10",   "ebay_kw":"Rookie Ticket Auto Championship"},
  {"label":"Rookie Ticket Auto Printing Plate /1",  "ebay_kw":"Rookie Ticket Auto Printing Plate"},
  {"label":"Veteran Ticket Auto",                   "ebay_kw":"Veteran Ticket Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CONTENDERS FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Rookie Ticket",                         "ebay_kw":"Rookie Ticket"},
  {"label":"Rookie Ticket Auto",                    "ebay_kw":"Rookie Ticket Auto"},
  {"label":"Season Ticket /249",                    "ebay_kw":"Season Ticket"},
  {"label":"Cracked Ice /25",                       "ebay_kw":"Cracked Ice"},
  {"label":"Championship Ticket /10",               "ebay_kw":"Championship Ticket"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket RPS Auto",                "ebay_kw":"Rookie Ticket RPS Auto"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",    "ebay_kw":"Rookie Ticket Auto Cracked Ice"},
  {"label":"Rookie Ticket Auto Championship /10",   "ebay_kw":"Rookie Ticket Auto Championship"},
  {"label":"Rookie Ticket Auto Printing Plate /1",  "ebay_kw":"Rookie Ticket Auto Printing Plate"},
  {"label":"Veteran Ticket Auto",                   "ebay_kw":"Veteran Ticket Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CONTENDERS DRAFT PICKS (basketball + football)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Draft Ticket Auto",                     "ebay_kw":"Draft Ticket Auto"},
  {"label":"Season Ticket /249",                    "ebay_kw":"Season Ticket"},
  {"label":"Cracked Ice /25",                       "ebay_kw":"Cracked Ice"},
  {"label":"Championship Ticket /10",               "ebay_kw":"Championship Ticket"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Draft Ticket Auto Cracked Ice /25",     "ebay_kw":"Draft Ticket Auto Cracked Ice"},
  {"label":"Draft Ticket Auto Championship /10",    "ebay_kw":"Draft Ticket Auto Championship"},
  {"label":"Draft Ticket Auto Printing Plate /1",   "ebay_kw":"Draft Ticket Auto Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Draft Picks';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CHRONICLES (basketball + football)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Pink /199",             "ebay_kw":"Pink"},
  {"label":"Blue /99",              "ebay_kw":"Blue"},
  {"label":"Green /75",             "ebay_kw":"Green"},
  {"label":"Purple /49",            "ebay_kw":"Purple"},
  {"label":"Gold /25",              "ebay_kw":"Gold"},
  {"label":"Platinum /10",          "ebay_kw":"Platinum"},
  {"label":"Black /1",              "ebay_kw":"Black"},
  {"label":"Rookie Auto",           "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Pink /199", "ebay_kw":"Rookie Auto Pink"},
  {"label":"Rookie Auto Blue /99",  "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Gold /25",  "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",  "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Chronicles';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI ABSOLUTE BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                            "ebay_kw":""},
  {"label":"Spectrum Blue /199",              "ebay_kw":"Spectrum Blue"},
  {"label":"Spectrum Red /99",                "ebay_kw":"Spectrum Red"},
  {"label":"Spectrum Green /75",              "ebay_kw":"Spectrum Green"},
  {"label":"Spectrum Purple /49",             "ebay_kw":"Spectrum Purple"},
  {"label":"Spectrum Gold /25",               "ebay_kw":"Spectrum Gold"},
  {"label":"Spectrum Platinum /10",           "ebay_kw":"Spectrum Platinum"},
  {"label":"Spectrum Black /1",               "ebay_kw":"Spectrum Black"},
  {"label":"Rookie Premiere Materials Auto",  "ebay_kw":"Rookie Premiere Materials Auto"},
  {"label":"RPM Auto Blue /199",              "ebay_kw":"RPM Auto Blue"},
  {"label":"RPM Auto Red /99",                "ebay_kw":"RPM Auto Red"},
  {"label":"RPM Auto Gold /25",               "ebay_kw":"RPM Auto Gold"},
  {"label":"RPM Auto Black /1",               "ebay_kw":"RPM Auto Black"},
  {"label":"Tools of the Trade",              "ebay_kw":"Tools of the Trade"},
  {"label":"War Room Auto",                   "ebay_kw":"War Room Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Absolute' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI ABSOLUTE FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                            "ebay_kw":""},
  {"label":"Spectrum Blue /199",              "ebay_kw":"Spectrum Blue"},
  {"label":"Spectrum Red /99",                "ebay_kw":"Spectrum Red"},
  {"label":"Spectrum Green /75",              "ebay_kw":"Spectrum Green"},
  {"label":"Spectrum Purple /49",             "ebay_kw":"Spectrum Purple"},
  {"label":"Spectrum Gold /25",               "ebay_kw":"Spectrum Gold"},
  {"label":"Spectrum Platinum /10",           "ebay_kw":"Spectrum Platinum"},
  {"label":"Spectrum Black /1",               "ebay_kw":"Spectrum Black"},
  {"label":"Rookie Premiere Materials Auto",  "ebay_kw":"Rookie Premiere Materials Auto"},
  {"label":"RPM Auto Blue /199",              "ebay_kw":"RPM Auto Blue"},
  {"label":"RPM Auto Red /99",                "ebay_kw":"RPM Auto Red"},
  {"label":"RPM Auto Gold /25",               "ebay_kw":"RPM Auto Gold"},
  {"label":"RPM Auto Black /1",               "ebay_kw":"RPM Auto Black"},
  {"label":"Gridiron Force",                  "ebay_kw":"Gridiron Force"},
  {"label":"War Room Auto",                   "ebay_kw":"War Room Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Absolute' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CERTIFIED BASKETBALL + FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                        "ebay_kw":""},
  {"label":"Mirror Blue /199",            "ebay_kw":"Mirror Blue"},
  {"label":"Mirror Red /99",              "ebay_kw":"Mirror Red"},
  {"label":"Mirror Green /75",            "ebay_kw":"Mirror Green"},
  {"label":"Mirror Purple /49",           "ebay_kw":"Mirror Purple"},
  {"label":"Mirror Gold /25",             "ebay_kw":"Mirror Gold"},
  {"label":"Mirror Black /1",             "ebay_kw":"Mirror Black"},
  {"label":"Freshman Fabric Auto",        "ebay_kw":"Freshman Fabric Auto"},
  {"label":"Freshman Fabric Auto Gold /25","ebay_kw":"Freshman Fabric Auto Gold"},
  {"label":"Freshman Fabric Auto Black /1","ebay_kw":"Freshman Fabric Auto Black"},
  {"label":"Potential Auto",              "ebay_kw":"Potential Auto"},
  {"label":"Skills Auto",                 "ebay_kw":"Skills Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI REVOLUTION BASKETBALL + FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Astro",                     "ebay_kw":"Astro"},
  {"label":"Chinese New Year",          "ebay_kw":"Chinese New Year"},
  {"label":"Cubic",                     "ebay_kw":"Cubic"},
  {"label":"Infinite",                  "ebay_kw":"Infinite"},
  {"label":"Sunburst",                  "ebay_kw":"Sunburst"},
  {"label":"Blue /149",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Purple /49",                "ebay_kw":"Purple"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Galactic /10",              "ebay_kw":"Galactic"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /149",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",       "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Purple /49",    "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Revolution';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS BASKETBALL (base Donruss, not Optic)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Rated Rookie",                  "ebay_kw":"Rated Rookie"},
  {"label":"Press Proof Blue /199",         "ebay_kw":"Press Proof Blue"},
  {"label":"Press Proof Red /99",           "ebay_kw":"Press Proof Red"},
  {"label":"Press Proof Green /25",         "ebay_kw":"Press Proof Green"},
  {"label":"Press Proof Gold /1",           "ebay_kw":"Press Proof Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Rated Rookie Auto",             "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Blue /199",   "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /99",     "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Gold /25",    "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",    "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS FOOTBALL (base Donruss)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Rated Rookie",                  "ebay_kw":"Rated Rookie"},
  {"label":"Press Proof Blue /199",         "ebay_kw":"Press Proof Blue"},
  {"label":"Press Proof Red /99",           "ebay_kw":"Press Proof Red"},
  {"label":"Press Proof Green /25",         "ebay_kw":"Press Proof Green"},
  {"label":"Press Proof Gold /1",           "ebay_kw":"Press Proof Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Rated Rookie Auto",             "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Bronze /199", "ebay_kw":"Rated Rookie Auto Bronze"},
  {"label":"Rated Rookie Auto Blue /99",    "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /49",     "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Gold /25",    "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",    "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SCORE FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Red /199",                  "ebay_kw":"Red"},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Platinum /25",              "ebay_kw":"Platinum"},
  {"label":"Black /10",                 "ebay_kw":"Black"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Red /199",      "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /50",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /10",     "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Score' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI ILLUSIONS (basketball + football)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Blue /199",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Green /75",                 "ebay_kw":"Green"},
  {"label":"Purple /49",                "ebay_kw":"Purple"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /199",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",       "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Purple /49",    "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Illusions';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI COURT KINGS BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Fresco /149",               "ebay_kw":"Fresco"},
  {"label":"Level 2 /99",               "ebay_kw":"Level 2"},
  {"label":"Level 3 /49",               "ebay_kw":"Level 3"},
  {"label":"Artist Proof /25",          "ebay_kw":"Artist Proof"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Fresco /149",   "ebay_kw":"Rookie Auto Fresco"},
  {"label":"Rookie Auto Level 2 /99",   "ebay_kw":"Rookie Auto Level 2"},
  {"label":"Rookie Auto Level 3 /49",   "ebay_kw":"Rookie Auto Level 3"},
  {"label":"Rookie Auto Gold /10",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Court Kings';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI GOLD STANDARD BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Gold /299",                 "ebay_kw":"Gold"},
  {"label":"White Gold /199",           "ebay_kw":"White Gold"},
  {"label":"Rose Gold /149",            "ebay_kw":"Rose Gold"},
  {"label":"Ruby /99",                  "ebay_kw":"Ruby"},
  {"label":"Emerald /49",               "ebay_kw":"Emerald"},
  {"label":"Sapphire /25",              "ebay_kw":"Sapphire"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Jersey Auto",        "ebay_kw":"Rookie Jersey Auto"},
  {"label":"RJA Gold /299",             "ebay_kw":"Rookie Jersey Auto Gold"},
  {"label":"RJA Ruby /99",              "ebay_kw":"Rookie Jersey Auto Ruby"},
  {"label":"RJA Emerald /49",           "ebay_kw":"Rookie Jersey Auto Emerald"},
  {"label":"RJA Sapphire /25",          "ebay_kw":"Rookie Jersey Auto Sapphire"},
  {"label":"RJA Black /1",              "ebay_kw":"Rookie Jersey Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Gold Standard';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI STATUS BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Blue /199",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Green /75",                 "ebay_kw":"Green"},
  {"label":"Purple /49",                "ebay_kw":"Purple"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /199",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",       "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Status';
