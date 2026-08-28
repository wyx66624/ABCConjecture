/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ChebyshevPrimeEscape

/-!
# Bounding exceptional-prime mass by one arithmetic divisor

For a finite set `A` of primes, put

`P_A = product_{p in A} p`,
`x_A = sum_{p in A} log p`.

The basic identity is

`x_A = log P_A`.

Consequently, whenever `P_A` divides a positive integer `N`, one has

`x_A <= log N`.

This is the exact bridge needed in the GenEll route: rather than estimate each
exceptional Galois prime separately, it suffices to construct one nonzero
arithmetic integer or ideal norm whose prime support contains the exceptional
set, and then bound the logarithm of that divisor by height/different data.

The theorem is elementary and makes no assertion about which Galois primes are
exceptional or which divisor supports them.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- Product of a finite set of natural primes. -/
def exceptionalPrimeProduct (A : Finset ℕ) : ℕ :=
  ∏ p in A, p

/-- The product of a finite set of primes is positive. -/
theorem exceptionalPrimeProduct_pos
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    0 < exceptionalPrimeProduct A := by
  unfold exceptionalPrimeProduct
  exact Finset.prod_pos fun p hp => (hA p hp).pos

/-- The real logarithm of the finite prime product is the logarithmic prime
mass. -/
theorem log_exceptionalPrimeProduct_eq_primeLogMass
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    Real.log (exceptionalPrimeProduct A) = primeLogMass A := by
  classical
  induction A using Finset.induction_on with
  | empty =>
      simp [exceptionalPrimeProduct, primeLogMass]
  | @insert p A hp ih =>
      have hpPrime : p.Prime := hA p (by simp)
      have hAprime : ∀ q ∈ A, q.Prime := by
        intro q hq
        exact hA q (by simp [hq])
      have hp0R : (p : ℝ) ≠ 0 := by
        exact_mod_cast hpPrime.ne_zero
      have hprodPos : 0 < exceptionalPrimeProduct A :=
        exceptionalPrimeProduct_pos A hAprime
      have hprod0R :
          ((exceptionalPrimeProduct A : ℕ) : ℝ) ≠ 0 := by
        exact_mod_cast hprodPos.ne'
      rw [exceptionalPrimeProduct, Finset.prod_insert hp]
      push_cast
      rw [Real.log_mul hp0R hprod0R]
      rw [ih hAprime]
      simp [primeLogMass, hp]

/-- Equivalent orientation of the prime-product logarithm identity. -/
theorem primeLogMass_eq_log_exceptionalPrimeProduct
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    primeLogMass A = Real.log (exceptionalPrimeProduct A) :=
  (log_exceptionalPrimeProduct_eq_primeLogMass A hA).symm

/-- Divisibility by a positive integer bounds the exceptional prime product. -/
theorem exceptionalPrimeProduct_le_of_dvd
    (A : Finset ℕ) {N : ℕ}
    (hN : 0 < N)
    (hdiv : exceptionalPrimeProduct A ∣ N) :
    exceptionalPrimeProduct A ≤ N :=
  Nat.le_of_dvd hN hdiv

/-- **Exceptional-mass divisor bound.** If the product of all exceptional
primes divides a positive integer `N`, then their logarithmic mass is at most
`log N`. -/
theorem primeLogMass_le_log_of_product_dvd
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {N : ℕ} (hN : 0 < N)
    (hdiv : exceptionalPrimeProduct A ∣ N) :
    primeLogMass A ≤ Real.log N := by
  rw [primeLogMass_eq_log_exceptionalPrimeProduct A hA]
  have hprodPos : 0 < exceptionalPrimeProduct A :=
    exceptionalPrimeProduct_pos A hA
  have hleNat : exceptionalPrimeProduct A ≤ N :=
    exceptionalPrimeProduct_le_of_dvd A hN hdiv
  have hprodPosR : (0 : ℝ) < exceptionalPrimeProduct A := by
    exact_mod_cast hprodPos
  have hleReal :
      ((exceptionalPrimeProduct A : ℕ) : ℝ) ≤ N := by
    exact_mod_cast hleNat
  exact Real.log_le_log hprodPosR hleReal

/-- A height bound on the supporting divisor immediately gives a height bound
on the exceptional logarithmic mass. -/
theorem primeLogMass_le_height_of_product_dvd
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {N : ℕ} (hN : 0 < N)
    (hdiv : exceptionalPrimeProduct A ∣ N)
    {H C : ℝ} (hNheight : Real.log N ≤ H + C) :
    primeLogMass A ≤ H + C :=
  (primeLogMass_le_log_of_product_dvd A hA hN hdiv).trans hNheight

end IUTThreeClosures
