/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LegendreLocalInertiaLargeImage

/-!
# Euclid selection of a bounded prime for two local inertia directions

Fix a lower threshold `B` and positive local inertia exponents `m₁`, `m₂`.
Set

`M = B! * (m₁*m₂) + 1`

and let `ell` be the least prime factor of `M`.  Since a prime at most `B`
divides `B!`, no prime divisor of `M` can be at most `B`.  Likewise no prime
divisor of `M` divides `m₁*m₂`.  Thus

`B < ell`, `ell ∤ m₁*m₂`, and
`ell ≤ B! * (m₁*m₂) + 1`.

If the two Picard--Lefschetz inertia matrices exist uniformly for primes above
`B`, the selected prime gives two nonzero transvections and hence full `SL₂`
image by the preceding theorem.

This route avoids estimating a complete Serre exceptional set.  Its remaining
arithmetic input is the genuine two-place local inertia formula and an upper
bound for the two local exponents.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2
open LegendreTwoInertia
open LegendreLocalInertia

namespace TwoInertiaEuclidPrime

/-- A divisor of `a` cannot also divide `a+1` when it is larger than one. -/
theorem not_dvd_add_one_of_dvd
    {p a : ℕ} (hp : 1 < p) (ha : p ∣ a) :
    ¬ p ∣ a + 1 := by
  intro hsucc
  have ha0 : a % p = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp ha
  have hsucc0 : (a + 1) % p = 0 :=
    Nat.dvd_iff_mod_eq_zero.mp hsucc
  have hone : 1 % p = 1 :=
    Nat.mod_eq_of_lt hp
  rw [Nat.add_mod, ha0, hone] at hsucc0
  simp at hsucc0

/-- **Euclid bounded avoidance selector.** -/
theorem exists_prime_above_not_dvd_le_factorial_mul_add_one
    (B N : ℕ) (hN : 0 < N) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      ¬ ell ∣ N ∧
      ell ≤ B.factorial * N + 1 := by
  let M : ℕ := B.factorial * N + 1
  have hfactorial : 0 < B.factorial := Nat.factorial_pos B
  have hproduct : 0 < B.factorial * N :=
    Nat.mul_pos hfactorial hN
  have hMone : 1 < M := by
    dsimp [M]
    omega
  let ell : ℕ := M.minFac
  have hell : ell.Prime := by
    dsimp [ell]
    exact Nat.minFac_prime (by omega)
  have helldiv : ell ∣ M := by
    dsimp [ell]
    exact Nat.minFac_dvd M
  have hellabove : B < ell := by
    by_contra hnot
    have hellB : ell ≤ B := Nat.le_of_not_gt hnot
    have hellFact : ell ∣ B.factorial :=
      Nat.dvd_factorial hell.pos hellB
    have hellProd : ell ∣ B.factorial * N :=
      dvd_mul_of_dvd_left hellFact N
    have hnotDiv : ¬ ell ∣ B.factorial * N + 1 :=
      not_dvd_add_one_of_dvd hell.one_lt hellProd
    exact hnotDiv (by simpa [M] using helldiv)
  have hellAvoid : ¬ ell ∣ N := by
    intro hellN
    have hellProd : ell ∣ B.factorial * N :=
      dvd_mul_of_dvd_right hellN B.factorial
    have hnotDiv : ¬ ell ∣ B.factorial * N + 1 :=
      not_dvd_add_one_of_dvd hell.one_lt hellProd
    exact hnotDiv (by simpa [M] using helldiv)
  have hellBound : ell ≤ B.factorial * N + 1 := by
    have hMpos : 0 < M := by omega
    have := Nat.le_of_dvd hMpos helldiv
    simpa [M] using this
  exact ⟨ell, hell, hellabove, hellAvoid, hellBound⟩

/-- Uniform two-direction local inertia data above a fixed lower threshold. -/
structure UniformTwoInertiaAbove
    (B exponent₁ exponent₂ : ℕ) where
  image : ∀ ell : ℕ,
    MultiplicativeCarrier (Matrix2 (ZMod ell))
  direction₁ : BoundaryDirection
  direction₂ : BoundaryDirection
  directions_ne : direction₁ ≠ direction₂
  inertia₁ :
    ∀ ell : ℕ, ell.Prime → B < ell →
      boundaryTransvection direction₁
          (exponent₁ : ZMod ell) ∈
        (image ell).carrier
  inertia₂ :
    ∀ ell : ℕ, ell.Prime → B < ell →
      boundaryTransvection direction₂
          (exponent₂ : ZMod ell) ∈
        (image ell).carrier

namespace UniformTwoInertiaAbove

/-- Package the uniform source data as the two-inertia structure at one
selected prime. -/
def atPrime
    {B exponent₁ exponent₂ ell : ℕ}
    (D : UniformTwoInertiaAbove B exponent₁ exponent₂)
    (hell : ell.Prime) (hBell : B < ell) :
    TwoInertiaData ell (D.image ell) where
  direction₁ := D.direction₁
  direction₂ := D.direction₂
  directions_ne := D.directions_ne
  exponent₁ := exponent₁
  exponent₂ := exponent₂
  inertia₁ := D.inertia₁ ell hell hBell
  inertia₂ := D.inertia₂ ell hell hBell

/-- **Explicitly bounded full-`SL₂` prime from two local inertia places.** -/
theorem exists_bounded_full_SL2_prime
    {B exponent₁ exponent₂ : ℕ}
    (h₁ : 0 < exponent₁)
    (h₂ : 0 < exponent₂)
    (D : UniformTwoInertiaAbove B exponent₁ exponent₂) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      ell ≤ B.factorial * (exponent₁ * exponent₂) + 1 ∧
      (∀ A : Matrix2 (ZMod ell),
        det A = 1 → A ∈ (D.image ell).carrier) := by
  have hproduct : 0 < exponent₁ * exponent₂ :=
    Nat.mul_pos h₁ h₂
  rcases
      exists_prime_above_not_dvd_le_factorial_mul_add_one
        B (exponent₁ * exponent₂) hproduct with
    ⟨ell, hell, hBell, hAvoid, hBound⟩
  refine ⟨ell, hell, hBell, hBound, ?_⟩
  exact
    (D.atPrime hell hBell).
      full_SL2_of_prime_not_dvd_exponent_product
        hell (D.image ell) hAvoid

/-- Logarithmic upper bound for the selected prime. -/
theorem exists_bounded_full_SL2_prime_log
    {B exponent₁ exponent₂ : ℕ}
    (h₁ : 0 < exponent₁)
    (h₂ : 0 < exponent₂)
    (D : UniformTwoInertiaAbove B exponent₁ exponent₂) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      Real.log ell ≤
        Real.log
          (B.factorial * (exponent₁ * exponent₂) + 1) ∧
      (∀ A : Matrix2 (ZMod ell),
        det A = 1 → A ∈ (D.image ell).carrier) := by
  rcases D.exists_bounded_full_SL2_prime h₁ h₂ with
    ⟨ell, hell, hBell, hBound, hfull⟩
  refine ⟨ell, hell, hBell, ?_, hfull⟩
  have hellpos : (0 : ℝ) < ell := by
    exact_mod_cast hell.pos
  have hBoundReal :
      (ell : ℝ) ≤
        B.factorial * (exponent₁ * exponent₂) + 1 := by
    exact_mod_cast hBound
  exact Real.log_le_log hellpos hBoundReal

end UniformTwoInertiaAbove

end TwoInertiaEuclidPrime

end IUTThreeClosures
