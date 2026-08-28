/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SpectrumPreservingInd2Envelope

/-!
# The coherent spectrum-preserving packet union

The componentwise envelope theorem proves that each coordinate separately has
native Tate radius once Ind2 preserves the label spectrum.  A genuine packet,
however, uses one common indeterminacy choice at every coordinate; independent
coordinatewise choices would lose this coherence.

This module therefore takes the union of the complete packet regions over
single coherent spectrum-preserving choices.  Every such packet is contained
in the native product region, and the single native choice realizes the entire
product simultaneously.  Hence the coherent packet union is exactly

`{x | forall j, x j in q^(labelNat j)^2 O}`.

Thus no independent-choice enlargement occurs at the packet level.  The
remaining Theorem 3.11 problem is to prove that the genuine Hodge-theater
possible images are represented by these spectrum-preserving choices and to
connect this packet to the procession and measured component formula.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

namespace ThetaIndeterminacyChoice

/-- The union of complete packet regions over coherent spectrum-preserving
choices. -/
def spectrumPreservingPacketUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  ⋃ (C : ThetaIndeterminacyChoice K Label),
    ⋃ (_hC : C.PreservesLabelNat labelNat),
      C.packetRegion t labelNat

/-- The complete native Tate-spectrum packet. -/
def nativeSpectrumPacket
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  {x | ∀ j, x j ∈ t.qPowerRegion (labelNat j ^ 2)}

@[simp]
theorem mem_nativeSpectrumPacket
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (x : Label → K) :
    x ∈ nativeSpectrumPacket t labelNat ↔
      ∀ j, x j ∈ t.qPowerRegion (labelNat j ^ 2) :=
  Iff.rfl

/-- Every coherent spectrum-preserving packet lies in the native product
region. -/
theorem packetRegion_subset_nativeSpectrumPacket
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (hC : C.PreservesLabelNat labelNat) :
    C.packetRegion t labelNat ⊆
      nativeSpectrumPacket t labelNat := by
  intro x hx j
  exact C.outputRegion_subset_native_qPowerRegion
    t labelNat hC j (hx j)

/-- The native coherent choice realizes the complete native packet exactly. -/
theorem nativeChoice_packetRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    (nativeChoice (K := K) (Label := Label)).packetRegion t labelNat =
      nativeSpectrumPacket t labelNat := by
  ext x
  constructor
  · intro hx j
    have hj := hx j
    rw [nativeChoice_outputRegion t labelNat j] at hj
    exact hj
  · intro hx j
    rw [nativeChoice_outputRegion t labelNat j]
    exact hx j

/-- **Coherent non-collapse theorem.**  The union over complete packets, using
one common spectrum-preserving Ind2/Ind3 choice at all coordinates, is exactly
the native Tate-spectrum packet. -/
theorem spectrumPreservingPacketUnion_eq_nativeSpectrumPacket
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    spectrumPreservingPacketUnion t labelNat =
      nativeSpectrumPacket t labelNat := by
  apply Set.Subset.antisymm
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
    rcases Set.mem_iUnion.mp hxC with ⟨hC, hxPacket⟩
    exact packetRegion_subset_nativeSpectrumPacket
      t labelNat C hC hxPacket
  · intro x hx
    apply Set.mem_iUnion.mpr
    refine ⟨nativeChoice (K := K) (Label := Label), ?_⟩
    apply Set.mem_iUnion.mpr
    refine ⟨nativeChoice_preservesLabelNat
      (K := K) (Label := Label) labelNat, ?_⟩
    rw [nativeChoice_packetRegion t labelNat]
    exact hx

/-- Equivalently, the coherent possible-image packet union is already the
single native packet region. -/
theorem spectrumPreservingPacketUnion_eq_nativeChoice
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    spectrumPreservingPacketUnion t labelNat =
      (nativeChoice (K := K) (Label := Label)).packetRegion t labelNat := by
  rw [spectrumPreservingPacketUnion_eq_nativeSpectrumPacket,
    nativeChoice_packetRegion]

end ThetaIndeterminacyChoice

end IUTThreeClosures
