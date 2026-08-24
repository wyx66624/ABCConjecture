/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Absorbing auxiliary-prime source growth into the q-pilot term

A selected auxiliary prime may depend on a local Tate order.  Bounding its
logarithm by `log(order) + O_epsilon(1)` does not by itself give a bound in
terms of the abc conductor: controlling prime-power exponents by the radical
would be circular.  The correct noncircular quantity is the q-pilot itself,
which already contains the local Tate-order contribution.

This module formalizes the scalar absorption step.  Suppose a public IUT IV
estimate has been reduced to

`rawQ / 6 <= A * conductor + K + theta * rawQ`.

If `theta < 1/6`, the source-dependent term proportional to `rawQ` may be moved
to the left, giving

`rawQ / 6 <= (A * conductor + K) / (1 - 6*theta)`.

Thus logarithmic dependence on a Tate order can be absorbed into the q-pilot
with an arbitrarily small loss in the final conductor coefficient.  This is a
third quantitative route, distinct from both a uniform auxiliary-prime bound
and direct conductor-slope bounds.

The theorem is purely real algebra.  It does not prove that an actual IUT
different/error term has the required logarithmic dependence, nor that the
actual q-pilot contains the selected local order.
-/

namespace IUTThreeClosures

/-- Move a sufficiently small multiple of the q-pilot from the right-hand side
of a Theorem 1.10 estimate to the left. -/
theorem qPilot_bound_of_self_absorbing_error
    {rawQ A conductor K theta : ℝ}
    (htheta : theta < 1 / 6)
    (hbound :
      rawQ / 6 ≤ A * conductor + K + theta * rawQ) :
    rawQ / 6 ≤
      (A * conductor + K) / (1 - 6 * theta) := by
  have hden : 0 < 1 - 6 * theta := by
    linarith
  apply (le_div_iff₀ hden).2
  have hleft :
      (rawQ / 6) * (1 - 6 * theta) =
        rawQ / 6 - theta * rawQ := by
    ring
  rw [hleft]
  linarith

/-- Separated conductor and constant form of the self-absorption theorem. -/
theorem qPilot_bound_of_self_absorbing_error'
    {rawQ A conductor K theta : ℝ}
    (htheta : theta < 1 / 6)
    (hbound :
      rawQ / 6 ≤ A * conductor + K + theta * rawQ) :
    rawQ / 6 ≤
      (A / (1 - 6 * theta)) * conductor +
        K / (1 - 6 * theta) := by
  have hden : 0 < 1 - 6 * theta := by
    linarith
  have h := qPilot_bound_of_self_absorbing_error htheta hbound
  calc
    rawQ / 6 ≤ (A * conductor + K) / (1 - 6 * theta) := h
    _ = (A / (1 - 6 * theta)) * conductor +
        K / (1 - 6 * theta) := by
      field_simp [hden.ne']
      ring

/-- If the post-absorption conductor coefficient fits the target epsilon
budget, the desired final affine q-bound follows. -/
theorem qPilot_bound_with_target_coefficient
    {rawQ A conductor K theta epsilon : ℝ}
    (hconductor : 0 ≤ conductor)
    (htheta : theta < 1 / 6)
    (hcoefficient :
      A / (1 - 6 * theta) ≤ 1 + epsilon)
    (hbound :
      rawQ / 6 ≤ A * conductor + K + theta * rawQ) :
    rawQ / 6 ≤
      (1 + epsilon) * conductor +
        K / (1 - 6 * theta) := by
  have h := qPilot_bound_of_self_absorbing_error' htheta hbound
  have hcoefmul :=
    mul_le_mul_of_nonneg_right hcoefficient hconductor
  linarith

/-- A convenient budget decomposition: a correction `alpha` and a
self-absorption loss `theta` jointly fit epsilon precisely through the displayed
rational coefficient. -/
theorem qPilot_bound_of_correction_and_self_absorption
    {rawQ conductor K alpha theta epsilon : ℝ}
    (hconductor : 0 ≤ conductor)
    (htheta : theta < 1 / 6)
    (hbudget :
      (1 + alpha) / (1 - 6 * theta) ≤ 1 + epsilon)
    (hbound :
      rawQ / 6 ≤
        (1 + alpha) * conductor + K + theta * rawQ) :
    rawQ / 6 ≤
      (1 + epsilon) * conductor +
        K / (1 - 6 * theta) :=
  qPilot_bound_with_target_coefficient
    hconductor htheta hbudget hbound

end IUTThreeClosures
