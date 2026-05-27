"""
ebay_reference_images.py — Phase 1 prototype: pull raw-listing reference
images from eBay Browse API for 14 hardcoded 2024 Topps Chrome Football
BASE cards (sourced from the PSA scraper's Phase 1 matches).

Per card:
  1. Build query: "2024 Topps Chrome Football <player_name> <card_number>"
  2. GET /buy/browse/v1/item_summary/search (limit=20, US, football cat)
  3. Filter out graded / autograph titles (keyword blacklist, word-bound)
  4. Pick the first remaining listing with a usable image (HEAD 200)
  5. UPDATE cards.reference_image_* (or journal-only if 015a not applied)
  6. Journal everything to scripts/_ebay_reference_images_<slug>.jsonl

Constraints respected:
  - 1.0s sleep between cards (well under 5,000/day quota)
  - Exponential backoff on 429 / 5xx (Browse API)
  - On 401: force-refresh OAuth token via ebay_auth, retry once
  - Credentials loaded from .env.local into os.environ; never logged

Output files (in scripts/):
  _ebay_reference_images_<slug>.jsonl       — one line per matched card
  _ebay_unmatched_images_<slug>.jsonl       — one line per card with no image
"""
import argparse
import json
import os
import pathlib
import re
import sys
import time
import urllib.parse
from typing import Optional

import requests

# Make scripts/lib importable when running this file directly
SCRIPTS_DIR = pathlib.Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPTS_DIR))
from lib import ebay_auth  # noqa: E402

# ── env loader (no echoing of values) ────────────────────────────────────────
def load_env_local() -> None:
    """Parse .env.local at the repo root into os.environ. Skip blank lines
    and #-comments. Existing os.environ values are NOT overwritten — process
    env wins."""
    env_path = SCRIPTS_DIR.parent / ".env.local"
    if not env_path.exists():
        return
    for line in env_path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.startswith("#") or "=" not in s:
            continue
        k, v = s.split("=", 1)
        k = k.strip()
        v = v.strip()
        # Strip optional surrounding quotes
        if len(v) >= 2 and v[0] == v[-1] and v[0] in ("'", '"'):
            v = v[1:-1]
        if k and k not in os.environ:
            os.environ[k] = v

load_env_local()

# ── config ───────────────────────────────────────────────────────────────────
TOKEN = os.environ.get("SUPABASE_TOKEN")
if not TOKEN:
    sys.exit(
        "ERROR: SUPABASE_TOKEN env var is required.\n"
        "  Add to .env.local, or: $env:SUPABASE_TOKEN = 'sbp_...'  (PowerShell)"
    )

REF = os.environ.get("SUPABASE_REF", "dcsrpdmhmcboydjsbgsg")
DB_URL = f"https://api.supabase.com/v1/projects/{REF}/database/query"
DB_HDRS = {"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"}

BROWSE_URL = "https://api.ebay.com/buy/browse/v1/item_summary/search"
SET_TEXT = "2024 Topps Chrome Football"
SET_SLUG = "2024_topps_chrome_fb"
FOOTBALL_CATEGORY_ID = "261328"
PER_CARD_SLEEP_S = 1.0
EBAY_BACKOFF_S = [2, 5, 15, 45]
DB_BACKOFF_S = [5, 15, 45, 90, 180]
HEAD_TIMEOUT_S = 5
MAX_RAW_PRICE_USD = 150  # listings above this are almost always slabbed or auto;
                         # cheap check, runs BEFORE graded-keyword filter

# Title-keyword blacklist (word-bounded, case-insensitive). Matching ANY of
# these in the listing title eliminates the listing as "not a raw card".
# Note: 'auto' / 'autograph' / 'autographed' / 'autos' are excluded because
# Phase 1 is base-only; autos are a separate parallel.
GRADED_KEYWORDS = [
    "psa", "bgs", "sgc", "cgc", "csg", "gma", "hga", "tag", "isa",
    "beckett", "graded", "slab", "slabbed",
]
AUTO_KEYWORDS = ["auto", "autograph", "autographed", "autos", "autographs"]

