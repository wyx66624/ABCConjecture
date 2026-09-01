#!/usr/bin/env python3
"""Resolve remaining balancing terms using archived FactorDB API records.

Every accepted exponent-one certificate is rechecked locally by computing
u_n modulo p and p^2.  For p < 2^64, primality is also rechecked locally by
the deterministic seven-base Miller--Rabin test.  Larger primes are accepted
only when a second FactorDB API query reports status P; this external-status
dependency is stated explicitly in the output.
"""

from __future__ import annotations

import csv
import hashlib
import json
import time
import urllib.parse
import urllib.request
from pathlib import Path

HERE = Path(__file__).resolve().parent
RAW = HERE / "factordb_raw"
RAW.mkdir(exist_ok=True)


def balancing(n: int) -> int:
    a, b = 0, 1
    for _ in range(n):
        a, b = b, 6 * b - a
    return a


def balancing_mod(n: int, modulus: int) -> int:
    a, b = 0, 1 % modulus
    for _ in range(n):
        a, b = b, (6 * b - a) % modulus
    return a


def is_prime_u64(n: int) -> bool:
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
    d, s = n - 1, 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for a in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
        if a % n == 0:
            continue
        x = pow(a, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x * x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def fetch(query: int, label: str) -> dict:
    if len(label) > 120:
        digest = hashlib.sha256(str(query).encode("ascii")).hexdigest()
        label = f"query_sha256_{digest}"
    path = RAW / f"{label}.json"
    if path.exists():
        return json.loads(path.read_text(encoding="utf-8"))
    url = "https://factordb.com/api?" + urllib.parse.urlencode({"query": str(query)})
    with urllib.request.urlopen(url, timeout=60) as response:
        data = json.load(response)
    path.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    time.sleep(0.15)
    return data


def main() -> None:
    source = HERE / "balancing_certificates.csv"
    rows = list(csv.DictReader(source.open(newline="", encoding="utf-8")))
    resolved = []
    complete = []
    unresolved = []
    for row in rows:
        if row["status"] != "unresolved_by_search":
            continue
        n = int(row["n"])
        u = balancing(n)
        record = fetch(u, f"u_{n}")
        factors = [(int(q), int(e)) for q, e in record.get("factors", [])]
        product = 1
        for q, e in factors:
            product *= q**e
        product_verified = product == u
        if record.get("status") == "FF" and product_verified:
            complete.append(n)

        accepted = None
        for q, e in factors:
            if e != 1:
                continue
            if q < 2**64:
                prime_basis = "local deterministic Miller-Rabin (<2^64)"
                prime_ok = is_prime_u64(q)
                factor_status = "P" if prime_ok else "composite"
            else:
                qrecord = fetch(q, f"factor_{q}")
                factor_status = qrecord.get("status", "")
                prime_ok = factor_status == "P"
                prime_basis = "FactorDB status P (external)"
            if not prime_ok:
                continue
            r = balancing_mod(n, q * q)
            if r % q == 0 and r != 0:
                accepted = {
                    "n": n,
                    "p": q,
                    "residue_mod_p2": r,
                    "quotient_mod_p": r // q,
                    "factor_record_status": record.get("status", ""),
                    "factorization_product_verified": product_verified,
                    "prime_basis": prime_basis,
                    "prime_record_status": factor_status,
                    "u_decimal_digits": len(str(u)),
                }
                break
        if accepted:
            resolved.append(accepted)
        else:
            unresolved.append({
                "n": n,
                "factor_record_status": record.get("status", ""),
                "factorization_product_verified": product_verified,
                "factors_returned": [[str(q), e] for q, e in factors],
                "u_decimal_digits": len(str(u)),
            })

    fields = [
        "n", "p", "residue_mod_p2", "quotient_mod_p",
        "factor_record_status", "factorization_product_verified",
        "prime_basis", "prime_record_status", "u_decimal_digits",
    ]
    with (HERE / "balancing_factordb_certificates.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        writer.writerows(resolved)
    summary = {
        "queried_terms": len(resolved) + len(unresolved),
        "resolved_by_verified_exponent_one_prime": len(resolved),
        "complete_factorizations_status_FF_and_product_verified": complete,
        "unresolved": unresolved,
        "qualification": (
            "Local modular checks prove v_p(u_n)=1 once primality of p is known. "
            "Primality below 2^64 is checked locally; larger p values depend on "
            "the archived FactorDB P status and are explicitly labelled external."
        ),
    }
    (HERE / "balancing_factordb_summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(summary, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
