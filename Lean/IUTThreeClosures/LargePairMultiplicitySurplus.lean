/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# More than one height unit of multiplicity is necessary for an abc violation

For `M=max(a,b)`, define the net multiplicity surplus of the two large nearby
integers by

`L = log(M*c) - log rad(a*b*c)`.

The elementary inequality `c^2 <= 2*M*c` gives

`2h - log 2 - R <= L`.

Consequently an abc violation `h > (1+epsilon)R+C` forces `L` to have slope
strictly larger than one in the height.  This is the precise reason that one
isolated highly powerful endpoint, such as `2^k` in `1+2^k=2^k+1`, is not by
itself enough to violate abc: after the full radical budget is subtracted, a
counterexample needs more than one height unit of repeated-prime mass across
the large pair.
-/

namespace IUTThreeClosures
namespace LargePairMultiplicitySurplus

noncomputable section

namespace ABCPoint

/-- Logarithmic size of the two large nearby integers. -/
def largePairLog (P : ABCPoint) : ℝ :=
  Real.log (((P.largeEndpoint * P.c : ℕ) : ℝ))

/-- Net multiplicity remaining after paying the full abc radical. -/
def largePairMultiplicitySurplus (P : ABCPoint) : ℝ :=
  P.largePairLog - P.conductor

/-- The large-pair logarithm contains two height units up to `log 2`. -/
theorem two_mul_height_sub_log_two_le_largePairLog (P : ABCPoint) :
    2 * P.height - Real.log 2 ≤ P.largePairLog := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hpairpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos P.largeEndpoint_pos P.c_pos)
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hpairpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largePairLog
  linarith

/-- Exact lower corridor for the net multiplicity surplus. -/
theorem two_mul_height_sub_log_two_sub_conductor_le_surplus
    (P : ABCPoint) :
    2 * P.height - Real.log 2 - P.conductor ≤
      P.largePairMultiplicitySurplus := by
  have h := P.two_mul_height_sub_log_two_le_largePairLog
  unfold largePairMultiplicitySurplus
  linarith

/-- If the net large-pair surplus has height slope below one, then the standard
height is controlled with the exact denominator `1-delta`. -/
theorem height_le_of_largePairMultiplicitySurplus_heightSlope
    (P : ABCPoint) {delta K : ℝ}
    (hdelta : delta < 1)
    (hsurplus :
      P.largePairMultiplicitySurplus ≤
        (1 + delta) * P.height + K) :
    P.height ≤
      (P.conductor + K + Real.log 2) / (1 - delta) := by
  have hlower :=
    P.two_mul_height_sub_log_two_sub_conductor_le_surplus
  have hden : 0 < 1 - delta := by linarith
  apply (le_div_iff₀ hden).2
  nlinarith

/-- Every `(1+epsilon)` abc violation forces more than one height unit of net
multiplicity in the two large endpoints.  The denominator-free form avoids
any loss at small epsilon. -/
theorem largePairMultiplicitySurplus_large_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (1 + 2 * epsilon) * P.height + C -
        (1 + epsilon) * Real.log 2 <
      (1 + epsilon) * P.largePairMultiplicitySurplus := by
  have hlower :=
    P.two_mul_height_sub_log_two_sub_conductor_le_surplus
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hlower hone
  nlinarith

end ABCPoint

#print axioms ABCPoint.two_mul_height_sub_log_two_le_largePairLog
#print axioms ABCPoint.two_mul_height_sub_log_two_sub_conductor_le_surplus
#print axioms ABCPoint.height_le_of_largePairMultiplicitySurplus_heightSlope
#print axioms ABCPoint.largePairMultiplicitySurplus_large_of_abc_violation

end
end LargePairMultiplicitySurplus
end IUTThreeClosures
