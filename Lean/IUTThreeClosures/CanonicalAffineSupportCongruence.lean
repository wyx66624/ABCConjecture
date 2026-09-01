/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalPowerfulResidualCore
import IUTThreeClosures.AffineResidualParametrization
import Mathlib.Tactic

/-!
# Support saturation as congruences on the affine residual parameter

Let `R*x + S*y = 1` and

`A = -m*x + t*S`, `B = m*y + t*R`.

If a divisor is shared by `A` and `R`, it divides `t-m*x*y`.  If a divisor is
shared by `B` and `S`, it divides `t+m*x*y`.  For the canonical abc
factorization, support saturation therefore gives

`rad(R) | t-m*x*y`, `rad(S) | t+m*x*y`.

Because the two radicals are coprime, their product divides
`t^2-(m*x*y)^2`.  This is the first direct use of modulus--residual shared
prime support in the affine parameter.  The result controls support, not the
higher prime exponents of the moduli, and does not assert an abc estimate.
-/

namespace IUTThreeClosures
namespace CanonicalAffineSupportCongruence

open AffineResidualParametrization

/-- Exact identity behind the left support congruence. -/
theorem leftParameterShift_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    t - m * x * y =
      y * residualA m S x t + t * R * x := by
  unfold residualA
  calc
    t - m * x * y = t * (R * x + S * y) - m * x * y := by
      rw [hbezout]
      ring
    _ = y * (-m * x + t * S) + t * R * x := by ring

/-- Exact identity behind the right support congruence. -/
theorem rightParameterShift_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    t + m * x * y =
      x * residualB m R y t + t * S * y := by
  unfold residualB
  calc
    t + m * x * y = t * (R * x + S * y) + m * x * y := by
      rw [hbezout]
      ring
    _ = x * (m * y + t * R) + t * S * y := by ring

/-- Every common divisor of the left residual and the left modulus divides the
negative affine parameter shift. -/
theorem commonDivisor_left_dvd_parameterShift
    {R S m x y t d : ℤ}
    (hbezout : R * x + S * y = 1)
    (hresidual : d ∣ residualA m S x t)
    (hmodulus : d ∣ R) :
    d ∣ t - m * x * y := by
  rw [leftParameterShift_identity hbezout]
  exact dvd_add
    (dvd_mul_of_dvd_right hresidual y)
    (dvd_mul_of_dvd_left
      (dvd_mul_of_dvd_right hmodulus t) x)

/-- Every common divisor of the right residual and the right modulus divides
the positive affine parameter shift. -/
theorem commonDivisor_right_dvd_parameterShift
    {R S m x y t d : ℤ}
    (hbezout : R * x + S * y = 1)
    (hresidual : d ∣ residualB m R y t)
    (hmodulus : d ∣ S) :
    d ∣ t + m * x * y := by
  rw [rightParameterShift_identity hbezout]
  exact dvd_add
    (dvd_mul_of_dvd_right hresidual x)
    (dvd_mul_of_dvd_left
      (dvd_mul_of_dvd_right hmodulus t) y)

/-- The same statement for an arbitrary solution of `S*B-R*A=m`, with its
canonical affine parameter `t=y*A+x*B`. -/
theorem solution_leftSupport_dvd_parameterShift
    {R S A B m x y d : ℤ}
    (hbezout : R * x + S * y = 1)
    (hgap : S * B - R * A = m)
    (hresidual : d ∣ A)
    (hmodulus : d ∣ R) :
    d ∣ (y * A + x * B) - m * x * y := by
  have hrecover := residualA_recover hbezout hgap
  have hresidual' :
      d ∣ residualA m S x (y * A + x * B) := by
    rw [← hrecover]
    exact hresidual
  exact commonDivisor_left_dvd_parameterShift
    hbezout hresidual' hmodulus

/-- Right-hand analogue for an arbitrary residual solution. -/
theorem solution_rightSupport_dvd_parameterShift
    {R S A B m x y d : ℤ}
    (hbezout : R * x + S * y = 1)
    (hgap : S * B - R * A = m)
    (hresidual : d ∣ B)
    (hmodulus : d ∣ S) :
    d ∣ (y * A + x * B) + m * x * y := by
  have hrecover := residualB_recover hbezout hgap
  have hresidual' :
      d ∣ residualB m R y (y * A + x * B) := by
    rw [← hrecover]
    exact hresidual
  exact commonDivisor_right_dvd_parameterShift
    hbezout hresidual' hmodulus

/-- Coprime divisors of the two opposite shifts divide the difference of
squares. -/
theorem coprimeProduct_dvd_parameterSquare_sub
    {dR dS t mu : ℤ}
    (hcoprime : IsCoprime dR dS)
    (hleft : dR ∣ t - mu)
    (hright : dS ∣ t + mu) :
    dR * dS ∣ t ^ 2 - mu ^ 2 := by
  have hleftProduct : dR ∣ (t - mu) * (t + mu) :=
    dvd_mul_of_dvd_left hleft (t + mu)
  have hrightProduct : dS ∣ (t - mu) * (t + mu) :=
    dvd_mul_of_dvd_right hright (t - mu)
  have hproduct : dR * dS ∣ (t - mu) * (t + mu) :=
    hcoprime.mul_dvd hleftProduct hrightProduct
  convert hproduct using 1 <;> ring

