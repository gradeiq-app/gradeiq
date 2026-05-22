'use client'

import { useEffect, useState } from 'react'

interface Config {
  announcement_enabled: string
  announcement_text: string
  announcement_type: string
  pro_display_price: string
  dealer_display_price: string
}

const DEFAULTS: Config = {
  announcement_enabled: 'false',
  announcement_text: '',
  announcement_type: 'info',
  pro_display_price: '4.99',
  dealer_display_price: '19.99',
}

export default function SettingsPage() {
  const [config, setConfig] = useState<Config>(DEFAULTS)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    fetch('/api/admin/config')
      .then(r => r.json())
      .then(d => setConfig({ ...DEFAULTS, ...d }))
      .finally(() => setLoading(false))
  }, [])

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    setSaved(false)
    setError('')

    const res = await fetch('/api/admin/config', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(config),
    })
    const data = await res.json()

    if (data.error) { setError(data.error); setSaving(false); return }
    setSaved(true)
    setSaving(false)
    setTimeout(() => setSaved(false), 3000)
  }

  if (loading) return <div className="text-muted text-sm animate-pulse">Loading settings…</div>

  return (
    <div className="flex flex-col gap-8 max-w-2xl">
      <div>
        <h1 className="font-heading text-3xl text-white">Site Settings</h1>
        <p className="mt-1 text-sm text-muted">Changes take effect immediately — no redeploy needed.</p>
      </div>

      <form onSubmit={handleSave} className="flex flex-col gap-6">
        {/* ── Announcement banner ── */}
        <section className="rounded-xl border border-border bg-surface p-6 flex flex-col gap-4">
          <div>
            <h2 className="font-semibold text-white">Announcement Banner</h2>
            <p className="mt-1 text-xs text-muted">Shown at the top of the landing and pricing pages.</p>
          </div>

          <label className="flex cursor-pointer items-center gap-3">
            <div className="relative">
              <input type="checkbox"
                checked={config.announcement_enabled === 'true'}
                onChange={e => setConfig(c => ({ ...c, announcement_enabled: e.target.checked ? 'true' : 'false' }))}
                className="sr-only" />
              <div className={`h-5 w-9 rounded-full transition-colors ${config.announcement_enabled === 'true' ? 'bg-gold' : 'bg-border'}`} />
              <div className={`absolute top-0.5 h-4 w-4 rounded-full bg-white shadow transition-transform ${config.announcement_enabled === 'true' ? 'translate-x-4' : 'translate-x-0.5'}`} />
            </div>
            <span className="text-sm text-white">{config.announcement_enabled === 'true' ? 'Enabled' : 'Disabled'}</span>
          </label>

          <div>
            <label className="mb-1 block text-xs text-muted">Message</label>
            <textarea
              value={config.announcement_text}
              onChange={e => setConfig(c => ({ ...c, announcement_text: e.target.value }))}
              rows={2}
              placeholder="🎉 Launch special — use code LAUNCH10 for 10 free bonus lookups!"
              className="w-full rounded-lg border border-border bg-background px-3 py-2 text-sm text-white placeholder-muted/40 outline-none focus:border-gold/50 resize-none"
            />
          </div>

          <div>
            <label className="mb-1 block text-xs text-muted">Style</label>
            <div className="flex gap-2">
              {([
                { value: 'info',    label: 'Info',    color: 'text-blue-400 border-blue-400/30 bg-blue-400/10' },
                { value: 'success', label: 'Success', color: 'text-emerald-400 border-emerald-400/30 bg-emerald-400/10' },
                { value: 'warning', label: 'Warning', color: 'text-amber-400 border-amber-400/30 bg-amber-400/10' },
              ] as const).map(({ value, label, color }) => (
                <button key={value} type="button"
                  onClick={() => setConfig(c => ({ ...c, announcement_type: value }))}
                  className={`rounded-full border px-3 py-1 text-xs font-medium transition-all ${config.announcement_type === value ? color : 'border-border text-muted hover:text-white'}`}>
                  {label}
                </button>
              ))}
            </div>
          </div>

          {/* Preview */}
          {config.announcement_enabled === 'true' && config.announcement_text && (
            <div className={`rounded-lg border px-4 py-2 text-center text-sm ${
              config.announcement_type === 'success' ? 'border-emerald-500/30 bg-emerald-500/10 text-emerald-400' :
              config.announcement_type === 'warning' ? 'border-amber-500/30 bg-amber-500/10 text-amber-400' :
              'border-blue-500/30 bg-blue-500/10 text-blue-400'
            }`}>
              <span className="text-xs font-semibold uppercase tracking-wider opacity-60 mr-2">Preview:</span>
              {config.announcement_text}
            </div>
          )}
        </section>

        {/* ── Display prices ── */}
        <section className="rounded-xl border border-border bg-surface p-6 flex flex-col gap-4">
          <div>
            <h2 className="font-semibold text-white">Display Prices</h2>
            <p className="mt-1 text-xs text-muted">
              Changes what's shown on the pricing page and upgrade modal.{' '}
              <span className="text-amber-400">These do not change what Stripe charges</span> — update Stripe prices separately in the Stripe Dashboard.
            </p>
          </div>
          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <label className="mb-1 block text-xs text-muted">Pro plan price ($/mo)</label>
              <div className="flex items-center gap-1">
                <span className="text-muted">$</span>
                <input type="number" step="0.01" min="0"
                  value={config.pro_display_price}
                  onChange={e => setConfig(c => ({ ...c, pro_display_price: e.target.value }))}
                  className="w-28 rounded-lg border border-border bg-background px-3 py-2 text-sm text-white outline-none focus:border-gold/50" />
                <span className="text-muted text-xs">/mo</span>
              </div>
            </div>
            <div>
              <label className="mb-1 block text-xs text-muted">Dealer plan price ($/mo)</label>
              <div className="flex items-center gap-1">
                <span className="text-muted">$</span>
                <input type="number" step="0.01" min="0"
                  value={config.dealer_display_price}
                  onChange={e => setConfig(c => ({ ...c, dealer_display_price: e.target.value }))}
                  className="w-28 rounded-lg border border-border bg-background px-3 py-2 text-sm text-white outline-none focus:border-gold/50" />
                <span className="text-muted text-xs">/mo</span>
              </div>
            </div>
          </div>
        </section>

        {error && <p className="text-sm text-red-400">{error}</p>}

        <div className="flex items-center gap-4">
          <button type="submit" disabled={saving} className="btn-gold px-6 py-2 text-sm disabled:opacity-50">
            {saving ? 'Saving…' : 'Save Changes'}
          </button>
          {saved && <span className="text-sm text-emerald-400">✓ Saved</span>}
        </div>
      </form>
    </div>
  )
}
