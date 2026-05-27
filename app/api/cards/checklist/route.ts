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
  // Accept both camelCase and snake_case so callers can use either convention.
  const setId    = searchParams.get('setId')    ?? searchParams.get('set_id')
  const playerId = searchParams.get('playerId') ?? searchParams.get('player_id')
  if (!setId) {
    return NextResponse.json({ error: 'setId/set_id required' }, { status: 400 })
  }

  const supabase = createClient(url, key)

  let query = supabase
    .from('cards')
    .select('id, card_number, name, player:players(id, name)')
    .eq('set_id', setId)

  if (playerId) query = query.eq('player_id', playerId)

  const { data, error } = await query

  if (error) {
    console.error('[cards/checklist] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  // Sort by card number with numeric values first, ascending — matches the
  // PostgreSQL `CASE WHEN card_number ~ '^[0-9]+$' THEN ::integer ELSE 999999 END`
  // pattern. Lexicographic ordering would put '10' before '2', which is wrong
  // for card checklists.
  const cards = (data ?? []).slice().sort((a, b) => {
    const aNum = a.card_number && /^[0-9]+$/.test(a.card_number) ? parseInt(a.card_number, 10) : null
    const bNum = b.card_number && /^[0-9]+$/.test(b.card_number) ? parseInt(b.card_number, 10) : null
    if (aNum !== null && bNum !== null) return aNum - bNum
    if (aNum !== null) return -1
    if (bNum !== null) return 1
    return (a.card_number ?? '').localeCompare(b.card_number ?? '')
  })

  return NextResponse.json(
    { cards },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
