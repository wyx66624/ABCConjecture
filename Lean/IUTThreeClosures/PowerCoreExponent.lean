/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Prime-exponent inequalities for square and cube cores

For a prime exponent `e`, the square core retains exponent `2 * floor(e/2)`
and the cube core retains exponent `3 * floor(e/3)`.  The elementary
inequalities

`e - 1 ≤ 2 * floor(e/2)`

and

`e - 2 ≤ 3 * floor(e/3)`

are the primewise input for the multiplicity-excess, large-square-core and
large-cube-core reductions in the v8 abc research programme.
-/

namespace IUTThreeClosures

/-- A square core loses at most one copy of each supporting prime. -/
theorem exponent_sub_one_le_two_mul_div_two (e : ℕ) :
    e - 1 ≤ 2 * (e / 2) := by
  have hmod : e % 2 < 2 := Nat.mod_lt e (by omega)
  have hdecomp : e % 2 + 2 * (e / 2) = e := by
    simpa [Nat.mul_comm] using Nat.mod_add_div e 2
  omega

/-- A cube core loses at most two copies of each supporting prime. -/
theorem exponent_sub_two_le_three_mul_div_three (e : ℕ) :
    e - 2 ≤ 3 * (e / 3) := by
  have hmod : e % 3 < 3 := Nat.mod_lt e (by omega)
  have hdecomp : e % 3 + 3 * (e / 3) = e := by
    simpa [Nat.mul_comm] using Nat.mod_add_div e 3
  omega

/-- Equivalent square-core inequality in additive-exponent form. -/
theorem exponent_le_squareCore_add_one (e : ℕ) :
    e ≤ 2 * (e / 2) + 1 := by
  have hmod : e % 2 < 2 := Nat.mod_lt e (by omega)
  have hdecomp : e % 2 + 2 * (e / 2) = e := by
    simpa [Nat.mul_comm] using Nat.mod_add_div e 2
  omega

/-- Equivalent cube-core inequality in additive-exponent form. -/
theorem exponent_le_cubeCore_add_two (e : ℕ) :
    e ≤ 3 * (e / 3) + 2 := by
  have hmod : e % 3 < 3 := Nat.mod_lt e (by omega)
  have hdecomp : e % 3 + 3 * (e / 3) = e := by
    simpa [Nat.mul_comm] using Nat.mod_add_div e 3
  omega

end IUTThreeClosures
