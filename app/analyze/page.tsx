import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase-server'
import AnalyzePage from '@/components/AnalyzePage'

export const dynamic = 'force-dynamic'

export const metadata = {
  title: 'Analyze — GradeIQ',
}

export default async function Page() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/?auth=required')
  }

  // Check for deactivated account
  const { data: profile } = await supabase
    .from('profiles')
    .select('deactivated_at')
    .eq('id', user.id)
    .single()

  if (profile?.deactivated_at) {
    await supabase.auth.signOut()
    redirect('/?deactivated=true')
  }

  return <AnalyzePage user={user} />
}
