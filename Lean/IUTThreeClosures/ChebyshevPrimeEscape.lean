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

This module proves that exact finite-sum step and then combines it with
Mathlib's explicit upper and lower Chebyshev estimates. The only remaining
analytic task in GenEll Lemma 4.1 is to choose a concrete `X` for which the
displayed elementary inequality holds.
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

/-- A completely explicit sufficient inequality, obtained by combining
Mathlib's Chebyshev upper bound at `h` and lower bound at `X`.

Thus the prescribed-size prime problem is reduced to an ordinary real
inequality involving only `h`, `X`, and the forbidden logarithmic mass. -/
theorem exists_prime_not_mem_of_explicit_chebyshev_bound
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {h X : ℕ}
    (hbound :
      Real.log 4 * (h : ℝ) + primeLogMass A <
        (X : ℝ) * Real.log 2 - Real.log ((X : ℝ) + 1) -
          2 * Real.sqrt X * Real.log X) :
    ∃ p : ℕ, p.Prime ∧ h < p ∧ p ≤ X ∧ p ∉ A := by
  apply exists_prime_not_mem_of_theta_gt A hA
  have hupper :
      Chebyshev.theta h ≤ Real.log 4 * (h : ℝ) :=
    Chebyshev.theta_le_log4_mul_x (by positivity)
  have hlower :
      (X : ℝ) * Real.log 2 - Real.log ((X : ℝ) + 1) -
          2 * Real.sqrt X * Real.log X ≤ Chebyshev.theta X := by
    simpa using Chebyshev.theta_ge X
  have hmass :
      Chebyshev.theta h + primeLogMass A ≤
        Real.log 4 * (h : ℝ) + primeLogMass A :=
    add_le_add_right hupper _
  exact (hmass.trans_lt hbound).trans_le hlower

end IUTThreeClosures
