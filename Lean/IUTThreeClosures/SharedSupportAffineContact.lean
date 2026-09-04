/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineResidualParametrization
import Mathlib.Tactic

/-!
# Shared-support contact in the affine residual parametrization

Assume `R*x + S*y = 1` and use

`A_t = -m*x + t*S`,  `B_t = m*y + t*R`.

A divisor shared by `R` and `A_t` divides `t-m*x*y`; a divisor shared by `S`
and `B_t` divides `t+m*x*y`.  This detects the radical support shared by a
modulus and its squarefree residual.  It does not by itself detect the higher
multiplicities inside the modulus; those are handled by the separate exact
cross-endpoint contact-depth module.
-/

namespace IUTThreeClosures
namespace SharedSupportAffineContact

open AffineResidualParametrization

/-- The left shared-support contact identity. -/
theorem left_contact_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    t - m * x * y =
      y * residualA m S x t + (t * x) * R := by
  unfold residualA
  linear_combination t * hbezout

/-- The right shared-support contact identity. -/
theorem right_contact_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    t + m * x * y =
      x * residualB m R y t + (t * y) * S := by
  unfold residualB
  linear_combination t * hbezout

/-- A divisor shared by the left modulus and residual divides the left contact
factor. -/
theorem left_shared_support_dvd_contact
    {R S m x y t r : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t) :
    r ∣ t - m * x * y := by
  rw [left_contact_identity hbezout]
  exact dvd_add
    (dvd_mul_of_dvd_right hrA y)
    (dvd_mul_of_dvd_right hrR (t * x))

/-- A divisor shared by the right modulus and residual divides the right
contact factor. -/
theorem right_shared_support_dvd_contact
    {R S m x y t s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t) :
    s ∣ t + m * x * y := by
  rw [right_contact_identity hbezout]
  exact dvd_add
    (dvd_mul_of_dvd_right hsB x)
    (dvd_mul_of_dvd_right hsS (t * y))

/-- The two shared-support parts jointly divide one quadratic contact value. -/
theorem shared_support_product_dvd_quadratic_contact
    {R S m x y t r s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t) :
    r * s ∣ t ^ 2 - (m * x * y) ^ 2 := by
  have hl : r ∣ t - m * x * y :=
    left_shared_support_dvd_contact hbezout hrR hrA
  have hr : s ∣ t + m * x * y :=
    right_shared_support_dvd_contact hbezout hsS hsB
  have hprod : r * s ∣
      (t - m * x * y) * (t + m * x * y) :=
    mul_dvd_mul hl hr
  convert hprod using 1 <;> ring

/-- Nonzero quadratic contact dominates the shared-support product in absolute
value. -/
theorem shared_support_product_natAbs_le_quadratic_contact_natAbs
    {R S m x y t r s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t)
    (hcontact : t ^ 2 - (m * x * y) ^ 2 ≠ 0) :
    (r * s).natAbs ≤
      (t ^ 2 - (m * x * y) ^ 2).natAbs := by
  exact Int.natAbs_le_of_dvd_ne_zero
    (shared_support_product_dvd_quadratic_contact
      hbezout hrR hrA hsS hsB)
    hcontact

/-- The left contact factor cannot vanish under positive left canonical data. -/
theorem left_contact_ne_zero_of_positive
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1)
    (hm : 0 < m)
    (hR : 0 < R)
    (hA : 0 < residualA m S x t) :
    t - m * x * y ≠ 0 := by
  intro hzero
  have ht : t = m * x * y := by linarith
  have hcollapse : residualA m S x t = -m * R * x ^ 2 := by
    unfold residualA
    rw [ht]
    linear_combination m * x * hbezout
  rw [hcollapse] at hA
  nlinarith [sq_nonneg x]

/-- Vanishing of the right contact factor gives an explicit square-bearing
collapse. -/
theorem right_residual_eq_of_right_contact_zero
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1)
    (hzero : t + m * x * y = 0) :
    residualB m R y t = m * S * y ^ 2 := by
  have ht : t = -m * x * y := by linarith
  unfold residualB
  rw [ht]
  linear_combination m * y * hbezout

#print axioms left_contact_identity
#print axioms right_contact_identity
#print axioms left_shared_support_dvd_contact
#print axioms right_shared_support_dvd_contact
#print axioms shared_support_product_dvd_quadratic_contact
#print axioms shared_support_product_natAbs_le_quadratic_contact_natAbs
#print axioms left_contact_ne_zero_of_positive
#print axioms right_residual_eq_of_right_contact_zero

end SharedSupportAffineContact
end IUTThreeClosures
