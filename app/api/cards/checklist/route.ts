/**
 * GET /api/cards/checklist?setId=&playerId=
 * Cards within a set, optionally filtered to a single player (Step 4).
 * Returns a searchable list of card_number + name pairs.
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
  const setId    = searchParams.get('setId')
  const playerId = searchParams.get('playerId')
  if (!setId) {
    return NextResponse.json({ error: 'setId required' }, { status: 400 })
  }

  const supabase = createClient(url, key)

  let query = supabase
    .from('cards')
    .select('id, card_number, name, player:players(id, name)')
    .eq('set_id', setId)
    .order('card_number', { ascending: true })

  if (playerId) query = query.eq('player_id', playerId)

  const { data, error } = await query

  if (error) {
    console.error('[cards/checklist] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { cards: data ?? [] },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
