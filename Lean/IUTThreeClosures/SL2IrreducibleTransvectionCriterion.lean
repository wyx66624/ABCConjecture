/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2FromTransvectionAndIrreducibility

/-!
# The complete irreducible-transvection criterion for `SL₂`

Fix a basis in which a nonzero transvection in a matrix image is upper
unipotent.  If every image matrix had lower-left entry zero, then the first
coordinate line would be invariant.  Thus irreducibility supplies an image
matrix moving this line.  Since an actual matrix image is closed under
inverses, the elementary conjugation theorem produces the full lower root
subgroup, and explicit unipotent factorization gives all determinant-one
matrices.

The theorem below closes the finite-group step of the semistable Frey route.
No subgroup classification is used.  The remaining arithmetic theorems are
precisely:

* put the multiplicative-inertia transvection into upper-unipotent form;
* prove irreducibility of the mod-`ell` representation;
* transport the actual `GL₂` image to the concrete matrix coordinates.
-/

namespace IUTThreeClosures

namespace MatrixTwo

/-- A matrix image over the prime field, expressed in a basis containing a
standard upper transvection. -/
structure PrimeFieldMatrixImage (p : ℕ) [Fact p.Prime] where
  carrier : Set (MatrixTwo (ZMod p))
  mul_mem :
    ∀ {A B : MatrixTwo (ZMod p)},
      A ∈ carrier → B ∈ carrier → A * B ∈ carrier
  one_mem : upper 0 ∈ carrier
  inverse_mem :
    ∀ {A : MatrixTwo (ZMod p)},
      A ∈ carrier → det A ≠ 0 → inverse A ∈ carrier
  det_ne_zero :
    ∀ {A : MatrixTwo (ZMod p)}, A ∈ carrier → det A ≠ 0

namespace PrimeFieldMatrixImage

/-- The first coordinate line is not invariant: equivalently, some image
matrix has nonzero lower-left entry.  This is the basis-level consequence of
irreducibility used by the proof. -/
def UpperLineIrreducible
    {p : ℕ} [Fact p.Prime]
    (H : PrimeFieldMatrixImage p) : Prop :=
  ¬ ∀ A : MatrixTwo (ZMod p), A ∈ H.carrier → A.a21 = 0

/-- Basis-level irreducibility produces a matrix moving the fixed line of the
standard upper transvection. -/
theorem exists_movingMatrix
    {p : ℕ} [Fact p.Prime]
    (H : PrimeFieldMatrixImage p)
    (hirr : H.UpperLineIrreducible) :
    ∃ A : MatrixTwo (ZMod p),
      A ∈ H.carrier ∧ A.a21 ≠ 0 := by
  by_contra h
  apply hirr
  intro A hA
  by_contra hA21
  apply h
  exact ⟨A, hA, hA21⟩

/-- A nonzero upper transvection together with irreducibility forces the image
to contain every determinant-one matrix. -/
theorem contains_SL2_of_transvection_irreducible
    {p : ℕ} [Fact p.Prime]
    (H : PrimeFieldMatrixImage p)
    {s : ZMod p}
    (hs0 : s ≠ 0)
    (htransvection : upper s ∈ H.carrier)
    (hirr : H.UpperLineIrreducible) :
    ∀ M : MatrixTwo (ZMod p), det M = 1 → M ∈ H.carrier := by
  rcases H.exists_movingMatrix hirr with ⟨A, hA, hmove⟩
  exact mem_all_det_one_of_transvection_and_moving
    H.carrier H.mul_mem H.one_mem hs0 htransvection
    A hA (H.inverse_mem hA (H.det_ne_zero hA))
    (H.det_ne_zero hA) hmove

/-- Packaged form of the exact finite-group theorem needed from a semistable
Galois representation. -/
structure IrreducibleTransvectionData
    (p : ℕ) [Fact p.Prime]
    (H : PrimeFieldMatrixImage p) where
  parameter : ZMod p
  parameter_ne_zero : parameter ≠ 0
  transvection_mem : upper parameter ∈ H.carrier
  upperLineIrreducible : H.UpperLineIrreducible

namespace IrreducibleTransvectionData

/-- The packaged data force containment of `SL₂`. -/
theorem contains_SL2
    {p : ℕ} [Fact p.Prime]
    {H : PrimeFieldMatrixImage p}
    (D : IrreducibleTransvectionData p H) :
    ∀ M : MatrixTwo (ZMod p), det M = 1 → M ∈ H.carrier :=
  H.contains_SL2_of_transvection_irreducible
    D.parameter_ne_zero D.transvection_mem D.upperLineIrreducible

end IrreducibleTransvectionData

end PrimeFieldMatrixImage

end MatrixTwo

end IUTThreeClosures
