"""
ebay_auth.py — OAuth Client Credentials helper for eBay Browse API.

Reads EBAY_APP_ID and EBAY_CERT_ID from os.environ. The caller is
responsible for loading .env.local into os.environ before calling
get_access_token(). This module NEVER prints, logs, or echoes credential
values or the access token itself.

Token lifecycle:
  - Cached in module-level globals (process memory only — never written
    to disk).
  - eBay tokens TTL ~7200s (2h). We refresh when within REFRESH_BUFFER_S
    of expiry (5 min) so an in-flight request never sees a stale token.
  - get_access_token(force_refresh=True) bypasses the cache. Callers use
    this on a 401 from a Browse API call, then retry once.

Failure model:
  - Exponential backoff on 429 / 5xx during token fetch.
  - Hard exit on 4xx other than 401 — usually means credentials are
    wrong, which can't recover by retrying.
  - On exit, the error message includes status code only, NOT response
    body (eBay's error envelopes can echo the Authorization header).
"""
import base64
import os
import sys
import time

import requests

OAUTH_URL = "https://api.ebay.com/identity/v1/oauth2/token"
SCOPE = "https://api.ebay.com/oauth/api_scope"
REFRESH_BUFFER_S = 300   # refresh when <5 min remain on the token
BACKOFF_S = [2, 5, 15, 45]

_token: str | None = None
_expires_at: float | None = None


def _basic_auth_header() -> str:
    """Build the Basic <base64(APP_ID:CERT_ID)> Authorization header.
    Reads from os.environ each call so a .env.local reload mid-process
    is picked up. Exits if either var is missing."""
    app_id = os.environ.get("EBAY_APP_ID")
    cert_id = os.environ.get("EBAY_CERT_ID")
    if not app_id or not cert_id:
        sys.exit(
            "ERROR: EBAY_APP_ID and EBAY_CERT_ID must be set in os.environ.\n"
            "       Load .env.local before calling get_access_token()."
        )
    creds = f"{app_id}:{cert_id}".encode("utf-8")
    return "Basic " + base64.b64encode(creds).decode("ascii")


def _fetch_new_token() -> tuple[str, float]:
    """POST to /identity/v1/oauth2/token and return (token, expires_at).
    Retries 429 / 5xx with exponential backoff. Never logs response body."""
    headers = {
        "Authorization": _basic_auth_header(),
        "Content-Type": "application/x-www-form-urlencoded",
    }
    body = f"grant_type=client_credentials&scope={SCOPE}"

    for attempt, wait in enumerate([0] + BACKOFF_S, 1):
        if wait:
            time.sleep(wait)
        try:
            r = requests.post(OAUTH_URL, headers=headers, data=body, timeout=20)
        except Exception as e:
            # Print exception TYPE only; some exception reprs include URL+headers
            print(f"[ebay_auth] token request exception (attempt {attempt}): {type(e).__name__}",
                  flush=True)
            continue

        if r.status_code == 200:
            j = r.json()
            tok = j.get("access_token")
            ttl = int(j.get("expires_in", 7200))
            if not tok:
                sys.exit("ERROR: eBay OAuth returned 200 but no access_token field")
            return tok, time.time() + ttl

        if r.status_code in (429, 500, 502, 503, 504) and attempt <= len(BACKOFF_S):
            print(f"[ebay_auth] transient {r.status_code} on token fetch "
                  f"(attempt {attempt}/{len(BACKOFF_S)+1}), backing off", flush=True)
            continue

        # 4xx other than 429: don't retry — credentials are probably wrong.
        # Status code only, no body.
        sys.exit(f"ERROR: eBay OAuth failed status={r.status_code} "
                 f"(check EBAY_APP_ID / EBAY_CERT_ID)")

    sys.exit("ERROR: eBay OAuth exhausted retries")


def get_access_token(force_refresh: bool = False) -> str:
    """Return a valid OAuth access token.

    Uses the cached token if it's still within the refresh-buffer window.
    Refreshes (or first-fetches) otherwise. Pass force_refresh=True after
    a 401 from a Browse call to invalidate the cache and re-fetch.
    """
    global _token, _expires_at
    now = time.time()
    if (not force_refresh
            and _token is not None
            and _expires_at is not None
            and now < _expires_at - REFRESH_BUFFER_S):
        return _token
    _token, _expires_at = _fetch_new_token()
    return _token


def token_status() -> dict:
    """Diagnostic helper — returns metadata WITHOUT the token value.
    Safe to print/log."""
    if _token is None or _expires_at is None:
        return {"cached": False}
    return {
        "cached": True,
        "remaining_seconds": max(0, int(_expires_at - time.time())),
        "token_length": len(_token),
    }
