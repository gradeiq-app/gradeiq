/**
 * GET /api/cards/sets
 *
 * Two modes:
 *   ?sport=&year=&brand=     — sets from the sets table for the given combo
 *                              (brand is matched against manufacturers.slug,
 *                              falling back to a case-insensitive name match)
 *   ?playerId=&year=         — sets that contain a card for this player, with
 *                              card counts (used by the player-first variant)
 *
 * Sport mode is the primary path for the guided selector since the sets table
 * is well-populated whereas the cards table is sparse.
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'
import { isContaminatedCardCount } from '@/lib/contaminated-signatures'

export const dynamic = 'force-dynamic'

interface SetOut {
  id:           string
  year:         number
  name:         string
  manufacturer: { id: string; name: string; slug: string } | null
  card_count:   number
}

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const sport    = searchParams.get('sport')
  const yearStr  = searchParams.get('year')
  const brand    = searchParams.get('brand')
  const playerId = searchParams.get('playerId')

  if (!yearStr) {
    return NextResponse.json({ error: 'year required' }, { status: 400 })
  }
  const year = parseInt(yearStr)
  if (isNaN(year)) {
    return NextResponse.json({ error: 'year must be numeric' }, { status: 400 })
  }

  const supabase = createClient(url, key)

  // ── Sport mode ───────────────────────────────────────────────────────────
  if (sport) {
    let query = supabase
      .from('sets')
      .select(`
        id, year, name, card_count,
        sport:sports!inner(slug),
        manufacturer:manufacturers!inner(id, name, slug)
      `)
      .eq('sports.slug', sport)
      .eq('year', year)
      .eq('is_active', true)
      .order('name')
      .limit(1000)

    if (brand) {
      // Match either the slug (preferred — stable id) or the name (forgiving)
      query = query.or(`slug.eq.${brand},name.ilike.${brand}`, { foreignTable: 'manufacturers' })
    }

    const { data, error } = await query
    if (error) {
      console.error('[cards/sets] sport mode error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    const sets: SetOut[] = (data ?? [])
      .filter(r => !isContaminatedCardCount(sport, (r.card_count as number | null) ?? 0))
      .map(r => ({
      id:           r.id as string,
      year:         r.year as number,
      name:         r.name as string,
      manufacturer: (r.manufacturer as unknown as SetOut['manufacturer']) ?? null,
      card_count:   (r.card_count as number | null) ?? 0,
    })).sort((a, b) => {
      const ma = a.manufacturer?.name ?? ''
      const mb = b.manufacturer?.name ?? ''
      if (ma !== mb) return ma.localeCompare(mb)
      return a.name.localeCompare(b.name)
    })

    return NextResponse.json(
      { sets },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  }

  // ── Player mode ──────────────────────────────────────────────────────────
  if (!playerId) {
    return NextResponse.json({ error: 'sport or playerId required' }, { status: 400 })
  }

  const { data, error } = await supabase
    .from('cards')
    .select(`
      id,
      set:sets!inner(
        id, year, name,
        manufacturer:manufacturers(id, name, slug)
      )
    `)
    .eq('player_id', playerId)
    .eq('sets.year', year)
    .eq('sets.is_active', true)

  if (error) {
    console.error('[cards/sets] player mode error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  const byId = new Map<string, SetOut>()
  for (const row of data ?? []) {
    const s = row.set as unknown as {
      id: string; year: number; name: string
      manufacturer: SetOut['manufacturer']
    } | null
    if (!s) continue
    const existing = byId.get(s.id)
    if (existing) {
      existing.card_count += 1
    } else {
      byId.set(s.id, {
        id:           s.id,
        year:         s.year,
        name:         s.name,
        manufacturer: s.manufacturer ?? null,
        card_count:   1,
      })
    }
  }

  const sets = Array.from(byId.values()).sort((a, b) => {
    const ma = a.manufacturer?.name ?? ''
    const mb = b.manufacturer?.name ?? ''
    if (ma !== mb) return ma.localeCompare(mb)
    return a.name.localeCompare(b.name)
  })

  return NextResponse.json(
    { sets },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
