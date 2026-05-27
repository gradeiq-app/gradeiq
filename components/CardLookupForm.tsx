'use client'

import { useState, useEffect, useMemo } from 'react'
import type { CardFormData } from '@/lib/types'
import { displayYear } from '@/lib/utils'
import ParallelVerifier from './ParallelVerifier'

// ─── Types ────────────────────────────────────────────────────────────────────

interface Parallel {
  label:   string   // display text, e.g. "Gold Refractor /50"
  ebay_kw: string   // eBay search suffix, e.g. "Gold Refractor"
}

interface CardSet {
  id:        string
  sport:     string
  year:      number
  brand:     string
  set_name:  string
  parallels: Parallel[]
}

interface Props {
  onSubmit: (data: CardFormData) => void
  loading:  boolean
}

// ─── Constants ────────────────────────────────────────────────────────────────

// emoji: standard emoji shown as the icon
// badge: short text shown as a styled badge instead of an emoji (for sports with no unique emoji)
type Sport = { id: string; label: string } & ({ emoji: string; badge?: never } | { badge: string; emoji?: never })

const SPORTS: Sport[] = [
  { id: 'baseball',   label: 'Baseball',   emoji: '⚾' },
  { id: 'basketball', label: 'Basketball', emoji: '🏀' },
  { id: 'football',   label: 'Football',   emoji: '🏈' },
  { id: 'hockey',     label: 'Hockey',     emoji: '🏒' },
  { id: 'wnba',       label: 'WNBA',       badge: 'W'  },
]

// Shared label/input classes
const labelCls = 'block mb-1.5 text-xs font-medium uppercase tracking-wider text-muted'
const inputCls = 'input-base'

// ─── Main component ───────────────────────────────────────────────────────────

