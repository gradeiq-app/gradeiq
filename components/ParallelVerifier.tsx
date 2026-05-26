'use client'

/**
 * ParallelVerifier — Step 5b in the card lookup flow.
 *
 * Appears inline after parallel selection and before cost basis entry.
 * Layer 1: Reference viewer (visual description + eBay reference image).
 * Layer 2: AI-powered photo comparison via /api/verify-parallel.
 *
 * Never blocks the user — skip is always available.
 */

import { useState, useRef, useCallback } from 'react'
import type { VerifyAIResult } from '@/lib/types'

// ─── Types ────────────────────────────────────────────────────────────────────

interface Parallel {
  label:   string
  ebay_kw: string
  // Future: populated once card-level parallels are seeded
  id?:                 string
  visual_identifiers?: string[]
  surface_description?: string
  reference_image_url?: string
}

interface Props {
  parallel:  Parallel
  setId?:    string
  year:      number
  brand:     string
  setName:   string
  sport:     string
  onConfirm: () => void   // user confirmed parallel looks right
  onGoBack:  () => void   // user wants to pick a different parallel
}

type Step = 'closed' | 'reference' | 'upload' | 'verifying' | 'result'

// ─── Verdict config ───────────────────────────────────────────────────────────

const VERDICT_CONFIG = {
  'CONFIRMED':         { color: 'emerald', icon: '✓', label: 'Confirmed' },
  'LIKELY MATCH':      { color: 'gold',    icon: '~', label: 'Likely Match' },
  'POSSIBLE MISMATCH': { color: 'orange',  icon: '!', label: 'Possible Mismatch' },
  'MISMATCH':          { color: 'red',     icon: '✗', label: 'Mismatch' },
} as const

const verdictColorCls: Record<string, string> = {
  emerald: 'bg-emerald-500/20 text-emerald-400 border-emerald-500/30',
  gold:    'bg-gold-muted text-gold border-gold/30',
  orange:  'bg-orange-500/20 text-orange-400 border-orange-500/30',
  red:     'bg-red-500/20 text-red-400 border-red-500/30',
}

// ─── Sub-components ───────────────────────────────────────────────────────────

function PrintRunBadge({ label }: { label: string }) {
  const match = label.match(/\/(\d+)$/)
  if (!match) return null
  return (
    <span className="ml-2 rounded-full bg-gold-muted px-2 py-0.5 text-xs font-semibold text-gold">
      /{match[1]} print run
    </span>
  )
}

function ConfidenceBar({ value }: { value: number }) {
  const color = value >= 75 ? 'bg-emerald-500' : value >= 50 ? 'bg-gold' : 'bg-orange-500'
  return (
    <div className="mt-1 h-1.5 w-full rounded-full bg-border">
      <div
        className={`h-full rounded-full transition-all duration-500 ${color}`}
        style={{ width: `${value}%` }}
      />
    </div>
  )
}

// ─── Main component ───────────────────────────────────────────────────────────

