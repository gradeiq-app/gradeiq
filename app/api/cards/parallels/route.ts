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

function sortParallels(arr: ParallelOut[]): ParallelOut[] {
  return [...arr].sort((a, b) => {
    if (a.is_base && !b.is_base) return -1
    if (!a.is_base && b.is_base) return 1
    if (a.is_base && b.is_base)  return 0
    if (a.print_run == null && b.print_run != null) return -1
    if (a.print_run != null && b.print_run == null) return 1
    if (a.print_run == null && b.print_run == null) return a.label.localeCompare(b.label)
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
  const cardId = searchParams.get('cardId')
  const setId  = searchParams.get('setId')

  if (!cardId && !setId) {
    return NextResponse.json({ error: 'cardId or setId required' }, { status: 400 })
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

    parallels = ensureBase(dedupeByLabel(parallels))
    return NextResponse.json(
      { parallels: sortParallels(parallels), set_id: resolvedSetId, source: parallels.every(p => p.id === null) ? 'templates' : 'parallels' },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  }

  // ── Set mode (setId only) ───────────────────────────────────────────────
  // Step 1: distinct parallels via cards in this set
  const { data: joined, error: joinErr } = await supabase
    .from('parallels')
    .select(`
      id, label, ebay_kw, print_run, reference_image_url, visual_identifiers, surface_description,
      card:cards!inner(set_id)
    `)
    .eq('cards.set_id', setId!)

  if (joinErr) {
    console.error('[cards/parallels] set mode join error', joinErr.message)
    return NextResponse.json({ error: joinErr.message }, { status: 500 })
  }

  let parallels: ParallelOut[] = (joined ?? []).map(r => ({
    id:                  r.id as string,
    label:               r.label as string,
    ebay_kw:             (r.ebay_kw as string) ?? '',
    print_run:           (r.print_run as number | null) ?? parsePrintRun(r.label as string),
    reference_image_url: (r.reference_image_url as string | null) ?? null,
    visual_identifiers:  (r.visual_identifiers as string[] | null) ?? null,
    surface_description: (r.surface_description as string | null) ?? null,
    is_base:             /^base\b/i.test(r.label as string),
  }))

  let source: 'parallels' | 'templates' = 'parallels'

  // Step 2: fall back to set.parallel_templates if nothing came back
  if (parallels.length === 0) {
    parallels = await loadFromTemplates(url, key, setId!)
    source = 'templates'
  }

  parallels = ensureBase(dedupeByLabel(parallels))

  return NextResponse.json(
    { parallels: sortParallels(parallels), set_id: setId, source },
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
