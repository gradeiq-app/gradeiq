/**
 * GET /api/cards/price?parallelId=
 *   or  /api/cards/price?year=&brand=&set=&playerName=&parallel=&cardNumber=
 *
 * Looks up the cached market price for a parallel (Step 5 tiles + Step 6
 * cost-basis pre-fill). Reads from the existing price_cache table populated
 * by /api/ebay — does NOT fire a live eBay query, so this is cheap to call
 * on hover/render without burning rate limits.
 *
 * Returns:
 *   { cached: true,  raw_avg, raw_count, psa10_avg, psa10_count }
 *   { cached: false }   // no entry in cache; client should fall back gracefully
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'
import { getServiceClient } from '@/lib/supabase-admin'

export const dynamic = 'force-dynamic'

function makeCacheKey(
  year: string, brand: string, set: string,
  cardNumber: string, parallel: string, playerName: string,
): string {
  // Must match the format used by /api/ebay route.
  return [year, brand, set, cardNumber, parallel, playerName]
    .map(s => s.toLowerCase().trim()).join('|')
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)

  let year       = searchParams.get('year')       ?? ''
  let brand      = searchParams.get('brand')      ?? ''
  let setName    = searchParams.get('set')        ?? ''
  let cardNumber = searchParams.get('cardNumber') ?? ''
  let parallel   = searchParams.get('parallel')   ?? ''
  let playerName = searchParams.get('playerName') ?? ''

  const parallelId = searchParams.get('parallelId')

  // ── Resolve parallelId → param bundle if provided ──────────────────────
  if (parallelId) {
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL
    const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
    if (!url || !key) {
      return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
    }
    const supabase = createClient(url, key)

    const { data: p, error } = await supabase
      .from('parallels')
      .select(`
        ebay_kw,
        card:cards!inner(
          card_number,
          player:players(name),
          set:sets!inner(
            year, name,
            manufacturer:manufacturers(name)
          )
        )
      `)
      .eq('id', parallelId)
      .maybeSingle()

    if (error) {
      console.error('[cards/price] Supabase error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }
    if (!p) {
      return NextResponse.json({ cached: false })
    }

    const card = p.card as unknown as {
      card_number: string | null
      player:      { name: string } | null
      set:         {
        year: number; name: string
        manufacturer: { name: string } | null
      } | null
    } | null

    parallel   = p.ebay_kw ?? ''
    cardNumber = card?.card_number ?? ''
    playerName = card?.player?.name ?? ''
    setName    = card?.set?.name ?? ''
    brand      = card?.set?.manufacturer?.name ?? ''
    year       = card?.set?.year ? String(card.set.year) : ''
  }

  if (!year || !brand || !playerName) {
    return NextResponse.json({ cached: false })
  }

  const sb = getServiceClient()
  if (!sb) {
    return NextResponse.json({ cached: false })
  }

  const cacheKey = makeCacheKey(year, brand, setName, cardNumber, parallel, playerName)
  const { data, error } = await sb
    .from('price_cache')
    .select('raw_avg, raw_count, psa10_avg, psa10_count')
    .eq('cache_key', cacheKey)
    .gt('expires_at', new Date().toISOString())
    .maybeSingle()

  if (error || !data) {
    return NextResponse.json({ cached: false })
  }

  return NextResponse.json(
    {
      cached:      true,
      raw_avg:     Number(data.raw_avg) || 0,
      raw_count:   data.raw_count ?? 0,
      psa10_avg:   Number(data.psa10_avg) || 0,
      psa10_count: data.psa10_count ?? 0,
    },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
