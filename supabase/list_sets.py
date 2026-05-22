import os, requests, json

token = os.environ.get("SUPABASE_TOKEN", "")
ref   = os.environ.get("SUPABASE_REF", "")

if not token or not ref:
    print("ERROR: Set SUPABASE_TOKEN and SUPABASE_REF environment variables.")
    raise SystemExit(1)

for sport in ["baseball", "basketball", "football", "hockey"]:
    sql = f"""
    SELECT DISTINCT brand, set_name
    FROM card_sets
    WHERE sport = '{sport}'
    ORDER BY brand, set_name;
    """
    r = requests.post(
        "https://api.supabase.com/v1/projects/" + ref + "/database/query",
        headers={"Authorization": "Bearer " + token, "Content-Type": "application/json"},
        json={"query": sql},
        timeout=30
    )
    rows = r.json()
    print(f"\n{'='*50}")
    print(f"  {sport.upper()} — {len(rows)} distinct brand/set combos")
    print(f"{'='*50}")
    for row in rows:
        print(f"  {row['brand']:<15} {row['set_name']}")
