/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The Kummer monomial transvection formula

Let `zeta` and `r` lie in a commutative multiplicative group, and let `sigma`
be an automorphism satisfying

`sigma(zeta) = zeta`,
`sigma(r) = zeta^m * r`.

Then on every Kummer monomial one has

`sigma(zeta^i * r^j) = zeta^(i + m*j) * r^j`.

Thus, after reducing the two exponents modulo `ell`, the coordinate action is
the upper transvection `(i,j) |-> (i + m*j,j)`.
-/

namespace IUTThreeClosures

/-- The Kummer monomial formula for natural exponents. -/
theorem kummer_monomial_map
    {G : Type*} [CommGroup G]
    (σ : G ≃* G)
    (ζ r : G) (m : ℕ)
    (hζ : σ ζ = ζ)
    (hr : σ r = ζ ^ m * r)
    (i j : ℕ) :
    σ (ζ ^ i * r ^ j) = ζ ^ (i + m * j) * r ^ j := by
  calc
    σ (ζ ^ i * r ^ j) = σ (ζ ^ i) * σ (r ^ j) := map_mul σ _ _
    _ = ζ ^ i * (ζ ^ m * r) ^ j := by rw [map_pow, map_pow, hζ, hr]
    _ = ζ ^ i * ((ζ ^ m) ^ j * r ^ j) := by rw [mul_pow]
    _ = ζ ^ i * (ζ ^ (m * j) * r ^ j) := by rw [pow_mul]
    _ = ζ ^ (i + m * j) * r ^ j := by rw [← mul_assoc, ← pow_add]

/-- The induced transvection on exponent coordinates modulo `ell`. -/
def kummerCoordinateTransvection
    (ell : ℕ) (m : ZMod ell) :
    ZMod ell × ZMod ell → ZMod ell × ZMod ell :=
  fun x => (x.1 + m * x.2, x.2)

/-- Replacing `m` with `-m` gives a left inverse. -/
theorem kummerCoordinateTransvection_neg_leftInverse
    (ell : ℕ) (m : ZMod ell) :
    Function.LeftInverse
      (kummerCoordinateTransvection ell (-m))
      (kummerCoordinateTransvection ell m) := by
  intro x
  apply Prod.ext
  · dsimp [kummerCoordinateTransvection]
    ring
  · rfl

/-- Replacing `m` with `-m` gives a right inverse. -/
theorem kummerCoordinateTransvection_neg_rightInverse
    (ell : ℕ) (m : ZMod ell) :
    Function.RightInverse
      (kummerCoordinateTransvection ell (-m))
      (kummerCoordinateTransvection ell m) := by
  intro x
  apply Prod.ext
  · dsimp [kummerCoordinateTransvection]
    ring
  · rfl

/-- The Kummer coordinate transvection is a genuine permutation. -/
def kummerCoordinateEquiv
    (ell : ℕ) (m : ZMod ell) :
    (ZMod ell × ZMod ell) ≃ (ZMod ell × ZMod ell) where
  toFun := kummerCoordinateTransvection ell m
  invFun := kummerCoordinateTransvection ell (-m)
  left_inv := kummerCoordinateTransvection_neg_leftInverse ell m
  right_inv := kummerCoordinateTransvection_neg_rightInverse ell m

/-- A nonzero Kummer parameter gives a nontrivial transvection. -/
theorem kummerCoordinateTransvection_ne_id
    (ell : ℕ) (m : ZMod ell) (hm : m ≠ 0) :
    kummerCoordinateTransvection ell m ≠ id := by
  intro h
  have hpoint := congrFun h ((0 : ZMod ell), (1 : ZMod ell))
  have hfirst := congrArg Prod.fst hpoint
  have hmzero : m = 0 := by
    simpa [kummerCoordinateTransvection] using hfirst
  exact hm hmzero

/-- The second coordinate, i.e. the quotient direction, is fixed. -/
theorem kummerCoordinateTransvection_snd
    (ell : ℕ) (m : ZMod ell)
    (x : ZMod ell × ZMod ell) :
    (kummerCoordinateTransvection ell m x).2 = x.2 :=
  rfl

/-- The first coordinate changes by the bilinear Kummer term. -/
theorem kummerCoordinateTransvection_fst
    (ell : ℕ) (m : ZMod ell)
    (x : ZMod ell × ZMod ell) :
    (kummerCoordinateTransvection ell m x).1 = x.1 + m * x.2 :=
  rfl

end IUTThreeClosures
