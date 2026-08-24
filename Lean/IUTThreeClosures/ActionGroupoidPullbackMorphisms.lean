/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActionGroupoidPullbackClasses

/-!
# Morphisms in the action-groupoid pullback

The previous file identified isomorphism classes of the weak pullback with the
source type.  Here we retain the morphisms and prove the stronger groupoid
statement.

For weak-pullback objects

`P = (x, y, a : a • f(x) = y)`,
`Q = (x', y', b : b • f(x') = y')`,

a morphism is a group element `h` such that

`h • x = x'`, `y = y'`, and `b*h = a`.

Such a morphism exists exactly when the normalized source points

`a • x`, `b • x'`

are equal, and when it exists it is unique.  Hence the weak pullback groupoid
is equivalent to the discrete groupoid on `X`, not merely bijective on
isomorphism classes.  This is the elementary 2-cartesian theorem required by
the stacky sign-quotient construction.
-/

namespace IUTThreeClosures

universe u v w

/-- Morphisms in the weak pullback of an equivariant action-groupoid map along
the target atlas. -/
structure ActionGroupoidPullbackHom
    {G : Type u} {X : Type v} {Y : Type w}
    [Group G] [MulAction G X] [MulAction G Y]
    {f : X → Y}
    (P Q : ActionGroupoidPullbackObject G X Y f) where
  groupElement : G
  source_eq : groupElement • P.source = Q.source
  atlas_eq : P.atlasPoint = Q.atlasPoint
  coherence : Q.transporter * groupElement = P.transporter

namespace ActionGroupoidPullbackHom

variable {G : Type u} {X : Type v} {Y : Type w}
variable [Group G] [MulAction G X] [MulAction G Y]
variable {f : X → Y}
variable (hf : ∀ (g : G) (x : X), f (g • x) = g • f x)

variable {P Q R : ActionGroupoidPullbackObject G X Y f}

/-- Identity morphism. -/
def id (P : ActionGroupoidPullbackObject G X Y f) :
    ActionGroupoidPullbackHom P P where
  groupElement := 1
  source_eq := by simp
  atlas_eq := rfl
  coherence := by simp

/-- Composition of weak-pullback morphisms. -/
def comp
    (h : ActionGroupoidPullbackHom P Q)
    (k : ActionGroupoidPullbackHom Q R) :
    ActionGroupoidPullbackHom P R where
  groupElement := k.groupElement * h.groupElement
  source_eq := by
    rw [mul_smul, h.source_eq, k.source_eq]
  atlas_eq := h.atlas_eq.trans k.atlas_eq
  coherence := by
    rw [mul_assoc, k.coherence, h.coherence]

/-- Every weak-pullback morphism is invertible. -/
def inv
    (h : ActionGroupoidPullbackHom P Q) :
    ActionGroupoidPullbackHom Q P where
  groupElement := h.groupElement⁻¹
  source_eq := by
    rw [← h.source_eq]
    simp
  atlas_eq := h.atlas_eq.symm
  coherence := by
    have hc := h.coherence
    calc
      P.transporter * h.groupElement⁻¹ =
          (Q.transporter * h.groupElement) * h.groupElement⁻¹ := by
            rw [hc]
      _ = Q.transporter := by simp [mul_assoc]

/-- A morphism preserves the normalized source point. -/
theorem normalize_eq
    (h : ActionGroupoidPullbackHom P Q) :
    P.normalize f = Q.normalize f := by
  unfold ActionGroupoidPullbackObject.normalize
  calc
    P.transporter • P.source =
        (Q.transporter * h.groupElement) • P.source := by
          rw [h.coherence]
    _ = Q.transporter • (h.groupElement • P.source) := by
          rw [mul_smul]
    _ = Q.transporter • Q.source := by
          rw [h.source_eq]

/-- Equality of normalized source points constructs the unique pullback
morphism. -/
def ofNormalizeEq
    (h : P.normalize f = Q.normalize f) :
    ActionGroupoidPullbackHom P Q where
  groupElement := Q.transporter⁻¹ * P.transporter
  source_eq := by
    have h' := congrArg (fun x : X => Q.transporter⁻¹ • x) h
    simpa [ActionGroupoidPullbackObject.normalize, mul_smul] using h'
  atlas_eq := by
    rw [← P.map_normalize f hf, ← Q.map_normalize f hf, h]
  coherence := by
    simp [mul_assoc]

/-- The group element of a pullback morphism is forced by the two retained
transporters. -/
theorem groupElement_eq
    (h : ActionGroupoidPullbackHom P Q) :
    h.groupElement = Q.transporter⁻¹ * P.transporter := by
  calc
    h.groupElement = 1 * h.groupElement := by simp
    _ = (Q.transporter⁻¹ * Q.transporter) * h.groupElement := by simp
    _ = Q.transporter⁻¹ * (Q.transporter * h.groupElement) := by
          rw [mul_assoc]
    _ = Q.transporter⁻¹ * P.transporter := by
          rw [h.coherence]

/-- Pullback morphisms are unique. -/
instance : Subsingleton (ActionGroupoidPullbackHom P Q) where
  allEq h k := by
    cases h
    cases k
    congr
    exact groupElement_eq hf _ |>.trans (groupElement_eq hf _).symm

/-- A pullback morphism exists exactly when the normalized source points are
equal. -/
theorem nonempty_iff_normalize_eq :
    Nonempty (ActionGroupoidPullbackHom P Q) ↔
      P.normalize f = Q.normalize f := by
  constructor
  · rintro ⟨h⟩
    exact h.normalize_eq hf
  · intro h
    exact ⟨ofNormalizeEq hf h⟩

/-- The morphism type is equivalent to the proposition that normalized source
points agree. -/
def homEquivNormalizeEquality :
    ActionGroupoidPullbackHom P Q ≃
      PLift (P.normalize f = Q.normalize f) where
  toFun h := ⟨h.normalize_eq hf⟩
  invFun h := ofNormalizeEq hf h.down
  left_inv := by
    intro h
    exact Subsingleton.elim _ _
  right_inv := by
    rintro ⟨h⟩
    rfl

end ActionGroupoidPullbackHom

end IUTThreeClosures
