/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiradialScaleCompatibilityNoGo

/-!
# The unique local scale at a nonzero theta label

For a nonzero label `j`, the concrete theta point has logarithmic norm
`j^2 * L`, where `L` is the logarithmic norm of the Tate parameter.  This
module defines the explicit positive scale `1 / j^2` and proves, rather than
postulates, that it is the unique real scale calibrating the label back to the
q-degree `L` when `L != 0`.

The pointwise theorem is compatible with finite weighted averaging and with
uniform rescaling of a zero product-formula sum.  These are local real-algebra
facts, not a construction of the arithmetic holomorphic structures in IUT III.
In particular, the theorem does not provide log-Kummer maps, global
Frobenioids, or the tensor compatibility that identifies the log-volume effect
of multiplication by integers across different labels.

The final theorem records a concrete boundary of the repository's current
fixed-field candidate: its horizontal translation from label `1` to label `2`
does not preserve logarithmic norm.  This rejects that translation as the
missing degree-line isometry; it is not a counterexample to IUT or to abc.
-/

namespace IUTThreeClosures

open TateCurvesTheta
open scoped BigOperators

universe u

/-- The explicit real calibration scale attached to theta label `j`. -/
noncomputable def multiradialLabelScale (j : ℕ) : ℝ :=
  ((j : ℝ) ^ 2)⁻¹

@[simp]
theorem multiradialLabelScale_zero :
    multiradialLabelScale 0 = 0 := by
  simp [multiradialLabelScale]

@[simp]
theorem multiradialLabelScale_one :
    multiradialLabelScale 1 = 1 := by
  simp [multiradialLabelScale]

/-- Every nonzero-label calibration scale is strictly positive. -/
theorem multiradialLabelScale_pos
    {j : ℕ} (hj : 0 < j) :
    0 < multiradialLabelScale j := by
  unfold multiradialLabelScale
  positivity

/-- The explicit label scale cancels the square label exponent. -/
theorem multiradialLabelScale_calibrates
    (L : ℝ) {j : ℕ} (hj : 0 < j) :
    multiradialLabelScale j * ((j : ℝ) ^ 2 * L) = L := by
  have hj0 : (j : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hj)
  simp [multiradialLabelScale, hj0]

/-- `1 / j^2` is the unique scale calibrating a nonzero logarithmic degree.

This is the strongest local positive statement: the scale is computed from
the label and is not supplied as a field of a bridge structure. -/
theorem scale_calibrates_square_iff
    {L s : ℝ} {j : ℕ} (hL : L ≠ 0) (hj : 0 < j) :
    s * ((j : ℝ) ^ 2 * L) = L ↔
      s = multiradialLabelScale j := by
  have hj0 : (j : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hj)
  have hsq : (j : ℝ) ^ 2 ≠ 0 := pow_ne_zero _ hj0
  constructor
  · intro hs
    have hse : s * (j : ℝ) ^ 2 = 1 := by
      apply mul_right_cancel₀ hL
      simpa [mul_assoc] using hs
    unfold multiradialLabelScale
    calc
      s = s * ((j : ℝ) ^ 2 * ((j : ℝ) ^ 2)⁻¹) := by
        simp [hsq]
      _ = (s * (j : ℝ) ^ 2) * ((j : ℝ) ^ 2)⁻¹ := by
        rw [mul_assoc]
      _ = ((j : ℝ) ^ 2)⁻¹ := by simp [hse]
  · rintro rfl
    exact multiradialLabelScale_calibrates L hj

/-- Multiplicative coherence under composition of square-power labels. -/
theorem multiradialLabelScale_mul (j k : ℕ) :
    multiradialLabelScale (j * k) =
      multiradialLabelScale j * multiradialLabelScale k := by
  simp [multiradialLabelScale, mul_pow, mul_comm]

/-- Pointwise calibration commutes with an arbitrary finite weighted sum. -/
theorem weighted_sum_multiradialLabelScale_calibrates
    {ι : Type u} [Fintype ι]
    (label : ι → ℕ) (hlabel : ∀ i, 0 < label i)
    (weight : ι → ℝ) (L : ℝ) :
    (∑ i, weight i *
        (multiradialLabelScale (label i) *
          ((label i : ℝ) ^ 2 * L))) =
      (∑ i, weight i) * L := by
  calc
    (∑ i, weight i *
        (multiradialLabelScale (label i) *
          ((label i : ℝ) ^ 2 * L))) =
        ∑ i, weight i * L := by
          apply Finset.sum_congr rfl
          intro i hi
          rw [multiradialLabelScale_calibrates L (hlabel i)]
    _ = (∑ i, weight i) * L := by
      rw [Finset.sum_mul]

