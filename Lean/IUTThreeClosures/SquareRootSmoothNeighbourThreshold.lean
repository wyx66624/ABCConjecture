/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SubcriticalRadicalSlopeDisproofGate
import Mathlib.Tactic

/-!
# The square-root short-interval threshold

Current all-interval smooth-number technology reaches gaps of size
`X^(1/2 + o(1))`.  For a neighbour of a prime power, the deterministic abc
slope therefore splits as

`1/2 + primeSlope + smoothLoss`.

This file proves the exact threshold hidden in that expression.  A strict abc
counterexample slope exists precisely when the prime-power support and the
radical loss of the neighbour together stay strictly below `1/2`.  In
particular, a square-root gap combined only with a square-root radical bound is
critical and cannot disprove abc; a fixed positive saving below square-root
radical is essential.

The analytic construction of such neighbours is not asserted here.
-/

namespace IUTThreeClosures
namespace SquareRootSmoothNeighbourThreshold

noncomputable section

/-- Total radical slope for a square-root-sized additive gap. -/
def squareRootNeighbourSlope
    (primeSlope smoothLoss : ℝ) : ℝ :=
  (1 : ℝ) / 2 + primeSlope + smoothLoss

/-- A nonnegative slope satisfying a subcritical epsilon inequality is already
strictly below one. -/
theorem subunit_slope_of_subcritical
    {s ε : ℝ}
    (hε : 0 ≤ ε)
    (hs : 0 ≤ s)
    (hsubcritical : (1 + ε) * s < 1) :
    s < 1 := by
  have hprod : 0 ≤ ε * s := mul_nonneg hε hs
  nlinarith

/-- Conversely, every nonnegative slope strictly below one admits a fixed
positive epsilon margin. -/
theorem exists_positive_epsilon_of_subunit_slope
    {s : ℝ}
    (hs : 0 ≤ s)
    (hsubunit : s < 1) :
    ∃ ε : ℝ, 0 < ε ∧ (1 + ε) * s < 1 := by
  let ε : ℝ := (1 - s) / 2
  have hε : 0 < ε := by
    dsimp [ε]
    linarith
  have htwo : 0 < 2 - s := by
    linarith
  have hprod : 0 < (1 - s) * (2 - s) :=
    mul_pos (sub_pos.mpr hsubunit) htwo
  refine ⟨ε, hε, ?_⟩
  dsimp [ε]
  nlinarith

/-- Necessity of the sub-square-root radical threshold. -/
theorem smoothLoss_lt_half_sub_primeSlope_of_subcritical
    {primeSlope smoothLoss ε : ℝ}
    (hε : 0 ≤ ε)
    (hprime : 0 ≤ primeSlope)
    (hloss : 0 ≤ smoothLoss)
    (hsubcritical :
      (1 + ε) * squareRootNeighbourSlope primeSlope smoothLoss < 1) :
    smoothLoss < (1 : ℝ) / 2 - primeSlope := by
  have hsnonneg :
      0 ≤ squareRootNeighbourSlope primeSlope smoothLoss := by
    dsimp [squareRootNeighbourSlope]
    linarith
  have hslt :
      squareRootNeighbourSlope primeSlope smoothLoss < 1 :=
    subunit_slope_of_subcritical hε hsnonneg hsubcritical
  dsimp [squareRootNeighbourSlope] at hslt
  linarith

/-- Sufficiency: a strict budget below one half for the prime support plus the
neighbour radical gives an epsilon margin. -/
theorem exists_positive_epsilon_for_squareRoot_budget
    {primeSlope smoothLoss : ℝ}
    (hprime : 0 ≤ primeSlope)
    (hloss : 0 ≤ smoothLoss)
    (hbudget : primeSlope + smoothLoss < (1 : ℝ) / 2) :
    ∃ ε : ℝ, 0 < ε ∧
      (1 + ε) * squareRootNeighbourSlope primeSlope smoothLoss < 1 := by
  apply exists_positive_epsilon_of_subunit_slope
  · dsimp [squareRootNeighbourSlope]
    linarith
  · dsimp [squareRootNeighbourSlope]
    linarith

