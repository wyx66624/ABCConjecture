/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# Quantitative cubeful excess on the two large abc endpoints

For a positive integer `n`, set

`Q(n) = n / gcd(n, rad(n)^2)`.

This retains precisely the prime-exponent mass above level two.  The elementary
identity behind the route is

`n ≤ rad(n)^2 * Q(n)`.

Applied to `n = max(a,b) * c`, it gives

`2 * height ≤ log 2 + 2 * conductor + log Q`.

Thus subcritical control of `Q` proves abc, while every abc violation forces
quantitatively large cubeful excess.  No such control theorem is assumed here.
-/

namespace IUTThreeClosures
namespace LargeEndpointCubefulExcess

noncomputable section

/-- The factor left after removing from `n` at most two copies of each prime. -/
def cubefulExcess (n : ℕ) : ℕ :=
  n / Nat.gcd n (abcRadical n ^ 2)

/-- The gcd part times the cubeful excess recovers the original integer. -/
theorem gcd_mul_cubefulExcess_eq (n : ℕ) :
    Nat.gcd n (abcRadical n ^ 2) * cubefulExcess n = n := by
  unfold cubefulExcess
  have hdiv : Nat.gcd n (abcRadical n ^ 2) ∣ n :=
    Nat.gcd_dvd_left n (abcRadical n ^ 2)
  have hcancel := Nat.div_mul_cancel hdiv
  simpa [Nat.mul_comm] using hcancel

/-- Every integer is bounded by radical square times its cubeful excess. -/
theorem le_radical_sq_mul_cubefulExcess (n : ℕ) :
    n ≤ abcRadical n ^ 2 * cubefulExcess n := by
  have hradpos : 0 < abcRadical n ^ 2 :=
    pow_pos (abcRadical_pos n) 2
  have hgcd : Nat.gcd n (abcRadical n ^ 2) ≤ abcRadical n ^ 2 :=
    Nat.le_of_dvd hradpos (Nat.gcd_dvd_right n (abcRadical n ^ 2))
  calc
    n = Nat.gcd n (abcRadical n ^ 2) * cubefulExcess n :=
      (gcd_mul_cubefulExcess_eq n).symm
    _ ≤ abcRadical n ^ 2 * cubefulExcess n :=
      Nat.mul_le_mul_right _ hgcd

/-- Cubeful excess is positive on positive inputs. -/
theorem cubefulExcess_pos {n : ℕ} (hn : 0 < n) :
    0 < cubefulExcess n := by
  unfold cubefulExcess
  have hgpos : 0 < Nat.gcd n (abcRadical n ^ 2) :=
    Nat.gcd_pos_of_pos_left (abcRadical n ^ 2) hn
  have hgle : Nat.gcd n (abcRadical n ^ 2) ≤ n :=
    Nat.le_of_dvd hn (Nat.gcd_dvd_left n (abcRadical n ^ 2))
  exact Nat.div_pos hgpos hgle

end
end LargeEndpointCubefulExcess

open LargeEndpointCubefulExcess

noncomputable section

namespace ABCPoint

/-- Cubeful excess of the product of the two large adjacent endpoints. -/
def largeEndpointCubefulExcess (P : ABCPoint) : ℕ :=
  cubefulExcess (P.largeEndpoint * P.c)

@[simp]
theorem largeEndpointCubefulExcess_pos (P : ABCPoint) :
    0 < P.largeEndpointCubefulExcess := by
  apply cubefulExcess_pos
  exact mul_pos P.largeEndpoint_pos P.c_pos

/-- Move the radical-square/excess estimate from the large-endpoint product to
`abc`. -/
theorem largeEndpoint_mul_c_le_abcRadical_sq_mul_cubefulExcess
    (P : ABCPoint) :
    P.largeEndpoint * P.c ≤
      abcRadical (P.a * P.b * P.c) ^ 2 *
        P.largeEndpointCubefulExcess := by
  calc
    P.largeEndpoint * P.c ≤
        abcRadical (P.largeEndpoint * P.c) ^ 2 *
          P.largeEndpointCubefulExcess := by
      simpa [largeEndpointCubefulExcess] using
        le_radical_sq_mul_cubefulExcess (P.largeEndpoint * P.c)
    _ ≤ abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largeEndpointCubefulExcess := by
      exact Nat.mul_le_mul_right _
        (Nat.pow_le_pow_left P.radical_largeEndpoint_mul_c_le_abcRadical 2)

/-- Exact natural-number cubeful-excess estimate for the abc height. -/
theorem c_sq_le_two_radical_sq_mul_cubefulExcess (P : ABCPoint) :
    P.c ^ 2 ≤
      2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
        P.largeEndpointCubefulExcess) := by
  calc
    P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
      P.c_sq_le_two_largeEndpoint_mul_c
    _ ≤ 2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largeEndpointCubefulExcess) :=
      Nat.mul_le_mul_left 2
        P.largeEndpoint_mul_c_le_abcRadical_sq_mul_cubefulExcess

/-- Logarithmic cubeful-excess ledger. -/
theorem two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.conductor +
        Real.log (P.largeEndpointCubefulExcess : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hqpos : 0 < (P.largeEndpointCubefulExcess : ℝ) := by
    exact_mod_cast P.largeEndpointCubefulExcess_pos
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((abcRadical (P.a * P.b * P.c) : ℝ) ^ 2 *
          (P.largeEndpointCubefulExcess : ℝ)) := by
    exact_mod_cast P.c_sq_le_two_radical_sq_mul_cubefulExcess
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

/-- A relative conductor bound on the cubeful excess gives the standard abc
slope. -/
theorem height_le_of_cubefulExcess_bound
    (P : ABCPoint) {epsilon K : ℝ}
    (hexcess :
      Real.log (P.largeEndpointCubefulExcess : ℝ) ≤
        2 * epsilon * P.conductor + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
  nlinarith

/-- Every violation forces a quantitatively large cubeful excess. -/
theorem cubefulExcess_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 <
      Real.log (P.largeEndpointCubefulExcess : ℝ) := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
  nlinarith

end ABCPoint

namespace LargeEndpointCubefulExcess

/-- A direct quantitative target for the remaining large-endpoint arithmetic.
It contains no abc conclusion as an assumption. -/
def UniformLargeEndpointCubefulExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      Real.log (P.largeEndpointCubefulExcess : ℝ) ≤
        2 * epsilon * P.conductor + K

/-- Uniform subcritical cubeful-excess control implies the logarithmic abc
conjecture. -/
theorem abc_of_uniformLargeEndpointCubefulExcessBound
    (hbound : UniformLargeEndpointCubefulExcessBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨(K + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hpoint := ABCPoint.height_le_of_cubefulExcess_bound P (hK P)
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms gcd_mul_cubefulExcess_eq
#print axioms le_radical_sq_mul_cubefulExcess
#print axioms cubefulExcess_pos
#print axioms ABCPoint.c_sq_le_two_radical_sq_mul_cubefulExcess
#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
#print axioms ABCPoint.height_le_of_cubefulExcess_bound
#print axioms ABCPoint.cubefulExcess_large_of_height_violation
#print axioms abc_of_uniformLargeEndpointCubefulExcessBound

end LargeEndpointCubefulExcess
end
end IUTThreeClosures
