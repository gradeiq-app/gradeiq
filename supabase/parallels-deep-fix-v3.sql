-- ============================================================
-- parallels-deep-fix-v3.sql
-- Deep-dive parallel accuracy fixes (round 3)
-- Verified against: ChecklistInsider, Beckett, Topps Ripped
-- ============================================================

-- ============================================================
-- 1. TOPPS CHROME FOOTBALL (all years)
--    Current errors: "Pink Refractor /199" (Pink=unlim),
--    "Blue Wave Refractor /150" (doesn't exist in football Chrome)
--    Football Chrome has DIFFERENT color/print-run structure vs baseball:
--    Teal /250 (not Purple), Magenta /399, White Geometric /15,
--    Black Geometric /2, FrozenFractor /-5
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Chrome Football"},
  {"label":"Refractor","ebay_kw":"Topps Chrome Football Refractor"},
  {"label":"Prism Refractor","ebay_kw":"Topps Chrome Football Prism Refractor"},
  {"label":"X-Fractor","ebay_kw":"Topps Chrome Football X-Fractor"},
  {"label":"Sepia Refractor","ebay_kw":"Topps Chrome Football Sepia Refractor"},
  {"label":"Negative Refractor","ebay_kw":"Topps Chrome Football Negative Refractor"},
  {"label":"Pink Refractor","ebay_kw":"Topps Chrome Football Pink Refractor"},
  {"label":"Camo Wave Refractor","ebay_kw":"Topps Chrome Football Camo Wave"},
  {"label":"Magenta Refractor /399","ebay_kw":"Topps Chrome Football Magenta 399"},
  {"label":"Magenta Speckle /399","ebay_kw":"Topps Chrome Football Magenta Speckle 399"},
  {"label":"Purple Speckle /275","ebay_kw":"Topps Chrome Football Purple Speckle 275"},
  {"label":"Purple Refractor /275","ebay_kw":"Topps Chrome Football Purple 275"},
  {"label":"Teal Refractor /250","ebay_kw":"Topps Chrome Football Teal 250"},
  {"label":"Aqua Refractor /199","ebay_kw":"Topps Chrome Football Aqua 199"},
  {"label":"Blue Refractor /150","ebay_kw":"Topps Chrome Football Blue 150"},
  {"label":"Blue Sonar /150","ebay_kw":"Topps Chrome Football Blue Sonar 150"},
  {"label":"Green Refractor /99","ebay_kw":"Topps Chrome Football Green 99"},
  {"label":"Yellow Refractor /75","ebay_kw":"Topps Chrome Football Yellow 75"},
  {"label":"Gold Refractor /50","ebay_kw":"Topps Chrome Football Gold 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Topps Chrome Football Orange 25"},
  {"label":"White Geometric /15","ebay_kw":"Topps Chrome Football White Geometric 15"},
  {"label":"Red Refractor /5","ebay_kw":"Topps Chrome Football Red 5"},
  {"label":"Black Geometric /2","ebay_kw":"Topps Chrome Football Black Geometric 2"},
  {"label":"FrozenFractor","ebay_kw":"Topps Chrome Football FrozenFractor"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Chrome Football SuperFractor 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Chrome Football Printing Plate"},
  {"label":"RC Auto","ebay_kw":"Topps Chrome Football Rookie Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"Topps Chrome Football Rookie Auto Refractor"},
  {"label":"RC Auto Blue /150","ebay_kw":"Topps Chrome Football Rookie Auto Blue 150"},
  {"label":"RC Auto Gold /50","ebay_kw":"Topps Chrome Football Rookie Auto Gold 50"},
  {"label":"RC Auto Orange /25","ebay_kw":"Topps Chrome Football Rookie Auto Orange 25"},
  {"label":"RC Auto Red /5","ebay_kw":"Topps Chrome Football Rookie Auto Red 5"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"Topps Chrome Football Rookie Auto SuperFractor 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Chrome' AND sport = 'football';

-- ============================================================
-- 2. BOWMAN DRAFT CHROME BASEBALL (all years)
--    "Pink Refractor /250" is WRONG — should be "Purple Refractor /250"
--    There is no Pink parallel in Bowman Draft Chrome
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Bowman Draft Chrome Baseball"},
  {"label":"Refractor","ebay_kw":"Bowman Draft Chrome Refractor"},
  {"label":"Negative Refractor","ebay_kw":"Bowman Draft Chrome Negative Refractor"},
  {"label":"X-Fractor","ebay_kw":"Bowman Draft Chrome X-Fractor"},
  {"label":"Speckle Refractor /299","ebay_kw":"Bowman Draft Chrome Speckle 299"},
  {"label":"Purple Refractor /250","ebay_kw":"Bowman Draft Chrome Purple 250"},
  {"label":"Blue Refractor /150","ebay_kw":"Bowman Draft Chrome Blue 150"},
  {"label":"Green Refractor /99","ebay_kw":"Bowman Draft Chrome Green 99"},
  {"label":"Gold Refractor /50","ebay_kw":"Bowman Draft Chrome Gold 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Bowman Draft Chrome Orange 25"},
  {"label":"Red Refractor /5","ebay_kw":"Bowman Draft Chrome Red 5"},
  {"label":"SuperFractor /1","ebay_kw":"Bowman Draft Chrome SuperFractor 1"},
  {"label":"Draft Pick Auto","ebay_kw":"Bowman Draft Chrome Draft Pick Auto"},
  {"label":"Draft Pick Auto Refractor","ebay_kw":"Bowman Draft Chrome Draft Pick Auto Refractor"},
  {"label":"Draft Pick Auto Blue /150","ebay_kw":"Bowman Draft Chrome Auto Blue 150"},
  {"label":"Draft Pick Auto Gold /50","ebay_kw":"Bowman Draft Chrome Auto Gold 50"},
  {"label":"Draft Pick Auto Orange /25","ebay_kw":"Bowman Draft Chrome Auto Orange 25"},
  {"label":"Draft Pick Auto Red /5","ebay_kw":"Bowman Draft Chrome Auto Red 5"},
  {"label":"Draft Pick Auto SuperFractor /1","ebay_kw":"Bowman Draft Chrome Auto SuperFractor 1"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Draft Chrome' AND sport = 'baseball';

-- ============================================================
-- 3. BOWMAN BASE BASEBALL (all years)
--    Current: Missing Purple /250, wrong order (Blue /150 listed
--    before Gold /50 and Orange /25 making it appear /150 > /50)
--    Fix: Add Purple /250 and correct ordering
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Bowman Baseball Base"},
  {"label":"Foil","ebay_kw":"Bowman Baseball Foil"},
  {"label":"Purple /250","ebay_kw":"Bowman Baseball Purple 250"},
  {"label":"Blue /150","ebay_kw":"Bowman Baseball Blue 150"},
  {"label":"Gold /50","ebay_kw":"Bowman Baseball Gold 50"},
  {"label":"Orange /25","ebay_kw":"Bowman Baseball Orange 25"},
  {"label":"Red /5","ebay_kw":"Bowman Baseball Red 5"},
  {"label":"Platinum /1","ebay_kw":"Bowman Baseball Platinum 1"},
  {"label":"Prospect Auto","ebay_kw":"Bowman Baseball Prospect Auto"},
  {"label":"Prospect Auto Blue /150","ebay_kw":"Bowman Baseball Prospect Auto Blue 150"},
  {"label":"Prospect Auto Gold /50","ebay_kw":"Bowman Baseball Prospect Auto Gold 50"},
  {"label":"Prospect Auto Orange /25","ebay_kw":"Bowman Baseball Prospect Auto Orange 25"},
  {"label":"Prospect Auto Red /5","ebay_kw":"Bowman Baseball Prospect Auto Red 5"},
  {"label":"Prospect Auto Platinum /1","ebay_kw":"Bowman Baseball Prospect Auto Platinum 1"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Base' AND sport = 'baseball';

-- ============================================================
-- 4. TOPPS UPDATE SERIES BASEBALL (all years)
--    Fix: Black /73 → /74, add First Card /1 marker,
--    Gold print run note (numbered to year+1 on Update sets)
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Update Series Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Update Short Print SP"},
  {"label":"Gold Foil","ebay_kw":"Topps Update Gold Foil"},
  {"label":"Rainbow Foil","ebay_kw":"Topps Update Rainbow Foil"},
  {"label":"Gold (numbered)","ebay_kw":"Topps Update Gold numbered"},
  {"label":"Blue Holofoil /999","ebay_kw":"Topps Update Blue Holofoil 999"},
  {"label":"Purple Holofoil /799","ebay_kw":"Topps Update Purple Holofoil 799"},
  {"label":"Green Crackle /499","ebay_kw":"Topps Update Green Crackle 499"},
  {"label":"Orange Crackle /299","ebay_kw":"Topps Update Orange Crackle 299"},
  {"label":"Red Crackle /199","ebay_kw":"Topps Update Red Crackle 199"},
  {"label":"Vintage Stock /99","ebay_kw":"Topps Update Vintage Stock 99"},
  {"label":"Independence Day /76","ebay_kw":"Topps Update Independence Day 76"},
  {"label":"Black /74","ebay_kw":"Topps Update Black 74"},
  {"label":"Yellow Crackle /50","ebay_kw":"Topps Update Yellow Crackle 50"},
  {"label":"Father Day Powder Blue /50","ebay_kw":"Topps Update Father Day Powder Blue 50"},
  {"label":"Mother Day Hot Pink /50","ebay_kw":"Topps Update Mother Day Hot Pink 50"},
  {"label":"Memorial Day Camo /25","ebay_kw":"Topps Update Memorial Day Camo 25"},
  {"label":"Clear /10","ebay_kw":"Topps Update Clear 10"},
  {"label":"First Card /1","ebay_kw":"Topps Update First Card 1"},
  {"label":"Platinum /1","ebay_kw":"Topps Update Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Update Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Update Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Update Autograph Gold 50"},
  {"label":"Autograph Red /25","ebay_kw":"Topps Update Autograph Red 25"},
  {"label":"Autograph Black /1","ebay_kw":"Topps Update Autograph Black 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Update Series' AND sport = 'baseball';

-- Also fix the old "Update" set name which may have old data
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Update Series Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Update Short Print SP"},
  {"label":"Gold Foil","ebay_kw":"Topps Update Gold Foil"},
  {"label":"Rainbow Foil","ebay_kw":"Topps Update Rainbow Foil"},
  {"label":"Gold (numbered)","ebay_kw":"Topps Update Gold numbered"},
  {"label":"Blue Holofoil /999","ebay_kw":"Topps Update Blue Holofoil 999"},
  {"label":"Purple Holofoil /799","ebay_kw":"Topps Update Purple Holofoil 799"},
  {"label":"Green Crackle /499","ebay_kw":"Topps Update Green Crackle 499"},
  {"label":"Orange Crackle /299","ebay_kw":"Topps Update Orange Crackle 299"},
  {"label":"Red Crackle /199","ebay_kw":"Topps Update Red Crackle 199"},
  {"label":"Vintage Stock /99","ebay_kw":"Topps Update Vintage Stock 99"},
  {"label":"Independence Day /76","ebay_kw":"Topps Update Independence Day 76"},
  {"label":"Black /74","ebay_kw":"Topps Update Black 74"},
  {"label":"Yellow Crackle /50","ebay_kw":"Topps Update Yellow Crackle 50"},
  {"label":"Memorial Day Camo /25","ebay_kw":"Topps Update Memorial Day Camo 25"},
  {"label":"Clear /10","ebay_kw":"Topps Update Clear 10"},
  {"label":"Platinum /1","ebay_kw":"Topps Update Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Update Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Update Autograph"},
  {"label":"Autograph Gold /50","ebay_kw":"Topps Update Autograph Gold 50"},
  {"label":"Autograph Red /25","ebay_kw":"Topps Update Autograph Red 25"},
  {"label":"Autograph Black /1","ebay_kw":"Topps Update Autograph Black 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Update' AND sport = 'baseball';

-- ============================================================
-- 5. TOPPS FINEST BASEBALL (all years)
--    Current: "Blue Wave Refractor /150" is wrong name for Finest
--    Finest uses tiered structure; key parallels are Oil Spill,
--    Checkerboard, Sky Blue, actual Blue, Green, Gold, Orange, Red, Black
--    Also fix to include correct non-wave variants
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Finest Baseball"},
  {"label":"Refractor","ebay_kw":"Topps Finest Refractor"},
  {"label":"Checkerboard Refractor","ebay_kw":"Topps Finest Checkerboard Refractor"},
  {"label":"Oil Spill Refractor","ebay_kw":"Topps Finest Oil Spill Refractor"},
  {"label":"Sky Blue Refractor /200","ebay_kw":"Topps Finest Sky Blue 200"},
  {"label":"Purple Refractor /150","ebay_kw":"Topps Finest Purple 150"},
  {"label":"Blue Refractor /99","ebay_kw":"Topps Finest Blue 99"},
  {"label":"Green Refractor /50","ebay_kw":"Topps Finest Green 50"},
  {"label":"Gold Refractor /25","ebay_kw":"Topps Finest Gold 25"},
  {"label":"Orange Refractor /15","ebay_kw":"Topps Finest Orange 15"},
  {"label":"Black Refractor /5","ebay_kw":"Topps Finest Black 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Finest SuperFractor 1"},
  {"label":"Finest Auto","ebay_kw":"Topps Finest Autograph"},
  {"label":"Finest Auto Refractor","ebay_kw":"Topps Finest Autograph Refractor"},
  {"label":"Finest Auto Blue /99","ebay_kw":"Topps Finest Autograph Blue 99"},
  {"label":"Finest Auto Gold /25","ebay_kw":"Topps Finest Autograph Gold 25"},
  {"label":"Finest Auto Orange /15","ebay_kw":"Topps Finest Autograph Orange 15"},
  {"label":"Finest Auto Black /5","ebay_kw":"Topps Finest Autograph Black 5"},
  {"label":"Finest Auto SuperFractor /1","ebay_kw":"Topps Finest Autograph SuperFractor 1"},
  {"label":"Rookie Auto Refractor","ebay_kw":"Topps Finest Rookie Auto Refractor"},
  {"label":"Rookie Patch Auto","ebay_kw":"Topps Finest Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball';

-- ============================================================
-- 6. TOPPS FINEST FOOTBALL (same tiered structure, different brand)
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Finest Football"},
  {"label":"Refractor","ebay_kw":"Topps Finest Football Refractor"},
  {"label":"Checkerboard Refractor","ebay_kw":"Topps Finest Football Checkerboard"},
  {"label":"Oil Spill Refractor","ebay_kw":"Topps Finest Football Oil Spill"},
  {"label":"Sky Blue Refractor /200","ebay_kw":"Topps Finest Football Sky Blue 200"},
  {"label":"Purple Refractor /150","ebay_kw":"Topps Finest Football Purple 150"},
  {"label":"Blue Refractor /99","ebay_kw":"Topps Finest Football Blue 99"},
  {"label":"Green Refractor /50","ebay_kw":"Topps Finest Football Green 50"},
  {"label":"Gold Refractor /25","ebay_kw":"Topps Finest Football Gold 25"},
  {"label":"Orange Refractor /15","ebay_kw":"Topps Finest Football Orange 15"},
  {"label":"Black Refractor /5","ebay_kw":"Topps Finest Football Black 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Finest Football SuperFractor 1"},
  {"label":"Rookie Auto Refractor","ebay_kw":"Topps Finest Football Rookie Auto Refractor"},
  {"label":"Rookie Auto Blue /99","ebay_kw":"Topps Finest Football Rookie Auto Blue 99"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Topps Finest Football Rookie Auto Gold 25"},
  {"label":"Rookie Auto Black /5","ebay_kw":"Topps Finest Football Rookie Auto Black 5"},
  {"label":"Rookie Auto SuperFractor /1","ebay_kw":"Topps Finest Football Rookie Auto SuperFractor 1"},
  {"label":"Rookie Patch Auto","ebay_kw":"Topps Finest Football Rookie Patch Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'football';

-- ============================================================
-- 7. TOPPS GYPSY QUEEN BASEBALL — fix duplicate /99 colors
--    Current: Purple /99 AND Red /99 (both same print run odd),
--    Gold /50 AND Black /50 (both same print run)
--    Real GQ: Green /199, Blue /150, Purple /99, Red /50, Black /25
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Gypsy Queen Baseball"},
  {"label":"Mini","ebay_kw":"Topps Gypsy Queen Mini"},
  {"label":"Green /199","ebay_kw":"Topps Gypsy Queen Green 199"},
  {"label":"Blue /150","ebay_kw":"Topps Gypsy Queen Blue 150"},
  {"label":"Purple /99","ebay_kw":"Topps Gypsy Queen Purple 99"},
  {"label":"Red /50","ebay_kw":"Topps Gypsy Queen Red 50"},
  {"label":"Black /25","ebay_kw":"Topps Gypsy Queen Black 25"},
  {"label":"Gold /10","ebay_kw":"Topps Gypsy Queen Gold 10"},
  {"label":"Platinum /1","ebay_kw":"Topps Gypsy Queen Platinum 1"},
  {"label":"Printing Plate /1","ebay_kw":"Topps Gypsy Queen Printing Plate"},
  {"label":"Autograph","ebay_kw":"Topps Gypsy Queen Autograph"},
  {"label":"Autograph Green /199","ebay_kw":"Topps Gypsy Queen Autograph Green 199"},
  {"label":"Autograph Red /50","ebay_kw":"Topps Gypsy Queen Autograph Red 50"},
  {"label":"Autograph Black /25","ebay_kw":"Topps Gypsy Queen Autograph Black 25"},
  {"label":"Autograph Gold /10","ebay_kw":"Topps Gypsy Queen Autograph Gold 10"},
  {"label":"Autograph Platinum /1","ebay_kw":"Topps Gypsy Queen Autograph Platinum 1"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Gypsy Queen' AND sport = 'baseball';

-- ============================================================
-- 8. TOPPS ARCHIVES BASEBALL — fix Gold /50 duplicate
--    Current: "Purple /50 | Gold /50" both same print run
--    Real Archives: Blue /99, Purple /75, Red /50, Gold /25, Black /5
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Archives Baseball"},
  {"label":"Short Print SP","ebay_kw":"Topps Archives Short Print SP"},
  {"label":"Blue /99","ebay_kw":"Topps Archives Blue 99"},
  {"label":"Purple /75","ebay_kw":"Topps Archives Purple 75"},
  {"label":"Red /50","ebay_kw":"Topps Archives Red 50"},
  {"label":"Gold /25","ebay_kw":"Topps Archives Gold 25"},
  {"label":"Black /5","ebay_kw":"Topps Archives Black 5"},
  {"label":"Platinum /1","ebay_kw":"Topps Archives Platinum 1"},
  {"label":"Fan Favorites Auto","ebay_kw":"Topps Archives Fan Favorites Auto"},
  {"label":"Fan Favorites Auto Blue /99","ebay_kw":"Topps Archives Fan Favorites Auto Blue 99"},
  {"label":"Fan Favorites Auto Red /50","ebay_kw":"Topps Archives Fan Favorites Auto Red 50"},
  {"label":"Fan Favorites Auto Gold /25","ebay_kw":"Topps Archives Fan Favorites Auto Gold 25"},
  {"label":"Fan Favorites Auto Black /5","ebay_kw":"Topps Archives Fan Favorites Auto Black 5"},
  {"label":"1965 Topps Auto","ebay_kw":"Topps Archives 1965 Auto"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Archives' AND sport = 'baseball';

-- ============================================================
-- 9. UPPER Deck SPx HOCKEY — add Winning Materials structure
--    Current: 11 parallels, but missing key Rookie material autos
--    SPx Rookie Auto structure: Spectrum /299, Gold /199, Blue /100,
--    Purple /50, Green /25, Black /1, Winning Materials Auto
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck SPx Hockey"},
  {"label":"Spectrum /299","ebay_kw":"SPx Spectrum 299"},
  {"label":"Gold /199","ebay_kw":"SPx Gold 199"},
  {"label":"Blue /100","ebay_kw":"SPx Blue 100"},
  {"label":"Purple /50","ebay_kw":"SPx Purple 50"},
  {"label":"Green /25","ebay_kw":"SPx Green 25"},
  {"label":"Black /1","ebay_kw":"SPx Black 1"},
  {"label":"Winning Materials Auto","ebay_kw":"SPx Winning Materials Auto"},
  {"label":"WMA Gold /199","ebay_kw":"SPx Winning Materials Auto Gold 199"},
  {"label":"WMA Blue /100","ebay_kw":"SPx Winning Materials Auto Blue 100"},
  {"label":"WMA Green /25","ebay_kw":"SPx Winning Materials Auto Green 25"},
  {"label":"WMA Black /1","ebay_kw":"SPx Winning Materials Auto Black 1"},
  {"label":"RC Auto","ebay_kw":"SPx Rookie Auto"},
  {"label":"RC Auto Gold /199","ebay_kw":"SPx Rookie Auto Gold 199"},
  {"label":"RC Auto Blue /100","ebay_kw":"SPx Rookie Auto Blue 100"},
  {"label":"RC Auto Green /25","ebay_kw":"SPx Rookie Auto Green 25"},
  {"label":"RC Auto Black /1","ebay_kw":"SPx Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'SPx' AND sport = 'hockey';

-- ============================================================
-- 10. UPPER DECK ICE HOCKEY — fix color/structure
--     Current: 12 parallels with Glacial Graphs, Frozen Fabrics (inserts)
--     Ice RC Premieres are the key RC card in this product;
--     also has numbered base parallels
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Ice Hockey"},
  {"label":"Ice Premieres RC","ebay_kw":"Upper Deck Ice Premieres RC"},
  {"label":"Retro /99","ebay_kw":"Upper Deck Ice Retro 99"},
  {"label":"Blue /50","ebay_kw":"Upper Deck Ice Blue 50"},
  {"label":"Purple /25","ebay_kw":"Upper Deck Ice Purple 25"},
  {"label":"Gold /10","ebay_kw":"Upper Deck Ice Gold 10"},
  {"label":"Black /1","ebay_kw":"Upper Deck Ice Black 1"},
  {"label":"Ice Premieres Auto","ebay_kw":"Upper Deck Ice Premieres Auto"},
  {"label":"Ice Premieres Auto Retro /99","ebay_kw":"Upper Deck Ice Premieres Auto Retro 99"},
  {"label":"Ice Premieres Auto Gold /10","ebay_kw":"Upper Deck Ice Premieres Auto Gold 10"},
  {"label":"Ice Premieres Auto Black /1","ebay_kw":"Upper Deck Ice Premieres Auto Black 1"},
  {"label":"Glacial Graphs Auto","ebay_kw":"Upper Deck Ice Glacial Graphs Auto"},
  {"label":"Frozen Fabrics Patch Auto","ebay_kw":"Upper Deck Ice Frozen Fabrics Auto"},
  {"label":"Frozen Fabrics Patch Auto Gold /10","ebay_kw":"Upper Deck Ice Frozen Fabrics Auto Gold 10"},
  {"label":"Frozen Fabrics Patch Auto Black /1","ebay_kw":"Upper Deck Ice Frozen Fabrics Auto Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ice' AND sport = 'hockey';

-- ============================================================
-- 11. UPPER DECK ENGRAINED HOCKEY
--     Current: 12 parallels, verify structure
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Engrained Hockey"},
  {"label":"Blue /299","ebay_kw":"Upper Deck Engrained Blue 299"},
  {"label":"Red /199","ebay_kw":"Upper Deck Engrained Red 199"},
  {"label":"Gold /99","ebay_kw":"Upper Deck Engrained Gold 99"},
  {"label":"Cyan /49","ebay_kw":"Upper Deck Engrained Cyan 49"},
  {"label":"Violet /25","ebay_kw":"Upper Deck Engrained Violet 25"},
  {"label":"Black /1","ebay_kw":"Upper Deck Engrained Black 1"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Engrained RC Auto"},
  {"label":"RC Auto Blue /299","ebay_kw":"Upper Deck Engrained RC Auto Blue 299"},
  {"label":"RC Auto Red /199","ebay_kw":"Upper Deck Engrained RC Auto Red 199"},
  {"label":"RC Auto Gold /99","ebay_kw":"Upper Deck Engrained RC Auto Gold 99"},
  {"label":"RC Auto Cyan /49","ebay_kw":"Upper Deck Engrained RC Auto Cyan 49"},
  {"label":"RC Auto Violet /25","ebay_kw":"Upper Deck Engrained RC Auto Violet 25"},
  {"label":"RC Auto Black /1","ebay_kw":"Upper Deck Engrained RC Auto Black 1"},
  {"label":"Wood Auto","ebay_kw":"Upper Deck Engrained Wood Auto"},
  {"label":"Wood Auto Gold /25","ebay_kw":"Upper Deck Engrained Wood Auto Gold 25"},
  {"label":"Wood Auto Black /1","ebay_kw":"Upper Deck Engrained Wood Auto Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Engrained' AND sport = 'hockey';

-- ============================================================
-- 12. PANINI CONTENDERS DRAFT PICKS (both sports, all years)
--     "Championship Ticket /10" IS correct for Draft Picks base
--     BUT the auto Championship Ticket should be /1 (not /10)
--     Adding more parallels also missing from this product
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Contenders Draft Picks Basketball"},
  {"label":"Draft Ticket Auto","ebay_kw":"Contenders Draft Picks Auto"},
  {"label":"Season Ticket /249","ebay_kw":"Contenders Draft Picks Season Ticket 249"},
  {"label":"Draft Ticket Cracked Ice /25","ebay_kw":"Contenders Draft Picks Cracked Ice 25"},
  {"label":"Championship Ticket /10","ebay_kw":"Contenders Draft Picks Championship Ticket 10"},
  {"label":"Printing Plate /1","ebay_kw":"Contenders Draft Picks Printing Plate"},
  {"label":"Draft Ticket Auto Season /249","ebay_kw":"Contenders Draft Picks Auto Season 249"},
  {"label":"Draft Ticket Auto Cracked Ice /25","ebay_kw":"Contenders Draft Picks Auto Cracked Ice 25"},
  {"label":"Draft Ticket Auto Championship /1","ebay_kw":"Contenders Draft Picks Auto Championship 1"},
  {"label":"Draft Ticket Auto Printing Plate /1","ebay_kw":"Contenders Draft Picks Auto Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Draft Picks' AND sport = 'basketball';

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Contenders Draft Picks Football"},
  {"label":"Draft Ticket Auto","ebay_kw":"Contenders Draft Picks Football Auto"},
  {"label":"Season Ticket /249","ebay_kw":"Contenders Draft Picks Football Season Ticket 249"},
  {"label":"Draft Ticket Cracked Ice /25","ebay_kw":"Contenders Draft Picks Football Cracked Ice 25"},
  {"label":"Championship Ticket /10","ebay_kw":"Contenders Draft Picks Football Championship Ticket 10"},
  {"label":"Printing Plate /1","ebay_kw":"Contenders Draft Picks Football Printing Plate"},
  {"label":"Draft Ticket Auto Season /249","ebay_kw":"Contenders Draft Picks Football Auto Season 249"},
  {"label":"Draft Ticket Auto Cracked Ice /25","ebay_kw":"Contenders Draft Picks Football Auto Cracked Ice 25"},
  {"label":"Draft Ticket Auto Championship /1","ebay_kw":"Contenders Draft Picks Football Auto Championship 1"},
  {"label":"Draft Ticket Auto Printing Plate /1","ebay_kw":"Contenders Draft Picks Football Auto Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Draft Picks' AND sport = 'football';

-- ============================================================
-- 13. PANINI CONTENDERS ROOKIE TICKET AUTO (basketball only)
--     Same Championship Ticket fix — Auto Championship should be /1
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Contenders Rookie Ticket Auto Basketball"},
  {"label":"Rookie Ticket Auto","ebay_kw":"Contenders Rookie Ticket Auto"},
  {"label":"Season Ticket /249","ebay_kw":"Contenders Season Ticket 249"},
  {"label":"Cracked Ice /25","ebay_kw":"Contenders Cracked Ice 25"},
  {"label":"Championship Ticket /10","ebay_kw":"Contenders Championship Ticket 10"},
  {"label":"Printing Plate /1","ebay_kw":"Contenders Printing Plate"},
  {"label":"Rookie Ticket Auto Cracked Ice /25","ebay_kw":"Contenders Rookie Auto Cracked Ice 25"},
  {"label":"Rookie Ticket Auto Championship /1","ebay_kw":"Contenders Rookie Auto Championship 1"},
  {"label":"Rookie Ticket Auto Printing Plate /1","ebay_kw":"Contenders Rookie Auto Printing Plate"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Contenders Rookie Ticket Auto' AND sport = 'basketball';
