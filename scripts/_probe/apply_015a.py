"""One-shot applier for migration 015a_card_reference_image.sql.

Loads .env.local, posts the migration SQL to Supabase Management API,
retries on 55P03 / transient HTTP. Never logs the SUPABASE_TOKEN value.
"""
import json
import os
import pathlib
import sys
import time

import requests

ROOT = pathlib.Path(__file__).resolve().parent.parent.parent
env_path = ROOT / ".env.local"
for line in env_path.read_text(encoding="utf-8").splitlines():
    s = line.strip()
    if not s or s.startswith("#") or "=" not in s:
        continue
    k, v = s.split("=", 1)
    os.environ.setdefault(k.strip(), v.strip())

TOKEN = os.environ.get("SUPABASE_TOKEN")
if not TOKEN:
    sys.exit("SUPABASE_TOKEN missing from env")
REF = os.environ.get("SUPABASE_REF", "dcsrpdmhmcboydjsbgsg")
URL = f"https://api.supabase.com/v1/projects/{REF}/database/query"
HDRS = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

MIG = ROOT / "supabase" / "migrations" / "015a_card_reference_image.sql"
sql = MIG.read_text(encoding="utf-8")
print(f"Migration: {MIG.name}  size={len(sql)} bytes", flush=True)
print("DDL: 4x ADD COLUMN IF NOT EXISTS + 1x CREATE INDEX IF NOT EXISTS (lock_timeout=4s)", flush=True)

backoff = [0, 5, 15, 45, 90, 180]
for attempt, wait in enumerate(backoff, 1):
    if wait:
        print(f"  sleeping {wait}s before attempt {attempt}...", flush=True)
        time.sleep(wait)
    print(f"[attempt {attempt}/{len(backoff)}] POST", flush=True)
    try:
        r = requests.post(URL, headers=HDRS, json={"query": sql}, timeout=60)
    except Exception as e:
        print(f"  ! exception: {type(e).__name__}", flush=True)
        continue
    print(f"  status={r.status_code}", flush=True)
    body = r.text or ""
    print(f"  body[:600]={body[:600]!r}", flush=True)
    if r.status_code in (200, 201):
        low = body.lower()
        if '"error"' in low and ("55p03" in low or "lock_timeout" in low or "could not obtain lock" in low):
            print("  -> transient lock_timeout in body; retrying", flush=True)
            continue
        print("APPLIED", flush=True)
        sys.exit(0)
    if r.status_code in (429, 500, 502, 503, 504, 522, 524, 544):
        print("  -> transient HTTP; retrying", flush=True)
        continue
    if "55P03" in body or "lock_timeout" in body.lower():
        print("  -> 55P03/lock_timeout indication; retrying", flush=True)
        continue
    print(f"PERMANENT FAILURE status={r.status_code}", flush=True)
    sys.exit(1)
print("EXHAUSTED RETRIES", flush=True)
sys.exit(1)
