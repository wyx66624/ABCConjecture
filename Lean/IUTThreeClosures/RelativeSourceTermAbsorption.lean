/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110
import IUTThreeClosures.FreyConductorCalibratedIUTIVBridge

/-!
# Relative absorption of the IUT IV source terms

An eventual large-image theorem supplies arbitrarily large admissible primes,
but by itself gives no independent upper bound for the first usable prime.  An
upper bound is unnecessary if the prime-dependent source terms are controlled
*relative to the abc conductor* and their slopes tend to zero simultaneously
with the public correction `20 * d_mod / ell`.

This module proves that precise alternative.  For a sequence of genuine public
Theorem 1.10 bridges, suppose

* the public correction is at most `gamma_n`;
* the different is at most `alpha_n * conductor + D_n`;
* the remaining error is at most `beta_n * conductor + E_n`;
* for every positive `rho`, some common index satisfies
  `gamma_n <= rho`, `alpha_n <= rho`, and `20 * beta_n <= rho`.

Then the logarithmic abc conjecture follows.  No upper bound on the selected
auxiliary prime is used.  Thus the quantitative-prime bottleneck may be closed
by either a genuinely quantitative prime theorem or a simultaneous relative
decay theorem for the actual source terms.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- A sequence of genuine public IUT IV sources whose conductor-relative
source-term slopes can be made simultaneously small.  The additive constants
may depend on the selected index, exactly as the constant in abc may depend on
`epsilon`. -/
structure RelativeDecayPublicFreyTheorem110Bridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  bridge : ℕ → PublicFreyTheorem110Bridge F
  correctionBound : ℕ → ℝ
  differentSlope : ℕ → ℝ
  differentConstant : ℕ → ℝ
  errorSlope : ℕ → ℝ
  errorConstant : ℕ → ℝ
  differentConstant_nonneg : ∀ n, 0 ≤ differentConstant n
  errorConstant_nonneg : ∀ n, 0 ≤ errorConstant n
  correction_le : ∀ (n : ℕ) (P : ABCPoint),
    publicFreyTheorem110Correction (bridge n) P ≤ correctionBound n
  different_le : ∀ (n : ℕ) (P : ABCPoint),
    (bridge n).different P ≤
      differentSlope n * P.conductor + differentConstant n
  error_le : ∀ (n : ℕ) (P : ABCPoint),
    (bridge n).error P ≤
      errorSlope n * P.conductor + errorConstant n
  simultaneous_decay : ∀ ρ : ℝ, 0 < ρ →
    ∃ n : ℕ,
      correctionBound n ≤ ρ ∧
      differentSlope n ≤ ρ ∧
      20 * errorSlope n ≤ ρ

namespace RelativeDecayPublicFreyTheorem110Bridge

