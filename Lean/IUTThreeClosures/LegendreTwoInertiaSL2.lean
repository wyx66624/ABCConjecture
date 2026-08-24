/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TransvectionLargeImageCriterion

/-!
# Any two Legendre local transvection directions generate `SL₂`

The three boundary points `0`, `1`, `infinity` of the Legendre line produce
three Picard--Lefschetz transvection directions.  In a common symplectic basis
we model them by

`U(x) = [[1,x],[0,1]]`,
`L(x) = [[1,0],[x,1]]`,
`V(x) = [[1-x,x],[-x,1+x]]`.

The third family fixes the diagonal line and has determinant one.  Over a
prime field, one nonzero member of any root family generates the complete
one-parameter family by powers.

We prove that any two distinct nonzero Legendre directions force containment
of every determinant-one matrix.  Thus a Frey/Legendre specialization needs
two nontrivial local inertia directions, not a separate global irreducibility
or subgroup-classification theorem.

The arithmetic Picard--Lefschetz formula for the actual elliptic curve remains
a separate source theorem.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

namespace LegendreTwoInertia

universe u

/-- The third Legendre transvection direction. -/
def diagonalTransvection
    {F : Type u} [Ring F] (x : F) : Matrix2 F where
  a := 1 - x
  b := x
  c := -x
  d := 1 + x

@[simp]
theorem det_diagonalTransvection
    {F : Type u} [CommRing F] (x : F) :
    det (diagonalTransvection x) = 1 := by
  simp [diagonalTransvection, det]
  ring

@[simp]
theorem diagonalTransvection_zero
    {F : Type u} [Ring F] :
    diagonalTransvection (0 : F) = 1 := by
  ext <;> simp [diagonalTransvection, Matrix2.identity]

/-- The third transvection family is additive under multiplication. -/
theorem diagonalTransvection_mul
    {F : Type u} [CommRing F] (x y : F) :
    diagonalTransvection x * diagonalTransvection y =
      diagonalTransvection (x + y) := by
  ext <;> simp [diagonalTransvection, Matrix2.mul] <;> ring

/-- Powers add the third transvection parameter. -/
theorem diagonalTransvection_pow
    {F : Type u} [CommRing F] (x : F) (n : ℕ) :
    diagonalTransvection x ^ n =
      diagonalTransvection ((n : F) * x) := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [pow_succ, ih, diagonalTransvection_mul]
      congr 1
      push_cast
      ring

/-- One nonzero third-direction transvection generates the complete third
root family over `ZMod p`. -/
theorem all_diagonal_of_one_nonzero
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u : ZMod p} (hu : u ≠ 0)
    (hdiag : diagonalTransvection u ∈ C.carrier) :
    ∀ x : ZMod p, diagonalTransvection x ∈ C.carrier := by
  intro x
  let y : ZMod p := x / u
  have hpow := C.pow_mem hdiag y.val
  rw [diagonalTransvection_pow] at hpow
  have hparameter : (y.val : ZMod p) * u = x := by
    simp [y, hu]
  simpa [hparameter] using hpow

/-- Symmetric `L-U-L` factorization for determinant-one matrices with nonzero
upper-right entry. -/
theorem factor_of_det_one_of_b_ne_zero
    {F : Type u} [Field F]
    (A : Matrix2 F)
    (hdet : det A = 1)
    (hb : A.b ≠ 0) :
    A =
      lower ((A.d - 1) / A.b) *
        upper A.b *
          lower ((A.a - 1) / A.b) := by
  ext <;>
    simp [upper, lower, Matrix2.mul, det] <;>
    field_simp [hb] <;>
    try ring
  linear_combination hdet