export default function ParallelVerifier({
  parallel, setId, year, brand, setName, sport, onConfirm, onGoBack,
}: Props) {
  const [step, setStep]               = useState<Step>('closed')
  const [imagePreview, setImagePreview] = useState<string | null>(null)
  const [imageFile, setImageFile]     = useState<File | null>(null)
  const [verdict, setVerdict]         = useState<VerifyAIResult | null>(null)
  const [referenceUrl, setReferenceUrl] = useState<string | null>(null)
  const [apiError, setApiError]       = useState<string | null>(null)
  const fileRef = useRef<HTMLInputElement>(null)

  const printRunMatch = parallel.label.match(/\/(\d+)$/)

  // ── Handlers ───────────────────────────────────────────────────────────────

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0]
    if (!file) return
    const MAX = parseInt(process.env.NEXT_PUBLIC_MAX_VERIFY_FILE_SIZE ?? '10485760')
    if (file.size > MAX) {
      setApiError(`File too large — max ${Math.round(MAX / 1048576)} MB`)
      return
    }
    setImageFile(file)
    setApiError(null)
    const reader = new FileReader()
    reader.onload = () => setImagePreview(reader.result as string)
    reader.readAsDataURL(file)
  }

  const handleVerify = useCallback(async () => {
    if (!imageFile) return
    setStep('verifying')
    setApiError(null)

    const fd = new FormData()
    fd.append('parallel_label',   parallel.label)
    fd.append('parallel_ebay_kw', parallel.ebay_kw)
    fd.append('year',             String(year))
    fd.append('brand',            brand)
    fd.append('set_name',         setName)
    fd.append('sport',            sport)
    fd.append('card_image',       imageFile)
    if (setId) fd.append('set_id', setId)

    try {
      const res  = await fetch('/api/verify-parallel', { method: 'POST', body: fd })
      const data = await res.json()

      if (!res.ok || !data.ok) {
        const msg: string = data.message ?? 'Verification failed. You can still proceed.'
        setApiError(msg)
        // Still let them through — not a gatekeeper
        if (data.error === 'no_reference') {
          setStep('reference')
        } else {
          setStep('upload')
        }
        return
      }

      if (data.reference_url) setReferenceUrl(data.reference_url)
      setVerdict(data.verdict)
      setStep('result')
    } catch {
      setApiError('Verification unavailable — you can still proceed without it.')
      setStep('upload')
    }
  }, [imageFile, parallel, year, brand, setName, sport, setId])

  function handleSkip() {
    onConfirm()
  }

  // ── Closed state — compact hint ────────────────────────────────────────────
  if (step === 'closed') {
    return (
      <div className="flex items-center justify-between rounded-lg border border-border/60 bg-surface px-4 py-3">
        <div className="flex items-center gap-2 text-sm text-muted">
          <span className="text-base">🔍</span>
          <span>
            Selected: <span className="font-medium text-white">{parallel.label}</span>
            {printRunMatch && (
              <span className="ml-1 text-gold">/{printRunMatch[1]}</span>
            )}
          </span>
        </div>
        <div className="flex items-center gap-3">
          <button
            type="button"
            onClick={() => setStep('reference')}
            className="text-xs text-gold/80 hover:text-gold transition-colors underline underline-offset-2"
          >
            Verify parallel →
          </button>
          <button
            type="button"
            onClick={handleSkip}
            className="text-xs text-muted hover:text-white transition-colors"
          >
            Skip
          </button>
        </div>
      </div>
    )
  }

  // ── Reference viewer (Layer 1) ─────────────────────────────────────────────
  if (step === 'reference') {
    const identifiers: string[] = parallel.visual_identifiers ?? []
    const description: string   = parallel.surface_description ?? ''
    const refImageUrl: string   = parallel.reference_image_url ?? referenceUrl ?? ''

    return (
      <div className="animate-fade-in rounded-xl border border-gold/20 bg-surface overflow-hidden">
        {/* Header */}
        <div className="flex items-center justify-between border-b border-border px-5 py-3">
          <div className="flex items-center gap-2">
            <span className="text-sm font-semibold text-white">Parallel Reference</span>
            <PrintRunBadge label={parallel.label} />
          </div>
          <button
            type="button"
            onClick={handleSkip}
            className="text-xs text-muted hover:text-white transition-colors"
          >
            Skip verification
          </button>
        </div>

        <div className="flex flex-col gap-0 sm:flex-row">
          {/* Reference image */}
          <div className="sm:w-48 shrink-0 flex items-center justify-center border-b sm:border-b-0 sm:border-r border-border bg-background/50 p-4">
            {refImageUrl ? (
              <img
                src={refImageUrl}
                alt={`Reference image: ${parallel.label}`}
                className="max-h-40 max-w-full rounded object-contain"
              />
            ) : (
              <div className="flex h-36 w-36 flex-col items-center justify-center rounded-lg border border-dashed border-border/60 text-center">
                <span className="text-3xl">🃏</span>
                <p className="mt-2 text-xs text-muted leading-tight">
                  Reference image<br />not yet available
                </p>
              </div>
            )}
          </div>

          {/* Info panel */}
          <div className="flex flex-1 flex-col gap-4 p-5">
            <div>
              <p className="text-xs font-semibold uppercase tracking-wider text-muted">Parallel</p>
              <p className="mt-1 text-lg font-semibold text-white">{parallel.label}</p>
              {description && (
                <p className="mt-1 text-sm text-muted">{description}</p>
              )}
            </div>

            {identifiers.length > 0 ? (
              <div>
                <p className="text-xs font-semibold uppercase tracking-wider text-muted mb-2">
                  What to look for
                </p>
                <ul className="space-y-1">
                  {identifiers.map((id, i) => (
                    <li key={i} className="flex items-center gap-2 text-sm text-white/80">
                      <span className="flex h-4 w-4 shrink-0 items-center justify-center rounded-full bg-gold/20 text-gold text-[10px] font-bold">
                        ✓
                      </span>
                      {id}
                    </li>
                  ))}
                </ul>
              </div>
            ) : (
              <div className="rounded-lg border border-dashed border-border/60 bg-background/30 px-4 py-3">
                <p className="text-xs text-muted">
                  Visual identifier checklist coming soon. Use the photo verifier below for AI-powered comparison.
                </p>
              </div>
            )}

            {apiError && (
              <p className="rounded-lg bg-orange-500/10 border border-orange-500/20 px-3 py-2 text-xs text-orange-400">
                {apiError}
              </p>
            )}

            {/* Action row */}
            <div className="mt-auto flex flex-wrap items-center gap-3 pt-2">
              <button
                type="button"
                onClick={() => setStep('upload')}
                className="flex items-center gap-1.5 rounded-lg border border-border/60 bg-background/50 px-3 py-2 text-xs text-white hover:border-gold/40 hover:text-gold transition-colors"
              >
                <span>📷</span> Verify with photo
              </button>
              <button
                type="button"
                onClick={onConfirm}
                className="btn-gold px-4 py-2 text-sm"
              >
                This matches my card →
              </button>
              <button
                type="button"
                onClick={onGoBack}
                className="text-xs text-muted hover:text-white transition-colors"
              >
                ← Doesn&apos;t look right
              </button>
            </div>
          </div>
        </div>
      </div>
    )
  }

  // ── Photo upload (Layer 2) ─────────────────────────────────────────────────
  if (step === 'upload') {
    return (
      <div className="animate-fade-in rounded-xl border border-gold/20 bg-surface overflow-hidden">
        <div className="flex items-center justify-between border-b border-border px-5 py-3">
          <span className="text-sm font-semibold text-white">AI Photo Verifier</span>
          <button type="button" onClick={handleSkip} className="text-xs text-muted hover:text-white transition-colors">
            Skip verification
          </button>
        </div>

        <div className="p-5 flex flex-col gap-4">
          <p className="text-sm text-muted">
            Upload a photo of your card. Our AI will compare it against a reference image of&nbsp;
            <span className="font-medium text-white">{parallel.label}</span>.
          </p>

          {/* Drop zone / preview */}
          <div
            onClick={() => fileRef.current?.click()}
            className={`relative cursor-pointer rounded-xl border-2 border-dashed transition-colors ${
              imagePreview
                ? 'border-gold/40 bg-background/30'
                : 'border-border/60 bg-background/30 hover:border-gold/40'
            } flex min-h-[140px] items-center justify-center overflow-hidden`}
          >
            {imagePreview ? (
              <img
                src={imagePreview}
                alt="Card preview"
                className="max-h-48 max-w-full object-contain rounded-lg"
              />
            ) : (
              <div className="flex flex-col items-center gap-2 p-6 text-center">
                <span className="text-4xl">📷</span>
                <p className="text-sm font-medium text-white">
                  Tap to upload card photo
                </p>
                <p className="text-xs text-muted">JPG, PNG, WEBP, HEIC — max {Math.round(MAX_FILE_BYTES / 1048576)} MB</p>
              </div>
            )}
          </div>

          <input
            ref={fileRef}
            type="file"
            accept="image/jpeg,image/jpg,image/png,image/webp,image/heic"
            onChange={handleFileChange}
            className="sr-only"
          />

          {apiError && (
            <p className="rounded-lg bg-orange-500/10 border border-orange-500/20 px-3 py-2 text-xs text-orange-400">
              {apiError}
            </p>
          )}

          <div className="flex items-center gap-3">
            <button
              type="button"
              onClick={() => setStep('reference')}
              className="btn-outline px-4 py-2 text-sm"
            >
              ← Back
            </button>
            <button
              type="button"
              onClick={handleVerify}
              disabled={!imageFile}
              className="btn-gold px-5 py-2 text-sm disabled:opacity-50"
            >
              Verify →
            </button>
            <button
              type="button"
              onClick={onConfirm}
              className="ml-auto text-xs text-muted hover:text-white transition-colors"
            >
              Skip and continue
            </button>
          </div>
        </div>
      </div>
    )
  }

  // ── Verifying (loading) ────────────────────────────────────────────────────
  if (step === 'verifying') {
    return (
      <div className="animate-fade-in rounded-xl border border-gold/20 bg-surface p-6 flex items-center gap-4">
        <svg className="animate-spin shrink-0 text-gold" width="24" height="24" viewBox="0 0 24 24" fill="none">
          <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="2.5" strokeOpacity="0.3" />
          <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" />
        </svg>
        <div>
          <p className="text-sm font-semibold text-white">Analyzing your card…</p>
          <p className="text-xs text-muted">Comparing against eBay reference. This takes 5–10 seconds.</p>
        </div>
        <button
          type="button"
          onClick={handleSkip}
          className="ml-auto text-xs text-muted hover:text-white transition-colors shrink-0"
        >
          Skip
        </button>
      </div>
    )
  }

  // ── AI Verdict result ──────────────────────────────────────────────────────
  if (step === 'result' && verdict) {
    const cfg         = VERDICT_CONFIG[verdict.verdict]
    const colorCls    = verdictColorCls[cfg.color]
    const isPositive  = verdict.verdict === 'CONFIRMED' || verdict.verdict === 'LIKELY MATCH'

    return (
      <div className="animate-fade-in rounded-xl border border-gold/20 bg-surface overflow-hidden">
        <div className="flex items-center justify-between border-b border-border px-5 py-3">
          <span className="text-sm font-semibold text-white">AI Verification Result</span>
          <button type="button" onClick={handleSkip} className="text-xs text-muted hover:text-white transition-colors">
            Skip and continue
          </button>
        </div>

        <div className="p-5 flex flex-col gap-4">
          {/* Verdict badge */}
          <div className="flex items-center gap-4">
            <div className={`flex items-center gap-2 rounded-full border px-4 py-2 font-bold ${colorCls}`}>
              <span className="text-lg">{cfg.icon}</span>
              <span>{cfg.label}</span>
            </div>
            <div>
              <p className="text-xs text-muted mb-1">Confidence: {verdict.confidence}%</p>
              <ConfidenceBar value={verdict.confidence} />
            </div>
          </div>

          {/* Reasoning */}
          <p className="text-sm text-white/80">{verdict.reasoning}</p>

          {/* Visual checks */}
          {verdict.visual_checks?.length > 0 && (
            <div>
              <p className="text-xs font-semibold uppercase tracking-wider text-muted mb-2">Feature Checks</p>
              <div className="rounded-lg border border-border overflow-hidden">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border bg-background/50 text-xs text-muted">
                      <th className="px-3 py-2 text-left font-medium">Feature</th>
                      <th className="px-3 py-2 text-left font-medium hidden sm:table-cell">Reference</th>
                      <th className="px-3 py-2 text-left font-medium hidden sm:table-cell">Observed</th>
                      <th className="px-3 py-2 text-center font-medium">Match</th>
                    </tr>
                  </thead>
                  <tbody>
                    {verdict.visual_checks.map((check, i) => (
                      <tr key={i} className={i > 0 ? 'border-t border-border/50' : ''}>
                        <td className="px-3 py-2 text-white/80 font-medium">{check.feature}</td>
                        <td className="px-3 py-2 text-muted hidden sm:table-cell">{check.reference}</td>
                        <td className="px-3 py-2 text-muted hidden sm:table-cell">{check.observed}</td>
                        <td className="px-3 py-2 text-center">
                          {check.match
                            ? <span className="text-emerald-400">✓</span>
                            : <span className="text-red-400">✗</span>
                          }
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Warnings */}
          {verdict.warnings?.length > 0 && (
            <div className="rounded-lg border border-amber-500/20 bg-amber-500/10 px-4 py-3">
              <p className="mb-1 text-xs font-semibold text-amber-400">⚠ Flags</p>
              {verdict.warnings.map((w, i) => (
                <p key={i} className="text-xs text-amber-400/80">{w}</p>
              ))}
            </div>
          )}

          {/* Actions */}
          <div className="flex flex-wrap items-center gap-3 pt-1">
            {isPositive ? (
              <button
                type="button"
                onClick={onConfirm}
                className="btn-gold px-5 py-2 text-sm"
              >
                Looks good → Continue to analysis
              </button>
            ) : (
              <button
                type="button"
                onClick={onGoBack}
                className="btn-gold px-5 py-2 text-sm"
              >
                Update my selection
              </button>
            )}
            {!isPositive && (
              <button
                type="button"
                onClick={onConfirm}
                className="text-xs text-muted hover:text-white transition-colors"
              >
                Proceed anyway
              </button>
            )}
            <button
              type="button"
              onClick={() => { setStep('upload'); setVerdict(null); setApiError(null) }}
              className="ml-auto text-xs text-muted hover:text-white transition-colors"
            >
              ← Try another photo
            </button>
          </div>
        </div>
      </div>
    )
  }

  return null
}

// Re-export the file size constant so the upload input can reference it
const MAX_FILE_BYTES = parseInt(
  typeof process !== 'undefined'
    ? (process.env.NEXT_PUBLIC_MAX_VERIFY_FILE_SIZE ?? '10485760')
    : '10485760',
)
