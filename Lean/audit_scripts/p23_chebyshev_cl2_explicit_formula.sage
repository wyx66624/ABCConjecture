#!/usr/bin/env sage
"""Rigorous unconditional explicit-formula gate for the p=23 field.

This script uses only certified real balls / real intervals for every
transcendental quantity.  It implements Brueggeman--Doud, Theorem 2.4(1),
for a hypothetical quadratic extension E/K which is unramified at every
finite prime and split at the real place of K = Q(a), a^23 = 2.

The prime correction is deliberately truncated: j = 1,...,100 for q <= 100
and j = 1 for q > 100.  Every omitted term is nonnegative, so the result is
still an unconditional lower bound.
"""

from sage.all import (
    QQ,
    RealBallField,
    RealIntervalField,
    prime_range,
    proof,
)


PRECISION_BITS = 256
DEGREE_E = 46
REAL_PLACES_E = 2
S = QQ(1419) / 10000              # S = sqrt(y) in Theorem 2.4.
TAIL_X = 32
INTERVAL_PANELS = 128000          # panel width = 1/4000.
HIGHER_J_PRIME_MAX = 100
HIGHER_J_MAX = 100
SEARCH_MAX = 9_100_000
REQUIRED_LOG_MARGIN = QQ(1) / 500 # 0.002, fixed before the search.

# Filled with the first cutoff found by the certified search.  Keeping this
# literal in the final package makes the generator and verifier independent of
# a floating-point threshold computation.
CERTIFICATE_BOUND = 8_928_769


RBF = RealBallField(PRECISION_BITS)
RIF = RealIntervalField(PRECISION_BITS)


