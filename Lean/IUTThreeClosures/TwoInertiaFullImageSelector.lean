/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaPrimeSelector

/-!
# From two local inertia directions to an explicitly bounded full image prime

The prime selected from `B!*(m₁*m₂)+1` avoids both exponents. Their casts in
`ZMod ell` are therefore nonzero. If the actual mod-`ell` image contains the
two corresponding Legendre boundary transvections, the finite-group theorem
forces containment of every determinant-one matrix.

This module performs the complete finite and elementary arithmetic passage.
The remaining source theorem is purely local/Galois: construct the two image
matrices in one common Tate-torsion basis.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2
open LegendreTwoInertia

/-- The three Legendre boundary monodromy directions. -/
inductive LegendreInertiaDirection where
  | upper
  | lower
  | third
  deriving DecidableEq, Fintype

namespace LegendreInertiaDirection

/-- The concrete transvection associated to one direction and one parameter. -/
def matrix
    (p : ℕ) : LegendreInertiaDirection → ZMod p → Matrix2 (ZMod p)
  | upper, x => Matrix2.upper x
  | lower, x => Matrix2.lower x
  | third, x => LegendreTwoInertia.third x

end LegendreInertiaDirection

/-- Nondivisibility by the characteristic gives a nonzero prime-field cast. -/
theorem zmod_natCast_ne_zero_of_not_dvd
    (p m : ℕ) [Fact p.Prime]
    (h : ¬ p ∣ m) :
    (m : ZMod p) ≠ 0 := by
  intro hm
  apply h
  exact (CharP.cast_eq_zero (ZMod p) p m).mp hm

/-- Any two distinct nonzero Legendre inertia directions force full
`SL₂(ZMod p)`. -/
theorem full_of_two_distinct_directions
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    (d₁ d₂ : LegendreInertiaDirection)
    (hd : d₁ ≠ d₂)
    (x₁ x₂ : ZMod p)
    (hx₁ : x₁ ≠ 0) (hx₂ : x₂ ≠ 0)
    (h₁ : d₁.matrix p x₁ ∈ C.carrier)
    (h₂ : d₂.matrix p x₂ ∈ C.carrier) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  cases d₁ <;> cases d₂
  · exact (hd rfl).elim
  · exact full_of_upper_lower p C hx₁ hx₂ h₁ h₂
  · exact full_of_upper_third p C hx₁ hx₂ h₁ h₂
  · exact full_of_upper_lower p C hx₂ hx₁ h₂ h₁
  · exact (hd rfl).elim
  · exact full_of_lower_third p C hx₁ hx₂ h₁ h₂
  · exact full_of_upper_third p C hx₂ hx₁ h₂ h₁
  · exact full_of_lower_third p C hx₂ hx₁ h₂ h₁
  · exact (hd rfl).elim

/-- Actual image data at the selected prime, reduced to two explicit local
transvection witnesses. -/
structure TwoDirectionImageData
    (p m₁ m₂ : ℕ)
    (d₁ d₂ : LegendreInertiaDirection) [Fact p.Prime] where
  carrier : MultiplicativeCarrier (Matrix2 (ZMod p))
  directions_ne : d₁ ≠ d₂
  first_mem :
    d₁.matrix p (m₁ : ZMod p) ∈ carrier.carrier
  second_mem :
    d₂.matrix p (m₂ : ZMod p) ∈ carrier.carrier

namespace TwoDirectionImageData

/-- Avoiding both local exponents upgrades the two local witnesses to full
`SL₂` image. -/
theorem full_image_of_avoids
    {p m₁ m₂ : ℕ}
    {d₁ d₂ : LegendreInertiaDirection}
    [Fact p.Prime]
    (I : TwoDirectionImageData p m₁ m₂ d₁ d₂)
    (hp₁ : ¬ p ∣ m₁)
    (hp₂ : ¬ p ∣ m₂) :
    ∀ A : Matrix2 (ZMod p), det A = 1 →
      A ∈ I.carrier.carrier := by
  exact full_of_two_distinct_directions
    p I.carrier d₁ d₂ I.directions_ne
      (m₁ : ZMod p) (m₂ : ZMod p)
      (zmod_natCast_ne_zero_of_not_dvd p m₁ hp₁)
      (zmod_natCast_ne_zero_of_not_dvd p m₂ hp₂)
      I.first_mem I.second_mem

end TwoDirectionImageData

/-- A selected prime together with its two actual inertia witnesses. -/
structure SelectedTwoInertiaFullImageData
    (B m₁ m₂ : ℕ)
    (d₁ d₂ : LegendreInertiaDirection) where
  primeData : TwoInertiaPrimeData B m₁ m₂
  imageData :
    letI : Fact primeData.ell.Prime := ⟨primeData.ell_prime⟩
    TwoDirectionImageData primeData.ell m₁ m₂ d₁ d₂

namespace SelectedTwoInertiaFullImageData

/-- The selected prime has full determinant-one image. -/
theorem full_image
    {B m₁ m₂ : ℕ}
    {d₁ d₂ : LegendreInertiaDirection}
    (D : SelectedTwoInertiaFullImageData B m₁ m₂ d₁ d₂) :
    letI : Fact D.primeData.ell.Prime := ⟨D.primeData.ell_prime⟩
    ∀ A : Matrix2 (ZMod D.primeData.ell), det A = 1 →
      A ∈ D.imageData.carrier.carrier := by
  letI : Fact D.primeData.ell.Prime := ⟨D.primeData.ell_prime⟩
  exact D.imageData.full_image_of_avoids
    D.primeData.avoids_first D.primeData.avoids_second

/-- The same prime retains the explicit Euclidean upper bound. -/
theorem explicit_upper_bound
    {B m₁ m₂ : ℕ}
    {d₁ d₂ : LegendreInertiaDirection}
    (D : SelectedTwoInertiaFullImageData B m₁ m₂ d₁ d₂) :
    D.primeData.ell ≤ B.factorial * (m₁ * m₂) + 1 :=
  D.primeData.explicit_upper_bound

end SelectedTwoInertiaFullImageData

end IUTThreeClosures
