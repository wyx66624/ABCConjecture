/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Scalar barrier for one-endpoint power-divisor counting

A naive union bound counts integers up to `X` carrying a `j`-th-power divisor
of size at least `X^alpha`, then multiplies by a gap length `X^theta`. Its
formal exponent is

`1 + theta - alpha * (j-1)/j`.

Since a divisor of an endpoint has `alpha<=1`, this exponent is always
strictly positive. Therefore one-endpoint sparsity plus a free choice of every
gap cannot by itself prove eventual emptiness; a successful counting route
must exploit correlation between both endpoints or additional arithmetic
constraints.
-/

namespace IUTThreeClosures
namespace PowerDivisorCountingExponentBarrier

noncomputable section

/-- The naive one-endpoint union-bound exponent is always positive. -/
theorem naive_powerDivisor_gap_count_exponent_pos
    {j : ℕ} (hj : 0 < j)
    {alpha theta : ℝ}
    (halpha0 : 0 ≤ alpha)
    (halpha1 : alpha ≤ 1)
    (htheta : 0 ≤ theta) :
    0 < 1 + theta -
      alpha * (((j : ℝ) - 1) / (j : ℝ)) := by
  have hjR : 0 < (j : ℝ) := by exact_mod_cast hj
  have hjOne : (1 : ℝ) ≤ j := by exact_mod_cast hj
  have hfrac0 :
      0 ≤ ((j : ℝ) - 1) / (j : ℝ) :=
    div_nonneg (by linarith) hjR.le
  have hfrac_lt_one :
      ((j : ℝ) - 1) / (j : ℝ) < 1 := by
    apply (div_lt_iff₀ hjR).2
    linarith
  have hprod_le :
      alpha * (((j : ℝ) - 1) / (j : ℝ)) ≤
        ((j : ℝ) - 1) / (j : ℝ) :=
    mul_le_of_le_one_left hfrac0 halpha1
  linarith

/-- More explicit lower bound by `theta + 1/j`. -/
theorem theta_add_inv_j_le_naive_exponent
    {j : ℕ} (hj : 0 < j)
    {alpha theta : ℝ}
    (halpha0 : 0 ≤ alpha)
    (halpha1 : alpha ≤ 1) :
    theta + 1 / (j : ℝ) ≤
      1 + theta -
        alpha * (((j : ℝ) - 1) / (j : ℝ)) := by
  have hjR : 0 < (j : ℝ) := by exact_mod_cast hj
  have hjOne : (1 : ℝ) ≤ j := by exact_mod_cast hj
  have hfrac0 :
      0 ≤ ((j : ℝ) - 1) / (j : ℝ) :=
    div_nonneg (by linarith) hjR.le
  have hprod_le :
      alpha * (((j : ℝ) - 1) / (j : ℝ)) ≤
        ((j : ℝ) - 1) / (j : ℝ) :=
    mul_le_of_le_one_left hfrac0 halpha1
  have hid :
      1 - (((j : ℝ) - 1) / (j : ℝ)) = 1 / (j : ℝ) := by
    field_simp [hjR.ne']
    ring
  rw [← hid]
  linarith

#print axioms naive_powerDivisor_gap_count_exponent_pos
#print axioms theta_add_inv_j_le_naive_exponent

end
end PowerDivisorCountingExponentBarrier
end IUTThreeClosures
