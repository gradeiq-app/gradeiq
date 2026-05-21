import type { EbayApiResponse, CardFormData, AnalysisResult, GradeAnalysis, TierAnalysis } from './types'

export const GRADING_TIERS = [
  { id: 'economy', name: 'Economy', fee: 22, turnaround: '20+ business days' },
  { id: 'regular', name: 'Regular', fee: 50, turnaround: '10 business days' },
  { id: 'express', name: 'Express', fee: 150, turnaround: '5 business days' },
  { id: 'super_express', name: 'Super Express', fee: 300, turnaround: '2 business days' },
] as const

function getVerdict(roi: number, netProfit: number) {
  if (netProfit <= 0) return 'PASS' as const
  if (roi >= 50) return 'SUBMIT' as const
  return 'CONSIDER' as const
}

function analyzeTier(
  avgSalePrice: number,
  costBasis: number,
  tier: (typeof GRADING_TIERS)[number],
): TierAnalysis {
  const totalCost = costBasis + tier.fee
  const netProfit = avgSalePrice - totalCost
  const roi = totalCost > 0 ? (netProfit / totalCost) * 100 : 0

  return {
    id: tier.id,
    name: tier.name,
    fee: tier.fee,
    turnaround: tier.turnaround,
    netProfit,
    roi,
    totalCost,
    verdict: getVerdict(roi, netProfit),
  }
}

export function analyzeCard(ebayData: EbayApiResponse, cardInfo: CardFormData): AnalysisResult {
  const gradeKeys = [
    { key: 'psa8' as const, grade: 'psa8', label: 'PSA 8' },
    { key: 'psa9' as const, grade: 'psa9', label: 'PSA 9' },
    { key: 'psa10' as const, grade: 'psa10', label: 'PSA 10' },
  ]

  const grades: GradeAnalysis[] = gradeKeys.map(({ key, grade, label }) => {
    const { avg: avgSalePrice, count: sampleCount } = ebayData[key]
    const tiers = GRADING_TIERS.map(tier => analyzeTier(avgSalePrice, cardInfo.costBasis, tier))
    return { grade, label, avgSalePrice, sampleCount, tiers }
  })

  return {
    cardInfo,
    grades,
    rawAvg: ebayData.raw.avg,
    rawCount: ebayData.raw.count,
    analyzedAt: new Date().toISOString(),
  }
}

export function formatCurrency(n: number): string {
  if (n === 0) return '$0'
  const abs = Math.abs(n)
  const formatted = abs >= 1000
    ? `$${(abs / 1000).toFixed(1)}k`
    : `$${abs.toFixed(0)}`
  return n < 0 ? `-${formatted}` : formatted
}

export function formatROI(roi: number): string {
  if (!isFinite(roi)) return '—'
  return `${roi >= 0 ? '+' : ''}${roi.toFixed(0)}%`
}
