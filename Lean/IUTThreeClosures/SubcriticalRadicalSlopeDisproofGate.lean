/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Tactic

/-!
# A subcritical radical-slope gate for disproving abc

A concrete family disproves `ABCConjecture` once its logarithmic radical has a
uniform affine upper bound with slope `q` and `(1 + epsilon) * q < 1`, while
its logarithmic height is unbounded.  This module proves that implication and
stores no candidate family or unproved arithmetic input.

For a near-prime-power construction `c = p^k + a`, the intended paper-level
budget is

`q = theta + 1 / k + eta`,

where `a <= (p^k)^theta` and `eta` accounts for the radical of a smooth `c`.
The hard arithmetic task is to construct an unbounded primitive family with
that budget; the implication below is unconditional.
-/

namespace IUTThreeClosures

noncomputable section

/-- Logarithmic height used by `ABCConjecture`. -/
def familyABCHeightLog (a b c : ℕ) : ℝ :=
  Real.log (((max a (max b c) : ℕ) : ℝ))

/-- Logarithmic radical used by `ABCConjecture`. -/
def familyABCRadicalLog (a b c : ℕ) : ℝ :=
  Real.log (((abcRadical (a * b * c) : ℕ) : ℝ))

/-- An unbounded primitive abc family whose radical-log slope is strictly
below `1 / (1 + epsilon)` contradicts the uniform abc constant. -/
theorem not_abcConjecture_of_subcritical_radical_slope
    (a b c : ℕ → ℕ) (q K ε : ℝ)
    (hε : 0 < ε)
    (hsubcritical : (1 + ε) * q < 1)
    (hapos : ∀ n, 0 < a n)
    (hbpos : ∀ n, 0 < b n)
    (hcpos : ∀ n, 0 < c n)
    (hsum : ∀ n, a n + b n = c n)
    (hcoprime : ∀ n, PairwiseCoprimeABC (a n) (b n) (c n))
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ,
      B < familyABCHeightLog (a n) (b n) (c n))
    (hradical : ∀ n : ℕ,
      familyABCRadicalLog (a n) (b n) (c n) ≤
        q * familyABCHeightLog (a n) (b n) (c n) + K) :
    ¬ ABCConjecture := by
  intro habc
  obtain ⟨C, hC⟩ := habc ε hε
  let gap : ℝ := 1 - (1 + ε) * q
  have hgap : 0 < gap := by
    dsimp [gap]
    linarith
  let D : ℝ := (1 + ε) * K + C
  obtain ⟨n, hn⟩ := hunbounded (D / gap)
  have habcN :
      familyABCHeightLog (a n) (b n) (c n) ≤
        (1 + ε) * familyABCRadicalLog (a n) (b n) (c n) + C := by
    simpa [familyABCHeightLog, familyABCRadicalLog] using
      hC (a n) (b n) (c n)
        (hapos n) (hbpos n) (hcpos n)
        (hsum n) (hcoprime n)
  have hone : 0 ≤ 1 + ε := by linarith
  have hscaled :
      (1 + ε) * familyABCRadicalLog (a n) (b n) (c n) ≤
        (1 + ε) *
          (q * familyABCHeightLog (a n) (b n) (c n) + K) :=
    mul_le_mul_of_nonneg_left (hradical n) hone
  have hbound :
      gap * familyABCHeightLog (a n) (b n) (c n) ≤ D := by
    dsimp [gap, D]
    nlinarith [habcN, hscaled]
  have hlarge :
      D < gap * familyABCHeightLog (a n) (b n) (c n) := by
    have hmul :
        D < familyABCHeightLog (a n) (b n) (c n) * gap :=
      (div_lt_iff₀ hgap).mp hn
    nlinarith
  exact (not_lt_of_ge hbound) hlarge

/-- Near-prime-power notation for the same exact gate.  The three displayed
slopes may later be instantiated by interval length, prime-power support, and
smooth-radical loss. -/
theorem not_abcConjecture_of_nearPrimePower_budget
    (a b c : ℕ → ℕ) (theta primeSlope smoothLoss K ε : ℝ)
    (hε : 0 < ε)
    (hsubcritical :
      (1 + ε) * (theta + primeSlope + smoothLoss) < 1)
    (hapos : ∀ n, 0 < a n)
    (hbpos : ∀ n, 0 < b n)
    (hcpos : ∀ n, 0 < c n)
    (hsum : ∀ n, a n + b n = c n)
    (hcoprime : ∀ n, PairwiseCoprimeABC (a n) (b n) (c n))
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ,
      B < familyABCHeightLog (a n) (b n) (c n))
    (hradical : ∀ n : ℕ,
      familyABCRadicalLog (a n) (b n) (c n) ≤
        (theta + primeSlope + smoothLoss) *
          familyABCHeightLog (a n) (b n) (c n) + K) :
    ¬ ABCConjecture := by
  exact not_abcConjecture_of_subcritical_radical_slope
    a b c (theta + primeSlope + smoothLoss) K ε
    hε hsubcritical hapos hbpos hcpos hsum hcoprime hunbounded hradical

#print axioms not_abcConjecture_of_subcritical_radical_slope
#print axioms not_abcConjecture_of_nearPrimePower_budget

end

end IUTThreeClosures
