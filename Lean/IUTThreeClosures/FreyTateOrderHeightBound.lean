/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyLocalOrderHeightBound

/-!
# Height bound for the odd-prime Frey Tate order

At an odd support prime where the integral Frey equation is minimal and has
multiplicative reduction,

`ord_p(Δ_min) = 2 * ord_p(abc)`.

For a Tate curve this is also the positive order of the Tate parameter.  The
preceding file bounds `ord_p(abc)` by the abc height.  This file records the
resulting factor-two estimate for the actual local order.

The local reduction/Tate-uniformization theorem still has to identify the
stored `qOrder` with `2*n`; no such identification is assumed here.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- Twice a supported prime-power exponent is bounded by six times the abc
height. -/
theorem twiceLocalExponent_mul_log_two_le_six_height
    (P : ABCPoint)
    {p n : ℕ}
    (hp : Nat.Prime p)
    (hdiv : p ^ n ∣ P.a * P.b * P.c) :
    ((2 * n : ℕ) : ℝ) * Real.log 2 ≤ 6 * P.height := by
  have h := P.localExponent_mul_log_two_le_three_height hp hdiv
  push_cast
  nlinarith

/-- Any local order identified with twice the support exponent satisfies the
same bound. -/
theorem tateOrder_mul_log_two_le_six_height
    (P : ABCPoint)
    {p n qOrder : ℕ}
    (hp : Nat.Prime p)
    (hdiv : p ^ n ∣ P.a * P.b * P.c)
    (hqOrder : qOrder = 2 * n) :
    (qOrder : ℝ) * Real.log 2 ≤ 6 * P.height := by
  subst qOrder
  exact P.twiceLocalExponent_mul_log_two_le_six_height hp hdiv

/-- Explicit ratio form. -/
theorem tateOrder_le_height_ratio
    (P : ABCPoint)
    {p n qOrder : ℕ}
    (hp : Nat.Prime p)
    (hdiv : p ^ n ∣ P.a * P.b * P.c)
    (hqOrder : qOrder = 2 * n) :
    (qOrder : ℝ) ≤ 6 * P.height / Real.log 2 := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  apply (le_div_iff₀ hlog2).2
  simpa [mul_comm] using
    P.tateOrder_mul_log_two_le_six_height hp hdiv hqOrder

end ABCPoint

end IUTThreeClosures
