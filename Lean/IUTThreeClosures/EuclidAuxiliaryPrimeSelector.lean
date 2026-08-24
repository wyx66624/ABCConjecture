/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# A Euclidean quantitative auxiliary-prime selector

The eventual-open-image route supplies primes above a lower threshold, but the
final IUT estimate also needs control of prime-dependent source terms.  For the
finite-avoidance part there is a completely elementary quantitative selector.

For a lower threshold `B` and a positive forbidden product `N`, let

`A = B! * N + 1`

and choose the least prime factor `ell` of `A`.  Then

* `ell` is prime;
* `B < ell`, since every prime at most `B` divides `B!` and hence cannot divide
  `B! * N + 1`;
* `ell ∤ N`;
* `ell ≤ B! * N + 1`.

Thus one obtains a prime satisfying an arbitrary lower threshold and avoiding
all prime factors of `N`, with an upper bound linear in `N` for fixed `B`.
After taking logarithms, this is only logarithmic growth in `N`.  In the Frey
route, if the genuine large-image theorem is uniform above a fixed threshold
and the remaining local avoidance data have product polynomial in the height,
this selector supplies precisely the quantitative input needed by the
sublinear-height absorption route.

No large-image, reduction, IUT source, or abc theorem is asserted here.
-/

namespace IUTThreeClosures

/-- The Euclidean integer used to select an auxiliary prime. -/
def euclidAuxiliaryNumber (B N : ℕ) : ℕ :=
  B.factorial * N + 1

/-- The least prime factor of `B! * N + 1`. -/
def euclidAuxiliaryPrime (B N : ℕ) : ℕ :=
  (euclidAuxiliaryNumber B N).minFac

/-- The Euclidean integer is strictly larger than one when the forbidden
product is positive. -/
theorem one_lt_euclidAuxiliaryNumber
    {B N : ℕ} (hN : 0 < N) :
    1 < euclidAuxiliaryNumber B N := by
  unfold euclidAuxiliaryNumber
  have hfac : 0 < B.factorial := Nat.factorial_pos B
  have hprod : 0 < B.factorial * N := Nat.mul_pos hfac hN
  omega

/-- The selected auxiliary integer is prime. -/
theorem euclidAuxiliaryPrime_prime
    {B N : ℕ} (hN : 0 < N) :
    Nat.Prime (euclidAuxiliaryPrime B N) := by
  unfold euclidAuxiliaryPrime
  exact Nat.minFac_prime
    (ne_of_gt (one_lt_euclidAuxiliaryNumber hN))

/-- The selected prime divides the Euclidean integer. -/
theorem euclidAuxiliaryPrime_dvd
    {B N : ℕ} (hN : 0 < N) :
    euclidAuxiliaryPrime B N ∣ euclidAuxiliaryNumber B N := by
  unfold euclidAuxiliaryPrime
  exact Nat.minFac_dvd (euclidAuxiliaryNumber B N)

/-- Any prime divisor of `B! * N + 1` is coprime to `N`. -/
theorem prime_dvd_euclidAuxiliaryNumber_not_dvd_right
    {B N ell : ℕ}
    (hell : Nat.Prime ell)
    (hdiv : ell ∣ euclidAuxiliaryNumber B N) :
    ¬ ell ∣ N := by
  intro hNdiv
  have hAmod : euclidAuxiliaryNumber B N % ell = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp hdiv
  have hNmod : N % ell = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp hNdiv
  have hAmod_one : euclidAuxiliaryNumber B N % ell = 1 := by
    unfold euclidAuxiliaryNumber
    simp [Nat.add_mod, Nat.mul_mod, hNmod, hell.one_lt]
  omega

/-- Any prime divisor of `B! * N + 1` is coprime to `B!`. -/
theorem prime_dvd_euclidAuxiliaryNumber_not_dvd_factorial
    {B N ell : ℕ}
    (hell : Nat.Prime ell)
    (hdiv : ell ∣ euclidAuxiliaryNumber B N) :
    ¬ ell ∣ B.factorial := by
  intro hFdiv
  have hAmod : euclidAuxiliaryNumber B N % ell = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp hdiv
  have hFmod : B.factorial % ell = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp hFdiv
  have hAmod_one : euclidAuxiliaryNumber B N % ell = 1 := by
    unfold euclidAuxiliaryNumber
    simp [Nat.add_mod, Nat.mul_mod, hFmod, hell.one_lt]
  omega

/-- The selected auxiliary prime avoids the forbidden product. -/
theorem euclidAuxiliaryPrime_not_dvd
    {B N : ℕ} (hN : 0 < N) :
    ¬ euclidAuxiliaryPrime B N ∣ N :=
  prime_dvd_euclidAuxiliaryNumber_not_dvd_right
    (euclidAuxiliaryPrime_prime hN)
    (euclidAuxiliaryPrime_dvd hN)

/-- The selected auxiliary prime lies strictly above the prescribed threshold. -/
theorem threshold_lt_euclidAuxiliaryPrime
    {B N : ℕ} (hN : 0 < N) :
    B < euclidAuxiliaryPrime B N := by
  let ell := euclidAuxiliaryPrime B N
  have hp : Nat.Prime ell := euclidAuxiliaryPrime_prime hN
  have hnot : ¬ ell ∣ B.factorial :=
    prime_dvd_euclidAuxiliaryNumber_not_dvd_factorial hp
      (euclidAuxiliaryPrime_dvd hN)
  by_contra hle
  have hell_le : ell ≤ B := Nat.le_of_not_gt hle
  have hdiv : ell ∣ B.factorial :=
    Nat.dvd_factorial hp.pos hell_le
  exact hnot hdiv

/-- The selected auxiliary prime has the explicit Euclidean upper bound. -/
theorem euclidAuxiliaryPrime_le
    {B N : ℕ} (hN : 0 < N) :
    euclidAuxiliaryPrime B N ≤ euclidAuxiliaryNumber B N := by
  exact Nat.le_of_dvd
    (Nat.zero_lt_of_lt (one_lt_euclidAuxiliaryNumber hN))
    (euclidAuxiliaryPrime_dvd hN)

/-- Complete quantitative selection theorem. -/
theorem exists_prime_above_not_dvd_le
    (B N : ℕ) (hN : 0 < N) :
    ∃ ell : ℕ,
      Nat.Prime ell ∧
      B < ell ∧
      ¬ ell ∣ N ∧
      ell ≤ B.factorial * N + 1 := by
  refine ⟨euclidAuxiliaryPrime B N,
    euclidAuxiliaryPrime_prime hN,
    threshold_lt_euclidAuxiliaryPrime hN,
    euclidAuxiliaryPrime_not_dvd hN, ?_⟩
  simpa [euclidAuxiliaryNumber] using
    (euclidAuxiliaryPrime_le hN)

end IUTThreeClosures