/-- Canonical support saturation gives opposite congruence classes for the
unique affine parameter of every primitive abc point. -/
theorem canonical_support_parameter_congruences
    (P : ABCPoint) {x y : ℤ}
    (hbezout :
      (P.canonicalLargePowerfulModulus : ℤ) * x +
          (P.canonicalSumPowerfulModulus : ℤ) * y = 1) :
    ((abcRadical P.canonicalLargePowerfulModulus : ℕ) : ℤ) ∣
        (y * (P.canonicalLargeRadicalResidual : ℤ) +
            x * (P.canonicalSumRadicalResidual : ℤ)) -
          (P.endpointMin : ℤ) * x * y ∧
      ((abcRadical P.canonicalSumPowerfulModulus : ℕ) : ℤ) ∣
        (y * (P.canonicalLargeRadicalResidual : ℤ) +
            x * (P.canonicalSumRadicalResidual : ℤ)) +
          (P.endpointMin : ℤ) * x * y := by
  have hleftResidual :
      ((abcRadical P.canonicalLargePowerfulModulus : ℕ) : ℤ) ∣
        (P.canonicalLargeRadicalResidual : ℤ) := by
    exact_mod_cast P.radical_canonicalLargeModulus_dvd_residual
  have hrightResidual :
      ((abcRadical P.canonicalSumPowerfulModulus : ℕ) : ℤ) ∣
        (P.canonicalSumRadicalResidual : ℤ) := by
    exact_mod_cast P.radical_canonicalSumModulus_dvd_residual
  have hleftModulus :
      ((abcRadical P.canonicalLargePowerfulModulus : ℕ) : ℤ) ∣
        (P.canonicalLargePowerfulModulus : ℤ) := by
    exact_mod_cast
      ABCPoint.abcRadical_dvd_self P.canonicalLargePowerfulModulus
  have hrightModulus :
      ((abcRadical P.canonicalSumPowerfulModulus : ℕ) : ℤ) ∣
        (P.canonicalSumPowerfulModulus : ℤ) := by
    exact_mod_cast
      ABCPoint.abcRadical_dvd_self P.canonicalSumPowerfulModulus
  constructor
  · exact solution_leftSupport_dvd_parameterShift
      hbezout P.canonical_residual_gap_int
      hleftResidual hleftModulus
  · exact solution_rightSupport_dvd_parameterShift
      hbezout P.canonical_residual_gap_int
      hrightResidual hrightModulus

/-- Product form of the canonical support congruence. -/
theorem canonical_support_product_dvd_parameterSquare_sub
    (P : ABCPoint) {x y : ℤ}
    (hbezout :
      (P.canonicalLargePowerfulModulus : ℤ) * x +
          (P.canonicalSumPowerfulModulus : ℤ) * y = 1) :
    (((abcRadical P.canonicalLargePowerfulModulus : ℕ) : ℤ) *
        ((abcRadical P.canonicalSumPowerfulModulus : ℕ) : ℤ)) ∣
      (y * (P.canonicalLargeRadicalResidual : ℤ) +
          x * (P.canonicalSumRadicalResidual : ℤ)) ^ 2 -
        ((P.endpointMin : ℤ) * x * y) ^ 2 := by
  obtain ⟨hleft, hright⟩ :=
    canonical_support_parameter_congruences P hbezout
  have hradicalCoprimeNat : Nat.Coprime
      (abcRadical P.canonicalLargePowerfulModulus)
      (abcRadical P.canonicalSumPowerfulModulus) :=
    Nat.Coprime.of_dvd
      (ABCPoint.abcRadical_dvd_self
        P.canonicalLargePowerfulModulus)
      (ABCPoint.abcRadical_dvd_self
        P.canonicalSumPowerfulModulus)
      P.canonicalPowerfulModuli_coprime
  have hradicalCoprimeInt : IsCoprime
      ((abcRadical P.canonicalLargePowerfulModulus : ℕ) : ℤ)
      ((abcRadical P.canonicalSumPowerfulModulus : ℕ) : ℤ) :=
    hradicalCoprimeNat.isCoprime
  exact coprimeProduct_dvd_parameterSquare_sub
    hradicalCoprimeInt hleft hright

#print axioms leftParameterShift_identity
#print axioms rightParameterShift_identity
#print axioms commonDivisor_left_dvd_parameterShift
#print axioms commonDivisor_right_dvd_parameterShift
#print axioms solution_leftSupport_dvd_parameterShift
#print axioms solution_rightSupport_dvd_parameterShift
#print axioms coprimeProduct_dvd_parameterSquare_sub
#print axioms canonical_support_parameter_congruences
#print axioms canonical_support_product_dvd_parameterSquare_sub

end CanonicalAffineSupportCongruence
end IUTThreeClosures
