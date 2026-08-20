/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalQPilotCorridor

/-!
# Source-derived IUT IV bridge

Unlike `NonCircularIUTIVBridge`, this structure has no freely chosen `logQ`,
`logDiff`, or `logCond` functions and no field whose statement is the final
q-estimate.  Its q-logarithm and theta coefficient are canonical projections
of the actual IUT III source.  The q-bound is proved from Corollary 3.12 and the
source coefficient identity in `CanonicalCoefficientCorridor`.

The two remaining geometric inputs are stated at their natural levels: the
comparison of the elementary abc height with the canonical q-logarithm and a
uniform estimate for the source main term by the elementary conductor.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- A bridge whose numerical quantities are fixed by an actual source family. -/
structure SourceDerivedIUTIVBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  corridor : CanonicalCoefficientCorridor F
  /-- Bounded discrepancy in the Legendre/Tate height comparison. -/
  heightError : ℝ
  /-- The elementary height is bounded by the actual q-logarithm. -/
  height_le : ∀ P,
    P.height ≤ corridor.qLog P / 6 + heightError
  /-- Uniform source estimate for the actual IUT IV main term. -/
  mainTerm_estimate :
    ∀ ε : ℝ, 0 < ε →
      ∃ C : ℝ, ∀ P : ABCPoint,
        corridor.mainTerm P ≤ (1 + ε) * P.conductor + C

namespace SourceDerivedIUTIVBridge

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The source-derived bridge proves the standard logarithmic abc conjecture. -/
theorem abc (B : SourceDerivedIUTIVBridge F) : ABCConjecture := by
  intro ε hε
  rcases B.mainTerm_estimate ε hε with ⟨C, hC⟩
  refine ⟨C + B.heightError, ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  have h312 : Corollary312Variant
      (F.source (B.corridor.encode P)).toVariantData :=
    F.corollary312Variant (B.corridor.encode P)
  have hq : B.corridor.qLog P / 6 ≤ B.corridor.mainTerm P :=
    B.corridor.qLog_div_six_le_mainTerm P h312
  have hm := hC P
  have hh := B.height_le P
  have hfinal :
      P.height ≤ (1 + ε) * P.conductor + (C + B.heightError) := by
    calc
      P.height ≤ B.corridor.qLog P / 6 + B.heightError := hh
      _ ≤ B.corridor.mainTerm P + B.heightError :=
        add_le_add_right hq B.heightError
      _ ≤ ((1 + ε) * P.conductor + C) + B.heightError :=
        add_le_add_right hm B.heightError
      _ = (1 + ε) * P.conductor + (C + B.heightError) := by ring
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hfinal

end SourceDerivedIUTIVBridge

end IUTThreeClosures
