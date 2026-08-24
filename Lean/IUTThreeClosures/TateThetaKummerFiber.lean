/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import TateCurvesTheta.Theta.Divisor
import Mathlib.FieldTheory.KummerPolynomial
import Mathlib.FieldTheory.Separable

/-!
# Separable Kummer fibers of the Tate theta product

The local bad-place model in the étale-theta construction is obtained by
extracting an `ell`-th root of the theta function. The pinned
`tate-curves-theta` dependency already proves that the product form
`thetaProd` vanishes exactly on the single `q^ℤ`-orbit of `-1`.

This module constructs the corresponding pointwise Kummer polynomial

`Y^ell - thetaProd(u)`

and proves that, away from that zero orbit, it is monic and separable whenever
`ell` is invertible in the ground field. Consequently every geometric root
is simple. The associated `AdjoinRoot` algebra contains a canonical root with
exact `ell`-th power equal to the theta value.

This is a genuine algebraic ingredient of the local theta-root cover. It does
not yet construct the analytic family on the Tate quotient, the tempered
fundamental group, or the global orbicurve/cartesian package.
-/

namespace IUTThreeClosures

open Polynomial
open TateCurvesTheta

universe u v

variable {K : Type u} [NormedField K]

/-- The pointwise Kummer polynomial obtained by extracting an `ell`-th root of
the Tate theta product at `u`. -/
noncomputable def thetaKummerPolynomial
    (t : TateParameter K) (u : Kˣ) (ell : ℕ) : K[X] :=
  X ^ ell - C (t.thetaProd u)

/-- Away from the distinguished `q^ℤ` zero orbit, the theta product is
nonzero. -/
theorem thetaProd_ne_zero_of_not_zeroOrbit
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k) :
    t.thetaProd u ≠ 0 := by
  intro hzero
  exact hu ((t.thetaProd_eq_zero_iff u).mp hzero)

/-- The theta Kummer polynomial is monic as soon as the exponent is positive. -/
theorem thetaKummerPolynomial_monic
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell) :
    (thetaKummerPolynomial t u ell).Monic := by
  simpa [thetaKummerPolynomial] using
    (monic_X_pow_sub_C (t.thetaProd u) hell.ne')

/-- If `ell` is invertible in the ground field and `u` is away from the theta
zero orbit, then the Kummer polynomial is separable. -/
theorem thetaKummerPolynomial_separable
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) (ell : ℕ)
    (hell : IsUnit (ell : K))
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k) :
    (thetaKummerPolynomial t u ell).Separable := by
  have htheta : t.thetaProd u ≠ 0 :=
    thetaProd_ne_zero_of_not_zeroOrbit t u hu
  let thetaUnit : Kˣ := Units.mk0 (t.thetaProd u) htheta
  simpa [thetaKummerPolynomial, thetaUnit] using
    (separable_X_pow_sub_C_unit thetaUnit hell)

/-- Every geometric root of the theta Kummer polynomial is simple. -/
theorem thetaKummerPolynomial_derivative_ne_zero_at_root
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) (ell : ℕ)
    (hell : IsUnit (ell : K))
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k)
    {L : Type v} [Field L] [Algebra K L]
    (x : L)
    (hx : aeval x (thetaKummerPolynomial t u ell) = 0) :
    aeval x (derivative (thetaKummerPolynomial t u ell)) ≠ 0 :=
  (thetaKummerPolynomial_separable t u ell hell hu).aeval_derivative_ne_zero hx

/-- The pointwise algebra obtained by adjoining an `ell`-th root of the theta
value. -/
abbrev ThetaKummerFiber
    (t : TateParameter K) (u : Kˣ) (ell : ℕ) : Type u :=
  AdjoinRoot (thetaKummerPolynomial t u ell)

/-- The canonical root in the theta Kummer fiber has the prescribed
`ell`-th power. -/
theorem thetaKummerFiber_root_pow
    (t : TateParameter K) (u : Kˣ) (ell : ℕ) :
    (AdjoinRoot.root (thetaKummerPolynomial t u ell)) ^ ell =
      AdjoinRoot.of (thetaKummerPolynomial t u ell) (t.thetaProd u) := by
  change
    (AdjoinRoot.root (X ^ ell - C (t.thetaProd u))) ^ ell =
      AdjoinRoot.of (X ^ ell - C (t.thetaProd u)) (t.thetaProd u)
  exact root_X_pow_sub_C_pow ell (t.thetaProd u)

/-- Away from the zero orbit, the canonical theta root is nonzero whenever the
exponent is positive. -/
theorem thetaKummerFiber_root_ne_zero
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k) :
    AdjoinRoot.root (thetaKummerPolynomial t u ell) ≠ 0 := by
  have htheta : t.thetaProd u ≠ 0 :=
    thetaProd_ne_zero_of_not_zeroOrbit t u hu
  change AdjoinRoot.root (X ^ ell - C (t.thetaProd u)) ≠ 0
  exact root_X_pow_sub_C_ne_zero' hell htheta

end IUTThreeClosures
