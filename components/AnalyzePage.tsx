'use client'

import { useState, useRef, useEffect } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { createClient } from '@/lib/supabase-browser'
import GuidedCardSelector from './GuidedCardSelector'
import ResultsTable from './ResultsTable'
import UpgradeModal from './UpgradeModal'
import { analyzeCard } from '@/lib/calculations'
import { FREE_TIER_LIMIT } from '@/lib/stripe'
import type { CardFormData, AnalysisResult, EbayApiResponse, Profile } from '@/lib/types'
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
  const [profile, setProfile] = useState<Profile | null>(null)
  const [profileLoading, setProfileLoading] = useState(true)
  const [showUpgrade, setShowUpgrade] = useState(false)
  const [upgradeSuccess, setUpgradeSuccess] = useState(false)
  const resultsRef = useRef<HTMLDivElement>(null)
  const router = useRouter()
  const searchParams = useSearchParams()

  // Handle Stripe success redirect
  useEffect(() => {
    if (searchParams.get('upgraded') === 'true') {
      setUpgradeSuccess(true)
      router.replace('/analyze')
      // Refresh profile so new plan is reflected
      setTimeout(() => loadProfile(), 1500)
    }
  }, [searchParams])

  useEffect(() => {
    loadProfile()
    loadRecentLookups()
  }, [])

  async function loadProfile() {
    setProfileLoading(true)
    const supabase = createClient()
    if (!supabase) { setProfileLoading(false); return }

    const { data } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()

    const now = new Date()
    const nextReset = new Date(now.getFullYear(), now.getMonth() + 1, 1)

    if (!data) {
      // Bootstrap profile for users who predate the trigger
      const { data: created } = await supabase
        .from('profiles')
        .insert({ id: user.id, lookup_reset_date: nextReset.toISOString() })
        .select()
        .single()
      setProfile(created as Profile)
    } else if (new Date(data.lookup_reset_date) <= now) {
      // Monthly reset
      await supabase
        .from('profiles')
        .update({ lookup_count: 0, lookup_reset_date: nextReset.toISOString() })
        .eq('id', user.id)
      setProfile({ ...data, lookup_count: 0, lookup_reset_date: nextReset.toISOString() } as Profile)
    } else {
      setProfile(data as Profile)
    }
    setProfileLoading(false)
  }

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
    // Quota check — free users only (promo plan bypasses this)
    if (profile && isFree && profile.lookup_count >= effectiveLimit) {
      setShowUpgrade(true)
      return
    }

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
        parallel: form.parallel ?? '',
      })

      const res = await fetch(`/api/ebay?${params}`)
      const data: EbayApiResponse = await res.json()

      if (!res.ok) throw new Error((data as { error?: string }).error ?? 'eBay request failed')

      setIsMock(!!data._mock)
      const analysis = analyzeCard(data, form)
      setResult(analysis)

      // Persist lookup + increment quota
      await saveAndCount(form, data.raw.avg, analysis)

      setTimeout(() => {
        resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }, 100)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Something went wrong.')
    } finally {
      setLoading(false)
    }
  }

  async function saveAndCount(form: CardFormData, rawValue: number, analysis: AnalysisResult) {
    const supabase = createClient()
    if (!supabase) return

    const cardName = [form.year, form.brand, form.set, form.playerName, form.parallel].filter(Boolean).join(' ')

    // Save lookup to history
    await supabase.from('lookups').insert({
      user_id: user.id,
      card_name: cardName,
      raw_value: rawValue,
      result_json: analysis,
    })

    // Increment count for free users
    if (profile?.plan === 'free') {
      const newCount = (profile.lookup_count ?? 0) + 1
      await supabase
        .from('profiles')
        .update({ lookup_count: newCount })
        .eq('id', user.id)
      setProfile(prev => prev ? { ...prev, lookup_count: newCount } : prev)
    }

    await loadRecentLookups()
  }

  function loadPastLookup(lookup: RecentLookup) {
    setResult(lookup.result_json)
    setIsMock(false)
    setTimeout(() => {
      resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }, 50)
  }

  // Promo plan is active if it exists and either has no expiry or hasn't expired yet
  const promoActive = !!(
    profile?.promo_plan &&
    (!profile.promo_plan_expires_at || new Date(profile.promo_plan_expires_at) > new Date())
  )
  const effectivePlan = promoActive ? profile!.promo_plan! : (profile?.plan ?? 'free')
  const isFree = effectivePlan === 'free'
  const effectiveLimit = FREE_TIER_LIMIT + (profile?.bonus_lookups ?? 0)
  const lookupsLeft = isFree ? Math.max(0, effectiveLimit - (profile?.lookup_count ?? 0)) : null

  return (
    <div className="min-h-screen bg-background font-body text-white">
      {/* ─── Header ─── */}
      <header className="sticky top-0 z-40 border-b border-border bg-background/90 backdrop-blur-md">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-5 py-4">
          <a href="/" className="font-heading text-xl text-gold-gradient">RawIQ</a>
          <div className="flex items-center gap-4">
            <a href="/pricing" className="hidden text-sm text-muted hover:text-white transition-colors sm:block">
              Pricing
            </a>
            <span className="hidden text-sm text-muted sm:block">{user.email}</span>
            <button onClick={handleSignOut} disabled={signingOut} className="btn-outline py-1.5 px-4 text-sm">
              {signingOut ? 'Signing out…' : 'Sign Out'}
            </button>
          </div>
        </div>
      </header>

      {/* ─── Upgrade success banner ─── */}
      {upgradeSuccess && (
        <div className="border-b border-emerald-500/30 bg-emerald-500/10 px-5 py-3 text-center text-sm text-emerald-400">
          🎉 Welcome to the Pro plan! Unlimited lookups are now active.
          <button onClick={() => setUpgradeSuccess(false)} className="ml-4 opacity-60 hover:opacity-100">✕</button>
        </div>
      )}

      <main className="mx-auto max-w-6xl px-5 py-10 lg:py-14">
        <div className="grid gap-10 lg:grid-cols-[1fr_280px]">

          {/* ─── Left ─── */}
          <div className="flex flex-col gap-8">
            <div>
              <div className="mb-5 flex items-start justify-between gap-4">
                <div>
                  <h1 className="font-heading text-3xl text-white">Card Analyzer</h1>
                  <p className="mt-1 text-sm text-muted">
                    Enter card details to get grade-by-grade ROI across all PSA submission tiers.
                  </p>
                </div>

                {/* Quota badge */}
                {!profileLoading && isFree && (
                  <div className="shrink-0 rounded-lg border border-border bg-surface px-3 py-2 text-right">
                    <p className="text-xs text-muted">
                      {(profile?.bonus_lookups ?? 0) > 0 ? 'Free + bonus' : 'Free tier'}
                    </p>
                    <p className={`text-sm font-semibold ${lookupsLeft === 0 ? 'text-red-400' : 'text-white'}`}>
                      {lookupsLeft} / {effectiveLimit} left
                    </p>
                  </div>
                )}
                {!profileLoading && promoActive && (
                  <div className="shrink-0 rounded-lg border border-emerald-500/30 bg-emerald-500/10 px-3 py-2 text-right">
                    <p className="text-xs text-emerald-400">Demo Access</p>
                    <p className="text-sm font-semibold text-white">
                      {effectivePlan === 'pro' ? 'Pro' : 'Dealer'}
                      {profile?.promo_plan_expires_at ? (
                        <span className="ml-1 text-xs font-normal text-emerald-400/70">
                          · expires {new Date(profile.promo_plan_expires_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </span>
                      ) : null}
                    </p>
                  </div>
                )}
                {!profileLoading && !isFree && !promoActive && (
                  <div className="shrink-0 rounded-lg border border-gold/30 bg-gold-muted px-3 py-2 text-right">
                    <p className="text-xs text-gold">
                      {profile?.plan === 'pro' ? 'Pro' : 'Dealer'} Plan
                    </p>
                    <p className="text-sm font-semibold text-white">Unlimited</p>
                  </div>
                )}
              </div>

              <div className="card">
                <GuidedCardSelector onSubmit={handleAnalyze} loading={loading} />
              </div>
            </div>

            {error && (
              <div className="rounded-lg border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-400">
                {error}
              </div>
            )}

            {result && (
              <div ref={resultsRef}>
                <ResultsTable result={result} isMock={isMock} />
              </div>
            )}

            {!result && !loading && (
              <div className="flex flex-col items-center gap-3 py-16 text-center opacity-40">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" className="text-gold">
                  <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
                </svg>
                <p className="text-sm text-muted">Your results will appear here</p>
              </div>
            )}
          </div>

          {/* ─── Right sidebar ─── */}
          <aside className="flex flex-col gap-4">
            <h2 className="text-sm font-semibold uppercase tracking-wider text-muted">Recent Lookups</h2>

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
                    <span className="line-clamp-2 text-sm font-medium text-white group-hover:text-gold transition-colors">
                      {lookup.card_name}
                    </span>
                    {lookup.raw_value != null && lookup.raw_value > 0 && (
                      <span className="text-xs text-muted">Raw avg ${lookup.raw_value.toFixed(0)}</span>
                    )}
                    <span className="text-xs text-muted/60">
                      {new Date(lookup.created_at).toLocaleDateString()}
                    </span>
                  </button>
                ))}
              </div>
            )}

            {/* Plan / upgrade prompt */}
            {!profileLoading && isFree && (
              <div className="rounded-xl border border-gold/20 bg-gold-muted p-4">
                <p className="text-sm font-semibold text-white">Upgrade to Pro</p>
                <p className="mt-1 text-xs text-muted">
                  Unlimited lookups from $4.99/month.
                </p>
                <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-border">
                  <div
                    className="h-full rounded-full bg-gold"
                    style={{ width: `${Math.min(((profile?.lookup_count ?? 0) / effectiveLimit) * 100, 100)}%` }}
                  />
                </div>
                <p className="mt-1.5 text-xs text-muted">
                  {profile?.lookup_count ?? 0}/{effectiveLimit} lookups used · resets{' '}
                  {profile ? new Date(profile.lookup_reset_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }) : '—'}
                </p>
                <a href="/pricing" className="btn-gold mt-3 w-full text-center text-xs py-2 block">
                  See Plans →
                </a>
                <PromoCodeInput onRedeemed={loadProfile} />
              </div>
            )}

            {/* PSA fee reference */}
            <div className="rounded-xl border border-border bg-surface p-4">
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
                Verify current fees at{' '}
                <a href="https://www.psacard.com/services/tradingcardgrading" target="_blank" rel="noreferrer" className="text-gold/70 hover:text-gold">
                  psacard.com
                </a>
              </p>
            </div>
          </aside>
        </div>
      </main>

      {/* ─── Upgrade modal ─── */}
      <UpgradeModal
        isOpen={showUpgrade}
        onClose={() => setShowUpgrade(false)}
        lookupCount={profile?.lookup_count ?? FREE_TIER_LIMIT}
        resetDate={profile?.lookup_reset_date ?? new Date(new Date().getFullYear(), new Date().getMonth() + 1, 1).toISOString()}
        onRedeemed={loadProfile}
      />
    </div>
  )
}

