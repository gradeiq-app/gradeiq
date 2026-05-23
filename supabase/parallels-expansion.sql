-- ─────────────────────────────────────────────────────────────────────────────
-- Parallels Expansion — adds missing RC Autos, Rookie Autos, RPA tiers,
-- patch variants, and retail exclusives across all major product types.
-- Safe to re-run: every statement uses UPDATE … WHERE, no new rows.
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS / BOWMAN CHROME  (baseball, football)
-- Adds RC Auto / Prospect Auto colour parallels
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                       "ebay_kw":""},
  {"label":"Refractor",                  "ebay_kw":"Refractor"},
  {"label":"Negative Refractor",         "ebay_kw":"Negative Refractor"},
  {"label":"X-Fractor",                  "ebay_kw":"X-Fractor"},
  {"label":"Prism Refractor",            "ebay_kw":"Prism Refractor"},
  {"label":"Speckle Refractor /299",     "ebay_kw":"Speckle Refractor"},
  {"label":"Pink Refractor /199",        "ebay_kw":"Pink Refractor"},
  {"label":"Blue Wave Refractor /150",   "ebay_kw":"Blue Wave Refractor"},
  {"label":"Green Refractor /99",        "ebay_kw":"Green Refractor"},
  {"label":"Yellow Refractor /75",       "ebay_kw":"Yellow Refractor"},
  {"label":"Sepia Refractor /75",        "ebay_kw":"Sepia Refractor"},
  {"label":"Gold Refractor /50",         "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",       "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",           "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",            "ebay_kw":"Superfractor"},
  {"label":"Black Refractor",            "ebay_kw":"Black Refractor"},
  {"label":"RC Auto",                    "ebay_kw":"RC Auto"},
  {"label":"RC Auto Refractor",          "ebay_kw":"RC Auto Refractor"},
  {"label":"RC Auto Blue /150",          "ebay_kw":"RC Auto Blue Refractor"},
  {"label":"RC Auto Gold /50",           "ebay_kw":"RC Auto Gold Refractor"},
  {"label":"RC Auto Orange /25",         "ebay_kw":"RC Auto Orange Refractor"},
  {"label":"RC Auto Red /5",             "ebay_kw":"RC Auto Red Refractor"},
  {"label":"RC Auto SuperFractor /1",    "ebay_kw":"RC Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome';

-- Bowman Chrome — add Prospect Auto parallels
UPDATE card_sets SET parallels = '[
  {"label":"Base",                           "ebay_kw":""},
  {"label":"Refractor",                      "ebay_kw":"Refractor"},
  {"label":"Negative Refractor",             "ebay_kw":"Negative Refractor"},
  {"label":"X-Fractor",                      "ebay_kw":"X-Fractor"},
  {"label":"Scouts Top 100",                 "ebay_kw":"Scouts Top 100"},
  {"label":"Speckle Refractor /299",         "ebay_kw":"Speckle Refractor"},
  {"label":"Pink Refractor /250",            "ebay_kw":"Pink Refractor"},
  {"label":"Blue Refractor /150",            "ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99",            "ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50",             "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",           "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",               "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",                "ebay_kw":"Superfractor"},
  {"label":"1st Bowman Chrome",              "ebay_kw":"1st Bowman"},
  {"label":"Prospect Auto",                  "ebay_kw":"Prospect Auto"},
  {"label":"Prospect Auto Refractor",        "ebay_kw":"Prospect Auto Refractor"},
  {"label":"Prospect Auto Blue /150",        "ebay_kw":"Prospect Auto Blue Refractor"},
  {"label":"Prospect Auto Purple /250",      "ebay_kw":"Prospect Auto Purple Refractor"},
  {"label":"Prospect Auto Gold /50",         "ebay_kw":"Prospect Auto Gold Refractor"},
  {"label":"Prospect Auto Orange /25",       "ebay_kw":"Prospect Auto Orange Refractor"},
  {"label":"Prospect Auto Red /5",           "ebay_kw":"Prospect Auto Red Refractor"},
  {"label":"Prospect Auto SuperFractor /1",  "ebay_kw":"Prospect Auto Superfractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome';

-- Bowman Draft Chrome — same auto structure
UPDATE card_sets SET parallels = '[
  {"label":"Base",                           "ebay_kw":""},
  {"label":"Refractor",                      "ebay_kw":"Refractor"},
  {"label":"Negative Refractor",             "ebay_kw":"Negative Refractor"},
  {"label":"X-Fractor",                      "ebay_kw":"X-Fractor"},
  {"label":"Speckle Refractor /299",         "ebay_kw":"Speckle Refractor"},
  {"label":"Pink Refractor /250",            "ebay_kw":"Pink Refractor"},
  {"label":"Blue Refractor /150",            "ebay_kw":"Blue Refractor"},
  {"label":"Green Refractor /99",            "ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50",             "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",           "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",               "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",                "ebay_kw":"Superfractor"},
  {"label":"Draft Pick Auto",                "ebay_kw":"Draft Pick Auto"},
  {"label":"Draft Pick Auto Refractor",      "ebay_kw":"Draft Pick Auto Refractor"},
  {"label":"Draft Pick Auto Blue /150",      "ebay_kw":"Draft Pick Auto Blue Refractor"},
  {"label":"Draft Pick Auto Gold /50",       "ebay_kw":"Draft Pick Auto Gold Refractor"},
  {"label":"Draft Pick Auto Orange /25",     "ebay_kw":"Draft Pick Auto Orange Refractor"},
  {"label":"Draft Pick Auto Red /5",         "ebay_kw":"Draft Pick Auto Red Refractor"},
  {"label":"Draft Pick Auto SuperFractor /1","ebay_kw":"Draft Pick Auto Superfractor"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM  (all sports — adds Rookie Auto colour tree)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                           "ebay_kw":""},
  {"label":"Silver Prizm",                   "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                    "ebay_kw":"Hyper Prizm"},
  {"label":"Scope Prizm",                    "ebay_kw":"Scope Prizm"},
  {"label":"Fast Break Prizm",               "ebay_kw":"Fast Break Prizm"},
  {"label":"Ice Prizm",                      "ebay_kw":"Ice Prizm"},
  {"label":"Disco Prizm",                    "ebay_kw":"Disco Prizm"},
  {"label":"Tiger Stripe Prizm",             "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Red White Blue Prizm",           "ebay_kw":"Red White Blue Prizm"},
  {"label":"Neon Green Prizm /75",           "ebay_kw":"Neon Green Prizm"},
  {"label":"Luck of the Irish",              "ebay_kw":"Luck of the Irish"},
  {"label":"Cracked Ice Prizm /25",          "ebay_kw":"Cracked Ice Prizm"},
  {"label":"Blue Ice Prizm /225",            "ebay_kw":"Blue Ice Prizm"},
  {"label":"Blue Prizm /199",                "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                  "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",               "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                 "ebay_kw":"Pink Prizm"},
  {"label":"Gold Prizm /10",                 "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                 "ebay_kw":"Black Prizm"},
  {"label":"Rookie Auto Silver",             "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /149",           "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",           "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Green /75",          "ebay_kw":"Rookie Auto Green Prizm"},
  {"label":"Rookie Auto Purple /49",         "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Pink /35",           "ebay_kw":"Rookie Auto Pink Prizm"},
  {"label":"Rookie Auto Gold /10",           "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",           "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM DRAFT PICKS  (football, basketball)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                         "ebay_kw":""},
  {"label":"Silver Prizm",                 "ebay_kw":"Silver Prizm"},
  {"label":"Neon Green Prizm /75",         "ebay_kw":"Neon Green Prizm"},
  {"label":"Cracked Ice Prizm /25",        "ebay_kw":"Cracked Ice Prizm"},
  {"label":"Blue Prizm /199",              "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /149",               "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /99",              "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",             "ebay_kw":"Purple Prizm"},
  {"label":"Orange Prizm /25",             "ebay_kw":"Orange Prizm"},
  {"label":"Gold Prizm /10",               "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",               "ebay_kw":"Black Prizm"},
  {"label":"Draft Auto Silver",            "ebay_kw":"Draft Auto Silver Prizm"},
  {"label":"Draft Auto Blue /99",          "ebay_kw":"Draft Auto Blue Prizm"},
  {"label":"Draft Auto Gold /10",          "ebay_kw":"Draft Auto Gold Prizm"},
  {"label":"Draft Auto Black /1",          "ebay_kw":"Draft Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm Draft Picks';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SELECT  (all sports — adds RPA tiers)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Concourse",                        "ebay_kw":"Concourse"},
  {"label":"Premier Level",                    "ebay_kw":"Premier Level"},
  {"label":"Courtside",                        "ebay_kw":"Courtside"},
  {"label":"Silver Prizm",                     "ebay_kw":"Silver Prizm"},
  {"label":"Field Level",                      "ebay_kw":"Field Level"},
  {"label":"Blue /249",                        "ebay_kw":"Blue"},
  {"label":"Orange /199",                      "ebay_kw":"Orange"},
  {"label":"Red /99",                          "ebay_kw":"Red"},
  {"label":"Green /75",                        "ebay_kw":"Green"},
  {"label":"Purple /49",                       "ebay_kw":"Purple"},
  {"label":"Pink /35",                         "ebay_kw":"Pink"},
  {"label":"Gold /25",                         "ebay_kw":"Gold"},
  {"label":"Black /1",                         "ebay_kw":"Black"},
  {"label":"Die-Cut Silver Prizm",             "ebay_kw":"Die Cut Silver Prizm"},
  {"label":"Rookie Patch Auto (Concourse)",    "ebay_kw":"Rookie Patch Auto Concourse"},
  {"label":"Rookie Patch Auto (Premier)",      "ebay_kw":"Rookie Patch Auto Premier Level"},
  {"label":"Rookie Patch Auto (Courtside)",    "ebay_kw":"Rookie Patch Auto Courtside"},
  {"label":"RPA Silver Prizm",                 "ebay_kw":"Rookie Patch Auto Silver Prizm"},
  {"label":"RPA Blue /99",                     "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"RPA Purple /49",                   "ebay_kw":"Rookie Patch Auto Purple"},
  {"label":"RPA Gold /25",                     "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Black /1",                     "ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Tri-Color Rookie Patch Auto",      "ebay_kw":"Tri-Color Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Select';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI NATIONAL TREASURES  (football, basketball, hockey)
-- Full RPA / patch / logoman structure
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base /99",                        "ebay_kw":""},
  {"label":"Holo Silver /49",                 "ebay_kw":"Holo Silver"},
  {"label":"Holo Gold /25",                   "ebay_kw":"Holo Gold"},
  {"label":"Emerald /5",                      "ebay_kw":"Emerald"},
  {"label":"Black /1",                        "ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99",           "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Holo Silver /49",             "ebay_kw":"RPA Holo Silver"},
  {"label":"RPA Holo Gold /25",               "ebay_kw":"RPA Holo Gold"},
  {"label":"RPA Emerald /5",                  "ebay_kw":"RPA Emerald"},
  {"label":"RPA Black /1",                    "ebay_kw":"RPA Black"},
  {"label":"Shield Patch Auto /1",            "ebay_kw":"Shield Patch Auto"},
  {"label":"Logoman Patch Auto /1",           "ebay_kw":"Logoman Patch Auto"},
  {"label":"Jersey Autograph /99",            "ebay_kw":"Jersey Autograph"},
  {"label":"Printing Plate /1",               "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'National Treasures';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS OPTIC  (football, basketball)
-- Adds Rated Rookie Auto parallels
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Rated Rookie",                  "ebay_kw":"Rated Rookie"},
  {"label":"Holo",                          "ebay_kw":"Holo"},
  {"label":"Blue /149",                     "ebay_kw":"Blue"},
  {"label":"Orange /199",                   "ebay_kw":"Orange"},
  {"label":"Pink /149",                     "ebay_kw":"Pink"},
  {"label":"Red /99",                       "ebay_kw":"Red"},
  {"label":"Purple /75",                    "ebay_kw":"Purple"},
  {"label":"Gold /10",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Aqua",                          "ebay_kw":"Aqua"},
  {"label":"Lime Green /149",               "ebay_kw":"Lime Green"},
  {"label":"Shock",                         "ebay_kw":"Shock"},
  {"label":"Velocity",                      "ebay_kw":"Velocity"},
  {"label":"Rated Rookie Auto",             "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Holo",        "ebay_kw":"Rated Rookie Auto Holo"},
  {"label":"Rated Rookie Auto Blue /149",   "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /99",     "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Purple /75",  "ebay_kw":"Rated Rookie Auto Purple"},
  {"label":"Rated Rookie Auto Gold /10",    "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",    "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS  (football, basketball)
-- Adds Press Proof Auto and Rated Rookie Auto
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                     "ebay_kw":""},
  {"label":"Rated Rookie",             "ebay_kw":"Rated Rookie"},
  {"label":"Press Proof /99",          "ebay_kw":"Press Proof"},
  {"label":"Pink /149",                "ebay_kw":"Pink"},
  {"label":"Blue /149",                "ebay_kw":"Blue"},
  {"label":"Red /99",                  "ebay_kw":"Red"},
  {"label":"Purple /49",               "ebay_kw":"Purple"},
  {"label":"Gold /25",                 "ebay_kw":"Gold"},
  {"label":"Holo Gold",                "ebay_kw":"Holo Gold"},
  {"label":"Black /1",                 "ebay_kw":"Black"},
  {"label":"Rated Rookie Auto",        "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Red /99","ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Gold /25","ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1","ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI MOSAIC  (football, basketball)
-- Adds Rookie Auto / Genesis Prizm
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                         "ebay_kw":""},
  {"label":"Silver Prizm",                 "ebay_kw":"Silver Prizm"},
  {"label":"Mosaic Camo",                  "ebay_kw":"Mosaic Camo"},
  {"label":"Pink Camo",                    "ebay_kw":"Pink Camo"},
  {"label":"Reactive Blue",                "ebay_kw":"Reactive Blue"},
  {"label":"Reactive Orange",              "ebay_kw":"Reactive Orange"},
  {"label":"Reactive Yellow",              "ebay_kw":"Reactive Yellow"},
  {"label":"Genesis Prizm",                "ebay_kw":"Genesis Prizm"},
  {"label":"Color Blast",                  "ebay_kw":"Color Blast"},
  {"label":"Green /199",                   "ebay_kw":"Green Mosaic"},
  {"label":"Blue /149",                    "ebay_kw":"Blue"},
  {"label":"Red /99",                      "ebay_kw":"Red"},
  {"label":"Purple /49",                   "ebay_kw":"Purple"},
  {"label":"Gold /10",                     "ebay_kw":"Gold"},
  {"label":"Black /1",                     "ebay_kw":"Black"},
  {"label":"Rookie Auto Silver",           "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Blue /149",        "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",          "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /10",         "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",         "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CONTENDERS  (football, basketball)
-- Adds RPS Rookie Ticket numbering clarity
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                           "ebay_kw":""},
  {"label":"Rookie Ticket RPS Auto",         "ebay_kw":"Rookie Ticket Auto"},
  {"label":"Playoff Ticket /99",             "ebay_kw":"Playoff Ticket"},
  {"label":"Wild Card Ticket /49",           "ebay_kw":"Wild Card Ticket"},
  {"label":"Championship Ticket /25",        "ebay_kw":"Championship Ticket"},
  {"label":"Super Bowl Ticket /10",          "ebay_kw":"Super Bowl Ticket"},
  {"label":"Cracked Ice /21",                "ebay_kw":"Cracked Ice"},
  {"label":"Variation",                      "ebay_kw":"Variation"},
  {"label":"Optic /50",                      "ebay_kw":"Optic"},
  {"label":"Optic Pink /25",                 "ebay_kw":"Optic Pink"},
  {"label":"Optic Blue /10",                 "ebay_kw":"Optic Blue"},
  {"label":"Veteran Ticket",                 "ebay_kw":"Veteran Ticket"},
  {"label":"Printing Plate /1",              "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SPECTRA  (football, basketball)
-- Adds Neon Auto and patch auto tiers
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                       "ebay_kw":""},
  {"label":"Light Blue /199",            "ebay_kw":"Light Blue"},
  {"label":"Red /99",                    "ebay_kw":"Red"},
  {"label":"Green /49",                  "ebay_kw":"Green"},
  {"label":"Gold /25",                   "ebay_kw":"Gold"},
  {"label":"Neon Green /5",              "ebay_kw":"Neon Green"},
  {"label":"Black /1",                   "ebay_kw":"Black"},
  {"label":"Neon Auto /99",              "ebay_kw":"Neon Auto"},
  {"label":"Red Auto /99",               "ebay_kw":"Red Auto"},
  {"label":"Carolina Blue Auto /49",     "ebay_kw":"Carolina Blue Auto"},
  {"label":"Gold Auto /25",              "ebay_kw":"Gold Auto"},
  {"label":"Neon Green Auto /5",         "ebay_kw":"Neon Green Auto"},
  {"label":"Black Auto /1",              "ebay_kw":"Black Auto"},
  {"label":"Rookie Patch Auto /99",      "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /25",               "ebay_kw":"RPA Gold"},
  {"label":"RPA Neon Green /5",          "ebay_kw":"RPA Neon Green"},
  {"label":"RPA Black /1",               "ebay_kw":"RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Spectra';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK SERIES 1 & 2  (hockey)
-- Adds Clear Cut YG, Retro, Oversized YG, RC Auto
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                     "ebay_kw":""},
  {"label":"Young Guns",               "ebay_kw":"Young Guns"},
  {"label":"Canvas",                   "ebay_kw":"Canvas"},
  {"label":"Young Guns Canvas",        "ebay_kw":"Young Guns Canvas"},
  {"label":"Clear Cut Young Guns",     "ebay_kw":"Clear Cut Young Guns"},
  {"label":"Young Guns Oversized /10", "ebay_kw":"Young Guns Oversized"},
  {"label":"Retro",                    "ebay_kw":"Retro"},
  {"label":"Exclusives /100",          "ebay_kw":"Exclusives"},
  {"label":"High Gloss /10",           "ebay_kw":"High Gloss"},
  {"label":"French /100",              "ebay_kw":"French"},
  {"label":"Team Canada",              "ebay_kw":"Team Canada"},
  {"label":"RC Auto",                  "ebay_kw":"RC Auto"},
  {"label":"UD Stars /100",            "ebay_kw":"UD Stars"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name IN ('Series 1','Series 2');

-- Upper Deck Young Guns (standalone set)
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":"Young Guns"},
  {"label":"Canvas",                    "ebay_kw":"Young Guns Canvas"},
  {"label":"Clear Cut",                 "ebay_kw":"Clear Cut Young Guns"},
  {"label":"Oversized /10",             "ebay_kw":"Young Guns Oversized"},
  {"label":"Exclusives /100",           "ebay_kw":"Young Guns Exclusives"},
  {"label":"High Gloss /10",            "ebay_kw":"Young Guns High Gloss"},
  {"label":"Auto",                      "ebay_kw":"Young Guns Auto"},
  {"label":"Auto Exclusives /100",      "ebay_kw":"Young Guns Auto Exclusives"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Young Guns';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK SP AUTHENTIC  (hockey, baseball)
-- Adds Future Watch Auto tiers
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Future Watch Auto /999",        "ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Limited /100","ebay_kw":"Future Watch Limited"},
  {"label":"Future Watch Auto Gold /50",    "ebay_kw":"Future Watch Gold"},
  {"label":"Future Watch Auto Red /25",     "ebay_kw":"Future Watch Red"},
  {"label":"Future Watch Auto Black /10",   "ebay_kw":"Future Watch Black"},
  {"label":"Future Watch Auto Purple /1",   "ebay_kw":"Future Watch Purple"},
  {"label":"Silver Spectrum /50",           "ebay_kw":"Silver Spectrum"},
  {"label":"Rainbow /100",                  "ebay_kw":"Rainbow"},
  {"label":"Autofocus",                     "ebay_kw":"Autofocus"},
  {"label":"Super Script /1",               "ebay_kw":"Super Script"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'hockey';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI IMMACULATE  (football, basketball, WNBA)
-- Adds patch auto tiers
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Standard /99",              "ebay_kw":"Standard"},
  {"label":"Premium /75",               "ebay_kw":"Premium"},
  {"label":"Emerald /25",               "ebay_kw":"Emerald"},
  {"label":"Ruby /15",                  "ebay_kw":"Ruby"},
  {"label":"Sapphire /10",              "ebay_kw":"Sapphire"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Auto /99",                  "ebay_kw":"Auto"},
  {"label":"Patch Auto /49",            "ebay_kw":"Patch Auto"},
  {"label":"Patch Auto Ruby /25",       "ebay_kw":"Patch Auto Ruby"},
  {"label":"Patch Auto Sapphire /10",   "ebay_kw":"Patch Auto Sapphire"},
  {"label":"Patch Auto Gold /10",       "ebay_kw":"Patch Auto Gold"},
  {"label":"Logoman Patch Auto /1",     "ebay_kw":"Logoman Patch Auto"},
  {"label":"Printing Plate /1",         "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Immaculate'
  AND sport IN ('football','basketball','wnba');

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI NOIR  (football, basketball)
-- Auto-centric high-end product
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                  "ebay_kw":""},
  {"label":"Silver /99",            "ebay_kw":"Silver"},
  {"label":"Red /49",               "ebay_kw":"Red"},
  {"label":"Blue /25",              "ebay_kw":"Blue"},
  {"label":"Gold /10",              "ebay_kw":"Gold"},
  {"label":"Black /1",              "ebay_kw":"Black"},
  {"label":"Auto /99",              "ebay_kw":"Auto"},
  {"label":"Auto Silver /99",       "ebay_kw":"Auto Silver"},
  {"label":"Auto Red /49",          "ebay_kw":"Auto Red"},
  {"label":"Auto Blue /25",         "ebay_kw":"Auto Blue"},
  {"label":"Auto Gold /10",         "ebay_kw":"Auto Gold"},
  {"label":"Auto Black /1",         "ebay_kw":"Auto Black"},
  {"label":"Patch Auto /99",        "ebay_kw":"Patch Auto"},
  {"label":"Patch Auto Gold /10",   "ebay_kw":"Patch Auto Gold"},
  {"label":"Logoman /1",            "ebay_kw":"Logoman"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Noir';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI FLAWLESS  (football, basketball, WNBA)
-- Diamond-tinted high-end auto product
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                   "ebay_kw":""},
  {"label":"Ruby /20",               "ebay_kw":"Ruby"},
  {"label":"Sapphire /15",           "ebay_kw":"Sapphire"},
  {"label":"Emerald /10",            "ebay_kw":"Emerald"},
  {"label":"Diamond /5",             "ebay_kw":"Diamond"},
  {"label":"Black /1",               "ebay_kw":"Black"},
  {"label":"Auto /20",               "ebay_kw":"Auto"},
  {"label":"Patch Auto /20",         "ebay_kw":"Patch Auto"},
  {"label":"Patch Auto Ruby /10",    "ebay_kw":"Patch Auto Ruby"},
  {"label":"Patch Auto Diamond /3",  "ebay_kw":"Patch Auto Diamond"},
  {"label":"Logoman Auto /1",        "ebay_kw":"Logoman Auto"},
  {"label":"Printing Plate /1",      "ebay_kw":"Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name IN ('Flawless','Flawless WNBA');

-- ═══════════════════════════════════════════════════════════════════════════════
-- O-PEE-CHEE PLATINUM  (hockey)
-- Adds Marquee Rookie Auto and retro variants
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Marquee Rookies",           "ebay_kw":"Marquee Rookies"},
  {"label":"Retro",                     "ebay_kw":"Retro"},
  {"label":"Retro Rainbow /50",         "ebay_kw":"Retro Rainbow"},
  {"label":"Blue /199",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Teal /75",                  "ebay_kw":"Teal"},
  {"label":"Purple /50",                "ebay_kw":"Purple"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Black /5",                  "ebay_kw":"Black"},
  {"label":"Rainbow /1",                "ebay_kw":"Rainbow"},
  {"label":"Marquee Rookie Auto",       "ebay_kw":"Marquee Rookie Auto"},
  {"label":"Marquee Rookie Auto Blue /150","ebay_kw":"Marquee Rookie Auto Blue"},
  {"label":"Marquee Rookie Auto Gold /25","ebay_kw":"Marquee Rookie Auto Gold"},
  {"label":"Marquee Rookie Auto Black /1","ebay_kw":"Marquee Rookie Auto Black"}
]'::jsonb
WHERE brand = 'O-Pee-Chee' AND set_name = 'Platinum';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM WNBA  (expand with auto tiers for all years)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                        "ebay_kw":""},
  {"label":"Silver Prizm",                "ebay_kw":"Silver Prizm"},
  {"label":"Neon Green Prizm /75",        "ebay_kw":"Neon Green Prizm"},
  {"label":"Red /149",                    "ebay_kw":"Red Prizm"},
  {"label":"Blue /99",                    "ebay_kw":"Blue Prizm"},
  {"label":"Purple /49",                  "ebay_kw":"Purple Prizm"},
  {"label":"Orange /25",                  "ebay_kw":"Orange Prizm"},
  {"label":"Gold /10",                    "ebay_kw":"Gold Prizm"},
  {"label":"Black /1",                    "ebay_kw":"Black Prizm"},
  {"label":"Rookie Auto Silver",          "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /149",        "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",        "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Gold /10",        "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",        "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI HOOPS  (basketball) — adds Premium Stock Auto
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                 "ebay_kw":""},
  {"label":"Premium Stock",        "ebay_kw":"Premium Stock"},
  {"label":"Holofoil /699",        "ebay_kw":"Holofoil"},
  {"label":"Silver /149",          "ebay_kw":"Silver"},
  {"label":"Blue /149",            "ebay_kw":"Blue"},
  {"label":"Red /99",              "ebay_kw":"Red"},
  {"label":"Purple /49",           "ebay_kw":"Purple"},
  {"label":"Gold /10",             "ebay_kw":"Gold"},
  {"label":"Black /1",             "ebay_kw":"Black"},
  {"label":"Teal Explosion",       "ebay_kw":"Teal Explosion"},
  {"label":"Rookie Auto",          "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Silver",   "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Red /99",  "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /10", "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1", "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS FINEST  (baseball)
-- Adds RC Auto / Finest Auto tiers
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                     "ebay_kw":""},
  {"label":"Refractor",                "ebay_kw":"Refractor"},
  {"label":"Blue Refractor /99",       "ebay_kw":"Blue Refractor"},
  {"label":"Gold Refractor /50",       "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",     "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",         "ebay_kw":"Red Refractor"},
  {"label":"Black Refractor /5",       "ebay_kw":"Black Refractor"},
  {"label":"SuperFractor /1",          "ebay_kw":"Superfractor"},
  {"label":"Finest Auto",              "ebay_kw":"Finest Auto"},
  {"label":"Finest Auto Refractor",    "ebay_kw":"Finest Auto Refractor"},
  {"label":"Finest Auto Blue /99",     "ebay_kw":"Finest Auto Blue Refractor"},
  {"label":"Finest Auto Gold /50",     "ebay_kw":"Finest Auto Gold Refractor"},
  {"label":"Finest Auto Red /5",       "ebay_kw":"Finest Auto Red Refractor"},
  {"label":"Finest Auto SuperFractor /1","ebay_kw":"Finest Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS SERIES 1 / SERIES 2 / UPDATE  (baseball)
-- Adds short prints and autographs
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Gold",                      "ebay_kw":"Gold"},
  {"label":"Rainbow Foil",              "ebay_kw":"Rainbow Foil"},
  {"label":"Clear",                     "ebay_kw":"Clear"},
  {"label":"Blue /250",                 "ebay_kw":"Blue"},
  {"label":"Black /63",                 "ebay_kw":"Black"},
  {"label":"Independence Day /76",      "ebay_kw":"Independence Day"},
  {"label":"Memorial Day Camo /25",     "ebay_kw":"Memorial Day Camo"},
  {"label":"Father''s Day /50",         "ebay_kw":"Father Day"},
  {"label":"Orange /75",                "ebay_kw":"Orange"},
  {"label":"Red /10",                   "ebay_kw":"Red"},
  {"label":"Platinum /1",               "ebay_kw":"Platinum"},
  {"label":"Short Print SP",            "ebay_kw":"Short Print SP"},
  {"label":"Super Short Print SSP",     "ebay_kw":"Super Short Print"},
  {"label":"Image Variation",           "ebay_kw":"Variation"},
  {"label":"Autograph",                 "ebay_kw":"Auto"},
  {"label":"Autograph Blue /50",        "ebay_kw":"Auto Blue"},
  {"label":"Autograph Red /10",         "ebay_kw":"Auto Red"},
  {"label":"Autograph Platinum /1",     "ebay_kw":"Auto Platinum"}
]'::jsonb
WHERE brand = 'Topps' AND set_name IN ('Series 1','Series 2','Update');

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI OBSIDIAN  (football, basketball)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Electric Etch Blue /75",    "ebay_kw":"Electric Etch Blue"},
  {"label":"Electric Etch Orange /50",  "ebay_kw":"Electric Etch Orange"},
  {"label":"Electric Etch Green /25",   "ebay_kw":"Electric Etch Green"},
  {"label":"Electric Etch Gold /10",    "ebay_kw":"Electric Etch Gold"},
  {"label":"Electric Etch Red /5",      "ebay_kw":"Electric Etch Red"},
  {"label":"Flash /99",                 "ebay_kw":"Flash"},
  {"label":"Gold /10",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Electric Etch /75","ebay_kw":"Rookie Auto Electric Etch"},
  {"label":"Rookie Auto Gold /10",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Patch Auto",         "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /10",              "ebay_kw":"RPA Gold"},
  {"label":"RPA Black /1",              "ebay_kw":"RPA Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Obsidian';
