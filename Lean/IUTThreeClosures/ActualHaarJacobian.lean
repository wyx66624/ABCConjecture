/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualFactorHaarMeasure
import Mathlib.MeasureTheory.Measure.Haar.MulEquivHaarChar

/-!
# The actual Haar Jacobian of multiplication on a local-field factor

The additive Haar measure is not assigned a scaling law on arbitrary sets by
an unrelated real-valued field.  Multiplication by a nonzero local scalar is a
continuous additive equivalence, and Mathlib's canonical additive-equivalence
Haar character supplies its unique Jacobian.  Thus the raw scaling theorem is
a consequence of Haar uniqueness.

For a finite extension of `ℚ_p`, identifying this raw character with the
`[L : ℚ_p]`-th power of the spectral norm is a separate local-degree theorem.
After division by the local degree, this is precisely the normalized IUT IV
log-volume scaling law.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u

namespace ActualHaarJacobian

variable {K : Type u} [NormedField K]

/-- Multiplication by a nonzero scalar as a continuous additive equivalence. -/
def mulContinuousAddEquiv (a : Kˣ) : K ≃ₜ+ K where
  toFun x := (a : K) * x
  invFun x := (↑a⁻¹ : K) * x
  left_inv x := by simp [mul_assoc]
  right_inv x := by simp [mul_assoc]
  map_add' x y := by simp [mul_add]
  continuous_toFun := continuous_const_mul _
  continuous_invFun := continuous_const_mul _

@[simp]
theorem mulContinuousAddEquiv_apply (a : Kˣ) (x : K) :
    mulContinuousAddEquiv a x = (a : K) * x :=
  rfl

/-- The raw Haar character of multiplication by `a`.  With Mathlib's
convention it is the scalar appearing in the push-forward identity
`map (a·) μ = rawCharacter μ a • μ`; hence the measure of a direct image is
scaled by its reciprocal. -/
noncomputable def rawCharacter
    [MeasurableSpace K] [BorelSpace K]
    (μ : Measure K) [IsAddLeftInvariant μ]
    (a : Kˣ) : ℝ≥0 :=
  Measure.addEquivHaarChar μ (mulContinuousAddEquiv a)

/-- Exact Haar-Jacobian theorem for multiplication. -/
theorem map_mul_eq_character_smul
    [MeasurableSpace K] [BorelSpace K]
    (μ : Measure K) [IsAddLeftInvariant μ]
    (a : Kˣ) :
    Measure.map (mulContinuousAddEquiv a) μ =
      (rawCharacter μ a : ℝ≥0∞) • μ := by
  simpa [rawCharacter] using
    (Measure.map_addEquivHaarChar μ (mulContinuousAddEquiv a))

/-- The raw character is multiplicative in the scalar. -/
theorem rawCharacter_mul
    [MeasurableSpace K] [BorelSpace K]
    (μ : Measure K) [IsAddLeftInvariant μ]
    (a b : Kˣ) :
    rawCharacter μ (a * b) = rawCharacter μ a * rawCharacter μ b := by
  change Measure.addEquivHaarChar μ (mulContinuousAddEquiv (a * b)) = _
  have heq :
      mulContinuousAddEquiv (a * b) =
        (mulContinuousAddEquiv b).trans (mulContinuousAddEquiv a) := by
    ext x
    simp [mulContinuousAddEquiv, mul_assoc]
  rw [heq]
  exact map_mul (Measure.addEquivHaarChar μ)
    (mulContinuousAddEquiv b) (mulContinuousAddEquiv a)

/-- Consequently the character of the `n`-th power is the `n`-th power of the
character. -/
theorem rawCharacter_pow
    [MeasurableSpace K] [BorelSpace K]
    (μ : Measure K) [IsAddLeftInvariant μ]
    (a : Kˣ) (n : ℕ) :
    rawCharacter μ (a ^ n) = rawCharacter μ a ^ n := by
  change Measure.addEquivHaarChar μ (mulContinuousAddEquiv (a ^ n)) = _
  induction n with
  | zero => simp [mulContinuousAddEquiv, rawCharacter]
  | succ n ih =>
      rw [pow_succ, rawCharacter_mul, ih, pow_succ]

end ActualHaarJacobian

end IUTThreeClosures
