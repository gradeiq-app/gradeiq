/**
 * GET /api/cards/parallels?cardId=
 *   or  /api/cards/parallels?setId=
 *
 * Card mode: parallels for one specific card.
 * Set mode:  distinct parallels across every card in the set. Used by the
 *            guided selector — works even when the cards table is empty for
 *            the chosen set, by falling back to set.parallel_templates JSONB.
 *
 * Always returns a Base entry first, then parallels sorted by print_run DESC
 * (most common to rarest, unnumbered before numbered).
 */
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export const dynamic = 'force-dynamic'

interface ParallelOut {
  id:                  string | null
  label:               string
  ebay_kw:             string
  print_run:           number | null
  reference_image_url: string | null
  visual_identifiers:  string[] | null
  surface_description: string | null
  is_base:             boolean
}

function parsePrintRun(label: string): number | null {
  const m = label.match(/\/(\d+)\b/)
  return m ? parseInt(m[1]) : null
}

/**
 * Canonical "first chase" parallels that should sit right after Base —
 * the unnumbered premium variant that defines each product family.
 * Match is case-insensitive and exact on the trimmed label.
 */
const PROMOTED_LABELS = new Set([
  'silver prizm',
  'silver',
  'refractor',
  'holo',
  'rainbow foil',
  'prism refractor',
  'chrome',
])

function isPromoted(p: ParallelOut): boolean {
  return PROMOTED_LABELS.has(p.label.toLowerCase().trim())
}

function sortParallels(arr: ParallelOut[]): ParallelOut[] {
  return [...arr].sort((a, b) => {
    // 1. Base first
    if (a.is_base && !b.is_base) return -1
    if (!a.is_base && b.is_base) return 1
    if (a.is_base && b.is_base)  return 0

    // 2. Canonical premium parallels (Silver Prizm, Refractor, Holo, etc.)
    //    surface right after Base regardless of print run
    const aP = isPromoted(a)
    const bP = isPromoted(b)
    if (aP && !bP) return -1
    if (!aP && bP) return 1
    if (aP && bP)  return a.label.localeCompare(b.label)

    // 3. Unnumbered before numbered (rarity ascending into the numbered group)
    if (a.print_run == null && b.print_run != null) return -1
    if (a.print_run != null && b.print_run == null) return 1

    // 4. Within unnumbered: alphabetical
    if (a.print_run == null && b.print_run == null) return a.label.localeCompare(b.label)

    // 5. Within numbered: largest print run first (most common to rarest)
    return (b.print_run ?? 0) - (a.print_run ?? 0)
  })
}

function dedupeByLabel(arr: ParallelOut[]): ParallelOut[] {
  const seen = new Map<string, ParallelOut>()
  for (const p of arr) {
    const key = p.label.toLowerCase().trim()
    if (!seen.has(key)) seen.set(key, p)
  }
  return Array.from(seen.values())
}

function ensureBase(arr: ParallelOut[]): ParallelOut[] {
  if (arr.some(p => p.is_base)) return arr
  return [
    {
      id:                  null,
      label:               'Base',
      ebay_kw:             '',
      print_run:           null,
      reference_image_url: null,
      visual_identifiers:  null,
      surface_description: null,
      is_base:             true,
    },
    ...arr,
  ]
}

