'use client'

import { useState, useEffect } from 'react'

interface Parallel { label: string; ebay_kw: string }

interface CardSet {
  id:        string
  sport:     string
  year:      number
  brand:     string
  set_name:  string
  parallels: Parallel[]
}

interface QueueItem {
  id:                string
  sport:             string
  year:              number
  brand:             string
  set_name:          string
  source_name:       string
  source_title:      string
  source_url:        string
  proposed_parallels: Parallel[]
  created_at:        string
}

const SPORTS = ['baseball', 'basketball', 'football', 'hockey']
const SPORT_EMOJI: Record<string, string> = {
  baseball: '⚾', basketball: '🏀', football: '🏈', hockey: '🏒',
}

const CURRENT_YEAR = new Date().getFullYear()
const YEARS = Array.from({ length: CURRENT_YEAR - 2017 }, (_, i) => CURRENT_YEAR - i)

// ─── Main page ───────────────────────────────────────────────────────────────

export default function AdminSetsPage() {
  const [activeTab, setActiveTab] = useState<'sets' | 'queue'>('sets')
  const [pendingCount, setPendingCount] = useState(0)

  // Refresh pending count whenever we switch tabs
  useEffect(() => {
    fetch('/api/admin/sets-queue?status=pending')
      .then(r => r.json())
      .then(d => setPendingCount(d.items?.length ?? 0))
      .catch(() => {})
  }, [activeTab])

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      {/* Header */}
      <div className="mb-6 flex items-start justify-between">
        <div>
          <h1 className="font-heading text-2xl text-white">Card Sets</h1>
          <p className="mt-1 text-sm text-muted">
            Manage the set + parallel database used by the lookup form.
          </p>
        </div>
      </div>

      {/* Tabs */}
      <div className="mb-6 flex gap-1 border-b border-border">
        <TabButton active={activeTab === 'sets'} onClick={() => setActiveTab('sets')}>
          Database
        </TabButton>
        <TabButton active={activeTab === 'queue'} onClick={() => setActiveTab('queue')}>
          Discovery Queue
          {pendingCount > 0 && (
            <span className="ml-2 rounded-full bg-amber-500 px-1.5 py-0.5 text-[10px] font-bold text-black">
              {pendingCount}
            </span>
          )}
        </TabButton>
      </div>

      {activeTab === 'sets'  && <SetsPanel />}
      {activeTab === 'queue' && <QueuePanel onCountChange={setPendingCount} />}
    </div>
  )
}

function TabButton({ active, onClick, children }: {
  active: boolean; onClick: () => void; children: React.ReactNode
}) {
  return (
    <button
      onClick={onClick}
      className={`flex items-center rounded-t-md px-4 py-2 text-sm font-medium transition-colors ${
        active
          ? 'border-b-2 border-gold text-gold'
          : 'text-muted hover:text-white'
      }`}
    >
      {children}
    </button>
  )
}

// ═══════════════════════════════════════════════════════════
// SETS PANEL — existing card sets management
// ═══════════════════════════════════════════════════════════

