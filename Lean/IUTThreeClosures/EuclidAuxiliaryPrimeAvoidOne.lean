/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeAvoidance

/-!
# Avoiding one additional prime by a two-stage Euclidean selector

For the semistable Frey large-image route, one wants an auxiliary prime `ell`
which is above a fixed threshold, does not divide a local Tate/discriminant
order `N`, and is distinct from the residue characteristic `p` at the chosen
multiplicative place.

Putting `p` directly into the avoidance product would introduce a factor whose
logarithm can be as large as the full abc height.  A two-stage Euclidean
construction avoids this loss.

First select a prime factor `ell₁` of

`A₁ = B! * N + 1`.

If `ell₁ ≠ p`, use it.  If `ell₁ = p`, select a prime factor `ell₂` of

`B! * (N * A₁) + 1`.

Then `ell₂` divides neither `N` nor `A₁`; since `p = ell₁` divides `A₁`, one
has `ell₂ ≠ p`.  In both cases

`ell ≤ B! * N * (B! * N + 1) + 1`.

Thus the extra exclusion `ell ≠ p` costs only one more fixed-degree polynomial
in `N`, and `log ell` remains `O(log N)` for fixed `B`.
-/

namespace IUTThreeClosures

/-- Uniform upper bound for the two-stage selector. -/
def euclidAvoidOneBound (B N : ℕ) : ℕ :=
  B.factorial * N * euclidAuxiliaryNumber B N + 1

/-- Two-stage auxiliary-prime selector avoiding one additional prime `p`. -/
def euclidAuxiliaryPrimeAvoidOne (B N p : ℕ) : ℕ :=
  let ell₁ := euclidAuxiliaryPrime B N
  if ell₁ = p then
    euclidAuxiliaryPrime B (N * euclidAuxiliaryNumber B N)
  else
    ell₁

/-- The second-stage avoidance product is positive. -/
theorem secondStageProduct_pos
    {B N : ℕ} (hN : 0 < N) :
    0 < N * euclidAuxiliaryNumber B N := by
  exact Nat.mul_pos hN
    (Nat.zero_lt_of_lt (one_lt_euclidAuxiliaryNumber hN))

/-- The two-stage selector is prime. -/
theorem euclidAuxiliaryPrimeAvoidOne_prime
    {B N p : ℕ} (hN : 0 < N) :
    Nat.Prime (euclidAuxiliaryPrimeAvoidOne B N p) := by
  by_cases hfirst : euclidAuxiliaryPrime B N = p
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_pos]
    exact euclidAuxiliaryPrime_prime
      (secondStageProduct_pos (B := B) hN)
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_neg]
    exact euclidAuxiliaryPrime_prime hN

/-- The two-stage selector remains above the original threshold. -/
theorem threshold_lt_euclidAuxiliaryPrimeAvoidOne
    {B N p : ℕ} (hN : 0 < N) :
    B < euclidAuxiliaryPrimeAvoidOne B N p := by
  by_cases hfirst : euclidAuxiliaryPrime B N = p
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_pos]
    exact threshold_lt_euclidAuxiliaryPrime
      (secondStageProduct_pos (B := B) hN)
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_neg]
    exact threshold_lt_euclidAuxiliaryPrime hN

/-- The two-stage selector avoids the original product `N`. -/
theorem euclidAuxiliaryPrimeAvoidOne_not_dvd
    {B N p : ℕ} (hN : 0 < N) :
    ¬ euclidAuxiliaryPrimeAvoidOne B N p ∣ N := by
  by_cases hfirst : euclidAuxiliaryPrime B N = p
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_pos]
    exact euclidAuxiliaryPrime_not_dvd_of_dvd
      (secondStageProduct_pos (B := B) hN)
      (dvd_mul_right N (euclidAuxiliaryNumber B N))
  · simp only [euclidAuxiliaryPrimeAvoidOne, hfirst, if_neg]
    exact euclidAuxiliaryPrime_not_dvd hN

