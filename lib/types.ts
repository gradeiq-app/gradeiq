export interface CardFormData {
  playerName: string
  year: string
  brand: string
  set: string
  cardNumber: string
  costBasis: number
}

export interface GradePrices {
  avg: number
  count: number
}

export interface EbayApiResponse {
  raw: GradePrices
  psa8: GradePrices
  psa9: GradePrices
  psa10: GradePrices
  _mock?: boolean
}

export type Verdict = 'SUBMIT' | 'CONSIDER' | 'PASS'

export interface TierAnalysis {
  id: string
  name: string
  fee: number
  turnaround: string
  netProfit: number
  roi: number
  totalCost: number
  verdict: Verdict
}

export interface GradeAnalysis {
  grade: string
  label: string
  avgSalePrice: number
  sampleCount: number
  tiers: TierAnalysis[]
}

export interface AnalysisResult {
  cardInfo: CardFormData
  grades: GradeAnalysis[]
  rawAvg: number
  rawCount: number
  analyzedAt: string
}

export interface Profile {
  id: string
  plan: 'free' | 'pro' | 'dealer'
  lookup_count: number
  lookup_reset_date: string
  stripe_customer_id: string | null
  stripe_subscription_id: string | null
  updated_at: string
}
