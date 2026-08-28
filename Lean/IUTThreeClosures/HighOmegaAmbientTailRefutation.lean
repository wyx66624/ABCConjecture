/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# A finite counting obstruction to a tiny ambient high-omega tail

A proposed near-prime-power counterexample route assumes an ambient estimate
of the shape

`#{n ≤ x : omega(n) > w(x)} = o(x^(3/5))`

for a threshold `w(x)` of order `log log x`.  The estimate is incompatible
with the elementary supply of multiples of a primorial-type modulus.

Let `S` be any finite set of distinct primes, let `Q` be their product, and
assume a threshold is strictly smaller than `S.card`.  Every positive multiple
of `Q` has more than that threshold many distinct prime divisors.  Up to
`Q^5` there are exactly `Q^4` positive multiples of `Q`.  Thus the ambient
high-prime-divisor tail has cardinality at least `Q^4 = (Q^5)^(4/5)`, not a
quantity of `3/5` scale.

This file formalizes the finite counting core and proves that, along any
unbounded family of such products, no uniform cubic bound in `Q` can hold at
the fifth-power scale.  It does not formalize a particular real-valued
`log log` threshold; an application only has to prove that the chosen finite
prime set eventually has cardinality above that threshold.
-/

namespace IUTThreeClosures
namespace HighOmegaAmbientTailRefutation

open scoped BigOperators

/-- Injectively enumerate the positive multiples
`Q, 2Q, ..., (X / Q)Q`. -/
def positiveMultipleEmbedding (Q : ℕ) (hQ : 0 < Q) : ℕ ↪ ℕ where
  toFun m := (m + 1) * Q
  inj' := by
    intro a b hab
    have hcancel : a + 1 = b + 1 := Nat.mul_right_cancel hQ hab
    omega

/-- The positive multiples of `Q` obtained from the quotient interval. -/
def positiveMultiplesUpTo (Q X : ℕ) (hQ : 0 < Q) : Finset ℕ :=
  (Finset.range (X / Q)).map (positiveMultipleEmbedding Q hQ)

@[simp]
theorem card_positiveMultiplesUpTo
    (Q X : ℕ) (hQ : 0 < Q) :
    (positiveMultiplesUpTo Q X hQ).card = X / Q := by
  simp [positiveMultiplesUpTo]

/-- Exact finite sieve lower bound: if every positive multiple of `Q` below
`X` is bad, then the bad set in `[1,X]` has at least `X / Q` elements. -/
theorem many_bad_of_all_positive_multiples_bad
    (Q X : ℕ) (hQ : 0 < Q)
    (bad : ℕ → Prop)
    (hbad : ∀ n : ℕ,
      0 < n → n ≤ X → Q ∣ n → bad n) :
    X / Q ≤ ((Finset.Icc 1 X).filter bad).card := by
  classical
  have hsubset :
      positiveMultiplesUpTo Q X hQ ⊆
        (Finset.Icc 1 X).filter bad := by
    intro n hn
    rcases Finset.mem_map.mp hn with ⟨m, hm, rfl⟩
    have hm_lt : m < X / Q := Finset.mem_range.mp hm
    have hm_le : m + 1 ≤ X / Q := Nat.succ_le_iff.mpr hm_lt
    have hn_pos : 0 < (m + 1) * Q :=
      Nat.mul_pos (Nat.succ_pos m) hQ
    have hn_le : (m + 1) * Q ≤ X := by
      calc
        (m + 1) * Q ≤ (X / Q) * Q :=
          Nat.mul_le_mul_right Q hm_le
        _ ≤ X := Nat.div_mul_le_self X Q
    have hQdvd : Q ∣ (m + 1) * Q := by
      refine ⟨m + 1, ?_⟩
      simp [Nat.mul_comm]
    exact Finset.mem_filter.mpr
      ⟨Finset.mem_Icc.mpr
          ⟨Nat.succ_le_iff.mpr hn_pos, hn_le⟩,
        hbad ((m + 1) * Q) hn_pos hn_le hQdvd⟩
  have hcard := Finset.card_le_card hsubset
  simpa using hcard

/-- At the fifth-power scale the exact lower bound becomes `Q^4`. -/
theorem many_bad_at_fifth_power_scale
    (Q : ℕ) (hQ : 0 < Q)
    (bad : ℕ → Prop)
    (hbad : ∀ n : ℕ,
      0 < n → n ≤ Q ^ 5 → Q ∣ n → bad n) :
    Q ^ 4 ≤ ((Finset.Icc 1 (Q ^ 5)).filter bad).card := by
  have h := many_bad_of_all_positive_multiples_bad
    Q (Q ^ 5) hQ bad hbad
  have hdiv : Q ^ 5 / Q = Q ^ 4 := by
    apply Nat.div_eq_of_eq_mul_right hQ
    ring
  rwa [hdiv] at h

/-- Product of the primes in a finite set. -/
def primeProduct (S : Finset ℕ) : ℕ :=
  ∏ p ∈ S, p

