/**
 * RawIQ shared utilities
 */

/** Sports whose cards are labelled with a two-year season range */
const SEASON_SPORTS = new Set(['basketball', 'hockey'])

/**
 * Returns the display label for a card year.
 *   baseball / football → "2024"
 *   basketball / hockey → "2023-24"
 *
 * DB year convention for season sports: year = calendar release year =
 * the END year of the season.  So year=2024 means the 2023-24 season
 * (products released in calendar 2024).  The display label is therefore
 * `${year - 1}-${year two-digit}`.
 */
export function displayYear(year: number | string, sport: string): string {
  const y = typeof year === 'string' ? parseInt(year, 10) : year
  if (isNaN(y)) return String(year)
  if (SEASON_SPORTS.has(sport)) {
    const endShort = (y % 100).toString().padStart(2, '0')
    return `${y - 1}-${endShort}`
  }
  return String(y)
}
