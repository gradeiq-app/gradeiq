import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase-server'

export const dynamic = 'force-dynamic'

export const metadata = { title: 'Admin — GradeIQ' }

export default async function AdminLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/')

  const { data: profile } = await supabase
    .from('profiles')
    .select('is_admin')
    .eq('id', user.id)
    .single()

  if (!profile?.is_admin) redirect('/')

  return (
    <div className="min-h-screen bg-background font-body text-white">
      {/* Admin header */}
      <header className="sticky top-0 z-40 border-b border-border bg-background/90 backdrop-blur-md">
        <div className="mx-auto flex max-w-7xl items-center gap-6 px-5 py-3">
          <a href="/" className="font-heading text-lg text-gold-gradient">GradeIQ</a>
          <span className="rounded-full border border-amber-500/30 bg-amber-500/10 px-2 py-0.5 text-xs font-semibold text-amber-400">
            Admin
          </span>
          <nav className="flex items-center gap-1 text-sm">
            {[
              { href: '/admin/dashboard', label: 'Dashboard' },
              { href: '/admin/promos',    label: 'Promos' },
              { href: '/admin/users',     label: 'Users' },
              { href: '/admin/settings',  label: 'Settings' },
            ].map(({ href, label }) => (
              <a
                key={href}
                href={href}
                className="rounded-md px-3 py-1.5 text-muted transition-colors hover:bg-surface hover:text-white"
              >
                {label}
              </a>
            ))}
          </nav>
          <div className="ml-auto">
            <a href="/analyze" className="text-xs text-muted hover:text-white transition-colors">
              ← Back to App
            </a>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-7xl px-5 py-10">
        {children}
      </main>
    </div>
  )
}
