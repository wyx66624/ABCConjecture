/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FullPolyCore

/-!
# Countermodel for restricted coric families
-/

namespace IUTThreeClosures

/-- Boolean negation as an equivalence. -/
def boolSwapEquiv : Bool ≃ Bool where
  toFun b := !b
  invFun b := !b
  left_inv := by intro b; cases b <;> rfl
  right_inv := by intro b; cases b <;> rfl

/-- A proper restricted family containing only the identity. -/
def restrictedCoric : Set (Bool ≃ Bool) := {Equiv.refl Bool}

/-- The Kummer conjugate of the horizontal swap is not allowed by the restricted
family. This shows why fullness or an explicit compatibility theorem is necessary. -/
theorem conjugate_not_mem_restricted :
    kummerConjugate (Equiv.refl Bool) (Equiv.refl Bool) boolSwapEquiv
      ∉ restrictedCoric := by
  intro h
  have hid :
      kummerConjugate (Equiv.refl Bool) (Equiv.refl Bool) boolSwapEquiv =
        Equiv.refl Bool := by
    simpa [restrictedCoric] using h
  have hfalse := congrArg (fun e : Bool ≃ Bool => e false) hid
  simp [kummerConjugate, boolSwapEquiv] at hfalse

end IUTThreeClosures
