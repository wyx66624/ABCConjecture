/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FourOpenConstructions

/-!
# Inhabitation audit for the proposed non-circular bridge

The fields of `NonCircularIUTIVBridge` do not literally contain
`ABCConjecture`. Nevertheless, once the input type is inhabited, the bridge
itself is inhabited if and only if `ABCConjecture` is true. The reverse
construction uses the abc inequality to populate the bridge and ignores the
Corollary 3.12 premise.

Consequently the current `FourStageProgram` is inhabited exactly when an
upstream source family is inhabited and abc is already true. This theorem is
an honesty boundary: replacing one target field by height functions and a
uniform estimate does not, by itself, remove circularity at the level of
inhabitation.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

namespace NonCircularIUTIVBridge

/-- Any proof of abc gives a bridge after choosing an encoding. This
construction deliberately does not use the Corollary 3.12 hypothesis; it is
used below to identify the exact logical strength of bridge inhabitation. -/
noncomputable def ofABC
    {F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input}
    (encode : ABCPoint → Input)
    (habc : ABCConjecture) :
    NonCircularIUTIVBridge F where
  encode := encode
  logQ := fun P => 6 * P.height
  logDiff := fun _ => 0
  logCond := fun P => P.conductor
  heightError := 0
  differentError := 0
  conductorError := 0
  height_le := by
    intro P
    change P.height ≤ (6 : ℝ) * P.height / 6 + 0
    have h : (6 : ℝ) * P.height / 6 + 0 = P.height := by ring
    rw [h]
  different_le := by
    intro P
    change (0 : ℝ) ≤ 0
    norm_num
  conductor_le := by
    intro P
    change P.conductor ≤ P.conductor + 0
    simp
  qEstimate := by
    intro ε hε
    rcases habc ε hε with ⟨C, hC⟩
    refine ⟨C, ?_⟩
    intro P _
    have hP := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
      P.sum_eq P.pairwise_coprime
    calc
      (6 * P.height) / 6 = P.height := by ring
      _ ≤ (1 + ε) * P.conductor + C := by
        simpa [ABCPoint.height, ABCPoint.conductor] using hP
      _ = (1 + ε) * (0 + P.conductor) + C := by ring

/-- For an inhabited input type, inhabiting the proposed non-circular bridge
is logically equivalent to proving abc. -/
theorem nonempty_iff_abc
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    [Nonempty Input] :
    Nonempty (NonCircularIUTIVBridge F) ↔ ABCConjecture := by
  constructor
  · rintro ⟨B⟩
    exact B.abc
  · intro habc
    rcases (inferInstance : Nonempty Input) with ⟨x₀⟩
    exact ⟨ofABC (F := F) (fun _ => x₀) habc⟩

end NonCircularIUTIVBridge

/-- Exact inhabitation strength of the current four-stage programme, for an
inhabited arithmetic input type. -/
theorem nonempty_fourStageProgram_iff
    [Nonempty Input] :
    Nonempty (FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) ↔
      Nonempty (UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) ∧ ABCConjecture := by
  constructor
  · rintro ⟨P⟩
    exact ⟨⟨P.upstream⟩, P.downstream.abc⟩
  · rintro ⟨⟨U⟩, habc⟩
    rcases (inferInstance : Nonempty Input) with ⟨x₀⟩
    exact ⟨{
      upstream := U
      downstream := NonCircularIUTIVBridge.ofABC
        (F := U.family) (fun _ => x₀) habc
    }⟩

end IUTThreeClosures
