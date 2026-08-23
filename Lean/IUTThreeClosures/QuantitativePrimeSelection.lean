/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Quantitative prime selection in a bounded interval

The auxiliary prime in the IUT IV application must satisfy both a lower bound
and an upper bound.  The elementary mechanism is finite counting: if an
interval contains more primes than the number of exceptional primes, then one
prime in the interval is nonexceptional.

This module isolates that mechanism.  The genuinely arithmetic input is then a
lower bound for the number of primes in a suitable interval together with a
quantitative bound for the exceptional large-image primes.  Those inputs are
precisely stronger than a merely eventual open-image theorem.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- The finite set of primes in the interval `(L,U]`. -/
def primesInInterval (L U : ℕ) : Finset ℕ :=
  (Finset.Icc (L + 1) U).filter Nat.Prime

@[simp]
theorem mem_primesInInterval {L U p : ℕ} :
    p ∈ primesInInterval L U ↔ p.Prime ∧ L < p ∧ p ≤ U := by
  simp [primesInInterval]
  omega

/-- If `(L,U]` contains more primes than an exceptional finite set has
members, then some prime in the interval is nonexceptional. -/
theorem exists_prime_in_interval_not_mem
    (L U : ℕ) (exceptional : Finset ℕ)
    (hcard : exceptional.card < (primesInInterval L U).card) :
    ∃ p : ℕ, p.Prime ∧ L < p ∧ p ≤ U ∧ p ∉ exceptional := by
  classical
  have hex : ∃ p ∈ primesInInterval L U, p ∉ exceptional := by
    by_contra h
    push_neg at h
    have hsub : primesInInterval L U ⊆ exceptional := by
      intro p hp
      exact h p hp
    have hle := Finset.card_le_card hsub
    omega
  rcases hex with ⟨p, hpI, hpE⟩
  rcases (mem_primesInInterval.mp hpI) with ⟨hp, hL, hU⟩
  exact ⟨p, hp, hL, hU, hpE⟩

/-- Quantitative large-image prime selection: a finite exceptional-set bound
and a prime-count lower bound produce a prime in a prescribed interval with
the desired property. -/
theorem exists_quantitatively_controlled_prime
    (L U : ℕ) (exceptional : Finset ℕ)
    (P : ℕ → Prop)
    (hP : ∀ p : ℕ, p.Prime → p ∉ exceptional → P p)
    (hcard : exceptional.card < (primesInInterval L U).card) :
    ∃ p : ℕ,
      p.Prime ∧ L < p ∧ p ≤ U ∧ P p ∧ p ∉ exceptional := by
  rcases exists_prime_in_interval_not_mem L U exceptional hcard with
    ⟨p, hp, hL, hU, hpE⟩
  exact ⟨p, hp, hL, hU, hP p hp hpE, hpE⟩

/-- Simultaneously impose local coprimality conditions, once all primes that
violate them have been included in the exceptional set. -/
theorem exists_quantitatively_controlled_admissible_prime
    (L U : ℕ) (exceptional orders : Finset ℕ)
    (P : ℕ → Prop)
    (hP : ∀ p : ℕ, p.Prime → p ∉ exceptional → P p)
    (hcop : ∀ p : ℕ, p.Prime → p ∉ exceptional →
      ∀ n ∈ orders, Nat.Coprime p n)
    (hcard : exceptional.card < (primesInInterval L U).card) :
    ∃ p : ℕ,
      p.Prime ∧ L < p ∧ p ≤ U ∧ P p ∧ p ∉ exceptional ∧
        ∀ n ∈ orders, Nat.Coprime p n := by
  rcases exists_prime_in_interval_not_mem L U exceptional hcard with
    ⟨p, hp, hL, hU, hpE⟩
  exact ⟨p, hp, hL, hU, hP p hp hpE, hpE, hcop p hp hpE⟩

end IUTThreeClosures
