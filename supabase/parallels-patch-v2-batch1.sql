-- ─────────────────────────────────────────────────────────────────────────────
-- Parallels Patch v2 — Batch 1: Prizm (all sports), Donruss Optic, Mosaic, Hoops
-- Every UPDATE hits brand+set_name+(sport where needed), no year filter
-- Safe to re-run
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM BASKETBALL — full parallel tree incl. Orange Cracked Ice
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                    "ebay_kw":""},
  {"label":"Silver Prizm",                            "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                             "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                               "ebay_kw":"Ice Prizm"},
  {"label":"Disco Prizm",                             "ebay_kw":"Disco Prizm"},
  {"label":"Tiger Stripe Prizm",                      "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Red White Blue Prizm",                    "ebay_kw":"Red White Blue Prizm"},
  {"label":"Luck of the Irish Prizm",                 "ebay_kw":"Luck of the Irish Prizm"},
  {"label":"Fast Break Prizm",                        "ebay_kw":"Fast Break Prizm"},
  {"label":"Scope Prizm",                             "ebay_kw":"Scope Prizm"},
  {"label":"Blue Ice Prizm /225",                     "ebay_kw":"Blue Ice Prizm"},
  {"label":"Carolina Blue Prizm /175",                "ebay_kw":"Carolina Blue Prizm"},
  {"label":"Blue Prizm /199",                         "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                           "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                         "ebay_kw":"Green Prizm"},
  {"label":"Neon Green Prizm /75",                    "ebay_kw":"Neon Green Prizm"},
  {"label":"Purple Prizm /49",                        "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                          "ebay_kw":"Pink Prizm"},
  {"label":"Orange Cracked Ice /25",                  "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Gold Prizm /10",                          "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                          "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                       "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                      "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Ice",                         "ebay_kw":"Rookie Auto Ice Prizm"},
  {"label":"Rookie Auto Red /149",                    "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",                    "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Neon Green /75",              "ebay_kw":"Rookie Auto Neon Green Prizm"},
  {"label":"Rookie Auto Purple /49",                  "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Pink /35",                    "ebay_kw":"Rookie Auto Pink Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",      "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                    "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                    "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                    "ebay_kw":""},
  {"label":"Silver Prizm",                            "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                             "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                               "ebay_kw":"Ice Prizm"},
  {"label":"Disco Prizm",                             "ebay_kw":"Disco Prizm"},
  {"label":"Tiger Stripe Prizm",                      "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Red White Blue Prizm",                    "ebay_kw":"Red White Blue Prizm"},
  {"label":"Luck of the Irish Prizm",                 "ebay_kw":"Luck of the Irish Prizm"},
  {"label":"Fast Break Prizm",                        "ebay_kw":"Fast Break Prizm"},
  {"label":"Scope Prizm",                             "ebay_kw":"Scope Prizm"},
  {"label":"Blue Ice Prizm /225",                     "ebay_kw":"Blue Ice Prizm"},
  {"label":"Blue Prizm /199",                         "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                           "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                         "ebay_kw":"Green Prizm"},
  {"label":"Neon Green Prizm /75",                    "ebay_kw":"Neon Green Prizm"},
  {"label":"Purple Prizm /49",                        "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                          "ebay_kw":"Pink Prizm"},
  {"label":"Orange Cracked Ice /25",                  "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Gold Prizm /10",                          "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                          "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                       "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                      "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Ice",                         "ebay_kw":"Rookie Auto Ice Prizm"},
  {"label":"Rookie Auto Red /149",                    "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",                    "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Neon Green /75",              "ebay_kw":"Rookie Auto Neon Green Prizm"},
  {"label":"Rookie Auto Purple /49",                  "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Pink /35",                    "ebay_kw":"Rookie Auto Pink Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",      "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                    "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                    "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM BASEBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Silver Prizm",                      "ebay_kw":"Silver Prizm"},
  {"label":"Red White Blue Prizm",              "ebay_kw":"Red White Blue Prizm"},
  {"label":"Hyper Prizm",                       "ebay_kw":"Hyper Prizm"},
  {"label":"Scope Prizm",                       "ebay_kw":"Scope Prizm"},
  {"label":"Blue Prizm /199",                   "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                     "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                   "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",                  "ebay_kw":"Purple Prizm"},
  {"label":"Gold Prizm /10",                    "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                    "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"},
  {"label":"Auto Silver",                       "ebay_kw":"Auto Silver Prizm"},
  {"label":"Auto Blue /150",                    "ebay_kw":"Auto Blue Prizm"},
  {"label":"Auto Gold /50",                     "ebay_kw":"Auto Gold Prizm"},
  {"label":"Auto Red /25",                      "ebay_kw":"Auto Red Prizm"},
  {"label":"Auto Gold /10",                     "ebay_kw":"Auto Gold Prizm"},
  {"label":"Auto Black /1",                     "ebay_kw":"Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM DRAFT PICKS (basketball/football)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                "ebay_kw":""},
  {"label":"Silver Prizm",                        "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                         "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                           "ebay_kw":"Ice Prizm"},
  {"label":"Tiger Stripe Prizm",                  "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Blue Prizm /199",                     "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                       "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                     "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",                    "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                      "ebay_kw":"Pink Prizm"},
  {"label":"Orange Cracked Ice /25",              "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Gold Prizm /10",                      "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                   "ebay_kw":"Printing Plate"},
  {"label":"Draft Auto Silver",                   "ebay_kw":"Draft Auto Silver Prizm"},
  {"label":"Draft Auto Red /149",                 "ebay_kw":"Draft Auto Red Prizm"},
  {"label":"Draft Auto Blue /99",                 "ebay_kw":"Draft Auto Blue Prizm"},
  {"label":"Draft Auto Purple /49",               "ebay_kw":"Draft Auto Purple Prizm"},
  {"label":"Draft Auto Pink /35",                 "ebay_kw":"Draft Auto Pink Prizm"},
  {"label":"Draft Auto Orange Cracked Ice /25",   "ebay_kw":"Draft Auto Orange Cracked Ice Prizm"},
  {"label":"Draft Auto Gold /10",                 "ebay_kw":"Draft Auto Gold Prizm"},
  {"label":"Draft Auto Black /1",                 "ebay_kw":"Draft Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm Draft Picks';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM WNBA — add Orange Cracked Ice
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Silver Prizm",                          "ebay_kw":"Silver Prizm"},
  {"label":"Ice Prizm",                             "ebay_kw":"Ice Prizm"},
  {"label":"Tiger Stripe Prizm",                    "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Red White Blue Prizm",                  "ebay_kw":"Red White Blue Prizm"},
  {"label":"Blue Prizm /199",                       "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /149",                        "ebay_kw":"Red Prizm"},
  {"label":"Blue Ice Prizm /99",                    "ebay_kw":"Blue Ice Prizm"},
  {"label":"Purple Prizm /49",                      "ebay_kw":"Purple Prizm"},
  {"label":"Orange Cracked Ice /25",                "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Gold Prizm /10",                        "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                        "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                    "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /149",                  "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",                  "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Purple /49",                "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",    "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                  "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                  "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS OPTIC BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Rated Rookie",                      "ebay_kw":"Rated Rookie"},
  {"label":"Holo",                              "ebay_kw":"Holo"},
  {"label":"Velocity",                          "ebay_kw":"Velocity"},
  {"label":"My House",                          "ebay_kw":"My House"},
  {"label":"Orange /199",                       "ebay_kw":"Orange Holo"},
  {"label":"Pink /149",                         "ebay_kw":"Pink"},
  {"label":"Blue /149",                         "ebay_kw":"Blue Holo"},
  {"label":"Red /99",                           "ebay_kw":"Red Holo"},
  {"label":"Lime Green /75",                    "ebay_kw":"Lime Green"},
  {"label":"Purple /49",                        "ebay_kw":"Purple Holo"},
  {"label":"Gold /25",                          "ebay_kw":"Gold Holo"},
  {"label":"Black /1",                          "ebay_kw":"Black"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"},
  {"label":"Rated Rookie Auto Holo",            "ebay_kw":"Rated Rookie Auto Holo"},
  {"label":"Rated Rookie Auto Orange /199",     "ebay_kw":"Rated Rookie Auto Orange"},
  {"label":"Rated Rookie Auto Pink /149",       "ebay_kw":"Rated Rookie Auto Pink"},
  {"label":"Rated Rookie Auto Blue /99",        "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /99",         "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Lime Green /75",  "ebay_kw":"Rated Rookie Auto Lime Green"},
  {"label":"Rated Rookie Auto Purple /49",      "ebay_kw":"Rated Rookie Auto Purple"},
  {"label":"Rated Rookie Auto Gold /10",        "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",        "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI DONRUSS OPTIC FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                              "ebay_kw":""},
  {"label":"Rated Rookie",                      "ebay_kw":"Rated Rookie"},
  {"label":"Holo",                              "ebay_kw":"Holo"},
  {"label":"Velocity",                          "ebay_kw":"Velocity"},
  {"label":"Orange /199",                       "ebay_kw":"Orange Holo"},
  {"label":"Pink /149",                         "ebay_kw":"Pink"},
  {"label":"Blue /149",                         "ebay_kw":"Blue Holo"},
  {"label":"Red /99",                           "ebay_kw":"Red Holo"},
  {"label":"Lime Green /75",                    "ebay_kw":"Lime Green"},
  {"label":"Purple /49",                        "ebay_kw":"Purple Holo"},
  {"label":"Gold /25",                          "ebay_kw":"Gold Holo"},
  {"label":"Black /1",                          "ebay_kw":"Black"},
  {"label":"Printing Plate /1",                 "ebay_kw":"Printing Plate"},
  {"label":"Rated Rookie Auto Holo",            "ebay_kw":"Rated Rookie Auto Holo"},
  {"label":"Rated Rookie Auto Orange /199",     "ebay_kw":"Rated Rookie Auto Orange"},
  {"label":"Rated Rookie Auto Pink /149",       "ebay_kw":"Rated Rookie Auto Pink"},
  {"label":"Rated Rookie Auto Blue /99",        "ebay_kw":"Rated Rookie Auto Blue"},
  {"label":"Rated Rookie Auto Red /99",         "ebay_kw":"Rated Rookie Auto Red"},
  {"label":"Rated Rookie Auto Lime Green /75",  "ebay_kw":"Rated Rookie Auto Lime Green"},
  {"label":"Rated Rookie Auto Purple /49",      "ebay_kw":"Rated Rookie Auto Purple"},
  {"label":"Rated Rookie Auto Gold /10",        "ebay_kw":"Rated Rookie Auto Gold"},
  {"label":"Rated Rookie Auto Black /1",        "ebay_kw":"Rated Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Donruss Optic' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI MOSAIC BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Silver Prizm",                  "ebay_kw":"Silver Prizm"},
  {"label":"Reactive Blue",                 "ebay_kw":"Reactive Blue"},
  {"label":"Camo",                          "ebay_kw":"Camo Prizm"},
  {"label":"Pink Camo",                     "ebay_kw":"Pink Camo"},
  {"label":"Mosaic",                        "ebay_kw":"Mosaic Prizm"},
  {"label":"Color Blast",                   "ebay_kw":"Color Blast"},
  {"label":"Genesis",                       "ebay_kw":"Genesis Prizm"},
  {"label":"Green Fluorescent /175",        "ebay_kw":"Green Fluorescent"},
  {"label":"Blue /150",                     "ebay_kw":"Blue Prizm"},
  {"label":"Red /100",                      "ebay_kw":"Red Prizm"},
  {"label":"Neon Green /75",                "ebay_kw":"Neon Green"},
  {"label":"Purple /49",                    "ebay_kw":"Purple Prizm"},
  {"label":"Gold /25",                      "ebay_kw":"Gold Prizm"},
  {"label":"Orange /15",                    "ebay_kw":"Orange Prizm"},
  {"label":"Black /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",            "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Camo /99",          "ebay_kw":"Rookie Auto Camo"},
  {"label":"Rookie Auto Red /99",           "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Blue /99",          "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Green /75",         "ebay_kw":"Rookie Auto Green"},
  {"label":"Rookie Auto Purple /49",        "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI MOSAIC FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Silver Prizm",                  "ebay_kw":"Silver Prizm"},
  {"label":"Reactive Blue",                 "ebay_kw":"Reactive Blue"},
  {"label":"Camo",                          "ebay_kw":"Camo Prizm"},
  {"label":"Pink Camo",                     "ebay_kw":"Pink Camo"},
  {"label":"Mosaic",                        "ebay_kw":"Mosaic Prizm"},
  {"label":"Color Blast",                   "ebay_kw":"Color Blast"},
  {"label":"Genesis",                       "ebay_kw":"Genesis Prizm"},
  {"label":"Green Fluorescent /175",        "ebay_kw":"Green Fluorescent"},
  {"label":"Blue /150",                     "ebay_kw":"Blue Prizm"},
  {"label":"Red /100",                      "ebay_kw":"Red Prizm"},
  {"label":"Neon Green /75",                "ebay_kw":"Neon Green"},
  {"label":"Purple /49",                    "ebay_kw":"Purple Prizm"},
  {"label":"Gold /25",                      "ebay_kw":"Gold Prizm"},
  {"label":"Orange /15",                    "ebay_kw":"Orange Prizm"},
  {"label":"Black /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",            "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Camo /99",          "ebay_kw":"Rookie Auto Camo"},
  {"label":"Rookie Auto Red /99",           "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Blue /99",          "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Green /75",         "ebay_kw":"Rookie Auto Green"},
  {"label":"Rookie Auto Purple /49",        "ebay_kw":"Rookie Auto Purple"},
  {"label":"Rookie Auto Gold /25",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Mosaic' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI HOOPS BASKETBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Teal Explosion",                "ebay_kw":"Teal Explosion"},
  {"label":"Purple /199",                   "ebay_kw":"Purple"},
  {"label":"Silver /169",                   "ebay_kw":"Silver"},
  {"label":"Red /149",                      "ebay_kw":"Red"},
  {"label":"Blue /99",                      "ebay_kw":"Blue"},
  {"label":"Green /75",                     "ebay_kw":"Green"},
  {"label":"Gold /10",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Printing Plate /1",             "ebay_kw":"Printing Plate"},
  {"label":"Arriving Now",                  "ebay_kw":"Arriving Now"},
  {"label":"High Voltage",                  "ebay_kw":"High Voltage"},
  {"label":"Rookie Auto",                   "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Silver /149",       "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Red /99",           "ebay_kw":"Rookie Auto Red"},
  {"label":"Rookie Auto Blue /49",          "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Gold /10",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI HOOPS WNBA
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                          "ebay_kw":""},
  {"label":"Purple /199",                   "ebay_kw":"Purple"},
  {"label":"Silver /149",                   "ebay_kw":"Silver"},
  {"label":"Blue /99",                      "ebay_kw":"Blue"},
  {"label":"Green /75",                     "ebay_kw":"Green"},
  {"label":"Gold /10",                      "ebay_kw":"Gold"},
  {"label":"Black /1",                      "ebay_kw":"Black"},
  {"label":"Rookie Auto",                   "ebay_kw":"Rookie Auto"},
  {"label":"Rookie Auto Silver /149",       "ebay_kw":"Rookie Auto Silver"},
  {"label":"Rookie Auto Blue /99",          "ebay_kw":"Rookie Auto Blue"},
  {"label":"Rookie Auto Gold /10",          "ebay_kw":"Rookie Auto Gold"},
  {"label":"Rookie Auto Black /1",          "ebay_kw":"Rookie Auto Black"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Hoops WNBA';
