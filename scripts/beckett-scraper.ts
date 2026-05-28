/**
 * beckett-scraper.ts
 *
 * Pulls authoritative card checklists from beckett.com news pages
 * (HTML + S3-hosted xlsx) and populates `cards` / `players` in Supabase.
 *
 *   npx ts-node scripts/beckett-scraper.ts                   # all configured targets
 *   npx ts-node scripts/beckett-scraper.ts --only=prizm-2023 # one target by key
 *
 * Re-runnable: progress persisted to scripts/beckett-progress.json.
 *
 * Hard rules from the spec:
 *   - 2-second floor between every outbound request
 *   - never fabricate card numbers — only what Beckett provides
 *   - no schema changes, no migrations, no images
 */

import { createClient } from '@supabase/supabase-js'
import * as cheerio from 'cheerio'
import * as XLSX from 'xlsx'
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'fs'
import { join } from 'path'
import { sanitizePlayerName, detectParallelFamily } from './lib/beckett_sanitizers'

// ─── Env ──────────────────────────────────────────────────────────────────────
function loadEnv() {
  const envPath = join(process.cwd(), '.env.local')
  if (!existsSync(envPath)) return
  for (const line of readFileSync(envPath, 'utf8').split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/)
    if (!m) continue
    const [, k, vRaw] = m
    if (process.env[k]) continue
    process.env[k] = vRaw.replace(/^["']|["']$/g, '')
  }
}
loadEnv()

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!
if (!SUPABASE_URL || !SERVICE_KEY) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SERVICE_KEY, {
  auth: { persistSession: false, autoRefreshToken: false },
})

// ─── Constants ────────────────────────────────────────────────────────────────
const CACHE_DIR = join(process.cwd(), 'scripts', '_beckett-cache')
const PROGRESS_FILE = join(process.cwd(), 'scripts', 'beckett-progress.json')
const REQUEST_DELAY_MS = 2000
const USER_AGENT =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

mkdirSync(CACHE_DIR, { recursive: true })

// ─── Target definitions ───────────────────────────────────────────────────────
// Each target is one Beckett news page that maps to one of OUR sets.
// `dbMatch` is the parameters we use to find our matching set in Supabase.
type Target = {
  key: string
  url: string
  dbMatch: {
    year: number
    sport_slug: string
    manufacturer_slug: string
    /** case-insensitive contains check against sets.name */
    name_contains: string
    /** if multiple sets match name_contains, require exact name */
    name_exact?: string
  }
}

