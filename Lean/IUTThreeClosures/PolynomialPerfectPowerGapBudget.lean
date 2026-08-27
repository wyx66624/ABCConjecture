/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The scalar Mason budget for polynomial perfect-power gaps

Suppose a characteristic-zero polynomial identity has the form

`X^m + A = Y^n`.

After a Mason--Stothers estimate one obtains a degree inequality

`D ≤ deg X + deg Y + deg A`,

where `deg X ≤ D / m` and `deg Y ≤ D / n`.  This module kernel-checks the
source-independent real-arithmetic consequence

`D * (1 - 1/m - 1/n) ≤ deg A`.

For square--cube gaps this lower bound is `D/6`.  Hence a polynomial
parametrization cannot achieve the strict exponent saving below `1/6` required
by the generalized perfect-power disproof criterion.

The polynomial Mason--Stothers theorem itself is not postulated here; it will
be connected only after a suitable verified polynomial-abc API is available.
-/

namespace IUTThreeClosures

/-- Scalar consequence of a Mason--Stothers degree inequality. -/
theorem polynomialPerfectPowerGap_degree_lower_bound
    {m n D x y z : ℝ}
    (hx : x ≤ D / m)
    (hy : y ≤ D / n)
    (hmason : D ≤ x + y + z) :
    D * (1 - 1 / m - 1 / n) ≤ z := by
  have hxy : x + y ≤ D / m + D / n :=
    add_le_add hx hy
  calc
    D * (1 - 1 / m - 1 / n) = D - D / m - D / n := by ring
    _ ≤ z := by linarith

/-- If the total degree is positive, every upper exponent for the gap is at
least the Mason threshold `1 - 1/m - 1/n`. -/
theorem polynomialPerfectPowerGap_exponent_lower_bound
    {m n D x y z θ : ℝ}
    (hD : 0 < D)
    (hx : x ≤ D / m)
    (hy : y ≤ D / n)
    (hmason : D ≤ x + y + z)
    (hz : z ≤ θ * D) :
    1 - 1 / m - 1 / n ≤ θ := by
  have hgap :=
    polynomialPerfectPowerGap_degree_lower_bound hx hy hmason
  have hmul :
      D * (1 - 1 / m - 1 / n) ≤ D * θ := by
    calc
      D * (1 - 1 / m - 1 / n) ≤ z := hgap
      _ ≤ θ * D := hz
      _ = D * θ := by ring
  nlinarith [hmul]

/-- Square--cube specialization of the Mason degree threshold. -/
theorem squareCubePolynomialGap_degree_lower_bound
    {D x y z : ℝ}
    (hx : x ≤ D / 3)
    (hy : y ≤ D / 2)
    (hmason : D ≤ x + y + z) :
    D / 6 ≤ z := by
  have h :=
    polynomialPerfectPowerGap_degree_lower_bound
      (m := (3 : ℝ)) (n := (2 : ℝ)) hx hy hmason
  convert h using 1 <;> norm_num <;> ring

/-- A positive-degree square--cube polynomial identity cannot have a gap
exponent strictly below `1/6`. -/
theorem no_squareCubePolynomialGap_below_one_sixth
    {D x y z θ : ℝ}
    (hD : 0 < D)
    (hx : x ≤ D / 3)
    (hy : y ≤ D / 2)
    (hmason : D ≤ x + y + z)
    (hz : z ≤ θ * D)
    (hθ : θ < 1 / 6) : False := by
  have h := squareCubePolynomialGap_degree_lower_bound hx hy hmason
  have hupper : z < D / 6 := by
    have : θ * D < (1 / 6 : ℝ) * D :=
      mul_lt_mul_of_pos_right hθ hD
    calc
      z ≤ θ * D := hz
      _ < (1 / 6 : ℝ) * D := this
      _ = D / 6 := by ring
  exact (not_lt_of_ge h) hupper

end IUTThreeClosures
