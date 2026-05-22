import os, requests, json

token = os.environ.get("SUPABASE_TOKEN", "")
ref   = os.environ.get("SUPABASE_REF", "")

if not token or not ref:
    print("ERROR: Set SUPABASE_TOKEN and SUPABASE_REF environment variables.")
    raise SystemExit(1)

sql = """
SELECT sport, COUNT(*) as total, COUNT(DISTINCT brand) as brands, COUNT(DISTINCT set_name) as unique_sets,
       MIN(year) as min_year, MAX(year) as max_year
FROM card_sets
GROUP BY sport
ORDER BY sport;
"""

r = requests.post(
    "https://api.supabase.com/v1/projects/" + ref + "/database/query",
    headers={"Authorization": "Bearer " + token, "Content-Type": "application/json"},
    json={"query": sql},
    timeout=30
)
print("STATUS:", r.status_code)
data = r.json()
print(json.dumps(data, indent=2))

# also total
r2 = requests.post(
    "https://api.supabase.com/v1/projects/" + ref + "/database/query",
    headers={"Authorization": "Bearer " + token, "Content-Type": "application/json"},
    json={"query": "SELECT COUNT(*) as total FROM card_sets;"},
    timeout=30
)
print("\nTotal rows:", r2.json())
