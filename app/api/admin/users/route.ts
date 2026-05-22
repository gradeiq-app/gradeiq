import { NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function GET() {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = getServiceClient()
  if (!db) return NextResponse.json({ error: 'Service role key not configured' }, { status: 503 })

  // Join profiles with auth.users to get email
  const { data, error } = await db
    .from('profiles')
    .select('id, plan, lookup_count, is_admin, deactivated_at, promo_plan, bonus_lookups, created_at:updated_at')
    .eq('is_admin', false)
    .order('updated_at', { ascending: false })
    .limit(200)

  if (error) return NextResponse.json({ error: error.message }, { status: 500 })

  // Fetch emails from auth.users via the admin API
  const { data: authUsers } = await db.auth.admin.listUsers({ perPage: 1000 })
  const emailMap = Object.fromEntries((authUsers?.users ?? []).map(u => [u.id, u.email]))

  const users = (data ?? []).map(p => ({
    ...p,
    email: emailMap[p.id] ?? '—',
  }))

  return NextResponse.json(users)
}
