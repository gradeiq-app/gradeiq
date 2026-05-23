-- ─────────────────────────────────────────────────────────────────────────────
-- PRIZM DEFINITIVE FIX — verified against official Panini checklists
--
-- Key corrections vs. previous data:
--   • Orange Cracked Ice: UNNUMBERED (not /25) — retail blaster/hanger exclusive
--   • Mojo Prizm: /25 (numbered — was missing entirely)
--   • Blue Ice Prizm: /125 (NOT /225 — was wrong)
--   • Rookie Auto Ice: REMOVED — not an official Prizm parallel
--   • Carolina Blue /175: REMOVED — not in official 2020–24 checklists
--   • Rookie Auto Orange Cracked Ice /25: KEPT — autos ARE numbered
-- ─────────────────────────────────────────────────────────────────────────────

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM BASKETBALL (applies to all years in DB)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                "ebay_kw":""},
  {"label":"Silver Prizm",                        "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                         "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                           "ebay_kw":"Ice Prizm"},
  {"label":"Disco Prizm",                         "ebay_kw":"Disco Prizm"},
  {"label":"Tiger Stripe Prizm",                  "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Fast Break Prizm",                    "ebay_kw":"Fast Break Prizm"},
  {"label":"Red White Blue Prizm",                "ebay_kw":"Red White Blue Prizm"},
  {"label":"Luck of the Irish Prizm",             "ebay_kw":"Luck of the Irish Prizm"},
  {"label":"Scope Prizm",                         "ebay_kw":"Scope Prizm"},
  {"label":"Orange Cracked Ice",                  "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Mojo Prizm /25",                      "ebay_kw":"Mojo Prizm"},
  {"label":"Blue Ice Prizm /125",                 "ebay_kw":"Blue Ice Prizm"},
  {"label":"Blue Prizm /199",                     "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                       "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                     "ebay_kw":"Green Prizm"},
  {"label":"Neon Green Prizm /75",                "ebay_kw":"Neon Green Prizm"},
  {"label":"Purple Prizm /49",                    "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                      "ebay_kw":"Pink Prizm"},
  {"label":"Gold Prizm /10",                      "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                   "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                  "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /149",                "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",                "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Green /75",               "ebay_kw":"Rookie Auto Green Prizm"},
  {"label":"Rookie Auto Neon Green /75",          "ebay_kw":"Rookie Auto Neon Green Prizm"},
  {"label":"Rookie Auto Purple /49",              "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Pink /35",                "ebay_kw":"Rookie Auto Pink Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",  "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'basketball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM FOOTBALL
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                "ebay_kw":""},
  {"label":"Silver Prizm",                        "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                         "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                           "ebay_kw":"Ice Prizm"},
  {"label":"Disco Prizm",                         "ebay_kw":"Disco Prizm"},
  {"label":"Tiger Stripe Prizm",                  "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Fast Break Prizm",                    "ebay_kw":"Fast Break Prizm"},
  {"label":"Red White Blue Prizm",                "ebay_kw":"Red White Blue Prizm"},
  {"label":"Luck of the Irish Prizm",             "ebay_kw":"Luck of the Irish Prizm"},
  {"label":"Scope Prizm",                         "ebay_kw":"Scope Prizm"},
  {"label":"Orange Cracked Ice",                  "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Mojo Prizm /25",                      "ebay_kw":"Mojo Prizm"},
  {"label":"Blue Ice Prizm /125",                 "ebay_kw":"Blue Ice Prizm"},
  {"label":"Blue Prizm /199",                     "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",                       "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",                     "ebay_kw":"Green Prizm"},
  {"label":"Neon Green Prizm /75",                "ebay_kw":"Neon Green Prizm"},
  {"label":"Purple Prizm /49",                    "ebay_kw":"Purple Prizm"},
  {"label":"Pink Prizm /35",                      "ebay_kw":"Pink Prizm"},
  {"label":"Gold Prizm /10",                      "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                      "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                   "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                  "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /149",                "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /99",                "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Green /75",               "ebay_kw":"Rookie Auto Green Prizm"},
  {"label":"Rookie Auto Neon Green /75",          "ebay_kw":"Rookie Auto Neon Green Prizm"},
  {"label":"Rookie Auto Purple /49",              "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Pink /35",                "ebay_kw":"Rookie Auto Pink Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",  "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'football';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM BASEBALL
-- (Simpler product — no Orange Cracked Ice, no Mojo confirmed)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                        "ebay_kw":""},
  {"label":"Silver Prizm",                "ebay_kw":"Silver Prizm"},
  {"label":"Red White Blue Prizm",        "ebay_kw":"Red White Blue Prizm"},
  {"label":"Hyper Prizm",                 "ebay_kw":"Hyper Prizm"},
  {"label":"Scope Prizm",                 "ebay_kw":"Scope Prizm"},
  {"label":"Mojo Prizm /25",              "ebay_kw":"Mojo Prizm"},
  {"label":"Blue Prizm /199",             "ebay_kw":"Blue Prizm"},
  {"label":"Red Prizm /99",               "ebay_kw":"Red Prizm"},
  {"label":"Green Prizm /75",             "ebay_kw":"Green Prizm"},
  {"label":"Purple Prizm /49",            "ebay_kw":"Purple Prizm"},
  {"label":"Gold Prizm /10",              "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",              "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",           "ebay_kw":"Printing Plate"},
  {"label":"Auto Silver",                 "ebay_kw":"Auto Silver Prizm"},
  {"label":"Auto Blue /150",              "ebay_kw":"Auto Blue Prizm"},
  {"label":"Auto Green /99",              "ebay_kw":"Auto Green Prizm"},
  {"label":"Auto Gold /50",               "ebay_kw":"Auto Gold Prizm"},
  {"label":"Auto Red /25",                "ebay_kw":"Auto Red Prizm"},
  {"label":"Auto Gold /10",               "ebay_kw":"Auto Gold Prizm"},
  {"label":"Auto Black /1",               "ebay_kw":"Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm' AND sport = 'baseball';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM WNBA
-- Research: Orange Ice = unnumbered, Mojo = /25, no Carolina Blue
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Silver Prizm",                          "ebay_kw":"Silver Prizm"},
  {"label":"Ice Prizm",                             "ebay_kw":"Ice Prizm"},
  {"label":"Tiger Stripe Prizm",                    "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Red White Blue Prizm",                  "ebay_kw":"Red White Blue Prizm"},
  {"label":"Orange Cracked Ice",                    "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Mojo Prizm /25",                        "ebay_kw":"Mojo Prizm"},
  {"label":"Red Prizm /299",                        "ebay_kw":"Red Prizm"},
  {"label":"Blue Prizm /199",                       "ebay_kw":"Blue Prizm"},
  {"label":"Purple Prizm /149",                     "ebay_kw":"Purple Prizm"},
  {"label":"Orange Prizm /99",                      "ebay_kw":"Orange Prizm"},
  {"label":"Teal Prizm /49",                        "ebay_kw":"Teal Prizm"},
  {"label":"Gold Prizm /10",                        "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                        "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Rookie Auto Silver",                    "ebay_kw":"Rookie Auto Silver Prizm"},
  {"label":"Rookie Auto Red /299",                  "ebay_kw":"Rookie Auto Red Prizm"},
  {"label":"Rookie Auto Blue /199",                 "ebay_kw":"Rookie Auto Blue Prizm"},
  {"label":"Rookie Auto Purple /149",               "ebay_kw":"Rookie Auto Purple Prizm"},
  {"label":"Rookie Auto Orange /99",                "ebay_kw":"Rookie Auto Orange Prizm"},
  {"label":"Rookie Auto Orange Cracked Ice /25",    "ebay_kw":"Rookie Auto Orange Cracked Ice Prizm"},
  {"label":"Rookie Auto Gold /10",                  "ebay_kw":"Rookie Auto Gold Prizm"},
  {"label":"Rookie Auto Black /1",                  "ebay_kw":"Rookie Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm WNBA';

-- ═══════════════════════════════════════════════════════════════════════════════
-- PANINI PRIZM DRAFT PICKS
-- Research: Mojo /25 confirmed, Orange Cracked Ice unnumbered, no Carolina Blue
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE card_sets SET parallels = '[
  {"label":"Base",                                  "ebay_kw":""},
  {"label":"Silver Prizm",                          "ebay_kw":"Silver Prizm"},
  {"label":"Hyper Prizm",                           "ebay_kw":"Hyper Prizm"},
  {"label":"Ice Prizm",                             "ebay_kw":"Ice Prizm"},
  {"label":"Tiger Stripe Prizm",                    "ebay_kw":"Tiger Stripe Prizm"},
  {"label":"Orange Cracked Ice",                    "ebay_kw":"Orange Cracked Ice Prizm"},
  {"label":"Mojo Prizm /25",                        "ebay_kw":"Mojo Prizm"},
  {"label":"Blue Prizm /199",                       "ebay_kw":"Blue Prizm"},
  {"label":"Purple Ice Prizm /149",                 "ebay_kw":"Purple Ice Prizm"},
  {"label":"Blue Ice Prizm /99",                    "ebay_kw":"Blue Ice Prizm"},
  {"label":"Purple Prizm /75",                      "ebay_kw":"Purple Prizm"},
  {"label":"Orange Pulsar /49",                     "ebay_kw":"Orange Pulsar Prizm"},
  {"label":"Gold Prizm /10",                        "ebay_kw":"Gold Prizm"},
  {"label":"Black Prizm /1",                        "ebay_kw":"Black Prizm"},
  {"label":"Printing Plate /1",                     "ebay_kw":"Printing Plate"},
  {"label":"Draft Auto Silver",                     "ebay_kw":"Draft Auto Silver Prizm"},
  {"label":"Draft Auto Blue /199",                  "ebay_kw":"Draft Auto Blue Prizm"},
  {"label":"Draft Auto Purple /75",                 "ebay_kw":"Draft Auto Purple Prizm"},
  {"label":"Draft Auto Orange Cracked Ice /25",     "ebay_kw":"Draft Auto Orange Cracked Ice Prizm"},
  {"label":"Draft Auto Gold /10",                   "ebay_kw":"Draft Auto Gold Prizm"},
  {"label":"Draft Auto Black /1",                   "ebay_kw":"Draft Auto Black Prizm"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Prizm Draft Picks';
