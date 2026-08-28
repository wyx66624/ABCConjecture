/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Squaring signed Legendre transvections

At a potentially multiplicative local place, the torsion representation is a
quadratic sign times the Tate unipotent representation.  Squaring removes the
central sign and doubles the unipotent parameter.

This module verifies the matrix identity for all three standard Legendre
Picard--Lefschetz directions.  It is the elementary algebraic layer of the
actual local-inertia theorem; no local elliptic curve, Tate uniformization or
Galois representation is assumed here.
-/

namespace IUTThreeClosures

namespace SignedLegendreTransvection

universe u

variable {R : Type u} [CommRing R]

/-- Two-by-two matrices over the coefficient ring. -/
abbrev Matrix2 := Matrix (Fin 2) (Fin 2) R

/-- Upper Legendre transvection. -/
def upper (x : R) : Matrix2 :=
  !![1, x; 0, 1]

/-- Lower Legendre transvection. -/
def lower (x : R) : Matrix2 :=
  !![1, 0; x, 1]

/-- The third Legendre Picard--Lefschetz direction. -/
def third (x : R) : Matrix2 :=
  !![1 - x, x; -x, 1 + x]

/-- A central sign times the upper transvection. -/
def signedUpper (ε x : R) : Matrix2 :=
  !![ε, ε * x; 0, ε]

/-- A central sign times the lower transvection. -/
def signedLower (ε x : R) : Matrix2 :=
  !![ε, 0; ε * x, ε]

/-- A central sign times the third transvection. -/
def signedThird (ε x : R) : Matrix2 :=
  !![ε * (1 - x), ε * x; ε * (-x), ε * (1 + x)]

/-- Upper transvection parameters add under multiplication. -/
theorem upper_mul (x y : R) :
    upper x * upper y = upper (x + y) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [upper, Matrix.mul_apply, Fin.sum_univ_two] <;> ring

/-- Lower transvection parameters add under multiplication. -/
theorem lower_mul (x y : R) :
    lower x * lower y = lower (x + y) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [lower, Matrix.mul_apply, Fin.sum_univ_two] <;> ring

/-- Third-direction transvection parameters add under multiplication. -/
theorem third_mul (x y : R) :
    third x * third y = third (x + y) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [third, Matrix.mul_apply, Fin.sum_univ_two] <;> ring

/-- Squaring a signed upper transvection removes the sign and doubles the
parameter. -/
theorem signedUpper_sq
    (ε x : R)
    (hε : ε ^ 2 = 1) :
    signedUpper ε x * signedUpper ε x = upper (2 * x) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [signedUpper, upper, Matrix.mul_apply, Fin.sum_univ_two] <;>
    nlinarith

/-- Squaring a signed lower transvection removes the sign and doubles the
parameter. -/
theorem signedLower_sq
    (ε x : R)
    (hε : ε ^ 2 = 1) :
    signedLower ε x * signedLower ε x = lower (2 * x) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [signedLower, lower, Matrix.mul_apply, Fin.sum_univ_two] <;>
    nlinarith

/-- Squaring a signed third-direction transvection removes the sign and doubles
the parameter. -/
theorem signedThird_sq
    (ε x : R)
    (hε : ε ^ 2 = 1) :
    signedThird ε x * signedThird ε x = third (2 * x) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [signedThird, third, Matrix.mul_apply, Fin.sum_univ_two] <;>
    nlinarith

end SignedLegendreTransvection

end IUTThreeClosures
