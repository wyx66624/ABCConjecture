/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCTwoPrimeSupport20260831
import IUTThreeClosures.MersenneWeightedWieferichMass
import Mathlib.Data.Nat.Totient
import Mathlib.NumberTheory.PrimesCongruentOne

/-!
# Radical bounds at prime-index Mersenne layers

The paper proof is in
`research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`.

For an odd prime `ell`, every prime factor of `2^ell - 1` has exact
multiplicative order `ell` and is `1` modulo `2 * ell`.  If the Mersenne
number is composite, it cannot be a prime power; hence it has two distinct
prime factors.  These facts give the unconditional bound

`(2 * ell + 1)^2 * mersennePowerLoss ell <= 2^ell - 1`.

The asymmetric version accepts any independent lower bound for the largest
prime factor.  The final exact computations certify that `2^37 - 1` has
exactly two prime factors, so a proposed universal three-factor upgrade is
false even at the requested threshold `ell >= 37`.  No asymptotic claim and
no abc statement is assumed.  The total-mass bridge near the end keeps both
the base/lifting decomposition and the lifting bound as explicit hypotheses;
it does not assert the unformalized global Mersenne product decomposition.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid
open scoped BigOperators

/-- A composite Mersenne value with exponent greater than one is not a prime
power.  The imported elementary gap lemma replaces any appeal to Catalan. -/
theorem mersenne_not_primePow_of_composite
    (ell : ℕ) (hell : 1 < ell)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1)) :
    ¬ IsPrimePow (2 ^ ell - 1) := by
  intro hpow
  obtain ⟨q, v, hq, hv, hqv⟩ := (isPrimePow_nat_iff (2 ^ ell - 1)).mp hpow
  have heq : q ^ v + 1 = 2 ^ ell := by
    calc
      q ^ v + 1 = (2 ^ ell - 1) + 1 := by rw [hqv]
      _ = 2 ^ ell := Nat.sub_add_cancel (one_le_pow₀ (by norm_num))
  have hqne : q ≠ 2 := by
    intro h
    subst q
    have hleft : (2 ^ v + 1) % 2 = 1 := by
      have hdiv : 2 ∣ 2 ^ v := dvd_pow_self 2 hv.ne'
      rw [Nat.add_mod, Nat.mod_eq_zero_of_dvd hdiv]
    have hright : 2 ^ ell % 2 = 0 :=
      Nat.mod_eq_zero_of_dvd (dvd_pow_self 2 (by omega))
    have := congrArg (fun n : ℕ => n % 2) heq
    omega
  have hvone :=
    ABCTwoPrimeSupport20260831.exponent_eq_one_of_prime_pow_add_one
      hq hqne hv heq
  have hmprime : Nat.Prime (2 ^ ell - 1) := by
    rw [hvone, pow_one] at hqv
    exact hqv ▸ hq
  exact hcomp hmprime

/-- A composite Mersenne value with exponent greater than one has at least
two distinct prime divisors. -/
theorem mersenne_composite_two_support
    (ell : ℕ) (hell : 1 < ell)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1)) :
    ∃ q r : ℕ,
      q.Prime ∧ r.Prime ∧ q ≠ r ∧
      q ∣ 2 ^ ell - 1 ∧ r ∣ 2 ^ ell - 1 := by
  have htwo : 2 ≤ 2 ^ ell - 1 := by
    have : 4 ≤ 2 ^ ell := by
      simpa using Nat.pow_le_pow_right (by norm_num : 0 < (2 : ℕ))
        hell
    omega
  have hnontrivial : (2 ^ ell - 1).primeFactors.Nontrivial :=
    (Nat.not_isPrimePow_iff_nontrivial_of_two_le htwo).mp
      (mersenne_not_primePow_of_composite ell hell hcomp)
  obtain ⟨q, hqmem, r, hrmem, hqr⟩ := hnontrivial
  exact ⟨q, r,
    Nat.prime_of_mem_primeFactors hqmem,
    Nat.prime_of_mem_primeFactors hrmem,
    hqr,
    Nat.dvd_of_mem_primeFactors hqmem,
    Nat.dvd_of_mem_primeFactors hrmem⟩

