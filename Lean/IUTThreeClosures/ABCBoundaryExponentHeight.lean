/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCTwoBoundaryPrimeSupport

/-!
# Boundary prime-power exponents are logarithmic in the abc height

Suppose the two boundary primes selected from a primitive abc triple occur to
positive exponents `m` and `n`.  The corresponding prime powers divide their
boundary values.  Since every boundary value is at most `c` and every prime is
at least two, one obtains

`2^m ≤ c`, `2^n ≤ c`.

This is the exact arithmetic input used by the two-inertia sublinear-height
prime selector.  It does not identify the local Picard--Lefschetz exponent with
these valuations; that remains a local Tate/uniformization theorem.
-/

namespace IUTThreeClosures

/-- A boundary-prime pair enhanced by positive prime-power exponents. -/
structure BoundaryPrimePowerPair (a b c : ℕ)
    extends BoundaryPrimePair a b c where
  firstExponent : ℕ
  secondExponent : ℕ
  firstExponent_pos : 0 < firstExponent
  secondExponent_pos : 0 < secondExponent
  firstPow_dvd : p ^ firstExponent ∣ first.value a b c
  secondPow_dvd : q ^ secondExponent ∣ second.value a b c

namespace ABCBoundary

/-- Every Legendre boundary value of a positive abc triple is positive. -/
theorem value_pos
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hsum : a + b = c)
    (d : ABCBoundary) :
    0 < d.value a b c := by
  cases d with
  | left => exact ha
  | right => exact hb
  | sum => omega

/-- Every Legendre boundary value is bounded by the total `c`. -/
theorem value_le_sum
    {a b c : ℕ}
    (hsum : a + b = c)
    (d : ABCBoundary) :
    d.value a b c ≤ c := by
  cases d with
  | left => omega
  | right => omega
  | sum => simp [value]

end ABCBoundary

namespace BoundaryPrimePowerPair

/-- The first local exponent satisfies the elementary power bound `2^m ≤ c`. -/
theorem two_pow_firstExponent_le
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hsum : a + b = c)
    (D : BoundaryPrimePowerPair a b c) :
    2 ^ D.firstExponent ≤ c := by
  have hp2 : 2 ≤ D.p := D.p_prime.two_le
  have hpow : 2 ^ D.firstExponent ≤ D.p ^ D.firstExponent :=
    Nat.pow_le_pow_left hp2 D.firstExponent
  have hboundary_pos : 0 < D.first.value a b c :=
    ABCBoundary.value_pos ha hb hsum D.first
  have hpBoundary :
      D.p ^ D.firstExponent ≤ D.first.value a b c :=
    Nat.le_of_dvd hboundary_pos D.firstPow_dvd
  exact hpow.trans (hpBoundary.trans
    (ABCBoundary.value_le_sum hsum D.first))

/-- The second local exponent satisfies the elementary power bound `2^n ≤ c`. -/
theorem two_pow_secondExponent_le
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hsum : a + b = c)
    (D : BoundaryPrimePowerPair a b c) :
    2 ^ D.secondExponent ≤ c := by
  have hq2 : 2 ≤ D.q := D.q_prime.two_le
  have hpow : 2 ^ D.secondExponent ≤ D.q ^ D.secondExponent :=
    Nat.pow_le_pow_left hq2 D.secondExponent
  have hboundary_pos : 0 < D.second.value a b c :=
    ABCBoundary.value_pos ha hb hsum D.second
  have hqBoundary :
      D.q ^ D.secondExponent ≤ D.second.value a b c :=
    Nat.le_of_dvd hboundary_pos D.secondPow_dvd
  exact hpow.trans (hqBoundary.trans
    (ABCBoundary.value_le_sum hsum D.second))

/-- Both local exponents satisfy the power bounds consumed by the quantitative
selector. -/
theorem two_power_bounds
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hsum : a + b = c)
    (D : BoundaryPrimePowerPair a b c) :
    2 ^ D.firstExponent ≤ c ∧
      2 ^ D.secondExponent ≤ c :=
  ⟨D.two_pow_firstExponent_le ha hb hsum,
    D.two_pow_secondExponent_le ha hb hsum⟩

end BoundaryPrimePowerPair

end IUTThreeClosures
