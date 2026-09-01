/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffinePrimitiveEndpointFamily
import Mathlib.Tactic

/-!
# Discriminant and simple-root structure of the affine residual pair

For the exact affine residual parametrization

`A_t = -m*x + t*S`, `B_t = m*y + t*R`, `R*x + S*y = 1`,

define

`F_t = A_t*B_t`, `D_t = S*B_t + R*A_t`.

The elementary identity

`D_t^2 - 4*R*S*F_t = m^2`

is the discriminant relation of the two affine factors.  It implies that any
common divisor of `F_t` and `D_t` divides `m^2`: away from the gap primes the
residual product is squarefree as a polynomial value in the formal
simple-root sense.

The file also proves exact difference and root-class rigidity statements.
If `d` has an integral Bezout certificate with the leading coefficient `S`,
then two zeros of the left residual form modulo `d` have the same parameter
class; likewise for the right form and `R`.

No radical lower bound or abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace AffineResidualDiscriminant

open AffineResidualParametrization

/-- Product of the two affine residual coefficients. -/
def residualProduct (m R S x y t : ℤ) : ℤ :=
  residualA m S x t * residualB m R y t

/-- Linear square-root of the residual-product discriminant. -/
def residualDiscriminantLinear (m R S x y t : ℤ) : ℤ :=
  S * residualB m R y t + R * residualA m S x t

/-- Expanded residual product. -/
theorem residualProduct_expansion
    (m R S x y t : ℤ) :
    residualProduct m R S x y t =
      R * S * t ^ 2 + m * (S * y - R * x) * t - m ^ 2 * x * y := by
  unfold residualProduct residualA residualB
  ring

/-- Expanded linear discriminant factor. -/
theorem residualDiscriminantLinear_expansion
    (m R S x y t : ℤ) :
    residualDiscriminantLinear m R S x y t =
      2 * R * S * t + m * (S * y - R * x) := by
  unfold residualDiscriminantLinear residualA residualB
  ring

/-- Exact discriminant identity for the residual-product quadratic. -/
theorem residual_discriminant_identity
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ) :
    residualDiscriminantLinear m R S x y t ^ 2 -
        4 * R * S * residualProduct m R S x y t = m ^ 2 := by
  unfold residualDiscriminantLinear residualProduct residualA residualB
  have hsquare : (R * x + S * y) ^ 2 = 1 := by rw [hbezout]; norm_num
  calc
    (S * (m * y + t * R) + R * (-m * x + t * S)) ^ 2 -
        4 * R * S * ((-m * x + t * S) * (m * y + t * R)) =
      m ^ 2 * (R * x + S * y) ^ 2 := by ring
    _ = m ^ 2 := by rw [hsquare]; ring

/-- Any common divisor of the residual product and its linear discriminant
factor divides the square of the additive gap. -/
theorem common_divisor_product_discriminant_dvd_gap_sq
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ)
    (hproduct : d ∣ residualProduct m R S x y t)
    (hdiscriminant : d ∣ residualDiscriminantLinear m R S x y t) :
    d ∣ m ^ 2 := by
  rcases hproduct with ⟨q, hq⟩
  rcases hdiscriminant with ⟨r, hr⟩
  refine ⟨d * r ^ 2 - 4 * R * S * q, ?_⟩
  have hid := residual_discriminant_identity hbezout m t
  rw [hq, hr] at hid
  calc
    m ^ 2 = (d * r) ^ 2 - 4 * R * S * (d * q) := hid.symm
    _ = d * (d * r ^ 2 - 4 * R * S * q) := by ring

/-- Away from divisors of the gap square, a divisor of the residual product
cannot also divide the discriminant factor. -/
theorem not_dvd_discriminant_of_dvd_product_of_not_dvd_gap_sq
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ)
    (hproduct : d ∣ residualProduct m R S x y t)
    (hgap : ¬ d ∣ m ^ 2) :
    ¬ d ∣ residualDiscriminantLinear m R S x y t := by
  intro hdiscriminant
  exact hgap
    (common_divisor_product_discriminant_dvd_gap_sq
      hbezout m t hproduct hdiscriminant)

