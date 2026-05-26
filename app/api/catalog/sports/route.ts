/**
 * GET /api/catalog/sports
 * Returns all sports with optional league expansion.
 *
 * Query params:
 *   include_leagues=true  — include nested leagues array
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
  const includeLeagues = searchParams.get('include_leagues') === 'true'

  const supabase = createClient(url, key)

  const selectCols = includeLeagues
    ? 'id, name, slug, leagues(id, name, slug)'
    : 'id, name, slug'

  const { data, error } = await supabase
    .from('sports')
    .select(selectCols)
    .order('name')

  if (error) {
    console.error('[catalog/sports] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { sports: data ?? [] },
    { headers: { 'Cache-Control': 'public, s-maxage=3600, stale-while-revalidate=86400' } },
  )
}