# Compiled word-boundary regex matching any blacklist term
_BLACKLIST_RE = re.compile(
    r"\b(" + "|".join(re.escape(w) for w in GRADED_KEYWORDS + AUTO_KEYWORDS) + r")\b",
    re.IGNORECASE,
)

# ── target cards (card_ids from PSA Phase 1 base matches) ────────────────────
# Card numbers are loaded at startup from the PSA journal (load_psa_card_numbers)
# rather than hardcoded here, because rawiq's cards.card_number is NULL for
# this roster-contaminated set — the PSA "Card #" field is the canonical
# source of truth for Phase 1.
PSA_JOURNAL_FILENAME = "_psa_specs_2024_topps_chrome_fb.jsonl"

TARGET_CARDS: list[dict] = [
    {"card_id": "d631c97c-0e86-44d0-b27e-98cf96b2f2aa", "player": "Barry Sanders"},
    {"card_id": "02d16107-b57e-44b5-99b1-a96968392fd9", "player": "CJ Stroud"},
    {"card_id": "4a6535f4-1389-4011-9699-79408c529e7d", "player": "Peyton Manning"},
    {"card_id": "8af01a39-e1bd-48ee-9b4e-4cbdb3dd6d7e", "player": "Tom Brady"},
    {"card_id": "bfad234b-be74-4739-8ecd-7ae79a1201a7", "player": "Lawrence Taylor"},
    {"card_id": "4404266e-0111-401b-93e7-ed670d933d69", "player": "Jerry Rice"},
    {"card_id": "a9bcd2b4-7081-4f88-a4de-d8417cf7fa7a", "player": "Joe Montana"},
    {"card_id": "3b2e9bbf-6abc-47b5-a430-e88018898ca6", "player": "Jayden Daniels"},
    {"card_id": "987c0681-4d54-452e-b9f2-6d64d27b9418", "player": "Caleb Williams"},
    {"card_id": "af71b4c5-de24-4014-b592-27ad56af6d75", "player": "Drake Maye"},
    {"card_id": "0096457e-54b7-426d-a12f-d793bdf9f0ab", "player": "Marvin Harrison Jr."},
    {"card_id": "11f7e4de-ddf1-44b9-8482-453bda58dc74", "player": "Malik Nabers"},
    {"card_id": "e6520e0d-d6b6-4c3d-be92-d7265a687ada", "player": "Bo Nix"},
    {"card_id": "7c59b150-69f6-40d6-82f9-f36906b5cbaa", "player": "Xavier Worthy"},
]

def load_psa_card_numbers() -> dict[str, str]:
    """Read the PSA Phase 1 journal and build {subject_name: card_number}
    using only BASE rows (parallel_id IS NULL). Returns {} if the journal
    is missing — caller handles that gracefully (query falls back to
    set + name only)."""
    journal_path = SCRIPTS_DIR / PSA_JOURNAL_FILENAME
    if not journal_path.exists():
        log(f"  WARN: PSA journal {journal_path.name} not found; "
            f"queries will run without card numbers")
        return {}
    out: dict[str, str] = {}
    for line in journal_path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s:
            continue
        try:
            row = json.loads(s)
        except json.JSONDecodeError:
            continue
        if row.get("parallel_id"):
            continue  # base rows only
        name = row.get("subject_name")
        cn = row.get("card_number")
        if name and cn:
            out[name] = str(cn)
    return out

# ── logging ─────────────────────────────────────────────────────────────────
def log(msg: str) -> None:
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    try:
        sys.stdout.buffer.write(line.encode("utf-8") + b"\n")
        sys.stdout.buffer.flush()
    except Exception:
        print(line.encode("ascii", "replace").decode("ascii"), flush=True)

