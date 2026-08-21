/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PublicThetaHullUpperBound

/-!
# The exact scalar passage in IUT IV, Theorem 1.10

The blueprint formula for the theta coefficient is

`CTheta ≤ ((ell + 1) / (4 * absLogQ)) *
  ((1 + 12*dmod/ell) * (different + conductor)
    + 10 * error
    - (1/6) * (1 - 12/ell^2) * rawQ) - 1`.

Corollary 3.12 supplies the opposite inequality `-1 ≤ CTheta`. Positivity of
the prefactor therefore gives the core estimate

`(1/6) * (1 - 12/ell^2) * rawQ ≤
  (1 + 12*dmod/ell) * (different + conductor) + 10*error`.

For `ell ≥ 7` and `dmod ≥ 1`, the numerical comparison appearing in the
printed proof is

`rawQ / 6 ≤
  (1 + 20*dmod/ell) * (different + conductor) + 20*error`.

This file proves both implications and their direct public specialization. It
uses the actual public theta coefficient of the componentwise theta hull; no
independent coefficient, q-bound, or abc statement is supplied as data.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- For `ell ≥ 7`, the correction denominator `1 - 12/ell²` is positive. -/
theorem theorem110_denominator_pos
    {ell : ℝ} (hell : 7 ≤ ell) :
    0 < 1 - 12 / ell ^ 2 := by
  have hell_pos : 0 < ell := by linarith
  have hprod : 0 ≤ (ell - 7) * (ell + 7) :=
    mul_nonneg (by linarith) (by linarith)
  have hell_sq : (12 : ℝ) < ell ^ 2 := by
    nlinarith [hprod]
  have hell_sq_pos : 0 < ell ^ 2 := pow_pos hell_pos 2
  have hdiv : 12 / ell ^ 2 < 1 :=
    (div_lt_one hell_sq_pos).2 hell_sq
  linarith

/-- The coefficient of the different-plus-conductor term in Theorem 1.10 is
bounded by the coefficient used in its final displayed inequality. -/
theorem theorem110_main_coefficient_le
    {ell dmod : ℝ}
    (hell : 7 ≤ ell) (hdmod : 1 ≤ dmod) :
    1 + 12 * dmod / ell ≤
      (1 - 12 / ell ^ 2) * (1 + 20 * dmod / ell) := by
  have hell_pos : 0 < ell := by linarith
  have hell_ne : ell ≠ 0 := ne_of_gt hell_pos
  have hbase_product :
      0 ≤ (ell - 7) * (8 * ell + 44) :=
    mul_nonneg (by linarith) (by linarith)
  have hbase : 0 ≤ 8 * ell ^ 2 - 12 * ell - 240 := by
    nlinarith [hbase_product]
  have hquad : 0 ≤ 8 * ell ^ 2 - 240 := by
    nlinarith
  have hextra :
      0 ≤ (dmod - 1) * (8 * ell ^ 2 - 240) :=
    mul_nonneg (by linarith) hquad
  have hnum :
      0 ≤ 8 * dmod * ell ^ 2 - 12 * ell - 240 * dmod := by
    nlinarith [hbase, hextra]
  have hden : 0 < ell ^ 3 := pow_pos hell_pos 3
  have hfrac :
      0 ≤
        (8 * dmod * ell ^ 2 - 12 * ell - 240 * dmod) /
          ell ^ 3 :=
    div_nonneg hnum hden.le
  have hid :
      (1 - 12 / ell ^ 2) * (1 + 20 * dmod / ell) -
          (1 + 12 * dmod / ell) =
        (8 * dmod * ell ^ 2 - 12 * ell - 240 * dmod) /
          ell ^ 3 := by
    field_simp [hell_ne]
    ring
  rw [hid]
  exact hfrac

/-- The coefficient `10` of the remaining error term is at most
`20 * (1 - 12/ell²)` for `ell ≥ 7`. -/
theorem theorem110_error_coefficient_le
    {ell : ℝ} (hell : 7 ≤ ell) :
    (10 : ℝ) ≤ (1 - 12 / ell ^ 2) * 20 := by
  have hell_pos : 0 < ell := by linarith
  have hprod : 0 ≤ (ell - 7) * (ell + 7) :=
    mul_nonneg (by linarith) (by linarith)
  have hell_sq : (24 : ℝ) ≤ ell ^ 2 := by
    nlinarith [hprod]
  have hell_sq_pos : 0 < ell ^ 2 := pow_pos hell_pos 2
  have hdiv : 12 / ell ^ 2 ≤ (1 : ℝ) / 2 := by
    apply (div_le_iff₀ hell_sq_pos).2
    nlinarith
  nlinarith

