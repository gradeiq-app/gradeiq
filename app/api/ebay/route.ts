import { NextRequest, NextResponse } from 'next/server'
import { getServiceClient } from '@/lib/supabase-admin'

const EBAY_BASE_URL = 'https://svcs.ebay.com/services/search/FindingService/v1'
const CACHE_TTL_MS  = 24 * 60 * 60 * 1000   // 24 hours

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

// ─── Single eBay fetch ────────────────────────────────────────────────────────
async function fetchSoldPrices(keywords: string, appId: string): Promise<number[]> {
  const ninetyDaysAgo = new Date()
  ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90)

  const params = new URLSearchParams({
    'OPERATION-NAME':               'findCompletedItems',
    'SERVICE-VERSION':              '1.0.0',
    'SECURITY-APPNAME':             appId,
    'RESPONSE-DATA-FORMAT':         'JSON',
    'REST-PAYLOAD':                 '',
    keywords,
    'itemFilter(0).name':           'SoldItemsOnly',
    'itemFilter(0).value':          'true',
    'itemFilter(1).name':           'EndTimeFrom',
    'itemFilter(1).value':          ninetyDaysAgo.toISOString(),
    'paginationInput.entriesPerPage': '100',
    sortOrder:                      'EndTimeSoonest',
  })

  const res  = await fetch(`${EBAY_BASE_URL}?${params}`, {
    next: { revalidate: 3600 },
  })
  const data = await res.json()

  if (!res.ok) {
    console.error('[eBay] HTTP error', res.status, JSON.stringify(data))
    throw new Error(`eBay API HTTP error: ${res.status}`)
  }

  // eBay Finding API returns HTTP 200 even on auth/key errors — check ack
  const ack = data?.findCompletedItemsResponse?.[0]?.ack?.[0]
  if (ack === 'Failure') {
    const msg     = data?.findCompletedItemsResponse?.[0]?.errorMessage?.[0]?.error?.[0]?.message?.[0]  ?? 'Unknown eBay error'
    const errorId = data?.findCompletedItemsResponse?.[0]?.errorMessage?.[0]?.error?.[0]?.errorId?.[0] ?? ''
    console.error('[eBay] API failure', errorId, msg)
    throw new Error(`eBay error ${errorId}: ${msg}`)
  }

  const items: unknown[] =
    data?.findCompletedItemsResponse?.[0]?.searchResult?.[0]?.item ?? []

  return (items as Record<string, unknown>[])
    .map(item => {
      const raw = (item.sellingStatus as Record<string, unknown>[])?.[0]
        ?.currentPrice as Record<string, string>[] | undefined
      return parseFloat(raw?.[0]?.__value__ ?? '0')
    })
    .filter(p => p > 0)
}

// ─── Mock data (dev / no key) ─────────────────────────────────────────────────
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
    .map(s => s.toLowerCase().trim())
    .join('|')
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

  const appId = process.env.EBAY_API_KEY

  if (!appId) {
    if (process.env.NODE_ENV === 'development') {
      return NextResponse.json(mockData())
    }
    return NextResponse.json({ error: 'eBay API key not configured' }, { status: 500 })
  }

  // ── Cache check ────────────────────────────────────────────────────────────
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
    // Cache miss or DB error — fall through to eBay
    console.warn('[eBay cache] read failed', err)
  }

  // ── eBay fetch ─────────────────────────────────────────────────────────────
  // Include the parallel keyword in the base query so searches are variant-specific
  const base  = [year, brand, set, cardNumber, parallel, playerName].filter(Boolean).join(' ')
  const delay = (ms: number) => new Promise(r => setTimeout(r, ms))

  try {
    // Sequential calls with stagger to avoid eBay's burst rate limiter
    const rawPrices   = await fetchSoldPrices(`${base} raw ungraded`, appId); await delay(250)
    const psa8Prices  = await fetchSoldPrices(`${base} PSA 8`,        appId); await delay(250)
    const psa9Prices  = await fetchSoldPrices(`${base} PSA 9`,        appId); await delay(250)
    const psa10Prices = await fetchSoldPrices(`${base} PSA 10`,       appId)

    const result = {
      raw:   { avg: cleanAverage(rawPrices),   count: rawPrices.length   },
      psa8:  { avg: cleanAverage(psa8Prices),  count: psa8Prices.length  },
      psa9:  { avg: cleanAverage(psa9Prices),  count: psa9Prices.length  },
      psa10: { avg: cleanAverage(psa10Prices), count: psa10Prices.length },
    }

    // ── Cache write (non-blocking) ─────────────────────────────────────────
    writeCache(cacheKey, {
      raw_avg:    result.raw.avg,   raw_count:   result.raw.count,
      psa8_avg:   result.psa8.avg,  psa8_count:  result.psa8.count,
      psa9_avg:   result.psa9.avg,  psa9_count:  result.psa9.count,
      psa10_avg:  result.psa10.avg, psa10_count: result.psa10.count,
    }).catch(err => console.warn('[eBay cache] write failed', err))

    return NextResponse.json(result)
  } catch (err) {
    const msg = err instanceof Error ? err.message : 'Failed to fetch eBay data'
    console.error('[eBay API]', msg)
    return NextResponse.json({ error: msg }, { status: 502 })
  }
}