/-- A normalized finite procession of pointwise calibrated labels has exactly
the q-degree. -/
theorem normalized_sum_multiradialLabelScale_calibrates
    {ι : Type u} [Fintype ι]
    (label : ι → ℕ) (hlabel : ∀ i, 0 < label i)
    (weight : ι → ℝ) (hweight : ∑ i, weight i = 1)
    (L : ℝ) :
    (∑ i, weight i *
        (multiradialLabelScale (label i) *
          ((label i : ℝ) ^ 2 * L))) = L := by
  rw [weighted_sum_multiradialLabelScale_calibrates
    label hlabel weight L, hweight, one_mul]

/-- Uniformly rescaling every place in one label copy preserves any finite
weighted product-formula sum that was zero before rescaling. -/
theorem multiradialLabelScale_preserves_product_formula_sum
    {ι : Type u} [Fintype ι]
    (weight localLog : ι → ℝ) (j : ℕ)
    (hproduct : ∑ i, weight i * localLog i = 0) :
    ∑ i, weight i *
        (multiradialLabelScale j * localLog i) = 0 := by
  calc
    (∑ i, weight i *
        (multiradialLabelScale j * localLog i)) =
        multiradialLabelScale j *
          (∑ i, weight i * localLog i) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro i hi
            ring
    _ = 0 := by rw [hproduct, mul_zero]

/-- Distinct square labels cannot share one scale if both calibrate the same
nonzero degree.  This is a common-scale obstruction; the theorem itself does
not formalize the IUT tensor/procession structures. -/
theorem calibrating_scales_ne_of_square_ne
    {L s jScale kScale : ℝ}
    (hL : L ≠ 0) (hjk : jScale ≠ kScale)
    (hj : s * (jScale * L) = L)
    (hk : s * (kScale * L) = L) : False :=
  no_common_scale_of_distinct_exponents hL hjk hj hk

/-- No real scale calibrates the zero theta label to a nonzero Tate degree. -/
theorem KummerTorsor.no_scale_calibrates_thetaPoint_zero
    {K : Type u} [NormedField K]
    (t : TateParameter K) (s : ℝ) :
    ¬s * Real.log
        ‖((KummerTorsor.thetaPoint t 0 : Kˣ) : K)‖ =
      Real.log ‖(t.q : K)‖ := by
  intro hs
  rw [KummerTorsor.log_norm_thetaPoint] at hs
  norm_num at hs
  exact (Real.log_neg t.norm_q_pos t.norm_lt_one).ne hs.symm

/-- The explicit label scale calibrates the actual fixed-field theta point. -/
theorem KummerTorsor.multiradialLabelScale_calibrates_thetaPoint
    {K : Type u} [NormedField K]
    (t : TateParameter K) {j : ℕ} (hj : 0 < j) :
    multiradialLabelScale j *
        Real.log ‖((KummerTorsor.thetaPoint t j : Kˣ) : K)‖ =
      Real.log ‖(t.q : K)‖ := by
  rw [KummerTorsor.log_norm_thetaPoint]
  simpa only [Nat.cast_pow] using
    multiradialLabelScale_calibrates
      (Real.log ‖(t.q : K)‖) hj

/-- Uniqueness of the scale for an actual nonzero theta label. -/
theorem KummerTorsor.scale_calibrates_thetaPoint_iff
    {K : Type u} [NormedField K]
    (t : TateParameter K) {j : ℕ} (hj : 0 < j) (s : ℝ) :
    s * Real.log
        ‖((KummerTorsor.thetaPoint t j : Kˣ) : K)‖ =
          Real.log ‖(t.q : K)‖ ↔
      s = multiradialLabelScale j := by
  rw [KummerTorsor.log_norm_thetaPoint]
  simpa only [Nat.cast_pow] using
    scale_calibrates_square_iff
      (Real.log_neg t.norm_q_pos t.norm_lt_one).ne hj (s := s)

/-- The current horizontal translation from label `1` to label `2` is not a
log-norm isometry.  It remains a valid torsor equivalence, but it cannot itself
be the missing multiradial degree-line comparison. -/
theorem KummerTorsor.horizontalEquiv_one_two_not_log_norm_preserving
    {K : Type u} [NormedField K]
    (t : TateParameter K) :
    Real.log
        ‖((KummerTorsor.horizontalEquiv t 1 2
          (KummerTorsor.thetaPoint t 1) : Kˣ) : K)‖ ≠
      Real.log ‖((KummerTorsor.thetaPoint t 1 : Kˣ) : K)‖ := by
  rw [KummerTorsor.horizontalEquiv_thetaPoint]
  rw [KummerTorsor.log_norm_thetaPoint,
    KummerTorsor.log_norm_thetaPoint]
  norm_num
  intro h
  apply (Real.log_neg t.norm_q_pos t.norm_lt_one).ne
  linarith

end IUTThreeClosures
