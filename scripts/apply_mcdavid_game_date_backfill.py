"""McDavid Monster Season — game_date backfill (Phase 2 of the workstream).

Parses the date out of each of the 82 fake-player names ('Connor McDavid -
M/D/YYYY'), maps each fake row's 2 attached cards (Monster Season +
Monster Season Gold Parallel) to the parsed date, and UPDATEs cards.game_date
in one transaction.

Prerequisites: migration 014 applied (cards.game_date exists).
This script does NOT reassign player_id — that's the separate merge script.

DISPOSITIVE post-check (the key invariant from Phase 0): for the 164
target cards, ORDER BY game_date ASC must produce the same id sequence
as ORDER BY card_number ASC (with 'MS-N' parsed as integer N). 0 breaks
expected — Phase 0 confirmed perfect linear date-to-MS-number mapping
across all 82 game dates.

Idempotency:
  - Re-runs with identical journal -> identical UPDATEs (no-op rewrites).
  - Collision guard: STOPs if any target card already holds a DIFFERENT
    game_date (same-value-present is fine; different value means
    someone else wrote there or the source data changed).
"""
import json
import os
import pathlib
import sys
import time
from datetime import date, datetime

import requests

ROOT = pathlib.Path(__file__).resolve().parent.parent
for line in (ROOT / ".env.local").read_text(encoding="utf-8").splitlines():
    s = line.strip()
    if not s or s.startswith("#") or "=" not in s:
        continue
    k, v = s.split("=", 1)
    os.environ.setdefault(k.strip(), v.strip())

TOKEN = os.environ["SUPABASE_TOKEN"]
URL = f"https://api.supabase.com/v1/projects/{os.environ.get('SUPABASE_REF','dcsrpdmhmcboydjsbgsg')}/database/query"
H = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}


def run(label, sql, timeout=60):
    t0 = time.time()
    r = requests.post(URL, headers=H, json={"query": sql}, timeout=timeout)
    el = time.time() - t0
    print(f"[{label}] status={r.status_code}  elapsed={el:.2f}s", flush=True)
    if r.status_code not in (200, 201):
        print(f"  body={r.text[:1500]!r}", flush=True)
        sys.exit(f"{label} failed")
    try: return r.json()
    except: return None


# ─── 1. Load the 82 fake rows + their 164 cards ───
print("Loading the 82 fake McDavid rows + their cards...")
fake_rows = run("LOAD-rows", """
SELECT p.id AS player_id, p.name
FROM players p
WHERE p.name ~ '^Connor McDavid - '
ORDER BY p.name;
""")
assert len(fake_rows) == 82, f"expected 82 fake rows, got {len(fake_rows)}"

fake_id_csv = ",".join(f"'{r['player_id']}'::uuid" for r in fake_rows)
# No ORDER BY: we key into a dict by card_id below; row order is irrelevant.
# Avoids the lexicographic 'MS-1, MS-10, MS-11, ..., MS-2' footgun the
# dispositive check explicitly guards against — keep the bad sort out of
# the script entirely rather than introduce a different sort that diverges
# from the dispositive logic.
cards = run("LOAD-cards", f"""
SELECT c.id AS card_id, c.player_id, c.card_number, c.card_type, c.subset_name
FROM cards c
WHERE c.player_id IN ({fake_id_csv});
""")
assert len(cards) == 164, f"expected 164 cards, got {len(cards)}"


# ─── 2. Parse 82 dates; fail loud on any unparseable ───
def parse_date(name):
    suffix = name.removeprefix("Connor McDavid - ")
    try:
        return datetime.strptime(suffix, "%m/%d/%Y").date()
    except ValueError as e:
        raise SystemExit(f"unparseable date in name {name!r}: {e}")

player_to_date = {r["player_id"]: parse_date(r["name"]) for r in fake_rows}
unique_dates = set(player_to_date.values())
print(f"  parsed 82 unique dates: {len(unique_dates)} distinct  range {min(unique_dates)}..{max(unique_dates)}")
assert len(unique_dates) == 82


# ─── 3. Build (card_id, game_date) mapping for all 164 cards ───
# Each fake row has 2 cards; both share the same game_date as the row's date.
card_to_date = {c["card_id"]: player_to_date[c["player_id"]] for c in cards}
assert len(card_to_date) == 164


# ─── 4. Preflight ───
print("\nPreflight checks:")

# 4a. cards.game_date column exists
col = run("PREFLIGHT-column", """
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema='public' AND table_name='cards' AND column_name='game_date';
""")
if not col:
    sys.exit("STOP: cards.game_date column does not exist — apply migration 014 first.")
print(f"  cards.game_date: {col[0]}")