const TARGETS: Target[] = [
  // ── Panini Prizm Basketball ──────────────────────────────────────────────
  { key: 'prizm-basketball-2023-24', url: 'https://www.beckett.com/news/2023-24-panini-prizm-basketball-cards/',
    dbMatch: { year: 2023, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-basketball-2022-23', url: 'https://www.beckett.com/news/2022-23-panini-prizm-basketball-cards/',
    dbMatch: { year: 2022, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-basketball-2021-22', url: 'https://www.beckett.com/news/2021-22-panini-prizm-basketball-cards/',
    dbMatch: { year: 2021, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-basketball-2020-21', url: 'https://www.beckett.com/news/2020-21-panini-prizm-basketball-cards/',
    dbMatch: { year: 2020, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-basketball-2019-20', url: 'https://www.beckett.com/news/2019-20-panini-prizm-basketball-cards/',
    dbMatch: { year: 2019, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-basketball-2018-19', url: 'https://www.beckett.com/news/2018-19-panini-prizm-basketball-cards/',
    dbMatch: { year: 2018, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },

  // ── Panini Prizm Football ────────────────────────────────────────────────
  { key: 'prizm-football-2024', url: 'https://www.beckett.com/news/2024-panini-prizm-football-cards/',
    dbMatch: { year: 2024, sport_slug: 'football', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-football-2023', url: 'https://www.beckett.com/news/2023-panini-prizm-football-cards/',
    dbMatch: { year: 2023, sport_slug: 'football', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-football-2022', url: 'https://www.beckett.com/news/2022-panini-prizm-football-cards/',
    dbMatch: { year: 2022, sport_slug: 'football', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-football-2021', url: 'https://www.beckett.com/news/2021-panini-prizm-football-cards/',
    dbMatch: { year: 2021, sport_slug: 'football', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },
  { key: 'prizm-football-2020', url: 'https://www.beckett.com/news/2020-panini-prizm-football-cards/',
    dbMatch: { year: 2020, sport_slug: 'football', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm' } },

  // ── Topps Chrome Baseball ────────────────────────────────────────────────
  { key: 'topps-chrome-baseball-2024', url: 'https://www.beckett.com/news/2024-topps-chrome-baseball-cards/',
    dbMatch: { year: 2024, sport_slug: 'baseball', manufacturer_slug: 'topps', name_contains: 'chrome', name_exact: 'Chrome' } },
  { key: 'topps-chrome-baseball-2023', url: 'https://www.beckett.com/news/2023-topps-chrome-baseball-cards/',
    dbMatch: { year: 2023, sport_slug: 'baseball', manufacturer_slug: 'topps', name_contains: 'chrome', name_exact: 'Chrome' } },
  { key: 'topps-chrome-baseball-2022', url: 'https://www.beckett.com/news/2022-topps-chrome-baseball-cards/',
    dbMatch: { year: 2022, sport_slug: 'baseball', manufacturer_slug: 'topps', name_contains: 'chrome', name_exact: 'Chrome' } },

  // ── Panini Prizm WNBA ────────────────────────────────────────────────────
  { key: 'prizm-wnba-2024', url: 'https://www.beckett.com/news/2024-panini-prizm-wnba-basketball-cards/',
    dbMatch: { year: 2024, sport_slug: 'wnba', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm WNBA' } },
  { key: 'prizm-wnba-2023', url: 'https://www.beckett.com/news/2023-panini-prizm-wnba-basketball-cards/',
    dbMatch: { year: 2023, sport_slug: 'wnba', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm WNBA' } },
  { key: 'prizm-wnba-2022', url: 'https://www.beckett.com/news/2022-panini-prizm-wnba-basketball-cards/',
    dbMatch: { year: 2022, sport_slug: 'wnba', manufacturer_slug: 'panini', name_contains: 'prizm', name_exact: 'Prizm WNBA' } },

  // ── Bowman Chrome Baseball ───────────────────────────────────────────────
  { key: 'bowman-chrome-baseball-2024', url: 'https://www.beckett.com/news/2024-bowman-chrome-baseball-cards/',
    dbMatch: { year: 2024, sport_slug: 'baseball', manufacturer_slug: 'bowman', name_contains: 'chrome', name_exact: 'Chrome' } },
  { key: 'bowman-chrome-baseball-2023', url: 'https://www.beckett.com/news/2023-bowman-chrome-baseball-cards/',
    dbMatch: { year: 2023, sport_slug: 'baseball', manufacturer_slug: 'bowman', name_contains: 'chrome', name_exact: 'Chrome' } },

  // ── Panini Select / Mosaic Basketball ────────────────────────────────────
  { key: 'select-basketball-2023-24', url: 'https://www.beckett.com/news/2023-24-panini-select-basketball-cards/',
    dbMatch: { year: 2023, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'select', name_exact: 'Select' } },
  { key: 'mosaic-basketball-2023-24', url: 'https://www.beckett.com/news/2023-24-panini-mosaic-basketball-cards/',
    dbMatch: { year: 2023, sport_slug: 'basketball', manufacturer_slug: 'panini', name_contains: 'mosaic', name_exact: 'Mosaic' } },

  // ── Upper Deck Hockey Series 1 (Beckett doesn't have a separate /upper-deck-hockey/ article — Series 1 is the flagship) ──
  { key: 'upper-deck-series-1-hockey-2023-24', url: 'https://www.beckett.com/news/2023-24-upper-deck-series-1-hockey-cards/',
    dbMatch: { year: 2023, sport_slug: 'hockey', manufacturer_slug: 'upper-deck', name_contains: 'series', name_exact: 'Series 1' } },
]

// Targets can also be loaded from scripts/beckett-targets.json (produced by
// scripts/beckett-build-targets.ts) and overridden via
// scripts/beckett-target-overrides.json. Resolution priority (highest first):
//   1. overrides file — single source of truth for hand-tuned dbMatch fixes
//   2. hardcoded TARGETS array
//   3. auto-generated beckett-targets.json
// Overrides may also use { "key": "...", "skip": true } to permanently remove
// a target from the queue (e.g. sets that genuinely don't exist in the DB).
function loadJsonTargets(file: string): Array<Target | { key: string; skip: true }> {
  const p = join(process.cwd(), 'scripts', file)
  if (!existsSync(p)) return []
  try {
    const arr = JSON.parse(readFileSync(p, 'utf8'))
    if (!Array.isArray(arr)) return []
    return arr
  } catch {
    return []
  }
}

function mergedTargets(): Target[] {
  const skips = new Set<string>()
  const byKey = new Map<string, Target>()
  // (3) auto-generated baseline
  for (const t of loadJsonTargets('beckett-targets.json')) {
    if ('skip' in t) continue
    byKey.set(t.key, t as Target)
  }
  // (2) hardcoded TARGETS wins over auto-generated
  for (const t of TARGETS) byKey.set(t.key, t)
  // (1) overrides win over everything; can also mark skips
  for (const o of loadJsonTargets('beckett-target-overrides.json')) {
    if ('skip' in o && o.skip) {
      skips.add(o.key)
      continue
    }
    byKey.set((o as Target).key, o as Target)
  }
  return [...byKey.values()].filter((t) => !skips.has(t.key))
}

// ─── Types ────────────────────────────────────────────────────────────────────
type ProgressFile = {
  completed: string[]
  failed: string[]
  stats: {
    cards_inserted: number
    players_created: number
  }
  // For each target key: how many cards were inserted in the most recent successful run.
  last_run: Record<string, { at: string; cards_inserted: number; players_created: number }>
}

type CardType = 'base' | 'insert' | 'autograph' | 'auto_relic' | 'relic' | 'parallel_pending_review'

type ScrapedCard = {
  card_number: string
  player_name: string
  team: string | null
  card_type: CardType
  subset_name: string | null
  is_active: boolean
}

type DbSet = {
  id: string
  sport_id: string
  year: number
  name: string
}

// ─── Progress ─────────────────────────────────────────────────────────────────
function loadProgress(): ProgressFile {
  if (existsSync(PROGRESS_FILE)) {
    try {
      return JSON.parse(readFileSync(PROGRESS_FILE, 'utf8'))
    } catch {}
  }
  return {
    completed: [],
    failed: [],
    stats: { cards_inserted: 0, players_created: 0 },
    last_run: {},
  }
}

function saveProgress(p: ProgressFile) {
  writeFileSync(PROGRESS_FILE, JSON.stringify(p, null, 2), 'utf8')
}

// ─── Rate-limited fetch ───────────────────────────────────────────────────────
let lastRequestAt = 0
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms))

async function rateLimited<T>(fn: () => Promise<T>): Promise<T> {
  const wait = Math.max(0, REQUEST_DELAY_MS - (Date.now() - lastRequestAt))
  if (wait > 0) await sleep(wait)
  lastRequestAt = Date.now()
  return fn()
}

async function httpGet(url: string): Promise<Response> {
  return rateLimited(() =>
    fetch(url, {
      headers: {
        'user-agent': USER_AGENT,
        accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'accept-language': 'en-US,en;q=0.9',
      },
      redirect: 'follow',
    })
  )
}

// ─── 1. DB set lookup ─────────────────────────────────────────────────────────
async function findDbSet(t: Target): Promise<DbSet | null> {
  const { data, error } = await supabase
    .from('sets')
    .select('id, sport_id, year, name, sports:sport_id(slug), manufacturers:manufacturer_id(slug)')
    .eq('year', t.dbMatch.year)

  if (error) {
    console.error(`  ⚠ DB query failed: ${error.message}`)
    return null
  }
  const candidates = (data ?? []).filter((r: any) => {
    if (r.sports?.slug !== t.dbMatch.sport_slug) return false
    if (r.manufacturers?.slug !== t.dbMatch.manufacturer_slug) return false
    if (!r.name.toLowerCase().includes(t.dbMatch.name_contains.toLowerCase())) return false
    if (t.dbMatch.name_exact && r.name !== t.dbMatch.name_exact) return false
    return true
  })
  if (candidates.length === 0) {
    console.error(`  ⚠ no DB set match for ${t.key}`)
    return null
  }
  if (candidates.length > 1) {
    console.error(`  ⚠ ${candidates.length} DB sets match ${t.key} — refusing to guess:`)
    for (const c of candidates) console.error(`     - "${c.name}"`)
    console.error(`     Add a name_exact to TARGETS[${t.key}].dbMatch to disambiguate.`)
    return null
  }
  const c = candidates[0]
  return { id: c.id, sport_id: c.sport_id, year: c.year, name: c.name }
}

// ─── 2. Fetch HTML, find xlsx link, download xlsx ─────────────────────────────
async function fetchHtml(url: string): Promise<string> {
  const res = await httpGet(url)
  if (!res.ok) throw new Error(`HTML fetch ${res.status}`)
  return res.text()
}

function findXlsxUrl(html: string, pageUrl: string): string | null {
  const $ = cheerio.load(html)
  const candidates: string[] = []
  $('a[href$=".xlsx"], a[href*=".xlsx"]').each((_, el) => {
    const href = $(el).attr('href') || ''
    if (href.toLowerCase().includes('.xlsx')) candidates.push(href)
  })
  if (!candidates.length) return null
  // Prefer ones that look like a "checklist" file.
  candidates.sort((a, b) => {
    const score = (s: string) => (/checklist/i.test(s) ? 0 : 1)
    return score(a) - score(b)
  })
  try {
    return new URL(candidates[0], pageUrl).toString()
  } catch {
    return candidates[0]
  }
}

async function downloadXlsx(url: string, cacheName: string): Promise<Buffer> {
  const local = join(CACHE_DIR, cacheName)
  if (existsSync(local)) {
    return readFileSync(local)
  }
  const res = await httpGet(url)
  if (!res.ok) throw new Error(`xlsx download ${res.status}`)
  const buf = Buffer.from(await res.arrayBuffer())
  writeFileSync(local, buf)
  return buf
}

// ─── 3. Parse Master sheet → classified cards ─────────────────────────────────
// Beckett xlsx files use a variety of subset-naming conventions:
//   - Prizm: "Base"
//   - Mosaic: "Base"
//   - Select (BB): "Base Set - Concourse", "Base Set - Premier Level", …
//   - Select (FB): "Base Concourse", "Base Premier Level", …
//   - Chronicles: "Base Chronicles" (one product within the compilation is the base)
//   - Bowman Draft: "Bowman Base", "Bowman Chrome Base"
//   - Topps Chrome BB: "Base"
//
// And we always need to REJECT parallel variants which share the "Base" word but
// add a finish/color suffix: "Base Set - Concourse - Black Disco Prizms",
// "Base Chronicles Blue", "Base Club Level Gold Prizm", etc.
const PARALLEL_KEYWORDS = /\b(refractor|refractors|prizm|prizms|mojo|wave|disco|cosmic|pulsar|sparkle|sapphire|ruby|emerald|holo|foil|glow|negative|reactive|die[- ]cut|cracked|hyper|tie[- ]dye|zebra|tiger|elephant|snake ?skin|honeycomb|spectris|black|blue|gold|green|red|silver|orange|purple|pink|white|yellow|bronze|platinum|magenta|teal|fotl|fast break|choice|fluorescent|sepia|holiday|anniversary|all[- ]?stars?|aqua)\b/i

function isBaseSubset(s: string): boolean {
  const norm = s.trim()
  if (!norm) return false
  if (PARALLEL_KEYWORDS.test(norm)) return false
  if (!/\bbase\b/i.test(norm)) return false
  // Multi-dash names are parallel variants ("Base Set - Tier - Variant").
  if ((norm.match(/-/g) ?? []).length >= 2) return false
  return true
}

// Kept for any callers that still test exact-only "Base" / "Base Set" / "Base Set - X".
const BASE_SUBSET_RE = /^base(?:\s+set(?:\s*-\s*[^-]+?)?)?\s*$/i

/**
 * Classify a Beckett "subset" string into our card_type taxonomy.
 *  - "Base" / "Base Set" / "Base Set - White"  → base (subset_name dropped)
 *  - "Prizm Emergent", "Fireworks", "Color Blast" → insert
 *  - "Signatures", "Rookie Autographs"          → autograph
 *  - "Rookie Patch Autographs", "Auto Memorabilia" → auto_relic
 *  - "Game-Used Memorabilia", "Jersey Patches"  → relic
 *
 * Subset names with " - " parallel-suffix get trimmed so all parallel
 * variants of the same insert collapse to a single subset_name (e.g.
 * "Prizm Emergent - Silver /99" → "Prizm Emergent").
 */
function classifySubset(rawSubset: string): { card_type: CardType; subset_name: string | null; is_active: boolean } | null {
  const subset = rawSubset.trim()
  if (!subset) return null
  // Broad base check first — handles "Base", "Base Set - X", "Bowman Base",
  // "Base Chronicles", "Base Concourse", etc.; rejects parallel variants.
  if (isBaseSubset(subset)) {
    return { card_type: 'base', subset_name: null, is_active: true }
  }
  const lo = subset.toLowerCase()
  const hasAuto  = /\bauto(graph)?s?\b|\bsign(ature|ed)?s?\b/.test(lo)
  const hasRelic = /\bpatch(es)?\b|\brelic(s)?\b|\bmemorabilia\b|\bjersey\b|\bgame[\- ]?used\b/.test(lo)
  // Normalize: drop trailing parallel suffix (" - Silver /99" etc.)
  const sepIdx = subset.indexOf(' - ')
  const normalized = sepIdx > 0 ? subset.slice(0, sepIdx).trim() : subset
  // Parallel-family rows (Prizms, Refractors, Mosaic, …): persist as
  // card_type='parallel_pending_review', is_active=false. Preserve the
  // FULL raw subset string so tomorrow's Phase C can relocate the row
  // into the parallels table. See
  // [[project-beckett-card-type-contamination]].
  const pf = detectParallelFamily(subset)
  if (pf.matched) {
    return { card_type: 'parallel_pending_review', subset_name: subset, is_active: false }
  }
  if (hasAuto && hasRelic) return { card_type: 'auto_relic', subset_name: normalized, is_active: true }
  if (hasAuto)             return { card_type: 'autograph',  subset_name: normalized, is_active: true }
  if (hasRelic)            return { card_type: 'relic',      subset_name: normalized, is_active: true }
  return { card_type: 'insert', subset_name: normalized, is_active: true }
}

/**
 * Parse the Master sheet of a Beckett xlsx into classified ScrapedCards
 * across all sections (base + inserts + autos + relics).
 *
 * Dedupe key is (card_type, subset_name, card_number) so the same card
 * appearing under multiple parallel variants only inserts once per type.
 */
function parseChecklist(xlsx: Buffer): ScrapedCard[] {
  const wb = XLSX.read(xlsx, { type: 'buffer' })
  const sheetName =
    wb.SheetNames.find((n) => n.toLowerCase() === 'master') ?? wb.SheetNames[wb.SheetNames.length - 1]
  const ws = wb.Sheets[sheetName]
  const rows: any[][] = XLSX.utils.sheet_to_json(ws, { header: 1, blankrows: false, defval: null })

  const out: ScrapedCard[] = []
  const seen = new Set<string>()
  for (const r of rows) {
    if (!Array.isArray(r) || r.length < 3) continue
    const subset = String(r[0] ?? '').trim()
    const number = String(r[1] ?? '').trim()
    const player = String(r[2] ?? '').trim()
    const team = r[3] != null ? String(r[3]).trim() : null
    if (!subset || !number || !player) continue
    const classified = classifySubset(subset)
    if (!classified) continue
    const key = `${classified.card_type}::${classified.subset_name ?? ''}::${number}`
    if (seen.has(key)) continue
    seen.add(key)
    out.push({
      card_number: number,
      player_name: player,
      team:        team || null,
      card_type:   classified.card_type,
      subset_name: classified.subset_name,
      is_active:   classified.is_active,
    })
  }

  // Strategy B fallback: if the Master sheet yielded zero base cards,
  // parse the dedicated `Base` sheet directly. High-end products like
  // Immaculate and Contenders use the Master sheet for inserts/autos only,
  // and put the base checklist in a `Base` sheet shaped as header rows
  // followed by data rows [card_number, player, team, …].
  if (!out.some((c) => c.card_type === 'base')) {
    const baseCards = parseBaseSheetDirect(wb)
    for (const c of baseCards) {
      const key = `${c.card_type}::${c.subset_name ?? ''}::${c.card_number}`
      if (seen.has(key)) continue
      seen.add(key)
      out.push(c)
    }
  }

  return out
}

function parseBaseSheetDirect(wb: XLSX.WorkBook): ScrapedCard[] {
  const baseSheetName =
    wb.SheetNames.find((n) => /^base$/i.test(n)) ??
    wb.SheetNames.find((n) => /\bbase\b/i.test(n) && !/insert|auto|memo|parallel|variation|update/i.test(n))
  if (!baseSheetName) return []
  const rows: any[][] = XLSX.utils.sheet_to_json(wb.Sheets[baseSheetName], { header: 1, blankrows: false, defval: null })
  const out: ScrapedCard[] = []
  const seen = new Set<string>()
  for (const r of rows) {
    if (!Array.isArray(r) || r.length < 2) continue
    const c0 = String(r[0] ?? '').trim()
    const c1 = String(r[1] ?? '').trim()
    const c2 = r[2] != null ? String(r[2]).trim() : null
    // Accept numeric card numbers (allow optional letter suffix like "199a")
    // and Bowman-style prefixes like "BD-1", "BCP-12".
    if (!/^(?:[A-Z]{1,5}-)?\d+[A-Za-z]?$/.test(c0)) continue
    if (!c1) continue
    // Skip rows where col[1] is clearly meta rather than a player name.
    if (/^(parallels?|insert|auto|variations?):?$/i.test(c1)) continue
    if (seen.has(c0)) continue
    seen.add(c0)
    out.push({
      card_number: c0,
      player_name: c1,
      team:        c2 || null,
      card_type:   'base',
      subset_name: null,
      is_active:   true,
    })
  }
  return out
}

/**
 * Base-only variant kept for backward compatibility / debug runs.
 * The main orchestrator now calls parseChecklist (which is a superset).
 */
function parseBaseSet(xlsx: Buffer): ScrapedCard[] {
  return parseChecklist(xlsx).filter(c => c.card_type === 'base')
}

// ─── 3b. HTML fallback parser (older pages without xlsx) ─────────────────────
// Older Beckett checklist pages (e.g. 2018-19, 2019-20 Prizm Basketball) inline
// the base checklist under `<h2>Base Set Checklist</h2>` as a series of `<p>`
// blocks like `<p>1 Brandon Knight<br> 2 Dragan Bender<br>…</p>`. Some pages
// nest those paragraphs inside `<div class="column-group">` wrappers, so we
// can't rely on direct DOM-sibling traversal — we slice the raw HTML between
// the base heading and the next h2/h3 instead.
function parseHtmlBaseSet(html: string): ScrapedCard[] {
  // Locate the Base Set Checklist heading by source position.
  const headingRe = /<h([23])[^>]*>\s*Base Set Checklist\s*<\/h\1>/i
  const headingMatch = html.match(headingRe)
  if (!headingMatch || headingMatch.index == null) return []
  const sectionStart = headingMatch.index + headingMatch[0].length

  // Find the next h2/h3 boundary after the heading.
  const rest = html.slice(sectionStart)
  const nextHeadingRe = /<h[23][^>]*>/i
  const nextMatch = rest.match(nextHeadingRe)
  const sectionEnd = nextMatch && nextMatch.index != null ? nextMatch.index : rest.length
  const sectionHtml = rest.slice(0, sectionEnd)

  // Re-parse just that slice so we can pull every <p> within (any nesting).
  const $section = cheerio.load(`<div id="__base">${sectionHtml}</div>`)
  const paragraphs = $section('p').toArray()

  const out: ScrapedCard[] = []
  const seen = new Set<string>()
  for (const p of paragraphs) {
    const $p = $section(p)
    // Replace <br> with literal newlines so .text() yields line-separated content.
    $p.find('br').replaceWith('\n')
    const text = $p.text()
    for (const rawLine of text.split('\n')) {
      const line = rawLine.replace(/\s+/g, ' ').trim()
      if (!line) continue
      const m = line.match(/^(\d{1,4})\s+(.+)$/)
      if (!m) continue
      const number = m[1]
      let player = m[2].trim()
      // Strip trailing rookie/short-print flags from the player name.
      player = player.replace(/\s+(RC|RC1|RC2|SP|SSP|AU|Auto|Autograph|MEM|Memorabilia|Relic|Patch|Variation|Photo Variation|Image Variation)\b.*$/i, '').trim()
      // Strip trailing parenthesized notes like "(SP)".
      player = player.replace(/\s*\([^)]*\)\s*$/, '').trim()
      if (!player) continue
      // Reject meta/summary lines like "300 cards.", "100 cards", "300 Cards".
      // Real player names always have at least two words (first + last).
      if (/^cards?\.?$/i.test(player)) continue
      if (!player.includes(' ')) continue
      // Player name must start with a letter (catches stray punctuation).
      if (!/^[A-Z]/i.test(player)) continue
      if (seen.has(number)) continue
      seen.add(number)
      out.push({
        card_number: number,
        player_name: player,
        team:        null,
        card_type:   'base',
        subset_name: null,
        is_active:   true,
      })
    }
  }
  return out
}

// ─── 4. Player matching / creation ────────────────────────────────────────────
const playerCache = new Map<string, string>() // sport_id + lower(name) → id

async function findOrCreatePlayer(
  name: string,
  sportId: string,
  stats: ProgressFile['stats']
): Promise<string | null> {
  if (!name) return null
  // Sanitize at the boundary. Returns null for combos / meta / empty;
  // strips "/N" print runs and trailing ", Team" suffixes. Audit trail
  // appended to scripts/_beckett_sanitizer_log.jsonl. Caller already
  // tolerates null player_id (card row will be created with player_id=null).
  const sanitized = sanitizePlayerName(name)
  if (!sanitized) return null
  const key = `${sportId}::${sanitized.toLowerCase()}`
  const hit = playerCache.get(key)
  if (hit) return hit

  const { data: existing, error: selErr } = await supabase
    .from('players')
    .select('id')
    .ilike('name', sanitized)
    .eq('sport_id', sportId)
    .limit(1)
  if (selErr) {
    console.warn(`    ⚠ player lookup failed for "${sanitized}": ${selErr.message}`)
    return null
  }
  if (existing && existing.length) {
    playerCache.set(key, existing[0].id)
    return existing[0].id
  }
  const { data: created, error: insErr } = await supabase
    .from('players')
    .insert({ name: sanitized, sport_id: sportId, active: true })
    .select('id')
    .single()
  if (insErr || !created) {
    console.warn(`    ⚠ player create failed for "${sanitized}": ${insErr?.message}`)
    return null
  }
  stats.players_created++
  playerCache.set(key, created.id)
  return created.id
}

// ─── 5. Insert cards (WHERE NOT EXISTS) ───────────────────────────────────────
//
// Dedupe key is (card_number, card_type, subset_name) so the same card_number
// can exist as base, insert, and autograph rows without conflict.
async function insertCards(
  dbSet: DbSet,
  cards: ScrapedCard[],
  stats: ProgressFile['stats']
): Promise<number> {
  const { data: existing, error } = await supabase
    .from('cards')
    .select('card_number, card_type, subset_name')
    .eq('set_id', dbSet.id)
  if (error) {
    console.warn(`  ⚠ existing-cards check failed: ${error.message}`)
    return 0
  }
  const compositeKey = (n: string, t: string | null | undefined, s: string | null | undefined) =>
    `${n}::${t ?? 'base'}::${s ?? ''}`
  const existingKeys = new Set(
    (existing ?? []).map((c: any) => compositeKey(String(c.card_number), c.card_type, c.subset_name)),
  )

  const toInsert: Array<{
    set_id:      string
    player_id:   string | null
    card_number: string
    name:        string
    card_type:   CardType
    subset_name: string | null
    is_active:   boolean
  }> = []
  for (const c of cards) {
    if (existingKeys.has(compositeKey(c.card_number, c.card_type, c.subset_name))) continue
    const playerId = await findOrCreatePlayer(c.player_name, dbSet.sport_id, stats)
    toInsert.push({
      set_id:      dbSet.id,
      player_id:   playerId,
      card_number: c.card_number,
      name:        c.player_name,
      card_type:   c.card_type,
      subset_name: c.subset_name,
      is_active:   c.is_active,
    })
  }

  if (!toInsert.length) return 0
  let inserted = 0
  for (let i = 0; i < toInsert.length; i += 200) {
    const batch = toInsert.slice(i, i + 200)
    const { data, error } = await supabase.from('cards').insert(batch).select('id, card_number, name, card_type, subset_name')
    if (error) {
      console.warn(`  ⚠ card insert batch ${i / 200 + 1} failed: ${error.message}`)
      continue
    }
    for (const row of data ?? []) {
      const r = row as any
      const tag = r.card_type === 'base' ? '' : ` [${r.card_type}${r.subset_name ? ': ' + r.subset_name : ''}]`
      console.log(`    + #${r.card_number} ${r.name}${tag}`)
    }
    inserted += data?.length ?? 0
  }
  stats.cards_inserted += inserted
  return inserted
}

// ─── Orchestrator ─────────────────────────────────────────────────────────────
async function processTarget(t: Target, progress: ProgressFile): Promise<void> {
  console.log(`\n▶ ${t.key}`)
  console.log(`  • ${t.url}`)

  console.log('  • locating set in DB')
  const dbSet = await findDbSet(t)
  if (!dbSet) {
    progress.failed.push(t.key)
    saveProgress(progress)
    return
  }
  console.log(`  • DB set: "${dbSet.name}" (${dbSet.year}) — ${dbSet.id}`)

  console.log('  • fetching HTML')
  const html = await fetchHtml(t.url)

  console.log('  • locating xlsx link in page')
  const xlsxUrl = findXlsxUrl(html, t.url)

  let cards: ScrapedCard[] = []
  let source = ''
  if (xlsxUrl) {
    console.log(`  • xlsx: ${xlsxUrl}`)
    const cacheName = xlsxUrl.split('/').pop() || `${t.key}.xlsx`
    console.log('  • downloading xlsx (cached)')
    const buf = await downloadXlsx(xlsxUrl, cacheName)
    console.log(`  • xlsx ${buf.length} bytes`)
    console.log('  • parsing Master sheet (base + inserts + autos + relics)')
    cards = parseChecklist(buf)
    source = 'xlsx'
    const byType = cards.reduce<Record<string, number>>((acc, c) => {
      acc[c.card_type] = (acc[c.card_type] ?? 0) + 1
      return acc
    }, {})
    console.log(`  • xlsx parser found ${cards.length} cards: ${Object.entries(byType).map(([t, n]) => `${t}=${n}`).join(', ')}`)
  } else {
    console.log('  • no xlsx link on page — will use HTML fallback')
  }

  // Fallback: parse the article HTML directly for the Base Set Checklist section.
  // The HTML parser only knows about base rows; richer pages need an xlsx.
  if (cards.length === 0) {
    console.log('  • parsing HTML base-set section')
    cards = parseHtmlBaseSet(html)
    source = 'html'
    console.log(`  • HTML parser found ${cards.length} base-set cards`)
  }
  if (!cards.length) throw new Error('no cards found in xlsx or HTML')
  console.log(`  • using ${source} source: ${cards.length} unique cards`)

  console.log('  • inserting cards (skipping existing)')
  const inserted = await insertCards(dbSet, cards, progress.stats)
  console.log(`  ✓ inserted ${inserted} new cards`)

  progress.last_run[t.key] = {
    at: new Date().toISOString(),
    cards_inserted: inserted,
    players_created: 0, // tracked at the run level in stats
  }
  if (!progress.completed.includes(t.key)) progress.completed.push(t.key)
  // Remove from failed if re-succeeding
  progress.failed = progress.failed.filter((k) => k !== t.key)
  saveProgress(progress)
}

async function main() {
  const args = process.argv.slice(2)
  const onlyArg = args.find((a) => a.startsWith('--only='))
  const onlyKey = onlyArg ? onlyArg.slice('--only='.length) : null

  console.log('Beckett scraper — starting')
  console.log('─'.repeat(60))

  const progress = loadProgress()
  const all = mergedTargets()
  const queue = onlyKey ? all.filter((t) => t.key === onlyKey) : all
  if (!queue.length) {
    console.error(`No targets matched ${onlyKey ? `--only=${onlyKey}` : '(empty TARGETS)'}`)
    process.exit(1)
  }
  const hardcodedCount = TARGETS.length
  console.log(`Queue: ${queue.length} targets (${hardcodedCount} hardcoded + ${all.length - hardcodedCount} from JSON)`)

  let success = 0
  let failed = 0
  let consecutiveFailures = 0
  const MAX_CONSECUTIVE_FAILURES = 5
  for (const t of queue) {
    // Skip targets already completed in a prior run (still cheap, but avoids
    // re-downloading HTML/xlsx). Cards-table dedup would catch dupes anyway.
    if (!onlyKey && progress.completed.includes(t.key)) {
      console.log(`\n• skipping ${t.key} (already completed)`)
      continue
    }
    try {
      await processTarget(t, progress)
      success++
      consecutiveFailures = 0
    } catch (err: any) {
      console.warn(`  ✗ ${t.key}: ${err?.message || err}`)
      if (!progress.failed.includes(t.key)) progress.failed.push(t.key)
      saveProgress(progress)
      failed++
      consecutiveFailures++
      if (consecutiveFailures >= MAX_CONSECUTIVE_FAILURES) {
        console.warn(`\n⛔ ${MAX_CONSECUTIVE_FAILURES} consecutive failures — stopping the run.`)
        console.warn(`   Re-run later to resume; completed targets will be skipped.`)
        break
      }
    }
  }

  console.log('\n' + '─'.repeat(60))
  console.log('SUMMARY')
  console.log(`  Targets completed this run: ${success}`)
  console.log(`  Targets failed this run:    ${failed}`)
  console.log(`  Cards inserted (cumulative):    ${progress.stats.cards_inserted}`)
  console.log(`  Players created (cumulative):   ${progress.stats.players_created}`)

  // Per-sport breakdown of cards inserted across ALL runs in last_run.
  // We resolve sport from the merged target list (in-memory) by key.
  const keyToSport = new Map<string, string>()
  for (const t of all) keyToSport.set(t.key, t.dbMatch.sport_slug)
  const cardsBySport: Record<string, number> = {}
  const targetsBySport: Record<string, number> = {}
  for (const [key, rec] of Object.entries(progress.last_run)) {
    const sp = keyToSport.get(key) ?? 'unknown'
    cardsBySport[sp] = (cardsBySport[sp] ?? 0) + (rec.cards_inserted ?? 0)
    targetsBySport[sp] = (targetsBySport[sp] ?? 0) + 1
  }
  const sportOrder = Object.keys(cardsBySport).sort((a, b) => (cardsBySport[b] ?? 0) - (cardsBySport[a] ?? 0))
  if (sportOrder.length) {
    console.log('\n  Cards by sport (cumulative across all runs):')
    for (const sp of sportOrder) {
      console.log(`    ${sp.padEnd(12)} ${String(cardsBySport[sp]).padStart(6)} cards  (${targetsBySport[sp]} targets)`)
    }
  }

  if (progress.failed.length) {
    console.log(`\n  Currently-failed targets (${progress.failed.length}):`)
    for (const k of progress.failed.slice(-25)) console.log(`    - ${k}`)
    if (progress.failed.length > 25) console.log(`    … +${progress.failed.length - 25} more`)
  }
}

main().catch((e) => {
  console.error('Fatal:', e)
  process.exit(1)
})
