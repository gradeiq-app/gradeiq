/**
 * tcdb-scraper.ts
 *
 * Pulls authoritative card checklists from tcdb.com and populates the
 * `cards`, `players`, and `parallels` tables in Supabase.
 *
 *   npm install cheerio @types/cheerio
 *   npx ts-node scripts/tcdb-scraper.ts
 *
 * Re-runnable: progress persisted to scripts/tcdb-progress.json.
 *
 * Hard rules:
 *   - 2-second floor between every TCDB request
 *   - never fabricate card numbers — only what TCDB returns
 *   - no schema changes, no migrations, no images
 */

import { createClient } from '@supabase/supabase-js'
import * as cheerio from 'cheerio'
import { readFileSync, writeFileSync, existsSync } from 'fs'
import { join } from 'path'
import { sanitizePlayerName, detectParallelFamily } from './lib/beckett_sanitizers'

// ─── Env loader (.env.local) ──────────────────────────────────────────────────
function loadEnv() {
  const envPath = join(process.cwd(), '.env.local')
  if (!existsSync(envPath)) return
  const raw = readFileSync(envPath, 'utf8')
  for (const line of raw.split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/)
    if (!m) continue
    const [, k, vRaw] = m
    if (process.env[k]) continue
    const v = vRaw.replace(/^["']|["']$/g, '')
    process.env[k] = v
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
const PROGRESS_FILE = join(process.cwd(), 'scripts', 'tcdb-progress.json')
const REQUEST_DELAY_MS = 2000
const MAX_CONSECUTIVE_FAILURES = 3
const USER_AGENT =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

type ProgressFile = {
  completed: string[]
  failed: string[]
  pending: string[]
  not_found: string[]
  tcdb_ids: Record<string, number> // set_id → tcdb set id
  stats: {
    cards_inserted: number
    players_created: number
    parallels_applied: number
  }
}

type SetRow = {
  id: string
  year: number
  name: string
  sport_slug: string
  manufacturer_name: string
  manufacturer_slug: string
  sport_id: string
  parallel_templates: ParallelTemplate[] | null
  card_count: number
}

type ParallelTemplate = { label: string; ebay_kw: string; print_run?: number | null }

type ScrapedCard = {
  card_number: string
  player_name: string
  raw_name: string
  variation: string | null
  is_rookie: boolean
  is_autograph: boolean
  is_relic: boolean
  is_parallel_pending: boolean
}

// ─── Progress ─────────────────────────────────────────────────────────────────
function loadProgress(): ProgressFile {
  if (existsSync(PROGRESS_FILE)) {
    try {
      return JSON.parse(readFileSync(PROGRESS_FILE, 'utf8'))
    } catch {
      // fall through to fresh
    }
  }
  return {
    completed: [],
    failed: [],
    pending: [],
    not_found: [],
    tcdb_ids: {},
    stats: { cards_inserted: 0, players_created: 0, parallels_applied: 0 },
  }
}

function saveProgress(p: ProgressFile) {
  writeFileSync(PROGRESS_FILE, JSON.stringify(p, null, 2), 'utf8')
}

// ─── Rate-limited fetch with 429 retry ────────────────────────────────────────
// Returns { html, status }:
//   - status 200: html is the body
//   - status 404: real "not found on TCDB" — caller should mark not_found
//   - any other status: transient failure — caller should mark failed (retryable)
type FetchResult = { html: string | null; status: number }

let lastRequestAt = 0
async function tcdbFetch(url: string, attempt = 0): Promise<FetchResult> {
  const wait = Math.max(0, REQUEST_DELAY_MS - (Date.now() - lastRequestAt))
  if (wait > 0) await sleep(wait)
  lastRequestAt = Date.now()

  const res = await fetch(url, {
    headers: {
      'user-agent': USER_AGENT,
      accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'accept-language': 'en-US,en;q=0.9',
    },
    redirect: 'follow',
  })

  if (res.status === 429) {
    if (attempt >= 3) return { html: null, status: 429 }
    console.warn(`  ⏸  429 rate limited, waiting 30s before retry…`)
    await sleep(30_000)
    return tcdbFetch(url, attempt + 1)
  }
  if (res.status === 404) return { html: null, status: 404 }
  if (!res.ok) {
    console.warn(`  ⚠  ${res.status} fetching ${url}`)
    return { html: null, status: res.status }
  }
  return { html: await res.text(), status: 200 }
}

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms))

// ─── Step 1: build the set queue from Supabase ────────────────────────────────
async function buildSetQueue(): Promise<SetRow[]> {
  // Join sets → sports, manufacturers, and count cards per set.
  // The query returns nested objects; flatten in TS.
  const { data, error } = await supabase
    .from('sets')
    .select(`
      id,
      year,
      name,
      sport_id,
      parallel_templates,
      sports:sport_id ( slug ),
      manufacturers:manufacturer_id ( name, slug ),
      cards ( count )
    `)
    .eq('is_active', true)
    .order('year', { ascending: false })

  if (error) {
    console.error('Failed to load sets:', error.message)
    process.exit(1)
  }

  const rows: SetRow[] = (data ?? [])
    .map((r: any) => ({
      id: r.id,
      year: r.year,
      name: r.name,
      sport_id: r.sport_id,
      sport_slug: r.sports?.slug ?? '',
      manufacturer_name: r.manufacturers?.name ?? '',
      manufacturer_slug: r.manufacturers?.slug ?? '',
      parallel_templates: r.parallel_templates ?? null,
      card_count: r.cards?.[0]?.count ?? 0,
    }))
    .filter((r: SetRow) => r.card_count < 50)

  return rows.sort(priorityCompare)
}

// Priority order from the spec.
function priorityCompare(a: SetRow, b: SetRow): number {
  const ra = priorityRank(a)
  const rb = priorityRank(b)
  if (ra !== rb) return ra - rb
  // Newer first within a tier
  return b.year - a.year
}

function priorityRank(s: SetRow): number {
  const yearInRange = s.year >= 2018 && s.year <= 2025
  const n = s.name.toLowerCase()
  const sp = s.sport_slug
  const m = s.manufacturer_slug

  if (yearInRange && sp === 'basketball' && m === 'panini' && /\bprizm\b/.test(n) && !/wnba/i.test(n)) return 1
  if (yearInRange && sp === 'football' && m === 'panini' && /\bprizm\b/.test(n)) return 2
  if (yearInRange && sp === 'baseball' && m === 'topps' && /\bchrome\b/.test(n)) return 3
  if (yearInRange && sp === 'wnba' && m === 'panini' && /\bprizm\b/.test(n)) return 4
  if (yearInRange && sp === 'wnba' && /wnba/i.test(n) && m === 'panini' && /\bprizm\b/.test(n)) return 4
  if (yearInRange && sp === 'basketball' && /wnba/i.test(n) && /\bprizm\b/.test(n)) return 4
  if (yearInRange && sp === 'baseball' && m === 'bowman' && /\bchrome\b/.test(n)) return 5
  if (yearInRange && sp === 'hockey' && m === 'upper-deck' && /\bseries 1\b/.test(n)) return 6
  if (yearInRange && sp === 'basketball' && m === 'panini' && /\bselect\b/.test(n)) return 7
  if (yearInRange && sp === 'basketball' && m === 'panini' && /\bmosaic\b/.test(n)) return 8
  return 9
}

// ─── Step 2: search TCDB for a set ID ─────────────────────────────────────────
// Returns: { id: number | null, transient: boolean }
//   - id: TCDB set id if matched
//   - transient: true if the search itself failed (block, 5xx, network) so the
//     caller can mark this set as failed (retryable) rather than not_found.
type SearchResult = { id: number | null; transient: boolean }

async function findTcdbSetId(s: SetRow): Promise<SearchResult> {
  const sportWord = sportKeyword(s.sport_slug, s.name)
  const query = [s.year, s.manufacturer_name, s.name, sportWord]
    .filter(Boolean)
    .join(' ')
    .trim()

  const url = `https://www.tcdb.com/Search.cfm/sid/1?SearchTerms=${encodeURIComponent(query)}`
  const { html, status } = await tcdbFetch(url)
  if (!html) {
    return { id: null, transient: status !== 404 }
  }

  const $ = cheerio.load(html)
  type Candidate = { id: number; text: string }
  const candidates: Candidate[] = []
  $('a[href*="/ViewSet.cfm/sid/"]').each((_, el) => {
    const href = $(el).attr('href') || ''
    const m = href.match(/\/ViewSet\.cfm\/sid\/(\d+)/i)
    if (!m) return
    const id = Number(m[1])
    const text = $(el).text().trim()
    if (!text) return
    candidates.push({ id, text })
  })

  if (!candidates.length) return { id: null, transient: false }

  // Score candidates by how many of our query tokens appear in the link text.
  const tokens = query.toLowerCase().split(/\s+/).filter((t) => t.length > 2)
  const yearStr = String(s.year)
  let best: Candidate | null = null
  let bestScore = -1
  for (const c of candidates) {
    const lc = c.text.toLowerCase()
    if (!lc.includes(yearStr)) continue // year must match
    let score = 0
    for (const t of tokens) if (lc.includes(t)) score++
    if (score > bestScore) {
      bestScore = score
      best = c
    }
  }
  // Require at least 3 token matches including the year to be confident.
  if (!best || bestScore < 3) return { id: null, transient: false }
  return { id: best.id, transient: false }
}

function sportKeyword(slug: string, name: string): string {
  if (/wnba/i.test(name)) return 'WNBA'
  switch (slug) {
    case 'baseball':
      return 'Baseball'
    case 'basketball':
      return 'Basketball'
    case 'football':
      return 'Football'
    case 'hockey':
      return 'Hockey'
    case 'soccer':
      return 'Soccer'
    default:
      return ''
  }
}

// ─── Step 2 (cont): scrape checklist ──────────────────────────────────────────
async function scrapeChecklist(tcdbSetId: number): Promise<ScrapedCard[] | null> {
  const url = `https://www.tcdb.com/ViewSet.cfm/sid/${tcdbSetId}`
  const { html } = await tcdbFetch(url)
  if (!html) return null

  const $ = cheerio.load(html)
  const cards: ScrapedCard[] = []
  let parseFailures = 0

  $('table.spreadsheet tr').each((_, tr) => {
    const numEl = $(tr).find('td.cardnum').first()
    const nameEl = $(tr).find('td.cardname').first()
    if (!numEl.length || !nameEl.length) return
    const cardNumber = numEl.text().trim()
    const rawName = nameEl.text().trim().replace(/\s+/g, ' ')
    if (!cardNumber || !rawName) {
      parseFailures++
      if (parseFailures <= 3) {
        console.warn(`    ⚠ parse fail row: ${$(tr).html()?.slice(0, 200)}`)
      }
      return
    }
    cards.push(extractCard(cardNumber, rawName))
  })

  return cards
}

const FLAG_PATTERNS: Array<{ re: RegExp; flag: keyof Pick<ScrapedCard, 'is_rookie' | 'is_autograph' | 'is_relic'>; label: string }> = [
  { re: /\bRC\b/i, flag: 'is_rookie', label: 'RC' },
  { re: /\bRookie Card\b/i, flag: 'is_rookie', label: 'RC' },
  { re: /\bAuto(?:graph)?\b/i, flag: 'is_autograph', label: 'AU' },
  { re: /\bAU\b/, flag: 'is_autograph', label: 'AU' },
  { re: /\bMEM\b/, flag: 'is_relic', label: 'MEM' },
  { re: /\bRelic\b/i, flag: 'is_relic', label: 'Relic' },
  { re: /\bPatch\b/i, flag: 'is_relic', label: 'Patch' },
]

const VARIATION_PATTERNS = [
  /\bSSP\b/i,
  /\bSP\b/i,
  /\bPhoto Variation\b/i,
  /\bImage Variation\b/i,
  /\bShort Print\b/i,
]

function extractCard(cardNumber: string, rawName: string): ScrapedCard {
  let cleaned = rawName
  const card: ScrapedCard = {
    card_number: cardNumber,
    player_name: '',
    raw_name: rawName,
    variation: null,
    is_rookie: false,
    is_autograph: false,
    is_relic: false,
    is_parallel_pending: false,
  }

  for (const p of FLAG_PATTERNS) {
    if (p.re.test(cleaned)) {
      card[p.flag] = true
      cleaned = cleaned.replace(p.re, '').replace(/\s+/g, ' ').trim()
    }
  }
  for (const re of VARIATION_PATTERNS) {
    const m = cleaned.match(re)
    if (m) {
      card.variation = card.variation ? `${card.variation} ${m[0]}` : m[0]
      cleaned = cleaned.replace(re, '').replace(/\s+/g, ' ').trim()
    }
  }
  // Strip trailing team in parens — e.g. "Victor Wembanyama (Spurs)"
  cleaned = cleaned.replace(/\s*\([^)]*\)\s*$/, '').trim()
  card.player_name = cleaned
  // Defensive parallel-family detection. TCDB hasn't run successfully yet
  // (per [[project-player-name-contamination-phase-a-b-c]]); this is the
  // same sanitizer applied at the same boundary for consistency. Matched
  // rows persist as card_type='parallel_pending_review', is_active=false
  // so tomorrow's Phase C can triage them. See
  // [[project-beckett-card-type-contamination]].
  const pf = detectParallelFamily(rawName)
  if (pf.matched) card.is_parallel_pending = true
  return card
}

