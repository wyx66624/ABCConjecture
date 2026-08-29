/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCPointLegendreCurve
import Mathlib.Tactic

/-!
# Symmetric-product coefficient barriers for abc inequalities

Several IUT-derived or effective-abc statements naturally control
`log(a*b*c)` rather than the standard height `log c`.  For a positive abc
triple, the universal endpoint estimate is

`2 * log c - log 2 <= log(a*b*c)`.

Consequently a symmetric-product estimate with conductor coefficient `lambda`
transfers, without additional balance information, to height coefficient
`lambda / 2`.  In particular coefficient three yields only the universal
coefficient `3/2`; coefficient two is the exact sufficient threshold for the
standard abc slope one.

This module proves the endpoint inequality for the repository's actual
`ABCPoint`, gives the sharp coefficient transfer, and packages a non-circular
uniform coefficient-two criterion implying `ABCConjecture`.
-/

namespace IUTThreeClosures
namespace SymmetricProductCoefficientBarrier

noncomputable section

namespace ABCPoint

/-- Symmetric logarithmic size of a positive abc triple. -/
def symmetricProductLog (P : ABCPoint) : ℝ :=
  Real.log (((P.a * P.b * P.c : ℕ) : ℝ))

/-- The integer inequality `c^2 <= 2abc`.  It is sharp in logarithmic slope
along endpoint-shaped triples. -/
theorem c_sq_le_two_abc (P : ABCPoint) :
    (P.c : ℝ) ^ 2 ≤
      2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
  have ha : (1 : ℝ) ≤ P.a := by
    exact_mod_cast P.a_pos
  have hb : (1 : ℝ) ≤ P.b := by
    exact_mod_cast P.b_pos
  have hsum : (P.a : ℝ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  have hnonneg :
      0 ≤ ((P.a : ℝ) - 1) * ((P.b : ℝ) - 1) :=
    mul_nonneg (sub_nonneg.mpr ha) (sub_nonneg.mpr hb)
  have hcab : (P.c : ℝ) ≤ 2 * (P.a : ℝ) * P.b := by
    nlinarith
  have hc0 : 0 ≤ (P.c : ℝ) := by positivity
  have hmul := mul_le_mul_of_nonneg_right hcab hc0
  calc
    (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c := by ring
    _ ≤ (2 * (P.a : ℝ) * P.b) * P.c := hmul
    _ = 2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
      push_cast
      ring

/-- Universal conversion from height to symmetric product size. -/
theorem two_height_sub_log_two_le_symmetricProductLog (P : ABCPoint) :
    2 * P.height - Real.log 2 ≤ P.symmetricProductLog := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have habcpos :
      0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos)
  have hlog := Real.log_le_log
    (pow_pos hcpos 2) P.c_sq_le_two_abc
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) habcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold symmetricProductLog
  linarith

/-- General coefficient transfer from a symmetric-product inequality to the
standard abc height. -/
theorem height_le_of_symmetricProduct_bound
    (P : ABCPoint)
    {lambda error : ℝ}
    (hproduct :
      P.symmetricProductLog ≤ lambda * P.conductor + error) :
    P.height ≤
      (lambda / 2) * P.conductor +
        (error + Real.log 2) / 2 := by
  have hlower := P.two_height_sub_log_two_le_symmetricProductLog
  nlinarith

/-- Coefficient three transfers only to the universal height coefficient
`3/2`, before any additional balance-sensitive input. -/
theorem height_le_three_halves_of_coefficient_three
    (P : ABCPoint)
    {error : ℝ}
    (hproduct :
      P.symmetricProductLog ≤ 3 * P.conductor + error) :
    P.height ≤
      ((3 : ℝ) / 2) * P.conductor +
        (error + Real.log 2) / 2 := by
  exact P.height_le_of_symmetricProduct_bound hproduct

