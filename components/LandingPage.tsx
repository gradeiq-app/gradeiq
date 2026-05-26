'use client'

import { useState, useEffect, useRef } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase-browser'
import AuthModal from './AuthModal'
import WaitlistForm from './WaitlistForm'
import CardLookupForm from './CardLookupForm'
import ResultsTable from './ResultsTable'
import { analyzeCard } from '@/lib/calculations'
import type { CardFormData, AnalysisResult, EbayApiResponse } from '@/lib/types'
import type { User } from '@supabase/supabase-js'

interface Props {
  initialShowAuth: boolean
}

interface SiteConfig {
  announcement_enabled: string
  announcement_text: string
  announcement_type: string
}

export default function LandingPage({ initialShowAuth }: Props) {
  const [showAuth, setShowAuth] = useState(initialShowAuth)
  const [authMode, setAuthMode] = useState<'login' | 'signup'>('login')
  const [user, setUser] = useState<User | null>(null)
  const [lookupLoading, setLookupLoading] = useState(false)
  const [lookupResult, setLookupResult] = useState<AnalysisResult | null>(null)
  const [lookupError, setLookupError] = useState('')
  const [isMock, setIsMock] = useState(false)
  const [siteConfig, setSiteConfig] = useState<SiteConfig | null>(null)
  const [bannerDismissed, setBannerDismissed] = useState(false)
  const resultsRef = useRef<HTMLDivElement>(null)
  const demoRef = useRef<HTMLDivElement>(null)
  const router = useRouter()

  useEffect(() => {
    const supabase = createClient()
    if (!supabase) return
    supabase.auth.getUser().then(({ data: { user } }) => setUser(user))
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_, session) => {
      setUser(session?.user ?? null)
    })
    return () => subscription.unsubscribe()
  }, [])

  useEffect(() => {
    fetch('/api/admin/config')
      .then(r => r.json())
      .then(setSiteConfig)
      .catch(() => {/* non-critical */})
  }, [])

  async function handleLookup(form: CardFormData) {
    setLookupLoading(true)
    setLookupError('')
    setLookupResult(null)

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
        throw new Error((data as { error?: string }).error ?? 'Failed to fetch data')
      }

      setIsMock(!!data._mock)
      setLookupResult(analyzeCard(data, form))

      setTimeout(() => {
        resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }, 100)
    } catch (err) {
      setLookupError(err instanceof Error ? err.message : 'Something went wrong. Try again.')
    } finally {
      setLookupLoading(false)
    }
  }

  function openLogin() { setAuthMode('login'); setShowAuth(true) }
  function openSignup() { setAuthMode('signup'); setShowAuth(true) }

  const showBanner = !bannerDismissed && siteConfig?.announcement_enabled === 'true' && !!siteConfig.announcement_text
  const bannerStyle =
    siteConfig?.announcement_type === 'success' ? 'border-emerald-500/30 bg-emerald-500/10 text-emerald-400' :
    siteConfig?.announcement_type === 'warning'  ? 'border-amber-500/30 bg-amber-500/10 text-amber-400' :
    'border-blue-500/30 bg-blue-500/10 text-blue-400'

  return (
    <div className="min-h-screen bg-background font-body text-white">
      {/* ─── Announcement banner ─── */}
      {showBanner && (
        <div className={`border-b px-5 py-2.5 text-center text-sm ${bannerStyle}`}>
          {siteConfig!.announcement_text}
          <button onClick={() => setBannerDismissed(true)} className="ml-4 opacity-50 hover:opacity-100">✕</button>
        </div>
      )}

      {/* ─── Nav ─── */}
      <header className="fixed inset-x-0 top-0 z-40 border-b border-border/50 bg-background/80 backdrop-blur-md">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-5 py-4">
          <a href="/" className="font-heading text-xl text-gold-gradient">RawIQ</a>

          <nav className="flex items-center gap-3">
            <a href="/pricing" className="hidden text-sm text-muted hover:text-white transition-colors sm:block">
              Pricing
            </a>
            {user ? (
              <>
                <span className="hidden text-sm text-muted sm:block">{user.email}</span>
                <button onClick={() => router.push('/analyze')} className="btn-gold py-2 px-4 text-sm">
                  Open App
                </button>
              </>
            ) : (
              <>
                <button onClick={openLogin} className="btn-outline py-2 px-4 text-sm">
                  Sign In
                </button>
                <button onClick={openSignup} className="btn-gold py-2 px-4 text-sm">
                  Get Started
                </button>
              </>
            )}
          </nav>
        </div>
      </header>

      {/* ─── Hero ─── */}
      <section className="relative flex min-h-screen flex-col items-center justify-center bg-hero-gradient px-5 pt-20 text-center">
        {/* Background grid */}
        <div
          className="pointer-events-none absolute inset-0 opacity-[0.03]"
          style={{
            backgroundImage: 'linear-gradient(#c8a96e 1px, transparent 1px), linear-gradient(to right, #c8a96e 1px, transparent 1px)',
            backgroundSize: '48px 48px',
          }}
        />

        <div className="relative flex flex-col items-center gap-6 max-w-3xl">
          <span className="inline-flex items-center gap-2 rounded-full border border-gold/30 bg-gold-muted px-4 py-1.5 text-xs font-medium text-gold">
            <span className="h-1.5 w-1.5 rounded-full bg-gold animate-pulse" />
            Powered by real eBay sold data
          </span>

          <h1 className="font-heading text-5xl leading-tight text-white sm:text-6xl lg:text-7xl">
            Know Before{' '}
            <span className="text-gold-gradient">You Slab.</span>
          </h1>

          <p className="max-w-2xl text-lg text-muted sm:text-xl">
            RawIQ analyzes eBay completed listings to calculate your exact ROI for every PSA
            grading tier — Economy, Regular, Express, and Super Express — before you spend a dollar.
          </p>

          <div className="flex flex-wrap items-center justify-center gap-3">
            {user ? (
              <button onClick={() => router.push('/analyze')} className="btn-gold px-8 py-3.5 text-base">
                Open Analyzer →
              </button>
            ) : (
              <>
                <button onClick={openSignup} className="btn-gold px-8 py-3.5 text-base">
                  Try It Free →
                </button>
                <button
                  onClick={() => demoRef.current?.scrollIntoView({ behavior: 'smooth' })}
                  className="btn-outline px-8 py-3.5 text-base"
                >
                  See the Numbers
                </button>
              </>
            )}
          </div>
        </div>

        {/* Stats bar */}
        <div className="relative mt-20 grid w-full max-w-2xl grid-cols-3 gap-px overflow-hidden rounded-2xl border border-border bg-border">
          {[
            { value: '50K+', label: 'Cards Analyzed' },
            { value: '3.2×', label: 'Avg ROI Tracked' },
            { value: 'Free', label: 'To Start' },
          ].map(s => (
            <div key={s.label} className="flex flex-col items-center gap-1 bg-surface px-4 py-5">
              <span className="font-heading text-2xl text-gold">{s.value}</span>
              <span className="text-xs text-muted">{s.label}</span>
            </div>
          ))}
        </div>
      </section>

      {/* ─── How It Works ─── */}
      <section className="mx-auto max-w-6xl px-5 py-24">
        <div className="mb-14 text-center">
          <h2 className="font-heading text-4xl text-white">How It Works</h2>
          <p className="mt-3 text-muted">Three steps from raw card to confident decision.</p>
        </div>

        <div className="grid gap-8 sm:grid-cols-3">
          {[
            {
              n: '01',
              title: 'Enter Your Card',
              desc: 'Player, year, brand, set, card number, and what you paid for the raw card.',
              icon: (
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
              ),
            },
            {
              n: '02',
              title: 'We Pull the Data',
              desc: "Live eBay completed listings — raw, PSA 8, PSA 9, and PSA 10 — averaged over 90 days.",
              icon: (
                <path d="M22 12h-4l-3 9L9 3l-3 9H2" />
              ),
            },
            {
              n: '03',
              title: 'Get Your Verdict',
              desc: 'SUBMIT, CONSIDER, or PASS for every grading tier. ROI and net profit calculated instantly.',
              icon: (
                <><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></>
              ),
            },
          ].map(step => (
            <div key={step.n} className="card flex flex-col gap-4">
              <div className="flex items-center gap-3">
                <span className="font-heading text-3xl text-gold">{step.n}</span>
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" className="text-gold/60">
                  {step.icon}
                </svg>
              </div>
              <h3 className="font-heading text-xl text-white">{step.title}</h3>
              <p className="text-sm text-muted leading-relaxed">{step.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* ─── Live Demo / Card Lookup ─── */}
      <section ref={demoRef} id="demo" className="border-t border-border bg-surface/50 px-5 py-24">
        <div className="mx-auto max-w-4xl">
          <div className="mb-10 text-center">
            <h2 className="font-heading text-4xl text-white">Analyze a Card</h2>
            <p className="mt-3 text-muted">
              Enter any card below to see live ROI estimates. No account required.
            </p>
          </div>

          <div className="card">
            <CardLookupForm onSubmit={handleLookup} loading={lookupLoading} />
          </div>

          {lookupError && (
            <div className="mt-4 rounded-lg border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-400">
              {lookupError}
            </div>
          )}

          {lookupResult && (
            <div ref={resultsRef} className="mt-8">
              <ResultsTable result={lookupResult} isMock={isMock} />

              {!user && (
                <div className="mt-6 rounded-xl border border-gold/30 bg-gold-muted p-6 text-center">
                  <p className="font-heading text-xl text-white">Save your results &amp; track your portfolio</p>
                  <p className="mt-2 text-sm text-muted">Create a free account to save lookups and access the full analyzer.</p>
                  <button onClick={openSignup} className="btn-gold mt-4 px-8">
                    Create Free Account →
                  </button>
                </div>
              )}
            </div>
          )}
        </div>
      </section>

      {/* ─── Waitlist ─── */}
      <section className="mx-auto max-w-6xl px-5 py-24 text-center">
        <h2 className="font-heading text-4xl text-white">Join the Early Access List</h2>
        <p className="mt-3 max-w-xl mx-auto text-muted">
          Be first to know when new features drop — bulk submission optimizer, PSA pop overlays, and portfolio tracking.
        </p>
        <div className="mt-8 flex justify-center">
          <WaitlistForm />
        </div>
      </section>

      {/* ─── Footer ─── */}
      <footer className="border-t border-border px-5 py-10 text-center text-sm text-muted">
        <p className="font-heading text-lg text-gold-gradient mb-2">RawIQ</p>
        <p>© {new Date().getFullYear()} RawIQ. Built for collectors, by collectors.</p>
        <p className="mt-1 text-xs opacity-60">
          eBay data is for informational purposes only. Past sales do not guarantee future results.
        </p>
      </footer>

      {/* ─── Auth Modal ─── */}
      <AuthModal
        isOpen={showAuth}
        initialMode={authMode}
        onClose={() => setShowAuth(false)}
      />
    </div>
  )
}
