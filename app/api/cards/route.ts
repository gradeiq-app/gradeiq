/**
 * GET /api/cards
 * Returns all card sets with their parallel definitions.
 * Cached at the edge for 1 hour — data changes slowly.
 */
import { NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const supabase = createClient(url, key)

  const { data, error } = await supabase
    .from('card_sets')
    .select('id, sport, year, brand, set_name, parallels')
    .order('year', { ascending: false })

  if (error) {
    console.error('[cards] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { sets: data ?? [] },
    {
      headers: {
        // Fresh within 5 min, serve stale for up to 1 h while revalidating
        // Short s-maxage ensures DB changes (new sets) surface within minutes
        'Cache-Control': 'public, s-maxage=300, stale-while-revalidate=3600',
      },
    },
  )
}
