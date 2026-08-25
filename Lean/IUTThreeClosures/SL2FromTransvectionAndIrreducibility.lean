/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2FromOneMovedTransvection

/-!
# The elementary `SL₂` image criterion

Over the prime field `ZMod p`, the powers of one nonzero upper transvection
`U(s)` give every upper unipotent `U(t)`.  If the image also contains an
invertible matrix moving the fixed line of this transvection, together with
its inverse, the preceding conjugation theorem produces the full lower root
subgroup.  Explicit unipotent factorization then gives every determinant-one
matrix.

This proves the complete finite-group step needed in the semistable Frey
large-image argument without Dickson classification.  For an actual Galois
image, the source-facing arithmetic obligations are now exactly:

1. a nonzero transvection from multiplicative Tate inertia;
2. irreducibility, equivalently the existence of an image element moving the
   transvection's fixed line;
3. identification of the concrete representation matrices with `MatrixTwo`.
-/

namespace IUTThreeClosures

namespace MatrixTwo

/-- Repeated multiplication by one upper transvection yields every natural
multiple of its parameter. -/
theorem upper_natMultiple_mem
    {F : Type*} [Field F]
    (S : Set (MatrixTwo F))
    (hmul : ∀ {A B : MatrixTwo F}, A ∈ S → B ∈ S → A * B ∈ S)
    (hzero : upper 0 ∈ S)
    {s : F} (hs : upper s ∈ S) :
    ∀ n : ℕ, upper ((n : F) * s) ∈ S := by
  intro n
  induction n with
  | zero => simpa using hzero
  | succ n ih =>
      have hprod := hmul ih hs
      rw [upper_mul_upper] at hprod
      convert hprod using 1
      push_cast
      ring

/-- Over a prime field, one nonzero upper transvection generates the complete
upper root subgroup. -/
theorem all_upper_mem_of_one_nonzero
    {p : ℕ} [Fact p.Prime]
    (S : Set (MatrixTwo (ZMod p)))
    (hmul :
      ∀ {A B : MatrixTwo (ZMod p)}, A ∈ S → B ∈ S → A * B ∈ S)
    (hzero : upper 0 ∈ S)
    {s : ZMod p} (hs0 : s ≠ 0) (hs : upper s ∈ S) :
    ∀ t : ZMod p, upper t ∈ S := by
  intro t
  let n : ℕ := (t / s).val
  have hn := upper_natMultiple_mem S hmul hzero hs n
  have hcoeff : ((n : ℕ) : ZMod p) * s = t := by
    dsimp [n]
    rw [ZMod.natCast_zmod_val]
    exact div_mul_cancel₀ t hs0
  simpa [hcoeff] using hn

/-- Complete elementary image criterion: one nonzero transvection and one
invertible image element moving its fixed line force containment of every
matrix of determinant one. -/
theorem mem_all_det_one_of_transvection_and_moving
    {p : ℕ} [Fact p.Prime]
    (S : Set (MatrixTwo (ZMod p)))
    (hmul :
      ∀ {A B : MatrixTwo (ZMod p)}, A ∈ S → B ∈ S → A * B ∈ S)
    (hone : upper 0 ∈ S)
    {s : ZMod p}
    (hs0 : s ≠ 0)
    (htransvection : upper s ∈ S)
    (A : MatrixTwo (ZMod p))
    (hA : A ∈ S)
    (hAinv : inverse A ∈ S)
    (hdet : det A ≠ 0)
    (hmoves : A.a21 ≠ 0) :
    ∀ M : MatrixTwo (ZMod p), det M = 1 → M ∈ S := by
  have hupper : ∀ t : ZMod p, upper t ∈ S :=
    all_upper_mem_of_one_nonzero
      S hmul hone hs0 htransvection
  exact mem_all_det_one_of_moved_upper
    S hmul hupper A hA hAinv hdet hmoves

/-- Packaged form of the elementary criterion. -/
structure TransvectionIrreducibleImageData (p : ℕ) [Fact p.Prime] where
  carrier : Set (MatrixTwo (ZMod p))
  mul_mem :
    ∀ {A B : MatrixTwo (ZMod p)},
      A ∈ carrier → B ∈ carrier → A * B ∈ carrier
  one_mem : upper 0 ∈ carrier
  transvectionParameter : ZMod p
  transvectionParameter_ne_zero : transvectionParameter ≠ 0
  transvection_mem : upper transvectionParameter ∈ carrier
  movingMatrix : MatrixTwo (ZMod p)
  movingMatrix_mem : movingMatrix ∈ carrier
  movingMatrix_inv_mem : inverse movingMatrix ∈ carrier
  movingMatrix_det_ne_zero : det movingMatrix ≠ 0
  movingMatrix_moves : movingMatrix.a21 ≠ 0

namespace TransvectionIrreducibleImageData

/-- The packaged criterion contains all determinant-one matrices. -/
theorem contains_SL2
    {p : ℕ} [Fact p.Prime]
    (D : TransvectionIrreducibleImageData p) :
    ∀ M : MatrixTwo (ZMod p), det M = 1 → M ∈ D.carrier :=
  mem_all_det_one_of_transvection_and_moving
    D.carrier D.mul_mem D.one_mem
    D.transvectionParameter_ne_zero D.transvection_mem
    D.movingMatrix D.movingMatrix_mem D.movingMatrix_inv_mem
    D.movingMatrix_det_ne_zero D.movingMatrix_moves

end TransvectionIrreducibleImageData

end MatrixTwo

end IUTThreeClosures