/-- At an index where the three relative coefficients are at most `rho <= 1`,
the complete source estimate has conductor coefficient at most `1 + 4*rho`.
The displayed additive constant is independent of the abc point. -/
theorem pointwise_height_bound
    (U : RelativeDecayPublicFreyTheorem110Bridge F)
    (n : ℕ) {ρ : ℝ}
    (hρ0 : 0 ≤ ρ) (hρ1 : ρ ≤ 1)
    (hcorrection : U.correctionBound n ≤ ρ)
    (hdifferentSlope : U.differentSlope n ≤ ρ)
    (herrorSlope : 20 * U.errorSlope n ≤ ρ)
    (P : ABCPoint) :
    P.height ≤
      (1 + 4 * ρ) * P.conductor +
        ((1 + ρ) * (U.differentConstant n + Real.log 16) +
          20 * U.errorConstant n + Real.log 8 / 6) := by
  let B : PublicFreyTheorem110Bridge F := U.bridge n
  let c : ℝ := publicFreyTheorem110Correction B P
  let α : ℝ := U.differentSlope n
  let β : ℝ := U.errorSlope n
  let D : ℝ := U.differentConstant n
  let E : ℝ := U.errorConstant n
  have hpoint :
      P.height ≤
        (1 + c) * (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
    simpa [B, c, publicFreyTheorem110Correction] using
      B.pointwise_height_bound P
  have hc_nonneg : 0 ≤ c := by
    simpa [c] using publicFreyTheorem110Correction_nonneg B P
  have hc_le : c ≤ ρ := by
    have h := U.correction_le n P
    linarith
  have hα_le : α ≤ ρ := by
    simpa [α] using hdifferentSlope
  have hβ_le : 20 * β ≤ ρ := by
    simpa [β] using herrorSlope
  have hsum :
      B.different P + P.freyDiscriminantConductor ≤
        (1 + α) * P.conductor + (D + Real.log 16) := by
    have hd := U.different_le n P
    have hdisc := P.freyDiscriminantConductor_le
    calc
      B.different P + P.freyDiscriminantConductor ≤
          (α * P.conductor + D) +
            (P.conductor + Real.log 16) :=
        add_le_add hd hdisc
      _ = (1 + α) * P.conductor + (D + Real.log 16) := by
        ring
  have hone_c_nonneg : 0 ≤ 1 + c := by linarith
  have hsum_mul :
      (1 + c) * (B.different P + P.freyDiscriminantConductor) ≤
        (1 + c) *
          ((1 + α) * P.conductor + (D + Real.log 16)) :=
    mul_le_mul_of_nonneg_left hsum hone_c_nonneg
  have herror :
      20 * B.error P ≤
        20 * (β * P.conductor + E) := by
    apply mul_le_mul_of_nonneg_left
    · simpa [B, β, E] using U.error_le n P
    · norm_num
  have hone_α_le : 1 + α ≤ 1 + ρ := by linarith
  have hone_c_le : 1 + c ≤ 1 + ρ := by linarith
  have hone_ρ_nonneg : 0 ≤ 1 + ρ := by linarith
  have hfirst :
      (1 + c) * (1 + α) ≤ (1 + c) * (1 + ρ) :=
    mul_le_mul_of_nonneg_left hone_α_le hone_c_nonneg
  have hsecond :
      (1 + c) * (1 + ρ) ≤ (1 + ρ) * (1 + ρ) :=
    mul_le_mul_of_nonneg_right hone_c_le hone_ρ_nonneg
  have hρsq : ρ ^ 2 ≤ ρ := by
    nlinarith [mul_nonneg hρ0 (sub_nonneg.mpr hρ1)]
  have hcoefficient :
      (1 + c) * (1 + α) + 20 * β ≤ 1 + 4 * ρ := by
    nlinarith [hfirst.trans hsecond, hβ_le, hρsq]
  have hconductor_term :
      ((1 + c) * (1 + α) + 20 * β) * P.conductor ≤
        (1 + 4 * ρ) * P.conductor :=
    mul_le_mul_of_nonneg_right hcoefficient P.conductor_nonneg
  have hlog16 : 0 ≤ Real.log (16 : ℝ) :=
    Real.log_nonneg (by norm_num)
  have hconstant_nonneg : 0 ≤ D + Real.log 16 := by
    exact add_nonneg (by simpa [D] using U.differentConstant_nonneg n) hlog16
  have hconstant_mul :
      (1 + c) * (D + Real.log 16) ≤
        (1 + ρ) * (D + Real.log 16) :=
    mul_le_mul_of_nonneg_right hone_c_le hconstant_nonneg
  calc
    P.height ≤
        (1 + c) * (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := hpoint
    _ ≤ (1 + c) *
          ((1 + α) * P.conductor + (D + Real.log 16)) +
        20 * (β * P.conductor + E) + Real.log 8 / 6 := by
      linarith
    _ = ((1 + c) * (1 + α) + 20 * β) * P.conductor +
        ((1 + c) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      ring
    _ ≤ (1 + 4 * ρ) * P.conductor +
        ((1 + ρ) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      linarith
    _ = (1 + 4 * ρ) * P.conductor +
        ((1 + ρ) * (U.differentConstant n + Real.log 16) +
          20 * U.errorConstant n + Real.log 8 / 6) := by
      rfl

/-- Simultaneous relative decay of the correction, different slope and error
slope is sufficient for the logarithmic abc conjecture.  No quantitative upper
bound for the selected auxiliary prime appears in the proof. -/
theorem abc
    (U : RelativeDecayPublicFreyTheorem110Bridge F) :
    ABCConjecture := by
  intro ε hε
  let ρ : ℝ := min 1 (ε / 4)
  have hρpos : 0 < ρ := by
    dsimp [ρ]
    exact lt_min (by norm_num) (div_pos hε (by norm_num))
  have hρ0 : 0 ≤ ρ := hρpos.le
  have hρ1 : ρ ≤ 1 := by
    dsimp [ρ]
    exact min_le_left _ _
  have h4ρ : 4 * ρ ≤ ε := by
    have hmin : ρ ≤ ε / 4 := by
      dsimp [ρ]
      exact min_le_right _ _
    linarith
  rcases U.simultaneous_decay ρ hρpos with
    ⟨n, hcorrection, hdifferentSlope, herrorSlope⟩
  refine ⟨(1 + ρ) * (U.differentConstant n + Real.log 16) +
      20 * U.errorConstant n + Real.log 8 / 6, ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  have hpoint := U.pointwise_height_bound n hρ0 hρ1
    hcorrection hdifferentSlope herrorSlope P
  have hcoefficient : 1 + 4 * ρ ≤ 1 + ε := by linarith
  have hcoefficient_term :
      (1 + 4 * ρ) * P.conductor ≤ (1 + ε) * P.conductor :=
    mul_le_mul_of_nonneg_right hcoefficient P.conductor_nonneg
  have hfinal :
      P.height ≤
        (1 + ε) * P.conductor +
          ((1 + ρ) * (U.differentConstant n + Real.log 16) +
            20 * U.errorConstant n + Real.log 8 / 6) := by
    linarith
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hfinal

end RelativeDecayPublicFreyTheorem110Bridge

end IUTThreeClosures
