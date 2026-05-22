import { NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function GET() {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = getServiceClient()
  if (!db) return NextResponse.json({ error: 'Service role key not configured' }, { status: 503 })

  const [profiles, lookups, promos] = await Promise.all([
    db.from('profiles').select('plan, lookup_count, created_at, is_admin'),
    db.from('lookups').select('created_at').gte('created_at', new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString()),
    db.from('promo_codes').select('code, description, used_count, max_uses, grants_plan, extra_lookups, active').order('used_count', { ascending: false }).limit(10),
  ])

  const allProfiles = profiles.data ?? []
  const planCounts = allProfiles.reduce<Record<string, number>>((acc, p) => {
    acc[p.plan] = (acc[p.plan] ?? 0) + 1
    return acc
  }, {})

  return NextResponse.json({
    totalUsers: allProfiles.filter(p => !p.is_admin).length,
    planCounts: { free: planCounts.free ?? 0, pro: planCounts.pro ?? 0, dealer: planCounts.dealer ?? 0 },
    lookupsThisMonth: lookups.data?.length ?? 0,
    topPromos: promos.data ?? [],
  })
}
