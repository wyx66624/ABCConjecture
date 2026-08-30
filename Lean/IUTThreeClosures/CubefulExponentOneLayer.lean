/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointCubefulExcess
import IUTThreeClosures.LargeEndpointSignedMultiplicityExcess
import Mathlib.Tactic

/-!
# Exact cancellation between cubeful and exponent-one layers

For a positive integer `n`, put

`Q(n) = n / gcd(n, rad(n)^2)`

and

`L₁(n) = rad(n)^2 / gcd(n, rad(n)^2)`.

Primewise, `Q` retains exponent mass above two, while `L₁` is exactly the
product of primes occurring to exponent one.  The natural-number identity

`n * L₁(n) = rad(n)^2 * Q(n)`

gives the logarithmic identity

`log n - 2 log rad(n) = log Q(n) - log L₁(n)`.

Thus the sharp obstruction is cubeful mass after cancellation by the
squarefree exponent-one layer.
-/

namespace IUTThreeClosures
namespace CubefulExponentOneLayer

open LargeEndpointCubefulExcess
open LargeEndpointSignedMultiplicityExcess

noncomputable section

/-- The quotient of radical square by its part already contained in `n`.
Primewise this is the product of primes of exact exponent one. -/
def exponentOneLayer (n : ℕ) : ℕ :=
  abcRadical n ^ 2 / Nat.gcd n (abcRadical n ^ 2)

/-- The gcd part times the exponent-one layer is radical square. -/
theorem gcd_mul_exponentOneLayer_eq (n : ℕ) :
    Nat.gcd n (abcRadical n ^ 2) * exponentOneLayer n =
      abcRadical n ^ 2 := by
  unfold exponentOneLayer
  have hdiv : Nat.gcd n (abcRadical n ^ 2) ∣ abcRadical n ^ 2 :=
    Nat.gcd_dvd_right n (abcRadical n ^ 2)
  have hcancel := Nat.div_mul_cancel hdiv
  simpa [Nat.mul_comm] using hcancel

/-- The exponent-one layer is always positive. -/
theorem exponentOneLayer_pos (n : ℕ) : 0 < exponentOneLayer n := by
  by_contra hnot
  have hzero : exponentOneLayer n = 0 := Nat.eq_zero_of_not_pos hnot
  have hprod := gcd_mul_exponentOneLayer_eq n
  rw [hzero, mul_zero] at hprod
  have hradne : abcRadical n ^ 2 ≠ 0 :=
    pow_ne_zero 2 (abcRadical_pos n).ne'
  exact hradne hprod.symm

/-- Exact cross-multiplication identity between the two quotient layers. -/
theorem mul_exponentOneLayer_eq_radical_sq_mul_cubefulExcess (n : ℕ) :
    n * exponentOneLayer n =
      abcRadical n ^ 2 * cubefulExcess n := by
  calc
    n * exponentOneLayer n =
        (Nat.gcd n (abcRadical n ^ 2) * cubefulExcess n) *
          exponentOneLayer n := by
      rw [gcd_mul_cubefulExcess_eq]
    _ =
        (Nat.gcd n (abcRadical n ^ 2) * exponentOneLayer n) *
          cubefulExcess n := by ring
    _ = abcRadical n ^ 2 * cubefulExcess n := by
      rw [gcd_mul_exponentOneLayer_eq]

/-- Signed multiplicity excess equals cubeful mass minus the exact
exponent-one layer. -/
theorem signedMultiplicityExcess_eq_log_cubefulExcess_sub_log_exponentOneLayer
    {n : ℕ} (hn : 0 < n) :
    signedMultiplicityExcess n =
      Real.log (cubefulExcess n : ℝ) -
        Real.log (exponentOneLayer n : ℝ) := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hradR : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hqR : 0 < (cubefulExcess n : ℝ) := by
    exact_mod_cast cubefulExcess_pos hn
  have hL1R : 0 < (exponentOneLayer n : ℝ) := by
    exact_mod_cast exponentOneLayer_pos n
  have hprodR :
      (n : ℝ) * (exponentOneLayer n : ℝ) =
        (abcRadical n : ℝ) ^ 2 * (cubefulExcess n : ℝ) := by
    exact_mod_cast mul_exponentOneLayer_eq_radical_sq_mul_cubefulExcess n
  have hlogeq := congrArg Real.log hprodR
  rw [Real.log_mul hnR.ne' hL1R.ne',
      Real.log_mul (pow_pos hradR 2).ne' hqR.ne',
      Real.log_pow] at hlogeq
  unfold signedMultiplicityExcess
  linarith

end
end CubefulExponentOneLayer

open CubefulExponentOneLayer
open LargeEndpointCubefulExcess
open LargeEndpointSignedMultiplicityExcess

noncomputable section

namespace ABCPoint

/-- Exact exponent-one layer of the large-endpoint product. -/
def largeEndpointExponentOneLayer (P : ABCPoint) : ℕ :=
  exponentOneLayer (P.largeEndpoint * P.c)

@[simp]
theorem largeEndpointExponentOneLayer_pos (P : ABCPoint) :
    0 < P.largeEndpointExponentOneLayer :=
  exponentOneLayer_pos _

/-- The large-endpoint signed excess is exactly cubeful excess minus its
exponent-one cancellation layer. -/
theorem largeEndpointSignedMultiplicityExcess_eq_layers (P : ABCPoint) :
    P.largeEndpointSignedMultiplicityExcess =
      Real.log (P.largeEndpointCubefulExcess : ℝ) -
        Real.log (P.largeEndpointExponentOneLayer : ℝ) := by
  unfold largeEndpointSignedMultiplicityExcess
  unfold largeEndpointCubefulExcess
  unfold largeEndpointExponentOneLayer
  exact signedMultiplicityExcess_eq_log_cubefulExcess_sub_log_exponentOneLayer
    (mul_pos P.largeEndpoint_pos P.c_pos)

/-- A violation forces cubeful mass to dominate both the conductor-scale
threshold and the full exponent-one cancellation layer. -/
theorem cubefulExcess_dominates_exponentOneLayer_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 +
        Real.log (P.largeEndpointExponentOneLayer : ℝ) <
      Real.log (P.largeEndpointCubefulExcess : ℝ) := by
  have hsigned :=
    P.signedMultiplicityExcess_large_of_height_violation hviolation
  rw [P.largeEndpointSignedMultiplicityExcess_eq_layers] at hsigned
  linarith

end ABCPoint

namespace CubefulExponentOneLayer

#print axioms gcd_mul_exponentOneLayer_eq
#print axioms exponentOneLayer_pos
#print axioms mul_exponentOneLayer_eq_radical_sq_mul_cubefulExcess
#print axioms signedMultiplicityExcess_eq_log_cubefulExcess_sub_log_exponentOneLayer
#print axioms ABCPoint.largeEndpointSignedMultiplicityExcess_eq_layers
#print axioms ABCPoint.cubefulExcess_dominates_exponentOneLayer_of_height_violation

end CubefulExponentOneLayer
end
end IUTThreeClosures
