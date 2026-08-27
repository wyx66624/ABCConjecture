/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TransvectionLargeImageCriterion

/-!
# Any two Legendre boundary transvections force full `SL₂`

The three Picard--Lefschetz directions of the Legendre family are modeled by

`U(x) = [[1,x],[0,1]]`,
`L(x) = [[1,0],[x,1]]`,
`V(x) = [[1-x,x],[-x,1+x]]`.

The first two are the standard root subgroups.  The third has determinant one
and moves both standard fixed lines whenever `x` is nonzero.  We prove the
lower-root symmetric version of the transvection-and-mover criterion and then
show that every pair among `U`, `L`, and `V`, with nonzero parameters, forces
the image to contain every determinant-one matrix.
-/

namespace IUTThreeClosures

namespace LegendreTwoInertia

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

universe u

/-- The third Legendre/Picard--Lefschetz transvection direction. -/
def third {F : Type u} [Ring F] (x : F) : Matrix2 F where
  a := 1 - x
  b := x
  c := -x
  d := 1 + x

@[simp]
theorem det_third
    {F : Type u} [CommRing F] (x : F) :
    det (third x) = 1 := by
  dsimp [det, third]
  ring

/-- Symmetric three-unipotent factorization for a determinant-one matrix with
nonzero upper-right entry. -/
theorem factor_of_det_one_of_b_ne_zero
    {F : Type u} [Field F]
    (A : Matrix2 F)
    (hdet : det A = 1)
    (hb : A.b ≠ 0) :
    A =
      lower ((A.d - 1) / A.b) *
        upper A.b *
          lower ((A.a - 1) / A.b) := by
  change A.a * A.d - A.b * A.c = 1 at hdet
  apply Matrix2.ext
  · dsimp [upper, lower, Matrix2.mul]
    field_simp [hb] <;> ring
  · dsimp [upper, lower, Matrix2.mul]
    ring
  · dsimp [upper, lower, Matrix2.mul]
    field_simp [hb]
    linear_combination -hdet
  · dsimp [upper, lower, Matrix2.mul]
    field_simp [hb] <;> ring

/-- A complete lower root subgroup and one determinant-one matrix moving its
fixed line isolate a nonzero upper transvection. -/
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
    calc
      lower (-x) * g * lower (-y) =
          lower (-x) * (lower x * upper g.b * lower y) * lower (-y) := by
            rw [hfactor]
      _ = (lower (-x) * lower x) * upper g.b *
            (lower y * lower (-y)) := by
            ac_rfl
      _ = upper g.b := by
            rw [lower_mul_lower, lower_mul_lower, neg_add_cancel,
              add_neg_cancel, lower_zero, lower_zero, one_mul, mul_one]
  rw [hisolate] at hmem
  exact hmem

/-- Lower-root version of the transvection-and-mover full-image theorem. -/
theorem all_det_one_mem_of_lower_transvection_and_mover
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {v : ZMod p} (hv : v ≠ 0)
    (htransvection : lower v ∈ C.carrier)
    (g : Matrix2 (ZMod p))
    (hg : g ∈ C.carrier)
    (hdet : det g = 1)
    (hgb : g.b ≠ 0) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  have hlower := all_lower_of_one_nonzero p C hv htransvection
  have hUpperOne := upper_of_lower_and_mover
    p C hlower g hg hdet hgb
  have hupper := all_upper_of_one_nonzero p C hgb hUpperOne
  exact all_det_one_mem_of_upper_lower C hupper hlower

/-- Nonzero upper and lower directions force full determinant-one image. -/
theorem full_of_upper_lower
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u v : ZMod p}
    (hu : u ≠ 0) (hv : v ≠ 0)
    (hU : upper u ∈ C.carrier)
    (hL : lower v ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  have hupper := all_upper_of_one_nonzero p C hu hU
  have hlower := all_lower_of_one_nonzero p C hv hL
  exact all_det_one_mem_of_upper_lower C hupper hlower

/-- A nonzero upper direction and a nonzero third direction force full image. -/
theorem full_of_upper_third
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u w : ZMod p}
    (hu : u ≠ 0) (hw : w ≠ 0)
    (hU : upper u ∈ C.carrier)
    (hV : third w ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  apply all_det_one_mem_of_transvection_and_mover
    p C hu hU (third w) hV (det_third w)
  dsimp [third]
  exact neg_ne_zero.mpr hw

/-- A nonzero lower direction and a nonzero third direction force full image. -/
theorem full_of_lower_third
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {v w : ZMod p}
    (hv : v ≠ 0) (hw : w ≠ 0)
    (hL : lower v ∈ C.carrier)
    (hV : third w ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  apply all_det_one_mem_of_lower_transvection_and_mover
    p C hv hL (third w) hV (det_third w)
  dsimp [third]
  exact hw

end LegendreTwoInertia

end IUTThreeClosures
