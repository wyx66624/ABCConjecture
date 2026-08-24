/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TransvectionConjugation
import IUTThreeClosures.PrimeFieldTransvectionGeneration

/-!
# A moving conjugate of one transvection forces containment of `SL₂`

This module completes the elementary finite-group portion of the proposed
uniform semistable large-image argument.

Let `S` be a multiplicatively closed set of two-by-two matrices over the prime
field `ZMod ell`. Assume:

* `S` contains the identity `U(0)`;
* `S` contains the standard nontrivial upper transvection `U(1)`;
* `S` contains an invertible matrix `g` and its inverse;
* the lower-left entry of `g` is nonzero, i.e. `g` moves the fixed line of
  `U(1)`.

Then:

1. powers of `U(1)` give every upper transvection;
2. conjugating by `g`, followed by an upper translation, gives a nonzero lower
   transvection;
3. powers of that lower transvection give every lower transvection;
4. elementary generation gives every determinant-one matrix.

For an actual irreducible Galois image, the moving element exists because the
fixed line of `U(1)` cannot be invariant. Thus the remaining arithmetic inputs
are exactly the Tate-inertia transvection and irreducibility.
-/

namespace IUTThreeClosures

namespace SL2ElementaryGeneration
namespace Mat2

/-- One standard transvection and one image element moving its fixed line force
containment of every determinant-one matrix over the prime field. -/
theorem detOne_mem_of_upper_transvection_and_moving_element
    {ell : ℕ}
    [Fact ell.Prime]
    {S : Set (Mat2 (ZMod ell))}
    (hmul :
      ∀ {A B : Mat2 (ZMod ell)}, A ∈ S → B ∈ S → mul A B ∈ S)
    (hidentity : upper 0 ∈ S)
    (hupperOne : upper 1 ∈ S)
    (G : Mat2 (ZMod ell))
    (hG : G ∈ S)
    (hGinv : inv G ∈ S)
    (hdetG : det G ≠ 0)
    (hGc : G.c ≠ 0)
    (A : Mat2 (ZMod ell))
    (hdetA : det A = 1) :
    A ∈ S := by
  have hone_ne : (1 : ZMod ell) ≠ 0 := one_ne_zero
  have hupperAll : ∀ t : ZMod ell, upper t ∈ S :=
    all_upper_mem_of_one_nonzero
      hmul hidentity hone_ne hupperOne
  have hconjugate : conjugateUpper G ∈ S := by
    exact hmul (hmul hG (hupperAll 1)) hGinv
  have hlowerRaw :
      mul (mul (upper (-G.a / G.c)) (conjugateUpper G))
          (upper (G.a / G.c)) ∈ S := by
    exact hmul (hmul (hupperAll (-G.a / G.c)) hconjugate)
      (hupperAll (G.a / G.c))
  let l : ZMod ell := -(G.c ^ 2) / det G
  have hl_ne : l ≠ 0 := by
    exact translated_lower_parameter_ne_zero G hdetG hGc
  have hl : lower l ∈ S := by
    have heq := translated_conjugateUpper_eq_lower G hdetG hGc
    change
      mul (mul (upper (-G.a / G.c)) (conjugateUpper G))
          (upper (G.a / G.c)) = lower l at heq
    rw [← heq]
    exact hlowerRaw
  have hlowerZero : lower 0 ∈ S := by
    have hEq : lower (0 : ZMod ell) = upper 0 := by
      ext <;> simp [lower, upper]
    rw [hEq]
    exact hidentity
  have hlowerAll : ∀ t : ZMod ell, lower t ∈ S :=
    all_lower_mem_of_one_nonzero
      hmul hlowerZero hl_ne hl
  exact detOne_mem_of_contains_transvections
    hupperAll hlowerAll hmul A hdetA

end Mat2
end SL2ElementaryGeneration

end IUTThreeClosures
