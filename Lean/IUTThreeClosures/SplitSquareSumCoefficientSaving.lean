/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SplitSquareRadicalTransfer
import Mathlib.Tactic

/-!
# Power-saving coefficient in the split-square companion sum

In the complementary branch of the split-square radical transfer, write the
companion sum as

`s = A*r^2`.

If `Ts = log s`, `Ks = log A`, and `q = log r`, then `Ts = Ks + 2*q`.
The square-gain inequality and the elementary upper bound `s < 2y` imply the
exact coefficient saving

`Ks < alpha_epsilon*H + U - K + L`,

where `U` records the fixed upper loss (normally `log 2`).
-/

namespace IUTThreeClosures
namespace SplitSquareSumCoefficientSaving

open SplitSquareRadicalTransfer

noncomputable section

/-- A height-scale square divisor gives an exact power saving for the
squarefree companion coefficient. -/
theorem coefficient_small_of_sumSquareGain
    {epsilon H K L U Ts Ks q : ℝ}
    (hepsilon : 0 < epsilon)
    (hsumUpper : Ts ≤ H + U)
    (hdecomp : Ts = Ks + 2 * q)
    (hgain :
      (1 - halfEpsilonCriticalAlpha epsilon) * H + K - L <
        2 * q) :
    Ks < halfEpsilonCriticalAlpha epsilon * H + U - K + L := by
  nlinarith

/-- Complete coefficient-level split-square dichotomy. -/
theorem rootViolation_or_sumCoefficientSmall
    {epsilon H Rroot Rsum Ts Ks q C K L U : ℝ}
    (hepsilon : 0 < epsilon)
    (hH : 0 ≤ H)
    (hviolation :
      (1 + epsilon) * (Rroot + Rsum) + C < 2 * H)
    (hsumSize : H - L ≤ Ts)
    (hsumUpper : Ts ≤ H + U)
    (hsquareBudget : Ts ≤ Rsum + 2 * q)
    (hdecomp : Ts = Ks + 2 * q) :
    ((1 + epsilon / 2) * Rroot +
        ((1 + epsilon / 2) / (1 + epsilon)) *
          (C - (1 + epsilon) * K) < H) ∨
      (Ks < halfEpsilonCriticalAlpha epsilon * H + U - K + L) := by
  have hsplit := rootViolation_or_sumSquareGain
    hepsilon hH hviolation hsumSize hsquareBudget
  rcases hsplit with hroot | hgain
  · exact Or.inl hroot
  · exact Or.inr
      (coefficient_small_of_sumSquareGain
        hepsilon hsumUpper hdecomp hgain)

/-- The coefficient exponent is genuinely below one. -/
theorem companionCoefficientExponent_lt_one
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    halfEpsilonCriticalAlpha epsilon < 1 :=
  halfEpsilonCriticalAlpha_lt_one hepsilon

#print axioms coefficient_small_of_sumSquareGain
#print axioms rootViolation_or_sumCoefficientSmall
#print axioms companionCoefficientExponent_lt_one

end
end SplitSquareSumCoefficientSaving
end IUTThreeClosures