def degree_one_count(q):
    """Number of roots of X^23-2 in F_q, including q=2,23."""
    if q == 23:
        return 1
    if (q - 1) % 23 != 0:
        return 1
    return 23 if pow(2, (q - 1) // 23, q) == 1 else 0


def tartar_f_ball(t):
    """Certified ball for [3(sin(t)-t*cos(t))/t^3]^2, t != 0."""
    h = 3 * (t.sin() - t * t.cos()) / (t ** 3)
    return h ** 2


def integral_upper_bounds():
    r"""Certified upper bounds for the two integrals I_1 and I_2.

    We use the global inequalities

        0 <= 1-f(t) <= min(1,t^2/5).

    On each positive interval a direct MPFI enclosure is intersected with
    those two analytic upper bounds.  The first panel is handled analytically
    to avoid division by sinh(0).  For x >= TAIL_X, 1-f <= 1 gives the exact
    tail majorants 1-tanh(TAIL_X/2) and -log(tanh(TAIL_X/2)).
    """
    s = RIF(S)
    width_q = QQ(TAIL_X) / INTERVAL_PANELS
    width = RIF(width_q)

    # First panel [0,width].  Use sinh(x)>=x and 2*cosh(x/2)^2>=2.
    i1 = s * s * width ** 3 / 30
    i2 = s * s * width ** 2 / 10

    one_upper = RIF(1).upper()
    for k in range(1, INTERVAL_PANELS):
        x = RIF(k * width_q, (k + 1) * width_q)
        t = s * x
        h = 3 * (t.sin() - t * t.cos()) / (t ** 3)
        raw_u = 1 - h ** 2

        t2_over_5_upper = ((s * RIF(x.upper())) ** 2 / 5).upper()
        u_upper = min(one_upper, t2_over_5_upper, raw_u.upper())
        if u_upper < 0:
            raise ArithmeticError("interval enclosure contradicted 1-f >= 0")

        d1_upper = (1 / (2 * (x / 2).cosh() ** 2)).upper()
        d2_upper = (1 / x.sinh()).upper()
        i1 += width * RIF(u_upper) * RIF(d1_upper)
        i2 += width * RIF(u_upper) * RIF(d2_upper)

    half_tail = RIF(TAIL_X) / 2
    i1 += RIF((1 - half_tail.tanh()).upper())
    i2 += RIF((-half_tail.tanh().log()).upper())
    return i1.upper(), i2.upper()


def normalized_prime_correction(q, multiplicity):
    """A certified lower-enclosing ball for the retained correction terms.

    Each degree-one K-prime splits into two E-primes.  Thus Theorem 2.4's
    factor 4 becomes 8 after division by [E:Q]=46.
    """
    q_ball = RBF(q)
    log_q = q_ball.log()
    j_max = HIGHER_J_MAX if q <= HIGHER_J_PRIME_MAX else 1
    ans = RBF(0)
    for j in range(1, j_max + 1):
        t = RBF(S) * j * log_q
        f_value = tartar_f_ball(t)
        ans += (
            RBF(8 * multiplicity)
            * log_q
            * f_value
            / (RBF(DEGREE_E) * RBF(1 + q ** j))
        )
    return ans


def main():
    proof.arithmetic(True)
    i1_upper, i2_upper = integral_upper_bounds()

    s = RBF(S)
    base = (
        RBF.euler_constant()
        + (RBF(4) * RBF.pi()).log()
        + RBF(REAL_PLACES_E) / DEGREE_E
        - (RBF(REAL_PLACES_E) / DEGREE_E) * RBF(i1_upper)
        - RBF(i2_upper)
        - RBF(12) * RBF.pi() / (RBF(5 * DEGREE_E) * s)
    )
    target = RBF(23).log() + (RBF(22) / 23) * RBF(2).log()

    correction = RBF(0)
    ideal_count = 0
    first_positive = None
    first_safe = None
    first_positive_count = None
    first_safe_count = None
    certificate_margin = None
    certificate_count = None

    for q_integer in prime_range(2, SEARCH_MAX + 1):
        q = int(q_integer)
        multiplicity = degree_one_count(q)
        if multiplicity:
            ideal_count += multiplicity
            correction += normalized_prime_correction(q, multiplicity)

        margin = base + correction - target
        if first_positive is None and margin.lower() > 0:
            first_positive = q
            first_positive_count = ideal_count
        if first_safe is None and margin.lower() > RBF(REQUIRED_LOG_MARGIN).upper():
            first_safe = q
            first_safe_count = ideal_count

        if CERTIFICATE_BOUND and q <= CERTIFICATE_BOUND:
            certificate_margin = margin
            certificate_count = ideal_count

    if first_positive is None or first_safe is None:
        raise ArithmeticError("SEARCH_MAX did not reach the requested margin")

    print("FORMULA=BRUEGGEMAN_DOUD_THEOREM_2_4_1_UNCONDITIONAL")
    print("PRECISION_BITS={}".format(PRECISION_BITS))
    print("DEGREE_E={}".format(DEGREE_E))
    print("REAL_PLACES_E={}".format(REAL_PLACES_E))
    print("S={}".format(S))
    print("TAIL_X={}".format(TAIL_X))
    print("INTERVAL_PANELS={}".format(INTERVAL_PANELS))
    print("I1_UPPER={}".format(i1_upper))
    print("I2_UPPER={}".format(i2_upper))
    print("TARGET_LOG_RD={}".format(target))
    print("TARGET_RD={}".format(target.exp()))
    print("FIRST_POSITIVE_BOUND={}".format(first_positive))
    print("FIRST_POSITIVE_IDEALS={}".format(first_positive_count))
    print("REQUIRED_LOG_MARGIN={}".format(REQUIRED_LOG_MARGIN))
    print("FIRST_SAFE_BOUND={}".format(first_safe))
    print("FIRST_SAFE_IDEALS={}".format(first_safe_count))

    if CERTIFICATE_BOUND == 0:
        print("SET_CERTIFICATE_BOUND={}".format(first_safe))
        return
    if CERTIFICATE_BOUND != first_safe:
        raise ArithmeticError(
            "frozen CERTIFICATE_BOUND is not the first certified safe cutoff: "
            "{} != {}".format(CERTIFICATE_BOUND, first_safe)
        )
    if certificate_margin is None:
        raise ArithmeticError("certificate bound was not visited")
    if certificate_margin.lower() <= RBF(REQUIRED_LOG_MARGIN).upper():
        raise ArithmeticError("certificate margin gate failed")

    lower_log_rd = target + certificate_margin
    print("CERTIFICATE_BOUND={}".format(CERTIFICATE_BOUND))
    print("CERTIFICATE_IDEALS={}".format(certificate_count))
    print("CERTIFICATE_LOG_MARGIN={}".format(certificate_margin))
    print("LOWER_LOG_RD={}".format(lower_log_rd))
    print("LOWER_RD={}".format(lower_log_rd.exp()))
    print("P23_CL2_EXPLICIT_FORMULA_PASS")


if __name__ == "__main__":
    main()
