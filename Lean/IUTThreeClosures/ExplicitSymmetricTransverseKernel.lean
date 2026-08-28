/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricTransverseKernel

/-!
# An explicit symmetric transverse operator

Assume a field contains `i` with `i^2=-1` and let `nu` be a nonsquare.  Define

`a=(1+nu)/2`, `b=(1-nu)/(2*i)`.

Then `a^2+b^2=nu`, so the symmetric operator `[[a,b],[b,-a]]` is universally
transverse and its graph is isotropic.  The construction applies to the
auxiliary finite fields selected by primes congruent to one modulo twelve.
-/

namespace IUTThreeClosures

universe u

variable {F : Type u} [Field F]

/-- First coefficient of the explicit symmetric operator. -/
def explicitSymmetricA (nu : F) : F :=
  (1 + nu) / 2

/-- Second coefficient of the explicit symmetric operator. -/
def explicitSymmetricB (i nu : F) : F :=
  (1 - nu) / (2 * i)

/-- A square root of `-1` in a nontrivial field is nonzero. -/
theorem sqrtNegOne_ne_zero {i : F} (hi : i ^ 2 = -1) : i ≠ 0 := by
  intro h
  subst i
  norm_num at hi

/-- The two explicit coefficients have square sum `nu`. -/
theorem explicitSymmetric_sq_sum
    {i nu : F}
    (hchar : (2 : F) ≠ 0)
    (hi : i ^ 2 = -1) :
    explicitSymmetricA nu ^ 2 +
        explicitSymmetricB i nu ^ 2 = nu := by
  have hi0 : i ≠ 0 := sqrtNegOne_ne_zero hi
  unfold explicitSymmetricA explicitSymmetricB
  field_simp [hchar, hi0]
  nlinarith [hi]

/-- The explicit operator has no nonzero ground-field eigenvector when `nu`
is a nonsquare. -/
theorem explicitSymmetric_no_eigenvector
    {i nu lambda x y : F}
    (hchar : (2 : F) ≠ 0)
    (hi : i ^ 2 = -1)
    (hnu : ¬ ∃ z : F, z ^ 2 = nu)
    (h : symmetricTransverseOperator
        (explicitSymmetricA nu)
        (explicitSymmetricB i nu)
        (x, y) =
      (lambda * x, lambda * y)) :
    x = 0 ∧ y = 0 := by
  exact symmetricTransverseOperator_no_eigenvector
    (explicitSymmetric_sq_sum hchar hi) hnu h

/-- The explicit graph is transverse to every finite-slope scalar diagonal. -/
theorem explicitSymmetricGraph_inter_scalarDiagonal
    {i nu lambda : F} {z w : F × F}
    (hchar : (2 : F) ≠ 0)
    (hi : i ^ 2 = -1)
    (hnu : ¬ ∃ c : F, c ^ 2 = nu)
    (h : symmetricTransverseGraphPoint
        (explicitSymmetricA nu)
        (explicitSymmetricB i nu) z =
      scalarDiagonalPoint lambda w) :
    z = (0, 0) ∧ w = (0, 0) := by
  exact symmetricGraph_inter_scalarDiagonal
    (explicitSymmetric_sq_sum hchar hi) hnu h

/-- The explicit graph is isotropic for the product symplectic pairing. -/
theorem explicitSymmetricGraph_isotropic
    (i nu : F) (x y : F × F) :
    productSymplecticPairing
      (symmetricTransverseGraphPoint
        (explicitSymmetricA nu)
        (explicitSymmetricB i nu) x)
      (symmetricTransverseGraphPoint
        (explicitSymmetricA nu)
        (explicitSymmetricB i nu) y) = 0 :=
  symmetricGraph_isotropic _ _ _ _

end IUTThreeClosures
