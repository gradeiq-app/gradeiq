import { NextRequest, NextResponse } from 'next/server'

// PSA does not expose a public API for pop reports.
// This endpoint returns structured mock data.
// Replace the body of `fetchPopReport` with a real integration
// (e.g. a licensed PSA data partner or your own scraper service)
// once you have access.

interface PopReport {
  grade: string
  population: number
  populationHigher: number
}

function buildMockPopReport(cardNumber: string): PopReport[] {
  // Seed mock numbers from card number so results look consistent per card
  const seed = cardNumber.split('').reduce((a, c) => a + c.charCodeAt(0), 0)
  const base = (seed % 50) + 10

  return [
    { grade: 'PSA 10', population: base * 3, populationHigher: 0 },
    { grade: 'PSA 9', population: base * 8, populationHigher: base * 3 },
    { grade: 'PSA 8', population: base * 5, populationHigher: base * 11 },
    { grade: 'PSA 7', population: base * 2, populationHigher: base * 16 },
    { grade: 'PSA Auth', population: Math.floor(base * 0.5), populationHigher: base * 18 },
  ]
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const cardNumber = searchParams.get('cardNumber') ?? 'unknown'
  const playerName = searchParams.get('playerName') ?? ''
  const year = searchParams.get('year') ?? ''

  const report = buildMockPopReport(`${year}${playerName}${cardNumber}`)

  return NextResponse.json({
    cardNumber,
    playerName,
    year,
    report,
    source: 'mock',
    note: 'PSA pop data is mocked. Integrate a real PSA data source to enable live population reports.',
  })
}