/-- The numerical passage from the core Theorem 1.10 estimate to its final
q-bound. -/
theorem theorem110_q_bound
    {ell dmod different conductor error rawQ : ℝ}
    (hell : 7 ≤ ell)
    (hdmod : 1 ≤ dmod)
    (hdifferent : 0 ≤ different)
    (hconductor : 0 ≤ conductor)
    (herror : 0 ≤ error)
    (hcore :
      (1 / 6 : ℝ) * (1 - 12 / ell ^ 2) * rawQ ≤
        (1 + 12 * dmod / ell) * (different + conductor) +
          10 * error) :
    rawQ / 6 ≤
      (1 + 20 * dmod / ell) * (different + conductor) +
        20 * error := by
  have hden := theorem110_denominator_pos hell
  have hmainCoef := theorem110_main_coefficient_le hell hdmod
  have herrCoef := theorem110_error_coefficient_le hell
  have hsum : 0 ≤ different + conductor :=
    add_nonneg hdifferent hconductor
  have hmainMul := mul_le_mul_of_nonneg_right hmainCoef hsum
  have herrMul := mul_le_mul_of_nonneg_right herrCoef herror
  have hright :
      (1 + 12 * dmod / ell) * (different + conductor) +
          10 * error ≤
        (1 - 12 / ell ^ 2) *
          ((1 + 20 * dmod / ell) * (different + conductor) +
            20 * error) := by
    nlinarith [hmainMul, herrMul]
  have hscaled :
      (1 - 12 / ell ^ 2) * (rawQ / 6) ≤
        (1 - 12 / ell ^ 2) *
          ((1 + 20 * dmod / ell) * (different + conductor) +
            20 * error) := by
    have hleft :
        (1 - 12 / ell ^ 2) * (rawQ / 6) =
          (1 / 6 : ℝ) * (1 - 12 / ell ^ 2) * rawQ := by
      ring
    rw [hleft]
    exact hcore.trans hright
  exact (mul_le_mul_left hden).mp hscaled

/-- Corollary 3.12 and the public theta-coefficient upper formula imply the
core inequality of IUT IV, Theorem 1.10. -/
theorem theorem110_core_of_publicTheta_upper
    (X : Corollary312VariantData.{u, v} AG TG)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : Corollary312Variant X)
    {ell dmod different conductor error rawQ : ℝ}
    (hell : 7 ≤ ell)
    (hupper :
      publicThetaCoefficient X ≤
        ((ell + 1) / (4 * X.qPilot.absLogQ)) *
          ((1 + 12 * dmod / ell) * (different + conductor) +
            10 * error -
            (1 / 6 : ℝ) * (1 - 12 / ell ^ 2) * rawQ) - 1) :
    (1 / 6 : ℝ) * (1 - 12 / ell ^ 2) * rawQ ≤
      (1 + 12 * dmod / ell) * (different + conductor) +
        10 * error := by
  have hfactor :
      0 < (ell + 1) / (4 * X.qPilot.absLogQ) := by
    apply div_pos
    · linarith
    · positivity
  have hupper' :
      publicThetaCoefficient X ≤
        ((ell + 1) / (4 * X.qPilot.absLogQ)) *
          (((1 + 12 * dmod / ell) * (different + conductor) +
              10 * error) -
            ((1 / 6 : ℝ) * (1 - 12 / ell ^ 2)) * rawQ) - 1 := by
    convert hupper using 1 <;> ring
  have h := qTerm_le_main_of_publicThetaCoefficient_upper
    X hq h312 hfactor hupper'
  exact h

/-- Direct public form of the final numerical estimate in IUT IV,
Theorem 1.10. -/
theorem theorem110_q_bound_of_publicTheta_upper
    (X : Corollary312VariantData.{u, v} AG TG)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : Corollary312Variant X)
    {ell dmod different conductor error rawQ : ℝ}
    (hell : 7 ≤ ell)
    (hdmod : 1 ≤ dmod)
    (hdifferent : 0 ≤ different)
    (hconductor : 0 ≤ conductor)
    (herror : 0 ≤ error)
    (hupper :
      publicThetaCoefficient X ≤
        ((ell + 1) / (4 * X.qPilot.absLogQ)) *
          ((1 + 12 * dmod / ell) * (different + conductor) +
            10 * error -
            (1 / 6 : ℝ) * (1 - 12 / ell ^ 2) * rawQ) - 1) :
    rawQ / 6 ≤
      (1 + 20 * dmod / ell) * (different + conductor) +
        20 * error := by
  apply theorem110_q_bound hell hdmod hdifferent hconductor herror
  exact theorem110_core_of_publicTheta_upper X hq h312 hell hupper

end IUTThreeClosures