export default function CardLookupForm({ onSubmit, loading }: Props) {
  const [sets, setSets]           = useState<CardSet[]>([])
  const [setsLoading, setSetsLoading] = useState(true)
  const [manualMode, setManualMode]   = useState(false)

  // Cascading selectors
  const [sport,        setSport]        = useState('baseball')
  const [year,         setYear]         = useState('')
  const [brand,        setBrand]        = useState('')
  const [setName,      setSetName]      = useState('')
  const [parallelIdx,  setParallelIdx]  = useState(0)

  // Card details
  const [playerName, setPlayerName] = useState('')
  const [cardNumber, setCardNumber] = useState('')
  const [costBasis,  setCostBasis]  = useState<number | ''>('')

  // Verifier — resets when parallel changes
  const [verifierConfirmed, setVerifierConfirmed] = useState(false)

  // ── Fetch card sets once ─────────────────────────────────────────────────
  useEffect(() => {
    fetch('/api/cards')
      .then(r => r.json())
      .then(d => { setSets(d.sets ?? []); setSetsLoading(false) })
      .catch(() => { setSetsLoading(false); setManualMode(true) })
  }, [])

  // ── Derived option lists (cascade) ───────────────────────────────────────
  const sportSets = useMemo(
    () => sets.filter(s => s.sport === sport),
    [sets, sport],
  )

  const years = useMemo(
    () => [...new Set(sportSets.map(s => s.year))].sort((a, b) => b - a),
    [sportSets],
  )

  const brands = useMemo(() => {
    const pool = year ? sportSets.filter(s => s.year === +year) : sportSets
    return [...new Set(pool.map(s => s.brand))].sort()
  }, [sportSets, year])

  const setNames = useMemo(() => {
    const pool = sportSets.filter(
      s => (!year || s.year === +year) && (!brand || s.brand === brand),
    )
    return [...new Set(pool.map(s => s.set_name))].sort()
  }, [sportSets, year, brand])

  const currentSet = useMemo(
    () => sportSets.find(
      s => s.year === +year && s.brand === brand && s.set_name === setName,
    ),
    [sportSets, year, brand, setName],
  )

  const parallels = useMemo(() => currentSet?.parallels ?? [], [currentSet])

  // ── Cascade resets ───────────────────────────────────────────────────────
  useEffect(() => { setYear(''); setBrand(''); setSetName(''); setParallelIdx(0); setVerifierConfirmed(false) }, [sport])
  useEffect(() => { setBrand(''); setSetName(''); setParallelIdx(0); setVerifierConfirmed(false) }, [year])
  useEffect(() => { setSetName(''); setParallelIdx(0); setVerifierConfirmed(false) }, [brand])
  useEffect(() => { setParallelIdx(0); setVerifierConfirmed(false) }, [setName])
  // Reset verifier when parallel changes
  useEffect(() => { setVerifierConfirmed(false) }, [parallelIdx])

  // ── Submit ───────────────────────────────────────────────────────────────
  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!playerName.trim() || !year || !brand || !setName) return
    const parallel = parallels[parallelIdx] ?? { label: 'Base', ebay_kw: '' }
    onSubmit({
      playerName: playerName.trim(),
      // Send the formatted year so eBay search matches real listing titles
      // e.g. basketball 2024 → "2023-24", baseball 2024 → "2024"
      year:       displayYear(+year, sport),
      brand,
      set:        setName,
      cardNumber: cardNumber.trim(),
      parallel:   parallel.ebay_kw,
      costBasis:  typeof costBasis === 'number' ? costBasis : 0,
    })
  }

  const canSubmit = !!playerName.trim() && !!year && !!brand && !!setName

  // ── Manual mode fallback ─────────────────────────────────────────────────
  if (manualMode) {
    return (
      <ManualForm
        loading={loading}
        onSubmit={onSubmit}
        onBack={() => setManualMode(false)}
      />
    )
  }

  // ── Structured form ──────────────────────────────────────────────────────
  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-6">

      {/* ── Sport tabs ──────────────────────────────────────────────────── */}
      <div>
        <p className={labelCls}>Sport</p>
        <div className="flex flex-wrap gap-2">
          {SPORTS.map(s => (
            <button
              key={s.id}
              type="button"
              onClick={() => setSport(s.id)}
              disabled={loading}
              className={`flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-sm font-medium transition-colors ${
                sport === s.id
                  ? 'border-gold bg-gold-muted text-gold'
                  : 'border-border bg-surface text-muted hover:border-gold/40 hover:text-white'
              }`}
            >
              {s.emoji
                ? <span>{s.emoji}</span>
                : <span className="inline-flex h-5 w-5 items-center justify-center rounded text-[10px] font-bold leading-none bg-orange-500/20 text-orange-400">{s.badge}</span>
              }
              <span className="hidden sm:inline">{s.label}</span>
            </button>
          ))}
        </div>
      </div>

      {/* ── Year / Brand / Set ──────────────────────────────────────────── */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
        <div>
          <label className={labelCls}>Year *</label>
          <select
            value={year}
            onChange={e => setYear(e.target.value)}
            className={inputCls}
            disabled={loading || setsLoading}
            required
          >
            <option value="">Select year…</option>
            {years.map(y => (
              <option key={y} value={y}>{displayYear(y, sport)}</option>
            ))}
          </select>
        </div>

        <div>
          <label className={labelCls}>Brand *</label>
          <select
            value={brand}
            onChange={e => setBrand(e.target.value)}
            className={inputCls}
            disabled={loading || !year}
            required
          >
            <option value="">Select brand…</option>
            {brands.map(b => (
              <option key={b} value={b}>{b}</option>
            ))}
          </select>
        </div>

        <div>
          <label className={labelCls}>Set *</label>
          <select
            value={setName}
            onChange={e => setSetName(e.target.value)}
            className={inputCls}
            disabled={loading || !brand}
            required
          >
            <option value="">Select set…</option>
            {setNames.map(n => (
              <option key={n} value={n}>{n}</option>
            ))}
          </select>
        </div>
      </div>

      {/* ── Parallel selector — the key differentiator ──────────────────── */}
      {parallels.length > 0 && (
        <div>
          <label className={labelCls}>
            Parallel / Variant
            <span className="ml-2 font-normal normal-case text-gold/70">
              — pick the exact version you have
            </span>
          </label>
          <select
            value={parallelIdx}
            onChange={e => setParallelIdx(+e.target.value)}
            className="input-base border-gold/40 bg-surface focus:border-gold"
            disabled={loading}
          >
            {parallels.map((p, i) => (
              <option key={i} value={i}>
                {p.label}
              </option>
            ))}
          </select>
          {/* Visual hint — print run badge */}
          {(() => {
            const selected = parallels[parallelIdx]
            const match = selected?.label.match(/\/(\d+)$/)
            if (!match) return null
            return (
              <p className="mt-1.5 text-xs text-gold/70">
                Print run: <span className="font-semibold text-gold">/{match[1]}</span>
              </p>
            )
          })()}
        </div>
      )}

      {/* ── Step 5b: Parallel Verifier ──────────────────────────────────── */}
      {currentSet && parallels.length > 0 && !verifierConfirmed && (
        <ParallelVerifier
          parallel={parallels[parallelIdx] ?? parallels[0]}
          setId={currentSet.id}
          year={+year}
          brand={brand}
          setName={setName}
          sport={sport}
          onConfirm={() => setVerifierConfirmed(true)}
          onGoBack={() => { setParallelIdx(0); setVerifierConfirmed(false) }}
        />
      )}
      {verifierConfirmed && (
        <div className="flex items-center gap-2 rounded-lg border border-emerald-500/20 bg-emerald-500/10 px-4 py-2.5 text-sm">
          <span className="text-emerald-400">✓</span>
          <span className="text-emerald-400/90 font-medium">Parallel confirmed:</span>
          <span className="text-white">{parallels[parallelIdx]?.label ?? 'Base'}</span>
          <button
            type="button"
            onClick={() => setVerifierConfirmed(false)}
            className="ml-auto text-xs text-muted hover:text-white transition-colors"
          >
            Change
          </button>
        </div>
      )}

      {/* ── Player + Card # ─────────────────────────────────────────────── */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
        <div>
          <label htmlFor="playerName" className={labelCls}>Player Name *</label>
          <input
            id="playerName"
            type="text"
            required
            value={playerName}
            onChange={e => setPlayerName(e.target.value)}
            placeholder="e.g. LaMelo Ball"
            className={inputCls}
            disabled={loading}
          />
        </div>
        <div>
          <label htmlFor="cardNumber" className={labelCls}>Card Number</label>
          <input
            id="cardNumber"
            type="text"
            value={cardNumber}
            onChange={e => setCardNumber(e.target.value)}
            placeholder="e.g. #163, RC"
            className={inputCls}
            disabled={loading}
          />
        </div>
      </div>

      {/* ── Cost Basis ──────────────────────────────────────────────────── */}
      <div className="max-w-xs">
        <label htmlFor="costBasis" className={labelCls}>Your Cost Basis ($) *</label>
        <div className="relative">
          <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-muted">$</span>
          <input
            id="costBasis"
            type="number"
            required
            min="0"
            step="0.01"
            value={costBasis}
            onChange={e => setCostBasis(parseFloat(e.target.value) || 0)}
            placeholder="25.00"
            className="input-base pl-6"
            disabled={loading}
          />
        </div>
        <p className="mt-1 text-xs text-muted">What you paid for the raw card</p>
      </div>

      {/* ── Actions ─────────────────────────────────────────────────────── */}
      <div className="flex items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          <button
            type="submit"
            disabled={loading || !canSubmit}
            className="btn-gold px-8 py-3"
          >
            {loading ? (
              <span className="flex items-center gap-2">
                <Spinner /> Analyzing…
              </span>
            ) : (
              <span className="flex items-center gap-2">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
                </svg>
                Analyze Card
              </span>
            )}
          </button>
          {!loading && (
            <button
              type="button"
              onClick={() => { setPlayerName(''); setCardNumber(''); setCostBasis('') }}
              className="text-sm text-muted transition-colors hover:text-white"
            >
              Clear
            </button>
          )}
        </div>

        <button
          type="button"
          onClick={() => setManualMode(true)}
          className="text-xs text-muted transition-colors hover:text-white underline underline-offset-2"
        >
          Card not listed? Enter manually →
        </button>
      </div>
    </form>
  )
}

