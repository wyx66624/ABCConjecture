/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Quadratic-twist masking in Szpiro inequalities

At primes where the clean quadratic-twist formulas apply, logarithmic
minimal-discriminant and conductor contributions transform as

`discLog |-> discLog + 6 * twistLog`,
`condLog |-> condLog + 2 * twistLog`.

This file isolates the exact algebraic consequence.  For a proposed Szpiro
exponent `q`, a bound on the twist is equivalent to allowing the original
curve's `q`-excess to be absorbed by

`(2*q - 6) * twistLog`.

Thus:

* at `q = 3`, the twist contribution cancels exactly;
* below `3`, a nonnegative twist cannot hide a bad base curve;
* above `3`, a large twist can absorb base excess, so a statistical theorem on
  large twists yields a base-curve theorem only when the size of a good twist
  is controlled uniformly.

The module formalizes only this real-algebra calculation.  It does not assert
that the clean local formulas hold without correction at every prime, nor does
it assume any statistical Szpiro theorem.
-/

namespace IUTThreeClosures
namespace QuadraticTwistSzpiroMasking

/-- Idealized logarithmic discriminant after a clean squarefree quadratic
twist. -/
def twistDiscriminantLog (discLog twistLog : ℝ) : ℝ :=
  discLog + 6 * twistLog

/-- Idealized logarithmic conductor after a clean squarefree quadratic twist. -/
def twistConductorLog (condLog twistLog : ℝ) : ℝ :=
  condLog + 2 * twistLog

/-- Excess of the base curve over the affine Szpiro bound with exponent `q`
and additive constant `C`. -/
def szpiroExcess
    (discLog condLog q C : ℝ) : ℝ :=
  discLog - q * condLog - C

/-- Exact masking identity: a twist satisfies the affine `q`-Szpiro bound iff
the base excess is at most the twist masking budget `(2*q-6)*twistLog`. -/
theorem twist_bound_iff_excess_le_mask
    {discLog condLog q C twistLog : ℝ} :
    twistDiscriminantLog discLog twistLog ≤
        q * twistConductorLog condLog twistLog + C ↔
      szpiroExcess discLog condLog q C ≤
        (2 * q - 6) * twistLog := by
  unfold twistDiscriminantLog twistConductorLog szpiroExcess
  constructor <;> intro h <;> linarith

/-- The critical exponent `q=3` is exactly twist-invariant in the clean model. -/
theorem critical_three_twist_bound_iff
    {discLog condLog C twistLog : ℝ} :
    twistDiscriminantLog discLog twistLog ≤
        3 * twistConductorLog condLog twistLog + C ↔
      discLog ≤ 3 * condLog + C := by
  unfold twistDiscriminantLog twistConductorLog
  constructor <;> intro h <;> linarith

/-- For exponents at most three, a nonnegative clean twist cannot turn a bad
base curve into a good one. -/
theorem base_bound_of_twist_bound_of_q_le_three
    {discLog condLog q C twistLog : ℝ}
    (hq : q ≤ 3)
    (htwist : 0 ≤ twistLog)
    (hgood :
      twistDiscriminantLog discLog twistLog ≤
        q * twistConductorLog condLog twistLog + C) :
    discLog ≤ q * condLog + C := by
  have hmask :=
    (twist_bound_iff_excess_le_mask).1 hgood
  have hcoef : 2 * q - 6 ≤ 0 := by linarith
  have hnonpos : (2 * q - 6) * twistLog ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg hcoef htwist
  unfold szpiroExcess at hmask
  linarith

/-- Above exponent three, every good twist must have logarithmic size at least
the base excess divided by the positive masking coefficient. -/
theorem twistLog_ge_excess_ratio_of_twist_bound
    {discLog condLog q C twistLog : ℝ}
    (hq : 3 < q)
    (hgood :
      twistDiscriminantLog discLog twistLog ≤
        q * twistConductorLog condLog twistLog + C) :
    szpiroExcess discLog condLog q C / (2 * q - 6) ≤
      twistLog := by
  have hcoef : 0 < 2 * q - 6 := by linarith
  have hmask :=
    (twist_bound_iff_excess_le_mask).1 hgood
  apply (div_le_iff₀ hcoef).2
  simpa [mul_comm] using hmask

/-- Conversely, once the twist scale reaches the excess-ratio threshold, the
clean twisted curve satisfies the affine `q`-bound. -/
theorem twist_bound_of_excess_ratio_le_twistLog
    {discLog condLog q C twistLog : ℝ}
    (hq : 3 < q)
    (hscale :
      szpiroExcess discLog condLog q C / (2 * q - 6) ≤
        twistLog) :
    twistDiscriminantLog discLog twistLog ≤
      q * twistConductorLog condLog twistLog + C := by
  have hcoef : 0 < 2 * q - 6 := by linarith
  apply (twist_bound_iff_excess_le_mask).2
  exact (div_le_iff₀ hcoef).1 hscale

