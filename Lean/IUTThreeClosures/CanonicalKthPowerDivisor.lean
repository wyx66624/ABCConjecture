/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic

/-!
# Canonical `k`-th-power divisors

For `k>0` and

`n = prod p^e_p`,

define

`q_k(n) = prod p^(floor(e_p/k))`.

Then

* `q_k(n)^k | n`;
* `n | rad(n)^(k-1) * q_k(n)^k`;
* `log n - (k-1)log rad(n) <= k log q_k(n)`.

The square-divisor theorem is the case `k=2`; the quartic selector needed in
the remaining abc reduction is `k=4`.  No abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace CanonicalKthPowerDivisor

open UniqueFactorizationMonoid

noncomputable section

/-- Prime-exponent profile of the canonical `k`-th root. -/
def kthRootFactorization (k n : ℕ) : ℕ →₀ ℕ :=
  n.factorization.mapRange (fun e => e / k) (by simp)

/-- Canonical `k`-th root. -/
def canonicalKthRoot (k n : ℕ) : ℕ :=
  (kthRootFactorization k n).prod (fun p e => p ^ e)

/-- The canonical quotient profile lies below the original profile. -/
theorem kthRootFactorization_le_factorization (k n : ℕ) :
    kthRootFactorization k n ≤ n.factorization := by
  intro p
  simp [kthRootFactorization]
  exact Nat.div_le_self _ _

/-- Exact factorization of the canonical root. -/
theorem factorization_canonicalKthRoot (k n : ℕ) :
    (canonicalKthRoot k n).factorization = kthRootFactorization k n := by
  unfold canonicalKthRoot
  exact Nat.factorization_prod_pow_eq_self_of_le_factorization
    (kthRootFactorization_le_factorization k n)

/-- The canonical root is nonzero. -/
theorem canonicalKthRoot_ne_zero (k n : ℕ) :
    canonicalKthRoot k n ≠ 0 := by
  unfold canonicalKthRoot
  apply (kthRootFactorization k n).prod_ne_zero_iff.mpr
  intro p hp
  have hsupport : p ∈ n.factorization.support :=
    Finsupp.support_mono
      (kthRootFactorization_le_factorization k n) hp
  have hpprime : p.Prime := by
    apply Nat.prime_of_mem_primeFactors
    simpa using hsupport
  exact pow_ne_zero _ hpprime.ne_zero

@[simp]
theorem canonicalKthRoot_pos (k n : ℕ) :
    0 < canonicalKthRoot k n :=
  Nat.pos_of_ne_zero (canonicalKthRoot_ne_zero k n)

/-- The canonical `k`-th power divides the original integer. -/
theorem canonicalKthRoot_pow_dvd
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    canonicalKthRoot k n ^ k ∣ n := by
  apply (Nat.factorization_le_iff_dvd
    (pow_ne_zero k (canonicalKthRoot_ne_zero k n)) hn).2
  intro p
  rw [Nat.factorization_pow,
    factorization_canonicalKthRoot]
  simp [kthRootFactorization]
  exact Nat.mul_div_le _ _

/-- Every positive exponent is bounded by `k-1` plus the selected multiple of
`k`. -/
theorem exponent_le_radical_layers_add_k_mul_div
    {k e : ℕ} (hk : 0 < k) (he : 0 < e) :
    e ≤ (k - 1) + k * (e / k) := by
  omega

