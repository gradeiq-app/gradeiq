'use client'

import { useEffect, useState } from 'react'

interface VerificationStats {
  total:       number
  last30Days:  number
  verdicts: {
    confirmed:        number
    likelyMatch:      number
    possibleMismatch: number
    mismatch:         number
  }
  topMisidentified: Array<{ name: string; count: number }>
}

interface Stats {
  totalUsers: number
  planCounts: { free: number; pro: number; dealer: number }
  lookupsThisMonth: number
  topPromos: Array<{ code: string; description: string | null; used_count: number; max_uses: number | null; active: boolean; grants_plan: string | null; extra_lookups: number | null }>
  verifications?: VerificationStats
}

export default function DashboardPage() {
  const [stats, setStats] = useState<Stats | null>(null)
  const [error, setError] = useState('')

  useEffect(() => {
    fetch('/api/admin/stats')
      .then(r => r.json())
      .then(d => d.error ? setError(d.error) : setStats(d))
      .catch(() => setError('Failed to load stats'))
  }, [])

  if (error) return (
    <div className="rounded-lg border border-red-500/30 bg-red-500/10 p-6 text-red-400">
      <p className="font-semibold">Could not load stats</p>
      <p className="mt-1 text-sm">{error}</p>
      {error.includes('Service role') && (
        <p className="mt-2 text-xs text-red-400/70">
          Add <code className="rounded bg-red-500/10 px-1">SUPABASE_SERVICE_ROLE_KEY</code> to your Vercel environment variables.
        </p>
      )}
    </div>
  )

  if (!stats) return <div className="text-muted text-sm animate-pulse">Loading stats…</div>

  const paidUsers = stats.planCounts.pro + stats.planCounts.dealer
  const paidPct = stats.totalUsers > 0 ? Math.round((paidUsers / stats.totalUsers) * 100) : 0

  return (
    <div className="flex flex-col gap-8">
      <div>
        <h1 className="font-heading text-3xl text-white">Dashboard</h1>
        <p className="mt-1 text-sm text-muted">Overview of RawIQ usage.</p>
      </div>

      {/* Stat cards */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {[
          { label: 'Total Users',       value: stats.totalUsers,           sub: `${paidPct}% paid` },
          { label: 'Free',              value: stats.planCounts.free,       sub: 'active free tier' },
          { label: 'Pro',               value: stats.planCounts.pro,        sub: '$4.99/mo' },
          { label: 'Dealer',            value: stats.planCounts.dealer,     sub: '$19.99/mo' },
        ].map(({ label, value, sub }) => (
          <div key={label} className="rounded-xl border border-border bg-surface p-5">
            <p className="text-xs font-semibold uppercase tracking-wider text-muted">{label}</p>
            <p className="mt-2 font-heading text-3xl text-white">{value}</p>
            <p className="mt-1 text-xs text-muted/60">{sub}</p>
          </div>
        ))}
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <div className="rounded-xl border border-border bg-surface p-5">
          <p className="text-xs font-semibold uppercase tracking-wider text-muted">Lookups This Month</p>
          <p className="mt-2 font-heading text-3xl text-white">{stats.lookupsThisMonth}</p>
          <p className="mt-1 text-xs text-muted/60">calendar month to date</p>
        </div>
        <div className="rounded-xl border border-gold/20 bg-gold-muted p-5">
          <p className="text-xs font-semibold uppercase tracking-wider text-muted">Conversion Rate</p>
          <p className="mt-2 font-heading text-3xl text-white">{paidPct}%</p>
          <p className="mt-1 text-xs text-muted/60">{paidUsers} of {stats.totalUsers} users paid</p>
        </div>
      </div>

      {/* Verification analytics */}
      {stats.verifications && (
        <div>
          <h2 className="mb-3 text-sm font-semibold uppercase tracking-wider text-muted">Parallel Verifier</h2>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4 mb-4">
            {[
              { label: 'Total Verifications', value: stats.verifications.total,      sub: 'all time' },
              { label: 'Last 30 Days',         value: stats.verifications.last30Days, sub: 'rolling window' },
              { label: 'Confirmed',            value: stats.verifications.verdicts.confirmed + stats.verifications.verdicts.likelyMatch,
                sub: 'CONFIRMED + LIKELY MATCH' },
              { label: 'Mismatches',           value: stats.verifications.verdicts.possibleMismatch + stats.verifications.verdicts.mismatch,
                sub: 'flagged as wrong parallel' },
            ].map(({ label, value, sub }) => (
              <div key={label} className="rounded-xl border border-border bg-surface p-5">
                <p className="text-xs font-semibold uppercase tracking-wider text-muted">{label}</p>
                <p className="mt-2 font-heading text-3xl text-white">{value}</p>
                <p className="mt-1 text-xs text-muted/60">{sub}</p>
              </div>
            ))}
          </div>

          {/* Verdict distribution */}
          {stats.verifications.total > 0 && (() => {
            const t = stats.verifications!.total
            const v = stats.verifications!.verdicts
            const bars = [
              { label: 'Confirmed',         count: v.confirmed,        color: 'bg-emerald-500' },
              { label: 'Likely Match',      count: v.likelyMatch,      color: 'bg-gold' },
              { label: 'Poss. Mismatch',    count: v.possibleMismatch, color: 'bg-orange-500' },
              { label: 'Mismatch',          count: v.mismatch,         color: 'bg-red-500' },
            ]
            return (
              <div className="rounded-xl border border-border bg-surface p-5 mb-4">
                <p className="text-xs font-semibold uppercase tracking-wider text-muted mb-3">Verdict Distribution</p>
                <div className="flex gap-1 h-3 rounded-full overflow-hidden">
                  {bars.map(b => b.count > 0 && (
                    <div key={b.label} className={b.color} style={{ width: `${(b.count / t) * 100}%` }} title={`${b.label}: ${b.count}`} />
                  ))}
                </div>
                <div className="mt-3 flex flex-wrap gap-4 text-xs text-muted">
                  {bars.map(b => (
                    <span key={b.label}>
                      <span className={`inline-block w-2 h-2 rounded-full mr-1 ${b.color}`} />
                      {b.label}: {b.count} ({t > 0 ? Math.round((b.count / t) * 100) : 0}%)
                    </span>
                  ))}
                </div>
              </div>
            )
          })()}

          {/* Top misidentified */}
          {stats.verifications.topMisidentified.length > 0 && (
            <div className="rounded-xl border border-border bg-surface overflow-hidden">
              <div className="border-b border-border px-4 py-3">
                <p className="text-xs font-semibold uppercase tracking-wider text-muted">Most Commonly Misidentified Parallels</p>
              </div>
              <table className="w-full text-sm">
                <tbody>
                  {stats.verifications.topMisidentified.map((item, i) => (
                    <tr key={item.name} className={i > 0 ? 'border-t border-border/50' : ''}>
                      <td className="px-4 py-3 text-white/80">{item.name}</td>
                      <td className="px-4 py-3 text-right font-semibold text-red-400">{item.count}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Top promo codes */}
      {stats.topPromos.length > 0 && (
        <div>
          <h2 className="mb-3 text-sm font-semibold uppercase tracking-wider text-muted">Top Promo Codes</h2>
          <div className="rounded-xl border border-border bg-surface overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-border text-xs text-muted">
                  <th className="px-4 py-3 text-left font-medium">Code</th>
                  <th className="px-4 py-3 text-left font-medium">Type</th>
                  <th className="px-4 py-3 text-left font-medium">Description</th>
                  <th className="px-4 py-3 text-right font-medium">Uses</th>
                  <th className="px-4 py-3 text-center font-medium">Status</th>
                </tr>
              </thead>
              <tbody>
                {stats.topPromos.map((p, i) => (
                  <tr key={p.code} className={i > 0 ? 'border-t border-border/50' : ''}>
                    <td className="px-4 py-3 font-mono font-semibold text-gold">{p.code}</td>
                    <td className="px-4 py-3 text-muted">
                      {p.grants_plan ? `${p.grants_plan} plan` : p.extra_lookups ? `+${p.extra_lookups} lookups` : '—'}
                    </td>
                    <td className="px-4 py-3 text-muted/70 text-xs">{p.description ?? '—'}</td>
                    <td className="px-4 py-3 text-right text-white">
                      {p.used_count}{p.max_uses ? ` / ${p.max_uses}` : ''}
                    </td>
                    <td className="px-4 py-3 text-center">
                      <span className={`rounded-full px-2 py-0.5 text-xs font-semibold ${p.active ? 'bg-emerald-500/20 text-emerald-400' : 'bg-border text-muted'}`}>
                        {p.active ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}
