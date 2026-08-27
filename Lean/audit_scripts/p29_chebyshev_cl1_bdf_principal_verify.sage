#!/usr/bin/env sage
"""Exact verifier for the p=29 BDF principal-factor-base certificate.

The producer may use a provisional BNF to find candidates.  This verifier
constructs no BNF, class group, regulator, or unit group.  A record describes
P=(q,beta(a)) and alpha.  It checks that gcd(x^29-2,beta) is the expected
irreducible factor h modulo q, that alpha is zero modulo h, and that
|Res(x^29-2,alpha)|=q^deg(h).  Thus (alpha) is contained in P and both ideals
have the same norm, proving (alpha)=P.

It also proves finite completeness of the strict BDF factor base by exact
prime enumeration and the splitting law for x^29-2.  For every q for which a
higher-degree factor can enter the bound, the verifier additionally factors
the polynomial over F_q and compares the exact included factor set.
"""

import gzip
import re
import sys

from sage.all import GF, PolynomialRing, ZZ, prime_range, proof


ZZX = PolynomialRing(ZZ, "x")
x = ZZX.gen()
F = x ** 29 - 2


def open_text(path):
    if path.endswith(".gz"):
        return gzip.open(path, "rt", encoding="ascii", newline="")
    return open(path, "rt", encoding="ascii", newline="")


def read_certificate(path):
    with open_text(path) as stream:
        first = stream.readline().rstrip("\n")
        if first != "#P29_BDF_PRINCIPAL_CERT_V1":
            raise ValueError("bad certificate version header")
        bound_line = stream.readline().rstrip("\n")
        prefix = "#STRICT_NORM_BOUND="
        if not bound_line.startswith(prefix):
            raise ValueError("missing strict norm bound")
        bound = ZZ(bound_line[len(prefix):])
        range_line = stream.readline().rstrip("\n")
        match = re.fullmatch(r"#RATIONAL_Q_RANGE=\[([0-9]+),([0-9]+)\)", range_line)
        if match is None:
            raise ValueError("malformed rational-prime range")
        q_lo = ZZ(match.group(1))
        q_hi = ZZ(match.group(2))
        if not (2 <= q_lo < q_hi <= bound):
            raise ValueError("invalid rational-prime range")
        expected = [
            "#POLYNOMIAL=x^29-2",
            "#FIELDS=q,f,beta_c0,...,beta_c28,alpha_c0,...,alpha_c28",
        ]
        for wanted in expected:
            got = stream.readline().rstrip("\n")
            if got != wanted:
                raise ValueError("bad certificate header: {!r}".format(got))
        yield ("HEADER", bound, q_lo, q_hi)
        for raw in stream:
            line = raw.rstrip("\n")
            if line.startswith("#"):
                yield line
                continue
            fields = line.split("\t")
            if len(fields) != 60:
                raise ValueError("record must contain q,f and 58 coefficients")
            yield tuple(ZZ(v) for v in fields)


def order_mod_29(q):
    q = int(q % 29)
    if q == 0:
        raise ValueError("29 has no multiplicative order modulo 29")
    value = q
    order = 1
    while value != 1:
        value = (value * q) % 29
        order += 1
    if 28 % order != 0:
        raise ArithmeticError("computed order does not divide 28")
    return order


