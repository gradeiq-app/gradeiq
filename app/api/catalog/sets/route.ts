/**
 * GET /api/catalog/sets
 * Returns sets from the relational `sets` table with manufacturer + sport joins.
 *
 * Query params:
 *   sport        — filter by sports.slug (e.g. "baseball")
 *   year         — filter by year
 *   manufacturer — filter by manufacturers.slug (e.g. "panini")
 *   name         — ILIKE filter on set name
 *   limit        — max rows returned (default 200, max 1000)
 *   offset       — pagination offset
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

const MAX_LIMIT = 1000
const DEFAULT_LIMIT = 200

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const sport        = searchParams.get('sport')
  const year         = searchParams.get('year')
  const manufacturer = searchParams.get('manufacturer')
  const name         = searchParams.get('name')
  const limitParam   = parseInt(searchParams.get('limit')  ?? String(DEFAULT_LIMIT))
  const offsetParam  = parseInt(searchParams.get('offset') ?? '0')

  const limit  = Math.min(isNaN(limitParam)  ? DEFAULT_LIMIT : limitParam,  MAX_LIMIT)
  const offset = isNaN(offsetParam) ? 0 : offsetParam

  const supabase = createClient(url, key)

  // Join to sports and manufacturers for client convenience
  let query = supabase
    .from('sets')
    .select(`
      id,
      year,
      name,
      is_active,
      created_at,
      sport:sports!inner(id, name, slug),
      manufacturer:manufacturers!inner(id, name, slug)
    `)
    .order('year', { ascending: false })
    .order('name')
    .range(offset, offset + limit - 1)

  if (sport)        query = query.eq('sports.slug', sport)
  if (year)         query = query.eq('year', parseInt(year))
  if (manufacturer) query = query.eq('manufacturers.slug', manufacturer)
  if (name)         query = query.ilike('name', `%${name}%`)

  const { data, error } = await query

  if (error) {
    console.error('[catalog/sets] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json(
    { sets: data ?? [], count: data?.length ?? 0 },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
