/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArbitraryInd2ComponentCollapse
import IUTThreeClosures.SpectrumPreservingInd2Envelope
import IUTThreeClosures.SourceFaithfulFinalCapsuleRadialVolume

/-!
# The least dependent-product hull of a packet

The public theta-hull interface is product-valued.  To avoid leaving the word
"hull" abstract at the packet level, this module constructs the least direct
product containing an arbitrary set of dependent packets:

* the component at an index is the coordinate projection of the input set;
* the hull is the product of these coordinate projections.

The construction is proved to contain the input, to be a product region, and
to be minimal among all product regions.  It is then applied to three concrete
possible-image packets already obtained in the repository.

1. The arbitrary theta-label-permutation candidate has the full unit packet as
   its exact least product hull.
2. The spectrum-preserving candidate has the native squared-label packet as
   its exact least product hull.
3. The source-faithful fiberwise Ind2 packet on the actual final capsule has
   the actual `finalCapsuleProductRegion` as its exact least dependent-product
   hull.

The third statement, together with the actual Haar theorem in
`SourceFaithfulFinalCapsuleRadialVolume`, identifies both the radial hull and
its normalized local Haar log-volume without a freely supplied hull or volume
functional.  The full non-radial IUT possible image remains outside the scope
of this theorem.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

universe u v

namespace DependentProductHull

variable {Index : Type u}
variable {X : Index → Type v}

/-- Direct product of a dependent family of component sets. -/
def productRegion
    (component : ∀ i : Index, Set (X i)) :
    Set (∀ i : Index, X i) :=
  {x | ∀ i, x i ∈ component i}

/-- Predicate for dependent direct-product regions. -/
def IsProductRegion (U : Set (∀ i : Index, X i)) : Prop :=
  ∃ component : ∀ i : Index, Set (X i),
    U = productRegion component

/-- Coordinate projection of a packet set. -/
def coordinateProjection
    (U : Set (∀ i : Index, X i))
    (i : Index) : Set (X i) :=
  {z | ∃ x, x ∈ U ∧ x i = z}

/-- Least dependent-product hull: product of all coordinate projections. -/
def hull (U : Set (∀ i : Index, X i)) :
    Set (∀ i : Index, X i) :=
  productRegion (coordinateProjection U)

/-- Every packet lies in the product of its coordinate projections. -/
theorem subset_hull (U : Set (∀ i : Index, X i)) :
    U ⊆ hull U := by
  intro x hx i
  exact ⟨x, hx, rfl⟩

/-- The constructed hull is a dependent product region. -/
theorem isProductRegion_hull (U : Set (∀ i : Index, X i)) :
    IsProductRegion (hull U) := by
  exact ⟨coordinateProjection U, rfl⟩

/-- Minimality among all dependent product regions. -/
theorem hull_minimal
    {U V : Set (∀ i : Index, X i)}
    (hV : IsProductRegion V)
    (hUV : U ⊆ V) :
    hull U ⊆ V := by
  rcases hV with ⟨component, rfl⟩
  intro x hx i
  rcases hx i with ⟨y, hyU, hyi⟩
  rw [← hyi]
  exact hUV hyU i

/-- Product regions are fixed by the least-product-hull operator. -/
theorem hull_eq_self_of_isProductRegion
    {U : Set (∀ i : Index, X i)}
    (hU : IsProductRegion U) :
    hull U = U := by
  apply Set.Subset.antisymm
  · exact hull_minimal hU (subset_refl U)
  · exact subset_hull U

#print axioms subset_hull
#print axioms isProductRegion_hull
#print axioms hull_minimal
#print axioms hull_eq_self_of_isProductRegion

end DependentProductHull

open Iut TateCurvesTheta
open scoped Pointwise

namespace ThetaIndeterminacyChoice

universe w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

/-- Exact least product hull of the literal complete-packet union for the
arbitrary theta-label-permutation candidate. -/
theorem arbitraryPacketDependentProductHull_eq_unitPacketRegion
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (zeroLabel : Label)
    (hzero : labelNat zeroLabel = 0) :
    DependentProductHull.hull (packetChoiceUnion t labelNat) =
      unitPacketRegion := by
  apply Set.Subset.antisymm
  · apply DependentProductHull.hull_minimal
    · refine ⟨fun _ => normIntegralRegion (K := K), ?_⟩
      rfl
    · exact packetChoiceUnion_subset_unitPacketRegion t labelNat
  · have hleast :=
      unitPacketRegion_isLeastProductHull
        t labelNat zeroLabel hzero
    exact hleast.2
      (DependentProductHull.hull (packetChoiceUnion t labelNat))
      (by
        rcases DependentProductHull.isProductRegion_hull
          (packetChoiceUnion t labelNat) with ⟨component, hcomponent⟩
        exact ⟨component, hcomponent⟩)
      (DependentProductHull.subset_hull (packetChoiceUnion t labelNat))

/-- Exact least product hull of the literal complete-packet union for the
spectrum-preserving candidate. -/
theorem spectrumPreservingPacketDependentProductHull_eq_nativePacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    DependentProductHull.hull
        (spectrumPreservingPacketUnion t labelNat) =
      nativePacketRegion t labelNat := by
  rw [spectrumPreservingPacketUnion_eq_nativePacketRegion]
  apply DependentProductHull.hull_eq_self_of_isProductRegion
  refine ⟨fun j => t.qPowerRegion ((labelNat j) ^ 2), ?_⟩
  rfl

#print axioms arbitraryPacketDependentProductHull_eq_unitPacketRegion
#print axioms spectrumPreservingPacketDependentProductHull_eq_nativePacketRegion

end ThetaIndeterminacyChoice

namespace FinalCapsule

universe x

/-- Exact least dependent-product hull of the source-faithful radial packet on
an actual final capsule. -/
theorem sourceFaithfulPacketDependentProductHull_eq_finalCapsuleProductRegion
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    DependentProductHull.hull
        (fiberwisePacketChoiceUnion D Fiber) =
      D.finalCapsuleProductRegion := by
  rw [fiberwisePacketChoiceUnion_eq_finalCapsuleProductRegion]
  apply DependentProductHull.hull_eq_self_of_isProductRegion
  refine ⟨fun j =>
    (D.qParam j).qPowerRegion ((D.labelInteger j) ^ 2), ?_⟩
  rfl

/-- The exact Haar-volume formula attached to the source-faithful least
product hull.  The preceding theorem identifies the hull set; the actual local
Haar arithmetic was constructed directly in the imported module. -/
theorem sourceFaithfulDependentProductHull_actualHaarLogVolume
    (D : FinalCapsule)
    (Fiber : D.Label → Type x) :
    actualNativePacketHaarLogVolume D = processionLogSum D := by
  exact actualNativePacketHaarLogVolume_eq_processionLogSum D

#print axioms sourceFaithfulPacketDependentProductHull_eq_finalCapsuleProductRegion
#print axioms sourceFaithfulDependentProductHull_actualHaarLogVolume

end FinalCapsule

end IUTThreeClosures
