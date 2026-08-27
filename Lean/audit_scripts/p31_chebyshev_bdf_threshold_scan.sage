#!/usr/bin/env sage
"""Exact full and degree-one BDF scans for K=Q(2^(1/31))."""

from sage.all import GF, PolynomialRing, RealBallField, ZZ, prime_range

PRECISION = 256
THRESHOLDS = tuple(ZZ(t) for t in (40_000_000, 80_000_000, 160_000_000, 320_000_000))
MAX_T = THRESHOLDS[-1]
SEGMENT_LENGTH = ZZ(1_000_000)
ELL = ZZ(31)
R = RealBallField(PRECISION)


def order_mod_31(q):
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


def degree_one_multiplicity(q):
    q = ZZ(q)
    if q in (2, 31) or q % 31 != 1:
        return ZZ(1)
    return ZZ(31) if pow(2, int((q - 1) // 31), int(q)) == 1 else ZZ(0)


def splitting_degrees_needed(q):
    """All residue degrees whose norm might enter MAX_T."""
    q = ZZ(q)
    multiplicity_one = degree_one_multiplicity(q)
    if q in (2, 31):
        return [ZZ(1)]
    if q % 31 == 1:
        # The nonsplit factor has degree 31 and can never enter these cutoffs.
        return [ZZ(1)] * multiplicity_one
    degrees = [ZZ(1)]
    # Avoid computing the order for the millions of q for which q^2>=MAX_T.
    if q * q < MAX_T:
        order = order_mod_31(q)
        degrees.extend([order] * (30 // order))
    return [degree for degree in degrees if q ** degree < MAX_T]


def first_threshold_index(norm_power):
    for index, threshold in enumerate(THRESHOLDS):
        if norm_power < threshold:
            return index
    return None


def zero_balls():
    return [R(0) for _threshold in THRESHOLDS]


def zero_ints():
    return [ZZ(0) for _threshold in THRESHOLDS]


def add_from_bin(rows, index, value):
    if index is not None:
        rows[index] += value


def cumulative(rows):
    result = []
    total = rows[0] - rows[0]
    for value in rows:
        total += value
        result.append(total)
    return result


def main():
    if pow(2, 30, 31 ** 2) != 187:
        raise ArithmeticError("pure-field index guard failed")

    degree_one_a_bins = zero_balls()
    degree_one_b_bins = zero_balls()
    full_a_bins = zero_balls()
    full_b_bins = zero_balls()
    degree_one_ideal_bins = zero_ints()
    full_ideal_bins = zero_ints()
    degree_one_power_bins = zero_ints()
    full_power_bins = zero_ints()
    degree_counts_bins = {}
    power_counts_bins = {}
    rational_prime_bins = zero_ints()
    directly_factored_higher_degree_primes = ZZ(0)
    rational_primes_enumerated = ZZ(0)
    segments_enumerated = ZZ(0)

    low = ZZ(2)
    while low < MAX_T:
        high = min(low + SEGMENT_LENGTH, MAX_T)
        for q_raw in prime_range(low, high):
            q = ZZ(q_raw)
            rational_primes_enumerated += 1
            q_bin = first_threshold_index(q)
            add_from_bin(rational_prime_bins, q_bin, ZZ(1))

            degrees = splitting_degrees_needed(q)
            included_higher = [d for d in degrees if d > 1]
            if included_higher:
                Fq = GF(q)
                Fqx = PolynomialRing(Fq, "x")
                x = Fqx.gen()
                exact_degrees = sorted(
                    factor.degree()
                    for factor, _multiplicity in (x ** 31 - 2).factor()
                    if q ** factor.degree() < MAX_T
                )
                if exact_degrees != sorted(degrees):
                    raise ArithmeticError(
                        "exact finite-field splitting mismatch at q={}".format(q)
                    )
                directly_factored_higher_degree_primes += 1

            logq = None
            for degree in sorted(set(degrees)):
                multiplicity = ZZ(degrees.count(degree))
                norm_prime = q ** degree
                ideal_bin = first_threshold_index(norm_prime)
                add_from_bin(full_ideal_bins, ideal_bin, multiplicity)
                if degree == 1:
                    add_from_bin(degree_one_ideal_bins, ideal_bin, multiplicity)
                if degree not in degree_counts_bins:
                    degree_counts_bins[degree] = zero_ints()
                add_from_bin(degree_counts_bins[degree], ideal_bin, multiplicity)

                if logq is None:
                    logq = R(q).log()
                log_norm = degree * logq
                norm_power = norm_prime
                exponent = ZZ(1)
                while norm_power < MAX_T:
                    power_bin = first_threshold_index(norm_power)
                    denominator = R(1 + norm_power)
                    term_a = multiplicity * log_norm / denominator
                    term_b = multiplicity * exponent * log_norm * log_norm / denominator
                    add_from_bin(full_a_bins, power_bin, term_a)
                    add_from_bin(full_b_bins, power_bin, term_b)
                    add_from_bin(full_power_bins, power_bin, multiplicity)
                    key = (degree, exponent)
                    if key not in power_counts_bins:
                        power_counts_bins[key] = zero_ints()
                    add_from_bin(power_counts_bins[key], power_bin, multiplicity)
                    if degree == 1:
                        add_from_bin(degree_one_a_bins, power_bin, term_a)
                        add_from_bin(degree_one_b_bins, power_bin, term_b)
                        add_from_bin(degree_one_power_bins, power_bin, multiplicity)
                    norm_power *= norm_prime
                    exponent += 1
        segments_enumerated += 1
        print("SEGMENT_COMPLETE low={} high={} rational_primes_total={}".format(
            low, high, rational_primes_enumerated
        ))
        low = high

    degree_one_a = cumulative(degree_one_a_bins)
    degree_one_b = cumulative(degree_one_b_bins)
    full_a = cumulative(full_a_bins)
    full_b = cumulative(full_b_bins)
    degree_one_ideals = cumulative(degree_one_ideal_bins)
    full_ideals = cumulative(full_ideal_bins)
    degree_one_powers = cumulative(degree_one_power_bins)
    full_powers = cumulative(full_power_bins)
    rational_primes = cumulative(rational_prime_bins)
    degree_counts = {key: cumulative(value) for key, value in degree_counts_bins.items()}
    power_counts = {key: cumulative(value) for key, value in power_counts_bins.items()}

    h1 = R.pi() ** 2 / 4
    h2 = R(4).log()
    gamma = R.euler_constant()
    log_delta = R(2).log() * 30 + R(31).log() * 31

    print("P31 BDF Corollary 5.2 exact threshold scan")
    print("precision_bits =", PRECISION)
    print("thresholds =", THRESHOLDS)
    print("segment_length =", SEGMENT_LENGTH)
    print("segments_enumerated =", segments_enumerated)
    print("rational_primes_enumerated =", rational_primes_enumerated)
    print("directly_factored_higher_degree_rational_primes =",
          directly_factored_higher_degree_primes)
    print("two_to_30_mod_31_squared = 187")
    print("field_discriminant_abs = 2^30 * 31^31")

    first_degree_one_pass = None
    first_full_pass = None
    for index, threshold in enumerate(THRESHOLDS):
        log_t = R(threshold).log()
        target = log_delta - 31 * (gamma + (4 * R.pi()).log()) - 1
        arch = -(31 * h1 + h2) / log_t
        weighted_degree_one = 4 * (degree_one_a[index] - degree_one_b[index] / log_t)
        weighted_full = 4 * (full_a[index] - full_b[index] / log_t)
        s_degree_one = arch + weighted_degree_one
        s_full = arch + weighted_full
        margin_degree_one = s_degree_one - target
        margin_full = s_full - target
        by_degree = {
            int(degree): int(rows[index])
            for degree, rows in sorted(degree_counts.items())
            if rows[index]
        }
        by_degree_power = {
            "f{}_m{}".format(degree, exponent): int(rows[index])
            for (degree, exponent), rows in sorted(power_counts.items())
            if rows[index]
        }
        print("THRESHOLD_BEGIN", threshold)
        print("target =", target)
        print("archimedean_correction =", arch)
        print("weighted_degree_one_sum =", weighted_degree_one)
        print("S_degree_one =", s_degree_one)
        print("degree_one_margin =", margin_degree_one)
        print("degree_one_margin_lower_endpoint =", margin_degree_one.lower())
        print("degree_one_margin_upper_endpoint =", margin_degree_one.upper())
        print("weighted_full_prime_ideal_sum =", weighted_full)
        print("S_full =", s_full)
        print("full_margin =", margin_full)
        print("full_margin_lower_endpoint =", margin_full.lower())
        print("full_margin_upper_endpoint =", margin_full.upper())
        print("rational_primes_below_threshold =", rational_primes[index])
        print("degree_one_prime_ideals =", degree_one_ideals[index])
        print("full_prime_ideals =", full_ideals[index])
        print("degree_one_prime_power_terms =", degree_one_powers[index])
        print("full_prime_ideal_power_terms =", full_powers[index])
        print("prime_ideal_counts_by_residue_degree =", by_degree)
        print("prime_ideal_power_counts_by_degree_and_exponent =", by_degree_power)
        if margin_degree_one.lower() > 0:
            print("DEGREE_ONE_RESULT=PASS")
            if first_degree_one_pass is None:
                first_degree_one_pass = threshold
        elif margin_degree_one.upper() < 0:
            print("DEGREE_ONE_RESULT=STRICT_NEGATIVE")
        else:
            print("DEGREE_ONE_RESULT=INTERVAL_INCONCLUSIVE")
        if margin_full.lower() > 0:
            print("FULL_BDF_RESULT=PASS")
            if first_full_pass is None:
                first_full_pass = threshold
        elif margin_full.upper() < 0:
            print("FULL_BDF_RESULT=STRICT_NEGATIVE")
        else:
            print("FULL_BDF_RESULT=INTERVAL_INCONCLUSIVE")
        print("THRESHOLD_END", threshold)

    print("FIRST_SCANNED_DEGREE_ONE_PASS =", first_degree_one_pass)
    print("FIRST_SCANNED_FULL_BDF_PASS =", first_full_pass)
    print("NO_PRINCIPAL_WITNESSES_CONSTRUCTED=1")
    print("P31_BDF_THRESHOLD_SCAN_COMPLETE")


main()
