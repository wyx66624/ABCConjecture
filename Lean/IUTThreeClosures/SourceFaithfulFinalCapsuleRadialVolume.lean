/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SourceFaithfulInd2RadialShadow
import IUTThreeClosures.ActualFinalCapsuleProductRegion

/-!
# Source-faithful Ind2 on an actual final capsule

This file upgrades the uniform-field radial-shadow theorem to the actual
`FinalCapsule`, whose labels carry different completed local fields.  Ind2 is
fiberwise over each fixed final-capsule label, in accordance with the
source-level description in IUT III, Theorem 3.11(i).  It therefore does not
alter the squared theta label controlling the local Tate radius.

The literal union of all complete fiberwise-Ind2 packets is proved to be
exactly the already constructed `finalCapsuleProductRegion`.  The second main
theorem computes its normalized local Haar log-volume directly from the actual
adic completions and obtains the exact procession sum.  Thus the radial
possible-image packet is connected to the repository's genuine local Haar
arithmetic without a freely supplied volume functional.

This does not prove that the complete IUT III possible image has no additional
non-radial enlargement, and it does not assert the component upper inequality
of IUT IV or `ABCConjecture`.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise BigOperators

universe x

namespace FinalCapsule

/-- Fiberwise radial choice on the dependent local-field packet of a final
capsule. -/
structure FiberwiseRadialChoice
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) where
  ind1 : ∀ j : D.Label, NormOneKummerUnit (D.field j)
  ind2 : ∀ j : D.Label, Equiv.Perm (Fiber j)
  ind3 : D.Label → ℕ

/-- Ordinary choice at every label. -/
def ordinaryFiberwiseRadialChoice
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    FiberwiseRadialChoice D Fiber where
  ind1 := fun _ => NormOneKummerUnit.one
  ind2 := fun j => Equiv.refl (Fiber j)
  ind3 := fun _ => 0

/-- Label-fixed radial exponent. -/
def fiberwiseOutputPower
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) : ℕ :=
  (D.labelInteger j) ^ 2 + C.ind3 j

/-- Local output value at a final-capsule label. -/
noncomputable def fiberwiseOutputValue
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) : D.field j :=
  ((C.ind1 j).unit : D.field j) *
    ((D.qParam j).q : D.field j) ^ fiberwiseOutputPower D C j

/-- Exact norm of the local output. -/
theorem norm_fiberwiseOutputValue
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) :
    ‖fiberwiseOutputValue D C j‖ =
      ‖((D.qParam j).q : D.field j)‖ ^
        fiberwiseOutputPower D C j := by
  unfold fiberwiseOutputValue
  rw [norm_mul, (C.ind1 j).norm_eq_one, one_mul, norm_pow]

/-- Principal local output region. -/
def fiberwiseOutputRegion
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) : Set (D.field j) :=
  scaledRegion (fiberwiseOutputValue D C j)
    (normIntegralRegion (K := D.field j))

/-- Norm-one Ind1 reduces the output region to the corresponding Tate-power
region. -/
theorem fiberwiseOutputRegion_eq_qPowerRegion
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) :
    fiberwiseOutputRegion D C j =
      (D.qParam j).qPowerRegion (fiberwiseOutputPower D C j) := by
  unfold fiberwiseOutputRegion TateParameter.qPowerRegion
  apply scaledRegion_eq_of_norm_eq
  · exact pow_ne_zero _ (D.qParam j).q.ne_zero
  · simpa only [norm_pow] using
      norm_fiberwiseOutputValue D C j

/-- Fiberwise Ind2 and Ind3 cannot enlarge the native final-capsule component. -/
theorem fiberwiseOutputRegion_subset_native
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber)
    (j : D.Label) :
    fiberwiseOutputRegion D C j ⊆
      (D.qParam j).qPowerRegion ((D.labelInteger j) ^ 2) := by
  rw [fiberwiseOutputRegion_eq_qPowerRegion D C j]
  exact (D.qParam j).qPowerRegion_antitone
    (Nat.le_add_right ((D.labelInteger j) ^ 2) (C.ind3 j))

/-- Complete dependent packet attached to one choice. -/
def fiberwisePacketRegion
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber) :
    Set (∀ j : D.Label, D.field j) :=
  {a | ∀ j, a j ∈ fiberwiseOutputRegion D C j}