/-- Every prime factor at a prime index has exact multiplicative order equal
to that index. -/
theorem prime_index_mersenne_factor_order
    (ell q : ℕ) (hell : ell.Prime)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ ell - 1) :
    orderOf (2 : ZMod q) = ell := by
  letI : Fact ell.Prime := ⟨hell⟩
  letI : Fact q.Prime := ⟨hq⟩
  have hq2 : q ≠ 2 := by
    intro h
    subst q
    have hpmod : 2 ^ ell % 2 = 0 :=
      Nat.mod_eq_zero_of_dvd (dvd_pow_self 2 hell.pos.ne')
    have hodd : Odd (2 ^ ell - 1) := by
      rw [Nat.odd_sub (one_le_pow₀ (by norm_num))]
      simp [Nat.odd_iff, Nat.even_iff, hpmod]
    exact hodd.not_two_dvd_nat hqdvd
  have hpow : (2 : ZMod q) ^ ell = 1 := by
    have hzero : ((2 ^ ell - 1 : ℕ) : ZMod q) = 0 := by
      rw [CharP.cast_eq_zero_iff]
      exact hqdvd
    have hcastSub : ((2 ^ ell - 1 : ℕ) : ZMod q) =
        (2 : ZMod q) ^ ell - 1 := by
      rw [Nat.cast_sub (one_le_pow₀ (by norm_num))]
      simp
    rw [hcastSub] at hzero
    exact sub_eq_zero.mp hzero
  have hne : (2 : ZMod q) ≠ 1 := by
    intro heq
    have h := sub_eq_zero.mpr heq
    norm_num at h
  exact orderOf_eq_prime hpow hne

/-- At an odd prime index, every prime factor is one modulo twice the index. -/
theorem prime_index_mersenne_factor_two_mul_dvd
    (ell q : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ ell - 1) :
    2 * ell ∣ q - 1 := by
  letI : Fact q.Prime := ⟨hq⟩
  have hq2 : q ≠ 2 := by
    intro h
    subst q
    have hpmod : 2 ^ ell % 2 = 0 :=
      Nat.mod_eq_zero_of_dvd (dvd_pow_self 2 hell.pos.ne')
    have hodd : Odd (2 ^ ell - 1) := by
      rw [Nat.odd_sub (one_le_pow₀ (by norm_num))]
      simp [Nat.odd_iff, Nat.even_iff, hpmod]
    exact hodd.not_two_dvd_nat hqdvd
  have hord : orderOf (2 : ZMod q) = ell :=
    prime_index_mersenne_factor_order ell q hell hq hqdvd
  have hellDvd : ell ∣ q - 1 := by
    rw [← hord]
    exact ZMod.orderOf_dvd_card_sub_one (by
      intro hzero
      have hqdiv2 : q ∣ 2 :=
        (CharP.cast_eq_zero_iff (ZMod q) q 2).mp hzero
      exact hq2 ((Nat.prime_dvd_prime_iff_eq hq Nat.prime_two).mp hqdiv2))
  have htwoDvd : 2 ∣ q - 1 := by
    obtain ⟨k, hk⟩ := hq.odd_of_ne_two hq2
    exact ⟨k, by omega⟩
  have hcop : Nat.Coprime 2 ell := by
    exact (Nat.coprime_primes Nat.prime_two hell).mpr hell2.symm
  exact hcop.mul_dvd_of_dvd_of_dvd htwoDvd hellDvd

/-- Numerical form of the prime-factor congruence. -/
theorem prime_index_mersenne_factor_lower
    (ell q : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hq : q.Prime) (hqdvd : q ∣ 2 ^ ell - 1) :
    2 * ell + 1 ≤ q := by
  have hdiv := prime_index_mersenne_factor_two_mul_dvd
    ell q hell hell2 hq hqdvd
  have hpos : 0 < q - 1 := by
    have := hq.two_le
    omega
  have := Nat.le_of_dvd hpos hdiv
  omega

/-- Two distinct prime divisors give a square lower bound for the radical. -/
theorem two_distinct_prime_factors_radical_lower
    {N q r L : ℕ} (hN : N ≠ 0)
    (hq : q.Prime) (hr : r.Prime) (hqr : q ≠ r)
    (hqdvd : q ∣ N) (hrdvd : r ∣ N)
    (hqL : L ≤ q) (hrL : L ≤ r) :
    L ^ 2 ≤ abcRadical N := by
  have hqrad : q ∣ abcRadical N := by
    rw [abcRadical_eq_natRadical,
      dvd_radical_iff_of_irreducible hq.prime.irreducible hN]
    exact hqdvd
  have hrrad : r ∣ abcRadical N := by
    rw [abcRadical_eq_natRadical,
      dvd_radical_iff_of_irreducible hr.prime.irreducible hN]
    exact hrdvd
  have hmul : q * r ∣ abcRadical N :=
    ((Nat.coprime_primes hq hr).mpr hqr).mul_dvd_of_dvd_of_dvd hqrad hrrad
  calc
    L ^ 2 = L * L := by ring
    _ ≤ q * r := Nat.mul_le_mul hqL hrL
    _ ≤ abcRadical N := Nat.le_of_dvd (abcRadical_pos N) hmul

/-- The unconditional square radical bound at a composite odd-prime layer. -/
theorem composite_prime_index_mersenne_radical_lower
    (ell : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1)) :
    (2 * ell + 1) ^ 2 ≤ abcRadical (2 ^ ell - 1) := by
  obtain ⟨q, r, hq, hr, hqr, hqdvd, hrdvd⟩ :=
    mersenne_composite_two_support ell hell.one_lt hcomp
  apply two_distinct_prime_factors_radical_lower
    (N := 2 ^ ell - 1) (q := q) (r := r)
  · have : 1 < 2 ^ ell := one_lt_pow₀ (by norm_num) hell.pos.ne'
    omega
  · exact hq
  · exact hr
  · exact hqr
  · exact hqdvd
  · exact hrdvd
  · exact prime_index_mersenne_factor_lower ell q hell hell2 hq hqdvd
  · exact prime_index_mersenne_factor_lower ell r hell hell2 hr hrdvd

/-- An asymmetric radical bound used when one factor has a stronger external
lower bound. -/
theorem two_distinct_prime_factors_radical_asymmetric
    {N q r P L : ℕ} (hN : N ≠ 0)
    (hq : q.Prime) (hr : r.Prime) (hqr : q ≠ r)
    (hqdvd : q ∣ N) (hrdvd : r ∣ N)
    (hqP : P ≤ q) (hrL : L ≤ r) :
    P * L ≤ abcRadical N := by
  have hqrad : q ∣ abcRadical N := by
    rw [abcRadical_eq_natRadical,
      dvd_radical_iff_of_irreducible hq.prime.irreducible hN]
    exact hqdvd
  have hrrad : r ∣ abcRadical N := by
    rw [abcRadical_eq_natRadical,
      dvd_radical_iff_of_irreducible hr.prime.irreducible hN]
    exact hrdvd
  have hmul : q * r ∣ abcRadical N :=
    ((Nat.coprime_primes hq hr).mpr hqr).mul_dvd_of_dvd_of_dvd hqrad hrrad
  exact (Nat.mul_le_mul hqP hrL).trans
    (Nat.le_of_dvd (abcRadical_pos N) hmul)

/-- A supplied prime factor of size at least `P`, together with one other
factor, gives `P * (2*ell+1)` inside the radical. -/
theorem composite_prime_index_radical_of_large_factor
    (ell P : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1))
    (hlarge : ∃ q : ℕ, q.Prime ∧ q ∣ 2 ^ ell - 1 ∧ P ≤ q) :
    P * (2 * ell + 1) ≤ abcRadical (2 ^ ell - 1) := by
  obtain ⟨q, hq, hqdvd, hqP⟩ := hlarge
  have htwo : 2 ≤ 2 ^ ell - 1 := by
    have : 4 ≤ 2 ^ ell := by
      simpa using Nat.pow_le_pow_right (by norm_num : 0 < (2 : ℕ))
        hell.two_le
    omega
  have hnontrivial : (2 ^ ell - 1).primeFactors.Nontrivial :=
    (Nat.not_isPrimePow_iff_nontrivial_of_two_le htwo).mp
      (mersenne_not_primePow_of_composite ell hell.one_lt hcomp)
  obtain ⟨r, hrmem, hrq⟩ := hnontrivial.exists_ne q
  have hr := Nat.prime_of_mem_primeFactors hrmem
  have hrdvd := Nat.dvd_of_mem_primeFactors hrmem
  apply two_distinct_prime_factors_radical_asymmetric
    (N := 2 ^ ell - 1) (q := q) (r := r)
  · have : 1 < 2 ^ ell := one_lt_pow₀ (by norm_num) hell.pos.ne'
    omega
  · exact hq
  · exact hr
  · exact hrq.symm
  · exact hqdvd
  · exact hrdvd
  · exact hqP
  · exact prime_index_mersenne_factor_lower ell r hell hell2 hr hrdvd

