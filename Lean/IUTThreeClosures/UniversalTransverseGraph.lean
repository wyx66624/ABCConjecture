/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# A graph transverse to every scalar line

Let `F` be a field and choose `d : F` which is not a square.  The companion
operator

`T(x,y) = (d*y,x)`

has no eigenvalue in `F`.  Consequently its graph in
`(F^2) x (F^2)` meets every diagonal scalar subspace

`{(z, lambda*z)}`

only at zero, and it also meets the vertical subspace only at zero.

For `F = F_ell`, this is the elementary finite-field core of the construction
of a subgroup in `E[ell]^2` complementary to `L^2` for every cyclic line
`L subset E[ell]`.
-/

namespace IUTThreeClosures

universe u

variable {F : Type u} [Field F]

/-- Companion operator of `X^2-d`. -/
def transverseCompanion (d : F) (z : F × F) : F × F :=
  (d * z.2, z.1)

/-- A point of the graph of the companion operator. -/
def transverseGraphPoint (d : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, transverseCompanion d z)

/-- A point of the diagonal copy of the line of slope `lambda`. -/
def diagonalSlopePoint (lambda : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, (lambda * z.1, lambda * z.2))

/-- A point of the vertical diagonal subspace. -/
def verticalDiagonalPoint (z : F × F) :
    (F × F) × (F × F) :=
  ((0, 0), z)

/-- If `d` is not a square, the companion operator has no nonzero eigenvector
with eigenvalue in the ground field. -/
theorem transverseCompanion_no_eigenvector
    {d lambda x y : F}
    (hd : ¬ ∃ z : F, z ^ 2 = d)
    (h : transverseCompanion d (x, y) =
      (lambda * x, lambda * y)) :
    x = 0 ∧ y = 0 := by
  have h₁ : d * y = lambda * x := congrArg Prod.fst h
  have h₂ : x = lambda * y := congrArg Prod.snd h
  by_cases hy : y = 0
  · subst y
    simp at h₂
    exact ⟨h₂, rfl⟩
  · have hdy : d * y = (lambda ^ 2) * y := by
      calc
        d * y = lambda * x := h₁
        _ = lambda * (lambda * y) := by rw [h₂]
        _ = (lambda ^ 2) * y := by ring
    have hz : (d - lambda ^ 2) * y = 0 := by
      calc
        (d - lambda ^ 2) * y = d * y - (lambda ^ 2) * y := by ring
        _ = 0 := sub_eq_zero.mpr hdy
    have hcoef : d - lambda ^ 2 = 0 :=
      (mul_eq_zero.mp hz).resolve_right hy
    have hdlam : lambda ^ 2 = d := by
      exact (sub_eq_zero.mp hcoef).symm
    exact (hd ⟨lambda, hdlam⟩).elim

/-- The graph meets every finite-slope diagonal only at the origin. -/
theorem transverseGraph_inter_diagonalSlope
    {d lambda : F} {z w : F × F}
    (hd : ¬ ∃ a : F, a ^ 2 = d)
    (h : transverseGraphPoint d z = diagonalSlopePoint lambda w) :
    z = (0, 0) ∧ w = (0, 0) := by
  have hzw : z = w := congrArg Prod.fst h
  subst w
  have heig : transverseCompanion d z =
      (lambda * z.1, lambda * z.2) :=
    congrArg Prod.snd h
  rcases z with ⟨x, y⟩
  rcases transverseCompanion_no_eigenvector hd heig with ⟨hx, hy⟩
  subst x
  subst y
  simp

/-- The graph also meets the vertical diagonal only at the origin. -/
theorem transverseGraph_inter_vertical
    {d : F} {z w : F × F}
    (h : transverseGraphPoint d z = verticalDiagonalPoint w) :
    z = (0, 0) ∧ w = (0, 0) := by
  have hz : z = (0, 0) := congrArg Prod.fst h
  subst z
  have hw : transverseCompanion d (0, 0) = w :=
    congrArg Prod.snd h
  simp [transverseCompanion] at hw
  exact ⟨rfl, hw.symm⟩

end IUTThreeClosures
