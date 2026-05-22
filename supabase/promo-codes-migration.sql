-- GradeIQ — Promo / demo code migration
-- Run after profiles-migration.sql

-- ── 1. Extend profiles with promo fields ─────────────────────
alter table public.profiles
  add column if not exists bonus_lookups         int not null default 0,
  add column if not exists promo_plan            text
    check (promo_plan in ('pro', 'dealer')),
  add column if not exists promo_plan_expires_at timestamptz;

-- ── 2. Promo codes catalog ────────────────────────────────────
create table if not exists public.promo_codes (
  id               uuid primary key default gen_random_uuid(),
  code             text unique not null,          -- always stored uppercase
  description      text,                          -- internal note (e.g. "Conference demo Q3")
  -- What it grants (at most one of the two):
  extra_lookups    int,                           -- adds N lookups to free quota
  grants_plan      text check (grants_plan in ('pro', 'dealer')),
  grants_plan_days int,                           -- null = permanent
  -- Limits:
  max_uses         int,                           -- null = unlimited
  used_count       int not null default 0,
  active           boolean not null default true,
  expires_at       timestamptz,                   -- code itself expires (separate from plan duration)
  created_at       timestamptz not null default now()
);

-- ── 3. Redemption log ─────────────────────────────────────────
create table if not exists public.promo_redemptions (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid not null references auth.users(id) on delete cascade,
  code_id      uuid not null references public.promo_codes(id),
  redeemed_at  timestamptz not null default now(),
  unique (user_id, code_id)            -- one redemption per code per user
);

-- RLS: users can see their own redemptions
alter table public.promo_redemptions enable row level security;

create policy "Users view own redemptions"
  on public.promo_redemptions for select
  using (auth.uid() = user_id);

-- ── 4. SECURITY DEFINER function ─────────────────────────────
-- Runs with elevated privileges so it can update promo_codes.used_count
-- even though end-users have no direct write access to that table.
create or replace function public.redeem_promo_code(p_code text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $func$
declare
  v_code   promo_codes%rowtype;
  v_uid    uuid := auth.uid();
begin
  if v_uid is null then
    return jsonb_build_object('error', 'not_authenticated');
  end if;

  -- Lock the row to prevent race conditions on max_uses
  select * into v_code
  from promo_codes
  where code = upper(trim(p_code))
    and active = true
  for update;

  if not found then
    return jsonb_build_object('error', 'invalid_code');
  end if;

  if v_code.expires_at is not null and v_code.expires_at < now() then
    return jsonb_build_object('error', 'expired_code');
  end if;

  if v_code.max_uses is not null and v_code.used_count >= v_code.max_uses then
    return jsonb_build_object('error', 'code_exhausted');
  end if;

  if exists (
    select 1 from promo_redemptions
    where user_id = v_uid and code_id = v_code.id
  ) then
    return jsonb_build_object('error', 'already_redeemed');
  end if;

  -- Record redemption & bump counter
  insert into promo_redemptions (user_id, code_id) values (v_uid, v_code.id);
  update promo_codes set used_count = used_count + 1 where id = v_code.id;

  -- Apply benefit
  if v_code.grants_plan is not null then
    update profiles set
      promo_plan            = v_code.grants_plan,
      promo_plan_expires_at = case
        when v_code.grants_plan_days is not null
          then now() + (v_code.grants_plan_days || ' days')::interval
        else null  -- permanent
      end
    where id = v_uid;

    return jsonb_build_object(
      'success', true,
      'granted', v_code.grants_plan,
      'days',    v_code.grants_plan_days
    );
  end if;

  if v_code.extra_lookups is not null then
    update profiles
      set bonus_lookups = coalesce(bonus_lookups, 0) + v_code.extra_lookups
    where id = v_uid;

    return jsonb_build_object(
      'success',       true,
      'extra_lookups', v_code.extra_lookups
    );
  end if;

  return jsonb_build_object('success', true);
end;
$func$;

-- ── 5. Example seed codes (optional — delete before production) ──
-- insert into public.promo_codes (code, description, extra_lookups, max_uses)
--   values ('DEMO10', '10 bonus lookups for prospects', 10, null);
--
-- insert into public.promo_codes (code, description, grants_plan, grants_plan_days, max_uses)
--   values ('PROTRIAL', '7-day Pro trial', 'pro', 7, null);
