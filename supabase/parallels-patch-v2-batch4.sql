-- ─────────────────────────────────────────────────────────────────────────────
-- Parallels Patch v2 — Batch 4: Football (Phoenix, Origins, Luminance, Threads,
--   Limited, Rookies & Stars, Impeccable, Silhouette, Clearly Donruss, Honors,
--   Phoenix), Basketball (Flux, Impeccable, Panini Prizm Fast Break),
--   Upper Deck Basketball/Hockey SP Authentic
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PHOENIX FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Red /299",                      "ebay_kw":"Red"},
  {"label":"Blue /199",                     "ebay_kw":"Blue"},
  {"label":"Aqua /149",                     "ebay_kw":"Aqua"},
  {"label":"Green /99",                     "ebay_kw":"Green"},
  {"label":"Purple /49",                    "ebay_kw":"Purple"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Silver /10",                    "ebay_kw":"Silver"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rookie Auto",                   "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Red /299",          "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Blue /199",         "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Green /99",         "ebay_kw":"Rookie Auto Green"},
  {"label":"Rookie Auto Purple /49",        "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"},
  {"label":"Rising Rookie Auto",            "ebay_kw":"Rising Rookie Auto"},
  {"label":"Fire Burst",                    "ebay_kw":"Fire Burst"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Phoenix';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI ORIGINS FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Blue /149",                     "ebay_kw":"Blue"},
  {"label":"Red /99",                       "ebay_kw":"Red"},
  {"label":"Green /75",                     "ebay_kw":"Green"},
  {"label":"Purple /49",                    "ebay_kw":"Purple"},
  {"label":"Gold /10",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rookie Auto",                   "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /149",         "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",           "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Purple /49",        "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /10",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Patch Auto /99",         "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Blue /49",                  "ebay_kw":"Rookie Patch Auto Blue"},
  {"label":"RPA Gold /10",                  "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Black /1",                  "ebay_kw":"Rookie Patch Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Origins';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI LUMINANCE FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Blue /175",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
  {"label":"Green /75",                 "ebay_kw":"Green"},
  {"label":"Purple /49",                "ebay_kw":"Purple"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /175",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /99",       "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Purple /49",    "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Luminance';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI THREADS FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Bronze /249",               "ebay_kw":"Bronze"},
  {"label":"Blue /199",                 "ebay_kw":"Blue"},
  {"label":"Red /150",                  "ebay_kw":"Red"},
  {"label":"Green /99",                 "ebay_kw":"Green"},
  {"label":"Gold /25",                  "ebay_kw":"Gold"},
  {"label":"Black /1",                  "ebay_kw":"Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Bronze /249",   "ebay_kw":"Rookie Auto Bronze"},
  {"label":"Rookie Auto Blue /199",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /150",      "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"},
  {"label":"Rookie Material Signatures","ebay_kw":"Rookie Material Signatures"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Threads';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI LIMITED FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /199",                     "ebay_kw":""},
  {"label":"Silver /150",                   "ebay_kw":"Silver"},
  {"label":"Gold /99",                      "ebay_kw":"Gold"},
  {"label":"Emerald /49",                   "ebay_kw":"Emerald"},
  {"label":"Sapphire /25",                  "ebay_kw":"Sapphire"},
  {"label":"Ruby /5",                       "ebay_kw":"Ruby"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99",         "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /49",                  "ebay_kw":"Rookie Patch Auto Gold"},
  {"label":"RPA Emerald /25",               "ebay_kw":"Rookie Patch Auto Emerald"},
  {"label":"RPA Ruby /5",                   "ebay_kw":"Rookie Patch Auto Ruby"},
  {"label":"RPA Black /1",                  "ebay_kw":"Rookie Patch Auto Black"},
  {"label":"Rookie Jumbo Patch Auto /49",   "ebay_kw":"Rookie Jumbo Patch Auto"},
  {"label":"Limelight Auto",                "ebay_kw":"Limelight Auto"},
  {"label":"Phenoms Auto",                  "ebay_kw":"Phenoms Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Limited';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI ROOKIES & STARS FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Longevity Blue /199",       "ebay_kw":"Longevity Blue"},
  {"label":"Longevity Red /149",        "ebay_kw":"Longevity Red"},
  {"label":"Longevity Purple /99",      "ebay_kw":"Longevity Purple"},
  {"label":"Longevity Gold /25",        "ebay_kw":"Longevity Gold"},
  {"label":"Longevity Black /1",        "ebay_kw":"Longevity Black"},
  {"label":"Rookie Auto",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Blue /199",     "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Red /149",      "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Gold /25",      "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",      "ebay_kw":"Rookie Auto Black"},
  {"label":"Studio Auto",               "ebay_kw":"Studio Auto"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Rookies & Stars';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI IMPECCABLE FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /99",                      "ebay_kw":""},
  {"label":"Silver /49",                    "ebay_kw":"Silver"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Platinum /10",                  "ebay_kw":"Platinum"},
  {"label":"Stainless Stars Auto /99",      "ebay_kw":"Stainless Stars Auto"},
  {"label":"Stainless Stars Auto Gold /49", "ebay_kw":"Stainless Stars Auto Gold"},
  {"label":"Stainless Stars Auto Black /1", "ebay_kw":"Stainless Stars Auto Black"},
  {"label":"Indelible Ink Auto /99",        "ebay_kw":"Indelible Ink Auto"},
  {"label":"Indelible Ink Auto Silver /49", "ebay_kw":"Indelible Ink Auto Silver"},
  {"label":"Indelible Ink Auto Gold /25",   "ebay_kw":"Indelible Ink Auto Gold"},
  {"label":"Rookie Auto /99",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Silver /49",        "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Gold /25",          "ebay_kw":"Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Impeccable' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI IMPECCABLE BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /99",                      "ebay_kw":""},
  {"label":"Silver /49",                    "ebay_kw":"Silver"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Platinum /10",                  "ebay_kw":"Platinum"},
  {"label":"Stainless Stars Auto /99",      "ebay_kw":"Stainless Stars Auto"},
  {"label":"Stainless Stars Auto Gold /49", "ebay_kw":"Stainless Stars Auto Gold"},
  {"label":"Stainless Stars Auto Black /1", "ebay_kw":"Stainless Stars Auto Black"},
  {"label":"Indelible Ink Auto /99",        "ebay_kw":"Indelible Ink Auto"},
  {"label":"Indelible Ink Auto Silver /49", "ebay_kw":"Indelible Ink Auto Silver"},
  {"label":"Indelible Ink Auto Gold /25",   "ebay_kw":"Indelible Ink Auto Gold"},
  {"label":"Rookie Auto /99",               "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Silver /49",        "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Gold /25",          "ebay_kw":"Rookie Auto Gold"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Impeccable' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI SILHOUETTE FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Blue /175",                     "ebay_kw":"Blue"},
  {"label":"Red /99",                       "ebay_kw":"Red"},
  {"label":"Purple /49",                    "ebay_kw":"Purple"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rookie Silhouette Auto",        "ebay_kw":"Rookie Silhouette Auto"},
  {"label":"RSA Blue /175",                 "ebay_kw":"Rookie Silhouette Auto Blue"},
  {"label":"RSA Red /99",                   "ebay_kw":"Rookie Silhouette Auto Red"},
  {"label":"RSA Purple /49",                "ebay_kw":"Rookie Silhouette Auto Purple"},
  {"label":"RSA Gold /25",                  "ebay_kw":"Rookie Silhouette Auto Gold"},
  {"label":"RSA Black /1",                  "ebay_kw":"Rookie Silhouette Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Silhouette';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI CLEARLY DONRUSS FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Blue /199",                     "ebay_kw":"Blue"},
  {"label":"Red /99",                       "ebay_kw":"Red"},
  {"label":"Purple /49",                    "ebay_kw":"Purple"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Black /5",                      "ebay_kw":"Black"},
  {"label":"Clearly Donruss Rated Rookie Auto","ebay_kw":"Rated Rookie Auto"},
  {"label":"RR Auto Blue /199",             "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"RR Auto Red /99",               "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"RR Auto Gold /25",              "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"RR Auto Black /5",              "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Clearly Donruss';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI FLUX BASKETBALL + FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                      "ebay_kw":""},
  {"label":"Blue /199",                 "ebay_kw":"Blue"},
  {"label":"Red /99",                   "ebay_kw":"Red"},
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
WHERE brand = 'Panini' AND set_name = 'Flux';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM FAST BREAK BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                "ebay_kw":""},
  {"label":"Silver Prizm",                        "ebay_kw":"Silver Prizm"},
  {"label":"Blue Prizm /149",                     "ebay_kw":"Blue Prizm"},
  {"label":"Purple Prizm /99",                    "ebay_kw":"Purple Prizm"},
  {"label":"Red Prizm /85",                       "ebay_kw":"Red Prizm"},
  {"label":"Orange Prizm /49",                    "ebay_kw":"Orange Prizm"},
  {"label":"Green Prizm /25",                     "ebay_kw":"Green Prizm"},
  {"label":"Gold Prizm /10",                      "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Rookie Auto Silver",                  "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Blue /149",               "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Purple /99",              "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Orange /49",              "ebay_kw":"Rookie Auto Orange Prizm"},
  {"label":"Rookie Auto Green /25",               "ebay_kw":"Rookie Auto Green Prizm"},
  {"label":"Rookie Auto Gold /10",                "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm Fast Break';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK SP AUTHENTIC BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Gold /250",                     "ebay_kw":"Gold"},
  {"label":"Platinum /99",                  "ebay_kw":"Platinum"},
  {"label":"Limited /100",                  "ebay_kw":"Limited"},
  {"label":"Sign of the Times Auto",        "ebay_kw":"Sign of the Times Auto"},
  {"label":"SPA Future Watch Auto /999",    "ebay_kw":"Future Watch Auto"},
  {"label":"Future Watch Auto Gold /250",   "ebay_kw":"Future Watch Auto Gold"},
  {"label":"Future Watch Auto /99",         "ebay_kw":"Future Watch Limited Auto"},
  {"label":"Future Watch Auto Black /25",   "ebay_kw":"Future Watch Auto Black"},
  {"label":"SPA Authentic Moments Auto",    "ebay_kw":"Authentic Moments Auto"},
  {"label":"SPA Patch Auto /99",            "ebay_kw":"Patch Auto"},
  {"label":"Rookie Extended Auto /999",     "ebay_kw":"Rookie Extended Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SP Authentic' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPPER DECK EXQUISITE COLLECTION BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base /225",                         "ebay_kw":""},
  {"label":"Gold /75",                          "ebay_kw":"Gold"},
  {"label":"Platinum /10",                      "ebay_kw":"Platinum"},
  {"label":"Black /1",                          "ebay_kw":"Black"},
  {"label":"Rookie Patch Auto /99",             "ebay_kw":"Rookie Patch Auto"},
  {"label":"RPA Gold /35",                      "ebay_kw":"RPA Gold"},
  {"label":"RPA Platinum /10",                  "ebay_kw":"RPA Platinum"},
  {"label":"RPA Black /1",                      "ebay_kw":"RPA Black"},
  {"label":"Exquisite Auto Patch",              "ebay_kw":"Exquisite Auto Patch"},
  {"label":"Noble Nameplates Auto",             "ebay_kw":"Noble Nameplates Auto"},
  {"label":"Logoman Auto /1",                   "ebay_kw":"Logoman Auto"},
  {"label":"Dual Rookie Patch Auto /25",        "ebay_kw":"Dual Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Exquisite Collection';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS DONRUSS WNBA
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Rated Rookie",                  "ebay_kw":"Rated Rookie"},
  {"label":"Bronze /199",                   "ebay_kw":"Bronze"},
  {"label":"Blue /99",                      "ebay_kw":"Blue"},
  {"label":"Red /49",                       "ebay_kw":"Red"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Rated Rookie Auto",             "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Bronze /199", "ebay_kw":"Rated Rookie Auto Bronze"},
  {"label":"Rated Rookie Auto Blue /99",    "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /49",     "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Gold /25",    "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",    "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI OBSIDIAN WNBA
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Electric Etch Orange /99",          "ebay_kw":"Electric Etch Orange"},
  {"label":"Electric Etch Purple /49",          "ebay_kw":"Electric Etch Purple"},
  {"label":"Electric Etch Blue /25",            "ebay_kw":"Electric Etch Blue"},
  {"label":"Electric Etch Gold /10",            "ebay_kw":"Electric Etch Gold"},
  {"label":"Electric Etch Black /1",            "ebay_kw":"Electric Etch Black"},
  {"label":"Rookie Auto",                       "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Electric Etch /99",     "ebay_kw":"Rookie Auto Electric Etch"},
  {"label":"Rookie Auto Gold /10",              "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",              "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Obsidian WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS CHROME FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Refractor",                     "ebay_kw":"Refractor"},
  {"label":"Negative Refractor",            "ebay_kw":"Negative Refractor"},
  {"label":"X-Fractor",                     "ebay_kw":"X-Fractor"},
  {"label":"Prism Refractor",               "ebay_kw":"Prism Refractor"},
  {"label":"Pink Refractor /199",           "ebay_kw":"Pink Refractor"},
  {"label":"Blue Wave Refractor /150",      "ebay_kw":"Blue Wave Refractor"},
  {"label":"Green Refractor /99",           "ebay_kw":"Green Refractor"},
  {"label":"Gold Refractor /50",            "ebay_kw":"Gold Refractor"},
  {"label":"Orange Refractor /25",          "ebay_kw":"Orange Refractor"},
  {"label":"Red Refractor /5",              "ebay_kw":"Red Refractor"},
  {"label":"SuperFractor /1",               "ebay_kw":"Superfractor"},
  {"label":"Black Refractor",               "ebay_kw":"Black Refractor"},
  {"label":"RC Auto",                       "ebay_kw":"RC Auto"},
  {"label":"RC Auto Refractor",             "ebay_kw":"RC Auto Refractor"},
  {"label":"RC Auto Blue /150",             "ebay_kw":"RC Auto Blue Refractor"},
  {"label":"RC Auto Gold /50",              "ebay_kw":"RC Auto Gold Refractor"},
  {"label":"RC Auto Orange /25",            "ebay_kw":"RC Auto Orange Refractor"},
  {"label":"RC Auto Red /5",                "ebay_kw":"RC Auto Red Refractor"},
  {"label":"RC Auto SuperFractor /1",       "ebay_kw":"RC Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- TOPPS FINEST FOOTBALL
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
  {"label":"RC Auto Refractor",             "ebay_kw":"RC Auto Refractor"},
  {"label":"RC Auto Blue /150",             "ebay_kw":"RC Auto Blue Refractor"},
  {"label":"RC Auto Gold /50",              "ebay_kw":"RC Auto Gold Refractor"},
  {"label":"RC Auto Red /5",                "ebay_kw":"RC Auto Red Refractor"},
  {"label":"RC Auto SuperFractor /1",       "ebay_kw":"RC Auto Superfractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS RATED ROOKIES FOOTBALL (standalone set)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Bronze /199",                   "ebay_kw":"Bronze"},
  {"label":"Blue /99",                      "ebay_kw":"Blue"},
  {"label":"Red /49",                       "ebay_kw":"Red"},
  {"label":"Gold /25",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rated Rookie Auto",             "ebay_kw":"Rated Rookie Auto"},
  {"label":"Rated Rookie Auto Bronze /199", "ebay_kw":"Rated Rookie Auto Bronze"},
  {"label":"Rated Rookie Auto Blue /99",    "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /49",     "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Gold /25",    "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",    "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Rated Rookies';
