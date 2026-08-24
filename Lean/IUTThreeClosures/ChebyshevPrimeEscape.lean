/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.Chebyshev

/-!
# A Chebyshev-mass criterion for escaping a finite forbidden set

The analytic core of the prescribed-size prime argument is elementary once a
sufficient lower bound for the Chebyshev function has been supplied. Let

`x_A = sum_{p in A} log p`

for a finite set `A` of forbidden primes. If

`theta X > theta h + x_A`,

then some prime in `(h, X]` is not in `A`. Otherwise all primes up to `X`
would be covered by the primes up to `h` together with `A`, forcing the reverse
Chebyshev-mass inequality.

This module proves that exact finite-sum step. It isolates the remaining
analytic input in GenEll Lemma 4.1: choose an explicit `X` for which the strict
Chebyshev inequality holds. No Galois-image or elliptic-curve statement is
assumed here.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- Logarithmic mass of a finite forbidden set of natural numbers. In the
applications every member is prime. -/
noncomputable def primeLogMass (A : Finset ℕ) : ℝ :=
  ∑ p ∈ A, Real.log p

/-- The logarithmic mass of a finite set of primes is nonnegative. -/
theorem primeLogMass_nonneg
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    0 ≤ primeLogMass A := by
  unfold primeLogMass
  apply Finset.sum_nonneg
  intro p hp
  exact Real.log_nonneg (by
    exact_mod_cast (hA p hp).one_le)

/-- If every prime in `(h, X]` belongs to `A`, then the Chebyshev mass up to
`X` is at most the mass up to `h` plus the forbidden mass. -/
theorem theta_le_theta_add_primeLogMass_of_interval_covered
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {h X : ℕ}
    (hcover : ∀ p : ℕ, p.Prime → p ≤ X → h < p → p ∈ A) :
    Chebyshev.theta X ≤ Chebyshev.theta h + primeLogMass A := by
  classical
  rw [Chebyshev.theta_eq_sum_primesLE_log,
    Chebyshev.theta_eq_sum_primesLE_log]
  have hsubset : primesLE X ⊆ primesLE h ∪ A := by
    intro p hp
    by_cases hph : p ≤ h
    · exact Finset.mem_union_left A
        ((mem_primesLE.mpr ⟨hph, prime_of_mem_primesLE hp⟩))
    · exact Finset.mem_union_right (primesLE h)
        (hcover p (prime_of_mem_primesLE hp)
          (le_of_mem_primesLE hp) (lt_of_not_ge hph))
  have hsum_subset :
      (∑ p ∈ primesLE X, Real.log p) ≤
        ∑ p ∈ primesLE h ∪ A, Real.log p := by
    apply Finset.sum_le_sum_of_subset_of_nonneg hsubset
    intro p hpUnion hpNot
    have hpPrime : p.Prime := by
      rcases Finset.mem_union.mp hpUnion with hp | hp
      · exact prime_of_mem_primesLE hp
      · exact hA p hp
    exact Real.log_nonneg (by
      exact_mod_cast hpPrime.one_le)
  have hinter_nonneg :
      0 ≤ ∑ p ∈ primesLE h ∩ A, Real.log p := by
    apply Finset.sum_nonneg
    intro p hp
    exact Real.log_nonneg (by
      exact_mod_cast (prime_of_mem_primesLE
        (Finset.mem_inter.mp hp).1).one_le)
  have hunion :
      (∑ p ∈ primesLE h ∪ A, Real.log p) ≤
        (∑ p ∈ primesLE h, Real.log p) +
          ∑ p ∈ A, Real.log p := by
    have hidentity :
        (∑ p ∈ primesLE h ∪ A, Real.log p) +
            (∑ p ∈ primesLE h ∩ A, Real.log p) =
          (∑ p ∈ primesLE h, Real.log p) +
            ∑ p ∈ A, Real.log p := by
      exact Finset.sum_union_inter
    linarith
  exact hsum_subset.trans hunion

/-- **One-prime Chebyshev escape theorem.** A strict excess of Chebyshev mass
above the old-prime and forbidden-prime masses produces a prime in the desired
bounded interval outside the forbidden set. -/
theorem exists_prime_not_mem_of_theta_gt
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {h X : ℕ}
    (hTheta :
      Chebyshev.theta h + primeLogMass A < Chebyshev.theta X) :
    ∃ p : ℕ, p.Prime ∧ h < p ∧ p ≤ X ∧ p ∉ A := by
  by_contra hnone
  have hcovered :
      ∀ p : ℕ, p.Prime → p ≤ X → h < p → p ∈ A := by
    intro p hp hpX hhp
    by_contra hpA
    exact hnone ⟨p, hp, hhp, hpX, hpA⟩
  have hle :=
    theta_le_theta_add_primeLogMass_of_interval_covered
      A hA hcovered
  linarith

end IUTThreeClosures
