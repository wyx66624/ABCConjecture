/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedPrimeExponentLayer
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.Tactic

/-!
# Exact integer realization of the signed prime-exponent layer

For a nonzero natural number `n`, let

* `A₁(n)` be the product of primes occurring to exponent exactly one;
* `U₂(n)` be the product of `p^(v_p(n)-2)` over prime exponents above two.

This file proves the exact integer identity

`n * A₁(n) = rad(n)^2 * U₂(n)`.

Taking logarithms gives

`log n - 2 log rad(n) = log U₂(n) - log A₁(n)`.

Applied to the endpoint localization from the preceding module, every abc
violation forces the above-two integer layer of one large endpoint to dominate
its exponent-one layer by a conductor-scale factor.  No unproved distribution
statement or abc estimate is assumed.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace PrimeExponentIntegerLayer

/-- Product of primes whose exponent in `n` is exactly one. -/
def exponentOneLayer (n : ℕ) : ℕ :=
  n.factorization.prod fun p e => if e = 1 then p else 1

/-- Product of all exponent mass above level two. -/
def exponentAboveTwoLayer (n : ℕ) : ℕ :=
  n.factorization.prod fun p e => p ^ (e - 2)

/-- Radical as a product over the support of the factorization. -/
theorem abcRadical_eq_factorization_prod (n : ℕ) :
    abcRadical n = n.factorization.prod (fun p _ => p) := by
  unfold abcRadical Finsupp.prod
  rfl

@[simp]
theorem exponentOneLayer_pos (n : ℕ) : 0 < exponentOneLayer n := by
  classical
  unfold exponentOneLayer Finsupp.prod
  apply Finset.prod_pos
  intro p hp
  have hprime : p.Prime :=
    Nat.prime_of_mem_primeFactors (by simpa using hp)
  by_cases hone : n.factorization p = 1
  · simp [hone, hprime.pos]
  · simp [hone]

@[simp]
theorem exponentAboveTwoLayer_pos (n : ℕ) :
    0 < exponentAboveTwoLayer n := by
  classical
  unfold exponentAboveTwoLayer Finsupp.prod
  apply Finset.prod_pos
  intro p hp
  have hprime : p.Prime :=
    Nat.prime_of_mem_primeFactors (by simpa using hp)
  exact pow_pos hprime.pos _

/-- Exact integer balance between the exponent-one and above-two layers. -/
theorem mul_exponentOneLayer_eq_radical_sq_mul_aboveTwoLayer
    {n : ℕ} (hn : n ≠ 0) :
    n * exponentOneLayer n =
      abcRadical n ^ 2 * exponentAboveTwoLayer n := by
  rw [← Nat.prod_factorization_pow_eq_self hn]
  rw [abcRadical_eq_factorization_prod]
  unfold exponentOneLayer exponentAboveTwoLayer
  calc
    n.factorization.prod (fun p e => p ^ e) *
        n.factorization.prod (fun p e => if e = 1 then p else 1) =
      n.factorization.prod
        (fun p e => p ^ e * (if e = 1 then p else 1)) := by
          unfold Finsupp.prod
          rw [Finset.prod_mul_distrib]
    _ = n.factorization.prod
        (fun p e => p ^ 2 * p ^ (e - 2)) := by
          apply Finsupp.prod_congr
          intro p hp
          have hepos : 0 < n.factorization p :=
            Nat.pos_of_ne_zero (Finsupp.mem_support_iff.mp hp)
          by_cases hone : n.factorization p = 1
          · simp [hone, pow_two]
          · have htwo : 2 ≤ n.factorization p := by omega
            simp [hone, ← pow_add, Nat.add_sub_of_le htwo]
    _ = (n.factorization.prod (fun p _ => p)) ^ 2 *
        n.factorization.prod (fun p e => p ^ (e - 2)) := by
          unfold Finsupp.prod
          rw [Finset.prod_mul_distrib, ← Finset.prod_pow]

/-- Logarithmic form of the exact integer layer identity. -/
theorem log_sub_two_log_radical_eq_log_aboveTwo_sub_log_one
    {n : ℕ} (hn : n ≠ 0) :
    Real.log (n : ℝ) - 2 * Real.log (abcRadical n : ℝ) =
      Real.log (exponentAboveTwoLayer n : ℝ) -
        Real.log (exponentOneLayer n : ℝ) := by
  have hnpos : 0 < (n : ℝ) := by
    exact_mod_cast Nat.pos_of_ne_zero hn
  have honepos : 0 < (exponentOneLayer n : ℝ) := by
    exact_mod_cast exponentOneLayer_pos n
  have hradpos : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have habovepos : 0 < (exponentAboveTwoLayer n : ℝ) := by
    exact_mod_cast exponentAboveTwoLayer_pos n
  have hreal :
      (n : ℝ) * (exponentOneLayer n : ℝ) =
        (abcRadical n : ℝ) ^ 2 *
          (exponentAboveTwoLayer n : ℝ) := by
    exact_mod_cast
      (mul_exponentOneLayer_eq_radical_sq_mul_aboveTwoLayer hn)
  have hlog := congrArg Real.log hreal
  rw [Real.log_mul hnpos.ne' honepos.ne',
    Real.log_mul (pow_pos hradpos 2).ne' habovepos.ne',
    Real.log_pow] at hlog
  linarith

end PrimeExponentIntegerLayer

namespace ABCPoint

open PrimeExponentIntegerLayer

/-- The one-integer signed defect is exactly above-two layer log minus
exponent-one layer log. -/
theorem singleEndpointSquareRadicalDefect_eq_integerLayers
    {n : ℕ} (hn : n ≠ 0) :
    singleEndpointSquareRadicalDefect n =
      Real.log (exponentAboveTwoLayer n : ℝ) -
        Real.log (exponentOneLayer n : ℝ) := by
  unfold singleEndpointSquareRadicalDefect
  exact log_sub_two_log_radical_eq_log_aboveTwo_sub_log_one hn

/-- Every abc violation forces one large endpoint's above-two integer layer to
dominate its exponent-one layer by the explicit signed threshold. -/
theorem integer_layer_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let T :=
      Real.log (abcRadical P.endpointMin : ℝ) +
        epsilon * P.conductor + C - Real.log 2 / 2
    T < Real.log (exponentAboveTwoLayer P.largeEndpoint : ℝ) -
          Real.log (exponentOneLayer P.largeEndpoint : ℝ) ∨
      T < Real.log (exponentAboveTwoLayer P.c : ℝ) -
          Real.log (exponentOneLayer P.c : ℝ) := by
  dsimp
  obtain hlarge | hc :=
    P.endpoint_signed_defect_large_of_height_violation hviolation
  · left
    rw [P.singleEndpointSquareRadicalDefect_eq_integerLayers
      P.largeEndpoint_pos.ne'] at hlarge
    exact hlarge
  · right
    rw [P.singleEndpointSquareRadicalDefect_eq_integerLayers
      P.c_pos.ne'] at hc
    exact hc

end ABCPoint

namespace PrimeExponentIntegerLayer

#print axioms abcRadical_eq_factorization_prod
#print axioms mul_exponentOneLayer_eq_radical_sq_mul_aboveTwoLayer
#print axioms log_sub_two_log_radical_eq_log_aboveTwo_sub_log_one
#print axioms ABCPoint.singleEndpointSquareRadicalDefect_eq_integerLayers
#print axioms ABCPoint.integer_layer_large_of_height_violation

end PrimeExponentIntegerLayer
end
end IUTThreeClosures
