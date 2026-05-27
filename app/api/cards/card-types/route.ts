/**
 * GET /api/cards/card-types?setId=&playerId=
 *
 * Returns the distinct card types a given player has within a given set,
 * each paired with the specific card_id so the parallel selector can scope
 * to that exact card. Used by Step 6 of the guided card selector.
 *
 * Response shape:
 *   {
 *     types: [
 *       { card_type: 'base',      subset_name: null,             card_id, card_number, label: 'Base' },
 *       { card_type: 'insert',    subset_name: 'Prizm Emergent', card_id, card_number, label: 'Prizm Emergent' },
 *       { card_type: 'autograph', subset_name: 'Signatures',     card_id, card_number, label: 'Signatures' },
 *     ]
 *   }
 *
 * If multiple cards share the same (card_type, subset_name) for one player —
 * e.g. variation prints — we collapse to one entry per tuple and pick the
 * lowest card_id. Caller treats that representative as the canonical card
 * for parallel scoping.
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

interface CardRow {
  id:          string
  card_number: string | null
  card_type:   string | null
  subset_name: string | null
}

interface TypeEntry {
  card_type:   string
  subset_name: string | null
  card_id:     string
  card_number: string | null
  label:       string
}

const TYPE_ORDER: Record<string, number> = {
  base:       0,
  insert:     1,
  autograph:  2,
  auto_relic: 3,
  relic:      4,
}

function labelFor(card_type: string, subset_name: string | null): string {
  if (card_type === 'base') return 'Base'
  if (subset_name && subset_name.trim()) return subset_name.trim()
  // Fall back to a friendly capitalisation of the type when there's no subset name.
  switch (card_type) {
    case 'insert':     return 'Insert'
    case 'autograph':  return 'Autograph'
    case 'relic':      return 'Relic'
    case 'auto_relic': return 'Auto Relic'
    default:           return card_type
  }
}

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  const setId    = searchParams.get('setId')    ?? searchParams.get('set_id')
  const playerId = searchParams.get('playerId') ?? searchParams.get('player_id')
  if (!setId || !playerId) {
    return NextResponse.json(
      { error: 'setId/set_id and playerId/player_id both required' },
      { status: 400 },
    )
  }

  const supabase = createClient(url, key)

  const { data, error } = await supabase
    .from('cards')
    .select('id, card_number, card_type, subset_name')
    .eq('set_id', setId)
    .eq('player_id', playerId)

  if (error) {
    console.error('[cards/card-types] Supabase error', error.message)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  // Collapse to one entry per (card_type, subset_name) tuple. When duplicates
  // exist (e.g. photo variations of the same base card) we pick the smallest
  // card_id as the canonical representative.
  const bucket = new Map<string, TypeEntry>()
  for (const row of (data ?? []) as CardRow[]) {
    const ct = (row.card_type ?? 'base').trim().toLowerCase()
    const sn = row.subset_name && row.subset_name.trim() ? row.subset_name.trim() : null
    const k  = `${ct}::${sn ?? ''}`
    const existing = bucket.get(k)
    if (!existing || row.id < existing.card_id) {
      bucket.set(k, {
        card_type:   ct,
        subset_name: sn,
        card_id:     row.id,
        card_number: row.card_number ?? null,
        label:       labelFor(ct, sn),
      })
    }
  }

  const types = Array.from(bucket.values()).sort((a, b) => {
    const oa = TYPE_ORDER[a.card_type] ?? 99
    const ob = TYPE_ORDER[b.card_type] ?? 99
    if (oa !== ob) return oa - ob
    return (a.subset_name ?? '').localeCompare(b.subset_name ?? '')
  })

  return NextResponse.json(
    { types },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}
