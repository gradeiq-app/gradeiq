/**
 * eBay Marketplace Account Deletion / Closure Notification endpoint.
 *
 * eBay requires this endpoint to be registered in the developer portal before
 * they will enable your Production keyset.
 *
 * GET  — eBay challenge verification (proves we own the URL)
 * POST — Deletion/closure notification (we acknowledge receipt)
 *
 * Docs: https://developer.ebay.com/marketplace-account-deletion
 */
import { createHash } from 'crypto'
import { NextRequest, NextResponse } from 'next/server'

const VERIFICATION_TOKEN = process.env.EBAY_VERIFICATION_TOKEN ?? ''
const ENDPOINT_URL = 'https://gradeiq-beta.vercel.app/api/ebay/notification'

/**
 * GET — eBay sends ?challenge_code=xxxx to verify we own the endpoint.
 * We must respond with SHA-256(challengeCode + verificationToken + endpointUrl).
 */
export async function GET(request: NextRequest) {
  const challengeCode = request.nextUrl.searchParams.get('challenge_code')

  if (!challengeCode) {
    return NextResponse.json({ error: 'Missing challenge_code' }, { status: 400 })
  }

  if (!VERIFICATION_TOKEN) {
    console.error('[ebay/notification] EBAY_VERIFICATION_TOKEN is not set')
    return NextResponse.json({ error: 'Endpoint not configured' }, { status: 500 })
  }

  const hash = createHash('sha256')
    .update(challengeCode + VERIFICATION_TOKEN + ENDPOINT_URL)
    .digest('hex')

  // eBay requires this exact response shape
  return NextResponse.json({ challengeResponse: hash })
}

/**
 * POST — eBay notifies us when a marketplace user requests account deletion.
 * GradeIQ does not store eBay user accounts (users sign up with email/password,
 * not eBay OAuth), so there is no user data to delete. We just acknowledge.
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    // Log for audit trail — in a real app you'd verify the eBay signature
    // and delete any stored data associated with body.notification.data.userId
    console.log('[ebay/notification] Deletion notification received:', JSON.stringify(body))
  } catch {
    // Non-JSON body is fine — just acknowledge
  }

  return NextResponse.json({ acknowledged: true })
}