export async function GET(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !key) {
    return NextResponse.json({ error: 'Supabase not configured' }, { status: 500 })
  }

  const { searchParams } = new URL(request.url)
  // Accept both camelCase and snake_case so URLs match either the guided
  // selector convention (cardId/setId) or the /api/catalog/* convention
  // (card_id/set_id) without confusing callers.
  const cardId = searchParams.get('cardId') ?? searchParams.get('card_id')
  const setId  = searchParams.get('setId')  ?? searchParams.get('set_id')

  if (!cardId && !setId) {
    return NextResponse.json(
      { error: 'cardId/card_id or setId/set_id required' },
      { status: 400 },
    )
  }

  const supabase = createClient(url, key)

  // ── Card mode ────────────────────────────────────────────────────────────
  if (cardId) {
    const { data: rows, error } = await supabase
      .from('parallels')
      .select('id, label, ebay_kw, print_run, reference_image_url, visual_identifiers, surface_description')
      .eq('card_id', cardId)

    if (error) {
      console.error('[cards/parallels] card mode error', error.message)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    let parallels: ParallelOut[] = (rows ?? []).map(r => ({
      id:                  r.id,
      label:               r.label,
      ebay_kw:             r.ebay_kw ?? '',
      print_run:           r.print_run ?? parsePrintRun(r.label),
      reference_image_url: r.reference_image_url ?? null,
      visual_identifiers:  r.visual_identifiers ?? null,
      surface_description: r.surface_description ?? null,
      is_base:             /^base\b/i.test(r.label),
    }))

    // Fallback to set.parallel_templates if no card-level rows
    let resolvedSetId: string | null = null
    if (parallels.length === 0) {
      const { data: card } = await supabase
        .from('cards')
        .select('set_id')
        .eq('id', cardId)
        .maybeSingle()
      resolvedSetId = card?.set_id ?? null
      if (resolvedSetId) {
        parallels = await loadFromTemplates(url, key, resolvedSetId)
      }
    }

    // Only synthesize a Base entry when at least one real parallel exists;
    // truly-empty results stay empty so the caller can branch on "no data".
    const finalList = parallels.length > 0
      ? sortParallels(ensureBase(dedupeByLabel(parallels)))
      : []
    return NextResponse.json(
      { parallels: finalList, set_id: resolvedSetId, source: finalList.every(p => p.id === null) ? 'templates' : 'parallels' },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  }

  // ── Set mode (setId only) ───────────────────────────────────────────────
  // Two-step query avoids the fragile PostgREST embedded-resource filter
  // (.eq('cards.set_id', x) can silently return zero rows).
  //
  // Step A: get all card ids in the set
  const { data: cardRows, error: cardsErr } = await supabase
    .from('cards')
    .select('id')
    .eq('set_id', setId!)
    .limit(5000)

  if (cardsErr) {
    console.error('[cards/parallels] set mode cards lookup error', cardsErr.message)
    return NextResponse.json({ error: cardsErr.message }, { status: 500 })
  }

  const cardIds = (cardRows ?? []).map(c => c.id as string)
  let parallels: ParallelOut[] = []

  // Step B: get parallels for those cards (chunk if needed — PostgREST URL limit)
  if (cardIds.length > 0) {
    const CHUNK = 100
    for (let i = 0; i < cardIds.length; i += CHUNK) {
      const slice = cardIds.slice(i, i + CHUNK)
      const { data: rows, error: pErr } = await supabase
        .from('parallels')
        .select('id, label, ebay_kw, print_run, reference_image_url, visual_identifiers, surface_description')
        .in('card_id', slice)
        .limit(10000)

      if (pErr) {
        console.error('[cards/parallels] set mode parallels lookup error', pErr.message)
        return NextResponse.json({ error: pErr.message }, { status: 500 })
      }

      for (const r of rows ?? []) {
        parallels.push({
          id:                  r.id as string,
          label:               r.label as string,
          ebay_kw:             (r.ebay_kw as string) ?? '',
          print_run:           (r.print_run as number | null) ?? parsePrintRun(r.label as string),
          reference_image_url: (r.reference_image_url as string | null) ?? null,
          visual_identifiers:  (r.visual_identifiers as string[] | null) ?? null,
          surface_description: (r.surface_description as string | null) ?? null,
          is_base:             /^base\b/i.test(r.label as string),
        })
      }
    }
  }

  let source: 'parallels' | 'templates' = 'parallels'

  // Step C: fall back to set.parallel_templates if nothing came back
  if (parallels.length === 0) {
    parallels = await loadFromTemplates(url, key, setId!)
    source = 'templates'
  }

  const rawCount  = parallels.length
  // Only synthesize a Base entry when at least one real parallel exists;
  // truly-empty results stay empty so the caller can branch on "no data".
  const finalList = parallels.length > 0
    ? sortParallels(ensureBase(dedupeByLabel(parallels)))
    : []

  console.log(
    `[cards/parallels] setId=${setId} cards=${cardIds.length} ` +
    `raw_parallels=${rawCount} distinct=${finalList.length} source=${source}`,
  )

  return NextResponse.json(
    {
      parallels: finalList,
      set_id:    setId,
      source,
      count:     finalList.length,
      card_count: cardIds.length,
    },
    { headers: { 'Cache-Control': 'no-store' } },
  )
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

async function loadFromTemplates(
  url: string,
  key: string,
  setId: string,
): Promise<ParallelOut[]> {
  const supabase = createClient(url, key)
  const { data: setRow } = await supabase
    .from('sets')
    .select('parallel_templates')
    .eq('id', setId)
    .maybeSingle()

  const raw = (setRow as { parallel_templates?: unknown } | null)?.parallel_templates
  const templates = (Array.isArray(raw) ? raw : []) as Array<{
    label?:     string
    ebay_kw?:   string
    print_run?: number | null
  }>

  return templates
    .filter(t => !!t.label)
    .map(t => ({
      id:                  null,
      label:               t.label!,
      ebay_kw:             t.ebay_kw ?? '',
      print_run:           t.print_run ?? parsePrintRun(t.label!),
      reference_image_url: null,
      visual_identifiers:  null,
      surface_description: null,
      is_base:             /^base\b/i.test(t.label!),
    }))
}
