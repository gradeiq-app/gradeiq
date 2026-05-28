"""Backfill cards.psa_spec_id (013b) and parallels.psa_spec_id (013d)
from the Phase 1 PSA scraper journal.

Journal: scripts/_psa_specs_2024_topps_chrome_fb.jsonl (107 entries)
  - 14 entries with parallel_id IS NULL → cards.psa_spec_id
  - 93 entries with parallel_id populated → parallels.psa_spec_id

Two transactions (one per target table), each with lock_timeout='4s'.
Explicit id pairs from the journal — no name-based matching anywhere.

PREFLIGHT (read-only):
  - Reports current populated counts on cards/parallels (informational).
  - Collision guard: for any of the 107 target ids that ALREADY hold a
    non-null psa_spec_id, the existing value must equal the journal's
    value. Same-value-already-present is fine (idempotent re-run after
    full success). Different-value → STOP — that means another writer
    touched the column, or the journal changed.
  - No blanket "must be empty" gate; the script is resume-safe so a
    partial TX1-success / TX2-fail can be retried by re-running.

VERIFY (post-apply): every journal entry's target id holds its
psa_spec_id; mismatches = 0.
"""
import json, os, pathlib, requests, sys, time

ROOT = pathlib.Path(__file__).resolve().parent.parent
for line in (ROOT / ".env.local").read_text(encoding="utf-8").splitlines():
    s = line.strip()
    if not s or s.startswith("#") or "=" not in s: continue
    k, v = s.split("=", 1); os.environ.setdefault(k.strip(), v.strip())
TOKEN = os.environ["SUPABASE_TOKEN"]
URL = f"https://api.supabase.com/v1/projects/{os.environ.get('SUPABASE_REF','dcsrpdmhmcboydjsbgsg')}/database/query"
H = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}


def run(label, sql, timeout=60):
    t0 = time.time()
    r = requests.post(URL, headers=H, json={"query": sql}, timeout=timeout)
    el = time.time() - t0
    print(f"[{label}] status={r.status_code}  elapsed={el:.2f}s", flush=True)
    if r.status_code not in (200, 201):
        print(f"  body={r.text[:1200]!r}", flush=True)
        sys.exit(f"{label} failed")
    try: return r.json()
    except: return None


# ─── Load journal ───
journal_path = ROOT / "scripts" / "_psa_specs_2024_topps_chrome_fb.jsonl"
entries = [json.loads(l) for l in journal_path.read_text(encoding="utf-8").splitlines() if l.strip()]
assert len(entries) == 107, f"expected 107, got {len(entries)}"

base_entries = [e for e in entries if not e.get("parallel_id")]
par_entries  = [e for e in entries if e.get("parallel_id")]
assert len(base_entries) == 14, f"expected 14 base, got {len(base_entries)}"
assert len(par_entries)  == 93, f"expected 93 parallel, got {len(par_entries)}"
assert len(base_entries) + len(par_entries) == 107

print(f"Journal: {len(entries)} entries  =  {len(base_entries)} base  +  {len(par_entries)} parallel")


# ─── Preflight (informational): current populated counts ───
pre = run("PREFLIGHT-populated-counts", """
SELECT
  (SELECT COUNT(*) FROM cards     WHERE psa_spec_id IS NOT NULL) AS cards_populated,
  (SELECT COUNT(*) FROM parallels WHERE psa_spec_id IS NOT NULL) AS parallels_populated;
""")
print(f"  starting populated counts (informational): {pre[0]}")

# ─── Collision guard: any target id already holding a DIFFERENT spec_id ───
# Same-value-present is fine (idempotent re-run). Different-value is the
# real risk; STOP if any target id holds a non-NULL value that doesn't
# match the journal's value for that id.
journal_cards = {e["card_id"]: e["psa_spec_id"] for e in base_entries}
journal_pars  = {e["parallel_id"]: e["psa_spec_id"] for e in par_entries}

cids = ",".join(f"'{i}'::uuid" for i in journal_cards)
pids = ",".join(f"'{i}'::uuid" for i in journal_pars)

existing_cards = run("PREFLIGHT-cards-existing", f"""
SELECT id, psa_spec_id FROM cards
WHERE id IN ({cids}) AND psa_spec_id IS NOT NULL;
""")
existing_pars  = run("PREFLIGHT-parallels-existing", f"""
SELECT id, psa_spec_id FROM parallels
WHERE id IN ({pids}) AND psa_spec_id IS NOT NULL;
""")

collisions = []
for r in existing_cards:
    expected = journal_cards.get(r["id"])
    if r["psa_spec_id"] != expected:
        collisions.append({"table": "cards", "id": r["id"], "existing": r["psa_spec_id"], "journal": expected})
