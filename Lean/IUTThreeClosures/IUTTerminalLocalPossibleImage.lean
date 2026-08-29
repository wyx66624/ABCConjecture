/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalLabelCoefficientTwo

/-!
# The terminal square label is a genuine local possible image

The terminal coefficient-two reduction is not based on an invented local
region.  At every actual bad Hodge-theater place, the norm-controlled Tate
source takes every natural `q^m O` region as an ordinary branch.  Hence the
terminal region

`q^(processionLength^2) O`

is reachable by the source relation and belongs to the literal union of local
possible images.

This closes the local realization part of the terminal-label interface.  It
does not assemble these local outputs over the complete procession, identify
them with the global IUT III theta possible-image system, or prove the global
mono-analytic hull comparison needed for a coefficient-two abc estimate.
-/

namespace IUTThreeClosures
namespace IUTTerminalLocalPossibleImage

open Iut

noncomputable section

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Exponent of the terminal square-label Tate region. -/
def terminalSquareExponent (D : InitialThetaData AG TG) : ℕ :=
  ActualBadPlaceProcessionAssembly.processionLength D ^ 2

/-- The terminal square-label region is an ordinary branch of the actual
norm-controlled local source, hence genuinely reachable. -/
theorem terminalSquareRegion_reachable
    (H : ActualBadHodgeTheaterPlace D) :
    H.actualTateRelationalSource.toUpperSemicompatibleSystem.Reachable
      (H.tate.qPowerRegion (terminalSquareExponent D)) := by
  exact UpperSemicompatibleReachable.ordinary
    (terminalSquareExponent D)

/-- Therefore the terminal square-label region is contained in the literal
union of source-generated local possible images. -/
theorem terminalSquareRegion_le_possibleUnion
    (H : ActualBadHodgeTheaterPlace D) :
    H.tate.qPowerRegion (terminalSquareExponent D) ⊆
      H.actualTateRelationalSource.toUpperSemicompatibleSystem.possibleUnion := by
  intro z hz
  let S := H.actualTateRelationalSource.toUpperSemicompatibleSystem
  let o : S.Output :=
    ⟨H.tate.qPowerRegion (terminalSquareExponent D),
      terminalSquareRegion_reachable H⟩
  exact Set.mem_iUnion.mpr ⟨o, hz⟩

/-- The corresponding finite-positive terminal region has the same underlying
set as this genuine local possible image. -/
theorem terminalFinitePositiveRegion_coe
    (H : ActualBadHodgeTheaterPlace D) :
    (H.squareLabelRegion
        (ActualBadPlaceProcessionAssembly.processionLength D) :
      Set H.TateField) =
      H.tate.qPowerRegion (terminalSquareExponent D) := by
  rw [ActualBadHodgeTheaterPlace.coe_squareLabelRegion]
  rfl

/-- The finite-positive terminal region itself is contained in the local
possible-image union. -/
theorem terminalFinitePositiveRegion_le_possibleUnion
    (H : ActualBadHodgeTheaterPlace D) :
    (H.squareLabelRegion
        (ActualBadPlaceProcessionAssembly.processionLength D) :
      Set H.TateField) ⊆
      H.actualTateRelationalSource.toUpperSemicompatibleSystem.possibleUnion := by
  rw [terminalFinitePositiveRegion_coe]
  exact terminalSquareRegion_le_possibleUnion H

#print axioms terminalSquareRegion_reachable
#print axioms terminalSquareRegion_le_possibleUnion
#print axioms terminalFinitePositiveRegion_coe
#print axioms terminalFinitePositiveRegion_le_possibleUnion

end
end IUTTerminalLocalPossibleImage
end IUTThreeClosures
