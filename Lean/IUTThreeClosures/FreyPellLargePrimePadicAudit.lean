import Mathlib

/-!
# Scalar ledger for the shifted large-prime Pell audit

This module checks only the scalar bookkeeping in
`FREY_PELL_LARGE_PRIME_PADIC_AUDIT.md`:

* the sign condition behind the Bilu--Hong--Gun cutoff;
* an abstract two-range aggregation and cutoff substitution;
* the excess carried by a balanced pair of isolated cubes, one in each Pell
  factor; and
* the corresponding identity for a balanced pair of general prime-power
  carriers.

It does not formalize or assume a theorem about `p`-adic logarithms, prime
splitting, prime sums, algebraic heights, the Pell sequence, or its radical.
-/

namespace IUTThreeClosures

/-! ## Scalar cutoff ledger -/

/-- The numerical exponent in the shifted Bilu--Hong--Gun estimate for the
degree-four split Pell field is `0.0005`, and one quarter of it is the cutoff
constant `1 / 8000`. -/
theorem pellLargePrime_bhgCutoffConstant :
    (0.0005 : ℝ) / 4 = 1 / 8000 := by
  norm_num

/-- The strict inequality used after choosing a splitting exponent `theta`.
Analytically, `a` is the local exponential-saving constant and `kappa` is the
growth constant in the cutoff. -/
theorem pellLargePrime_savedExponent_negative
    (a kappa theta : ℝ)
    (hstrict : 4 * kappa < a * theta) :
    2 * kappa - a * theta / 2 < 0 := by
  linarith

/-- Abstract scalar form of the two-range cutoff argument.

Read `low` as the contribution from primes at most `Y^theta`, `growth^2` as
the square of the factor beyond `sqrt N`, and `saving` as the exponential
decay on the upper range.  The analytic estimates themselves are hypotheses;
this theorem checks their final substitution without importing them as
number-theoretic axioms. -/
theorem pellLargePrime_twoRangeCutoff_scalar
    (small low N growth saving logFactor epsilon : ℝ)
    (hN : 0 ≤ N)
    (hsmall :
      small ≤ logFactor * (low + N * growth ^ 2 * saving))
    (hlow : logFactor * low ≤ epsilon * N)
    (hsaved : logFactor * growth ^ 2 * saving ≤ epsilon) :
    small ≤ 2 * epsilon * N := by
  calc
    small ≤ logFactor * (low + N * growth ^ 2 * saving) := hsmall
    _ = logFactor * low +
        N * (logFactor * growth ^ 2 * saving) := by ring
    _ ≤ epsilon * N + N * epsilon := by
      gcongr
    _ = 2 * epsilon * N := by ring

/-! ## Balanced isolated prime-power carriers -/

/-- If two distinct abstract cubes each carry one Pell factor's logarithmic
mass `source`, their combined powerful excess is exactly `4/3` of one
source-height unit.  This preserves the separate `b`/`c` height budget. -/
theorem pellLargePrime_balancedCubePair_excess
    (source leftPrimeLog rightPrimeLog : ℝ)
    (hleft : 3 * leftPrimeLog = source)
    (hright : 3 * rightPrimeLog = source) :
    (3 - 1) * leftPrimeLog + (3 - 1) * rightPrimeLog =
      (4 / 3 : ℝ) * source := by
  nlinarith

/-- A positive balanced pair of isolated cubes exceeds the critical allowance
of one source-height unit. -/
theorem pellLargePrime_balancedCubePair_breaksCriticalCoefficient
    (source leftPrimeLog rightPrimeLog : ℝ)
    (hsource : 0 < source)
    (hleft : 3 * leftPrimeLog = source)
    (hright : 3 * rightPrimeLog = source) :
    source < (3 - 1) * leftPrimeLog + (3 - 1) * rightPrimeLog := by
  rw [pellLargePrime_balancedCubePair_excess source leftPrimeLog rightPrimeLog
    hleft hright]
  linarith

/-- General balanced profile: if one `k`-th-power carrier lies in each Pell
factor and each has mass `source`, their combined excess is
`2 * (1 - 1/k)` source-height units. -/
theorem pellLargePrime_balancedPowerPair_excess
    (k source leftPrimeLog rightPrimeLog : ℝ)
    (hk : k ≠ 0)
    (hleft : k * leftPrimeLog = source)
    (hright : k * rightPrimeLog = source) :
    (k - 1) * leftPrimeLog + (k - 1) * rightPrimeLog =
      (2 * (k - 1) / k) * source := by
  calc
    (k - 1) * leftPrimeLog + (k - 1) * rightPrimeLog =
        ((k - 1) / k) *
          (k * leftPrimeLog + k * rightPrimeLog) := by
      field_simp [hk]
    _ = ((k - 1) / k) * (source + source) := by rw [hleft, hright]
    _ = (2 * (k - 1) / k) * source := by ring

end IUTThreeClosures
