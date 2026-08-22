/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FiniteIndexHaarCorrection
import IUTThreeClosures.FiniteIndexHaarUpperBound
import IUTThreeClosures.TateParameterPowerRegions

/-!
# Factorwise Kummer/Haar component formula

This module isolates the exact local theorem needed after the corrected
finite-etale packet decomposition.  A primitive field factor carries:

* its genuine Tate parameter `q`;
* an actual tensor-product integral order `O_actual`;
* the maximal norm-integral order `O_max`;
* the finite additive quotient `O_max / O_actual`;
* the genuine Haar scaling law for multiplication by `q`.

The output region of exponent `n` is the `n`-fold q-scaling of `O_actual`.
Its logarithmic volume is forced to be

`n * log ‖q‖ - log [O_max : O_actual]`

when the maximal order has normalized log-volume zero.  In particular the
finite-index correction is nonpositive, so the upper bound required in IUT IV
is simply

`logVol(output_n) ≤ n * log ‖q‖`.

The only remaining local analytic input is the actual Haar scaling law.  No
component upper value, theta coefficient, height inequality, or abc statement
is stored in this datum.
-/

namespace IUTThreeClosures

open MeasureTheory TateCurvesTheta

universe u v

/-- Honest local data on one primitive packet field factor. -/
structure FactorKummerHaarData
    (K : Type u) [NormedField K] : Type (max (u + 1) (v + 1)) where
  /-- Actual additive Haar measure. -/
  measure : Measure K
  /-- Genuine local Tate parameter. -/
  tate : TateParameter K
  /-- Tensor-product integral order, represented on the finite-positive
  measured domain. -/
  actualOrder : FinitePositiveRegion K measure
  /-- Maximal norm-integral order. -/
  maximalOrder : FinitePositiveRegion K measure
  /-- Finite additive index of the actual order in the maximal order. -/
  finiteIndex :
    FinitePositiveRegion.FiniteIndexComparison.{u, v}
      actualOrder maximalOrder
  /-- Standard normalization of additive Haar measure. -/
  maximal_logVolume : maximalOrder.logVolume = 0
  /-- Genuine multiplicative modulus of the additive Haar measure. -/
  qScaling :
    FinitePositiveRegion.ScalingLaw
      (μ := measure)
      (fun U => scaledRegion ((tate.q : K)) U)
      (Real.log ‖(tate.q : K)‖)

namespace FactorKummerHaarData

variable {K : Type u} [NormedField K]

/-- Measured region produced by the `n`-th actual q-power on the tensor order. -/
noncomputable def outputRegion
    (D : FactorKummerHaarData.{u, v} K) (n : ℕ) :
    FinitePositiveRegion K D.measure :=
  (D.qScaling.iterate n).pullback D.actualOrder

/-- Exact local component formula, including the integral-index correction. -/
theorem outputRegion_logVolume
    (D : FactorKummerHaarData.{u, v} K) (n : ℕ) :
    (D.outputRegion n).logVolume =
      (n : ℝ) * Real.log ‖(D.tate.q : K)‖ -
        Real.log (Fintype.card D.finiteIndex.Quotient : ℝ) := by
  exact D.finiteIndex.iterate_scaling_logVolume_of_large_eq_zero
    D.qScaling n D.maximal_logVolume

/-- The finite-index seam cannot increase the local component log-volume. -/
theorem outputRegion_logVolume_le
    (D : FactorKummerHaarData.{u, v} K) (n : ℕ) :
    (D.outputRegion n).logVolume ≤
      (n : ℝ) * Real.log ‖(D.tate.q : K)‖ := by
  exact D.finiteIndex.iterate_scaling_logVolume_le_of_large_eq_zero
    D.qScaling n D.maximal_logVolume

/-- The exact correction term is nonpositive. -/
theorem integralIndexCorrection_nonpos
    (D : FactorKummerHaarData.{u, v} K) :
    -Real.log (Fintype.card D.finiteIndex.Quotient : ℝ) ≤ 0 :=
  D.finiteIndex.neg_log_card_nonpos

end FactorKummerHaarData

end IUTThreeClosures
