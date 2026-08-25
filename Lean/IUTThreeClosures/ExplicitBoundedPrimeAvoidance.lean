/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

/-!
# Explicitly bounded prime avoidance

Ordinary finite prime avoidance gives a prime above a prescribed threshold
that avoids finitely many nonzero integers, but gives no upper bound for the
selected prime.  For the quantitative Frey route one can obtain an elementary
bound by a Euclid-style construction.

For `B,n > 0`, put

`N = n * B! + 1`.

Every prime divisor `ell` of `N` satisfies

* `B < ell`, since every positive integer at most `B` divides `B!`;
* `ell ∤ n`, since otherwise `ell` would divide both `n*B!` and
  `n*B!+1`;
* `ell <= n*B!+1`.

Taking `n` to be the product of a finite collection of positive local orders
produces one prime avoiding every order, with an explicit upper bound linear in
the product.  The factorial depends only on the externally prescribed lower
threshold (hence, in the ABC application, only on epsilon).

This theorem is independent of any large-image input.  Combined with a
uniform group-theoretic criterion saying that a prime above a fixed constant
and avoiding one multiplicative Tate order has large image, it would turn the
previously unbounded `PrimeSupply` into a quantitative source selection.
-/

namespace IUTThreeClosures

/-- A prime factor of `n * B! + 1` is above `B`, avoids `n`, and has the
obvious explicit upper bound. -/
theorem exists_prime_above_not_dvd_le_factorial
    (B n : ℕ)
    (hn : 0 < n) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      ¬ ell ∣ n ∧
      ell ≤ n * B.factorial + 1 := by
  let N : ℕ := n * B.factorial + 1
  have hfac : 0 < B.factorial := Nat.factorial_pos B
  have hprod : 0 < n * B.factorial := Nat.mul_pos hn hfac
  have hNpos : 0 < N := by
    dsimp [N]
    omega
  have hNne : N ≠ 1 := by
    dsimp [N]
    omega
  let ell : ℕ := N.minFac
  have hellPrime : ell.Prime := Nat.minFac_prime hNne
  have hellDvdN : ell ∣ N := Nat.minFac_dvd N
  have hellLe : ell ≤ N := Nat.le_of_dvd hNpos hellDvdN
  have hellNotDvdN : ¬ ell ∣ n := by
    intro helln
    have hellProd : ell ∣ n * B.factorial :=
      dvd_mul_of_dvd_left helln B.factorial
    have hellOne : ell ∣ N - n * B.factorial :=
      Nat.dvd_sub' hellDvdN hellProd
    have : ell ∣ 1 := by
      simpa [N] using hellOne
    exact hellPrime.not_dvd_one this
  have hBlt : B < ell := by
    by_contra hnot
    have hellB : ell ≤ B := Nat.le_of_not_gt hnot
    have hellFac : ell ∣ B.factorial :=
      Nat.dvd_factorial hellPrime.pos hellB
    have hellProd : ell ∣ n * B.factorial :=
      dvd_mul_of_dvd_right hellFac n
    have hellOne : ell ∣ N - n * B.factorial :=
      Nat.dvd_sub' hellDvdN hellProd
    have : ell ∣ 1 := by
      simpa [N] using hellOne
    exact hellPrime.not_dvd_one this
  exact ⟨ell, hellPrime, hBlt, hellNotDvdN, by simpa [N] using hellLe⟩

open scoped BigOperators

/-- Explicitly bounded avoidance of every member of a finite collection of
positive integers. -/
theorem exists_prime_above_avoiding_finset_bounded
    (B : ℕ)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, 0 < n) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      (∀ n ∈ orders, ¬ ell ∣ n) ∧
      ell ≤ (∏ n ∈ orders, n) * B.factorial + 1 := by
  have hprod : 0 < ∏ n ∈ orders, n := by
    exact Finset.prod_pos fun n hn => horders n hn
  obtain ⟨ell, hellPrime, hBell, hellNotProd, hellBound⟩ :=
    exists_prime_above_not_dvd_le_factorial
      B (∏ n ∈ orders, n) hprod
  refine ⟨ell, hellPrime, hBell, ?_, hellBound⟩
  intro n hn helln
  apply hellNotProd
  exact dvd_trans helln (Finset.dvd_prod_of_mem n hn)

/-- Singleton specialization, convenient for a fixed bad Tate place. -/
theorem exists_prime_above_avoiding_one_bounded
    (B order : ℕ)
    (horder : 0 < order) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      ¬ ell ∣ order ∧
      ell ≤ order * B.factorial + 1 :=
  exists_prime_above_not_dvd_le_factorial B order horder

end IUTThreeClosures