/-- A number exceeds a threshold in its count of distinct prime divisors if
one can exhibit a larger finite set of distinct primes, every member of which
divides the number.  This witness-based definition avoids importing a
particular arithmetic-function notation for `omega`. -/
def ExceedsPrimeDivisorThreshold (threshold n : ℕ) : Prop :=
  ∃ S : Finset ℕ,
    threshold < S.card ∧
      ∀ p ∈ S, Nat.Prime p ∧ p ∣ n

/-- Any multiple of the product of a sufficiently large finite prime set
exceeds the stated distinct-prime-divisor threshold. -/
theorem product_multiple_exceeds_primeDivisorThreshold
    (S : Finset ℕ) (threshold n : ℕ)
    (hprime : ∀ p ∈ S, Nat.Prime p)
    (hthreshold : threshold < S.card)
    (hdiv : primeProduct S ∣ n) :
    ExceedsPrimeDivisorThreshold threshold n := by
  refine ⟨S, hthreshold, ?_⟩
  intro p hp
  refine ⟨hprime p hp, ?_⟩
  have hpQ : p ∣ primeProduct S := by
    simpa [primeProduct] using
      (Finset.dvd_prod_of_mem (fun q : ℕ => q) hp)
  exact hpQ.trans hdiv

/-- Finite core of the ambient-tail refutation.  If `S` contains more primes
than the threshold, then at least `Q^4` integers up to `Q^5`, where
`Q = prod S`, exceed that threshold. -/
theorem high_primeDivisor_tail_lower_bound_at_fifth_power_scale
    (S : Finset ℕ) (threshold : ℕ)
    (hprime : ∀ p ∈ S, Nat.Prime p)
    (hthreshold : threshold < S.card)
    (hQ : 0 < primeProduct S) :
    (primeProduct S) ^ 4 ≤
      ((Finset.Icc 1 ((primeProduct S) ^ 5)).filter
        (ExceedsPrimeDivisorThreshold threshold)).card := by
  apply many_bad_at_fifth_power_scale (primeProduct S) hQ
  intro n hn_pos hn_le hdiv
  exact product_multiple_exceeds_primeDivisorThreshold
    S threshold n hprime hthreshold hdiv

/-- Cardinality of the witness-defined high-prime-divisor tail at the
fifth-power scale. -/
noncomputable def highPrimeDivisorTailCard
    (Q threshold : ℕ) : ℕ := by
  classical
  exact ((Finset.Icc 1 (Q ^ 5)).filter
    (ExceedsPrimeDivisorThreshold threshold)).card

/-- Along an unbounded family of prime products whose finite prime-set
cardinalities exceed the selected thresholds, the tail cardinality cannot be
uniformly bounded by `C * Q^3`.  Since `X = Q^5`, this is the exact integral
power shadow of the failure of an `O(X^(3/5))` estimate. -/
theorem no_uniform_cubic_bound_for_highPrimeDivisorTail
    (S : ℕ → Finset ℕ) (threshold : ℕ → ℕ)
    (hprime : ∀ n p, p ∈ S n → Nat.Prime p)
    (hthreshold : ∀ n, threshold n < (S n).card)
    (hQ : ∀ n, 0 < primeProduct (S n))
    (hunbounded : ∀ C : ℕ, ∃ n : ℕ,
      C < primeProduct (S n)) :
    ¬ ∃ C : ℕ, ∀ n : ℕ,
      highPrimeDivisorTailCard
          (primeProduct (S n)) (threshold n) ≤
        C * (primeProduct (S n)) ^ 3 := by
  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := hunbounded C
  let Q := primeProduct (S n)
  have hQn : 0 < Q := by
    simpa [Q] using hQ n
  have hlower :
      Q ^ 4 ≤ highPrimeDivisorTailCard Q (threshold n) := by
    simpa [Q, highPrimeDivisorTailCard] using
      high_primeDivisor_tail_lower_bound_at_fifth_power_scale
        (S n) (threshold n)
        (hprime n) (hthreshold n) (hQ n)
  have hupper :
      highPrimeDivisorTailCard Q (threshold n) ≤ C * Q ^ 3 := by
    simpa [Q] using hC n
  have hpow_pos : 0 < Q ^ 3 := pow_pos hQn 3
  have hstrict : C * Q ^ 3 < Q * Q ^ 3 :=
    Nat.mul_lt_mul_of_lt_of_le hn (le_refl (Q ^ 3)) hpow_pos
  have hstrict' : C * Q ^ 3 < Q ^ 4 := by
    simpa [show Q * Q ^ 3 = Q ^ 4 by ring] using hstrict
  exact (Nat.not_lt_of_ge (hlower.trans hupper)) hstrict'

#print axioms card_positiveMultiplesUpTo
#print axioms many_bad_of_all_positive_multiples_bad
#print axioms many_bad_at_fifth_power_scale
#print axioms product_multiple_exceeds_primeDivisorThreshold
#print axioms high_primeDivisor_tail_lower_bound_at_fifth_power_scale
#print axioms no_uniform_cubic_bound_for_highPrimeDivisorTail

end HighOmegaAmbientTailRefutation
end IUTThreeClosures