/-- The radical layers and the canonical `k`-th power form a multiple of `n`. -/
theorem self_dvd_radical_pow_mul_canonicalKthRoot_pow
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    n ∣ radical n ^ (k - 1) * canonicalKthRoot k n ^ k := by
  have hrad_ne : radical n ^ (k - 1) ≠ 0 :=
    pow_ne_zero _ (Nat.radical_pos n).ne'
  have hroot_ne : canonicalKthRoot k n ^ k ≠ 0 :=
    pow_ne_zero _ (canonicalKthRoot_ne_zero k n)
  have htarget_ne :
      radical n ^ (k - 1) * canonicalKthRoot k n ^ k ≠ 0 :=
    mul_ne_zero hrad_ne hroot_ne
  apply (Nat.factorization_le_iff_dvd hn htarget_ne).2
  intro p
  rw [Nat.factorization_mul hrad_ne hroot_ne,
    Nat.factorization_pow,
    Nat.factorization_pow,
    factorization_canonicalKthRoot]
  simp only [Finsupp.add_apply, Finsupp.smul_apply, smul_eq_mul]
  by_cases hp : p.Prime
  · by_cases hpn : p ∣ n
    · have hprad : p ∣ radical n :=
        (dvd_radical_iff_of_irreducible hp hn).2 hpn
      have hfacrad : (radical n).factorization p = 1 :=
        Nat.factorization_eq_one_of_squarefree
          (squarefree_radical (a := n)) hp hprad
      have hepos : 0 < n.factorization p :=
        hp.factorization_pos_of_dvd hn hpn
      rw [hfacrad]
      simp [kthRootFactorization]
      exact exponent_le_radical_layers_add_k_mul_div hk hepos
    · have hfac : n.factorization p = 0 :=
        Nat.factorization_eq_zero_of_not_dvd hpn
      rw [hfac]
      simp [kthRootFactorization]
  · have hfac : n.factorization p = 0 :=
      Nat.factorization_eq_zero_of_not_prime n hp
    rw [hfac]
    simp [kthRootFactorization]

/-- Numerical `k`-th-power divisor inequality. -/
theorem self_le_radical_pow_mul_canonicalKthRoot_pow
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    n ≤ radical n ^ (k - 1) * canonicalKthRoot k n ^ k :=
  Nat.le_of_dvd
    (mul_pos
      (pow_pos (Nat.radical_pos n) (k - 1))
      (pow_pos (canonicalKthRoot_pos k n) k))
    (self_dvd_radical_pow_mul_canonicalKthRoot_pow hk hn)

/-- Logarithmic `k`-th-root capture inequality. -/
theorem log_sub_radical_layers_le_k_mul_log_canonicalKthRoot
    {k n : ℕ} (hk : 0 < k) (hn : 0 < n) :
    Real.log (n : ℝ) - (k - 1 : ℕ) * Real.log (radical n : ℝ) ≤
      (k : ℝ) * Real.log (canonicalKthRoot k n : ℝ) := by
  have hnreal : 0 < (n : ℝ) := by exact_mod_cast hn
  have hradreal : 0 < (radical n : ℝ) := by
    exact_mod_cast Nat.radical_pos n
  have hrootreal : 0 < (canonicalKthRoot k n : ℝ) := by
    exact_mod_cast canonicalKthRoot_pos k n
  have hreal :
      (n : ℝ) ≤
        (radical n : ℝ) ^ (k - 1) *
          (canonicalKthRoot k n : ℝ) ^ k := by
    exact_mod_cast
      self_le_radical_pow_mul_canonicalKthRoot_pow hk hn.ne'
  have hlog := Real.log_le_log hnreal hreal
  rw [Real.log_mul
      (pow_pos hradreal (k - 1)).ne'
      (pow_pos hrootreal k).ne',
    Real.log_pow, Real.log_pow] at hlog
  norm_num at hlog ⊢
  linarith

/-- Repository-radical version. -/
theorem log_sub_abcRadical_layers_le_k_mul_log_canonicalKthRoot
    {k n : ℕ} (hk : 0 < k) (hn : 0 < n) :
    Real.log (n : ℝ) - (k - 1 : ℕ) * Real.log (abcRadical n : ℝ) ≤
      (k : ℝ) * Real.log (canonicalKthRoot k n : ℝ) := by
  rw [abcRadical_eq_natRadical]
  exact log_sub_radical_layers_le_k_mul_log_canonicalKthRoot hk hn

/-- Quartic specialization. -/
theorem log_le_three_log_abcRadical_add_four_log_canonicalFourthRoot
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) ≤
      3 * Real.log (abcRadical n : ℝ) +
        4 * Real.log (canonicalKthRoot 4 n : ℝ) := by
  have h := log_sub_abcRadical_layers_le_k_mul_log_canonicalKthRoot
    (k := 4) (by norm_num) hn
  norm_num at h ⊢
  linarith

#print axioms factorization_canonicalKthRoot
#print axioms canonicalKthRoot_pow_dvd
#print axioms self_dvd_radical_pow_mul_canonicalKthRoot_pow
#print axioms log_sub_abcRadical_layers_le_k_mul_log_canonicalKthRoot
#print axioms log_le_three_log_abcRadical_add_four_log_canonicalFourthRoot

end
end CanonicalKthPowerDivisor
end IUTThreeClosures
