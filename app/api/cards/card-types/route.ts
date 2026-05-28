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

  // ─── Hide parallels-as-inserts (Path A of card-type cleanup) ────────────
  // The cards table is double-stamped: ~442k rows with card_type='insert'
  // are actually parallels of base cards (subset_name like 'Base Prizm
  // Silver' or '…Parallel'), seeded by an early bulk import. The same
  // parallels also exist correctly in the `parallels` table. Without this
  // filter, Step 6 surfaces them as selectable card types and Step 7
  // surfaces them again as parallels of the chosen card — the
  // "Silver Prizms appears twice" UX bug.
  //
  // Filter rule (verified 0 false positives on a 4,920-distinct-name
  // sample — see project-beckett-card-type-contamination.md):
  //   HIDE rows where  card_type='insert'
  //                    AND subset_name IS NOT NULL
  //                    AND (subset_name ILIKE 'Base %'
  //                         OR subset_name ILIKE '%Parallel%')
  //
  // KEPT (logical equivalent expressed for PostgREST .or()):
  //   card_type != 'insert'
  //   OR subset_name IS NULL
  //   OR (subset_name NOT ILIKE 'Base %' AND subset_name NOT ILIKE '%Parallel%')
  //
  // Verified scope: 1,817 distinct names / 442,821 rows hidden. Zero
  // genuine inserts hidden (top-60 + bottom-30 sample of 'Base %' and full
  // enumeration of '%Parallel%' all classified as parallels of either
  // base cards or insert sets).
  //
  // Known v1 limitation: ~233k other-bucket parallels still leak through
  // (bare 'Red Prizm', '<Insert> Platinum', 'Game Ticket <Color>',
  // 'Modern Marks Gold', etc.), because a tighter regex would also catch
  // legitimate inserts like 'UD Canvas', 'The Standard', 'Sneak Peek',
  // 'Cracked Ice Ticket', 'Colossal Logoman', 'Materials'. v2 needs
  // per-set parallel_template introspection to disambiguate. Acceptable
  // for now — visible contamination drops from ~675k to ~233k and the
  // 'Silver Prizms twice' bug is fixed for the high-volume Panini Prizm /
  // Mosaic / Select cases.
  //
  // Data is unchanged. This is a display-layer fix. Path B (deletion of
  // these rows) is deferred as a separate audited workstream; if/when it
  // happens, it uses this same boundary.
  // ────────────────────────────────────────────────────────────────────────
  const { data, error } = await supabase
    .from('cards')
    .select('id, card_number, card_type, subset_name')
    .eq('set_id', setId)
    .eq('player_id', playerId)
    .or(
      `card_type.neq.insert,subset_name.is.null,` +
      `and(subset_name.not.ilike.Base *,subset_name.not.ilike.*Parallel*)`,
    )

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
