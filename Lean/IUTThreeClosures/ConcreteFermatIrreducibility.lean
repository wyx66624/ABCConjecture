/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Polynomial.FieldDivision
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Polynomial.Eisenstein.Basic

/-!
# Irreducibility of the affine Fermat equation

For a characteristic-zero field `K` and `n > 0`, this module applies
Eisenstein's criterion at `X - 1` to

`Y^n - (1 - X^n) ∈ K[X][Y]`.

It follows that the affine Fermat coordinate ring before boundary
localization is an integral domain.  This is the connectedness input behind
the explicit tripod Kummer cover; identifying this presentation with the
existing iterated Kummer algebra and treating projective compactification are
separate steps.
-/

namespace IUTThreeClosures
namespace ConcreteFermatIrreducibility

noncomputable section

open Polynomial

universe u

variable (K : Type u) [Field K]

/-- The coefficient `1 - X^n` in the Fermat equation. -/
def boundaryPolynomial (n : ℕ) : K[X] :=
  1 - X ^ n

/-- The affine Fermat equation, viewed as a polynomial in `Y` over `K[X]`. -/
def fermatPolynomial (n : ℕ) : K[X][X] :=
  X ^ n - C (boundaryPolynomial K n)

/-- The prime ideal at `X = 1` used in the Eisenstein argument. -/
def onePrime : Ideal K[X] :=
  Ideal.span ({X - C (1 : K)} : Set K[X])

theorem onePrime_isPrime : (onePrime K).IsPrime := by
  exact Ideal.isPrime_span_singleton_of_prime (prime_X_sub_C (1 : K))

/-- `X - 1` divides `1 - X^n`. -/
theorem boundaryPolynomial_mem_onePrime (n : ℕ) :
    boundaryPolynomial K n ∈ onePrime K := by
  rw [onePrime, Ideal.mem_span_singleton]
  rw [dvd_iff_isRoot]
  simp [boundaryPolynomial, IsRoot]

/-- In characteristic zero the root `X = 1` of `1 - X^n` is simple. -/
theorem boundaryPolynomial_not_mem_onePrime_sq
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    boundaryPolynomial K n ∉ (onePrime K) ^ 2 := by
  intro hmem
  rw [onePrime, Ideal.span_singleton_pow,
    Ideal.mem_span_singleton] at hmem
  have hderiv :
      X - C (1 : K) ∣ derivative (boundaryPolynomial K n) := by
    have h := pow_sub_one_dvd_derivative_of_pow_dvd hmem
    simpa using h
  have hroot := dvd_iff_isRoot.mp hderiv
  have hnzero : (n : K) = 0 := by
    rw [boundaryPolynomial, derivative_sub, derivative_one,
      derivative_X_pow] at hroot
    simpa [IsRoot] using hroot
  exact (Nat.cast_ne_zero.mpr (Nat.ne_of_gt hn)) hnzero

/-- Eisenstein at `X - 1` proves irreducibility of the affine Fermat
polynomial over `K[X]`. -/
theorem fermatPolynomial_irreducible
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    Irreducible (fermatPolynomial K n) := by
  let P : Ideal K[X] := onePrime K
  have hP : P.IsPrime := onePrime_isPrime K
  have hmonic : (fermatPolynomial K n).Monic := by
    exact monic_X_pow_sub_C _ (Nat.ne_of_gt hn)
  have heisenstein : (fermatPolynomial K n).IsEisensteinAt P := by
    refine hmonic.isEisensteinAt_of_mem_of_notMem hP.ne_top ?_ ?_
    · intro i hi
      rw [fermatPolynomial, natDegree_X_pow_sub_C] at hi
      by_cases hi0 : i = 0
      · subst i
        have hn0 : (0 : ℕ) ≠ n := Nat.ne_of_lt hn
        have hb : boundaryPolynomial K n ∈ P := by
          simpa [P] using boundaryPolynomial_mem_onePrime K n
        simpa [fermatPolynomial, hn0] using P.neg_mem hb
      · have hin : i ≠ n := Nat.ne_of_lt hi
        simp only [fermatPolynomial, coeff_sub, coeff_X_pow, if_neg hin]
        rw [coeff_C_of_ne_zero hi0]
        simpa only [sub_zero] using P.zero_mem
    · have hnot := boundaryPolynomial_not_mem_onePrime_sq K hn
      change (fermatPolynomial K n).coeff 0 ∉ P ^ 2
      intro hcoeff
      apply hnot
      have hneg : -(boundaryPolynomial K n) ∈ P ^ 2 := by
        have hn0 : (0 : ℕ) ≠ n := Nat.ne_of_lt hn
        simpa [fermatPolynomial, hn0] using hcoeff
      simpa using (P ^ 2).neg_mem hneg
  exact heisenstein.irreducible hP hmonic.isPrimitive (by
    rw [fermatPolynomial, natDegree_X_pow_sub_C]
    exact hn)

/-- The affine Fermat coordinate ring before inverting the boundary. -/
abbrev FermatAffineRing (n : ℕ) :=
  AdjoinRoot (fermatPolynomial K n)

/-- The affine Fermat coordinate ring is an integral domain. -/
noncomputable instance fermatAffineRing_isDomain
    [CharZero K] {n : ℕ} [NeZero n] :
    IsDomain (FermatAffineRing K n) := by
  apply AdjoinRoot.isDomain_of_prime
  exact (fermatPolynomial_irreducible K (Nat.pos_of_ne_zero (NeZero.ne n))).prime

end
end ConcreteFermatIrreducibility
end IUTThreeClosures
