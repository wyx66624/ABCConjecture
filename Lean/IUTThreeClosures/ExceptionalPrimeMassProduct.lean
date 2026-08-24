/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ChebyshevPrimeEscape

/-!
# Bounding exceptional-prime mass by one avoidance product

Let `A` be a finite set of distinct primes and let

`rad(A) = product_{p in A} p`.

If this squarefree product divides a positive integer `N`, then

`sum_{p in A} log p = log rad(A) <= log N`.

Thus an exponential height estimate

`N <= exp(alpha * h + beta)`

immediately gives

`sum_{p in A} log p <= alpha * h + beta`.

This is the precise elementary reduction needed for the exceptional Galois
primes in the prescribed-size-prime argument.  Instead of estimating every
exceptional prime separately, it is enough to construct a single arithmetic
avoidance product divisible by all of them and bound that product in terms of
height, different and conductor data.

No Galois-image theorem or such arithmetic product estimate is asserted in
this module.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The squarefree product of a finite set of natural numbers. -/
def primeProduct (A : Finset ℕ) : ℕ :=
  ∏ p ∈ A, p

/-- A finite product of primes is strictly positive. -/
theorem primeProduct_pos
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    0 < primeProduct A := by
  unfold primeProduct
  apply Finset.prod_pos
  intro p hp
  exact (hA p hp).pos

/-- The logarithm of the squarefree prime product is exactly the logarithmic
mass used by the Chebyshev escape argument. -/
theorem primeLogMass_eq_log_primeProduct
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime) :
    primeLogMass A = Real.log (primeProduct A) := by
  classical
  revert hA
  induction A using Finset.induction_on with
  | empty =>
      intro hA
      simp [primeLogMass, primeProduct]
  | @insert p A hp ih =>
      intro hA
      have hpPrime : p.Prime := hA p (by simp)
      have hAPrime : ∀ q ∈ A, q.Prime := by
        intro q hq
        exact hA q (by simp [hq])
      have hpReal_ne : (p : ℝ) ≠ 0 := by
        exact_mod_cast hpPrime.ne_zero
      have hprodNat_ne : primeProduct A ≠ 0 :=
        (primeProduct_pos A hAPrime).ne'
      have hprodReal_ne : ((primeProduct A : ℕ) : ℝ) ≠ 0 := by
        exact_mod_cast hprodNat_ne
      calc
        primeLogMass (insert p A) =
            Real.log p + primeLogMass A := by
          simp [primeLogMass, hp]
        _ = Real.log p + Real.log (primeProduct A) := by
          rw [ih hAPrime]
        _ = Real.log ((p : ℝ) * (primeProduct A : ℝ)) := by
          rw [Real.log_mul hpReal_ne hprodReal_ne]
        _ = Real.log (primeProduct (insert p A)) := by
          simp [primeProduct, hp]

/-- If the squarefree exceptional-prime product divides `N`, then the total
exceptional logarithmic mass is at most `log N`. -/
theorem primeLogMass_le_log_of_primeProduct_dvd
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {N : ℕ} (hN : 0 < N)
    (hdiv : primeProduct A ∣ N) :
    primeLogMass A ≤ Real.log N := by
  have hprodle : primeProduct A ≤ N :=
    Nat.le_of_dvd hN hdiv
  have hprodposReal : (0 : ℝ) < primeProduct A := by
    exact_mod_cast primeProduct_pos A hA
  have hprodleReal : (primeProduct A : ℝ) ≤ N := by
    exact_mod_cast hprodle
  rw [primeLogMass_eq_log_primeProduct A hA]
  exact Real.log_le_log hprodposReal hprodleReal

/-- Exponential control of one avoidance product gives an affine height bound
for the complete exceptional-prime mass. -/
theorem primeLogMass_le_affine_of_primeProduct_dvd
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {N : ℕ} (hN : 0 < N)
    (hdiv : primeProduct A ∣ N)
    {α β h : ℝ}
    (hNheight : (N : ℝ) ≤ Real.exp (α * h + β)) :
    primeLogMass A ≤ α * h + β := by
  have hmass :=
    primeLogMass_le_log_of_primeProduct_dvd A hA hN hdiv
  have hNreal : (0 : ℝ) < N := by exact_mod_cast hN
  have hlogN : Real.log N ≤ α * h + β :=
    (Real.log_le_iff_le_exp hNreal).2 hNheight
  exact hmass.trans hlogN

/-- A conductor/different specialization convenient for the IUT/GenEll
application. -/
theorem primeLogMass_le_height_different_conductor
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    {N : ℕ} (hN : 0 < N)
    (hdiv : primeProduct A ∣ N)
    {height different conductor α β γ C : ℝ}
    (hNbound :
      (N : ℝ) ≤
        Real.exp
          (α * height + β * different + γ * conductor + C)) :
    primeLogMass A ≤
      α * height + β * different + γ * conductor + C := by
  have hmass :=
    primeLogMass_le_log_of_primeProduct_dvd A hA hN hdiv
  have hNreal : (0 : ℝ) < N := by exact_mod_cast hN
  have hlogN :
      Real.log N ≤
        α * height + β * different + γ * conductor + C :=
    (Real.log_le_iff_le_exp hNreal).2 hNbound
  exact hmass.trans hlogN

end IUTThreeClosures
