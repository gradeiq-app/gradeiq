/**
 * GET /api/cards/brands?sport=&year=
 * Distinct manufacturers that have at least one set for this sport + year.
 * Drives the Brand pill row in the guided selector.
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

interface Brand { id: string; name: string; slug: string }

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const sport   = searchParams.get('sport')
  const yearStr = searchParams.get('year')

  if (!sport || !yearStr) {
    return NextResponse.json({ error: 'sport and year required' }, { status: 400 })
  }
  const year = parseInt(yearStr)
  if (isNaN(year)) {
    return NextResponse.json({ error: 'year must be numeric' }, { status: 400 })
  }

  const supabase = createClient(url, key)

  const { data, error } = await supabase
    .from('sets')
    .select(`
      manufacturer:manufacturers!inner(id, name, slug),
      sport:sports!inner(slug),
      year
    `)
    .eq('sports.slug', sport)
    .eq('year', year)
    .limit(5000)

  if (error) {
    console.error('[cards/brands] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  const map = new Map<string, Brand>()
  for (const row of data ?? []) {
    const m = row.manufacturer as unknown as Brand | null
    if (m?.id && !map.has(m.id)) map.set(m.id, m)
  }

  const brands = Array.from(map.values()).sort((a, b) => a.name.localeCompare(b.name))

  return NextResponse.json(
    { brands },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
