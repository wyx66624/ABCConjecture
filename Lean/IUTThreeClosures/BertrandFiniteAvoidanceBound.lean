/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.Bertrand

/-!
# An explicit Bertrand bound for finite prime avoidance

A merely eventual prime theorem gives a lower threshold but no arbitrary
independent upper bound.  Once that threshold and a finite forbidden set are
known, however, no deep quantitative prime-distribution theorem is needed to
obtain an explicit upper bound.

Repeated Bertrand intervals suffice.  Starting above `h`, choose a prime at
most twice the current bound.  If it is forbidden, erase it and repeat.  After
at most `A.card + 1` steps a prime outside `A` must occur, and it is at most

`2^(A.card + 1) * h`.

The final theorem combines this with an eventual prime property.  It isolates
the genuinely arithmetic quantitative task: bound the eventual large-image
threshold and the size of the finite exceptional set.  Prime escape itself is
then explicit.
-/

namespace IUTThreeClosures

/-- **Explicit finite-avoidance Bertrand bound.**  Above every nonzero bound
`h`, a prime escaping a finite set `A` occurs before
`2^(A.card + 1) * h`.  The members of `A` need not themselves be prime. -/
theorem exists_prime_not_mem_le_two_pow_card
    (A : Finset ℕ) (h : ℕ) (hh : h ≠ 0) :
    ∃ p : ℕ,
      p.Prime ∧
      h < p ∧
      p ≤ 2 ^ (A.card + 1) * h ∧
      p ∉ A := by
  classical
  let P : ℕ → Prop := fun n =>
    ∀ A : Finset ℕ, A.card = n →
      ∀ h : ℕ, h ≠ 0 →
        ∃ p : ℕ,
          p.Prime ∧
          h < p ∧
          p ≤ 2 ^ (n + 1) * h ∧
          p ∉ A
  have hP : ∀ n : ℕ, P n := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
        intro A hcard h hh
        obtain ⟨p, hpPrime, hpLarge, hpUpper⟩ :=
          Nat.exists_prime_lt_and_le_two_mul h hh
        by_cases hpA : p ∈ A
        · let A' : Finset ℕ := A.erase p
          have hcardErase : A'.card + 1 = n := by
            dsimp [A']
            rw [← hcard]
            exact Finset.card_erase_add_one hpA
          have hcardLt : A'.card < n := by
            omega
          obtain ⟨q, hqPrime, hpq, hqUpper, hqAvoid⟩ :=
            ih A'.card hcardLt A' rfl p hpPrime.ne_zero
          refine ⟨q, hqPrime, hpLarge.trans hpq, ?_, ?_⟩
          · have hqUpper' : q ≤ 2 ^ n * p := by
              simpa [hcardErase] using hqUpper
            calc
              q ≤ 2 ^ n * p := hqUpper'
              _ ≤ 2 ^ n * (2 * h) :=
                Nat.mul_le_mul_left (2 ^ n) hpUpper
              _ = 2 ^ (n + 1) * h := by
                rw [pow_succ]
                ring
          · intro hqA
            apply hqAvoid
            exact Finset.mem_erase.mpr
              ⟨Nat.ne_of_gt hpq, hqA⟩
        · refine ⟨p, hpPrime, hpLarge, ?_, hpA⟩
          have hpow : 2 ≤ 2 ^ (n + 1) := by
            simpa using
              (pow_le_pow_right' (a := (2 : ℕ))
                (by norm_num : 1 ≤ (2 : ℕ))
                (show 1 ≤ n + 1 by omega))
          exact hpUpper.trans (Nat.mul_le_mul_right h hpow)
  exact hP A.card A rfl h hh

/-- An eventual prime property, together with a finite forbidden set, has an
explicit bounded witness.  The bound depends only on the eventual threshold,
the requested lower bound, and the cardinality of the forbidden set. -/
theorem exists_eventual_prime_not_mem_bounded
    (P : ℕ → Prop)
    (N : ℕ)
    (hP : ∀ p : ℕ, p.Prime → N < p → P p)
    (A : Finset ℕ)
    (B : ℕ)
    (hmax : max N B ≠ 0) :
    ∃ p : ℕ,
      p.Prime ∧
      B < p ∧
      P p ∧
      p ∉ A ∧
      p ≤ 2 ^ (A.card + 1) * max N B := by
  obtain ⟨p, hpPrime, hpLarge, hpUpper, hpAvoid⟩ :=
    exists_prime_not_mem_le_two_pow_card A (max N B) hmax
  refine ⟨p, hpPrime, ?_, hP p hpPrime ?_, hpAvoid, hpUpper⟩
  · exact (le_max_right N B).trans_lt hpLarge
  · exact (le_max_left N B).trans_lt hpLarge

end IUTThreeClosures
