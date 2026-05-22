/**
 * Admin API — Card Sets management
 * GET  — list all sets (filterable by sport/year)
 * POST — create a new set
 */
import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin } from '@/lib/supabase-admin'
import { getServiceClient } from '@/lib/supabase-admin'

export async function GET(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const { searchParams } = new URL(request.url)
  const sport = searchParams.get('sport')
  const year  = searchParams.get('year')

  let query = sb.from('card_sets').select('*').order('year', { ascending: false }).order('brand').order('set_name')
  if (sport) query = query.eq('sport', sport)
  if (year)  query = query.eq('year', parseInt(year))

  const { data, error } = await query
  if (error) return NextResponse.json({ error: error.message }, { status: 500 })
  return NextResponse.json({ sets: data })
}

export async function POST(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const body = await request.json()
  const { sport, year, brand, set_name, parallels } = body

  if (!sport || !year || !brand || !set_name || !Array.isArray(parallels)) {
    return NextResponse.json({ error: 'sport, year, brand, set_name, and parallels are required' }, { status: 400 })
  }

  const { data, error } = await sb
    .from('card_sets')
    .insert({ sport, year: parseInt(year), brand, set_name, parallels })
    .select()
    .single()

  if (error) return NextResponse.json({ error: error.message }, { status: 400 })
  return NextResponse.json({ set: data }, { status: 201 })
}
