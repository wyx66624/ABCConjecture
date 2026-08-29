/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Audit of the finite-range computation in Zhou's effective abc paper

The companion notebook for Theorem 3.2 intends to average the summand

`(11*p + 31) / (p^2 + p - 12)`.

The published Python source instead contains

`(11*p*+31) / (p^3 + p^2 - 12*p)`

and later divides the resulting average by `2`. Python parses `*+31` as
multiplication by positive `31`. For a single nonzero prime input, the effective
summand is therefore

`(341/2) / (p^2 + p - 12)`.

For every real `p >= 13`, this is strictly smaller than the intended summand.
Thus the published numerical run cannot certify the displayed mathematical
formula without a corrected rerun.

The second part of the file formalizes an exact algebraic refinement of the
finite-range estimate. Starting from

`h <= (3+a1)*r + a2 + 2*invN*h`,

one obtains

`h <= 3*r + ((a1+6*invN)/(3+a1))*h + 3*a2/(3+a1)`.

The notebook replaces the last term by the coarser `a2`. Retaining the exact
factor can repair a borderline interval, but that repair requires a new
verified computation. No IUT theorem, abc theorem, or external numerical
certificate is assumed here.
-/

namespace IUTThreeClosures
namespace ZhouFiniteRangeComputationAudit

/-- The summand printed in the mathematical definition of `a1`. -/
def intendedA1Summand (p : ℝ) : ℝ :=
  (11 * p + 31) / (p ^ 2 + p - 12)

/-- The effective per-prime summand produced by the published notebook after
Python parses `11*p*+31` as `341*p`, cancels the factor `p` in the denominator,
and applies the later division by two. -/
def notebookEffectiveA1Summand (p : ℝ) : ℝ :=
  ((341 : ℝ) / 2) / (p ^ 2 + p - 12)

/-- Algebraic verification of the effective notebook summand on the prime
range used in the computation. -/
theorem notebook_source_expression_eq_effective
    {p : ℝ} (hp : 13 ≤ p) :
    (341 * p / (p ^ 3 + p ^ 2 - 12 * p)) / 2 =
      notebookEffectiveA1Summand p := by
  have hp0 : p ≠ 0 := by nlinarith
  have hdenPos : 0 < p ^ 2 + p - 12 := by nlinarith
  have hden0 : p ^ 2 + p - 12 ≠ 0 := ne_of_gt hdenPos
  have hbig0 : p ^ 3 + p ^ 2 - 12 * p ≠ 0 := by
    rw [show p ^ 3 + p ^ 2 - 12 * p =
      p * (p ^ 2 + p - 12) by ring]
    exact mul_ne_zero hp0 hden0
  unfold notebookEffectiveA1Summand
  field_simp [hp0, hden0, hbig0]
  <;> ring

/-- The notebook's effective summand strictly underestimates the intended one
for every `p >= 13`. -/
theorem notebookEffectiveA1Summand_lt_intended
    {p : ℝ} (hp : 13 ≤ p) :
    notebookEffectiveA1Summand p < intendedA1Summand p := by
  have hdenPos : 0 < p ^ 2 + p - 12 := by nlinarith
  unfold notebookEffectiveA1Summand intendedA1Summand
  apply (div_lt_div_iff_of_pos_right hdenPos).2
  nlinarith

/-- Exact rearrangement of the inequality used after Lemma 3.1. The variable
`invN` represents `1/n`; keeping it abstract avoids importing a numerical
certificate. -/
theorem exact_finite_range_rearrangement
    {h r a1 a2 invN : ℝ}
    (hA : 0 < 3 + a1)
    (hbase :
      h ≤ (3 + a1) * r + a2 + 2 * invN * h) :
    h ≤ 3 * r +
      ((a1 + 6 * invN) / (3 + a1)) * h +
      3 * a2 / (3 + a1) := by
  have hthree : (0 : ℝ) ≤ 3 := by norm_num
  have hscaled :
      3 * h ≤
        3 * ((3 + a1) * r + a2 + 2 * invN * h) :=
    mul_le_mul_of_nonneg_left hbase hthree
  have hmul :
      (3 + a1) * h ≤
        (3 + a1) *
          (3 * r +
            ((a1 + 6 * invN) / (3 + a1)) * h +
            3 * a2 / (3 + a1)) := by
    calc
      (3 + a1) * h = 3 * h + a1 * h := by ring
      _ ≤ 3 * ((3 + a1) * r + a2 + 2 * invN * h) +
          a1 * h := add_le_add_right hscaled (a1 * h)
      _ = (3 + a1) *
          (3 * r +
            ((a1 + 6 * invN) / (3 + a1)) * h +
            3 * a2 / (3 + a1)) := by
          field_simp [ne_of_gt hA]
          <;> ring
  exact (mul_le_mul_left hA).mp hmul

/-- For nonnegative `a1,a2`, the exact `a2` contribution is no larger than the
coarse replacement used in the notebook. -/
theorem exact_a2_term_le_coarse
    {a1 a2 : ℝ}
    (ha1 : 0 ≤ a1) (ha2 : 0 ≤ a2) :
    3 * a2 / (3 + a1) ≤ a2 := by
  have hA : 0 < 3 + a1 := by linarith
  apply (div_le_iff₀ hA).2
  have hprod : 0 ≤ a1 * a2 := mul_nonneg ha1 ha2
  nlinarith

/-- If both correction terms are positive, replacing the exact factor by
`a2` loses a strict amount. -/
theorem exact_a2_term_lt_coarse
    {a1 a2 : ℝ}
    (ha1 : 0 < a1) (ha2 : 0 < a2) :
    3 * a2 / (3 + a1) < a2 := by
  have hA : 0 < 3 + a1 := by linarith
  apply (div_lt_iff₀ hA).2
  have hprod : 0 < a1 * a2 := mul_pos ha1 ha2
  nlinarith

#print axioms notebook_source_expression_eq_effective
#print axioms notebookEffectiveA1Summand_lt_intended
#print axioms exact_finite_range_rearrangement
#print axioms exact_a2_term_le_coarse
#print axioms exact_a2_term_lt_coarse

end ZhouFiniteRangeComputationAudit
end IUTThreeClosures
