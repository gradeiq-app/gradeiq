"""
psa_pop_scraper.py — PSA pop-report scraper for GradeIQ (Phase 1 prototype).

Scrapes PSA's pop-report JSON endpoint for a single set, matches each spec
row to a rawiq card (and parallel where applicable), and writes pop counts
to public.pop_reports keyed by grader_id=PSA, card_id, parallel_id, grade,
qualifier.

Reads SUPABASE_TOKEN from os.environ — fail-fast, no hardcoded fallback.
Default target set: 2024 Topps Chrome Football (PSA headingID 296820).

Anti-scraping: PSA sits behind Cloudflare with TLS-fingerprint filtering.
Python requests + a real Chrome UA passes; Anthropic WebFetch and PowerShell
Invoke-WebRequest do not. No JS challenge / cookie clearance needed.

Output:
  - INSERT/DELETE on public.pop_reports for matched cards (idempotent)
  - INSERT/UPSERT on public.psa_set_mappings (one row per scraped set)
  - scripts/_psa_specs_<slug>.jsonl       — (card_id, psa_spec_id) journal
                                            for the deferred 013b backfill
  - scripts/_unmatched_<slug>.jsonl       — PSA specs with no rawiq card
  - scripts/_unmatched_parallels_<slug>.jsonl
                                          — PSA parallel specs whose card
                                            matched but parallel.label did
                                            not

Phase 1 caveats:
  - cards.psa_spec_id column does NOT exist yet (013b deferred). The
    scraper journals SpecIDs to JSONL; backfill is a follow-up script.
  - pop_reports has NO foreign keys yet (013c deferred). The scraper
    trusts its matcher to produce valid card_id / parallel_id.
"""
import argparse, json, os, pathlib, re, sys, time, unicodedata
from typing import Optional
import requests

# ── env + config ─────────────────────────────────────────────────────────────
TOKEN = os.environ.get("SUPABASE_TOKEN")
if not TOKEN:
    sys.exit(
        "ERROR: SUPABASE_TOKEN env var is required.\n"
        "  Source from Supabase Dashboard > Account > Access Tokens (sbp_...).\n"
        "  Then: $env:SUPABASE_TOKEN = 'sbp_...'  (PowerShell)\n"
        "        export SUPABASE_TOKEN='sbp_...'  (bash)"
    )

REF = os.environ.get("SUPABASE_REF", "dcsrpdmhmcboydjsbgsg")
DB_URL = f"https://api.supabase.com/v1/projects/{REF}/database/query"
DB_HDRS = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 " \
     "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

SCRIPTS_DIR = pathlib.Path(__file__).resolve().parent

PSA_PAGE_SIZE = 500
PSA_REQUEST_GAP_S = 1.5       # polite cadence between PSA page requests
PSA_BACKOFF_S = [5, 15, 45, 90, 180]   # exponential backoff on 429/5xx
DB_BACKOFF_S  = [5, 15, 45, 90, 180]

# PSA's per-grade field list. Order matters for output stability.
# Format: (psa_field, grade_numeric, qualifier)
#   qualifier 'A' = Authentic (ungraded but verified real, GradeN0)
#   qualifier 'Q' = Qualified (OC/MC/MK/ST/PD — low-grade defect callout)
#   qualifier NULL = regular numeric grade
GRADE_FIELDS = [
    ("GradeN0",   0.0, "A"),
    ("Grade1Q",   1.0, "Q"),  ("Grade1",   1.0, None),
    ("Grade1_5Q", 1.5, "Q"),  ("Grade1_5", 1.5, None),
    ("Grade2Q",   2.0, "Q"),  ("Grade2",   2.0, None),
                              ("Grade2_5", 2.5, None),
    ("Grade3Q",   3.0, "Q"),  ("Grade3",   3.0, None),
                              ("Grade3_5", 3.5, None),
    ("Grade4Q",   4.0, "Q"),  ("Grade4",   4.0, None),
                              ("Grade4_5", 4.5, None),
    ("Grade5Q",   5.0, "Q"),  ("Grade5",   5.0, None),
                              ("Grade5_5", 5.5, None),
    ("Grade6Q",   6.0, "Q"),  ("Grade6",   6.0, None),
                              ("Grade6_5", 6.5, None),
    ("Grade7Q",   7.0, "Q"),  ("Grade7",   7.0, None),
                              ("Grade7_5", 7.5, None),
    ("Grade8Q",   8.0, "Q"),  ("Grade8",   8.0, None),
                              ("Grade8_5", 8.5, None),
    ("Grade9Q",   9.0, "Q"),  ("Grade9",   9.0, None),
                              ("Grade10", 10.0, None),
]

