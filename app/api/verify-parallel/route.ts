/**
 * POST /api/verify-parallel
 *
 * Accepts a card photo + parallel metadata, fetches a reference image from
 * eBay, and uses Anthropic Vision to compare them.
 *
 * Multipart form fields:
 *   parallel_label   — display label, e.g. "Gold Refractor /50"
 *   parallel_ebay_kw — eBay keyword suffix, e.g. "Gold Refractor"
 *   set_id           — UUID from sets table (optional)
 *   year             — e.g. "2024"
 *   brand            — e.g. "Topps"
 *   set_name         — e.g. "Chrome"
 *   sport            — e.g. "baseball"
 *   card_image       — File (jpg/png/webp/heic, max 10 MB)
 *
 * Rate limits:
 *   Free:        10 verifications / user / 24 h
 *   Pro/Dealer:  unlimited
 */
import { NextRequest, NextResponse } from 'next/server'
import Anthropic from '@anthropic-ai/sdk'
import { createClient } from '@/lib/supabase-server'
import { getServiceClient } from '@/lib/supabase-admin'
import type { VerifyAIResult } from '@/lib/types'

export const dynamic = 'force-dynamic'

const FREE_DAILY_LIMIT = 10
const MAX_FILE_BYTES   = parseInt(process.env.NEXT_PUBLIC_MAX_VERIFY_FILE_SIZE ?? '10485760')

// ─── eBay token cache (shared with main eBay route) ──────────────────────────
let _ebayToken    = ''
let _ebayExpires  = 0

async function getEbayToken(): Promise<string> {
  if (_ebayToken && Date.now() < _ebayExpires) return _ebayToken
  const id  = process.env.EBAY_API_KEY        ?? ''
  const sec = process.env.EBAY_CLIENT_SECRET  ?? ''
  if (!id || !sec) throw new Error('eBay credentials missing')
  const creds = Buffer.from(`${id}:${sec}`).toString('base64')
  const res   = await fetch('https://api.ebay.com/identity/v1/oauth2/token', {
    method: 'POST',
    headers: { Authorization: `Basic ${creds}`, 'Content-Type': 'application/x-www-form-urlencoded' },
    body:    'grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope',
    cache:   'no-store',
  })
  if (!res.ok) throw new Error('eBay token failed')
  const d = await res.json()
  _ebayToken   = d.access_token
  _ebayExpires = Date.now() + (d.expires_in - 600) * 1000
  return _ebayToken
}

/** Fetch a reference image URL from eBay for this parallel. */
async function fetchReferenceImageFromEbay(
  year: string, brand: string, setName: string,
  parallelEbayKw: string, sport: string,
): Promise<string | null> {
  try {
    const token   = await getEbayToken()
    const kw      = parallelEbayKw || ''
    // Search for PSA-graded version — cleaner isolated card image
    const queries = [
      [year, brand, setName, kw, 'PSA 10'].filter(Boolean).join(' '),
      [year, brand, setName, kw, 'PSA 9'].filter(Boolean).join(' '),
      [year, brand, setName, kw].filter(Boolean).join(' '),
    ]
    for (const q of queries) {
      const params = new URLSearchParams({
        q, limit: '5', filter: 'buyingOptions:{FIXED_PRICE|AUCTION}',
      })
      const res = await fetch(
        `https://api.ebay.com/buy/browse/v1/item_summary/search?${params}`,
        { headers: { Authorization: `Bearer ${token}`, 'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US' }, cache: 'no-store' },
      )
      if (!res.ok) continue
      const data = await res.json()
      const item = (data.itemSummaries ?? []).find(
        (i: Record<string, unknown>) => (i.image as Record<string, string>)?.imageUrl,
      )
      if (item) return (item.image as Record<string, string>).imageUrl
    }
    return null
  } catch {
    return null
  }
}

