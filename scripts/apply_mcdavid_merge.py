"""McDavid Monster Season — merge phase (Phases 3-4 of the workstream).

Phases:
  --phase reassign : snapshot (82 fake + canonical + 164 cards) + JSONL,
                     then UPDATE cards SET player_id = canonical for the
                     164 cards. Verifies + STOPS at the gate.
  --phase delete   : preflight + count-guarded DELETE of the 82 emptied
                     fake rows. Verifies.

Run --phase reassign first; review the verify output; then run
--phase delete only after gate approval.

Prerequisites:
  - Migration 014 applied
  - apply_mcdavid_game_date_backfill.py run + dispositive check PASS

Idempotency:
  - reassign: re-running rewrites identical player_id → same canonical
    (no-op on already-merged cards). Snapshot DROP IF EXISTS + recreate.
  - delete: count-guarded; STOPs if not exactly 82 deletable rows with 0
    cards.

Snapshot tables:
  players_backup_mcdavid_2026_05_28  — 83 rows (82 fake + canonical)
  cards_backup_mcdavid_2026_05_28    — 164 rows (pre-merge player_id captured)
"""
import argparse
import json
import os
import pathlib
import sys
import time

import requests

CANONICAL_ID = "6e5535b5-7a4d-47e6-b4a4-a214d6a025e1"  # Connor McDavid (Hockey)
SNAP_PLAYERS = "players_backup_mcdavid_2026_05_28"
SNAP_CARDS   = "cards_backup_mcdavid_2026_05_28"

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


