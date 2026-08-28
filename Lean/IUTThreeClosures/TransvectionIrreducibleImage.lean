/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TransvectionLargeImageCriterion

/-!
# A transvection plus an irreducible invertible image contains `SL₂`

The first transvection criterion required the element moving the fixed line to
have determinant one.  An actual Galois image naturally lies in `GL₂`, so this
normalization should not be imposed as an additional arithmetic theorem.

For an invertible matrix `g`, the conjugate

`g * U(1) * g⁻¹`

has determinant one.  If the lower-left entry `c(g)` is nonzero, the
lower-left entry of the conjugate is

`-c(g)^2 / det(g)`,

which is also nonzero.  Thus one arbitrary invertible mover produces exactly
the determinant-one mover consumed by the previous theorem.

Consequently a multiplicative image closed under matrix inverses contains all
of `SL₂` as soon as it contains one nonzero upper transvection and does not
preserve the upper fixed line.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

namespace TransvectionIrreducibleImage

universe u

variable {F : Type u} [Field F]

/-- Explicit inverse of a nonsingular concrete `2 × 2` matrix. -/
def matrixInverse (A : Matrix2 F) : Matrix2 F where
  a := A.d / det A
  b := -A.b / det A
  c := -A.c / det A
  d := A.a / det A

/-- Right inverse formula. -/
theorem mul_matrixInverse
    (A : Matrix2 F) (hdet : det A ≠ 0) :
    A * matrixInverse A = 1 := by
  ext <;>
    simp [matrixInverse, Matrix2.mul, Matrix2.identity, det] <;>
    field_simp [hdet] <;> ring

/-- Left inverse formula. -/
theorem matrixInverse_mul
    (A : Matrix2 F) (hdet : det A ≠ 0) :
    matrixInverse A * A = 1 := by
  ext <;>
    simp [matrixInverse, Matrix2.mul, Matrix2.identity, det] <;>
    field_simp [hdet] <;> ring

/-- Determinant of the explicit inverse. -/
theorem det_matrixInverse
    (A : Matrix2 F) (hdet : det A ≠ 0) :
    det (matrixInverse A) = (det A)⁻¹ := by
  simp [matrixInverse, det]
  field_simp [hdet]
  ring

/-- An image carrier consisting of nonsingular matrices and closed under the
explicit inverse. -/
structure InvertibleImageCarrier (F : Type u) [Field F]
    extends MultiplicativeCarrier (Matrix2 F) where
  nonsingular : ∀ A, A ∈ carrier → det A ≠ 0
  inverse_mem : ∀ A, A ∈ carrier → matrixInverse A ∈ carrier

namespace InvertibleImageCarrier

/-- View an invertible image as the multiplicative carrier used by the
previous transvection theorem. -/
def toCarrier (C : InvertibleImageCarrier F) :
    MultiplicativeCarrier (Matrix2 F) :=
  C.toMultiplicativeCarrier

/-- Conjugate of an upper transvection by an image matrix. -/
def conjugateUpper (g : Matrix2 F) (x : F) : Matrix2 F :=
  g * upper x * matrixInverse g

/-- The conjugate remains in an invertible image carrier. -/
theorem conjugateUpper_mem
    (C : InvertibleImageCarrier F)
    {g : Matrix2 F} (hg : g ∈ C.carrier)
    {x : F} (hU : upper x ∈ C.carrier) :
    C.conjugateUpper g x ∈ C.carrier := by
  exact C.mul_mem (C.mul_mem hg hU) (C.inverse_mem g hg)

/-- A conjugated upper transvection has determinant one. -/
theorem det_conjugateUpper
    (C : InvertibleImageCarrier F)
    {g : Matrix2 F} (hg : g ∈ C.carrier)
    (x : F) :
    det (C.conjugateUpper g x) = 1 := by
  have hdetg : det g ≠ 0 := C.nonsingular g hg
  unfold conjugateUpper
  rw [det_mul, det_mul, det_upper, det_matrixInverse g hdetg]
  field_simp [hdetg]

/-- Exact lower-left entry of the conjugated transvection. -/
theorem conjugateUpper_c
    (C : InvertibleImageCarrier F)
    {g : Matrix2 F} (hg : g ∈ C.carrier)
    (x : F) :
    (C.conjugateUpper g x).c =
      -(g.c ^ 2 * x) / det g := by
  have hdetg : det g ≠ 0 := C.nonsingular g hg
  simp [conjugateUpper, matrixInverse, Matrix2.mul, det]
  field_simp [hdetg]
  ring

/-- A nonzero transvection parameter and a mover with nonzero lower-left entry
produce a determinant-one mover with nonzero lower-left entry. -/
theorem exists_det_one_mover_from_conjugation
    (C : InvertibleImageCarrier F)
    (hupper : ∀ x : F, upper x ∈ C.carrier)
    {g : Matrix2 F} (hg : g ∈ C.carrier)
    (hgc : g.c ≠ 0) :
    ∃ h : Matrix2 F,
      h ∈ C.carrier ∧ det h = 1 ∧ h.c ≠ 0 := by
  let h : Matrix2 F := C.conjugateUpper g 1
  refine ⟨h, C.conjugateUpper_mem hg (hupper 1),
    C.det_conjugateUpper hg 1, ?_⟩
  rw [h, C.conjugateUpper_c hg 1]
  have hdetg : det g ≠ 0 := C.nonsingular g hg
  field_simp [hdetg]
  exact pow_ne_zero 2 hgc

/-- Chosen-basis form of irreducibility: the image does not preserve the
upper transvection's fixed line. -/
def MovesUpperFixedLine
    (C : InvertibleImageCarrier F) : Prop :=
  ∃ g : Matrix2 F, g ∈ C.carrier ∧ g.c ≠ 0

/-- **Irreducible-image transvection criterion over a prime field.**  One
nonzero upper transvection and one arbitrary invertible mover force the image
to contain every determinant-one matrix. -/
theorem all_det_one_mem_of_transvection_and_irreducible
    (p : ℕ) [Fact p.Prime]
    (C : InvertibleImageCarrier (ZMod p))
    {u : ZMod p} (hu : u ≠ 0)
    (htransvection : upper u ∈ C.carrier)
    (hmove : C.MovesUpperFixedLine) :
    ∀ A : Matrix2 (ZMod p),
      det A = 1 → A ∈ C.carrier := by
  have hupper : ∀ x : ZMod p, upper x ∈ C.carrier :=
    all_upper_of_one_nonzero p C.toCarrier hu htransvection
  rcases hmove with ⟨g, hg, hgc⟩
  rcases C.exists_det_one_mover_from_conjugation
      hupper hg hgc with ⟨h, hh, hdet, hhc⟩
  exact all_det_one_mem_of_transvection_and_mover
    p C.toCarrier hu htransvection h hh hdet hhc

end InvertibleImageCarrier

end TransvectionIrreducibleImage

end IUTThreeClosures