/-- The square radical bound as an upper bound for exact Mersenne power loss. -/
theorem composite_prime_index_powerLoss_bound
    (ell : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1)) :
    (2 * ell + 1) ^ 2 * mersennePowerLoss ell ≤ 2 ^ ell - 1 := by
  calc
    (2 * ell + 1) ^ 2 * mersennePowerLoss ell
        ≤ abcRadical (2 ^ ell - 1) * mersennePowerLoss ell :=
      Nat.mul_le_mul_right _
        (composite_prime_index_mersenne_radical_lower
          ell hell hell2 hcomp)
    _ = 2 ^ ell - 1 := mersenneRadical_mul_powerLoss ell

/-- The asymmetric radical bound as an upper bound for exact Mersenne power
loss. -/
theorem composite_prime_index_powerLoss_of_large_factor
    (ell P : ℕ) (hell : ell.Prime) (hell2 : ell ≠ 2)
    (hcomp : ¬ Nat.Prime (2 ^ ell - 1))
    (hlarge : ∃ q : ℕ, q.Prime ∧ q ∣ 2 ^ ell - 1 ∧ P ≤ q) :
    (P * (2 * ell + 1)) * mersennePowerLoss ell ≤ 2 ^ ell - 1 := by
  calc
    (P * (2 * ell + 1)) * mersennePowerLoss ell
        ≤ abcRadical (2 ^ ell - 1) * mersennePowerLoss ell :=
      Nat.mul_le_mul_right _
        (composite_prime_index_radical_of_large_factor
          ell P hell hell2 hcomp hlarge)
    _ = 2 ^ ell - 1 := mersenneRadical_mul_powerLoss ell

