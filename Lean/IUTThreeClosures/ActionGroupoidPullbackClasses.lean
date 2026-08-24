/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.StackySignLift

/-!
# Isomorphism classes of an action-groupoid pullback

The coarse quotient counterexample is repaired by retaining the group element
that identifies an image with the chosen atlas point.  This file proves the
corresponding statement for an arbitrary equivariant map of group actions.

Let a group `G` act on `X` and `Y`, and let `f : X → Y` be equivariant.  An
object of the weak pullback of the quotient-groupoid map `[X/G] → [Y/G]`
along the atlas `Y → [Y/G]` consists of

* `x : X`;
* `y : Y`;
* `g : G`;
* an equality `g • f(x) = y`.

Its normalized source point is `g • x`; equivariance implies that this point
maps exactly to `y`.  Two weak-pullback objects are isomorphic precisely at
the level relevant here when their normalized source points agree.  Quotienting
by this relation yields a type canonically equivalent to `X`.

This is the object/isomorphism-class shadow of the standard 2-cartesian square
for quotient stacks.  It gives a positive replacement for the coarse orbit-set
square excluded by `OrbifoldQuotientNecessity`.  A full orbicurve construction
still requires the groupoid/category topology, finite étale covers, and
fundamental groups.
-/

namespace IUTThreeClosures

universe u v w

/-- Objects of the weak pullback of an equivariant quotient-groupoid map along
the target atlas. -/
structure ActionGroupoidPullbackObject
    (G : Type u) (X : Type v) (Y : Type w)
    [Group G] [MulAction G X] [MulAction G Y]
    (f : X → Y) where
  source : X
  atlasPoint : Y
  transporter : G
  commutes : transporter • f source = atlasPoint

namespace ActionGroupoidPullbackObject

variable {G : Type u} {X : Type v} {Y : Type w}
variable [Group G] [MulAction G X] [MulAction G Y]
variable (f : X → Y)
variable (hf : ∀ (g : G) (x : X), f (g • x) = g • f x)

/-- Normalize a weak-pullback object by applying its retained transporter to
the source point. -/
def normalize
    (P : ActionGroupoidPullbackObject G X Y f) : X :=
  P.transporter • P.source

/-- The normalized point maps to the chosen atlas point. -/
theorem map_normalize
    (P : ActionGroupoidPullbackObject G X Y f) :
    f (P.normalize f) = P.atlasPoint := by
  rw [normalize, hf]
  exact P.commutes

/-- Canonical weak-pullback object attached to an ordinary source point. -/
def ofSource (x : X) :
    ActionGroupoidPullbackObject G X Y f where
  source := x
  atlasPoint := f x
  transporter := 1
  commutes := by simp

@[simp]
theorem normalize_ofSource (x : X) :
    (ofSource f x).normalize f = x := by
  simp [normalize, ofSource]

/-- Setoid identifying weak-pullback objects with the same normalized source
point.  This is the isomorphism-class relation needed for the 2-pullback
comparison. -/
def normalizedSetoid :
    Setoid (ActionGroupoidPullbackObject G X Y f) where
  r P Q := P.normalize f = Q.normalize f
  iseqv := {
    refl := fun _ => rfl
    symm := fun h => h.symm
    trans := fun h₁ h₂ => h₁.trans h₂
  }

/-- Isomorphism classes of the weak action-groupoid pullback. -/
abbrev Classes :=
  Quotient (normalizedSetoid f)

/-- The normalized source point descends to isomorphism classes. -/
def classesToSource : Classes f → X :=
  Quotient.lift (normalize f) (fun _ _ h => h)

/-- Embed an ordinary source point into the weak-pullback classes. -/
def sourceToClasses (x : X) : Classes f :=
  Quotient.mk (normalizedSetoid f) (ofSource f x)

@[simp]
theorem classesToSource_sourceToClasses (x : X) :
    classesToSource f (sourceToClasses f x) = x := by
  rfl

/-- Every weak-pullback object is isomorphic, in the normalized relation, to
the canonical object attached to its normalized source point. -/
theorem sourceToClasses_classesToSource (P : Classes f) :
    sourceToClasses f (classesToSource f P) = P := by
  refine Quotient.inductionOn P ?_
  intro Q
  apply Quotient.sound
  change (ofSource f (Q.normalize f)).normalize f = Q.normalize f
  simp

/-- The weak action-groupoid pullback recovers the source type on isomorphism
classes. -/
def classesEquivSource : Classes f ≃ X where
  toFun := classesToSource f
  invFun := sourceToClasses f
  left_inv := sourceToClasses_classesToSource f
  right_inv := classesToSource_sourceToClasses f

end ActionGroupoidPullbackObject

end IUTThreeClosures