# ── query construction ──────────────────────────────────────────────────────
def build_query(player: str, card_number: Optional[str]) -> str:
    """Compose the eBay `q` parameter.

    Player-name normalization is minimal:
      - Strip the trailing '.' after Jr / Sr suffix (so "Marvin Harrison Jr."
        becomes "Marvin Harrison Jr"). eBay tokenizes "Jr" and "Jr." the same
        way, but the period adds noise to some title-match relevance scores.
      - Apostrophes and hyphens are LEFT INTACT (e.g. "Ja'Marr Chase",
        "Jaxon Smith-Njigba"). eBay's full-text search treats them as
        relevance signals on player names.
      - We do NOT lowercase; eBay search is case-insensitive.
    Card number is appended verbatim if non-null. URL encoding is handled
    later by requests.params, so no manual escaping here.
    """
    name = re.sub(r"\b(Jr|Sr)\.", r"\1", player)
    parts = [SET_TEXT, name]
    if card_number:
        parts.append(str(card_number))
    return " ".join(p.strip() for p in parts if p and p.strip())

# ── filter logic ────────────────────────────────────────────────────────────
def listing_price_usd(it: dict) -> tuple[Optional[float], Optional[str]]:
    """Extract price as (value, currency) from an itemSummary. Returns
    (None, None) if no price field is present. Non-numeric strings safely
    yield None."""
    p = it.get("price")
    if not isinstance(p, dict):
        return None, None
    raw_val = p.get("value")
    try:
        val = float(raw_val) if raw_val is not None else None
    except (ValueError, TypeError):
        val = None
    return val, p.get("currency")

def filter_listings(items: list[dict]) -> tuple[list[dict], dict]:
    """Apply (1) price cap, then (2) graded/auto keyword blacklist.
    Price runs first because it's cheaper and catches a lot of slabs +
    autos without keyword detection (slabs at $200+, autos at $300+).

    Returns (kept_listings, stats) where stats tracks how many were
    eliminated by each filter — useful for spot-checking the
    MAX_RAW_PRICE_USD threshold.
    """
    stats = {
        "returned": len(items),
        "rejected_price": 0,
        "rejected_graded": 0,
        "kept": 0,
    }
    kept: list[dict] = []
    for it in items:
        val, currency = listing_price_usd(it)
        # Only enforce on USD. Non-USD (rare on EBAY_US marketplace) passes.
        if currency == "USD" and val is not None and val > MAX_RAW_PRICE_USD:
            stats["rejected_price"] += 1
            continue
        if not is_raw_listing(it.get("title", "")):
            stats["rejected_graded"] += 1
            continue
        kept.append(it)
    stats["kept"] = len(kept)
    return kept, stats

def is_raw_listing(title: str) -> bool:
    """Return True if a listing title looks like a raw (ungraded, non-auto)
    card. Word-bounded match against GRADED_KEYWORDS + AUTO_KEYWORDS.

    Examples:
      'Tom Brady 2024 Topps Chrome #120 PSA 10'        -> False (PSA)
      'Tom Brady 2024 Topps Chrome #120 Auto /99'      -> False (Auto)
      '2024 Topps Chrome Tom Brady #120 NM-MT'         -> True
      '2024 Topps Chrome Brady Photovariation'         -> True
      'Tom Brady 2024 Topps Chrome #120 PSA-Worthy'    -> False  (false neg
        is acceptable; better to over-exclude than ship a slab as raw)
    """
    if not title:
        return False
    return _BLACKLIST_RE.search(title) is None

def pick_best_listing(items: list[dict]) -> tuple[Optional[dict], dict]:
    """From the filtered raw-listing pool, pick the first item that:
      - has an `image.imageUrl` field set
      - that URL responds 200 on HEAD (~5s timeout)

    Quality-tier preference: try items with bidCount > 0 first (a signal
    the listing is live and not a relisted ghost). If none qualify under
    that filter, fall back to the unfiltered pool. (eBay's item_summary
    does NOT include watchCount; only bidCount, which is auction-only.)

    Returns: (chosen_item_or_None, stats_dict).
    """
    stats = {
        "filtered_raw": len(items),
        "with_image_field": 0,
        "head_checked": 0,
        "head_ok": 0,
        "head_failed": 0,
        "had_bids": 0,
    }

    # Partition by buyer-interaction signal (auction-only — bidCount)
    bid_items = [it for it in items if (it.get("bidCount") or 0) > 0]
    stats["had_bids"] = len(bid_items)

    for pool in (bid_items, items):
        for it in pool:
            img = (it.get("image") or {}).get("imageUrl")
            if not img:
                continue
            stats["with_image_field"] += 1
            stats["head_checked"] += 1
            try:
                h = requests.head(img, timeout=HEAD_TIMEOUT_S, allow_redirects=True)
                if h.status_code == 200:
                    stats["head_ok"] += 1
                    return it, stats
                stats["head_failed"] += 1
            except Exception:
                stats["head_failed"] += 1
                continue
        if pool is items:
            break  # fallback pool already exhausted
    return None, stats

