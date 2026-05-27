'use client'

/**
 * GuidedCardSelector — guided, set-driven card entry for /analyze.
 *
 * Replaces the old free-text dropdown form. Built around the `sets` and
 * `parallels` tables (well-populated) and degrades gracefully when the
 * `cards`/`players` tables are sparse:
 *
 *   1. Sport          (pill tabs)
 *   2. Year           (pills, distinct years from sets for the sport)
 *   3. Brand          (pills, distinct manufacturers for sport+year)
 *   4. Set            (tiles, sets for sport+year+brand)
 *   5. Card details   (player name + card number; optional autocomplete from
 *                      cards/players when seeded, free text otherwise)
 *   6. Parallel       (tiles from parallels.set_id, with parallel_templates
 *                      fallback; inline ParallelVerifier; always shows once
 *                      a set is chosen, never blocked by missing player data)
 *   7. Cost basis     (summary card + editable cost + Run Analysis)
 *
 * "Card not listed? Enter manually →" toggles a free-text fallback form
 * for cases where the set picker doesn't cover the user's card.
 */

import { useState, useEffect, useMemo, useRef, useCallback } from 'react'
import type { CardFormData } from '@/lib/types'
import { displayYear } from '@/lib/utils'
import ParallelVerifier from './ParallelVerifier'

// ─── Constants ────────────────────────────────────────────────────────────────

type Sport = { id: string; label: string } & ({ emoji: string; badge?: never } | { badge: string; emoji?: never })

const SPORTS: Sport[] = [
  { id: 'baseball',   label: 'Baseball',   emoji: '⚾' },
  { id: 'basketball', label: 'Basketball', emoji: '🏀' },
  { id: 'football',   label: 'Football',   emoji: '🏈' },
  { id: 'hockey',     label: 'Hockey',     emoji: '🏒' },
  { id: 'soccer',     label: 'Soccer',     emoji: '⚽' },
  { id: 'wnba',       label: 'WNBA',       badge: 'W' },
]

const STEP_LABELS = [
  'Sport',
  'Year',
  'Brand',
  'Set',
  'Card #',
  'Parallel',
  'Cost',
] as const

type Step = 1 | 2 | 3 | 4 | 5 | 6 | 7

// ─── Domain types ─────────────────────────────────────────────────────────────

interface ManufacturerRef { id: string; name: string; slug: string }

interface SetOption {
  id:           string
  year:         number
  name:         string
  manufacturer: ManufacturerRef | null
  card_count:   number
}

interface CardOption {
  id:          string
  card_number: string | null
  name:        string | null
  player:      { id: string; name: string } | null
}

interface Player {
  id:       string
  name:     string
  position: string | null
  sport:    { id: string; name: string; slug: string } | null
}

interface Parallel {
  id:                  string | null
  label:               string
  ebay_kw:             string
  print_run:           number | null
  reference_image_url: string | null
  visual_identifiers:  string[] | null
  surface_description: string | null
  is_base:             boolean
}

