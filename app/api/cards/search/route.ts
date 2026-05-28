/**
 * GET /api/cards/search?q=
 * Player autocomplete for the guided card selector.
 *
 * Uses the players.search_vector tsvector (full-text) combined with an ILIKE
 * trigram fallback so short partial queries ("Maho") still match.
 *
 * Query params:
 *   q      — search query (min 2 chars)
 *   sport  — optional sport slug filter
 *   setId  — optional set UUID; when present, restricts results to players
 *            who have at least one card in that set. Used by Step 5 of the
 *            guided card selector so autocomplete only suggests players
 *            actually in the chosen checklist. Omit for all-players search.
 *   limit  — max results (default 12, max 25)
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

const DEFAULT_LIMIT = 12
const MAX_LIMIT     = 25

const BASE_COLS    = 'id, name, position, sport:sports(id, name, slug)'
const SET_COLS     = `${BASE_COLS}, cards!inner(set_id)`

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const q     = (searchParams.get('q') ?? '').trim()
  const sport = searchParams.get('sport')
  const setId = searchParams.get('setId') ?? searchParams.get('set_id')
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

  // Inner-joining via `cards!inner(set_id)` scopes results to players who
  // have at least one card in the set. PostgREST returns each player once
  // with cards as a nested array — we strip it before responding.
  const baseQuery = () => {
    let q2 = supabase
      .from('players')
      .select(setId ? SET_COLS : BASE_COLS)
      // Exclude combo / triple-duplicate / contamination rows from autocomplete.
      // 2,630 rows whose name contains '/' — verified zero legitimate single
      // players are in this population; all cards remain reachable via the
      // canonical player records. Applied here in baseQuery() so it covers
      // all three return paths (primary tsvector, primary ilike, fallback ilike).
      // See project_triple_duplicate_rows.md.
      .not('name', 'like', '%/%')
      .order('name')
      .limit(limit)
    if (setId) q2 = q2.eq('cards.set_id', setId)
    if (sport) q2 = q2.eq('sports.slug', sport)
    return q2
  }

  let query = baseQuery()
  if (tsQuery) {
    query = query.textSearch('search_vector', tsQuery, { config: 'english' })
  } else {
    query = query.ilike('name', `%${q}%`)
  }

  let { data, error } = await query

  // Fallback: tsvector match returned nothing — try ILIKE for autocomplete-style
  // partial matches ("Tro" → "Trout") that don't survive prefix tsquery.
  if (!error && (!data || data.length === 0)) {
    const r = await baseQuery().ilike('name', `%${q}%`)
    data  = r.data
    error = r.error
  }

  if (error) {
    console.error('[cards/search] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  // Strip the `cards` join field — clients only need player fields.
  const players = (data ?? []).map((row: any) => {
    const { cards: _cards, ...rest } = row
    return rest
  })

  return NextResponse.json(
    { players },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
