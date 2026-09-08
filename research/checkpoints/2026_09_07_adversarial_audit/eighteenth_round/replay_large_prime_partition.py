"""Exact actual endpoint and recursive Lucas certificates; standard library only.

Default writes a canonical result; --check recomputes and compares without writing.
No factorization oracle, probable-prime predicate, floating logs, or bounded search
is used in this verifier. The witness input is not trusted: every node is proved.
"""

from argparse import ArgumentParser
from fractions import Fraction
from hashlib import sha256
import json
from math import gcd, prod
from pathlib import Path


BASE = Path(__file__).resolve().parent
PRIMES = BASE / "verification/large_prime_lucas_certificate.json"
RESULT = BASE / "verification/large_prime_partition_exact.json"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def check_primes(raw):
    nodes = json.loads(raw)["nodes"]
    proved = set()
    witnesses_checked = 0
    for node in nodes:
        p = int(node["p"])
        require(p not in proved and p >= 2, "duplicate or invalid node")
        if p == 2:
            require(node == {"p": "2"}, "base node has unexpected fields")
        else:
            factors = [(int(q), int(e)) for q, e in node["factors"]]
            require(len({q for q, _ in factors}) == len(factors), "duplicate factor")
            require(all(q in proved and q < p and e > 0 for q, e in factors),
                    "unproved factor or invalid exponent")
            require(prod(q ** e for q, e in factors) == p - 1,
                    "factorization is not the full p-minus-one")
            ws = [(int(q), int(a)) for q, a in node["witnesses"]]
            require(len(ws) == len(factors) and {q for q, _ in ws} ==
                    {q for q, _ in factors}, "missing or duplicate witnesses")
            for q, a in ws:
                require(1 < a < p and pow(a, p - 1, p) == 1,
                        "failed full-power witness")
                require(gcd(pow(a, (p - 1) // q, p) - 1, p) == 1,
                        "failed prime-order witness")
                witnesses_checked += 1
        proved.add(p)
    return proved, witnesses_checked


def fraction_data(x):
    return [str(x.numerator), str(x.denominator)]


def compute():
    raw = PRIMES.read_bytes()
    proved, witness_count = check_primes(raw)
    e, f, p, q = 64, 41, 13, 3981112602195296746201614890054671463
    require(p in proved and q in proved and p != q, "endpoint primes unproved")
    M, N = 2 ** e, 3 ** f
    c, A, B = M * N, M // 2, N // 3
    Q = p * q
    require(c - 1 == p ** 2 * q, "endpoint factorization fails")
    require(gcd(c, c - 1) == 1 and gcd(c, Q) == 1, "not primitive/disjoint")
    require(e >= 2 and f >= 2, "wrong stratum")
    require(max(M, N) < 2 * min(M, N) - 1, "not balanced")
    require(A * B > Q, "scalar defect is not positive")
    require(q > max(A, B), "large-prime barrier absent")
    divisors = [1, p, q, p * q]
    require(divisors == sorted(divisors), "divisor order fails")
    require(all(not (Q <= H * B and H <= A) for H in divisors),
            "unexpected central divisor")
    R = Q // q
    require(R * B < Q and R < A and q > A, "barrier endpoints fail")
    defect = Fraction(A * B, Q)
    gap = Fraction(q, max(A, B))
    cost = Fraction(min(A, B), R)
    require(defect > 1 and gap > defect ** 52 and defect * gap == cost,
            "exact logarithmic comparison fails")
    return {
        "status": "PASS",
        "scope": "one actual balanced endpoint; complete radix and Lucas witnesses; no infinity assertion",
        "e": e, "f": f, "c": str(c), "M": str(M), "N": str(N),
        "A": str(A), "B": str(B), "Q_rad_c_minus_one": str(Q),
        "full_factorization_c_minus_one": [[str(p), 2], [str(q), 1]],
        "all_divisors_Q": [str(x) for x in divisors],
        "strict_balance_margin": str(2 * min(M, N) - 1 - max(M, N)),
        "exp_D": fraction_data(defect), "exp_Gamma": fraction_data(gap),
        "exp_optimal_boundary": fraction_data(cost),
        "Gamma_gt_52D": True,
        "prime_nodes": len(proved), "modular_gcd_witnesses": witness_count,
        "prime_certificate_sha256": sha256(raw).hexdigest(),
    }


def main():
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = compute()
    canonical = (json.dumps(result, sort_keys=True, indent=2) + "\n").encode()
    if args.check:
        require(RESULT.read_bytes() == canonical, "canonical result differs")
    else:
        RESULT.parent.mkdir(parents=True, exist_ok=True)
        RESULT.write_bytes(canonical)
    print("PASS", result["prime_nodes"], "prime nodes;",
          result["modular_gcd_witnesses"], "witnesses; canonical SHA256",
          sha256(canonical).hexdigest())


if __name__ == "__main__":
    main()