# ── logging ─────────────────────────────────────────────────────────────────
def log(msg: str) -> None:
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    try:
        sys.stdout.buffer.write(line.encode("utf-8") + b"\n")
        sys.stdout.buffer.flush()
    except Exception:
        print(line.encode("ascii", "replace").decode("ascii"), flush=True)

# ── normalization ───────────────────────────────────────────────────────────
SUFFIX_RE = re.compile(r"\b(jr|sr|ii|iii|iv|v)\b\.?", re.IGNORECASE)

def norm_name(s: Optional[str]) -> str:
    """Normalize a player name for cross-source matching.

    Pipeline:
      1. Unicode → ASCII (drops accents)
      2. Remove punctuation (apostrophes, periods, hyphens)
      3. Strip suffix tokens (Jr / Sr / II / III / IV / V)
      4. Collapse whitespace
      5. Lowercase

    Examples:
      'Marvin Harrison Jr.'  → 'marvin harrison'
      "Ja'Marr Chase"        → 'jamarr chase'
      'Kenneth Walker III'   → 'kenneth walker'
      'Jaxon Smith-Njigba'   → 'jaxon smith njigba'
      'Tom Brady'            → 'tom brady'
      'Barry Sanders'        → 'barry sanders'

    TODO Phase 2: preserve Jr/Sr/II/III/IV/V as a disambiguation token
    rather than dropping. Current behavior is safe for one-set-at-a-time
    matching (rawiq rarely has both father + son in the same set) but
    produces silent false matches across generations — e.g. Marvin
    Harrison Sr. vs Jr., Ken Griffey Sr. vs Jr. Future work: emit a
    structured token like 'sfx:jr' instead of stripping outright.
    """
    if not s:
        return ""
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode("ascii")
    s = s.replace("'", "").replace(".", "")
    s = SUFFIX_RE.sub(" ", s)
    s = re.sub(r"[^a-zA-Z0-9]+", " ", s)
    s = re.sub(r"\s+", " ", s).strip().lower()
    return s

PRINT_RUN_RE = re.compile(r"#?\s*/\s*(\d+)")

def norm_variety(s: Optional[str]) -> str:
    """Normalize a parallel label/variety for cross-source matching.

    Pipeline:
      1. Strip '#/N' and '/N' print-run suffixes
      2. Drop 'numbered to N' phrasing
      3. Collapse non-alphanumeric → space
      4. Lowercase + trim

    Examples:
      'Gold Refractor'           → 'gold refractor'
      'Pink Refractor #/199'     → 'pink refractor'
      'Gold /50'                 → 'gold'
      'Gold Refractor /50'       → 'gold refractor'
      'Refractor numbered to 99' → 'refractor'
    """
    if not s:
        return ""
    s = PRINT_RUN_RE.sub("", s)
    s = re.sub(r"\bnumbered to \d+\b", "", s, flags=re.IGNORECASE)
    s = re.sub(r"[^a-zA-Z0-9]+", " ", s)
    s = re.sub(r"\s+", " ", s).strip().lower()
    return s

def parse_print_run(s: Optional[str]) -> Optional[int]:
    """Extract '/N' or '#/N' suffix as int. Returns None if absent."""
    if not s:
        return None
    m = PRINT_RUN_RE.search(s)
    return int(m.group(1)) if m else None