/-- Complete lower root subgroup and one determinant-one matrix with nonzero
upper-right entry isolate an upper transvection. -/
theorem upper_of_lower_and_mover
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    (hlower : ∀ x : ZMod p, lower x ∈ C.carrier)
    (g : Matrix2 (ZMod p))
    (hg : g ∈ C.carrier)
    (hdet : det g = 1)
    (hgb : g.b ≠ 0) :
    upper g.b ∈ C.carrier := by
  let x : ZMod p := (g.d - 1) / g.b
  let y : ZMod p := (g.a - 1) / g.b
  have hfactor : g = lower x * upper g.b * lower y := by
    simpa [x, y] using
      factor_of_det_one_of_b_ne_zero g hdet hgb
  have hmem : lower (-x) * g * lower (-y) ∈ C.carrier :=
    C.mul_mem (C.mul_mem (hlower (-x)) hg) (hlower (-y))
  have hisolate : lower (-x) * g * lower (-y) = upper g.b := by
    rw [hfactor]
    simp [mul_assoc]
  rwa [hisolate] at hmem

/-- Nonzero upper and lower Legendre directions generate every
`det = 1` matrix. -/
theorem full_SL2_of_upper_lower
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u l : ZMod p} (hu : u ≠ 0) (hl : l ≠ 0)
    (hU : upper u ∈ C.carrier)
    (hL : lower l ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  have hupper := all_upper_of_one_nonzero p C hu hU
  have hlower := all_lower_of_one_nonzero p C hl hL
  exact all_det_one_mem_of_upper_lower C hupper hlower

/-- Nonzero upper and diagonal Legendre directions generate every
`det = 1` matrix. -/
theorem full_SL2_of_upper_diagonal
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u v : ZMod p} (hu : u ≠ 0) (hv : v ≠ 0)
    (hU : upper u ∈ C.carrier)
    (hV : diagonalTransvection v ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  exact all_det_one_mem_of_transvection_and_mover
    p C hu hU (diagonalTransvection v) hV
      (det_diagonalTransvection v) (neg_ne_zero.mpr hv)

/-- Nonzero lower and diagonal Legendre directions generate every
`det = 1` matrix. -/
theorem full_SL2_of_lower_diagonal
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {l v : ZMod p} (hl : l ≠ 0) (hv : v ≠ 0)
    (hL : lower l ∈ C.carrier)
    (hV : diagonalTransvection v ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  have hlower := all_lower_of_one_nonzero p C hl hL
  have hupperOne : upper v ∈ C.carrier :=
    upper_of_lower_and_mover p C hlower
      (diagonalTransvection v) hV
      (det_diagonalTransvection v) hv
  have hupper := all_upper_of_one_nonzero p C hv hupperOne
  exact all_det_one_mem_of_upper_lower C hupper hlower

/-- Enumeration of the three Legendre boundary directions. -/
inductive BoundaryDirection where
  | zero
  | one
  | infinity
  deriving DecidableEq

/-- Matrix family attached to one boundary direction. -/
def boundaryTransvection
    {F : Type u} [Ring F] :
    BoundaryDirection → F → Matrix2 F
  | .zero => upper
  | .one => lower
  | .infinity => diagonalTransvection

/-- Pairwise distinct nonzero boundary directions force full `SL₂`. -/
theorem full_SL2_of_two_boundary_directions
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    (d₁ d₂ : BoundaryDirection)
    (hd : d₁ ≠ d₂)
    {u v : ZMod p} (hu : u ≠ 0) (hv : v ≠ 0)
    (h₁ : boundaryTransvection d₁ u ∈ C.carrier)
    (h₂ : boundaryTransvection d₂ v ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  cases d₁ <;> cases d₂ <;> simp_all [boundaryTransvection]
  · exact full_SL2_of_upper_lower p C hu hv h₁ h₂
  · exact full_SL2_of_upper_diagonal p C hu hv h₁ h₂
  · exact full_SL2_of_upper_lower p C hv hu h₂ h₁
  · exact full_SL2_of_lower_diagonal p C hu hv h₁ h₂
  · exact full_SL2_of_upper_diagonal p C hv hu h₂ h₁
  · exact full_SL2_of_lower_diagonal p C hv hu h₂ h₁

end LegendreTwoInertia

end IUTThreeClosures
