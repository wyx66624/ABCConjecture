/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootOrbitLocalFiniteness
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# The compact topological quotient of the radial theta-root skeleton

The all-integer corrected theta-root deck action sends the normalized radial
coordinate to `rho+n`.  The quotient of the real radial line by integer
translation is the unit additive circle `ℝ/ℤ`, which Mathlib already equips
with its compact quotient topology and a properly discontinuous translation
action on the covering line.

This module defines the canonical radial quotient map and proves that it is
constant on every complete theta-root deck orbit.  It therefore constructs the
topological quotient of the radial skeleton itself.  It does not claim that
the full theta-root analytic locus is determined by this one real coordinate;
the Berkovich retraction/fiber theorem remains the source-facing analytic
step.
-/

namespace IUTThreeClosures

open TateCurvesTheta AddSubgroup

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialQuotient

/-- The compact radial skeleton quotient. -/
abbrev RadialCircle := UnitAddCircle

/-- The actual theta-root point mapped to its logarithmic radial coordinate
modulo integer translation. -/
noncomputable def radialCircle
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : RadialCircle :=
  TateThetaRootRadialSkeleton.coordinate t ell r z

/-- Integer translation is trivial in the unit additive circle. -/
theorem coe_add_int_eq
    (x : ℝ) (n : ℤ) :
    ((x + (n : ℝ) : ℝ) : UnitAddCircle) = (x : UnitAddCircle) := by
  change AddCircle.mk (1 : ℝ) (x + (n : ℝ)) =
    AddCircle.mk (1 : ℝ) x
  apply QuotientAddGroup.eq_iff_sub_mem.mpr
  change x + (n : ℝ) - x ∈ zmultiples (1 : ℝ)
  simpa using (zmultiples (1 : ℝ)).intCast_mem n

/-- The radial quotient map is invariant under every integer theta-root deck
iterate. -/
theorem radialCircle_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ) (z : TateThetaRootPullbackPoint t ell) :
    radialCircle t ell r
        (TateThetaRootIntegerAction.shiftInt t ell r hr n z) =
      radialCircle t ell r z := by
  unfold radialCircle
  rw [TateThetaRootIntegerAction.coordinate_shiftInt]
  exact coe_add_int_eq _ _

/-- The radial quotient is compact. -/
theorem compact_univ_radialCircle :
    IsCompact (Set.univ : Set RadialCircle) :=
  isCompact_univ

/-- Integer translation on the covering radial line is properly discontinuous.
This is the standard Mathlib instance behind the additive-circle quotient. -/
theorem radial_integer_translation_properlyDiscontinuous :
    ProperlyDiscontinuousVAdd (zmultiples (1 : ℝ)).op ℝ :=
  inferInstance

end TateThetaRootRadialQuotient

end IUTThreeClosures
