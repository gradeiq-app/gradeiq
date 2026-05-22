-- ============================================================
-- GradeIQ — Sets Discovery Queue
-- Holds candidates found by the daily RSS scraper agent
-- ============================================================

CREATE TABLE IF NOT EXISTS sets_queue (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  sport            text        NOT NULL,
  year             integer     NOT NULL,
  brand            text        NOT NULL,
  set_name         text        NOT NULL,
  source_url       text,
  source_name      text,
  source_title     text,                       -- original RSS headline
  status           text        NOT NULL DEFAULT 'pending',  -- pending | approved | rejected
  proposed_parallels jsonb     NOT NULL DEFAULT '[]'::jsonb,
  created_at       timestamptz NOT NULL DEFAULT now(),
  reviewed_at      timestamptz,
  reviewed_by      uuid REFERENCES auth.users(id),
  CONSTRAINT sets_queue_sport_year_brand_set_key UNIQUE (sport, year, brand, set_name)
);

-- Status index for fast admin queries
CREATE INDEX IF NOT EXISTS sets_queue_status_idx ON sets_queue (status, created_at DESC);

-- Only admins read/write this table
ALTER TABLE sets_queue ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Service role full access"
  ON sets_queue FOR ALL
  USING (true)
  WITH CHECK (true);