interface PriceInfo {
  cached:       boolean
  raw_avg?:     number
  raw_count?:   number
  psa10_avg?:   number
  psa10_count?: number
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function colorSwatchFor(label: string): string {
  const l = label.toLowerCase()
  if (l.includes('superfractor')) return 'linear-gradient(135deg,#ffd700,#ff8c00,#ffd700)'
  if (l.includes('rainbow'))      return 'linear-gradient(90deg,red,orange,yellow,green,blue,indigo,violet)'
  if (l.includes('printing plate')) return '#444'
  if (l.includes('gold'))         return '#d4af37'
  if (l.includes('silver'))       return '#c0c0c0'
  if (l.includes('bronze'))       return '#cd7f32'
  if (l.includes('platinum'))     return '#e5e4e2'
  if (l.includes('emerald'))      return '#10b981'
  if (l.includes('ruby'))         return '#e0115f'
  if (l.includes('sapphire'))     return '#0f52ba'
  if (l.includes('aqua'))         return '#22d3ee'
  if (l.includes('teal'))         return '#14b8a6'
  if (l.includes('neon green'))   return '#39ff14'
  if (l.includes('lime'))         return '#bef264'
  if (l.includes('green'))        return '#10b981'
  if (l.includes('blue ice'))     return '#7dd3fc'
  if (l.includes('blue'))         return '#3b82f6'
  if (l.includes('purple'))       return '#a855f7'
  if (l.includes('pink'))         return '#ec4899'
  if (l.includes('red'))          return '#ef4444'
  if (l.includes('orange'))       return '#f97316'
  if (l.includes('yellow'))       return '#facc15'
  if (l.includes('black'))        return '#0a0a0a'
  if (l.includes('white'))        return '#f5f5f5'
  if (l.includes('refractor'))    return 'linear-gradient(135deg,#9ca3af,#e5e7eb,#9ca3af)'
  if (l.includes('prizm'))        return 'linear-gradient(135deg,#c8a96e,#e5e7eb)'
  if (l.includes('base'))         return '#374151'
  return '#374151'
}

function formatPrice(n: number | undefined): string {
  if (typeof n !== 'number' || !isFinite(n) || n <= 0) return '—'
  return n >= 100 ? `$${n.toFixed(0)}` : `$${n.toFixed(2)}`
}

// ─── Props ────────────────────────────────────────────────────────────────────

interface Props {
  onSubmit: (data: CardFormData) => void
  loading:  boolean
}

// ─── Main component ──────────────────────────────────────────────────────────

export default function GuidedCardSelector({ onSubmit, loading }: Props) {
  const [manualMode, setManualMode] = useState(false)
  const [step, setStep] = useState<Step>(1)

  // Selections
  const [sport,      setSport]      = useState<string>('')
  const [year,       setYear]       = useState<number | null>(null)
  const [brand,      setBrand]      = useState<ManufacturerRef | null>(null)
  const [setSel,     setSetSel]     = useState<SetOption | null>(null)
  const [playerName, setPlayerName] = useState<string>('')
  const [cardNumber, setCardNumber] = useState<string>('')
  const [parallel,   setParallel]   = useState<Parallel | null>(null)
  const [parallelPrice, setParallelPrice] = useState<PriceInfo | null>(null)

  const [verifierConfirmed, setVerifierConfirmed] = useState(false)
  const [costBasis,         setCostBasis]         = useState<number | ''>('')

  function resetFrom(s: Step) {
    if (s <= 1) setYear(null)
    if (s <= 2) setBrand(null)
    if (s <= 3) setSetSel(null)
    if (s <= 4) { setPlayerName(''); setCardNumber('') }
    if (s <= 5) { setParallel(null); setParallelPrice(null); setVerifierConfirmed(false) }
    if (s <= 6) setCostBasis('')
  }

  function goTo(s: Step) { setStep(s) }
  function back()       { if (step > 1) setStep((step - 1) as Step) }

  function handleAnalyze() {
    if (!sport || year == null || !brand || !setSel || !parallel || !verifierConfirmed) return
    if (!playerName.trim()) return
    onSubmit({
      playerName: playerName.trim(),
      year:       displayYear(year, sport),
      brand:      brand.name,
      set:        setSel.name,
      cardNumber: cardNumber.trim(),
      parallel:   parallel.ebay_kw ?? '',
      costBasis:  typeof costBasis === 'number' ? costBasis : 0,
    })
  }

  // Manual mode short-circuits the whole flow
  if (manualMode) {
    return <ManualForm onSubmit={onSubmit} loading={loading} onBack={() => setManualMode(false)} />
  }

  return (
    <div className="flex flex-col gap-5">
      <StepIndicator step={step} />

      <Breadcrumb
        sport={sport}
        year={year}
        brand={brand}
        setSel={setSel}
        cardNumber={cardNumber}
        playerName={playerName}
        parallel={parallel}
        onJump={(s) => goTo(s)}
      />

      <div key={step} className="animate-slide-up">
        {step === 1 && (
          <Step1Sport
            selected={sport}
            onPick={(s) => { setSport(s); resetFrom(1); goTo(2) }}
          />
        )}

        {step === 2 && sport && (
          <Step2Year
            sport={sport}
            selected={year}
            onPick={(y) => { setYear(y); resetFrom(2); goTo(3) }}
          />
        )}

        {step === 3 && sport && year != null && (
          <Step3Brand
            sport={sport}
            year={year}
            selected={brand}
            onPick={(b) => { setBrand(b); resetFrom(3); goTo(4) }}
          />
        )}

        {step === 4 && sport && year != null && brand && (
          <Step4Set
            sport={sport}
            year={year}
            brand={brand}
            selected={setSel}
            onPick={(s) => { setSetSel(s); resetFrom(4); goTo(5) }}
          />
        )}

        {step === 5 && setSel && (
          <Step5CardDetails
            setId={setSel.id}
            playerName={playerName}
            cardNumber={cardNumber}
            onPlayerChange={setPlayerName}
            onCardNumberChange={setCardNumber}
            onContinue={() => goTo(6)}
          />
        )}

        {step === 6 && setSel && (
          <Step6Parallel
            setId={setSel.id}
            sportSlug={sport}
            year={year!}
            brand={brand!.name}
            setName={setSel.name}
            cardNumber={cardNumber}
            playerName={playerName}
            selected={parallel}
            onPick={(p, price) => {
              setParallel(p)
              setParallelPrice(price)
              setVerifierConfirmed(false)
            }}
            confirmed={verifierConfirmed}
            setConfirmed={setVerifierConfirmed}
            onConfirmed={() => goTo(7)}
          />
        )}

        {step === 7 && setSel && brand && parallel && (
          <Step7CostBasis
            sport={sport}
            year={year!}
            brand={brand}
            setSel={setSel}
            cardNumber={cardNumber}
            playerName={playerName}
            parallel={parallel}
            price={parallelPrice}
            costBasis={costBasis}
            setCostBasis={setCostBasis}
            loading={loading}
            onAnalyze={handleAnalyze}
          />
        )}
      </div>

      <div className="flex items-center justify-between">
        {step > 1 ? (
          <button
            type="button"
            onClick={back}
            disabled={loading}
            className="text-xs text-muted transition-colors hover:text-white"
          >
            ← Back
          </button>
        ) : <span />}
        <button
          type="button"
          onClick={() => setManualMode(true)}
          className="text-xs text-muted underline underline-offset-2 transition-colors hover:text-white"
        >
          Card not listed? Enter manually →
        </button>
      </div>
    </div>
  )
}

// ─── Step indicator ──────────────────────────────────────────────────────────

function StepIndicator({ step }: { step: number }) {
  return (
    <div className="flex flex-wrap items-center gap-2">
      {STEP_LABELS.map((label, i) => {
        const n          = i + 1
        const isActive   = n === step
        const isComplete = n < step
        return (
          <div key={label} className="flex items-center gap-2">
            <div
              className={`flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-[11px] font-semibold transition-colors ${
                isActive
                  ? 'bg-gold text-black'
                  : isComplete
                    ? 'bg-gold-muted text-gold'
                    : 'bg-border text-muted'
              }`}
            >
              {isComplete ? '✓' : n}
            </div>
            <span className={`hidden text-xs sm:inline ${isActive ? 'font-semibold text-white' : 'text-muted'}`}>
              {label}
            </span>
            {n < STEP_LABELS.length && (
              <div className={`h-px w-4 sm:w-6 ${isComplete ? 'bg-gold/60' : 'bg-border'}`} />
            )}
          </div>
        )
      })}
    </div>
  )
}

// ─── Breadcrumb ──────────────────────────────────────────────────────────────

function Breadcrumb({
  sport, year, brand, setSel, cardNumber, playerName, parallel, onJump,
}: {
  sport:      string
  year:       number | null
  brand:      ManufacturerRef | null
  setSel:     SetOption | null
  cardNumber: string
  playerName: string
  parallel:   Parallel | null
  onJump:     (s: Step) => void
}) {
  const parts: Array<{ label: string; step: Step }> = []
  if (sport) {
    const s = SPORTS.find(x => x.id === sport)
    if (s) parts.push({ label: s.label, step: 1 })
  }
  if (year != null) parts.push({ label: displayYear(year, sport), step: 2 })
  if (brand)        parts.push({ label: brand.name, step: 3 })
  if (setSel)       parts.push({ label: setSel.name, step: 4 })
  if (playerName || cardNumber) {
    parts.push({
      label: [playerName, cardNumber ? `#${cardNumber}` : null].filter(Boolean).join(' '),
      step:  5,
    })
  }
  if (parallel) parts.push({ label: parallel.label, step: 6 })

  if (parts.length === 0) return null

  return (
    <div className="flex flex-wrap items-center gap-1.5 rounded-lg border border-border bg-surface px-3 py-2 text-xs">
      {parts.map((p, i) => (
        <span key={i} className="flex items-center gap-1.5">
          {i > 0 && <span className="text-muted/50">→</span>}
          <button
            type="button"
            onClick={() => onJump(p.step)}
            className="text-white/80 transition-colors hover:text-gold"
            title={`Edit ${STEP_LABELS[p.step - 1]}`}
          >
            {p.label}
          </button>
        </span>
      ))}
    </div>
  )
}

// ─── Step 1: Sport ───────────────────────────────────────────────────────────

function Step1Sport({
  selected, onPick,
}: {
  selected: string
  onPick:   (s: string) => void
}) {
  return (
    <div className="flex flex-col gap-3">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Pick a sport
      </label>
      <div className="flex flex-wrap gap-2">
        {SPORTS.map(s => {
          const isSel = selected === s.id
          return (
            <button
              key={s.id}
              type="button"
              onClick={() => onPick(s.id)}
              className={`flex items-center gap-2 rounded-lg border px-4 py-2.5 text-sm font-medium transition-colors ${
                isSel
                  ? 'border-gold bg-gold-muted text-gold'
                  : 'border-border bg-surface text-white hover:border-gold/40'
              }`}
            >
              {s.emoji
                ? <span className="text-lg">{s.emoji}</span>
                : <span className="inline-flex h-5 w-5 items-center justify-center rounded bg-orange-500/20 text-[10px] font-bold text-orange-400">{s.badge}</span>
              }
              <span>{s.label}</span>
            </button>
          )
        })}
      </div>
    </div>
  )
}

// ─── Step 2: Year ────────────────────────────────────────────────────────────

function Step2Year({
  sport, selected, onPick,
}: {
  sport:    string
  selected: number | null
  onPick:   (y: number) => void
}) {
  const [years, setYears]     = useState<number[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError]     = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false
    setLoading(true)
    setError(null)
    fetch(`/api/cards/years?sport=${encodeURIComponent(sport)}`)
      .then(r => r.json())
      .then(d => {
        if (cancelled) return
        if (d.error) throw new Error(d.error)
        setYears(d.years ?? [])
      })
      .catch(e => { if (!cancelled) setError(e.message ?? 'Failed to load years') })
      .finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [sport])

