/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Why the anabelian covering square cannot be replaced by an ordinary set quotient

A tempting shortcut is to model the quotient of an elliptic curve by the sign
involution using only the orbit set `x ~ -x`, and to regard multiplication by
an odd prime `ell` as a map between these orbit sets.  The expected orbicurve
covering square would then be replaced by an ordinary pullback square of sets.

This loses the stacky/orbifold inertia at the two-torsion branch locus.  The
failure is already visible in the finite abelian group `ZMod 6` with
`ell = 3`.

The elements `1` and `-1 = 5` have the same sign orbit.  Their images under
multiplication by `3` are also equal, since both map to the nonzero two-torsion
element `3`.  Hence the canonical map

`x ↦ (signOrbit(x), 3*x)`

is not injective.  In any pullback square of sets the corresponding canonical
map would be injective (indeed bijective).  Therefore the naive set-quotient
square is not cartesian.

This counterexample does not obstruct the genuine IUT construction.  It shows
that a valid construction must retain the orbifold/stack stabilizer data at the
branch points, exactly as the `Orbicurve` interface is intended to do.  Thus a
plain set or coarse-scheme quotient route is rigorously excluded, while the
stacky/Galois-category route remains open.
-/

namespace IUTThreeClosures

/-- A concrete representative of the orbit of `x` under `x ↦ -x` in `ZMod 6`.
It is used only to exhibit the coarse sign quotient in the counterexample. -/
def coarseSignRepresentative (x : ZMod 6) : ℕ :=
  min x.val (-x).val

/-- The canonical map to the would-be set-theoretic pullback coordinates. -/
def naiveSignPullbackMap (x : ZMod 6) : ℕ × ZMod 6 :=
  (coarseSignRepresentative x, 3 * x)

/-- The two witnesses are genuinely distinct. -/
theorem one_ne_five_zmod_six :
    (1 : ZMod 6) ≠ 5 := by
  norm_num

/-- The witnesses have the same coarse sign orbit. -/
theorem coarseSignRepresentative_one_eq_five :
    coarseSignRepresentative (1 : ZMod 6) =
      coarseSignRepresentative (5 : ZMod 6) := by
  native_decide

/-- Multiplication by three sends both witnesses to the same nonzero
`2`-torsion element. -/
theorem three_mul_one_eq_three_mul_five :
    (3 : ZMod 6) * 1 = 3 * 5 := by
  norm_num

/-- The canonical map associated to the naive coarse quotient is not
injective. -/
theorem naiveSignPullbackMap_not_injective :
    ¬ Function.Injective naiveSignPullbackMap := by
  intro hinj
  apply one_ne_five_zmod_six
  apply hinj
  apply Prod.ext
  · exact coarseSignRepresentative_one_eq_five
  · exact three_mul_one_eq_three_mul_five

/-- Abstract obstruction: no equivalence from `ZMod 6` to any would-be
pullback carrier can have `naiveSignPullbackMap` as its underlying function. -/
theorem no_pullback_equiv_with_naiveSignPullbackMap :
    ¬ ∃ e : ZMod 6 ≃ (Set.range naiveSignPullbackMap),
      ∀ x, (e x : ℕ × ZMod 6) = naiveSignPullbackMap x := by
  rintro ⟨e, he⟩
  apply naiveSignPullbackMap_not_injective
  intro x y hxy
  apply e.injective
  apply Subtype.ext
  simpa [he] using hxy

end IUTThreeClosures
