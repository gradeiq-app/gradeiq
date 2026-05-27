"""
seed_parallels_all.py - backfill parallels for ALL orphan cards (every card_type).

Same pattern as scripts/seed_parallels.py - no card_type filter, just:
  card_number IS NOT NULL
  AND card has zero parallels
  AND card's set has a non-empty parallel_templates JSONB

Difference vs the original: per-set INSERT is chunked (CARDS_PER_CHUNK cards
at a time) so single queries stay well under the Supabase Management API
300s timeout, even for Prizm-scale sets with millions of expected rows.

Safety:
  - Idempotent: per-card NOT EXISTS guard. Re-running is a no-op.
  - Only touches the parallels table.
  - Per-set logging, per-chunk logging. Errors logged and skipped.
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

CARDS_PER_CHUNK_DEFAULT = 3000        # base size; per-set chunks adapt down
MAX_ROWS_PER_INSERT     = 30000       # cap on raw rows per chunk INSERT
                                       # (chunk_size = min(default, cap // template_size))
                                       # keeps any single INSERT under statement_timeout
MAX_RETRIES             = 4
RETRY_BACKOFF_S         = 5

# Per-chunk retry (separate from MAX_RETRIES which is for transient HTTP errors).
# Chunks that exhaust these get appended to RESUME_FILE for a follow-up pass.
MAX_CHUNK_RETRIES       = 3
RETRY_BACKOFF_SECONDS   = [10, 30, 90]
RESUME_FILE             = '_seed_parallels_resume.jsonl'

# Phantom Topps NFL sets from the 2016-2025 license-era dead zone — Topps had
# no NFL license in those years, so these sets are invalid and slated for
# deletion. Skipping them avoids wasting throughput on parallels that will be
# dropped anyway.
SKIP_SET_IDS = frozenset({
    '6a2cee66-c463-4541-98e2-f25dcd061ec1',
    '456033d4-b3fb-4a99-b63e-e37703f0e61a',
    '4324b3ee-9093-44ac-a18c-f4f584ae302d',
    'fcdcc1fa-9d53-40db-aafc-e57006b8b0cb',
    'f2b1fd63-316d-44ad-a730-c2fc74597586',
    'b539c0c2-0d26-4d43-acda-d01f65bf94ba',
    'a8d6ef48-3881-472d-8e60-c00bbcdf6004',
    '4ad7ba60-a382-486b-8ba0-53299523beed',
    '80392d0d-5e58-4db7-9d55-3ac7404a13ba',
    '9d1f43aa-042f-4d60-9a80-af17a4919abb',
    'a446dd32-6cfa-4618-b14b-7e04c1e24fd3',
    '9ed14258-216e-4db8-aa90-1c2b0e4d165b',
    '2793ac65-2b81-465c-94db-a6e12a7bedad',
    '66fb3563-fed5-4453-aaeb-709ae808d906',
    'ccbdf2d7-ce6b-4c2b-81fc-26fd29727c80',
    '9167e2a7-68cd-40bc-b52d-762af13fe901',
    '6d0cafe9-bc94-4f6d-a985-797c2fe7c524',
    'b14da4a5-688e-4451-b8e0-d3b536700e14',
    '7c534468-6a55-4e43-87f6-1ce61a7a0492',
    '274e08a2-f51a-4f75-8372-fa90ffbc6095',
    'ad6df0ab-4833-484f-84ec-30894ad3f15d',
})

def log(msg):
    # Force UTF-8 to survive Windows cp1252 stdout (checkmarks, em-dashes, etc.)
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    try:
        sys.stdout.buffer.write(line.encode("utf-8") + b"\n")
        sys.stdout.buffer.flush()
    except Exception:
        print(line.encode("ascii", "replace").decode("ascii"), flush=True)

READONLY_BACKOFF = [30, 60, 120, 300, 600]

def run_sql(sql, timeout=300):
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            r = requests.post(URL, headers=HDRS, json={"query": sql}, timeout=timeout)
            if r.status_code == 201:
                return r.status_code, r.text
            # transient: retry on 5xx or 429
            if r.status_code in (429, 500, 502, 503, 504) and attempt < MAX_RETRIES:
                log(f"     ! transient {r.status_code}, retry {attempt}/{MAX_RETRIES} in {RETRY_BACKOFF_S * attempt}s")
                time.sleep(RETRY_BACKOFF_S * attempt)
                continue
            # supabase read-only throttle: 400 + 25006 error code. wait longer.
            if r.status_code == 400 and "25006" in r.text:
                wait = READONLY_BACKOFF[min(attempt - 1, len(READONLY_BACKOFF) - 1)]
                log(f"     ! read-only throttle, sleeping {wait}s (retry {attempt}/{MAX_RETRIES})")
                time.sleep(wait)
                continue
            return r.status_code, r.text
        except Exception as e:
            if attempt < MAX_RETRIES:
                log(f"     ! exception {e!r}, retry {attempt}/{MAX_RETRIES} in {RETRY_BACKOFF_S * attempt}s")
                time.sleep(RETRY_BACKOFF_S * attempt)
                continue
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

# Chunked INSERT: pulls at most CARDS_PER_CHUNK cards from this set that still
# have no parallels, then explodes them across the set's parallel_templates.
# The NOT EXISTS guard inside the CTE makes each iteration shrink the orphan
# pool, so looping until the chunk inserts 0 rows is sufficient.
CHUNK_INSERT_SQL = """
WITH batch AS (
  SELECT c.id, c.set_id
  FROM cards c
  WHERE c.set_id = '{set_id}'::uuid
    AND c.card_number IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM parallels p WHERE p.card_id = c.id)
  LIMIT {chunk}
)
INSERT INTO parallels (card_id, label, ebay_kw, print_run)
SELECT
  b.id,
  t->>'label',
  COALESCE(t->>'ebay_kw', ''),
  CASE
    WHEN (t->>'label') ~ '/\\s*[0-9]+\\s*$'
      THEN (regexp_match(t->>'label', '/\\s*([0-9]+)\\s*$'))[1]::integer
    ELSE NULL
  END
