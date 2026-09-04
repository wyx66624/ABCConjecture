/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# Cubeful excess and its exact height threshold

For a positive integer `n`, define

`Q₂(n) = n / gcd(n, rad(n)^2)`.

Primewise this retains precisely the exponent mass above level two.  Applied
to `max(a,b) * c`, it gives the exact ledger

`2 * height ≤ log 2 + 2 * conductor + log Q₂`.

This file does not postulate any estimate for `Q₂`.  It proves two concrete
consequences of the ledger:

* bounded cubeful excess gives a coefficient-one abc estimate;
* every violation of a `(1+epsilon)` abc estimate forces cubeful excess with
  a fixed positive height slope.

The latter is the correct necessary threshold for a counterexample family.
-/

namespace IUTThreeClosures
namespace LargeEndpointCubefulHeightThreshold

noncomputable section

/-- Exponent mass above level two. -/
def cubefulExcess (n : ℕ) : ℕ :=
  n / Nat.gcd n (abcRadical n ^ 2)

/-- The gcd part times the quotient recovers the original integer. -/
theorem gcd_mul_cubefulExcess_eq (n : ℕ) :
    Nat.gcd n (abcRadical n ^ 2) * cubefulExcess n = n := by
  unfold cubefulExcess
  exact Nat.mul_div_cancel' (Nat.gcd_dvd_left n (abcRadical n ^ 2))

/-- Every integer is at most its radical square times its cubeful excess. -/
theorem le_radical_sq_mul_cubefulExcess (n : ℕ) :
    n ≤ abcRadical n ^ 2 * cubefulExcess n := by
  have hradpos : 0 < abcRadical n ^ 2 :=
    pow_pos (abcRadical_pos n) 2
  have hgcdle :
      Nat.gcd n (abcRadical n ^ 2) ≤ abcRadical n ^ 2 :=
    Nat.le_of_dvd hradpos (Nat.gcd_dvd_right n (abcRadical n ^ 2))
  calc
    n = Nat.gcd n (abcRadical n ^ 2) * cubefulExcess n :=
      (gcd_mul_cubefulExcess_eq n).symm
    _ ≤ abcRadical n ^ 2 * cubefulExcess n :=
      Nat.mul_le_mul_right _ hgcdle

/-- The cubeful excess is positive on positive inputs. -/
theorem cubefulExcess_pos {n : ℕ} (hn : 0 < n) :
    0 < cubefulExcess n := by
  unfold cubefulExcess
  apply Nat.div_pos
  · exact Nat.le_of_dvd hn (Nat.gcd_dvd_left n (abcRadical n ^ 2))
  · exact Nat.gcd_pos_of_pos_left _ hn

end
end LargeEndpointCubefulHeightThreshold

open LargeEndpointCubefulHeightThreshold

noncomputable section

namespace ABCPoint

/-- Cubeful excess of the two large adjacent endpoints. -/
def largePairCubefulExcess (P : ABCPoint) : ℕ :=
  cubefulExcess (P.largeEndpoint * P.c)

@[simp]
theorem largePairCubefulExcess_pos (P : ABCPoint) :
    0 < P.largePairCubefulExcess := by
  apply cubefulExcess_pos
  exact mul_pos P.largeEndpoint_pos P.c_pos

/-- Natural-number radical-square/excess estimate for the large pair. -/
theorem largeEndpoint_mul_c_le_radical_sq_mul_largePairCubefulExcess
    (P : ABCPoint) :
    P.largeEndpoint * P.c ≤
      abcRadical (P.a * P.b * P.c) ^ 2 *
        P.largePairCubefulExcess := by
  calc
    P.largeEndpoint * P.c ≤
        abcRadical (P.largeEndpoint * P.c) ^ 2 *
          P.largePairCubefulExcess := by
      simpa [largePairCubefulExcess] using
        le_radical_sq_mul_cubefulExcess (P.largeEndpoint * P.c)
    _ ≤ abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largePairCubefulExcess := by
      exact Nat.mul_le_mul_right _
        (Nat.pow_le_pow_left P.radical_largeEndpoint_mul_c_le_abcRadical 2)

