import { NextRequest, NextResponse } from 'next/server'
import { requireAdmin, getServiceClient } from '@/lib/supabase-admin'

export async function GET() {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = getServiceClient()
  if (!db) return NextResponse.json({ error: 'Service role key not configured' }, { status: 503 })

  const { data, error } = await db
    .from('promo_codes')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) return NextResponse.json({ error: error.message }, { status: 500 })
  return NextResponse.json(data)
}

export async function POST(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = getServiceClient()
  if (!db) return NextResponse.json({ error: 'Service role key not configured' }, { status: 503 })

  const body = await request.json()
  const {
    code, description,
    extra_lookups, grants_plan, grants_plan_days,
    max_uses, expires_at,
  } = body as {
    code: string
    description?: string
    extra_lookups?: number | null
    grants_plan?: 'pro' | 'dealer' | null
    grants_plan_days?: number | null
    max_uses?: number | null
    expires_at?: string | null
  }

  if (!code?.trim()) return NextResponse.json({ error: 'Code is required' }, { status: 400 })

  const { data, error } = await db
    .from('promo_codes')
    .insert({
      code: code.trim().toUpperCase(),
      description: description?.trim() || null,
      extra_lookups: extra_lookups || null,
      grants_plan: grants_plan || null,
      grants_plan_days: grants_plan_days || null,
      max_uses: max_uses || null,
      expires_at: expires_at || null,
    })
    .select()
    .single()

  if (error) return NextResponse.json({ error: error.message }, { status: 400 })
  return NextResponse.json(data, { status: 201 })
}
