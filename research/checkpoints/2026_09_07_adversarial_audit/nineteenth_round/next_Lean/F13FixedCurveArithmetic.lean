import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Algebra.Field.ZMod
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Sum
import Mathlib.Tactic

/-!
# A finite arithmetic certificate for the fixed curve at thirteen

The polynomial Bezout identity is in `Polynomial (ZMod 13)`. The other statements
concern the literal affine equations, chart coordinates and third-division
x-numerators. The disjoint-sum finite model is not a construction of a projective
curve. Elliptic multiplication, reduction and all rational or p-adic conclusions
remain outside this module.
-/

set_option autoImplicit false
set_option maxHeartbeats 8000000
set_option maxRecDepth 100000

namespace ABCF13FixedCurve20260908

abbrev F := ZMod 13

instance : Fact (Nat.Prime 13) := ⟨by decide⟩

open Polynomial

noncomputable def sexticPoly : Polynomial F := X ^ 6 - C 27 * X ^ 4 + C 99 * X ^ 2 - C 9

def sextic (z : F) : F := z ^ 6 - 27 * z ^ 4 + 99 * z ^ 2 - 9

def elliptic (a b x y : F) : Prop := y ^ 2 = x ^ 3 + a * x + b

instance (a b x y : F) : Decidable (elliptic a b x y) := by
  unfold elliptic
  infer_instance

def psi (a b x : F) : F := 3 * x ^ 4 + 6 * a * x ^ 2 + 12 * b * x - a ^ 2

def d4 (a b x : F) : F :=
  x ^ 6 + 5 * a * x ^ 4 + 20 * b * x ^ 3 - 5 * a ^ 2 * x ^ 2 -
    4 * a * b * x - 8 * b ^ 2 - a ^ 3

def phi (a b x : F) : F :=
  x * psi a b x ^ 2 - 8 * (x ^ 3 + a * x + b) * d4 a b x

def xFirst (z : F) : F := (z ^ 2 - 9) / 4

def yFirst (w : F) : F := w / 8

def xSecond (z : F) : F := (33 - 9 / z ^ 2) / 4

def ySecond (z w : F) : F := -9 * w / (8 * z ^ 3)

def secondNumerator (x : F) : F := phi (-189) 999 x - 11 * psi (-189) 999 x ^ 2

def affinePoints : Finset (F × F) :=
  Finset.univ.filter (fun zw ↦ zw.2 ^ 2 = sextic zw.1)

def affineTable : Finset (F × F) :=
  {(0, 2), (0, 11), (1, 5), (1, 8), (3, 3), (3, 10), (6, 3),
    (6, 10), (7, 3), (7, 10), (10, 3), (10, 10), (12, 5), (12, 8)}

def ellipticAffineCount (a b : F) : ℕ :=
  ((Finset.univ : Finset (F × F)).filter (fun xy ↦ elliptic a b xy.1 xy.2)).card

abbrev ModelPoint := Sum (F × F) F

def validModel : ModelPoint → Prop
  | Sum.inl (z, w) => w ^ 2 = sextic z
  | Sum.inr ε => ε ^ 2 = 1

instance (p : ModelPoint) : Decidable (validModel p) := by
  cases p with
  | inl zw => rcases zw with ⟨z, w⟩; exact inferInstanceAs (Decidable (w ^ 2 = sextic z))
  | inr ε => exact inferInstanceAs (Decidable (ε ^ 2 = 1))

def modelPoints : Finset ModelPoint := Finset.univ.filter validModel

def firstZero : ModelPoint → Prop
  | Sum.inl (z, _) => psi (-9) (-9) (xFirst z) = 0
  | Sum.inr _ => True

def secondTarget : ModelPoint → Prop
  | Sum.inl (z, _) => z ≠ 0 ∧ secondNumerator (xSecond z) = 0
  | Sum.inr _ => secondNumerator (33 / 4) = 0

instance (p : ModelPoint) : Decidable (firstZero p) := by
  cases p with
  | inl zw =>
    rcases zw with ⟨z, w⟩
    exact inferInstanceAs (Decidable (psi (-9) (-9) (xFirst z) = 0))
  | inr ε => exact inferInstanceAs (Decidable True)

