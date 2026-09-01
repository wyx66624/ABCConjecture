/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SharedSupportAffineContact
import Mathlib.Tactic

/-!
# Quadratic elimination of the Bezout coefficients

For the residual parametrization

`A_t = -m*x+t*S`, `B_t = m*y+t*R`, `R*x+S*y=1`,

the contact factors `t-m*x*y` and `t+m*x*y` can be expressed by quadratic
polynomials in the single parameter `t`:

`m*(t-m*x*y) = R*S*t^2 - 2*R*A_t*t + A_t*B_t`,

`m*(t+m*x*y) = -R*S*t^2 + 2*S*B_t*t - A_t*B_t`.

The first quadratic has discriminant `-4*m*R*A_t`; the second has
discriminant `4*m*S*B_t`.  This removes the potentially large Bezout
coefficients from the archimedean size problem while retaining the exact
shared-support divisibility.
-/

namespace IUTThreeClosures
namespace SharedSupportContactQuadratics

open AffineResidualParametrization
open SharedSupportAffineContact

/-- Left contact after eliminating both Bezout coefficients. -/
theorem left_contact_quadratic_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    m * (t - m * x * y) =
      R * S * t ^ 2 -
        2 * R * residualA m S x t * t +
          residualA m S x t * residualB m R y t := by
  unfold residualA residualB
  linear_combination m * t * hbezout

/-- Right contact after eliminating both Bezout coefficients. -/
theorem right_contact_quadratic_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    m * (t + m * x * y) =
      -(R * S * t ^ 2) +
        2 * S * residualB m R y t * t -
          residualA m S x t * residualB m R y t := by
  unfold residualA residualB
  linear_combination m * t * hbezout

/-- The left contact quadratic has negative discriminant on positive
canonical data. -/
theorem left_contact_discriminant_identity
    {R S m A B : ℤ}
    (hgap : S * B - R * A = m) :
    (2 * R * A) ^ 2 - 4 * (R * S) * (A * B) =
      -4 * m * R * A := by
  linear_combination -4 * R * A * hgap

/-- The right contact quadratic has positive discriminant `4*m*S*B`. -/
theorem right_contact_discriminant_identity
    {R S m A B : ℤ}
    (hgap : S * B - R * A = m) :
    (2 * S * B) ^ 2 - 4 * (R * S) * (A * B) =
      4 * m * S * B := by
  linear_combination 4 * S * B * hgap

/-- Any divisor of the left contact, after multiplication by the gap, divides
the one-parameter left quadratic. -/
theorem gap_mul_left_support_dvd_quadratic
    {R S m x y t r : ℤ}
    (hbezout : R * x + S * y = 1)
    (hr : r ∣ t - m * x * y) :
    m * r ∣
      R * S * t ^ 2 -
        2 * R * residualA m S x t * t +
          residualA m S x t * residualB m R y t := by
  have hmul : m * r ∣ m * (t - m * x * y) :=
    mul_dvd_mul_left m hr
  rw [left_contact_quadratic_identity hbezout] at hmul
  exact hmul

/-- Shared left modulus/residual support gives the quadratic divisibility. -/
theorem gap_mul_left_shared_support_dvd_quadratic
    {R S m x y t r : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t) :
    m * r ∣
      R * S * t ^ 2 -
        2 * R * residualA m S x t * t +
          residualA m S x t * residualB m R y t := by
  exact gap_mul_left_support_dvd_quadratic hbezout
    (left_shared_support_dvd_contact hbezout hrR hrA)

/-- Symmetric right quadratic divisibility. -/
theorem gap_mul_right_shared_support_dvd_quadratic
    {R S m x y t s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t) :
    m * s ∣
      -(R * S * t ^ 2) +
        2 * S * residualB m R y t * t -
          residualA m S x t * residualB m R y t := by
  have hcontact : s ∣ t + m * x * y :=
    right_shared_support_dvd_contact hbezout hsS hsB
  have hmul : m * s ∣ m * (t + m * x * y) :=
    mul_dvd_mul_left m hcontact
  rw [right_contact_quadratic_identity hbezout] at hmul
  exact hmul

#print axioms left_contact_quadratic_identity
#print axioms right_contact_quadratic_identity
#print axioms left_contact_discriminant_identity
#print axioms right_contact_discriminant_identity
#print axioms gap_mul_left_support_dvd_quadratic
#print axioms gap_mul_left_shared_support_dvd_quadratic
#print axioms gap_mul_right_shared_support_dvd_quadratic

end SharedSupportContactQuadratics
end IUTThreeClosures