# ──────────────────────────────────────────────────────────────────────────────
# Phase: reassign  (snapshot + UPDATE cards SET player_id, verify, STOP)
# ──────────────────────────────────────────────────────────────────────────────
def phase_reassign():
    # Load 82 fake ids (source of truth — same query as backfill)
    fake_rows = run("LOAD-fakes", """
SELECT id FROM players WHERE name ~ '^Connor McDavid - ' ORDER BY id;
""")
    if len(fake_rows) != 82:
        sys.exit(f"STOP: expected 82 fake rows, got {len(fake_rows)} — investigate before merging.")
    fake_ids = [r["id"] for r in fake_rows]
    fake_id_csv = ",".join(f"'{i}'::uuid" for i in fake_ids)
    snap_ids = fake_ids + [CANONICAL_ID]
    snap_id_csv = ",".join(f"'{i}'::uuid" for i in snap_ids)

    # ─── Snapshot ───
    print("\nCreating snapshots...")
    run("SNAPSHOT-players", f"""
BEGIN;
SET LOCAL lock_timeout = '4s';
DROP TABLE IF EXISTS {SNAP_PLAYERS};
CREATE TABLE {SNAP_PLAYERS} AS
SELECT * FROM players WHERE id IN ({snap_id_csv});
COMMIT;
""")
    p_count = run("SNAPSHOT-players-verify", f"SELECT COUNT(*) AS n FROM {SNAP_PLAYERS};")
    assert p_count[0]["n"] == 83, f"expected 83 player snapshot rows (82 fake + canonical), got {p_count[0]['n']}"
    print(f"  {SNAP_PLAYERS}: 83 rows OK")

    run("SNAPSHOT-cards", f"""
BEGIN;
SET LOCAL lock_timeout = '4s';
DROP TABLE IF EXISTS {SNAP_CARDS};
CREATE TABLE {SNAP_CARDS} AS
SELECT id, player_id, set_id, card_number, card_type, subset_name, game_date, now() AS snapped_at
FROM cards WHERE player_id IN ({fake_id_csv});
COMMIT;
""")
    c_count = run("SNAPSHOT-cards-verify", f"SELECT COUNT(*) AS n FROM {SNAP_CARDS};")
    assert c_count[0]["n"] == 164, f"expected 164 card snapshot rows, got {c_count[0]['n']}"
    print(f"  {SNAP_CARDS}: 164 rows OK")

    # JSONL exports
    backups = ROOT / "scripts" / "backups"
    backups.mkdir(parents=True, exist_ok=True)

    # SELECT * from the snapshot table — it's a full CTAS copy, so this
    # exports whatever columns players actually has without assuming a
    # specific set (no 'active'/etc. assumption that could break if the
    # schema diverged from this script's expectations).
    p_rows = run("SNAPSHOT-players-export", f"""
SELECT * FROM {SNAP_PLAYERS} ORDER BY id;
""")
    p_jsonl = backups / f"{SNAP_PLAYERS}.jsonl"
    with p_jsonl.open("w", encoding="utf-8") as f:
        for r in p_rows: f.write(json.dumps(r, default=str, ensure_ascii=False) + "\n")
    p_lines = sum(1 for _ in p_jsonl.open(encoding="utf-8"))
    print(f"  JSONL: {p_jsonl.name}  lines={p_lines}")
    assert p_lines == 83

    c_rows = run("SNAPSHOT-cards-export", f"""
SELECT * FROM {SNAP_CARDS} ORDER BY id;
""")
    c_jsonl = backups / f"{SNAP_CARDS}.jsonl"
    with c_jsonl.open("w", encoding="utf-8") as f:
        for r in c_rows: f.write(json.dumps(r, default=str, ensure_ascii=False) + "\n")
    c_lines = sum(1 for _ in c_jsonl.open(encoding="utf-8"))
    print(f"  JSONL: {c_jsonl.name}  lines={c_lines}")
    assert c_lines == 164

    # ─── Reassign txn ───
    print("\nReassigning 164 cards onto canonical Connor McDavid...")
    before = run("PRE-counts", f"""
SELECT
  (SELECT COUNT(*) FROM cards WHERE player_id IN ({fake_id_csv})) AS cards_on_fakes,
  (SELECT COUNT(*) FROM cards WHERE player_id = '{CANONICAL_ID}'::uuid) AS cards_on_canonical;
""")
    print(f"  before: {before[0]}")

    run("REASSIGN", f"""
BEGIN;
SET LOCAL lock_timeout = '4s';
UPDATE cards SET player_id = '{CANONICAL_ID}'::uuid
WHERE player_id IN ({fake_id_csv});
COMMIT;
""")

    after = run("POST-counts", f"""
SELECT
  (SELECT COUNT(*) FROM cards WHERE player_id IN ({fake_id_csv})) AS cards_on_fakes,
  (SELECT COUNT(*) FROM cards WHERE player_id = '{CANONICAL_ID}'::uuid) AS cards_on_canonical;
""")
    print(f"  after:  {after[0]}")

    moved = after[0]["cards_on_canonical"] - before[0]["cards_on_canonical"]
    assert after[0]["cards_on_fakes"] == 0, f"expected 0 cards on fakes, got {after[0]['cards_on_fakes']}"
    assert moved == 164, f"expected 164 cards moved, got {moved}"

    # Per-row check: all 82 fake rows should each be at 0 cards
    per_fake = run("VERIFY-per-fake", f"""
SELECT COUNT(*) AS rows_at_zero
FROM players p
WHERE p.id IN ({fake_id_csv})
  AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.player_id = p.id);
""")
    print(f"  fake rows now at 0 cards: {per_fake[0]['rows_at_zero']}/82")
    assert per_fake[0]["rows_at_zero"] == 82

    # Global integrity
    integ = run("INTEGRITY", """
SELECT
  COUNT(*) FILTER (WHERE player_id IS NULL) AS null_pid,
  COUNT(*) FILTER (WHERE player_id IS NOT NULL
                   AND NOT EXISTS (SELECT 1 FROM players p WHERE p.id = cards.player_id)) AS orphan_pid
FROM cards;
""")
    print(f"  global integrity: {integ[0]}")
    assert integ[0]["null_pid"] == 0 and integ[0]["orphan_pid"] == 0

    out = ROOT / "scripts" / "_task_mcdavid" / "merge_reassign_results.json"
    out.write_text(json.dumps({
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "snapshot_players": p_lines,
        "snapshot_cards": c_lines,
        "cards_moved": moved,
        "cards_on_fakes_post": after[0]["cards_on_fakes"],
        "cards_on_canonical_post": after[0]["cards_on_canonical"],
        "fake_rows_at_zero": per_fake[0]["rows_at_zero"],
        "integrity": integ[0],
    }, indent=2, default=str), encoding="utf-8")
    print(f"\nWrote {out}")
    print("\nSTOPPED at reassign gate. Re-run with --phase delete after review.")


