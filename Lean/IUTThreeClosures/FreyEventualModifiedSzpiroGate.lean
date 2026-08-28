/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyModifiedSzpiroRoute

/-!
# Eventual modified-Szpiro is enough for abc

The difficult modified-Szpiro estimate need only hold above a height
threshold that is uniform in the Frey point.  The unconditional upper corridor

`freyModifiedHeight P <= 6 * height P + log 4096`

absorbs every point below that threshold into one enlarged constant.  This
module contains only that quantifier argument and then applies the existing
uniform modified-Szpiro-to-abc theorem.

No modified-Szpiro estimate, `ABCConjecture`, or external arithmetic theorem
is stored in a structure or supplied as an instance.
-/

namespace IUTThreeClosures

/-- The modified-Szpiro estimate with a height threshold.  For each positive
`epsilon`, both the threshold and the constant are chosen before the Frey
point and are therefore uniform in that point. -/
def EventualFreyModifiedSzpiro : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ H C : ℝ, ∀ P : ABCPoint,
      H ≤ P.height →
        P.freyModifiedHeight ≤
          (6 + 6 * ε) * P.freyDiscriminantConductor + C

private theorem freyDiscriminantConductor_nonneg_eventualGate
    (P : ABCPoint) :
    0 ≤ P.freyDiscriminantConductor := by
  unfold ABCPoint.freyDiscriminantConductor
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (abcRadical_pos P.freyDiscriminantNat).ne')

/-- Enlarge the eventual constant by the explicit low-height corridor bound.
This removes the height threshold without using a finiteness theorem. -/
theorem uniform_freyModifiedSzpiro_of_eventual
    (hMS : EventualFreyModifiedSzpiro) :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ P : ABCPoint,
      P.freyModifiedHeight ≤
        (6 + 6 * ε) * P.freyDiscriminantConductor + C := by
  intro ε hε
  obtain ⟨H, C, hlarge⟩ := hMS ε hε
  refine ⟨max C (6 * H + Real.log 4096), ?_⟩
  intro P
  by_cases hPH : H ≤ P.height
  · exact (hlarge P hPH).trans
      (add_le_add_right (le_max_left C (6 * H + Real.log 4096)) _)
  · have hheight : P.height ≤ H := le_of_lt (lt_of_not_ge hPH)
    have hcoefficient : 0 ≤ 6 + 6 * ε := by linarith
    have hconductor : 0 ≤ P.freyDiscriminantConductor :=
      freyDiscriminantConductor_nonneg_eventualGate P
    have hproduct :
        0 ≤ (6 + 6 * ε) * P.freyDiscriminantConductor :=
      mul_nonneg hcoefficient hconductor
    calc
      P.freyModifiedHeight ≤ 6 * P.height + Real.log 4096 :=
        P.freyModifiedHeight_le
      _ ≤ 6 * H + Real.log 4096 := by linarith
      _ ≤ (6 + 6 * ε) * P.freyDiscriminantConductor +
          max C (6 * H + Real.log 4096) := by
        have hmax :
            6 * H + Real.log 4096 ≤
              max C (6 * H + Real.log 4096) :=
          le_max_right _ _
        linarith

/-- An eventual modified-Szpiro estimate of slope `6 + 6*epsilon` for the
source-derived Frey height implies the logarithmic abc conjecture. -/
theorem abc_of_eventual_freyModifiedSzpiro
    (hMS : EventualFreyModifiedSzpiro) :
    ABCConjecture :=
  abc_of_uniform_freyModifiedSzpiro
    (uniform_freyModifiedSzpiro_of_eventual hMS)

#print axioms uniform_freyModifiedSzpiro_of_eventual
#print axioms abc_of_eventual_freyModifiedSzpiro

end IUTThreeClosures