# ── DB layer ────────────────────────────────────────────────────────────────
def run_sql(sql: str, timeout: int = 120) -> tuple[int, str]:
    """POST a SQL query to Supabase Management API. Retries 5xx / 429."""
    for attempt, wait in enumerate([0] + DB_BACKOFF_S, 1):
        if wait:
            time.sleep(wait)
        try:
            r = requests.post(DB_URL, headers=DB_HDRS, json={"query": sql}, timeout=timeout)
        except Exception as e:
            log(f"     ! db exception {e!r} (attempt {attempt})")
            continue
        if r.status_code in (200, 201):
            return r.status_code, r.text
        # 524/522/544 are Cloudflare-specific "origin timeout" errors that
        # show up when Supabase's API gateway is overloaded (e.g. by PID
        # 24540's parallel backfill traffic) — treat as transient.
        if r.status_code in (429, 500, 502, 503, 504, 522, 524, 544) and attempt <= len(DB_BACKOFF_S):
            log(f"     ! db transient {r.status_code} (attempt {attempt}), will retry")
            continue
        return r.status_code, r.text
    return 0, "exhausted retries"

def q(sql: str) -> list[dict]:
    status, body = run_sql(sql)
    if status not in (200, 201):
        log(f"SQL failed status={status} body={body[:400]}")
        sys.exit(1)
    return json.loads(body)

def sql_literal(v) -> str:
    """Quote a Python value for embedding in SQL. Handles None, str, int, float."""
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "TRUE" if v else "FALSE"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("'", "''") + "'"

# ── PSA fetch ───────────────────────────────────────────────────────────────
def fetch_psa_set(heading_id: int, category_id: int) -> list[dict]:
    """Paginate PSA's /Pop/GetSetItems for a single set heading.

    Polite cadence: PSA_REQUEST_GAP_S between page requests, exponential
    backoff on transient 4xx/5xx. Returns all spec rows excluding the
    synthetic TOTAL POPULATION row (SpecID=0).
    """
    referer = f"https://www.psacard.com/pop/football-cards/2024/topps-chrome/{heading_id}"
    headers = {"User-Agent": UA, "X-Requested-With": "XMLHttpRequest", "Referer": referer}

    all_rows: list[dict] = []
    start = 0
    page_num = 0
    records_total = None
    while True:
        page_num += 1
        page_rows, status = _fetch_psa_page(heading_id, category_id, start, headers)
        if page_rows is None:
            log(f"  ! PSA page {page_num} (start={start}) failed permanently status={status}")
            sys.exit(1)

        if not page_rows.get("data"):
            log(f"  PSA page {page_num} (start={start}): empty data, stopping")
            break

        raw = page_rows["data"]
        records_total = page_rows.get("recordsTotal", records_total)
        # First page contains a TOTAL POPULATION aggregate row with SpecID=0
        specs = [row for row in raw if row.get("SpecID", 0) != 0]
        all_rows.extend(specs)
        log(f"  PSA page {page_num}: start={start:>4} raw={len(raw):>3} specs={len(specs):>3} "
            f"cumulative={len(all_rows):>4} (recordsTotal={records_total})")

        if len(raw) < PSA_PAGE_SIZE:
            break
        start += PSA_PAGE_SIZE
        time.sleep(PSA_REQUEST_GAP_S)

    log(f"  PSA fetch complete: walked {page_num} page(s), got {len(all_rows)} specs "
        f"(recordsTotal={records_total})")
    # recordsTotal counts only real specs (the TOTAL POPULATION row is added
    # on top of the count, not included in it). So we expect len(all_rows)
    # == records_total exactly after filtering.
    if records_total is not None and len(all_rows) != records_total:
        diff = records_total - len(all_rows)
        log(f"  WARN: pagination shortfall {diff} (expected={records_total}, got={len(all_rows)})")
    return all_rows

