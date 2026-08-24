/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Orbitwise volume invariance does not control the volume of an orbit union

A label permutation preserves the volume of each permuted packet when the
measure is permutation invariant.  This fact alone does not imply that the
literal union of all permuted packets has the same volume as one packet.

The finite counting-measure counterexample below uses two coordinates.  The
region

`A = {(0,0),(0,1)}`

has two points.  Swapping the coordinates produces

`B = {(0,0),(1,0)}`,

which also has two points, but `A ∪ B` has three points.  Thus

`vol(A) = vol(B)` while `vol(A ∪ B) > vol(A)`.

This proves a precise boundary for the Ind2 programme.  Permutation-invariant
procession averages are compatible with arbitrary Ind2 permutations, but a
literal possible-image union requires an additional theorem identifying the
public log-volume with a quotient/orbit average, or a structural theorem that
makes the regions themselves permutation invariant.  The former cannot be
replaced by the bare invariance of each orbit member.
-/

namespace IUTThreeClosures

namespace Ind2OrbitUnionCounterexample

/-- Coordinate transposition on a two-coordinate Boolean packet. -/
def swapCoordinates : Bool × Bool ≃ Bool × Bool where
  toFun x := (x.2, x.1)
  invFun x := (x.2, x.1)
  left_inv x := by cases x; rfl
  right_inv x := by cases x; rfl

/-- A two-point nonsymmetric packet region. -/
def regionA : Finset (Bool × Bool) :=
  {(false, false), (false, true)}

/-- Its Ind2-permuted image. -/
def regionB : Finset (Bool × Bool) :=
  regionA.map swapCoordinates.toEmbedding

/-- The original region has counting volume two. -/
theorem card_regionA : regionA.card = 2 := by
  native_decide

/-- The coordinate permutation preserves counting volume. -/
theorem card_regionB : regionB.card = regionA.card := by
  exact Finset.card_map _

/-- Nevertheless the literal orbit union has counting volume three. -/
theorem card_orbitUnion : (regionA ∪ regionB).card = 3 := by
  native_decide

/-- Explicit strict growth of volume under the literal Ind2 orbit union. -/
theorem card_regionA_lt_orbitUnion :
    regionA.card < (regionA ∪ regionB).card := by
  rw [card_regionA, card_orbitUnion]
  norm_num

/-- Hence orbitwise permutation invariance does not imply equality between a
region volume and the volume of its orbit union. -/
theorem orbitwiseInvariant_but_unionGrows :
    regionB.card = regionA.card ∧
      regionA.card < (regionA ∪ regionB).card :=
  ⟨card_regionB, card_regionA_lt_orbitUnion⟩

end Ind2OrbitUnionCounterexample

end IUTThreeClosures
