/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PuncturedTorsionCover
import IUTThreeClosures.ActionGroupoidPullbackMorphisms

/-!
# The stacky sign-groupoid pullback of the punctured torsion cover

The coarse orbit-set square for multiplication by `n` fails at sign-fixed
branch points.  The correct replacement retains the sign transporter as a
morphism in the action groupoid.

This file constructs the two-element sign group explicitly, lets it act by
`x ↦ x` and `x ↦ -x` on an additive commutative group, restricts the action to

`A \ A[n]` and `A \ {0}`,

and proves that the punctured multiplication-by-`n` map is equivariant.  The
general action-groupoid pullback theorem then specializes to this actual
cover: the weak pullback groupoid is equivalent to the discrete groupoid on
the punctured source, both on isomorphism classes and on morphism types.

This is the object/groupoid core of the 2-cartesian orbicurve square.  The
remaining algebro-geometric work is to realize these carriers as curves or
analytic spaces and transport the groupoid statement to étale and tempered
fundamental groups.
-/

namespace IUTThreeClosures

universe u

/-- The two signs as a concrete multiplicative group. -/
inductive Sign where
  | positive
  | negative
  deriving DecidableEq

namespace Sign

/-- Multiplication of signs. -/
def mul : Sign → Sign → Sign
  | .positive, s => s
  | .negative, .positive => .negative
  | .negative, .negative => .positive

instance : Group Sign where
  one := .positive
  mul := mul
  inv := id
  one_mul := by intro s; cases s <;> rfl
  mul_one := by intro s; cases s <;> rfl
  mul_assoc := by
    intro a b c
    cases a <;> cases b <;> cases c <;> rfl
  inv_mul_cancel := by
    intro s
    cases s <;> rfl

@[simp]
theorem positive_mul (s : Sign) :
    Sign.positive * s = s := by
  cases s <;> rfl

@[simp]
theorem negative_mul_positive :
    Sign.negative * Sign.positive = Sign.negative :=
  rfl

@[simp]
theorem negative_mul_negative :
    Sign.negative * Sign.negative = Sign.positive :=
  rfl

@[simp]
theorem inv_eq_self (s : Sign) : s⁻¹ = s :=
  rfl

end Sign

namespace PuncturedTorsionSignGroupoid

open PuncturedTorsionCover

variable (A : Type u) [AddCommGroup A]
variable (n : ℕ)

/-- The sign action on the ambient additive group. -/
def ambientAction : Sign → A → A
  | .positive, x => x
  | .negative, x => -x

instance ambientMulAction : MulAction Sign A where
  smul := ambientAction A
  one_smul := by
    intro x
    rfl
  mul_smul := by
    intro s t x
    cases s <;> cases t <;> simp [ambientAction, Sign.mul]

@[simp]
theorem positive_smul (x : A) :
    Sign.positive • x = x :=
  rfl

@[simp]
theorem negative_smul (x : A) :
    Sign.negative • x = -x :=
  rfl

/-- The punctured source is invariant under the sign action. -/
theorem source_smul_mem
    (s : Sign) (x : source A n) :
    s • (x : A) ∈ source A n := by
  cases s
  · exact x.property
  · exact (neg_mem_source_iff A n x).2 x.property

/-- The punctured target is invariant under the sign action. -/
theorem base_smul_mem
    (s : Sign) (x : base A) :
    s • (x : A) ∈ base A := by
  cases s
  · exact x.property
  · exact (neg_mem_base_iff A x).2 x.property

/-- Restricted sign action on the punctured source. -/
instance sourceMulAction : MulAction Sign (source A n) where
  smul s x := ⟨s • (x : A), source_smul_mem A n s x⟩
  one_smul := by
    intro x
    apply Subtype.ext
    simp
  mul_smul := by
    intro s t x
    apply Subtype.ext
    simp [mul_smul]

/-- Restricted sign action on the once-punctured target. -/
instance baseMulAction : MulAction Sign (base A) where
  smul s x := ⟨s • (x : A), base_smul_mem A s x⟩
  one_smul := by
    intro x
    apply Subtype.ext
    simp
  mul_smul := by
    intro s t x
    apply Subtype.ext
    simp [mul_smul]

@[simp]
theorem source_smul_coe
    (s : Sign) (x : source A n) :
    ((s • x : source A n) : A) = s • (x : A) :=
  rfl

@[simp]
theorem base_smul_coe
    (s : Sign) (x : base A) :
    ((s • x : base A) : A) = s • (x : A) :=
  rfl

/-- Multiplication by `n` commutes with the sign action. -/
theorem map_equivariant
    (s : Sign) (x : source A n) :
    map A n (s • x) = s • map A n x := by
  apply Subtype.ext
  cases s <;> simp [map, ambientAction]

/-- Objects of the actual weak pullback groupoid for the punctured torsion
cover and sign action. -/
abbrev PullbackObject :=
  ActionGroupoidPullbackObject
    Sign (source A n) (base A) (map A n)

/-- Isomorphism classes of the weak stacky pullback recover exactly the
punctured source. -/
noncomputable def pullbackClassesEquivSource :
    ActionGroupoidPullbackObject.Classes (map A n) ≃ source A n :=
  ActionGroupoidPullbackObject.classesEquivSource (map A n)

/-- The normalized point of a weak-pullback object maps to its selected atlas
point. -/
theorem map_normalize
    (P : PullbackObject A n) :
    map A n (P.normalize (map A n)) = P.atlasPoint :=
  P.map_normalize (map A n) (map_equivariant A n)

/-- Morphisms in the weak pullback are equivalent to equality of normalized
source points.  In particular they are unique whenever they exist. -/
noncomputable def pullbackHomEquivNormalizeEquality
    (P Q : PullbackObject A n) :
    ActionGroupoidPullbackHom P Q ≃
      PLift
        (P.normalize (map A n) = Q.normalize (map A n)) :=
  ActionGroupoidPullbackHom.homEquivNormalizeEquality
    (map_equivariant A n)

/-- Existence of a pullback morphism is exactly equality of normalized source
points. -/
theorem pullbackHom_nonempty_iff
    (P Q : PullbackObject A n) :
    Nonempty (ActionGroupoidPullbackHom P Q) ↔
      P.normalize (map A n) = Q.normalize (map A n) :=
  ActionGroupoidPullbackHom.nonempty_iff_normalize_eq
    (map_equivariant A n)

/-- The weak pullback groupoid is thin: every morphism type is a subsingleton. -/
instance pullbackHom_subsingleton
    (P Q : PullbackObject A n) :
    Subsingleton (ActionGroupoidPullbackHom P Q) :=
  inferInstance

end PuncturedTorsionSignGroupoid

end IUTThreeClosures
