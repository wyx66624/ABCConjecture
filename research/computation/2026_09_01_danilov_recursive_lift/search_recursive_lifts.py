"""Bounded exact search for the next Danilov prime-square lift.

For the current necessary progression t = T + Q*r, this script searches
primes p <= limit in two independent senses:

1. p || L_T, which is a finite certificate that the least surviving
   representative itself is not squarefull;
2. p | L_T and eta^Q = 1 mod p, which makes p divide L_(T+Q*r) for every r.
   The computation modulo p^2 then either forces one residue r mod p, gives
   no new information, or rules out the whole progression.

The search is finite and makes no assertion past ``limit``.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from pathlib import Path


# Recursive CRT moduli quickly exceed Python 3.11's conservative decimal
# conversion guard.  These are public certificate integers, not untrusted
# decimal input, so exact serialization should remain unrestricted.
if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)


ALPHA0 = (682, 305)
ETA = (1_730_726_404_001, 774_004_377_960)
T = 122_136_955_032_565_025_967_809_449_110_840_347_537_827
Q = 183_205_432_548_847_538_951_714_173_666_260_521_306_741
FIXED = 3375


def qmul(x: tuple[int, int], y: tuple[int, int], modulus: int) -> tuple[int, int]:
    return (
        (x[0] * y[0] + 5 * x[1] * y[1]) % modulus,
        (x[0] * y[1] + x[1] * y[0]) % modulus,
    )


def qpow(x: tuple[int, int], exponent: int, modulus: int) -> tuple[int, int]:
    out = (1, 0)
    while exponent:
        if exponent & 1:
            out = qmul(out, x, modulus)
        x = qmul(x, x, modulus)
        exponent >>= 1
    return out


def orbit_mod(t: int, modulus: int, exponent_reduction: int | None = None) -> tuple[int, int]:
    exponent = t if exponent_reduction is None else t % exponent_reduction
    return qmul(
        (ALPHA0[0] % modulus, ALPHA0[1] % modulus),
        qpow((ETA[0] % modulus, ETA[1] % modulus), exponent, modulus),
        modulus,
    )


def odd_primes(limit: int):
    if limit < 3:
        return
    sieve = bytearray(b"\x01") * (limit + 1)
    sieve[0:2] = b"\x00\x00"
    sieve[4::2] = b"\x00" * ((limit - 4) // 2 + 1)
    top = math.isqrt(limit)
    for p in range(3, top + 1, 2):
        if sieve[p]:
            start = p * p
            sieve[start:: 2 * p] = b"\x00" * ((limit - start) // (2 * p) + 1)
    for p in range(3, limit + 1, 2):
        if sieve[p]:
            yield p


def trial_prime_certificate(p: int) -> dict[str, object]:
    checked_to = math.isqrt(p)
    for d in range(2, checked_to + 1):
        assert p % d
    return {"method": "exhaustive_trial_division", "checked_through": checked_to}


def legendre_five(p: int) -> int:
    value = pow(5, (p - 1) // 2, p)
    assert value in (1, p - 1)
    return 1 if value == 1 else -1


def p2_packet(p: int) -> dict[str, object]:
    p2 = p * p
    group_order = p - legendre_five(p)
    base = orbit_mod(T, p2)
    step = qpow((ETA[0] % p2, ETA[1] % p2), Q, p2)
    l_residue = (2 * base[0] + 11) % p2
    assert l_residue % p == 0
    assert (step[0] - 1) % p == 0 and step[1] % p == 0
    # Norm(eta^Q)=1 and p is odd, so its real first-order coefficient is zero.
    assert step[0] == 1
    c = l_residue // p % p
    d = step[1] // p % p
    y = base[1] % p
    slope = 10 * y * d % p
    row: dict[str, object] = {
        "p": p,
        "prime_certificate": trial_prime_certificate(p),
        "norm_one_group_order": group_order,
        "alpha_T_mod_p2": list(base),
        "eta_pow_Q_mod_p2": list(step),
        "L_T_over_p_mod_p": c,
        "w_T_mod_p": y,
        "eta_step_im_over_p_mod_p": d,
        "linear_slope": slope,
    }
    if slope:
        rho = -c * pow(slope, -1, p) % p
        row.update(
            classification="unique_forced_residue",
            forced_r_mod_p=rho,
            next_T=str(T + Q * rho),
            next_Q=str(Q * p),
        )
        # Spot-check the formula computationally.  Its all-r validity is the
        # algebraic nilpotent-linearization identity proved in REPORT.md; an
        # O(p) residue loop would obscure the bounded prime search endpoint.
        for r in sorted({0, 1, rho, p - 1}):
            actual = (2 * orbit_mod(T + Q * r, p2)[0] + 11) % p2
            predicted = p * ((c + slope * r) % p)
            assert actual == predicted
    elif c:
        row["classification"] = "whole_progression_excluded"
    else:
        row["classification"] = "p2_divides_every_member_no_new_constraint"
    return row


def crt_pair(residue: int, modulus: int, new_residue: int, prime: int) -> tuple[int, int]:
    assert math.gcd(modulus, prime) == 1
    multiplier = (new_residue - residue) * pow(modulus, -1, prime) % prime
    return residue + modulus * multiplier, modulus * prime


def main() -> None:
    global T, Q
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=5_000_000)
    parser.add_argument("--t", type=int, default=T)
    parser.add_argument("--q", type=int, default=Q)
    parser.add_argument("--previous", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    if args.previous is not None:
        previous = json.loads(args.previous.read_text(encoding="utf-8"))
        T = int(previous["batch_next_T"])
        Q = int(previous["batch_next_Q"])
    else:
        T = args.t
        Q = args.q

    assert ETA[0] * ETA[0] - 5 * ETA[1] * ETA[1] == 1
    assert ALPHA0[0] * ALPHA0[0] - 5 * ALPHA0[1] * ALPHA0[1] == -1
    assert 0 < T < Q

    divisors_of_L_T: list[dict[str, object]] = []
    lift_packets: list[dict[str, object]] = []
    prime_count = 0
    for p in odd_primes(args.limit):
        prime_count += 1
        if FIXED % p == 0 or Q % p == 0:
            continue
        symbol = legendre_five(p)
        group_order = p - symbol
        base_mod_p = orbit_mod(T, p, group_order)
        if (2 * base_mod_p[0] + 11) % p:
            continue

        p2 = p * p
        base_mod_p2 = orbit_mod(T, p2)
        l_mod_p2 = (2 * base_mod_p2[0] + 11) % p2
        assert l_mod_p2 % p == 0
        c = l_mod_p2 // p % p
        divisors_of_L_T.append(
            {
                "p": p,
                "prime_certificate": trial_prime_certificate(p),
                "L_T_mod_p2": l_mod_p2,
                "valuation_exactly_one": c != 0,
                "L_T_over_p_mod_p": c,
            }
        )

        possible_order = math.gcd(Q, group_order)
        step_mod_p = qpow((ETA[0] % p, ETA[1] % p), possible_order, p)
        if step_mod_p != (1, 0):
            continue
        # eta has order dividing both Q and the norm-one group order.
        assert qpow((ETA[0] % p, ETA[1] % p), Q, p) == (1, 0)
        lift_packets.append(p2_packet(p))

    forced_r = 0
    forced_r_modulus = 1
    for packet in lift_packets:
        if packet["classification"] == "whole_progression_excluded":
            continue
        if packet["classification"] != "unique_forced_residue":
            continue
        forced_r, forced_r_modulus = crt_pair(
            forced_r,
            forced_r_modulus,
            int(packet["forced_r_mod_p"]),
            int(packet["p"]),
        )

    result = {
        "scope": "finite exact search; no claim beyond the endpoint",
        "limit": args.limit,
        "odd_prime_count": prime_count,
        "current_T": str(T),
        "current_Q": str(Q),
        "divisors_of_L_T": divisors_of_L_T,
        "recursive_lift_packets": lift_packets,
        "batch_forced_r": str(forced_r),
        "batch_forced_r_modulus": str(forced_r_modulus),
        "batch_next_T": str(T + Q * forced_r),
        "batch_next_Q": str(Q * forced_r_modulus),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    digest = hashlib.sha256(args.output.read_bytes()).hexdigest()
    print(json.dumps({"output": str(args.output), "sha256": digest, **result}, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
