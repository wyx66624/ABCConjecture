/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Eventual large image is not a quantitative prime-selection theorem

The IUT IV application may require an auxiliary prime that is simultaneously
large enough for the epsilon correction and quantitatively controlled so that
all prime-dependent source terms admit bounds uniform in the abc input. A
merely eventual large-image theorem of Serre type supplies only a lower
threshold. It gives no upper bound for the first usable prime.

This logical distinction is real, not cosmetic. For any proposed upper bound
`B`, the prime property `B < p` holds for every sufficiently large prime, but
no prime satisfying it lies below `B`. Thus eventuality alone cannot prove a
quantitative upper bound. One needs either a quantitative large-image prime
theorem or an independent proof that every prime-dependent term in the final
bridge is uniformly bounded without such an upper bound.
-/

namespace IUTThreeClosures

/-- A property of primes may hold eventually while having no witness below a
prescribed bound. -/
theorem eventual_prime_property_without_bounded_witness (B : ℕ) :
    let P : ℕ → Prop := fun p => B < p
    (∀ p : ℕ, p.Prime → B < p → P p) ∧
      ¬ ∃ p : ℕ, p.Prime ∧ P p ∧ p ≤ B := by
  dsimp
  constructor
  · intro p hp hpB
    exact hpB
  · rintro ⟨p, hp, hpB, hp_le⟩
    omega

/-- Therefore no abstract implication can turn only an eventual-prime
hypothesis into a witness satisfying an arbitrary independent upper bound. -/
theorem no_eventual_to_arbitrary_upper_bound :
    ¬ (∀ (P : ℕ → Prop) (N B : ℕ),
      (∀ p : ℕ, p.Prime → N < p → P p) →
      ∃ p : ℕ, p.Prime ∧ P p ∧ p ≤ B) := by
  intro h
  let P : ℕ → Prop := fun p => 10 < p
  rcases h P 10 10 (by
    intro p hp hp10
    exact hp10) with ⟨p, hp, hpP, hpB⟩
  dsimp [P] at hpP
  omega

end IUTThreeClosures
