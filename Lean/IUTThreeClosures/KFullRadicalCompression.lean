/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalNeighbourTransfer
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.Data.Nat.Squarefree

/-!
# Radical compression for k-full integers

A positive integer is `k`-full when every prime in its support occurs with
multiplicity at least `k`. The deterministic content relevant to abc is

`rad(n)^k ∣ n`, hence `rad(n)^k ≤ n`

and, for `k > 0`,

`log rad(n) ≤ log n / k`.

This file proves those statements from the ordinary prime-factorization
definition. They quantify exactly how much radical saving can be obtained
from powerful/squarefull/cubefull endpoints in the low-radical-neighbour
route. No distribution theorem for k-full integers is assumed.
-/

namespace IUTThreeClosures
namespace KFullRadicalCompression

open UniqueFactorizationMonoid

/-- `n` is `k`-full: it is nonzero and every prime divisor occurs with
factorization exponent at least `k`. -/
def IsKFull (k n : ℕ) : Prop :=
  n ≠ 0 ∧ ∀ p : ℕ, p.Prime → p ∣ n → k ≤ n.factorization p

namespace IsKFull

variable {k n : ℕ}

@[simp] theorem ne_zero (h : IsKFull k n) : n ≠ 0 := h.1

/-- Equivalent prime-power divisibility formulation of k-fullness. -/
theorem iff_prime_pow_dvd (hn : n ≠ 0) :
    IsKFull k n ↔
      ∀ p : ℕ, p.Prime → p ∣ n → p ^ k ∣ n := by
  constructor
  · intro h p hp hpn
    exact (hp.pow_dvd_iff_le_factorization hn).2 (h.2 p hp hpn)
  · intro h
    refine ⟨hn, ?_⟩
    intro p hp hpn
    exact (hp.pow_dvd_iff_le_factorization hn).1 (h p hp hpn)

/-- The radical of a k-full integer, raised to the fullness exponent, divides
the integer. -/
theorem radical_pow_dvd (h : IsKFull k n) :
    abcRadical n ^ k ∣ n := by
  rw [abcRadical_eq_natRadical]
  have hd : radical n ^ k ≠ 0 :=
    pow_ne_zero k (Nat.ne_of_gt (Nat.radical_pos n))
  rw [← Nat.factorization_le_iff_dvd hd h.ne_zero]
  intro p
  rw [Nat.factorization_pow]
  change k * (radical n).factorization p ≤ n.factorization p
  by_cases hp : p.Prime
  · by_cases hpn : p ∣ n
    · have hprad : p ∣ radical n :=
        (UniqueFactorizationMonoid.dvd_radical_iff_of_irreducible
          hp h.ne_zero).2 hpn
      have hfac : (radical n).factorization p = 1 :=
        Nat.factorization_eq_one_of_squarefree
          (UniqueFactorizationMonoid.squarefree_radical (a := n))
          hp hprad
      rw [hfac, mul_one]
      exact h.2 p hp hpn
    · have hnrad : ¬p ∣ radical n := by
        intro hprad
        apply hpn
        exact
          (UniqueFactorizationMonoid.dvd_radical_iff_of_irreducible
            hp h.ne_zero).1 hprad
      rw [Nat.factorization_eq_zero_of_not_dvd hnrad]
      simp
  · rw [Nat.factorization_eq_zero_of_not_prime _ hp]
    simp

/-- Numerical radical compression. -/
theorem radical_pow_le (h : IsKFull k n) :
    abcRadical n ^ k ≤ n :=
  Nat.le_of_dvd (Nat.pos_of_ne_zero h.ne_zero) h.radical_pow_dvd

/-- Logarithmic radical compression for a positive fullness exponent. -/
theorem log_radical_le_div_log
    (h : IsKFull k n) (hk : 0 < k) :
    Real.log (abcRadical n : ℝ) ≤
      Real.log (n : ℝ) / (k : ℝ) := by
  have hradpos : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hpow :
      ((abcRadical n : ℕ) : ℝ) ^ k ≤ (n : ℝ) := by
    exact_mod_cast h.radical_pow_le
  have hlog :
      Real.log (((abcRadical n : ℕ) : ℝ) ^ k) ≤
        Real.log (n : ℝ) :=
    Real.log_le_log (pow_pos hradpos k) hpow
  rw [Real.log_pow] at hlog
  have hkR : 0 < (k : ℝ) := by exact_mod_cast hk
  apply (le_div_iff₀ hkR).2
  simpa [mul_comm] using hlog

end IsKFull

/-- The endpoint radicals of two k-full numbers satisfy the exact product
compression needed by neighbour constructions. -/
theorem endpoint_radical_power_product_le
    {b c r s : ℕ}
    (hb : IsKFull r b) (hc : IsKFull s c) :
    abcRadical b ^ r * abcRadical c ^ s ≤ b * c :=
  Nat.mul_le_mul hb.radical_pow_le hc.radical_pow_le

/-- Logarithmic endpoint budget for an `(r,s)`-full pair. -/
theorem log_endpoint_radicals_le
    {b c r s : ℕ}
    (hb : IsKFull r b) (hc : IsKFull s c)
    (hr : 0 < r) (hs : 0 < s) :
    Real.log (abcRadical b : ℝ) +
        Real.log (abcRadical c : ℝ) ≤
      Real.log (b : ℝ) / (r : ℝ) +
        Real.log (c : ℝ) / (s : ℝ) :=
  add_le_add (hb.log_radical_le_div_log hr)
    (hc.log_radical_le_div_log hs)

/-- Bare squarefull endpoints spend the whole exponent budget before the
positive additive gap is charged. -/
theorem square_square_endpoint_exponent :
    (1 : ℝ) / 2 + 1 / 2 = 1 := by
  norm_num

/-- A squarefull/cubefull pair leaves the sharp bare gap margin `1/6`. -/
theorem square_cube_endpoint_exponent :
    (1 : ℝ) / 2 + 1 / 3 = 5 / 6 := by
  norm_num

/-- Two cubefull endpoints leave the sharp bare gap margin `1/3`. -/
theorem cube_cube_endpoint_exponent :
    (1 : ℝ) / 3 + 1 / 3 = 2 / 3 := by
  norm_num

end KFullRadicalCompression
end IUTThreeClosures