for r in existing_pars:
    expected = journal_pars.get(r["id"])
    if r["psa_spec_id"] != expected:
        collisions.append({"table": "parallels", "id": r["id"], "existing": r["psa_spec_id"], "journal": expected})

print(f"  collision-guard: {len(existing_cards)} cards / {len(existing_pars)} parallels target ids already populated")
print(f"  collision-guard: {len(collisions)} differing-value collisions (STOP if > 0)")
if collisions:
    for c in collisions[:10]: print(f"    {c}")
    sys.exit("STOP: collision guard hit — target ids already hold values that differ from the journal.")


# ─── Backfill 1/2: cards.psa_spec_id (14 base entries) ───
base_values = ",\n    ".join(
    f"('{e['card_id']}'::uuid, '{e['psa_spec_id']}'::text)" for e in base_entries
)
sql_cards = f"""
BEGIN;
SET LOCAL lock_timeout = '4s';

WITH v(card_id, spec_id) AS (
  VALUES
    {base_values}
)
UPDATE cards c SET psa_spec_id = v.spec_id
FROM v WHERE c.id = v.card_id;

COMMIT;
"""
run("BACKFILL-cards", sql_cards)


# ─── Backfill 2/2: parallels.psa_spec_id (93 parallel entries) ───
par_values = ",\n    ".join(
    f"('{e['parallel_id']}'::uuid, '{e['psa_spec_id']}'::text)" for e in par_entries
)
sql_par = f"""
BEGIN;
SET LOCAL lock_timeout = '4s';

WITH v(parallel_id, spec_id) AS (
  VALUES
    {par_values}
)
UPDATE parallels p SET psa_spec_id = v.spec_id
FROM v WHERE p.id = v.parallel_id;

COMMIT;
"""
run("BACKFILL-parallels", sql_par)


# ─── Verify count totals ───
post = run("VERIFY-counts", """
SELECT
  (SELECT COUNT(*) FROM cards     WHERE psa_spec_id IS NOT NULL) AS cards_populated,
  (SELECT COUNT(*) FROM parallels WHERE psa_spec_id IS NOT NULL) AS parallels_populated;
""")
print(f"  post-counts: {post[0]}")
assert post[0]["cards_populated"]     == 14, f"expected 14, got {post[0]['cards_populated']}"
assert post[0]["parallels_populated"] == 93, f"expected 93, got {post[0]['parallels_populated']}"


# ─── Verify every entry: read back and compare ───
# Pull current spec_id for each (card_id, parallel_id) and assert equality
cids = ",".join(f"'{e['card_id']}'::uuid" for e in base_entries)
cards_back = run("VERIFY-cards-readback", f"""
SELECT id, psa_spec_id FROM cards WHERE id IN ({cids});
""")
cards_map = {r["id"]: r["psa_spec_id"] for r in cards_back}
mismatches_c = []
for e in base_entries:
    got = cards_map.get(e["card_id"])
    if got != e["psa_spec_id"]:
        mismatches_c.append({"card_id": e["card_id"], "expected": e["psa_spec_id"], "got": got})

pids = ",".join(f"'{e['parallel_id']}'::uuid" for e in par_entries)
par_back = run("VERIFY-parallels-readback", f"""
SELECT id, psa_spec_id FROM parallels WHERE id IN ({pids});
""")
par_map = {r["id"]: r["psa_spec_id"] for r in par_back}
mismatches_p = []
for e in par_entries:
    got = par_map.get(e["parallel_id"])
    if got != e["psa_spec_id"]:
        mismatches_p.append({"parallel_id": e["parallel_id"], "expected": e["psa_spec_id"], "got": got})

print(f"  card  readback mismatches: {len(mismatches_c)}")
print(f"  par   readback mismatches: {len(mismatches_p)}")
if mismatches_c or mismatches_p:
    print("FAIL:")
    for m in mismatches_c[:5]: print(f"  card  {m}")
    for m in mismatches_p[:5]: print(f"  par   {m}")
    sys.exit(1)

print(f"\nSUCCESS: 14 cards + 93 parallels backfilled, 0 mismatches.")

# Persist
out = ROOT / "scripts" / "_task_2_psa_spec" / "backfill_results.json"
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps({
    "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    "journal_total": len(entries),
    "base_count":    len(base_entries),
    "parallel_count": len(par_entries),
    "pre_cards_populated":      pre[0]["cards_populated"],
    "pre_parallels_populated":  pre[0]["parallels_populated"],
    "collision_count":          len(collisions),
    "post_cards_populated":     post[0]["cards_populated"],
    "post_parallels_populated": post[0]["parallels_populated"],
    "mismatches_cards":     mismatches_c,
    "mismatches_parallels": mismatches_p,
}, indent=2, default=str), encoding="utf-8")
print(f"Wrote {out}")
