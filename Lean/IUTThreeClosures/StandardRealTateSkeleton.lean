/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.RadialSkeletonOrbitPresentation
import Mathlib.Topology.Covering.AddCircle

/-!
# The standard real Tate skeleton and its circle quotient

The normalized skeleton of a Tate annulus is the real line.  The deck
generator acts by translation by one, and the quotient is the unit additive
circle.  This module constructs that model without any abstract presentation
fields and records the standard covering-map and proper-discontinuity theorems
already available in Mathlib.

The remaining analytic comparison theorem is not the topology of the model:
it is the geometric construction of an equivariant deformation retraction from
the actual Berkovich theta-root space onto this standard real skeleton.
-/

namespace IUTThreeClosures

open AddSubgroup

namespace StandardRealTateSkeleton

/-- Integer translation on the normalized real skeleton. -/
def shift (k : ℤ) (x : ℝ) : ℝ := x + (k : ℝ)

@[simp]
theorem shift_zero (x : ℝ) : shift 0 x = x := by
  simp [shift]

@[simp]
theorem shift_add (m n : ℤ) (x : ℝ) :
    shift m (shift n x) = shift (n + m) x := by
  simp [shift]
  ring

@[simp]
theorem coordinate_shift (k : ℤ) (x : ℝ) :
    shift k x = x + (k : ℝ) :=
  rfl

/-- Equality in `ℝ/ℤ` is precisely integer translation on `ℝ`. -/
theorem circle_eq_iff_exists_shift (x y : ℝ) :
    (x : UnitAddCircle) = (y : UnitAddCircle) ↔
      ∃ k : ℤ, shift k x = y := by
  constructor
  · intro h
    rw [AddCircle.coe_eq_coe_iff] at h
    rcases h with ⟨k, hk⟩
    refine ⟨k, ?_⟩
    simpa [shift] using hk
  · rintro ⟨k, rfl⟩
    change (x : UnitAddCircle) = ((x + (k : ℝ) : ℝ) : UnitAddCircle)
    simp

/-- Concrete source-facing radial presentation carried by the real line. -/
noncomputable def presentation : RadialSkeletonPresentation ℝ where
  shift := shift
  coordinate := id
  shift_zero := shift_zero
  shift_add := shift_add
  coordinate_shift := by
    intro k x
    rfl
  coordinate_surjective := Function.surjective_id
  orbit_complete := by
    intro x y h
    exact (circle_eq_iff_exists_shift x y).1 h

/-- Orbit classes of the standard real skeleton are the circle. -/
noncomputable def orbitEquivCircle :
    presentation.OrbitClasses ≃ UnitAddCircle :=
  presentation.orbitClassesEquivCircle

/-- The transported orbit topology is homeomorphic to the standard circle. -/
noncomputable def orbitHomeomorphCircle :
    @Homeomorph presentation.OrbitClasses UnitAddCircle
      presentation.orbitClassTopology inferInstance :=
  presentation.orbitClassesHomeomorphCircle

/-- The standard quotient projection `ℝ → ℝ/ℤ` is a covering map. -/
theorem quotientProjection_isCoveringMap :
    IsCoveringMap (AddCircle.mk' (1 : ℝ)) := by
  exact AddCircle.isCoveringMap_mk' (1 : ℝ)

/-- Integer translation on the real skeleton is properly discontinuous. -/
theorem integerTranslation_properlyDiscontinuous :
    ProperlyDiscontinuousVAdd (zmultiples (1 : ℝ)).op ℝ :=
  inferInstance

/-- The quotient circle is compact. -/
theorem quotientCircle_compact : CompactSpace UnitAddCircle :=
  inferInstance

/-- The canonical deck translation has no fixed point. -/
theorem shift_one_ne (x : ℝ) : shift 1 x ≠ x := by
  intro h
  simp [shift] at h

/-- Every nonzero integer deck translation has no fixed point. -/
theorem shift_ne_of_ne_zero {k : ℤ} (hk : k ≠ 0) (x : ℝ) :
    shift k x ≠ x := by
  intro h
  have : (k : ℝ) = 0 := by
    dsimp [shift] at h
    linarith
  exact hk (by exact_mod_cast this)

/-- The quotient map is invariant under every deck translation. -/
theorem quotientProjection_shift (k : ℤ) (x : ℝ) :
    AddCircle.mk' (1 : ℝ) (shift k x) =
      AddCircle.mk' (1 : ℝ) x := by
  change ((x + (k : ℝ) : ℝ) : UnitAddCircle) =
    (x : UnitAddCircle)
  simp

end StandardRealTateSkeleton

end IUTThreeClosures
