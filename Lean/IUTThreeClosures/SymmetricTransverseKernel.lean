/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Symmetric universally transverse graph kernels

Let `T = [[a,b],[b,-a]]` over a field and assume `a^2+b^2=d`, where `d` is
not a square. Then `T^2=dI`, so `T` has no ground-field eigenvalue. Its graph
is therefore transverse to every scalar diagonal subspace. Since `T` is
symmetric, the graph is also isotropic for the standard product symplectic
form.

This is the elementary linear-algebra core of a maximal-isotropic subgroup of
`E[ell]^2` which is complementary to `L^2` for every cyclic line
`L subset E[ell]`.
-/

namespace IUTThreeClosures

universe u

variable {F : Type u} [Field F]

/-- The symmetric trace-zero operator `[[a,b],[b,-a]]`. -/
def symmetricTransverseOperator (a b : F) (z : F × F) : F × F :=
  (a * z.1 + b * z.2, b * z.1 - a * z.2)

/-- The square of the symmetric operator is scalar multiplication by
`a^2+b^2`. -/
theorem symmetricTransverseOperator_sq
    (a b : F) (z : F × F) :
    symmetricTransverseOperator a b
        (symmetricTransverseOperator a b z) =
      ((a ^ 2 + b ^ 2) * z.1,
        (a ^ 2 + b ^ 2) * z.2) := by
  rcases z with ⟨x, y⟩
  simp [symmetricTransverseOperator]
  constructor <;> ring

/-- If `a^2+b^2` is not a square, the symmetric operator has no nonzero
vector with an eigenvalue in the ground field. -/
theorem symmetricTransverseOperator_no_eigenvector
    {a b d lambda x y : F}
    (hsum : a ^ 2 + b ^ 2 = d)
    (hd : ¬ ∃ z : F, z ^ 2 = d)
    (h : symmetricTransverseOperator a b (x, y) =
      (lambda * x, lambda * y)) :
    x = 0 ∧ y = 0 := by
  have hsq := congrArg (symmetricTransverseOperator a b) h
  have hsq' :
      ((d * x, d * y) : F × F) =
        (lambda ^ 2 * x, lambda ^ 2 * y) := by
    calc
      ((d * x, d * y) : F × F) =
          symmetricTransverseOperator a b
            (symmetricTransverseOperator a b (x, y)) := by
        rw [symmetricTransverseOperator_sq, hsum]
      _ = symmetricTransverseOperator a b
          (lambda * x, lambda * y) := hsq
      _ = (lambda ^ 2 * x, lambda ^ 2 * y) := by
        simp [symmetricTransverseOperator]
        constructor <;> ring
  have hxmul : (d - lambda ^ 2) * x = 0 := by
    have hx := congrArg Prod.fst hsq'
    nlinarith
  have hymul : (d - lambda ^ 2) * y = 0 := by
    have hy := congrArg Prod.snd hsq'
    nlinarith
  have hcoef : d - lambda ^ 2 ≠ 0 := by
    intro hz
    have hdl : lambda ^ 2 = d := by
      exact (sub_eq_zero.mp hz).symm
    exact hd ⟨lambda, hdl⟩
  exact ⟨(mul_eq_zero.mp hxmul).resolve_left hcoef,
    (mul_eq_zero.mp hymul).resolve_left hcoef⟩

/-- A point in the graph of the symmetric operator. -/
def symmetricTransverseGraphPoint
    (a b : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, symmetricTransverseOperator a b z)

/-- A point in a finite-slope diagonal two-copy subspace. -/
def scalarDiagonalPoint (lambda : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, (lambda * z.1, lambda * z.2))

/-- The graph is transverse to every finite-slope diagonal. -/
theorem symmetricGraph_inter_scalarDiagonal
    {a b d lambda : F} {z w : F × F}
    (hsum : a ^ 2 + b ^ 2 = d)
    (hd : ¬ ∃ c : F, c ^ 2 = d)
    (h : symmetricTransverseGraphPoint a b z =
      scalarDiagonalPoint lambda w) :
    z = (0, 0) ∧ w = (0, 0) := by
  have hzw : z = w := congrArg Prod.fst h
  subst w
  have heig : symmetricTransverseOperator a b z =
      (lambda * z.1, lambda * z.2) :=
    congrArg Prod.snd h
  rcases z with ⟨x, y⟩
  rcases symmetricTransverseOperator_no_eigenvector
      hsum hd heig with ⟨hx, hy⟩
  subst x
  subst y
  simp

/-- The standard product symplectic pairing on `(F^2) x (F^2)`. -/
def productSymplecticPairing
    (u v : (F × F) × (F × F)) : F :=
  u.1.1 * v.2.1 + u.1.2 * v.2.2 -
    (u.2.1 * v.1.1 + u.2.2 * v.1.2)

/-- The graph of a symmetric operator is isotropic. -/
theorem symmetricGraph_isotropic
    (a b : F) (x y : F × F) :
    productSymplecticPairing
        (symmetricTransverseGraphPoint a b x)
        (symmetricTransverseGraphPoint a b y) = 0 := by
  rcases x with ⟨x₁, x₂⟩
  rcases y with ⟨y₁, y₂⟩
  simp [productSymplecticPairing, symmetricTransverseGraphPoint,
    symmetricTransverseOperator]
  ring

end IUTThreeClosures
