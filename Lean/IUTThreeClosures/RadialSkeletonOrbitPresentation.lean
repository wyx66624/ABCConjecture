/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootIntegerOrbitQuotient
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# A source-facing presentation theorem for a radial Berkovich skeleton

The arithmetic theta-root development already proves that the corrected deck
generator translates the normalized logarithmic radius by one on all integer
iterates.  To identify an actual analytic or Berkovich quotient with a circle,
one still needs two genuinely geometric facts:

* every real radial value is represented by a skeleton point;
* two skeleton points with the same value modulo `ℤ` differ by a deck
  transformation.

This module isolates precisely those facts in `RadialSkeletonPresentation` and
proves all remaining quotient consequences.  The orbit relation is exactly
equality of radial coordinates in `ℝ/ℤ`; its quotient is canonically equivalent
to the unit additive circle.  Equipping the orbit classes with the topology
transported by this equivalence yields a compact topological circle.

No Berkovich skeleton or analytic deformation retraction is manufactured here.
An actual geometric construction must instantiate the presentation fields.
-/

namespace IUTThreeClosures

open AddSubgroup

universe u

/-- A complete radial-skeleton presentation for a free integer deck action.

The fields are source-facing rather than target-facing: they specify the
actual deck action, an actual real radial coordinate, its translation law,
surjectivity of the coordinate, and completeness of the orbit coordinate.
No quotient, compactness, fundamental group, or cyclic target is stored. -/
structure RadialSkeletonPresentation (S : Type u) where
  shift : ℤ → S → S
  coordinate : S → ℝ
  shift_zero : ∀ x, shift 0 x = x
  shift_add : ∀ m n x, shift m (shift n x) = shift (n + m) x
  coordinate_shift :
    ∀ k x, coordinate (shift k x) = coordinate x + (k : ℝ)
  coordinate_surjective : Function.Surjective coordinate
  orbit_complete :
    ∀ x y,
      ((coordinate x : UnitAddCircle) =
        (coordinate y : UnitAddCircle)) →
      ∃ k : ℤ, shift k x = y

namespace RadialSkeletonPresentation

variable {S : Type u} (P : RadialSkeletonPresentation S)

/-- Equality of radial coordinates modulo integer translation. -/
def orbitSetoid : Setoid S where
  r x y :=
    ((P.coordinate x : UnitAddCircle) =
      (P.coordinate y : UnitAddCircle))
  iseqv := {
    refl := fun _ => rfl
    symm := fun h => h.symm
    trans := fun h₁ h₂ => h₁.trans h₂
  }

/-- Classes of the integer deck action. -/
abbrev OrbitClasses := Quotient P.orbitSetoid

/-- Every actual integer deck translate belongs to the same radial orbit
class. -/
theorem related_of_shift (k : ℤ) (x : S) :
    P.orbitSetoid.r x (P.shift k x) := by
  change
    (P.coordinate x : UnitAddCircle) =
      (P.coordinate (P.shift k x) : UnitAddCircle)
  rw [P.coordinate_shift]
  change
    (P.coordinate x : UnitAddCircle) =
      ((P.coordinate x + (k : ℝ) : ℝ) : UnitAddCircle)
  simp

/-- The radial equivalence relation is exactly the actual deck-orbit
relation. -/
theorem related_iff_exists_shift (x y : S) :
    P.orbitSetoid.r x y ↔ ∃ k : ℤ, P.shift k x = y := by
  constructor
  · exact P.orbit_complete x y
  · rintro ⟨k, rfl⟩
    exact P.related_of_shift k x

/-- The circle-valued radial coordinate descends to orbit classes. -/
noncomputable def classesToCircle : P.OrbitClasses → UnitAddCircle :=
  Quotient.lift
    (fun x : S => (P.coordinate x : UnitAddCircle))
    (fun _ _ h => h)

