/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WronskianKernelLattice

/-!
# Actual realization of the Mersenne Wronskian obstruction

`WronskianKernelLattice.lean` proves that in the primitive family

`(1, 2^m-1, 2^m)`

every compatible nonzero free-prime-weight derivative has normalized cost
strictly larger than `m/2`.  The research note also gives a paper proof that
such compatible nonzero weight systems really exist.  This file formalizes
that missing realization step.

For a prime `q | 2^m-1`, put a weight at `q` equal to the coefficient of the
prime `2` in `D(2^m)`, and a weight at `2` equal to the coefficient of `q` in
`D(2^m-1)`.  The two derivative values are then the same nonzero product.
Consequently the normalized costs of actual compatible nondegenerate weight
systems are unbounded; a uniform constant selection theorem is impossible.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- A weight supported at one prescribed prime coordinate. -/
def singlePrimeWeight (q : ℕ) (z : ℤ) : ℕ → ℤ :=
  fun p => if p = q then z else 0

@[simp] theorem singlePrimeWeight_self (q : ℕ) (z : ℤ) :
    singlePrimeWeight q z q = z := by
  simp [singlePrimeWeight]

@[simp] theorem singlePrimeWeight_of_ne
    {p q : ℕ} (z : ℤ) (hpq : p ≠ q) :
    singlePrimeWeight q z p = 0 := by
  simp [singlePrimeWeight, hpq]

/-- The free arithmetic derivative is additive in the prime-weight system. -/
theorem weightedArithmeticDerivative_add_weights
    (x y : ℕ → ℤ) (n : ℕ) :
    weightedArithmeticDerivative (fun p => x p + y p) n =
      weightedArithmeticDerivative x n +
        weightedArithmeticDerivative y n := by
  classical
  unfold weightedArithmeticDerivative
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro p hp
  ring

/-- Exact evaluation of a one-coordinate weight. -/
theorem weightedArithmeticDerivative_singlePrimeWeight
    (n q : ℕ) (z : ℤ) :
    weightedArithmeticDerivative (singlePrimeWeight q z) n =
      if q ∈ n.primeFactors then
        (((n / q) * n.factorization q : ℕ) : ℤ) * z
      else 0 := by
  classical
  unfold weightedArithmeticDerivative
  by_cases hq : q ∈ n.primeFactors
  · simp only [hq, if_true]
    rw [Finset.sum_eq_single q]
    · simp [singlePrimeWeight]
    · intro p hp hpq
      simp [singlePrimeWeight, hpq]
    · simp [hq]
  · simp only [hq, if_false]
    apply Finset.sum_eq_zero
    intro p hp
    have hpq : p ≠ q := by
      intro heq
      subst p
      exact hq hp
    simp [singlePrimeWeight, hpq]

/-- The coefficient of the `q`-coordinate in `D(n)`. -/
def weightedPrimeCoefficient (n q : ℕ) : ℕ :=
  (n / q) * n.factorization q

/-- The coefficient of the coordinate `2` in `D(2^m)`. -/
def mersenneTwoCoefficient (m : ℕ) : ℕ :=
  m * 2 ^ (m - 1)

/-- The explicit two-coordinate weight realizing the intersection of the two
nonzero derivative-value subgroups. -/
def mersenneIntersectionWeight (m q : ℕ) : ℕ → ℤ :=
  fun p =>
    singlePrimeWeight 2
        (weightedPrimeCoefficient (2 ^ m - 1) q : ℤ) p +
      singlePrimeWeight q (mersenneTwoCoefficient m : ℤ) p

/-- The Mersenne number is coprime to the adjacent power of two. -/
theorem mersenne_coprime_two_pow
    (m : ℕ) (hm : m ≠ 0) :
    Nat.Coprime (2 ^ m - 1) (2 ^ m) := by
  have hpowpos : 0 < 2 ^ m := pow_pos (by norm_num) m
  have hone : 1 ≤ 2 ^ m := hpowpos
  exact (Nat.coprime_self_sub_left hone).2 (by simp)

/-- No positive Mersenne number is divisible by `2`. -/
theorem two_not_dvd_mersenne
    (m : ℕ) (hm : m ≠ 0) :
    ¬ 2 ∣ 2 ^ m - 1 := by
  intro htwo
  have htwoPow : 2 ∣ 2 ^ m := by
    refine ⟨2 ^ (m - 1), ?_⟩
    exact (mul_pow_sub_one hm 2).symm
  have htwoEqOne : 2 = 1 :=
    Nat.eq_one_of_dvd_coprimes
      (mersenne_coprime_two_pow m hm) htwo htwoPow
  norm_num at htwoEqOne

