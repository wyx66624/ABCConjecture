/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SourceFaithfulDirectSummandPacket
import IUTThreeClosures.SourceFaithfulFinalCapsuleRadialVolume
import Mathlib.Tactic.FieldSimp

/-!
# Source-faithful tensor-factor multiplicity and normalized Haar volume

IUT III, Theorem 3.11(i), applies the local Ind2 action to the direct summands
of the `j + 1` tensor factors attached to a fixed theta label `j`.  The complete
direct-summand theorem already proves that fiberwise Ind1/Ind2/Ind3 choices do
not enlarge the native squared-label packet.  This file specializes the
summand fiber to the actual multiplicity `Fin (j + 1)` and proves the exact
normalization identity hidden in the tensor packet.

Before normalization, repeating the same local component over `j + 1` factors
multiplies its additive Haar log-volume by `j + 1`.  The canonical factor
weight `1 / (j + 1)` cancels this multiplicity exactly.  Summing over the
actual final-capsule labels therefore recovers the existing
`processionLogSum`, not an enlarged coefficient.

The theorem uses the actual adic-completion Haar volume of each local
Tate-power region.  No abstract component-volume function, IUT IV estimate, or
abc statement is supplied.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise BigOperators

namespace FinalCapsule

/-- The source tensor-factor fiber over a final-capsule label. -/
def tensorFactorFiber
    (D : FinalCapsule)
    (j : D.Label) : Type :=
  Fin (D.labelInteger j + 1)

/-- Complete source-faithful tensor-factor packet union. -/
def sourceFaithfulTensorFactorPacketUnion
    (D : FinalCapsule) :
    Set (∀ j : D.Label,
      tensorFactorFiber D j → D.field j) :=
  directSummandPacketUnion D (tensorFactorFiber D)

/-- Native tensor-factor packet. -/
def nativeTensorFactorPacket
    (D : FinalCapsule) :
    Set (∀ j : D.Label,
      tensorFactorFiber D j → D.field j) :=
  nativeDirectSummandPacket D (tensorFactorFiber D)

/-- The literal complete source-faithful tensor-factor packet union is exactly
the native squared-label packet at all `j + 1` factors. -/
theorem sourceFaithfulTensorFactorPacketUnion_eq_native
    (D : FinalCapsule) :
    sourceFaithfulTensorFactorPacketUnion D =
      nativeTensorFactorPacket D := by
  exact directSummandPacketUnion_eq_nativeDirectSummandPacket
    D (tensorFactorFiber D)

/-- Normalized actual Haar log-volume of the `j + 1` tensor-factor packet over
one final-capsule label. -/
noncomputable def normalizedTensorFactorLocalHaarLogVolume
    (D : FinalCapsule)
    (j : D.Label) : ℝ :=
  (1 / ((D.labelInteger j + 1 : ℕ) : ℝ)) *
    ∑ _f : tensorFactorFiber D j,
      actualHaarLogVolume (D.toActualBadPlaceData j)
        ((D.qParam j).qPowerRegion ((D.labelInteger j) ^ 2))

/-- Exact cancellation of the `j + 1` tensor-factor multiplicity. -/
theorem normalizedTensorFactorLocalHaarLogVolume_eq
    (D : FinalCapsule)
    (j : D.Label) :
    normalizedTensorFactorLocalHaarLogVolume D j =
      ((D.labelInteger j) ^ 2 : ℕ) *
        D.signedHaarLogSum j := by
  unfold normalizedTensorFactorLocalHaarLogVolume tensorFactorFiber
  simp_rw [actualHaarLogVolume_qPowerRegion]
  rw [← D.signedHaarLogSum_eq_local j]
  have hne :
      (((D.labelInteger j + 1 : ℕ) : ℝ)) ≠ 0 := by
    positivity
  simp only [Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp [hne]

/-- Global normalized actual Haar log-volume of all source tensor factors. -/
noncomputable def actualTensorFactorNormalizedHaarLogVolume
    (D : FinalCapsule) : ℝ :=
  ∑ j : D.Label,
    normalizedTensorFactorLocalHaarLogVolume D j

/-- **Exact tensor-normalization theorem.**  The actual normalized Haar
log-volume of all `j + 1` source tensor factors is the same procession sum as
the one-coordinate native radial packet. -/
theorem actualTensorFactorNormalizedHaarLogVolume_eq_processionLogSum
    (D : FinalCapsule) :
    actualTensorFactorNormalizedHaarLogVolume D =
      processionLogSum D := by
  unfold actualTensorFactorNormalizedHaarLogVolume processionLogSum
  apply Finset.sum_congr rfl
  intro j _
  exact normalizedTensorFactorLocalHaarLogVolume_eq D j

/-- The tensor-factor and one-coordinate native radial volumes agree. -/
theorem actualTensorFactorNormalizedHaarLogVolume_eq_nativePacketHaarLogVolume
    (D : FinalCapsule) :
    actualTensorFactorNormalizedHaarLogVolume D =
      actualNativePacketHaarLogVolume D := by
  rw [actualTensorFactorNormalizedHaarLogVolume_eq_processionLogSum,
    actualNativePacketHaarLogVolume_eq_processionLogSum]

#print axioms sourceFaithfulTensorFactorPacketUnion_eq_native
#print axioms normalizedTensorFactorLocalHaarLogVolume_eq
#print axioms actualTensorFactorNormalizedHaarLogVolume_eq_processionLogSum
#print axioms actualTensorFactorNormalizedHaarLogVolume_eq_nativePacketHaarLogVolume

end FinalCapsule

end IUTThreeClosures