  return (
    <div className="flex flex-col gap-3">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Pick a year
      </label>

      {loading && <SkeletonPills />}

      {error && (
        <p className="rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-xs text-red-400">
          {error}
        </p>
      )}

      {!loading && !error && years.length === 0 && (
        <p className="rounded-lg border border-border bg-surface px-3 py-3 text-sm text-muted">
          No years on file for {sport} yet.
        </p>
      )}

      {!loading && years.length > 0 && (
        <div className="-mx-1 overflow-x-auto pb-1">
          <div className="flex min-w-min gap-2 px-1">
            {years.map(y => (
              <button
                key={y}
                type="button"
                onClick={() => onPick(y)}
                className={`shrink-0 rounded-full border px-4 py-2 text-sm font-medium transition-colors ${
                  selected === y
                    ? 'border-gold bg-gold-muted text-gold'
                    : 'border-border bg-surface text-white hover:border-gold/40'
                }`}
              >
                {displayYear(y, sport)}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}

// ─── Step 3: Brand ───────────────────────────────────────────────────────────

function Step3Brand({
  sport, year, selected, onPick,
}: {
  sport:    string
  year:     number
  selected: ManufacturerRef | null
  onPick:   (b: ManufacturerRef) => void
}) {
  const [brands, setBrands]   = useState<ManufacturerRef[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError]     = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false
    setLoading(true)
    setError(null)
    fetch(`/api/cards/brands?sport=${encodeURIComponent(sport)}&year=${year}`)
      .then(r => r.json())
      .then(d => {
        if (cancelled) return
        if (d.error) throw new Error(d.error)
        setBrands(d.brands ?? [])
      })
      .catch(e => { if (!cancelled) setError(e.message ?? 'Failed to load brands') })
      .finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [sport, year])

  return (
    <div className="flex flex-col gap-3">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Pick a brand — {displayYear(year, sport)}
      </label>

      {loading && <SkeletonPills />}

      {error && (
        <p className="rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-xs text-red-400">
          {error}
        </p>
      )}

      {!loading && !error && brands.length === 0 && (
        <p className="rounded-lg border border-border bg-surface px-3 py-3 text-sm text-muted">
          No brands on file for {displayYear(year, sport)}.
        </p>
      )}

      {!loading && brands.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {brands.map(b => {
            const isSel = selected?.id === b.id
            return (
              <button
                key={b.id}
                type="button"
                onClick={() => onPick(b)}
                className={`shrink-0 rounded-lg border px-4 py-2 text-sm font-medium transition-colors ${
                  isSel
                    ? 'border-gold bg-gold-muted text-gold'
                    : 'border-border bg-surface text-white hover:border-gold/40'
                }`}
              >
                {b.name}
              </button>
            )
          })}
        </div>
      )}
    </div>
  )
}

// ─── Step 4: Set ─────────────────────────────────────────────────────────────

function Step4Set({
  sport, year, brand, selected, onPick,
}: {
  sport:    string
  year:     number
  brand:    ManufacturerRef
  selected: SetOption | null
  onPick:   (s: SetOption) => void
}) {
  const [sets, setSets]       = useState<SetOption[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError]     = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false
    setLoading(true)
    setError(null)
    const params = new URLSearchParams({
      sport,
      year:  String(year),
      brand: brand.slug,
    })
    fetch(`/api/cards/sets?${params}`)
      .then(r => r.json())
      .then(d => {
        if (cancelled) return
        if (d.error) throw new Error(d.error)
        setSets(d.sets ?? [])
      })
      .catch(e => { if (!cancelled) setError(e.message ?? 'Failed to load sets') })
      .finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [sport, year, brand])

  return (
    <div className="flex flex-col gap-3">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Pick a set — {brand.name} {displayYear(year, sport)}
      </label>

      {loading && <SkeletonRows />}

      {error && (
        <p className="rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-xs text-red-400">
          {error}
        </p>
      )}

      {!loading && !error && sets.length === 0 && (
        <p className="rounded-lg border border-border bg-surface px-3 py-3 text-sm text-muted">
          No sets on file for {brand.name} {displayYear(year, sport)}.
        </p>
      )}

      {!loading && sets.length > 0 && (
        <div className="grid grid-cols-1 gap-2 sm:grid-cols-2">
          {sets.map(s => {
            const isSel = selected?.id === s.id
            return (
              <button
                key={s.id}
                type="button"
                onClick={() => onPick(s)}
                className={`flex items-center justify-between gap-3 rounded-lg border px-4 py-3 text-left transition-colors ${
                  isSel
                    ? 'border-gold bg-gold-muted'
                    : 'border-border bg-surface hover:border-gold/40 hover:bg-surface-2'
                }`}
              >
                <span className="text-sm font-medium text-white">{s.name}</span>
                {s.card_count > 0 && (
                  <span className="shrink-0 text-xs text-muted">
                    {s.card_count} card{s.card_count === 1 ? '' : 's'}
                  </span>
                )}
              </button>
            )
          })}
        </div>
      )}
    </div>
  )
}

// ─── Step 5: Card # + Player ─────────────────────────────────────────────────

function Step5CardDetails({
  setId, playerName, cardNumber,
  onPlayerChange, onCardNumberChange, onContinue,
}: {
  setId:              string
  playerName:         string
  cardNumber:         string
  onPlayerChange:     (v: string) => void
  onCardNumberChange: (v: string) => void
  onContinue:         () => void
}) {
  // Load checklist for autocomplete — silently no-op if empty
  const [cards, setCards]     = useState<CardOption[]>([])
  const [loading, setLoading] = useState(true)
  const [filter, setFilter]   = useState('')

  useEffect(() => {
    let cancelled = false
    setLoading(true)
    fetch(`/api/cards/checklist?setId=${encodeURIComponent(setId)}`)
      .then(r => r.json())
      .then(d => { if (!cancelled) setCards(d.cards ?? []) })
      .catch(() => { /* checklist is optional */ })
      .finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [setId])

  // Player autocomplete (debounced 300 ms) — also optional
  const [playerResults, setPlayerResults] = useState<Player[]>([])
  const [playerOpen, setPlayerOpen]       = useState(false)
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current)
    if (playerName.trim().length < 2) { setPlayerResults([]); return }
    debounceRef.current = setTimeout(async () => {
      try {
        const params = new URLSearchParams({
          q:     playerName,
          setId,
          limit: '8',
        })
        const r = await fetch(`/api/cards/search?${params}`)
        const d = await r.json()
        setPlayerResults(d.players ?? [])
      } catch {
        setPlayerResults([])
      }
    }, 300)
    return () => { if (debounceRef.current) clearTimeout(debounceRef.current) }
  }, [playerName, setId])

  const filteredCards = useMemo(() => {
    const f = filter.trim().toLowerCase()
    if (!f) return cards
    return cards.filter(c => {
      const num  = (c.card_number ?? '').toLowerCase()
      const name = (c.name        ?? '').toLowerCase()
      const pn   = (c.player?.name ?? '').toLowerCase()
      return num.includes(f) || name.includes(f) || pn.includes(f)
    })
  }, [cards, filter])

  function applyCard(c: CardOption) {
    onCardNumberChange(c.card_number ?? '')
    if (c.player?.name) onPlayerChange(c.player.name)
  }

  const canContinue = !!playerName.trim()

  return (
    <div className="flex flex-col gap-4">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Card details
      </label>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
        {/* Player name with optional autocomplete */}
        <div className="relative">
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">
            Player name *
          </label>
          <input
            autoFocus
            type="text"
            value={playerName}
            onChange={e => { onPlayerChange(e.target.value); setPlayerOpen(true) }}
            onFocus={() => setPlayerOpen(true)}
            placeholder="e.g. Patrick Mahomes"
            className="input-base"
            autoComplete="off"
          />
          {playerOpen && playerResults.length > 0 && playerName.trim().length >= 2 && (
            <div className="absolute z-10 mt-1 w-full max-h-56 overflow-y-auto rounded-lg border border-border bg-surface shadow-lg">
              {playerResults.map(p => (
                <button
                  key={p.id}
                  type="button"
                  onClick={() => { onPlayerChange(p.name); setPlayerOpen(false) }}
                  className="flex w-full items-center justify-between gap-3 border-b border-border/50 px-3 py-2 text-left text-sm transition-colors last:border-b-0 hover:bg-surface-2"
                >
                  <span className="text-white">{p.name}</span>
                  {p.sport?.name && (
                    <span className="text-xs text-muted">{p.sport.name}</span>
                  )}
                </button>
              ))}
            </div>
          )}
        </div>

        {/* Card number — free text */}
        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">
            Card number
          </label>
          <input
            type="text"
            value={cardNumber}
            onChange={e => onCardNumberChange(e.target.value)}
            placeholder="e.g. 15, RC, 250"
            className="input-base"
          />
          <p className="mt-1 text-xs text-muted/70">Optional — leave blank if unknown.</p>
        </div>
      </div>

      {/* Optional checklist picker (only renders if checklist has rows) */}
      {!loading && cards.length > 0 && (
        <div className="rounded-lg border border-border bg-surface p-3">
          <div className="mb-2 flex items-center justify-between gap-2">
            <p className="text-xs font-medium uppercase tracking-wider text-muted">
              Or pick from the set checklist ({cards.length})
            </p>
            <input
              type="text"
              value={filter}
              onChange={e => setFilter(e.target.value)}
              placeholder="Filter…"
              className="input-base max-w-[180px] py-1.5 text-xs"
            />
          </div>
          <div className="max-h-56 overflow-y-auto rounded border border-border/60">
            {filteredCards.slice(0, 50).map(c => (
              <button
                key={c.id}
                type="button"
                onClick={() => applyCard(c)}
                className="flex w-full items-center gap-3 border-b border-border/40 px-3 py-2 text-left text-sm transition-colors last:border-b-0 hover:bg-surface-2"
              >
                <span className="rounded bg-border px-1.5 py-0.5 font-mono text-[11px] text-gold">
                  {c.card_number ? `#${c.card_number}` : '—'}
                </span>
                <span className="text-white">{c.player?.name ?? c.name ?? 'Card'}</span>
              </button>
            ))}
            {filteredCards.length > 50 && (
              <p className="border-t border-border/40 px-3 py-2 text-center text-xs text-muted">
                Showing first 50 — refine your filter to see more.
              </p>
            )}
          </div>
        </div>
      )}

      {!loading && cards.length === 0 && (
        <p className="rounded-lg border border-dashed border-border/60 bg-background/30 px-3 py-2 text-xs text-muted">
          Set checklist not seeded yet — type the card number above (or leave blank) and continue to the parallel selector.
        </p>
      )}

      <div>
        <button
          type="button"
          disabled={!canContinue}
          onClick={onContinue}
          className="btn-gold px-6 py-2 text-sm disabled:opacity-50"
        >
          Continue to parallel →
        </button>
      </div>
    </div>
  )
}

// ─── Step 6: Parallel + Verifier ─────────────────────────────────────────────

function Step6Parallel({
  setId, sportSlug, year, brand, setName, cardNumber, playerName,
  selected, onPick, confirmed, setConfirmed, onConfirmed,
}: {
  setId:        string
  sportSlug:    string
  year:         number
  brand:        string
  setName:      string
  cardNumber:   string
  playerName:   string
  selected:     Parallel | null
  onPick:       (p: Parallel, price: PriceInfo | null) => void
  confirmed:    boolean
  setConfirmed: (b: boolean) => void
  onConfirmed:  () => void
}) {
  const [parallels, setParallels] = useState<Parallel[]>([])
  const [loading, setLoading]     = useState(true)
  const [error, setError]         = useState<string | null>(null)
  const [source, setSource]       = useState<'parallels' | 'templates' | null>(null)
  const [prices, setPrices]       = useState<Record<string, PriceInfo>>({})

  // Always set-driven — parallels by setId, with parallel_templates fallback
  useEffect(() => {
    let cancelled = false
    setLoading(true)
    setError(null)
    fetch(`/api/cards/parallels?setId=${encodeURIComponent(setId)}`)
      .then(r => r.json())
      .then(d => {
        if (cancelled) return
        if (d.error) throw new Error(d.error)
        setParallels(d.parallels ?? [])
        setSource(d.source ?? null)
      })
      .catch(e => { if (!cancelled) setError(e.message ?? 'Failed to load parallels') })
      .finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [setId])

  const fetchPrice = useCallback(async (p: Parallel): Promise<PriceInfo | null> => {
    if (!playerName.trim()) return null
    try {
      const params = new URLSearchParams()
      if (p.id) {
        params.set('parallelId', p.id)
      } else {
        params.set('year',       String(year))
        params.set('brand',      brand)
        params.set('set',        setName)
        params.set('cardNumber', cardNumber)
        params.set('parallel',   p.ebay_kw ?? '')
        params.set('playerName', playerName)
      }
      const r = await fetch(`/api/cards/price?${params}`)
      return await r.json() as PriceInfo
    } catch {
      return null
    }
  }, [year, brand, setName, cardNumber, playerName])

  useEffect(() => {
    let cancelled = false
    if (parallels.length === 0 || !playerName.trim()) return
    ;(async () => {
      const next: Record<string, PriceInfo> = {}
      for (const p of parallels) {
        const k = p.id ?? `${p.label}::${p.ebay_kw}`
        const price = await fetchPrice(p)
        if (cancelled) return
        if (price) next[k] = price
      }
      if (!cancelled) setPrices(next)
    })()
    return () => { cancelled = true }
  }, [parallels, fetchPrice, playerName])

  return (
    <div className="flex flex-col gap-4">
      <div>
        <label className="block text-xs font-medium uppercase tracking-wider text-muted">
          Pick your parallel
        </label>
        <p className="mt-1 text-xs text-gold/70">
          You must select a parallel — pick Base if you have an unnumbered version.
        </p>
        {source === 'templates' && (
          <p className="mt-1 text-[11px] text-muted/70">
            Showing set-level parallel templates (card-specific data not yet seeded).
          </p>
        )}
      </div>

      {loading && <SkeletonRows />}

      {error && (
        <p className="rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-xs text-red-400">
          {error}
        </p>
      )}

      {!loading && parallels.length === 0 && !error && (
        <p className="rounded-lg border border-border bg-surface px-3 py-3 text-sm text-muted">
          Base only — no parallel variants on file for this set.
        </p>
      )}

      {!loading && parallels.length > 0 && (
        <div className="grid grid-cols-1 gap-2 sm:grid-cols-2">
          {parallels.map(p => {
            const k     = p.id ?? `${p.label}::${p.ebay_kw}`
            const isSel = selected?.label === p.label && (selected?.id ?? null) === (p.id ?? null)
            const price = prices[k]
            const pr    = p.print_run
            return (
              <button
                key={k}
                type="button"
                onClick={() => onPick(p, price ?? null)}
                className={`flex items-center gap-3 rounded-lg border px-3 py-3 text-left transition-colors ${
                  isSel
                    ? 'border-gold bg-gold-muted'
                    : 'border-border bg-surface hover:border-gold/40 hover:bg-surface-2'
                }`}
              >
                <span
                  className="block h-8 w-8 shrink-0 rounded border border-border/60"
                  style={{ background: colorSwatchFor(p.label) }}
                  aria-hidden
                />
                <span className="flex min-w-0 flex-1 flex-col">
                  <span className="truncate text-sm font-medium text-white">{p.label}</span>
                  <span className="flex items-center gap-2 text-xs text-muted">
                    {pr != null && <span className="text-gold/80">/{pr}</span>}
                    {price?.cached && price.psa10_avg != null && price.psa10_avg > 0 && (
                      <span>PSA 10 {formatPrice(price.psa10_avg)}</span>
                    )}
                  </span>
                </span>
              </button>
            )
          })}
        </div>
      )}

      {/* Verifier — only after parallel chosen */}
      {selected && (
        <div className="border-t border-border pt-4">
          <p className="mb-3 text-xs font-medium uppercase tracking-wider text-muted">
            Verify the parallel
          </p>
          {!confirmed ? (
            <ParallelVerifier
              parallel={{ label: selected.label, ebay_kw: selected.ebay_kw }}
              setId={setId}
              year={year}
              brand={brand}
              setName={setName}
              sport={sportSlug}
              onConfirm={() => { setConfirmed(true); onConfirmed() }}
              onGoBack={() => { setConfirmed(false) }}
            />
          ) : (
            <div className="flex items-center gap-2 rounded-lg border border-emerald-500/20 bg-emerald-500/10 px-4 py-2.5 text-sm">
              <span className="text-emerald-400">✓</span>
              <span className="font-medium text-emerald-400/90">Parallel confirmed:</span>
              <span className="text-white">{selected.label}</span>
              <button
                type="button"
                onClick={() => setConfirmed(false)}
                className="ml-auto text-xs text-muted transition-colors hover:text-white"
              >
                Change
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Step 7: Cost basis ──────────────────────────────────────────────────────

function Step7CostBasis({
  sport, year, brand, setSel, cardNumber, playerName, parallel, price,
  costBasis, setCostBasis, loading, onAnalyze,
}: {
  sport:        string
  year:         number
  brand:        ManufacturerRef
  setSel:       SetOption
  cardNumber:   string
  playerName:   string
  parallel:     Parallel
  price:        PriceInfo | null
  costBasis:    number | ''
  setCostBasis: (v: number | '') => void
  loading:      boolean
  onAnalyze:    () => void
}) {
  const prefilledRef = useRef(false)
  useEffect(() => {
    if (prefilledRef.current) return
    if (price?.cached && price.raw_avg && price.raw_avg > 0 && costBasis === '') {
      setCostBasis(Math.round(price.raw_avg * 100) / 100)
      prefilledRef.current = true
    }
  }, [price, costBasis, setCostBasis])

  return (
    <div className="flex flex-col gap-4">
      <label className="block text-xs font-medium uppercase tracking-wider text-muted">
        Confirm & set cost basis
      </label>

      <div className="flex gap-4 rounded-xl border border-gold/20 bg-surface p-4">
        {parallel.reference_image_url ? (
          <img
            src={parallel.reference_image_url}
            alt={`${playerName} reference`}
            className="h-32 w-24 shrink-0 rounded object-cover"
          />
        ) : (
          <div className="flex h-32 w-24 shrink-0 items-center justify-center rounded border border-dashed border-border bg-background/50 text-2xl">
            🃏
          </div>
        )}
        <div className="flex min-w-0 flex-1 flex-col gap-1">
          <p className="text-base font-semibold text-white">{playerName || 'Unknown player'}</p>
          <p className="text-sm text-muted">
            {displayYear(year, sport)} · {brand.name} {setSel.name}
          </p>
          <p className="text-sm text-muted">
            {cardNumber ? `#${cardNumber}` : 'No card #'} · {parallel.label}
            {parallel.print_run != null && (
              <span className="ml-1 text-gold">/{parallel.print_run}</span>
            )}
          </p>
          {price?.cached && (
            <div className="mt-1 flex gap-3 text-xs text-muted">
              {price.raw_avg != null && price.raw_avg > 0 && (
                <span>Raw avg <span className="text-white">{formatPrice(price.raw_avg)}</span></span>
              )}
              {price.psa10_avg != null && price.psa10_avg > 0 && (
                <span>PSA 10 <span className="text-white">{formatPrice(price.psa10_avg)}</span></span>
              )}
            </div>
          )}
        </div>
      </div>

      <div className="max-w-xs">
        <label htmlFor="costBasis" className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">
          Your Cost Basis ($) *
        </label>
        <div className="relative">
          <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-muted">$</span>
          <input
            id="costBasis"
            type="number"
            min="0"
            step="0.01"
            value={costBasis}
            onChange={e => {
              const v = e.target.value
              setCostBasis(v === '' ? '' : parseFloat(v) || 0)
            }}
            placeholder={price?.raw_avg && price.raw_avg > 0 ? price.raw_avg.toFixed(2) : '25.00'}
            className="input-base pl-6"
            disabled={loading}
          />
        </div>
        <p className="mt-1 text-xs text-muted">
          What you paid for the raw card{price?.cached && price.raw_avg && price.raw_avg > 0 ? ' — pre-filled from cached market avg' : ''}.
        </p>
      </div>

      <div>
        <button
          type="button"
          onClick={onAnalyze}
          disabled={loading || costBasis === '' || costBasis < 0 || !playerName.trim()}
          className="btn-gold px-8 py-3"
        >
          {loading ? (
            <span className="flex items-center gap-2"><Spinner /> Analyzing…</span>
          ) : (
            <span className="flex items-center gap-2">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
              </svg>
              Run Analysis
            </span>
          )}
        </button>
      </div>
    </div>
  )
}

// ─── Manual fallback (free text everything) ──────────────────────────────────

const MANUAL_BRANDS = [
  'Topps', 'Bowman', 'Panini', 'Upper Deck', 'O-Pee-Chee',
  'Leaf', 'Fleer', 'Donruss', 'Score', 'SP Authentic', 'Other',
]

function ManualForm({
  onSubmit, loading, onBack,
}: {
  onSubmit: (data: CardFormData) => void
  loading:  boolean
  onBack:   () => void
}) {
  const [form, setForm] = useState<CardFormData>({
    playerName: '', year: '', brand: 'Topps', set: '',
    cardNumber: '', parallel: '', costBasis: 0,
  })

  function field<K extends keyof CardFormData>(k: K, v: CardFormData[K]) {
    setForm(prev => ({ ...prev, [k]: v }))
  }

  return (
    <form
      onSubmit={e => { e.preventDefault(); onSubmit(form) }}
      className="flex flex-col gap-5"
    >
      <div className="flex items-center justify-between gap-3">
        <p className="text-sm font-medium text-white">Manual entry</p>
        <button type="button" onClick={onBack} className="text-xs text-gold hover:underline">
          ← Back to guided search
        </button>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <div className="col-span-full sm:col-span-2">
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Player Name *</label>
          <input
            type="text" required value={form.playerName}
            onChange={e => field('playerName', e.target.value)}
            placeholder="e.g. Mike Trout"
            className="input-base" disabled={loading}
          />
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Year *</label>
          <input
            type="text" required value={form.year}
            onChange={e => field('year', e.target.value)}
            placeholder="e.g. 2011" pattern="\d{4}" maxLength={4}
            className="input-base" disabled={loading}
          />
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Brand *</label>
          <select
            value={form.brand}
            onChange={e => field('brand', e.target.value)}
            className="input-base" disabled={loading}
          >
            {MANUAL_BRANDS.map(b => <option key={b} value={b}>{b}</option>)}
          </select>
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Set</label>
          <input
            type="text" value={form.set}
            onChange={e => field('set', e.target.value)}
            placeholder="e.g. Chrome, Prizm"
            className="input-base" disabled={loading}
          />
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Parallel / Variant</label>
          <input
            type="text" value={form.parallel}
            onChange={e => field('parallel', e.target.value)}
            placeholder="e.g. Silver Prizm, Refractor"
            className="input-base" disabled={loading}
          />
          <p className="mt-1 text-xs text-muted">Leave blank for base</p>
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Card Number</label>
          <input
            type="text" value={form.cardNumber}
            onChange={e => field('cardNumber', e.target.value)}
            placeholder="e.g. 27, RC"
            className="input-base" disabled={loading}
          />
        </div>

        <div>
          <label className="mb-1.5 block text-xs font-medium uppercase tracking-wider text-muted">Cost Basis ($) *</label>
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

      <div>
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
      </div>
    </form>
  )
}

// ─── Misc ─────────────────────────────────────────────────────────────────────

function Spinner() {
  return (
    <svg className="animate-spin text-gold" width="14" height="14" viewBox="0 0 24 24" fill="none">
      <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="3" strokeOpacity="0.3" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
    </svg>
  )
}

function SkeletonPills() {
  return (
    <div className="flex gap-2 overflow-hidden">
      {[1, 2, 3, 4, 5, 6].map(i => (
        <div key={i} className="h-9 w-16 shrink-0 animate-pulse rounded-full bg-surface" />
      ))}
    </div>
  )
}

function SkeletonRows() {
  return (
    <div className="flex flex-col gap-2">
      {[1, 2, 3].map(i => (
        <div key={i} className="h-12 animate-pulse rounded-lg bg-surface" />
      ))}
    </div>
  )
}
