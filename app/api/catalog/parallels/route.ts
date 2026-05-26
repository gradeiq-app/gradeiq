/**
 * GET /api/catalog/parallels
 * Returns card-level parallels from the relational `parallels` table.
 * Currently returns empty results until cards are seeded.
 * Will replace the JSONB parallel lookup once individual cards are populated.
 *
 * Query params:
 *   card_id  — required: filter parallels for a specific card
 *   set_id   — alternative: return all distinct parallel labels for a set
 *              (joins through cards → parallels)
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
  const card_id = searchParams.get('card_id')
  const set_id  = searchParams.get('set_id')

  if (!card_id && !set_id) {
    return NextResponse.json(
      { error: 'card_id or set_id query param required' },
      { status: 400 },
    )
  }

  const supabase = createClient(url, key)

  if (card_id) {
    // Parallels for a specific card
    const { data, error } = await supabase
      .from('parallels')
      .select('id, label, ebay_kw, print_run')
      .eq('card_id', card_id)
      .order('print_run', { ascending: false, nullsFirst: true })

    if (error) {
      console.error('[catalog/parallels] Supabase error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json(
      { parallels: data ?? [] },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  }

  // set_id: distinct parallel labels across all cards in a set
  // Useful for set-level UI dropdowns before card-level data is seeded
  const { data, error } = await supabase
    .from('parallels')
    .select('id, label, ebay_kw, print_run, card:cards!inner(set_id)')
    .eq('cards.set_id', set_id!)
    .order('label')

  if (error) {
    console.error('[catalog/parallels] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { parallels: data ?? [] },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
