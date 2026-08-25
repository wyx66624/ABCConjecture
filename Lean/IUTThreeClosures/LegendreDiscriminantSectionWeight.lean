/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Weight arithmetic for the Legendre discriminant section

If an auxiliary level satisfies `ell = 12 * m + 1`, then the `m`-th power of
a weight-twelve discriminant section has weight `ell - 1`.  Since the
Legendre discriminant has cusp order two at each of the three labelled cusps,
its `m`-th power has cusp coefficient

`2 * m = (ell - 1) / 6`.

This module formalizes the scalar arithmetic behind that geometric statement.
It does not construct the modular stack, discriminant section, integral model,
or Arakelov metric.
-/

namespace IUTThreeClosures

/-- The integral discriminant power has exactly weight `ell - 1`. -/
theorem twelve_mul_discriminantPower_eq_level_sub_one
    {ell m : ℕ}
    (hlevel : ell = 12 * m + 1) :
    12 * m = ell - 1 := by
  omega

/-- Twice the discriminant power is one sixth of the real level weight. -/
theorem twice_discriminantPower_real_eq_levelWeight_div_six
    {ell m : ℕ}
    (hlevel : ell = 12 * m + 1) :
    (2 * m : ℝ) = ((ell : ℝ) - 1) / 6 := by
  subst ell
  push_cast
  ring

/-- The finite cusp contribution of the discriminant power has the canonical
Tate-line coefficient against a quantity `Q = 2 * H`. -/
theorem discriminantPower_boundary_eq_tateCoefficient
    {ell m : ℕ}
    (hlevel : ell = 12 * m + 1)
    (H : ℝ) :
    (2 * m : ℝ) * H =
      (((ell : ℝ) - 1) / 12) * (2 * H) := by
  subst ell
  push_cast
  ring

/-- Equivalent formulation using the weight-twelve power itself. -/
theorem discriminantPower_times_doubleHeight
    {ell m : ℕ}
    (hlevel : ell = 12 * m + 1)
    (H : ℝ) :
    (m : ℝ) * (2 * H) =
      (((ell : ℝ) - 1) / 12) * (2 * H) := by
  subst ell
  push_cast
  ring

end IUTThreeClosures
