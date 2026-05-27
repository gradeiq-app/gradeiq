/**
 * GET /api/cards/search?q=
 * Player autocomplete for the guided card selector (Step 1).
 *
 * Uses the players.search_vector tsvector (full-text) combined with an ILIKE
 * trigram fallback so short partial queries ("Maho") still match.
 *
 * Query params:
 *   q      — search query (min 2 chars)
 *   sport  — optional sport slug filter
 *   limit  — max results (default 12, max 25)
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

const DEFAULT_LIMIT = 12
const MAX_LIMIT     = 25

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const q     = (searchParams.get('q') ?? '').trim()
  const sport = searchParams.get('sport')
  const limit = Math.min(
    parseInt(searchParams.get('limit') ?? String(DEFAULT_LIMIT)) || DEFAULT_LIMIT,
    MAX_LIMIT,
  )

  if (q.length < 2) {
    return NextResponse.json({ players: [] })
  }

  const supabase = createClient(url, key)

  // Try tsvector full-text search first (handles multi-word queries naturally).
  // Build a prefix tsquery so "Maho" matches "Mahomes".
  const tsQuery = q
    .split(/\s+/)
    .map(t => t.replace(/[^\p{L}\p{N}]/gu, ''))
    .filter(Boolean)
    .map(t => `${t}:*`)
    .join(' & ')

  let query = supabase
    .from('players')
    .select('id, name, position, sport:sports(id, name, slug)')
    .order('name')
    .limit(limit)

  if (tsQuery) {
    query = query.textSearch('search_vector', tsQuery, { config: 'english' })
  } else {
    query = query.ilike('name', `%${q}%`)
  }

  if (sport) query = query.eq('sports.slug', sport)

  let { data, error } = await query

  // Fallback: tsvector match returned nothing — try ILIKE for autocomplete-style
  // partial matches ("Tro" → "Trout") that don't survive prefix tsquery.
  if (!error && (!data || data.length === 0)) {
    let fallback = supabase
      .from('players')
      .select('id, name, position, sport:sports(id, name, slug)')
      .ilike('name', `%${q}%`)
      .order('name')
      .limit(limit)
    if (sport) fallback = fallback.eq('sports.slug', sport)
    const r = await fallback
    data  = r.data
    error = r.error
  }

  if (error) {
    console.error('[cards/search] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { players: data ?? [] },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
