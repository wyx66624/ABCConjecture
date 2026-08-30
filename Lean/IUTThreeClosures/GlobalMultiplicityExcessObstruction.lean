/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import IUTThreeClosures.CubefulExponentOneLayer
import Mathlib.Tactic

/-!
# Global prime-multiplicity obstruction forced by every abc violation

For a positive primitive abc point define

`Sigma = log(abc) - 2*log rad(abc)`.

The universal inequality `2*log c-log 2 <= log(abc)` shows that every
coefficient-`1+epsilon` abc violation forces

`Sigma > 2*epsilon*conductor + O(1)`.

Using the exact cubeful/exponent-one layer identity, this says that the full
cubeful mass of `abc` must dominate its entire exponent-one prime layer by a
positive conductor-scale amount.  This is a necessary condition, not an abc
proof.
-/

namespace IUTThreeClosures
namespace GlobalMultiplicityExcessObstruction

open SymmetricProductCoefficientBarrier
open LargeEndpointCubefulExcess
open LargeEndpointSignedMultiplicityExcess
open CubefulExponentOneLayer

noncomputable section

namespace ABCPoint

/-- Signed prime-multiplicity excess of the complete abc product. -/
def globalSignedMultiplicityExcess (P : ABCPoint) : ℝ :=
  SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P -
    2 * P.conductor

/-- The global excess is the ordinary signed multiplicity excess of `abc`. -/
theorem globalSignedMultiplicityExcess_eq (P : ABCPoint) :
    P.globalSignedMultiplicityExcess =
      signedMultiplicityExcess (P.a * P.b * P.c) := by
  rfl

/-- Every pointwise abc violation forces positive conductor-scale global
multiplicity excess. -/
theorem globalSignedMultiplicityExcess_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 <
      P.globalSignedMultiplicityExcess := by
  have hlower :=
    SymmetricProductCoefficientBarrier.ABCPoint.two_height_sub_log_two_le_symmetricProductLog P
  unfold globalSignedMultiplicityExcess
  nlinarith

/-- Full cubeful quotient of the abc product. -/
def globalCubefulExcess (P : ABCPoint) : ℕ :=
  cubefulExcess (P.a * P.b * P.c)

/-- Full exact-exponent-one layer of the abc product. -/
def globalExponentOneLayer (P : ABCPoint) : ℕ :=
  exponentOneLayer (P.a * P.b * P.c)

@[simp]
theorem globalCubefulExcess_pos (P : ABCPoint) :
    0 < P.globalCubefulExcess := by
  unfold globalCubefulExcess
  apply cubefulExcess_pos
  exact mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos

@[simp]
theorem globalExponentOneLayer_pos (P : ABCPoint) :
    0 < P.globalExponentOneLayer := by
  unfold globalExponentOneLayer
  exact exponentOneLayer_pos _

/-- Exact global layer decomposition. -/
theorem globalSignedMultiplicityExcess_eq_layers (P : ABCPoint) :
    P.globalSignedMultiplicityExcess =
      Real.log (P.globalCubefulExcess : ℝ) -
        Real.log (P.globalExponentOneLayer : ℝ) := by
  rw [P.globalSignedMultiplicityExcess_eq]
  unfold globalCubefulExcess globalExponentOneLayer
  exact signedMultiplicityExcess_eq_log_cubefulExcess_sub_log_exponentOneLayer
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos)

/-- Every abc violation forces global cubeful mass to dominate the complete
exponent-one layer. -/
theorem globalCubefulExcess_dominates_exponentOneLayer_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 +
        Real.log (P.globalExponentOneLayer : ℝ) <
      Real.log (P.globalCubefulExcess : ℝ) := by
  have hglobal :=
    P.globalSignedMultiplicityExcess_large_of_height_violation hviolation
  rw [P.globalSignedMultiplicityExcess_eq_layers] at hglobal
  linarith

/-- A coefficient-three symmetric-product estimate gives the corresponding
upper corridor for the global multiplicity excess. -/
theorem globalSignedMultiplicityExcess_le_of_coefficient_three
    (P : ABCPoint) {eta K : ℝ}
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + eta * P.height + K) :
    P.globalSignedMultiplicityExcess ≤
      P.conductor + eta * P.height + K := by
  unfold globalSignedMultiplicityExcess
  linarith

end ABCPoint

#print axioms ABCPoint.globalSignedMultiplicityExcess_large_of_height_violation
#print axioms ABCPoint.globalSignedMultiplicityExcess_eq_layers
#print axioms ABCPoint.globalCubefulExcess_dominates_exponentOneLayer_of_height_violation
#print axioms ABCPoint.globalSignedMultiplicityExcess_le_of_coefficient_three

end
end GlobalMultiplicityExcessObstruction
end IUTThreeClosures
