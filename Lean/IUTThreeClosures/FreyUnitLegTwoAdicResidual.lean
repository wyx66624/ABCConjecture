/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The uncancelled two-adic denominator in unit-leg Frey data

For a unit-leg Frey triple whose even boundary is `2^n`, the raw Frey
`j`-fraction has the shape

`256 * Q^3 / (2^n * u)^2`,

where `Q` and the complementary factor `u` are odd.  Cancelling the fixed
factor `256 = 2^8` gives

`Q^3 / (2^(2*n-8) * u^2)`.

For `n ≥ 5`, the displayed residual denominator is even while the numerator is
odd.  Therefore its gcd with the numerator is odd, and dividing by that gcd
leaves an even denominator.  Thus the negative two-adic contribution cannot
be erased by any further ordinary gcd cancellation.

The conversion from this reduced-denominator theorem to a completed-local-field
valuation statement remains a separate bridge.
-/

namespace IUTThreeClosures

/-- The residual denominator after cancelling the fixed Frey numerator factor
`2^8`. -/
def freyTwoResidualDenominator (n u : ℕ) : ℕ :=
  2 ^ (2 * n - 8) * u ^ 2

/-- Exact cross-multiplication identity for the cancellation of `2^8`. -/
theorem frey_two_fixed_cancellation
    {n Q u : ℕ} (hn : 4 ≤ n) :
    (256 * Q ^ 3) * freyTwoResidualDenominator n u =
      Q ^ 3 * (2 ^ n * u) ^ 2 := by
  have hexponent : 8 + (2 * n - 8) = 2 * n := by omega
  calc
    (256 * Q ^ 3) * freyTwoResidualDenominator n u =
        (2 ^ 8 * Q ^ 3) * (2 ^ (2 * n - 8) * u ^ 2) := by
          norm_num [freyTwoResidualDenominator]
    _ = (2 ^ 8 * 2 ^ (2 * n - 8)) * (Q ^ 3 * u ^ 2) := by ring
    _ = 2 ^ (8 + (2 * n - 8)) * (Q ^ 3 * u ^ 2) := by
          rw [pow_add]
    _ = 2 ^ (2 * n) * (Q ^ 3 * u ^ 2) := by rw [hexponent]
    _ = Q ^ 3 * ((2 ^ n) ^ 2 * u ^ 2) := by
          rw [pow_mul]
          ring
    _ = Q ^ 3 * (2 ^ n * u) ^ 2 := by rw [mul_pow]

/-- The residual denominator is even as soon as `n ≥ 5`. -/
theorem freyTwoResidualDenominator_even
    {n u : ℕ} (hn : 5 ≤ n) :
    Even (freyTwoResidualDenominator n u) := by
  have hexp : 0 < 2 * n - 8 := by omega
  rcases hexp with ⟨k, hk⟩
  rw [hk, Nat.pow_succ, freyTwoResidualDenominator]
  refine Even.mul_right ?_ (u ^ 2)
  exact ⟨2 ^ k, by ring⟩

/-- A common divisor of an odd number and any other integer is odd. -/
theorem gcd_odd_of_left_odd
    {a b : ℕ} (ha : a.Odd) :
    (Nat.gcd a b).Odd := by
  rcases Nat.even_or_odd (Nat.gcd a b) with hgEven | hgOdd
  · have hgDvd : Nat.gcd a b ∣ a := Nat.gcd_dvd_left a b
    rcases hgDvd with ⟨k, hk⟩
    have haEven : Even a := by
      rw [hk]
      exact hgEven.mul_right k
    exact (ha.not_even haEven).elim
  · exact hgOdd

/-- Dividing an even number by an odd divisor leaves an even quotient. -/
theorem even_div_of_odd_dvd
    {d N : ℕ}
    (hd : d.Odd) (hN : Even N) (hdN : d ∣ N) :
    Even (N / d) := by
  have hfactor : d * (N / d) = N := Nat.mul_div_cancel' hdN
  rcases Nat.even_or_odd (N / d) with hquotEven | hquotOdd
  · exact hquotEven
  · have hprodOdd : (d * (N / d)).Odd := hd.mul hquotOdd
    rw [hfactor] at hprodOdd
    exact (hprodOdd.not_even hN).elim

/-- The numerator `Q^3` remains odd when `Q` is odd. -/
theorem cube_odd {Q : ℕ} (hQ : Q.Odd) :
    (Q ^ 3).Odd := by
  exact hQ.pow

/-- **Residual two-adic denominator theorem.**  After all ordinary gcd
cancellation, the denominator still has a factor of two. -/
theorem reduced_freyTwoResidualDenominator_even
    {n Q u : ℕ}
    (hn : 5 ≤ n)
    (hQ : Q.Odd) :
    Even
      (freyTwoResidualDenominator n u /
        Nat.gcd (Q ^ 3) (freyTwoResidualDenominator n u)) := by
  let D := freyTwoResidualDenominator n u
  let g := Nat.gcd (Q ^ 3) D
  have hD : Even D := by
    dsimp [D]
    exact freyTwoResidualDenominator_even hn
  have hnum : (Q ^ 3).Odd := cube_odd hQ
  have hg : g.Odd := by
    dsimp [g]
    exact gcd_odd_of_left_odd hnum
  have hgd : g ∣ D := by
    dsimp [g]
    exact Nat.gcd_dvd_right _ _
  exact even_div_of_odd_dvd hg hD hgd

/-- The first unit-leg quadratic factor is odd. -/
theorem unitLegPlusQ_odd (n : ℕ) :
    (1 + 2 ^ n + (2 ^ n) ^ 2).Odd := by
  by_cases hn : n = 0
  · subst n
    norm_num
  · have hpowEven : Even (2 ^ n) := by
      rcases Nat.exists_eq_succ_of_ne_zero hn with ⟨k, rfl⟩
      rw [Nat.pow_succ]
      exact Even.mul_right ⟨1, by norm_num⟩ (2 ^ k)
    have hpowSqEven : Even ((2 ^ n) ^ 2) := hpowEven.pow_right 2
    exact (Nat.odd_iff_not_even.mpr (by
      intro hEven
      have : Even 1 := by
        simpa only [Nat.even_add, hpowEven, hpowSqEven, Bool.false_or,
          Bool.or_false] using hEven
      norm_num at this))

end IUTThreeClosures
