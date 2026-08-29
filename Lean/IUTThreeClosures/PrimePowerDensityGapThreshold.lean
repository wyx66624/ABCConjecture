/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalDensityBarrier
import Mathlib.Tactic

/-!
# The exact density-gap threshold for prime-power neighbour routes

Suppose a prospective counterexample is built immediately to the right of a
prime power `p^k`.  Write

* `theta` for the logarithmic size of the additive gap;
* `1 / k` for the radical contribution of `p^k`;
* `beta` for the radical contribution of the neighbouring integer.

If the construction is required on a prime-power family dense enough that the
low-radical counting barrier forces `beta >= 1 / k`, then a subcritical abc
slope exists exactly when

`theta + 2 / k < 1`,

or equivalently

`2 < (1 - theta) * k`.

This generalizes the previously formalized square-root threshold `k > 4`.
No analytic existence theorem for the required neighbours is asserted here.
-/

namespace IUTThreeClosures
namespace PrimePowerDensityGapThreshold

open SquareRootSmoothNeighbourThreshold

noncomputable section

/-- The total deterministic radical slope of a prime-power neighbour. -/
def neighbourSlope (theta : ℝ) (k : ℕ) (beta : ℝ) : ℝ :=
  theta + 1 / (k : ℝ) + beta

/-- A radical slope compatible with the density lower bound exists precisely
when the gap and the two unavoidable `1/k` contributions have total slope
strictly below one. -/
theorem exists_density_compatible_beta_iff
    {theta : ℝ} {k : ℕ} (hk : 0 < k) :
    (∃ beta : ℝ,
      1 / (k : ℝ) ≤ beta ∧
      neighbourSlope theta k beta < 1) ↔
      theta + 2 / (k : ℝ) < 1 := by
  constructor
  · rintro ⟨beta, hbeta, hsubcritical⟩
    dsimp [neighbourSlope] at hsubcritical
    have htwo :
        theta + 2 / (k : ℝ) =
          theta + 1 / (k : ℝ) + 1 / (k : ℝ) := by
      ring
    rw [htwo]
    linarith
  · intro hthreshold
    refine ⟨1 / (k : ℝ), le_rfl, ?_⟩
    dsimp [neighbourSlope]
    have htwo :
        theta + 1 / (k : ℝ) + 1 / (k : ℝ) =
          theta + 2 / (k : ℝ) := by
      ring
    rw [htwo]
    exact hthreshold

/-- Equivalent multiplicative form of the exact threshold. -/
theorem density_gap_threshold_iff
    {theta : ℝ} {k : ℕ} (hk : 0 < k) :
    (∃ beta : ℝ,
      1 / (k : ℝ) ≤ beta ∧
      neighbourSlope theta k beta < 1) ↔
      2 < (1 - theta) * (k : ℝ) := by
  rw [exists_density_compatible_beta_iff hk]
  have hkreal : 0 < (k : ℝ) := by exact_mod_cast hk
  constructor
  · intro hthreshold
    have hdiv : 2 / (k : ℝ) < 1 - theta := by
      linarith
    exact (div_lt_iff₀ hkreal).mp hdiv
  · intro hthreshold
    have hdiv : 2 / (k : ℝ) < 1 - theta :=
      (div_lt_iff₀ hkreal).mpr hthreshold
    linarith

/-- Below the exact exponent threshold no density-compatible neighbour radical
can have subcritical total slope. -/
theorem no_density_compatible_beta_of_threshold_le
    {theta : ℝ} {k : ℕ}
    (hk : 0 < k)
    (hthreshold : (1 - theta) * (k : ℝ) ≤ 2) :
    ¬ ∃ beta : ℝ,
      1 / (k : ℝ) ≤ beta ∧
      neighbourSlope theta k beta < 1 := by
  intro hexists
  have hstrict := (density_gap_threshold_iff hk).mp hexists
  linarith

/-- At the density edge `beta = 1/k`, every nonnegative subunit total slope
admits a fixed positive abc epsilon margin. -/
theorem exists_positive_epsilon_at_density_edge
    {theta : ℝ} {k : ℕ}
    (hk : 0 < k)
    (htheta : 0 ≤ theta)
    (hthreshold : theta + 2 / (k : ℝ) < 1) :
    ∃ epsilon : ℝ,
      0 < epsilon ∧
      (1 + epsilon) * (theta + 2 / (k : ℝ)) < 1 := by
  have hkreal : 0 < (k : ℝ) := by exact_mod_cast hk
  apply exists_positive_epsilon_of_subunit_slope
  · have hdiv : 0 ≤ 2 / (k : ℝ) :=
      div_nonneg (by norm_num) hkreal.le
    linarith
  · exact hthreshold

/-- The square-root case is exactly the integer threshold `k > 4`. -/
theorem squareRoot_density_threshold_iff
    {k : ℕ} (hk : 0 < k) :
    (∃ beta : ℝ,
      1 / (k : ℝ) ≤ beta ∧
      neighbourSlope ((1 : ℝ) / 2) k beta < 1) ↔
      4 < k := by
  rw [density_gap_threshold_iff hk]
  constructor
  · intro hthreshold
    have hhalf : (2 : ℝ) < (k : ℝ) / 2 := by
      calc
        (2 : ℝ) < (1 - (1 : ℝ) / 2) * (k : ℝ) := hthreshold
        _ = (k : ℝ) / 2 := by ring
    have hkreal : (4 : ℝ) < (k : ℝ) := by
      nlinarith
    exact_mod_cast hkreal
  · intro hkfour
    have hkreal : (4 : ℝ) < (k : ℝ) := by
      exact_mod_cast hkfour
    have hhalf : (2 : ℝ) < (k : ℝ) / 2 := by
      nlinarith
    calc
      (2 : ℝ) < (k : ℝ) / 2 := hhalf
      _ = (1 - (1 : ℝ) / 2) * (k : ℝ) := by ring

/-- The old square-root exponent-five feasible point is recovered by choosing
`beta = 1/4`, but the present theorem identifies the entire feasible region. -/
theorem quarter_beta_is_feasible_for_squareRoot_of_five_le
    {k : ℕ} (hk : 5 ≤ k) :
    1 / (k : ℝ) ≤ (1 : ℝ) / 4 ∧
      neighbourSlope ((1 : ℝ) / 2) k ((1 : ℝ) / 4) < 1 := by
  simpa [neighbourSlope] using
    LowRadicalDensityBarrier.quarter_radical_slope_feasible_of_exponent_at_least_five hk

#print axioms exists_density_compatible_beta_iff
#print axioms density_gap_threshold_iff
#print axioms no_density_compatible_beta_of_threshold_le
#print axioms exists_positive_epsilon_at_density_edge
#print axioms squareRoot_density_threshold_iff
#print axioms quarter_beta_is_feasible_for_squareRoot_of_five_le

end
end PrimePowerDensityGapThreshold
end IUTThreeClosures