// ─── Promo code redemption widget ────────────────────────────────────────────

interface PromoCodeInputProps {
  onRedeemed: () => void
}

function PromoCodeInput({ onRedeemed }: PromoCodeInputProps) {
  const [expanded, setExpanded] = useState(false)
  const [code, setCode] = useState('')
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [message, setMessage] = useState('')

  async function handleRedeem() {
    if (!code.trim()) return
    setStatus('loading')
    setMessage('')

    try {
      const res = await fetch('/api/redeem', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code }),
      })
      const data = await res.json()

      if (data.success) {
        setStatus('success')
        if (data.granted) {
          const planLabel = data.granted === 'pro' ? 'Pro' : 'Dealer'
          setMessage(
            data.days
              ? `${planLabel} access activated for ${data.days} days!`
              : `${planLabel} access activated!`
          )
        } else if (data.extra_lookups) {
          setMessage(`${data.extra_lookups} bonus lookups added!`)
        } else {
          setMessage('Code redeemed!')
        }
        setCode('')
        onRedeemed()
      } else {
        setStatus('error')
        const msgs: Record<string, string> = {
          invalid_code: 'Invalid or inactive code.',
          expired_code: 'This code has expired.',
          code_exhausted: 'This code has reached its usage limit.',
          already_redeemed: 'You\'ve already used this code.',
        }
        setMessage(msgs[data.error] ?? 'Something went wrong.')
      }
    } catch {
      setStatus('error')
      setMessage('Could not apply code. Try again.')
    }
  }

  if (!expanded) {
    return (
      <button
        onClick={() => setExpanded(true)}
        className="mt-3 w-full text-xs text-muted/70 hover:text-gold transition-colors text-center"
      >
        Have a promo code? →
      </button>
    )
  }

  return (
    <div className="mt-3">
      <div className="flex gap-1.5">
        <input
          value={code}
          onChange={e => { setCode(e.target.value.toUpperCase()); setStatus('idle'); setMessage('') }}
          onKeyDown={e => e.key === 'Enter' && handleRedeem()}
          placeholder="ENTER CODE"
          className="min-w-0 flex-1 rounded-lg border border-border bg-background px-2.5 py-1.5 text-xs uppercase tracking-widest text-white placeholder-muted/40 outline-none focus:border-gold/50"
          disabled={status === 'loading'}
          autoFocus
        />
        <button
          onClick={handleRedeem}
          disabled={!code.trim() || status === 'loading'}
          className="shrink-0 rounded-lg bg-gold/20 px-3 py-1.5 text-xs font-semibold text-gold hover:bg-gold/30 disabled:opacity-40 transition-colors"
        >
          {status === 'loading' ? '…' : 'Apply'}
        </button>
      </div>
      {message && (
        <p className={`mt-1.5 text-xs ${status === 'success' ? 'text-emerald-400' : 'text-red-400'}`}>
          {message}
        </p>
      )}
    </div>
  )
}
