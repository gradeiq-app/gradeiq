import sys, os, requests, json

# Set SUPABASE_TOKEN and SUPABASE_REF as environment variables, or pass inline:
#   SUPABASE_TOKEN=sbp_... SUPABASE_REF=xxx python run_patch.py my_patch.sql
token = os.environ.get("SUPABASE_TOKEN", "")
ref   = os.environ.get("SUPABASE_REF", "")

if not token or not ref:
    print("ERROR: Set SUPABASE_TOKEN and SUPABASE_REF environment variables.")
    sys.exit(1)

with open(sys.argv[1], "r", encoding="utf-8") as f:
    sql = f.read()

r = requests.post(
    "https://api.supabase.com/v1/projects/" + ref + "/database/query",
    headers={"Authorization": "Bearer " + token, "Content-Type": "application/json"},
    json={"query": sql},
    timeout=90
)
print("STATUS:", r.status_code)
try:
    data = r.json()
    print(json.dumps(data, indent=2)[:5000])
except Exception:
    print(r.text[:5000])
