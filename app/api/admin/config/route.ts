import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase-server'
import { requireAdmin } from '@/lib/supabase-admin'

/** Public read — anyone (including the landing page) can fetch site config. */
export async function GET() {
  const supabase = await createClient()
  const { data } = await supabase.from('site_config').select('key, value')
  const config = Object.fromEntries((data ?? []).map(row => [row.key, row.value]))
  return NextResponse.json(config)
}

/** Admin-only write — uses SECURITY DEFINER function so no service role key needed. */
export async function POST(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const supabase = await createClient()
  const updates = await request.json() as Record<string, string>

  const errors: string[] = []
  for (const [key, value] of Object.entries(updates)) {
    const { error } = await supabase.rpc('admin_set_config', { p_key: key, p_value: String(value) })
    if (error) errors.push(`${key}: ${error.message}`)
  }

  if (errors.length) return NextResponse.json({ error: errors.join('; ') }, { status: 400 })
  return NextResponse.json({ saved: true })
}
