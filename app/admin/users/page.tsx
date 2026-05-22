'use client'

import { useEffect, useState } from 'react'
import { FREE_TIER_LIMIT } from '@/lib/stripe'

interface UserRow {
  id: string
  email: string
  plan: 'free' | 'pro' | 'dealer'
  lookup_count: number
  bonus_lookups: number
  promo_plan: 'pro' | 'dealer' | null
  deactivated_at: string | null
  created_at: string
}

export default function UsersPage() {
  const [users, setUsers] = useState<UserRow[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [search, setSearch] = useState('')
  const [filter, setFilter] = useState<'all' | 'free' | 'paid' | 'deactivated'>('all')

  async function loadUsers() {
    setLoading(true)
    const res = await fetch('/api/admin/users')
    const data = await res.json()
    if (data.error) setError(data.error)
    else setUsers(data)
    setLoading(false)
  }

  useEffect(() => { loadUsers() }, [])

  async function toggleDeactivate(id: string, currentlyDeactivated: boolean) {
    const action = currentlyDeactivated ? 'Reactivate' : 'Deactivate'
    if (!confirm(`${action} this user?`)) return
    await fetch(`/api/admin/users/${id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ deactivate: !currentlyDeactivated }),
    })
    loadUsers()
  }

  const filtered = users.filter(u => {
    const matchSearch = !search || u.email.toLowerCase().includes(search.toLowerCase())
    const matchFilter =
      filter === 'all' ? true :
      filter === 'free' ? u.plan === 'free' && !u.promo_plan :
      filter === 'paid' ? u.plan !== 'free' || !!u.promo_plan :
      filter === 'deactivated' ? !!u.deactivated_at : true
    return matchSearch && matchFilter
  })

  if (loading) return <div className="text-muted text-sm animate-pulse">Loading users…</div>
  if (error) return (
    <div className="rounded-lg border border-red-500/30 bg-red-500/10 p-6 text-red-400">
      <p>{error}</p>
      {error.includes('Service role') && (
        <p className="mt-2 text-xs">Add <code className="rounded bg-red-500/10 px-1">SUPABASE_SERVICE_ROLE_KEY</code> to Vercel env vars.</p>
      )}
    </div>
  )

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-heading text-3xl text-white">Users</h1>
        <p className="mt-1 text-sm text-muted">{users.length} total users</p>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap items-center gap-3">
        <input
          value={search}
          onChange={e => setSearch(e.target.value)}
          placeholder="Search by email…"
          className="rounded-lg border border-border bg-surface px-3 py-1.5 text-sm text-white placeholder-muted/50 outline-none focus:border-gold/50 w-56"
        />
        <div className="flex gap-1">
          {(['all', 'free', 'paid', 'deactivated'] as const).map(f => (
            <button key={f} onClick={() => setFilter(f)}
              className={`rounded-md px-3 py-1.5 text-xs font-medium transition-colors ${filter === f ? 'bg-gold/10 text-gold border border-gold/30' : 'text-muted hover:text-white border border-transparent'}`}>
              {f.charAt(0).toUpperCase() + f.slice(1)}
            </button>
          ))}
        </div>
        <span className="ml-auto text-xs text-muted">{filtered.length} shown</span>
      </div>

      {/* Table */}
      <div className="rounded-xl border border-border bg-surface overflow-x-auto">
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b border-border text-xs text-muted">
              <th className="px-4 py-3 text-left font-medium">Email</th>
              <th className="px-4 py-3 text-center font-medium">Plan</th>
              <th className="px-4 py-3 text-center font-medium">Lookups</th>
              <th className="px-4 py-3 text-center font-medium">Bonus</th>
              <th className="px-4 py-3 text-center font-medium">Status</th>
              <th className="px-4 py-3 text-center font-medium">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filtered.length === 0 ? (
              <tr><td colSpan={6} className="px-4 py-8 text-center text-sm text-muted">No users found.</td></tr>
            ) : filtered.map((u, i) => {
              const effectivePlan = u.promo_plan ?? u.plan
              const isFree = effectivePlan === 'free'
              return (
                <tr key={u.id} className={`${i > 0 ? 'border-t border-border/50' : ''} ${u.deactivated_at ? 'opacity-50' : ''}`}>
                  <td className="px-4 py-3 text-white font-mono text-xs">{u.email}</td>
                  <td className="px-4 py-3 text-center">
                    {u.promo_plan ? (
                      <span className="rounded-full bg-emerald-500/20 px-2 py-0.5 text-xs text-emerald-400">
                        Demo/{u.promo_plan}
                      </span>
                    ) : (
                      <span className={`rounded-full px-2 py-0.5 text-xs font-semibold ${
                        u.plan === 'dealer' ? 'bg-gold/20 text-gold' :
                        u.plan === 'pro'    ? 'bg-blue-500/20 text-blue-400' :
                        'bg-border text-muted'
                      }`}>{u.plan}</span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-center text-white">
                    {isFree ? (
                      <span className={u.lookup_count >= FREE_TIER_LIMIT + (u.bonus_lookups ?? 0) ? 'text-red-400' : ''}>
                        {u.lookup_count} / {FREE_TIER_LIMIT + (u.bonus_lookups ?? 0)}
                      </span>
                    ) : '∞'}
                  </td>
                  <td className="px-4 py-3 text-center text-muted text-xs">
                    {u.bonus_lookups > 0 ? `+${u.bonus_lookups}` : '—'}
                  </td>
                  <td className="px-4 py-3 text-center">
                    {u.deactivated_at ? (
                      <span className="rounded-full bg-red-500/20 px-2 py-0.5 text-xs text-red-400">Deactivated</span>
                    ) : (
                      <span className="rounded-full bg-emerald-500/20 px-2 py-0.5 text-xs text-emerald-400">Active</span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-center">
                    <button
                      onClick={() => toggleDeactivate(u.id, !!u.deactivated_at)}
                      className={`text-xs transition-colors ${u.deactivated_at ? 'text-emerald-400/70 hover:text-emerald-400' : 'text-muted hover:text-red-400'}`}>
                      {u.deactivated_at ? 'Reactivate' : 'Deactivate'}
                    </button>
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>

      <p className="text-xs text-muted/60">
        Deactivation blocks access to /analyze. Refunds must be processed in the{' '}
        <a href="https://dashboard.stripe.com" target="_blank" rel="noreferrer" className="text-gold/70 hover:text-gold">Stripe Dashboard</a>.
      </p>
    </div>
  )
}