/-- A square-root gap and a radical loss of at least one half cannot be
subcritical once the prime-power summand has any positive support slope. -/
theorem squareRoot_gap_and_squareRoot_radical_not_subcritical
    {primeSlope smoothLoss ε : ℝ}
    (hε : 0 ≤ ε)
    (hprime : 0 < primeSlope)
    (hloss : (1 : ℝ) / 2 ≤ smoothLoss) :
    ¬ (1 + ε) * squareRootNeighbourSlope primeSlope smoothLoss < 1 := by
  intro hsubcritical
  have hprime0 : 0 ≤ primeSlope := hprime.le
  have hloss0 : 0 ≤ smoothLoss := by linarith
  have hthreshold :=
    smoothLoss_lt_half_sub_primeSlope_of_subcritical
      hε hprime0 hloss0 hsubcritical
  linarith

/-- The logarithmic support slope of a prime power `p^k`. -/
def primePowerSupportSlope (k : ℕ) : ℝ :=
  1 / (k : ℝ)

/-- For exponent `k`, a square-root-gap route requires neighbour-radical slope
strictly below `1/2 - 1/k`. -/
theorem smoothLoss_threshold_for_primePowerExponent
    {k : ℕ} {smoothLoss ε : ℝ}
    (hk : 0 < k)
    (hε : 0 ≤ ε)
    (hloss : 0 ≤ smoothLoss)
    (hsubcritical :
      (1 + ε) *
        squareRootNeighbourSlope (primePowerSupportSlope k) smoothLoss < 1) :
    smoothLoss < (1 : ℝ) / 2 - 1 / (k : ℝ) := by
  have hprime : 0 ≤ primePowerSupportSlope k := by
    unfold primePowerSupportSlope
    positivity
  simpa [primePowerSupportSlope] using
    (smoothLoss_lt_half_sub_primeSlope_of_subcritical
      hε hprime hloss hsubcritical)

/-- A square prime-power centre (`k = 2`) cannot close the square-root-gap
route with any nonnegative neighbour-radical slope. -/
theorem square_primePower_center_cannot_be_subcritical
    {smoothLoss ε : ℝ}
    (hε : 0 ≤ ε)
    (hloss : 0 ≤ smoothLoss) :
    ¬ (1 + ε) *
      squareRootNeighbourSlope (primePowerSupportSlope 2) smoothLoss < 1 := by
  intro hsubcritical
  have hthreshold :=
    smoothLoss_threshold_for_primePowerExponent
      (k := 2) (smoothLoss := smoothLoss) (ε := ε)
      (by norm_num) hε hloss hsubcritical
  norm_num [primePowerSupportSlope] at hthreshold
  linarith

/-- Specialization of the repository's exact disproof gate to the
square-root-gap slope. -/
theorem not_abcConjecture_of_squareRoot_nearPrimePower_budget
    (a b c : ℕ → ℕ)
    (primeSlope smoothLoss K ε : ℝ)
    (hε : 0 < ε)
    (hsubcritical :
      (1 + ε) * squareRootNeighbourSlope primeSlope smoothLoss < 1)
    (hapos : ∀ n, 0 < a n)
    (hbpos : ∀ n, 0 < b n)
    (hcpos : ∀ n, 0 < c n)
    (hsum : ∀ n, a n + b n = c n)
    (hcoprime : ∀ n, PairwiseCoprimeABC (a n) (b n) (c n))
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ,
      B < familyABCHeightLog (a n) (b n) (c n))
    (hradical : ∀ n : ℕ,
      familyABCRadicalLog (a n) (b n) (c n) ≤
        squareRootNeighbourSlope primeSlope smoothLoss *
          familyABCHeightLog (a n) (b n) (c n) + K) :
    ¬ ABCConjecture := by
  exact not_abcConjecture_of_nearPrimePower_budget
    a b c ((1 : ℝ) / 2) primeSlope smoothLoss K ε
    hε
    (by simpa [squareRootNeighbourSlope] using hsubcritical)
    hapos hbpos hcpos hsum hcoprime hunbounded
    (by
      intro n
      simpa [squareRootNeighbourSlope] using hradical n)

#print axioms subunit_slope_of_subcritical
#print axioms exists_positive_epsilon_of_subunit_slope
#print axioms smoothLoss_lt_half_sub_primeSlope_of_subcritical
#print axioms exists_positive_epsilon_for_squareRoot_budget
#print axioms squareRoot_gap_and_squareRoot_radical_not_subcritical
#print axioms smoothLoss_threshold_for_primePowerExponent
#print axioms square_primePower_center_cannot_be_subcritical
#print axioms not_abcConjecture_of_squareRoot_nearPrimePower_budget

end
end SquareRootSmoothNeighbourThreshold
end IUTThreeClosures
