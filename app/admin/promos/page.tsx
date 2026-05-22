'use client'

import { useEffect, useState } from 'react'

interface PromoCode {
  id: string
  code: string
  description: string | null
  extra_lookups: number | null
  grants_plan: 'pro' | 'dealer' | null
  grants_plan_days: number | null
  max_uses: number | null
  used_count: number
  active: boolean
  expires_at: string | null
  created_at: string
}

const EMPTY_FORM = {
  code: '', description: '',
  type: 'lookups' as 'lookups' | 'plan',
  extra_lookups: '10',
  grants_plan: 'pro' as 'pro' | 'dealer',
  grants_plan_days: '',
  max_uses: '',
  expires_at: '',
}

export default function PromosPage() {
  const [promos, setPromos] = useState<PromoCode[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [showForm, setShowForm] = useState(false)
  const [form, setForm] = useState(EMPTY_FORM)
  const [saving, setSaving] = useState(false)
  const [formError, setFormError] = useState('')

  async function loadPromos() {
    setLoading(true)
    const res = await fetch('/api/admin/promos')
    const data = await res.json()
    if (data.error) setError(data.error)
    else setPromos(data)
    setLoading(false)
  }

  useEffect(() => { loadPromos() }, [])

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    setFormError('')

    const body: Record<string, unknown> = {
      code: form.code,
      description: form.description || null,
      max_uses: form.max_uses ? Number(form.max_uses) : null,
      expires_at: form.expires_at || null,
    }
    if (form.type === 'lookups') {
      body.extra_lookups = Number(form.extra_lookups)
    } else {
      body.grants_plan = form.grants_plan
      body.grants_plan_days = form.grants_plan_days ? Number(form.grants_plan_days) : null
    }

    const res = await fetch('/api/admin/promos', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) })
    const data = await res.json()

    if (data.error) { setFormError(data.error); setSaving(false); return }
    setForm(EMPTY_FORM)
    setShowForm(false)
    setSaving(false)
    loadPromos()
  }

  async function toggleActive(id: string, current: boolean) {
    await fetch(`/api/admin/promos/${id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ active: !current }),
    })
    loadPromos()
  }

  async function handleDelete(id: string, code: string) {
    if (!confirm(`Delete code "${code}"? This cannot be undone.`)) return
    await fetch(`/api/admin/promos/${id}`, { method: 'DELETE' })
    loadPromos()
  }

  if (loading) return <div className="text-muted text-sm animate-pulse">Loading promo codes…</div>
  if (error) return <div className="text-red-400 text-sm">{error}</div>

  return (
    <div className="flex flex-col gap-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-heading text-3xl text-white">Promo Codes</h1>
          <p className="mt-1 text-sm text-muted">Create and manage demo/discount codes.</p>
        </div>
        <button onClick={() => setShowForm(v => !v)} className="btn-gold px-4 py-2 text-sm">
          {showForm ? 'Cancel' : '+ New Code'}
        </button>
      </div>

      {/* Create form */}
      {showForm && (
        <form onSubmit={handleCreate} className="rounded-xl border border-gold/20 bg-gold-muted p-6 flex flex-col gap-4">
          <h2 className="font-semibold text-white">New Promo Code</h2>
          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <label className="mb-1 block text-xs text-muted">Code *</label>
              <input value={form.code} onChange={e => setForm(f => ({ ...f, code: e.target.value.toUpperCase() }))}
                placeholder="SUMMER25" required
                className="w-full rounded-lg border border-border bg-background px-3 py-2 text-sm uppercase tracking-widest text-white placeholder-muted/40 outline-none focus:border-gold/50" />
            </div>
            <div>
              <label className="mb-1 block text-xs text-muted">Internal Description</label>
              <input value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))}
                placeholder="Trade show giveaway Q3"
                className="w-full rounded-lg border border-border bg-background px-3 py-2 text-sm text-white placeholder-muted/40 outline-none focus:border-gold/50" />
            </div>
          </div>

          {/* Type selector */}
          <div>
            <label className="mb-1 block text-xs text-muted">What does it grant?</label>
            <div className="flex gap-2">
              {(['lookups', 'plan'] as const).map(t => (
                <button type="button" key={t} onClick={() => setForm(f => ({ ...f, type: t }))}
                  className={`rounded-lg border px-4 py-2 text-sm font-medium transition-colors ${form.type === t ? 'border-gold/60 bg-gold/10 text-gold' : 'border-border bg-surface text-muted hover:text-white'}`}>
                  {t === 'lookups' ? 'Bonus Lookups' : 'Plan Access'}
                </button>
              ))}
            </div>
          </div>

          {form.type === 'lookups' ? (
            <div>
              <label className="mb-1 block text-xs text-muted">Number of bonus lookups *</label>
              <input type="number" min="1" value={form.extra_lookups} onChange={e => setForm(f => ({ ...f, extra_lookups: e.target.value }))}
                className="w-32 rounded-lg border border-border bg-background px-3 py-2 text-sm text-white outline-none focus:border-gold/50" />
            </div>
          ) : (
            <div className="flex gap-4">
              <div>
                <label className="mb-1 block text-xs text-muted">Plan *</label>
                <select value={form.grants_plan} onChange={e => setForm(f => ({ ...f, grants_plan: e.target.value as 'pro' | 'dealer' }))}
                  className="rounded-lg border border-border bg-background px-3 py-2 text-sm text-white outline-none focus:border-gold/50">
                  <option value="pro">Pro</option>
                  <option value="dealer">Dealer</option>
                </select>
              </div>
              <div>
                <label className="mb-1 block text-xs text-muted">Duration (days — blank = permanent)</label>
                <input type="number" min="1" value={form.grants_plan_days} onChange={e => setForm(f => ({ ...f, grants_plan_days: e.target.value }))}
                  placeholder="7"
                  className="w-32 rounded-lg border border-border bg-background px-3 py-2 text-sm text-white placeholder-muted/40 outline-none focus:border-gold/50" />
              </div>
            </div>
          )}

          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <label className="mb-1 block text-xs text-muted">Max uses (blank = unlimited)</label>
              <input type="number" min="1" value={form.max_uses} onChange={e => setForm(f => ({ ...f, max_uses: e.target.value }))}
                placeholder="∞"
                className="w-full rounded-lg border border-border bg-background px-3 py-2 text-sm text-white placeholder-muted/40 outline-none focus:border-gold/50" />
            </div>
            <div>
              <label className="mb-1 block text-xs text-muted">Code expires on (optional)</label>
              <input type="date" value={form.expires_at} onChange={e => setForm(f => ({ ...f, expires_at: e.target.value }))}
                className="w-full rounded-lg border border-border bg-background px-3 py-2 text-sm text-white outline-none focus:border-gold/50" />
            </div>
          </div>

          {formError && <p className="text-sm text-red-400">{formError}</p>}

          <div className="flex gap-3">
            <button type="submit" disabled={saving} className="btn-gold px-6 py-2 text-sm disabled:opacity-50">
              {saving ? 'Creating…' : 'Create Code'}
            </button>
            <button type="button" onClick={() => { setShowForm(false); setFormError('') }} className="btn-outline px-6 py-2 text-sm">
              Cancel
            </button>
          </div>
        </form>
      )}

      {/* Codes table */}
      {promos.length === 0 ? (
        <p className="text-sm text-muted/60">No promo codes yet. Create one above.</p>
      ) : (
        <div className="rounded-xl border border-border bg-surface overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-border text-xs text-muted">
                <th className="px-4 py-3 text-left font-medium">Code</th>
                <th className="px-4 py-3 text-left font-medium">Description</th>
                <th className="px-4 py-3 text-left font-medium">Grants</th>
                <th className="px-4 py-3 text-right font-medium">Uses</th>
                <th className="px-4 py-3 text-center font-medium">Expires</th>
                <th className="px-4 py-3 text-center font-medium">Status</th>
                <th className="px-4 py-3 text-center font-medium">Actions</th>
              </tr>
            </thead>
            <tbody>
              {promos.map((p, i) => (
                <tr key={p.id} className={i > 0 ? 'border-t border-border/50' : ''}>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-2">
                      <span className="font-mono font-semibold text-gold">{p.code}</span>
                      <button onClick={() => navigator.clipboard.writeText(p.code)}
                        className="text-muted/40 hover:text-muted text-xs transition-colors" title="Copy">⧉</button>
                    </div>
                  </td>
                  <td className="px-4 py-3 text-muted/70 text-xs max-w-[160px] truncate">{p.description ?? '—'}</td>
                  <td className="px-4 py-3 text-muted">
                    {p.grants_plan
                      ? <span className="rounded-full bg-gold/10 px-2 py-0.5 text-xs text-gold">{p.grants_plan}{p.grants_plan_days ? ` · ${p.grants_plan_days}d` : ' · ∞'}</span>
                      : p.extra_lookups
                      ? <span className="rounded-full bg-blue-500/10 px-2 py-0.5 text-xs text-blue-400">+{p.extra_lookups} lookups</span>
                      : '—'}
                  </td>
                  <td className="px-4 py-3 text-right text-white">
                    {p.used_count}{p.max_uses != null ? ` / ${p.max_uses}` : ''}
                  </td>
                  <td className="px-4 py-3 text-center text-xs text-muted">
                    {p.expires_at ? new Date(p.expires_at).toLocaleDateString() : '—'}
                  </td>
                  <td className="px-4 py-3 text-center">
                    <span className={`rounded-full px-2 py-0.5 text-xs font-semibold ${p.active ? 'bg-emerald-500/20 text-emerald-400' : 'bg-border text-muted'}`}>
                      {p.active ? 'Active' : 'Inactive'}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex items-center justify-center gap-2">
                      <button onClick={() => toggleActive(p.id, p.active)}
                        className="text-xs text-muted hover:text-white transition-colors">
                        {p.active ? 'Deactivate' : 'Activate'}
                      </button>
                      <span className="text-border">·</span>
                      <button onClick={() => handleDelete(p.id, p.code)}
                        className="text-xs text-muted hover:text-red-400 transition-colors">
                        Delete
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
