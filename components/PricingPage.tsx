'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase-browser'
import { PLANS, stripeConfigured, FREE_TIER_LIMIT } from '@/lib/stripe'
import type { User } from '@supabase/supabase-js'
import type { PlanName } from '@/lib/stripe'

const FREE_FEATURES = [
  { label: `${FREE_TIER_LIMIT} lookups per month`, included: true },
  { label: 'ROI calculator — all 4 tiers', included: true },
  { label: 'Full lookup history', included: false },
  { label: 'Bulk CSV upload', included: false, soon: true },
]

interface SiteConfig {
  announcement_enabled?: string
  announcement_text?: string
  announcement_type?: string
  pro_display_price?: string
  dealer_display_price?: string
}

export default function PricingPage() {
  const [user, setUser] = useState<User | null>(null)
  const [userPlan, setUserPlan] = useState<PlanName>('free')
  const [loading, setLoading] = useState<string | null>(null)
  const [siteConfig, setSiteConfig] = useState<SiteConfig>({})
  const [bannerDismissed, setBannerDismissed] = useState(false)
  const router = useRouter()

  useEffect(() => {
    const supabase = createClient()
    if (!supabase) return

    supabase.auth.getUser().then(async ({ data: { user } }) => {
      setUser(user)
      if (user) {
        const { data } = await supabase
          .from('profiles')
          .select('plan')
          .eq('id', user.id)
          .single()
        if (data?.plan) setUserPlan(data.plan as PlanName)
      }
    })

    fetch('/api/admin/config').then(r => r.json()).then(setSiteConfig).catch(() => {})
  }, [])

  // Dynamic display prices (fall back to PLANS defaults if not set)
  const proPrice = parseFloat(siteConfig.pro_display_price ?? '') || PLANS.pro.price
  const dealerPrice = parseFloat(siteConfig.dealer_display_price ?? '') || PLANS.dealer.price

  async function handleCheckout(planId: 'pro' | 'dealer') {
    if (!user) {
      router.push('/?auth=required')
      return
    }

    setLoading(planId)
    try {
      const res = await fetch('/api/stripe/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ planId }),
      })
      const data = await res.json()

      if (data.billingComingSoon) {
        alert('Billing is coming soon! Check back shortly.')
        return
      }
      if (data.url) {
        window.location.href = data.url
      }
    } catch {
      alert('Something went wrong. Please try again.')
    } finally {
      setLoading(null)
    }
  }

  const showBanner = !bannerDismissed && siteConfig.announcement_enabled === 'true' && !!siteConfig.announcement_text
  const bannerStyle =
    siteConfig.announcement_type === 'success' ? 'border-emerald-500/30 bg-emerald-500/10 text-emerald-400' :
    siteConfig.announcement_type === 'warning'  ? 'border-amber-500/30 bg-amber-500/10 text-amber-400' :
    'border-blue-500/30 bg-blue-500/10 text-blue-400'

  return (
    <div className="min-h-screen bg-background font-body text-white">
      {/* ─── Announcement banner ─── */}
      {showBanner && (
        <div className={`border-b px-5 py-2.5 text-center text-sm ${bannerStyle}`}>
          {siteConfig.announcement_text}
          <button onClick={() => setBannerDismissed(true)} className="ml-4 opacity-50 hover:opacity-100">✕</button>
        </div>
      )}

      {/* Nav */}
      <header className="border-b border-border bg-background/80 backdrop-blur-md">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-5 py-4">
          <a href="/" className="font-heading text-xl text-gold-gradient">GradeIQ</a>
          <div className="flex items-center gap-3">
            {user ? (
              <a href="/analyze" className="btn-gold py-2 px-4 text-sm">Open App</a>
            ) : (
              <a href="/?auth=required" className="btn-gold py-2 px-4 text-sm">Get Started</a>
            )}
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-6xl px-5 py-20">
        {/* Header */}
        <div className="mb-16 text-center">
          <h1 className="font-heading text-5xl text-white">Simple Pricing</h1>
          <p className="mt-4 text-lg text-muted">
            Start free. Upgrade when you need more.
          </p>
          {!stripeConfigured && (
            <div className="mx-auto mt-4 max-w-sm rounded-full border border-amber-500/30 bg-amber-500/10 px-4 py-2 text-sm text-amber-400">
              Billing coming soon — all features free during beta
            </div>
          )}
        </div>

        {/* Plan cards */}
        <div className="grid gap-6 lg:grid-cols-3">
          {/* Free */}
          <PlanCard
            name="Free"
            price={0}
            tagline="Get started, no card required"
            features={FREE_FEATURES}
            isCurrent={userPlan === 'free'}
            cta={userPlan === 'free' ? 'Current Plan' : 'Downgrade'}
            ctaDisabled={userPlan === 'free'}
            onCta={() => router.push('/analyze')}
          />

          {/* Pro */}
          <PlanCard
            name={PLANS.pro.name}
            price={proPrice}
            tagline={PLANS.pro.tagline}
            features={PLANS.pro.features}
            highlighted
            isCurrent={userPlan === 'pro'}
            cta={
              userPlan === 'pro' ? 'Current Plan' :
              loading === 'pro' ? 'Redirecting…' : 'Upgrade to Pro'
            }
            ctaDisabled={userPlan === 'pro' || loading !== null}
            onCta={() => handleCheckout('pro')}
          />

          {/* Dealer */}
          <PlanCard
            name={PLANS.dealer.name}
            price={dealerPrice}
            tagline={PLANS.dealer.tagline}
            features={PLANS.dealer.features}
            isCurrent={userPlan === 'dealer'}
            cta={
              userPlan === 'dealer' ? 'Current Plan' :
              loading === 'dealer' ? 'Redirecting…' : 'Upgrade to Dealer'
            }
            ctaDisabled={userPlan === 'dealer' || loading !== null}
            onCta={() => handleCheckout('dealer')}
          />
        </div>

        {/* FAQ */}
        <div className="mt-20 grid gap-6 sm:grid-cols-2">
          {[
            {
              q: 'What counts as a lookup?',
              a: 'Each time you click "Analyze Card" counts as one lookup. Viewing past results from your history is free.',
            },
            {
              q: 'When does my free tier reset?',
              a: 'Your 5 free lookups reset on the 1st of each calendar month. Promo codes can add bonus lookups on top of your free allowance.',
            },
            {
              q: 'Can I cancel anytime?',
              a: 'Yes. Cancel from your Stripe billing portal anytime. You keep access until the end of your billing period.',
            },
            {
              q: 'What is bulk CSV upload?',
              a: 'Upload a spreadsheet of cards and get ROI analysis on all of them at once. Launching soon for Dealer plan subscribers.',
            },
          ].map(({ q, a }) => (
            <div key={q} className="card">
              <p className="font-semibold text-white">{q}</p>
              <p className="mt-2 text-sm text-muted leading-relaxed">{a}</p>
            </div>
          ))}
        </div>
      </main>
    </div>
  )
}

