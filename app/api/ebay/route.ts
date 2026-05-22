/**
 * GET /api/ebay
 * Returns current eBay listing prices for raw + PSA 8/9/10 grades.
 *
 * Uses the eBay Browse API (OAuth client-credentials) instead of the legacy
 * Finding API.  Browse API returns active listings; prices reflect the current
 * ask market which closely tracks sold prices for graded cards.
 *
 * OAuth tokens are module-cached for up to 110 minutes (tokens last 2 hours;
 * we refresh 10 min early to avoid edge expiry).
 */
import { NextRequest, NextResponse } from 'next/server'
import { getServiceClient } from '@/lib/supabase-admin'

const BROWSE_BASE   = 'https://api.ebay.com/buy/browse/v1/item_summary/search'
const TOKEN_URL     = 'https://api.ebay.com/identity/v1/oauth2/token'
const CACHE_TTL_MS  = 24 * 60 * 60 * 1000   // price cache: 24 hours
const MIN_USEFUL    = 3                       // fall to next query tier if fewer results
const CALL_DELAY_MS = 150                     // ms between Browse API calls

// ─── OAuth token cache (module-level, survives warm Vercel invocations) ───────
let _tokenValue   = ''
let _tokenExpires = 0   // unix ms

async function getAppToken(): Promise<string> {
  if (_tokenValue && Date.now() < _tokenExpires) return _tokenValue

  const clientId     = process.env.EBAY_API_KEY        ?? ''
  const clientSecret = process.env.EBAY_CLIENT_SECRET  ?? ''

  if (!clientId || !clientSecret) throw new Error('eBay credentials not configured')

  console.log(`[eBay auth] clientId length=${clientId.length} secret length=${clientSecret.length} id_end="${clientId.slice(-4)}" secret_end="${clientSecret.slice(-4)}"`)
  const creds = Buffer.from(`${clientId}:${clientSecret}`).toString('base64')
  const res   = await fetch(TOKEN_URL, {
    method: 'POST',
    headers: { 'Authorization': `Basic ${creds}`, 'Content-Type': 'application/x-www-form-urlencoded' },
    body:    'grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope',
    cache:   'no-store',
  })

  if (!res.ok) {
    const err = await res.text()
    throw new Error(`eBay token error ${res.status}: ${err}`)
  }

  const data     = await res.json()
  _tokenValue    = data.access_token
  _tokenExpires  = Date.now() + (data.expires_in - 600) * 1000   // refresh 10 min early
  return _tokenValue
}

// ─── IQR-based outlier removal ────────────────────────────────────────────────
function cleanAverage(prices: number[]): number {
  if (prices.length === 0) return 0
  if (prices.length === 1) return prices[0]

  const sorted = [...prices].sort((a, b) => a - b)
  const q1  = sorted[Math.floor(sorted.length * 0.25)]
  const q3  = sorted[Math.floor(sorted.length * 0.75)]
  const iqr = q3 - q1

  const filtered = sorted.filter(p => p >= q1 - 1.5 * iqr && p <= q3 + 1.5 * iqr)
  const arr = filtered.length > 0 ? filtered : sorted
  return arr.reduce((s, p) => s + p, 0) / arr.length
}

// ─── Tiered query builder ─────────────────────────────────────────────────────
function buildQueryTiers(parts: {
  year: string; brand: string; set: string
  cardNumber: string; parallel: string; playerName: string
}): string[] {
  const { year, brand, set, cardNumber, parallel, playerName } = parts

  const candidates = [
    [year, brand, set, cardNumber, parallel, playerName],   // Tier 1 — everything
    [year, brand, set, parallel, playerName],               // Tier 2 — no card#
    [year, brand, parallel, playerName],                    // Tier 3 — no set
    [playerName, year, parallel],                           // Tier 4 — minimal
    [playerName, year],                                     // Tier 5 — absolute fallback
  ]

  const seen = new Set<string>()
  const tiers: string[] = []
  for (const p of candidates) {
    const q = p.filter(Boolean).join(' ').trim().slice(0, 350)
    if (q && !seen.has(q)) { seen.add(q); tiers.push(q) }
  }
  return tiers
}

// ─── Single Browse API fetch ──────────────────────────────────────────────────
async function fetchListingPrices(query: string, token: string): Promise<number[]> {
  const params = new URLSearchParams({
    q:      query,
    limit:  '100',
    filter: 'buyingOptions:{FIXED_PRICE|AUCTION}',
  })

  const res = await fetch(`${BROWSE_BASE}?${params}`, {
    headers: { 'Authorization': `Bearer ${token}`, 'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US' },
    cache: 'no-store',
  })

  if (!res.ok) {
    const err = await res.text()
    console.error('[eBay Browse] HTTP error', res.status, err)
    throw new Error(`eBay Browse API error: ${res.status}`)
  }

  const data = await res.json()
  const items: Record<string, unknown>[] = data.itemSummaries ?? []

  return items
    .map(item => parseFloat((item.price as Record<string, string>)?.value ?? '0'))
    .filter(p => p > 0)
}

// ─── Fetch with tiered fallback ───────────────────────────────────────────────
const delay = (ms: number) => new Promise(r => setTimeout(r, ms))

