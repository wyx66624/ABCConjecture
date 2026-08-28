/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Two distinct boundary-prime directions in a primitive abc triple

For a positive primitive triple `a + b = c`, the three boundary components of
the associated Legendre parameter are represented by `a`, `b`, and `c`.
Except for the single triple `(1,1,2)`, at least two of these three components
are greater than one.  Each therefore has a prime divisor, and pairwise
coprimality forces the two selected primes to be distinct.

This is the elementary support theorem needed by the two-local-inertia route.
It does not claim that both selected primes are odd.  Since they are distinct,
at most one is `2`; the remaining arithmetic source theorem may therefore be
split into

* two odd multiplicative directions, or
* one odd direction together with the `2`-adic boundary direction.

No local Galois action, Picard--Lefschetz formula, large-image theorem, IUT
source, or abc inequality is asserted here.
-/

namespace IUTThreeClosures

/-- The three degeneration directions of the Legendre presentation of an abc
triple. -/
inductive ABCBoundary where
  | left
  | right
  | sum
  deriving DecidableEq, Fintype

namespace ABCBoundary

/-- The positive integer attached to a boundary direction. -/
def value (a b c : ℕ) : ABCBoundary → ℕ
  | left => a
  | right => b
  | sum => c

end ABCBoundary

/-- Two distinct boundary components together with distinct prime divisors. -/
structure BoundaryPrimePair (a b c : ℕ) where
  first : ABCBoundary
  second : ABCBoundary
  boundary_ne : first ≠ second
  p : ℕ
  q : ℕ
  p_prime : p.Prime
  q_prime : q.Prime
  p_dvd : p ∣ first.value a b c
  q_dvd : q ∣ second.value a b c
  primes_ne : p ≠ q

namespace BoundaryPrimePair

/-- Distinct selected primes cannot both be equal to `2`. -/
theorem at_least_one_ne_two
    {a b c : ℕ} (D : BoundaryPrimePair a b c) :
    D.p ≠ 2 ∨ D.q ≠ 2 := by
  by_cases hp : D.p = 2
  · right
    intro hq
    exact D.primes_ne (hp.trans hq.symm)
  · exact Or.inl hp

end BoundaryPrimePair

private theorem distinct_primes_of_coprime_factors
    {m n p q : ℕ}
    (hmn : m.Coprime n)
    (hp : p.Prime) (hq : q.Prime)
    (hpm : p ∣ m) (hqn : q ∣ n) :
    p ≠ q := by
  intro hpq
  subst q
  have hpgcd : p ∣ Nat.gcd m n := Nat.dvd_gcd hpm hqn
  have hgcd : Nat.gcd m n = 1 := hmn
  rw [hgcd] at hpgcd
  have hpone : p = 1 := Nat.dvd_one.mp hpgcd
  exact hp.ne_one hpone

/-- **Two-boundary support theorem.**  Every positive primitive abc triple
other than `(1,1,2)` has two distinct boundary directions carrying distinct
prime divisors. -/
theorem exists_two_boundary_prime_directions
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hsum : a + b = c)
    (hab : a.Coprime b)
    (hac : a.Coprime c)
    (hbc : b.Coprime c)
    (hnontrivial : ¬ (a = 1 ∧ b = 1)) :
    Nonempty (BoundaryPrimePair a b c) := by
  by_cases ha1 : a = 1
  · have hb1 : b ≠ 1 := by
      intro hb1
      exact hnontrivial ⟨ha1, hb1⟩
    have hb_ne_one : b ≠ 1 := hb1
    have hc_ne_one : c ≠ 1 := by
      omega
    rcases Nat.exists_prime_and_dvd hb_ne_one with ⟨p, hp, hpb⟩
    rcases Nat.exists_prime_and_dvd hc_ne_one with ⟨q, hq, hqc⟩
    refine ⟨{
      first := ABCBoundary.right
      second := ABCBoundary.sum
      boundary_ne := by decide
      p := p
      q := q
      p_prime := hp
      q_prime := hq
      p_dvd := hpb
      q_dvd := hqc
      primes_ne := distinct_primes_of_coprime_factors hbc hp hq hpb hqc
    }⟩
  · have ha_ne_one : a ≠ 1 := ha1
    by_cases hb1 : b = 1
    · have hc_ne_one : c ≠ 1 := by
        omega
      rcases Nat.exists_prime_and_dvd ha_ne_one with ⟨p, hp, hpa⟩
      rcases Nat.exists_prime_and_dvd hc_ne_one with ⟨q, hq, hqc⟩
      refine ⟨{
        first := ABCBoundary.left
        second := ABCBoundary.sum
        boundary_ne := by decide
        p := p
        q := q
        p_prime := hp
        q_prime := hq
        p_dvd := hpa
        q_dvd := hqc
        primes_ne := distinct_primes_of_coprime_factors hac hp hq hpa hqc
      }⟩
    · have hb_ne_one : b ≠ 1 := hb1
      rcases Nat.exists_prime_and_dvd ha_ne_one with ⟨p, hp, hpa⟩
      rcases Nat.exists_prime_and_dvd hb_ne_one with ⟨q, hq, hqb⟩
      refine ⟨{
        first := ABCBoundary.left
        second := ABCBoundary.right
        boundary_ne := by decide
        p := p
        q := q
        p_prime := hp
        q_prime := hq
        p_dvd := hpa
        q_dvd := hqb
        primes_ne := distinct_primes_of_coprime_factors hab hp hq hpa hqb
      }⟩

/-- If both selected support primes are different from `2`, they are odd. -/
theorem boundary_prime_pair_both_odd
    {a b c : ℕ} (D : BoundaryPrimePair a b c)
    (hp2 : D.p ≠ 2) (hq2 : D.q ≠ 2) :
    D.p.Odd ∧ D.q.Odd := by
  exact ⟨D.p_prime.odd_of_ne_two hp2,
    D.q_prime.odd_of_ne_two hq2⟩

end IUTThreeClosures