def expected_degrees(q, bound):
    """Residue degrees of all prime ideals above q with strict norm < bound."""
    q = ZZ(q)
    if q in (2, 29):
        return [1]
    if q % 29 == 1:
        if pow(int(2), int((q - 1) // 29), int(q)) == 1:
            degrees = [1] * 29
        else:
            degrees = [29]
    else:
        order = order_mod_29(q)
        degrees = [1] + [order] * (28 // order)
    return sorted(d for d in degrees if q ** d < bound)


def verify_record(record, q_expected):
    q = ZZ(record[0])
    degree = ZZ(record[1])
    if q != q_expected:
        raise ArithmeticError("record ordering mismatch at q={}".format(q_expected))
    beta = ZZX(record[2:31])
    alpha = ZZX(record[31:60])

    if degree == 1:
        # This fast path covers more than 99.98% of the full factor base.  The
        # producer's degree-one prime representation must be exactly x-r
        # modulo q; then only modular Horner evaluation is needed.
        beta_coefficients = [int(c % q) for c in beta.list()]
        beta_coefficients += [0] * (29 - len(beta_coefficients))
        if beta_coefficients[1] != 1 or any(beta_coefficients[k] for k in range(2, 29)):
            raise ArithmeticError("noncanonical degree-one beta at q={}".format(q))
        r = (-beta_coefficients[0]) % int(q)
        if pow(r, 29, int(q)) != 2 % int(q):
            raise ArithmeticError("beta does not select a root at q={}".format(q))
        value_mod_q = 0
        for coefficient in reversed(alpha.list()):
            value_mod_q = (value_mod_q * r + int(coefficient)) % int(q)
        if value_mod_q != 0:
            raise ArithmeticError("alpha is not in the degree-one prime at q={}".format(q))
        h_key = ((-r) % int(q), 1)
    else:
        Fq = PolynomialRing(GF(q), "x")
        fq = Fq(F)
        h = fq.gcd(Fq(beta)).monic()
        if h.degree() != degree:
            raise ArithmeticError("wrong residue degree at q={}".format(q))
        if not h.is_irreducible():
            raise ArithmeticError("beta does not select a prime ideal at q={}".format(q))
        if Fq(alpha) % h != 0:
            raise ArithmeticError("alpha is not in (q,beta(a)) at q={}".format(q))
        h_key = tuple(ZZ(c) for c in h.list())
    resultant = F.resultant(alpha)
    if abs(resultant) != q ** degree:
        raise ArithmeticError("candidate has wrong exact norm at q={}".format(q))
    return int(degree), h_key


def main():
    proof.arithmetic(True)
    if len(sys.argv) < 2:
        raise SystemExit("usage: sage SCRIPT SHARD[.gz] [SHARD[.gz] ...]")

    # Exact power-basis hypotheses.  The same pure-field index criterion used
    # in the main p=29 audit turns this polynomial norm into the field norm.
    if not F.is_irreducible():
        raise ArithmeticError("x^29-2 unexpectedly failed irreducibility")
    if F.discriminant() != (ZZ(2) ** 28) * (ZZ(29) ** 29):
        raise ArithmeticError("unexpected polynomial discriminant")
    if pow(2, 28, 29 ** 2) != 30:
        raise ArithmeticError("unexpected 29-adic pure-field index case")
    F2 = PolynomialRing(GF(2), "u")
    F29 = PolynomialRing(GF(29), "v")
    if F2(F) != F2.gen() ** 29:
        raise ArithmeticError("unexpected factorization at the ramified prime 2")
    if F29(F) != (F29.gen() - 2) ** 29:
        raise ArithmeticError("unexpected factorization at the ramified prime 29")

    bound = None
    next_q_lo = ZZ(2)
    position = 0
    higher_degree_ideals = 0
    by_degree = {}
    previous_key = None
    shard_count = 0

    for certificate_path in sys.argv[1:]:
        items = iter(read_certificate(certificate_path))
        header = next(items, None)
        if (not isinstance(header, tuple) or len(header) != 4
                or header[0] != "HEADER"):
            raise ValueError("certificate shard did not yield its header")
        shard_bound, q_lo, q_hi = header[1:]
        if bound is None:
            bound = shard_bound
            if bound <= 2:
                raise ArithmeticError("invalid bound")
        elif shard_bound != bound:
            raise ArithmeticError("certificate shards disagree on the bound")
        if q_lo != next_q_lo:
            raise ArithmeticError("certificate shard ranges have a gap or overlap")

        shard_position = 0
        current = next(items, None)
        for q0 in prime_range(q_lo, q_hi):
            q = ZZ(q0)
            degrees = expected_degrees(q, bound)
            seen = set()
            actual_degrees = []
            for _ in degrees:
                if current is None or isinstance(current, str):
                    raise ArithmeticError("certificate ended before q={}".format(q))
                degree, key = verify_record(current, q)
                canonical_key = (q, degree, tuple(reversed(key)))
                if previous_key is not None and canonical_key <= previous_key:
                    raise ArithmeticError("records are not in canonical q/f/factor order")
                previous_key = canonical_key
                if key in seen:
                    raise ArithmeticError("duplicate prime ideal at q={}".format(q))
                seen.add(key)
                actual_degrees.append(degree)
                by_degree[degree] = by_degree.get(degree, 0) + 1
                if degree > 1:
                    higher_degree_ideals += 1
                position += 1
                shard_position += 1
                current = next(items, None)
            if sorted(actual_degrees) != degrees:
                raise ArithmeticError("wrong splitting degrees at q={}".format(q))

            # A higher-degree factor can enter only for small q.  In precisely
            # those cases, independently factor F mod q and compare the full
            # set of factors whose ideal norms satisfy the strict cutoff.
            if any(d > 1 for d in degrees):
                Fq = PolynomialRing(GF(q), "x")
                expected_factors = {
                    tuple(ZZ(c) for c in h.monic().list())
                    for h, _multiplicity in Fq(F).factor()
                    if q ** h.degree() < bound
                }
                if seen != expected_factors:
                    raise ArithmeticError(
                        "exact higher-degree factor mismatch at q={}".format(q))

        if current != "#COUNT={}".format(shard_position):
            raise ArithmeticError("missing, misplaced, or wrong shard count footer")
        current = next(items, None)
        if current != "#P29_BDF_PRINCIPAL_CERT_END":
            raise ArithmeticError("missing or misplaced certificate end footer")
        if next(items, None) is not None:
            raise ArithmeticError("trailing certificate data")
        next_q_lo = q_hi
        shard_count += 1

    if bound is None or next_q_lo != bound:
        raise ArithmeticError("certificate shards do not cover [2,bound)")

    print("STRICT_NORM_BOUND={}".format(bound))
    print("VERIFIED_SHARDS={}".format(shard_count))
    print("VERIFIED_FACTOR_BASE_IDEALS={}".format(position))
    print("VERIFIED_HIGHER_DEGREE_IDEALS={}".format(higher_degree_ideals))
    print("VERIFIED_COUNTS_BY_RESIDUE_DEGREE={}".format(dict(sorted(by_degree.items()))))
    print("NO_BNF_OR_CLASS_GROUP_USED=1")
    print("P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS")


if __name__ == "__main__":
    main()
