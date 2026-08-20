/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ThreeClosureTheorems

/-!
# Exact remaining inhabitation proposition
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- The precise proposition still required for a parameter-free proof. -/
def ThreeClosuresInhabited : Prop :=
  Nonempty (FinalCertificateType.{u, v, w, z}
    (AG := AG) (TG := TG) (Input := Input))

/-- Inhabitation of the three-closure certificate implies abc. -/
theorem abc_of_three_closures_inhabited
    (h : ThreeClosuresInhabited.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ABCConjecture := by
  rcases h with ⟨C⟩
  exact C.abc_conjecture_of_three_closures

end IUTThreeClosures
