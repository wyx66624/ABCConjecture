/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MovingTransvectionForcesSL2

/-!
# Irreducibility plus one transvection forces containment of `SL₂`

In coordinates where the Tate-inertia transvection is `U(1)`, its unique fixed
line is the first coordinate line.  That line is invariant under a matrix
`g = [[a,b],[c,d]]` exactly when `c = 0`.  Hence an image that is irreducible
cannot have `c = 0` for every element: it contains a moving element.

This file packages that elementary logical step with the constructive matrix
theorem.  The result is the precise finite-group statement needed in the
uniform semistable large-image route:

* multiplicative closure and inverses;
* the identity and one Tate transvection;
* non-invariance of the Tate fixed line;

imply containment of every determinant-one matrix.

No subgroup classification is used.
-/

namespace IUTThreeClosures

namespace SL2ElementaryGeneration
namespace Mat2

/-- The first coordinate line is invariant under every matrix in `S` exactly
when every matrix in `S` has zero lower-left entry. -/
def FirstLineInvariant
    {F : Type*} [Field F]
    (S : Set (Mat2 F)) : Prop :=
  ∀ G : Mat2 F, G ∈ S → G.c = 0

/-- Failure of first-line invariance supplies a moving image element. -/
theorem exists_moving_element_of_not_firstLineInvariant
    {F : Type*} [Field F]
    {S : Set (Mat2 F)}
    (h : ¬ FirstLineInvariant S) :
    ∃ G : Mat2 F, G ∈ S ∧ G.c ≠ 0 := by
  simpa [FirstLineInvariant, not_forall, Classical.not_imp] using h

/-- Irreducibility at the Tate fixed line plus one nontrivial upper
transvection forces containment of every determinant-one matrix. -/
theorem detOne_mem_of_not_firstLineInvariant
    {ell : ℕ}
    [Fact ell.Prime]
    {S : Set (Mat2 (ZMod ell))}
    (hmul :
      ∀ {A B : Mat2 (ZMod ell)}, A ∈ S → B ∈ S → mul A B ∈ S)
    (hinv :
      ∀ {G : Mat2 (ZMod ell)},
        G ∈ S → det G ≠ 0 → inv G ∈ S)
    (hidentity : upper 0 ∈ S)
    (hupperOne : upper 1 ∈ S)
    (hirreducible : ¬ FirstLineInvariant S)
    (hdet_nonzero : ∀ {G : Mat2 (ZMod ell)}, G ∈ S → det G ≠ 0)
    (A : Mat2 (ZMod ell))
    (hdetA : det A = 1) :
    A ∈ S := by
  obtain ⟨G, hG, hGc⟩ :=
    exists_moving_element_of_not_firstLineInvariant hirreducible
  have hdetG : det G ≠ 0 := hdet_nonzero hG
  exact detOne_mem_of_upper_transvection_and_moving_element
    hmul hidentity hupperOne G hG (hinv hG hdetG)
    hdetG hGc A hdetA

end Mat2
end SL2ElementaryGeneration

end IUTThreeClosures
