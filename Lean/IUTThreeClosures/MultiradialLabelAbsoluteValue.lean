/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiradialLabelScaleCalibration
import Mathlib.Analysis.AbsoluteValue.Equivalence
import Mathlib.Analysis.Normed.Field.WithAbs
import Mathlib.Analysis.Normed.Group.Ultra
import Mathlib.Analysis.Normed.Unbundled.RingSeminorm
import Mathlib.NumberTheory.Padics.PadicNumbers

/-!
# Actual label-rescaled nonarchimedean absolute values

This module realizes the scalar `multiradialLabelScale` inside bundled
`AbsoluteValue` objects and their associated `WithAbs` normed-field copies.

If `v` is nonarchimedean and `s > 0`, then `x |-> v(x)^s` is again an
absolute value.  The nonarchimedean hypothesis is essential when `s > 1`:
raising an ordinary triangle inequality to an arbitrary positive power does
not preserve that inequality.  The new absolute value is equivalent to `v`,
so the canonical identity ring equivalence between the corresponding
`WithAbs` copies is a homeomorphism.

At label `j > 0`, the exponent is `s_j = 1 / j^2`.  The actual rescaled
absolute value sends `q^(j^2)` to a value with the same logarithm as the
original value of `q`, while it sends an embedded integer `a` to a value whose
logarithm is `s_j` times its original logarithm.  Consequently the canonical
identity ring equivalence from label `1` to label `2` is not a logarithmic
norm isometry whenever the field contains an integer of nonzero logarithmic
norm.
-/

namespace IUTThreeClosures

universe u

/-! ## Positive powers of a nonarchimedean absolute value -/

