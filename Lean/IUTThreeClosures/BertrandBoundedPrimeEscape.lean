/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.Bertrand

/-!
# A quantitative finite-exception prime escape theorem

An eventual large-image theorem together with a finite exceptional set does
not give a prime below an arbitrarily prescribed independent bound.  It does,
however, give an explicit upper bound once the eventual threshold and the
finite exceptional set themselves are quantitatively controlled.

For a threshold `N` and a forbidden finite set `S`, put

`M = max 1 (N + sum S)`.

Bertrand's postulate supplies a prime `p` with

`M < p <= 2M`.

Such a prime is automatically above `N` and outside `S`.  Thus every property
which holds for primes above `N` outside `S` has a witness whose size is at
most `2M`.

This theorem does not solve the quantitative auxiliary-prime problem by
itself: in the IUT/GenEll application one must still bound the relevant
large-image threshold and exceptional-prime mass in terms of the arithmetic
height/different/conductor data.  It identifies that remaining quantitative
input exactly and separates it from the elementary prime-existence layer.
-/

namespace IUTThreeClosures

private theorem finset_member_le_sum
    (S : Finset ℕ) {n : ℕ} (hn : n ∈ S) :
    n ≤ S.sum id := by
  classical
  induction S using Finset.induction_on with
  | empty => simp at hn
  | @insert a S ha ih =>
      rw [Finset.sum_insert ha]
      simp only [Finset.mem_insert] at hn
      rcases hn with rfl | hn
      · simp [id]
      · simpa only [id_eq] using
          (ih hn).trans (Nat.le_add_left _ _)

/-- The scale at which Bertrand's postulate simultaneously clears a lower
threshold and every member of a finite forbidden set. -/
def bertrandEscapeScale (N : ℕ) (S : Finset ℕ) : ℕ :=
  max 1 (N + S.sum id)

/-- The escape scale is positive. -/
theorem bertrandEscapeScale_pos
    (N : ℕ) (S : Finset ℕ) :
    0 < bertrandEscapeScale N S := by
  unfold bertrandEscapeScale
  omega

/-- Every forbidden element is at most the escape scale. -/
theorem mem_le_bertrandEscapeScale
    (N : ℕ) (S : Finset ℕ) {n : ℕ}
    (hn : n ∈ S) :
    n ≤ bertrandEscapeScale N S := by
  unfold bertrandEscapeScale
  exact (finset_member_le_sum S hn).trans
    ((Nat.le_add_left _ _).trans (le_max_right _ _))

/-- The input lower threshold is at most the escape scale. -/
theorem threshold_le_bertrandEscapeScale
    (N : ℕ) (S : Finset ℕ) :
    N ≤ bertrandEscapeScale N S := by
  unfold bertrandEscapeScale
  exact (Nat.le_add_right N (S.sum id)).trans (le_max_right _ _)

/-- There is a prime above `N`, outside `S`, and no larger than twice the
explicit escape scale. -/
theorem exists_prime_above_not_mem_bounded
    (N : ℕ) (S : Finset ℕ) :
    ∃ p : ℕ,
      p.Prime ∧
      N < p ∧
      p ∉ S ∧
      p ≤ 2 * bertrandEscapeScale N S := by
  let M := bertrandEscapeScale N S
  have hM : M ≠ 0 := (bertrandEscapeScale_pos N S).ne'
  obtain ⟨p, hp, hMp, hpUpper⟩ :=
    Nat.exists_prime_lt_and_le_two_mul M hM
  refine ⟨p, hp, ?_, ?_, hpUpper⟩
  · exact (threshold_le_bertrandEscapeScale N S).trans_lt hMp
  · intro hpS
    have hpM : p ≤ M := by
      exact mem_le_bertrandEscapeScale N S hpS
    exact hMp.not_le hpM

/-- Quantitative closure of an eventual finite-exception prime property.
The upper bound depends only on the supplied eventual threshold and forbidden
finset, rather than on the unknown first satisfying prime. -/
theorem exists_prime_of_eventual_finite_exception_bounded
    (N : ℕ) (S : Finset ℕ)
    (P : ℕ → Prop)
    (hP :
      ∀ p : ℕ,
        p.Prime →
        N < p →
        p ∉ S →
        P p) :
    ∃ p : ℕ,
      p.Prime ∧
      P p ∧
      N < p ∧
      p ∉ S ∧
      p ≤ 2 * bertrandEscapeScale N S := by
  obtain ⟨p, hp, hNp, hpS, hpUpper⟩ :=
    exists_prime_above_not_mem_bounded N S
  exact ⟨p, hp, hP p hp hNp hpS, hNp, hpS, hpUpper⟩

/-- A useful reformulation: once one proves a uniform upper bound on the
escape scale, the selected satisfying prime inherits twice that bound. -/
theorem exists_prime_of_eventual_below_uniform_scale
    (N : ℕ) (S : Finset ℕ)
    (P : ℕ → Prop)
    (hP :
      ∀ p : ℕ,
        p.Prime →
        N < p →
        p ∉ S →
        P p)
    (B : ℕ)
    (hscale : bertrandEscapeScale N S ≤ B) :
    ∃ p : ℕ,
      p.Prime ∧
      P p ∧
      N < p ∧
      p ∉ S ∧
      p ≤ 2 * B := by
  obtain ⟨p, hp, hPp, hNp, hpS, hpUpper⟩ :=
    exists_prime_of_eventual_finite_exception_bounded N S P hP
  refine ⟨p, hp, hPp, hNp, hpS, hpUpper.trans ?_⟩
  exact Nat.mul_le_mul_left 2 hscale

end IUTThreeClosures
