/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The scalar Mason obstruction to perfect-power gap counterexamples

For a pairwise-coprime polynomial identity

`Y^n - X^m = Z`

whose two perfect-power terms have common degree `D` and whose gap has degree
`d < D`, Mason--Stothers gives

`D <= D/m + D/n + d - 1`.

This module verifies the exact real-algebra consequence:

`1 + 1/D <= d/D + 1/m + 1/n`.

Therefore the strict generalized perfect-power disproof budget is impossible
for a fixed polynomial parametrization.  Mason--Stothers and the polynomial
radical estimate are deliberately not postulated here; they remain the
algebraic source of the displayed degree inequality.
-/

namespace IUTThreeClosures

/-- The exact normalized consequence of the Mason degree inequality. -/
theorem masonPerfectPowerGap_budget
    {m n D d : ℝ}
    (hm : 0 < m)
    (hn : 0 < n)
    (hD : 0 < D)
    (hMason : D ≤ D / m + D / n + d - 1) :
    1 + 1 / D ≤ d / D + 1 / m + 1 / n := by
  have hm0 : m ≠ 0 := ne_of_gt hm
  have hn0 : n ≠ 0 := ne_of_gt hn
  have hD0 : D ≠ 0 := ne_of_gt hD
  have hscaled : D + 1 ≤ D / m + D / n + d := by
    linarith
  have hdiv :
      (D + 1) / D ≤ (D / m + D / n + d) / D :=
    (div_le_div_iff_of_pos_right hD).2 hscaled
  convert hdiv using 1 <;> field_simp [hm0, hn0, hD0] <;> ring

/-- A Mason-compatible degree identity cannot satisfy the strict
perfect-power abc-disproof budget. -/
theorem not_masonPerfectPowerGap_disproofBudget
    {m n D d : ℝ}
    (hm : 0 < m)
    (hn : 0 < n)
    (hD : 0 < D)
    (hMason : D ≤ D / m + D / n + d - 1) :
    ¬ d / D + 1 / m + 1 / n < 1 := by
  intro hstrict
  have hbudget :=
    masonPerfectPowerGap_budget hm hn hD hMason
  linarith

/-- At the square--cube specialization, a polynomial gap lies strictly above
the Hall exponent by the finite-degree correction `1 / D`. -/
theorem squareCube_masonGap_lowerBound
    {D d : ℝ}
    (hD : 0 < D)
    (hMason : D ≤ D / 2 + D / 3 + d - 1) :
    (1 / 6 : ℝ) + 1 / D ≤ d / D := by
  have hbudget := masonPerfectPowerGap_budget
    (m := (2 : ℝ)) (n := (3 : ℝ))
    (by norm_num) (by norm_num) hD hMason
  norm_num at hbudget
  linarith

end IUTThreeClosures