/-- Difference of two left residual coefficients. -/
theorem residualA_sub
    (m S x t u : ℤ) :
    residualA m S x t - residualA m S x u = S * (t - u) := by
  unfold residualA
  ring

/-- Difference of two right residual coefficients. -/
theorem residualB_sub
    (m R y t u : ℤ) :
    residualB m R y t - residualB m R y u = R * (t - u) := by
  unfold residualB
  ring

/-- Difference of two linear discriminant factors. -/
theorem residualDiscriminantLinear_sub
    (m R S x y t u : ℤ) :
    residualDiscriminantLinear m R S x y t -
        residualDiscriminantLinear m R S x y u =
      2 * R * S * (t - u) := by
  unfold residualDiscriminantLinear residualA residualB
  ring

/-- If `d` and `S` admit a Bezout certificate, the left residual form has at
most one root class modulo `d`. -/
theorem residualA_root_class_rigid
    {d S alpha beta m x t u : ℤ}
    (hcoprime : alpha * d + beta * S = 1)
    (ht : d ∣ residualA m S x t)
    (hu : d ∣ residualA m S x u) :
    d ∣ t - u := by
  rcases ht with ⟨a, ha⟩
  rcases hu with ⟨b, hb⟩
  refine ⟨alpha * (t - u) + beta * (a - b), ?_⟩
  have hsub := residualA_sub m S x t u
  rw [ha, hb] at hsub
  calc
    t - u = (alpha * d + beta * S) * (t - u) := by rw [hcoprime]; ring
    _ = d * (alpha * (t - u)) + beta * (d * a - d * b) := by
      rw [hsub]
      ring
    _ = d * (alpha * (t - u) + beta * (a - b)) := by ring

/-- If `d` and `R` admit a Bezout certificate, the right residual form has at
most one root class modulo `d`. -/
theorem residualB_root_class_rigid
    {d R alpha beta m y t u : ℤ}
    (hcoprime : alpha * d + beta * R = 1)
    (ht : d ∣ residualB m R y t)
    (hu : d ∣ residualB m R y u) :
    d ∣ t - u := by
  rcases ht with ⟨a, ha⟩
  rcases hu with ⟨b, hb⟩
  refine ⟨alpha * (t - u) + beta * (a - b), ?_⟩
  have hsub := residualB_sub m R y t u
  rw [ha, hb] at hsub
  calc
    t - u = (alpha * d + beta * R) * (t - u) := by rw [hcoprime]; ring
    _ = d * (alpha * (t - u)) + beta * (d * a - d * b) := by
      rw [hsub]
      ring
    _ = d * (alpha * (t - u) + beta * (a - b)) := by ring

/-- A divisor of both residual factors must divide the gap. -/
theorem common_divisor_residual_factors_dvd_gap
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ)
    (hA : d ∣ residualA m S x t)
    (hB : d ∣ residualB m R y t) :
    d ∣ m :=
  ((common_divisor_iff (d := d) hbezout m t).1 ⟨hA, hB⟩).1

/-- Consequently, away from gap divisors, the two factor root classes are
disjoint. -/
theorem not_both_residual_factors_of_not_dvd_gap
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ)
    (hgap : ¬ d ∣ m) :
    ¬ (d ∣ residualA m S x t ∧ d ∣ residualB m R y t) := by
  rintro ⟨hA, hB⟩
  exact hgap (common_divisor_residual_factors_dvd_gap hbezout m t hA hB)

#print axioms residualProduct_expansion
#print axioms residualDiscriminantLinear_expansion
#print axioms residual_discriminant_identity
#print axioms common_divisor_product_discriminant_dvd_gap_sq
#print axioms not_dvd_discriminant_of_dvd_product_of_not_dvd_gap_sq
#print axioms residualA_sub
#print axioms residualB_sub
#print axioms residualDiscriminantLinear_sub
#print axioms residualA_root_class_rigid
#print axioms residualB_root_class_rigid
#print axioms common_divisor_residual_factors_dvd_gap
#print axioms not_both_residual_factors_of_not_dvd_gap

end AffineResidualDiscriminant
end IUTThreeClosures
