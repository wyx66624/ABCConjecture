/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AnalyticAmplificationContinuation20260830

/-!
# Actual prime support in square-completion amplification

The mathematical proofs were written first in
`research/ANALYTIC_ACTUAL_RADICAL_UNIFORM_GATE_2026_08_30.md`.

This file proves an exact decomposition of the actual integer radical into
inherited and new prime support. It then proves the necessary repeated-prime
excess for actual exceptional square completions, and checks the real-algebra
comparison of two independently established counting exponents.

The external S-unit theorem, its analytic divisor sum, the conic lattice count,
asymptotic estimates, and BBLT are not introduced as axioms or claimed to be
formalized here. No theorem in this file proves or disproves ABCConjecture.
-/

namespace IUTThreeClosures
namespace AnalyticActualRadicalUniformGate20260830

open UniqueFactorizationMonoid
open scoped BigOperators

/-- Only the primes of `n` absent from the inherited coefficient product `P`. -/
def newPrimeRadical (P n : ℕ) : ℕ :=
  ∏ p ∈ n.primeFactors \ P.primeFactors, p

/-- The exact saving from old primes and repeated powers of new primes. -/
def primeExcess (P n : ℕ) : ℕ := n / newPrimeRadical P n

theorem newPrimeRadical_pos (P n : ℕ) : 0 < newPrimeRadical P n := by
  unfold newPrimeRadical
  apply Finset.prod_pos
  intro p hp
  exact Nat.pos_of_mem_primeFactors (Finset.mem_sdiff.mp hp).1

theorem newPrimeRadical_dvd (P n : ℕ) : newPrimeRadical P n ∣ n := by
  exact (Finset.prod_dvd_prod_of_subset
    (n.primeFactors \ P.primeFactors) n.primeFactors id
    Finset.sdiff_subset).trans (Nat.prod_primeFactors_dvd n)

theorem newPrimeRadical_coprime (P n : ℕ) :
    Nat.Coprime (radical P) (newPrimeRadical P n) := by
  rw [Nat.radical_eq_prod_primeFactors, newPrimeRadical]
  apply Nat.Coprime.prod_left
  intro p hp
  apply Nat.Coprime.prod_right
  intro q hq
  obtain ⟨hqn, hqP⟩ := Finset.mem_sdiff.mp hq
  apply (Nat.coprime_primes (Nat.prime_of_mem_primeFactors hp)
    (Nat.prime_of_mem_primeFactors hqn)).mpr
  intro hpq
  exact hqP (hpq ▸ hp)

/-- Splitting the union of actual prime-factor sets gives an equality. -/
theorem radical_mul_eq_newPrimeRadical {P n : ℕ} (hP : P ≠ 0) (hn : n ≠ 0) :
    radical (P * n) = radical P * newPrimeRadical P n := by
  rw [Nat.radical_eq_prod_primeFactors, Nat.radical_eq_prod_primeFactors,
    Nat.primeFactors_mul hP hn, newPrimeRadical,
    ← Finset.prod_union Finset.disjoint_sdiff]
  simp

theorem radical_mul_sq_eq_newPrimeRadical {P n : ℕ}
    (hP : P ≠ 0) (hn : n ≠ 0) :
    radical (P * n ^ 2) = radical P * newPrimeRadical P n := by
  rw [radical_mul_eq_newPrimeRadical hP (pow_ne_zero _ hn)]
  simp only [newPrimeRadical, Nat.primeFactors_pow n (by decide : 2 ≠ 0)]

theorem newPrimeRadical_mul_primeExcess (P n : ℕ) :
    newPrimeRadical P n * primeExcess P n = n := by
  exact Nat.mul_div_cancel' (newPrimeRadical_dvd P n)

theorem primeExcess_pos {P n : ℕ} (hn : 0 < n) : 0 < primeExcess P n := by
  have h := newPrimeRadical_mul_primeExcess P n
  by_contra hnot
  have hz : primeExcess P n = 0 := by omega
  rw [hz, mul_zero] at h
  omega

