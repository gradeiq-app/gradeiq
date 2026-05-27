# VERCEL_TOKEN: source from Vercel dashboard → Settings → Tokens
import os, pathlib, sys
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

TOKEN = os.environ.get("VERCEL_TOKEN")
PROJECT_ID = os.environ.get("VERCEL_PROJECT_ID")
TEAM_ID = os.environ.get("VERCEL_TEAM_ID")
missing = [k for k, v in (("VERCEL_TOKEN", TOKEN), ("VERCEL_PROJECT_ID", PROJECT_ID), ("VERCEL_TEAM_ID", TEAM_ID)) if not v]
if missing:
    sys.exit(
        f"ERROR: missing env vars: {', '.join(missing)}.\n"
        "  Add to .env.local. Token source: Vercel dashboard → Settings → Tokens."
    )

DEPLOY_ID = "dpl_AYrLVGpATKZLC45c13a3ptEKepYv"

h = {"Authorization": f"Bearer {TOKEN}"}

# Get project domains / aliases
r = requests.get(
    f"https://api.vercel.com/v9/projects/{PROJECT_ID}?teamId={TEAM_ID}",
    headers=h, timeout=15
)
p = r.json()
print("Production aliases:")
for a in p.get("alias", []):
    print(f"  {a}")
print()

# Check the deployment's aliases
r2 = requests.get(
    f"https://api.vercel.com/v13/deployments/{DEPLOY_ID}?teamId={TEAM_ID}",
    headers=h, timeout=15
)
d = r2.json()
print(f"Deploy state:  {d.get('status', d.get('readyState'))}")
print(f"Deploy URL:    https://{d.get('url', '')}")
print("Aliases assigned:")
for a in d.get("alias", []):
    print(f"  https://{a}")
