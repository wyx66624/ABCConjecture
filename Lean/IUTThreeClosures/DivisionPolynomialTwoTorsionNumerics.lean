/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Numerical core of division-polynomial evaluation at two-torsion

For an odd division-polynomial index `n = 2*k+1`, the exponent in the formula

`Psi_n(e) = (-1)^k * f'(e)^(k*(k+1))`

is `k*(k+1) = (n^2-1)/4`.

The odd division-polynomial recurrence splits according to the parity of its
middle index.  This module kernel-checks the exponent and sign-parity identities
in both branches.  It is independent of the still-to-be-formalized elliptic
curve division-polynomial recurrence.
-/

namespace IUTThreeClosures

/-- Exponent `(n^2-1)/4` when the odd index is written as `n=2*k+1`. -/
def oddDivisionExponent (k : ℕ) : ℕ :=
  k * (k + 1)

/-- The division-polynomial exponent really is one quarter of `n^2-1`. -/
theorem four_mul_oddDivisionExponent (k : ℕ) :
    (4 : ℤ) * oddDivisionExponent k =
      ((2 * k + 1 : ℕ) : ℤ) ^ 2 - 1 := by
  simp [oddDivisionExponent]
  ring

/-- Exponent identity in the recurrence branch whose middle index is odd.

For `m=2*r+1`, the surviving term is `Psi_(m+2) * Psi_m^3`. -/
theorem divisionExponent_oddMiddle (r : ℕ) :
    oddDivisionExponent (r + 1) +
        3 * oddDivisionExponent r =
      (2 * r + 1) * (2 * r + 2) := by
  simp [oddDivisionExponent]
  ring

/-- Exponent identity in the recurrence branch whose middle index is positive
and even.

Writing `m=2*(r+1)`, the surviving term is
`- Psi_(m-1) * Psi_(m+1)^3`. -/
theorem divisionExponent_evenMiddle (r : ℕ) :
    oddDivisionExponent r +
        3 * oddDivisionExponent (r + 1) =
      (2 * (r + 1)) * (2 * (r + 1) + 1) := by
  simp [oddDivisionExponent]
  ring

/-- In the odd-middle branch, the recurrence sign exponent differs from the
target sign exponent by an even integer. -/
theorem divisionSignParity_oddMiddle (r : ℕ) :
    (r + 1) + 3 * r =
      (2 * r + 1) + 2 * r := by
  omega

/-- In the even-middle branch, including the leading minus sign, the recurrence
sign exponent differs from the target sign exponent by an even integer. -/
theorem divisionSignParity_evenMiddle (r : ℕ) :
    1 + r + 3 * (r + 1) =
      2 * (r + 1) + 2 * (r + 1) := by
  omega

/-- The target exponent for the odd index `2*m+1` is `m*(m+1)`. -/
theorem oddDivisionExponent_target (m : ℕ) :
    oddDivisionExponent m = m * (m + 1) :=
  rfl

end IUTThreeClosures
