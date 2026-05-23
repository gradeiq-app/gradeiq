-- ═══════════════════════════════════════════════════════════════════════════════
-- PARALLELS DEEP FIX v1 — verified against official checklists (Beckett/ChecklistInsider)
-- Covers: Contenders (bball/ftball), Score Football, Artifacts Hockey, Young Guns,
--         O-Pee-Chee Hockey, Obsidian, Spectra, Hoops Basketball, Mosaic (bball/ftball),
--         Select (bball), Totally Certified, Bowman Basketball 2025-26
-- ═══════════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI CONTENDERS BASKETBALL
-- FIX: Championship Ticket was /10 — correct is /1 (one-of-one)
--      Added full ticket rainbow per official 2023-24 checklist
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                    "ebay_kw":""},
  {"label":"Rookie Ticket",                           "ebay_kw":"Rookie Ticket"},
  {"label":"Playoff Ticket /249",                     "ebay_kw":"Playoff Ticket"},
  {"label":"First Round Ticket /149",                 "ebay_kw":"First Round Ticket"},
  {"label":"Semifinal Ticket /99",                    "ebay_kw":"Semifinal Ticket"},
  {"label":"Conference Finals Ticket /75",            "ebay_kw":"Conference Finals Ticket"},
  {"label":"The Finals Ticket /49",                   "ebay_kw":"Finals Ticket"},
  {"label":"Cracked Ice Ticket /25",                  "ebay_kw":"Cracked Ice Ticket"},
  {"label":"Game 7 Ticket /7",                        "ebay_kw":"Game 7 Ticket"},
  {"label":"Championship Ticket /1",                  "ebay_kw":"Championship Ticket"},
  {"label":"Printing Plate /1",                       "ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket Auto",                      "ebay_kw":"Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Playoff /249",         "ebay_kw":"Rookie Ticket Auto Playoff"},
  {"label":"Rookie Ticket Auto First Round /149",     "ebay_kw":"Rookie Ticket Auto First Round"},
  {"label":"Rookie Ticket Auto Blue /99",             "ebay_kw":"Rookie Ticket Auto Blue"},
  {"label":"Rookie Ticket Auto Gold /10",             "ebay_kw":"Rookie Ticket Auto Gold"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",      "ebay_kw":"Rookie Ticket Auto Cracked Ice"},
  {"label":"Rookie Ticket Auto Championship /1",      "ebay_kw":"Rookie Ticket Auto Championship"},
  {"label":"Veteran Ticket Auto",                     "ebay_kw":"Veteran Ticket Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI CONTENDERS FOOTBALL
-- FIX: Championship Ticket /10 was wrong — correct is "Super Bowl Ticket /1"
--      Added full ticket rainbow per official 2024 checklist
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                        "ebay_kw":""},
  {"label":"Rookie Ticket",                               "ebay_kw":"Rookie Ticket"},
  {"label":"Game Ticket Blue /499",                       "ebay_kw":"Game Ticket Blue"},
  {"label":"Playoff Ticket /199",                         "ebay_kw":"Playoff Ticket"},
  {"label":"Game Ticket Green /175",                      "ebay_kw":"Game Ticket Green"},
  {"label":"Divisional Ticket /149",                      "ebay_kw":"Divisional Ticket"},
  {"label":"Conference Ticket /99",                       "ebay_kw":"Conference Ticket"},
  {"label":"Ticket Stub /99",                             "ebay_kw":"Ticket Stub"},
  {"label":"Game Ticket Teal /75",                        "ebay_kw":"Game Ticket Teal"},
  {"label":"Midfield Ticket /50",                         "ebay_kw":"Midfield Ticket"},
  {"label":"Cracked Ice Ticket /25",                      "ebay_kw":"Cracked Ice Ticket"},
  {"label":"Week 18 Ticket /18",                          "ebay_kw":"Week 18 Ticket"},
  {"label":"Game Ticket Gold /10",                        "ebay_kw":"Game Ticket Gold"},
  {"label":"Super Bowl Ticket /1",                        "ebay_kw":"Super Bowl Ticket"},
  {"label":"Printing Plate /1",                           "ebay_kw":"Printing Plate"},
  {"label":"Rookie Ticket Auto",                          "ebay_kw":"Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Playoff /199",             "ebay_kw":"Rookie Ticket Auto Playoff"},
  {"label":"Rookie Ticket Auto Divisional /149",          "ebay_kw":"Rookie Ticket Auto Divisional"},
  {"label":"Rookie Ticket Auto Conference /99",           "ebay_kw":"Rookie Ticket Auto Conference"},
  {"label":"Rookie Ticket Auto Midfield /50",             "ebay_kw":"Rookie Ticket Auto Midfield"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",          "ebay_kw":"Rookie Ticket Auto Cracked Ice"},
  {"label":"Rookie Ticket Auto Super Bowl /1",            "ebay_kw":"Rookie Ticket Auto Super Bowl"},
  {"label":"Veteran Ticket Auto",                         "ebay_kw":"Veteran Ticket Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI SCORE FOOTBALL
-- FIX: Was 10 parallels — real product has 24+ numbered + unlimiteds
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Gold",                  "ebay_kw":"Score Gold"},
  {"label":"Green",                 "ebay_kw":"Score Green"},
  {"label":"Orange",                "ebay_kw":"Score Orange"},
  {"label":"Purple",                "ebay_kw":"Score Purple"},
  {"label":"Red",                   "ebay_kw":"Score Red"},
  {"label":"Scorecard",             "ebay_kw":"Scorecard"},
  {"label":"Extraterrestrial",      "ebay_kw":"Extraterrestrial"},
  {"label":"Lava /630",             "ebay_kw":"Score Lava"},
  {"label":"Stars /399",            "ebay_kw":"Score Stars"},
  {"label":"Ellipse /299",          "ebay_kw":"Score Ellipse"},
  {"label":"Dots Gold /240",        "ebay_kw":"Dots Gold"},
  {"label":"Spokes /180",           "ebay_kw":"Score Spokes"},
  {"label":"Circular /135",         "ebay_kw":"Score Circular"},
  {"label":"Cubic /120",            "ebay_kw":"Score Cubic"},
  {"label":"Showcase /100",         "ebay_kw":"Score Showcase"},
  {"label":"Electric /99",          "ebay_kw":"Score Electric"},
  {"label":"Gold Zone /50",         "ebay_kw":"Gold Zone"},
  {"label":"Artist Proof /35",      "ebay_kw":"Artist Proof Score"},
  {"label":"Red Zone /20",          "ebay_kw":"Red Zone"},
  {"label":"Die-Cut /10",           "ebay_kw":"Score Die-Cut"},
  {"label":"First Down /10",        "ebay_kw":"First Down"},
  {"label":"End Zone /6",           "ebay_kw":"End Zone"},
  {"label":"Gem Masters /1",        "ebay_kw":"Gem Masters"},
  {"label":"Printing Plates /1",    "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Score' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI SPECTRA BASKETBALL
-- FIX: Complete rebuild — our parallels were entirely wrong colors/names
--      Real product: Celestial, Supernova, Interstellar, Astral, Meta, Gold, Marble, Nebula
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Celestial /99",                 "ebay_kw":"Spectra Celestial"},
  {"label":"Supernova /75",                 "ebay_kw":"Spectra Supernova"},
  {"label":"Interstellar /49",              "ebay_kw":"Spectra Interstellar"},
  {"label":"Astral /35",                    "ebay_kw":"Spectra Astral"},
  {"label":"Meta /25",                      "ebay_kw":"Spectra Meta"},
  {"label":"Gold /10",                      "ebay_kw":"Spectra Gold"},
  {"label":"Marble /5",                     "ebay_kw":"Spectra Marble"},
  {"label":"Nebula /1",                     "ebay_kw":"Spectra Nebula"},
  {"label":"Neon /99",                      "ebay_kw":"Spectra Neon"},
  {"label":"Neon Auto /99",                 "ebay_kw":"Spectra Neon Auto"},
  {"label":"Celestial Auto /99",            "ebay_kw":"Spectra Celestial Auto"},
  {"label":"Supernova Auto /75",            "ebay_kw":"Spectra Supernova Auto"},
  {"label":"Interstellar Auto /49",         "ebay_kw":"Spectra Interstellar Auto"},
  {"label":"Astral Auto /35",               "ebay_kw":"Spectra Astral Auto"},
  {"label":"Gold Auto /10",                 "ebay_kw":"Spectra Gold Auto"},
  {"label":"Nebula Auto /1",                "ebay_kw":"Spectra Nebula Auto"},
  {"label":"RPA Celestial /99",             "ebay_kw":"Spectra RPA Celestial"},
  {"label":"RPA Interstellar /49",          "ebay_kw":"Spectra RPA Interstellar"},
  {"label":"RPA Meta /25",                  "ebay_kw":"Spectra RPA Meta"},
  {"label":"RPA Gold /10",                  "ebay_kw":"Spectra RPA Gold"},
  {"label":"RPA Black /1",                  "ebay_kw":"Spectra RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Spectra' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI OBSIDIAN BASKETBALL
-- FIX: Complete rebuild — Electric Etch color names were wrong
--      Real product uses "Flood" naming (Orange Flood, Bronze Flood, etc.)
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":"Obsidian"},
  {"label":"Electric Etch Orange Flood /125",       "ebay_kw":"Electric Etch Orange Flood"},
  {"label":"Electric Etch Bronze Flood /99",        "ebay_kw":"Electric Etch Bronze"},
  {"label":"Electric Etch Purple Flood /75",        "ebay_kw":"Electric Etch Purple"},
  {"label":"Electric Etch Pink Flood /49",          "ebay_kw":"Electric Etch Pink Flood"},
  {"label":"Electric Etch Fire and Ice /49",        "ebay_kw":"Electric Etch Fire Ice"},
  {"label":"Electric Etch Blue Flood /30",          "ebay_kw":"Electric Etch Blue"},
  {"label":"Electric Etch Green Flood /25",         "ebay_kw":"Electric Etch Green"},
  {"label":"Electric Etch Jade /25",                "ebay_kw":"Electric Etch Jade"},
  {"label":"Electric Etch Hot Springs /15",         "ebay_kw":"Electric Etch Hot Springs"},
  {"label":"Electric Etch Gold Flood /10",          "ebay_kw":"Electric Etch Gold"},
  {"label":"Electric Etch Molten Mojo /10",         "ebay_kw":"Electric Etch Molten"},
  {"label":"Electric Etch Deep Sea Mojo /5",        "ebay_kw":"Electric Etch Deep Sea"},
  {"label":"Electric Etch Ashen Flood /1",          "ebay_kw":"Electric Etch Ashen"},
  {"label":"Electric Etch Vibrant Mojo /1",         "ebay_kw":"Electric Etch Vibrant"},
  {"label":"Rookie Auto",                           "ebay_kw":"Obsidian Rookie Auto"},
  {"label":"Rookie Auto Electric Etch /75",         "ebay_kw":"Obsidian Rookie Auto Electric Etch"},
  {"label":"Rookie Auto Bronze /49",                "ebay_kw":"Obsidian Rookie Auto Bronze"},
  {"label":"Rookie Auto Gold /10",                  "ebay_kw":"Obsidian Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",                  "ebay_kw":"Obsidian Rookie Auto Black"},
  {"label":"Rookie Patch Auto",                     "ebay_kw":"Obsidian RPA"},
  {"label":"RPA Electric Etch /49",                 "ebay_kw":"Obsidian RPA Electric Etch"},
  {"label":"RPA Gold /10",                          "ebay_kw":"Obsidian RPA Gold"},
  {"label":"RPA Black /1",                          "ebay_kw":"Obsidian RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Obsidian' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- UPPER DECK ARTIFACTS HOCKEY
-- FIX: Complete rebuild — colors/print runs were completely wrong
--      Real product: Ruby /499, Emerald /149, Copper /75, Orange /65, Yellow /50,
--      Pink /35, Purple /25, Spectrum Jungle /15, Seafoam Green /10, Masterful /1
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":"Artifacts"},
  {"label":"Ruby /499",                         "ebay_kw":"Artifacts Ruby"},
  {"label":"Emerald /149",                      "ebay_kw":"Artifacts Emerald"},
  {"label":"Copper /75",                        "ebay_kw":"Artifacts Copper"},
  {"label":"Orange /65",                        "ebay_kw":"Artifacts Orange"},
  {"label":"Yellow /50",                        "ebay_kw":"Artifacts Yellow"},
  {"label":"Pink /35",                          "ebay_kw":"Artifacts Pink"},
  {"label":"Purple /25",                        "ebay_kw":"Artifacts Purple"},
  {"label":"Spectrum Jungle /15",               "ebay_kw":"Artifacts Spectrum Jungle"},
  {"label":"Seafoam Green /10",                 "ebay_kw":"Artifacts Seafoam"},
  {"label":"Masterful Artifacts /1",            "ebay_kw":"Masterful Artifacts"},
  {"label":"Foilboard",                         "ebay_kw":"Artifacts Foilboard"},
  {"label":"Gold Foilboard",                    "ebay_kw":"Artifacts Gold Foilboard"},
  {"label":"RC Auto",                           "ebay_kw":"Artifacts RC Auto"},
  {"label":"Autofacts Auto",                    "ebay_kw":"Autofacts"},
  {"label":"Auto Emerald /149",                 "ebay_kw":"Artifacts Auto Emerald"},
  {"label":"Auto Copper /75",                   "ebay_kw":"Artifacts Auto Copper"},
  {"label":"Auto Purple /25",                   "ebay_kw":"Artifacts Auto Purple"},
  {"label":"Auto Seafoam Green /10",            "ebay_kw":"Artifacts Auto Seafoam"},
  {"label":"Frozen Artifacts Patch Auto /35",   "ebay_kw":"Frozen Artifacts"},
  {"label":"Dual Artifacts Auto",               "ebay_kw":"Dual Artifacts Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Artifacts' AND sport = 'hockey';

-- ─────────────────────────────────────────────────────────────────────────────
-- UPPER DECK O-PEE-CHEE HOCKEY
-- FIX: Print runs were wrong — Rainbow is /350 not /99
--      Added Orange Border /25, corrected structure
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":"O-Pee-Chee"},
  {"label":"Rainbow Foil /350",         "ebay_kw":"OPC Rainbow Foil"},
  {"label":"Black Border /100",         "ebay_kw":"OPC Black Border"},
  {"label":"Orange Border /25",         "ebay_kw":"OPC Orange Border"},
  {"label":"Rainbow Foil Gold /1",      "ebay_kw":"OPC Rainbow Foil Gold"},
  {"label":"Printing Plate /1",         "ebay_kw":"OPC Printing Plate"},
  {"label":"Retro",                     "ebay_kw":"OPC Retro"},
  {"label":"Retro Black /99",           "ebay_kw":"OPC Retro Black"},
  {"label":"Retro Rainbow /50",         "ebay_kw":"OPC Retro Rainbow"},
  {"label":"Marquee Rookies",           "ebay_kw":"OPC Marquee Rookies"},
  {"label":"Marquee Rookies Black /100","ebay_kw":"OPC Marquee Rookies Black"},
  {"label":"RC Auto",                   "ebay_kw":"OPC RC Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'O-Pee-Chee' AND sport = 'hockey';

-- ─────────────────────────────────────────────────────────────────────────────
-- UPPER DECK YOUNG GUNS HOCKEY
-- FIX: Was missing Outburst Red /25, Deluxe /250, Outburst Gold /1
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Young Guns",                "ebay_kw":"Young Guns"},
  {"label":"Canvas",                    "ebay_kw":"Young Guns Canvas"},
  {"label":"Outburst Silver",           "ebay_kw":"Young Guns Outburst Silver"},
  {"label":"Clear Cut",                 "ebay_kw":"Clear Cut Young Guns"},
  {"label":"Deluxe /250",               "ebay_kw":"Young Guns Deluxe"},
  {"label":"Exclusives /100",           "ebay_kw":"Young Guns Exclusives"},
  {"label":"Outburst Red /25",          "ebay_kw":"Young Guns Outburst Red"},
  {"label":"High Gloss /10",            "ebay_kw":"Young Guns High Gloss"},
  {"label":"Outburst Gold /1",          "ebay_kw":"Young Guns Outburst Gold"},
  {"label":"Auto",                      "ebay_kw":"Young Guns Auto"},
  {"label":"Auto Exclusives /100",      "ebay_kw":"Young Guns Auto Exclusives"},
  {"label":"Auto High Gloss /10",       "ebay_kw":"Young Guns Auto High Gloss"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Young Guns' AND sport = 'hockey';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI HOOPS BASKETBALL
-- FIX: Was missing Artist Proof /25, Artist Proof Gold /10, Artist Proof Black /1
--      Fixed Silver print run (was /169, should be /199)
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Teal Explosion",            "ebay_kw":"Teal Explosion Hoops"},
  {"label":"Winter",                    "ebay_kw":"Hoops Winter"},
  {"label":"Purple",                    "ebay_kw":"Hoops Purple"},
  {"label":"Silver /199",               "ebay_kw":"Hoops Silver"},
  {"label":"Teal /175",                 "ebay_kw":"Hoops Teal"},
  {"label":"Orange /149",               "ebay_kw":"Hoops Orange"},
  {"label":"Green /99",                 "ebay_kw":"Hoops Green"},
  {"label":"Red /75",                   "ebay_kw":"Hoops Red"},
  {"label":"Blue /49",                  "ebay_kw":"Hoops Blue"},
  {"label":"Artist Proof /25",          "ebay_kw":"Hoops Artist Proof"},
  {"label":"Gold /10",                  "ebay_kw":"Hoops Gold"},
  {"label":"Artist Proof Gold /10",     "ebay_kw":"Hoops Artist Proof Gold"},
  {"label":"Black /1",                  "ebay_kw":"Hoops Black"},
  {"label":"Artist Proof Black /1",     "ebay_kw":"Hoops Artist Proof Black"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto",               "ebay_kw":"Hoops Rookie Auto"},
  {"label":"Rookie Auto Silver /199",   "ebay_kw":"Hoops Rookie Auto Silver"},
  {"label":"Rookie Auto Red /99",       "ebay_kw":"Hoops Rookie Auto Red"},
  {"label":"Rookie Auto Blue /49",      "ebay_kw":"Hoops Rookie Auto Blue"},
  {"label":"Rookie Auto Gold /10",      "ebay_kw":"Hoops Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Hoops Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI HOOPS WNBA
-- Add Artist Proof parallels (same structure as regular Hoops)
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Purple",                    "ebay_kw":"Hoops WNBA Purple"},
  {"label":"Silver /199",               "ebay_kw":"Hoops WNBA Silver"},
  {"label":"Orange /149",               "ebay_kw":"Hoops WNBA Orange"},
  {"label":"Green /99",                 "ebay_kw":"Hoops WNBA Green"},
  {"label":"Red /75",                   "ebay_kw":"Hoops WNBA Red"},
  {"label":"Blue /49",                  "ebay_kw":"Hoops WNBA Blue"},
  {"label":"Artist Proof /25",          "ebay_kw":"Hoops WNBA Artist Proof"},
  {"label":"Gold /10",                  "ebay_kw":"Hoops WNBA Gold"},
  {"label":"Artist Proof Gold /10",     "ebay_kw":"Hoops WNBA Artist Proof Gold"},
  {"label":"Black /1",                  "ebay_kw":"Hoops WNBA Black"},
  {"label":"Artist Proof Black /1",     "ebay_kw":"Hoops WNBA Artist Proof Black"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops WNBA';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI MOSAIC BASKETBALL
-- EXPAND: From 25 → 40 parallels with correct numbered variants
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":"Mosaic"},
  {"label":"Silver Mosaic",                 "ebay_kw":"Silver Mosaic"},
  {"label":"White Sparkle Mosaic",          "ebay_kw":"White Sparkle Mosaic"},
  {"label":"Reactive Blue Mosaic",          "ebay_kw":"Reactive Blue Mosaic"},
  {"label":"Reactive Yellow Mosaic",        "ebay_kw":"Reactive Yellow Mosaic"},
  {"label":"Genesis Mosaic",                "ebay_kw":"Genesis Mosaic"},
  {"label":"Green Mosaic",                  "ebay_kw":"Green Mosaic"},
  {"label":"Red Mosaic",                    "ebay_kw":"Red Mosaic"},
  {"label":"Glitter Mosaic",                "ebay_kw":"Glitter Mosaic"},
  {"label":"Honeycomb Mosaic",              "ebay_kw":"Honeycomb Mosaic"},
  {"label":"Color Blast Mosaic",            "ebay_kw":"Color Blast Mosaic"},
  {"label":"Camo Mosaic",                   "ebay_kw":"Camo Mosaic"},
  {"label":"Red Seismic /299",              "ebay_kw":"Red Seismic Mosaic"},
  {"label":"Orange Mosaic /249",            "ebay_kw":"Orange Mosaic"},
  {"label":"Purple Fluorescent /249",       "ebay_kw":"Purple Fluorescent Mosaic"},
  {"label":"Blue Mosaic /199",              "ebay_kw":"Blue Mosaic"},
  {"label":"Pink Mosaic /175",              "ebay_kw":"Pink Mosaic"},
  {"label":"Blue Seismic /149",             "ebay_kw":"Blue Seismic Mosaic"},
  {"label":"Ice Mosaic /125",               "ebay_kw":"Ice Mosaic"},
  {"label":"Purple Mosaic /99",             "ebay_kw":"Purple Mosaic"},
  {"label":"Blue Fluorescent /75",          "ebay_kw":"Blue Fluorescent Mosaic"},
  {"label":"Bronze Mosaic /75",             "ebay_kw":"Bronze Mosaic"},
  {"label":"Red Fluorescent /75",           "ebay_kw":"Red Fluorescent Mosaic"},
  {"label":"Fast Break Blue /85",           "ebay_kw":"Fast Break Blue Mosaic"},
  {"label":"Fast Break Purple /50",         "ebay_kw":"Fast Break Purple Mosaic"},
  {"label":"Orange Ice /49",                "ebay_kw":"Orange Ice Mosaic"},
  {"label":"Tessellation /15",              "ebay_kw":"Tessellation Mosaic"},
  {"label":"White Mosaic /25",              "ebay_kw":"White Mosaic"},
  {"label":"Orange Fluorescent /25",        "ebay_kw":"Orange Fluorescent Mosaic"},
  {"label":"Fast Break Gold /10",           "ebay_kw":"Fast Break Gold Mosaic"},
  {"label":"Gold Mosaic /10",               "ebay_kw":"Gold Mosaic"},
  {"label":"Green Fluorescent /10",         "ebay_kw":"Green Fluorescent Mosaic"},
  {"label":"Pink Fluorescent /10",          "ebay_kw":"Pink Fluorescent Mosaic"},
  {"label":"Fast Break Neon Green /5",      "ebay_kw":"Fast Break Neon Green Mosaic"},
  {"label":"Gold Glitter Mosaic /5",        "ebay_kw":"Gold Glitter Mosaic"},
  {"label":"Fast Break Gold Black /3",      "ebay_kw":"Fast Break Gold Black Mosaic"},
  {"label":"Black Mosaic /1",               "ebay_kw":"Black Mosaic"},
  {"label":"Fast Break Black /1",           "ebay_kw":"Fast Break Black Mosaic"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI MOSAIC FOOTBALL
-- EXPAND: Added full numbered rainbow per 2024 checklist
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":"Mosaic"},
  {"label":"Silver Mosaic",                 "ebay_kw":"Silver Mosaic"},
  {"label":"White Sparkle Mosaic",          "ebay_kw":"White Sparkle Mosaic"},
  {"label":"Reactive Blue Mosaic",          "ebay_kw":"Reactive Blue Mosaic"},
  {"label":"Yellow Reactive Mosaic",        "ebay_kw":"Yellow Reactive Mosaic"},
  {"label":"Genesis Mosaic",                "ebay_kw":"Genesis Mosaic"},
  {"label":"Green Mosaic",                  "ebay_kw":"Green Mosaic"},
  {"label":"Red Mosaic",                    "ebay_kw":"Red Mosaic"},
  {"label":"Honeycomb Mosaic",              "ebay_kw":"Honeycomb Mosaic"},
  {"label":"Camo Pink Mosaic",              "ebay_kw":"Camo Pink Mosaic"},
  {"label":"Camo Red Mosaic",               "ebay_kw":"Camo Red Mosaic"},
  {"label":"No Huddle Silver Mosaic",       "ebay_kw":"No Huddle Mosaic"},
  {"label":"Orange Mosaic /199",            "ebay_kw":"Orange Mosaic"},
  {"label":"Blue Mosaic /99",               "ebay_kw":"Blue Mosaic"},
  {"label":"No Huddle Blue Mosaic /75",     "ebay_kw":"No Huddle Blue Mosaic"},
  {"label":"No Huddle Purple Mosaic /50",   "ebay_kw":"No Huddle Purple Mosaic"},
  {"label":"Purple Mosaic /49",             "ebay_kw":"Purple Mosaic"},
  {"label":"Orange Fluorescent /25",        "ebay_kw":"Orange Fluorescent Mosaic"},
  {"label":"White Mosaic /25",              "ebay_kw":"White Mosaic"},
  {"label":"No Huddle Pink Mosaic /20",     "ebay_kw":"No Huddle Pink Mosaic"},
  {"label":"Tessellation /15",              "ebay_kw":"Tessellation Mosaic"},
  {"label":"Blue Fluorescent /15",          "ebay_kw":"Blue Fluorescent Mosaic"},
  {"label":"Gold Mosaic /10",               "ebay_kw":"Gold Mosaic"},
  {"label":"Green Fluorescent /10",         "ebay_kw":"Green Fluorescent Mosaic"},
  {"label":"No Huddle Gold Mosaic /10",     "ebay_kw":"No Huddle Gold Mosaic"},
  {"label":"Pink Fluorescent /10",          "ebay_kw":"Pink Fluorescent Mosaic"},
  {"label":"Black Gold Choice /8",          "ebay_kw":"Black Gold Mosaic"},
  {"label":"Black Mosaic /1",               "ebay_kw":"Black Mosaic"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI SELECT BASKETBALL
-- EXPAND: Added key numbered variants from all tiers (Concourse/Premier/Courtside)
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base (Concourse)",              "ebay_kw":"Select Concourse"},
  {"label":"Silver Prizm",                  "ebay_kw":"Select Silver Prizm"},
  {"label":"Tri-Color Prizm",               "ebay_kw":"Select Tri-Color"},
  {"label":"Cosmic Prizm",                  "ebay_kw":"Select Cosmic"},
  {"label":"Disco Prizm",                   "ebay_kw":"Select Disco"},
  {"label":"Premier Level",                 "ebay_kw":"Select Premier Level"},
  {"label":"Courtside",                     "ebay_kw":"Select Courtside"},
  {"label":"Light Blue Prizm /299",         "ebay_kw":"Select Light Blue"},
  {"label":"Red Prizm /199",                "ebay_kw":"Select Red Prizm"},
  {"label":"Maroon Prizm /175",             "ebay_kw":"Select Maroon"},
  {"label":"White Prizm /149",              "ebay_kw":"Select White Prizm"},
  {"label":"Blue Camo /99",                 "ebay_kw":"Select Blue Camo"},
  {"label":"Neon Green /75",                "ebay_kw":"Select Neon Green"},
  {"label":"Orange Prizm /65",              "ebay_kw":"Select Orange Prizm"},
  {"label":"Green Wave /50",                "ebay_kw":"Select Green Wave"},
  {"label":"White Scope /35",               "ebay_kw":"Select White Scope"},
  {"label":"Tie-Dye /25",                   "ebay_kw":"Select Tie-Dye"},
  {"label":"Blue Disco /25",                "ebay_kw":"Select Blue Disco"},
  {"label":"Neon Orange Pulsar /18",        "ebay_kw":"Select Neon Orange Pulsar"},
  {"label":"Gold Prizm /10",                "ebay_kw":"Select Gold Prizm"},
  {"label":"Gold Disco /10",                "ebay_kw":"Select Gold Disco"},
  {"label":"Dragon Scale /8",               "ebay_kw":"Select Dragon Scale"},
  {"label":"Green Prizm /5",                "ebay_kw":"Select Green Prizm"},
  {"label":"Neon Purple Pulsar /5",         "ebay_kw":"Select Neon Purple Pulsar"},
  {"label":"Black Finite /1",               "ebay_kw":"Select Black Finite"},
  {"label":"RPA Silver",                    "ebay_kw":"Select RPA Silver"},
  {"label":"RPA Tie-Dye /25",               "ebay_kw":"Select RPA Tie-Dye"},
  {"label":"RPA Gold /10",                  "ebay_kw":"Select RPA Gold"},
  {"label":"RPA Black /1",                  "ebay_kw":"Select RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI SELECT FOOTBALL
-- EXPAND: Tri-Color /299, Tie-Dye /25, key numbered tiers
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base (Concourse)",          "ebay_kw":"Select Concourse"},
  {"label":"Silver Prizm",              "ebay_kw":"Select Silver Prizm"},
  {"label":"Tri-Color Prizm /299",      "ebay_kw":"Select Tri-Color"},
  {"label":"Cosmic Prizm",              "ebay_kw":"Select Cosmic"},
  {"label":"Disco Prizm",               "ebay_kw":"Select Disco"},
  {"label":"Premier Level",             "ebay_kw":"Select Premier Level"},
  {"label":"Red Prizm /199",            "ebay_kw":"Select Red Prizm"},
  {"label":"Maroon Prizm /175",         "ebay_kw":"Select Maroon"},
  {"label":"White Prizm /149",          "ebay_kw":"Select White Prizm"},
  {"label":"Neon Green /75",            "ebay_kw":"Select Neon Green"},
  {"label":"Orange Prizm /65",          "ebay_kw":"Select Orange Prizm"},
  {"label":"Green Wave /50",            "ebay_kw":"Select Green Wave"},
  {"label":"White Scope /35",           "ebay_kw":"Select White Scope"},
  {"label":"Tie-Dye /25",               "ebay_kw":"Select Tie-Dye"},
  {"label":"Blue Disco /25",            "ebay_kw":"Select Blue Disco"},
  {"label":"Neon Orange Pulsar /18",    "ebay_kw":"Select Neon Orange Pulsar"},
  {"label":"Gold Prizm /10",            "ebay_kw":"Select Gold Prizm"},
  {"label":"Dragon Scale /8",           "ebay_kw":"Select Dragon Scale"},
  {"label":"Green Prizm /5",            "ebay_kw":"Select Green Prizm"},
  {"label":"Black Finite /1",           "ebay_kw":"Select Black Finite"},
  {"label":"RPA Silver",                "ebay_kw":"Select RPA Silver"},
  {"label":"RPA Tie-Dye /25",           "ebay_kw":"Select RPA Tie-Dye"},
  {"label":"RPA Gold /10",              "ebay_kw":"Select RPA Gold"},
  {"label":"RPA Black /1",              "ebay_kw":"Select RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI CERTIFIED BASKETBALL (Totally Certified era: 2022-25)
-- EXPAND: Full Mirror parallel structure per 2024-25 Totally Certified checklist
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Mirror",                            "ebay_kw":"Certified Mirror"},
  {"label":"Mirror Bronze",                     "ebay_kw":"Certified Mirror Bronze"},
  {"label":"Mirror Maroon",                     "ebay_kw":"Certified Mirror Maroon"},
  {"label":"Mirror Purple",                     "ebay_kw":"Certified Mirror Purple"},
  {"label":"Mirror Neon Orange /299",           "ebay_kw":"Certified Mirror Neon Orange"},
  {"label":"Mirror Blue /199",                  "ebay_kw":"Certified Mirror Blue"},
  {"label":"Mirror Red /149",                   "ebay_kw":"Certified Mirror Red"},
  {"label":"Mirror Pink /125",                  "ebay_kw":"Certified Mirror Pink"},
  {"label":"Mirror Platinum Red Die-Cut /125",  "ebay_kw":"Mirror Platinum Red"},
  {"label":"Mirror Neon Green /99",             "ebay_kw":"Certified Mirror Neon Green"},
  {"label":"Mirror Platinum Blue /99",          "ebay_kw":"Mirror Platinum Blue"},
  {"label":"Mirror Platinum Orange /75",        "ebay_kw":"Mirror Platinum Orange"},
  {"label":"Mirror Platinum Silver /75",        "ebay_kw":"Mirror Platinum Silver"},
  {"label":"Mirror Platinum Purple Die-Cut /49","ebay_kw":"Mirror Platinum Purple"},
  {"label":"Mirror Platinum Blue Camo /35",     "ebay_kw":"Mirror Platinum Blue Camo"},
  {"label":"Mirror Platinum Camo /25",          "ebay_kw":"Mirror Platinum Camo"},
  {"label":"Mirror Platinum White /25",         "ebay_kw":"Mirror Platinum White"},
  {"label":"Mirror Gold /10",                   "ebay_kw":"Certified Mirror Gold"},
  {"label":"Mirror Platinum Gold /10",          "ebay_kw":"Mirror Platinum Gold"},
  {"label":"Mirror Platinum Green /5",          "ebay_kw":"Mirror Platinum Green"},
  {"label":"Mirror Platinum Mixorama /5",       "ebay_kw":"Mirror Platinum Mixorama"},
  {"label":"Mirror Platinum Black /1",          "ebay_kw":"Mirror Platinum Black"},
  {"label":"Mirror Platinum Nebula /1",         "ebay_kw":"Mirror Platinum Nebula"},
  {"label":"Freshman Fabric Auto",              "ebay_kw":"Freshman Fabric Auto"},
  {"label":"Freshman Fabric Auto Mirror /25",   "ebay_kw":"Freshman Fabric Auto Mirror Gold"},
  {"label":"Freshman Fabric Auto Black /1",     "ebay_kw":"Freshman Fabric Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI CERTIFIED FOOTBALL (Totally Certified)
-- EXPAND: Full Mirror parallel structure per 2024 Totally Certified Football checklist
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Mirror",                            "ebay_kw":"Certified Mirror"},
  {"label":"Mirror Bronze",                     "ebay_kw":"Certified Mirror Bronze"},
  {"label":"Mirror Maroon",                     "ebay_kw":"Certified Mirror Maroon"},
  {"label":"Mirror Purple",                     "ebay_kw":"Certified Mirror Purple"},
  {"label":"Mirror Blue /399",                  "ebay_kw":"Certified Mirror Blue"},
  {"label":"Mirror Neon Orange /399",           "ebay_kw":"Certified Mirror Neon Orange"},
  {"label":"Mirror Platinum Silver /299",       "ebay_kw":"Mirror Platinum Silver"},
  {"label":"Mirror Red /249",                   "ebay_kw":"Certified Mirror Red"},
  {"label":"Mirror Platinum Red Die-Cut /175",  "ebay_kw":"Mirror Platinum Red"},
  {"label":"Mirror Platinum Blue /149",         "ebay_kw":"Mirror Platinum Blue"},
  {"label":"Mirror Neon Green /99",             "ebay_kw":"Certified Mirror Neon Green"},
  {"label":"Mirror Platinum Orange /99",        "ebay_kw":"Mirror Platinum Orange"},
  {"label":"Mirror Platinum Purple Die-Cut /75","ebay_kw":"Mirror Platinum Purple"},
  {"label":"Mirror Platinum Blue Camo /50",     "ebay_kw":"Mirror Platinum Blue Camo"},
  {"label":"Mirror Pink /44",                   "ebay_kw":"Certified Mirror Pink"},
  {"label":"Mirror Platinum White /40",         "ebay_kw":"Mirror Platinum White"},
  {"label":"Mirror Platinum Camo /35",          "ebay_kw":"Mirror Platinum Camo"},
  {"label":"Mirror Gold /10",                   "ebay_kw":"Certified Mirror Gold"},
  {"label":"Mirror Platinum Gold /10",          "ebay_kw":"Mirror Platinum Gold"},
  {"label":"Mirror Platinum Green /5",          "ebay_kw":"Mirror Platinum Green"},
  {"label":"Mirror Platinum Mixorama /5",       "ebay_kw":"Mirror Platinum Mixorama"},
  {"label":"Mirror Platinum Black /1",          "ebay_kw":"Mirror Platinum Black"},
  {"label":"Mirror Platinum Nebula /1",         "ebay_kw":"Mirror Platinum Nebula"},
  {"label":"Rookie Auto Mirror",                "ebay_kw":"Certified Rookie Auto Mirror"},
  {"label":"Rookie Auto Mirror Gold /10",       "ebay_kw":"Certified Rookie Auto Mirror Gold"},
  {"label":"Rookie Auto Mirror Black /1",       "ebay_kw":"Certified Rookie Auto Mirror Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Certified' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- BOWMAN BASKETBALL (2025-26 product — Topps-era, full chrome parallel structure)
-- FIX: Was generic placeholder; rebuild with actual 2025-26 Bowman parallels
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":"Bowman Basketball"},
  {"label":"Purple Border /199",            "ebay_kw":"Bowman Purple"},
  {"label":"Pink Border /175",              "ebay_kw":"Bowman Pink"},
  {"label":"Blue Border /150",              "ebay_kw":"Bowman Blue"},
  {"label":"Green Border /99",              "ebay_kw":"Bowman Green"},
  {"label":"Yellow Border /75",             "ebay_kw":"Bowman Yellow"},
  {"label":"Gold Border /50",               "ebay_kw":"Bowman Gold"},
  {"label":"Orange Border /25",             "ebay_kw":"Bowman Orange"},
  {"label":"Black Border /10",              "ebay_kw":"Bowman Black"},
  {"label":"Red Border /5",                 "ebay_kw":"Bowman Red"},
  {"label":"Platinum Border /1",            "ebay_kw":"Bowman Platinum"},
  {"label":"Chrome Refractor /499",         "ebay_kw":"Bowman Chrome Refractor"},
  {"label":"Chrome Speckle /299",           "ebay_kw":"Bowman Chrome Speckle"},
  {"label":"Chrome Purple /250",            "ebay_kw":"Bowman Chrome Purple"},
  {"label":"Chrome Fuchsia /199",           "ebay_kw":"Bowman Chrome Fuchsia"},
  {"label":"Chrome Blue /150",              "ebay_kw":"Bowman Chrome Blue"},
  {"label":"Chrome Steel Metal /100",       "ebay_kw":"Bowman Chrome Steel Metal"},
  {"label":"Chrome Yellow /75",             "ebay_kw":"Bowman Chrome Yellow"},
  {"label":"Chrome Gold /50",               "ebay_kw":"Bowman Chrome Gold"},
  {"label":"Chrome Orange /25",             "ebay_kw":"Bowman Chrome Orange"},
  {"label":"Chrome Rose Gold /15",          "ebay_kw":"Bowman Chrome Rose Gold"},
  {"label":"Chrome Black /10",              "ebay_kw":"Bowman Chrome Black"},
  {"label":"Chrome Red /5",                 "ebay_kw":"Bowman Chrome Red"},
  {"label":"Chrome FireFractor /3",         "ebay_kw":"Bowman Chrome FireFractor"},
  {"label":"Chrome SuperFractor /1",        "ebay_kw":"Bowman Chrome SuperFractor"},
  {"label":"Prospect Auto",                 "ebay_kw":"Bowman Prospect Auto"},
  {"label":"Prospect Auto Refractor /499",  "ebay_kw":"Bowman Prospect Auto Refractor"},
  {"label":"Prospect Auto Blue /150",       "ebay_kw":"Bowman Prospect Auto Blue"},
  {"label":"Prospect Auto Gold /50",        "ebay_kw":"Bowman Prospect Auto Gold"},
  {"label":"Prospect Auto Orange /25",      "ebay_kw":"Bowman Prospect Auto Orange"},
  {"label":"Prospect Auto Red /5",          "ebay_kw":"Bowman Prospect Auto Red"},
  {"label":"Prospect Auto SuperFractor /1", "ebay_kw":"Bowman Prospect Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Basketball' AND sport = 'basketball' AND year >= 2025;

-- ─────────────────────────────────────────────────────────────────────────────
-- TOPPS CHROME BASKETBALL (2025-26 product)
-- EXPAND: Was 16 parallels; real product has 25+ including Wave parallels
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base Chrome",               "ebay_kw":"Topps Chrome Basketball"},
  {"label":"Refractor",                 "ebay_kw":"Chrome Refractor"},
  {"label":"Prism Refractor",           "ebay_kw":"Chrome Prism Refractor"},
  {"label":"Negative Refractor",        "ebay_kw":"Chrome Negative Refractor"},
  {"label":"Magenta /399",              "ebay_kw":"Chrome Magenta Refractor"},
  {"label":"Teal /299",                 "ebay_kw":"Chrome Teal Refractor"},
  {"label":"Yellow /275",               "ebay_kw":"Chrome Yellow Refractor"},
  {"label":"Aqua /199",                 "ebay_kw":"Chrome Aqua Refractor"},
  {"label":"Blue /150",                 "ebay_kw":"Chrome Blue Refractor"},
  {"label":"Green /99",                 "ebay_kw":"Chrome Green Refractor"},
  {"label":"Purple /75",                "ebay_kw":"Chrome Purple Refractor"},
  {"label":"Gold /50",                  "ebay_kw":"Chrome Gold Refractor"},
  {"label":"Orange /25",                "ebay_kw":"Chrome Orange Refractor"},
  {"label":"Black /10",                 "ebay_kw":"Chrome Black Refractor"},
  {"label":"Red /5",                    "ebay_kw":"Chrome Red Refractor"},
  {"label":"FrozenFractor /5",          "ebay_kw":"FrozenFractor"},
  {"label":"SuperFractor /1",           "ebay_kw":"Chrome SuperFractor"},
  {"label":"Blue Wave /150",            "ebay_kw":"Chrome Blue Wave"},
  {"label":"Green Wave /99",            "ebay_kw":"Chrome Green Wave"},
  {"label":"Gold Wave /50",             "ebay_kw":"Chrome Gold Wave"},
  {"label":"Orange Wave /25",           "ebay_kw":"Chrome Orange Wave"},
  {"label":"Speckle Green /99",         "ebay_kw":"Chrome Speckle Green"},
  {"label":"Pulsar Refractor",          "ebay_kw":"Chrome Pulsar"},
  {"label":"Auto Refractor /150",       "ebay_kw":"Chrome Auto Refractor"},
  {"label":"Auto Blue /150",            "ebay_kw":"Chrome Auto Blue"},
  {"label":"Auto Green /99",            "ebay_kw":"Chrome Auto Green"},
  {"label":"Auto Purple /75",           "ebay_kw":"Chrome Auto Purple"},
  {"label":"Auto Gold /50",             "ebay_kw":"Chrome Auto Gold"},
  {"label":"Auto Orange /25",           "ebay_kw":"Chrome Auto Orange"},
  {"label":"Auto Black /10",            "ebay_kw":"Chrome Auto Black"},
  {"label":"Auto Red /5",               "ebay_kw":"Chrome Auto Red"},
  {"label":"Auto SuperFractor /1",      "ebay_kw":"Chrome Auto SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome Basketball' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- BOWMAN CHROME BASEBALL — Prospect Auto parallels (was missing many)
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base Chrome",                       "ebay_kw":"Bowman Chrome"},
  {"label":"Refractor",                         "ebay_kw":"Bowman Chrome Refractor"},
  {"label":"Atomic Refractor",                  "ebay_kw":"Bowman Atomic"},
  {"label":"X-Fractor",                         "ebay_kw":"Bowman X-Fractor"},
  {"label":"Purple /250",                       "ebay_kw":"Bowman Chrome Purple"},
  {"label":"Blue /150",                         "ebay_kw":"Bowman Chrome Blue"},
  {"label":"Aqua /125",                         "ebay_kw":"Bowman Chrome Aqua"},
  {"label":"Green /99",                         "ebay_kw":"Bowman Chrome Green"},
  {"label":"Yellow /75",                        "ebay_kw":"Bowman Chrome Yellow"},
  {"label":"Gold /50",                          "ebay_kw":"Bowman Chrome Gold"},
  {"label":"Orange /25",                        "ebay_kw":"Bowman Chrome Orange"},
  {"label":"Rose Gold /15",                     "ebay_kw":"Bowman Chrome Rose Gold"},
  {"label":"Black /10",                         "ebay_kw":"Bowman Chrome Black"},
  {"label":"Red /5",                            "ebay_kw":"Bowman Chrome Red"},
  {"label":"FireFractor /3",                    "ebay_kw":"Bowman FireFractor"},
  {"label":"SuperFractor /1",                   "ebay_kw":"Bowman Chrome SuperFractor"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Bowman Chrome Printing Plate"},
  {"label":"Chrome Prospect Auto",              "ebay_kw":"Bowman Chrome Prospect Auto"},
  {"label":"Prospect Auto Refractor /499",      "ebay_kw":"Bowman Prospect Auto Refractor"},
  {"label":"Prospect Auto Blue /150",           "ebay_kw":"Bowman Prospect Auto Blue"},
  {"label":"Prospect Auto Mini-Diamond /100",   "ebay_kw":"Bowman Prospect Auto Mini-Diamond"},
  {"label":"Prospect Auto Yellow /75",          "ebay_kw":"Bowman Prospect Auto Yellow"},
  {"label":"Prospect Auto Gold /50",            "ebay_kw":"Bowman Prospect Auto Gold"},
  {"label":"Prospect Auto Orange /25",          "ebay_kw":"Bowman Prospect Auto Orange"},
  {"label":"Prospect Auto Red /5",              "ebay_kw":"Bowman Prospect Auto Red"},
  {"label":"Prospect Auto SuperFractor /1",     "ebay_kw":"Bowman Prospect Auto SuperFractor"},
  {"label":"Prospect Auto Printing Plate /1",   "ebay_kw":"Bowman Prospect Auto Plate"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'baseball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI NATIONAL TREASURES BASKETBALL — Expand RPA parallels
-- FIX: Was missing full RPA numbered structure
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":"NT"},
  {"label":"Holo Silver /99",           "ebay_kw":"NT Holo Silver"},
  {"label":"Holo Gold /25",             "ebay_kw":"NT Holo Gold"},
  {"label":"Holo Black /5",             "ebay_kw":"NT Holo Black"},
  {"label":"Logoman /1",                "ebay_kw":"NT Logoman"},
  {"label":"Printing Plate /1",         "ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99",             "ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10",        "ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1",        "ebay_kw":"NT Signature Black"},
  {"label":"RPA /99",                   "ebay_kw":"NT RPA"},
  {"label":"RPA Orange /75",            "ebay_kw":"NT RPA Orange"},
  {"label":"RPA Bronze /49",            "ebay_kw":"NT RPA Bronze"},
  {"label":"RPA Pink /25",              "ebay_kw":"NT RPA Pink"},
  {"label":"RPA Gold /10",              "ebay_kw":"NT RPA Gold"},
  {"label":"RPA Emerald /5",            "ebay_kw":"NT RPA Emerald"},
  {"label":"RPA Black /3",              "ebay_kw":"NT RPA Black"},
  {"label":"RPA Logoman /1",            "ebay_kw":"NT RPA Logoman"},
  {"label":"Dual RPA",                  "ebay_kw":"NT Dual RPA"},
  {"label":"Shield /1",                 "ebay_kw":"NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI NATIONAL TREASURES FOOTBALL — same RPA structure
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":"NT"},
  {"label":"Holo Silver /99",           "ebay_kw":"NT Holo Silver"},
  {"label":"Holo Gold /25",             "ebay_kw":"NT Holo Gold"},
  {"label":"Holo Black /5",             "ebay_kw":"NT Holo Black"},
  {"label":"Logoman /1",                "ebay_kw":"NT Logoman"},
  {"label":"Printing Plate /1",         "ebay_kw":"NT Printing Plate"},
  {"label":"Signature /99",             "ebay_kw":"NT Signature"},
  {"label":"Signature Gold /10",        "ebay_kw":"NT Signature Gold"},
  {"label":"Signature Black /1",        "ebay_kw":"NT Signature Black"},
  {"label":"RPA /99",                   "ebay_kw":"NT RPA"},
  {"label":"RPA Orange /75",            "ebay_kw":"NT RPA Orange"},
  {"label":"RPA Bronze /49",            "ebay_kw":"NT RPA Bronze"},
  {"label":"RPA Pink /25",              "ebay_kw":"NT RPA Pink"},
  {"label":"RPA Gold /10",              "ebay_kw":"NT RPA Gold"},
  {"label":"RPA Emerald /5",            "ebay_kw":"NT RPA Emerald"},
  {"label":"RPA Black /3",              "ebay_kw":"NT RPA Black"},
  {"label":"RPA Logoman /1",            "ebay_kw":"NT RPA Logoman"},
  {"label":"Dual RPA",                  "ebay_kw":"NT Dual RPA"},
  {"label":"Shield /1",                 "ebay_kw":"NT Shield"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- UPPER DECK SP AUTHENTIC HOCKEY — Expand with Future Watch structure
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":"SP Authentic"},
  {"label":"Limited Red",                       "ebay_kw":"SP Authentic Limited Red"},
  {"label":"Limited Blue /399",                 "ebay_kw":"SP Authentic Limited Blue"},
  {"label":"Limited Green /199",                "ebay_kw":"SP Authentic Limited Green"},
  {"label":"Limited Gold /99",                  "ebay_kw":"SP Authentic Limited Gold"},
  {"label":"Limited Black /1",                  "ebay_kw":"SP Authentic Limited Black"},
  {"label":"Future Watch Auto /999",            "ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Blue /399",       "ebay_kw":"Future Watch Auto Blue"},
  {"label":"Future Watch Auto Green /199",      "ebay_kw":"Future Watch Auto Green"},
  {"label":"Future Watch Auto Gold /99",        "ebay_kw":"Future Watch Auto Gold"},
  {"label":"Future Watch Auto Black /1",        "ebay_kw":"Future Watch Auto Black"},
  {"label":"Auto Patch /100",                   "ebay_kw":"SP Authentic Auto Patch"},
  {"label":"Auto Limited Material /49",         "ebay_kw":"SP Authentic Limited Auto Material"},
  {"label":"Sign of the Times Auto",            "ebay_kw":"Sign of the Times Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI DONRUSS OPTIC BASKETBALL — Expand with key numbered parallels
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":"Donruss Optic"},
  {"label":"Holo",                              "ebay_kw":"Optic Holo"},
  {"label":"Hyper",                             "ebay_kw":"Optic Hyper"},
  {"label":"Fast Break Holo",                   "ebay_kw":"Optic Fast Break Holo"},
  {"label":"Hyper Orange /299",                 "ebay_kw":"Optic Hyper Orange"},
  {"label":"Orange /175",                       "ebay_kw":"Optic Orange"},
  {"label":"Red Seismic /149",                  "ebay_kw":"Optic Red Seismic"},
  {"label":"Red /99",                           "ebay_kw":"Optic Red"},
  {"label":"Fast Break Red /75",                "ebay_kw":"Optic Fast Break Red"},
  {"label":"Blue /49",                          "ebay_kw":"Optic Blue"},
  {"label":"Fast Break Blue /49",               "ebay_kw":"Optic Fast Break Blue"},
  {"label":"Cracked Ice /25",                   "ebay_kw":"Optic Cracked Ice"},
  {"label":"Pink /25",                          "ebay_kw":"Optic Pink"},
  {"label":"Gold /10",                          "ebay_kw":"Optic Gold"},
  {"label":"Fast Break Gold /10",               "ebay_kw":"Optic Fast Break Gold"},
  {"label":"Green /5",                          "ebay_kw":"Optic Green"},
  {"label":"Black /1",                          "ebay_kw":"Optic Black"},
  {"label":"Gold Vinyl /1",                     "ebay_kw":"Optic Gold Vinyl"},
  {"label":"Rated Rookie Auto Silver",          "ebay_kw":"Rated Rookie Auto Silver Optic"},
  {"label":"Rated Rookie Auto Red /99",         "ebay_kw":"Rated Rookie Auto Red Optic"},
  {"label":"Rated Rookie Auto Blue /49",        "ebay_kw":"Rated Rookie Auto Blue Optic"},
  {"label":"Rated Rookie Auto Cracked Ice /25", "ebay_kw":"Rated Rookie Auto Cracked Ice Optic"},
  {"label":"Rated Rookie Auto Pink /25",        "ebay_kw":"Rated Rookie Auto Pink Optic"},
  {"label":"Rated Rookie Auto Gold /10",        "ebay_kw":"Rated Rookie Auto Gold Optic"},
  {"label":"Rated Rookie Auto Green /5",        "ebay_kw":"Rated Rookie Auto Green Optic"},
  {"label":"Rated Rookie Auto Black /1",        "ebay_kw":"Rated Rookie Auto Black Optic"},
  {"label":"Rated Rookie Auto Gold Vinyl /1",   "ebay_kw":"Rated Rookie Auto Gold Vinyl Optic"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball';

-- ─────────────────────────────────────────────────────────────────────────────
-- PANINI DONRUSS OPTIC FOOTBALL — same structure
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                      "ebay_kw":"Donruss Optic"},
  {"label":"Holo",                                      "ebay_kw":"Optic Holo"},
  {"label":"Hyper",                                     "ebay_kw":"Optic Hyper"},
  {"label":"Fast Break Holo",                           "ebay_kw":"Optic Fast Break Holo"},
  {"label":"Hyper Orange /299",                         "ebay_kw":"Optic Hyper Orange"},
  {"label":"Orange /175",                               "ebay_kw":"Optic Orange"},
  {"label":"Red Seismic /149",                          "ebay_kw":"Optic Red Seismic"},
  {"label":"Red /99",                                   "ebay_kw":"Optic Red"},
  {"label":"Fast Break Red /75",                        "ebay_kw":"Optic Fast Break Red"},
  {"label":"Blue /49",                                  "ebay_kw":"Optic Blue"},
  {"label":"Fast Break Blue /49",                       "ebay_kw":"Optic Fast Break Blue"},
  {"label":"Cracked Ice /25",                           "ebay_kw":"Optic Cracked Ice"},
  {"label":"Pink /25",                                  "ebay_kw":"Optic Pink"},
  {"label":"Gold /10",                                  "ebay_kw":"Optic Gold"},
  {"label":"Fast Break Gold /10",                       "ebay_kw":"Optic Fast Break Gold"},
  {"label":"Green /5",                                  "ebay_kw":"Optic Green"},
  {"label":"Black /1",                                  "ebay_kw":"Optic Black"},
  {"label":"Gold Vinyl /1",                             "ebay_kw":"Optic Gold Vinyl"},
  {"label":"Rated Rookie Auto Silver",                  "ebay_kw":"Rated Rookie Auto Silver Optic"},
  {"label":"Rated Rookie Auto Red /99",                 "ebay_kw":"Rated Rookie Auto Red Optic"},
  {"label":"Rated Rookie Auto Blue /49",                "ebay_kw":"Rated Rookie Auto Blue Optic"},
  {"label":"Rated Rookie Auto Cracked Ice /25",         "ebay_kw":"Rated Rookie Auto Cracked Ice Optic"},
  {"label":"Rated Rookie Auto Pink /25",                "ebay_kw":"Rated Rookie Auto Pink Optic"},
  {"label":"Rated Rookie Auto Gold /10",                "ebay_kw":"Rated Rookie Auto Gold Optic"},
  {"label":"Rated Rookie Auto Green /5",                "ebay_kw":"Rated Rookie Auto Green Optic"},
  {"label":"Rated Rookie Auto Black /1",                "ebay_kw":"Rated Rookie Auto Black Optic"},
  {"label":"Rated Rookie Auto Gold Vinyl /1",           "ebay_kw":"Rated Rookie Auto Gold Vinyl Optic"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football';

-- ─────────────────────────────────────────────────────────────────────────────
-- ADD: UPPER DECK HOCKEY SERIES 1 / SERIES 2 (base UD Hockey product)
-- These are the most widely collected hockey sets — were MISSING from DB
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', yr, 'Upper Deck', 'Hockey',
'[
  {"label":"Base",                    "ebay_kw":"Upper Deck Hockey"},
  {"label":"Outburst Silver",         "ebay_kw":"UD Outburst Silver"},
  {"label":"Clear Cut",               "ebay_kw":"UD Clear Cut"},
  {"label":"Deluxe /250",             "ebay_kw":"UD Deluxe"},
  {"label":"Exclusives /100",         "ebay_kw":"UD Exclusives"},
  {"label":"Outburst Red /25",        "ebay_kw":"UD Outburst Red"},
  {"label":"High Gloss /10",          "ebay_kw":"UD High Gloss"},
  {"label":"Outburst Gold /1",        "ebay_kw":"UD Outburst Gold"},
  {"label":"Printing Plate /1",       "ebay_kw":"UD Printing Plate"},
  {"label":"Young Guns",              "ebay_kw":"Upper Deck Young Guns"},
  {"label":"Young Guns Exclusives /100","ebay_kw":"Young Guns Exclusives"},
  {"label":"Young Guns High Gloss /10","ebay_kw":"Young Guns High Gloss"},
  {"label":"Young Guns Outburst Gold /1","ebay_kw":"Young Guns Outburst Gold"},
  {"label":"Canvas",                  "ebay_kw":"UD Canvas"}
]'::jsonb
FROM generate_series(2000, 2025) AS yr
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- ADD: O-PEE-CHEE PLATINUM HOCKEY (chrome-style product, different from base OPC)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'hockey', yr, 'Upper Deck', 'O-Pee-Chee Platinum',
'[
  {"label":"Base",                    "ebay_kw":"OPC Platinum"},
  {"label":"Rainbow",                 "ebay_kw":"OPC Platinum Rainbow"},
  {"label":"Blue Luster /100",        "ebay_kw":"OPC Platinum Blue Luster"},
  {"label":"Houndstooth /15",         "ebay_kw":"OPC Platinum Houndstooth"},
  {"label":"Golden Treasures /1",     "ebay_kw":"OPC Platinum Golden Treasures"},
  {"label":"Red Auto",                "ebay_kw":"OPC Platinum Red Auto"},
  {"label":"Blue Auto /100",          "ebay_kw":"OPC Platinum Blue Auto"},
  {"label":"Gold Auto /50",           "ebay_kw":"OPC Platinum Gold Auto"},
  {"label":"Black Auto /1",           "ebay_kw":"OPC Platinum Black Auto"},
  {"label":"Marquee Rookies",         "ebay_kw":"OPC Platinum Marquee Rookies"},
  {"label":"Rookie Patch Auto",       "ebay_kw":"OPC Platinum RPA"},
  {"label":"RPA Gold /50",            "ebay_kw":"OPC Platinum RPA Gold"},
  {"label":"RPA Black /1",            "ebay_kw":"OPC Platinum RPA Black"}
]'::jsonb
FROM generate_series(2010, 2025) AS yr
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- ADD: PANINI CONTENDERS OPTIC (basketball/football) — was missing entirely
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'basketball', yr, 'Panini', 'Contenders Optic',
'[
  {"label":"Base",                                    "ebay_kw":"Contenders Optic"},
  {"label":"Optic Prizm",                             "ebay_kw":"Contenders Optic Prizm"},
  {"label":"Optic Gold Prizm /10",                    "ebay_kw":"Contenders Optic Gold"},
  {"label":"Rookie Ticket Auto",                      "ebay_kw":"Contenders Optic Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",      "ebay_kw":"Contenders Optic Cracked Ice"},
  {"label":"Rookie Ticket Auto Gold /10",             "ebay_kw":"Contenders Optic Gold Auto"},
  {"label":"Rookie Ticket Auto Black /1",             "ebay_kw":"Contenders Optic Black Auto"},
  {"label":"Championship Ticket /1",                  "ebay_kw":"Contenders Optic Championship"}
]'::jsonb
FROM generate_series(2018, 2024) AS yr
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;

INSERT INTO card_sets (sport, year, brand, set_name, parallels)
SELECT 'football', yr, 'Panini', 'Contenders Optic',
'[
  {"label":"Base",                                    "ebay_kw":"Contenders Optic"},
  {"label":"Optic Prizm",                             "ebay_kw":"Contenders Optic Prizm"},
  {"label":"Optic Gold Prizm /10",                    "ebay_kw":"Contenders Optic Gold"},
  {"label":"Rookie Ticket Auto",                      "ebay_kw":"Contenders Optic Rookie Ticket Auto"},
  {"label":"Rookie Ticket Auto Cracked Ice /25",      "ebay_kw":"Contenders Optic Cracked Ice"},
  {"label":"Rookie Ticket Auto Gold /10",             "ebay_kw":"Contenders Optic Gold Auto"},
  {"label":"Rookie Ticket Auto Black /1",             "ebay_kw":"Contenders Optic Black Auto"},
  {"label":"Championship Ticket /1",                  "ebay_kw":"Contenders Optic Championship"}
]'::jsonb
FROM generate_series(2017, 2024) AS yr
ON CONFLICT (sport, year, brand, set_name) DO NOTHING;