# ── eBay Browse call ────────────────────────────────────────────────────────
def browse_search(q: str) -> tuple[Optional[list[dict]], int]:
    """Call /item_summary/search. Returns (itemSummaries, http_status).
    Retries 429/5xx; on a single 401, force-refreshes the OAuth token and
    retries exactly once. Never logs the token or full response body."""
    refreshed_for_401 = False
    for attempt, wait in enumerate([0] + EBAY_BACKOFF_S, 1):
        if wait:
            time.sleep(wait)
        token = ebay_auth.get_access_token()
        params = {
            "q": q,
            "filter": "conditions:{NEW|USED_EXCELLENT|USED_VERY_GOOD},itemLocationCountry:US",
            "category_ids": FOOTBALL_CATEGORY_ID,
            "limit": "20",
        }
        headers = {
            "Authorization": f"Bearer {token}",
            "X-EBAY-C-MARKETPLACE-ID": "EBAY_US",
            "X-EBAY-C-ENDUSERCTX": "contextualLocation=country=US",
            "Accept": "application/json",
        }
        try:
            r = requests.get(BROWSE_URL, params=params, headers=headers, timeout=30)
        except Exception as e:
            log(f"     ! browse exception (attempt {attempt}): {type(e).__name__}")
            continue

        if r.status_code == 200:
            j = r.json()
            return j.get("itemSummaries", []) or [], 200

        if r.status_code == 401 and not refreshed_for_401:
            log(f"     ! browse 401 — forcing OAuth refresh and retrying once")
            ebay_auth.get_access_token(force_refresh=True)
            refreshed_for_401 = True
            continue

        if r.status_code in (429, 500, 502, 503, 504) and attempt <= len(EBAY_BACKOFF_S):
            log(f"     ! browse transient {r.status_code} "
                f"(attempt {attempt}/{len(EBAY_BACKOFF_S)+1})")
            continue

        # Truncate body in case it includes anything sensitive
        log(f"     ! browse failed status={r.status_code} body[:200]={r.text[:200]!r}")
        return None, r.status_code
    return None, 0

# ── DB layer ────────────────────────────────────────────────────────────────
def run_sql(sql: str, timeout: int = 60) -> tuple[int, str]:
    """POST a SQL query to Supabase Management API. Retries 5xx / 429."""
    for attempt, wait in enumerate([0] + DB_BACKOFF_S, 1):
        if wait:
            time.sleep(wait)
        try:
            r = requests.post(DB_URL, headers=DB_HDRS,
                              json={"query": sql}, timeout=timeout)
        except Exception as e:
            log(f"     ! db exception {type(e).__name__} (attempt {attempt})")
            continue
        if r.status_code in (200, 201):
            return r.status_code, r.text
        if r.status_code in (429, 500, 502, 503, 504, 522, 524, 544) \
                and attempt <= len(DB_BACKOFF_S):
            log(f"     ! db transient {r.status_code} (attempt {attempt})")
            continue
        return r.status_code, r.text
    return 0, "exhausted retries"

def q_db(sql: str) -> list[dict]:
    status, body = run_sql(sql)
    if status not in (200, 201):
        log(f"SQL failed status={status} body={body[:400]}")
        sys.exit(1)
    return json.loads(body)

def sql_lit(v) -> str:
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("'", "''") + "'"

