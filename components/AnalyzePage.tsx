'use client'

import { useState, useRef, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase-browser'
import CardLookupForm from './CardLookupForm'
import ResultsTable from './ResultsTable'
import { analyzeCard } from '@/lib/calculations'
import type { CardFormData, AnalysisResult, EbayApiResponse } from '@/lib/types'
import type { User } from '@supabase/supabase-js'

interface RecentLookup {
  id: string
  card_name: string
  raw_value: number | null
  created_at: string
  result_json: AnalysisResult
}

interface Props {
  user: User
}

export default function AnalyzePage({ user }: Props) {
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState<AnalysisResult | null>(null)
  const [error, setError] = useState('')
  const [isMock, setIsMock] = useState(false)
  const [recentLookups, setRecentLookups] = useState<RecentLookup[]>([])
  const [signingOut, setSigningOut] = useState(false)
  const resultsRef = useRef<HTMLDivElement>(null)
  const router = useRouter()

  useEffect(() => {
    loadRecentLookups()
  }, [])

  async function loadRecentLookups() {
    const supabase = createClient()
    if (!supabase) return
    const { data } = await supabase
      .from('lookups')
      .select('id, card_name, raw_value, created_at, result_json')
      .eq('user_id', user.id)
      .order('created_at', { ascending: false })
      .limit(5)

    if (data) setRecentLookups(data as RecentLookup[])
  }

  async function handleSignOut() {
    setSigningOut(true)
    const supabase = createClient()
    if (supabase) await supabase.auth.signOut()
    router.push('/')
    router.refresh()
  }

  async function handleAnalyze(form: CardFormData) {
    setLoading(true)
    setError('')
    setResult(null)

    try {
      const params = new URLSearchParams({
        playerName: form.playerName,
        year: form.year,
        brand: form.brand,
        set: form.set,
        cardNumber: form.cardNumber,
      })

      const res = await fetch(`/api/ebay?${params}`)
      const data: EbayApiResponse = await res.json()

      if (!res.ok) {
        throw new Error((data as { error?: string }).error ?? 'eBay request failed')
      }

      setIsMock(!!data._mock)
      const analysis = analyzeCard(data, form)
      setResult(analysis)

      // Save to Supabase
      await saveLookup(form, data.raw.avg, analysis)

      setTimeout(() => {
        resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }, 100)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Something went wrong.')
    } finally {
      setLoading(false)
    }
  }

  async function saveLookup(form: CardFormData, rawValue: number, analysis: AnalysisResult) {
    const supabase = createClient()
    if (!supabase) return
    const cardName = [form.year, form.brand, form.set, form.playerName]
      .filter(Boolean)
      .join(' ')

    await supabase.from('lookups').insert({
      user_id: user.id,
      card_name: cardName,
      raw_value: rawValue,
      result_json: analysis,
    })

    await loadRecentLookups()
  }

  function loadPastLookup(lookup: RecentLookup) {
    setResult(lookup.result_json)
    setIsMock(false)
    setTimeout(() => {
      resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }, 50)
  }

  return (
    <div className="min-h-screen bg-background font-body text-white">
      {/* ─── Header ─── */}
      <header className="sticky top-0 z-40 border-b border-border bg-background/90 backdrop-blur-md">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-5 py-4">
          <a href="/" className="font-heading text-xl text-gold-gradient">GradeIQ</a>

          <div className="flex items-center gap-4">
            <span className="hidden text-sm text-muted sm:block">{user.email}</span>
            <button
              onClick={handleSignOut}
              disabled={signingOut}
              className="btn-outline py-1.5 px-4 text-sm"
            >
              {signingOut ? 'Signing out…' : 'Sign Out'}
            </button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-6xl px-5 py-10 lg:py-14">
        <div className="grid gap-10 lg:grid-cols-[1fr_280px]">
          {/* ─── Left: form + results ─── */}
          <div className="flex flex-col gap-8">
            {/* Form card */}
            <div>
              <div className="mb-5">
                <h1 className="font-heading text-3xl text-white">Card Analyzer</h1>
                <p className="mt-1 text-sm text-muted">
                  Enter card details to get grade-by-grade ROI across all PSA submission tiers.
                </p>
              </div>

              <div className="card">
                <CardLookupForm onSubmit={handleAnalyze} loading={loading} />
              </div>
            </div>

            {error && (
              <div className="rounded-lg border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-400">
                {error}
              </div>
            )}

            {/* Results */}
            {result && (
              <div ref={resultsRef}>
                <ResultsTable result={result} isMock={isMock} />
              </div>
            )}

            {!result && !loading && (
              <div className="flex flex-col items-center gap-3 py-16 text-center opacity-40">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" className="text-gold">
                  <circle cx="11" cy="11" r="8" />
                  <path d="m21 21-4.35-4.35" />
                </svg>
                <p className="text-sm text-muted">Your results will appear here</p>
              </div>
            )}
          </div>

          {/* ─── Right: recent lookups ─── */}
          <aside className="flex flex-col gap-4">
            <h2 className="text-sm font-semibold uppercase tracking-wider text-muted">
              Recent Lookups
            </h2>

            {recentLookups.length === 0 ? (
              <p className="text-xs text-muted/60">No lookups yet. Analyze a card to get started.</p>
            ) : (
              <div className="flex flex-col gap-2">
                {recentLookups.map(lookup => (
                  <button
                    key={lookup.id}
                    onClick={() => loadPastLookup(lookup)}
                    className="group flex flex-col gap-1 rounded-lg border border-border bg-surface p-3 text-left transition-colors hover:border-gold/40 hover:bg-surface-2"
                  >
                    <span className="text-sm font-medium text-white group-hover:text-gold transition-colors line-clamp-2">
                      {lookup.card_name}
                    </span>
                    {lookup.raw_value != null && lookup.raw_value > 0 && (
                      <span className="text-xs text-muted">
                        Raw avg ${lookup.raw_value.toFixed(0)}
                      </span>
                    )}
                    <span className="text-xs text-muted/60">
                      {new Date(lookup.created_at).toLocaleDateString()}
                    </span>
                  </button>
                ))}
              </div>
            )}

            {/* Grading fee reference */}
            <div className="mt-4 rounded-xl border border-border bg-surface p-4">
              <p className="mb-3 text-xs font-semibold uppercase tracking-wider text-muted">PSA Fees</p>
              <div className="flex flex-col gap-1.5">
                {[
                  { name: 'Economy', fee: '$22', time: '20+ days' },
                  { name: 'Regular', fee: '$50', time: '10 days' },
                  { name: 'Express', fee: '$150', time: '5 days' },
                  { name: 'Super Express', fee: '$300', time: '2 days' },
                ].map(t => (
                  <div key={t.name} className="flex items-center justify-between text-xs">
                    <span className="text-muted">{t.name}</span>
                    <span className="font-medium text-white">{t.fee}</span>
                  </div>
                ))}
              </div>
              <p className="mt-3 text-xs text-muted/60">
                Fees current as of 2024. Verify at{' '}
                <a href="https://www.psacard.com/services/tradingcardgrading" target="_blank" rel="noreferrer" className="text-gold/70 hover:text-gold">
                  psacard.com
                </a>
              </p>
            </div>
          </aside>
        </div>
      </main>
    </div>
  )
}
