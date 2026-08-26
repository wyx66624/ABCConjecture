import Mathlib

/-!
# Scalar ledger for the Pell global truncated-counting audit

This module verifies only the real-valued bookkeeping used in the companion
paper audit.  In particular, it distinguishes the coefficient actually needed
for the Pell abc family from the much stronger assertion that the entire
powerful excess is sublinear.  It also records an abstract finite-sum estimate
and the cleared-denominator scalar step behind the corrected Yu--Chebyshev
sub-square-root cutoff.

No theorem about algebraic number fields, prime splitting, `p`-adic logarithms,
Chebyshev estimates, radicals, gcd carriers, heights, or Vojta counting
functions is formalized here or inserted as an axiom.
-/

namespace IUTThreeClosures

/-! ## Critical radical and excess coefficients -/

/-- If total logarithmic size is `2 * source` and is partitioned into radical
weight plus powerful excess, then one source-height unit of radical is exactly
equivalent to allowing one source-height unit of excess (up to `eta`). -/
theorem pellGlobal_criticalRadical_iff_excess
    (source radical excess eta : ℝ)
    (hledger : radical + excess = 2 * source) :
    (1 - eta) * source ≤ radical ↔
      excess ≤ (1 + eta) * source := by
  constructor <;> intro h <;> nlinarith

/-- The stronger hypothesis `excess ≤ eta * source` leaves almost two
source-height units of radical.  It is therefore substantially stronger than
the critical Pell abc requirement. -/
theorem pellGlobal_sublinearScale_forces_twoHeightRadical
    (source radical excess eta : ℝ)
    (hledger : radical + excess = 2 * source)
    (hstrong : excess ≤ eta * source) :
    (2 - eta) * source ≤ radical := by
  nlinarith

/-- Four target points on `P¹` have conjectural truncated coefficient
`4 - 2`; the orbit height is one half of the rational source height. -/
theorem pellGlobal_fourTargetCoefficient (source : ℝ) :
    ((4 : ℝ) - 2) * (source / 2) = source := by
  ring

/-- The untruncated degree-four divisor has two source-height units. -/
theorem pellGlobal_fourTargetFullDegree (source : ℝ) :
    (4 : ℝ) * (source / 2) = 2 * source := by
  ring

/-! ## Abstract moving-prime aggregation -/

/-- A finite family of nonnegative prime parameters bounded by `Y`, with at
most `Y` members and individual weight at most `C * ell * p`, has total weight
at most `C * ell * Y^2`.

This is a scalar aggregation lemma.  Its hypotheses are not asserted here for
the actual prime support. -/
theorem pellGlobal_finiteMovingPrime_sum_le
    {I : Type*} (S : Finset I) (p weight : I → ℝ)
    (C ell Y : ℝ)
    (hC : 0 ≤ C) (hell : 0 ≤ ell) (hY : 0 ≤ Y)
    (hp : ∀ i ∈ S, 0 ≤ p i ∧ p i ≤ Y)
    (hweight : ∀ i ∈ S, weight i ≤ C * ell * p i)
    (hcard : (S.card : ℝ) ≤ Y) :
    ∑ i ∈ S, weight i ≤ C * ell * Y ^ 2 := by
  have hCell : 0 ≤ C * ell := mul_nonneg hC hell
  have hCellY : 0 ≤ C * ell * Y := mul_nonneg hCell hY
  calc
    ∑ i ∈ S, weight i ≤ ∑ i ∈ S, C * ell * p i := by
      exact Finset.sum_le_sum fun i hi => hweight i hi
    _ ≤ ∑ _i ∈ S, C * ell * Y := by
      exact Finset.sum_le_sum fun i hi =>
        mul_le_mul_of_nonneg_left (hp i hi).2 hCell
    _ = (S.card : ℝ) * (C * ell * Y) := by simp
    _ ≤ Y * (C * ell * Y) :=
      mul_le_mul_of_nonneg_right hcard hCellY
    _ = C * ell * Y ^ 2 := by ring

/-- Cleared-denominator scalar step for the corrected sub-square-root cutoff.

Read `logN` as `log (4 * n)`, `logY` as `log Y`, and `primeSum` as
`sum_{p ≤ Y} p`.  The first two analytic inputs are abstracted as
`small ≤ CY * logN * primeSum` and
`logY * primeSum ≤ CC * Y^2`.  Near the square-root scale one has
`logN ≤ A * logY`.  If `Omega * Y^2 ≤ N`, the conclusion is the scale
`small ≤ const * N / Omega`, written without division. -/
theorem pellGlobal_yuChebyshevBelowSqrt_scalar
    (small primeSum CY CC logN logY A Omega Y N : ℝ)
    (hCY : 0 ≤ CY) (hCC : 0 ≤ CC)
    (hlogN : 0 ≤ logN) (hlogY : 0 < logY)
    (hA : 0 ≤ A) (hOmega : 0 ≤ Omega)
    (hYu : small ≤ CY * logN * primeSum)
    (hChebyshev : logY * primeSum ≤ CC * Y ^ 2)
    (hlogCompare : logN ≤ A * logY)
    (hcutoff : Omega * Y ^ 2 ≤ N) :
    Omega * small ≤ CY * CC * A * N := by
  have hCYlogN : 0 ≤ CY * logN := mul_nonneg hCY hlogN
  have hlogYsmall : logY * small ≤ logY * (CY * CC * A * Y ^ 2) := by
    calc
      logY * small ≤ logY * (CY * logN * primeSum) :=
        mul_le_mul_of_nonneg_left hYu (le_of_lt hlogY)
      _ = (CY * logN) * (logY * primeSum) := by ring
      _ ≤ (CY * logN) * (CC * Y ^ 2) :=
        mul_le_mul_of_nonneg_left hChebyshev hCYlogN
      _ = (CY * CC * Y ^ 2) * logN := by ring
      _ ≤ (CY * CC * Y ^ 2) * (A * logY) :=
        mul_le_mul_of_nonneg_left hlogCompare
          (mul_nonneg (mul_nonneg hCY hCC) (sq_nonneg Y))
      _ = logY * (CY * CC * A * Y ^ 2) := by ring
  have hsmall : small ≤ CY * CC * A * Y ^ 2 :=
    le_of_mul_le_mul_left hlogYsmall hlogY
  calc
    Omega * small ≤ Omega * (CY * CC * A * Y ^ 2) :=
      mul_le_mul_of_nonneg_left hsmall hOmega
    _ = (CY * CC * A) * (Omega * Y ^ 2) := by ring
    _ ≤ (CY * CC * A) * N := by
      exact mul_le_mul_of_nonneg_left hcutoff
        (mul_nonneg (mul_nonneg hCY hCC) hA)
    _ = CY * CC * A * N := by ring

end IUTThreeClosures
