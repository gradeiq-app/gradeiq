/**
 * Step7Parallel auto-advance + idempotency tests.
 *
 * Step 7 fetches /api/cards/parallels and, when the response carries zero
 * parallels, calls onNoParallels() so the parent can auto-advance to Step 8
 * with parallel=null. The advancedRef guard prevents this callback from
 * firing more than once even if the effect re-runs (e.g. React strict mode
 * double-invoke, or a benign re-render).
 *
 * ParallelVerifier is stubbed because it only renders after a parallel is
 * picked — none of these tests reach that state, but the stub keeps the
 * import resolvable without pulling in the verifier's own fetch logic.
 */
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest'
import { render, screen, waitFor } from '@testing-library/react'
import { Step7Parallel, type Parallel, type PriceInfo } from '../GuidedCardSelector'

vi.mock('../ParallelVerifier', () => ({
  default: () => null,
}))

// ─── Test fixtures ────────────────────────────────────────────────────────────

const baseProps = {
  setId:       'set-uuid',
  cardId:      'card-uuid',
  sportSlug:   'football',
  year:        2024,
  brand:       'Topps',
  setName:     'Chrome',
  cardNumber:  '1',
  playerName:  'Test Player',
  selected:    null as Parallel | null,
  onPick:      vi.fn(),
  onNoParallels: vi.fn(),
  confirmed:   false,
  setConfirmed: vi.fn(),
  onConfirmed: vi.fn(),
}

function makeParallel(overrides: Partial<Parallel>): Parallel {
  return {
    id:                  null,
    label:               'Base',
    ebay_kw:             '',
    print_run:           null,
    reference_image_url: null,
    visual_identifiers:  null,
    surface_description: null,
    is_base:             true,
    ...overrides,
  }
}

function makeResponse(body: unknown): Response {
  return {
    ok:     true,
    status: 200,
    json:   async () => body,
  } as unknown as Response
}

// ─── Suite ────────────────────────────────────────────────────────────────────

describe('Step7Parallel', () => {
  let fetchMock: ReturnType<typeof vi.fn>

  beforeEach(() => {
    fetchMock = vi.fn()
    vi.stubGlobal('fetch', fetchMock)
  })

  afterEach(() => {
    vi.unstubAllGlobals()
    vi.clearAllMocks()
  })

  it('calls onNoParallels when API returns empty array', async () => {
    fetchMock.mockResolvedValueOnce(
      makeResponse({ parallels: [], source: 'templates', count: 0 }),
    )
    const onNoParallels = vi.fn()

    render(<Step7Parallel {...baseProps} onNoParallels={onNoParallels} />)

    await waitFor(() => {
      expect(onNoParallels).toHaveBeenCalledTimes(1)
    })

    // No parallel buttons rendered (empty grid path).
    expect(screen.queryByText('Base')).not.toBeInTheDocument()
    expect(screen.queryByText('Refractor')).not.toBeInTheDocument()
  })

  it('renders parallel options when API returns non-empty', async () => {
    const parallels: Parallel[] = [
      makeParallel({ id: '1', label: 'Base',      ebay_kw: '',          is_base: true  }),
      makeParallel({ id: '2', label: 'Refractor', ebay_kw: 'Refractor', is_base: false }),
    ]
    // First fetch: parallels list.
    fetchMock.mockResolvedValueOnce(
      makeResponse({ parallels, source: 'parallels', count: 2 }),
    )
    // Subsequent fetches: per-parallel price endpoint — return cache-miss.
    fetchMock.mockResolvedValue(makeResponse({ cached: false }))

    const onNoParallels = vi.fn()
    render(<Step7Parallel {...baseProps} onNoParallels={onNoParallels} />)

    expect(await screen.findByText('Base')).toBeInTheDocument()
    expect(await screen.findByText('Refractor')).toBeInTheDocument()
    expect(onNoParallels).not.toHaveBeenCalled()
  })

  it('does not call onNoParallels on fetch error', async () => {
    fetchMock.mockRejectedValueOnce(new Error('network down'))
    const onNoParallels = vi.fn()

    render(<Step7Parallel {...baseProps} onNoParallels={onNoParallels} />)

    // Error UI is the visible signal that the failure path was taken.
    expect(await screen.findByText(/network down|Failed to load parallels/i))
      .toBeInTheDocument()

    expect(onNoParallels).not.toHaveBeenCalled()
  })

  it('does not call onNoParallels twice if component re-renders', async () => {
    fetchMock.mockResolvedValue(
      makeResponse({ parallels: [], source: 'templates', count: 0 }),
    )
    const onNoParallels = vi.fn()
    const props = { ...baseProps, onNoParallels }

    const { rerender } = render(<Step7Parallel {...props} />)

    await waitFor(() => {
      expect(onNoParallels).toHaveBeenCalledTimes(1)
    })

    // Re-render with a non-relevant prop change. The useEffect deps are
    // [setId, cardId] so this does not re-fire the fetch — but the advancedRef
    // guard would catch a re-fire anyway (e.g. under React strict-mode double
    // invoke). Either way, onNoParallels must remain at one call.
    rerender(<Step7Parallel {...props} confirmed />)

    // Give any pending microtasks a chance to flush.
    await new Promise(r => setTimeout(r, 30))

    expect(onNoParallels).toHaveBeenCalledTimes(1)
  })
})
