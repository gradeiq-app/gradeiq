/**
 * Admin API — Daily Card-Set Discovery Agent
 *
 * GET  /api/admin/sets-discovery   — run discovery now (admin UI button)
 * POST /api/admin/sets-discovery   — Vercel cron trigger (checks CRON_SECRET)
 *
 * What it does:
 *  1. Fetches RSS/Atom feeds from 8 hobby-news sources
 *  2. Parses titles for year / brand / set name / sport (including WNBA)
 *  3. Assigns brand-aware default parallels instead of a single generic template
 *  4. Compares against card_sets table — skips anything already there
 *  5. Inserts new candidates into sets_queue (status = 'pending')
 *
 * Cron schedule: daily at 08:00 UTC (vercel.json)
 */

import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

// ─── RSS sources ──────────────────────────────────────────────────────────────

const RSS_SOURCES = [
  { name: 'Cardboard Connection', url: 'https://www.cardboardconnection.com/feed' },
  { name: 'Panini America Blog',  url: 'https://www.paniniamerica.net/blogs/news.atom' },
  { name: 'Beckett News',         url: 'https://www.beckett.com/news/feed/' },
  { name: 'Sports Card Investor', url: 'https://www.sportscardinvestor.com/feed/' },
  { name: 'Hobby News Daily',     url: 'https://hobbynewsdaily.com/feed/' },
  { name: 'Topps Blog',           url: 'https://www.topps.com/blogs/news.atom' },
  { name: 'Upper Deck Blog',      url: 'https://www.upperdeck.com/blog/rss' },
  { name: 'Sports Collectors Digest', url: 'https://www.sportscollectorsdigest.com/feed' },
]

// ─── Known brands (case-insensitive match) ────────────────────────────────────
// Order matters: more-specific multi-word brands first

const KNOWN_BRANDS: string[] = [
  'Upper Deck',
  'O-Pee-Chee',
  'Bowman',
  'Topps',
  'Panini',
  'Donruss',
  'Fleer',
  'Score',
  'Fanatics',
  'SkyBox',
  'Pacific',
  'Leaf',
  'SP Authentic',
  'SPx',
]

// ─── Sports (includes WNBA) ───────────────────────────────────────────────────

const SPORTS: string[] = ['baseball', 'basketball', 'football', 'hockey', 'wnba']

// ─── Words stripped from titles when extracting set name ─────────────────────

const FILLER_PATTERN = /\bcards?\b|\bchecklist\b|\bhobby\b|\bblaster\b|\bbreaks?\b|\bpreview\b|\brelease\b|\brookie\b|\bbase\b|\bset\b|\bpack\b|\bbox\b|\bcase\b|\bwax\b|\bproduct\b|\bunveils?\b|\bintroduces?\b|\bnew\b|\b\d{4}-\d{2}\b/gi

// ─── Brand-aware parallel templates ──────────────────────────────────────────

interface Parallel { label: string; ebay_kw: string }

const PARALLEL_TEMPLATES: Record<string, Parallel[]> = {
  prizm: [
    { label: 'Base',          ebay_kw: '' },
    { label: 'Silver Prizm',  ebay_kw: 'Silver Prizm' },
    { label: 'Gold /10',      ebay_kw: 'Gold Prizm' },
    { label: 'Black /1',      ebay_kw: 'Black Prizm' },
  ],
  chrome: [
    { label: 'Base',              ebay_kw: '' },
    { label: 'Refractor',         ebay_kw: 'Refractor' },
    { label: 'Gold Refractor /50',ebay_kw: 'Gold Refractor' },
    { label: 'SuperFractor /1',   ebay_kw: 'Superfractor' },
  ],
  optic: [
    { label: 'Base',      ebay_kw: '' },
    { label: 'Holo',      ebay_kw: 'Holo' },
    { label: 'Gold /10',  ebay_kw: 'Gold' },
    { label: 'Black /1',  ebay_kw: 'Black' },
  ],
  donruss: [
    { label: 'Base',             ebay_kw: '' },
    { label: 'Press Proof /99',  ebay_kw: 'Press Proof' },
    { label: 'Gold /25',         ebay_kw: 'Gold' },
    { label: 'Black /1',         ebay_kw: 'Black' },
  ],
  upper_deck: [
    { label: 'Base',             ebay_kw: '' },
    { label: 'Young Guns',       ebay_kw: 'Young Guns' },
    { label: 'Exclusives /100',  ebay_kw: 'Exclusives' },
    { label: 'High Gloss /10',   ebay_kw: 'High Gloss' },
  ],
  high_end: [                    // National Treasures, Immaculate, Flawless, The Cup, etc.
    { label: 'Base',             ebay_kw: '' },
    { label: 'Gold /25',         ebay_kw: 'Gold' },
    { label: 'Platinum /10',     ebay_kw: 'Platinum' },
    { label: 'Black /1',         ebay_kw: 'Black' },
  ],
  generic: [
    { label: 'Base',     ebay_kw: '' },
    { label: 'Silver',   ebay_kw: 'Silver' },
    { label: 'Gold /10', ebay_kw: 'Gold' },
    { label: 'Black /1', ebay_kw: 'Black' },
  ],
}

