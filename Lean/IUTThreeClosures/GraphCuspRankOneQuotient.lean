/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CycleCuspGraph
import IUTThreeClosures.TemperedCycleSkeletonBridge

/-!
# The rank-one cyclic quotient carried by the graph cusp

The quotient graph constructed in `CycleCuspGraph` has one core loop and an
attached tree ray.  Its rank-one loop group is therefore modelled by `ℤ`.
The `ell`-fold cyclic cover records the loop winding number modulo `ell`.

This file proves the complete algebraic quotient sequence

`ell * ℤ  ->  ℤ  ->  ZMod ell`:

* the winding-to-deck map is surjective;
* its kernel consists exactly of the multiples of `ell`;
* one core turn maps to the canonical nonzero deck generator for prime `ell`.

Thus the graph-cusp quotient and its canonical `ZMod ell` coordinate no longer
require an abstract cyclic-group field.  What remains in the tempered route is
the geometric comparison identifying the actual tempered loop quotient with
this graph-skeleton sequence.
-/

namespace IUTThreeClosures

namespace GraphCuspRankOneQuotient

/-- Winding number of the core loop mapped to the deck transformation of the
`ell`-fold cyclic skeleton. -/
def loopMonodromy (ell : ℕ) : ℤ →+ ZMod ell where
  toFun n := n
  map_zero' := by simp
  map_add' a b := by simp

@[simp]
theorem loopMonodromy_apply (ell : ℕ) (n : ℤ) :
    loopMonodromy ell n = (n : ZMod ell) :=
  rfl

/-- Every cyclic deck translation is represented by a core-loop winding. -/
theorem loopMonodromy_surjective (ell : ℕ) :
    Function.Surjective (loopMonodromy ell) := by
  intro a
  refine ⟨(a.val : ℤ), ?_⟩
  simpa using (ZMod.natCast_zmod_val a).symm

/-- The kernel consists exactly of windings divisible by `ell`. -/
theorem loopMonodromy_eq_zero_iff_dvd
    (ell : ℕ) (n : ℤ) :
    loopMonodromy ell n = 0 ↔ (ell : ℤ) ∣ n := by
  simpa [loopMonodromy] using
    (ZMod.intCast_zmod_eq_zero_iff_dvd n ell)

/-- Equality of two deck transformations is congruence of winding numbers
modulo `ell`. -/
theorem loopMonodromy_eq_iff_dvd_sub
    (ell : ℕ) (m n : ℤ) :
    loopMonodromy ell m = loopMonodromy ell n ↔
      (ell : ℤ) ∣ m - n := by
  rw [← sub_eq_zero]
  change loopMonodromy ell (m - n) = 0 ↔ _
  exact loopMonodromy_eq_zero_iff_dvd ell (m - n)

/-- One positive turn of the core loop is the canonical translation by one. -/
@[simp]
theorem loopMonodromy_one (ell : ℕ) :
    loopMonodromy ell 1 = 1 := by
  rfl

/-- For prime `ell`, the core-loop generator has nonzero cyclic coordinate. -/
theorem loopMonodromy_one_ne_zero
    {ell : ℕ} (hell : Nat.Prime ell) :
    loopMonodromy ell 1 ≠ 0 := by
  letI : NeZero ell := ⟨hell.ne_zero⟩
  simpa using (one_ne_zero : (1 : ZMod ell) ≠ 0)

/-- Exactly `ell` turns lift to the identity deck transformation. -/
@[simp]
theorem loopMonodromy_ell (ell : ℕ) :
    loopMonodromy ell (ell : ℤ) = 0 := by
  exact (loopMonodromy_eq_zero_iff_dvd ell ell).2 dvd_rfl

/-- The canonical graph-cusp loop coordinate supplies the same `ZMod ell`
coordinate used by the oriented-cycle deck quotient. -/
theorem loop_generator_matches_skeleton_coordinate
    {Q : Type*} {ell : ℕ}
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) :
    rankOneQuotientEquivZMod skeletonEquiv
        (canonicalSkeletonQuotientElement skeletonEquiv) =
      loopMonodromy ell 1 := by
  rw [canonicalSkeletonQuotientElement_coordinate]
  rfl

/-- A concise exactness package for the rank-one graph-cusp quotient. -/
structure ExactCyclicLoopQuotient (ell : ℕ) : Prop where
  surjective : Function.Surjective (loopMonodromy ell)
  kernel : ∀ n : ℤ,
    loopMonodromy ell n = 0 ↔ (ell : ℤ) ∣ n
  generator : loopMonodromy ell 1 = 1

/-- The graph-cusp winding map always supplies the exact cyclic quotient. -/
theorem exactCyclicLoopQuotient (ell : ℕ) :
    ExactCyclicLoopQuotient ell where
  surjective := loopMonodromy_surjective ell
  kernel := loopMonodromy_eq_zero_iff_dvd ell
  generator := loopMonodromy_one ell

end GraphCuspRankOneQuotient

end IUTThreeClosures