# ──────────────────────────────────────────────────────────────────────────────
# Phase: delete  (count-guarded DELETE of the 82 emptied fake rows)
# ──────────────────────────────────────────────────────────────────────────────
def phase_delete():
    # Re-load the fake ids (in case anything shifted between phases)
    fake_rows = run("LOAD-fakes", """
SELECT id FROM players WHERE name ~ '^Connor McDavid - ' ORDER BY id;
""")
    if len(fake_rows) != 82:
        sys.exit(f"STOP: expected 82 fake rows, got {len(fake_rows)} — state diverged, abort.")
    fake_ids = [r["id"] for r in fake_rows]
    fake_id_csv = ",".join(f"'{i}'::uuid" for i in fake_ids)

    # Preflight (read-only sanity)
    pre = run("PREFLIGHT", f"""
SELECT
  COUNT(*) FILTER (WHERE EXISTS (SELECT 1 FROM cards WHERE player_id = p.id))     AS has_cards,
  COUNT(*) FILTER (WHERE NOT EXISTS (SELECT 1 FROM cards WHERE player_id = p.id)) AS deletable,
  COUNT(*) AS still_present
FROM players p WHERE p.id IN ({fake_id_csv});
""")
    print(f"  preflight: {pre[0]}")
    assert pre[0]["still_present"] == 82
    assert pre[0]["has_cards"] == 0, f"STOP: {pre[0]['has_cards']} fake rows still hold cards"

    before = run("COUNT-BEFORE", "SELECT COUNT(*) AS n FROM players;")
    print(f"  players before: {before[0]['n']}")

    # Count-guarded delete
    sql_del = f"""
BEGIN;
SET LOCAL lock_timeout = '4s';

DO $$
DECLARE guard_count INT;
BEGIN
  SELECT COUNT(*) INTO guard_count
  FROM players p
  WHERE p.id IN ({fake_id_csv})
    AND NOT EXISTS (SELECT 1 FROM cards WHERE player_id = p.id);
  IF guard_count <> 82 THEN
    RAISE EXCEPTION 'McDavid DELETE guard failed: % deletable (need exactly 82)', guard_count;
  END IF;
END $$;

DELETE FROM players p
WHERE p.id IN ({fake_id_csv})
  AND NOT EXISTS (SELECT 1 FROM cards WHERE player_id = p.id)
RETURNING id, name;

COMMIT;
"""
    deleted = run("DELETE", sql_del)
    print(f"  rows deleted: {len(deleted)}")
    assert len(deleted) == 82, f"expected 82, got {len(deleted)}"

    after = run("COUNT-AFTER", "SELECT COUNT(*) AS n FROM players;")
    print(f"  players after: {after[0]['n']}  (delta {after[0]['n'] - before[0]['n']})")
    assert after[0]["n"] - before[0]["n"] == -82

    # Residue + integrity + detector
    residue = run("RESIDUE", f"SELECT COUNT(*) AS n FROM players WHERE id IN ({fake_id_csv});")
    print(f"  residue: {residue[0]['n']}  (expect 0)")
    assert residue[0]["n"] == 0

    integ = run("INTEGRITY", """
SELECT
  COUNT(*) FILTER (WHERE player_id IS NULL) AS null_pid,
  COUNT(*) FILTER (WHERE player_id IS NOT NULL
                   AND NOT EXISTS (SELECT 1 FROM players p WHERE p.id = cards.player_id)) AS orphan_pid
FROM cards;
""")
    print(f"  integrity: {integ[0]}")
    assert integ[0]["null_pid"] == 0 and integ[0]["orphan_pid"] == 0

    det = run("DETECTOR", r"""
SELECT COUNT(*) AS n FROM players WHERE name ~ '^Connor McDavid - ';
""")
    print(f"  McDavid date-row detector: {det[0]['n']}  (expect 0)")
    assert det[0]["n"] == 0

    canon = run("CANONICAL", f"""
SELECT (SELECT COUNT(*) FROM cards WHERE player_id = '{CANONICAL_ID}'::uuid) AS cards;
""")
    print(f"  canonical McDavid cards: {canon[0]['cards']}  (expect 579 = 415 + 164)")

    out = ROOT / "scripts" / "_task_mcdavid" / "merge_delete_results.json"
    out.write_text(json.dumps({
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "rows_deleted": len(deleted),
        "players_before": before[0]["n"],
        "players_after": after[0]["n"],
        "residue": residue[0]["n"],
        "integrity": integ[0],
        "detector_remaining": det[0]["n"],
        "canonical_cards_post": canon[0]["cards"],
    }, indent=2, default=str), encoding="utf-8")
    print(f"\nWrote {out}")
    print("\nMcDavid merge complete.")


# ──────────────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", choices=["reassign", "delete"], required=True)
    args = ap.parse_args()
    if args.phase == "reassign": phase_reassign()
    elif args.phase == "delete": phase_delete()
