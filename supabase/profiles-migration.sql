-- RawIQ — Profiles migration
-- Run this in the Supabase SQL Editor after the initial schema.sql

-- Profiles table: extends auth.users with billing + quota data
create table if not exists public.profiles (
  id                     uuid primary key references auth.users(id) on delete cascade,
  plan                   text not null default 'free'
                           check (plan in ('free', 'pro', 'dealer')),
  lookup_count           int not null default 0,
  lookup_reset_date      timestamptz not null
                           default (date_trunc('month', now()) + interval '1 month'),
  stripe_customer_id     text unique,
  stripe_subscription_id text unique,
  updated_at             timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "Users read own profile"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Users insert own profile"
  on public.profiles for insert
  with check (auth.uid() = id);

create policy "Users update own profile"
  on public.profiles for update
  using (auth.uid() = id);

-- Auto-create a profile row whenever a new user signs up
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id)
  values (new.id)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Back-fill profiles for any users that already exist
insert into public.profiles (id)
select id from auth.users
on conflict (id) do nothing;
