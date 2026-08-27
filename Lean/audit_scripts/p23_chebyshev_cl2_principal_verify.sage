#!/usr/bin/env sage
"""Independent exact verifier for the p=23 principal-prime certificate.

No bnf, class group, regulator, units, GRH bound, or heuristic class-number
data is constructed or consulted here.  For every record (q,r,c_0,...,c_22)
the verifier checks primality/completeness, the simple root r of X^23-2,
membership G(r)=0 mod q, and the exact integer resultant Res(F,G)=+/-q.
"""

import gzip
import sys

from sage.all import GF, PolynomialRing, ZZ, prime_range, proof


BOUND = 8_928_769
EXPECTED_RECORDS = 598_490       # excludes the separately treated q=2,23
CERTIFICATE_NAME = "p23_chebyshev_cl2_principal_generators.tsv.gz"

ZZX = PolynomialRing(ZZ, "x")
x = ZZX.gen()
F = x ** 23 - 2


def degree_one_count(q):
    """Exact number of simple roots of X^23-2 over F_q, q != 2,23."""
    if (q - 1) % 23 != 0:
        return 1
    return 23 if pow(2, (q - 1) // 23, q) == 1 else 0


def read_certificate(path):
    with gzip.open(path, "rt", encoding="ascii", newline="") as stream:
        expected_header = [
            "#P23_CL2_PRINCIPAL_CERT_V1",
            "#BOUND={}".format(BOUND),
            "#POLYNOMIAL=x^23-2",
            "#FIELDS=q,r,c0,...,c22",
        ]
        for expected in expected_header:
            got = stream.readline().rstrip("\n")
            if got != expected:
                raise ValueError("bad certificate header: {!r} != {!r}".format(got, expected))

        for line in stream:
            line = line.rstrip("\n")
            if line.startswith("#"):
                yield line
                continue
            fields = line.split("\t")
            if len(fields) != 25:
                raise ValueError("record does not have q,r and 23 coefficients")
            yield tuple(ZZ(v) for v in fields)


def verify_record(record, expected_q, seen_roots):
    q = int(record[0])
    r = int(record[1])
    coefficients = list(record[2:])

    # expected_q comes from Sage's exact prime sieve, so matching it is an
    # explicit deterministic primality check as well as an ordering check.
    if q != expected_q:
        raise ArithmeticError("unexpected rational prime {} (expected {})".format(q, expected_q))
    if not (0 <= r < q):
        raise ArithmeticError("noncanonical residue representative at q={}".format(q))
    if r in seen_roots:
        raise ArithmeticError("duplicate residue root at q={}".format(q))
    seen_roots.add(r)

    if pow(r, 23, q) != 2 % q:
        raise ArithmeticError("r^23 != 2 mod q at q={}".format(q))
    if (23 * pow(r, 22, q)) % q == 0:
        raise ArithmeticError("residue root is not simple at q={}".format(q))

    value_mod_q = 0
    for coefficient in reversed(coefficients):
        value_mod_q = (value_mod_q * r + int(coefficient)) % q
    if value_mod_q != 0:
        raise ArithmeticError("G(r) != 0 mod q at q={}".format(q))

    G = ZZX(coefficients)
    resultant = F.resultant(G)
    if abs(resultant) != q:
        raise ArithmeticError("abs(Res(F,G)) != q at q={}".format(q))


def main():
    proof.arithmetic(True)
    # Exact hypotheses for the power-basis interpretation.  The polynomial
    # discriminant has no prime divisor other than 2 and 23.  Dedekind's index
    # criterion gives M=-1 at 2.  At 23 the repeated factor is x-2 and
    # M(2)=(2^23-2)/23=11 (mod 23), certified by the two checks below.
    if F.discriminant() != -(ZZ(2) ** 22) * (ZZ(23) ** 23):
        raise ArithmeticError("unexpected polynomial discriminant")
    if pow(2, 22, 23 ** 2) != 392:
        raise ArithmeticError("failed the exact 23-adic index input")
    if ((ZZ(2) ** 23 - 2) // 23) % 23 != 11:
        raise ArithmeticError("Dedekind index criterion failed at 23")

    if len(sys.argv) != 2:
        raise SystemExit("usage: sage p23_chebyshev_cl2_principal_verify.sage CERT.gz")
    certificate_path = sys.argv[1]
    items = iter(read_certificate(certificate_path))
    current = next(items, None)
    total = 0

    for q_integer in prime_range(3, BOUND + 1):
        q = int(q_integer)
        if q == 23:
            continue
        expected = degree_one_count(q)
        seen_roots = set()
        for _ in range(expected):
            if current is None or isinstance(current, str):
                raise ArithmeticError("certificate ended before q={}".format(q))
            verify_record(current, q, seen_roots)
            total += 1
            current = next(items, None)
        if len(seen_roots) != expected:
            raise ArithmeticError("wrong root count at q={}".format(q))

    if current != "#COUNT={}".format(EXPECTED_RECORDS):
        raise ArithmeticError("missing or wrong certificate count footer")
    current = next(items, None)
    if current != "#P23_CL2_PRINCIPAL_CERT_END":
        raise ArithmeticError("missing certificate end marker")
    if next(items, None) is not None:
        raise ArithmeticError("trailing certificate data")
    if total != EXPECTED_RECORDS:
        raise ArithmeticError("verified record count mismatch")

    print("BOUND={}".format(BOUND))
    print("VERIFIED_RECORDS={}".format(total))
    print("RAMIFIED_PRIMES_TREATED_SEPARATELY=2,23")
    print("POWER_BASIS_DEDEKIND_INDEX_CHECK=1")
    print("NO_BNF_OR_CLASS_GROUP_USED=1")
    print("P23_CL2_PRINCIPAL_EXACT_VERIFY_PASS")


if __name__ == "__main__":
    main()
