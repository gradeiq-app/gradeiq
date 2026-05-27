# PSA Pop Scrape — Phase 1 Notes (2026-05-27)

## Phase 1B — PSA Set Discovery

### URL structure
Pop-report pages follow:
```
https://www.psacard.com/pop/<sport-cards>/<year>/<set-slug>/<heading-id>
```
For our target:
```
https://www.psacard.com/pop/football-cards/2024/topps-chrome/296820
```
- **headingID:** `296820`
- **categoryID:** `20014` (football-cards)
- **set:** 2024 Topps Chrome Football

### Response shape — NOT HTML scraping; JSON API
The pop table is *not* server-rendered. The HTML embeds an empty `<tbody>` and a DataTables initializer that POSTs to:

```
POST https://www.psacard.com/Pop/GetSetItems
Content-Type: application/x-www-form-urlencoded
```

with form fields:
```
draw=1
start=<int offset>
length=<int page size, 300/400/500 accepted>
search=
headingID=296820
categoryID=20014
isPSADNA=false
```

Response is standard DataTables JSON:
```json
{
  "draw": 1,
  "recordsTotal": 3092,
  "recordsFiltered": 3092,
  "data": [ { ...row... }, ... ]
}
```

### Per-row schema
First row in every page is the `TOTAL POPULATION` aggregate (`SpecID=0`) — skip it.

Real rows have these fields (relevant ones bolded):
- **`SpecID`** — PSA's unique spec ID (int) → store in `cards.psa_spec_id`
- **`SubjectName`** — player name (e.g. "Caleb Williams")
- **`CardNumber`** — string (e.g. `"202"`)
- **`Variety`** — parallel label (e.g. `"Gold Refractor"`) or `null` for base
- **`GradeN0`** — Authentic / ungraded count
- **`Grade1`, `Grade1_5`, `Grade2`, `Grade2_5`, ... `Grade8`, `Grade8_5`, `Grade9`, `Grade10`** — counts by grade (no `Grade9_5`)
- **`Grade1Q`, `Grade1_5Q`, ..., `Grade9Q`** — qualified counts (low grades + 9; no 10Q)
- `Total`, `GradeTotal`, `HalfGradeTotal`, `QualifiedGradeTotal` — convenience aggregates (we'll recompute)

### Pagination
- `recordsTotal = 3092` for this set
- At `length=500`, 7 pages total (3000 + 92 = 3092 incl. the synthetic TOTAL row at index 0 of page 1)
- Each page returns in ~2s
- **Polite cadence:** 1.5s sleep between pages

### Anti-scraping characterization
PSA sits behind Cloudflare (`Server: cloudflare`, `CF-RAY` header). Behavior:

| Client | Result |
|---|---|
| Anthropic `WebFetch` | **403** (likely data-center IP and/or curl-bot UA fingerprint) |
| PowerShell `Invoke-WebRequest` (.NET HTTP stack, browser UA + Sec-Fetch headers) | **403** (.NET TLS fingerprint blocked) |
| Native `curl.exe` (Schannel TLS) | **200 OK** |
| Python `requests` (urllib3 + OpenSSL TLS) | **200 OK** |

**Conclusion:** plain `requests.post(...)` with a realistic User-Agent works. No Cloudflare JS-challenge solving, no `cloudscraper` / `curl_cffi`, no headless browser needed. Required request headers:
- `User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ... Chrome/131.0.0.0 ...`
- `X-Requested-With: XMLHttpRequest`
- `Referer: <the set page URL>`

`robots.txt` returns 403 too — that is the same TLS-fingerprint block, not an actual disallow.

### Counts in this set
- 3092 total spec rows
- **96 base cards** (rows where `Variety IS NULL`), card-number range 7..296
- The remaining ~2996 rows are parallels/variants

NB: 96 base cards is lower than a typical 200-card Topps Chrome base + RC checklist. PSA only lists *graded* specs, so cards that have never been submitted don't appear at all. Pop = 0 for those.

### Ground-truth pop snapshot for the validation set
Captured live at 2026-05-27 (use as the Phase 1D yardstick):

| Player | Card # | SpecID | G9 | G10 | Total |
|---|---|---|---|---|---|
| Caleb Williams       | 202 | 12943026 | 306 | 441 | 816  |
| Jayden Daniels       | 201 | 12943025 | 565 | 306 | 1192 |
| Drake Maye           | 203 | 12943027 | 377 | 299 | 766  |
| Marvin Harrison Jr.  | 204 | 12943028 | 44  | 47  | 97   |
| Malik Nabers         | 205 | 12943029 | 40  | 36  | 90   |
| Walter Payton (vet)  | 23  | 12942847 | —   | —   | 8    |
| Jim Kelly (vet)      | 7   | 12942831 | —   | —   | 2    |

Vet counts are tiny and likely won't change between probe and re-fetch.

---

## Open items before Phase 1A/1C/1D

1. **`SUPABASE_TOKEN` not in env** — required to apply migration 013 and to write `pop_reports` rows. Memory confirms `.env.local` lacks it. User needs to source it from Supabase Dashboard → Account → Access Tokens and either export in shell or add to `.env.local`.
2. **bs4 not installed** — no longer a blocker. We're going JSON-only (no HTML parse), so the scraper only needs `requests`.
3. **PID 24540 still running** — confirmed alive (CPU 39s, started 07:24). Migration 013's only contentious DDL is `ALTER TABLE cards ADD COLUMN psa_spec_id` (metadata-only, AccessExclusive) — guarded by `SET LOCAL lock_timeout='4s'`, retry as needed (same as 011).