/-! ## Finite form of the minimal surviving order-block criterion -/

/-- If all divisor layers at least `D` cost at most `epsilon * phi(d)`, their
total cost is at most `epsilon * m`; the remaining cost is exactly the finite
small-divisor prefix.  This is the finite inequality behind the paper's
sufficient condition `log E_d = o(phi(d))`. -/
theorem orderBlockMassSum_le_smallDivisors_add_totient_tail
    (mass : ℕ → ℝ) (m D : ℕ) (epsilon : ℝ)
    (hepsilon : 0 ≤ epsilon)
    (htail : ∀ d ∈ m.divisors, D ≤ d →
      mass d ≤ epsilon * (Nat.totient d : ℝ)) :
    orderBlockMassSum mass m ≤
      (∑ d ∈ m.divisors with d < D, mass d) + epsilon * m := by
  unfold orderBlockMassSum
  rw [← Finset.sum_filter_add_sum_filter_not
    m.divisors (fun d : ℕ => d < D) mass]
  have htailBound :
      (∑ d ∈ m.divisors with ¬ d < D, mass d) ≤ epsilon * m := by
    calc
      (∑ d ∈ m.divisors with ¬ d < D, mass d)
          ≤ ∑ d ∈ m.divisors with ¬ d < D,
              epsilon * (Nat.totient d : ℝ) := by
            apply Finset.sum_le_sum
            intro d hd
            exact htail d (Finset.mem_filter.mp hd).1
              (Nat.le_of_not_gt (Finset.mem_filter.mp hd).2)
      _ = epsilon * ∑ d ∈ m.divisors with ¬ d < D,
            (Nat.totient d : ℝ) := by
          rw [Finset.mul_sum]
      _ ≤ epsilon * ∑ d ∈ m.divisors, (Nat.totient d : ℝ) := by
          apply mul_le_mul_of_nonneg_left _ hepsilon
          apply Finset.sum_le_sum_of_subset_of_nonneg
            (Finset.filter_subset (fun d : ℕ => ¬ d < D) m.divisors)
          intro d _ _
          positivity
      _ = epsilon * m := by
          congr 1
          exact_mod_cast Nat.sum_totient m
  have := add_le_add_left htailBound
    (∑ d ∈ m.divisors with d < D, mass d)
  simpa [add_comm] using this