interface Feature {
  label: string
  included: boolean
  soon?: boolean
}

interface PlanCardProps {
  name: string
  price: number
  tagline: string
  features: readonly Feature[]
  highlighted?: boolean
  isCurrent?: boolean
  cta: string
  ctaDisabled?: boolean
  onCta: () => void
}

function PlanCard({ name, price, tagline, features, highlighted, isCurrent, cta, ctaDisabled, onCta }: PlanCardProps) {
  return (
    <div className={`relative flex flex-col rounded-2xl border p-7 ${
      highlighted
        ? 'border-gold/60 bg-gold-muted shadow-[0_0_40px_rgba(200,169,110,0.08)]'
        : 'border-border bg-surface'
    }`}>
      {highlighted && (
        <div className="absolute -top-3.5 left-1/2 -translate-x-1/2">
          <span className="rounded-full bg-gold px-4 py-1 text-xs font-semibold text-black">
            Most Popular
          </span>
        </div>
      )}

      <div className="mb-6">
        <h2 className="font-heading text-2xl text-white">{name}</h2>
        <p className="mt-1 text-sm text-muted">{tagline}</p>
        <div className="mt-4 flex items-end gap-1">
          <span className="font-heading text-4xl text-white">${price}</span>
          {price > 0 && <span className="mb-1 text-muted">/month</span>}
        </div>
      </div>

      <ul className="mb-8 flex flex-col gap-3">
        {features.map(f => (
          <li key={f.label} className="flex items-center gap-3 text-sm">
            {f.included ? (
              <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-emerald-500/20 text-emerald-400 text-xs">✓</span>
            ) : (
              <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-border text-muted text-xs">–</span>
            )}
            <span className={f.included ? 'text-white' : 'text-muted'}>
              {f.label}
              {f.soon && (
                <span className="ml-2 rounded-full border border-gold/30 px-1.5 py-0.5 text-xs text-gold">
                  Soon
                </span>
              )}
            </span>
          </li>
        ))}
      </ul>

      <div className="mt-auto">
        <button
          onClick={onCta}
          disabled={ctaDisabled}
          className={`w-full rounded-lg py-3 text-sm font-semibold transition-colors ${
            isCurrent
              ? 'border border-border bg-transparent text-muted cursor-default'
              : highlighted
              ? 'btn-gold'
              : 'btn-outline'
          }`}
        >
          {cta}
        </button>
      </div>
    </div>
  )
}
