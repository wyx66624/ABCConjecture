/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The simultaneous selector for the three Legendre boundary directions

For positive coprime integers `a+b=c`, the primitive vector

`(b,-a)`

lies in the first boundary line modulo `a`, in the second boundary line modulo
`b`, and in the diagonal boundary line modulo `c`.  Thus one global rational
vector follows all three locally canonical Legendre directions at their full
prime-power depths.

This module formalizes the elementary integer core.  No parabolic metric or
abc inequality is assumed.
-/

namespace IUTThreeClosures

/-- The global two-coordinate selector associated with `a+b=c`. -/
def legendreSimultaneousSelector (a b : ℤ) : ℤ × ℤ :=
  (b, -a)

/-- The second coordinate vanishes modulo the `a`-boundary modulus. -/
theorem legendreSelector_firstBoundary
    (a b : ℤ) :
    a ∣ (legendreSimultaneousSelector a b).2 := by
  simp [legendreSimultaneousSelector]

/-- The first coordinate vanishes modulo the `b`-boundary modulus. -/
theorem legendreSelector_secondBoundary
    (a b : ℤ) :
    b ∣ (legendreSimultaneousSelector a b).1 := by
  simp [legendreSimultaneousSelector]

/-- The two coordinates agree modulo the `c=a+b` boundary modulus. -/
theorem legendreSelector_thirdBoundary
    {a b c : ℤ}
    (h : a + b = c) :
    c ∣
      (legendreSimultaneousSelector a b).1 -
        (legendreSimultaneousSelector a b).2 := by
  refine ⟨1, ?_⟩
  simp [legendreSimultaneousSelector, ← h, add_comm]

/-- All three full-depth congruence conditions hold simultaneously. -/
theorem legendreSelector_allBoundaries
    {a b c : ℤ}
    (h : a + b = c) :
    a ∣ (legendreSimultaneousSelector a b).2 ∧
      b ∣ (legendreSimultaneousSelector a b).1 ∧
      c ∣
        ((legendreSimultaneousSelector a b).1 -
          (legendreSimultaneousSelector a b).2) := by
  exact ⟨legendreSelector_firstBoundary a b,
    legendreSelector_secondBoundary a b,
    legendreSelector_thirdBoundary h⟩

/-- Coprimality makes the selector vector primitive. -/
theorem legendreSelector_primitive
    {a b : ℕ}
    (hcop : a.Coprime b) :
    Nat.gcd b a = 1 := by
  simpa [Nat.coprime_comm] using hcop.gcd_eq_one

/-- The selector has archimedean sup-size at least half the total height. -/
theorem legendreSelector_half_height_le
    {a b c : ℕ}
    (h : a + b = c) :
    c ≤ 2 * max a b := by
  omega

/-- For positive legs, the selector's sup-size is strictly below `c`. -/
theorem legendreSelector_size_lt_height
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (h : a + b = c) :
    max a b < c := by
  omega

end IUTThreeClosures
