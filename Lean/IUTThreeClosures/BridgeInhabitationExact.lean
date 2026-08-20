/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BridgeInhabitationAudit

/-!
# Exact bridge inhabitation without a typeclass side condition

This file removes the auxiliary `[Nonempty Input]` assumption from the audit by
exhibiting the standard abc point `(1, 1, 2)`. A bridge itself maps that point
to an input, so bridge inhabitation already forces `Input` to be inhabited.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- The elementary abc point `(1, 1, 2)`. -/
def oneOneTwoABCPoint : ABCPoint where
  a := 1
  b := 1
  c := 2
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by
    norm_num [PairwiseCoprimeABC]

namespace NonCircularIUTIVBridge

/-- Exact logical strength of bridge inhabitation, with no external
inhabitedness assumption. -/
theorem nonempty_iff_nonempty_input_and_abc
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Nonempty (NonCircularIUTIVBridge F) ↔
      Nonempty Input ∧ ABCConjecture := by
  constructor
  · rintro ⟨B⟩
    exact ⟨⟨B.encode oneOneTwoABCPoint⟩, B.abc⟩
  · rintro ⟨⟨x₀⟩, habc⟩
    exact ⟨ofABC (F := F) (fun _ => x₀) habc⟩

end NonCircularIUTIVBridge

/-- Exact logical strength of the complete four-stage record without any
implicit typeclass hypothesis. -/
theorem nonempty_fourStageProgram_iff_exact :
    Nonempty (FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) ↔
      Nonempty (UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) ∧
      Nonempty Input ∧ ABCConjecture := by
  constructor
  · rintro ⟨P⟩
    exact ⟨⟨P.upstream⟩,
      ⟨⟨P.downstream.encode oneOneTwoABCPoint⟩, P.downstream.abc⟩⟩
  · rintro ⟨⟨U⟩, ⟨⟨x₀⟩, habc⟩⟩
    exact ⟨{
      upstream := U
      downstream := NonCircularIUTIVBridge.ofABC
        (F := U.family) (fun _ => x₀) habc
    }⟩

end IUTThreeClosures
