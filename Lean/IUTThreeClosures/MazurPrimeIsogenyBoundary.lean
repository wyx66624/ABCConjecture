/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The Mazur prime-isogeny boundary for mod-`ell` irreducibility

For an elliptic curve over `ℚ`, reducibility of the mod-`ell` representation
produces a Galois-stable cyclic subgroup of order `ell`, hence a rational
`ell`-isogeny.  Mazur's rational-isogeny theorem says that a prime degree of a
rational isogeny belongs to

`{2,3,5,7,11,13,17,19,37,43,67,163}`.

This file formalizes the finite numerical part and the exact logical reduction.
The deep source theorem is deliberately exposed as the classification field
`isogeny_prime_mem_mazurDegrees`; it is not replaced by an eventual open-image
hypothesis.
-/

namespace IUTThreeClosures

/-- Prime degrees permitted by Mazur's rational-isogeny theorem over `ℚ`. -/
def mazurPrimeIsogenyDegrees : Finset ℕ :=
  {2, 3, 5, 7, 11, 13, 17, 19, 37, 43, 67, 163}

/-- Every prime degree in Mazur's list is at most `163`. -/
theorem le_163_of_mem_mazurPrimeIsogenyDegrees
    {ell : ℕ}
    (h : ell ∈ mazurPrimeIsogenyDegrees) :
    ell ≤ 163 := by
  simp [mazurPrimeIsogenyDegrees] at h
  rcases h with rfl | rfl | rfl | rfl | rfl | rfl |
      rfl | rfl | rfl | rfl | rfl | rfl <;> norm_num

/-- Abstract source interface for the two standard geometric implications:
reducibility gives a rational cyclic isogeny, and Mazur classifies its prime
degree. -/
structure MazurIrreducibilitySource
    (Reducible : ℕ → Prop)
    (HasRationalCyclicIsogeny : ℕ → Prop) where
  reducible_implies_isogeny :
    ∀ ell : ℕ,
      Nat.Prime ell →
      Reducible ell →
      HasRationalCyclicIsogeny ell
  isogeny_prime_mem_mazurDegrees :
    ∀ ell : ℕ,
      Nat.Prime ell →
      HasRationalCyclicIsogeny ell →
      ell ∈ mazurPrimeIsogenyDegrees

namespace MazurIrreducibilitySource

/-- Mazur's classification gives uniform irreducibility above `163`. -/
theorem irreducible_above_163
    {Reducible HasRationalCyclicIsogeny : ℕ → Prop}
    (S : MazurIrreducibilitySource
      Reducible HasRationalCyclicIsogeny)
    {ell : ℕ}
    (hell : Nat.Prime ell)
    (hlarge : 163 < ell) :
    ¬ Reducible ell := by
  intro hred
  have hisog := S.reducible_implies_isogeny ell hell hred
  have hmem := S.isogeny_prime_mem_mazurDegrees ell hell hisog
  have hle := le_163_of_mem_mazurPrimeIsogenyDegrees hmem
  omega

/-- The same result with an arbitrary cutoff at least `163`. -/
theorem irreducible_above_cutoff
    {Reducible HasRationalCyclicIsogeny : ℕ → Prop}
    (S : MazurIrreducibilitySource
      Reducible HasRationalCyclicIsogeny)
    {B ell : ℕ}
    (hB : 163 ≤ B)
    (hell : Nat.Prime ell)
    (hlarge : B < ell) :
    ¬ Reducible ell :=
  S.irreducible_above_163 hell (lt_of_le_of_lt hB hlarge)

end MazurIrreducibilitySource

end IUTThreeClosures