def detect_db_mode() -> str:
    """Return 'write' if cards.reference_image_url exists, else 'journal-only'.
    Looks at information_schema rather than trying-and-catching to avoid
    triggering any locks on the cards table."""
    rows = q_db(
        "SELECT 1 AS present FROM information_schema.columns "
        "WHERE table_schema='public' AND table_name='cards' "
        "AND column_name='reference_image_url' LIMIT 1;"
    )
    return "write" if rows else "journal-only"

def update_card_reference_image(
    card_id: str,
    image_url: str,
    listing_url: Optional[str],
    source: str = "ebay",
) -> None:
    """Single-row UPDATE with short lock timeout. UPDATE on cards.id PK is
    blocked only by another writer on that exact row — the parallel backfill
    INSERTs into parallels, not cards, so contention should be near-zero."""
    sql = f"""
BEGIN;
SET LOCAL lock_timeout = '4s';
UPDATE public.cards
   SET reference_image_url         = {sql_lit(image_url)},
       reference_image_source      = {sql_lit(source)},
       reference_image_listing_url = {sql_lit(listing_url)},
       reference_image_fetched_at  = now()
 WHERE id = {sql_lit(card_id)}::uuid;
COMMIT;
"""
    status, body = run_sql(sql)
    if status not in (200, 201):
        log(f"     ! UPDATE failed for {card_id} status={status} body={body[:200]}")

# ── journal writes ──────────────────────────────────────────────────────────
def append_jsonl(path: pathlib.Path, obj: dict) -> None:
    with open(path, "a", encoding="utf-8") as f:
        f.write(json.dumps(obj, ensure_ascii=False) + "\n")