def _fetch_psa_page(heading_id, category_id, start, headers) -> tuple[Optional[dict], int]:
    data = {
        "draw": 1, "start": start, "length": PSA_PAGE_SIZE, "search": "",
        "headingID": heading_id, "categoryID": category_id, "isPSADNA": "false",
    }
    for attempt, wait in enumerate([0] + PSA_BACKOFF_S, 1):
        if wait:
            time.sleep(wait)
        try:
            r = requests.post("https://www.psacard.com/Pop/GetSetItems",
                              headers=headers, data=data, timeout=30)
        except Exception as e:
            log(f"     ! PSA exception {e!r} (attempt {attempt})")
            continue
        if r.status_code == 200:
            try:
                return r.json(), 200
            except Exception:
                log(f"     ! PSA non-JSON 200 body[:200]={r.text[:200]!r}")
                continue
        if r.status_code in (429, 500, 502, 503, 504) and attempt <= len(PSA_BACKOFF_S):
            log(f"     ! PSA transient {r.status_code} (attempt {attempt}/{len(PSA_BACKOFF_S)+1}), will back off")
            continue
        return None, r.status_code
    return None, 0

# ── set + rawiq lookup ──────────────────────────────────────────────────────
def resolve_set_id(args) -> tuple[str, str]:
    """Resolve the rawiq sets.id (UUID) and a display name."""
    if args.set_id:
        rows = q(f"""
SELECT s.id::text, s.name, s.year, m.slug AS mfg, sp.slug AS sport
FROM sets s
JOIN manufacturers m ON m.id = s.manufacturer_id
JOIN sports sp ON sp.id = s.sport_id
WHERE s.id = '{args.set_id}';
""")
        if not rows:
            sys.exit(f"set_id={args.set_id} not found in rawiq sets")
        r = rows[0]
        return r["id"], f"{r['year']} {r['mfg']} {r['name']} ({r['sport']})"

    rows = q(f"""
SELECT s.id::text, s.name, s.year, m.slug AS mfg, sp.slug AS sport,
       (SELECT COUNT(*) FROM cards c WHERE c.set_id = s.id) AS card_count
FROM sets s
JOIN manufacturers m ON m.id = s.manufacturer_id
JOIN sports sp ON sp.id = s.sport_id
WHERE s.year = {args.year}
  AND m.slug = '{args.manufacturer}'
  AND sp.slug = '{args.sport}'
  AND s.name ILIKE '%{args.set_name}%'
ORDER BY s.name;
""")
    if not rows:
        sys.exit(f"no rawiq sets matched year={args.year} mfg={args.manufacturer} "
                 f"sport={args.sport} name~={args.set_name!r}")
    if len(rows) > 1:
        log(f"  multiple set matches:")
        for r in rows:
            log(f"    {r['id']}  {r['year']} {r['mfg']} {r['name']!r}  cards={r['card_count']}")
        # pick the one with the most cards (most likely the right one)
        rows.sort(key=lambda x: -x["card_count"])
    r = rows[0]
    return r["id"], f"{r['year']} {r['mfg']} {r['name']} ({r['sport']})"

