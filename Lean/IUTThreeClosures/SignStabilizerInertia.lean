/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignActionGroup

/-!
# Stacky inertia of the sign quotient

For the quotient groupoid of an additive group by `x ↦ -x`, the stabilizer of
a point is trivial away from the two-torsion locus and contains the nontrivial
sign exactly at the two-torsion locus.  This is the inertia data erased by the
coarse orbit set and retained by the orbicurve/quotient-stack construction.

The result explains the finite counterexample in `ZMod 6`: the target point
`3` is nonzero two-torsion and therefore has nontrivial stacky inertia, while
the coarse quotient records only its orbit.
-/

namespace IUTThreeClosures

namespace Sign

universe u

/-- Stabilizer subgroup of a point for the sign action. -/
def stabilizer
    {A : Type u} [AddGroup A] (x : A) : Subgroup Sign where
  carrier := {s | s • x = x}
  one_mem' := by simp
  mul_mem' := by
    intro a b ha hb
    rw [mul_smul, hb, ha]
  inv_mem' := by
    intro a ha
    cases a <;> simp_all

@[simp]
theorem positive_mem_stabilizer
    {A : Type u} [AddGroup A] (x : A) :
    positive ∈ stabilizer x := by
  simp [stabilizer]

/-- The nontrivial sign fixes `x` exactly when `x` is two-torsion. -/
theorem negative_mem_stabilizer_iff
    {A : Type u} [AddGroup A] (x : A) :
    negative ∈ stabilizer x ↔ 2 • x = 0 := by
  simp [stabilizer, two_nsmul]
  constructor
  · intro h
    have := congrArg (fun y => y + x) h
    simpa [add_assoc] using this
  · intro h
    have h' : x + x = 0 := by simpa [two_nsmul] using h
    exact eq_neg_of_add_eq_zero_left h'

/-- Away from two-torsion, the stabilizer is the trivial subgroup. -/
theorem stabilizer_eq_bot_of_not_twoTorsion
    {A : Type u} [AddGroup A] {x : A}
    (h : 2 • x ≠ 0) :
    stabilizer x = ⊥ := by
  ext s
  cases s with
  | positive => simp
  | negative =>
      simp [negative_mem_stabilizer_iff, h]

/-- At a two-torsion point, the entire sign group is the stabilizer. -/
theorem stabilizer_eq_top_of_twoTorsion
    {A : Type u} [AddGroup A] {x : A}
    (h : 2 • x = 0) :
    stabilizer x = ⊤ := by
  ext s
  cases s with
  | positive => simp
  | negative =>
      simp [negative_mem_stabilizer_iff, h]

/-- In `ZMod 6`, the ordinary point `1` has trivial stabilizer. -/
theorem zmodSix_stabilizer_one :
    stabilizer (1 : ZMod 6) = ⊥ := by
  apply stabilizer_eq_bot_of_not_twoTorsion
  norm_num

/-- The nonzero two-torsion point `3` has full stacky sign inertia. -/
theorem zmodSix_stabilizer_three :
    stabilizer (3 : ZMod 6) = ⊤ := by
  apply stabilizer_eq_top_of_twoTorsion
  norm_num

end Sign

end IUTThreeClosures
