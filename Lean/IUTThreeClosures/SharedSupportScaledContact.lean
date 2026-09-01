/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SharedSupportAffineContact
import Mathlib.Tactic

/-!
# Scaled shared-support contact identities

The affine contact factors admit the exact rescalings

`S*(t-m*x*y) = A_t + m*R*x^2`,
`R*(t+m*x*y) = B_t - m*S*y^2`.

Therefore shared support yields divisibility by `S*rad(R)` and `R*rad(S)`,
not only by the two radicals separately.  The right zero case is exactly the
square collapse `B_t=m*S*y^2`.
-/

namespace IUTThreeClosures
namespace SharedSupportScaledContact

open AffineResidualParametrization
open SharedSupportAffineContact

/-- Exact scaled left contact identity. -/
theorem scaled_left_contact_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    S * (t - m * x * y) =
      residualA m S x t + m * R * x ^ 2 := by
  unfold residualA
  linear_combination -m * x * hbezout

/-- Exact scaled right contact identity. -/
theorem scaled_right_contact_identity
    {R S m x y t : ℤ}
    (hbezout : R * x + S * y = 1) :
    R * (t + m * x * y) =
      residualB m R y t - m * S * y ^ 2 := by
  unfold residualB
  linear_combination m * y * hbezout

/-- A left shared-support divisor gains the full opposite modulus after
rescaling. -/
theorem opposite_modulus_mul_left_support_dvd
    {R S m x y t r : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t) :
    S * r ∣ residualA m S x t + m * R * x ^ 2 := by
  have hcontact : r ∣ t - m * x * y :=
    left_shared_support_dvd_contact hbezout hrR hrA
  have hscaled : S * r ∣ S * (t - m * x * y) :=
    mul_dvd_mul_left S hcontact
  rw [scaled_left_contact_identity hbezout] at hscaled
  exact hscaled

/-- A right shared-support divisor gains the full opposite modulus after
rescaling. -/
theorem opposite_modulus_mul_right_support_dvd
    {R S m x y t s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t) :
    R * s ∣ residualB m R y t - m * S * y ^ 2 := by
  have hcontact : s ∣ t + m * x * y :=
    right_shared_support_dvd_contact hbezout hsS hsB
  have hscaled : R * s ∣ R * (t + m * x * y) :=
    mul_dvd_mul_left R hcontact
  rw [scaled_right_contact_identity hbezout] at hscaled
  exact hscaled

/-- A nonzero left scaled contact gives an absolute size bound. -/
theorem opposite_modulus_mul_left_support_natAbs_le
    {R S m x y t r : ℤ}
    (hbezout : R * x + S * y = 1)
    (hrR : r ∣ R)
    (hrA : r ∣ residualA m S x t)
    (hnonzero :
      residualA m S x t + m * R * x ^ 2 ≠ 0) :
    (S * r).natAbs ≤
      (residualA m S x t + m * R * x ^ 2).natAbs := by
  exact Int.natAbs_le_of_dvd_ne_zero
    (opposite_modulus_mul_left_support_dvd hbezout hrR hrA)
    hnonzero

/-- A nonzero right scaled contact gives the symmetric absolute size bound. -/
theorem opposite_modulus_mul_right_support_natAbs_le
    {R S m x y t s : ℤ}
    (hbezout : R * x + S * y = 1)
    (hsS : s ∣ S)
    (hsB : s ∣ residualB m R y t)
    (hnonzero :
      residualB m R y t - m * S * y ^ 2 ≠ 0) :
    (R * s).natAbs ≤
      (residualB m R y t - m * S * y ^ 2).natAbs := by
  exact Int.natAbs_le_of_dvd_ne_zero
    (opposite_modulus_mul_right_support_dvd hbezout hsS hsB)
    hnonzero

#print axioms scaled_left_contact_identity
#print axioms scaled_right_contact_identity
#print axioms opposite_modulus_mul_left_support_dvd
#print axioms opposite_modulus_mul_right_support_dvd
#print axioms opposite_modulus_mul_left_support_natAbs_le
#print axioms opposite_modulus_mul_right_support_natAbs_le

end SharedSupportScaledContact
end IUTThreeClosures
