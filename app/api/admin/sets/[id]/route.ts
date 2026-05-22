/**
 * Admin API — single card set
 * PATCH  — update parallels (or any field)
 * DELETE — remove set
 */
import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function PATCH(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const { id } = await params
  const body = await request.json()

  const { data, error } = await sb
    .from('card_sets')
    .update(body)
    .eq('id', id)
    .select()
    .single()

  if (error) return NextResponse.json({ error: error.message }, { status: 400 })
  return NextResponse.json({ set: data })
}

export async function DELETE(_request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const { id } = await params
  const { error } = await sb.from('card_sets').delete().eq('id', id)
  if (error) return NextResponse.json({ error: error.message }, { status: 400 })
  return NextResponse.json({ ok: true })
}
