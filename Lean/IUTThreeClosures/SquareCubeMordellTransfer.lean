/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Square--cube endpoint equations and their Mordell rescaling

Two mixed-depth endpoint equations occur naturally after extracting square and
cube divisors from an abc triple:

`v*z^3 - u*x^2 = m`

and

`v*y^2 - u*x^3 = m`.

This file records their exact transformations to Mordell equations.  It also
records the common monomial factors in all three transformed terms.  Hence the
Mordell equation is a rescaling of the original generalized Fermat equation;
its primitive core is not a new abc triple.

No height or radical estimate is assumed.
-/

namespace IUTThreeClosures
namespace SquareCubeMordellTransfer

/-- A cube-minus-square equation gives a Mordell equation after monomial
rescaling. -/
theorem cube_minus_square_to_mordell
    (u v x z m : ℤ)
    (h : v * z ^ 3 - u * x ^ 2 = m) :
    (u * v * z) ^ 3 =
      (u ^ 2 * v * x) ^ 2 + u ^ 3 * v ^ 2 * m := by
  have hv : v * z ^ 3 = u * x ^ 2 + m := by
    linarith
  calc
    (u * v * z) ^ 3 = u ^ 3 * v ^ 2 * (v * z ^ 3) := by ring
    _ = u ^ 3 * v ^ 2 * (u * x ^ 2 + m) := by rw [hv]
    _ = (u ^ 2 * v * x) ^ 2 + u ^ 3 * v ^ 2 * m := by ring

/-- A square-minus-cube equation gives the other sign of a Mordell equation. -/
theorem square_minus_cube_to_mordell
    (u v x y m : ℤ)
    (h : v * y ^ 2 - u * x ^ 3 = m) :
    (u * v ^ 2 * y) ^ 2 =
      (u * v * x) ^ 3 + u ^ 2 * v ^ 3 * m := by
  have hv : v * y ^ 2 = u * x ^ 3 + m := by
    linarith
  calc
    (u * v ^ 2 * y) ^ 2 = u ^ 2 * v ^ 3 * (v * y ^ 2) := by ring
    _ = u ^ 2 * v ^ 3 * (u * x ^ 3 + m) := by rw [hv]
    _ = (u * v * x) ^ 3 + u ^ 2 * v ^ 3 * m := by ring

/-- The three terms in the cube-minus-square Mordell equation are exactly the
original three terms multiplied by the same factor `u^3*v^2`. -/
theorem cube_minus_square_scaled_terms
    (u v x z m : ℤ) :
    (u * v * z) ^ 3 = u ^ 3 * v ^ 2 * (v * z ^ 3) ∧
      (u ^ 2 * v * x) ^ 2 = u ^ 3 * v ^ 2 * (u * x ^ 2) ∧
      u ^ 3 * v ^ 2 * m = u ^ 3 * v ^ 2 * m := by
  constructor
  · ring
  constructor
  · ring
  · rfl

/-- The three terms in the square-minus-cube Mordell equation are exactly the
original three terms multiplied by the same factor `u^2*v^3`. -/
theorem square_minus_cube_scaled_terms
    (u v x y m : ℤ) :
    (u * v ^ 2 * y) ^ 2 = u ^ 2 * v ^ 3 * (v * y ^ 2) ∧
      (u * v * x) ^ 3 = u ^ 2 * v ^ 3 * (u * x ^ 3) ∧
      u ^ 2 * v ^ 3 * m = u ^ 2 * v ^ 3 * m := by
  constructor
  · ring
  constructor
  · ring
  · rfl

/-- In natural numbers, the cube-minus-square Mordell terms share the factor
`u^3*v^2`. -/
theorem cube_minus_square_common_factor
    (u v x z m : ℕ) :
    u ^ 3 * v ^ 2 ∣ (u * v * z) ^ 3 ∧
      u ^ 3 * v ^ 2 ∣ (u ^ 2 * v * x) ^ 2 ∧
      u ^ 3 * v ^ 2 ∣ u ^ 3 * v ^ 2 * m := by
  constructor
  · refine ⟨v * z ^ 3, ?_⟩
    ring
  constructor
  · refine ⟨u * x ^ 2, ?_⟩
    ring
  · exact dvd_mul_right _ _

/-- In natural numbers, the square-minus-cube Mordell terms share the factor
`u^2*v^3`. -/
theorem square_minus_cube_common_factor
    (u v x y m : ℕ) :
    u ^ 2 * v ^ 3 ∣ (u * v ^ 2 * y) ^ 2 ∧
      u ^ 2 * v ^ 3 ∣ (u * v * x) ^ 3 ∧
      u ^ 2 * v ^ 3 ∣ u ^ 2 * v ^ 3 * m := by
  constructor
  · refine ⟨v * y ^ 2, ?_⟩
    ring
  constructor
  · refine ⟨u * x ^ 3, ?_⟩
    ring
  · exact dvd_mul_right _ _

/-- A common divisor larger than one prevents coprimality of the first two
Mordell terms. -/
theorem not_coprime_of_common_factor
    {g A B : ℕ} (hg : 1 < g) (hA : g ∣ A) (hB : g ∣ B) :
    ¬ Nat.Coprime A B := by
  intro hcoprime
  have hg_one : g = 1 := Nat.eq_one_of_dvd_coprimes hcoprime hA hB
  omega

/-- Unless the rescaling factor is one, the cube-minus-square Mordell pair is
not primitive. -/
theorem cube_minus_square_not_coprime
    {u v x z : ℕ} (hscale : 1 < u ^ 3 * v ^ 2) :
    ¬ Nat.Coprime ((u * v * z) ^ 3) ((u ^ 2 * v * x) ^ 2) := by
  exact not_coprime_of_common_factor hscale
    (cube_minus_square_common_factor u v x z 1).1
    (cube_minus_square_common_factor u v x z 1).2.1

/-- Unless the rescaling factor is one, the square-minus-cube Mordell pair is
not primitive. -/
theorem square_minus_cube_not_coprime
    {u v x y : ℕ} (hscale : 1 < u ^ 2 * v ^ 3) :
    ¬ Nat.Coprime ((u * v ^ 2 * y) ^ 2) ((u * v * x) ^ 3) := by
  exact not_coprime_of_common_factor hscale
    (square_minus_cube_common_factor u v x y 1).1
    (square_minus_cube_common_factor u v x y 1).2.1

#print axioms cube_minus_square_to_mordell
#print axioms square_minus_cube_to_mordell
#print axioms cube_minus_square_common_factor
#print axioms square_minus_cube_common_factor
#print axioms not_coprime_of_common_factor
#print axioms cube_minus_square_not_coprime
#print axioms square_minus_cube_not_coprime

end SquareCubeMordellTransfer
end IUTThreeClosures
