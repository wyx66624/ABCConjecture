/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Data.Nat.Factorization.Root

/-!
# Adaptive root saturation and the fixed-order obstruction

For a positive exponent `e`, the `e`-th ceiling root of the prime power
`p^e` is exactly `p`.  Thus choosing the root order to equal the actual local
multiplicity converts that prime-power contact to radical contact.

In contrast, one fixed root order `m` sends `p^(k*m)` to `p^k`.  As `k`
grows this is unbounded, so no fixed-order root stack can truncate arbitrary
valuation multiplicities to their support.  This is the elementary exponent
core of the adaptive Kummer/root-stack route.
-/

namespace IUTThreeClosures

/-- Matching the root order to the actual exponent radicalizes one prime
power exactly. -/
theorem adaptive_ceilRoot_prime_power
    (p e : ℕ) (he : e ≠ 0) :
    Nat.ceilRoot e (p ^ e) = p :=
  Nat.ceilRoot_pow_self he p

/-- A fixed root order divides only the exponent: a contact of order `k*m`
retains contact order `k`. -/
theorem fixed_ceilRoot_prime_power
    (p m k : ℕ) (hm : m ≠ 0) :
    Nat.ceilRoot m (p ^ (k * m)) = p ^ k := by
  simpa [pow_mul] using
    (Nat.ceilRoot_pow_self hm (p ^ k))

/-- In particular, every fixed positive root order leaves unbounded residual
multiplicity, already on powers of two. -/
theorem fixed_root_order_residual_unbounded
    (m : ℕ) (hm : m ≠ 0) :
    ∀ B : ℕ, ∃ k : ℕ,
      B < Nat.ceilRoot m (2 ^ (k * m)) := by
  intro B
  refine ⟨B + 1, ?_⟩
  rw [fixed_ceilRoot_prime_power 2 m (B + 1) hm]
  exact (Nat.lt_succ_self B).trans (Nat.lt_two_pow_self)

/-- Adaptive saturation has residual exponent one at every positive prime-power
contact. -/
theorem adaptive_residual_exponent
    (e : ℕ) (he : e ≠ 0) :
    Nat.ceilDiv e e = 1 := by
  rw [Nat.ceilDiv_eq_add_pred_div]
  omega

/-- A fixed order `m` has residual exponent `k` on contact order `k*m`. -/
theorem fixed_residual_exponent
    (m k : ℕ) (hm : m ≠ 0) :
    Nat.ceilDiv (k * m) m = k := by
  rw [Nat.ceilDiv_eq_add_pred_div]
  omega

end IUTThreeClosures