# 4b. All 164 target ids exist + current game_date state
card_id_csv = ",".join(f"'{cid}'::uuid" for cid in card_to_date)
state = run("PREFLIGHT-state", f"""
SELECT id, game_date FROM cards WHERE id IN ({card_id_csv});
""")
present_ids = {r["id"] for r in state}
missing = [cid for cid in card_to_date if cid not in present_ids]
if missing:
    sys.exit(f"STOP: {len(missing)} target card ids missing from cards table: {missing[:5]}...")
print(f"  all 164 target card ids present: True")

# 4c. Collision guard — any already holding a DIFFERENT game_date?
existing_nonnull = [r for r in state if r["game_date"] is not None]
print(f"  cards with non-NULL game_date already: {len(existing_nonnull)}")
collisions = []
for r in existing_nonnull:
    expected = card_to_date[r["id"]]
    actual = date.fromisoformat(r["game_date"]) if isinstance(r["game_date"], str) else r["game_date"]
    if actual != expected:
        collisions.append({"card_id": r["id"], "existing": str(actual), "expected": str(expected)})
if collisions:
    print(f"\n*** COLLISIONS ({len(collisions)} — same-value-present is FINE, different-value STOPs) ***")
    for c in collisions[:10]: print(f"    {c}")
    sys.exit("STOP: target cards already hold game_date values that differ from the journal.")
print(f"  collision-guard: 0 differing-value collisions")


# ─── 5. UPDATE in one txn ───
print("\nApplying backfill...")
values = ",\n    ".join(
    f"('{cid}'::uuid, DATE '{gd.isoformat()}')" for cid, gd in card_to_date.items()
)
sql_update = f"""
BEGIN;
SET LOCAL lock_timeout = '4s';

WITH v(card_id, game_date) AS (
  VALUES
    {values}
)
UPDATE cards c SET game_date = v.game_date
FROM v WHERE c.id = v.card_id;

COMMIT;
"""
run("BACKFILL", sql_update)


# ─── 6. Verify counts ───
post = run("VERIFY-counts", f"""
SELECT
  COUNT(*) FILTER (WHERE game_date IS NOT NULL) AS populated,
  COUNT(*) FILTER (WHERE game_date IS NULL)     AS null_count
FROM cards WHERE id IN ({card_id_csv});
""")
print(f"\nPost-backfill counts: {post[0]}")
assert post[0]["populated"] == 164, f"expected 164, got {post[0]['populated']}"
assert post[0]["null_count"] == 0


# ─── 7. DISPOSITIVE check — date order == card_number order ───
print("\nDispositive check: ORDER BY game_date ASC == ORDER BY card_number ASC")
ordered = run("VERIFY-ordering", f"""
SELECT id, game_date, card_number,
       (regexp_match(card_number, '\\d+'))[1]::int AS ms_n,
       ROW_NUMBER() OVER (ORDER BY game_date, id)                                                  AS rn_by_date,
       ROW_NUMBER() OVER (ORDER BY (regexp_match(card_number, '\\d+'))[1]::int, id)                AS rn_by_num
FROM cards WHERE id IN ({card_id_csv});
""")
# Per (game_date, card_number) we have 2 cards (regular + Gold Parallel).
# The ROW_NUMBER tiebreak is `id` on both sides — same tiebreak, same order.
# A break is any row where rn_by_date != rn_by_num.
breaks = [r for r in ordered if r["rn_by_date"] != r["rn_by_num"]]
print(f"  total cards checked: {len(ordered)}")
print(f"  ordering breaks (date-rank vs ms_n-rank): {len(breaks)}")
if breaks:
    print("\n*** ORDERING BREAKS ***")
    for b in breaks[:10]:
        print(f"    card_id={b['id']}  ms_n={b['ms_n']}  date={b['game_date']}  rn_date={b['rn_by_date']}  rn_num={b['rn_by_num']}")
    sys.exit("STOP: backfill produced a game_date ordering inconsistent with card_number ordering.")
print("  dispositive check PASS — date order matches card_number order exactly.")


# ─── Persist ───
out = ROOT / "scripts" / "_task_mcdavid" / "backfill_results.json"
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps({
    "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    "fake_rows": 82,
    "cards_updated": 164,
    "date_range": [str(min(unique_dates)), str(max(unique_dates))],
    "collisions": collisions,
    "post_populated": post[0]["populated"],
    "ordering_breaks": len(breaks),
}, indent=2, default=str), encoding="utf-8")
print(f"\nWrote {out}")
print("\nBackfill complete. Game_date populated on all 164 cards; dispositive check PASS.")
print("Next: scripts/apply_mcdavid_merge.py --phase reassign  (after review).")