// ─── Manual / free-text fallback ──────────────────────────────────────────────

const BRANDS_MANUAL = [
  'Topps', 'Bowman', 'Panini', 'Upper Deck', 'O-Pee-Chee',
  'Leaf', 'Fleer', 'Donruss', 'Score', 'SP Authentic', 'Other',
]

interface ManualFormProps {
  loading:  boolean
  onSubmit: (data: CardFormData) => void
  onBack:   () => void
}

function ManualForm({ loading, onSubmit, onBack }: ManualFormProps) {
  const [form, setForm] = useState<CardFormData>({
    playerName: '', year: '', brand: 'Topps', set: '',
    cardNumber: '', parallel: '', costBasis: 0,
  })

  function field<K extends keyof CardFormData>(key: K, value: CardFormData[K]) {
    setForm(prev => ({ ...prev, [key]: value }))
  }

  return (
    <form onSubmit={e => { e.preventDefault(); onSubmit(form) }} className="flex flex-col gap-5">
      <div className="flex items-center gap-3">
        <button type="button" onClick={onBack} className="text-xs text-gold hover:underline">
          ← Back to guided search
        </button>
        <span className="text-xs text-muted/50">Manual entry mode</span>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <div className="col-span-full sm:col-span-2">
          <label className={labelCls}>Player Name *</label>
          <input
            type="text" required value={form.playerName}
            onChange={e => field('playerName', e.target.value)}
            placeholder="e.g. Mike Trout" className={inputCls} disabled={loading}
          />
        </div>

        <div>
          <label className={labelCls}>Year *</label>
          <input
            type="text" required value={form.year}
            onChange={e => field('year', e.target.value)}
            placeholder="e.g. 2011" pattern="\d{4}" maxLength={4}
            className={inputCls} disabled={loading}
          />
        </div>

        <div>
          <label className={labelCls}>Brand *</label>
          <select
            value={form.brand}
            onChange={e => field('brand', e.target.value)}
            className={inputCls} disabled={loading}
          >
            {BRANDS_MANUAL.map(b => <option key={b} value={b}>{b}</option>)}
          </select>
        </div>

        <div>
          <label className={labelCls}>Set</label>
          <input
            type="text" value={form.set}
            onChange={e => field('set', e.target.value)}
            placeholder="e.g. Chrome, Prizm" className={inputCls} disabled={loading}
          />
        </div>

        <div>
          <label className={labelCls}>Parallel / Variant</label>
          <input
            type="text" value={form.parallel}
            onChange={e => field('parallel', e.target.value)}
            placeholder="e.g. Silver Prizm, Refractor"
            className={inputCls} disabled={loading}
          />
          <p className="mt-1 text-xs text-muted">Leave blank for base</p>
        </div>

        <div>
          <label className={labelCls}>Card Number</label>
          <input
            type="text" value={form.cardNumber}
            onChange={e => field('cardNumber', e.target.value)}
            placeholder="e.g. #27, RC" className={inputCls} disabled={loading}
          />
        </div>

        <div>
          <label className={labelCls}>Cost Basis ($) *</label>
          <div className="relative">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-muted">$</span>
            <input
              type="number" required min="0" step="0.01"
              value={form.costBasis || ''}
              onChange={e => field('costBasis', parseFloat(e.target.value) || 0)}
              placeholder="25.00" className="input-base pl-6" disabled={loading}
            />
          </div>
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button type="submit" disabled={loading} className="btn-gold px-8 py-3">
          {loading
            ? <span className="flex items-center gap-2"><Spinner /> Analyzing…</span>
            : <span className="flex items-center gap-2">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
                </svg>
                Analyze Card
              </span>
          }
        </button>
        {!loading && (
          <button type="button" onClick={() => setForm(f => ({ ...f, playerName: '', year: '', set: '', cardNumber: '', parallel: '', costBasis: 0 }))}
            className="text-sm text-muted hover:text-white transition-colors">
            Clear
          </button>
        )}
      </div>
    </form>
  )
}

// ─── Spinner ──────────────────────────────────────────────────────────────────
function Spinner() {
  return (
    <svg className="animate-spin" width="14" height="14" viewBox="0 0 24 24" fill="none">
      <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="3" strokeOpacity="0.3" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
    </svg>
  )
}
