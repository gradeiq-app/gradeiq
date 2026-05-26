import { NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function GET() {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = getServiceClient()
  if (!db) return NextResponse.json({ error: 'Service role key not configured' }, { status: 503 })

  const monthStart = new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString()
  const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 3600 * 1000).toISOString()

  const [profiles, lookups, promos, verifications, verificationsMonth] = await Promise.all([
    db.from('profiles').select('plan, lookup_count, created_at, is_admin'),
    db.from('lookups').select('created_at').gte('created_at', monthStart),
    db.from('promo_codes').select('code, description, used_count, max_uses, grants_plan, extra_lookups, active').order('used_count', { ascending: false }).limit(10),
    // All-time verification stats
    db.from('parallel_verifications').select('verdict, parallel_label, set_name, brand, year'),
    // Last 30 days count
    db.from('parallel_verifications').select('id', { count: 'exact', head: true }).gte('created_at', thirtyDaysAgo),
  ])

  const allProfiles = profiles.data ?? []
  const planCounts = allProfiles.reduce<Record<string, number>>((acc, p) => {
    acc[p.plan] = (acc[p.plan] ?? 0) + 1
    return acc
  }, {})

  // Verification analytics
  const allVerifications = (verifications.data ?? []).filter(v => v.verdict !== 'UNAVAILABLE')
  const verdictCounts = allVerifications.reduce<Record<string, number>>((acc, v) => {
    acc[v.verdict] = (acc[v.verdict] ?? 0) + 1
    return acc
  }, {})
  const totalVerified = allVerifications.length

  // Most commonly misidentified parallels (MISMATCH or POSSIBLE MISMATCH)
  const mismatches = allVerifications.filter(
    v => v.verdict === 'MISMATCH' || v.verdict === 'POSSIBLE MISMATCH',
  )
  const mismatchCounts = mismatches.reduce<Record<string, number>>((acc, v) => {
    const key = `${v.year} ${v.brand} ${v.set_name} — ${v.parallel_label}`
    acc[key] = (acc[key] ?? 0) + 1
    return acc
  }, {})
  const topMisidentified = Object.entries(mismatchCounts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 5)
    .map(([name, count]) => ({ name, count }))

  return NextResponse.json({
    totalUsers: allProfiles.filter(p => !p.is_admin).length,
    planCounts: { free: planCounts.free ?? 0, pro: planCounts.pro ?? 0, dealer: planCounts.dealer ?? 0 },
    lookupsThisMonth: lookups.data?.length ?? 0,
    topPromos: promos.data ?? [],
    verifications: {
      total:       totalVerified,
      last30Days:  verificationsMonth.count ?? 0,
      verdicts:    {
        confirmed:        verdictCounts['CONFIRMED']         ?? 0,
        likelyMatch:      verdictCounts['LIKELY MATCH']      ?? 0,
        possibleMismatch: verdictCounts['POSSIBLE MISMATCH'] ?? 0,
        mismatch:         verdictCounts['MISMATCH']          ?? 0,
      },
      topMisidentified,
    },
  })
}
