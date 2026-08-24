/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZOrbitProperness

/-!
# Compact-intersection properness from radial continuity

The two-sided theta-root orbit theorem proves finiteness of deck translates
between any two radially bounded subsets.  In every topological realization
where the normalized radial coordinate is continuous, compact subsets are
automatically radially bounded: their radial images are compact subsets of
`R`, hence bounded above and below.

This file makes that implication precise.  It proves the standard
compact-intersection criterion for proper discontinuity:

for compact subsets `K₁`, `K₂`, only finitely many integer deck translates of
`K₁` meet `K₂`.

The theorem is deliberately topology-parametric.  To apply it to the genuine
Tate/Berkovich theta-root space, the remaining analytic source theorem is only
that the logarithmic norm/radial coordinate is continuous in the chosen
analytic topology.  No properness field is postulated.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- A compact subset has bounded image under a continuous real-valued
function. -/
theorem isRadiallyBounded_of_isCompact
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    [TopologicalSpace (TateThetaRootPullbackPoint t ell)]
    (hcoord : Continuous (coordinate t ell r))
    {S : Set (TateThetaRootPullbackPoint t ell)}
    (hS : IsCompact S) :
    IsRadiallyBounded t ell r S := by
  have himage : IsCompact (coordinate t ell r '' S) :=
    hS.image hcoord
  rcases himage.bddBelow with ⟨a, ha⟩
  rcases himage.bddAbove with ⟨b, hb⟩
  refine ⟨a, b, ?_⟩
  intro z hz
  have hzImage : coordinate t ell r z ∈
      coordinate t ell r '' S := ⟨z, hz, rfl⟩
  exact ⟨ha hzImage, hb hzImage⟩

/-- **Compact-intersection finiteness.**  If the radial coordinate is
continuous, then between two compact subsets only finitely many complete
integer deck translates can meet. -/
theorem compact_meetingShiftIndices_finite
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    [TopologicalSpace (TateThetaRootPullbackPoint t ell)]
    (hcoord : Continuous (coordinate t ell r))
    {S T : Set (TateThetaRootPullbackPoint t ell)}
    (hS : IsCompact S) (hT : IsCompact T) :
    (meetingShiftIndices t ell r hr S T).Finite := by
  apply meetingShiftIndices_finite_of_radiallyBounded
    t ell r hr
  · exact isRadiallyBounded_of_isCompact t ell r hcoord hS
  · exact isRadiallyBounded_of_isCompact t ell r hcoord hT

/-- The compact-intersection form of proper discontinuity for the complete
integer deck action. -/
def CompactIntersectionProper
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    [TopologicalSpace (TateThetaRootPullbackPoint t ell)] : Prop :=
  ∀ S T : Set (TateThetaRootPullbackPoint t ell),
    IsCompact S → IsCompact T →
      (meetingShiftIndices t ell r hr S T).Finite

/-- Continuity of the radial coordinate implies compact-intersection
properness of the theta-root integer deck action. -/
theorem compactIntersectionProper_of_continuous_coordinate
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    [TopologicalSpace (TateThetaRootPullbackPoint t ell)]
    (hcoord : Continuous (coordinate t ell r)) :
    CompactIntersectionProper t ell r hr := by
  intro S T hS hT
  exact compact_meetingShiftIndices_finite
    t ell r hr hcoord hS hT

end TateThetaRootRadialSkeleton

end IUTThreeClosures
