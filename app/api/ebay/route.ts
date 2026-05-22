import { NextRequest, NextResponse } from 'next/server'

const EBAY_BASE_URL = 'https://svcs.ebay.com/services/search/FindingService/v1'

// IQR-based outlier removal for cleaner price averages
function cleanAverage(prices: number[]): number {
  if (prices.length === 0) return 0
  if (prices.length === 1) return prices[0]

  const sorted = [...prices].sort((a, b) => a - b)
  const q1 = sorted[Math.floor(sorted.length * 0.25)]
  const q3 = sorted[Math.floor(sorted.length * 0.75)]
  const iqr = q3 - q1

  const filtered = sorted.filter(
    p => p >= q1 - 1.5 * iqr && p <= q3 + 1.5 * iqr,
  )
  const arr = filtered.length > 0 ? filtered : sorted
  return arr.reduce((s, p) => s + p, 0) / arr.length
}

async function fetchSoldPrices(keywords: string, appId: string): Promise<number[]> {
  const ninetyDaysAgo = new Date()
  ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90)

  const params = new URLSearchParams({
    'OPERATION-NAME': 'findCompletedItems',
    'SERVICE-VERSION': '1.0.0',
    'SECURITY-APPNAME': appId,
    'RESPONSE-DATA-FORMAT': 'JSON',
    'REST-PAYLOAD': '',
    keywords,
    'itemFilter(0).name': 'SoldItemsOnly',
    'itemFilter(0).value': 'true',
    'itemFilter(1).name': 'EndTimeFrom',
    'itemFilter(1).value': ninetyDaysAgo.toISOString(),
    'paginationInput.entriesPerPage': '100',
    sortOrder: 'EndTimeSoonest',
  })

  const res = await fetch(`${EBAY_BASE_URL}?${params}`, {
    next: { revalidate: 3600 }, // cache eBay results for 1 hour
  })

  const data = await res.json()

  if (!res.ok) {
    console.error('[eBay] HTTP error', res.status, JSON.stringify(data))
    throw new Error(`eBay API HTTP error: ${res.status}`)
  }

  // eBay Finding API returns HTTP 200 even for auth/key errors — check ack
  const ack = data?.findCompletedItemsResponse?.[0]?.ack?.[0]
  if (ack === 'Failure') {
    const msg = data?.findCompletedItemsResponse?.[0]?.errorMessage?.[0]?.error?.[0]?.message?.[0] ?? 'Unknown eBay error'
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

// Mock data returned in development when no API key is set
function mockData() {
  return {
    raw: { avg: 42, count: 7 },
    psa8: { avg: 88, count: 9 },
    psa9: { avg: 165, count: 14 },
    psa10: { avg: 420, count: 21 },
    _mock: true,
  }
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const playerName = searchParams.get('playerName')?.trim() ?? ''
  const year = searchParams.get('year')?.trim() ?? ''
  const brand = searchParams.get('brand')?.trim() ?? ''
  const set = searchParams.get('set')?.trim() ?? ''
  const cardNumber = searchParams.get('cardNumber')?.trim() ?? ''

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

  const base = [year, brand, set, cardNumber, playerName].filter(Boolean).join(' ')

  try {
    const [rawPrices, psa8Prices, psa9Prices, psa10Prices] = await Promise.all([
      fetchSoldPrices(`${base} raw ungraded`, appId),
      fetchSoldPrices(`${base} PSA 8`, appId),
      fetchSoldPrices(`${base} PSA 9`, appId),
      fetchSoldPrices(`${base} PSA 10`, appId),
    ])

    return NextResponse.json({
      raw: { avg: cleanAverage(rawPrices), count: rawPrices.length },
      psa8: { avg: cleanAverage(psa8Prices), count: psa8Prices.length },
      psa9: { avg: cleanAverage(psa9Prices), count: psa9Prices.length },
      psa10: { avg: cleanAverage(psa10Prices), count: psa10Prices.length },
    })
  } catch (err) {
    const msg = err instanceof Error ? err.message : 'Failed to fetch eBay data'
    console.error('[eBay API]', msg)
    return NextResponse.json({ error: msg }, { status: 502 })
  }
}
