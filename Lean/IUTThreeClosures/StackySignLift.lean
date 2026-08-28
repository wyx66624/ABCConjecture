/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.OrbifoldQuotientNecessity

/-!
# The elementary stacky sign-lifting mechanism

The coarse quotient forgets which sign identifies two representatives.  The
quotient groupoid retains this sign as a morphism.  At the object level, the
correction mechanism is elementary: if a sign identifies the `n`-multiple of
`c` with `x`, apply the same sign to `c`.  Since multiplication by `n`
commutes with negation, this produces an honest lift whose `n`-multiple is
exactly `x`.

This does not construct the full orbicurve quotient stack or its étale
fundamental group.  It proves the basic lifting identity that the stacky
construction uses and which the coarse set quotient loses.
-/

namespace IUTThreeClosures

/-- Action of the two signs on an additive group. -/
def signAct
    {A : Type*} [AddGroup A] (negative : Bool) (x : A) : A :=
  if negative then -x else x

@[simp]
theorem signAct_false
    {A : Type*} [AddGroup A] (x : A) :
    signAct false x = x := by
  simp [signAct]

@[simp]
theorem signAct_true
    {A : Type*} [AddGroup A] (x : A) :
    signAct true x = -x := by
  simp [signAct]

/-- Sign action commutes with multiplication by a natural number. -/
theorem signAct_nsmul
    {A : Type*} [AddGroup A]
    (negative : Bool) (n : ℕ) (x : A) :
    signAct negative (n • x) = n • signAct negative x := by
  cases negative <;> simp [signAct]

/-- Retaining the sign witness turns an orbit-level compatibility into an
honest lift. -/
theorem stacky_sign_lift
    {A : Type*} [AddGroup A]
    (negative : Bool) (n : ℕ) (c x : A)
    (h : signAct negative (n • c) = x) :
    ∃ u : A,
      n • u = x ∧
      (u = c ∨ u = -c) := by
  refine ⟨signAct negative c, ?_, ?_⟩
  · rw [← signAct_nsmul]
    exact h
  · cases negative <;> simp [signAct]

/-- In the finite counterexample, the two coarse lifts are connected by the
nontrivial sign morphism. -/
theorem zmodSix_five_is_negative_one :
    signAct true (1 : ZMod 6) = 5 := by
  norm_num [signAct]

/-- The problematic two-torsion target is fixed by the nontrivial sign.  This
is stabilizer data, which is present in the quotient groupoid and absent from
the coarse orbit set. -/
theorem zmodSix_three_has_sign_stabilizer :
    signAct true (3 : ZMod 6) = 3 := by
  norm_num [signAct]

end IUTThreeClosures
