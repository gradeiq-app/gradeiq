import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin } from '@/lib/supabase-admin'
import { createClient } from '@/lib/supabase-server'

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { id } = await params
  const { deactivate } = await request.json() as { deactivate: boolean }

  const supabase = await createClient()
  const { error } = await supabase.rpc('admin_deactivate_user', {
    p_user_id: id,
    p_deactivate: deactivate,
  })

  if (error) return NextResponse.json({ error: error.message }, { status: 400 })
  return NextResponse.json({ updated: true })
}
