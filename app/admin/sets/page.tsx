'use client'

import { useState, useEffect, useMemo } from 'react'

interface Parallel { label: string; ebay_kw: string }

interface CardSet {
  id:        string
  sport:     string
  year:      number
  brand:     string
  set_name:  string
  parallels: Parallel[]
}

const SPORTS = ['baseball', 'basketball', 'football', 'hockey']
const SPORT_EMOJI: Record<string, string> = {
  baseball: '⚾', basketball: '🏀', football: '🏈', hockey: '🏒',
}

const CURRENT_YEAR = new Date().getFullYear()
const YEARS = Array.from({ length: CURRENT_YEAR - 2017 }, (_, i) => CURRENT_YEAR - i)

export default function AdminSetsPage() {
  const [sets, setSets]           = useState<CardSet[]>([])
  const [loading, setLoading]     = useState(true)
  const [sportFilter, setSportFilter] = useState('baseball')
  const [yearFilter, setYearFilter]   = useState(String(CURRENT_YEAR))

  // New-set form
  const [showForm, setShowForm] = useState(false)
  const [saving, setSaving]     = useState(false)
  const [formError, setFormError] = useState('')
  const [newSet, setNewSet]     = useState({
    sport: 'baseball', year: String(CURRENT_YEAR), brand: '', set_name: '',
  })
  // Parallels editor (for new set and edit mode)
  const [parallelRows, setParallelRows] = useState<Parallel[]>([{ label: 'Base', ebay_kw: '' }])

  // Edit mode
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editParallels, setEditParallels] = useState<Parallel[]>([])

  useEffect(() => { fetchSets() }, [sportFilter, yearFilter])

  async function fetchSets() {
    setLoading(true)
    const r = await fetch(`/api/admin/sets?sport=${sportFilter}&year=${yearFilter}`)
    const d = await r.json()
    setSets(d.sets ?? [])
    setLoading(false)
  }

  // ── Create new set ────────────────────────────────────────────────────────
  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true); setFormError('')
    const r = await fetch('/api/admin/sets', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...newSet, year: parseInt(newSet.year), parallels: parallelRows }),
    })
    const d = await r.json()
    if (!r.ok) { setFormError(d.error ?? 'Failed'); setSaving(false); return }
    setShowForm(false)
    setNewSet({ sport: sportFilter, year: String(CURRENT_YEAR), brand: '', set_name: '' })
    setParallelRows([{ label: 'Base', ebay_kw: '' }])
    fetchSets()
    setSaving(false)
  }

  // ── Save edited parallels ─────────────────────────────────────────────────
  async function handleSaveParallels(id: string) {
    setSaving(true)
    const r = await fetch(`/api/admin/sets/${id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ parallels: editParallels }),
    })
    if (r.ok) { setEditingId(null); fetchSets() }
    setSaving(false)
  }

  // ── Delete set ────────────────────────────────────────────────────────────
  async function handleDelete(id: string, name: string) {
    if (!confirm(`Delete "${name}"? This cannot be undone.`)) return
    await fetch(`/api/admin/sets/${id}`, { method: 'DELETE' })
    fetchSets()
  }

  const labelCls = 'block mb-1 text-xs font-medium uppercase tracking-wider text-muted'
  const inputCls = 'input-base text-sm'

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">

      {/* Header */}
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="font-heading text-2xl text-white">Card Sets</h1>
          <p className="mt-1 text-sm text-muted">
            Manage the set + parallel database used by the lookup form.
          </p>
        </div>
        <button onClick={() => setShowForm(v => !v)} className="btn-gold px-4 py-2 text-sm">
          {showForm ? 'Cancel' : '+ Add Set'}
        </button>
      </div>

      {/* Add Set Form */}
      {showForm && (
        <form onSubmit={handleCreate} className="card mb-6 flex flex-col gap-4">
          <h2 className="font-semibold text-white">New Card Set</h2>

          <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
            <div>
              <label className={labelCls}>Sport *</label>
              <select value={newSet.sport} onChange={e => setNewSet(p => ({ ...p, sport: e.target.value }))} className={inputCls}>
                {SPORTS.map(s => <option key={s} value={s}>{SPORT_EMOJI[s]} {s}</option>)}
              </select>
            </div>
            <div>
              <label className={labelCls}>Year *</label>
              <select value={newSet.year} onChange={e => setNewSet(p => ({ ...p, year: e.target.value }))} className={inputCls}>
                {YEARS.map(y => <option key={y} value={y}>{y}</option>)}
              </select>
            </div>
            <div>
              <label className={labelCls}>Brand *</label>
              <input value={newSet.brand} onChange={e => setNewSet(p => ({ ...p, brand: e.target.value }))} placeholder="e.g. Panini" className={inputCls} required />
            </div>
            <div>
              <label className={labelCls}>Set Name *</label>
              <input value={newSet.set_name} onChange={e => setNewSet(p => ({ ...p, set_name: e.target.value }))} placeholder="e.g. Prizm" className={inputCls} required />
            </div>
          </div>

          <div>
            <div className="mb-2 flex items-center justify-between">
              <label className={labelCls}>Parallels *</label>
              <button type="button" onClick={() => setParallelRows(p => [...p, { label: '', ebay_kw: '' }])}
                className="text-xs text-gold hover:underline">+ Add parallel</button>
            </div>
            <div className="flex flex-col gap-2">
              {parallelRows.map((p, i) => (
                <div key={i} className="flex items-center gap-2">
                  <input value={p.label} placeholder="Display label  (e.g. Gold Refractor /50)"
                    onChange={e => setParallelRows(rows => rows.map((r, j) => j === i ? { ...r, label: e.target.value } : r))}
                    className="input-base flex-1 text-sm" />
                  <input value={p.ebay_kw} placeholder="eBay keyword  (e.g. Gold Refractor)"
                    onChange={e => setParallelRows(rows => rows.map((r, j) => j === i ? { ...r, ebay_kw: e.target.value } : r))}
                    className="input-base flex-1 text-sm" />
                  <button type="button" onClick={() => setParallelRows(rows => rows.filter((_, j) => j !== i))}
                    className="text-red-400 hover:text-red-300 text-sm px-1">✕</button>
                </div>
              ))}
            </div>
            <p className="mt-1.5 text-xs text-muted">Label = what the user sees. eBay keyword = appended to the search (blank for Base).</p>
          </div>

          {formError && <p className="text-sm text-red-400">{formError}</p>}
          <div className="flex gap-3">
            <button type="submit" disabled={saving} className="btn-gold px-6 py-2 text-sm">
              {saving ? 'Saving…' : 'Create Set'}
            </button>
          </div>
        </form>
      )}

      {/* Filters */}
      <div className="mb-4 flex flex-wrap items-center gap-3">
        <div className="flex gap-1">
          {SPORTS.map(s => (
            <button key={s} onClick={() => setSportFilter(s)}
              className={`rounded-lg border px-3 py-1.5 text-sm font-medium transition-colors ${
                sportFilter === s ? 'border-gold bg-gold-muted text-gold' : 'border-border bg-surface text-muted hover:text-white'
              }`}>
              {SPORT_EMOJI[s]} <span className="hidden sm:inline">{s}</span>
            </button>
          ))}
        </div>
        <select value={yearFilter} onChange={e => setYearFilter(e.target.value)}
          className="input-base w-28 text-sm">
          {YEARS.map(y => <option key={y} value={y}>{y}</option>)}
        </select>
        <span className="text-xs text-muted">{sets.length} sets</span>
      </div>

      {/* Sets table */}
      {loading ? (
        <div className="py-16 text-center text-muted text-sm">Loading…</div>
      ) : sets.length === 0 ? (
        <div className="py-16 text-center text-muted text-sm">No sets for this filter. Add one above.</div>
      ) : (
        <div className="flex flex-col gap-3">
          {sets.map(set => (
            <div key={set.id} className="rounded-xl border border-border bg-surface p-4">

              {/* Set header */}
              <div className="flex items-start justify-between gap-4">
                <div>
                  <p className="font-semibold text-white">
                    {set.year} {set.brand} {set.set_name}
                  </p>
                  <p className="text-xs text-muted mt-0.5">
                    {SPORT_EMOJI[set.sport]} {set.sport} · {set.parallels.length} parallels
                  </p>
                </div>
                <div className="flex items-center gap-2 shrink-0">
                  <button
                    onClick={() => { setEditingId(set.id); setEditParallels([...set.parallels]) }}
                    className="rounded-lg border border-border bg-surface-2 px-3 py-1.5 text-xs text-muted hover:text-white transition-colors"
                  >
                    Edit parallels
                  </button>
                  <button onClick={() => handleDelete(set.id, `${set.year} ${set.brand} ${set.set_name}`)}
                    className="rounded-lg border border-red-500/30 px-3 py-1.5 text-xs text-red-400 hover:bg-red-500/10 transition-colors">
                    Delete
                  </button>
                </div>
              </div>

              {/* Parallel chips (read mode) */}
              {editingId !== set.id && (
                <div className="mt-3 flex flex-wrap gap-1.5">
                  {set.parallels.map((p, i) => (
                    <span key={i} className={`rounded-full border px-2.5 py-0.5 text-xs ${
                      p.ebay_kw === '' ? 'border-gold/30 bg-gold-muted text-gold' : 'border-border bg-surface-2 text-muted'
                    }`}>
                      {p.label}
                    </span>
                  ))}
                </div>
              )}

              {/* Parallel editor (edit mode) */}
              {editingId === set.id && (
                <div className="mt-3 flex flex-col gap-2">
                  <div className="flex items-center justify-between mb-1">
                    <p className="text-xs text-muted font-medium uppercase tracking-wider">Edit Parallels</p>
                    <button type="button"
                      onClick={() => setEditParallels(p => [...p, { label: '', ebay_kw: '' }])}
                      className="text-xs text-gold hover:underline">+ Add row</button>
                  </div>
                  {editParallels.map((p, i) => (
                    <div key={i} className="flex items-center gap-2">
                      <input value={p.label} placeholder="Display label"
                        onChange={e => setEditParallels(rows => rows.map((r, j) => j === i ? { ...r, label: e.target.value } : r))}
                        className="input-base flex-1 text-sm py-1.5" />
                      <input value={p.ebay_kw} placeholder="eBay keyword (blank = Base)"
                        onChange={e => setEditParallels(rows => rows.map((r, j) => j === i ? { ...r, ebay_kw: e.target.value } : r))}
                        className="input-base flex-1 text-sm py-1.5" />
                      <button type="button"
                        onClick={() => setEditParallels(rows => rows.filter((_, j) => j !== i))}
                        className="text-red-400 hover:text-red-300 text-sm px-1">✕</button>
                    </div>
                  ))}
                  <div className="flex gap-2 mt-1">
                    <button onClick={() => handleSaveParallels(set.id)} disabled={saving}
                      className="btn-gold px-4 py-1.5 text-xs">
                      {saving ? 'Saving…' : 'Save'}
                    </button>
                    <button onClick={() => setEditingId(null)}
                      className="px-4 py-1.5 text-xs text-muted hover:text-white transition-colors">
                      Cancel
                    </button>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