/** Build the AI system + user prompt. */
function buildPrompt(
  parallelLabel: string, year: string, brand: string,
  setName: string, sport: string,
): string {
  return `You are a sports card parallel identification expert. You will be shown two images:
1. A reference image of a ${parallelLabel} parallel from ${year} ${brand} ${setName} (${sport})
2. A photo of a card the user believes is the same parallel

Analyze both images and respond ONLY with valid JSON in this exact format (no markdown, no extra text):
{
  "match": true | false | "uncertain",
  "confidence": 0-100,
  "verdict": "CONFIRMED" | "LIKELY MATCH" | "POSSIBLE MISMATCH" | "MISMATCH",
  "reasoning": "2-3 sentence plain English explanation",
  "visual_checks": [
    { "feature": "Border color", "reference": "Gold", "observed": "describe what you see", "match": true | false }
  ],
  "warnings": ["warning if any — empty array if none"]
}

Rules:
- If confidence < 60, set match to "uncertain" and verdict to "POSSIBLE MISMATCH" or "MISMATCH" as appropriate
- If the user's photo is too blurry, dark, or unclear to evaluate, set confidence to 0 and verdict to "MISMATCH" with a warning "Photo quality too low — try again in better lighting"
- Check: border treatment, surface pattern (holo/refractor/matte), print run if visible, color tints, any text identifiers`
}

// ─── Parse + validate Anthropic response ─────────────────────────────────────
function parseAIResponse(raw: string): VerifyAIResult | null {
  try {
    // Strip markdown code fences if present
    const cleaned = raw.replace(/^```(?:json)?\n?/, '').replace(/\n?```$/, '').trim()
    const parsed  = JSON.parse(cleaned) as VerifyAIResult
    // Basic validation
    if (!['CONFIRMED', 'LIKELY MATCH', 'POSSIBLE MISMATCH', 'MISMATCH'].includes(parsed.verdict)) return null
    if (typeof parsed.confidence !== 'number') return null
    // Clamp confidence
    if (parsed.confidence < 60 && parsed.match !== 'uncertain') {
      parsed.match = 'uncertain'
    }
    return parsed
  } catch {
    return null
  }
}

// ─── Route handler ────────────────────────────────────────────────────────────

