#!/usr/bin/env sage
"""
Certified numerical gate for BDF Corollary 5.2 in K = Q(2^(1/29)).

This is not by itself a class-group-triviality certificate.  Subject to the
published BDF theorem and Sage/Arb's certified ball arithmetic and exact prime
enumeration, it proves that the positive degree-one part of the BDF
prime-ideal sum already makes all prime ideals of norm below T a generating
factor base for the full class group.

Run with:
  sage Lean/audit_scripts/p29_chebyshev_cl2_bdf_factorbase_plan.sage
"""

from sage.all import RealBallField, ZZ, power_mod, prime_range

PRECISION = 256
T = ZZ(40_000_000)
R = RealBallField(PRECISION)


def degree_one_count(q):
    """Number of degree-one primes above q in Q[x]/(x^29-2)."""
    q = ZZ(q)
    if q == 2 or q == 29:
        # x^29-2 is Eisenstein at 2; modulo 29 it is (x-2)^29.
        return ZZ(1)
    if q % 29 != 1:
        # x |-> x^29 is an automorphism of F_q^*.
        return ZZ(1)
    return ZZ(29) if power_mod(ZZ(2), (q - 1) // 29, q) == 1 else ZZ(0)


def main():
    logT = R(T).log()
    h1 = R.pi() ** 2 / 4
    h2 = R(4).log()
    gamma = R.euler_constant()
    log_delta = R(2).log() * 28 + R(29).log() * 29
    target = log_delta - 29 * (gamma + (4 * R.pi()).log()) - 1

    weighted_sum = R(0)
    distinct_degree_one_ideals = ZZ(0)
    prime_power_records = ZZ(0)
    rational_primes_used = ZZ(0)
    split_type_prime_counts = {"ramified": ZZ(0), "one_root": ZZ(0),
                               "twenty_nine_roots": ZZ(0), "no_root": ZZ(0)}
    by_m = {}

    # Every omitted higher-residue-degree prime ideal contributes positively.
    for q in prime_range(2, T):
        q = ZZ(q)
        multiplicity = degree_one_count(q)
        if q in (2, 29):
            split_type_prime_counts["ramified"] += 1
        elif q % 29 != 1:
            split_type_prime_counts["one_root"] += 1
        elif multiplicity == 29:
            split_type_prime_counts["twenty_nine_roots"] += 1
        else:
            split_type_prime_counts["no_root"] += 1
        if multiplicity == 0:
            continue

        rational_primes_used += 1
        distinct_degree_one_ideals += multiplicity
        logq = R(q).log()
        q_power = q
        m = 1
        while q_power < T:              # strict inequality from BDF
            raw = (logq / (1 + q_power)) * (1 - R(q_power).log() / logT)
            contribution = 4 * multiplicity * raw
            weighted_sum += contribution
            if m not in by_m:
                by_m[m] = {"records": ZZ(0), "ideal_power_terms": ZZ(0),
                           "contribution": R(0)}
            by_m[m]["records"] += 1
            by_m[m]["ideal_power_terms"] += multiplicity
            by_m[m]["contribution"] += contribution
            prime_power_records += multiplicity
            q_power *= q
            m += 1

    archimedean_correction = -(29 * h1 + h2) / logT
    s_lower = archimedean_correction + weighted_sum
    margin = s_lower - target

    print("BDF Corollary 5.2 degree-one lower-bound audit")
    print("precision_bits =", PRECISION)
    print("T =", T, "(all inequalities use N(p)^m < T)")
    print("target =", target)
    print("archimedean_correction =", archimedean_correction)
    print("weighted_prime_sum =", weighted_sum)
    print("S_degree_one =", s_lower)
    print("margin =", margin)
    print("margin_lower_endpoint =", margin.lower())
    print("rational_primes_used =", rational_primes_used)
    print("distinct_degree_one_prime_ideals =", distinct_degree_one_ideals)
    print("prime_ideal_power_terms_with_multiplicity =", prime_power_records)
    print("rational_prime_split_categories =", split_type_prime_counts)
    print("m_decomposition:")
    for m in sorted(by_m):
        row = by_m[m]
        print("  m=%d rational_records=%s ideal_terms=%s contribution=%s" %
              (m, row["records"], row["ideal_power_terms"], row["contribution"]))

    if margin.lower() > 0:
        print("PASS: the degree-one sub-sum alone rigorously satisfies Corollary 5.2.")
        print("P29_BDF_FACTORBASE_REALBALL_PASS")
    else:
        raise RuntimeError("FAIL/INCONCLUSIVE: the ball lower endpoint is not positive")


main()