/-- Raising a nonarchimedean real absolute value to a positive real power
produces an actual bundled absolute value. -/
noncomputable def rescaledAbsoluteValue
    {K : Type u} [Field K]
    (v : AbsoluteValue K ℝ) (hv : IsNonarchimedean v)
    (s : ℝ) (hs : 0 < s) : AbsoluteValue K ℝ where
  toFun x := v x ^ s
  map_mul' x y := by
    rw [v.map_mul]
    exact Real.mul_rpow (v.nonneg x) (v.nonneg y)
  nonneg' x := Real.rpow_nonneg (v.nonneg x) s
  eq_zero' x := by
    rw [Real.rpow_eq_zero (v.nonneg x) hs.ne']
    exact v.eq_zero
  add_le' x y := by
    calc
      v (x + y) ^ s ≤ (max (v x) (v y)) ^ s :=
        Real.rpow_le_rpow (v.nonneg _) (hv x y) hs.le
      _ = max (v x ^ s) (v y ^ s) :=
        Real.rpow_max (v.nonneg x) (v.nonneg y) hs.le
      _ ≤ v x ^ s + v y ^ s :=
        max_le
          (le_add_of_nonneg_right (Real.rpow_nonneg (v.nonneg y) s))
          (le_add_of_nonneg_left (Real.rpow_nonneg (v.nonneg x) s))

@[simp]
theorem rescaledAbsoluteValue_apply
    {K : Type u} [Field K]
    (v : AbsoluteValue K ℝ) (hv : IsNonarchimedean v)
    (s : ℝ) (hs : 0 < s) (x : K) :
    rescaledAbsoluteValue v hv s hs x = v x ^ s := by
  simp [rescaledAbsoluteValue]

/-- The rescaled absolute value still satisfies the strong triangle
inequality, not merely the ordinary one. -/
theorem rescaledAbsoluteValue_isNonarchimedean
    {K : Type u} [Field K]
    (v : AbsoluteValue K ℝ) (hv : IsNonarchimedean v)
    (s : ℝ) (hs : 0 < s) :
    IsNonarchimedean (rescaledAbsoluteValue v hv s hs) := by
  intro x y
  simp only [rescaledAbsoluteValue_apply]
  calc
    v (x + y) ^ s ≤ (max (v x) (v y)) ^ s :=
      Real.rpow_le_rpow (v.nonneg _) (hv x y) hs.le
    _ = max (v x ^ s) (v y ^ s) :=
      Real.rpow_max (v.nonneg x) (v.nonneg y) hs.le

/-- A positive-power rescaling is equivalent to the original absolute
value. -/
theorem rescaledAbsoluteValue_isEquiv
    {K : Type u} [Field K]
    (v : AbsoluteValue K ℝ) (hv : IsNonarchimedean v)
    (s : ℝ) (hs : 0 < s) :
    v.IsEquiv (rescaledAbsoluteValue v hv s hs) := by
  apply AbsoluteValue.isEquiv_iff_exists_rpow_eq.mpr
  exact ⟨s, hs, by funext x; simp⟩

/-- The identity on the underlying field is a homeomorphism between the
`WithAbs` copies attached to the original and rescaled absolute values. -/
theorem rescaledAbsoluteValue_isHomeomorph
    {K : Type u} [Field K]
    (v : AbsoluteValue K ℝ) (hv : IsNonarchimedean v)
    (s : ℝ) (hs : 0 < s) :
    IsHomeomorph
      (WithAbs.congr v (rescaledAbsoluteValue v hv s hs)
        (RingEquiv.refl K)) := by
  exact (AbsoluteValue.isEquiv_iff_isHomeomorph
    v (rescaledAbsoluteValue v hv s hs)).mp
      (rescaledAbsoluteValue_isEquiv v hv s hs)

/-! ## Rescaled norm copies and their logarithms -/

/-- The norm absolute value of an ultrametric normed field, raised to a
positive real power. -/
noncomputable def rescaledNormAbsoluteValue
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (s : ℝ) (hs : 0 < s) : AbsoluteValue K ℝ :=
  rescaledAbsoluteValue (NormedField.toAbsoluteValue K)
    IsUltrametricDist.isNonarchimedean_norm s hs

@[simp]
theorem rescaledNormAbsoluteValue_apply
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (s : ℝ) (hs : 0 < s) (x : K) :
    rescaledNormAbsoluteValue K s hs x = ‖x‖ ^ s := by
  simp [rescaledNormAbsoluteValue, NormedField.toAbsoluteValue]

/-- The logarithm of a nonzero element's rescaled norm is multiplied by the
rescaling exponent. -/
theorem log_rescaledNormAbsoluteValue
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (s : ℝ) (hs : 0 < s) {x : K} (hx : x ≠ 0) :
    Real.log (rescaledNormAbsoluteValue K s hs x) =
      s * Real.log ‖x‖ := by
  rw [rescaledNormAbsoluteValue_apply,
    Real.log_rpow (norm_pos_iff.mpr hx)]

/-- The actual normed-field copy associated to a positive rescaling. -/
abbrev RescaledNormCopy
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (s : ℝ) (hs : 0 < s) :=
  WithAbs (rescaledNormAbsoluteValue K s hs)

/-- The rescaled norm copy has the same topology as the original norm
absolute-value copy. -/
theorem rescaledNormCopy_isHomeomorph
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (s : ℝ) (hs : 0 < s) :
    IsHomeomorph
      (WithAbs.congr (NormedField.toAbsoluteValue K)
        (rescaledNormAbsoluteValue K s hs) (RingEquiv.refl K)) := by
  exact rescaledAbsoluteValue_isHomeomorph
    (NormedField.toAbsoluteValue K)
    IsUltrametricDist.isNonarchimedean_norm s hs

/-! ## The label `1 / j^2` copies -/

/-- The actual absolute value attached to a positive theta label. -/
noncomputable def labelAbsoluteValue
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (j : ℕ) (hj : 0 < j) : AbsoluteValue K ℝ :=
  rescaledNormAbsoluteValue K (multiradialLabelScale j)
    (multiradialLabelScale_pos hj)

@[simp]
theorem labelAbsoluteValue_apply
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (j : ℕ) (hj : 0 < j) (x : K) :
    labelAbsoluteValue K j hj x =
      ‖x‖ ^ multiradialLabelScale j := by
  simp [labelAbsoluteValue]

/-- The actual normed-field copy attached to a positive theta label. -/
abbrev LabelNormCopy
    (K : Type u) [NormedField K] [IsUltrametricDist K]
    (j : ℕ) (hj : 0 < j) :=
  WithAbs (labelAbsoluteValue K j hj)

/-- The logarithmic size of a nonzero element in label `j` is exactly
`1 / j^2` times its original logarithmic size. -/
theorem log_labelAbsoluteValue
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (j : ℕ) (hj : 0 < j) {x : K} (hx : x ≠ 0) :
    Real.log (labelAbsoluteValue K j hj x) =
      multiradialLabelScale j * Real.log ‖x‖ := by
  exact log_rescaledNormAbsoluteValue
    (multiradialLabelScale j) (multiradialLabelScale_pos hj) hx

/-- In the actual label-rescaled absolute value, `q^(j^2)` has the original
logarithmic size of `q`. -/
theorem log_labelAbsoluteValue_q_square
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (q : Kˣ) (j : ℕ) (hj : 0 < j) :
    Real.log
        (labelAbsoluteValue K j hj ((q : K) ^ (j ^ 2))) =
      Real.log ‖(q : K)‖ := by
  calc
    Real.log
        (labelAbsoluteValue K j hj ((q : K) ^ (j ^ 2))) =
        multiradialLabelScale j *
          Real.log ‖(q : K) ^ (j ^ 2)‖ :=
      log_labelAbsoluteValue j hj (pow_ne_zero _ q.ne_zero)
    _ = multiradialLabelScale j *
          ((j : ℝ) ^ 2 * Real.log ‖(q : K)‖) := by
      rw [norm_pow, Real.log_pow]
      simp only [Nat.cast_pow]
    _ = Real.log ‖(q : K)‖ :=
      multiradialLabelScale_calibrates _ hj

/-- The same logarithmic scaling formula applied to the image of an integer
under the canonical ring map. -/
theorem log_labelAbsoluteValue_intCast
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (j : ℕ) (hj : 0 < j) (a : ℤ) (ha : (a : K) ≠ 0) :
    Real.log (labelAbsoluteValue K j hj (a : K)) =
      multiradialLabelScale j * Real.log ‖(a : K)‖ :=
  log_labelAbsoluteValue j hj ha

/-! ## The concrete label-one/label-two comparison -/

noncomputable def labelOneAbsoluteValue
    (K : Type u) [NormedField K] [IsUltrametricDist K] :
    AbsoluteValue K ℝ :=
  labelAbsoluteValue K 1 (by norm_num)

noncomputable def labelTwoAbsoluteValue
    (K : Type u) [NormedField K] [IsUltrametricDist K] :
    AbsoluteValue K ℝ :=
  labelAbsoluteValue K 2 (by norm_num)

abbrev LabelOneNormCopy
    (K : Type u) [NormedField K] [IsUltrametricDist K] :=
  WithAbs (labelOneAbsoluteValue K)

abbrev LabelTwoNormCopy
    (K : Type u) [NormedField K] [IsUltrametricDist K] :=
  WithAbs (labelTwoAbsoluteValue K)

/-- The underlying identity ring map between the two actual normed-field
copies.  It is algebraic, but in general not an isometry. -/
noncomputable def labelOneTwoRingEquiv
    (K : Type u) [NormedField K] [IsUltrametricDist K] :
    LabelOneNormCopy K ≃+* LabelTwoNormCopy K :=
  WithAbs.congr (labelOneAbsoluteValue K) (labelTwoAbsoluteValue K)
    (RingEquiv.refl K)

/-- If one embedded integer has nonzero original logarithmic norm, the
identity ring equivalence from label `1` to label `2` fails to preserve
logarithmic norm at that very integer. -/
theorem labelOneTwoRingEquiv_not_logNorm_preserving_at_int
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (a : ℤ) (hlog : Real.log ‖(a : K)‖ ≠ 0) :
    Real.log
        ‖labelOneTwoRingEquiv K (a : LabelOneNormCopy K)‖ ≠
      Real.log ‖(a : LabelOneNormCopy K)‖ := by
  have ha : (a : K) ≠ 0 := by
    intro ha
    apply hlog
    simp [ha]
  rw [map_intCast]
  change Real.log (labelTwoAbsoluteValue K (a : K)) ≠
    Real.log (labelOneAbsoluteValue K (a : K))
  rw [labelTwoAbsoluteValue, labelOneAbsoluteValue,
    log_labelAbsoluteValue_intCast 2 (by norm_num) a ha,
    log_labelAbsoluteValue_intCast 1 (by norm_num) a ha]
  norm_num [multiradialLabelScale]
  intro h
  apply hlog
  linarith

/-- Hence the canonical identity ring equivalence between labels `1` and `2`
is not a global logarithmic norm isometry. -/
theorem labelOneTwoRingEquiv_not_logNormIsometry
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (a : ℤ) (hlog : Real.log ‖(a : K)‖ ≠ 0) :
    ¬ ∀ x : LabelOneNormCopy K,
        Real.log ‖labelOneTwoRingEquiv K x‖ = Real.log ‖x‖ := by
  intro h
  exact labelOneTwoRingEquiv_not_logNorm_preserving_at_int a hlog
    (h (a : LabelOneNormCopy K))

/-- No ring equivalence between the two label copies can preserve logarithmic
norm if one embedded integer has nonzero logarithmic norm.  The point is that
every unital ring equivalence fixes integer casts. -/
theorem no_labelOneTwoRingEquiv_logNormIsometry
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (a : ℤ) (hlog : Real.log ‖(a : K)‖ ≠ 0)
    (e : LabelOneNormCopy K ≃+* LabelTwoNormCopy K) :
    ¬ ∀ x : LabelOneNormCopy K,
        Real.log ‖e x‖ = Real.log ‖x‖ := by
  intro h
  have ha : (a : K) ≠ 0 := by
    intro ha
    apply hlog
    simp [ha]
  have heq := h (a : LabelOneNormCopy K)
  rw [map_intCast] at heq
  change Real.log (labelTwoAbsoluteValue K (a : K)) =
    Real.log (labelOneAbsoluteValue K (a : K)) at heq
  rw [labelTwoAbsoluteValue, labelOneAbsoluteValue,
    log_labelAbsoluteValue_intCast 2 (by norm_num) a ha,
    log_labelAbsoluteValue_intCast 1 (by norm_num) a ha] at heq
  norm_num [multiradialLabelScale] at heq
  apply hlog
  linarith

/-- At an actual `p`-adic place the integer `p` supplies the required
nonzero logarithmic norm, so the label-one/label-two identity ring
equivalence is concretely not a logarithmic norm isometry. -/
theorem padic_labelOneTwoRingEquiv_not_logNormIsometry
    (p : ℕ) [Fact p.Prime] :
    ¬ ∀ x : LabelOneNormCopy ℚ_[p],
        Real.log ‖labelOneTwoRingEquiv ℚ_[p] x‖ =
          Real.log ‖x‖ := by
  apply labelOneTwoRingEquiv_not_logNormIsometry (K := ℚ_[p]) (p : ℤ)
  have hp0 : (p : ℚ_[p]) ≠ 0 := by
    exact_mod_cast (Fact.out : p.Prime).ne_zero
  exact Real.log_ne_zero_of_pos_of_ne_one
    (norm_pos_iff.mpr hp0) (ne_of_lt Padic.norm_p_lt_one)

/-- More strongly, at a genuine `p`-adic place there is no ring equivalence
between the two rescaled copies that preserves logarithmic norm. -/
theorem padic_no_labelOneTwoRingEquiv_logNormIsometry
    (p : ℕ) [Fact p.Prime]
    (e : LabelOneNormCopy ℚ_[p] ≃+* LabelTwoNormCopy ℚ_[p]) :
    ¬ ∀ x : LabelOneNormCopy ℚ_[p],
        Real.log ‖e x‖ = Real.log ‖x‖ := by
  apply no_labelOneTwoRingEquiv_logNormIsometry (K := ℚ_[p]) (p : ℤ)
  have hp0 : (p : ℚ_[p]) ≠ 0 := by
    exact_mod_cast (Fact.out : p.Prime).ne_zero
  exact Real.log_ne_zero_of_pos_of_ne_one
    (norm_pos_iff.mpr hp0) (ne_of_lt Padic.norm_p_lt_one)

end IUTThreeClosures
