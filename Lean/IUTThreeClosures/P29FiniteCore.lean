/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Tactic.NormNum

/-!
# A finite arithmetic core at 29

This file records the exact multiplicative-order calculation used in the
prime-index `p = 29` analysis.  It contains no class-group, class-field-theory,
or analytic assumptions.
-/

namespace IUTThreeClosures

/-- Fermat's exponent `28` kills `2` modulo `29`. -/
theorem p29_two_pow_twentyEight : (2 : ZMod 29) ^ 28 = 1 := by
  decide

/-- The prime-factor test at `2`: exponent `28 / 2 = 14` is insufficient. -/
theorem p29_two_pow_fourteen_ne_one : (2 : ZMod 29) ^ 14 ≠ 1 := by
  decide

/-- The prime-factor test at `7`: exponent `28 / 7 = 4` is insufficient. -/
theorem p29_two_pow_four_ne_one : (2 : ZMod 29) ^ 4 ≠ 1 := by
  decide

/-- The multiplicative order of `2` modulo `29` is the full value `28`.

The proof uses the standard prime-divisor criterion for the order: `2^28 = 1`,
while division of `28` by either of its prime factors `2` and `7` does not give
an exponent killing `2`.
-/
theorem p29_orderOf_two : orderOf (2 : ZMod 29) = 28 := by
  apply orderOf_eq_of_pow_and_pow_div_prime (n := 28)
  · norm_num
  · exact p29_two_pow_twentyEight
  · intro p hp hpd
    have hp_cases : p = 2 ∨ p = 7 := by
      change p ∣ 2 ^ 2 * 7 at hpd
      rcases (hp.dvd_mul.mp hpd) with h2 | h7
      · exact Or.inl <|
          (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp
            (hp.dvd_of_dvd_pow h2)
      · exact Or.inr <| (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp h7
    rcases hp_cases with rfl | rfl
    · simpa using p29_two_pow_fourteen_ne_one
    · simpa using p29_two_pow_four_ne_one

#print axioms p29_two_pow_twentyEight
#print axioms p29_two_pow_fourteen_ne_one
#print axioms p29_two_pow_four_ne_one
#print axioms p29_orderOf_two

end IUTThreeClosures
