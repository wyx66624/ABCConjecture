/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalQPilotCorridor

/-!
# Audit of the first canonical coefficient corridor

Fixing the q-logarithm and theta coefficient from the public source removes the
most direct circular assignment `logQ := 6 * height`.  It is not yet enough:
if `factor` and `mainTerm` remain arbitrary fields, every source with positive
q-logarithm admits a corridor by defining the main term from the desired
coefficient identity itself.

The construction below is an explicit counterexample to treating
`CanonicalCoefficientCorridor` alone as source-derived IUT IV mathematics.
It contains no proof of abc and no use of Corollary 3.12.  A stricter bridge
must make the factor and main term canonical projections of independently
constructed arithmetic-geometric objects.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

namespace CanonicalCoefficientCorridor

/-- Tautological corridor obtained by solving the coefficient formula for its
still-free main term.  This witnesses the remaining specification loophole. -/
noncomputable def tautological
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    (encode : ABCPoint → Input)
    (qPositive : ∀ P, 0 < (F.qPilot (encode P)).absLogQ) :
    CanonicalCoefficientCorridor F where
  encode := encode
  qPositive := qPositive
  factor := fun _ => 1
  factorPositive := by
    intro P
    norm_num
  mainTerm := fun P =>
    (F.source (encode P)).toVariantData.rhsData.rhs /
        (F.qPilot (encode P)).absLogQ +
      (F.qPilot (encode P)).absLogQ / 6 + 1
  coefficientFormula := by
    intro P
    ring

/-- Consequently, corridor inhabitation follows from positivity alone; the
record does not yet certify that its main term came from IUT IV geometry. -/
theorem nonempty_of_positive_q
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    (encode : ABCPoint → Input)
    (qPositive : ∀ P, 0 < (F.qPilot (encode P)).absLogQ) :
    Nonempty (CanonicalCoefficientCorridor F) :=
  ⟨tautological F encode qPositive⟩

end CanonicalCoefficientCorridor
end IUTThreeClosures
