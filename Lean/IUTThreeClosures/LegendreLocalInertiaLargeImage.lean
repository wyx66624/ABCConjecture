/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LegendreTwoInertiaSL2

/-!
# Two nondivisible Legendre inertia exponents force full `SL₂`

For a semistable elliptic curve, the Picard--Lefschetz/Tate inertia parameter
at a multiplicative place is an integer valuation or component-group order.
Modulo an auxiliary prime `ell`, the local transvection is nontrivial exactly
when `ell` does not divide that integer.

This module connects those arithmetic integers to the two-direction finite
matrix theorem.  Given two distinct Legendre boundary directions and two
actual image elements whose parameters are the natural casts of local
exponents `m₁`, `m₂`, every prime avoiding `m₁*m₂` gives two nonzero
transvections and hence full `SL₂` image.

The genuine arithmetic source theorem still has to identify the local Galois
inertia matrices with these Picard--Lefschetz forms in one common basis.  No
such formula is assumed as a large-image conclusion here.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2
open LegendreTwoInertia

namespace LegendreLocalInertia

/-- A natural integer has nonzero image in `ZMod ell` when `ell` does not
divide it. -/
theorem natCast_ne_zero_of_prime_not_dvd
    {ell m : ℕ} (hell : ell.Prime)
    (hnot : ¬ ell ∣ m) :
    (m : ZMod ell) ≠ 0 := by
  intro hzero
  have hmod : m % ell = 0 := by
    have hval := congrArg ZMod.val hzero
    simpa [hell.ne_zero] using hval
  exact hnot (Nat.dvd_iff_mod_eq_zero.mpr hmod)

/-- Avoiding a product avoids each factor. -/
theorem not_dvd_left_of_not_dvd_mul
    {ell m n : ℕ} (h : ¬ ell ∣ m * n) :
    ¬ ell ∣ m := by
  intro hm
  exact h (dvd_mul_of_dvd_left hm n)

/-- Avoiding a product avoids the right factor. -/
theorem not_dvd_right_of_not_dvd_mul
    {ell m n : ℕ} (h : ¬ ell ∣ m * n) :
    ¬ ell ∣ n := by
  intro hn
  exact h (dvd_mul_of_dvd_right hn m)

/-- Two local Picard--Lefschetz inertia matrices in one common basis. -/
structure TwoInertiaData
    (ell : ℕ)
    (C : MultiplicativeCarrier (Matrix2 (ZMod ell))) where
  direction₁ : BoundaryDirection
  direction₂ : BoundaryDirection
  directions_ne : direction₁ ≠ direction₂
  exponent₁ : ℕ
  exponent₂ : ℕ
  inertia₁ :
    boundaryTransvection direction₁ (exponent₁ : ZMod ell) ∈
      C.carrier
  inertia₂ :
    boundaryTransvection direction₂ (exponent₂ : ZMod ell) ∈
      C.carrier

namespace TwoInertiaData

/-- A prime avoiding the two local exponents has full `SL₂` image. -/
theorem full_SL2_of_prime_not_dvd_exponent_product
    {ell : ℕ}
    (hell : ell.Prime)
    (C : MultiplicativeCarrier (Matrix2 (ZMod ell)))
    (D : TwoInertiaData ell C)
    (havoid : ¬ ell ∣ D.exponent₁ * D.exponent₂) :
    ∀ A : Matrix2 (ZMod ell),
      det A = 1 → A ∈ C.carrier := by
  letI : Fact ell.Prime := ⟨hell⟩
  have h₁not : ¬ ell ∣ D.exponent₁ :=
    not_dvd_left_of_not_dvd_mul havoid
  have h₂not : ¬ ell ∣ D.exponent₂ :=
    not_dvd_right_of_not_dvd_mul havoid
  have h₁ : (D.exponent₁ : ZMod ell) ≠ 0 :=
    natCast_ne_zero_of_prime_not_dvd hell h₁not
  have h₂ : (D.exponent₂ : ZMod ell) ≠ 0 :=
    natCast_ne_zero_of_prime_not_dvd hell h₂not
  exact full_SL2_of_two_boundary_directions
    ell C D.direction₁ D.direction₂ D.directions_ne
      h₁ h₂ D.inertia₁ D.inertia₂

/-- Expanded existential form convenient for a prime-selection theorem. -/
theorem exists_full_SL2_image_at_prime
    {ell : ℕ}
    (hell : ell.Prime)
    (C : MultiplicativeCarrier (Matrix2 (ZMod ell)))
    (D : TwoInertiaData ell C)
    (havoid : ¬ ell ∣ D.exponent₁ * D.exponent₂) :
    ∃ image : MultiplicativeCarrier (Matrix2 (ZMod ell)),
      image = C ∧
      ∀ A : Matrix2 (ZMod ell),
        det A = 1 → A ∈ image.carrier := by
  refine ⟨C, rfl, ?_⟩
  exact D.full_SL2_of_prime_not_dvd_exponent_product
    hell C havoid

end TwoInertiaData

/-- Point-dependent family form.  A prime selector only has to avoid the
product of the two local inertia exponents. -/
structure TwoInertiaFamily (Input : Type*) where
  exponent₁ : Input → ℕ
  exponent₂ : Input → ℕ
  image : ∀ P : Input, ∀ ell : ℕ,
    MultiplicativeCarrier (Matrix2 (ZMod ell))
  data :
    ∀ P : Input, ∀ ell : ℕ,
      TwoInertiaData ell (image P ell)

namespace TwoInertiaFamily

/-- Every selected prime avoiding the point-dependent product has full
`SL₂` image. -/
theorem full_SL2_at_selected_prime
    {Input : Type*}
    (F : TwoInertiaFamily Input)
    (P : Input) (ell : ℕ)
    (hell : ell.Prime)
    (havoid :
      ¬ ell ∣ F.exponent₁ P * F.exponent₂ P) :
    ∀ A : Matrix2 (ZMod ell),
      det A = 1 → A ∈ (F.image P ell).carrier := by
  exact (F.data P ell).full_SL2_of_prime_not_dvd_exponent_product
    hell (F.image P ell) havoid

end TwoInertiaFamily

end LegendreLocalInertia

end IUTThreeClosures