/-- The selected prime is distinct from the additionally excluded prime. -/
theorem euclidAuxiliaryPrimeAvoidOne_ne
    {B N p : ℕ} (hN : 0 < N) (hp : Nat.Prime p) :
    euclidAuxiliaryPrimeAvoidOne B N p ≠ p := by
  unfold euclidAuxiliaryPrimeAvoidOne
  by_cases hfirst : euclidAuxiliaryPrime B N = p
  · simp only [hfirst, if_pos]
    intro hsecond
    have hp_dvd_A : p ∣ euclidAuxiliaryNumber B N := by
      rw [← hfirst]
      exact euclidAuxiliaryPrime_dvd hN
    have hselected_dvd_A :
        euclidAuxiliaryPrime B
            (N * euclidAuxiliaryNumber B N) ∣
          euclidAuxiliaryNumber B N := by
      simpa [hsecond] using hp_dvd_A
    exact
      (euclidAuxiliaryPrime_not_dvd_of_dvd
        (secondStageProduct_pos hN)
        (dvd_mul_left (euclidAuxiliaryNumber B N) N))
        hselected_dvd_A
  · simpa [hfirst]

/-- The first-stage bound is below the common two-stage bound. -/
theorem euclidAuxiliaryNumber_le_avoidOneBound
    {B N : ℕ} (hN : 0 < N) :
    euclidAuxiliaryNumber B N ≤ euclidAvoidOneBound B N := by
  unfold euclidAuxiliaryNumber euclidAvoidOneBound
  apply Nat.add_le_add_right
  calc
    B.factorial * N = B.factorial * N * 1 := by simp
    _ ≤ B.factorial * N * (B.factorial * N + 1) :=
      Nat.mul_le_mul_left _ (by omega)

/-- Explicit polynomial upper bound for the two-stage selector. -/
theorem euclidAuxiliaryPrimeAvoidOne_le
    {B N p : ℕ} (hN : 0 < N) :
    euclidAuxiliaryPrimeAvoidOne B N p ≤ euclidAvoidOneBound B N := by
  unfold euclidAuxiliaryPrimeAvoidOne
  by_cases hfirst : euclidAuxiliaryPrime B N = p
  · simp only [hfirst, if_pos]
    have hle := euclidAuxiliaryPrime_le
      (B := B) (N := N * euclidAuxiliaryNumber B N)
      (secondStageProduct_pos (B := B) hN)
    simpa [euclidAuxiliaryNumber, euclidAvoidOneBound,
      Nat.mul_assoc] using hle
  · simp only [hfirst, if_neg]
    exact (euclidAuxiliaryPrime_le hN).trans
      (euclidAuxiliaryNumber_le_avoidOneBound hN)

/-- Complete two-stage quantitative selection theorem. -/
theorem exists_prime_above_not_dvd_ne_le
    (B N p : ℕ) (hN : 0 < N) (hp : Nat.Prime p) :
    ∃ ell : ℕ,
      Nat.Prime ell ∧
      B < ell ∧
      ¬ ell ∣ N ∧
      ell ≠ p ∧
      ell ≤ B.factorial * N * (B.factorial * N + 1) + 1 := by
  refine ⟨euclidAuxiliaryPrimeAvoidOne B N p,
    euclidAuxiliaryPrimeAvoidOne_prime hN,
    threshold_lt_euclidAuxiliaryPrimeAvoidOne hN,
    euclidAuxiliaryPrimeAvoidOne_not_dvd hN,
    euclidAuxiliaryPrimeAvoidOne_ne hN hp, ?_⟩
  simpa [euclidAvoidOneBound, euclidAuxiliaryNumber,
    Nat.mul_assoc] using
    (euclidAuxiliaryPrimeAvoidOne_le (B := B) (N := N) (p := p) hN)

end IUTThreeClosures
