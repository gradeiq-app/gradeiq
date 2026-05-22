/**
 * Server-side helpers that require elevated Supabase privileges.
 * Only import from API routes and Server Components — never from client code.
 */
import { createServerClient } from '@supabase/ssr'
import { createClient } from './supabase-server'

/** Service-role client — bypasses RLS. Requires SUPABASE_SERVICE_ROLE_KEY. */
export function getServiceClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!url || !key) return null
  return createServerClient(url, key, {
    cookies: { get: () => undefined, set: () => {}, remove: () => {} },
    auth: { persistSession: false },
  })
}

/**
 * Verify the current request's session belongs to an admin.
 * Returns the user object if authorised, null otherwise.
 */
export async function requireAdmin() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return null

  const { data } = await supabase
    .from('profiles')
    .select('is_admin, deactivated_at')
    .eq('id', user.id)
    .single()

  if (!data?.is_admin) return null
  return user
}
