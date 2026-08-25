/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExceptionalPrimeMassProduct
import Mathlib.RingTheory.Polynomial.Resultant.Basic

/-!
# Polynomial discriminants and the tame Kummer budget

This file isolates two unconditional elementary layers of the
Fermat--Kummer discriminant route.

First, after replacing a root `x^n = a / c` by the integral element
`alpha = c*x`, its displayed polynomial is

`T^n - a*c^(n-1)`.

We compute the discriminant of this *polynomial*.  This is not asserted to
be the discriminant of the selected root field: the polynomial may be
reducible, its selected root may have smaller degree, and even in the
irreducible case its power order need not be the full ring of integers.

Second, at a tame prime whose boundary multiplicity is `m`, put
`g = gcd(n,m)`.  A Kummer root has ramification index `n/g`; hence the
normalized truncated-boundary weight is `g/n`, while the normalized tame
different weight is `1-g/n`.  Their sum is exactly one.  The formal theorem
below proves this coefficient identity locally and after summing over any
finite tame support.  It contains no Vojta or `abc` estimate.
-/

namespace IUTThreeClosures

open scoped BigOperators
open Polynomial

/-! ## The displayed integral Kummer polynomial -/

/-- The integral parameter obtained from `x^n = a/c` after setting
`alpha = c*x`. -/
def kummerIntegralParameter (n a c : ℕ) : ℕ :=
  a * c ^ (n - 1)

/-- The monic integral polynomial satisfied by the rescaled Kummer root. -/
noncomputable def kummerIntegralPolynomial (n A : ℕ) : ℤ[X] :=
  X ^ n - C (A : ℤ)

/-- The absolute value predicted by the polynomial discriminant formula.
This is deliberately named an envelope, not a field discriminant. -/
def kummerPolynomialDiscriminantAbs (n A : ℕ) : ℕ :=
  n ^ n * A ^ (n - 1)

/-- Exact discriminant of the displayed binomial.  No irreducibility or
maximal-order conclusion is part of this statement. -/
theorem discr_kummerIntegralPolynomial
    (n A : ℕ) (hn : 0 < n) :
    (kummerIntegralPolynomial n A).discr =
      (-1 : ℤ) ^ (n * (n - 1) / 2 + (n - 1)) *
        (n : ℤ) ^ n * (A : ℤ) ^ (n - 1) := by
  let f : ℤ[X] := kummerIntegralPolynomial n A
  have hdegree : f.degree = (n : WithBot ℕ) := by
    simpa [f, kummerIntegralPolynomial] using
      (degree_X_pow_sub_C hn (A : ℤ))
  have hnatDegree : f.natDegree = n := by
    exact natDegree_eq_of_degree_eq_some hdegree
  have hleading : f.leadingCoeff = 1 := by
    simpa [f, kummerIntegralPolynomial] using
      (leadingCoeff_X_pow_sub_C (R := ℤ) (r := (A : ℤ)) hn)
  have hderivative : f.derivative = C (n : ℤ) * X ^ (n - 1) := by
    simp [f, kummerIntegralPolynomial, derivative_X_pow]
  have hres := resultant_deriv (f := f) (by simpa [hdegree] using hn)
  rw [hderivative, hnatDegree, hleading, mul_one] at hres
  rw [resultant_C_mul_right] at hres
  rw [resultant_X_pow_right f n (n - 1)
    (by simp [hnatDegree])] at hres
  have hcoeff : f.coeff 0 = -(A : ℤ) := by
    simp [f, kummerIntegralPolynomial, Ne.symm hn.ne']
  have heven : Even (n * (n - 1)) := by
    have hsucc : n - 1 + 1 = n := Nat.sub_add_cancel hn
    simpa [hsucc, mul_comm] using Nat.even_mul_succ_self (n - 1)
  simp only [hcoeff, heven.neg_one_pow, one_mul] at hres
  calc
    f.discr = (-1 : ℤ) ^ (n * (n - 1) / 2) *
        ((n : ℤ) ^ n * (-(A : ℤ)) ^ (n - 1)) := by
      have hsign :
          (-1 : ℤ) ^ (n * (n - 1) / 2) *
              (-1 : ℤ) ^ (n * (n - 1) / 2) = 1 := by
        rw [← pow_add]
        exact (Even.add_self _).neg_one_pow
      calc
        f.discr = 1 * f.discr := by simp
        _ = ((-1 : ℤ) ^ (n * (n - 1) / 2) *
              (-1 : ℤ) ^ (n * (n - 1) / 2)) * f.discr := by
            rw [hsign]
        _ = (-1 : ℤ) ^ (n * (n - 1) / 2) *
              ((-1 : ℤ) ^ (n * (n - 1) / 2) * f.discr) := by ring
        _ = _ := by rw [← hres]
    _ = (-1 : ℤ) ^ (n * (n - 1) / 2 + (n - 1)) *
          (n : ℤ) ^ n * (A : ℤ) ^ (n - 1) := by
      rw [neg_pow (A : ℤ) (n - 1), pow_add]
      ring

/-- The natural absolute value of the displayed polynomial discriminant is
the elementary envelope `n^n A^(n-1)`. -/
theorem natAbs_discr_kummerIntegralPolynomial
    (n A : ℕ) (hn : 0 < n) :
    Int.natAbs (kummerIntegralPolynomial n A).discr =
      kummerPolynomialDiscriminantAbs n A := by
  rw [discr_kummerIntegralPolynomial n A hn]
  simp only [Int.natAbs_mul, Int.natAbs_pow, Int.natAbs_neg,
    Int.natAbs_one, Int.natAbs_natCast, one_pow, one_mul]
  rfl

/-- A prime in the displayed polynomial discriminant divides either the
Kummer degree or the integral parameter. -/
theorem prime_dvd_kummerPolynomialDiscriminantAbs
    {p n A : ℕ} (hp : p.Prime)
    (hdiv : p ∣ kummerPolynomialDiscriminantAbs n A) :
    p ∣ n ∨ p ∣ A := by
  rcases hp.dvd_mul.mp hdiv with hnpart | hApart
  · exact Or.inl (hp.dvd_of_dvd_pow hnpart)
  · exact Or.inr (hp.dvd_of_dvd_pow hApart)

/-- For the rescaled equation `alpha^n = a*c^(n-1)`, every prime in the
displayed polynomial discriminant divides `n*a*c`. -/
theorem prime_dvd_rescaledKummerPolynomialDiscriminantAbs
    {p n a c : ℕ} (hp : p.Prime)
    (hdiv : p ∣
      kummerPolynomialDiscriminantAbs n
        (kummerIntegralParameter n a c)) :
    p ∣ n * a * c := by
  rcases prime_dvd_kummerPolynomialDiscriminantAbs hp hdiv with hn' | hA
  · exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_left hn' a) c
  · rcases hp.dvd_mul.mp hA with ha | hc
    · exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_right ha n) c
    · have hc' : p ∣ c := hp.dvd_of_dvd_pow hc
      exact dvd_mul_of_dvd_right hc' (n * a)

