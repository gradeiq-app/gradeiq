# VERCEL_TOKEN: source from Vercel dashboard → Settings → Tokens
import json, os, pathlib, sys
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

headers = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

# 1. Get numeric GitHub repo ID
gh = requests.get(
    "https://api.github.com/repos/gradeiq-app/gradeiq",
    headers={"Accept": "application/vnd.github+json"},
    timeout=15
)
repo_info = gh.json()
numeric_id = repo_info.get("id")
print(f"GitHub repo numeric ID: {numeric_id}")
print(f"Repo: {repo_info.get('full_name')}  private={repo_info.get('private')}")

# 2. Get latest commit SHA
sha_r = requests.get(
    "https://api.github.com/repos/gradeiq-app/gradeiq/commits/master",
    headers={"Accept": "application/vnd.github+json"},
    timeout=15
)
sha = sha_r.json().get("sha", "")
msg = sha_r.json().get("commit", {}).get("message", "")[:60]
print(f"Latest commit: {sha[:12]}  '{msg}'")

# 3. Trigger deployment
payload = {
    "name": "gradeiq",
    "gitSource": {
        "type":   "github",
        "repoId": str(numeric_id),
        "ref":    "master",
        "sha":    sha,
    },
    "target": "production",
}

r = requests.post(
    f"https://api.vercel.com/v13/deployments?teamId={TEAM_ID}&forceNew=1",
    headers=headers,
    json=payload,
    timeout=30
)
print(f"\nDeploy trigger: {r.status_code}")
d = r.json()
if r.status_code in (200, 201):
    print(f"ID:    {d.get('id')}")
    print(f"URL:   https://{d.get('url', '')}")
    print(f"State: {d.get('status', d.get('readyState', '?'))}")
else:
    print(json.dumps(d, indent=2)[:800])
