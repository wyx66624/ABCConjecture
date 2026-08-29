/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArbitraryInd2ComponentCollapse
import IUTThreeClosures.SpectrumPreservingInd2Envelope

/-!
# Packet-level Ind2 and mono-analytic product hulls

The earlier component audit showed that an arbitrary `Ind2` permutation makes
an independently unioned coordinate equal to the full norm unit ball whenever
there is one zero theta label.  A possible objection is that the public theta
construction retains the whole packet before taking the holomorphic hull.

This file removes that objection.  It forms the literal union of the complete
packet regions and proves that its least rectangular/product envelope is still
the full product of norm unit balls.  The proof is joint, not componentwise:
for any coordinate and any unit-ball value, one concrete packet in the union
realizes that value at the selected coordinate and zero at all other
coordinates.  Consequently every product region containing the packet union
must contain the entire unit packet.

The second result records the surviving alternative.  If `Ind2` preserves the
source label spectrum, then the literal union of complete packets is exactly
the ordinary squared-label Tate packet.  One ordinary choice realizes all
coordinates simultaneously, so there is no invalid interchange of unions and
products.

No volume inequality, IUT IV estimate, or abc statement is assumed here.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Pointwise

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

namespace ThetaIndeterminacyChoice

/-- Literal union of the complete packet regions over all Ind1/Ind2/Ind3
choices. -/
def packetChoiceUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  ⋃ C : ThetaIndeterminacyChoice K Label,
    C.packetRegion t labelNat

/-- Product of normalized local integer balls at all packet coordinates. -/
def unitPacketRegion : Set (Label → K) :=
  {x | ∀ j, x j ∈ normIntegralRegion (K := K)}

/-- A rectangular region in the packet carrier. -/
def productRegion (component : Label → Set K) : Set (Label → K) :=
  {x | ∀ j, x j ∈ component j}

/-- Predicate saying that a packet region is a direct product of component
regions. -/
def IsProductRegion (U : Set (Label → K)) : Prop :=
  ∃ component : Label → Set K, U = productRegion component

/-- Every concrete choice packet is contained in the normalized unit packet. -/
theorem packetRegion_subset_unitPacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label) :
    C.packetRegion t labelNat ⊆ unitPacketRegion := by
  intro x hx j
  exact C.outputRegion_subset_normIntegralRegion t labelNat j (hx j)

/-- Hence the literal complete-packet union is contained in the unit packet. -/
theorem packetChoiceUnion_subset_unitPacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    packetChoiceUnion t labelNat ⊆ unitPacketRegion := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
  exact packetRegion_subset_unitPacketRegion t labelNat C hxC

/-- Packet supported at one coordinate. -/
def coordinateSpike
    [DecidableEq Label]
    (j : Label) (z : K) : Label → K :=
  fun k => if k = j then z else 0

@[simp]
theorem coordinateSpike_apply_self
    [DecidableEq Label]
    (j : Label) (z : K) :
    coordinateSpike j z j = z := by
  simp [coordinateSpike]

@[simp]
theorem coordinateSpike_apply_of_ne
    [DecidableEq Label]
    {j k : Label} (hkj : k ≠ j) (z : K) :
    coordinateSpike j z k = 0 := by
  simp [coordinateSpike, hkj]

/-- With one zero label, every unit-ball value can be realized at an arbitrary
chosen coordinate by one genuine complete packet; all other coordinates are
set to zero, which lies in every Tate-power region. -/
theorem coordinateSpike_mem_packetChoiceUnion
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (zeroLabel j : Label)
    (hzero : labelNat zeroLabel = 0)
    {z : K}
    (hz : z ∈ normIntegralRegion (K := K)) :
    coordinateSpike j z ∈ packetChoiceUnion t labelNat := by
  apply Set.mem_iUnion.mpr
  let C : ThetaIndeterminacyChoice K Label :=
    zeroTargetChoice (K := K) j zeroLabel
  refine ⟨C, ?_⟩
  intro k
  by_cases hkj : k = j
  · subst k
    rw [coordinateSpike_apply_self]
    simpa [C] using
      (show z ∈
        (zeroTargetChoice (K := K) j zeroLabel).outputRegion
          t labelNat j by
        rw [zeroTargetChoice_outputRegion t labelNat j zeroLabel hzero]
        exact hz)
  · rw [coordinateSpike_apply_of_ne hkj]
    rw [C.outputRegion_eq_qPowerRegion t labelNat k]
    exact t.zero_mem_qPowerRegion _

