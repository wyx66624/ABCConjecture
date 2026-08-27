#!/usr/bin/env sage
"""Strict T=40,000,000 BDF/RealBall scout for K=Q(2^(1/31)).

The certified BDF lower bound uses only degree-one prime ideals.  Exact
binomial splitting data are also counted to describe the complete strict
factor base, but higher-degree ideals are not added to the RealBall sum.
No principal generators, BNF, class group, regulator, or unit group are
constructed.
"""

from sage.all import GF, PolynomialRing, RealBallField, ZZ, power_mod, prime_range

PRECISION = 256
T = ZZ(40_000_000)
ELL = ZZ(31)
R = RealBallField(PRECISION)


def order_mod_31(q):
    """Multiplicative order of q modulo 31, computed exactly."""
    residue = ZZ(q) % ELL
    if residue == 0:
        raise ValueError("31 has no multiplicative order modulo 31")
    value = residue
    order = ZZ(1)
    while value != 1:
        value = (value * residue) % ELL
        order += 1
    if 30 % order != 0:
        raise ArithmeticError("computed order does not divide 30")
    return order


def splitting_degrees(q):
    """Residue degrees above q in Q[x]/(x^31-2), before the norm cutoff."""
    q = ZZ(q)
    if q in (2, 31):
        return [ZZ(1)]
    if q % 31 == 1:
        if power_mod(ZZ(2), (q - 1) // 31, q) == 1:
            return [ZZ(1)] * 31
        return [ZZ(31)]
    order = order_mod_31(q)
    return [ZZ(1)] + [order] * (30 // order)


def main():
    # Exact index guard used by the field-discriminant formula.
    index_guard = power_mod(ZZ(2), 30, ZZ(31) ** 2)
    if index_guard == 1:
        raise ArithmeticError("pure-field index guard unexpectedly failed")

    logT = R(T).log()
    h1 = R.pi() ** 2 / 4
    h2 = R(4).log()
    gamma = R.euler_constant()
    log_delta = R(2).log() * 30 + R(31).log() * 31
    target = log_delta - 31 * (gamma + (4 * R.pi()).log()) - 1

    weighted_sum = R(0)
    degree_one_ideals = ZZ(0)
    degree_one_power_terms = ZZ(0)
    rational_primes_used = ZZ(0)
    split_type_prime_counts = {
        "ramified": ZZ(0),
        "one_root": ZZ(0),
        "thirty_one_roots": ZZ(0),
        "no_root": ZZ(0),
    }
    factor_base_counts_by_degree = {}
    directly_factored_higher_degree_primes = ZZ(0)
    by_m = {}

    for q in prime_range(2, T):
        q = ZZ(q)
        degrees = splitting_degrees(q)
        included_degrees = [d for d in degrees if q ** d < T]
        if any(d > 1 for d in included_degrees):
            Fq = GF(q)
            Fqx = PolynomialRing(Fq, "x")
            x = Fqx.gen()
            factored_degrees = sorted(
                factor.degree()
                for factor, _multiplicity in (x ** 31 - 2).factor()
                if q ** factor.degree() < T
            )
            if factored_degrees != sorted(included_degrees):
                raise ArithmeticError(
                    "exact higher-degree factor mismatch at q={}".format(q)
                )
            directly_factored_higher_degree_primes += 1
        for degree in included_degrees:
            factor_base_counts_by_degree[degree] = (
                factor_base_counts_by_degree.get(degree, ZZ(0)) + 1
            )

        multiplicity = ZZ(sum(1 for degree in degrees if degree == 1))
        if q in (2, 31):
            split_type_prime_counts["ramified"] += 1
        elif q % 31 != 1:
            split_type_prime_counts["one_root"] += 1
        elif multiplicity == 31:
            split_type_prime_counts["thirty_one_roots"] += 1
        else:
            split_type_prime_counts["no_root"] += 1
        if multiplicity == 0:
            continue

        rational_primes_used += 1
        degree_one_ideals += multiplicity
        logq = R(q).log()
        q_power = q
        m = ZZ(1)
        while q_power < T:
            raw = (logq / (1 + q_power)) * (1 - R(q_power).log() / logT)
            contribution = 4 * multiplicity * raw
            weighted_sum += contribution
            if m not in by_m:
                by_m[m] = {
                    "rational_records": ZZ(0),
                    "ideal_terms": ZZ(0),
                    "contribution": R(0),
                }
            by_m[m]["rational_records"] += 1
            by_m[m]["ideal_terms"] += multiplicity
            by_m[m]["contribution"] += contribution
            degree_one_power_terms += multiplicity
            q_power *= q
            m += 1

    archimedean_correction = -(31 * h1 + h2) / logT
    s_lower = archimedean_correction + weighted_sum
    margin = s_lower - target

    print("BDF Corollary 5.2 p=31 strict T=40000000 degree-one scout")
    print("precision_bits =", PRECISION)
    print("T =", T, "(all inequalities use N(p)^m < T)")
    print("two_to_30_mod_31_squared =", index_guard)
    print("field_discriminant_abs = 2^30 * 31^31")
    print("target =", target)
    print("archimedean_correction =", archimedean_correction)
    print("weighted_prime_sum =", weighted_sum)
    print("S_degree_one =", s_lower)
    print("margin =", margin)
    print("margin_lower_endpoint =", margin.lower())
    print("margin_upper_endpoint =", margin.upper())
    print("rational_primes_used =", rational_primes_used)
    print("distinct_degree_one_prime_ideals =", degree_one_ideals)
    print("degree_one_prime_ideal_power_terms =", degree_one_power_terms)
    print("rational_prime_split_categories =", split_type_prime_counts)
    print("strict_factor_base_counts_by_residue_degree =", {
        int(degree): int(factor_base_counts_by_degree[degree])
        for degree in sorted(factor_base_counts_by_degree)
    })
    print("directly_factored_higher_degree_rational_primes =",
          directly_factored_higher_degree_primes)
    print("degree_one_power_decomposition:")
    for m in sorted(by_m):
        row = by_m[m]
        print("  m=%d rational_records=%s ideal_terms=%s contribution=%s" % (
            m, row["rational_records"], row["ideal_terms"], row["contribution"]
        ))

    if margin.lower() > 0:
        print("PASS: the degree-one sub-sum rigorously satisfies Corollary 5.2.")
        print("P31_BDF_T40000000_REALBALL_PASS")
        return
    print("FAIL/INCONCLUSIVE AT THE FIXED CUTOFF: margin is not strictly positive.")
    print("No larger cutoff was tried and no extrapolation is asserted.")
    print("P31_BDF_T40000000_REALBALL_INCONCLUSIVE")
    # This is a successful fixed-cutoff scout run, not a positive BDF gate.
    # Keep process success separate from the explicit mathematical marker.
    return


main()
