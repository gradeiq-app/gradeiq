"""
seed_parallels.py — backfill parallels for orphan cards.

Targets: cards where (card_number IS NOT NULL) AND (card has zero parallels) AND
         (the card's set has a non-empty parallel_templates JSONB).

For each such card, inserts one parallel row per element in the parent set's
parallel_templates. print_run extracted from labels like 'Blue Prizm /149' via regex.

Safety:
  - Idempotent: per-card NOT EXISTS guard. Re-running is a no-op.
  - Only touches the parallels table. cards/sets unchanged.
  - Per-set processing with progress logging. Errors are logged and skipped.
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
REF   = os.environ.get("SUPABASE_REF", "dcsrpdmhmcboydjsbgsg")
URL   = f"https://api.supabase.com/v1/projects/{REF}/database/query"
HDRS  = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)

def run_sql(sql, timeout=300):
    try:
        r = requests.post(URL, headers=HDRS, json={"query": sql}, timeout=timeout)
        return r.status_code, r.text
    except Exception as e:
        return 0, repr(e)

FIND_SETS_SQL = """
SELECT
  s.id::text AS set_id,
  s.year,
  s.name AS set_name,
  COALESCE(sp.name, '?') AS sport,
  COUNT(DISTINCT c.id) AS orphan_count,
  jsonb_array_length(s.parallel_templates) AS template_size
FROM sets s
JOIN cards c ON c.set_id = s.id
LEFT JOIN sports sp ON sp.id = s.sport_id
WHERE c.card_number IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM parallels p WHERE p.card_id = c.id)
  AND s.parallel_templates IS NOT NULL
  AND jsonb_array_length(s.parallel_templates) > 0
GROUP BY s.id, s.year, s.name, sp.name, s.parallel_templates
ORDER BY COUNT(DISTINCT c.id) DESC;
"""

def find_sets():
    status, body = run_sql(FIND_SETS_SQL)
    if status != 201:
        log(f"find_sets FAILED status={status} body={body[:300]}")
        return []
    return json.loads(body)

def apply_template(set_id, set_label):
    sql = f"""
INSERT INTO parallels (card_id, label, ebay_kw, print_run)
SELECT
  c.id,
  t->>'label',
  COALESCE(t->>'ebay_kw', ''),
  CASE
    WHEN (t->>'label') ~ '/\\s*[0-9]+\\s*$'
      THEN (regexp_match(t->>'label', '/\\s*([0-9]+)\\s*$'))[1]::integer
    ELSE NULL
  END
FROM cards c
JOIN sets s ON s.id = c.set_id
CROSS JOIN LATERAL jsonb_array_elements(s.parallel_templates) t
WHERE s.id = '{set_id}'::uuid
  AND c.card_number IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM parallels p WHERE p.card_id = c.id
  )
RETURNING 1;
"""
    return run_sql(sql, timeout=300)

def remaining_orphans():
    sql = """
SELECT COUNT(*) AS n FROM cards c
WHERE c.card_number IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM parallels p WHERE p.card_id = c.id);
"""
    status, body = run_sql(sql)
    if status == 201:
        return json.loads(body)[0]['n']
    return None

def total_parallels():
    sql = "SELECT COUNT(*) AS n FROM parallels;"
    status, body = run_sql(sql)
    if status == 201:
        return json.loads(body)[0]['n']
    return None

def main():
    log("RawIQ parallel backfill starting")
    pre_orphans = remaining_orphans()
    pre_total   = total_parallels()
    log(f"Initial state: {pre_orphans} orphan cards, {pre_total} total parallel rows")

    sets = find_sets()
    log(f"Found {len(sets)} sets with orphan cards + template")
    if not sets:
        log("Nothing to do. Done.")
        return

    grand_inserted = 0
    grand_errors   = 0
    for i, s in enumerate(sets, 1):
        sid       = s['set_id']
        year      = s['year']
        name      = s['set_name']
        sport     = s.get('sport', '?')
        orphans   = s['orphan_count']
        tplsize   = s['template_size']
        expected  = orphans * tplsize
        label = f"{year} {name} ({sport})"
        log(f"[{i}/{len(sets)}] {label}: {orphans} cards x {tplsize} tmpl ~= {expected} parallels")
        status, body = apply_template(sid, label)
        if status == 201:
            try:
                inserted = len(json.loads(body))
            except Exception:
                inserted = -1
            grand_inserted += inserted if inserted >= 0 else 0
            log(f"     -> inserted {inserted} (cumulative {grand_inserted})")
        else:
            grand_errors += 1
            log(f"     -> FAILED status={status} body={body[:300]}")

    post_orphans = remaining_orphans()
    post_total   = total_parallels()
    log("=== SUMMARY ===")
    log(f"  Sets processed:     {len(sets)}")
    log(f"  Errors (non-fatal): {grand_errors}")
    log(f"  Reported inserted:  {grand_inserted}")
    log(f"  Orphan cards: {pre_orphans} -> {post_orphans}")
    log(f"  Parallels:    {pre_total} -> {post_total} (delta {post_total - pre_total if post_total is not None and pre_total is not None else '?'})")
    log("Done.")

if __name__ == "__main__":
    main()
