/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Divisibility rescaling barrier at a critical short-interval exponent

Suppose a short-interval theorem is available only at the critical scale

`h^n = x^m`, with `m < n`.

To count integers divisible by `q`, one naturally divides both the interval
centre and its length by `q`.  For every `q > 1`, however, the rescaled interval
is strictly shorter than the same critical power scale:

`(h / q)^n < (x / q)^m`.

Thus an all-interval theorem whose hypothesis is the non-strict reverse
inequality cannot simply be reapplied after imposing divisibility.  A separate
uniform theorem below the critical exponent, or an averaged estimate with the
required divisibility information, is necessary.
-/

namespace IUTThreeClosures

/-- General rational-exponent rescaling barrier.

If `h^n = x^m`, `m < n`, and `q > 1`, then scaling both `x` and `h` by
`1/q` moves strictly below the same `m/n` critical curve. -/
theorem criticalRationalPower_rescaling_strict
    {x h q : ℝ} {m n : ℕ}
    (hx : 0 < x)
    (hq : 1 < q)
    (hmn : m < n)
    (hcritical : h ^ n = x ^ m) :
    (h / q) ^ n < (x / q) ^ m := by
  have hqpos : 0 < q := lt_trans zero_lt_one hq
  have hxpowpos : 0 < x ^ m := pow_pos hx m
  have hqnp : 0 < q ^ n := pow_pos hqpos n
  have hqmp : 0 < q ^ m := pow_pos hqpos m
  have hpow : q ^ m < q ^ n := pow_lt_pow_right₀ hq hmn
  rw [div_pow, div_pow, hcritical]
  exact (div_lt_div_iff₀ hqnp hqmp).2
    (mul_lt_mul_of_pos_left hpow hxpowpos)

/-- The `3/5` specialization relevant to the present smooth-number route. -/
theorem threeFifths_rescaling_strict
    {x h q : ℝ}
    (hx : 0 < x)
    (hq : 1 < q)
    (hcritical : h ^ 5 = x ^ 3) :
    (h / q) ^ 5 < (x / q) ^ 3 := by
  exact criticalRationalPower_rescaling_strict
    (m := 3) (n := 5) hx hq (by norm_num) hcritical

/-- Consequently the rescaled interval cannot satisfy the weak critical-scale
hypothesis in the opposite direction. -/
theorem not_threeFifths_rescaled_admissible
    {x h q : ℝ}
    (hx : 0 < x)
    (hq : 1 < q)
    (hcritical : h ^ 5 = x ^ 3) :
    ¬ (x / q) ^ 3 ≤ (h / q) ^ 5 := by
  exact not_le_of_gt (threeFifths_rescaling_strict hx hq hcritical)

end IUTThreeClosures