def load_rawiq(set_id: str) -> tuple[dict[str, dict], dict[tuple[str, str], dict]]:
    """Build two indexes for matching:
      cards_idx[norm_name] = {card_id, raw_name, raw_card_number}
      parallels_idx[(card_id, norm_variety)] = {parallel_id, label, print_run}

    Within one set, player names are unique, so cards_idx has a single
    entry per name. If a duplicate is detected, the second entry overwrites
    the first and we log a warning (shouldn't happen in clean data).
    """
    log(f"  loading rawiq cards + parallels for set_id={set_id}")
    cards_rows = q(f"""
SELECT c.id::text AS card_id, c.card_number, c.name AS card_name,
       p.name AS player_name
FROM cards c
LEFT JOIN players p ON p.id = c.player_id
WHERE c.set_id = '{set_id}';
""")
    cards_idx: dict[str, dict] = {}
    for r in cards_rows:
        # Prefer player name; fall back to card name (card.name often equals the player)
        display = r["player_name"] or r["card_name"] or ""
        nm = norm_name(display)
        if not nm:
            continue
        if nm in cards_idx:
            log(f"    WARN: duplicate normalized name {nm!r} in set; previous="
                f"{cards_idx[nm]['card_id']} new={r['card_id']}")
        cards_idx[nm] = {
            "card_id": r["card_id"],
            "raw_name": display,
            "raw_card_number": r["card_number"],
        }

    par_rows = q(f"""
SELECT p.id::text AS parallel_id, p.card_id::text AS card_id,
       p.label, p.print_run
FROM parallels p
JOIN cards c ON c.id = p.card_id
WHERE c.set_id = '{set_id}';
""")
    parallels_idx: dict[tuple[str, str], dict] = {}
    for r in par_rows:
        nv = norm_variety(r["label"])
        if not nv:
            continue
        key = (r["card_id"], nv)
        if key in parallels_idx:
            log(f"    WARN: duplicate normalized parallel {key!r}; "
                f"previous={parallels_idx[key]['parallel_id']} new={r['parallel_id']}")
        parallels_idx[key] = {
            "parallel_id": r["parallel_id"],
            "label": r["label"],
            "print_run": r["print_run"],
        }

    log(f"  rawiq: {len(cards_idx)} unique normalized card names, "
        f"{len(parallels_idx)} unique (card, parallel) pairs")
    return cards_idx, parallels_idx

# ── matcher ─────────────────────────────────────────────────────────────────
def match_psa_rows(
    psa_rows: list[dict],
    cards_idx: dict[str, dict],
    parallels_idx: dict[tuple[str, str], dict],
) -> tuple[list[dict], list[dict], list[dict]]:
    """Match each PSA spec row to (card_id, parallel_id_or_None).

    Match logic — name + variety as a pure normalized exact lookup:
      1. Normalize SubjectName. If no rawiq entry for that key, row is
         unmatched (no rawiq card).
      2. If Variety is null/empty, this is a BASE row → parallel_id=None.
      3. If Variety is set, normalize and look up parallels_idx[(card_id,
         norm_variety)]. If not present → unmatched_parallel.
      4. If the rawiq parallel has a non-null print_run AND PSA's Variety
         carries a '/N' suffix that disagrees, treat as unmatched_parallel
         (logged with both values).

    Returns:
      matches:               [{card_id, parallel_id, psa_row}, ...]
      unmatched_cards:       [psa_row, ...] (no name match in rawiq)
      unmatched_parallels:   [{matched_card_id, reason, psa_row}, ...]
                             (name matched, variety did not)

    Threshold logic note: this build uses exact normalized-key match only
    (no trigram fallback). The contamination diagnostic showed only 15
    name overlaps between rawiq and PSA, and all 15 are exact normalized
    matches — trigram would only widen the false-positive surface. Add a
    trigram fallback in a later phase if/when a cleaner set is targeted.
    """
    matches: list[dict] = []
    unmatched_cards: list[dict] = []
    unmatched_parallels: list[dict] = []

    for row in psa_rows:
        nm = norm_name(row.get("SubjectName"))
        if not nm or nm not in cards_idx:
            unmatched_cards.append(row)
            continue
        card_id = cards_idx[nm]["card_id"]

        variety = row.get("Variety")
        if not variety:
            # Base row
            matches.append({"card_id": card_id, "parallel_id": None, "psa_row": row})
            continue

        nv = norm_variety(variety)
        if not nv:
            unmatched_parallels.append({
                "matched_card_id": card_id,
                "reason": "empty-normalized-variety",
                "psa_row": row,
            })
            continue

        par = parallels_idx.get((card_id, nv))
        if not par:
            unmatched_parallels.append({
                "matched_card_id": card_id,
                "reason": "no-parallel-match",
                "psa_row": row,
            })
            continue

        psa_pr = parse_print_run(variety)
        if par["print_run"] is not None and psa_pr is not None and par["print_run"] != psa_pr:
            unmatched_parallels.append({
                "matched_card_id": card_id,
                "reason": f"print-run-mismatch (rawiq={par['print_run']} psa={psa_pr})",
                "psa_row": row,
            })
            continue

        matches.append({
            "card_id": card_id,
            "parallel_id": par["parallel_id"],
            "psa_row": row,
        })

    return matches, unmatched_cards, unmatched_parallels