/-- A prime divisor of a positive Mersenne number is different from `2`. -/
theorem prime_dvd_mersenne_ne_two
    {m q : ℕ} (hm : m ≠ 0)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ m - 1) :
    q ≠ 2 := by
  intro hq2
  subst q
  exact two_not_dvd_mersenne m hm hqdvd

/-- Exact value of the explicit weight on the Mersenne side. -/
theorem weightedArithmeticDerivative_mersenneIntersection_left
    {m q : ℕ} (hm : m ≠ 0)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ m - 1) :
    weightedArithmeticDerivative (mersenneIntersectionWeight m q)
        (2 ^ m - 1) =
      ((weightedPrimeCoefficient (2 ^ m - 1) q *
        mersenneTwoCoefficient m : ℕ) : ℤ) := by
  have hnpos : 0 < 2 ^ m - 1 :=
    Nat.sub_pos_of_lt (Nat.one_lt_pow hm (by norm_num))
  have hn0 : 2 ^ m - 1 ≠ 0 := hnpos.ne'
  have hqmem : q ∈ (2 ^ m - 1).primeFactors :=
    hq.mem_primeFactors hqdvd hn0
  have htwoNotMem : 2 ∉ (2 ^ m - 1).primeFactors := by
    intro hmem
    exact two_not_dvd_mersenne m hm
      (Nat.dvd_of_mem_primeFactors hmem)
  rw [show mersenneIntersectionWeight m q =
      fun p =>
        singlePrimeWeight 2
            (weightedPrimeCoefficient (2 ^ m - 1) q : ℤ) p +
          singlePrimeWeight q (mersenneTwoCoefficient m : ℤ) p by rfl]
  rw [weightedArithmeticDerivative_add_weights,
    weightedArithmeticDerivative_singlePrimeWeight,
    weightedArithmeticDerivative_singlePrimeWeight]
  simp [htwoNotMem, hqmem, weightedPrimeCoefficient]

/-- Exact value of the same explicit weight on the power-of-two side. -/
theorem weightedArithmeticDerivative_mersenneIntersection_right
    {m q : ℕ} (hm : m ≠ 0)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ m - 1) :
    weightedArithmeticDerivative (mersenneIntersectionWeight m q)
        (2 ^ m) =
      ((weightedPrimeCoefficient (2 ^ m - 1) q *
        mersenneTwoCoefficient m : ℕ) : ℤ) := by
  have hq2 : q ≠ 2 := prime_dvd_mersenne_ne_two hm hq hqdvd
  have h2q : 2 ≠ q := Ne.symm hq2
  rw [weightedArithmeticDerivative_two_pow
    (mersenneIntersectionWeight m q) m hm]
  simp [mersenneIntersectionWeight, singlePrimeWeight,
    h2q, weightedPrimeCoefficient, mersenneTwoCoefficient]
  ring

/-- Both factors in the realized common derivative value are positive. -/
theorem mersenneIntersection_product_pos
    {m q : ℕ} (hm : m ≠ 0)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ m - 1) :
    0 < weightedPrimeCoefficient (2 ^ m - 1) q *
      mersenneTwoCoefficient m := by
  have hnpos : 0 < 2 ^ m - 1 :=
    Nat.sub_pos_of_lt (Nat.one_lt_pow hm (by norm_num))
  have hn0 : 2 ^ m - 1 ≠ 0 := hnpos.ne'
  have hqle : q ≤ 2 ^ m - 1 := Nat.le_of_dvd hnpos hqdvd
  have hdivpos : 0 < (2 ^ m - 1) / q :=
    Nat.div_pos hqle hq.pos
  have hfacpos : 0 < (2 ^ m - 1).factorization q :=
    (hq.dvd_iff_one_le_factorization hn0).1 hqdvd
  have hmpos : 0 < m := Nat.pos_of_ne_zero hm
  have htwopos : 0 < 2 ^ (m - 1) := by positivity
  exact Nat.mul_pos
    (Nat.mul_pos hdivpos hfacpos)
    (Nat.mul_pos hmpos htwopos)

