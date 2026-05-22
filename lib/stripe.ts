import Stripe from 'stripe'

// Graceful degradation — app works without Stripe keys (free tier still enforced)
const key = process.env.STRIPE_SECRET_KEY

export const stripeConfigured = Boolean(key && !key.startsWith('sk_placeholder'))

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export const stripe: Stripe | null = stripeConfigured ? new Stripe(key! as any) : null

// ─── Free tier ───────────────────────────────────────────────
export const FREE_TIER_LIMIT = 5

// ─── Plans ───────────────────────────────────────────────────
export const PLANS = {
  pro: {
    id: 'pro' as const,
    name: 'Pro',
    price: 9,
    priceId: process.env.STRIPE_PRO_PRICE_ID ?? '',
    tagline: 'For serious collectors',
    features: [
      { label: 'Unlimited lookups', included: true },
      { label: 'Full lookup history', included: true },
      { label: 'ROI calculator — all 4 tiers', included: true },
      { label: 'Bulk CSV upload', included: false, soon: true },
    ],
  },
  dealer: {
    id: 'dealer' as const,
    name: 'Dealer',
    price: 29,
    priceId: process.env.STRIPE_DEALER_PRICE_ID ?? '',
    tagline: 'For dealers & flippers',
    features: [
      { label: 'Unlimited lookups', included: true },
      { label: 'Full lookup history', included: true },
      { label: 'ROI calculator — all 4 tiers', included: true },
      { label: 'Bulk CSV upload', included: true, soon: true },
    ],
  },
} as const

export type PlanId = keyof typeof PLANS
export type PlanName = 'free' | PlanId

export function getPlanFromPriceId(priceId: string): PlanName {
  if (priceId === process.env.STRIPE_PRO_PRICE_ID) return 'pro'
  if (priceId === process.env.STRIPE_DEALER_PRICE_ID) return 'dealer'
  return 'free'
}
