/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Explicit unipotent factorization in `SL₂`

The semistable large-image route uses the elementary fact that the upper and
lower transvection subgroups generate `SL₂` over a field.  This module proves
that fact by an explicit bounded-length factorization, without invoking the
classification of subgroups of `GL₂`.

For

`A = [[a,b],[c,d]]`, `det A = 1`,

if `c ≠ 0`, then

`A = U((a-1)/c) * L(c) * U((d-1)/c)`.

If `c = 0`, multiply conceptually by `L(1)` and obtain the four-factor formula

`A = U((a+b-1)/d) * L(d) * U((d-1)/d) * L(-1)`.

Here

`U(t) = [[1,t],[0,1]]`,
`L(t) = [[1,0],[t,1]]`.

Consequently every multiplicatively closed set containing all upper and lower
unipotents contains every determinant-one matrix.  This is the algebraic
factorization needed after one proves that an irreducible image containing a
transvection contains both root subgroups.
-/

namespace IUTThreeClosures

universe u

/-- A lightweight concrete `2 × 2` matrix used for explicit calculations. -/
@[ext]
structure MatrixTwo (F : Type u) where
  a11 : F
  a12 : F
  a21 : F
  a22 : F

namespace MatrixTwo

variable {F : Type u}

instance [Mul F] [Add F] : Mul (MatrixTwo F) where
  mul A B :=
    { a11 := A.a11 * B.a11 + A.a12 * B.a21
      a12 := A.a11 * B.a12 + A.a12 * B.a22
      a21 := A.a21 * B.a11 + A.a22 * B.a21
      a22 := A.a21 * B.a12 + A.a22 * B.a22 }

instance [Zero F] [One F] : One (MatrixTwo F) where
  one :=
    { a11 := 1
      a12 := 0
      a21 := 0
      a22 := 1 }

@[simp]
theorem mul_a11 [Mul F] [Add F] (A B : MatrixTwo F) :
    (A * B).a11 = A.a11 * B.a11 + A.a12 * B.a21 := rfl

@[simp]
theorem mul_a12 [Mul F] [Add F] (A B : MatrixTwo F) :
    (A * B).a12 = A.a11 * B.a12 + A.a12 * B.a22 := rfl

@[simp]
theorem mul_a21 [Mul F] [Add F] (A B : MatrixTwo F) :
    (A * B).a21 = A.a21 * B.a11 + A.a22 * B.a21 := rfl

@[simp]
theorem mul_a22 [Mul F] [Add F] (A B : MatrixTwo F) :
    (A * B).a22 = A.a21 * B.a12 + A.a22 * B.a22 := rfl

/-- Determinant of a concrete `2 × 2` matrix. -/
def det [Mul F] [Sub F] (A : MatrixTwo F) : F :=
  A.a11 * A.a22 - A.a12 * A.a21

/-- Upper unipotent matrix. -/
def upper [Zero F] [One F] (t : F) : MatrixTwo F :=
  { a11 := 1
    a12 := t
    a21 := 0
    a22 := 1 }

/-- Lower unipotent matrix. -/
def lower [Zero F] [One F] (t : F) : MatrixTwo F :=
  { a11 := 1
    a12 := 0
    a21 := t
    a22 := 1 }

@[simp]
theorem det_upper [CommRing F] (t : F) :
    det (upper t) = 1 := by
  simp [det, upper]

@[simp]
theorem det_lower [CommRing F] (t : F) :
    det (lower t) = 1 := by
  simp [det, lower]

/-- Three-unipotent factorization when the lower-left entry is nonzero. -/
theorem factor_of_a21_ne_zero
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A = 1)
    (hc : A.a21 ≠ 0) :
    A =
      (upper ((A.a11 - 1) / A.a21) * lower A.a21) *
        upper ((A.a22 - 1) / A.a21) := by
  ext <;>
    simp [upper, lower, det] at hdet ⊢ <;>
    field_simp [hc] <;>
    nlinarith [hdet]

/-- Four-unipotent factorization in the triangular case. -/
theorem factor_of_a21_eq_zero
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A = 1)
    (hc : A.a21 = 0) :
    A =
      (((upper ((A.a11 + A.a12 - 1) / A.a22) * lower A.a22) *
          upper ((A.a22 - 1) / A.a22)) *
        lower (-1)) := by
  have hd : A.a22 ≠ 0 := by
    intro hd0
    simp [det, hc, hd0] at hdet
  ext <;>
    simp [upper, lower, det, hc] at hdet ⊢ <;>
    field_simp [hd] <;>
    nlinarith [hdet]

/-- Every determinant-one matrix is a product of either three or four standard
unipotents. -/
theorem exists_unipotent_factorization
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A = 1) :
    (∃ x c y : F,
      A = (upper x * lower c) * upper y) ∨
    (∃ x d y : F,
      A = ((upper x * lower d) * upper y) * lower (-1)) := by
  by_cases hc : A.a21 = 0
  · right
    exact ⟨(A.a11 + A.a12 - 1) / A.a22,
      A.a22,
      (A.a22 - 1) / A.a22,
      factor_of_a21_eq_zero A hdet hc⟩
  · left
    exact ⟨(A.a11 - 1) / A.a21,
      A.a21,
      (A.a22 - 1) / A.a21,
      factor_of_a21_ne_zero A hdet hc⟩

/-- Any multiplicatively closed set containing all upper and lower
unipotents contains every determinant-one matrix. -/
theorem mem_of_det_eq_one
    [Field F]
    (S : Set (MatrixTwo F))
    (hmul : ∀ {A B : MatrixTwo F}, A ∈ S → B ∈ S → A * B ∈ S)
    (hupper : ∀ t : F, upper t ∈ S)
    (hlower : ∀ t : F, lower t ∈ S)
    (A : MatrixTwo F)
    (hdet : det A = 1) :
    A ∈ S := by
  rcases exists_unipotent_factorization A hdet with
    ⟨x, c, y, rfl⟩ | ⟨x, d, y, rfl⟩
  · exact hmul (hmul (hupper x) (hlower c)) (hupper y)
  · exact hmul
      (hmul (hmul (hupper x) (hlower d)) (hupper y))
      (hlower (-1))

end MatrixTwo

end IUTThreeClosures
