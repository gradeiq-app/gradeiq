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

  return <AnalyzePage user={user} />
}