# ── pop_reports build + upsert ──────────────────────────────────────────────
def build_pop_rows(matches: list[dict], grader_id: str, source: str, source_url_tmpl: str):
    """Expand each (card, parallel, psa_row) match into one pop_reports row
    per non-zero grade count. Returns a list of dicts ready for INSERT.
    """
    rows = []
    for m in matches:
        psa = m["psa_row"]
        spec_id = psa.get("SpecID")
        source_url = source_url_tmpl.format(spec_id=spec_id) if spec_id else None
        for field, grade, qualifier in GRADE_FIELDS:
            count = psa.get(field) or 0
            if count <= 0:
                continue
            rows.append({
                "card_id": m["card_id"],
                "grader_id": grader_id,
                "parallel_id": m["parallel_id"],
                "grade": grade,
                "qualifier": qualifier,
                "count": int(count),
                "source": source,
                "source_url": source_url,
            })
    return rows

def upsert_pop_reports(rows: list[dict], matched_card_ids: list[str], grader_id: str, dry_run: bool):
    """Idempotent replace: DELETE existing pop_reports for (grader_id,
    matched_card_ids) then bulk INSERT. Wrapped in a single transaction
    via Supabase's multi-statement query body.

    NULL parallel_id sidesteps PostgreSQL's NULLS-DISTINCT unique-constraint
    behavior by doing replace-not-merge.
    """
    if not rows:
        log("  no pop_reports rows to insert (no matches yielded grades > 0)")
        return
    if dry_run:
        log(f"  [DRY RUN] would DELETE+INSERT {len(rows)} pop_reports rows "
            f"for {len(matched_card_ids)} cards")
        return

    # Chunk inserts to keep each statement under Supabase's 300s limit and
    # the query body under reasonable size. ~1500 rows ≈ 250KB.
    INSERT_CHUNK = 1500
    card_id_array = "ARRAY[" + ",".join(sql_literal(cid) + "::uuid" for cid in matched_card_ids) + "]"

    # Phase 1: delete in its own transaction so the inserts can chunk
    delete_sql = f"""
BEGIN;
SET LOCAL lock_timeout = '8s';
DELETE FROM pop_reports
WHERE grader_id = {sql_literal(grader_id)}::uuid
  AND card_id = ANY({card_id_array});
COMMIT;
"""
    log(f"  DELETE pop_reports for {len(matched_card_ids)} cards (grader=PSA)")
    status, body = run_sql(delete_sql)
    if status not in (200, 201):
        log(f"  DELETE failed status={status} body={body[:400]}")
        sys.exit(1)

    inserted = 0
    for i in range(0, len(rows), INSERT_CHUNK):
        chunk = rows[i:i + INSERT_CHUNK]
        values = ",\n".join(
            "(" + ", ".join([
                sql_literal(r["card_id"]) + "::uuid",
                sql_literal(r["grader_id"]) + "::uuid",
                (sql_literal(r["parallel_id"]) + "::uuid") if r["parallel_id"] else "NULL",
                sql_literal(r["grade"]),
                sql_literal(r["qualifier"]),
                sql_literal(r["count"]),
                sql_literal(r["source"]),
                sql_literal(r["source_url"]),
            ]) + ")"
            for r in chunk
        )
        sql = f"""
INSERT INTO pop_reports (card_id, grader_id, parallel_id, grade, qualifier, count, source, source_url)
VALUES
{values}
RETURNING 1;
"""
        status, body = run_sql(sql)
        if status not in (200, 201):
            log(f"  INSERT chunk failed status={status} body={body[:400]}")
            sys.exit(1)
        try:
            inserted += len(json.loads(body))
        except Exception:
            inserted += len(chunk)
        log(f"  INSERT chunk {i // INSERT_CHUNK + 1}: +{len(chunk)} rows (cumulative {inserted})")

