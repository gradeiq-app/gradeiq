/**
 * seed-inserts.mjs
 * Inserts missing insert sets + WNBA sets into card_sets.
 * Run:  node --env-file=.env.local scripts/seed-inserts.mjs
 */

if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
  console.error("Missing required env: SUPABASE_SERVICE_ROLE_KEY");
  console.error("Set in .env.local (loaded via `node --env-file=.env.local`) or shell environment.");
  process.exit(1);
}

const SUPABASE_URL  = 'https://dcsrpdmhmcboydjsbgsg.supabase.co'
const SERVICE_KEY   = process.env.SUPABASE_SERVICE_ROLE_KEY

// ─── Parallel templates ───────────────────────────────────────────────────────

const PRIZM_WNBA = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Silver Prizm',     ebay_kw: 'Silver Prizm' },
  { label: 'Red /149',         ebay_kw: 'Red Prizm' },
  { label: 'Blue /99',         ebay_kw: 'Blue Prizm' },
  { label: 'Purple /49',       ebay_kw: 'Purple Prizm' },
  { label: 'Orange /25',       ebay_kw: 'Orange Prizm' },
  { label: 'Gold /10',         ebay_kw: 'Gold Prizm' },
  { label: 'Black /1',         ebay_kw: 'Black Prizm' },
]

const PRIZM_WNBA_WITH_AUTO = [
  ...PRIZM_WNBA,
  { label: 'Rookie Auto',      ebay_kw: 'Rookie Auto' },
  { label: 'Auto Silver',      ebay_kw: 'Auto Silver Prizm' },
  { label: 'Auto Gold /10',    ebay_kw: 'Auto Gold Prizm' },
]

const DONRUSS_WNBA = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Rated Rookie',     ebay_kw: 'Rated Rookie' },
  { label: 'Bronze /199',      ebay_kw: 'Bronze' },
  { label: 'Blue /99',         ebay_kw: 'Blue' },
  { label: 'Red /49',          ebay_kw: 'Red' },
  { label: 'Gold /25',         ebay_kw: 'Gold' },
  { label: 'Black /1',         ebay_kw: 'Black' },
  { label: 'Rated Rookie Auto',ebay_kw: 'Rated Rookie Auto' },
]

const IMMACULATE_WNBA = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Auto /49',         ebay_kw: 'Auto' },
  { label: 'Patch Auto /25',   ebay_kw: 'Patch Auto' },
  { label: 'Logoman Auto /1',  ebay_kw: 'Logoman Auto' },
]

const FLAWLESS_WNBA = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Ruby /15',         ebay_kw: 'Ruby' },
  { label: 'Sapphire /10',     ebay_kw: 'Sapphire' },
  { label: 'Emerald /5',       ebay_kw: 'Emerald' },
  { label: 'Diamond /1',       ebay_kw: 'Diamond' },
]

const NT_WNBA = [
  { label: 'RPA /99',          ebay_kw: 'RPA' },
  { label: 'Gold RPA /25',     ebay_kw: 'Gold RPA' },
  { label: 'Platinum RPA /1',  ebay_kw: 'Platinum RPA' },
]

const YOUNG_GUNS = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Canvas',           ebay_kw: 'Canvas' },
  { label: 'Exclusives /100',  ebay_kw: 'Exclusives' },
  { label: 'High Gloss /10',   ebay_kw: 'High Gloss' },
  { label: 'Clear Cut',        ebay_kw: 'Clear Cut' },
]

const CONTENDERS_RTA_BBB = [  // Basketball Rookie Ticket Auto
  { label: 'Base',                  ebay_kw: '' },
  { label: 'Cracked Ice /25',       ebay_kw: 'Cracked Ice' },
  { label: 'Championship Ticket /10', ebay_kw: 'Championship Ticket' },
  { label: 'Printing Plate /1',     ebay_kw: 'Printing Plate' },
]

const PRIZM_FAST_BREAK = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Silver',           ebay_kw: 'Silver Prizm' },
  { label: 'Blue /149',        ebay_kw: 'Blue Prizm' },
  { label: 'Purple /99',       ebay_kw: 'Purple Prizm' },
  { label: 'Orange /49',       ebay_kw: 'Orange Prizm' },
  { label: 'Gold /10',         ebay_kw: 'Gold Prizm' },
  { label: 'Black /1',         ebay_kw: 'Black Prizm' },
]

const BOWMAN_CHROME_PROSPECT_AUTO = [
  { label: 'Base Auto',            ebay_kw: 'Auto' },
  { label: 'Blue Refractor /150',  ebay_kw: 'Blue Refractor Auto' },
  { label: 'Purple Refractor /250',ebay_kw: 'Purple Refractor Auto' },
  { label: 'Orange Refractor /25', ebay_kw: 'Orange Refractor Auto' },
  { label: 'Gold Refractor /50',   ebay_kw: 'Gold Refractor Auto' },
  { label: 'Red Refractor /5',     ebay_kw: 'Red Refractor Auto' },
  { label: 'Superfractor /1',      ebay_kw: 'Superfractor Auto' },
]

const TOPPS_CHROME_SAPPHIRE = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Blue /150',        ebay_kw: 'Blue Refractor' },
  { label: 'Gold /50',         ebay_kw: 'Gold Refractor' },
  { label: 'Orange /25',       ebay_kw: 'Orange Refractor' },
  { label: 'Red /5',           ebay_kw: 'Red Refractor' },
  { label: 'Superfractor /1',  ebay_kw: 'Superfractor' },
]

const NT_FOOTBALL_RPA = [
  { label: 'RPA /99',          ebay_kw: 'RPA' },
  { label: 'Gold RPA /25',     ebay_kw: 'Gold RPA' },
  { label: 'Platinum RPA /1',  ebay_kw: 'Platinum RPA' },
]

