'use client'

import type { AnalysisResult, Verdict, GradeAnalysis, TierAnalysis } from '@/lib/types'
import { formatCurrency, formatROI } from '@/lib/calculations'

interface Props {
  result: AnalysisResult
  isMock?: boolean
}

const VERDICT_STYLES: Record<Verdict, string> = {
  SUBMIT: 'bg-emerald-500/15 text-emerald-400 border-emerald-500/25',
  CONSIDER: 'bg-amber-500/15 text-amber-400 border-amber-500/25',
  PASS: 'bg-red-500/15 text-red-400 border-red-500/25',
}

const VERDICT_ICONS: Record<Verdict, string> = {
  SUBMIT: '✓',
  CONSIDER: '~',
  PASS: '✗',
}

function VerdictBadge({ verdict }: { verdict: Verdict }) {
  return (
    <span
      className={`inline-flex items-center gap-1 rounded-full border px-2.5 py-0.5 text-xs font-semibold ${VERDICT_STYLES[verdict]}`}
    >
      <span>{VERDICT_ICONS[verdict]}</span>
      {verdict}
    </span>
  )
}

function TierCell({ tier, noData }: { tier: TierAnalysis; noData: boolean }) {
  if (noData) {
    return (
      <div className="flex flex-col items-center gap-1 py-3">
        <span className="text-xs text-muted">No data</span>
      </div>
    )
  }

  return (
    <div className="flex flex-col items-center gap-1.5 py-3">
      <div className="text-sm font-semibold text-white">
        {formatCurrency(tier.netProfit)}
      </div>
      <div className={`text-xs ${tier.roi >= 0 ? 'text-emerald-400' : 'text-red-400'}`}>
        {formatROI(tier.roi)} ROI
      </div>
      <VerdictBadge verdict={tier.verdict} />
    </div>
  )
}

function GradeCard({ grade }: { grade: GradeAnalysis }) {
  const noData = grade.avgSalePrice === 0

  return (
    <div className="rounded-xl border border-border bg-surface overflow-hidden animate-slide-up">
      {/* Grade header */}
      <div className="flex items-center justify-between border-b border-border px-5 py-3.5">
        <div className="flex items-center gap-3">
          <span className="font-heading text-lg text-gold">{grade.label}</span>
          {noData ? (
            <span className="rounded-full border border-border px-2 py-0.5 text-xs text-muted">
              No eBay sales found
            </span>
          ) : (
            <>
              <span className="text-lg font-semibold text-white">
                {formatCurrency(grade.avgSalePrice)}
              </span>
              <span className="text-xs text-muted">
                avg / {grade.sampleCount} sale{grade.sampleCount !== 1 ? 's' : ''}
              </span>
            </>
          )}
        </div>
      </div>

      {/* Tier grid */}
      <div className="grid grid-cols-2 divide-x divide-border lg:grid-cols-4">
        {grade.tiers.map((tier, i) => (
          <div key={tier.id}>
            {/* Tier label */}
            <div className="border-b border-border bg-surface-2 px-3 py-1.5 text-center">
              <p className="text-xs font-semibold text-white">{tier.name}</p>
              <p className="text-xs text-muted">${tier.fee}</p>
            </div>
            <TierCell tier={tier} noData={noData} />
          </div>
        ))}
      </div>
    </div>
  )
}

export default function ResultsTable({ result, isMock }: Props) {
  const { cardInfo, grades, rawAvg, rawCount } = result

  const cardLabel = [cardInfo.year, cardInfo.brand, cardInfo.set, cardInfo.playerName]
    .filter(Boolean)
    .join(' ')

  return (
    <div className="flex flex-col gap-5 animate-fade-in">
      {/* Summary header */}
      <div className="rounded-xl border border-border bg-surface p-5">
        <div className="flex flex-wrap items-start justify-between gap-4">
          <div>
            <h2 className="font-heading text-xl text-white">{cardLabel}</h2>
            {cardInfo.cardNumber && (
              <p className="mt-0.5 text-sm text-muted">#{cardInfo.cardNumber}</p>
            )}
          </div>

          <div className="flex flex-wrap gap-4 text-right">
            <Stat label="Cost Basis" value={formatCurrency(cardInfo.costBasis)} />
            {rawAvg > 0 && (
              <Stat
                label="Raw Avg"
                value={formatCurrency(rawAvg)}
                sub={`${rawCount} sale${rawCount !== 1 ? 's' : ''}`}
              />
            )}
          </div>
        </div>
      </div>

      {isMock && (
        <div className="rounded-lg border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-sm text-amber-400">
          <strong>Demo mode:</strong> showing mock prices — add <code className="font-mono text-xs">EBAY_API_KEY</code> to .env.local for live eBay data.
        </div>
      )}

      {/* Legend */}
      <div className="flex flex-wrap items-center gap-4 text-xs text-muted">
        <div className="flex items-center gap-1.5">
          <span className="inline-block h-2 w-2 rounded-full bg-emerald-500" />
          <span>SUBMIT = ROI ≥ 50%</span>
        </div>
        <div className="flex items-center gap-1.5">
          <span className="inline-block h-2 w-2 rounded-full bg-amber-500" />
          <span>CONSIDER = ROI &gt; 0%</span>
        </div>
        <div className="flex items-center gap-1.5">
          <span className="inline-block h-2 w-2 rounded-full bg-red-500" />
          <span>PASS = negative profit</span>
        </div>
        <span className="ml-auto">Net = Avg Sale − Cost − Fee</span>
      </div>

      {/* Grade cards */}
      {grades.map(grade => (
        <GradeCard key={grade.grade} grade={grade} />
      ))}
    </div>
  )
}

function Stat({ label, value, sub }: { label: string; value: string; sub?: string }) {
  return (
    <div>
      <p className="text-xs text-muted">{label}</p>
      <p className="font-semibold text-white">{value}</p>
      {sub && <p className="text-xs text-muted">{sub}</p>}
    </div>
  )
}