# ── psa_set_mappings + journal + jsonl writes ───────────────────────────────
def upsert_set_mapping(rawiq_set_id, grader_id, external_set_id, external_set_url, confidence, dry_run):
    if dry_run:
        log(f"  [DRY RUN] would upsert psa_set_mappings: rawiq={rawiq_set_id} "
            f"external={external_set_id}")
        return
    sql = f"""
INSERT INTO psa_set_mappings (rawiq_set_id, grader_id, external_set_id, external_set_url, match_confidence)
VALUES ({sql_literal(rawiq_set_id)}::uuid, {sql_literal(grader_id)}::uuid,
        {sql_literal(external_set_id)}, {sql_literal(external_set_url)},
        {sql_literal(confidence)})
ON CONFLICT (rawiq_set_id, grader_id) DO UPDATE
  SET external_set_id = EXCLUDED.external_set_id,
      external_set_url = EXCLUDED.external_set_url,
      match_confidence = EXCLUDED.match_confidence
RETURNING id;
"""
    status, body = run_sql(sql)
    if status not in (200, 201):
        log(f"  psa_set_mappings upsert failed status={status} body={body[:400]}")
        sys.exit(1)
    log(f"  psa_set_mappings upserted: {body}")

def write_jsonl(path: pathlib.Path, items: list[dict]) -> None:
    with open(path, "w", encoding="utf-8") as f:
        for it in items:
            f.write(json.dumps(it, ensure_ascii=False) + "\n")
    log(f"  wrote {len(items)} lines → {path.name}")

