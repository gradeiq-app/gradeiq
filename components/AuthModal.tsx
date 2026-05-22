'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase-browser'
import { useRouter } from 'next/navigation'

type Mode = 'login' | 'signup'

interface Props {
  isOpen: boolean
  initialMode?: Mode
  onClose: () => void
}

export default function AuthModal({ isOpen, initialMode = 'login', onClose }: Props) {
  const [mode, setMode] = useState<Mode>(initialMode)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [message, setMessage] = useState('')
  const router = useRouter()
  const supabase = createClient()  // null when NEXT_PUBLIC_SUPABASE_* env vars are not set

  useEffect(() => {
    setMode(initialMode)
    setError('')
    setMessage('')
  }, [initialMode, isOpen])

  useEffect(() => {
    if (!isOpen) return
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', handler)
    return () => window.removeEventListener('keydown', handler)
  }, [isOpen, onClose])

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError('')
    setMessage('')
    setLoading(true)

    try {
      if (!supabase) throw new Error('Supabase is not configured. Add NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY to .env.local.')
      if (mode === 'login') {
        const { error } = await supabase.auth.signInWithPassword({ email, password })
        if (error) throw error
        onClose()
        router.push('/analyze')
        router.refresh()
      } else {
        const { data, error } = await supabase.auth.signUp({ email, password })
        if (error) throw error
        // If auto-confirm is on, session is immediately available — go straight to app
        if (data.session) {
          onClose()
          router.push('/analyze')
          router.refresh()
        } else {
          setMessage('Check your email to confirm your account, then sign in.')
        }
      }
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Something went wrong')
    } finally {
      setLoading(false)
    }
  }

  if (!isOpen) return null

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      {/* Backdrop */}
      <div className="absolute inset-0 bg-black/70 backdrop-blur-sm" />

      {/* Modal */}
      <div className="relative w-full max-w-sm animate-slide-up rounded-2xl border border-border bg-surface p-8 shadow-2xl">
        {/* Close */}
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded-md p-1 text-muted hover:text-white transition-colors"
          aria-label="Close"
        >
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M18 6L6 18M6 6l12 12" />
          </svg>
        </button>

        {/* Logo mark */}
        <div className="mb-6 flex flex-col items-center gap-1 text-center">
          <span className="font-heading text-2xl text-gold-gradient">GradeIQ</span>
          <p className="text-sm text-muted">
            {mode === 'login' ? 'Welcome back.' : 'Create your free account.'}
          </p>
        </div>

        {message ? (
          <div className="rounded-lg border border-gold/30 bg-gold-muted p-4 text-center text-sm text-gold">
            {message}
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <div>
              <label htmlFor="auth-email" className="mb-1.5 block text-xs font-medium text-muted uppercase tracking-wider">
                Email
              </label>
              <input
                id="auth-email"
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={e => setEmail(e.target.value)}
                placeholder="you@example.com"
                className="input-base"
              />
            </div>

            <div>
              <label htmlFor="auth-password" className="mb-1.5 block text-xs font-medium text-muted uppercase tracking-wider">
                Password
              </label>
              <input
                id="auth-password"
                type="password"
                required
                minLength={6}
                autoComplete={mode === 'login' ? 'current-password' : 'new-password'}
                value={password}
                onChange={e => setPassword(e.target.value)}
                placeholder="••••••••"
                className="input-base"
              />
              {mode === 'signup' && (
                <p className="mt-1 text-xs text-muted">Minimum 6 characters</p>
              )}
            </div>

            {error && (
              <p className="rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-sm text-red-400">
                {error}
              </p>
            )}

            <button type="submit" disabled={loading} className="btn-gold mt-1 w-full py-3">
              {loading ? (
                <span className="flex items-center gap-2">
                  <Spinner /> {mode === 'login' ? 'Signing in…' : 'Creating account…'}
                </span>
              ) : mode === 'login' ? 'Sign In' : 'Create Account'}
            </button>
          </form>
        )}

        {/* Toggle */}
        {!message && (
          <p className="mt-5 text-center text-sm text-muted">
            {mode === 'login' ? "Don't have an account? " : 'Already have an account? '}
            <button
              onClick={() => { setMode(mode === 'login' ? 'signup' : 'login'); setError('') }}
              className="font-medium text-gold hover:text-gold-light transition-colors"
            >
              {mode === 'login' ? 'Sign up free' : 'Sign in'}
            </button>
          </p>
        )}
      </div>
    </div>
  )
}

function Spinner() {
  return (
    <svg className="animate-spin" width="14" height="14" viewBox="0 0 24 24" fill="none">
      <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="3" strokeOpacity="0.3" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
    </svg>
  )
}
