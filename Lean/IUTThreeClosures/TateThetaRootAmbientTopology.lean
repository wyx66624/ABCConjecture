/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootCompactProperness
import Mathlib.Topology.Algebra.Group.Units

/-!
# The ambient topology on the corrected Tate theta-root locus

A point of the corrected theta-root locus consists of

`(v,y) in K^x x K`

satisfying `y^ell = thetaProd(v^ell)`.  This file equips the point type with
the topology induced by the ambient product `K^x x K`.  In this concrete
topology we prove:

* the base and root coordinate maps are continuous;
* the corrected deck generator and its inverse are continuous, hence form a
  homeomorphism;
* the normalized logarithmic radial coordinate is continuous;
* therefore the complete integer deck action satisfies compact-intersection
  properness by the already verified two-sided radial theorem.

This closes the ordinary topological proper-discontinuity step for the actual
point equation.  It does not assert that the resulting topological space is a
Berkovich analytic space, nor identify its quotient with an orbicurve or its
tempered fundamental group.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPullbackPoint

variable (t : TateParameter K) (ell : ℕ)

/-- The faithful ambient-coordinate map of the corrected theta-root locus. -/
def toAmbient
    (z : TateThetaRootPullbackPoint t ell) : Kˣ × K :=
  (z.base, z.root)

/-- The ambient-coordinate map is injective. -/
theorem toAmbient_injective :
    Function.Injective (toAmbient t ell) := by
  intro x y h
  apply TateThetaRootPullbackPoint.ext
  · exact congrArg Prod.fst h
  · exact congrArg Prod.snd h

/-- The genuine subspace topology inherited from `K^x x K`. -/
noncomputable instance instTopologicalSpace :
    TopologicalSpace (TateThetaRootPullbackPoint t ell) :=
  TopologicalSpace.induced (toAmbient t ell) inferInstance

/-- The ambient-coordinate map is continuous by construction. -/
@[fun_prop]
theorem continuous_toAmbient :
    Continuous (toAmbient t ell) :=
  continuous_induced_dom

/-- The base-unit coordinate is continuous. -/
@[fun_prop]
theorem continuous_base :
    Continuous (fun z : TateThetaRootPullbackPoint t ell => z.base) :=
  continuous_fst.comp (continuous_toAmbient t ell)

/-- The root coordinate is continuous. -/
@[fun_prop]
theorem continuous_root :
    Continuous (fun z : TateThetaRootPullbackPoint t ell => z.root) :=
  continuous_snd.comp (continuous_toAmbient t ell)

/-- The value of the base unit in the ambient field is continuous. -/
@[fun_prop]
theorem continuous_base_val :
    Continuous (fun z : TateThetaRootPullbackPoint t ell => (z.base : K)) :=
  Units.continuous_val.comp (continuous_base t ell)

/-- The corrected forward deck transformation is continuous. -/
theorem continuous_shift
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Continuous (shift t ell r hr) := by
  apply continuous_induced_rng.mpr
  change Continuous fun z : TateThetaRootPullbackPoint t ell =>
    (r * z.base,
      (((r * z.base : Kˣ) : K)⁻¹) * z.root)
  have hbase :
      Continuous (fun z : TateThetaRootPullbackPoint t ell => r * z.base) :=
    continuous_const.mul (continuous_base t ell)
  have hinv :
      Continuous (fun z : TateThetaRootPullbackPoint t ell =>
        (((r * z.base : Kˣ) : K)⁻¹)) := by
    simpa using Units.continuous_coe_inv.comp hbase
  exact hbase.prod_mk (hinv.mul (continuous_root t ell))

/-- The corrected inverse deck transformation is continuous. -/
theorem continuous_shiftInv
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Continuous (shiftInv t ell r hr) := by
  apply continuous_induced_rng.mpr
  change Continuous fun z : TateThetaRootPullbackPoint t ell =>
    (r⁻¹ * z.base, (z.base : K) * z.root)
  have hbase :
      Continuous (fun z : TateThetaRootPullbackPoint t ell => r⁻¹ * z.base) :=
    continuous_const.mul (continuous_base t ell)
  exact hbase.prod_mk
    ((continuous_base_val t ell).mul (continuous_root t ell))

/-- The corrected deck generator is a homeomorphism of the actual topological
root locus. -/
noncomputable def shiftHomeomorph
    (r : Kˣ) (hr : r ^ ell = t.q) :
    TateThetaRootPullbackPoint t ell ≃ₜ
      TateThetaRootPullbackPoint t ell where
  __ := shiftEquiv t ell r hr
  continuous_toFun := continuous_shift t ell r hr
  continuous_invFun := continuous_shiftInv t ell r hr

/-- The norm of the base coordinate is continuous. -/
@[fun_prop]
theorem continuous_base_norm :
    Continuous (fun z : TateThetaRootPullbackPoint t ell => ‖(z.base : K)‖) :=
  continuous_norm.comp (continuous_base_val t ell)

/-- The logarithmic base norm is continuous because a unit never has zero
norm. -/
@[fun_prop]
theorem continuous_log_base_norm :
    Continuous
      (fun z : TateThetaRootPullbackPoint t ell =>
        Real.log ‖(z.base : K)‖) := by
  apply Continuous.log (continuous_base_norm t ell)
  intro z
  exact norm_ne_zero_iff.mpr (Units.ne_zero z.base)

/-- The normalized radial coordinate is continuous in the actual ambient
subspace topology. -/
theorem continuous_radialCoordinate
    (r : Kˣ) :
    Continuous (TateThetaRootRadialSkeleton.coordinate t ell r) := by
  unfold TateThetaRootRadialSkeleton.coordinate
  exact (continuous_log_base_norm t ell).div_const _

/-- The actual ambient topology therefore satisfies compact-intersection
properness for the full integer deck action. -/
theorem compactIntersectionProper
    (r : Kˣ) (hr : r ^ ell = t.q) :
    TateThetaRootRadialSkeleton.CompactIntersectionProper
      t ell r hr :=
  TateThetaRootRadialSkeleton.compactIntersectionProper_of_continuous_coordinate
    t ell r hr (continuous_radialCoordinate t ell r)

end TateThetaRootPullbackPoint

end IUTThreeClosures
