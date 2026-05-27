/**
 * GET /api/cards/years?sport=          — distinct years from sets for a sport
 *   or  /api/cards/years?playerId=     — distinct years a player has cards in
 *
 * Sport mode drives the guided selector (works from the well-populated sets
 * table). Player mode is kept for the deeper player-first variant of the flow.
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const sport    = searchParams.get('sport')
  const playerId = searchParams.get('playerId')

  if (!sport && !playerId) {
    return NextResponse.json({ error: 'sport or playerId required' }, { status: 400 })
  }

  const supabase = createClient(url, key)

  let years: number[] = []

  if (sport) {
    // Sets joined to sports.slug — pull year off every row, de-dupe in JS.
    const { data, error } = await supabase
      .from('sets')
      .select('year, sport:sports!inner(slug)')
      .eq('sports.slug', sport)
      .limit(5000)

    if (error) {
      console.error('[cards/years] sport mode error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }
    years = Array.from(
      new Set((data ?? []).map(r => r.year).filter((y): y is number => typeof y === 'number')),
    )
  } else {
    // Player mode — cards → sets join, scoped to this player.
    const { data, error } = await supabase
      .from('cards')
      .select('set:sets!inner(year)')
      .eq('player_id', playerId!)

    if (error) {
      console.error('[cards/years] player mode error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }
    years = Array.from(
      new Set(
        (data ?? [])
          .map(r => (r.set as unknown as { year?: number } | null)?.year)
          .filter((y): y is number => typeof y === 'number'),
      ),
    )
  }

  years.sort((a, b) => b - a)

  return NextResponse.json(
    { years },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
