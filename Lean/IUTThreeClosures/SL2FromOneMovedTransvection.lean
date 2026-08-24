/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2UnipotentFactorization

/-!
# From one moved transvection to all of `SL₂`

Over the prime field `ZMod p`, one nontrivial transvection supplies its entire
one-parameter root subgroup by taking powers.  If a matrix `A` moves the fixed
line of the upper transvection, then a suitable upper-unipotent conjugation of

`A * U(1) * A⁻¹`

is a nontrivial lower transvection.  Hence a multiplicatively closed image that
contains all upper unipotents, a moving matrix `A`, and its inverse contains
all lower unipotents.  The explicit factorization theorem of
`SL2UnipotentFactorization` then gives every determinant-one matrix.

This is the elementary group-theoretic core of the semistable Frey
large-image route.  The remaining arithmetic inputs are:

* multiplicative inertia supplies one nontrivial transvection;
* irreducibility supplies a matrix moving its fixed line.
-/

namespace IUTThreeClosures

namespace MatrixTwo

universe u

variable {F : Type u}

/-- The adjugate formula for the inverse of a `2 × 2` matrix.  It is used under
the explicit hypothesis that the determinant is nonzero. -/
def inverse [Field F] (A : MatrixTwo F) : MatrixTwo F :=
  { a11 := A.a22 / det A
    a12 := -A.a12 / det A
    a21 := -A.a21 / det A
    a22 := A.a11 / det A }

/-- Upper unipotents add their parameters. -/
theorem upper_mul_upper [CommRing F] (x y : F) :
    upper x * upper y = upper (x + y) := by
  ext <;> simp [upper] <;> ring

/-- Lower unipotents add their parameters. -/
theorem lower_mul_lower [CommRing F] (x y : F) :
    lower x * lower y = lower (x + y) := by
  ext <;> simp [lower] <;> ring

/-- Normalize the conjugate of the standard upper transvection by a matrix
whose lower-left entry is nonzero. -/
theorem normalize_moved_upper
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A ≠ 0)
    (hc : A.a21 ≠ 0) :
    ((((upper (-A.a11 / A.a21) * A) * upper 1) * inverse A) *
        upper (A.a11 / A.a21)) =
      lower (-(A.a21 ^ 2) / det A) := by
  ext <;>
    simp [upper, lower, inverse, det] <;>
    field_simp [hdet, hc] <;>
    ring

/-- The normalized lower-transvection parameter is nonzero. -/
theorem normalized_lower_parameter_ne_zero
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A ≠ 0)
    (hc : A.a21 ≠ 0) :
    -(A.a21 ^ 2) / det A ≠ 0 := by
  exact div_ne_zero (neg_ne_zero.mpr (pow_ne_zero 2 hc)) hdet

/-- Repeated multiplication by one lower transvection yields every natural
multiple of its parameter. -/
theorem lower_natMultiple_mem
    [Field F]
    (S : Set (MatrixTwo F))
    (hmul : ∀ {A B : MatrixTwo F}, A ∈ S → B ∈ S → A * B ∈ S)
    (hzero : lower 0 ∈ S)
    {s : F} (hs : lower s ∈ S) :
    ∀ n : ℕ, lower ((n : F) * s) ∈ S := by
  intro n
  induction n with
  | zero => simpa using hzero
  | succ n ih =>
      have hprod := hmul ih hs
      rw [lower_mul_lower] at hprod
      convert hprod using 1
      push_cast
      ring

/-- Over a prime field, one nonzero lower transvection generates the complete
lower root subgroup. -/
theorem all_lower_mem_of_one_nonzero
    {p : ℕ} [Fact p.Prime]
    (S : Set (MatrixTwo (ZMod p)))
    (hmul :
      ∀ {A B : MatrixTwo (ZMod p)}, A ∈ S → B ∈ S → A * B ∈ S)
    (hzero : lower 0 ∈ S)
    {s : ZMod p} (hs0 : s ≠ 0) (hs : lower s ∈ S) :
    ∀ t : ZMod p, lower t ∈ S := by
  intro t
  let n : ℕ := (t / s).val
  have hn := lower_natMultiple_mem S hmul hzero hs n
  have hcoeff : ((n : ℕ) : ZMod p) * s = t := by
    dsimp [n]
    rw [ZMod.natCast_zmod_val]
    exact div_mul_cancel₀ t hs0
  simpa [hcoeff] using hn

/-- A multiplicatively closed matrix image containing the full upper root
subgroup and one matrix moving its fixed line contains every determinant-one
matrix.  The inverse of the moving matrix is supplied explicitly, as it is
automatic for an actual subgroup of `GL₂`. -/
theorem mem_all_det_one_of_moved_upper
    {p : ℕ} [Fact p.Prime]
    (S : Set (MatrixTwo (ZMod p)))
    (hmul :
      ∀ {A B : MatrixTwo (ZMod p)}, A ∈ S → B ∈ S → A * B ∈ S)
    (hupper : ∀ t : ZMod p, upper t ∈ S)
    (A : MatrixTwo (ZMod p))
    (hA : A ∈ S)
    (hAinv : inverse A ∈ S)
    (hdet : det A ≠ 0)
    (hc : A.a21 ≠ 0) :
    ∀ M : MatrixTwo (ZMod p), det M = 1 → M ∈ S := by
  let r : ZMod p := -A.a11 / A.a21
  let s : ZMod p := -(A.a21 ^ 2) / det A
  have hconj : lower s ∈ S := by
    have hmem :
        ((((upper r * A) * upper 1) * inverse A) * upper (-r)) ∈ S :=
      hmul (hmul (hmul (hmul (hupper r) hA) (hupper 1)) hAinv)
        (hupper (-r))
    have heq :
        ((((upper r * A) * upper 1) * inverse A) * upper (-r)) =
          lower s := by
      dsimp [r, s]
      simpa [neg_div] using normalize_moved_upper A hdet hc
    rwa [heq] at hmem
  have hs0 : s ≠ 0 := by
    dsimp [s]
    exact normalized_lower_parameter_ne_zero A hdet hc
  have hlower : ∀ t : ZMod p, lower t ∈ S :=
    all_lower_mem_of_one_nonzero S hmul (by simpa using hupper 0) hs0 hconj
  intro M hM
  exact mem_of_det_eq_one S hmul hupper hlower M hM

end MatrixTwo

end IUTThreeClosures