/-- Exact natural-number cubeful-excess ledger. -/
theorem c_sq_le_two_radical_sq_mul_largePairCubefulExcess
    (P : ABCPoint) :
    P.c ^ 2 ≤
      2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
        P.largePairCubefulExcess) := by
  calc
    P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
      P.c_sq_le_two_largeEndpoint_mul_c
    _ ≤ 2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largePairCubefulExcess) :=
      Nat.mul_le_mul_left 2
        P.largeEndpoint_mul_c_le_radical_sq_mul_largePairCubefulExcess

/-- Exact logarithmic cubeful-excess ledger. -/
theorem two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.conductor +
        Real.log (P.largePairCubefulExcess : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hqpos : 0 < (P.largePairCubefulExcess : ℝ) := by
    exact_mod_cast P.largePairCubefulExcess_pos
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((abcRadical (P.a * P.b * P.c) : ℝ) ^ 2 *
          (P.largePairCubefulExcess : ℝ)) := by
    exact_mod_cast P.c_sq_le_two_radical_sq_mul_largePairCubefulExcess
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (mul_pos (pow_pos hradpos 2) hqpos).ne',
      Real.log_mul (pow_pos hradpos 2).ne' hqpos.ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  linarith

/-- A fixed logarithmic bound for the cubeful excess gives a coefficient-one
abc estimate with an explicit constant. -/
theorem height_le_conductor_add_constant_of_log_largePairCubefulExcess_le
    (P : ABCPoint) {K : ℝ}
    (hexcess : Real.log (P.largePairCubefulExcess : ℝ) ≤ K) :
    P.height ≤ P.conductor + (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
  nlinarith

/-- A height-relative cubeful-excess slope `delta<1` transfers with the exact
denominator `2*(1-delta)`. -/
theorem height_le_of_largePairCubefulExcess_heightSlope
    (P : ABCPoint) {delta K : ℝ}
    (hdelta : delta < 1)
    (hexcess :
      Real.log (P.largePairCubefulExcess : ℝ) ≤
        2 * delta * P.height + K) :
    P.height ≤
      (2 * P.conductor + K + Real.log 2) /
        (2 * (1 - delta)) := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
  have hden : 0 < 2 * (1 - delta) := by linarith
  apply (le_div_iff₀ hden).2
  nlinarith

/-- Quantitative necessary condition for every abc violation.  The statement
is denominator-free: a violation with epsilon forces a positive linear height
slope in the logarithm of the cubeful excess. -/
theorem largePairCubefulExcess_heightSlope_large_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.height + 2 * C -
        (1 + epsilon) * Real.log 2 <
      (1 + epsilon) *
        Real.log (P.largePairCubefulExcess : ℝ) := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
  have hlower :
      2 * P.height - Real.log 2 - 2 * P.conductor ≤
        Real.log (P.largePairCubefulExcess : ℝ) := by
    linarith
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hlower hone
  nlinarith

end ABCPoint

namespace LargeEndpointCubefulHeightThreshold

#print axioms gcd_mul_cubefulExcess_eq
#print axioms le_radical_sq_mul_cubefulExcess
#print axioms cubefulExcess_pos
#print axioms ABCPoint.c_sq_le_two_radical_sq_mul_largePairCubefulExcess
#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
#print axioms ABCPoint.height_le_conductor_add_constant_of_log_largePairCubefulExcess_le
#print axioms ABCPoint.height_le_of_largePairCubefulExcess_heightSlope
#print axioms ABCPoint.largePairCubefulExcess_heightSlope_large_of_abc_violation

end LargeEndpointCubefulHeightThreshold
end
end IUTThreeClosures