export async function POST(request: NextRequest) {
  // ── 1. Auth ──────────────────────────────────────────────────────────────
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) {
    return NextResponse.json({ ok: false, error: 'not_authenticated', message: 'Sign in required' }, { status: 401 })
  }

  // ── 2. Parse form data ───────────────────────────────────────────────────
  let formData: FormData
  try {
    formData = await request.formData()
  } catch {
    return NextResponse.json({ ok: false, error: 'unknown', message: 'Invalid form data' }, { status: 400 })
  }

  const parallelLabel  = (formData.get('parallel_label')   as string | null) ?? ''
  const parallelEbayKw = (formData.get('parallel_ebay_kw') as string | null) ?? ''
  const setId          = (formData.get('set_id')           as string | null) ?? null
  const year           = (formData.get('year')             as string | null) ?? ''
  const brand          = (formData.get('brand')            as string | null) ?? ''
  const setName        = (formData.get('set_name')         as string | null) ?? ''
  const sport          = (formData.get('sport')            as string | null) ?? ''
  const imageFile      = formData.get('card_image') as File | null

  if (!parallelLabel || !year || !brand || !imageFile) {
    return NextResponse.json(
      { ok: false, error: 'unknown', message: 'parallel_label, year, brand, and card_image are required' },
      { status: 400 },
    )
  }

  // ── 3. Validate image size ───────────────────────────────────────────────
  if (imageFile.size > MAX_FILE_BYTES) {
    return NextResponse.json(
      { ok: false, error: 'unknown', message: `File too large — maximum is ${Math.round(MAX_FILE_BYTES / 1048576)} MB` },
      { status: 400 },
    )
  }

  // ── 4. Rate limit check ──────────────────────────────────────────────────
  const sb = getServiceClient()
  if (sb) {
    // Check plan
    const { data: profile } = await sb
      .from('profiles')
      .select('plan, promo_plan, promo_plan_expires_at')
      .eq('id', user.id)
      .single()

    const promoActive = !!(
      profile?.promo_plan &&
      (!profile.promo_plan_expires_at || new Date(profile.promo_plan_expires_at) > new Date())
    )
    const effectivePlan = promoActive ? profile!.promo_plan! : (profile?.plan ?? 'free')

    if (effectivePlan === 'free') {
      const since = new Date(Date.now() - 24 * 3600 * 1000).toISOString()
      const { count } = await sb
        .from('parallel_verifications')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', user.id)
        .gte('created_at', since)

      if ((count ?? 0) >= FREE_DAILY_LIMIT) {
        return NextResponse.json(
          { ok: false, error: 'rate_limited', message: `Free users can run ${FREE_DAILY_LIMIT} verifications per day. Upgrade to Pro for unlimited.` },
          { status: 429 },
        )
      }
    }
  }

  // ── 5. Fetch reference image from eBay ───────────────────────────────────
  const referenceUrl = await fetchReferenceImageFromEbay(year, brand, setName, parallelEbayKw, sport)
  const referenceSource: 'ebay' | 'none' = referenceUrl ? 'ebay' : 'none'

  if (!referenceUrl) {
    // Log as "unavailable" — still useful to track
    if (sb) {
      await sb.from('parallel_verifications').insert({
        user_id: user.id,
        set_id:  setId,
        parallel_label: parallelLabel,
        sport, year: parseInt(year), brand, set_name: setName,
        verdict: 'UNAVAILABLE',
        confidence: 0,
        reference_source: 'none',
      }).catch(() => {})
    }
    return NextResponse.json(
      { ok: false, error: 'no_reference', message: 'No reference image found for this parallel yet. Try the reference viewer or proceed without verification.' },
      { status: 422 },
    )
  }

  // ── 6. Encode user image ─────────────────────────────────────────────────
  const imageBuffer = await imageFile.arrayBuffer()
  const base64Image = Buffer.from(imageBuffer).toString('base64')
  const mimeType    = (imageFile.type || 'image/jpeg') as 'image/jpeg' | 'image/png' | 'image/gif' | 'image/webp'

  // ── 7. Call Anthropic Vision API ─────────────────────────────────────────
  const anthropicKey = process.env.ANTHROPIC_API_KEY
  if (!anthropicKey) {
    return NextResponse.json(
      { ok: false, error: 'api_unavailable', message: 'AI verification is not configured on this deployment.' },
      { status: 503 },
    )
  }

  let aiResult: VerifyAIResult
  try {
    const anthropic = new Anthropic({ apiKey: anthropicKey })
    const response  = await anthropic.messages.create({
      model:      'claude-opus-4-5',
      max_tokens: 1024,
      messages: [{
        role:    'user',
        content: [
          // Image 1: reference (from eBay URL)
          {
            type:   'image',
            source: { type: 'url', url: referenceUrl },
          },
          // Image 2: user's uploaded card
          {
            type:   'image',
            source: { type: 'base64', media_type: mimeType, data: base64Image },
          },
          // Prompt
          {
            type: 'text',
            text: buildPrompt(parallelLabel, year, brand, setName, sport),
          },
        ],
      }],
    })

    const rawText = response.content
      .filter(b => b.type === 'text')
      .map(b => (b as { type: 'text'; text: string }).text)
      .join('')

    const parsed = parseAIResponse(rawText)
    if (!parsed) {
      throw new Error('AI returned unparseable response')
    }
    aiResult = parsed
  } catch (err) {
    const msg = err instanceof Error ? err.message : 'Unknown error'
    console.error('[verify-parallel] Anthropic error:', msg)
    return NextResponse.json(
      { ok: false, error: 'api_unavailable', message: 'AI verification timed out or failed. You can proceed without it.' },
      { status: 502 },
    )
  }

  // ── 8. Store result ───────────────────────────────────────────────────────
  let verificationId = ''
  if (sb) {
    const { data: inserted } = await sb
      .from('parallel_verifications')
      .insert({
        user_id:          user.id,
        set_id:           setId,
        parallel_label:   parallelLabel,
        sport,
        year:             parseInt(year),
        brand,
        set_name:         setName,
        verdict:          aiResult.verdict,
        confidence:       aiResult.confidence,
        ai_response_json: aiResult as unknown as Record<string, unknown>,
        reference_source: referenceSource,
      })
      .select('id')
      .single()
    verificationId = inserted?.id ?? ''
  }

  return NextResponse.json({
    ok:               true,
    verdict:          aiResult,
    verification_id:  verificationId,
    reference_source: referenceSource,
    reference_url:    referenceUrl,
  })
}
