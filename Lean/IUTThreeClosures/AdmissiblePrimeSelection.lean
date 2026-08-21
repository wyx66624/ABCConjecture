import Mathlib

/-!
# Prime selection above a bound and outside a finite set

This formalizes the elementary selection layer needed by an actual
admissible-prime construction.  Besides avoiding a finite exceptional set, a
single sufficiently large prime is simultaneously coprime to every member of
a prescribed finite family of nonzero residue characteristics, Tate orders,
and extension degrees.

It still does not prove the substantive eventual large-image or local
geometric properties; those must be supplied separately.
-/

namespace IUTThreeClosures

private theorem mem_le_sum (s : Finset ℕ) {p : ℕ} (hp : p ∈ s) :
    p ≤ s.sum id := by
  classical
  induction s using Finset.induction_on with
  | empty => simp at hp
  | @insert a s ha ih =>
      rw [Finset.sum_insert ha]
      simp only [Finset.mem_insert] at hp
      rcases hp with rfl | hp
      · simp [id]
      · simp only [id_eq]
        exact (ih hp).trans (Nat.le_add_left _ _)

/-- There is a prime strictly above `N` and outside any prescribed finite set. -/
theorem exists_prime_above_not_mem (N : ℕ) (s : Finset ℕ) :
    ∃ p : ℕ, p.Prime ∧ N < p ∧ p ∉ s := by
  classical
  let B : ℕ := N + s.sum id + 1
  rcases Nat.exists_infinite_primes B with ⟨p, hBp, hpprime⟩
  refine ⟨p, hpprime, ?_, ?_⟩
  · dsimp [B] at hBp
    omega
  · intro hps
    have hle := mem_le_sum s hps
    dsimp [B] at hBp
    omega

/-- A prime above the sum of a finite family of nonzero naturals is coprime to
every member of the family. -/
theorem exists_prime_above_coprime_finset
    (N : ℕ) (s : Finset ℕ)
    (hs : ∀ n ∈ s, n ≠ 0) :
    ∃ p : ℕ, p.Prime ∧ N < p ∧ ∀ n ∈ s, Nat.Coprime p n := by
  classical
  let B : ℕ := N + s.sum id + 1
  rcases Nat.exists_infinite_primes B with ⟨p, hBp, hp⟩
  refine ⟨p, hp, ?_, ?_⟩
  · dsimp [B] at hBp
    omega
  · intro n hn
    apply hp.coprime_iff_not_dvd.mpr
    intro hpn
    have hple : p ≤ n := Nat.le_of_dvd (Nat.pos_of_ne_zero (hs n hn)) hpn
    have hnle : n ≤ s.sum id := mem_le_sum s hn
    dsimp [B] at hBp
    omega

/-- Simultaneous elementary admissible-prime selection: avoid one finite set,
be coprime to all members of another finite nonzero family, and satisfy any
property known for all sufficiently large primes outside the exceptional set. -/
theorem exists_prime_of_eventual_finite_exception_and_coprimality
    (N : ℕ) (exceptional orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0)
    (P : ℕ → Prop)
    (hP : ∀ p, p.Prime → N < p → p ∉ exceptional → P p) :
    ∃ p : ℕ, p.Prime ∧ P p ∧ p ∉ exceptional ∧
      ∀ n ∈ orders, Nat.Coprime p n := by
  classical
  let B : ℕ := N + exceptional.sum id + orders.sum id + 2
  rcases Nat.exists_infinite_primes B with ⟨p, hBp, hp⟩
  have hN : N < p := by
    dsimp [B] at hBp
    omega
  have hExc : p ∉ exceptional := by
    intro hpExc
    have hle := mem_le_sum exceptional hpExc
    dsimp [B] at hBp
    omega
  refine ⟨p, hp, hP p hp hN hExc, hExc, ?_⟩
  intro n hn
  apply hp.coprime_iff_not_dvd.mpr
  intro hpn
  have hple : p ≤ n := Nat.le_of_dvd (Nat.pos_of_ne_zero (horders n hn)) hpn
  have hnle : n ≤ orders.sum id := mem_le_sum orders hn
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