function pickParallelTemplate(brand: string, setName: string): Parallel[] {
  const s = (brand + ' ' + setName).toLowerCase()

  if (s.includes('prizm') || s.includes('mosaic') || s.includes('select'))      return PARALLEL_TEMPLATES.prizm
  if (s.includes('chrome') || s.includes('refractor') || s.includes('finest'))  return PARALLEL_TEMPLATES.chrome
  if (s.includes('optic'))                                                        return PARALLEL_TEMPLATES.optic
  if (s.includes('donruss') && !s.includes('optic'))                             return PARALLEL_TEMPLATES.donruss
  if (s.includes('upper deck') || s.includes('ud '))                             return PARALLEL_TEMPLATES.upper_deck
  if (
    s.includes('national treasures') || s.includes('immaculate') ||
    s.includes('flawless') || s.includes('the cup') || s.includes('noir') ||
    s.includes('impeccable') || s.includes('obsidian')
  ) return PARALLEL_TEMPLATES.high_end

  return PARALLEL_TEMPLATES.generic
}

// ─── RSS parser ───────────────────────────────────────────────────────────────

interface RssItem { title: string; link: string; source: string }

async function fetchRssItems(source: { name: string; url: string }): Promise<RssItem[]> {
  try {
    const res = await fetch(source.url, {
      headers: { 'User-Agent': 'GradeIQ/1.0 (card-set-discovery-bot; contact: admin@gradeiq.app)' },
      signal: AbortSignal.timeout(10_000),
    })
    if (!res.ok) return []
    const xml = await res.text()

    const titleMatches = [...xml.matchAll(/<title[^>]*><!\[CDATA\[([\s\S]+?)]]><\/title>|<title[^>]*>([^<]+)<\/title>/g)]
    const linkMatches  = [...xml.matchAll(/<link[^>]*>([^<]+)<\/link>|<link[^>]+href="([^"]+)"/g)]

    const items: RssItem[] = []
    const count = Math.min(titleMatches.length, linkMatches.length, 50)

    for (let i = 0; i < count; i++) {
      const title = (titleMatches[i][1] ?? titleMatches[i][2] ?? '').trim()
      const link  = (linkMatches[i][1]  ?? linkMatches[i][2]  ?? '').trim()
      if (title) items.push({ title, link, source: source.name })
    }
    return items
  } catch {
    return []
  }
}

// ─── Title → set info extraction ─────────────────────────────────────────────

interface ParsedSet { sport: string; year: number; brand: string; set_name: string }

