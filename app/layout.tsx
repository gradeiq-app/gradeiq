import type { Metadata } from 'next'
import { DM_Serif_Display, DM_Sans } from 'next/font/google'
import './globals.css'

const dmSerifDisplay = DM_Serif_Display({
  subsets: ['latin'],
  weight: '400',
  variable: '--font-heading',
  display: 'swap',
})

const dmSans = DM_Sans({
  subsets: ['latin'],
  variable: '--font-body',
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'RawIQ — PSA Submission Optimizer',
  description:
    'Know before you slab. RawIQ analyzes real eBay sold data to calculate your exact ROI for every PSA grading tier before you spend a dollar.',
  openGraph: {
    title: 'RawIQ — PSA Submission Optimizer',
    description:
      'Know before you slab. Data-driven ROI analysis for sports card collectors.',
    type: 'website',
  },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${dmSerifDisplay.variable} ${dmSans.variable}`}>
      <body>{children}</body>
    </html>
  )
}
