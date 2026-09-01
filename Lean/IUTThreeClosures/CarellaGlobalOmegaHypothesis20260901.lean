/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SubcriticalRadicalSlopeDisproofGate
import IUTThreeClosures.PrimePowerDensityGapThreshold

/-!
# The printed global-omega hypothesis and the retained radical target

The paper proof precedes this implementation in
`research/ABC_CARELLA_GLOBAL_OMEGA_HYPOTHESIS_2026_09_01.md`.

The first part proves the exact finite core of the primorial-multiple
counterexample. If `Q` has more than `w` distinct prime factors, every positive
multiple of `Q` has more than `w` distinct prime factors. Consequently there
are at least `N / Q` such integers up to `N`.

The second part keeps the positive route. At interval exponent `3/5`, a
nonnegative prime-support slope `kappa` and neighbour-radical slope `sigma`
are subcritical as soon as `sigma < 2/5 - kappa`. We construct a positive
`epsilon` and apply the repository's unconditional radical-slope disproof
gate. No arithmetic family or analytic existence theorem is postulated.
-/

namespace IUTThreeClosures
namespace CarellaGlobalOmegaHypothesis20260901

/-- Positive integers at most `N` having more than `w` distinct prime
divisors. -/
noncomputable def highOmegaUpTo (N w : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 1 N).filter (fun n => w < n.primeFactors.card)

/-- The positive multiples `m * Q` with `m ≤ N / Q`. -/
noncomputable def positiveMultiplesUpTo (N Q : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 1 (N / Q)).image (fun m => m * Q)

/-- Multiplication by a positive natural number is injective. -/
theorem mul_right_injective_of_pos {Q : ℕ} (hQ : 0 < Q) :
    Function.Injective (fun m : ℕ => m * Q) := by
  intro a b hab
  exact Nat.eq_of_mul_eq_mul_right hQ hab

/-- There are exactly `N / Q` positive multiples of a positive `Q` in the
chosen finite packet. -/
theorem positiveMultiplesUpTo_card (N : ℕ) {Q : ℕ} (hQ : 0 < Q) :
    (positiveMultiplesUpTo N Q).card = N / Q := by
  classical
  rw [positiveMultiplesUpTo,
    Finset.card_image_of_injective _ (mul_right_injective_of_pos hQ)]
  simp

/-- Every positive multiple of `Q` retains all prime factors of `Q`. -/
theorem primeFactors_card_le_mul {m Q : ℕ} (hm : 0 < m) (hQ : 0 < Q) :
    Q.primeFactors.card ≤ (m * Q).primeFactors.card := by
  apply Finset.card_le_card
  exact Nat.primeFactors_mono
    (by exact ⟨m, by simp [Nat.mul_comm]⟩)
    (Nat.mul_ne_zero hm.ne' hQ.ne')

/-- Exact finite lower bound behind the counterexample to the printed global
high-omega estimate. -/
theorem highOmegaUpTo_card_lower (N Q w : ℕ)
    (hQ : 0 < Q) (homega : w < Q.primeFactors.card) :
    N / Q ≤ (highOmegaUpTo N w).card := by
  classical
  have hsub : positiveMultiplesUpTo N Q ⊆ highOmegaUpTo N w := by
    intro n hn
    obtain ⟨m, hm, rfl⟩ := Finset.mem_image.mp hn
    have hmIcc : m ∈ Finset.Icc 1 (N / Q) := hm
    have hmpos : 0 < m := by
      have := (Finset.mem_Icc.mp hmIcc).1
      omega
    have hmn : m ≤ N / Q := (Finset.mem_Icc.mp hmIcc).2
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_Icc.mpr ⟨?_, ?_⟩, ?_⟩
    · exact Nat.mul_pos hmpos hQ
    · calc
        m * Q ≤ (N / Q) * Q := Nat.mul_le_mul_right Q hmn
        _ ≤ N := Nat.div_mul_le_self N Q
    · exact homega.trans_le (primeFactors_card_le_mul hmpos hQ)
  rw [← positiveMultiplesUpTo_card N hQ]
  exact Finset.card_le_card hsub

/-- The wider radical target at exponent `3/5` is strictly below slope one. -/
theorem threeFifths_target_lt_one {kappa sigma : ℝ}
    (htarget : sigma < (2 : ℝ) / 5 - kappa) :
    (3 : ℝ) / 5 + kappa + sigma < 1 := by
  linarith

/-- Every nonnegative slope strictly below one admits some positive abc
epsilon for which the scaled slope remains below one. -/
theorem exists_positive_epsilon_scaled_lt_one {q : ℝ}
    (hqone : q < 1) :
    ∃ epsilon : ℝ, 0 < epsilon ∧ (1 + epsilon) * q < 1 := by
  let epsilon : ℝ := (1 - q) / 2
  have hepsilon : 0 < epsilon := by
    dsimp [epsilon]
    linarith
  have hleft : 0 < 1 - q := by linarith
  have hright : 0 < 1 - q / 2 := by linarith
  have hprod : 0 < (1 - q) * (1 - q / 2) :=
    mul_pos hleft hright
  refine ⟨epsilon, hepsilon, ?_⟩
  dsimp [epsilon]
  nlinarith