/-- With nonnegative block masses, the small-divisor term is bounded by one
fixed prefix independent of `m`. -/
theorem orderBlockMassSum_le_prefix_add_totient_tail
    (mass : ℕ → ℝ) (m D : ℕ) (epsilon : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hepsilon : 0 ≤ epsilon)
    (htail : ∀ d ∈ m.divisors, D ≤ d →
      mass d ≤ epsilon * (Nat.totient d : ℝ)) :
    orderBlockMassSum mass m ≤
      (∑ d ∈ Finset.range D, mass d) + epsilon * m := by
  have hbase := orderBlockMassSum_le_smallDivisors_add_totient_tail
    mass m D epsilon hepsilon htail
  have hsubset :
      m.divisors.filter (fun d : ℕ => d < D) ⊆ Finset.range D := by
    intro d hd
    exact Finset.mem_range.mpr (Finset.mem_filter.mp hd).2
  have hsmall :
      (∑ d ∈ m.divisors with d < D, mass d) ≤
        ∑ d ∈ Finset.range D, mass d := by
    apply Finset.sum_le_sum_of_subset_of_nonneg hsubset
    intro d _ _
    exact hmass d
  have hadd := add_le_add_right hsmall (epsilon * m)
  exact hbase.trans (by simpa [add_comm] using hadd)

/-- An abstract finite bridge from base-block control to a total mass.  The
arithmetic decomposition and the logarithmic lifting estimate are explicit
hypotheses: this theorem does not manufacture either one from the desired
conclusion. -/
theorem totalMass_le_prefix_add_totient_tail_add_log
    (mass : ℕ → ℝ) (m D : ℕ)
    (epsilon totalMass liftingMass : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hepsilon : 0 ≤ epsilon)
    (htail : ∀ d ∈ m.divisors, D ≤ d →
      mass d ≤ epsilon * (Nat.totient d : ℝ))
    (hdecomp : totalMass = orderBlockMassSum mass m + liftingMass)
    (hlifting : liftingMass ≤ Real.log m) :
    totalMass ≤
      (∑ d ∈ Finset.range D, mass d) + epsilon * m + Real.log m := by
  rw [hdecomp]
  exact add_le_add
    (orderBlockMassSum_le_prefix_add_totient_tail
      mass m D epsilon hmass hepsilon htail)
    hlifting

/-! ## Exact counterexamples to proposed global strengthenings -/