/-- A bounded twist fibre contains a good twist exactly when its maximum scale
can absorb the whole base excess.  This packages the no-free-amplification
statement: searching all twists up to `maxTwistLog` adds no algebraic capacity
beyond `(2*q-6)*maxTwistLog`. -/
theorem exists_good_twist_up_to_iff_excess_le_capacity
    {discLog condLog q C maxTwistLog : ℝ}
    (hq : 3 < q)
    (hmax : 0 ≤ maxTwistLog) :
    (∃ twistLog : ℝ,
      0 ≤ twistLog ∧
      twistLog ≤ maxTwistLog ∧
      twistDiscriminantLog discLog twistLog ≤
        q * twistConductorLog condLog twistLog + C) ↔
      szpiroExcess discLog condLog q C ≤
        (2 * q - 6) * maxTwistLog := by
  have hcoef : 0 ≤ 2 * q - 6 := by linarith
  constructor
  · rintro ⟨twistLog, htwist, hle, hgood⟩
    have hmask :=
      (twist_bound_iff_excess_le_mask).1 hgood
    exact le_trans hmask
      (mul_le_mul_of_nonneg_left hle hcoef)
  · intro hcapacity
    refine ⟨maxTwistLog, hmax, le_rfl, ?_⟩
    exact (twist_bound_iff_excess_le_mask).2 hcapacity

/-- At exponent three, the existence of any nonnegative good twist in a
nonempty bounded interval is equivalent to the base bound itself. -/
theorem exists_critical_three_good_twist_iff_base_bound
    {discLog condLog C maxTwistLog : ℝ}
    (hmax : 0 ≤ maxTwistLog) :
    (∃ twistLog : ℝ,
      0 ≤ twistLog ∧
      twistLog ≤ maxTwistLog ∧
      twistDiscriminantLog discLog twistLog ≤
        3 * twistConductorLog condLog twistLog + C) ↔
      discLog ≤ 3 * condLog + C := by
  constructor
  · rintro ⟨twistLog, htwist, hle, hgood⟩
    exact (critical_three_twist_bound_iff).1 hgood
  · intro hbase
    refine ⟨0, le_rfl, hmax, ?_⟩
    exact (critical_three_twist_bound_iff).2 hbase

/-- A good twist whose logarithmic size is bounded by `eta * height` transfers
to the base curve with exactly the residual slope
`(2*q-6)*eta`. -/
theorem base_bound_of_small_good_twist
    {discLog condLog q C twistLog eta height : ℝ}
    (hq : 3 ≤ q)
    (hscale : twistLog ≤ eta * height)
    (hgood :
      twistDiscriminantLog discLog twistLog ≤
        q * twistConductorLog condLog twistLog + C) :
    discLog ≤
      q * condLog + C + (2 * q - 6) * eta * height := by
  have hcoef : 0 ≤ 2 * q - 6 := by linarith
  have hmask :=
    (twist_bound_iff_excess_le_mask).1 hgood
  have hmul :
      (2 * q - 6) * twistLog ≤
        (2 * q - 6) * (eta * height) :=
    mul_le_mul_of_nonneg_left hscale hcoef
  unfold szpiroExcess at hmask
  linarith

/-- At exponent `3+epsilon`, the masking coefficient is exactly `2*epsilon`. -/
theorem maskingCoefficient_three_add
    (epsilon : ℝ) :
    2 * (3 + epsilon) - 6 = 2 * epsilon := by
  ring

/-- At the classical Szpiro exponent `6+epsilon`, the masking coefficient is
`6+2*epsilon`; large twists therefore introduce a substantial residual term. -/
theorem maskingCoefficient_six_add
    (epsilon : ℝ) :
    2 * (6 + epsilon) - 6 = 6 + 2 * epsilon := by
  ring

#print axioms twist_bound_iff_excess_le_mask
#print axioms critical_three_twist_bound_iff
#print axioms base_bound_of_twist_bound_of_q_le_three
#print axioms twistLog_ge_excess_ratio_of_twist_bound
#print axioms twist_bound_of_excess_ratio_le_twistLog
#print axioms exists_good_twist_up_to_iff_excess_le_capacity
#print axioms exists_critical_three_good_twist_iff_base_bound
#print axioms base_bound_of_small_good_twist
#print axioms maskingCoefficient_three_add
#print axioms maskingCoefficient_six_add

end QuadraticTwistSzpiroMasking
end IUTThreeClosures
