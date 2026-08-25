/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteFermatIrreducibility

/-!
# Pointwise Jacobian nonsingularity of the projective Fermat equation

For a characteristic-zero field and a positive exponent, the three partial
derivatives of `X^n + Y^n - Z^n` cannot vanish simultaneously at a nonzero
triple.  In particular, every field-valued projective Fermat point satisfies
the elementary Jacobian nonsingularity condition.

This module deliberately stops at the coordinate statement.  It does not yet
construct the projective scheme or invoke a scheme-level Jacobian criterion.
-/

namespace IUTThreeClosures
namespace ConcreteProjectiveFermatSmoothness

universe u

variable {K : Type u} [Field K]

/-- The homogeneous Fermat equation evaluated at a coordinate triple. -/
def fermatHomogeneousValue (n : ℕ) (x y z : K) : K :=
  x ^ n + y ^ n - z ^ n

/-- The `X`-partial derivative evaluated at a coordinate triple. -/
def fermatPartialX (n : ℕ) (x : K) : K :=
  (n : K) * x ^ (n - 1)

/-- The `Y`-partial derivative evaluated at a coordinate triple. -/
def fermatPartialY (n : ℕ) (y : K) : K :=
  (n : K) * y ^ (n - 1)

/-- The `Z`-partial derivative evaluated at a coordinate triple. -/
def fermatPartialZ (n : ℕ) (z : K) : K :=
  -((n : K) * z ^ (n - 1))

/-- A coordinate representative of a projective Fermat point. -/
def IsProjectiveFermatPoint (n : ℕ) (x y z : K) : Prop :=
  fermatHomogeneousValue n x y z = 0 ∧
    (x ≠ 0 ∨ y ≠ 0 ∨ z ≠ 0)

/-- The elementary coordinate Jacobian-singularity condition. -/
def IsFermatJacobianSingular (n : ℕ) (x y z : K) : Prop :=
  fermatPartialX n x = 0 ∧
    fermatPartialY n y = 0 ∧
    fermatPartialZ n z = 0

/-- At a nonzero coordinate triple, at least one Fermat partial derivative is
nonzero. -/
theorem fermat_partials_not_all_zero
    [CharZero K] {n : ℕ} (hn : 0 < n) {x y z : K}
    (hxyz : x ≠ 0 ∨ y ≠ 0 ∨ z ≠ 0) :
    fermatPartialX n x ≠ 0 ∨
      fermatPartialY n y ≠ 0 ∨
      fermatPartialZ n z ≠ 0 := by
  have hnK : (n : K) ≠ 0 :=
    Nat.cast_ne_zero.mpr (Nat.ne_of_gt hn)
  rcases hxyz with hx | hy | hz
  · exact Or.inl (mul_ne_zero hnK (pow_ne_zero _ hx))
  · exact Or.inr (Or.inl (mul_ne_zero hnK (pow_ne_zero _ hy)))
  · exact Or.inr (Or.inr (neg_ne_zero.mpr
      (mul_ne_zero hnK (pow_ne_zero _ hz))))

/-- No field-valued projective Fermat point is Jacobian-singular in
characteristic zero. -/
theorem projectiveFermatPoint_not_jacobianSingular
    [CharZero K] {n : ℕ} (hn : 0 < n) {x y z : K}
    (hpoint : IsProjectiveFermatPoint n x y z) :
    ¬ IsFermatJacobianSingular n x y z := by
  intro hsing
  rcases fermat_partials_not_all_zero hn hpoint.2 with hx | hy | hz
  · exact hx hsing.1
  · exact hy hsing.2.1
  · exact hz hsing.2.2

end ConcreteProjectiveFermatSmoothness
end IUTThreeClosures