# ── main ────────────────────────────────────────────────────────────────────
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true",
                    help="skip DB writes; eBay calls + journal still happen")
    args = ap.parse_args()

    t_start = time.time()
    log("=== eBay Reference Image scraper — Phase 1 prototype ===")
    log(f"  set:            {SET_TEXT}")
    log(f"  target cards:   {len(TARGET_CARDS)}")
    log(f"  per-card sleep: {PER_CARD_SLEEP_S}s")
    log(f"  dry_run:        {args.dry_run}")

    log("--- OAuth token preflight ---")
    _ = ebay_auth.get_access_token()
    st = ebay_auth.token_status()
    log(f"  token cached={st['cached']} ttl_remaining={st.get('remaining_seconds')}s "
        f"len={st.get('token_length')}")

    log("--- PSA card-number lookup ---")
    psa_card_numbers = load_psa_card_numbers()
    log(f"  loaded {len(psa_card_numbers)} player_name -> card_number entries")

    log("--- DB mode detection ---")
    db_mode = detect_db_mode()
    log(f"  db_mode = {db_mode}  "
        f"({'cards.reference_image_url exists; UPDATEs enabled' if db_mode == 'write' else '015a not applied; journal-only'})")

    matched_path   = SCRIPTS_DIR / f"_ebay_reference_images_{SET_SLUG}.jsonl"
    unmatched_path = SCRIPTS_DIR / f"_ebay_unmatched_images_{SET_SLUG}.jsonl"
    # Truncate previous run output
    matched_path.write_text("", encoding="utf-8")
    unmatched_path.write_text("", encoding="utf-8")

    results: list[dict] = []
    api_calls = 0
    error_counts = {"401": 0, "429": 0, "5xx": 0, "other": 0}
    listings_returned_total = 0
    listings_after_filter_total = 0

    for i, card in enumerate(TARGET_CARDS, 1):
        psa_cn = psa_card_numbers.get(card["player"])
        log(f"--- card {i}/{len(TARGET_CARDS)}: {card['player']} "
            f"(PSA #{psa_cn or '?'}) ---")
        query = build_query(card["player"], psa_cn)
        log(f"  query = {query!r}")

        api_calls += 1
        items, status = browse_search(query)
        if status == 401:
            error_counts["401"] += 1
        elif status == 429:
            error_counts["429"] += 1
        elif status and status >= 500:
            error_counts["5xx"] += 1
        elif items is None:
            error_counts["other"] += 1

        if items is None:
            log(f"  ! browse returned no results (status={status})")
            append_jsonl(unmatched_path, {
                "card_id": card["card_id"], "player": card["player"],
                "card_number": card["card_number"], "query": query,
                "reason": f"browse-error-{status}",
                "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            })
            time.sleep(PER_CARD_SLEEP_S)
            continue

        listings_returned_total += len(items)
        raw_items, filter_stats = filter_listings(items)
        listings_after_filter_total += len(raw_items)
        log(f"  filter: returned={filter_stats['returned']} "
            f"rejected_price={filter_stats['rejected_price']} "
            f"rejected_graded={filter_stats['rejected_graded']} "
            f"kept={filter_stats['kept']}")

        chosen, pick_stats = pick_best_listing(raw_items)
        log(f"  pick:   {pick_stats}")

        if not chosen:
            log(f"  ! no usable raw listing with image")
            append_jsonl(unmatched_path, {
                "card_id": card["card_id"], "player": card["player"],
                "card_number": psa_cn, "query": query,
                "listings_returned": len(items),
                "listings_after_filter": len(raw_items),
                "filter_stats": filter_stats,
                "reason": "no-raw-listing-with-image",
                "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            })
            time.sleep(PER_CARD_SLEEP_S)
            continue

        image_url = (chosen.get("image") or {}).get("imageUrl")
        listing_url = chosen.get("itemWebUrl")
        item_id = chosen.get("itemId")
        title = chosen.get("title", "")
        log(f"  picked: itemId={item_id} title={title[:80]!r}")
        log(f"  image:  {image_url}")
        log(f"  url:    {listing_url}")

        if db_mode == "write" and not args.dry_run:
            update_card_reference_image(card["card_id"], image_url, listing_url)

        result = {
            "card_id": card["card_id"],
            "player_name": card["player"],
            "card_number": psa_cn,
            "query": query,
            "listings_returned": len(items),
            "listings_after_filter": len(raw_items),
            "filter_stats": filter_stats,
            "selected_listing_id": item_id,
            "selected_title": title,
            "image_url": image_url,
            "listing_url": listing_url,
            "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        }
        append_jsonl(matched_path, result)
        results.append(result)

        time.sleep(PER_CARD_SLEEP_S)

    # ── summary ──────────────────────────────────────────────────────────────
    elapsed = time.time() - t_start
    log("=== SUMMARY ===")
    log(f"  total cards processed:        {len(TARGET_CARDS)}")
    log(f"  cards with image:             {len(results)}")
    log(f"  cards without image:          {len(TARGET_CARDS) - len(results)}")
    log(f"  total eBay API calls:         {api_calls}")
    log(f"  total listings returned:      {listings_returned_total} "
        f"(avg {listings_returned_total / max(1, api_calls):.1f}/query)")
    log(f"  total raw after filter:       {listings_after_filter_total} "
        f"(avg {listings_after_filter_total / max(1, api_calls):.1f}/query)")
    log(f"  401s={error_counts['401']} 429s={error_counts['429']} "
        f"5xxs={error_counts['5xx']} other={error_counts['other']}")
    log(f"  db_mode:                      {db_mode}"
        + (" (dry-run, no writes)" if args.dry_run else ""))
    log(f"  elapsed:                      {elapsed:.1f}s")

    # Per-card table for spot-check
    log("=== PER-CARD RESULTS (for spot-check) ===")
    log(f"  {'#':>2}  {'player':<22} {'card_id':<36}  image / listing")
    for i, card in enumerate(TARGET_CARDS, 1):
        match = next((r for r in results if r["card_id"] == card["card_id"]), None)
        if match:
            log(f"  {i:>2}  {card['player']:<22} {card['card_id']}  IMAGE: {match['image_url']}")
            log(f"  {'':>2}  {'':<22} {'':<36}  LIST:  {match['listing_url']}")
        else:
            log(f"  {i:>2}  {card['player']:<22} {card['card_id']}  (no image found)")

    log(f"  matched journal:   {matched_path.name}  ({len(results)} lines)")
    log(f"  unmatched journal: {unmatched_path.name}  "
        f"({len(TARGET_CARDS) - len(results)} lines)")

if __name__ == "__main__":
    main()
