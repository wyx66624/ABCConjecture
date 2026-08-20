import Mathlib

/-!
# Prime selection above a bound and outside a finite set

This formalizes the purely elementary selection step. It does not prove that
the Galois-image, Tate-order, or Corollary 2.2 conditions fail at only finitely
many primes; those are the substantive arithmetic inputs.
-/

namespace IUTThreeClosures

private theorem mem_le_sum (s : Finset ℕ) {p : ℕ} (hp : p ∈ s) :
    p ≤ ∑ q in s, q := by
  classical
  induction s using Finset.induction_on with
  | empty => simp at hp
  | @insert a s ha ih =>
      rw [Finset.sum_insert ha]
      simp only [Finset.mem_insert] at hp
      rcases hp with rfl | hp
      · omega
      · have h := ih hp
        omega

/-- There is a prime strictly above `N` and outside any prescribed finite set. -/
theorem exists_prime_above_not_mem (N : ℕ) (s : Finset ℕ) :
    ∃ p : ℕ, p.Prime ∧ N < p ∧ p ∉ s := by
  classical
  let B : ℕ := N + (∑ q in s, q) + 1
  rcases Nat.exists_infinite_primes B with ⟨p, hBp, hpprime⟩
  refine ⟨p, hpprime, ?_, ?_⟩
  · dsimp [B] at hBp
    omega
  · intro hps
    have hle := mem_le_sum s hps
    dsimp [B] at hBp
    omega

/-- If a desired prime property holds for every sufficiently large prime
outside a finite exceptional set, then a prime with that property exists. -/
theorem exists_prime_of_eventual_finite_exception
    (N : ℕ) (s : Finset ℕ) (P : ℕ → Prop)
    (hP : ∀ p, p.Prime → N < p → p ∉ s → P p) :
    ∃ p : ℕ, p.Prime ∧ P p := by
  rcases exists_prime_above_not_mem N s with ⟨p, hp, hN, hs⟩
  exact ⟨p, hp, hP p hp hN hs⟩

end IUTThreeClosures