/-! ## Exact tame boundary--different cancellation -/

/-- Normalized truncated-boundary weight at a tame Kummer prime. -/
noncomputable def kummerTameBoundaryWeight (n m : ℕ) : ℝ :=
  (Nat.gcd n m : ℝ) / n

/-- Normalized tame-different weight at the same prime. -/
noncomputable def kummerTameDifferentWeight (n m : ℕ) : ℝ :=
  1 - kummerTameBoundaryWeight n m

/-- Tame ramification does not dilute the conductor coefficient: truncated
boundary plus different is exactly one at every supported prime. -/
theorem kummer_tame_boundary_add_different (n m : ℕ) :
    kummerTameBoundaryWeight n m +
        kummerTameDifferentWeight n m = 1 := by
  simp [kummerTameDifferentWeight]

/-- The logarithmic local budget attached to a tame Kummer prime. -/
noncomputable def kummerTameLocalBudget (n m p : ℕ) : ℝ :=
  (kummerTameBoundaryWeight n m + kummerTameDifferentWeight n m) *
    Real.log p

/-- The complete local budget is exactly `log p`, independently of the
covering degree and of the boundary multiplicity. -/
theorem kummerTameLocalBudget_eq_log (n m p : ℕ) :
    kummerTameLocalBudget n m p = Real.log p := by
  simp [kummerTameLocalBudget, kummer_tame_boundary_add_different]

/-- Sum of the local tame budgets over a finite support. -/
noncomputable def kummerTameGlobalBudget
    (S : Finset ℕ) (n : ℕ) (multiplicity : ℕ → ℕ) : ℝ :=
  ∑ p ∈ S, kummerTameLocalBudget n (multiplicity p) p

/-- Globally, boundary plus tame different is exactly the squarefree prime
mass.  Raising the Kummer degree cannot change its coefficient. -/
theorem kummerTameGlobalBudget_eq_primeLogMass
    (S : Finset ℕ) (n : ℕ) (multiplicity : ℕ → ℕ) :
    kummerTameGlobalBudget S n multiplicity = primeLogMass S := by
  simp [kummerTameGlobalBudget, primeLogMass,
    kummerTameLocalBudget_eq_log]

/-- Abstract coefficient obstruction extracted from the exact tame budget:
on any positive support mass, an attempted uniform replacement by
`alpha * mass` forces `alpha ≥ 1`. -/
theorem tame_budget_forces_coefficient_one
    {mass alpha : ℝ} (hmass : 0 < mass) (hbound : mass ≤ alpha * mass) :
    1 ≤ alpha := by
  nlinarith

end IUTThreeClosures