/-- **Packet-level collapse theorem.**  The unit packet is the least product
region containing the literal union of all complete arbitrary-Ind2 packets.
Thus retaining joint packets before taking a rectangular holomorphic hull does
not rescue the q-radii in this candidate model. -/
theorem unitPacketRegion_isLeastProductHull
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (zeroLabel : Label)
    (hzero : labelNat zeroLabel = 0) :
    packetChoiceUnion t labelNat ⊆ unitPacketRegion ∧
      ∀ V : Set (Label → K),
        IsProductRegion V →
        packetChoiceUnion t labelNat ⊆ V →
        unitPacketRegion ⊆ V := by
  constructor
  · exact packetChoiceUnion_subset_unitPacketRegion t labelNat
  · intro V hV hUnion x hx
    rcases hV with ⟨component, rfl⟩
    intro j
    have hspike :
        coordinateSpike j (x j) ∈ productRegion component :=
      hUnion
        (coordinateSpike_mem_packetChoiceUnion
          t labelNat zeroLabel j hzero (hx j))
    simpa [productRegion] using hspike j

/-- The product-unit packet is itself a product region. -/
theorem unitPacketRegion_isProductRegion :
    IsProductRegion (unitPacketRegion (K := K) (Label := Label)) := by
  refine ⟨fun _ => normIntegralRegion (K := K), ?_⟩
  rfl

/-- The ordinary squared-label Tate packet. -/
def nativePacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  {x | ∀ j, x j ∈ t.qPowerRegion ((labelNat j) ^ 2)}

/-- Literal union of complete packets over choices whose `Ind2` permutation
preserves the source label spectrum. -/
def spectrumPreservingPacketUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  ⋃ C : {C : ThetaIndeterminacyChoice K Label //
      C.PreservesLabelNat labelNat},
    C.1.packetRegion t labelNat

/-- **Joint spectrum-preserving theorem.**  The complete-packet union over all
spectrum-preserving choices is exactly the native squared-label Tate packet.
The reverse inclusion is realized by one ordinary choice simultaneously at
all coordinates. -/
theorem spectrumPreservingPacketUnion_eq_nativePacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    spectrumPreservingPacketUnion t labelNat =
      nativePacketRegion t labelNat := by
  apply Set.Subset.antisymm
  · intro x hx j
    rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
    exact C.2.outputRegion_subset_native t labelNat j (hxC j)
  · intro x hx
    apply Set.mem_iUnion.mpr
    let C : {C : ThetaIndeterminacyChoice K Label //
        C.PreservesLabelNat labelNat} :=
      ⟨nativeChoice, nativeChoice_preservesLabelNat labelNat⟩
    refine ⟨C, ?_⟩
    intro j
    rw [C.1.nativeChoice_outputRegion t labelNat j]
    exact hx j

/-- The native packet is a genuine product region. -/
theorem nativePacketRegion_isProductRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    IsProductRegion (nativePacketRegion t labelNat) := by
  refine ⟨fun j => t.qPowerRegion ((labelNat j) ^ 2), ?_⟩
  rfl

#print axioms packetRegion_subset_unitPacketRegion
#print axioms packetChoiceUnion_subset_unitPacketRegion
#print axioms coordinateSpike_mem_packetChoiceUnion
#print axioms unitPacketRegion_isLeastProductHull
#print axioms unitPacketRegion_isProductRegion
#print axioms spectrumPreservingPacketUnion_eq_nativePacketRegion
#print axioms nativePacketRegion_isProductRegion

end ThetaIndeterminacyChoice

end IUTThreeClosures