/-- A strict radical-neighbour target `sigma < 2/5 - kappa` automatically
supplies an abc epsilon. -/
theorem exists_epsilon_of_threeFifths_radical_target
    {kappa sigma : ℝ}
    (htarget : sigma < (2 : ℝ) / 5 - kappa) :
    ∃ epsilon : ℝ, 0 < epsilon ∧
      (1 + epsilon) * ((3 : ℝ) / 5 + kappa + sigma) < 1 := by
  apply exists_positive_epsilon_scaled_lt_one
  exact threeFifths_target_lt_one htarget

/-- If radical counting forces the density lower slope `1/k`, then a
three-fifths-gap radical target exists exactly from exponent six onward.  The
analytic argument forcing the density lower slope is not asserted here; this
theorem checks its exact exponent arithmetic. -/
theorem threeFifths_density_threshold_iff {k : ℕ} (hk : 0 < k) :
    (∃ sigma : ℝ,
      1 / (k : ℝ) ≤ sigma ∧
      PrimePowerDensityGapThreshold.neighbourSlope
        ((3 : ℝ) / 5) k sigma < 1) ↔
      5 < k := by
  rw [PrimePowerDensityGapThreshold.density_gap_threshold_iff hk]
  constructor
  · intro hthreshold
    have hkreal : (5 : ℝ) < (k : ℝ) := by
      nlinarith [hthreshold]
    exact_mod_cast hkreal
  · intro hkfive
    have hkreal : (5 : ℝ) < (k : ℝ) := by
      exact_mod_cast hkfive
    nlinarith

/-- The universal density-compatible point `sigma = 1/5` works for every
prime-power exponent at least six. -/
theorem oneFifth_radical_slope_feasible_of_exponent_at_least_six
    {k : ℕ} (hk : 6 ≤ k) :
    1 / (k : ℝ) ≤ (1 : ℝ) / 5 ∧
      (3 : ℝ) / 5 + 1 / (k : ℝ) + (1 : ℝ) / 5 < 1 := by
  have hkposNat : 0 < k := by omega
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast hkposNat
  have hksix : (6 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
  constructor
  · apply (div_le_iff₀ hkpos).2
    nlinarith
  · have hdiv : 1 / (k : ℝ) ≤ (1 : ℝ) / 6 := by
      apply (div_le_iff₀ hkpos).2
      nlinarith
    linarith

/-- Consequently the universal one-fifth radical target has a positive fixed
abc epsilon margin for every exponent at least six. -/
theorem exists_epsilon_for_oneFifth_radical_slope_of_exponent_at_least_six
    {k : ℕ} (hk : 6 ≤ k) :
    ∃ epsilon : ℝ, 0 < epsilon ∧
      (1 + epsilon) *
        ((3 : ℝ) / 5 + 1 / (k : ℝ) + (1 : ℝ) / 5) < 1 := by
  have hwindow :=
    oneFifth_radical_slope_feasible_of_exponent_at_least_six hk
  apply exists_positive_epsilon_scaled_lt_one
  exact hwindow.2

/-- Unconditional composition of the wider `3/5` radical target with the
existing abstract disproof gate. The hypotheses still require an actual
unbounded primitive family and its radical-log estimate. -/
theorem not_abcConjecture_of_threeFifths_radical_target
    (a b c : ℕ → ℕ) (kappa sigma K : ℝ)
    (htarget : sigma < (2 : ℝ) / 5 - kappa)
    (hapos : ∀ n, 0 < a n)
    (hbpos : ∀ n, 0 < b n)
    (hcpos : ∀ n, 0 < c n)
    (hsum : ∀ n, a n + b n = c n)
    (hcoprime : ∀ n, PairwiseCoprimeABC (a n) (b n) (c n))
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ,
      B < familyABCHeightLog (a n) (b n) (c n))
    (hradical : ∀ n : ℕ,
      familyABCRadicalLog (a n) (b n) (c n) ≤
        ((3 : ℝ) / 5 + kappa + sigma) *
          familyABCHeightLog (a n) (b n) (c n) + K) :
    ¬ ABCConjecture := by
  obtain ⟨epsilon, hepsilon, hsubcritical⟩ :=
    exists_epsilon_of_threeFifths_radical_target
      htarget
  exact not_abcConjecture_of_nearPrimePower_budget
    a b c ((3 : ℝ) / 5) kappa sigma K epsilon
    hepsilon hsubcritical hapos hbpos hcpos hsum hcoprime
    hunbounded hradical

#print axioms mul_right_injective_of_pos
#print axioms positiveMultiplesUpTo_card
#print axioms primeFactors_card_le_mul
#print axioms highOmegaUpTo_card_lower
#print axioms threeFifths_target_lt_one
#print axioms exists_positive_epsilon_scaled_lt_one
#print axioms exists_epsilon_of_threeFifths_radical_target
#print axioms threeFifths_density_threshold_iff
#print axioms oneFifth_radical_slope_feasible_of_exponent_at_least_six
#print axioms exists_epsilon_for_oneFifth_radical_slope_of_exponent_at_least_six
#print axioms not_abcConjecture_of_threeFifths_radical_target

end CarellaGlobalOmegaHypothesis20260901
end IUTThreeClosures
