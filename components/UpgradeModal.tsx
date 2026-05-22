'use client'

import { useState } from 'react'
import { PLANS, stripeConfigured, FREE_TIER_LIMIT } from '@/lib/stripe'

interface Props {
  isOpen: boolean
  onClose: () => void
  lookupCount: number
  resetDate: string
  onRedeemed?: () => void
}

export default function UpgradeModal({ isOpen, onClose, lookupCount, resetDate, onRedeemed }: Props) {
  const [loading, setLoading] = useState<string | null>(null)
  const [error, setError] = useState('')
  const [promoCode, setPromoCode] = useState('')
  const [promoStatus, setPromoStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [promoMessage, setPromoMessage] = useState('')

  const resetFormatted = new Date(resetDate).toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
  })

  async function handleCheckout(planId: 'pro' | 'dealer') {
    setLoading(planId)
    setError('')

    try {
      const res = await fetch('/api/stripe/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ planId }),
      })
      const data = await res.json()

      if (data.billingComingSoon) {
        setError('Billing coming soon! Check back shortly.')
        return
      }
      if (data.url) {
        window.location.href = data.url
      } else {
        setError('Could not start checkout. Please try again.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setLoading(null)
    }
  }

  async function handlePromoRedeem() {
    if (!promoCode.trim()) return
    setPromoStatus('loading')
    setPromoMessage('')

    try {
      const res = await fetch('/api/redeem', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: promoCode }),
      })
      const data = await res.json()

      if (data.success) {
        setPromoStatus('success')
        if (data.granted) {
          const planLabel = data.granted === 'pro' ? 'Pro' : 'Dealer'
          setPromoMessage(
            data.days
              ? `${planLabel} access activated for ${data.days} days! Closing…`
              : `${planLabel} access activated! Closing…`
          )
        } else if (data.extra_lookups) {
          setPromoMessage(`${data.extra_lookups} bonus lookups added! Closing…`)
        } else {
          setPromoMessage('Code redeemed!')
        }
        setPromoCode('')
        onRedeemed?.()
        setTimeout(onClose, 1800)
      } else {
        setPromoStatus('error')
        const msgs: Record<string, string> = {
          invalid_code: 'Invalid or inactive code.',
          expired_code: 'This code has expired.',
          code_exhausted: 'This code has reached its usage limit.',
          already_redeemed: 'You\'ve already used this code.',
        }
        setPromoMessage(msgs[data.error] ?? 'Something went wrong.')
      }
    } catch {
      setPromoStatus('error')
      setPromoMessage('Could not apply code. Try again.')
    }
  }

  if (!isOpen) return null

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="absolute inset-0 bg-black/70 backdrop-blur-sm" />

      <div className="relative w-full max-w-lg animate-slide-up rounded-2xl border border-border bg-surface p-8 shadow-2xl">
        {/* Close */}
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded-md p-1 text-muted hover:text-white transition-colors"
        >
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M18 6L6 18M6 6l12 12" />
          </svg>
        </button>

        {/* Usage indicator */}
        <div className="mb-6 text-center">
          <div className="mx-auto mb-3 flex h-14 w-14 items-center justify-center rounded-full border border-gold/30 bg-gold-muted">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" className="text-gold">
              <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" />
            </svg>
          </div>
          <h2 className="font-heading text-2xl text-white">You've hit the free limit</h2>
          <p className="mt-2 text-sm text-muted">
            {lookupCount}/{FREE_TIER_LIMIT} lookups used this month.
            Resets <span className="text-white">{resetFormatted}</span>.
          </p>

          {/* Progress bar */}
          <div className="mx-auto mt-4 h-2 w-48 overflow-hidden rounded-full bg-border">
            <div
              className="h-full rounded-full bg-gold transition-all"
              style={{ width: `${Math.min((lookupCount / FREE_TIER_LIMIT) * 100, 100)}%` }}
            />
          </div>
        </div>

        {/* Coming soon banner (no Stripe keys) */}
        {!stripeConfigured && (
          <div className="mb-5 rounded-lg border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-center text-sm text-amber-400">
            Billing coming soon — check back shortly or{' '}
            <a href="/#waitlist" className="font-medium underline" onClick={onClose}>
              join the waitlist
            </a>{' '}
            to be notified.
          </div>
        )}

        {/* Plan cards */}
        <div className="grid grid-cols-2 gap-4">
          {(['pro', 'dealer'] as const).map(planId => {
            const plan = PLANS[planId]
            return (
              <div
                key={planId}
                className={`rounded-xl border p-5 ${
                  planId === 'pro'
                    ? 'border-gold/40 bg-gold-muted'
                    : 'border-border bg-surface-2'
                }`}
              >
                <div className="flex items-center justify-between">
                  <span className="font-heading text-lg text-white">{plan.name}</span>
                  {planId === 'pro' && (
                    <span className="rounded-full bg-gold px-2 py-0.5 text-xs font-semibold text-black">
                      Popular
                    </span>
                  )}
                </div>
                <div className="mt-1">
                  <span className="font-heading text-2xl text-white">${plan.price}</span>
                  <span className="text-xs text-muted">/mo</span>
                </div>
                <p className="mt-2 text-xs text-muted">{plan.tagline}</p>

                <button
                  onClick={() => handleCheckout(planId)}
                  disabled={!stripeConfigured || loading !== null}
                  className={`mt-4 w-full rounded-lg py-2.5 text-sm font-semibold transition-colors disabled:opacity-50 disabled:cursor-not-allowed ${
                    planId === 'pro' ? 'btn-gold' : 'btn-outline'
                  }`}
                >
                  {loading === planId ? 'Redirecting…' : `Get ${plan.name}`}
                </button>
              </div>
            )
          })}
        </div>

        {error && (
          <p className="mt-4 text-center text-sm text-amber-400">{error}</p>
        )}

        <p className="mt-5 text-center text-xs text-muted">
          Cancel anytime · No hidden fees ·{' '}
          <a href="/pricing" className="text-gold/70 hover:text-gold" onClick={onClose}>
            See full comparison →
          </a>
        </p>

        {/* Promo code redemption */}
        <div className="mt-5 border-t border-border pt-5">
          <p className="mb-2 text-center text-xs text-muted">Have a promo code?</p>
          <div className="flex gap-2">
            <input
              value={promoCode}
              onChange={e => { setPromoCode(e.target.value.toUpperCase()); setPromoStatus('idle'); setPromoMessage('') }}
              onKeyDown={e => e.key === 'Enter' && handlePromoRedeem()}
              placeholder="ENTER CODE"
              className="min-w-0 flex-1 rounded-lg border border-border bg-background px-3 py-2 text-sm uppercase tracking-widest text-white placeholder-muted/40 outline-none focus:border-gold/50"
              disabled={promoStatus === 'loading' || promoStatus === 'success'}
            />
            <button
              onClick={handlePromoRedeem}
              disabled={!promoCode.trim() || promoStatus === 'loading' || promoStatus === 'success'}
              className="shrink-0 rounded-lg border border-gold/40 bg-gold-muted px-4 py-2 text-sm font-semibold text-gold hover:bg-gold/20 disabled:opacity-40 transition-colors"
            >
              {promoStatus === 'loading' ? '…' : 'Apply'}
            </button>
          </div>
          {promoMessage && (
            <p className={`mt-2 text-center text-xs ${promoStatus === 'success' ? 'text-emerald-400' : 'text-red-400'}`}>
              {promoMessage}
            </p>
          )}
        </div>
      </div>
    </div>
  )
}
