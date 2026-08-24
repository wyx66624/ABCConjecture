/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The cyclic deck quotient of an oriented skeleton

The Berkovich skeleton of a split multiplicative Tate curve is a circle, and
the relevant theta-root covers induce finite cyclic covers of this oriented
circle.  Before constructing the analytic curve and tempered fundamental
group, one can isolate the graph-theoretic quotient.

An orientation-preserving deck transformation of an `ell`-cycle is a
permutation of `ZMod ell` commuting with the successor map `x ↦ x + 1`.  Such a
permutation is uniquely a translation by its value at zero.  Hence the type of
oriented deck transformations is canonically equivalent to `ZMod ell`.

This supplies a concrete model for the rank-one graph quotient and its
canonical generator.  It does not yet identify the actual Berkovich skeleton,
theta-root model, or tempered fundamental group with this finite cycle.
-/

namespace IUTThreeClosures

/-- Orientation-preserving automorphisms of the finite directed cycle with
vertex set `ZMod ell`. -/
structure OrientedCycleDeck (ell : ℕ) where
  toEquiv : Equiv.Perm (ZMod ell)
  map_succ : ∀ x : ZMod ell,
    toEquiv (x + 1) = toEquiv x + 1

namespace OrientedCycleDeck

variable {ell : ℕ}

instance : CoeFun (OrientedCycleDeck ell) (fun _ => ZMod ell → ZMod ell) where
  coe D := D.toEquiv

/-- Translation by a cycle vertex is an oriented deck transformation. -/
def translation (a : ZMod ell) : OrientedCycleDeck ell where
  toEquiv :=
    { toFun := fun x => a + x
      invFun := fun x => -a + x
      left_inv := by
        intro x
        simp [add_assoc]
      right_inv := by
        intro x
        simp [add_assoc] }
  map_succ := by
    intro x
    simp only
    abel

@[simp]
theorem translation_apply (a x : ZMod ell) :
    translation a x = a + x := rfl

/-- Every oriented deck transformation is translation by its value at zero. -/
theorem apply_eq_zero_add (D : OrientedCycleDeck ell) (x : ZMod ell) :
    D x = D 0 + x := by
  have hnat : ∀ n : ℕ,
      D ((n : ℕ) : ZMod ell) = D 0 + (n : ZMod ell) := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
        calc
          D (((n + 1 : ℕ) : ZMod ell)) =
              D (((n : ℕ) : ZMod ell) + 1) := by
                congr 1
                push_cast
                ring
          _ = D ((n : ℕ) : ZMod ell) + 1 := D.map_succ _
          _ = (D 0 + (n : ZMod ell)) + 1 := by rw [ih]
          _ = D 0 + ((n + 1 : ℕ) : ZMod ell) := by
                push_cast
                ring
  have hx := hnat x.val
  simpa using hx

/-- An oriented deck transformation is completely determined by its value at
zero. -/
theorem ext_zero {D E : OrientedCycleDeck ell}
    (h0 : D 0 = E 0) : D = E := by
  cases D with
  | mk D hD =>
      cases E with
      | mk E hE =>
          congr 1
          apply Equiv.ext
          intro x
          have hDx := apply_eq_zero_add ⟨D, hD⟩ x
          have hEx := apply_eq_zero_add ⟨E, hE⟩ x
          simpa [h0] using hDx.trans hEx.symm

/-- Evaluation at zero identifies the complete oriented deck quotient with
`ZMod ell`. -/
def deckEquivZMod : OrientedCycleDeck ell ≃ ZMod ell where
  toFun D := D 0
  invFun := translation
  left_inv := by
    intro D
    apply ext_zero
    simp [translation]
  right_inv := by
    intro a
    simp [translation]

@[simp]
theorem deckEquivZMod_apply (D : OrientedCycleDeck ell) :
    deckEquivZMod D = D 0 := rfl

@[simp]
theorem deckEquivZMod_symm_apply (a : ZMod ell) :
    deckEquivZMod.symm a = translation a := rfl

/-- The canonical nonzero graph-quotient element is translation by one, when
`ell` is nontrivial. -/
def canonicalGenerator : OrientedCycleDeck ell :=
  translation 1

/-- The canonical generator has coordinate one. -/
theorem canonicalGenerator_coordinate :
    deckEquivZMod (canonicalGenerator : OrientedCycleDeck ell) = 1 := by
  rfl

/-- For prime `ell`, the canonical generator is nonzero in graph-quotient
coordinates. -/
theorem canonicalGenerator_ne_zero
    (hell : Nat.Prime ell) :
    deckEquivZMod (canonicalGenerator : OrientedCycleDeck ell) ≠ 0 := by
  letI : NeZero ell := ⟨hell.ne_zero⟩
  simp [canonicalGenerator_coordinate]

end OrientedCycleDeck

end IUTThreeClosures
