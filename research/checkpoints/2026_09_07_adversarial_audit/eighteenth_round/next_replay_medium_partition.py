"""Next-only exact certificates; no factorization oracle or floating logarithms."""
from argparse import ArgumentParser
from fractions import Fraction
from hashlib import sha256
import json
from math import gcd, prod
from pathlib import Path

BASE = Path(__file__).resolve().parent / "next_verification"
CERT = BASE / "medium_prime_lucas_certificate.json"
RESULT = BASE / "medium_partition_exact.json"


def require(c, msg):
    if not c:
        raise ValueError(msg)


def mul(z, w, n):
    a, b = z
    c, d = w
    return ((a*c-b*d) % n, (a*d+b*c) % n)


def power(z, k, n):
    ans = (1, 0)
    while k:
        if k & 1:
            ans = mul(ans, z, n)
        z = mul(z, z, n)
        k //= 2
    return ans


def prove_nodes(raw):
    proved = set()
    counts = {"minus": 0, "plus_gaussian": 0, "witnesses": 0}
    for node in json.loads(raw)["nodes"]:
        p = int(node["p"])
        require(p >= 2 and p not in proved, "invalid repeated node")
        kind = node["kind"]
        if kind == "base":
            require(node == {"p": "2", "kind": "base"}, "invalid base")
        else:
            require(kind in ("minus", "plus_gaussian"), "invalid criterion")
            require(p > 2 and p % 2 == 1, "odd candidate required")
            fs = [(int(q), int(e)) for q, e in node["factors"]]
            require(len({q for q, _ in fs}) == len(fs), "duplicate factor")
            require(all(q in proved and q < p and e > 0 for q, e in fs), "unproved factor")
            order = p-1 if kind == "minus" else p+1
            require(prod(q**e for q, e in fs) == order, "incomplete full factorization")
            ws = node["witnesses"]
            require(len(ws) == len(fs) and {int(w[0]) for w in ws} == {q for q, _ in fs}, "missing witness")
            for w in ws:
                q = int(w[0])
                if kind == "minus":
                    require(len(w) == 2, "bad scalar witness")
                    a = int(w[1])
                    require(1 < a < p and pow(a, order, p) == 1, "failed scalar full power")
                    require(gcd(pow(a, order//q, p)-1, p) == 1, "failed scalar order gcd")
                else:
                    require(len(w) == 3, "bad Gaussian witness")
                    a, b = int(w[1]), int(w[2])
                    require(0 <= a < p and 0 <= b < p and (a*a+b*b) % p == 1, "norm is not one")
                    require(power((a, b), order, p) == (1, 0), "failed Gaussian full power")
                    c, d = power((a, b), order//q, p)
                    require(gcd((c-1)**2+d*d, p) == 1, "failed Gaussian order gcd")
                counts["witnesses"] += 1
            counts[kind] += 1
        proved.add(p)
    return proved, counts


def frac(x):
    return [str(x.numerator), str(x.denominator)]


def endpoint(e, f, ps, proved):
    require(len(set(ps)) == len(ps) and all(p in proved for p in ps), "endpoint prime unproved")
    M, N = 2**e, 3**f
    c, A, B = M*N, M//2, N//3
    Q = prod(ps)
    require(c-1 == 7*Q and 7 in ps, "full factorization fails")
    require(gcd(c, c-1) == 1 and gcd(c, Q) == 1, "primitive/disjoint premise fails")
    require(e >= 2 and f >= 2 and max(M, N) < 2*min(M, N)-1, "stratum or balance fails")
    require(A*B > Q, "D is not positive")
    require(e % 2 == 1, "non-DP nonsquare property fails")
    ds = [1]
    prefix, lam = 1, Fraction(1)
    for p in sorted(ps):
        lam = max(lam, Fraction(p, prefix))
        prefix *= p
        ds += [d*p for d in ds]
    ds.sort()
    require(len(ds) == 2**len(ps) and len(set(ds)) == len(ds), "divisor list fails")
    require(max(Fraction(v, u) for u, v in zip(ds, ds[1:])) == lam, "exact maximum-gap law fails")
    inside = [d for d in ds if d <= A and Q <= B*d]
    D = Fraction(A*B, Q)
    if inside:
        gap = Fraction(1)
        near = [str(inside[0]), str(Q//inside[0])]
    else:
        low = max(d for d in ds if B*d < Q)
        high = min(d for d in ds if d > A)
        gap = min(Fraction(Q, B*low), Fraction(high, A))
        near = [str(low), str(high)]
    require(gap*gap <= max(Fraction(1), lam/D), "global-gap bound fails")
    return {"e": e, "f": f, "c": str(c), "A": str(A), "B": str(B), "Q": str(Q),
            "prime_support": [str(p) for p in sorted(ps)], "all_divisors": [str(d) for d in ds],
            "balance_margin": str(2*min(M, N)-1-max(M, N)), "exp_D": frac(D),
            "exp_Gamma": frac(gap), "Lambda": frac(lam), "central_divisors": [str(d) for d in inside],
            "witness_or_bracket": near}, D, gap


def compute():
    raw = CERT.read_bytes()
    proved, counts = prove_nodes(raw)
    ps = [7, 439, 857, 2729, 292183, 380261663]
    first, d1, g1 = endpoint(41, 26, ps, proved)
    require(g1 == 1 and first["central_divisors"] == ["1037734078327"], "successful partition fails")
    ps += [31, 919, 4266021703, 257077829249200341434761489003997119]
    second, d2, g2 = endpoint(123, 78, ps, proved)
    q = max(ps)
    R = int(second["Q"])//q
    require(sorted(p for p in ps if p != q)[:2] == [7, 31], "wrong two least primes")
    require(7*31*q <= R < 31**2*q and 31*q > max(int(second["A"]), int(second["B"])), "complete medium-barrier premises fail")
    require(second["witness_or_bracket"] == [str(R//31), str(31*q)], "full-divisor bracket fails")
    require(20*max(ps) < min(int(second["A"]), int(second["B"])), "medium largest prime condition fails")
    require(g2 > d2*d2 > 1 and d2 < Fraction(6, 5), "Gamma>2D or D bound fails")
    require(not second["central_divisors"], "unexpected central divisor")
    return {"status": "PASS", "scope": "Two complete actual nonsquare endpoints and elementary full primality certificates; no infinitude or ABC claim",
            "prime_nodes": len(proved), "criterion_counts": counts, "certificate_sha256": sha256(raw).hexdigest(),
            "zero_gap_endpoint": first, "medium_prime_barrier": second,
            "medium_conclusion": "20 P < min(A,B), 0<D<log(6/5)<1, Gamma>2D>0"}


def main():
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    data = compute()
    raw = (json.dumps(data, indent=2, sort_keys=True)+"\n").encode()
    if args.check:
        require(RESULT.read_bytes() == raw, "canonical result changed")
    else:
        RESULT.write_bytes(raw)
    print("PASS", data["prime_nodes"], data["criterion_counts"], "64+1024 full actual divisors", sha256(raw).hexdigest())


if __name__ == "__main__":
    main()
