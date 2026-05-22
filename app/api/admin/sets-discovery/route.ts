/**
 * Admin API — Daily Card-Set Discovery Agent
 *
 * GET  /api/admin/sets-discovery          — run discovery now (admin UI button)
 * POST /api/admin/sets-discovery          — Vercel cron trigger (checks CRON_SECRET)
 *
 * What it does:
 *  1. Fetches RSS from Cardboard Connection + Panini America blog
 *  2. Parses titles for year / brand / set name / sport
 *  3. Compares against card_sets table
 *  4. Inserts new candidates into sets_queue (status = 'pending')
 *
 * PATCH /api/admin/sets-discovery/:id — approve or reject a queued item
 */

import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin, getServiceClient }  from '@/lib/supabase-admin'

// ─── RSS Sources ────────────────────────────────────────────────────────────

const RSS_SOURCES = [
  {
    name: 'Cardboard Connection',
    url: 'https://www.cardboardconnection.com/feed',
  },
  {
    name: 'Panini America News',
    url: 'https://www.paniniamerica.net/blogs/news.atom',
  },
  {
    name: 'Beckett News',
    url: 'https://www.beckett.com/news/feed/',
  },
]

// ─── Extraction config ───────────────────────────────────────────────────────

const KNOWN_BRANDS = [
  'Upper Deck',
  'O-Pee-Chee',
  'Bowman',
  'Topps',
  'Panini',
  'Donruss',
  'Fleer',
  'Score',
]

const SPORTS = ['baseball', 'basketball', 'football', 'hockey']

// Default parallels to assign when approving a discovered set
// (admin can edit after approving via the existing sets editor)
const DEFAULT_PARALLELS = [
  { label: 'Base', ebay_kw: '' },
  { label: 'Silver', ebay_kw: 'Silver' },
  { label: 'Gold /10', ebay_kw: 'Gold' },
  { label: 'Black /1', ebay_kw: 'Black' },
]

// ─── RSS parser ──────────────────────────────────────────────────────────────

interface RssItem {
  title: string
  link: string
  source: string
}

async function fetchRssItems(source: { name: string; url: string }): Promise<RssItem[]> {
  try {
    const res = await fetch(source.url, {
      headers: { 'User-Agent': 'GradeIQ/1.0 (card-set-discovery-bot)' },
      signal: AbortSignal.timeout(10_000),
    })
    if (!res.ok) return []
    const xml = await res.text()

    // Parse both RSS <item> and Atom <entry> elements
    // Use [\s\S] instead of . with s-flag for ES2017 compat
    const titleMatches = [...xml.matchAll(/<title[^>]*><!\[CDATA\[([\s\S]+?)]]><\/title>|<title[^>]*>([^<]+)<\/title>/g)]
    const linkMatches  = [...xml.matchAll(/<link[^>]*>([^<]+)<\/link>|<link[^>]+href="([^"]+)"/g)]

    const items: RssItem[] = []
    const itemCount = Math.min(titleMatches.length, linkMatches.length, 50)

    for (let i = 0; i < itemCount; i++) {
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

interface ParsedSet {
  sport:    string
  year:     number
  brand:    string
  set_name: string
}

function extractSetFromTitle(title: string): ParsedSet | null {
  const lower = title.toLowerCase()

  // Must mention a sport
  const sport = SPORTS.find(s => lower.includes(s))
  if (!sport) return null

  // Must have a 4-digit year (2019-2026 range)
  const yearMatch = title.match(/\b(20(?:1[89]|2[0-6]))\b/)
  if (!yearMatch) return null
  const year = parseInt(yearMatch[1])

  // Must mention a known brand
  const brand = KNOWN_BRANDS.find(b => lower.includes(b.toLowerCase()))
  if (!brand) return null

  // Set name = text between brand and sport keyword (cleaned)
  const brandIdx = lower.indexOf(brand.toLowerCase())
  const sportIdx = lower.indexOf(sport)

  // brand must come before sport in the title
  if (brandIdx === -1 || sportIdx === -1 || brandIdx >= sportIdx) return null

  const rawSetName = title
    .slice(brandIdx + brand.length, sportIdx)
    .replace(/\bcards?\b/gi, '')
    .replace(/\bchecklist\b/gi, '')
    .replace(/\bhobbies?\b/gi, '')
    .replace(/\bblaster\b/gi, '')
    .replace(/\bbreaks?\b/gi, '')
    .replace(/\bpreview\b/gi, '')
    .replace(/[^a-zA-Z0-9 &'.-]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()

  if (!rawSetName || rawSetName.length < 2 || rawSetName.length > 60) return null

  // Capitalise properly (title case for set name)
  const set_name = rawSetName
    .split(' ')
    .map(w => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
    .join(' ')

  return { sport, year, brand, set_name }
}

// ─── GET — manual trigger from admin UI ─────────────────────────────────────

export async function GET(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  return runDiscovery()
}

// ─── POST — Vercel cron trigger ───────────────────────────────────────────────

export async function POST(request: NextRequest) {
  // Verify Vercel cron secret
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

  // 1. Fetch all existing set keys (sport|year|brand|set_name) for fast lookup
  const { data: existing } = await sb
    .from('card_sets')
    .select('sport, year, brand, set_name')

  const existingKeys = new Set(
    (existing ?? []).map(r => `${r.sport}|${r.year}|${r.brand.toLowerCase()}|${r.set_name.toLowerCase()}`)
  )

  // Also load already-queued items so we don't re-queue the same thing
  const { data: queued } = await sb
    .from('sets_queue')
    .select('sport, year, brand, set_name')

  const queuedKeys = new Set(
    (queued ?? []).map(r => `${r.sport}|${r.year}|${r.brand.toLowerCase()}|${r.set_name.toLowerCase()}`)
  )

  // 2. Fetch RSS feeds
  const allItems: RssItem[] = []
  for (const source of RSS_SOURCES) {
    const items = await fetchRssItems(source)
    allItems.push(...items)
  }

  // 3. Parse and deduplicate candidates
  const seen = new Set<string>()
  const candidates: Array<ParsedSet & { source_url: string; source_name: string; source_title: string }> = []

  for (const item of allItems) {
    const parsed = extractSetFromTitle(item.title)
    if (!parsed) continue

    const key = `${parsed.sport}|${parsed.year}|${parsed.brand.toLowerCase()}|${parsed.set_name.toLowerCase()}`

    // Skip if already in db, already queued, or seen this run
    if (existingKeys.has(key) || queuedKeys.has(key) || seen.has(key)) continue
    seen.add(key)

    candidates.push({
      ...parsed,
      source_url:   item.link,
      source_name:  item.source,
      source_title: item.title,
    })
  }

  // 4. Insert new candidates
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
      proposed_parallels: DEFAULT_PARALLELS,
      status:             'pending',
    }))

    const { error, count } = await sb
      .from('sets_queue')
      .upsert(rows, {
        onConflict:       'sport, year, brand, set_name',
        ignoreDuplicates: true,
        count:            'exact',
      })

    if (!error) inserted = count ?? rows.length
  }

  return NextResponse.json({
    ok:         true,
    rss_items:  allItems.length,
    candidates: candidates.length,
    inserted,
    sources:    RSS_SOURCES.map(s => s.name),
  })
}