function SetsPanel() {
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

  async function handleDelete(id: string, name: string) {
    if (!confirm(`Delete "${name}"? This cannot be undone.`)) return
    await fetch(`/api/admin/sets/${id}`, { method: 'DELETE' })
    fetchSets()
  }

  const labelCls = 'block mb-1 text-xs font-medium uppercase tracking-wider text-muted'
  const inputCls = 'input-base text-sm'

  return (
    <div>
      {/* Toolbar */}
      <div className="mb-4 flex items-center justify-between">
        <div className="flex flex-wrap items-center gap-3">
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

      {/* Sets list */}
      {loading ? (
        <div className="py-16 text-center text-muted text-sm">Loading…</div>
      ) : sets.length === 0 ? (
        <div className="py-16 text-center text-muted text-sm">No sets for this filter. Add one above.</div>
      ) : (
        <div className="flex flex-col gap-3">
          {sets.map(set => (
            <div key={set.id} className="rounded-xl border border-border bg-surface p-4">
              <div className="flex items-start justify-between gap-4">
                <div>
                  <p className="font-semibold text-white">{set.year} {set.brand} {set.set_name}</p>
                  <p className="text-xs text-muted mt-0.5">
                    {SPORT_EMOJI[set.sport]} {set.sport} · {set.parallels.length} parallels
                  </p>
                </div>
                <div className="flex items-center gap-2 shrink-0">
                  <button
                    onClick={() => { setEditingId(set.id); setEditParallels([...set.parallels]) }}
                    className="rounded-lg border border-border bg-surface-2 px-3 py-1.5 text-xs text-muted hover:text-white transition-colors">
                    Edit parallels
                  </button>
                  <button onClick={() => handleDelete(set.id, `${set.year} ${set.brand} ${set.set_name}`)}
                    className="rounded-lg border border-red-500/30 px-3 py-1.5 text-xs text-red-400 hover:bg-red-500/10 transition-colors">
                    Delete
                  </button>
                </div>
              </div>

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

// ═══════════════════════════════════════════════════════════
// QUEUE PANEL — discovery review
// ═══════════════════════════════════════════════════════════

function QueuePanel({ onCountChange }: { onCountChange: (n: number) => void }) {
  const [items, setItems]       = useState<QueueItem[]>([])
  const [loading, setLoading]   = useState(true)
  const [running, setRunning]   = useState(false)
  const [runResult, setRunResult] = useState<string | null>(null)
  const [actionId, setActionId] = useState<string | null>(null)
  const [statusFilter, setStatusFilter] = useState<'pending' | 'approved' | 'rejected'>('pending')

  useEffect(() => { loadQueue() }, [statusFilter])

  async function loadQueue() {
    setLoading(true)
    const r = await fetch(`/api/admin/sets-queue?status=${statusFilter}`)
    const d = await r.json()
    const list = d.items ?? []
    setItems(list)
    if (statusFilter === 'pending') onCountChange(list.length)
    setLoading(false)
  }

  async function runDiscovery() {
    setRunning(true); setRunResult(null)
    const r = await fetch('/api/admin/sets-discovery')
    const d = await r.json()
    if (r.ok) {
      setRunResult(`Found ${d.candidates} new candidates from ${d.rss_items} RSS items. Added ${d.inserted} to queue.`)
    } else {
      setRunResult(`Error: ${d.error ?? 'Unknown'}`)
    }
    setRunning(false)
    loadQueue()
  }

  async function handleAction(id: string, action: 'approve' | 'reject') {
    setActionId(id)
    await fetch('/api/admin/sets-queue', {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id, action }),
    })
    setActionId(null)
    loadQueue()
  }

  return (
    <div>
      {/* Discovery controls */}
      <div className="mb-6 rounded-xl border border-border bg-surface p-4">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="font-semibold text-white">Discovery Agent</p>
            <p className="mt-1 text-xs text-muted leading-relaxed">
              Fetches RSS feeds from Cardboard Connection, Panini America, and Beckett News.
              Parses titles for new sets not already in the database and queues them here for review.
              Runs automatically every day at 8 AM UTC — or trigger manually below.
            </p>
          </div>
          <button
            onClick={runDiscovery}
            disabled={running}
            className="btn-gold shrink-0 px-4 py-2 text-sm"
          >
            {running ? 'Scanning…' : '▶ Run Now'}
          </button>
        </div>
        {runResult && (
          <p className={`mt-3 text-xs ${runResult.startsWith('Error') ? 'text-red-400' : 'text-green-400'}`}>
            {runResult}
          </p>
        )}
        <div className="mt-3 flex gap-2 text-xs text-muted">
          <span className="rounded-full border border-border px-2 py-0.5">cardboardconnection.com</span>
          <span className="rounded-full border border-border px-2 py-0.5">paniniamerica.net</span>
          <span className="rounded-full border border-border px-2 py-0.5">beckett.com</span>
        </div>
      </div>

      {/* Status filter */}
      <div className="mb-4 flex gap-2">
        {(['pending', 'approved', 'rejected'] as const).map(s => (
          <button key={s} onClick={() => setStatusFilter(s)}
            className={`rounded-lg border px-3 py-1.5 text-xs font-medium capitalize transition-colors ${
              statusFilter === s
                ? 'border-gold bg-gold-muted text-gold'
                : 'border-border bg-surface text-muted hover:text-white'
            }`}>
            {s}
          </button>
        ))}
        <span className="ml-auto self-center text-xs text-muted">{items.length} items</span>
      </div>

      {/* Queue items */}
      {loading ? (
        <div className="py-16 text-center text-sm text-muted">Loading…</div>
      ) : items.length === 0 ? (
        <div className="py-16 text-center text-sm text-muted">
          {statusFilter === 'pending'
            ? 'No pending items. Run the agent above or wait for the daily scan.'
            : `No ${statusFilter} items.`}
        </div>
      ) : (
        <div className="flex flex-col gap-3">
          {items.map(item => (
            <div key={item.id} className="rounded-xl border border-border bg-surface p-4">
              <div className="flex items-start justify-between gap-4">
                <div className="min-w-0">
                  {/* Set identity */}
                  <p className="font-semibold text-white">
                    {item.year} {item.brand} {item.set_name}
                  </p>
                  <p className="text-xs text-muted mt-0.5">
                    {SPORT_EMOJI[item.sport] ?? '🃏'} {item.sport}
                  </p>
                  {/* Source */}
                  <div className="mt-2">
                    <a
                      href={item.source_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-xs text-gold/70 hover:text-gold truncate block max-w-sm"
                      title={item.source_title}
                    >
                      📰 {item.source_name}: {item.source_title}
                    </a>
                  </div>
                  {/* Proposed parallels */}
                  <div className="mt-2 flex flex-wrap gap-1">
                    {item.proposed_parallels.map((p, i) => (
                      <span key={i} className="rounded-full border border-border bg-surface-2 px-2 py-0.5 text-xs text-muted">
                        {p.label}
                      </span>
                    ))}
                    <span className="text-xs text-muted/50 self-center ml-1">
                      (edit after approving)
                    </span>
                  </div>
                </div>

                {/* Actions — only for pending */}
                {statusFilter === 'pending' && (
                  <div className="flex items-center gap-2 shrink-0">
                    <button
                      onClick={() => handleAction(item.id, 'approve')}
                      disabled={actionId === item.id}
                      className="rounded-lg border border-green-500/30 bg-green-500/10 px-3 py-1.5 text-xs font-medium text-green-400 hover:bg-green-500/20 transition-colors disabled:opacity-50"
                    >
                      {actionId === item.id ? '…' : '✓ Approve'}
                    </button>
                    <button
                      onClick={() => handleAction(item.id, 'reject')}
                      disabled={actionId === item.id}
                      className="rounded-lg border border-red-500/30 px-3 py-1.5 text-xs text-red-400 hover:bg-red-500/10 transition-colors disabled:opacity-50"
                    >
                      {actionId === item.id ? '…' : '✕ Reject'}
                    </button>
                  </div>
                )}

                {/* Status badge — for approved/rejected */}
                {statusFilter !== 'pending' && (
                  <span className={`shrink-0 rounded-full px-2.5 py-0.5 text-xs font-medium ${
                    statusFilter === 'approved'
                      ? 'bg-green-500/10 text-green-400'
                      : 'bg-red-500/10 text-red-400'
                  }`}>
                    {statusFilter}
                  </span>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
