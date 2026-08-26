/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Simultaneous lower bounds from a multiplicative-excess product

The strengthened powerful-core route reaches an inequality of the form

`M * c < exc(x) * exc(c)`

while each excess is nonnegative and at most `c`.  This elementary module
proves that **both** excesses are then larger than `M`, not merely one of them.

The arithmetic instantiation takes

`M = c^(epsilon/(1+epsilon)) / 2`.
-/

namespace IUTThreeClosures

/-- If two nonnegative factors are at most `c`, but their product is larger
than `M*c`, then both factors are larger than `M`. -/
theorem both_gt_of_mul_gt_mul_cap
    {M c x y : ℝ}
    (hc : 0 < c)
    (hx : 0 ≤ x) (hy : 0 ≤ y)
    (hxc : x ≤ c) (hyc : y ≤ c)
    (hprod : M * c < x * y) :
    M < x ∧ M < y := by
  constructor
  · have hxy_le : x * y ≤ x * c :=
      mul_le_mul_of_nonneg_left hyc hx
    have hMc_lt : M * c < x * c :=
      hprod.trans_le hxy_le
    exact (mul_lt_mul_right hc).mp hMc_lt
  · have hxy_le : x * y ≤ c * y :=
      mul_le_mul_of_nonneg_right hxc hy
    have hMc_lt : M * c < c * y :=
      hprod.trans_le hxy_le
    have hrewrite : M * c = c * M := by ring
    rw [hrewrite] at hMc_lt
    exact (mul_lt_mul_left hc).mp hMc_lt

/-- Non-strict companion used when the arithmetic input supplies a weak
product inequality. -/
theorem both_ge_of_mul_ge_mul_cap
    {M c x y : ℝ}
    (hc : 0 < c)
    (hx : 0 ≤ x) (hy : 0 ≤ y)
    (hxc : x ≤ c) (hyc : y ≤ c)
    (hprod : M * c ≤ x * y) :
    M ≤ x ∧ M ≤ y := by
  constructor
  · have hxy_le : x * y ≤ x * c :=
      mul_le_mul_of_nonneg_left hyc hx
    have hMc_le : M * c ≤ x * c :=
      hprod.trans hxy_le
    exact (mul_le_mul_right hc).mp hMc_le
  · have hxy_le : x * y ≤ c * y :=
      mul_le_mul_of_nonneg_right hxc hy
    have hMc_le : M * c ≤ c * y :=
      hprod.trans hxy_le
    have hrewrite : M * c = c * M := by ring
    rw [hrewrite] at hMc_le
    exact (mul_le_mul_left hc).mp hMc_le

end IUTThreeClosures
