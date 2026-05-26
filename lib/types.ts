export interface CardFormData {
  playerName: string
  year: string
  brand: string
  set: string
  cardNumber: string
  /** eBay keyword suffix for the parallel/variant — empty string = Base */
  parallel: string
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
  // Promo / demo codes
  bonus_lookups: number
  promo_plan: 'pro' | 'dealer' | null
  promo_plan_expires_at: string | null
  updated_at: string
}

// ─── Parallel Verifier ────────────────────────────────────────────────────────

export interface VisualCheck {
  feature:   string
  reference: string
  observed:  string
  match:     boolean
}

export type VerifyVerdict = 'CONFIRMED' | 'LIKELY MATCH' | 'POSSIBLE MISMATCH' | 'MISMATCH'

export interface VerifyAIResult {
  match:          boolean | 'uncertain'
  confidence:     number
  verdict:        VerifyVerdict
  reasoning:      string
  visual_checks:  VisualCheck[]
  warnings:       string[]
}

export interface VerifyResponse {
  ok:                true
  verdict:           VerifyAIResult
  verification_id:   string
  reference_source:  'ebay' | 'storage' | 'none'
}

export interface VerifyErrorResponse {
  ok:     false
  error:  'rate_limited' | 'no_reference' | 'image_quality' | 'api_unavailable' | 'unknown'
  message: string
}

export interface PromoRedeemResult {
  success?: boolean
  error?: 'invalid_code' | 'expired_code' | 'code_exhausted' | 'already_redeemed' | 'not_authenticated'
  granted?: 'pro' | 'dealer'
  days?: number | null
  extra_lookups?: number
}
