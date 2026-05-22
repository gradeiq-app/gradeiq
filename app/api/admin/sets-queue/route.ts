/**
 * Admin API — Sets Queue
 * GET   — list queue items (filterable by status)
 * PATCH — approve or reject an item
 */
import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function GET(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const { searchParams } = new URL(request.url)
  const status = searchParams.get('status') ?? 'pending'

  const { data, error } = await sb
    .from('sets_queue')
    .select('*')
    .eq('status', status)
    .order('created_at', { ascending: false })
    .limit(200)

  if (error) return NextResponse.json({ error: error.message }, { status: 500 })
  return NextResponse.json({ items: data })
}

export async function PATCH(request: NextRequest) {
  const admin = await requireAdmin()
  if (!admin) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const sb = getServiceClient()
  if (!sb) return NextResponse.json({ error: 'Service client unavailable' }, { status: 500 })

  const body = await request.json()
  const { id, action, parallels } = body  // action: 'approve' | 'reject'

  if (!id || !['approve', 'reject'].includes(action)) {
    return NextResponse.json({ error: 'id and action (approve|reject) required' }, { status: 400 })
  }

  // Fetch the queue item
  const { data: item, error: fetchErr } = await sb
    .from('sets_queue')
    .select('*')
    .eq('id', id)
    .single()

  if (fetchErr || !item) return NextResponse.json({ error: 'Item not found' }, { status: 404 })

  if (action === 'approve') {
    // Insert into card_sets using the proposed parallels (or overridden ones)
    const usedParallels = parallels ?? item.proposed_parallels
    const { error: insertErr } = await sb
      .from('card_sets')
      .insert({
        sport:     item.sport,
        year:      item.year,
        brand:     item.brand,
        set_name:  item.set_name,
        parallels: usedParallels,
      })

    if (insertErr) {
      // If already exists, that's fine — still mark as approved
      if (!insertErr.message.includes('duplicate') && !insertErr.message.includes('unique')) {
        return NextResponse.json({ error: insertErr.message }, { status: 400 })
      }
    }
  }

  // Update queue item status
  const { error: updateErr } = await sb
    .from('sets_queue')
    .update({
      status:      action === 'approve' ? 'approved' : 'rejected',
      reviewed_at: new Date().toISOString(),
      reviewed_by: admin.id,
    })
    .eq('id', id)

  if (updateErr) return NextResponse.json({ error: updateErr.message }, { status: 400 })
  return NextResponse.json({ ok: true, action })
}