# ── main ────────────────────────────────────────────────────────────────────
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--set-id", help="rawiq sets.id (UUID); overrides name lookup")
    ap.add_argument("--year", type=int, default=2024)
    ap.add_argument("--manufacturer", default="topps")
    ap.add_argument("--sport", default="football")
    ap.add_argument("--set-name", default="chrome",
                    help="rawiq set name fragment; ILIKE '%FRAG%'")
    ap.add_argument("--psa-heading-id", type=int, default=296820,
                    help="PSA pop URL heading ID; default 296820 = 2024 Topps Chrome Football")
    ap.add_argument("--psa-category-id", type=int, default=20014,
                    help="PSA category ID; default 20014 = football-cards")
    ap.add_argument("--slug", default="2024_topps_chrome_fb",
                    help="filename slug for journal + unmatched files")
    ap.add_argument("--dry-run", action="store_true", help="skip DB writes")
    args = ap.parse_args()

    t_total = time.time()

    log("=== Phase 1C: PSA pop scraper ===")
    log(f"  args: year={args.year} mfg={args.manufacturer} sport={args.sport} "
        f"name~={args.set_name!r} heading={args.psa_heading_id} dry_run={args.dry_run}")

    log("--- Step 1: resolve rawiq set + grader ---")
    rawiq_set_id, set_display = resolve_set_id(args)
    log(f"  rawiq_set_id = {rawiq_set_id}  ({set_display})")
    grader_row = q("SELECT id::text FROM graders WHERE slug = 'psa';")
    if not grader_row:
        sys.exit("grader 'psa' not found — was 013a applied?")
    psa_grader_id = grader_row[0]["id"]
    log(f"  psa_grader_id = {psa_grader_id}")

    log("--- Step 2: load rawiq cards + parallels ---")
    cards_idx, parallels_idx = load_rawiq(rawiq_set_id)

    log("--- Step 3: fetch PSA pop ---")
    psa_rows = fetch_psa_set(args.psa_heading_id, args.psa_category_id)

    log("--- Step 4: match PSA → rawiq ---")
    matches, unmatched_cards, unmatched_parallels = match_psa_rows(
        psa_rows, cards_idx, parallels_idx
    )
    base_matches = [m for m in matches if m["parallel_id"] is None]
    par_matches  = [m for m in matches if m["parallel_id"] is not None]
    base_unmatched = [r for r in unmatched_cards if not r.get("Variety")]
    par_unmatched_no_card = [r for r in unmatched_cards if r.get("Variety")]
    log(f"  PSA specs total:           {len(psa_rows)}")
    log(f"  matched (base):            {len(base_matches)}")
    log(f"  matched (parallel):        {len(par_matches)}")
    log(f"  unmatched (base, no card): {len(base_unmatched)}")
    log(f"  unmatched (par, no card):  {len(par_unmatched_no_card)}")
    log(f"  unmatched (par, no par):   {len(unmatched_parallels)}")

    log("--- Step 5: build pop_reports rows ---")
    source_url_tmpl = "https://www.psacard.com/cert/{spec_id}"
    pop_rows = build_pop_rows(matches, psa_grader_id, source="psa-pop-scrape",
                              source_url_tmpl=source_url_tmpl)
    matched_card_ids = sorted({m["card_id"] for m in matches})
    log(f"  pop_reports rows to insert: {len(pop_rows)} "
        f"(covering {len(matched_card_ids)} distinct cards)")

    log("--- Step 6: upsert pop_reports ---")
    upsert_pop_reports(pop_rows, matched_card_ids, psa_grader_id, args.dry_run)

    log("--- Step 7: upsert psa_set_mappings ---")
    external_url = f"https://www.psacard.com/pop/football-cards/{args.year}/topps-chrome/{args.psa_heading_id}"
    upsert_set_mapping(rawiq_set_id, psa_grader_id, str(args.psa_heading_id),
                       external_url, "high", args.dry_run)

    log("--- Step 8: write journal + unmatched files ---")
    journal_path  = SCRIPTS_DIR / f"_psa_specs_{args.slug}.jsonl"
    unmatched_path = SCRIPTS_DIR / f"_unmatched_{args.slug}.jsonl"
    unmatched_par_path = SCRIPTS_DIR / f"_unmatched_parallels_{args.slug}.jsonl"

    journal = [
        {"card_id": m["card_id"], "psa_spec_id": str(m["psa_row"].get("SpecID")),
         "parallel_id": m["parallel_id"],
         "subject_name": m["psa_row"].get("SubjectName"),
         "card_number": m["psa_row"].get("CardNumber"),
         "variety": m["psa_row"].get("Variety")}
        for m in matches
    ]
    write_jsonl(journal_path, journal)

    unmatched_payload = [
        {"psa_spec_id": str(r.get("SpecID")),
         "psa_player_name": r.get("SubjectName"),
         "psa_card_number": r.get("CardNumber"),
         "psa_variety": r.get("Variety"),
         "psa_set_name": set_display,
         "reason": "no-rawiq-card"}
        for r in unmatched_cards
    ]
    write_jsonl(unmatched_path, unmatched_payload)

    unmatched_par_payload = [
        {"psa_spec_id": str(u["psa_row"].get("SpecID")),
         "psa_player_name": u["psa_row"].get("SubjectName"),
         "psa_card_number": u["psa_row"].get("CardNumber"),
         "psa_variety": u["psa_row"].get("Variety"),
         "psa_set_name": set_display,
         "matched_card_id": u["matched_card_id"],
         "reason": u["reason"]}
        for u in unmatched_parallels
    ]
    write_jsonl(unmatched_par_path, unmatched_par_payload)

    elapsed = time.time() - t_total
    log("=== SUMMARY ===")
    log(f"  set:                    {set_display}")
    log(f"  rawiq_set_id:           {rawiq_set_id}")
    log(f"  PSA specs fetched:      {len(psa_rows)}")
    log(f"  matched (base/par):     {len(base_matches)}/{len(par_matches)}")
    log(f"  unmatched (no card):    {len(unmatched_cards)}")
    log(f"  unmatched (no parallel):{len(unmatched_parallels)}")
    log(f"  pop_reports rows:       {len(pop_rows)} ({'dry-run, not inserted' if args.dry_run else 'inserted'})")
    log(f"  journal lines:          {len(journal)}")
    log(f"  elapsed:                {elapsed:.1f}s ({elapsed/60:.2f}m)")

if __name__ == "__main__":
    main()