instance (p : ModelPoint) : Decidable (secondTarget p) := by
  cases p with
  | inl zw =>
    rcases zw with ⟨z, w⟩
    exact inferInstanceAs (Decidable (z ≠ 0 ∧ secondNumerator (xSecond z) = 0))
  | inr ε => exact inferInstanceAs (Decidable (secondNumerator (33 / 4) = 0))

theorem sextic_eval (z : F) : sexticPoly.eval z = sextic z := by
  simp [sexticPoly, sextic]

/-- This is an identity of polynomials, not just thirteen evaluation identities. -/
theorem sextic_polynomial_bezout :
    (C 10 + C 8 * X ^ 2) * sexticPoly +
      (C 6 * X + C 3 * X ^ 3) * sexticPoly.derivative = 1 := by
  norm_num [sexticPoly, derivative_sub, derivative_add, derivative_C_mul_X_pow,
    derivative_X_pow]
  simp only [C_ofNat]
  have hz : (13 : Polynomial F) = 0 := by
    simpa only [C_ofNat, map_zero] using
      congrArg (C : F → Polynomial F) (show (13 : F) = 0 by decide)
  linear_combination (-7 + 162 * X ^ 2 + 36 * X ^ 4 - 38 * X ^ 6 + 2 * X ^ 8) * hz

theorem affine_table_exact : affinePoints = affineTable := by decide

theorem affine_count : affinePoints.card = 14 := by decide

theorem elliptic_affine_counts :
    ellipticAffineCount (-9) (-9) = 14 ∧ ellipticAffineCount (-189) 999 = 14 := by decide

theorem infinity_signs : ∀ ε : F, ε ^ 2 = 1 ↔ ε = 1 ∨ ε = -1 := by decide

theorem complete_finite_model_count : modelPoints.card = 16 := by decide

theorem nonzero_projection_equations : ∀ z w : F, w ^ 2 = sextic z → z ≠ 0 →
    elliptic (-9) (-9) (xFirst z) (yFirst w) ∧
      elliptic (-189) 999 (xSecond z) (ySecond z w) := by decide +kernel

theorem zero_projection_equation : ∀ w : F, w ^ 2 = sextic 0 →
    elliptic (-9) (-9) (-9 / 4) (yFirst w) := by decide +kernel

theorem infinity_projection_equation : ∀ ε : F, ε ^ 2 = 1 →
    elliptic (-189) 999 (33 / 4) (-9 * ε / 8) := by decide +kernel

/-- Substitute the actual curve equation into the third-division numerator. -/
theorem numerator_substitution (a b x y : F) (h : elliptic a b x y) :
    phi a b x = x * psi a b x ^ 2 - (4 * y * d4 a b x) * (2 * y) := by
  unfold elliptic at h
  unfold phi
  rw [← h]
  ring

theorem nonzero_chart_exclusion : ∀ z w : F, w ^ 2 = sextic z → z ≠ 0 →
    psi (-9) (-9) (xFirst z) = 0 → secondNumerator (xSecond z) ≠ 0 := by decide +kernel

theorem zero_chart_first_psi : psi (-9) (-9) (-9 / 4) = 7 := by decide +kernel

theorem infinity_chart_second_numerator : secondNumerator (33 / 4) = 9 := by decide +kernel

/-- This is a literal finite-predicate exclusion, not an abstract group-operation theorem. -/
theorem complete_finite_exclusion : ∀ p : ModelPoint, validModel p →
    ¬(firstZero p ∧ secondTarget p) := by decide +kernel

#print axioms sextic_eval
#print axioms sextic_polynomial_bezout
#print axioms affine_table_exact
#print axioms affine_count
#print axioms elliptic_affine_counts
#print axioms infinity_signs
#print axioms complete_finite_model_count
#print axioms nonzero_projection_equations
#print axioms zero_projection_equation
#print axioms infinity_projection_equation
#print axioms numerator_substitution
#print axioms nonzero_chart_exclusion
#print axioms zero_chart_first_psi
#print axioms infinity_chart_second_numerator
#print axioms complete_finite_exclusion

end ABCF13FixedCurve20260908
