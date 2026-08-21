/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.Statement

/-!
# The actual public theta-hull component formula

The public Corollary 3.12 right-hand side is the procession-normalized
log-volume of the holomorphic hull of the theta-pilot region.  A crucial point
is that one does not need to assume that the raw theta-pilot region is a
rectangle.  The defining theorem of the public hull system says that the hull
of every admissible region is a hull region `a · O`; such a region is
literally a direct product of its component regions.

Consequently the public `packetVol_product` law applies to the actual
`RHSData.thetaHull`.  This file chooses the canonical scale supplied by the
least-hull theorem and proves, without an additional component-volume field,
that every local packet volume, every global capsule volume, and the complete
public right-hand side are the corresponding weighted component sums.

The final section records the source-faithful coefficient algebra.  An upper
bound

`CTheta ≤ factor * (main - qCoeff * rawQ) - 1`

together with Corollary 3.12's lower bound `-1 ≤ CTheta` forces
`qCoeff * rawQ ≤ main`.  Equality is not required; this is the inequality
shape used by the componentwise calculation in IUT IV, Theorem 1.10.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut
open scoped BigOperators Pointwise

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The actual local theta hull is a scaled integral region.  This is a theorem
of the public least-hull interface, not a new geometric assumption. -/
theorem thetaHull_isHullRegion
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    (R.container.packet i vQ).IsHullRegion
      ((R.thetaHull i).region vQ) := by
  simpa [RHSData.thetaHull, ContainerHullSystem.hullFamily,
    ContainerHullSystem.hullAdmissible] using
    (R.hull.system i vQ).isHullRegion_hull
      (R.thetaPilot_hullAdmissible i vQ)

/-- The scale `a` of the actual local theta hull `a · O`. -/
noncomputable def thetaHullScale
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    (R.container.packet i vQ).Total :=
  Classical.choose (thetaHull_isHullRegion R i vQ)

/-- Every component of the theta-hull scale is nonzero. -/
theorem thetaHullScale_ne_zero
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    ∀ c, thetaHullScale R i vQ c ≠ 0 :=
  (Classical.choose_spec (thetaHull_isHullRegion R i vQ)).1

/-- The actual local theta hull is exactly the scaled integral region selected
above. -/
theorem thetaHull_region_eq_scaledIntegral
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    (R.thetaHull i).region vQ =
      (R.container.packet i vQ).scaledIntegral
        (thetaHullScale R i vQ) :=
  (Classical.choose_spec (thetaHull_isHullRegion R i vQ)).2

/-- The component region of the actual theta hull at a direct-sum component. -/
noncomputable def thetaHullComponentRegion
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace)
    (c : R.container.Components i vQ) :
    Set ((R.container.packet i vQ).Summand c) :=
  thetaHullScale R i vQ c •
    ((R.container.packet i vQ).integral c :
      Set ((R.container.packet i vQ).Summand c))

/-- The weighted component sum attached to the actual local theta hull. -/
noncomputable def thetaHullPacketComponentSum
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) : ℝ :=
  ∑ c : R.container.Components i vQ,
    R.vol.packetWeight i vQ c *
      R.vol.componentVol i vQ c
        (thetaHullComponentRegion R i vQ c)

/-- **Actual componentwise product formula.**  The packet volume of the
public theta hull is exactly the product-weighted sum of the log-volumes of
its scaled integral component regions. -/
theorem packetVol_thetaHull_eq_componentSum
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length)
    (vQ : RationalPlace) :
    R.vol.packetVol i vQ ((R.thetaHull i).region vQ) =
      thetaHullPacketComponentSum R i vQ := by
  rw [thetaHull_region_eq_scaledIntegral R i vQ]
  unfold thetaHullPacketComponentSum
  simpa only [thetaHullComponentRegion,
    DirectSumPresentation.scaledIntegral,
    DirectSumPresentation.productRegion] using
    (R.vol.packetVol_product' i vQ
      (fun c => thetaHullComponentRegion R i vQ c))

/-- The all-rational-place component sum for one capsule. -/
noncomputable def thetaHullGlobalComponentSum
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length) : ℝ :=
  ∑ᶠ vQ : RationalPlace, thetaHullPacketComponentSum R i vQ

