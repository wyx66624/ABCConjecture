/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import Mathlib.Tactic

/-!
# Balance-sensitive reduction of the coefficient-three interface

A bound for `log(a*b*c)` with conductor coefficient three loses a factor
`3/2` if one uses only the endpoint inequality `a*b >= c/2`.  The loss is not
uniformly necessary.  Let `m = min(a,b)`.  The exact stronger inequality is

`m * c^2 <= 2 * a * b * c`,

hence

`2 log c + log m - log 2 <= log(a*b*c)`.

Therefore a coefficient-three product estimate already gives the ordinary abc
coefficient on every quantitatively balanced region in which `m` has almost
full height.  More precisely, for `epsilon > 0`, if

`log m >= (1 - epsilon/(1+epsilon)) log c - K`,

then a product estimate of coefficient `3 + epsilon` implies a height estimate
of coefficient `1 + epsilon`.

The contrapositive is the main research reduction: under a coefficient-three
product estimate, every remaining abc violation must be endpoint-shaped.  No
global product estimate or abc statement is assumed as a structure field in
this module; all theorems are pointwise implications with the hypotheses
shown explicitly.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- The smaller additive summand. -/
def minSummand (P : ABCPoint) : ℕ := min P.a P.b

@[simp]
theorem minSummand_pos (P : ABCPoint) : 0 < P.minSummand := by
  unfold minSummand
  exact lt_min P.a_pos P.b_pos

/-- The balance-sensitive integer inequality
`min(a,b) * c^2 <= 2abc`. -/
theorem minSummand_mul_c_sq_le_two_abc (P : ABCPoint) :
    P.minSummand * P.c ^ 2 ≤ 2 * (P.a * P.b * P.c) := by
  rcases le_total P.a P.b with hab | hba
  · have hc : P.c ≤ 2 * P.b := by
      rw [← P.sum_eq]
      omega
    calc
      P.minSummand * P.c ^ 2 = (P.a * P.c) * P.c := by
        rw [minSummand, min_eq_left hab]
        ring
      _ ≤ (P.a * P.c) * (2 * P.b) :=
        Nat.mul_le_mul_left (P.a * P.c) hc
      _ = 2 * (P.a * P.b * P.c) := by ring
  · have hc : P.c ≤ 2 * P.a := by
      rw [← P.sum_eq]
      omega
    calc
      P.minSummand * P.c ^ 2 = (P.b * P.c) * P.c := by
        rw [minSummand, min_eq_right hba]
        ring
      _ ≤ (P.b * P.c) * (2 * P.a) :=
        Nat.mul_le_mul_left (P.b * P.c) hc
      _ = 2 * (P.a * P.b * P.c) := by ring

/-- The exact logarithmic balance refinement of the endpoint lower bound. -/
theorem two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
    (P : ABCPoint) :
    2 * P.height + Real.log (P.minSummand : ℝ) - Real.log 2 ≤
      P.symmetricProductLog := by
  have hmpos : 0 < (P.minSummand : ℝ) := by
    exact_mod_cast P.minSummand_pos
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have habcposNat : 0 < P.a * P.b * P.c :=
    mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos
  have habcpos : 0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast habcposNat
  have hreal :
      (P.minSummand : ℝ) * (P.c : ℝ) ^ 2 ≤
        2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.minSummand_mul_c_sq_le_two_abc
  have hleftpos :
      0 < (P.minSummand : ℝ) * (P.c : ℝ) ^ 2 :=
    mul_pos hmpos (pow_pos hcpos 2)
  have hlog := Real.log_le_log hleftpos hreal
  rw [Real.log_mul hmpos.ne' (pow_pos hcpos 2).ne',
      Real.log_pow,
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) habcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold symmetricProductLog
  linarith

