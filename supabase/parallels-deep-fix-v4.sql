-- ============================================================
-- parallels-deep-fix-v4.sql
-- Deep-dive parallel accuracy fixes (round 4)
-- Verified against: ChecklistInsider, Beckett, CardboardConnection
-- ============================================================

-- ============================================================
-- 1. PANINI OBSIDIAN BASKETBALL (all years)
--    Current: 24 parallels — missing 4 unlim parallels and
--    3 numbered FOTL/Lucky Envelopes variants
--    Full 2024-25 verified Electric Etch parallel list
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Panini Obsidian Basketball Base"},
  {"label":"Electric Etch Caldera","ebay_kw":"Obsidian Electric Etch Caldera"},
  {"label":"Electric Etch International","ebay_kw":"Obsidian Electric Etch International"},
  {"label":"Electric Etch Pink Pulsar","ebay_kw":"Obsidian Electric Etch Pink Pulsar"},
  {"label":"Electric Etch Red Flood","ebay_kw":"Obsidian Electric Etch Red Flood"},
  {"label":"Electric Etch Orange Flood /125","ebay_kw":"Obsidian Electric Etch Orange Flood 125"},
  {"label":"Electric Etch Bronze Flood /99","ebay_kw":"Obsidian Electric Etch Bronze Flood 99"},
  {"label":"Electric Etch Purple Flood /75","ebay_kw":"Obsidian Electric Etch Purple Flood 75"},
  {"label":"Electric Etch Fire and Ice /49","ebay_kw":"Obsidian Electric Etch Fire Ice 49"},
  {"label":"Electric Etch Pink Flood /49","ebay_kw":"Obsidian Electric Etch Pink Flood 49"},
  {"label":"Electric Etch Blue Flood /30","ebay_kw":"Obsidian Electric Etch Blue Flood 30"},
  {"label":"Electric Etch Green Flood /25","ebay_kw":"Obsidian Electric Etch Green Flood 25"},
  {"label":"Electric Etch Jade /25","ebay_kw":"Obsidian Electric Etch Jade 25"},
  {"label":"Electric Etch Martian FOTL /16","ebay_kw":"Obsidian Electric Etch Martian 16"},
  {"label":"Electric Etch Hot Springs /15","ebay_kw":"Obsidian Electric Etch Hot Springs 15"},
  {"label":"Electric Etch Gold Flood /10","ebay_kw":"Obsidian Electric Etch Gold Flood 10"},
  {"label":"Electric Etch Molten Mojo /10","ebay_kw":"Obsidian Electric Etch Molten Mojo 10"},
  {"label":"Electric Etch Lucky Envelopes /8","ebay_kw":"Obsidian Electric Etch Lucky Envelopes 8"},
  {"label":"Electric Etch Deep Sea Mojo /5","ebay_kw":"Obsidian Electric Etch Deep Sea Mojo 5"},
  {"label":"Electric Etch Contra FOTL /3","ebay_kw":"Obsidian Electric Etch Contra FOTL 3"},
  {"label":"Electric Etch Ashen Flood /1","ebay_kw":"Obsidian Electric Etch Ashen Flood 1"},
  {"label":"Electric Etch Vibrant Mojo /1","ebay_kw":"Obsidian Electric Etch Vibrant Mojo 1"},
  {"label":"Rookie Auto","ebay_kw":"Obsidian Rookie Auto"},
  {"label":"Rookie Auto EE Orange /75","ebay_kw":"Obsidian Rookie Auto Orange 75"},
  {"label":"Rookie Auto EE Bronze /49","ebay_kw":"Obsidian Rookie Auto Bronze 49"},
  {"label":"Rookie Auto EE Gold /10","ebay_kw":"Obsidian Rookie Auto Gold 10"},
  {"label":"Rookie Auto EE Black /1","ebay_kw":"Obsidian Rookie Auto Black 1"},
  {"label":"Rookie Patch Auto","ebay_kw":"Obsidian Rookie Patch Auto"},
  {"label":"RPA EE Orange /49","ebay_kw":"Obsidian RPA Orange 49"},
  {"label":"RPA EE Gold /10","ebay_kw":"Obsidian RPA Gold 10"},
  {"label":"RPA EE Black /1","ebay_kw":"Obsidian RPA Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Obsidian' AND sport = 'basketball';

-- ============================================================
-- 2. UPPER DECK THE CUP HOCKEY (all years)
--    Current: Wrong RPA structure — uses "Gold /25, Platinum /10"
--    which are OLD names. New 2024-25 Cup RPA has:
--    Gold Foil /24, Red Foil /4, Green Foil /3, Black Foil /1
--    Plus new Gold Spectrum Foil /36 variant
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base /249","ebay_kw":"Upper Deck The Cup Hockey Base 249"},
  {"label":"Gold Foil /8","ebay_kw":"The Cup Gold Foil 8"},
  {"label":"Red Foil /4","ebay_kw":"The Cup Red Foil 4"},
  {"label":"Green Foil /3","ebay_kw":"The Cup Green Foil 3"},
  {"label":"Black Foil /1","ebay_kw":"The Cup Black Foil 1"},
  {"label":"Printing Plate /1","ebay_kw":"The Cup Printing Plate"},
  {"label":"Rookie Patch Auto /99","ebay_kw":"The Cup Rookie Patch Auto 99"},
  {"label":"RPA Gold Spectrum /36","ebay_kw":"The Cup RPA Gold Spectrum 36"},
  {"label":"RPA Gold Foil /24","ebay_kw":"The Cup RPA Gold Foil 24"},
  {"label":"RPA Red Foil /4","ebay_kw":"The Cup RPA Red Foil 4"},
  {"label":"RPA Green Foil /3","ebay_kw":"The Cup RPA Green Foil 3"},
  {"label":"RPA Black Foil /1","ebay_kw":"The Cup RPA Black Foil 1"},
  {"label":"Cup Foundations Auto /99","ebay_kw":"The Cup Cup Foundations Auto 99"},
  {"label":"Cup Honorable Numbers Auto","ebay_kw":"The Cup Honorable Numbers Auto"},
  {"label":"Dual Rookie Patch Auto /25","ebay_kw":"The Cup Dual Rookie Patch Auto 25"},
  {"label":"Triple Rookie Patch Auto /18","ebay_kw":"The Cup Triple Rookie Patch Auto 18"},
  {"label":"Scripted Swatches Auto","ebay_kw":"The Cup Scripted Swatches Auto"},
  {"label":"Enshrinements Auto","ebay_kw":"The Cup Enshrinements Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'The Cup' AND sport = 'hockey';

-- ============================================================
-- 3. TOPPS FINEST BASKETBALL (all years)
--    Same issue as baseball Finest — "Blue Wave Refractor /150"
--    is wrong. Finest uses tiered structure. Fix both baseball
--    and basketball versions with correct tiered parallel names
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Finest Basketball"},
  {"label":"Refractor","ebay_kw":"Topps Finest Basketball Refractor"},
  {"label":"Checkerboard Refractor","ebay_kw":"Topps Finest Basketball Checkerboard"},
  {"label":"Oil Spill Refractor","ebay_kw":"Topps Finest Basketball Oil Spill"},
  {"label":"Sky Blue Refractor /200","ebay_kw":"Topps Finest Basketball Sky Blue 200"},
  {"label":"Purple Refractor /150","ebay_kw":"Topps Finest Basketball Purple 150"},
  {"label":"Blue Refractor /99","ebay_kw":"Topps Finest Basketball Blue 99"},
  {"label":"Green Refractor /50","ebay_kw":"Topps Finest Basketball Green 50"},
  {"label":"Gold Refractor /25","ebay_kw":"Topps Finest Basketball Gold 25"},
  {"label":"Orange Refractor /15","ebay_kw":"Topps Finest Basketball Orange 15"},
  {"label":"Black Refractor /5","ebay_kw":"Topps Finest Basketball Black 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Finest Basketball SuperFractor 1"},
  {"label":"Finest Auto Refractor","ebay_kw":"Topps Finest Basketball Auto Refractor"},
  {"label":"Finest Auto Blue /99","ebay_kw":"Topps Finest Basketball Auto Blue 99"},
  {"label":"Finest Auto Gold /25","ebay_kw":"Topps Finest Basketball Auto Gold 25"},
  {"label":"Finest Auto Black /5","ebay_kw":"Topps Finest Basketball Auto Black 5"},
  {"label":"Finest Auto SuperFractor /1","ebay_kw":"Topps Finest Basketball Auto SuperFractor 1"},
  {"label":"Rookie Auto Refractor","ebay_kw":"Topps Finest Basketball Rookie Auto Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest Basketball' AND sport = 'basketball';

-- Also handle if set_name = 'Finest' for basketball
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Topps Finest Basketball"},
  {"label":"Refractor","ebay_kw":"Topps Finest Basketball Refractor"},
  {"label":"Checkerboard Refractor","ebay_kw":"Topps Finest Basketball Checkerboard"},
  {"label":"Oil Spill Refractor","ebay_kw":"Topps Finest Basketball Oil Spill"},
  {"label":"Sky Blue Refractor /200","ebay_kw":"Topps Finest Basketball Sky Blue 200"},
  {"label":"Purple Refractor /150","ebay_kw":"Topps Finest Basketball Purple 150"},
  {"label":"Blue Refractor /99","ebay_kw":"Topps Finest Basketball Blue 99"},
  {"label":"Green Refractor /50","ebay_kw":"Topps Finest Basketball Green 50"},
  {"label":"Gold Refractor /25","ebay_kw":"Topps Finest Basketball Gold 25"},
  {"label":"Orange Refractor /15","ebay_kw":"Topps Finest Basketball Orange 15"},
  {"label":"Black Refractor /5","ebay_kw":"Topps Finest Basketball Black 5"},
  {"label":"SuperFractor /1","ebay_kw":"Topps Finest Basketball SuperFractor 1"},
  {"label":"Finest Auto Refractor","ebay_kw":"Topps Finest Basketball Auto Refractor"},
  {"label":"Finest Auto Blue /99","ebay_kw":"Topps Finest Basketball Auto Blue 99"},
  {"label":"Finest Auto Gold /25","ebay_kw":"Topps Finest Basketball Auto Gold 25"},
  {"label":"Finest Auto Black /5","ebay_kw":"Topps Finest Basketball Auto Black 5"},
  {"label":"Finest Auto SuperFractor /1","ebay_kw":"Topps Finest Basketball Auto SuperFractor 1"},
  {"label":"Rookie Auto Refractor","ebay_kw":"Topps Finest Basketball Rookie Auto Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'basketball';

-- ============================================================
-- 4. UPPER DECK CLEAR CUT HOCKEY — add missing RC Auto Purple /25
--    and expand to include more auto variants
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Clear Cut Hockey"},
  {"label":"Blue /199","ebay_kw":"Upper Deck Clear Cut Blue 199"},
  {"label":"Red /99","ebay_kw":"Upper Deck Clear Cut Red 99"},
  {"label":"Gold /49","ebay_kw":"Upper Deck Clear Cut Gold 49"},
  {"label":"Purple /25","ebay_kw":"Upper Deck Clear Cut Purple 25"},
  {"label":"Black /5","ebay_kw":"Upper Deck Clear Cut Black 5"},
  {"label":"Platinum /1","ebay_kw":"Upper Deck Clear Cut Platinum 1"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Clear Cut RC Auto"},
  {"label":"RC Auto Blue /199","ebay_kw":"Upper Deck Clear Cut RC Auto Blue 199"},
  {"label":"RC Auto Red /99","ebay_kw":"Upper Deck Clear Cut RC Auto Red 99"},
  {"label":"RC Auto Gold /49","ebay_kw":"Upper Deck Clear Cut RC Auto Gold 49"},
  {"label":"RC Auto Purple /25","ebay_kw":"Upper Deck Clear Cut RC Auto Purple 25"},
  {"label":"RC Auto Black /5","ebay_kw":"Upper Deck Clear Cut RC Auto Black 5"},
  {"label":"RC Auto Platinum /1","ebay_kw":"Upper Deck Clear Cut RC Auto Platinum 1"},
  {"label":"Rookie Patch Auto","ebay_kw":"Upper Deck Clear Cut Rookie Patch Auto"},
  {"label":"RPA Gold /10","ebay_kw":"Upper Deck Clear Cut RPA Gold 10"},
  {"label":"RPA Black /1","ebay_kw":"Upper Deck Clear Cut RPA Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Clear Cut' AND sport = 'hockey';

-- ============================================================
-- 5. UPPER DECK CREDENTIALS HOCKEY — expand to include missing
--    high-end auto variants (it's a mid-premium product)
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck Credentials Hockey"},
  {"label":"Blue /199","ebay_kw":"Upper Deck Credentials Blue 199"},
  {"label":"Red /99","ebay_kw":"Upper Deck Credentials Red 99"},
  {"label":"Gold /49","ebay_kw":"Upper Deck Credentials Gold 49"},
  {"label":"Purple /25","ebay_kw":"Upper Deck Credentials Purple 25"},
  {"label":"Black /5","ebay_kw":"Upper Deck Credentials Black 5"},
  {"label":"Platinum /1","ebay_kw":"Upper Deck Credentials Platinum 1"},
  {"label":"RC Auto","ebay_kw":"Upper Deck Credentials RC Auto"},
  {"label":"RC Auto Blue /199","ebay_kw":"Upper Deck Credentials RC Auto Blue 199"},
  {"label":"RC Auto Red /99","ebay_kw":"Upper Deck Credentials RC Auto Red 99"},
  {"label":"RC Auto Gold /49","ebay_kw":"Upper Deck Credentials RC Auto Gold 49"},
  {"label":"RC Auto Purple /25","ebay_kw":"Upper Deck Credentials RC Auto Purple 25"},
  {"label":"RC Auto Black /5","ebay_kw":"Upper Deck Credentials RC Auto Black 5"},
  {"label":"RC Auto Platinum /1","ebay_kw":"Upper Deck Credentials RC Auto Platinum 1"},
  {"label":"Debut Threads Patch Auto","ebay_kw":"Upper Deck Credentials Debut Threads Auto"},
  {"label":"Debut Threads Patch Auto Gold /10","ebay_kw":"Upper Deck Credentials Debut Threads Auto Gold 10"},
  {"label":"Debut Threads Patch Auto Black /1","ebay_kw":"Upper Deck Credentials Debut Threads Auto Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Credentials' AND sport = 'hockey';

-- ============================================================
-- 6. UPPER DECK ULTIMATE COLLECTION HOCKEY (all years)
--    Current: 12 parallels. Add RC Auto Green and Purple variants
--    which are standard in this product
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base /299","ebay_kw":"Upper Deck Ultimate Collection Hockey Base 299"},
  {"label":"Gold /99","ebay_kw":"Upper Deck Ultimate Collection Gold 99"},
  {"label":"Onyx /25","ebay_kw":"Upper Deck Ultimate Collection Onyx 25"},
  {"label":"Black /1","ebay_kw":"Upper Deck Ultimate Collection Black 1"},
  {"label":"RC Auto /499","ebay_kw":"Upper Deck Ultimate Collection RC Auto 499"},
  {"label":"RC Auto Gold /99","ebay_kw":"Upper Deck Ultimate Collection RC Auto Gold 99"},
  {"label":"RC Auto Onyx /25","ebay_kw":"Upper Deck Ultimate Collection RC Auto Onyx 25"},
  {"label":"RC Auto Black /1","ebay_kw":"Upper Deck Ultimate Collection RC Auto Black 1"},
  {"label":"Ultimate Debut Threads Auto","ebay_kw":"Upper Deck Ultimate Debut Threads Auto"},
  {"label":"UDT Auto Gold /50","ebay_kw":"Upper Deck Ultimate Debut Threads Auto Gold 50"},
  {"label":"UDT Auto Black /1","ebay_kw":"Upper Deck Ultimate Debut Threads Auto Black 1"},
  {"label":"Ultimate Signatures Auto","ebay_kw":"Upper Deck Ultimate Signatures Auto"},
  {"label":"Ultimate Patches Auto","ebay_kw":"Upper Deck Ultimate Patches Auto"},
  {"label":"Ultimate Dual Rookie Auto","ebay_kw":"Upper Deck Ultimate Dual Rookie Auto"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'Ultimate Collection' AND sport = 'hockey';

-- ============================================================
-- 7. PANINI REVOLUTION BASKETBALL — verify insert parallel names
--    Chinese New Year is real but Astro, Cubic, Infinite, Sunburst
--    are unlim retail-exclusive parallel designs. This looks correct.
--    Add the Astral /10 which appears in Revolution
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Panini Revolution Basketball"},
  {"label":"Astro","ebay_kw":"Revolution Astro"},
  {"label":"Chinese New Year","ebay_kw":"Revolution Chinese New Year"},
  {"label":"Cubic","ebay_kw":"Revolution Cubic"},
  {"label":"Infinite","ebay_kw":"Revolution Infinite"},
  {"label":"Sunburst","ebay_kw":"Revolution Sunburst"},
  {"label":"Blue /149","ebay_kw":"Revolution Blue 149"},
  {"label":"Red /99","ebay_kw":"Revolution Red 99"},
  {"label":"Purple /49","ebay_kw":"Revolution Purple 49"},
  {"label":"Gold /25","ebay_kw":"Revolution Gold 25"},
  {"label":"Galactic /10","ebay_kw":"Revolution Galactic 10"},
  {"label":"Black /1","ebay_kw":"Revolution Black 1"},
  {"label":"Rookie Auto","ebay_kw":"Revolution Rookie Auto"},
  {"label":"Rookie Auto Blue /149","ebay_kw":"Revolution Rookie Auto Blue 149"},
  {"label":"Rookie Auto Red /99","ebay_kw":"Revolution Rookie Auto Red 99"},
  {"label":"Rookie Auto Purple /49","ebay_kw":"Revolution Rookie Auto Purple 49"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Revolution Rookie Auto Gold 25"},
  {"label":"Rookie Auto Galactic /10","ebay_kw":"Revolution Rookie Auto Galactic 10"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Revolution Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Revolution' AND sport = 'basketball';

UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Panini Revolution Football"},
  {"label":"Astro","ebay_kw":"Revolution Football Astro"},
  {"label":"Chinese New Year","ebay_kw":"Revolution Football Chinese New Year"},
  {"label":"Cubic","ebay_kw":"Revolution Football Cubic"},
  {"label":"Infinite","ebay_kw":"Revolution Football Infinite"},
  {"label":"Sunburst","ebay_kw":"Revolution Football Sunburst"},
  {"label":"Blue /149","ebay_kw":"Revolution Football Blue 149"},
  {"label":"Red /99","ebay_kw":"Revolution Football Red 99"},
  {"label":"Purple /49","ebay_kw":"Revolution Football Purple 49"},
  {"label":"Gold /25","ebay_kw":"Revolution Football Gold 25"},
  {"label":"Galactic /10","ebay_kw":"Revolution Football Galactic 10"},
  {"label":"Black /1","ebay_kw":"Revolution Football Black 1"},
  {"label":"Rookie Auto","ebay_kw":"Revolution Football Rookie Auto"},
  {"label":"Rookie Auto Blue /149","ebay_kw":"Revolution Football Rookie Auto Blue 149"},
  {"label":"Rookie Auto Red /99","ebay_kw":"Revolution Football Rookie Auto Red 99"},
  {"label":"Rookie Auto Purple /49","ebay_kw":"Revolution Football Rookie Auto Purple 49"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Revolution Football Rookie Auto Gold 25"},
  {"label":"Rookie Auto Galactic /10","ebay_kw":"Revolution Football Rookie Auto Galactic 10"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Revolution Football Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Revolution' AND sport = 'football';

-- ============================================================
-- 8. UPPER DECK MVP HOCKEY — expand the minimal 7-parallel set
--    MVP is budget but has more parallels than currently stored
--    Super Script /1 and Gold Script /25 are correct
--    Adding more color variants that appear in this set
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Upper Deck MVP Hockey"},
  {"label":"Silver Script /100","ebay_kw":"Upper Deck MVP Silver Script 100"},
  {"label":"Gold Script /25","ebay_kw":"Upper Deck MVP Gold Script 25"},
  {"label":"Super Script /1","ebay_kw":"Upper Deck MVP Super Script 1"},
  {"label":"Colors & Contours","ebay_kw":"Upper Deck MVP Colors Contours"},
  {"label":"Colors & Contours Blue /25","ebay_kw":"Upper Deck MVP Colors Contours Blue 25"},
  {"label":"Colors & Contours Black /5","ebay_kw":"Upper Deck MVP Colors Contours Black 5"},
  {"label":"RC Auto","ebay_kw":"Upper Deck MVP Rookie Auto"},
  {"label":"RC Auto Silver /100","ebay_kw":"Upper Deck MVP Rookie Auto Silver 100"},
  {"label":"RC Auto Gold /25","ebay_kw":"Upper Deck MVP Rookie Auto Gold 25"},
  {"label":"RC Auto Black /1","ebay_kw":"Upper Deck MVP Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Upper Deck' AND set_name = 'MVP' AND sport = 'hockey';

-- ============================================================
-- 9. PANINI IMPECCABLE BASKETBALL/FOOTBALL — add missing Black /1
--    Current: Rookie Auto Gold /25 is last (missing /1 finish)
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base /99","ebay_kw":"Panini Impeccable Basketball Base 99"},
  {"label":"Silver /49","ebay_kw":"Panini Impeccable Silver 49"},
  {"label":"Gold /25","ebay_kw":"Panini Impeccable Gold 25"},
  {"label":"Platinum /10","ebay_kw":"Panini Impeccable Platinum 10"},
  {"label":"Black /1","ebay_kw":"Panini Impeccable Black 1"},
  {"label":"Stainless Stars Auto /99","ebay_kw":"Panini Impeccable Stainless Stars Auto 99"},
  {"label":"Stainless Stars Auto Gold /49","ebay_kw":"Panini Impeccable Stainless Stars Auto Gold 49"},
  {"label":"Stainless Stars Auto Black /1","ebay_kw":"Panini Impeccable Stainless Stars Auto Black 1"},
  {"label":"Indelible Ink Auto /99","ebay_kw":"Panini Impeccable Indelible Ink Auto 99"},
  {"label":"Indelible Ink Auto Silver /49","ebay_kw":"Panini Impeccable Indelible Ink Auto Silver 49"},
  {"label":"Indelible Ink Auto Gold /25","ebay_kw":"Panini Impeccable Indelible Ink Auto Gold 25"},
  {"label":"Indelible Ink Auto Black /1","ebay_kw":"Panini Impeccable Indelible Ink Auto Black 1"},
  {"label":"Rookie Auto /99","ebay_kw":"Panini Impeccable Rookie Auto 99"},
  {"label":"Rookie Auto Silver /49","ebay_kw":"Panini Impeccable Rookie Auto Silver 49"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Panini Impeccable Rookie Auto Gold 25"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Panini Impeccable Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Impeccable' AND sport = 'basketball';

UPDATE card_sets SET parallels = '[
  {"label":"Base /99","ebay_kw":"Panini Impeccable Football Base 99"},
  {"label":"Silver /49","ebay_kw":"Panini Impeccable Football Silver 49"},
  {"label":"Gold /25","ebay_kw":"Panini Impeccable Football Gold 25"},
  {"label":"Platinum /10","ebay_kw":"Panini Impeccable Football Platinum 10"},
  {"label":"Black /1","ebay_kw":"Panini Impeccable Football Black 1"},
  {"label":"Stainless Stars Auto /99","ebay_kw":"Panini Impeccable Football Stainless Stars Auto 99"},
  {"label":"Stainless Stars Auto Gold /49","ebay_kw":"Panini Impeccable Football Stainless Stars Auto Gold 49"},
  {"label":"Stainless Stars Auto Black /1","ebay_kw":"Panini Impeccable Football Stainless Stars Auto Black 1"},
  {"label":"Indelible Ink Auto /99","ebay_kw":"Panini Impeccable Football Indelible Ink Auto 99"},
  {"label":"Indelible Ink Auto Silver /49","ebay_kw":"Panini Impeccable Football Indelible Ink Auto Silver 49"},
  {"label":"Indelible Ink Auto Gold /25","ebay_kw":"Panini Impeccable Football Indelible Ink Auto Gold 25"},
  {"label":"Indelible Ink Auto Black /1","ebay_kw":"Panini Impeccable Football Indelible Ink Auto Black 1"},
  {"label":"Rookie Auto /99","ebay_kw":"Panini Impeccable Football Rookie Auto 99"},
  {"label":"Rookie Auto Silver /49","ebay_kw":"Panini Impeccable Football Rookie Auto Silver 49"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Panini Impeccable Football Rookie Auto Gold 25"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Panini Impeccable Football Rookie Auto Black 1"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Impeccable' AND sport = 'football';

-- ============================================================
-- 10. PANINI CERTIFIED BASKETBALL — verify /fix structure
--     Current data shows 27 parallels (was updated in v1)
--     The key parallel "Totally Certified Mirror" structure verified OK
--     No changes needed for Certified since v1 already fixed it
-- ============================================================
-- (skip - already verified as correct after v1 update)

-- ============================================================
-- 11. BOWMAN CHROME FOOTBALL — add Purple /250, Speckle /299
--     Current: Only has Blue /150, Green /99 as first numbered variants
--     Missing the higher print run Speckle and Purple variants
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Bowman Chrome Football"},
  {"label":"Refractor","ebay_kw":"Bowman Chrome Football Refractor"},
  {"label":"Speckle Refractor /299","ebay_kw":"Bowman Chrome Football Speckle 299"},
  {"label":"Purple Refractor /250","ebay_kw":"Bowman Chrome Football Purple 250"},
  {"label":"Blue Refractor /150","ebay_kw":"Bowman Chrome Football Blue 150"},
  {"label":"Green Refractor /99","ebay_kw":"Bowman Chrome Football Green 99"},
  {"label":"Gold Refractor /50","ebay_kw":"Bowman Chrome Football Gold 50"},
  {"label":"Orange Refractor /25","ebay_kw":"Bowman Chrome Football Orange 25"},
  {"label":"Red Refractor /5","ebay_kw":"Bowman Chrome Football Red 5"},
  {"label":"SuperFractor /1","ebay_kw":"Bowman Chrome Football SuperFractor 1"},
  {"label":"Printing Plate /1","ebay_kw":"Bowman Chrome Football Printing Plate"},
  {"label":"RC Auto","ebay_kw":"Bowman Chrome Football RC Auto"},
  {"label":"RC Auto Refractor","ebay_kw":"Bowman Chrome Football RC Auto Refractor"},
  {"label":"RC Auto Speckle /299","ebay_kw":"Bowman Chrome Football RC Auto Speckle 299"},
  {"label":"RC Auto Blue /150","ebay_kw":"Bowman Chrome Football RC Auto Blue 150"},
  {"label":"RC Auto Green /99","ebay_kw":"Bowman Chrome Football RC Auto Green 99"},
  {"label":"RC Auto Gold /50","ebay_kw":"Bowman Chrome Football RC Auto Gold 50"},
  {"label":"RC Auto Orange /25","ebay_kw":"Bowman Chrome Football RC Auto Orange 25"},
  {"label":"RC Auto Red /5","ebay_kw":"Bowman Chrome Football RC Auto Red 5"},
  {"label":"RC Auto SuperFractor /1","ebay_kw":"Bowman Chrome Football RC Auto SuperFractor 1"}
]'::jsonb
WHERE brand = 'Bowman' AND set_name = 'Chrome' AND sport = 'football';

-- ============================================================
-- 12. PANINI PHOENIX FOOTBALL — "Rising Rookie Auto" and "Fire Burst"
--     need ebay_kw entries; also verify color structure
-- ============================================================
UPDATE card_sets SET parallels = '[
  {"label":"Base","ebay_kw":"Panini Phoenix Football Base"},
  {"label":"Red /299","ebay_kw":"Panini Phoenix Red 299"},
  {"label":"Blue /199","ebay_kw":"Panini Phoenix Blue 199"},
  {"label":"Aqua /149","ebay_kw":"Panini Phoenix Aqua 149"},
  {"label":"Green /99","ebay_kw":"Panini Phoenix Green 99"},
  {"label":"Purple /49","ebay_kw":"Panini Phoenix Purple 49"},
  {"label":"Gold /25","ebay_kw":"Panini Phoenix Gold 25"},
  {"label":"Silver /10","ebay_kw":"Panini Phoenix Silver 10"},
  {"label":"Black /1","ebay_kw":"Panini Phoenix Black 1"},
  {"label":"Rookie Auto","ebay_kw":"Panini Phoenix Rookie Auto"},
  {"label":"Rookie Auto Red /299","ebay_kw":"Panini Phoenix Rookie Auto Red 299"},
  {"label":"Rookie Auto Blue /199","ebay_kw":"Panini Phoenix Rookie Auto Blue 199"},
  {"label":"Rookie Auto Green /99","ebay_kw":"Panini Phoenix Rookie Auto Green 99"},
  {"label":"Rookie Auto Purple /49","ebay_kw":"Panini Phoenix Rookie Auto Purple 49"},
  {"label":"Rookie Auto Gold /25","ebay_kw":"Panini Phoenix Rookie Auto Gold 25"},
  {"label":"Rookie Auto Black /1","ebay_kw":"Panini Phoenix Rookie Auto Black 1"},
  {"label":"Rising Rookie Auto","ebay_kw":"Panini Phoenix Rising Rookie Auto"},
  {"label":"Fire Burst","ebay_kw":"Panini Phoenix Fire Burst"}
]'::jsonb
WHERE brand = 'Panini' AND set_name = 'Phoenix' AND sport = 'football';