/-- The public global volume of one actual theta hull is exactly its all-place
component sum. -/
theorem globalVol_thetaHull_eq_componentSum
    (R : RHSData.{u, v} D)
    (i : Fin R.container.proc.length) :
    R.vol.globalVol (R.thetaHull i) =
      thetaHullGlobalComponentSum R i := by
  unfold LogVolumeData.globalVol thetaHullGlobalComponentSum
  exact finsum_congr fun vQ =>
    packetVol_thetaHull_eq_componentSum R i vQ

/-- The procession average of the actual theta-hull component sums. -/
noncomputable def thetaHullProcessionComponentAverage
    (R : RHSData.{u, v} D) : ℝ :=
  (∑ i : Fin R.container.proc.length,
      thetaHullGlobalComponentSum R i) /
    (R.container.proc.length : ℝ)

/-- **Complete actual RHS formula.**  The public theta right-hand side is
exactly the procession average of the all-place, product-weighted component
log-volumes selected by the holomorphic hull. -/
theorem rhs_eq_thetaHullProcessionComponentAverage
    (R : RHSData.{u, v} D) :
    R.rhs = thetaHullProcessionComponentAverage R := by
  calc
    R.rhs =
        (∑ i : Fin R.container.proc.length,
          R.vol.globalVol (R.thetaHull i)) /
          (R.container.proc.length : ℝ) := by
      rfl
    _ = thetaHullProcessionComponentAverage R := by
      unfold thetaHullProcessionComponentAverage
      congr 1
      exact Finset.sum_congr rfl fun i _ =>
        globalVol_thetaHull_eq_componentSum R i

/-- The public theta coefficient, read from the actual public RHS and the
actual root-normalized public q-pilot. -/
noncomputable def publicThetaCoefficient
    (X : Corollary312VariantData.{u, v} AG TG) : ℝ :=
  X.rhsData.rhs / X.qPilot.absLogQ

/-- The public theta coefficient is the explicit componentwise procession
average divided by the public q-logarithm. -/
theorem publicThetaCoefficient_eq_componentAverage
    (X : Corollary312VariantData.{u, v} AG TG) :
    publicThetaCoefficient X =
      thetaHullProcessionComponentAverage X.rhsData /
        X.qPilot.absLogQ := by
  rw [publicThetaCoefficient,
    rhs_eq_thetaHullProcessionComponentAverage]

/-- Corollary 3.12 gives the lower coefficient bound directly for the public
componentwise coefficient. -/
theorem publicThetaCoefficient_ge_neg_one
    (X : Corollary312VariantData.{u, v} AG TG)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : Corollary312Variant X) :
    -1 ≤ publicThetaCoefficient X := by
  rw [publicThetaCoefficient]
  apply (le_div_iff₀ hq).2
  change (-1 : ℝ) * X.qPilot.absLogQ ≤ X.rhsData.rhs
  change X.qPilot.lhs ≤ X.rhsData.rhs at h312
  simpa [QPilotData.lhs] using h312

/-- Source-faithful coefficient extraction.  An upper coefficient inequality,
rather than an artificially strengthened equality, is sufficient to recover
the q-bound. -/
theorem qTerm_le_main_of_thetaCoefficient_upper
    {CTheta factor main qCoeff rawQ : ℝ}
    (hfactor : 0 < factor)
    (hlower : -1 ≤ CTheta)
    (hupper :
      CTheta ≤ factor * (main - qCoeff * rawQ) - 1) :
    qCoeff * rawQ ≤ main := by
  nlinarith

/-- Public specialization of the preceding extraction theorem. -/
theorem qTerm_le_main_of_publicThetaCoefficient_upper
    (X : Corollary312VariantData.{u, v} AG TG)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : Corollary312Variant X)
    {factor main qCoeff rawQ : ℝ}
    (hfactor : 0 < factor)
    (hupper :
      publicThetaCoefficient X ≤
        factor * (main - qCoeff * rawQ) - 1) :
    qCoeff * rawQ ≤ main :=
  qTerm_le_main_of_thetaCoefficient_upper hfactor
    (publicThetaCoefficient_ge_neg_one X hq h312) hupper

end IUTThreeClosures