/-- The actual radical of a square-completion output, with no size certificate. -/
theorem square_completion_radical_eq_newPrimeRadical {a b c x y z : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) =
      radical (a * b * c) * newPrimeRadical (a * b * c) (x * y * z) := by
  have hP : a * b * c ≠ 0 := ne_of_gt (mul_pos (mul_pos ha hb) hc)
  have hn : x * y * z ≠ 0 := ne_of_gt (mul_pos (mul_pos hx hy) hz)
  calc
    _ = radical ((a * b * c) * (x * y * z) ^ 2) := by congr 1; ring
    _ = _ := radical_mul_sq_eq_newPrimeRadical hP hn

/-- Unscaled integer completions retain the entire inherited prime support. -/
theorem square_completion_retains_seed_radical {a b c x y z : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    radical (a * b * c) ∣ radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) := by
  rw [square_completion_radical_eq_newPrimeRadical ha hb hc hx hy hz]
  exact dvd_mul_right _ _

/-- Every repetition and every old-prime reuse is accounted for exactly. -/
theorem square_completion_radical_mul_excess {a b c x y z : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) *
        primeExcess (a * b * c) (x * y * z) =
      radical (a * b * c) * (x * y * z) := by
  rw [square_completion_radical_eq_newPrimeRadical ha hb hc hx hy hz,
    mul_assoc, newPrimeRadical_mul_primeExcess]

/-- The necessary excess budget uses the actual radical hypothesis, rather
than the stronger inherited-radical-times-multiplier certificate. -/
theorem square_completion_actual_excess_budget {a b c x y z : ℕ} {μ : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z)
    (hab : a + b = c) (hconic : a * x ^ 2 + b * y ^ 2 = c * z ^ 2)
    (hactual : ((radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) : ℕ) : ℝ) ≤
      ((c * z ^ 2 : ℕ) : ℝ) ^ μ) :
    ((radical (a * b * c) : ℕ) : ℝ) * (c * z ^ 2 : ℕ) ≤
      (c : ℝ) * (primeExcess (a * b * c) (x * y * z) : ℝ) *
        ((c * z ^ 2 : ℕ) : ℝ) ^ μ := by
  have hc : 0 < c := by omega
  have hprod := AnalyticAmplificationContinuation20260830.square_completion_sq_le_product
    ha hb hx hy hab hconic
  have hnat : radical (a * b * c) * (c * z ^ 2) ≤
      c * (radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) *
        primeExcess (a * b * c) (x * y * z)) := by
    rw [square_completion_radical_mul_excess ha hb hc hx hy hz]
    nlinarith [Nat.mul_le_mul_left (radical (a * b * c) * c) hprod]
  have hreal : ((radical (a * b * c) : ℕ) : ℝ) * (c * z ^ 2 : ℕ) ≤
      (c : ℝ) * (((radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) : ℕ) : ℝ) *
        (primeExcess (a * b * c) (x * y * z) : ℝ)) := by
    have hcast := (Nat.cast_le (α := ℝ)).mpr hnat
    simpa only [Nat.cast_mul] using hcast
  calc
    _ ≤ _ := hreal
    _ = (c : ℝ) * (primeExcess (a * b * c) (x * y * z) : ℝ) *
        ((radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) : ℕ) : ℝ) := by ring
    _ ≤ _ := mul_le_mul_of_nonneg_left hactual
      (mul_nonneg (Nat.cast_nonneg c) (Nat.cast_nonneg _))

/-- The numerical exponent appearing in the cited BBLT v2 estimates.
This definition does not assert the analytic estimates themselves. -/
noncomputable def bbltExponent (μ : ℝ) : ℝ :=
  min (2 * μ / 3) (min ((23 * μ + 3) / 40) (3 / 5))

theorem bbltExponent_pos {μ : ℝ} (hμ : 0 < μ) : 0 < bbltExponent μ := by
  unfold bbltExponent
  simp only [lt_min_iff]
  constructor
  · linarith
  constructor <;> linarith

theorem bbltExponent_ge_half {μ : ℝ} (hμ : 3 / 4 ≤ μ) :
    1 / 2 ≤ bbltExponent μ := by
  unfold bbltExponent
  simp only [le_min_iff]
  constructor
  · linarith
  constructor <;> linarith

