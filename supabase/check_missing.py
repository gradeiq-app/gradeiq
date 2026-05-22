import os, requests

token = os.environ.get("SUPABASE_TOKEN", "")
ref   = os.environ.get("SUPABASE_REF", "")

if not token or not ref:
    print("ERROR: Set SUPABASE_TOKEN and SUPABASE_REF environment variables.")
    raise SystemExit(1)

def query(sql):
    r = requests.post(
        f"https://api.supabase.com/v1/projects/{ref}/database/query",
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        json={"query": sql}, timeout=30
    )
    return r.json()

# What brand+set combos exist per sport?
for sport, years in [("basketball", "2025"), ("football", "2025")]:
    rows = query(f"""
        SELECT DISTINCT brand, set_name FROM card_sets
        WHERE sport = '{sport}' AND year = {years}
        ORDER BY brand, set_name;
    """)
    print(f"\n=== {sport.upper()} year {years} ===")
    for r in rows:
        print(f"  {r['brand']:<15} {r['set_name']}")
