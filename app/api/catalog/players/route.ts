/**
 * GET /api/catalog/players
 * Full-text + trigram search over the players table.
 * Powers the player name autocomplete in the card lookup form.
 *
 * Query params:
 *   q      — search query (required, min 2 chars)
 *   sport  — filter by sports.slug
 *   limit  — max results (default 20, max 50)
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

const DEFAULT_LIMIT = 20
const MAX_LIMIT     = 50

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const q          = (searchParams.get('q') ?? '').trim()
  const sport      = searchParams.get('sport')
  const limitParam = parseInt(searchParams.get('limit') ?? String(DEFAULT_LIMIT))
  const limit      = Math.min(isNaN(limitParam) ? DEFAULT_LIMIT : limitParam, MAX_LIMIT)

  if (q.length < 2) {
    return NextResponse.json({ players: [] })
  }

  const supabase = createClient(url, key)

  // Use trigram ILIKE for prefix/partial matching (faster for short queries)
  // Supabase's .textSearch() uses tsvector for full-word matches;
  // .ilike() with pg_trgm index handles "Maho" → "Mahomes" autocomplete
  let query = supabase
    .from('players')
    .select('id, name, position, sport:sports(name, slug)')
    .ilike('name', `%${q}%`)
    .order('name')
    .limit(limit)

  if (sport) query = query.eq('sports.slug', sport)

  const { data, error } = await query

  if (error) {
    console.error('[catalog/players] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { players: data ?? [] },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