/-- Coefficient two is exactly sufficient to recover slope one. -/
theorem height_le_one_of_coefficient_two
    (P : ABCPoint)
    {error : ℝ}
    (hproduct :
      P.symmetricProductLog ≤ 2 * P.conductor + error) :
    P.height ≤ P.conductor + (error + Real.log 2) / 2 := by
  have h := P.height_le_of_symmetricProduct_bound hproduct
  norm_num at h ⊢
  linarith

/-- A relative product error of slope `eta < 2` gives the exact transferred
height denominator `2 - eta`. -/
theorem height_le_of_relative_symmetricProduct_error
    (P : ABCPoint)
    {lambda error eta K : ℝ}
    (heta : eta < 2)
    (hproduct :
      P.symmetricProductLog ≤ lambda * P.conductor + error)
    (herror : error ≤ eta * P.height + K) :
    P.height ≤
      (lambda * P.conductor + K + Real.log 2) / (2 - eta) := by
  have hlower := P.two_height_sub_log_two_le_symmetricProductLog
  have hraw :
      (2 - eta) * P.height ≤
        lambda * P.conductor + K + Real.log 2 := by
    nlinarith
  have hden : 0 < 2 - eta := sub_pos.mpr heta
  apply (le_div_iff₀ hden).2
  simpa [mul_comm] using hraw

end ABCPoint

/-- Uniform coefficient-two control of the symmetric product is a clean,
non-circular sufficient target for the abc conjecture. -/
def UniformSymmetricProductBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      P.symmetricProductLog ≤
        (2 + 2 * epsilon) * P.conductor + C

/-- The coefficient-two symmetric-product target implies the repository's
standard logarithmic `ABCConjecture`. -/
theorem abc_of_uniformSymmetricProductBound
    (hbound : UniformSymmetricProductBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  rcases hbound epsilon hepsilon with ⟨C, hC⟩
  refine ⟨(C + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hproduct := hC P
  have hlower := P.two_height_sub_log_two_le_symmetricProductLog
  have hheight :
      P.height ≤
        (1 + epsilon) * P.conductor +
          (C + Real.log 2) / 2 := by
    nlinarith
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hheight

/-- Pure coefficient countermodel: the two abstract inequalities
`2H <= product` and `product <= 3R` cannot, by themselves, imply a uniform
slope-one height bound.  This is a coefficient audit, not an actual abc
counterexample. -/
theorem coefficient_three_product_model_does_not_force_slope_one :
    ¬ ∃ C : ℝ, ∀ H product conductor : ℝ,
      0 ≤ conductor →
      2 * H ≤ product →
      product ≤ 3 * conductor →
      H ≤ conductor + C := by
  rintro ⟨C, hC⟩
  let conductor : ℝ := 2 * |C| + 2
  let H : ℝ := ((3 : ℝ) / 2) * conductor
  let product : ℝ := 3 * conductor
  have hconductor : 0 ≤ conductor := by
    dsimp [conductor]
    positivity
  have hlower : 2 * H ≤ product := by
    dsimp [H, product]
    ring_nf
  have hupper : product ≤ 3 * conductor := by
    dsimp [product]
  have hbad := hC H product conductor hconductor hlower hupper
  have hCle : C ≤ |C| := le_abs_self C
  dsimp [H, conductor] at hbad
  nlinarith [abs_nonneg C]

#print axioms ABCPoint.c_sq_le_two_abc
#print axioms ABCPoint.two_height_sub_log_two_le_symmetricProductLog
#print axioms ABCPoint.height_le_of_symmetricProduct_bound
#print axioms ABCPoint.height_le_three_halves_of_coefficient_three
#print axioms ABCPoint.height_le_one_of_coefficient_two
#print axioms ABCPoint.height_le_of_relative_symmetricProduct_error
#print axioms abc_of_uniformSymmetricProductBound
#print axioms coefficient_three_product_model_does_not_force_slope_one

end
end SymmetricProductCoefficientBarrier
end IUTThreeClosures