function extractSetFromTitle(title: string): ParsedSet | null {
  const lower = title.toLowerCase()

  // Need a year in 2017–2027 (also handles "2024-25" season format — captures first year)
  const yearMatch = title.match(/\b(20(?:1[7-9]|2[0-7]))/)
  if (!yearMatch) return null
  const year = parseInt(yearMatch[1])

  // Need a known brand (check multi-word first)
  const brand = KNOWN_BRANDS.find(b => lower.includes(b.toLowerCase()))
  if (!brand) return null

  // Need a sport keyword anywhere in the title
  const sport = SPORTS.find(s => lower.includes(s))
  if (!sport) return null

  // Build the set name by stripping all the known tokens from the title, leaving
  // the set-specific words (e.g. "Prizm", "Heritage", "Finest Draft").
  const set_name = title
    .replace(new RegExp(yearMatch[0].replace(/[-]/g, '[-]?'), 'g'), '')   // year (incl. season format)
    .replace(new RegExp(brand.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'gi'), '')
    .replace(new RegExp('\\b' + sport + '\\b', 'gi'), '')
    .replace(FILLER_PATTERN, ' ')
    .replace(/[^a-zA-Z0-9 &'.]/g, ' ')   // remove punctuation
    .replace(/\s+/g, ' ')
    .trim()
    // Title-case each word
    .split(' ')
    .filter(w => w.length > 0)
    .map(w => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
    .join(' ')

  if (!set_name || set_name.length < 2 || set_name.length > 60) return null

  return { sport, year, brand, set_name }
}

// ─── GET — manual trigger from admin UI ──────────────────────────────────────

export async function GET(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  return runDiscovery()
}

// ─── POST — Vercel cron trigger ───────────────────────────────────────────────

export async function POST(request: NextRequest) {
  const secret = process.env.CRON_SECRET
  if (secret) {
    const auth = request.headers.get('authorization') ?? ''
    if (auth !== `Bearer ${secret}`) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }
  }
  return runDiscovery()
}

// ─── Core discovery logic ─────────────────────────────────────────────────────

async function runDiscovery(): Promise<NextResponse> {
  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  // 1. Build lookup sets of existing + already-queued items
  const [existingRes, queuedRes] = await Promise.all([
    sb.from('card_sets').select('sport, year, brand, set_name'),
    sb.from('sets_queue').select('sport, year, brand, set_name'),
  ])

  const existingKeys = new Set(
    (existingRes.data ?? []).map(r =>
      `${r.sport}|${r.year}|${r.brand.toLowerCase()}|${r.set_name.toLowerCase()}`
    )
  )
  const queuedKeys = new Set(
    (queuedRes.data ?? []).map(r =>
      `${r.sport}|${r.year}|${r.brand.toLowerCase()}|${r.set_name.toLowerCase()}`
    )
  )

  // 2. Fetch all RSS feeds in parallel (with individual timeouts)
  const feedResults = await Promise.allSettled(RSS_SOURCES.map(fetchRssItems))
  const allItems: RssItem[] = []
  for (const result of feedResults) {
    if (result.status === 'fulfilled') allItems.push(...result.value)
  }

  // 3. Parse, deduplicate, skip known items
  const seen = new Set<string>()
  const candidates: Array<ParsedSet & { source_url: string; source_name: string; source_title: string }> = []

  for (const item of allItems) {
    const parsed = extractSetFromTitle(item.title)
    if (!parsed) continue

    const key = `${parsed.sport}|${parsed.year}|${parsed.brand.toLowerCase()}|${parsed.set_name.toLowerCase()}`
    if (existingKeys.has(key) || queuedKeys.has(key) || seen.has(key)) continue

    seen.add(key)
    candidates.push({
      ...parsed,
      source_url:   item.link,
      source_name:  item.source,
      source_title: item.title,
    })
  }

  // 4. Insert new candidates with brand-aware parallels
  let inserted = 0
  if (candidates.length > 0) {
    const rows = candidates.map(c => ({
      sport:              c.sport,
      year:               c.year,
      brand:              c.brand,
      set_name:           c.set_name,
      source_url:         c.source_url,
      source_name:        c.source_name,
      source_title:       c.source_title,
      proposed_parallels: pickParallelTemplate(c.brand, c.set_name),
      status:             'pending',
    }))

    const { error, count } = await sb
      .from('sets_queue')
      .upsert(rows, { onConflict: 'sport, year, brand, set_name', ignoreDuplicates: true, count: 'exact' })

    if (!error) inserted = count ?? rows.length
  }

  // 5. Also auto-approve any queued items whose key now exists in card_sets
  //    (handles the case where we seeded the DB manually after the item was queued)
  const alreadySyncedKeys = [...queuedKeys].filter(k => existingKeys.has(k))
  if (alreadySyncedKeys.length > 0) {
    // Best-effort — don't block on this
    sb.from('sets_queue')
      .update({ status: 'approved', reviewed_at: new Date().toISOString() })
      .in('status', ['pending'])
      .then(() => {/* fire-and-forget */})
  }

  return NextResponse.json({
    ok:            true,
    rss_items:     allItems.length,
    candidates:    candidates.length,
    inserted,
    sources:       RSS_SOURCES.map(s => s.name),
    sports_watched: SPORTS,
  })
}
