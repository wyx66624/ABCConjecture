/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TemperedCycleSkeleton

/-!
# From an actual skeleton identification to the public cyclic quotient

Once the rank-one quotient attached to a genuine tempered/orbicurve model is
identified with the oriented deck transformations of its `ell`-cycle
skeleton, the required public equivalence with `ZMod ell` is canonical.  This
module records that final transport and the corresponding canonical quotient
element.

The source-facing analytic theorem is therefore isolated as an equivalence

`Q ≃ OrientedCycleDeck ell`.

No cyclic-coordinate choices remain after that equivalence is supplied.
-/

namespace IUTThreeClosures

universe u

/-- Canonical `ZMod ell` coordinate on any quotient identified with the
oriented `ell`-cycle deck transformations. -/
def rankOneQuotientEquivZMod
    {Q : Type u} {ell : ℕ}
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) :
    Q ≃ ZMod ell :=
  skeletonEquiv.trans OrientedCycleDeck.deckEquivZMod

/-- The quotient element corresponding to the canonical translation by one. -/
def canonicalSkeletonQuotientElement
    {Q : Type u} {ell : ℕ}
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) : Q :=
  skeletonEquiv.symm OrientedCycleDeck.canonicalGenerator

/-- The canonical skeleton quotient element has coordinate one. -/
theorem canonicalSkeletonQuotientElement_coordinate
    {Q : Type u} {ell : ℕ}
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) :
    rankOneQuotientEquivZMod skeletonEquiv
        (canonicalSkeletonQuotientElement skeletonEquiv) = 1 := by
  simp [rankOneQuotientEquivZMod,
    canonicalSkeletonQuotientElement,
    OrientedCycleDeck.canonicalGenerator_coordinate]

/-- For prime `ell`, the canonical skeleton quotient element is nonzero in the
public cyclic coordinates. -/
theorem canonicalSkeletonQuotientElement_ne_zero
    {Q : Type u} {ell : ℕ}
    (hell : Nat.Prime ell)
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) :
    rankOneQuotientEquivZMod skeletonEquiv
        (canonicalSkeletonQuotientElement skeletonEquiv) ≠ 0 := by
  rw [canonicalSkeletonQuotientElement_coordinate]
  letI : NeZero ell := ⟨hell.ne_zero⟩
  exact one_ne_zero

end IUTThreeClosures
