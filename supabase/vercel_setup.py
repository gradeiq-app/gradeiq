# VERCEL_TOKEN: source from Vercel dashboard → Settings → Tokens
import os, pathlib, secrets, sys
import requests


def load_env_local() -> None:
    """Parse .env.local at the repo root into os.environ. Skip blank lines
    and #-comments. Existing os.environ values are NOT overwritten."""
    env_path = pathlib.Path(__file__).resolve().parent.parent / ".env.local"
    if not env_path.exists():
        return
    for line in env_path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.startswith("#") or "=" not in s:
            continue
        k, v = s.split("=", 1)
        k, v = k.strip(), v.strip()
        if len(v) >= 2 and v[0] == v[-1] and v[0] in ("'", '"'):
            v = v[1:-1]
        if k and k not in os.environ:
            os.environ[k] = v


load_env_local()

VERCEL_TOKEN = os.environ.get("VERCEL_TOKEN")
PROJECT_ID = os.environ.get("VERCEL_PROJECT_ID")
TEAM_ID = os.environ.get("VERCEL_TEAM_ID")
NEXT_PUBLIC_SUPABASE_URL = os.environ.get("NEXT_PUBLIC_SUPABASE_URL")
NEXT_PUBLIC_SUPABASE_ANON_KEY = os.environ.get("NEXT_PUBLIC_SUPABASE_ANON_KEY")
SUPABASE_SERVICE_ROLE_KEY = os.environ.get("SUPABASE_SERVICE_ROLE_KEY")
EBAY_VERIFICATION_TOKEN = os.environ.get("EBAY_VERIFICATION_TOKEN")
missing = [k for k, v in (
    ("VERCEL_TOKEN", VERCEL_TOKEN),
    ("VERCEL_PROJECT_ID", PROJECT_ID),
    ("VERCEL_TEAM_ID", TEAM_ID),
    ("NEXT_PUBLIC_SUPABASE_URL", NEXT_PUBLIC_SUPABASE_URL),
    ("NEXT_PUBLIC_SUPABASE_ANON_KEY", NEXT_PUBLIC_SUPABASE_ANON_KEY),
    ("SUPABASE_SERVICE_ROLE_KEY", SUPABASE_SERVICE_ROLE_KEY),
    ("EBAY_VERIFICATION_TOKEN", EBAY_VERIFICATION_TOKEN),
) if not v]
if missing:
    sys.exit(
        f"ERROR: missing env vars: {', '.join(missing)}.\n"
        "  Add to .env.local. Token source: Vercel dashboard → Settings → Tokens."
    )

HEADERS = {
    "Authorization": f"Bearer {VERCEL_TOKEN}",
    "Content-Type": "application/json",
}
BASE = "https://api.vercel.com"

# ── 1. List existing env vars ──────────────────────────────────────────────────
print("=== Fetching existing Vercel env vars ===")
r = requests.get(
    f"{BASE}/v9/projects/{PROJECT_ID}/env?teamId={TEAM_ID}",
    headers=HEADERS
)
existing = r.json()
existing_keys = {e["key"] for e in existing.get("envs", [])}
print(f"  Existing keys: {sorted(existing_keys)}")

# ── 2. Env vars to ensure exist ────────────────────────────────────────────────
CRON_SECRET = secrets.token_hex(32)
print(f"\n  Generated CRON_SECRET = {CRON_SECRET}")

TARGET_ENVS = {
    "NEXT_PUBLIC_SUPABASE_URL":      NEXT_PUBLIC_SUPABASE_URL,
    "NEXT_PUBLIC_SUPABASE_ANON_KEY": NEXT_PUBLIC_SUPABASE_ANON_KEY,
    "SUPABASE_SERVICE_ROLE_KEY":     SUPABASE_SERVICE_ROLE_KEY,
    "EBAY_VERIFICATION_TOKEN":       EBAY_VERIFICATION_TOKEN,
    "CRON_SECRET":                   CRON_SECRET,
}

# ── 3. Create or update each env var ──────────────────────────────────────────
print("\n=== Upserting env vars ===")
for key, value in TARGET_ENVS.items():
    if key in existing_keys:
        # Find the existing entry id and patch it
        env_id = next(e["id"] for e in existing["envs"] if e["key"] == key)
        r = requests.patch(
            f"{BASE}/v9/projects/{PROJECT_ID}/env/{env_id}?teamId={TEAM_ID}",
            headers=HEADERS,
            json={"value": value, "type": "encrypted", "target": ["production", "preview", "development"]}
        )
        print(f"  PATCH {key}: {r.status_code}")
    else:
        r = requests.post(
            f"{BASE}/v10/projects/{PROJECT_ID}/env?teamId={TEAM_ID}",
            headers=HEADERS,
            json={"key": key, "value": value, "type": "encrypted", "target": ["production", "preview", "development"]}
        )
        print(f"  POST  {key}: {r.status_code}")
    if r.status_code not in (200, 201):
        print(f"    ERROR: {r.text[:300]}")

# ── 4. Write CRON_SECRET to local .env.local too ───────────────────────────────
env_path = pathlib.Path(__file__).resolve().parent.parent / ".env.local"
content = env_path.read_text(encoding="utf-8")

if "CRON_SECRET=" not in content:
    with env_path.open("a", encoding="utf-8") as f:
        f.write(f"\nCRON_SECRET={CRON_SECRET}\n")
    print(f"\n  Written CRON_SECRET to .env.local")
else:
    print(f"\n  CRON_SECRET already in .env.local")

print(f"\n  CRON_SECRET = {CRON_SECRET}")
print("\n=== Done ===")