FROM batch b
JOIN sets s ON s.id = b.set_id
CROSS JOIN LATERAL jsonb_array_elements(s.parallel_templates) t
RETURNING 1;
"""

def _adaptive_chunk_size(template_size):
    # Bound per-statement row count by MAX_ROWS_PER_INSERT. For high-template
    # sets (30+) this drops chunk_size well below the default so a single
    # INSERT stays under statement_timeout even on a loaded DB.
    if template_size and template_size > 0:
        return max(50, min(CARDS_PER_CHUNK_DEFAULT, MAX_ROWS_PER_INSERT // template_size))
    return CARDS_PER_CHUNK_DEFAULT

def record_failed_chunk(set_id, label, chunk_idx, chunk_size, status, body):
    # JSONL: one record per failed chunk. The follow-up resume pass re-runs
    # this script — the NOT EXISTS guard inside CHUNK_INSERT_SQL means failed
    # chunks' cards are still orphans and get picked up automatically. This
    # file is mainly a diagnostic log of what failed, not a worklist.
    rec = {
        'set_id':     set_id,
        'label':      label,
        'chunk_idx':  chunk_idx,
        'chunk_size': chunk_size,
        'status':     status,
        'body':       (body or '')[:300],
        'ts':         time.strftime('%Y-%m-%dT%H:%M:%S'),
    }
    try:
        with open(RESUME_FILE, 'a', encoding='utf-8') as f:
            f.write(json.dumps(rec) + '\n')
    except Exception as e:
        log(f"     !! could not record failed chunk to {RESUME_FILE}: {e!r}")

def apply_template_chunked(set_id, label, template_size):
    chunk_size = _adaptive_chunk_size(template_size)
    if chunk_size != CARDS_PER_CHUNK_DEFAULT:
        log(f"     chunk_size={chunk_size} (adapted for template_size={template_size})")
    total_inserted = 0
    chunk_idx = 0
    while True:
        chunk_idx += 1
        sql = CHUNK_INSERT_SQL.format(set_id=set_id, chunk=chunk_size)
        # Per-chunk retry with backoff. run_sql already handles transient HTTP
        # 5xx/throttle; this layer covers statement_timeout (57014) and gateway
        # timeouts (524) that bubble back as terminal failures from run_sql.
        status, body, dt = None, None, 0.0
        success = False
        for attempt in range(MAX_CHUNK_RETRIES + 1):
            t0 = time.time()
            status, body = run_sql(sql, timeout=300)
            dt = time.time() - t0
            if status == 201:
                success = True
                break
            if attempt < MAX_CHUNK_RETRIES:
                wait = RETRY_BACKOFF_SECONDS[attempt]
                log(f"     -> CHUNK {chunk_idx} attempt {attempt+1} FAILED status={status}; sleeping {wait}s")
                time.sleep(wait)
        if not success:
            log(f"     -> CHUNK {chunk_idx} EXHAUSTED retries status={status} body={(body or '')[:300]}")
            record_failed_chunk(set_id, label, chunk_idx, chunk_size, status, body)
            return total_inserted, False
        try:
            inserted = len(json.loads(body))
        except Exception:
            inserted = 0
        total_inserted += inserted
        log(f"     chunk {chunk_idx} (size {chunk_size}): +{inserted} rows in {dt:.1f}s (set cumulative {total_inserted})")
        if inserted == 0:
            break
    return total_inserted, True

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
    log("RawIQ parallel backfill (all card_types) starting")
    pre_orphans = remaining_orphans()
    pre_total   = total_parallels()
    log(f"Initial state: {pre_orphans} orphan cards, {pre_total} total parallel rows")

    sets = find_sets()
    log(f"Found {len(sets)} sets with orphan cards + template (largest-first)")
    if SKIP_SET_IDS:
        before = len(sets)
        sets = [s for s in sets if s['set_id'] not in SKIP_SET_IDS]
        skipped = before - len(sets)
        if skipped:
            log(f"Skipping {skipped} phantom set(s) per SKIP_SET_IDS")
    if not sets:
        log("Nothing to do. Done.")
        return

    grand_inserted = 0
    grand_errors   = 0
    t_run = time.time()
    for i, s in enumerate(sets, 1):
        sid       = s['set_id']
        year      = s['year']
        name      = s['set_name']
        sport     = s.get('sport', '?')
        orphans   = s['orphan_count']
        tplsize   = s['template_size']
        expected  = orphans * tplsize
        label = f"{year} {name} ({sport})"
        log(f"[{i}/{len(sets)}] {label}: {orphans} orphan cards x {tplsize} tmpl ~= {expected} parallels")
        inserted, ok = apply_template_chunked(sid, label, tplsize)
        grand_inserted += inserted
        if ok:
            log(f"     ✓ {label} — {inserted} parallels inserted (grand cumulative {grand_inserted})")
        else:
            grand_errors += 1
            log(f"     ✗ {label} — FAILED after {inserted} rows inserted")

    elapsed = time.time() - t_run
    post_orphans = remaining_orphans()
    post_total   = total_parallels()
    log("=== SUMMARY ===")
    log(f"  Elapsed:            {elapsed:.0f}s ({elapsed/60:.1f}m)")
    log(f"  Sets processed:     {len(sets)}")
    log(f"  Set-level errors:   {grand_errors}")
    log(f"  Rows inserted:      {grand_inserted}")
    log(f"  Orphan cards:       {pre_orphans} -> {post_orphans}")
    log(f"  Parallels rows:     {pre_total} -> {post_total}")
    log("Done.")

if __name__ == "__main__":
    main()
