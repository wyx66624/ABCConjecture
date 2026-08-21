/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PublicThetaHullComponentFormula

/-!
# From actual theta-hull component bounds to the public coefficient

The preceding component formula rewrites the actual public theta right-hand
side as a procession average of product-weighted local component volumes.
This module proves the exact local-to-global reduction used in the
componentwise calculation of IUT IV, Theorem 1.10.

An estimate consists only of a proposed upper value for every actual
component, a proof of the corresponding pointwise component inequality, and
the finite-support statement needed for the all-rational-place sum. Positivity
of the public packet weights then propagates the estimate through the direct
sum, the global finite sum and the procession average.

Thus the remaining arithmetic-geometric input is now genuinely local: prove
the component inequality for the theta/Kummer/tempered scale selected by the
actual holomorphic hull. No global theta coefficient or final abc inequality
is included in the input structure.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut
open scoped BigOperators

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Pointwise upper estimates for the actual component regions of a public
theta hull. -/
structure ThetaHullComponentUpperEstimate
    (R : RHSData.{u, v} D) : Type (max u v) where
  /-- Arithmetic upper value assigned to one genuine packet component. -/
  upper : ∀ (i : Fin R.container.proc.length) (vQ : RationalPlace),
    R.container.Components i vQ → ℝ
  /-- The actual local log-volume of the theta-hull component is bounded by
  the proposed arithmetic value. -/
  component_le : ∀ i vQ c,
    R.vol.componentVol i vQ c
        (thetaHullComponentRegion R i vQ c) ≤
      upper i vQ c
  /-- The resulting rational-place upper sum has finite support. -/
  upper_finiteSupport : ∀ i,
    (Function.support fun vQ : RationalPlace =>
      ∑ c : R.container.Components i vQ,
        R.vol.packetWeight i vQ c * upper i vQ c).Finite

namespace ThetaHullComponentUpperEstimate

variable {R : RHSData.{u, v} D}

/-- Product-weighted upper sum at one capsule and rational place. -/
noncomputable def packetUpperSum
    (E : ThetaHullComponentUpperEstimate R)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) : ℝ :=
  ∑ c : R.container.Components i vQ,
    R.vol.packetWeight i vQ c * E.upper i vQ c

/-- The actual local packet volume is bounded by the product-weighted sum of
its component upper estimates. -/
theorem packetVol_thetaHull_le
    (E : ThetaHullComponentUpperEstimate R)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    R.vol.packetVol i vQ ((R.thetaHull i).region vQ) ≤
      E.packetUpperSum i vQ := by
  rw [packetVol_thetaHull_eq_componentSum]
  unfold thetaHullPacketComponentSum packetUpperSum
  exact Finset.sum_le_sum fun c _ =>
    mul_le_mul_of_nonneg_left (E.component_le i vQ c)
      (R.vol.packetWeight_pos i vQ c).le

/-- All-rational-place upper value for one capsule. -/
noncomputable def globalUpperSum
    (E : ThetaHullComponentUpperEstimate R)
    (i : Fin R.container.proc.length) : ℝ :=
  ∑ᶠ vQ : RationalPlace, E.packetUpperSum i vQ

/-- The actual global volume of one capsule is bounded by the all-place
component upper sum. -/
theorem globalVol_thetaHull_le
    (E : ThetaHullComponentUpperEstimate R)
    (i : Fin R.container.proc.length) :
    R.vol.globalVol (R.thetaHull i) ≤ E.globalUpperSum i := by
  rw [globalVol_thetaHull_eq_componentSum]
  unfold thetaHullGlobalComponentSum globalUpperSum
  have hactual :
      (Function.support fun vQ : RationalPlace =>
        thetaHullPacketComponentSum R i vQ).Finite := by
    simpa only [packetVol_thetaHull_eq_componentSum] using
      (R.vol.finite_support_packetVol (R.thetaHull i))
  refine finsum_le_finsum' hactual ?_ fun vQ => ?_
  · simpa only [packetUpperSum] using E.upper_finiteSupport i
  · rw [← packetVol_thetaHull_eq_componentSum]
    exact E.packetVol_thetaHull_le i vQ

/-- Procession average of the all-place upper values. -/
noncomputable def processionUpperAverage
    (E : ThetaHullComponentUpperEstimate R) : ℝ :=
  (∑ i : Fin R.container.proc.length, E.globalUpperSum i) /
    (R.container.proc.length : ℝ)

/-- The complete actual public theta right-hand side is bounded by the
procession average of the component upper values. -/
theorem rhs_le_processionUpperAverage
    (E : ThetaHullComponentUpperEstimate R) :
    R.rhs ≤ E.processionUpperAverage := by
  rw [rhs_eq_thetaHullProcessionComponentAverage]
  unfold thetaHullProcessionComponentAverage processionUpperAverage
  apply div_le_div_of_nonneg_right
  · exact Finset.sum_le_sum fun i _ => E.globalVol_thetaHull_le i
  · positivity

/-- A componentwise estimate of the standard coefficient expression gives the
corresponding upper bound for the actual public theta coefficient. -/
theorem publicThetaCoefficient_le_of_processionUpper
    {X : Corollary312VariantData.{u, v} AG TG}
    (E : ThetaHullComponentUpperEstimate X.rhsData)
    (hq : 0 < X.qPilot.absLogQ)
    {B : ℝ}
    (hupper :
      E.processionUpperAverage ≤ X.qPilot.absLogQ * B) :
    publicThetaCoefficient X ≤ B := by
  rw [publicThetaCoefficient]
  apply (div_le_iff₀ hq).2
  exact (E.rhs_le_processionUpperAverage).trans hupper

/-- Direct source-faithful bridge from local component estimates to the
q-term bound. -/
theorem qTerm_le_main_of_componentUpper
    {X : Corollary312VariantData.{u, v} AG TG}
    (E : ThetaHullComponentUpperEstimate X.rhsData)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : Corollary312Variant X)
    {factor main qCoeff rawQ : ℝ}
    (hfactor : 0 < factor)
    (hupper :
      E.processionUpperAverage ≤
        X.qPilot.absLogQ *
          (factor * (main - qCoeff * rawQ) - 1)) :
    qCoeff * rawQ ≤ main := by
  apply qTerm_le_main_of_publicThetaCoefficient_upper X hq h312 hfactor
  exact E.publicThetaCoefficient_le_of_processionUpper hq hupper

end ThetaHullComponentUpperEstimate

end IUTThreeClosures
