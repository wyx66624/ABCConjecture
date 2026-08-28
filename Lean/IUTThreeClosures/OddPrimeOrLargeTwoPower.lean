/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# An odd-prime or power-of-two dichotomy

A positive integer with no odd prime divisor is a power of two. Consequently,
a positive integer at least `32` either has an odd prime divisor or is `2^k`
with `5 ≤ k`.

This elementary theorem isolates the only `2`-adic case in the two-boundary
inertia strategy. For a unit-leg abc triple, if an even boundary component has
no second odd prime direction and is outside the finite range below `32`, its
`2`-adic exponent is automatically at least five.
-/

namespace IUTThreeClosures

/-- If every prime divisor of a positive integer is `2`, then the integer is a
power of two. -/
theorem eq_two_pow_of_all_prime_dvd_eq_two :
    ∀ n : ℕ, 0 < n →
      (∀ p : ℕ, p.Prime → p ∣ n → p = 2) →
      ∃ k : ℕ, n = 2 ^ k := by
  intro n
  induction n using Nat.strong_induction_on with
  | h n ih =>
      intro hn hprime
      by_cases hn1 : n = 1
      · exact ⟨0, by simp [hn1]⟩
      · rcases Nat.exists_prime_and_dvd hn1 with ⟨p, hp, hpn⟩
        have hp2 : p = 2 := hprime p hp hpn
        subst p
        rcases hpn with ⟨m, hm⟩
        have hmpos : 0 < m := by
          rw [hm] at hn
          omega
        have hmlt : m < n := by
          rw [hm]
          omega
        have hmdivn : m ∣ n := by
          refine ⟨2, ?_⟩
          rw [hm, Nat.mul_comm]
        have hmprime :
            ∀ q : ℕ, q.Prime → q ∣ m → q = 2 := by
          intro q hq hqm
          exact hprime q hq (hqm.trans hmdivn)
        rcases ih m hmlt hmpos hmprime with ⟨k, hk⟩
        refine ⟨k + 1, ?_⟩
        rw [hm, hk, pow_succ]
        omega

/-- Every positive integer either has an odd prime divisor or is a power of
two. -/
theorem exists_odd_prime_dvd_or_eq_two_pow
    {n : ℕ} (hn : 0 < n) :
    (∃ p : ℕ, p.Prime ∧ p.Odd ∧ p ∣ n) ∨
      ∃ k : ℕ, n = 2 ^ k := by
  by_cases hodd : ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ n
  · rcases hodd with ⟨p, hp, hp2, hpn⟩
    exact Or.inl ⟨p, hp, hp.odd_of_ne_two hp2, hpn⟩
  · right
    apply eq_two_pow_of_all_prime_dvd_eq_two n hn
    intro p hp hpn
    by_contra hp2
    exact hodd ⟨p, hp, hp2, hpn⟩

/-- A power of two at least `32` has exponent at least five. -/
theorem five_le_exponent_of_two_pow_ge_thirtyTwo
    {n k : ℕ}
    (hk : n = 2 ^ k)
    (hn32 : 32 ≤ n) :
    5 ≤ k := by
  subst n
  by_contra hnot
  have hklt : k < 5 := by omega
  have hkle : k ≤ 4 := by omega
  interval_cases k <;> norm_num at hn32

/-- **Large even-boundary dichotomy.** A positive integer at least `32`
either has an odd prime divisor or is a power `2^k` with `k ≥ 5`. -/
theorem exists_odd_prime_dvd_or_large_two_pow
    {n : ℕ} (hn : 0 < n) (hn32 : 32 ≤ n) :
    (∃ p : ℕ, p.Prime ∧ p.Odd ∧ p ∣ n) ∨
      ∃ k : ℕ, 5 ≤ k ∧ n = 2 ^ k := by
  rcases exists_odd_prime_dvd_or_eq_two_pow hn with hodd | ⟨k, hk⟩
  · exact Or.inl hodd
  · exact Or.inr ⟨k,
      five_le_exponent_of_two_pow_ge_thirtyTwo hk hn32,
      hk⟩

end IUTThreeClosures