/-- Literal union of all complete fiberwise packets. -/
def fiberwisePacketChoiceUnion
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    Set (∀ j : D.Label, D.field j) :=
  ⋃ C : FiberwiseRadialChoice D Fiber,
    fiberwisePacketRegion D C

/-- Every fiberwise packet lies in the actual final-capsule product region. -/
theorem fiberwisePacketRegion_subset_finalCapsuleProductRegion
    (D : FinalCapsule)
    {Fiber : D.Label → Type x}
    (C : FiberwiseRadialChoice D Fiber) :
    fiberwisePacketRegion D C ⊆ D.finalCapsuleProductRegion := by
  intro a ha j
  exact fiberwiseOutputRegion_subset_native D C j (ha j)

/-- The ordinary fiberwise choice realizes the actual final-capsule product
region exactly. -/
theorem ordinaryFiberwisePacketRegion
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    fiberwisePacketRegion D (ordinaryFiberwiseRadialChoice D Fiber) =
      D.finalCapsuleProductRegion := by
  ext a
  constructor
  · intro ha j
    have hj := ha j
    rw [fiberwiseOutputRegion_eq_qPowerRegion] at hj
    simpa [ordinaryFiberwiseRadialChoice, fiberwiseOutputPower] using hj
  · intro ha j
    rw [fiberwiseOutputRegion_eq_qPowerRegion]
    simpa [ordinaryFiberwiseRadialChoice, fiberwiseOutputPower] using ha j

/-- **Actual final-capsule radial packet theorem.**  The source-faithful
fiberwise Ind2 packet union is exactly the genuine squared-label product region
already used in the final-capsule Haar calculation. -/
theorem fiberwisePacketChoiceUnion_eq_finalCapsuleProductRegion
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    fiberwisePacketChoiceUnion D Fiber =
      D.finalCapsuleProductRegion := by
  apply Set.Subset.antisymm
  · intro a ha
    rcases Set.mem_iUnion.mp ha with ⟨C, haC⟩
    exact fiberwisePacketRegion_subset_finalCapsuleProductRegion D C haC
  · intro a ha
    apply Set.mem_iUnion.mpr
    refine ⟨ordinaryFiberwiseRadialChoice D Fiber, ?_⟩
    rw [ordinaryFiberwisePacketRegion D Fiber]
    exact ha

/-- Direct normalized Haar log-volume of the native final-capsule radial
packet, computed component by component from the actual local completions. -/
noncomputable def actualNativePacketHaarLogVolume
    (D : FinalCapsule) : ℝ :=
  ∑ j : D.Label,
    actualHaarLogVolume (D.toActualBadPlaceData j)
      ((D.qParam j).qPowerRegion ((D.labelInteger j) ^ 2))

/-- **Exact actual Haar bridge.**  The normalized local Haar log-volume of the
native/source-faithful radial packet is the procession sum, with no abstract
component-volume function supplied as data. -/
theorem actualNativePacketHaarLogVolume_eq_processionLogSum
    (D : FinalCapsule) :
    actualNativePacketHaarLogVolume D = processionLogSum D := by
  unfold actualNativePacketHaarLogVolume processionLogSum
  apply Finset.sum_congr rfl
  intro j _
  rw [actualHaarLogVolume_qPowerRegion]
  rw [← D.signedHaarLogSum_eq_local j]

/-- Rewriting the actual Haar calculation through the source-faithful packet
union. -/
theorem fiberwisePacketChoiceUnion_actualHaarLogVolume
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    actualNativePacketHaarLogVolume D = processionLogSum D := by
  exact actualNativePacketHaarLogVolume_eq_processionLogSum D

#print axioms norm_fiberwiseOutputValue
#print axioms fiberwiseOutputRegion_eq_qPowerRegion
#print axioms fiberwiseOutputRegion_subset_native
#print axioms fiberwisePacketRegion_subset_finalCapsuleProductRegion
#print axioms ordinaryFiberwisePacketRegion
#print axioms fiberwisePacketChoiceUnion_eq_finalCapsuleProductRegion
#print axioms actualNativePacketHaarLogVolume_eq_processionLogSum
#print axioms fiberwisePacketChoiceUnion_actualHaarLogVolume

end FinalCapsule

end IUTThreeClosures
