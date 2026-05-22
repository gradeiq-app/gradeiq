/**
 * GET /api/cards
 * Returns all card sets with their parallel definitions.
 *
 * Supabase/PostgREST has a server-side max-rows cap (default 1000) that the
 * JS client's .limit() cannot override.  We paginate in 1000-row pages and
 * concatenate the results so the UI sees the full 2000+ row catalogue.
 */
import { NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

const PAGE_SIZE = 1000

export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const supabase = createClient(url, key)

  // Paginate until Supabase returns a partial page (meaning we've got everything)
  const allSets: Record<string, unknown>[] = []
  let from = 0

  while (true) {
    const { data, error } = await supabase
      .from('card_sets')
      .select('id, sport, year, brand, set_name, parallels')
      .order('year', { ascending: false })
      .range(from, from + PAGE_SIZE - 1)

    if (error) {
      console.error('[cards] Supabase error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    allSets.push(...(data ?? []))

    // If we got fewer rows than a full page, we've reached the end
    if (!data || data.length < PAGE_SIZE) break

    from += PAGE_SIZE
  }

  return NextResponse.json(
    { sets: allSets },
    {
      headers: {
        // no-store: bypass CDN so every request fetches the current full dataset
        'Cache-Control': 'no-store',
      },
    },
  )
}
