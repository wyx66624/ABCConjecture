import IUTThreeClosures.FreyJHeightCorridor
import Heights.WeilHeight

/-!
# Complete local-place reconstruction of the global `j`-height

The strict bridge needs a q-pilot in the opposite direction from a selected
bad-place sub-sum.  At the level of ordinary Weil height there is a canonical
solution: include every finite place with its standard local contribution and
include every archimedean place with its multiplicity.  Mathlib's number-field
height decomposition then identifies the resulting weighted packet exactly
with the absolute normalized global height.

This file formalizes that exact reconstruction.  It closes, at the height
layer, the following pieces of the target:

* all finite places rather than only section-selected places;
* the canonical local-degree/multiplicity weights;
* the archimedean contribution.

It does not yet identify the IUT procession q-pilot with this complete packet;
that comparison still requires the multiradial, different and root-exponent
normalization theorems.
-/

namespace IUTThreeClosures

open NumberField
open scoped BigOperators

/-- The complete nonarchimedean positive-log contribution of `z`. -/
noncomputable def completeFiniteJContribution
    (K : Type*) [Field K] [NumberField K] (z : K) : ℝ :=
  ∑ᶠ v : FinitePlace K, Real.posLog (v z)

/-- The complete archimedean positive-log contribution, with the standard
real/complex multiplicities. -/
noncomputable def completeArchimedeanJContribution
    (K : Type*) [Field K] [NumberField K] (z : K) : ℝ :=
  ∑ v : InfinitePlace K, (v.mult : ℝ) * Real.posLog (v z)

/-- The canonical all-place packet, normalized by the number-field degree. -/
noncomputable def completeGlobalJPacket
    (K : Type*) [Field K] [NumberField K] (z : K) : ℝ :=
  (completeArchimedeanJContribution K z +
      completeFiniteJContribution K z) /
    (Module.finrank ℚ K : ℝ)

/-- Every finite local contribution is nonnegative, hence so is their complete
finite sum. -/
theorem completeFiniteJContribution_nonneg
    (K : Type*) [Field K] [NumberField K] (z : K) :
    0 ≤ completeFiniteJContribution K z := by
  unfold completeFiniteJContribution
  exact finsum_nonneg fun _ => Real.posLog_nonneg

/-- The complete weighted archimedean contribution is nonnegative. -/
theorem completeArchimedeanJContribution_nonneg
    (K : Type*) [Field K] [NumberField K] (z : K) :
    0 ≤ completeArchimedeanJContribution K z := by
  unfold completeArchimedeanJContribution
  apply Finset.sum_nonneg
  intro v _
  exact mul_nonneg (by positivity) Real.posLog_nonneg

/-- The complete all-place packet is nonnegative. -/
theorem completeGlobalJPacket_nonneg
    (K : Type*) [Field K] [NumberField K] (z : K) :
    0 ≤ completeGlobalJPacket K z := by
  unfold completeGlobalJPacket
  exact div_nonneg
    (add_nonneg
      (completeArchimedeanJContribution_nonneg K z)
      (completeFiniteJContribution_nonneg K z))
    (Heights.numberFieldDegree_pos K).le

/-- Exact product-formula reconstruction: the complete weighted packet is the
actual absolute logarithmic Weil height. -/
theorem completeGlobalJPacket_eq_normalizedLogHeight
    (K : Type*) [Field K] [NumberField K] (z : K) :
    completeGlobalJPacket K z = Heights.normalizedLogHeight K z := by
  rw [completeGlobalJPacket, completeArchimedeanJContribution,
    completeFiniteJContribution, Heights.normalizedLogHeight,
    NumberField.logHeight₁_eq]

/-- For the Frey curve over `ℚ`, the complete local packet controls the abc
height in the required direction, with the already verified absolute error
`log 8 / 6`. -/
theorem abcHeight_le_completeFreyJPacket (P : ABCPoint) :
    P.height ≤
      completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 +
        Real.log 8 / 6 := by
  rw [completeGlobalJPacket_eq_normalizedLogHeight]
  exact P.height_le_normalizedLogHeight_abcFrey_j

/-- Equivalently, the complete packet differs from six times the abc height by
an explicit two-sided constant corridor. -/
theorem completeFreyJPacket_corridor (P : ABCPoint) :
    P.height - Real.log 8 / 6 ≤
        completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 ∧
      completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 ≤
        P.height + Real.log 256 / 6 := by
  rw [completeGlobalJPacket_eq_normalizedLogHeight]
  constructor
  · linarith [P.height_le_normalizedLogHeight_abcFrey_j]
  · exact P.normalizedLogHeight_abcFrey_j_div_six_le

end IUTThreeClosures
