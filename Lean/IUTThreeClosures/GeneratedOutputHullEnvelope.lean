/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.PublicThetaHullComponentFormula

/-!
# Generated-output hull envelopes

The full log-Kummer indeterminacy (Ind3) is represented in the source by
inclusions, not by an elementwise equality with the ordinary Kummer branch.
Consequently one should not try to prove that every possible output is the
same `q`-power word.  The source-faithful target is an upper hull envelope:
for each capsule and rational place, construct one genuine hull region that
contains every possible output.

The union of all outputs is then contained in the envelope.  Since the public
holomorphic hull is the least hull region containing that union, the actual
public theta hull is contained in the same envelope.  This is exactly the
order-theoretic mechanism by which upper semi-compatibility is converted into
an upper estimate.

The module contains no volume assumption and no numerical bound.  It closes
the set-theoretic part of the full-Ind3 route; a monotone finite-positive or
radial log-volume may subsequently be applied to the resulting inclusion.
-/

namespace IUTThreeClosures

open Iut

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- A source-generated hull region containing every allowed multiradial
output at one capsule and rational place. -/
structure GeneratedOutputHullEnvelope
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  envelope :
    ∀ (i : Fin G.container.proc.length) (vQ : RationalPlace),
      Set (G.container.packet i vQ).Total
  envelope_isHullRegion : ∀ i vQ,
    (G.container.packet i vQ).IsHullRegion (envelope i vQ)
  output_le_envelope : ∀ o i vQ,
    (G.outputs.realize o i).region vQ ⊆ envelope i vQ

namespace GeneratedOutputHullEnvelope

variable {G : GeneratedRHSData.{u, v, w} D}

/-- The literal union of all generated outputs is contained in the common
source envelope. -/
theorem unionRegion_le_envelope
    (E : GeneratedOutputHullEnvelope G)
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    (G.outputs.unionRegion i).region vQ ⊆ E.envelope i vQ := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
  exact E.output_le_envelope o i vQ hx

/-- **Full-Ind3 hull theorem.**  The actual public holomorphic theta hull is
contained in every hull-region envelope containing all generated outputs. -/
theorem thetaHull_le_envelope
    (E : GeneratedOutputHullEnvelope G)
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    ((G.toRHSData).thetaHull i).region vQ ⊆ E.envelope i vQ := by
  change
    (G.hull.system i vQ).hull
      ((G.outputs.unionRegion i).region vQ) ⊆ E.envelope i vQ
  exact (G.hull.system i vQ).hull_le
    (G.union_hullAdmissible i vQ)
    (E.envelope_isHullRegion i vQ)
    (E.unionRegion_le_envelope i vQ)

/-- If the envelope itself is the least hull of the generated union, it is
literally the actual public theta hull.  The weaker inclusion theorem above is
usually sufficient for Ind3 upper estimates. -/
theorem thetaHull_eq_envelope_of_isLeast
    (E : GeneratedOutputHullEnvelope G)
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace)
    (hleast :
      (G.container.packet i vQ).IsLeastHullRegion
        ((G.outputs.unionRegion i).region vQ) (E.envelope i vQ)) :
    ((G.toRHSData).thetaHull i).region vQ = E.envelope i vQ := by
  change
    (G.hull.system i vQ).hull
      ((G.outputs.unionRegion i).region vQ) = E.envelope i vQ
  exact
    ((G.hull.system i vQ).isLeastHullRegion_hull
      ((G.outputs.unionRegion i).region vQ)
      (G.union_hullAdmissible i vQ)).unique hleast

/-- The envelope inclusion is stable under replacing the output type by a
larger family, provided every enlarged output still lies in the same source
envelope.  This records the monotonic nature of adding Ind1/Ind2/Ind3
choices. -/
theorem thetaHull_le_of_all_outputs_le
    (envelope :
      ∀ (i : Fin G.container.proc.length) (vQ : RationalPlace),
        Set (G.container.packet i vQ).Total)
    (henvelope : ∀ i vQ,
      (G.container.packet i vQ).IsHullRegion (envelope i vQ))
    (hall : ∀ o i vQ,
      (G.outputs.realize o i).region vQ ⊆ envelope i vQ)
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    ((G.toRHSData).thetaHull i).region vQ ⊆ envelope i vQ := by
  let E : GeneratedOutputHullEnvelope G :=
    { envelope := envelope
      envelope_isHullRegion := henvelope
      output_le_envelope := hall }
  exact E.thetaHull_le_envelope i vQ

end GeneratedOutputHullEnvelope

end IUTThreeClosures
