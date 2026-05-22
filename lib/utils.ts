/**
 * GradeIQ shared utilities
 */

/** Sports whose cards are labelled with a two-year season range */
const SEASON_SPORTS = new Set(['basketball', 'hockey'])

/**
 * Returns the display label for a card year.
 *   baseball / football → "2024"
 *   basketball / hockey → "2024-25"
 */
export function displayYear(year: number | string, sport: string): string {
  const y = typeof year === 'string' ? parseInt(year, 10) : year
  if (isNaN(y)) return String(year)
  if (SEASON_SPORTS.has(sport)) {
    const next = ((y + 1) % 100).toString().padStart(2, '0')
    return `${y}-${next}`
  }
  return String(y)
}
