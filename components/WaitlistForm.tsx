'use client'

import { useState } from 'react'

export default function WaitlistForm() {
  const [email, setEmail] = useState('')
  const [state, setState] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [errorMsg, setErrorMsg] = useState('')

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!email) return
    setState('loading')

    try {
      const res = await fetch('/api/waitlist', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      })
      const data = await res.json()

      if (!res.ok) {
        setErrorMsg(data.error ?? 'Something went wrong.')
        setState('error')
      } else {
        setState('success')
      }
    } catch {
      setErrorMsg('Network error. Please try again.')
      setState('error')
    }
  }

  if (state === 'success') {
    return (
      <div className="flex flex-col items-center gap-2 py-4">
        <div className="flex h-10 w-10 items-center justify-center rounded-full bg-gold/20 text-gold">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <polyline points="20 6 9 17 4 12" />
          </svg>
        </div>
        <p className="font-medium text-white">You&apos;re on the list!</p>
        <p className="text-sm text-muted">We&apos;ll notify you when new features drop.</p>
      </div>
    )
  }

  return (
    <form onSubmit={handleSubmit} className="flex w-full max-w-md flex-col gap-3 sm:flex-row">
      <input
        type="email"
        required
        value={email}
        onChange={e => setEmail(e.target.value)}
        placeholder="Enter your email"
        className="input-base flex-1"
        disabled={state === 'loading'}
      />
      <button
        type="submit"
        disabled={state === 'loading'}
        className="btn-gold shrink-0 px-6"
      >
        {state === 'loading' ? 'Joining…' : 'Join Waitlist'}
      </button>

      {state === 'error' && (
        <p className="w-full text-sm text-red-400 sm:col-span-2">{errorMsg}</p>
      )}
    </form>
  )
}
