/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Elementary logarithmic estimates from GenEll Lemma 4.2

Let `p_j` be primes and let `h_j` be positive natural numbers.  Put

`H = sum_j h_j * log p_j`.

GenEll Lemma 4.2 uses

`sum_j log p_j <= H`

and

`sum_j log (h_j + 1) <= 3 H / 2`.

In fact the second estimate admits the stronger bound

`sum_j log (h_j + 1) <= H`.

Indeed `h+1 <= 2^h` for every positive integer `h`, hence

`log(h+1) <= h log 2 <= h log p`

for every prime `p`.  This module formalizes the termwise argument and its
finite-sum consequences.  These are the elementary logarithmic-mass estimates
used to control the actual exceptional prime set in GenEll Corollaries 4.3 and
4.4.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The elementary inequality `n+1 <= 2^n` for every positive natural number. -/
theorem succ_le_two_pow
    {n : ℕ} (hn : 0 < n) :
    n + 1 ≤ 2 ^ n := by
  induction n using Nat.case_strong_induction_on with
  | hz => omega
  | hi n ih =>
      by_cases hn0 : n = 0
      · subst n
        norm_num
      · have hnpos : 0 < n := Nat.pos_of_ne_zero hn0
        have hih : n + 1 ≤ 2 ^ n := ih n (Nat.lt_succ_self n) hnpos
        have hone : 1 ≤ 2 ^ n := by positivity
        rw [pow_succ]
        omega

/-- One positive integer multiplicity contributes at least the logarithm of
its successor once it is paired with any prime. -/
theorem log_succ_le_mul_log_prime
    {p h : ℕ}
    (hp : p.Prime)
    (hh : 0 < h) :
    Real.log (h + 1) ≤ (h : ℝ) * Real.log p := by
  have hpowNat : h + 1 ≤ 2 ^ h := succ_le_two_pow hh
  have hsuccPos : (0 : ℝ) < h + 1 := by positivity
  have hpowPos : (0 : ℝ) < 2 ^ h := by positivity
  have hcast : ((h + 1 : ℕ) : ℝ) ≤ ((2 ^ h : ℕ) : ℝ) := by
    exact_mod_cast hpowNat
  have hlogPow :
      Real.log (h + 1) ≤ Real.log ((2 : ℝ) ^ h) :=
    Real.strictMonoOn_log.monotoneOn hsuccPos hpowPos hcast
  have htwoLe : (2 : ℝ) ≤ p := by
    exact_mod_cast hp.two_le
  have hlogTwo : Real.log (2 : ℝ) ≤ Real.log p :=
    Real.strictMonoOn_log.monotoneOn
      (by norm_num) (by exact_mod_cast hp.pos) htwoLe
  calc
    Real.log (h + 1) ≤ Real.log ((2 : ℝ) ^ h) := hlogPow
    _ = (h : ℝ) * Real.log 2 := by
      rw [Real.log_pow]
      norm_num
    _ ≤ (h : ℝ) * Real.log p :=
      mul_le_mul_of_nonneg_left hlogTwo (by positivity)

/-- The prime logarithm itself is bounded by its positive multiplicity-weighted
contribution. -/
theorem log_prime_le_mul_log_prime
    {p h : ℕ}
    (hp : p.Prime)
    (hh : 0 < h) :
    Real.log p ≤ (h : ℝ) * Real.log p := by
  have hlog : 0 ≤ Real.log p :=
    Real.log_nonneg (by exact_mod_cast hp.one_le)
  have hhreal : (1 : ℝ) ≤ h := by exact_mod_cast hh
  nlinarith

section FiniteFamily

variable {ι : Type*} [Fintype ι]
variable (p h : ι → ℕ)

/-- The weighted logarithmic height used in GenEll Lemma 4.2. -/
noncomputable def genEllWeightedPrimeHeight : ℝ :=
  ∑ i, (h i : ℝ) * Real.log (p i)

/-- The weighted prime height is nonnegative. -/
theorem genEllWeightedPrimeHeight_nonneg
    (hp : ∀ i, (p i).Prime) :
    0 ≤ genEllWeightedPrimeHeight p h := by
  unfold genEllWeightedPrimeHeight
  exact Finset.sum_nonneg fun i _ =>
    mul_nonneg (by positivity)
      (Real.log_nonneg (by exact_mod_cast (hp i).one_le))

/-- First estimate of GenEll Lemma 4.2. -/
theorem sum_log_prime_le_weightedHeight
    (hp : ∀ i, (p i).Prime)
    (hh : ∀ i, 0 < h i) :
    (∑ i, Real.log (p i)) ≤
      genEllWeightedPrimeHeight p h := by
  unfold genEllWeightedPrimeHeight
  exact Finset.sum_le_sum fun i _ =>
    log_prime_le_mul_log_prime (hp i) (hh i)

/-- Stronger form of the second estimate: the successor-logarithm sum is
already bounded by the weighted prime height with coefficient one. -/
theorem sum_log_succ_le_weightedHeight
    (hp : ∀ i, (p i).Prime)
    (hh : ∀ i, 0 < h i) :
    (∑ i, Real.log (h i + 1)) ≤
      genEllWeightedPrimeHeight p h := by
  unfold genEllWeightedPrimeHeight
  exact Finset.sum_le_sum fun i _ =>
    log_succ_le_mul_log_prime (hp i) (hh i)

/-- The printed `3/2` estimate follows immediately from the stronger
coefficient-one estimate. -/
theorem sum_log_succ_le_three_halves_weightedHeight
    (hp : ∀ i, (p i).Prime)
    (hh : ∀ i, 0 < h i) :
    (∑ i, Real.log (h i + 1)) ≤
      (3 / 2 : ℝ) * genEllWeightedPrimeHeight p h := by
  have hstrong := sum_log_succ_le_weightedHeight p h hp hh
  have hnonneg := genEllWeightedPrimeHeight_nonneg p h hp
  nlinarith

/-- Monotonicity also gives the lower comparison appearing in the printed
lemma. -/
theorem sum_log_le_sum_log_succ
    (hh : ∀ i, 0 < h i) :
    (∑ i, Real.log (h i)) ≤
      ∑ i, Real.log (h i + 1) := by
  exact Finset.sum_le_sum fun i _ => by
    have hhi : (0 : ℝ) < h i := by exact_mod_cast hh i
    have hs : (h i : ℝ) ≤ h i + 1 := by positivity
    exact Real.strictMonoOn_log.monotoneOn hhi (by positivity) hs

end FiniteFamily

end IUTThreeClosures
