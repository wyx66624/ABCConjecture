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
# Canonical square divisors and logarithmic multiplicity excess

For a positive integer `n`, define the canonical square-root factorization by
replacing every prime exponent `e` with `floor(e/2)`.  Its product is an actual
integer `q(n)` satisfying

* `q(n)^2 | n`;
* `n | rad(n) * q(n)^2`;
* `log n - log rad(n) <= 2 log q(n)`.

Thus every height-scale logarithmic multiplicity excess produces a genuine
height-scale square divisor.  No abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace CanonicalSquareDivisor

open UniqueFactorizationMonoid

noncomputable section

/-- Prime-exponent profile of the canonical square root. -/
def squareRootFactorization (n : ℕ) : ℕ →₀ ℕ :=
  n.factorization.mapRange (fun e => e / 2) (by simp)

/-- The canonical square root obtained from the factorization profile. -/
def canonicalSquareRoot (n : ℕ) : ℕ :=
  (squareRootFactorization n).prod (fun p e => p ^ e)

/-- The square-root exponent profile is pointwise below the original profile. -/
theorem squareRootFactorization_le_factorization (n : ℕ) :
    squareRootFactorization n ≤ n.factorization := by
  intro p
  simp [squareRootFactorization]
  exact Nat.div_le_self _ _

/-- The canonical square root has exactly the prescribed factorization. -/
theorem factorization_canonicalSquareRoot (n : ℕ) :
    (canonicalSquareRoot n).factorization = squareRootFactorization n := by
  unfold canonicalSquareRoot
  exact Nat.factorization_prod_pow_eq_self_of_le_factorization
    (squareRootFactorization_le_factorization n)

/-- The canonical square root is nonzero. -/
theorem canonicalSquareRoot_ne_zero (n : ℕ) :
    canonicalSquareRoot n ≠ 0 := by
  unfold canonicalSquareRoot
  apply (squareRootFactorization n).prod_ne_zero_iff.mpr
  intro p hp
  have hsupport : p ∈ n.factorization.support :=
    Finsupp.support_mono
      (squareRootFactorization_le_factorization n) hp
  have hpprime : p.Prime := by
    apply Nat.prime_of_mem_primeFactors
    simpa using hsupport
  exact pow_ne_zero _ hpprime.ne_zero

@[simp]
theorem canonicalSquareRoot_pos (n : ℕ) :
    0 < canonicalSquareRoot n :=
  Nat.pos_of_ne_zero (canonicalSquareRoot_ne_zero n)

/-- The square of the canonical root divides the original integer. -/
theorem canonicalSquareRoot_sq_dvd
    {n : ℕ} (hn : n ≠ 0) :
    canonicalSquareRoot n ^ 2 ∣ n := by
  apply (Nat.factorization_le_iff_dvd
    (pow_ne_zero 2 (canonicalSquareRoot_ne_zero n)) hn).2
  intro p
  rw [Nat.factorization_pow,
    factorization_canonicalSquareRoot]
  simp [squareRootFactorization]
  omega

/-- The radical times the canonical square divisor is a multiple of `n`. -/
theorem self_dvd_radical_mul_canonicalSquareRoot_sq
    {n : ℕ} (hn : n ≠ 0) :
    n ∣ radical n * canonicalSquareRoot n ^ 2 := by
  have hrad_ne : radical n ≠ 0 :=
    (Nat.radical_pos n).ne'
  have hroot_sq_ne : canonicalSquareRoot n ^ 2 ≠ 0 :=
    pow_ne_zero 2 (canonicalSquareRoot_ne_zero n)
  have htarget_ne :
      radical n * canonicalSquareRoot n ^ 2 ≠ 0 :=
    mul_ne_zero hrad_ne hroot_sq_ne
  apply (Nat.factorization_le_iff_dvd hn htarget_ne).2
  intro p
  rw [Nat.factorization_mul hrad_ne hroot_sq_ne,
    Nat.factorization_pow,
    factorization_canonicalSquareRoot]
  simp only [Finsupp.add_apply, Finsupp.smul_apply, smul_eq_mul]
  by_cases hp : p.Prime
  · by_cases hpn : p ∣ n
    · have hprad : p ∣ radical n :=
        (dvd_radical_iff_of_irreducible hp hn).2 hpn
      have hfacrad : (radical n).factorization p = 1 :=
        Nat.factorization_eq_one_of_squarefree
          (squarefree_radical (a := n)) hp hprad
      rw [hfacrad]
      simp [squareRootFactorization]
      omega
    · have hfac : n.factorization p = 0 :=
        Nat.factorization_eq_zero_of_not_dvd hpn
      rw [hfac]
      simp [squareRootFactorization]
  · have hfac : n.factorization p = 0 :=
      Nat.factorization_eq_zero_of_not_prime n hp
    rw [hfac]
    simp [squareRootFactorization]

/-- Numerical form of the canonical square-divisor inequality. -/
theorem self_le_radical_mul_canonicalSquareRoot_sq
    {n : ℕ} (hn : n ≠ 0) :
    n ≤ radical n * canonicalSquareRoot n ^ 2 :=
  Nat.le_of_dvd
    (mul_pos (Nat.radical_pos n) (pow_pos (canonicalSquareRoot_pos n) 2))
    (self_dvd_radical_mul_canonicalSquareRoot_sq hn)

/-- Logarithmic multiplicity excess is captured by twice the logarithmic size
of the canonical square root. -/
theorem log_sub_log_radical_le_two_log_canonicalSquareRoot
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) - Real.log (radical n : ℝ) ≤
      2 * Real.log (canonicalSquareRoot n : ℝ) := by
  have hnreal : 0 < (n : ℝ) := by exact_mod_cast hn
  have hradreal : 0 < (radical n : ℝ) := by
    exact_mod_cast Nat.radical_pos n
  have hrootreal : 0 < (canonicalSquareRoot n : ℝ) := by
    exact_mod_cast canonicalSquareRoot_pos n
  have hreal :
      (n : ℝ) ≤
        (radical n : ℝ) * (canonicalSquareRoot n : ℝ) ^ 2 := by
    exact_mod_cast
      self_le_radical_mul_canonicalSquareRoot_sq hn.ne'
  have hlog := Real.log_le_log hnreal hreal
  rw [Real.log_mul hradreal.ne'
      (pow_pos hrootreal 2).ne',
    Real.log_pow] at hlog
  linarith

/-- Repository-radical version of the logarithmic square-part bound. -/
theorem log_sub_log_abcRadical_le_two_log_canonicalSquareRoot
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) - Real.log (abcRadical n : ℝ) ≤
      2 * Real.log (canonicalSquareRoot n : ℝ) := by
  rw [abcRadical_eq_natRadical]
  exact log_sub_log_radical_le_two_log_canonicalSquareRoot hn

#print axioms squareRootFactorization_le_factorization
#print axioms factorization_canonicalSquareRoot
#print axioms canonicalSquareRoot_sq_dvd
#print axioms self_dvd_radical_mul_canonicalSquareRoot_sq
#print axioms log_sub_log_abcRadical_le_two_log_canonicalSquareRoot

end
end CanonicalSquareDivisor
end IUTThreeClosures