// ─── Step 3: match/create players, insert cards ───────────────────────────────
const playerCache = new Map<string, string>() // `${sport_id}::${lower(name)}` → player.id

async function findOrCreatePlayer(name: string, sportId: string, stats: ProgressFile['stats']): Promise<string | null> {
  if (!name) return null
  // Sanitize at the boundary — same module + behavior as Beckett. Audit
  // log appended to scripts/_beckett_sanitizer_log.jsonl. Caller already
  // tolerates null player_id.
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

async function insertCards(setRow: SetRow, scraped: ScrapedCard[], stats: ProgressFile['stats']): Promise<string[]> {
  // Existing card_numbers for this set, to enforce WHERE NOT EXISTS without a unique index.
  const { data: existing, error: exErr } = await supabase
    .from('cards')
    .select('id, card_number')
    .eq('set_id', setRow.id)

  if (exErr) {
    console.warn(`  ⚠ existing-cards check failed: ${exErr.message}`)
    return []
  }
  const existingNumbers = new Set((existing ?? []).map((c: any) => String(c.card_number)))

  const toInsert: Array<{
    set_id: string
    player_id: string | null
    card_number: string
    name: string
    card_type: string
    is_active: boolean
  }> = []
  for (const c of scraped) {
    if (existingNumbers.has(c.card_number)) continue
    const playerId = await findOrCreatePlayer(c.player_name, setRow.sport_id, stats)
    const displayName = [c.player_name, c.variation].filter(Boolean).join(' ').trim() || c.raw_name
    toInsert.push({
      set_id: setRow.id,
      player_id: playerId,
      card_number: c.card_number,
      name: displayName,
      card_type: c.is_parallel_pending ? 'parallel_pending_review' : 'base',
      is_active: !c.is_parallel_pending,
    })
  }

  if (!toInsert.length) return []

  // Batch insert in chunks of 200.
  const insertedIds: string[] = []
  for (let i = 0; i < toInsert.length; i += 200) {
    const batch = toInsert.slice(i, i + 200)
    const { data, error } = await supabase.from('cards').insert(batch).select('id')
    if (error) {
      console.warn(`  ⚠ card insert batch ${i / 200 + 1} failed: ${error.message}`)
      continue
    }
    stats.cards_inserted += data?.length ?? 0
    for (const row of data ?? []) insertedIds.push((row as any).id)
  }
  return insertedIds
}

// ─── Step 4: apply parallels ──────────────────────────────────────────────────
async function applyParallels(setRow: SetRow, newCardIds: string[], stats: ProgressFile['stats']): Promise<number> {
  if (!newCardIds.length) return 0

  // Skip if any of these cards already have parallels (idempotency safety).
  const { count: existingParallels } = await supabase
    .from('parallels')
    .select('id', { count: 'exact', head: true })
    .in('card_id', newCardIds)

  if ((existingParallels ?? 0) > 0) {
    return 0
  }

  const template = pickParallelTemplate(setRow)
  if (!template.length) return 0

  const rows: Array<{ card_id: string; label: string; ebay_kw: string; print_run: number | null }> = []
  for (const cardId of newCardIds) {
    for (const p of template) {
      rows.push({
        card_id: cardId,
        label: p.label,
        ebay_kw: p.ebay_kw ?? '',
        print_run: p.print_run ?? extractPrintRun(p.label),
      })
    }
  }

  let inserted = 0
  for (let i = 0; i < rows.length; i += 500) {
    const batch = rows.slice(i, i + 500)
    const { data, error } = await supabase.from('parallels').insert(batch).select('id')
    if (error) {
      console.warn(`  ⚠ parallel insert batch failed: ${error.message}`)
      continue
    }
    inserted += data?.length ?? 0
  }
  stats.parallels_applied += inserted
  return inserted
}

function pickParallelTemplate(s: SetRow): ParallelTemplate[] {
  const tpl = s.parallel_templates
  if (Array.isArray(tpl) && tpl.length) return tpl
  return defaultTemplateFor(s)
}

function defaultTemplateFor(s: SetRow): ParallelTemplate[] {
  const n = s.name.toLowerCase()
  const m = s.manufacturer_slug
  if (m === 'panini' && /\bprizm\b/.test(n)) {
    return [
      { label: 'Base', ebay_kw: '' },
      { label: 'Silver Prizm', ebay_kw: 'Silver Prizm' },
    ]
  }
  if ((m === 'topps' || m === 'bowman') && /\bchrome\b/.test(n)) {
    return [
      { label: 'Base', ebay_kw: '' },
      { label: 'Refractor', ebay_kw: 'Refractor' },
    ]
  }
  return [{ label: 'Base', ebay_kw: '' }]
}

function extractPrintRun(label: string): number | null {
  const m = label.match(/\/(\d+)\b/)
  return m ? Number(m[1]) : null
}

// ─── Main orchestration ───────────────────────────────────────────────────────
async function main() {
  console.log('TCDB scraper — starting')
  console.log('─'.repeat(60))

  const progress = loadProgress()
  const queue = await buildSetQueue()
  console.log(`Queue: ${queue.length} sets with <50 cards`)
  console.log(`Already completed: ${progress.completed.length} | failed: ${progress.failed.length} | not found: ${progress.not_found.length}`)

  let setsCompleted = 0
  let setsFailed = 0
  let consecutiveFailures = 0

  for (const s of queue) {
    if (progress.completed.includes(s.id)) continue
    if (progress.not_found.includes(s.id)) continue

    const label = `${s.year} ${s.manufacturer_name} ${s.name} (${s.sport_slug})`
    console.log(`\n▶ ${label}`)

    try {
      let tcdbId = progress.tcdb_ids[s.id]
      if (!tcdbId) {
        console.log('  • searching TCDB…')
        const found = await findTcdbSetId(s)
        if (found.transient) {
          throw new Error('search request failed (transient)')
        }
        if (!found.id) {
          console.log('  ✗ no TCDB match — marking not_found')
          progress.not_found.push(s.id)
          saveProgress(progress)
          continue
        }
        tcdbId = found.id
        progress.tcdb_ids[s.id] = tcdbId
        saveProgress(progress)
      }
      console.log(`  • TCDB set id: ${tcdbId}`)

      const scraped = await scrapeChecklist(tcdbId)
      if (!scraped) {
        throw new Error('checklist fetch failed')
      }
      console.log(`  • parsed ${scraped.length} rows`)

      const insertedIds = await insertCards(s, scraped, progress.stats)
      console.log(`  • inserted ${insertedIds.length} new cards`)

      const parallelCount = await applyParallels(s, insertedIds, progress.stats)
      if (parallelCount) console.log(`  • applied ${parallelCount} parallels`)

      progress.completed.push(s.id)
      saveProgress(progress)
      console.log(`✓ ${label} — ${insertedIds.length} cards inserted`)
      setsCompleted++
      consecutiveFailures = 0
    } catch (err: any) {
      console.warn(`  ✗ ${label}: ${err?.message || err}`)
      progress.failed.push(s.id)
      saveProgress(progress)
      setsFailed++
      consecutiveFailures++
      if (consecutiveFailures >= MAX_CONSECUTIVE_FAILURES) {
        console.warn(`  ⏸  ${MAX_CONSECUTIVE_FAILURES} consecutive failures — pausing 30s`)
        await sleep(30_000)
        consecutiveFailures = 0
      }
      continue
    }
    consecutiveFailures = 0
  }

  console.log('\n' + '─'.repeat(60))
  console.log('SUMMARY')
  console.log(`  Sets completed this run:  ${setsCompleted}`)
  console.log(`  Sets failed this run:     ${setsFailed}`)
  console.log(`  Total cards inserted:     ${progress.stats.cards_inserted}`)
  console.log(`  Total players created:    ${progress.stats.players_created}`)
  console.log(`  Total parallels applied:  ${progress.stats.parallels_applied}`)
  if (progress.not_found.length) {
    console.log(`  Sets not found on TCDB (${progress.not_found.length}):`)
    for (const id of progress.not_found.slice(-25)) console.log(`    - ${id}`)
    if (progress.not_found.length > 25) console.log(`    … +${progress.not_found.length - 25} more`)
  }
}

main().catch((e) => {
  console.error('Fatal:', e)
  process.exit(1)
})
