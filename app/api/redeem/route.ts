import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase-server'
import type { PromoRedeemResult } from '@/lib/types'

export async function POST(request: NextRequest) {
  const { code } = await request.json() as { code?: string }

  if (!code || typeof code !== 'string' || code.trim().length === 0) {
    return NextResponse.json({ error: 'invalid_code' } satisfies PromoRedeemResult, { status: 400 })
  }

  const supabase = await createClient()

  // Verify the user is authenticated
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) {
    return NextResponse.json({ error: 'not_authenticated' } satisfies PromoRedeemResult, { status: 401 })
  }

  // Delegate all validation + application to the SECURITY DEFINER function.
  // This keeps the logic atomic and avoids needing a service-role key here.
  const { data, error } = await supabase.rpc('redeem_promo_code', { p_code: code.trim() })

  if (error) {
    console.error('[redeem] RPC error:', error)
    return NextResponse.json({ error: 'invalid_code' } satisfies PromoRedeemResult, { status: 500 })
  }

  const result = data as PromoRedeemResult

  if (result.error) {
    // Map DB errors to HTTP status codes
    const status = result.error === 'not_authenticated' ? 401
      : result.error === 'already_redeemed' ? 409
      : 400
    return NextResponse.json(result, { status })
  }

  return NextResponse.json(result)
}
