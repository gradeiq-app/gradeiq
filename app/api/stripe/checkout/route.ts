import { NextRequest, NextResponse } from 'next/server'
import { stripe, stripeConfigured, PLANS, type PlanId } from '@/lib/stripe'
import { createClient } from '@/lib/supabase-server'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL ?? 'http://localhost:3000'

export async function POST(request: NextRequest) {
  // Graceful degradation — no Stripe keys yet
  if (!stripeConfigured || !stripe) {
    return NextResponse.json({ billingComingSoon: true })
  }

  let body: { planId?: string }
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const planId = body.planId as PlanId
  const plan = PLANS[planId]
  if (!plan) {
    return NextResponse.json({ error: 'Invalid plan' }, { status: 400 })
  }
  if (!plan.priceId) {
    return NextResponse.json({ error: 'Price ID not configured' }, { status: 500 })
  }

  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  // Get or create Stripe customer
  const { data: profile } = await supabase
    .from('profiles')
    .select('stripe_customer_id')
    .eq('id', user.id)
    .single()

  let customerId = profile?.stripe_customer_id ?? null

  if (!customerId) {
    const customer = await stripe.customers.create({
      email: user.email ?? undefined,
      metadata: { supabase_user_id: user.id },
    })
    customerId = customer.id
    await supabase
      .from('profiles')
      .update({ stripe_customer_id: customerId })
      .eq('id', user.id)
  }

  const session = await stripe.checkout.sessions.create({
    customer: customerId,
    payment_method_types: ['card'],
    line_items: [{ price: plan.priceId, quantity: 1 }],
    mode: 'subscription',
    success_url: `${BASE_URL}/analyze?upgraded=true`,
    cancel_url: `${BASE_URL}/pricing`,
    metadata: { supabase_user_id: user.id, plan: planId },
  })

  return NextResponse.json({ url: session.url })
}
