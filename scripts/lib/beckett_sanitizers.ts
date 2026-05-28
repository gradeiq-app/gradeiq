/**
 * beckett_sanitizers.ts
 *
 * Shared, source-of-truth sanitizers used by both Beckett and TCDB scrapers
 * to keep contaminated rows out of the `players` and `cards` tables.
 *
 * Two exports:
 *   sanitizePlayerName(raw, {strict?})    — see Phase A of
 *     [[project-player-name-contamination-phase-a-b-c]]. Strips trailing
 *     "/N" print runs and ", Team" suffixes; rejects multi-player combos
 *     and meta-only survivors. Returns the cleaned name, or null on reject.
 *
 *   detectParallelFamily(subsetName, {strict?}) — see
 *     [[project-beckett-card-type-contamination]]. Word-boundary match
 *     against a curated denylist of parallel-family labels (Prizms,
 *     Refractors, Mosaic, …). Caller persists matches as
 *     card_type='parallel_pending_review', is_active=false so tomorrow's
 *     Phase C cleanup can relocate them to the `parallels` table.
 *
 * --strict semantics: when opts.strict === true, both functions throw on
 * the reject/match path instead of returning null/{matched:true,…}. Used
 * by unit tests so we can assert behavior with toThrow.
 *
 * Audit log:
 *   scripts/_beckett_sanitizer_log.jsonl
 *   Each line: {ts, type, raw_input, matched_pattern, returned}
 */

import { appendFileSync } from 'fs'
import { join } from 'path'

const LOG_FILE = join(process.cwd(), 'scripts', '_beckett_sanitizer_log.jsonl')

type LogType = 'player_skip' | 'player_transform' | 'parallel_match'

type LogEntry = {
  ts: string
  type: LogType
  raw_input: string
  matched_pattern: string
  returned: string | boolean | null
}

function writeLog(entry: LogEntry): void {
  try {
    appendFileSync(LOG_FILE, JSON.stringify(entry) + '\n', 'utf8')
  } catch {
    // Logging is best-effort; never let it break the scraper.
  }
}

// Curated v1 denylist. Conservative — bias is over-detection (false
// positives become parallel_pending_review rows we triage in Phase C),
// not under-detection (under-detection leaves the bug intact).
const PARALLEL_FAMILY_DENYLIST: readonly string[] = [
  'prizms',
  'prizm',
  'refractors',
  'refractor',
  'chrome',
  'mosaic',
  'mosaics',
  'optic',
  'select',
  'sapphire',
  'cosmic',
  'sonar',
  'wave',
  'geometric',
  'speckle',
  'silver',
  'gold',
  'holo',
  'rainbow',
  'negative',
  'disco',
] as const

export type SanitizerOpts = { strict?: boolean }
export type ParallelMatch = { matched: boolean; family: string | null }

function rejectPlayer(raw: string, pattern: string, strict: boolean): null {
  writeLog({
    ts: new Date().toISOString(),
    type: 'player_skip',
    raw_input: raw,
    matched_pattern: pattern,
    returned: null,
  })
  if (strict) {
    throw new Error(`[beckett_sanitizers] strict: rejected player (${pattern}) "${raw}"`)
  }
  return null
}

export function sanitizePlayerName(raw: string, opts: SanitizerOpts = {}): string | null {
  const strict = opts.strict === true
  const original = typeof raw === 'string' ? raw : ''

  if (!original) return rejectPlayer(original, 'empty', strict)
  let name = original.trim()
  if (!name) return rejectPlayer(original, 'empty', strict)

  // 1. Strip trailing "/N" print-run suffix. Print runs are unambiguous
  //    (slash followed by digits at end of string).
  const printRunRe = /\s*\/\d+\s*$/
  if (printRunRe.test(name)) {
    name = name.replace(printRunRe, '').trim()
  }

  // 2. Reject multi-player combos. After /N is stripped, any remaining
  //    "/" followed (optionally after whitespace) by a capital letter
  //    indicates a second player name. Beckett packs these as "P1 / P2".
  if (/\/\s*[A-Z]/.test(name)) {
    return rejectPlayer(original, 'combo', strict)
  }

  // 3. Strip trailing ", Team" suffix. Team is 1–4 capitalized words
  //    (allowing apostrophes / hyphens / periods, and trailing digits
  //    like "76ers"). Examples covered:
  //      "Joel Embiid, Philadelphia 76ers" → "Joel Embiid"
  //      "Dyson Daniels, New Orleans Pelicans" → "Dyson Daniels"
  const teamRe = /,\s+[A-Z][A-Za-z'.\-]+(?:\s+(?:[A-Z][A-Za-z'.\-]+|\d+[A-Za-z]*))*\s*$/
  name = name.replace(teamRe, '').trim()

  // 4. Reject meta-only survivors.
  if (!name) return rejectPlayer(original, 'empty-after-strip', strict)
  if (/^cards?\.?$/i.test(name)) return rejectPlayer(original, 'meta-cards', strict)
  if (!name.includes(' ')) return rejectPlayer(original, 'single-word', strict)

  // 5. Log any transformation (even non-rejected). Useful audit trail.
  if (name !== original.trim()) {
    writeLog({
      ts: new Date().toISOString(),
      type: 'player_transform',
      raw_input: original,
      matched_pattern: 'cleanup',
      returned: name,
    })
  }
  return name
}

export function detectParallelFamily(
  subsetName: string | null | undefined,
  opts: SanitizerOpts = {},
): ParallelMatch {
  const strict = opts.strict === true
  if (!subsetName || typeof subsetName !== 'string' || !subsetName.trim()) {
    return { matched: false, family: null }
  }
  const lo = subsetName.toLowerCase()
  // Word-boundary match: "Silver Prizms" matches "prizms" but
  // "prizmatic" would not match "prizm". Denylist order decides ties
  // (e.g. "Refractors - Silver" matches "refractors" before "silver").
  for (const family of PARALLEL_FAMILY_DENYLIST) {
    const re = new RegExp(`\\b${family}\\b`, 'i')
    if (re.test(lo)) {
      writeLog({
        ts: new Date().toISOString(),
        type: 'parallel_match',
        raw_input: subsetName,
        matched_pattern: family,
        returned: true,
      })
      if (strict) {
        throw new Error(
          `[beckett_sanitizers] strict: parallel-family match (${family}) in "${subsetName}"`,
        )
      }
      return { matched: true, family }
    }
  }
  return { matched: false, family: null }
}
