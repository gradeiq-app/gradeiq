'use client'

import { useState } from 'react'
import type { CardFormData } from '@/lib/types'

const BRANDS = [
  'Topps',
  'Bowman',
  'Panini',
  'Upper Deck',
  'Leaf',
  'Fleer',
  'Donruss',
  'Score',
  'Pacific',
  'SP Authentic',
  'Other',
]

interface Props {
  onSubmit: (data: CardFormData) => void
  loading: boolean
  compact?: boolean
}

const EMPTY: CardFormData = {
  playerName: '',
  year: '',
  brand: 'Topps',
  set: '',
  cardNumber: '',
  costBasis: 0,
}

export default function CardLookupForm({ onSubmit, loading, compact = false }: Props) {
  const [form, setForm] = useState<CardFormData>(EMPTY)

  function set<K extends keyof CardFormData>(key: K, value: CardFormData[K]) {
    setForm(prev => ({ ...prev, [key]: value }))
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    onSubmit(form)
  }

  const labelClass = 'block mb-1.5 text-xs font-medium text-muted uppercase tracking-wider'
  const cols = compact ? 'grid-cols-2 sm:grid-cols-3' : 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3'

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-5">
      <div className={`grid gap-4 ${cols}`}>
        {/* Player Name */}
        <div className="col-span-full sm:col-span-2">
          <label htmlFor="playerName" className={labelClass}>Player Name *</label>
          <input
            id="playerName"
            type="text"
            required
            value={form.playerName}
            onChange={e => set('playerName', e.target.value)}
            placeholder="e.g. Mike Trout"
            className="input-base"
            disabled={loading}
          />
        </div>

        {/* Year */}
        <div>
          <label htmlFor="year" className={labelClass}>Year *</label>
          <input
            id="year"
            type="text"
            required
            value={form.year}
            onChange={e => set('year', e.target.value)}
            placeholder="e.g. 2011"
            pattern="\d{4}"
            maxLength={4}
            className="input-base"
            disabled={loading}
          />
        </div>

        {/* Brand */}
        <div>
          <label htmlFor="brand" className={labelClass}>Brand *</label>
          <select
            id="brand"
            value={form.brand}
            onChange={e => set('brand', e.target.value)}
            className="input-base"
            disabled={loading}
          >
            {BRANDS.map(b => (
              <option key={b} value={b}>{b}</option>
            ))}
          </select>
        </div>

        {/* Set */}
        <div>
          <label htmlFor="set" className={labelClass}>Set</label>
          <input
            id="set"
            type="text"
            value={form.set}
            onChange={e => set('set', e.target.value)}
            placeholder="e.g. Chrome, Prizm"
            className="input-base"
            disabled={loading}
          />
        </div>

        {/* Card Number */}
        <div>
          <label htmlFor="cardNumber" className={labelClass}>Card Number</label>
          <input
            id="cardNumber"
            type="text"
            value={form.cardNumber}
            onChange={e => set('cardNumber', e.target.value)}
            placeholder="e.g. #27, RC"
            className="input-base"
            disabled={loading}
          />
        </div>

        {/* Cost Basis */}
        <div>
          <label htmlFor="costBasis" className={labelClass}>Your Cost Basis ($) *</label>
          <div className="relative">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted text-sm">$</span>
            <input
              id="costBasis"
              type="number"
              required
              min="0"
              step="0.01"
              value={form.costBasis || ''}
              onChange={e => set('costBasis', parseFloat(e.target.value) || 0)}
              placeholder="25.00"
              className="input-base pl-6"
              disabled={loading}
            />
          </div>
          <p className="mt-1 text-xs text-muted">What you paid for the raw card</p>
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button type="submit" disabled={loading} className="btn-gold px-8 py-3">
          {loading ? (
            <span className="flex items-center gap-2">
              <Spinner /> Analyzing…
            </span>
          ) : (
            <>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <circle cx="11" cy="11" r="8" />
                <path d="m21 21-4.35-4.35" />
              </svg>
              Analyze Card
            </>
          )}
        </button>

        {!loading && (
          <button
            type="button"
            onClick={() => setForm(EMPTY)}
            className="text-sm text-muted hover:text-white transition-colors"
          >
            Clear
          </button>
        )}
      </div>
    </form>
  )
}

function Spinner() {
  return (
    <svg className="animate-spin" width="14" height="14" viewBox="0 0 24 24" fill="none">
      <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="3" strokeOpacity="0.3" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
    </svg>
  )
}
