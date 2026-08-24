/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyUnitLegTwoAdicResidual

/-!
# Rational nonintegrality from the residual two-adic denominator

An odd numerator divided by a positive even denominator cannot be an integer.
Applying this elementary parity fact to the residual unit-leg Frey fraction
shows that the uncancelled factor of two proved in the preceding module is a
genuine arithmetic obstruction, not merely an artifact of a chosen fraction
presentation.

The remaining local bridge is to identify this rational nonintegrality with
negative valuation at a place above two and then invoke Tate uniformization.
-/

namespace IUTThreeClosures

/-- An odd natural numerator over a positive even natural denominator is not an
integer rational number. -/
theorem odd_div_even_not_integer
    {a b : ℕ}
    (ha : a.Odd)
    (hb : Even b)
    (hbpos : 0 < b) :
    ¬ ∃ z : ℤ, (a : ℚ) / (b : ℚ) = (z : ℚ) := by
  rintro ⟨z, hz⟩
  have hbq : (b : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hbpos)
  have hq : (a : ℚ) = (z : ℚ) * (b : ℚ) :=
    (div_eq_iff hbq).mp hz
  have hint : (a : ℤ) = z * (b : ℤ) := by
    exact_mod_cast hq
  have hbIntPos : (0 : ℤ) < (b : ℤ) := by
    exact_mod_cast hbpos
  have haIntNonneg : (0 : ℤ) ≤ (a : ℤ) := by positivity
  have hznonneg : 0 ≤ z := by
    by_contra hz
    have hzneg : z < 0 := lt_of_not_ge hz
    have hprodneg : z * (b : ℤ) < 0 :=
      mul_neg_of_neg_of_pos hzneg hbIntPos
    rw [← hint] at hprodneg
    exact (not_lt_of_ge haIntNonneg) hprodneg
  have hzcast : (z.toNat : ℤ) = z :=
    Int.toNat_of_nonneg hznonneg
  have hint' : (a : ℤ) = (z.toNat : ℤ) * (b : ℤ) := by
    rw [hzcast]
    exact hint
  have hnat : a = z.toNat * b := by
    exact_mod_cast hint'
  have haEven : Even a := by
    rcases hb with ⟨k, hk⟩
    refine ⟨z.toNat * k, ?_⟩
    rw [hnat, hk]
    ring
  exact ha.not_even haEven

/-- The fully reduced residual unit-leg Frey fraction is nonintegral. -/
theorem unit_leg_residual_fraction_not_integer
    {n Q u : ℕ}
    (hn : 5 ≤ n)
    (hQ : Q.Odd)
    (hu : u.Odd) :
    ¬ ∃ z : ℤ,
      ((Q ^ 3 : ℕ) : ℚ) /
          (freyTwoResidualDenominator n u : ℚ) =
        (z : ℚ) := by
  have hnum : (Q ^ 3).Odd := cube_odd hQ
  have hdenEven : Even (freyTwoResidualDenominator n u) :=
    freyTwoResidualDenominator_even hn
  have hupos : 0 < u := hu.pos
  have hdenPos : 0 < freyTwoResidualDenominator n u := by
    unfold freyTwoResidualDenominator
    positivity
  exact odd_div_even_not_integer hnum hdenEven hdenPos

/-- The same nonintegrality conclusion after complete gcd reduction. -/
theorem reduced_unit_leg_residual_fraction_not_integer
    {n Q u : ℕ}
    (hn : 5 ≤ n)
    (hQ : Q.Odd)
    (hu : u.Odd) :
    let g := Nat.gcd (Q ^ 3) (freyTwoResidualDenominator n u)
    ¬ ∃ z : ℤ,
      (((Q ^ 3) / g : ℕ) : ℚ) /
          ((freyTwoResidualDenominator n u / g : ℕ) : ℚ) =
        (z : ℚ) := by
  dsimp
  let D := freyTwoResidualDenominator n u
  let g := Nat.gcd (Q ^ 3) D
  have hdenEven : Even (D / g) := by
    dsimp [D, g]
    exact reduced_freyTwoResidualDenominator_even hn hQ
  have hgOdd : g.Odd := by
    dsimp [g]
    exact gcd_odd_of_left_odd (cube_odd hQ)
  have hgDvdNum : g ∣ Q ^ 3 := by
    dsimp [g]
    exact Nat.gcd_dvd_left _ _
  have hnumOdd : ((Q ^ 3) / g).Odd := by
    rcases hgDvdNum with ⟨k, hk⟩
    have hqodd : (Q ^ 3).Odd := cube_odd hQ
    have hproduct : (g * k).Odd := by simpa [hk] using hqodd
    exact (Nat.odd_mul.mp hproduct).2
  have huPos : 0 < u := hu.pos
  have hDPos : 0 < D := by
    dsimp [D, freyTwoResidualDenominator]
    positivity
  have hgPos : 0 < g := hgOdd.pos
  have hdenPos : 0 < D / g := Nat.div_pos (Nat.le_of_dvd hDPos (Nat.gcd_dvd_right _ _))
  exact odd_div_even_not_integer hnumOdd hdenEven hdenPos

end IUTThreeClosures
