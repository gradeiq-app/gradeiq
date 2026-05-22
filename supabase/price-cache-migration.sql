-- ─────────────────────────────────────────────────────────────────────────────
-- Price Cache
-- Stores eBay results keyed by search params (24-hr TTL).
-- Dramatically reduces eBay API calls when multiple users look up the same card.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists price_cache (
  id          uuid        primary key default gen_random_uuid(),
  cache_key   text        unique not null,          -- normalized param hash
  raw_avg     numeric     not null default 0,
  raw_count   integer     not null default 0,
  psa8_avg    numeric     not null default 0,
  psa8_count  integer     not null default 0,
  psa9_avg    numeric     not null default 0,
  psa9_count  integer     not null default 0,
  psa10_avg   numeric     not null default 0,
  psa10_count integer     not null default 0,
  created_at  timestamptz not null default now(),
  expires_at  timestamptz not null
);

-- Fast lookup: key + expiry checked together
create index if not exists price_cache_key_exp on price_cache (cache_key, expires_at);

-- Public read (anon can read cache hits), no writes via client
alter table price_cache enable row level security;
create policy "Anyone can read price_cache"
  on price_cache for select using (true);
