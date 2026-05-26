-- ============================================================
-- RawIQ — Parallel Verifier
-- Migration 005: Add verifier columns to parallels table,
--                create parallel_verifications log,
--                create parallel-references storage bucket.
-- ============================================================

-- ── 1. Extend parallels table with verifier metadata ─────────────────────────
ALTER TABLE public.parallels
  ADD COLUMN IF NOT EXISTS reference_image_url  text,          -- Supabase Storage public URL
  ADD COLUMN IF NOT EXISTS visual_identifiers   text[],        -- e.g. ARRAY['Gold borders', 'Holo surface']
  ADD COLUMN IF NOT EXISTS surface_description  text;          -- plain English description

-- ── 2. Parallel verifications log ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.parallel_verifications (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  -- Relational reference (nullable — populated once individual parallels are seeded)
  parallel_id      uuid        REFERENCES public.parallels(id) ON DELETE SET NULL,
  set_id           uuid        REFERENCES public.sets(id) ON DELETE SET NULL,
  -- Denormalized for queries without card-level data
  parallel_label   text        NOT NULL,
  sport            text        NOT NULL,
  year             integer     NOT NULL,
  brand            text        NOT NULL,
  set_name         text        NOT NULL,
  -- Verdict fields
  verdict          text        NOT NULL
    CHECK (verdict IN ('CONFIRMED','LIKELY MATCH','POSSIBLE MISMATCH','MISMATCH','UNAVAILABLE')),
  confidence       integer     NOT NULL DEFAULT 0
    CHECK (confidence BETWEEN 0 AND 100),
  ai_response_json jsonb,
  -- Source of reference image used
  reference_source text,       -- 'ebay' | 'storage' | 'none'
  created_at       timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.parallel_verifications ENABLE ROW LEVEL SECURITY;

-- Users can read/write their own verifications
CREATE POLICY "Users read own verifications"
  ON public.parallel_verifications FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own verifications"
  ON public.parallel_verifications FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Service role can read all (for admin analytics)
-- (service role bypasses RLS automatically — no policy needed)

CREATE INDEX IF NOT EXISTS pv_user_id_created  ON public.parallel_verifications (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS pv_parallel_id      ON public.parallel_verifications (parallel_id) WHERE parallel_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS pv_verdict          ON public.parallel_verifications (verdict, created_at DESC);
CREATE INDEX IF NOT EXISTS pv_created_at       ON public.parallel_verifications (created_at DESC);

-- ── 3. Supabase Storage bucket ────────────────────────────────────────────────
-- Create via storage schema (requires service role / superuser).
-- Bucket is private — URLs are signed or served via Next.js proxy.
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'parallel-references',
  'parallel-references',
  false,
  5242880,    -- 5 MB max per reference image
  ARRAY['image/jpeg','image/jpg','image/png','image/webp']
)
ON CONFLICT (id) DO NOTHING;

-- Storage RLS: admins can upload; anyone can read (via signed URL)
CREATE POLICY "Admins can upload reference images"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'parallel-references'
    AND EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND is_admin = true
    )
  );

CREATE POLICY "Anyone can read reference images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'parallel-references');