async function fetchWithFallback(
  gradeSuffix: string,
  tiers: string[],
  token: string,
): Promise<number[]> {
  for (let i = 0; i < tiers.length; i++) {
    const query  = `${tiers[i]} ${gradeSuffix}`.trim()
    const prices = await fetchListingPrices(query, token)

    if (prices.length >= MIN_USEFUL || i === tiers.length - 1) {
      if (i > 0) console.log(`[eBay] "${gradeSuffix}" fell back to tier ${i + 1}: "${query}" (${prices.length} results)`)
      return prices
    }
    await delay(CALL_DELAY_MS)
  }
  return []
}

// ─── Mock data (dev / no credentials) ────────────────────────────────────────
function mockData() {
  return {
    raw:   { avg: 42,  count: 7  },
    psa8:  { avg: 88,  count: 9  },
    psa9:  { avg: 165, count: 14 },
    psa10: { avg: 420, count: 21 },
    _mock: true,
  }
}

// ─── Cache helpers ────────────────────────────────────────────────────────────
function makeCacheKey(
  year: string, brand: string, set: string,
  cardNumber: string, parallel: string, playerName: string,
): string {
  return [year, brand, set, cardNumber, parallel, playerName]
    .map(s => s.toLowerCase().trim()).join('|')
}

async function readCache(key: string) {
  const sb = getServiceClient()
  if (!sb) return null
  const { data } = await sb
    .from('price_cache')
    .select('*')
    .eq('cache_key', key)
    .gt('expires_at', new Date().toISOString())
    .maybeSingle()
  return data
}

async function writeCache(key: string, payload: {
  raw_avg: number; raw_count: number
  psa8_avg: number; psa8_count: number
  psa9_avg: number; psa9_count: number
  psa10_avg: number; psa10_count: number
}) {
  const sb = getServiceClient()
  if (!sb) return
  await sb.from('price_cache').upsert(
    { cache_key: key, ...payload, expires_at: new Date(Date.now() + CACHE_TTL_MS).toISOString() },
    { onConflict: 'cache_key' },
  )
}

// ─── Route handler ────────────────────────────────────────────────────────────
export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const playerName = searchParams.get('playerName')?.trim() ?? ''
  const year       = searchParams.get('year')?.trim()       ?? ''
  const brand      = searchParams.get('brand')?.trim()      ?? ''
  const set        = searchParams.get('set')?.trim()        ?? ''
  const cardNumber = searchParams.get('cardNumber')?.trim() ?? ''
  const parallel   = searchParams.get('parallel')?.trim()   ?? ''

  if (!playerName || !year || !brand) {
    return NextResponse.json(
      { error: 'playerName, year, and brand are required' },
      { status: 400 },
    )
  }

  const hasCredentials = !!(process.env.EBAY_API_KEY && process.env.EBAY_CLIENT_SECRET)

  if (!hasCredentials) {
    if (process.env.NODE_ENV === 'development') return NextResponse.json(mockData())
    return NextResponse.json({ error: 'eBay credentials not configured' }, { status: 500 })
  }

  // ── Cache check ──────────────────────────────────────────────────────────
  const cacheKey = makeCacheKey(year, brand, set, cardNumber, parallel, playerName)
  try {
    const cached = await readCache(cacheKey)
    if (cached) {
      return NextResponse.json({
        raw:   { avg: cached.raw_avg,   count: cached.raw_count   },
        psa8:  { avg: cached.psa8_avg,  count: cached.psa8_count  },
        psa9:  { avg: cached.psa9_avg,  count: cached.psa9_count  },
        psa10: { avg: cached.psa10_avg, count: cached.psa10_count },
        _cached: true,
      })
    }
  } catch (err) {
    console.warn('[eBay cache] read failed', err)
  }

  // ── Fetch prices ─────────────────────────────────────────────────────────
  try {
    const token      = await getAppToken()
    const queryTiers = buildQueryTiers({ year, brand, set, cardNumber, parallel, playerName })

    const rawPrices   = await fetchWithFallback('raw ungraded', queryTiers, token); await delay(CALL_DELAY_MS)
    const psa8Prices  = await fetchWithFallback('PSA 8',        queryTiers, token); await delay(CALL_DELAY_MS)
    const psa9Prices  = await fetchWithFallback('PSA 9',        queryTiers, token); await delay(CALL_DELAY_MS)
    const psa10Prices = await fetchWithFallback('PSA 10',       queryTiers, token)

    const result = {
      raw:   { avg: cleanAverage(rawPrices),   count: rawPrices.length   },
      psa8:  { avg: cleanAverage(psa8Prices),  count: psa8Prices.length  },
      psa9:  { avg: cleanAverage(psa9Prices),  count: psa9Prices.length  },
      psa10: { avg: cleanAverage(psa10Prices), count: psa10Prices.length },
    }

    writeCache(cacheKey, {
      raw_avg:   result.raw.avg,   raw_count:   result.raw.count,
      psa8_avg:  result.psa8.avg,  psa8_count:  result.psa8.count,
      psa9_avg:  result.psa9.avg,  psa9_count:  result.psa9.count,
      psa10_avg: result.psa10.avg, psa10_count: result.psa10.count,
    }).catch(err => console.warn('[eBay cache] write failed', err))

    return NextResponse.json(result)
  } catch (err) {
    const msg = err instanceof Error ? err.message : 'Failed to fetch eBay data'
    console.error('[eBay API]', msg)
    return NextResponse.json({ error: msg }, { status: 502 })
  }
}
