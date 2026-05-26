-- RawIQ — Admin migration
-- Run after profiles-migration.sql and promo-codes-migration.sql

-- ── 1. Admin flag on profiles ─────────────────────────────────
alter table public.profiles
  add column if not exists is_admin      boolean not null default false,
  add column if not exists deactivated_at timestamptz;

-- ── 2. Site config key-value store ───────────────────────────
-- Drives the announcement banner and display prices without redeploys.
create table if not exists public.site_config (
  key        text primary key,
  value      text not null default '',
  updated_at timestamptz not null default now()
);

-- Anyone (including unauthenticated) can read config (for banners/prices).
alter table public.site_config enable row level security;

create policy "Public can read site_config"
  on public.site_config for select
  using (true);

-- ── 3. Default config values ──────────────────────────────────
insert into public.site_config (key, value) values
  ('announcement_enabled', 'false'),
  ('announcement_text',    ''),
  ('announcement_type',    'info'),   -- 'info' | 'success' | 'warning'
  ('pro_display_price',    '4.99'),
  ('dealer_display_price', '19.99')
on conflict (key) do nothing;

-- ── 4. SECURITY DEFINER helpers for admin writes ─────────────
-- These run with DB-owner privileges but first verify the caller is an admin.

create or replace function public.admin_set_config(p_key text, p_value text)
returns void
language plpgsql
security definer
set search_path = public
as $func$
begin
  if not exists (
    select 1 from profiles where id = auth.uid() and is_admin = true
  ) then
    raise exception 'Not authorized';
  end if;
  insert into site_config (key, value, updated_at)
    values (p_key, p_value, now())
    on conflict (key) do update set value = excluded.value, updated_at = now();
end;
$func$;

create or replace function public.admin_deactivate_user(p_user_id uuid, p_deactivate boolean)
returns void
language plpgsql
security definer
set search_path = public
as $func$
begin
  if not exists (
    select 1 from profiles where id = auth.uid() and is_admin = true
  ) then
    raise exception 'Not authorized';
  end if;
  update profiles
    set deactivated_at = case when p_deactivate then now() else null end
    where id = p_user_id;
end;
$func$;

-- ── 5. Make yourself admin ────────────────────────────────────
-- Run this in the SQL editor with your actual user UUID:
-- update public.profiles set is_admin = true where id = '<your-uuid>';
