-- ─────────────────────────────────────────────────────────────────────────────
-- Parallels Patch v2 — Batch 3: Hockey (UD Ice, The Cup, Artifacts, SPx,
--   Ultimate, MVP, Allure, Trilogy, Black Diamond), Topps Baseball (Heritage,
--   Gypsy Queen, Allen & Ginter, Stadium Club, Museum, Inception, Finest,
--   Series 1/2/Update full rebuild)
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK ICE HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Glacial Graphs Auto",       "ebay_kw":"Glacial Graphs Auto"},
  {"label":"Frozen Fabrics",            "ebay_kw":"Frozen Fabrics"},
  {"label":"Ice Premieres RC",          "ebay_kw":"Ice Premieres"},
  {"label":"Retro /99",                 "ebay_kw":"Retro"},
  {"label":"Blue /50",                  "ebay_kw":"Blue"},
  {"label":"Purple /25",                "ebay_kw":"Purple"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"RC Auto",                   "ebay_kw":"RC Auto"},
  {"label":"RC Auto Gold /10",          "ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /1",          "ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK THE CUP HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /249",                         "ebay_kw":""},
  {"label":"Rookie Patch Auto /99",             "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /25",                      "ebay_kw":"RPA Gold"},
  {"label":"RPA Platinum /10",                  "ebay_kw":"RPA Platinum"},
  {"label":"RPA Silver /5",                     "ebay_kw":"RPA Silver"},
  {"label":"RPA Black /1",                      "ebay_kw":"RPA Black"},
  {"label":"Cup Foundations Auto /99",          "ebay_kw":"Cup Foundations Auto"},
  {"label":"Cup Honorable Numbers Auto",        "ebay_kw":"Honorable Numbers Auto"},
  {"label":"Dual Rookie Patch Auto /25",        "ebay_kw":"Dual Rookie Patch Auto"},
  {"label":"Triple Rookie Patch Auto /18",      "ebay_kw":"Triple Rookie Patch Auto"},
  {"label":"Scripted Swatches Auto",            "ebay_kw":"Scripted Swatches"},
  {"label":"Enshrinements Auto",                "ebay_kw":"Enshrinements Auto"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK ARTIFACTS HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Teal /299",                     "ebay_kw":"Teal"},
  {"label":"Blue /199",                     "ebay_kw":"Blue"},
  {"label":"Red /99",                       "ebay_kw":"Red"},
  {"label":"Purple /50",                    "ebay_kw":"Purple"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Black /5",                      "ebay_kw":"Black"},
  {"label":"Emerald /1",                    "ebay_kw":"Emerald"},
  {"label":"RC Auto",                       "ebay_kw":"RC Auto"},
  {"label":"Autofacts Auto",                "ebay_kw":"Autofacts"},
  {"label":"Frozen Artifacts Patch Auto",   "ebay_kw":"Frozen Artifacts Patch Auto"},
  {"label":"Dual Artifacts Auto",           "ebay_kw":"Dual Artifacts Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK SPx HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Winning Materials Auto",    "ebay_kw":"Winning Materials Auto"},
  {"label":"Spectrum /299",             "ebay_kw":"Spectrum"},
  {"label":"Gold /199",                 "ebay_kw":"Gold"},
  {"label":"Blue /100",                 "ebay_kw":"Blue"},
  {"label":"Purple /50",                "ebay_kw":"Purple"},
  {"label":"Green /25",                 "ebay_kw":"Green"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"RC Auto",                   "ebay_kw":"RC Auto"},
  {"label":"RC Auto Gold /199",         "ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /1",          "ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK ULTIMATE COLLECTION HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /299",                     "ebay_kw":""},
  {"label":"Gold /99",                      "ebay_kw":"Gold"},
  {"label":"Onyx /25",                      "ebay_kw":"Onyx"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"RC Auto /499",                  "ebay_kw":"RC Auto"},
  {"label":"RC Auto Gold /99",              "ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Onyx /25",              "ebay_kw":"RC Auto Onyx"},
  {"label":"RC Auto Black /1",              "ebay_kw":"RC Auto Black"},
  {"label":"Ultimate Debut Threads Auto",   "ebay_kw":"Debut Threads Auto"},
  {"label":"Ultimate Signatures Auto",      "ebay_kw":"Ultimate Signatures"},
  {"label":"Ultimate Patches Auto",         "ebay_kw":"Ultimate Patches Auto"},
  {"label":"Ultimate Dual Auto",            "ebay_kw":"Ultimate Dual Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK MVP HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Silver Script /100",    "ebay_kw":"Silver Script"},
  {"label":"Gold Script /25",       "ebay_kw":"Gold Script"},
  {"label":"Super Script /1",       "ebay_kw":"Super Script"},
  {"label":"Colors & Contours",     "ebay_kw":"Colors and Contours"},
  {"label":"20th Anniversary",      "ebay_kw":"20th Anniversary"},
  {"label":"RC Auto",               "ebay_kw":"RC Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'MVP';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK ALLURE HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Red /299",              "ebay_kw":"Red"},
  {"label":"Blue /199",             "ebay_kw":"Blue"},
  {"label":"Green /99",             "ebay_kw":"Green"},
  {"label":"Purple /49",            "ebay_kw":"Purple"},
  {"label":"Gold /25",              "ebay_kw":"Gold"},
  {"label":"Black /1",              "ebay_kw":"Black"},
  {"label":"RC Auto",               "ebay_kw":"RC Auto"},
  {"label":"RC Auto Red /299",      "ebay_kw":"RC Auto Red"},
  {"label":"RC Auto Blue /199",     "ebay_kw":"RC Auto Blue"},
  {"label":"RC Auto Gold /25",      "ebay_kw":"RC Auto Gold"},
  {"label":"RC Auto Black /1",      "ebay_kw":"RC Auto Black"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Allure';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK TRILOGY HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                        "ebay_kw":""},
  {"label":"Scripts Auto /99",            "ebay_kw":"Scripts Auto"},
  {"label":"Scripts Auto Gold /49",       "ebay_kw":"Scripts Auto Gold"},
  {"label":"Scripts Auto Green /25",      "ebay_kw":"Scripts Auto Green"},
  {"label":"Scripts Auto Black /1",       "ebay_kw":"Scripts Auto Black"},
  {"label":"Rookie Threads Auto",         "ebay_kw":"Rookie Threads Auto"},
  {"label":"Rookie Threads Auto Gold /49","ebay_kw":"Rookie Threads Auto Gold"},
  {"label":"Rookie Threads Auto Black /1","ebay_kw":"Rookie Threads Auto Black"},
  {"label":"Three Star Auto /99",         "ebay_kw":"Three Star Auto"},
  {"label":"Stars of the Game",           "ebay_kw":"Stars of the Game"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Trilogy';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK BLACK DIAMOND HOCKEY
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base Single Diamond",       "ebay_kw":"Single Diamond"},
  {"label":"Double Diamond /100",       "ebay_kw":"Double Diamond"},
  {"label":"Triple Diamond /25",        "ebay_kw":"Triple Diamond"},
  {"label":"Quadruple Diamond /10",     "ebay_kw":"Quadruple Diamond"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"RC Auto",                   "ebay_kw":"RC Auto"},
  {"label":"RC Auto Double /100",       "ebay_kw":"RC Auto Double"},
  {"label":"RC Auto Triple /25",        "ebay_kw":"RC Auto Triple"},
  {"label":"RC Auto Black /1",          "ebay_kw":"RC Auto Black"},
  {"label":"Diamond Relic Auto",        "ebay_kw":"Diamond Relic Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Black Diamond';

-- ═══════════════════════════════════════════════════════════════════════════════
-- O-PEE-CHEE HOCKEY (base, not Platinum)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Black /100",            "ebay_kw":"Black Border"},
  {"label":"Retro /100",            "ebay_kw":"Retro"},
  {"label":"Rainbow /99",           "ebay_kw":"Rainbow"},
  {"label":"Retro Rainbow /99",     "ebay_kw":"Retro Rainbow"},
  {"label":"Marquee Rookies",       "ebay_kw":"Marquee Rookies"},
  {"label":"Update Marquee Rookies","ebay_kw":"Update Marquee Rookies"}
]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Hockey';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS SERIES 1 BASEBALL — full rebuild with autos + short prints
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Short Print SP",                "ebay_kw":"SP Short Print"},
  {"label":"Image Variation SP",            "ebay_kw":"Image Variation"},
  {"label":"Gold /2024",                    "ebay_kw":"Gold Parallel"},
  {"label":"Gold Star",                     "ebay_kw":"Gold Star"},
  {"label":"Blue /150",                     "ebay_kw":"Blue Parallel"},
  {"label":"Sky Blue /99",                  "ebay_kw":"Sky Blue"},
  {"label":"Red Foil /199",                 "ebay_kw":"Red Foil"},
  {"label":"Pink /50",                      "ebay_kw":"Pink Parallel"},
  {"label":"Purple /50",                    "ebay_kw":"Purple Parallel"},
  {"label":"Orange /25",                    "ebay_kw":"Orange Parallel"},
  {"label":"Black /69",                     "ebay_kw":"Black Parallel"},
  {"label":"Platinum /1",                   "ebay_kw":"Platinum Parallel"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Autograph",                     "ebay_kw":"Autograph"},
  {"label":"Autograph Gold /50",            "ebay_kw":"Autograph Gold"},
  {"label":"Autograph Red /25",             "ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /1",            "ebay_kw":"Autograph Black"},
  {"label":"Relic",                         "ebay_kw":"Relic"},
  {"label":"Jumbo Relic",                   "ebay_kw":"Jumbo Relic"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 1';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS SERIES 2 BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Short Print SP",                "ebay_kw":"SP Short Print"},
  {"label":"Image Variation SP",            "ebay_kw":"Image Variation"},
  {"label":"Gold /2024",                    "ebay_kw":"Gold Parallel"},
  {"label":"Gold Star",                     "ebay_kw":"Gold Star"},
  {"label":"Blue /150",                     "ebay_kw":"Blue Parallel"},
  {"label":"Sky Blue /99",                  "ebay_kw":"Sky Blue"},
  {"label":"Red Foil /199",                 "ebay_kw":"Red Foil"},
  {"label":"Pink /50",                      "ebay_kw":"Pink Parallel"},
  {"label":"Orange /25",                    "ebay_kw":"Orange Parallel"},
  {"label":"Black /69",                     "ebay_kw":"Black Parallel"},
  {"label":"Platinum /1",                   "ebay_kw":"Platinum Parallel"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Autograph",                     "ebay_kw":"Autograph"},
  {"label":"Autograph Gold /50",            "ebay_kw":"Autograph Gold"},
  {"label":"Autograph Red /25",             "ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /1",            "ebay_kw":"Autograph Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Series 2';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS UPDATE BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Short Print SP",                "ebay_kw":"SP Short Print"},
  {"label":"Image Variation SP",            "ebay_kw":"Image Variation"},
  {"label":"Gold /2024",                    "ebay_kw":"Gold Parallel"},
  {"label":"Blue /150",                     "ebay_kw":"Blue Parallel"},
  {"label":"Sky Blue /99",                  "ebay_kw":"Sky Blue"},
  {"label":"Pink /50",                      "ebay_kw":"Pink Parallel"},
  {"label":"Orange /25",                    "ebay_kw":"Orange Parallel"},
  {"label":"Black /69",                     "ebay_kw":"Black Parallel"},
  {"label":"Platinum /1",                   "ebay_kw":"Platinum Parallel"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Autograph",                     "ebay_kw":"Autograph"},
  {"label":"Autograph Gold /50",            "ebay_kw":"Autograph Gold"},
  {"label":"Autograph Red /25",             "ebay_kw":"Autograph Red"},
  {"label":"Autograph Black /1",            "ebay_kw":"Autograph Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Update';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS HERITAGE BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Short Print SP",                "ebay_kw":"SP Short Print"},
  {"label":"Chrome",                        "ebay_kw":"Chrome"},
  {"label":"Chrome Refractor",              "ebay_kw":"Chrome Refractor"},
  {"label":"Chrome Blue Refractor /75",     "ebay_kw":"Chrome Blue Refractor"},
  {"label":"Chrome Purple Refractor /50",   "ebay_kw":"Chrome Purple Refractor"},
  {"label":"Chrome Red Refractor /25",      "ebay_kw":"Chrome Red Refractor"},
  {"label":"Chrome Black Refractor /5",     "ebay_kw":"Chrome Black Refractor"},
  {"label":"Chrome SuperFractor /1",        "ebay_kw":"Chrome Superfractor"},
  {"label":"Real One Auto",                 "ebay_kw":"Real One Autograph"},
  {"label":"Real One Auto Red /25",         "ebay_kw":"Real One Auto Red"},
  {"label":"Real One Auto Black /5",        "ebay_kw":"Real One Auto Black"},
  {"label":"Minors Auto",                   "ebay_kw":"Minors Auto"},
  {"label":"News Flashback SP",             "ebay_kw":"News Flashback"},
  {"label":"Then & Now",                    "ebay_kw":"Then and Now"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Heritage';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS GYPSY QUEEN BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Mini",                      "ebay_kw":"Mini"},
  {"label":"Green /199",                "ebay_kw":"Green"},
  {"label":"Blue /150",                 "ebay_kw":"Blue"},
  {"label":"Purple /99",                "ebay_kw":"Purple"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Black /50",                 "ebay_kw":"Black"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"},
  {"label":"Autograph",                 "ebay_kw":"Autograph"},
  {"label":"Autograph Green /199",      "ebay_kw":"Autograph Green"},
  {"label":"Autograph Gold /50",        "ebay_kw":"Autograph Gold"},
  {"label":"Autograph Black /5",        "ebay_kw":"Autograph Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Gypsy Queen';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS ALLEN & GINTER BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Mini",                          "ebay_kw":"Mini"},
  {"label":"Mini A&G Back",                 "ebay_kw":"Mini A&G Back"},
  {"label":"Mini Black /50",                "ebay_kw":"Mini Black"},
  {"label":"Mini Framed /10",               "ebay_kw":"Mini Framed"},
  {"label":"Mini No Number /1",             "ebay_kw":"Mini No Number"},
  {"label":"Full Size Rip Card",            "ebay_kw":"Rip Card"},
  {"label":"Autograph",                     "ebay_kw":"Autograph"},
  {"label":"Framed Auto /50",               "ebay_kw":"Framed Auto"},
  {"label":"Framed Mini Auto /25",          "ebay_kw":"Framed Mini Auto"},
  {"label":"Framed Mini Auto Black /10",    "ebay_kw":"Framed Mini Auto Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Allen & Ginter';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS STADIUM CLUB BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Chrome",                    "ebay_kw":"Chrome"},
  {"label":"Chrome Refractor",          "ebay_kw":"Chrome Refractor"},
  {"label":"Black /50",                 "ebay_kw":"Black"},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Red /5",                    "ebay_kw":"Red"},
  {"label":"White /10",                 "ebay_kw":"White"},
  {"label":"Members Only",              "ebay_kw":"Members Only"},
  {"label":"Autograph",                 "ebay_kw":"Autograph"},
  {"label":"Chrome Autograph",          "ebay_kw":"Chrome Autograph"},
  {"label":"Chrome Auto Refractor",     "ebay_kw":"Chrome Auto Refractor"},
  {"label":"Power Zone",                "ebay_kw":"Power Zone"},
  {"label":"Co-Signers",                "ebay_kw":"Co-Signers"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Stadium Club';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS MUSEUM COLLECTION BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base Copper /399",          "ebay_kw":"Copper"},
  {"label":"Amethyst /199",             "ebay_kw":"Amethyst"},
  {"label":"Emerald /99",               "ebay_kw":"Emerald"},
  {"label":"Sapphire /50",              "ebay_kw":"Sapphire"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Ruby /10",                  "ebay_kw":"Ruby"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Primary Pieces Patch Auto", "ebay_kw":"Primary Pieces Patch Auto"},
  {"label":"PPPA Copper /25",           "ebay_kw":"Primary Pieces Auto Copper"},
  {"label":"PPPA Gold /10",             "ebay_kw":"Primary Pieces Auto Gold"},
  {"label":"PPPA Black /5",             "ebay_kw":"Primary Pieces Auto Black"},
  {"label":"Momentous Material Auto",   "ebay_kw":"Momentous Material Auto"},
  {"label":"Double Auto Relic",         "ebay_kw":"Double Auto Relic"},
  {"label":"Archival Autograph /99",    "ebay_kw":"Archival Autograph"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Museum Collection';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS INCEPTION BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /250",                 "ebay_kw":""},
  {"label":"Orange /150",               "ebay_kw":"Orange"},
  {"label":"Green /99",                 "ebay_kw":"Green"},
  {"label":"Blue /75",                  "ebay_kw":"Blue"},
  {"label":"Purple /50",                "ebay_kw":"Purple"},
  {"label":"Red /25",                   "ebay_kw":"Red"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Black /5",                  "ebay_kw":"Black"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Rookie Patch Auto /99",     "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Orange /150",           "ebay_kw":"Rookie Patch Auto Orange"},
  {"label":"RPA Green /99",             "ebay_kw":"Rookie Patch Auto Green"},
  {"label":"RPA Blue /75",              "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"RPA Red /25",               "ebay_kw":"Rookie Patch Auto Red"},
  {"label":"RPA Gold /10",              "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Black /5",              "ebay_kw":"Rookie Patch Auto Black"},
  {"label":"RPA Platinum /1",           "ebay_kw":"Rookie Patch Auto Platinum"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Inception';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS FINEST BASEBALL (comprehensive)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Refractor",                     "ebay_kw":"Refractor"},
  {"label":"Blue Wave Refractor /150",      "ebay_kw":"Blue Wave Refractor"},
  {"label":"Green Refractor /99",           "ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50",            "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",          "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",              "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",               "ebay_kw":"Superfractor"},
  {"label":"Finest Auto",                   "ebay_kw":"Finest Autograph"},
  {"label":"Finest Auto Refractor",         "ebay_kw":"Finest Auto Refractor"},
  {"label":"Finest Auto Blue /150",         "ebay_kw":"Finest Auto Blue"},
  {"label":"Finest Auto Green /99",         "ebay_kw":"Finest Auto Green"},
  {"label":"Finest Auto Gold /50",          "ebay_kw":"Finest Auto Gold"},
  {"label":"Finest Auto Orange /25",        "ebay_kw":"Finest Auto Orange"},
  {"label":"Finest Auto Red /5",            "ebay_kw":"Finest Auto Red"},
  {"label":"Finest Auto SuperFractor /1",   "ebay_kw":"Finest Auto Superfractor"},
  {"label":"Rookie Auto Refractor",         "ebay_kw":"Rookie Auto Refractor"},
  {"label":"Rookie Auto Gold /50",          "ebay_kw":"Rookie Auto Gold Refractor"},
  {"label":"Rookie Patch Auto",             "ebay_kw":"Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS GOLD LABEL BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Class 1",                   "ebay_kw":"Class 1"},
  {"label":"Class 2",                   "ebay_kw":"Class 2"},
  {"label":"Class 3",                   "ebay_kw":"Class 3"},
  {"label":"Red /50",                   "ebay_kw":"Red"},
  {"label":"Black /25",                 "ebay_kw":"Black"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Framed /5",                 "ebay_kw":"Framed"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Framed Auto",               "ebay_kw":"Framed Autograph"},
  {"label":"Framed Auto Black /25",     "ebay_kw":"Framed Auto Black"},
  {"label":"Framed Auto Gold /10",      "ebay_kw":"Framed Auto Gold"},
  {"label":"Framed Auto Platinum /1",   "ebay_kw":"Framed Auto Platinum"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Gold Label';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS TRIPLE THREADS BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /99",                  "ebay_kw":""},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Emerald /25",               "ebay_kw":"Emerald"},
  {"label":"Sapphire /10",              "ebay_kw":"Sapphire"},
  {"label":"White /3",                  "ebay_kw":"White"},
  {"label":"Unity Relic Auto",          "ebay_kw":"Unity Relic Auto"},
  {"label":"Unity Relic Auto Gold /50", "ebay_kw":"Unity Relic Auto Gold"},
  {"label":"Unity Relic Auto Black /9", "ebay_kw":"Unity Relic Auto Black"},
  {"label":"Autograph Relic /99",       "ebay_kw":"Autograph Relic"},
  {"label":"Triple Relic Auto",         "ebay_kw":"Triple Relic Auto"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Triple Threads';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS TIER ONE BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /699",                 "ebay_kw":""},
  {"label":"Blue /299",                 "ebay_kw":"Blue"},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Red /25",                   "ebay_kw":"Red"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Prime Patchwork Auto",      "ebay_kw":"Prime Patchwork Auto"},
  {"label":"PPA Gold /50",              "ebay_kw":"Prime Patchwork Auto Gold"},
  {"label":"PPA Red /25",               "ebay_kw":"Prime Patchwork Auto Red"},
  {"label":"PPA Black /10",             "ebay_kw":"Prime Patchwork Auto Black"},
  {"label":"Clear One Auto /99",        "ebay_kw":"Clear One Auto"},
  {"label":"Top Shelf Relics Auto",     "ebay_kw":"Top Shelf Relics Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Tier One';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS GALLERY BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Artist Proof /250",         "ebay_kw":"Artist Proof"},
  {"label":"Gold /50",                  "ebay_kw":"Gold"},
  {"label":"Black /10",                 "ebay_kw":"Black"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"},
  {"label":"Autograph",                 "ebay_kw":"Autograph"},
  {"label":"Auto Artist Proof /25",     "ebay_kw":"Auto Artist Proof"},
  {"label":"Auto Gold /10",             "ebay_kw":"Auto Gold"},
  {"label":"Auto Black /5",             "ebay_kw":"Auto Black"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Gallery';

-- ═══════════════════════════════════════════════════════════════════════════════
-- BOWMAN PLATINUM BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Blue /150",                     "ebay_kw":"Blue"},
  {"label":"Green /99",                     "ebay_kw":"Green"},
  {"label":"Purple /50",                    "ebay_kw":"Purple"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Red /5",                        "ebay_kw":"Red"},
  {"label":"Platinum /1",                   "ebay_kw":"Platinum"},
  {"label":"Prospect Auto",                 "ebay_kw":"Prospect Auto"},
  {"label":"Prospect Auto Blue /150",       "ebay_kw":"Prospect Auto Blue"},
  {"label":"Prospect Auto Green /99",       "ebay_kw":"Prospect Auto Green"},
  {"label":"Prospect Auto Purple /50",      "ebay_kw":"Prospect Auto Purple"},
  {"label":"Prospect Auto Gold /25",        "ebay_kw":"Prospect Auto Gold"},
  {"label":"Prospect Auto Red /5",          "ebay_kw":"Prospect Auto Red"},
  {"label":"Prospect Auto Platinum /1",     "ebay_kw":"Prospect Auto Platinum"},
  {"label":"Prospect Patch Auto",           "ebay_kw":"Prospect Patch Auto"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Platinum';

-- ═══════════════════════════════════════════════════════════════════════════════
-- BOWMAN STERLING BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Refractor",                     "ebay_kw":"Refractor"},
  {"label":"Blue Refractor /150",           "ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99",           "ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50",            "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",          "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",              "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",               "ebay_kw":"Superfractor"},
  {"label":"Prospect Auto",                 "ebay_kw":"Prospect Auto"},
  {"label":"Prospect Auto Refractor",       "ebay_kw":"Prospect Auto Refractor"},
  {"label":"Prospect Auto Blue /150",       "ebay_kw":"Prospect Auto Blue"},
  {"label":"Prospect Auto Gold /50",        "ebay_kw":"Prospect Auto Gold"},
  {"label":"Prospect Auto Orange /25",      "ebay_kw":"Prospect Auto Orange"},
  {"label":"Prospect Auto Red /5",          "ebay_kw":"Prospect Auto Red"},
  {"label":"Prospect Auto SuperFractor /1", "ebay_kw":"Prospect Auto Superfractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Sterling';
