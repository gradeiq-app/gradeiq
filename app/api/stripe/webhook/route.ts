import { NextRequest, NextResponse } from 'next/server'
import { stripe, stripeConfigured, getPlanFromPriceId } from '@/lib/stripe'
import { createServerClient } from '@supabase/ssr'
import type Stripe from 'stripe'

// Webhook needs the service role key to bypass RLS and update any user's profile
function getServiceClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

  if (!url || !serviceKey) return null

  return createServerClient(url, serviceKey, {
    cookies: { get: () => undefined, set: () => {}, remove: () => {} },
    auth: { persistSession: false },
  })
}

export async function POST(request: NextRequest) {
  // Graceful degradation — no Stripe keys
  if (!stripeConfigured || !stripe) {
    return NextResponse.json({ received: true })
  }

  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET
  if (!webhookSecret) {
    return NextResponse.json({ received: true })
  }

  const body = await request.text()
  const sig = request.headers.get('stripe-signature')

  if (!sig) {
    return NextResponse.json({ error: 'Missing stripe-signature header' }, { status: 400 })
  }

  let event: Stripe.Event
  try {
    event = stripe.webhooks.constructEvent(body, sig, webhookSecret)
  } catch {
    return NextResponse.json({ error: 'Webhook signature verification failed' }, { status: 400 })
  }

  const supabase = getServiceClient()
  if (!supabase) {
    console.warn('[webhook] SUPABASE_SERVICE_ROLE_KEY not set — skipping profile update')
    return NextResponse.json({ received: true })
  }

  switch (event.type) {
    case 'customer.subscription.created':
    case 'customer.subscription.updated': {
      const sub = event.data.object as Stripe.Subscription
      const customerId = sub.customer as string
      const priceId = sub.items.data[0]?.price.id ?? ''
      const plan = getPlanFromPriceId(priceId)
      const active = sub.status === 'active' || sub.status === 'trialing'

      await supabase
        .from('profiles')
        .update({
          plan: active ? plan : 'free',
          stripe_subscription_id: sub.id,
        })
        .eq('stripe_customer_id', customerId)
      break
    }

    case 'customer.subscription.deleted': {
      const sub = event.data.object as Stripe.Subscription
      await supabase
        .from('profiles')
        .update({ plan: 'free', stripe_subscription_id: null })
        .eq('stripe_customer_id', sub.customer as string)
      break
    }

    // checkout.session.completed fires before the subscription events —
    // use it to set plan immediately so users don't see the free tier on return
    case 'checkout.session.completed': {
      const session = event.data.object as Stripe.Checkout.Session
      const userId = session.metadata?.supabase_user_id
      const plan = (session.metadata?.plan ?? 'free') as 'free' | 'pro' | 'dealer'

      if (userId && plan !== 'free') {
        await supabase
          .from('profiles')
          .update({ plan })
          .eq('id', userId)
      }
      break
    }
  }

  return NextResponse.json({ received: true })
}