/-- Choose an actual skeleton point over a circle coordinate. -/
noncomputable def circleToClasses (z : UnitAddCircle) : P.OrbitClasses := by
  let r : ℝ := Classical.choose (AddCircle.surjective_mk' (1 : ℝ) z)
  have hr : (r : UnitAddCircle) = z :=
    Classical.choose_spec (AddCircle.surjective_mk' (1 : ℝ) z)
  let x : S := Classical.choose (P.coordinate_surjective r)
  exact Quotient.mk P.orbitSetoid x

@[simp]
theorem classesToCircle_circleToClasses (z : UnitAddCircle) :
    P.classesToCircle (P.circleToClasses z) = z := by
  unfold circleToClasses classesToCircle
  simp only [Quotient.lift_mk]
  let r : ℝ := Classical.choose (AddCircle.surjective_mk' (1 : ℝ) z)
  have hr : (r : UnitAddCircle) = z :=
    Classical.choose_spec (AddCircle.surjective_mk' (1 : ℝ) z)
  let x : S := Classical.choose (P.coordinate_surjective r)
  have hx : P.coordinate x = r :=
    Classical.choose_spec (P.coordinate_surjective r)
  simpa [r, x, hx] using hr

@[simp]
theorem circleToClasses_classesToCircle (q : P.OrbitClasses) :
    P.circleToClasses (P.classesToCircle q) = q := by
  refine Quotient.inductionOn q ?_
  intro x
  apply Quotient.sound
  change
    ((P.coordinate
        (Classical.choose
          (P.coordinate_surjective
            (Classical.choose
              (AddCircle.surjective_mk' (1 : ℝ)
                (P.coordinate x : UnitAddCircle))))) : UnitAddCircle) =
      (P.coordinate x : UnitAddCircle))
  let r : ℝ :=
    Classical.choose
      (AddCircle.surjective_mk' (1 : ℝ)
        (P.coordinate x : UnitAddCircle))
  have hr : (r : UnitAddCircle) =
      (P.coordinate x : UnitAddCircle) :=
    Classical.choose_spec
      (AddCircle.surjective_mk' (1 : ℝ)
        (P.coordinate x : UnitAddCircle))
  let y : S := Classical.choose (P.coordinate_surjective r)
  have hy : P.coordinate y = r :=
    Classical.choose_spec (P.coordinate_surjective r)
  simpa [r, y, hy] using hr

/-- The integer deck-orbit classes are canonically the unit additive circle. -/
noncomputable def orbitClassesEquivCircle :
    P.OrbitClasses ≃ UnitAddCircle where
  toFun := P.classesToCircle
  invFun := P.circleToClasses
  left_inv := P.circleToClasses_classesToCircle
  right_inv := P.classesToCircle_circleToClasses

/-- Topology transported from the unit circle to the actual deck-orbit
classes.  A Berkovich quotient theorem should prove that its intrinsic quotient
topology agrees with this transported topology. -/
noncomputable def orbitClassTopology : TopologicalSpace P.OrbitClasses :=
  TopologicalSpace.induced P.orbitClassesEquivCircle inferInstance

/-- With the transported topology, the radial orbit quotient is
homeomorphic to `ℝ/ℤ`. -/
noncomputable def orbitClassesHomeomorphCircle :
    @Homeomorph P.OrbitClasses UnitAddCircle
      P.orbitClassTopology inferInstance :=
  { P.orbitClassesEquivCircle with
    continuous_toFun := continuous_induced_dom
    continuous_invFun := by
      rw [continuous_induced_iff]
      simpa using continuous_id }

/-- The transported orbit quotient is compact. -/
theorem compact_orbitClasses :
    @CompactSpace P.OrbitClasses P.orbitClassTopology := by
  let h :
      @Homeomorph P.OrbitClasses UnitAddCircle
        P.orbitClassTopology inferInstance :=
    P.orbitClassesHomeomorphCircle
  exact h.compactSpace

/-- Distinct integer translates of one skeleton point are distinct. -/
theorem shift_injective_index (x : S) :
    Function.Injective (fun k : ℤ => P.shift k x) := by
  intro m n h
  have hc := congrArg P.coordinate h
  rw [P.coordinate_shift, P.coordinate_shift] at hc
  have hreal : (m : ℝ) = n := by linarith
  exact_mod_cast hreal

/-- The presentation therefore supplies a free integer action at every
point. -/
theorem shift_ne_of_ne_index (x : S) {m n : ℤ} (hmn : m ≠ n) :
    P.shift m x ≠ P.shift n x := by
  intro h
  exact hmn (P.shift_injective_index x h)

end RadialSkeletonPresentation

end IUTThreeClosures
