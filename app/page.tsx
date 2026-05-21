import LandingPage from '@/components/LandingPage'

export default function Page({
  searchParams,
}: {
  searchParams: { auth?: string }
}) {
  return <LandingPage initialShowAuth={searchParams.auth === 'required'} />
}
