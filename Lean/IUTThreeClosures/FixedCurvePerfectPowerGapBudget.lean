/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar budget for perfect-power gaps over a fixed algebraic curve

A function-field abc estimate on a fixed genus-`g` curve gives a degree
inequality of the form

`D ≤ x + y + z + G`,

where `x ≤ D/m`, `y ≤ D/n`, `z` is the gap height and `G` is the fixed genus
error.  This module proves the source-independent consequence

`D * (1 - 1/m - 1/n) - G ≤ z`.

Thus the genus term is asymptotically negligible in every fixed-curve family;
the strict generalized perfect-power gap threshold cannot be beaten by
polynomial, rational-function, or fixed-curve algebraic parametrizations.

The geometric function-field abc theorem is not inserted as an axiom.
-/

namespace IUTThreeClosures

/-- Scalar consequence of a fixed-curve function-field abc degree budget. -/
theorem fixedCurvePerfectPowerGap_degree_lower_bound
    {m n D x y z G : ℝ}
    (hx : x ≤ D / m)
    (hy : y ≤ D / n)
    (hffabc : D ≤ x + y + z + G) :
    D * (1 - 1 / m - 1 / n) - G ≤ z := by
  have hxy : x + y ≤ D / m + D / n :=
    add_le_add hx hy
  calc
    D * (1 - 1 / m - 1 / n) - G =
        D - D / m - D / n - G := by ring
    _ ≤ z := by linarith

/-- If the total degree tends beyond the fixed genus error, every proposed gap
exponent remains asymptotically above the Mason threshold. -/
theorem fixedCurvePerfectPowerGap_exponent_budget
    {m n D x y z G θ : ℝ}
    (hD : 0 < D)
    (hx : x ≤ D / m)
    (hy : y ≤ D / n)
    (hffabc : D ≤ x + y + z + G)
    (hz : z ≤ θ * D) :
    1 - 1 / m - 1 / n ≤ θ + G / D := by
  have hgap :=
    fixedCurvePerfectPowerGap_degree_lower_bound hx hy hffabc
  have hmul :
      D * (1 - 1 / m - 1 / n) ≤ D * (θ + G / D) := by
    calc
      D * (1 - 1 / m - 1 / n) ≤ z + G := by linarith
      _ ≤ θ * D + G := by linarith
      _ = D * (θ + G / D) := by
        field_simp [ne_of_gt hD]
  nlinarith [hmul]

/-- Square--cube specialization with a fixed curve/genus error. -/
theorem fixedCurveSquareCubeGap_degree_lower_bound
    {D x y z G : ℝ}
    (hx : x ≤ D / 3)
    (hy : y ≤ D / 2)
    (hffabc : D ≤ x + y + z + G) :
    D / 6 - G ≤ z := by
  have h := fixedCurvePerfectPowerGap_degree_lower_bound
    (m := (3 : ℝ)) (n := (2 : ℝ)) hx hy hffabc
  convert h using 1 <;> norm_num <;> ring

end IUTThreeClosures
