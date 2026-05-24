-- ============================================================
-- parallels-deep-fix-v16.sql
-- Topps Finest Baseball 1993-2025: Replace uniform 21-parallel
-- template with historically accurate per-year parallel structures.
-- Sources: BaseballCardPedia.com, CardboardConnection.com, Topps Ripped
-- NOTE: brand = 'Topps', set_name = 'Finest', sport = 'baseball'
-- ============================================================

-- 1993: BIRTHPLACE OF REFRACTORS — single Refractor parallel (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1993 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "1993 Topps Finest Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1993;

-- 1994: Same — Refractor (unnumbered)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1994 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "1994 Topps Finest Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1994;

-- 1995: Same — Refractor (~550, unnumbered); peel-off coating intro
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1995 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "1995 Topps Finest Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1995;

-- 1996: First tiered Refractors — Bronze (1:12), Silver (1:48), Gold (1:288)
--       All unnumbered; Gold print run disputed (legal issues)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1996 Topps Finest Baseball"},
  {"label": "Bronze Refractor", "ebay_kw": "1996 Topps Finest Bronze Refractor"},
  {"label": "Silver Refractor", "ebay_kw": "1996 Topps Finest Silver Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "1996 Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1996;

-- 1997: Bronze/Silver/Gold Refractors + Embossed parallels (Silver & Gold tiers only)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1997 Topps Finest Baseball"},
  {"label": "Bronze Refractor", "ebay_kw": "1997 Topps Finest Bronze Refractor"},
  {"label": "Silver Refractor", "ebay_kw": "1997 Topps Finest Silver Refractor"},
  {"label": "Gold Refractor", "ebay_kw": "1997 Topps Finest Gold Refractor"},
  {"label": "Silver Embossed Refractor", "ebay_kw": "1997 Topps Finest Embossed Refractor"},
  {"label": "Gold Embossed Die-Cut Refractor", "ebay_kw": "1997 Topps Finest Gold Embossed Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1997;

-- 1998: No-Protector + Refractor + No-Protector Refractor (all unnumbered)
--       Series 1 had Centurions /500 + Centurions Refractor /75 inserts
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1998 Topps Finest Baseball"},
  {"label": "No-Protector", "ebay_kw": "1998 Topps Finest No Protector"},
  {"label": "Refractor", "ebay_kw": "1998 Topps Finest Refractor"},
  {"label": "No-Protector Refractor", "ebay_kw": "1998 Topps Finest No Protector Refractor"},
  {"label": "Centurions Refractor /75", "ebay_kw": "1998 Topps Finest Centurions Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1998;

-- 1999: Refractor (unnumb), Gold Refractor /100
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "1999 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "1999 Topps Finest Refractor"},
  {"label": "Gold Refractor /100", "ebay_kw": "1999 Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 1999;

-- 2000: Refractor (unnumb), Gold Refractor /100 (deckled edges on Gold)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2000 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2000 Topps Finest Refractor"},
  {"label": "Gold Refractor /100", "ebay_kw": "2000 Topps Finest Gold Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2000;

-- 2001: Numbered Refractors by subset (/499 vets, /399 stand-outs, /241 prospects)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2001 Topps Finest Baseball"},
  {"label": "Refractor /499", "ebay_kw": "2001 Topps Finest Refractor"},
  {"label": "Prospects Refractor /241", "ebay_kw": "2001 Topps Finest Prospects Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2001;

-- 2002: Refractor /499, X-Fractor /299, X-Fractor w/Protector /99
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2002 Topps Finest Baseball"},
  {"label": "Refractor /499", "ebay_kw": "2002 Topps Finest Refractor"},
  {"label": "X-Fractor /299", "ebay_kw": "2002 Topps Finest X-Fractor"},
  {"label": "X-Fractor w/Protector /99", "ebay_kw": "2002 Topps Finest X-Fractor Protector"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2002;

-- 2003: Refractor (unnumb), X-Fractor /99; Auto Refractor /199; Gold X-Fractor /199 (box topper)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2003 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2003 Topps Finest Refractor"},
  {"label": "X-Fractor /99", "ebay_kw": "2003 Topps Finest X-Fractor"},
  {"label": "Auto Refractor /199", "ebay_kw": "2003 Topps Finest Auto Refractor"},
  {"label": "Gold X-Fractor /199", "ebay_kw": "2003 Topps Finest Gold X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2003;

-- 2004: Refractor (unnumb), Gold Refractor /50, Uncirculated Gold X-Fractor /139
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2004 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2004 Topps Finest Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2004 Topps Finest Gold Refractor"},
  {"label": "Uncirculated Gold X-Fractor /139", "ebay_kw": "2004 Topps Finest Gold X-Fractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2004;

-- 2005: Peak complexity era — 14 parallel tiers; X-Fractor variants at every color
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2005 Topps Finest Baseball"},
  {"label": "Refractor /399", "ebay_kw": "2005 Topps Finest Refractor"},
  {"label": "Blue Refractor /299", "ebay_kw": "2005 Topps Finest Blue Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "2005 Topps Finest X-Fractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2005 Topps Finest Green Refractor"},
  {"label": "Blue X-Fractor /150", "ebay_kw": "2005 Topps Finest Blue X-Fractor"},
  {"label": "Black Refractor /99", "ebay_kw": "2005 Topps Finest Black Refractor"},
  {"label": "Green X-Fractor /50", "ebay_kw": "2005 Topps Finest Green X-Fractor"},
  {"label": "Gold Refractor /49", "ebay_kw": "2005 Topps Finest Gold Refractor"},
  {"label": "Black X-Fractor /25", "ebay_kw": "2005 Topps Finest Black X-Fractor"},
  {"label": "Gold X-Fractor /10", "ebay_kw": "2005 Topps Finest Gold X-Fractor"},
  {"label": "White Framed Refractor /1", "ebay_kw": "2005 Topps Finest White Frame Refractor"},
  {"label": "White Framed X-Fractor /1", "ebay_kw": "2005 Topps Finest White Frame X-Fractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2005 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2005 Topps Finest Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2005;

-- 2006: Same 14-tier structure as 2005
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2006 Topps Finest Baseball"},
  {"label": "Refractor /399", "ebay_kw": "2006 Topps Finest Refractor"},
  {"label": "Blue Refractor /299", "ebay_kw": "2006 Topps Finest Blue Refractor"},
  {"label": "X-Fractor /250", "ebay_kw": "2006 Topps Finest X-Fractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2006 Topps Finest Green Refractor"},
  {"label": "Blue X-Fractor /150", "ebay_kw": "2006 Topps Finest Blue X-Fractor"},
  {"label": "Black Refractor /99", "ebay_kw": "2006 Topps Finest Black Refractor"},
  {"label": "Green X-Fractor /50", "ebay_kw": "2006 Topps Finest Green X-Fractor"},
  {"label": "Gold Refractor /49", "ebay_kw": "2006 Topps Finest Gold Refractor"},
  {"label": "Black X-Fractor /25", "ebay_kw": "2006 Topps Finest Black X-Fractor"},
  {"label": "Gold X-Fractor /10", "ebay_kw": "2006 Topps Finest Gold X-Fractor"},
  {"label": "White Framed Refractor /1", "ebay_kw": "2006 Topps Finest White Frame Refractor"},
  {"label": "White Framed X-Fractor /1", "ebay_kw": "2006 Topps Finest White Frame X-Fractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2006 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2006 Topps Finest Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2006;

-- 2007: Streamlined — Refractor (unnumb), Blue /399, Green /199, Black /99, Gold /50, X-Fractor /25
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2007 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2007 Topps Finest Refractor"},
  {"label": "Blue Refractor /399", "ebay_kw": "2007 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2007 Topps Finest Green Refractor"},
  {"label": "Black Refractor /99", "ebay_kw": "2007 Topps Finest Black Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2007 Topps Finest Gold Refractor"},
  {"label": "X-Fractor /25", "ebay_kw": "2007 Topps Finest X-Fractor"},
  {"label": "White Framed X-Fractor /1", "ebay_kw": "2007 Topps Finest White Frame X-Fractor"},
  {"label": "Die-Cut SuperFractor /1", "ebay_kw": "2007 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2007 Topps Finest Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2007;

-- 2008: Red /25 replaces X-Fractor as rare tier; base starts at Blue /299
--       (no unnumbered base Refractor on base; autos had Refractor /499)
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2008 Topps Finest Baseball"},
  {"label": "Blue Refractor /299", "ebay_kw": "2008 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2008 Topps Finest Green Refractor"},
  {"label": "Black Refractor /99", "ebay_kw": "2008 Topps Finest Black Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2008 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2008 Topps Finest Red Refractor"},
  {"label": "White Framed X-Fractor /1", "ebay_kw": "2008 Topps Finest White Frame X-Fractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2008 Topps Finest Printing Plates"},
  {"label": "Auto Refractor /499", "ebay_kw": "2008 Topps Finest Auto Refractor"},
  {"label": "Auto Blue /399", "ebay_kw": "2008 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Black /99", "ebay_kw": "2008 Topps Finest Auto Black Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2008 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Red /25", "ebay_kw": "2008 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2008;

-- 2009: Tight structure — Blue /399, Green /99, Gold /50, Red /25; X-Fractor /1 only
--       Auto: Refractor /75 by letter, Blue /50, Gold /10, Red /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2009 Topps Finest Baseball"},
  {"label": "Blue Refractor /399", "ebay_kw": "2009 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2009 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2009 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2009 Topps Finest Red Refractor"},
  {"label": "X-Fractor /1", "ebay_kw": "2009 Topps Finest X-Fractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2009 Topps Finest Printing Plates"},
  {"label": "Auto Refractor /75", "ebay_kw": "2009 Topps Finest Auto Refractor"},
  {"label": "Auto Blue /50", "ebay_kw": "2009 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Gold /10", "ebay_kw": "2009 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2009 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2009;

-- 2010: Refractor /599, Blue /299, Green /99, Gold /50, Red /25, Purple /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2010 Topps Finest Baseball"},
  {"label": "Refractor /599", "ebay_kw": "2010 Topps Finest Refractor"},
  {"label": "Blue Refractor /299", "ebay_kw": "2010 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2010 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2010 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2010 Topps Finest Red Refractor"},
  {"label": "Purple Refractor /1", "ebay_kw": "2010 Topps Finest Purple Refractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2010 Topps Finest Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2010;

-- 2011: Complex era — 11 tiers; Canary Diamond /1 debut; Mosaic Die-Cut /10
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2011 Topps Finest Baseball"},
  {"label": "Refractor /549", "ebay_kw": "2011 Topps Finest Refractor"},
  {"label": "X-Fractor /299", "ebay_kw": "2011 Topps Finest X-Fractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2011 Topps Finest Green Refractor"},
  {"label": "Orange Refractor /99", "ebay_kw": "2011 Topps Finest Orange Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2011 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2011 Topps Finest Red Refractor"},
  {"label": "Die-Cut Mosaic /10", "ebay_kw": "2011 Topps Finest Mosaic Refractor"},
  {"label": "Purple Refractor /5", "ebay_kw": "2011 Topps Finest Purple Refractor"},
  {"label": "Canary Diamond /1", "ebay_kw": "2011 Topps Finest Canary Diamond"},
  {"label": "SuperFractor /1", "ebay_kw": "2011 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2011 Topps Finest Printing Plates"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2011;

-- 2012: Refractor/X-Fractor both unnumbered; Green /199, Orange /99, Gold /50, Red /25, Atomic /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2012 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2012 Topps Finest Refractor"},
  {"label": "X-Fractor", "ebay_kw": "2012 Topps Finest X-Fractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2012 Topps Finest Green Refractor"},
  {"label": "Orange Refractor /99", "ebay_kw": "2012 Topps Finest Orange Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2012 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2012 Topps Finest Red Refractor"},
  {"label": "Atomic Refractor /5", "ebay_kw": "2012 Topps Finest Atomic Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2012 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2012 Topps Finest Printing Plates"},
  {"label": "Auto Refractor /198", "ebay_kw": "2012 Topps Finest Auto Refractor"},
  {"label": "Auto Green /199", "ebay_kw": "2012 Topps Finest Auto Green Refractor"},
  {"label": "Auto Orange /99", "ebay_kw": "2012 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2012 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Red /25", "ebay_kw": "2012 Topps Finest Auto Red Refractor"},
  {"label": "Auto Atomic /5", "ebay_kw": "2012 Topps Finest Auto Atomic Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2012;

-- 2013: No unnumbered base Refractor; starts at Green /199; Auto X-Fractor /149
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2013 Topps Finest Baseball"},
  {"label": "Green Refractor /199", "ebay_kw": "2013 Topps Finest Green Refractor"},
  {"label": "Orange Refractor /99", "ebay_kw": "2013 Topps Finest Orange Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2013 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2013 Topps Finest Red Refractor"},
  {"label": "Atomic Refractor /5", "ebay_kw": "2013 Topps Finest Atomic Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2013 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2013 Topps Finest Printing Plates"},
  {"label": "Auto X-Fractor /149", "ebay_kw": "2013 Topps Finest Auto X-Fractor"},
  {"label": "Auto Green /125", "ebay_kw": "2013 Topps Finest Auto Green Refractor"},
  {"label": "Auto Orange /99", "ebay_kw": "2013 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2013 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Red /25", "ebay_kw": "2013 Topps Finest Auto Red Refractor"},
  {"label": "Auto Atomic /5", "ebay_kw": "2013 Topps Finest Auto Atomic Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2013;

-- 2014: Magenta /15 added; Blue /125 replaces Green; Black /99 replaces Orange
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2014 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2014 Topps Finest Refractor"},
  {"label": "X-Fractor", "ebay_kw": "2014 Topps Finest X-Fractor"},
  {"label": "Green Refractor /199", "ebay_kw": "2014 Topps Finest Green Refractor"},
  {"label": "Blue Refractor /125", "ebay_kw": "2014 Topps Finest Blue Refractor"},
  {"label": "Black Refractor /99", "ebay_kw": "2014 Topps Finest Black Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2014 Topps Finest Gold Refractor"},
  {"label": "Red Refractor /25", "ebay_kw": "2014 Topps Finest Red Refractor"},
  {"label": "Magenta Refractor /15", "ebay_kw": "2014 Topps Finest Magenta Refractor"},
  {"label": "Atomic Refractor /5", "ebay_kw": "2014 Topps Finest Atomic Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2014 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2014 Topps Finest Printing Plates"},
  {"label": "Auto X-Fractor /149", "ebay_kw": "2014 Topps Finest Auto X-Fractor"},
  {"label": "Auto Blue /125", "ebay_kw": "2014 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Black /99", "ebay_kw": "2014 Topps Finest Auto Black Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2014 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Red /25", "ebay_kw": "2014 Topps Finest Auto Red Refractor"},
  {"label": "Auto Atomic /5", "ebay_kw": "2014 Topps Finest Auto Atomic Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2014;

-- 2015: Purple /250 replaces Green /199 as top tier; Prism (unnumb) added
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2015 Topps Finest Baseball"},
  {"label": "Prism Refractor", "ebay_kw": "2015 Topps Finest Prism Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2015 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2015 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2015 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2015 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2015 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2015 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2015 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2015 Topps Finest Printing Plates"},
  {"label": "Auto Blue /150", "ebay_kw": "2015 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2015 Topps Finest Auto Green Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2015 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2015 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2015 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2015;

-- 2016: Clean rainbow — Refractor + Purple /250, Blue /150, Green /99, Gold /50, Orange /25, Red /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2016 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2016 Topps Finest Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2016 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2016 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2016 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2016 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2016 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2016 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2016 Topps Finest SuperFractor"},
  {"label": "Printing Plates /1", "ebay_kw": "2016 Topps Finest Printing Plates"},
  {"label": "Auto Blue /150", "ebay_kw": "2016 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2016 Topps Finest Auto Green Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2016 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2016 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2016 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2016;

-- 2017: Same base structure; auto adds Blue Wave and Red Wave variants
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2017 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2017 Topps Finest Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2017 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2017 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2017 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2017 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2017 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2017 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2017 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2017 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2017 Topps Finest Auto Green Refractor"},
  {"label": "Auto Blue Wave /150", "ebay_kw": "2017 Topps Finest Auto Blue Wave"},
  {"label": "Auto Gold /50", "ebay_kw": "2017 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2017 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2017 Topps Finest Auto Red Refractor"},
  {"label": "Auto Red Wave /5", "ebay_kw": "2017 Topps Finest Auto Red Wave"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2017;

-- 2018: Auto adds Green Wave /99, Orange Wave /25, Red Wave /5
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2018 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2018 Topps Finest Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2018 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2018 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2018 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2018 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2018 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2018 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2018 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2018 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2018 Topps Finest Auto Green Refractor"},
  {"label": "Auto Green Wave /99", "ebay_kw": "2018 Topps Finest Auto Green Wave"},
  {"label": "Auto Gold /50", "ebay_kw": "2018 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2018 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Orange Wave /25", "ebay_kw": "2018 Topps Finest Auto Orange Wave"},
  {"label": "Auto Red /5", "ebay_kw": "2018 Topps Finest Auto Red Refractor"},
  {"label": "Auto Red Wave /5", "ebay_kw": "2018 Topps Finest Auto Red Wave"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2018;

-- 2019: Clean version — same as 2018 base; auto drops Wave variants
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2019 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2019 Topps Finest Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2019 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2019 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2019 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2019 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2019 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2019 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2019 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2019 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2019 Topps Finest Auto Green Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2019 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2019 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2019 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2019;

-- 2020: Same structure as 2019
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2020 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2020 Topps Finest Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2020 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /150", "ebay_kw": "2020 Topps Finest Blue Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2020 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2020 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2020 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2020 Topps Finest Red Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2020 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2020 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2020 Topps Finest Auto Green Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2020 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2020 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Red /5", "ebay_kw": "2020 Topps Finest Auto Red Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2020;

-- 2021: MAJOR EXPANSION — Vapor/Shimmer variants debut; Rose Gold /75, Aqua /199, Purple/Pink Vapor /3
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2021 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2021 Topps Finest Refractor"},
  {"label": "Sky Blue Refractor /300", "ebay_kw": "2021 Topps Finest Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2021 Topps Finest Purple Refractor"},
  {"label": "Purple/Aqua Vapor /250", "ebay_kw": "2021 Topps Finest Purple Aqua Vapor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "2021 Topps Finest Aqua Refractor"},
  {"label": "Aqua Shimmer /175", "ebay_kw": "2021 Topps Finest Aqua Shimmer"},
  {"label": "Blue Refractor /150", "ebay_kw": "2021 Topps Finest Blue Refractor"},
  {"label": "Green Speckle /125", "ebay_kw": "2021 Topps Finest Green Speckle"},
  {"label": "Green Refractor /99", "ebay_kw": "2021 Topps Finest Green Refractor"},
  {"label": "Rose Gold Refractor /75", "ebay_kw": "2021 Topps Finest Rose Gold Refractor"},
  {"label": "Rose Gold Mini-Diamond /50", "ebay_kw": "2021 Topps Finest Rose Gold Mini Diamond"},
  {"label": "Gold Refractor /50", "ebay_kw": "2021 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2021 Topps Finest Orange Refractor"},
  {"label": "Red Refractor /5", "ebay_kw": "2021 Topps Finest Red Refractor"},
  {"label": "Purple/Pink Vapor /3", "ebay_kw": "2021 Topps Finest Purple Pink Vapor"},
  {"label": "SuperFractor /1", "ebay_kw": "2021 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2021 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2021 Topps Finest Auto Green Refractor"},
  {"label": "Auto Green Wave /99", "ebay_kw": "2021 Topps Finest Auto Green Wave"},
  {"label": "Auto Gold /50", "ebay_kw": "2021 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2021 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Orange Wave /25", "ebay_kw": "2021 Topps Finest Auto Orange Wave"},
  {"label": "Auto Red /5", "ebay_kw": "2021 Topps Finest Auto Red Refractor"},
  {"label": "Auto Red Wave /5", "ebay_kw": "2021 Topps Finest Auto Red Wave"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2021;

-- 2022: Green Lava /99 added alongside Green; Red/Black Vapor /10 new ultra-rare tier
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2022 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2022 Topps Finest Refractor"},
  {"label": "Sky Blue Refractor /300", "ebay_kw": "2022 Topps Finest Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2022 Topps Finest Purple Refractor"},
  {"label": "Blue/Aqua Vapor /250", "ebay_kw": "2022 Topps Finest Blue Aqua Vapor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "2022 Topps Finest Aqua Refractor"},
  {"label": "Aqua Shimmer /175", "ebay_kw": "2022 Topps Finest Aqua Shimmer"},
  {"label": "Blue Refractor /150", "ebay_kw": "2022 Topps Finest Blue Refractor"},
  {"label": "Green Speckle /125", "ebay_kw": "2022 Topps Finest Green Speckle"},
  {"label": "Green Refractor /99", "ebay_kw": "2022 Topps Finest Green Refractor"},
  {"label": "Green Lava Refractor /99", "ebay_kw": "2022 Topps Finest Green Lava Refractor"},
  {"label": "Rose Gold Refractor /75", "ebay_kw": "2022 Topps Finest Rose Gold Refractor"},
  {"label": "Rose Gold Mini-Diamond /50", "ebay_kw": "2022 Topps Finest Rose Gold Mini Diamond"},
  {"label": "Gold Refractor /50", "ebay_kw": "2022 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /25", "ebay_kw": "2022 Topps Finest Orange Refractor"},
  {"label": "Red/Black Vapor /10", "ebay_kw": "2022 Topps Finest Red Black Vapor"},
  {"label": "Red Refractor /5", "ebay_kw": "2022 Topps Finest Red Refractor"},
  {"label": "Purple/Pink Vapor /3", "ebay_kw": "2022 Topps Finest Purple Pink Vapor"},
  {"label": "SuperFractor /1", "ebay_kw": "2022 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2022 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2022 Topps Finest Auto Green Refractor"},
  {"label": "Auto Green Wave /99", "ebay_kw": "2022 Topps Finest Auto Green Wave"},
  {"label": "Auto Gold /50", "ebay_kw": "2022 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2022 Topps Finest Auto Orange Refractor"},
  {"label": "Auto Orange Wave /25", "ebay_kw": "2022 Topps Finest Auto Orange Wave"},
  {"label": "Auto Red /5", "ebay_kw": "2022 Topps Finest Auto Red Refractor"},
  {"label": "Auto Red Wave /5", "ebay_kw": "2022 Topps Finest Auto Red Wave"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2022;

-- 2023: Same Vapor/Shimmer structure; Lava /100 added as new distinct tier
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2023 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2023 Topps Finest Refractor"},
  {"label": "Sky Blue Refractor /300", "ebay_kw": "2023 Topps Finest Sky Blue Refractor"},
  {"label": "Purple Refractor /250", "ebay_kw": "2023 Topps Finest Purple Refractor"},
  {"label": "Blue/Aqua Vapor /250", "ebay_kw": "2023 Topps Finest Blue Aqua Vapor"},
  {"label": "Aqua Refractor /199", "ebay_kw": "2023 Topps Finest Aqua Refractor"},
  {"label": "Aqua Shimmer /175", "ebay_kw": "2023 Topps Finest Aqua Shimmer"},
  {"label": "Blue Refractor /150", "ebay_kw": "2023 Topps Finest Blue Refractor"},
  {"label": "Green Speckle /125", "ebay_kw": "2023 Topps Finest Green Speckle"},
  {"label": "Lava Refractor /100", "ebay_kw": "2023 Topps Finest Lava Refractor"},
  {"label": "Green Refractor /99", "ebay_kw": "2023 Topps Finest Green Refractor"},
  {"label": "Green Lava Refractor /99", "ebay_kw": "2023 Topps Finest Green Lava Refractor"},
  {"label": "Rose Gold Refractor /75", "ebay_kw": "2023 Topps Finest Rose Gold Refractor"},
  {"label": "Gold Refractor /50", "ebay_kw": "2023 Topps Finest Gold Refractor"},
  {"label": "Gold Mini-Diamond /50", "ebay_kw": "2023 Topps Finest Gold Mini Diamond"},
  {"label": "Orange Refractor /25", "ebay_kw": "2023 Topps Finest Orange Refractor"},
  {"label": "Red/Black Vapor /10", "ebay_kw": "2023 Topps Finest Red Black Vapor"},
  {"label": "Red Refractor /5", "ebay_kw": "2023 Topps Finest Red Refractor"},
  {"label": "Purple/Pink Vapor /3", "ebay_kw": "2023 Topps Finest Purple Pink Vapor"},
  {"label": "SuperFractor /1", "ebay_kw": "2023 Topps Finest SuperFractor"},
  {"label": "Auto Blue /150", "ebay_kw": "2023 Topps Finest Auto Blue Refractor"},
  {"label": "Auto Green /99", "ebay_kw": "2023 Topps Finest Auto Green Refractor"},
  {"label": "Auto Gold /50", "ebay_kw": "2023 Topps Finest Auto Gold Refractor"},
  {"label": "Auto Orange /25", "ebay_kw": "2023 Topps Finest Auto Orange Refractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2023;

-- 2024: New 3-TIERED base structure — Checkerboard Refractor, Oil Spill (unnumb);
--       Numbered: Sky Blue /150, Purple /125, Blue /99, Purple Checkerboard /75,
--       Blue Checkerboard /49, Green /25, Gold /20, Orange /15, Black /10, Red Lava /3, SF /1
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2024 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2024 Topps Finest Refractor"},
  {"label": "Checkerboard Refractor", "ebay_kw": "2024 Topps Finest Checkerboard Refractor"},
  {"label": "Oil Spill Refractor", "ebay_kw": "2024 Topps Finest Oil Spill Refractor"},
  {"label": "Sky Blue Refractor /150", "ebay_kw": "2024 Topps Finest Sky Blue Refractor"},
  {"label": "Purple Refractor /125", "ebay_kw": "2024 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /99", "ebay_kw": "2024 Topps Finest Blue Refractor"},
  {"label": "Purple Checkerboard /75", "ebay_kw": "2024 Topps Finest Purple Checkerboard"},
  {"label": "Blue Checkerboard /49", "ebay_kw": "2024 Topps Finest Blue Checkerboard"},
  {"label": "Green Refractor /25", "ebay_kw": "2024 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /20", "ebay_kw": "2024 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /15", "ebay_kw": "2024 Topps Finest Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "2024 Topps Finest Black Refractor"},
  {"label": "Red Lava Refractor /3", "ebay_kw": "2024 Topps Finest Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2024 Topps Finest SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2024;

-- 2025: Magenta /200 returns (first time since 2014); expanded tiers vs 2024
--       Base Rare tier: Magenta /200, Sky Blue /150, Purple /125, Blue /99,
--       Purple Checkerboard /75, Blue Checkerboard /49, Green /25, Gold /20, Orange /15,
--       Black /10, Red Lava /3, SF /1; tiered numbering varies by Common/Uncommon/Rare
UPDATE card_sets SET parallels = '[
  {"label": "Base", "ebay_kw": "2025 Topps Finest Baseball"},
  {"label": "Refractor", "ebay_kw": "2025 Topps Finest Refractor"},
  {"label": "Checkerboard Refractor", "ebay_kw": "2025 Topps Finest Checkerboard Refractor"},
  {"label": "Oil Spill Refractor", "ebay_kw": "2025 Topps Finest Oil Spill Refractor"},
  {"label": "Magenta Refractor /200", "ebay_kw": "2025 Topps Finest Magenta Refractor"},
  {"label": "Sky Blue Refractor /150", "ebay_kw": "2025 Topps Finest Sky Blue Refractor"},
  {"label": "Purple Refractor /125", "ebay_kw": "2025 Topps Finest Purple Refractor"},
  {"label": "Blue Refractor /99", "ebay_kw": "2025 Topps Finest Blue Refractor"},
  {"label": "Purple Checkerboard /75", "ebay_kw": "2025 Topps Finest Purple Checkerboard"},
  {"label": "Blue Checkerboard /49", "ebay_kw": "2025 Topps Finest Blue Checkerboard"},
  {"label": "Pear Checkerboard /30", "ebay_kw": "2025 Topps Finest Pear Checkerboard"},
  {"label": "Green Refractor /25", "ebay_kw": "2025 Topps Finest Green Refractor"},
  {"label": "Gold Refractor /20", "ebay_kw": "2025 Topps Finest Gold Refractor"},
  {"label": "Orange Refractor /15", "ebay_kw": "2025 Topps Finest Orange Refractor"},
  {"label": "Black Refractor /10", "ebay_kw": "2025 Topps Finest Black Refractor"},
  {"label": "Red Lava Refractor /3", "ebay_kw": "2025 Topps Finest Red Lava Refractor"},
  {"label": "SuperFractor /1", "ebay_kw": "2025 Topps Finest SuperFractor"}
]'::jsonb
WHERE brand = 'Topps' AND set_name = 'Finest' AND sport = 'baseball' AND year = 2025;
