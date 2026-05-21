-- GradeIQ Supabase Schema
-- Run this in the Supabase SQL editor to create the required tables.

-- Waitlist
create table if not exists public.waitlist (
  id         uuid primary key default gen_random_uuid(),
  email      text not null unique,
  created_at timestamptz not null default now()
);

alter table public.waitlist enable row level security;

-- Anyone can insert their email (public signup)
create policy "Anyone can join waitlist"
  on public.waitlist for insert
  with check (true);

-- Only service role can read
create policy "Service role reads waitlist"
  on public.waitlist for select
  using (auth.role() = 'service_role');


-- Card lookups (saved analysis history per user)
create table if not exists public.lookups (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  card_name   text not null,
  raw_value   numeric(10, 2),
  result_json jsonb not null,
  created_at  timestamptz not null default now()
);

alter table public.lookups enable row level security;

-- Users can only read/write their own lookups
create policy "Users read own lookups"
  on public.lookups for select
  using (auth.uid() = user_id);

create policy "Users insert own lookups"
  on public.lookups for insert
  with check (auth.uid() = user_id);

create policy "Users delete own lookups"
  on public.lookups for delete
  using (auth.uid() = user_id);

-- Index for fast user history queries
create index if not exists lookups_user_id_created_at
  on public.lookups (user_id, created_at desc);
