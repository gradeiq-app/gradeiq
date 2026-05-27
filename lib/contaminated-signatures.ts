/**
 * TEMPORARY UI WORKAROUND — hides template-roster-contaminated sets from
 * the public guided selector.
 *
 * Background: ~1,050 `sets` rows across all sports are real product scaffolds
 * but their cards are a generic placeholder roster (e.g. football sets carry
 * the same 68 names regardless of year, so Bo Nix appears in 2023 sets).
 * Each sport has one "magic" card_count that flags this contamination:
 *
 *   football=68, baseball=76, basketball=89, hockey=45, soccer=47, wnba=41
 *
 * Sets matching the per-sport signature are hidden from years/brands/sets
 * routes so the selector doesn't surface unusable data. Admin routes are
 * intentionally NOT filtered — they need to see contaminated rows to triage.
 *
 * Long-term fix: verified-row architecture (Workstream 1) — every card
 * gets validated against an authoritative checklist source. Until then,
 * this constant is the load-bearing filter.
 *
 * See memory: project_roster_contamination.md
 */

export const CONTAMINATED_CARD_COUNTS: Record<string, readonly number[]> = {
  baseball:   [76],
  basketball: [89],
  football:   [68],
  hockey:     [45],
  soccer:     [47],
  wnba:       [41],
}

export function isContaminatedCardCount(
  sportSlug: string | null | undefined,
  cardCount: number,
): boolean {
  if (!sportSlug) return false
  const counts = CONTAMINATED_CARD_COUNTS[sportSlug.toLowerCase()]
  return counts?.includes(cardCount) ?? false
}