const CONTENDERS_OPTIC_FOOTBALL = [
  { label: 'Base',             ebay_kw: '' },
  { label: 'Rookie Ticket Auto', ebay_kw: 'Rookie Ticket Auto' },
  { label: 'Blue /149',        ebay_kw: 'Blue' },
  { label: 'Orange /99',       ebay_kw: 'Orange' },
  { label: 'Red /50',          ebay_kw: 'Red' },
  { label: 'Gold /10',         ebay_kw: 'Gold' },
  { label: 'Black /1',         ebay_kw: 'Black' },
]

const SELECT_FOOTBALL = [
  { label: 'Concourse',         ebay_kw: 'Concourse' },
  { label: 'Premier Level',     ebay_kw: 'Premier Level' },
  { label: 'Courtside',         ebay_kw: 'Courtside' },
  { label: 'Silver',            ebay_kw: 'Silver' },
  { label: 'Blue /149',         ebay_kw: 'Blue' },
  { label: 'Purple /49',        ebay_kw: 'Purple' },
  { label: 'Gold /10',          ebay_kw: 'Gold' },
  { label: 'Black /1',          ebay_kw: 'Black' },
]

// ─── Range helper ─────────────────────────────────────────────────────────────
function range(start, end) {
  return Array.from({ length: end - start + 1 }, (_, i) => start + i)
}

// ─── Build all records ────────────────────────────────────────────────────────
const records = []

// ── WNBA ─────────────────────────────────────────────────────────────────────
for (const year of range(2019, 2024)) {
  records.push({ sport: 'wnba', year, brand: 'Panini', set_name: 'Prizm WNBA',
    parallels: year >= 2021 ? PRIZM_WNBA_WITH_AUTO : PRIZM_WNBA })
}
for (const year of range(2020, 2024)) {
  records.push({ sport: 'wnba', year, brand: 'Panini', set_name: 'Donruss WNBA', parallels: DONRUSS_WNBA })
}
for (const year of range(2021, 2024)) {
  records.push({ sport: 'wnba', year, brand: 'Panini', set_name: 'Immaculate WNBA', parallels: IMMACULATE_WNBA })
}
for (const year of range(2022, 2024)) {
  records.push({ sport: 'wnba', year, brand: 'Panini', set_name: 'Flawless WNBA', parallels: FLAWLESS_WNBA })
}
for (const year of range(2023, 2024)) {
  records.push({ sport: 'wnba', year, brand: 'Panini', set_name: 'National Treasures WNBA', parallels: NT_WNBA })
}

// ── Hockey Young Guns ─────────────────────────────────────────────────────────
for (const year of range(2018, 2025)) {
  records.push({ sport: 'hockey', year, brand: 'Upper Deck', set_name: 'Young Guns', parallels: YOUNG_GUNS })
}

// ── Basketball inserts ────────────────────────────────────────────────────────
for (const year of range(2018, 2024)) {
  records.push({ sport: 'basketball', year, brand: 'Panini', set_name: 'Contenders Rookie Ticket Auto', parallels: CONTENDERS_RTA_BBB })
}
for (const year of range(2020, 2024)) {
  records.push({ sport: 'basketball', year, brand: 'Panini', set_name: 'Prizm Fast Break', parallels: PRIZM_FAST_BREAK })
}

// ── Baseball inserts ──────────────────────────────────────────────────────────
for (const year of range(2018, 2024)) {
  records.push({ sport: 'baseball', year, brand: 'Bowman', set_name: 'Chrome Prospect Auto', parallels: BOWMAN_CHROME_PROSPECT_AUTO })
}
for (const year of range(2018, 2024)) {
  records.push({ sport: 'baseball', year, brand: 'Topps', set_name: 'Chrome Sapphire Edition', parallels: TOPPS_CHROME_SAPPHIRE })
}

// ── Football inserts ──────────────────────────────────────────────────────────
for (const year of range(2018, 2024)) {
  records.push({ sport: 'football', year, brand: 'Panini', set_name: 'National Treasures Rookie Patch Auto', parallels: NT_FOOTBALL_RPA })
}
for (const year of range(2018, 2024)) {
  records.push({ sport: 'football', year, brand: 'Panini', set_name: 'Contenders Optic', parallels: CONTENDERS_OPTIC_FOOTBALL })
}
for (const year of range(2019, 2024)) {
  records.push({ sport: 'football', year, brand: 'Panini', set_name: 'Select', parallels: SELECT_FOOTBALL })
}

console.log(`Preparing to insert ${records.length} records…`)

// ─── Insert in batches ────────────────────────────────────────────────────────
const BATCH = 50
let inserted = 0
let skipped  = 0

for (let i = 0; i < records.length; i += BATCH) {
  const batch = records.slice(i, i + BATCH)

  const res = await fetch(`${SUPABASE_URL}/rest/v1/card_sets`, {
    method: 'POST',
    headers: {
      'apikey':        SERVICE_KEY,
      'Authorization': `Bearer ${SERVICE_KEY}`,
      'Content-Type':  'application/json',
      'Prefer':        'resolution=ignore-duplicates,return=representation',
    },
    body: JSON.stringify(batch),
  })

  const text = await res.text()

  if (!res.ok) {
    console.error(`Batch ${i / BATCH + 1} FAILED (${res.status}):`, text.slice(0, 400))
    process.exit(1)
  }

  let rows = []
  try { rows = JSON.parse(text) } catch {}
  inserted += rows.length
  skipped  += batch.length - rows.length

  console.log(`Batch ${i / BATCH + 1}: +${rows.length} inserted, ${batch.length - rows.length} skipped (already exist)`)
}

console.log(`\nDone. ${inserted} new records inserted, ${skipped} already existed.`)
