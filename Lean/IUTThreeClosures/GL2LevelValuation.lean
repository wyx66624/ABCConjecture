/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The level-prime valuation in the order of `GL₂(F_p)`

The numerical order formula

`|GL₂(F_p)| = p * (p - 1)^2 * (p + 1)`

has exactly one factor of the prime `p`.  This is the elementary finite-group
input used by the full torsion-field root-discriminant estimate: a local
ramification index inside `GL₂(F_p)` has `p`-adic valuation at most one.

This module proves only the natural-number divisibility statement.  Connecting
it to the cardinality of the matrix group and to local different exponents is
kept as a separate arithmetic layer.
-/

namespace IUTThreeClosures

/-- A prime does not divide its predecessor. -/
theorem prime_not_dvd_pred {p : ℕ} (hp : p.Prime) :
    ¬ p ∣ p - 1 := by
  intro h
  have hpred_pos : 0 < p - 1 := by
    omega
  have hle : p ≤ p - 1 := Nat.le_of_dvd hpred_pos h
  omega

/-- A prime does not divide its successor. -/
theorem prime_not_dvd_succ {p : ℕ} (hp : p.Prime) :
    ¬ p ∣ p + 1 := by
  intro h
  rcases h with ⟨k, hk⟩
  have hp_two : 2 ≤ p := hp.two_le
  have hk_pos : 0 < k := by
    by_contra hk0
    have : k = 0 := Nat.eq_zero_of_not_pos hk0
    subst k
    simp at hk
  have hk_lt_two : k < 2 := by
    by_contra hk2
    have hk_ge_two : 2 ≤ k := by omega
    nlinarith
  have hk_one : k = 1 := by omega
  subst k
  omega

/-- The prime occurs only once in the standard cardinality expression for
`GL₂(F_p)`. -/
theorem prime_sq_not_dvd_gl2OrderExpression
    {p : ℕ} (hp : p.Prime) :
    ¬ p ^ 2 ∣ p * (p - 1) ^ 2 * (p + 1) := by
  intro hsq
  let A : ℕ := (p - 1) ^ 2 * (p + 1)
  have hp_pos : 0 < p := hp.pos
  have hpa : p ∣ A := by
    rcases hsq with ⟨k, hk⟩
    refine ⟨p * k, ?_⟩
    dsimp [A]
    apply Nat.eq_of_mul_eq_mul_left hp_pos
    simpa [pow_two, mul_assoc, mul_left_comm, mul_comm] using hk
  rcases hp.dvd_mul.mp hpa with hpredSq | hsucc
  · have hpred : p ∣ p - 1 := hp.dvd_of_dvd_pow hpredSq
    exact prime_not_dvd_pred hp hpred
  · exact prime_not_dvd_succ hp hsucc

/-- The standard cardinality expression is divisible by the prime itself. -/
theorem prime_dvd_gl2OrderExpression
    {p : ℕ} (hp : p.Prime) :
    p ∣ p * (p - 1) ^ 2 * (p + 1) := by
  exact dvd_mul_right p ((p - 1) ^ 2 * (p + 1))

/-- Combined exact-multiplicity form: `p` divides the expression, but `p²`
does not. -/
theorem prime_exactly_once_in_gl2OrderExpression
    {p : ℕ} (hp : p.Prime) :
    p ∣ p * (p - 1) ^ 2 * (p + 1) ∧
      ¬ p ^ 2 ∣ p * (p - 1) ^ 2 * (p + 1) :=
  ⟨prime_dvd_gl2OrderExpression hp,
    prime_sq_not_dvd_gl2OrderExpression hp⟩

end IUTThreeClosures