/-- The smallest lifting-remainder audit: `2^6 - 1 = 3^2 * 7`. -/
theorem mersenne_six_factorization :
    2 ^ 6 - 1 = 3 ^ 2 * 7 := by norm_num

/-- The complete prime support of the index-six audit value. -/
theorem mersenne_six_support :
    (2 ^ 6 - 1).primeFactors = {3, 7} := by
  have hcop : Nat.Coprime (3 ^ 2) 7 := by norm_num
  rw [mersenne_six_factorization, hcop.primeFactors_mul]
  rw [Nat.primeFactors_prime_pow (by norm_num : 2 ≠ 0) Nat.prime_three]
  simp [(by norm_num : Nat.Prime 7).primeFactors]

/-- The exact radical in the index-six audit. -/
theorem mersenne_six_radical :
    abcRadical (2 ^ 6 - 1) = 21 := by
  unfold abcRadical
  rw [mersenne_six_support]
  norm_num

/-- The prime `3` first occurs at order two with base valuation one. -/
theorem mersenne_six_three_order_and_baseValuation :
    orderOf (2 : ZMod 3) = 2 ∧ padicValNat 3 (2 ^ 2 - 1) = 1 := by
  constructor
  · exact prime_index_mersenne_factor_order 2 3
      (by norm_num) (by norm_num) (by norm_num)
  · norm_num [padicValNat]

/-- The prime `7` first occurs at order three with base valuation one. -/
theorem mersenne_six_seven_order_and_baseValuation :
    orderOf (2 : ZMod 7) = 3 ∧ padicValNat 7 (2 ^ 3 - 1) = 1 := by
  constructor
  · exact prime_index_mersenne_factor_order 3 7
      (by norm_num) (by norm_num) (by norm_num)
  · norm_num [padicValNat]

/-- Nevertheless the full power loss at index six is three.  This is the
finite witness that a global order-block product cannot omit its index-lift
remainder. -/
theorem mersenne_six_powerLoss :
    mersennePowerLoss 6 = 3 := by
  unfold mersennePowerLoss abcPowerfulPart
  rw [mersenne_six_radical]
  norm_num

/-- Exact factorization of the first prime-index counterexample used below. -/
theorem mersenne_37_semiprime :
    2 ^ 37 - 1 = 223 * 616318177 := by norm_num

/-- Primality certificate for the small factor of `2^37 - 1`. -/
theorem mersenne_prime_223 : Nat.Prime 223 := by norm_num

/-- Primality certificate for the large factor of `2^37 - 1`. -/
theorem mersenne_prime_616318177 : Nat.Prime 616318177 := by norm_num

/-- The complete prime support of `2^37 - 1`. -/
theorem mersenne_37_support_exactly_two :
    (2 ^ 37 - 1).primeFactors = {223, 616318177} := by
  have hcop : Nat.Coprime 223 616318177 :=
    (Nat.coprime_primes mersenne_prime_223 mersenne_prime_616318177).mpr
      (by norm_num)
  rw [mersenne_37_semiprime, hcop.primeFactors_mul]
  simp [mersenne_prime_223.primeFactors,
    mersenne_prime_616318177.primeFactors]

/-- In particular, the support has cardinality exactly two. -/
theorem mersenne_37_support_card :
    (2 ^ 37 - 1).primeFactors.card = 2 := by
  rw [mersenne_37_support_exactly_two]
  norm_num

/-- A second exact semiprime factorization, used to audit a cubic strengthening. -/
theorem mersenne_11_semiprime :
    2 ^ 11 - 1 = 23 * 89 := by norm_num

theorem mersenne_prime_23 : Nat.Prime 23 := by norm_num

theorem mersenne_prime_89 : Nat.Prime 89 := by norm_num

theorem mersenne_11_support_exactly_two :
    (2 ^ 11 - 1).primeFactors = {23, 89} := by
  have hcop : Nat.Coprime 23 89 :=
    (Nat.coprime_primes mersenne_prime_23 mersenne_prime_89).mpr (by norm_num)
  rw [mersenne_11_semiprime, hcop.primeFactors_mul]
  simp [mersenne_prime_23.primeFactors, mersenne_prime_89.primeFactors]