/-- The elementary abc conductor is nonnegative. -/
theorem conductor_nonneg (P : ABCPoint) : 0 ≤ P.conductor := by
  unfold conductor
  have hradNat : 1 ≤ abcRadical (P.a * P.b * P.c) :=
    Nat.succ_le_iff.mpr (abcRadical_pos (P.a * P.b * P.c))
  have hrad : (1 : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hradNat
  exact Real.log_nonneg hrad

/-- The amount by which the symmetric product falls below the balanced
three-height scale. -/
def balanceDefect (P : ABCPoint) : ℝ :=
  3 * P.height - P.symmetricProductLog

/-- The balance defect is controlled by the endpoint deficiency of the smaller
summand. -/
theorem balanceDefect_le_height_sub_log_minSummand_add_log_two
    (P : ABCPoint) :
    P.balanceDefect ≤
      P.height - Real.log (P.minSummand : ℝ) + Real.log 2 := by
  have hlower :=
    P.two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
  unfold balanceDefect
  linarith

end ABCPoint

namespace BalanceSensitiveSymmetricProductReduction

/-- General pointwise transfer from a product bound and a lower bound on the
smaller summand.  The denominator `3-delta` is exact. -/
theorem height_le_of_product_bound_and_minSummand_growth
    (P : ABCPoint)
    {lambda productError delta minError : ℝ}
    (hdelta : delta < 3)
    (hproduct :
      P.symmetricProductLog ≤ lambda * P.conductor + productError)
    (hmin :
      (1 - delta) * P.height - minError ≤
        Real.log (P.minSummand : ℝ)) :
    P.height ≤
      (lambda * P.conductor + productError + minError + Real.log 2) /
        (3 - delta) := by
  have hlower :=
    P.two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
  have hraw :
      (3 - delta) * P.height ≤
        lambda * P.conductor + productError + minError + Real.log 2 := by
    nlinarith
  have hden : 0 < 3 - delta := sub_pos.mpr hdelta
  apply (le_div_iff₀ hden).2
  simpa [mul_comm] using hraw

/-- With the explicit balance exponent
`1 - epsilon/(1+epsilon)`, coefficient `3+epsilon` for the symmetric product
already gives coefficient `1+epsilon` for the ordinary abc height. -/
theorem height_le_one_plus_epsilon_of_coefficient_three_and_balance
    (P : ABCPoint)
    (epsilon productError minError : ℝ)
    (hepsilon : 0 < epsilon)
    (hproductError : 0 ≤ productError)
    (hminError : 0 ≤ minError)
    (hproduct :
      P.symmetricProductLog ≤
        (3 + epsilon) * P.conductor + productError)
    (hmin :
      (1 - epsilon / (1 + epsilon)) * P.height - minError ≤
        Real.log (P.minSummand : ℝ)) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        productError + minError + Real.log 2 := by
  let delta : ℝ := epsilon / (1 + epsilon)
  let totalError : ℝ := productError + minError + Real.log 2
  have honepos : 0 < 1 + epsilon := by linarith
  have hdeltaLtOne : delta < 1 := by
    dsimp [delta]
    exact (div_lt_one honepos).2 (by linarith)
  have hden : 0 < 3 - delta := by linarith
  have hdenOne : 1 ≤ 3 - delta := by linarith
  have hlogtwo : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
  have htotalError : 0 ≤ totalError := by
    dsimp [totalError]
    linarith
  have hraw :
      (3 - delta) * P.height ≤
        (3 + epsilon) * P.conductor + totalError := by
    have hlower :=
      P.two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
    dsimp [delta, totalError] at hmin ⊢
    nlinarith
  have hcoef :
      (3 - delta) * (1 + epsilon) = 3 + 2 * epsilon := by
    dsimp [delta]
    field_simp [honepos.ne']
    ring
  have hcondScale :
      (3 + epsilon) * P.conductor ≤
        (3 + 2 * epsilon) * P.conductor := by
    apply mul_le_mul_of_nonneg_right
    · linarith
    · exact P.conductor_nonneg
  have herrorScale :
      totalError ≤ (3 - delta) * totalError := by
    have := mul_le_mul_of_nonneg_right hdenOne htotalError
    simpa using this
  have hscale :
      (3 + epsilon) * P.conductor + totalError ≤
        (3 - delta) *
          ((1 + epsilon) * P.conductor + totalError) := by
    calc
      (3 + epsilon) * P.conductor + totalError ≤
          (3 + 2 * epsilon) * P.conductor +
            (3 - delta) * totalError :=
        add_le_add hcondScale herrorScale
      _ = (3 - delta) *
          ((1 + epsilon) * P.conductor + totalError) := by
        rw [← hcoef]
        ring
  have hmul :
      (3 - delta) * P.height ≤
        (3 - delta) *
          ((1 + epsilon) * P.conductor + totalError) :=
    hraw.trans hscale
  have hfinal := (mul_le_mul_left hden).mp hmul
  simpa [totalError, add_assoc] using hfinal

/-- Contrapositive endpoint localization.  Under the product estimate, a
failure of the corresponding abc height bound forces the smaller summand below
the explicit almost-full-height threshold. -/
theorem endpoint_of_product_bound_and_abc_failure
    (P : ABCPoint)
    (epsilon productError minError : ℝ)
    (hepsilon : 0 < epsilon)
    (hproductError : 0 ≤ productError)
    (hminError : 0 ≤ minError)
    (hproduct :
      P.symmetricProductLog ≤
        (3 + epsilon) * P.conductor + productError)
    (hfailure :
      (1 + epsilon) * P.conductor +
          productError + minError + Real.log 2 < P.height) :
    Real.log (P.minSummand : ℝ) <
      (1 - epsilon / (1 + epsilon)) * P.height - minError := by
  by_contra hnot
  have hmin :
      (1 - epsilon / (1 + epsilon)) * P.height - minError ≤
        Real.log (P.minSummand : ℝ) :=
    le_of_not_gt hnot
  have hbound :=
    height_le_one_plus_epsilon_of_coefficient_three_and_balance
      P epsilon productError minError hepsilon
      hproductError hminError hproduct hmin
  linarith

#print axioms ABCPoint.minSummand_mul_c_sq_le_two_abc
#print axioms
  ABCPoint.two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
#print axioms ABCPoint.conductor_nonneg
#print axioms ABCPoint.balanceDefect_le_height_sub_log_minSummand_add_log_two
#print axioms height_le_of_product_bound_and_minSummand_growth
#print axioms height_le_one_plus_epsilon_of_coefficient_three_and_balance
#print axioms endpoint_of_product_bound_and_abc_failure

end BalanceSensitiveSymmetricProductReduction

end
end IUTThreeClosures
