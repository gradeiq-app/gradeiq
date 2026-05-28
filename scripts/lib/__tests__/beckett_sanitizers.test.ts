/**
 * Vitest coverage for scripts/lib/beckett_sanitizers.ts.
 *
 * Covers the contamination patterns documented in
 * [[project-player-name-contamination-phase-a-b-c]] and the parallel-family
 * denylist from [[project-beckett-card-type-contamination]].
 *
 * Word-boundary decision for detectParallelFamily:
 *   "Silver Prizms" → matched, family='prizms'. Denylist iteration is
 *   insertion-ordered, and 'prizms' precedes 'silver', so 'prizms' wins
 *   the tie. Word-boundary regex (\b<family>\b) means "prizmatic" would
 *   NOT match 'prizm' — the trailing 'atic' is a word character, killing
 *   the boundary.
 */

import { describe, expect, it } from 'vitest'
import { sanitizePlayerName, detectParallelFamily } from '../beckett_sanitizers'

describe('sanitizePlayerName — permissive mode', () => {
  it('passes through a clean two-word name', () => {
    expect(sanitizePlayerName('Joel Embiid')).toBe('Joel Embiid')
  })

  it('strips ", Team" suffix (1-2 word team)', () => {
    expect(sanitizePlayerName('Joel Embiid, Philadelphia 76ers')).toBe('Joel Embiid')
  })

  it('strips both /N print-run and ", Team" suffixes', () => {
    expect(sanitizePlayerName('Dyson Daniels, New Orleans Pelicans /99')).toBe('Dyson Daniels')
  })

  it('rejects multi-player combo with spaced slash', () => {
    expect(sanitizePlayerName('Victor Wembanyama / Brandon Miller')).toBeNull()
  })

  it('rejects multi-player combo with /Capital (no space)', () => {
    expect(sanitizePlayerName('Player/Capital')).toBeNull()
  })

  it('rejects meta survivor "Cards"', () => {
    expect(sanitizePlayerName('Cards')).toBeNull()
  })

  it('rejects meta survivor "cards."', () => {
    expect(sanitizePlayerName('cards.')).toBeNull()
  })

  it('rejects empty input', () => {
    expect(sanitizePlayerName('')).toBeNull()
  })

  it('rejects whitespace-only input', () => {
    expect(sanitizePlayerName('   ')).toBeNull()
  })

  it('rejects single-word survivor', () => {
    expect(sanitizePlayerName('Madonna')).toBeNull()
  })

  it('handles three-word player name without false team strip', () => {
    expect(sanitizePlayerName('Karl-Anthony Towns')).toBe('Karl-Anthony Towns')
  })

  it('strips trailing print-run on a clean name', () => {
    expect(sanitizePlayerName('Joel Embiid /99')).toBe('Joel Embiid')
  })
})

describe('sanitizePlayerName — strict mode', () => {
  it('throws on empty input', () => {
    expect(() => sanitizePlayerName('', { strict: true })).toThrow(/strict/)
  })

  it('throws on multi-player combo', () => {
    expect(() => sanitizePlayerName('Victor Wembanyama / Brandon Miller', { strict: true })).toThrow(/combo/)
  })

  it('throws on meta-cards survivor', () => {
    expect(() => sanitizePlayerName('Cards', { strict: true })).toThrow(/meta-cards/)
  })

  it('throws on single-word survivor', () => {
    expect(() => sanitizePlayerName('Madonna', { strict: true })).toThrow(/single-word/)
  })

  it('does NOT throw on a clean name', () => {
    expect(() => sanitizePlayerName('Joel Embiid', { strict: true })).not.toThrow()
    expect(sanitizePlayerName('Joel Embiid', { strict: true })).toBe('Joel Embiid')
  })
})

describe('detectParallelFamily — permissive mode', () => {
  it('matches "Prizms" exactly', () => {
    expect(detectParallelFamily('Prizms')).toEqual({ matched: true, family: 'prizms' })
  })

  it('matches "Silver Prizms" via word-boundary (denylist order picks "prizms")', () => {
    expect(detectParallelFamily('Silver Prizms')).toEqual({ matched: true, family: 'prizms' })
  })

  it('matches "Refractors - Silver /99" → first denylist hit "refractors"', () => {
    expect(detectParallelFamily('Refractors - Silver /99')).toEqual({ matched: true, family: 'refractors' })
  })

  it('matches mid-string "Donruss Optic Holo"', () => {
    expect(detectParallelFamily('Donruss Optic Holo')).toEqual({ matched: true, family: 'optic' })
  })

  it('does NOT match "Rookie Class"', () => {
    expect(detectParallelFamily('Rookie Class')).toEqual({ matched: false, family: null })
  })

  it('does NOT match a substring that lacks word boundary ("prizmatic")', () => {
    expect(detectParallelFamily('Prizmatic Variations')).toEqual({ matched: false, family: null })
  })

  it('returns {matched:false} for null', () => {
    expect(detectParallelFamily(null)).toEqual({ matched: false, family: null })
  })

  it('returns {matched:false} for empty string', () => {
    expect(detectParallelFamily('')).toEqual({ matched: false, family: null })
  })

  it('returns {matched:false} for whitespace-only', () => {
    expect(detectParallelFamily('   ')).toEqual({ matched: false, family: null })
  })
})

describe('detectParallelFamily — strict mode', () => {
  it('throws on a match', () => {
    expect(() => detectParallelFamily('Prizms', { strict: true })).toThrow(/parallel-family/)
  })

  it('does NOT throw on a non-match', () => {
    expect(() => detectParallelFamily('Rookie Class', { strict: true })).not.toThrow()
    expect(detectParallelFamily('Rookie Class', { strict: true })).toEqual({ matched: false, family: null })
  })

  it('does NOT throw on null', () => {
    expect(() => detectParallelFamily(null, { strict: true })).not.toThrow()
  })
})