theorem mersenne_11_radical :
    abcRadical (2 ^ 11 - 1) = 2047 := by
  unfold abcRadical
  rw [mersenne_11_support_exactly_two]
  norm_num

theorem mersenne_11_refutes_cubic_radical_lower :
    abcRadical (2 ^ 11 - 1) < (2 * 11 + 1) ^ 3 := by
  rw [mersenne_11_radical]
  norm_num

/-- The complete-hypothesis counterexample to the proposed statement that
every composite prime-index Mersenne number with index at least `37` has at
least three distinct prime divisors. -/
theorem not_all_composite_prime_index_mersenne_three_support :
    ¬ ∀ ell : ℕ, 37 ≤ ell → ell.Prime →
      ¬ Nat.Prime (2 ^ ell - 1) →
      3 ≤ (2 ^ ell - 1).primeFactors.card := by
  intro h
  have hcomp : ¬ Nat.Prime (2 ^ 37 - 1) := by
    norm_num [mersenne_37_semiprime]
  have hthree := h 37 (by norm_num) (by norm_num) hcomp
  rw [mersenne_37_support_card] at hthree
  omega

/-- The exact `ell = 11` witness also refutes a cubic replacement for the
proved square radical lower bound when that replacement is asserted for all
composite odd-prime layers. -/
theorem not_all_composite_prime_index_mersenne_cubic_radical :
    ¬ ∀ ell : ℕ, ell.Prime → ell ≠ 2 →
      ¬ Nat.Prime (2 ^ ell - 1) →
      (2 * ell + 1) ^ 3 ≤ abcRadical (2 ^ ell - 1) := by
  intro h
  have hcomp : ¬ Nat.Prime (2 ^ 11 - 1) := by
    norm_num [mersenne_11_semiprime]
  have hcubic := h 11 (by norm_num) (by norm_num) hcomp
  exact (Nat.not_le_of_lt mersenne_11_refutes_cubic_radical_lower) hcubic

#print axioms mersenne_not_primePow_of_composite
#print axioms mersenne_composite_two_support
#print axioms prime_index_mersenne_factor_order
#print axioms prime_index_mersenne_factor_two_mul_dvd
#print axioms prime_index_mersenne_factor_lower
#print axioms two_distinct_prime_factors_radical_lower
#print axioms composite_prime_index_mersenne_radical_lower
#print axioms two_distinct_prime_factors_radical_asymmetric
#print axioms composite_prime_index_radical_of_large_factor
#print axioms composite_prime_index_powerLoss_bound
#print axioms composite_prime_index_powerLoss_of_large_factor
#print axioms orderBlockMassSum_le_smallDivisors_add_totient_tail
#print axioms orderBlockMassSum_le_prefix_add_totient_tail
#print axioms totalMass_le_prefix_add_totient_tail_add_log
#print axioms mersenne_six_factorization
#print axioms mersenne_six_support
#print axioms mersenne_six_radical
#print axioms mersenne_six_three_order_and_baseValuation
#print axioms mersenne_six_seven_order_and_baseValuation
#print axioms mersenne_six_powerLoss
#print axioms mersenne_37_semiprime
#print axioms mersenne_prime_223
#print axioms mersenne_prime_616318177
#print axioms mersenne_37_support_exactly_two
#print axioms mersenne_37_support_card
#print axioms mersenne_11_semiprime
#print axioms mersenne_prime_23
#print axioms mersenne_prime_89
#print axioms mersenne_11_support_exactly_two
#print axioms mersenne_11_radical
#print axioms mersenne_11_refutes_cubic_radical_lower
#print axioms not_all_composite_prime_index_mersenne_three_support
#print axioms not_all_composite_prime_index_mersenne_cubic_radical

end IUTThreeClosures

