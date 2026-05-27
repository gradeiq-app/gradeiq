"""
seed_players.py - overnight player roster seeder for RawIQ.

Safe operations:
  - Inserts into public.players only.
  - Idempotent via WHERE NOT EXISTS on (name, sport_id) — no schema changes.
  - Logs every batch with insert/skip counts.
  - On per-batch error: logs and continues. Never aborts the run.
  - After all sports seeded: UPDATE search_vector WHERE NULL.

Rosters are training-data-derived, prioritized for prominent / card-relevant
players in the 2018-2025 window. Names that already exist for the given
sport_id are silently skipped by the NOT EXISTS guard.
"""
import os, sys, time, json, requests

TOKEN = os.environ.get("SUPABASE_TOKEN")
if not TOKEN:
    sys.exit(
        "ERROR: SUPABASE_TOKEN env var is required.\n"
        "  Source from Supabase dashboard > Account > Access Tokens (sbp_...).\n"
        "  Then: $env:SUPABASE_TOKEN = 'sbp_...'  (PowerShell)\n"
        "        export SUPABASE_TOKEN='sbp_...'  (bash)"
    )
REF   = os.environ.get("SUPABASE_REF",   "dcsrpdmhmcboydjsbgsg")
URL   = f"https://api.supabase.com/v1/projects/{REF}/database/query"
HDRS  = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

SPORTS = {
    "Basketball": "2c7883d5-26a7-4b2e-bbfc-dd17a41598d6",
    "WNBA":       "d4c5ab12-83df-4fc0-ab7d-0cc30d4b3972",
    "Baseball":   "2791898a-d019-45c2-a0f6-c7d681af701b",
    "Football":   "375bd899-8dcc-485f-9b24-9d4dbdc26423",
    "Hockey":     "ddb9d2c6-c7bc-4cf1-ad2c-c1a520278935",
    "Soccer":     "24521349-0287-4624-bcf6-dcd4f131c918",
}

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)

def sql_quote(s):
    if s is None or s == "":
        return "NULL"
    return "'" + str(s).replace("'", "''") + "'"

def run_sql(sql, timeout=120):
    try:
        r = requests.post(URL, headers=HDRS, json={"query": sql}, timeout=timeout)
        return r.status_code, r.text
    except Exception as e:
        return 0, repr(e)

def parse_roster(text):
    """Lines: 'Name|Pos' or 'Name|Pos|active'. '#' starts a comment."""
    out, seen = [], set()
    for line in text.strip().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        parts = [p.strip() for p in line.split("|")]
        name = parts[0]
        if not name or name in seen:
            continue
        seen.add(name)
        pos  = parts[1] if len(parts) > 1 and parts[1] else None
        active = True
        if len(parts) > 2:
            active = parts[2].lower() in ("true", "t", "1", "y", "yes")
        out.append((name, pos, active))
    return out

def seed_sport(sport_name, roster_text, batch_size=50):
    sport_id = SPORTS[sport_name]
    roster = parse_roster(roster_text)
    total_batches = (len(roster) + batch_size - 1) // batch_size
    log(f"=== {sport_name}: {len(roster)} unique names, {total_batches} batches ===")
    inserted_total, error_total = 0, 0
    for i in range(0, len(roster), batch_size):
        chunk = roster[i:i+batch_size]
        bn = i // batch_size + 1
        values = ",\n".join(
            f"({sql_quote(n)}, {sql_quote(p)}, {str(a).lower()})"
            for n, p, a in chunk
        )
        sql = f"""
WITH src(name, position, active) AS (VALUES
{values}
)
INSERT INTO players (name, sport_id, position, active)
SELECT s.name, '{sport_id}'::uuid, s.position, s.active
FROM src s
WHERE NOT EXISTS (
    SELECT 1 FROM players p
    WHERE p.name = s.name AND p.sport_id = '{sport_id}'::uuid
)
RETURNING 1;
"""
        status, body = run_sql(sql)
        if status == 201:
            try:
                inserted = len(json.loads(body))
            except Exception:
                inserted = 0
            inserted_total += inserted
            log(f"  {sport_name} batch {bn}/{total_batches}: inserted {inserted}/{len(chunk)} (running total {inserted_total} new in {sport_name})")
        else:
            error_total += 1
            log(f"  {sport_name} batch {bn}/{total_batches} FAILED status={status} body={body[:300]}")
    log(f"=== {sport_name} done: inserted {inserted_total} new, errors {error_total} ===")
    return inserted_total, error_total

def refresh_search_vectors():
    # search_vector is a GENERATED ALWAYS column derived from name —
    # auto-maintained on insert/update. Nothing to do.
    log("=== search_vector is GENERATED — auto-maintained, no refresh needed ===")

def final_counts():
    log("=== Final player counts by sport ===")
    sql = """
SELECT s.name AS sport, COUNT(p.id) AS n
FROM sports s LEFT JOIN players p ON p.sport_id = s.id
GROUP BY s.name ORDER BY s.name;
"""
    status, body = run_sql(sql)
    if status == 201:
        for row in json.loads(body):
            log(f"  {row['sport']:>10s}: {row['n']}")
    else:
        log(f"  count query failed status={status} body={body[:300]}")
    sql2 = "SELECT COUNT(*) AS n FROM players;"
    status, body = run_sql(sql2)
    if status == 201:
        log(f"  TOTAL: {json.loads(body)[0]['n']}")


# =============================================================================
# ROSTERS
# Format: "Name|Position" (active=true by default). Pipe-separated, one per line.
# Positions are intentionally short codes (G/F/C, QB/RB/WR, P/C/SS/OF, etc.)
# =============================================================================

from rosters import NBA, WNBA, MLB, NFL, NHL, SOCCER


def main():
    log("RawIQ player seeder starting")
    log(f"Project ref: {REF}")
    results = {}
    for sport, roster_text in [
        ("Basketball", NBA),
        ("WNBA",       WNBA),
        ("Baseball",   MLB),
        ("Football",   NFL),
        ("Hockey",     NHL),
        ("Soccer",     SOCCER),
    ]:
        try:
            inserted, errors = seed_sport(sport, roster_text)
            results[sport] = (inserted, errors)
        except Exception as e:
            log(f"!!! {sport} crashed: {e!r} — continuing to next sport")
            results[sport] = (0, -1)
    refresh_search_vectors()
    final_counts()
    log("=== SUMMARY ===")
    for sport, (ins, err) in results.items():
        log(f"  {sport:>10s}: inserted {ins}, errors {err}")
    log("Done.")

if __name__ == "__main__":
    main()
