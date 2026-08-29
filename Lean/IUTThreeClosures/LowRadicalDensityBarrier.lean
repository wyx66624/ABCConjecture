/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SquareRootSmoothNeighbourThreshold
import Mathlib.Tactic

/-!
# Low-radical density barriers for prime-power neighbour routes

The analytic Rankin bound proved in the accompanying research note says that,
for every fixed `eta > 0`, the number of integers `n <= X` with
`rad(n) <= R` is `O_eta(R * X^eta)`.  Hence a subcritical low-radical theorem
cannot hold after every integer centre.

For prime-power centres `p^k`, a theorem covering a positive-density set of
primes forces the neighbour-radical exponent to be at least `1/k`.  Combined
with a square-root gap and the abc subcritical inequality, this requires
`k > 4`.

This file kernel-formalizes the finite selection and exponent arithmetic.  It
does not axiomatize the Rankin estimate or the prime number theorem.
-/

namespace IUTThreeClosures
namespace LowRadicalDensityBarrier

open SquareRootSmoothNeighbourThreshold

/-- Distinct centres selecting distinct candidates cannot outnumber the finite
candidate set. -/
theorem center_card_le_candidate_card_of_injective_selection
    {Center Candidate : Type*}
    [DecidableEq Center] [DecidableEq Candidate]
    (centers : Finset Center)
    (candidates : Finset Candidate)
    (select : Center → Candidate)
    (hmem : ∀ x ∈ centers, select x ∈ candidates)
    (hinj : ∀ x ∈ centers, ∀ y ∈ centers,
      select x = select y → x = y) :
    centers.card ≤ candidates.card := by
  classical
  let f : {x // x ∈ centers} → {y // y ∈ candidates} :=
    fun x => ⟨select x.1, hmem x.1 x.2⟩
  have hf : Function.Injective f := by
    intro x y hxy
    apply Subtype.ext
    exact hinj x.1 x.2 y.1 y.2 (congrArg Subtype.val hxy)
  simpa using Fintype.card_le_of_injective f hf

/-- The density lower bound `beta >= 1/k`, together with a square-root gap and
subcritical total slope, forces the prime-power exponent to exceed four. -/
theorem exponent_gt_four_of_squareRoot_subcritical_and_density
    {k : ℕ} {beta : ℝ}
    (hk : 0 < k)
    (hdensity : 1 / (k : ℝ) ≤ beta)
    (hsubcritical :
      (1 : ℝ) / 2 + 1 / (k : ℝ) + beta < 1) :
    4 < k := by
  have hkreal : 0 < (k : ℝ) := by exact_mod_cast hk
  have hratio : 2 / (k : ℝ) < (1 : ℝ) / 2 := by
    linarith
  have hmul : (2 : ℝ) < ((1 : ℝ) / 2) * k :=
    (div_lt_iff₀ hkreal).mp hratio
  have hkfour : (4 : ℝ) < k := by
    nlinarith
  exact_mod_cast hkfour

/-- Exponents at most four cannot support a square-root-gap counterexample
budget on a prime-power family dense enough to force `beta >= 1/k`. -/
theorem no_squareRoot_dense_primePower_budget_of_exponent_le_four
    {k : ℕ} {beta : ℝ}
    (hk : 0 < k)
    (hkle : k ≤ 4)
    (hdensity : 1 / (k : ℝ) ≤ beta) :
    ¬ ((1 : ℝ) / 2 + 1 / (k : ℝ) + beta < 1) := by
  intro hsubcritical
  have hgt :=
    exponent_gt_four_of_squareRoot_subcritical_and_density
      hk hdensity hsubcritical
  omega

/-- Starting at exponent five, the density lower slope `1/k` and the
square-root subcritical upper slope leave a genuine interval.  The universal
choice `beta = 1/4` lies inside it. -/
theorem quarter_radical_slope_feasible_of_exponent_at_least_five
    {k : ℕ}
    (hk : 5 ≤ k) :
    1 / (k : ℝ) ≤ (1 : ℝ) / 4 ∧
      (1 : ℝ) / 2 + 1 / (k : ℝ) + (1 : ℝ) / 4 < 1 := by
  have hkposNat : 0 < k := by omega
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast hkposNat
  have hkfive : (5 : ℝ) ≤ k := by exact_mod_cast hk
  constructor
  · apply (div_le_iff₀ hkpos).2
    nlinarith
  · have hdiv : 1 / (k : ℝ) ≤ (1 : ℝ) / 5 := by
      apply (div_le_iff₀ hkpos).2
      nlinarith
    linarith

/-- Consequently, every exponent `k >= 5` admits a positive epsilon margin at
square-root gap scale with neighbour-radical slope `1/4`. -/
theorem exists_positive_epsilon_for_quarter_radical_slope
    {k : ℕ}
    (hk : 5 ≤ k) :
    ∃ epsilon : ℝ, 0 < epsilon ∧
      (1 + epsilon) *
        squareRootNeighbourSlope (1 / (k : ℝ)) ((1 : ℝ) / 4) < 1 := by
  have hwindow := quarter_radical_slope_feasible_of_exponent_at_least_five hk
  apply exists_positive_epsilon_for_squareRoot_budget
  · have hkposNat : 0 < k := by omega
    have hkpos : 0 < (k : ℝ) := by exact_mod_cast hkposNat
    positivity
  · norm_num
  · dsimp
    linarith [hwindow.2]

#print axioms center_card_le_candidate_card_of_injective_selection
#print axioms exponent_gt_four_of_squareRoot_subcritical_and_density
#print axioms no_squareRoot_dense_primePower_budget_of_exponent_le_four
#print axioms quarter_radical_slope_feasible_of_exponent_at_least_five
#print axioms exists_positive_epsilon_for_quarter_radical_slope

end LowRadicalDensityBarrier
end IUTThreeClosures