theorem bbltExponent_eq_two_thirds {μ : ℝ} (hμ : μ ≤ 3 / 4) :
    bbltExponent μ = 2 * μ / 3 := by
  unfold bbltExponent
  apply min_eq_left
  apply le_min <;> linarith

/-- Both actual counting exponents can exceed BBLT only in this range. -/
theorem actual_conic_exponent_window {K ρ σ μ : ℝ}
    (hK : 0 < K) (hρ : 0 < ρ) (hμ : 0 < μ)
    (hconic : K * bbltExponent μ < max 0 ((K - ρ) / 2))
    (hsupport : K * bbltExponent μ < K * μ - σ) :
    ρ + 4 * σ < K ∧ 3 * σ / K < μ ∧ μ < 3 / 4 * (1 - ρ / K) ∧ μ < 3 / 4 := by
  have hsmall : μ < 3 / 4 := by
    by_contra hnot
    have hF := bbltExponent_ge_half (le_of_not_gt hnot)
    have hmax : max 0 ((K - ρ) / 2) < K / 2 := by
      apply max_lt <;> linarith
    have hKF : K / 2 ≤ K * bbltExponent μ := by nlinarith
    linarith
  rw [bbltExponent_eq_two_thirds (le_of_lt hsmall)] at hconic hsupport
  have hpositive : 0 < K * (2 * μ / 3) := by positivity
  have hgeom : K * (2 * μ / 3) < (K - ρ) / 2 := by
    rcases lt_max_iff.mp hconic with h | h
    · linarith
    · exact h
  refine ⟨by nlinarith, ?_, ?_, hsmall⟩
  · apply (div_lt_iff₀ hK).mpr
    nlinarith
  · have heq : (3 : ℝ) / 4 * (1 - ρ / K) = ((3 : ℝ) / 4 * (K - ρ)) / K := by
      field_simp
    rw [heq]
    apply (lt_div_iff₀ hK).mpr
    nlinarith

/-- In the complementary height range there is no strict exponent gain.
Turning this into an asymptotic count also uses the paper estimates. -/
theorem actual_conic_min_exponent_le {K ρ σ μ : ℝ}
    (hK : 0 < K) (hρ : 0 < ρ) (hμ : 0 < μ) (hheight : K ≤ ρ + 4 * σ) :
    min (max 0 ((K - ρ) / 2)) (K * μ - σ) ≤ K * bbltExponent μ := by
  by_contra hnot
  rcases lt_min_iff.mp (lt_of_not_ge hnot) with ⟨hconic, hsupport⟩
  have h := (actual_conic_exponent_window hK hρ hμ hconic hsupport).1
  linarith

/-- Rational multipliers can remove inherited primes, even with primitive
input and output. The corresponding mathematical example is in Section 5. -/
theorem rational_completion_support_loss_coordinates :
    (49 : ℚ) * (3 / 7) ^ 2 = 9 ∧
    (576 : ℚ) * (1 / 6) ^ 2 = 16 ∧
    (625 : ℚ) * (1 / 5) ^ 2 = 25 ∧
    (49 : ℕ) + 576 = 625 ∧ (9 : ℕ) + 16 = 25 ∧
    Nat.Coprime 49 576 ∧ Nat.Coprime 9 16 ∧ (7 : ℕ) ∣ 49 * 576 * 625 ∧
    ¬ (7 : ℕ) ∣ 9 * 16 * 25 := by
  norm_num

/-- Exact integer separators used in the strict quality-loss counterexample. -/
theorem quadratic_quality_separator_powers :
    (2 : ℕ) ^ 38 < 3 ^ 24 ∧ (17 : ℕ) ^ 24 < 6 ^ 38 := by
  norm_num

#print axioms radical_mul_eq_newPrimeRadical
#print axioms newPrimeRadical_coprime
#print axioms radical_mul_sq_eq_newPrimeRadical
#print axioms square_completion_retains_seed_radical
#print axioms square_completion_radical_mul_excess
#print axioms square_completion_actual_excess_budget
#print axioms actual_conic_exponent_window
#print axioms actual_conic_min_exponent_le
#print axioms rational_completion_support_loss_coordinates
#print axioms quadratic_quality_separator_powers

end AnalyticActualRadicalUniformGate20260830
end IUTThreeClosures