/-- For every chosen prime divisor of `2^m-1`, the explicit weight is genuinely
compatible and nondegenerate. -/
theorem mersenneIntersectionWeight_compatible_nondegenerate
    {m q : ℕ} (hm : m ≠ 0)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ m - 1) :
    weightedArithmeticDerivative (mersenneIntersectionWeight m q)
        (2 ^ m - 1) =
      weightedArithmeticDerivative (mersenneIntersectionWeight m q)
        (2 ^ m) ∧
    weightedArithmeticDerivative (mersenneIntersectionWeight m q)
        (2 ^ m - 1) ≠ 0 := by
  have hleft :=
    weightedArithmeticDerivative_mersenneIntersection_left hm hq hqdvd
  have hright :=
    weightedArithmeticDerivative_mersenneIntersection_right hm hq hqdvd
  constructor
  · rw [hleft, hright]
  · rw [hleft]
    exact_mod_cast
      (mersenneIntersection_product_pos hm hq hqdvd).ne'

/-- Every exponent `m >= 2` admits an actual compatible nondegenerate
prime-weight system, and its normalized derivative cost is larger than `m/2`. -/
theorem exists_mersenne_actualWeight_normalized_gt_half
    (m : ℕ) (hm : 2 ≤ m) :
    ∃ x : ℕ → ℤ,
      weightedArithmeticDerivative x (2 ^ m - 1) =
        weightedArithmeticDerivative x (2 ^ m) ∧
      weightedArithmeticDerivative x (2 ^ m - 1) ≠ 0 ∧
      (m : ℝ) / 2 <
        ((weightedArithmeticDerivative x (2 ^ m - 1)).natAbs : ℝ) /
          (2 ^ m - 1 : ℕ) := by
  have hm0 : m ≠ 0 := by omega
  have hpowle : 2 ^ 2 ≤ 2 ^ m :=
    (pow_le_pow_iff_right₀ (by norm_num : 1 < (2 : ℕ))).2 hm
  have hn1 : 2 ^ m - 1 ≠ 1 := by
    norm_num at hpowle ⊢
    omega
  obtain ⟨q, hq, hqdvd⟩ := Nat.exists_prime_and_dvd hn1
  let x := mersenneIntersectionWeight m q
  have hreal :=
    mersenneIntersectionWeight_compatible_nondegenerate hm0 hq hqdvd
  refine ⟨x, hreal.1, hreal.2, ?_⟩
  exact mersenneCompatibleNormalizedDerivative_gt_half
    x m hm0 hreal.1 hreal.2

/-- The normalized costs of actual compatible nondegenerate Mersenne weights
are unbounded. -/
theorem mersenne_actualWeight_normalized_unbounded
    (K : ℝ) :
    ∃ m : ℕ, ∃ x : ℕ → ℤ,
      2 ≤ m ∧
      weightedArithmeticDerivative x (2 ^ m - 1) =
        weightedArithmeticDerivative x (2 ^ m) ∧
      weightedArithmeticDerivative x (2 ^ m - 1) ≠ 0 ∧
      K <
        ((weightedArithmeticDerivative x (2 ^ m - 1)).natAbs : ℝ) /
          (2 ^ m - 1 : ℕ) := by
  obtain ⟨m, hmK⟩ := exists_nat_gt (max 2 (2 * K))
  have hmTwoReal : (2 : ℝ) < m :=
    (le_max_left 2 (2 * K)).trans_lt hmK
  have hm : 2 ≤ m := by exact_mod_cast hmTwoReal.le
  have hKhalf : K < (m : ℝ) / 2 := by
    have htwoK : 2 * K < (m : ℝ) :=
      (le_max_right 2 (2 * K)).trans_lt hmK
    linarith
  obtain ⟨x, hcompat, hnonzero, hlower⟩ :=
    exists_mersenne_actualWeight_normalized_gt_half m hm
  exact ⟨m, x, hm, hcompat, hnonzero, hKhalf.trans hlower⟩

/-- Hence there is no uniform real constant bounding every actual compatible
nondegenerate Mersenne weight system. -/
theorem no_uniform_constant_mersenne_actualWeights :
    ¬ ∃ K : ℝ, ∀ m : ℕ, 2 ≤ m → ∀ x : ℕ → ℤ,
      weightedArithmeticDerivative x (2 ^ m - 1) =
          weightedArithmeticDerivative x (2 ^ m) →
      weightedArithmeticDerivative x (2 ^ m - 1) ≠ 0 →
      ((weightedArithmeticDerivative x (2 ^ m - 1)).natAbs : ℝ) /
          (2 ^ m - 1 : ℕ) ≤ K := by
  rintro ⟨K, hK⟩
  obtain ⟨m, x, hm, hcompat, hnonzero, hgt⟩ :=
    mersenne_actualWeight_normalized_unbounded K
  exact (not_le_of_gt hgt) (hK m hm x hcompat hnonzero)

end IUTThreeClosures
