/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Module.Submodule.Ker
import Mathlib.Algebra.Field.ZMod
import Mathlib.Tactic.NormNum

/-!
# Abstract linear core for the p=29 Selmer route

This file isolates the elementary linear-algebra implication needed by a
future exact global-to-dyadic localization certificate.  If a Selmer
subspace is contained in an explicitly computed over-approximation `W`, then
injectivity of localization on `W` implies injectivity on the Selmer
subspace.

No particular Selmer group, local Kummer map, number field, or `14 x 31`
matrix is constructed here.  Those arithmetic objects and their exact
finite certificates remain inputs to the theorem rather than hidden axioms.
The proof is stated over an arbitrary division ring; the p=29 corollaries
specialize it to the squareclass field `ZMod 2`.
-/

namespace IUTThreeClosures

section AbstractRestriction

variable {k V L : Type*}
variable [DivisionRing k]
variable [AddCommGroup V] [Module k V]
variable [AddCommGroup L] [Module k L]

/-- Injectivity of a linear map on a subspace descends to every smaller
subspace.  The ambient spaces need not be finite-dimensional for this
elementary implication. -/
theorem linearMap_domRestrict_injective_of_le
    (selmer W : Submodule k V) (loc : V →ₗ[k] L)
    (hselmerW : selmer ≤ W)
    (hW : Function.Injective (loc.domRestrict W)) :
    Function.Injective (loc.domRestrict selmer) := by
  intro x y hxy
  have hxyW :
      (⟨(x : V), hselmerW x.property⟩ : W) =
        ⟨(y : V), hselmerW y.property⟩ := by
    apply hW
    exact hxy
  have hval : (x : V) = (y : V) :=
    congrArg (fun z : W => (z : V)) hxyW
  exact Subtype.ext hval

/-- Kernel form of `linearMap_domRestrict_injective_of_le`.  This is the
form naturally produced by an exact rank or row-reduction certificate for
the localization matrix on `W`. -/
theorem linearMap_domRestrict_ker_eq_bot_of_le
    (selmer W : Submodule k V) (loc : V →ₗ[k] L)
    (hselmerW : selmer ≤ W)
    (hW : LinearMap.ker (loc.domRestrict W) = ⊥) :
    LinearMap.ker (loc.domRestrict selmer) = ⊥ := by
  apply LinearMap.ker_eq_bot.mpr
  apply linearMap_domRestrict_injective_of_le selmer W loc hselmerW
  exact LinearMap.ker_eq_bot.mp hW

end AbstractRestriction

section P29Squareclasses

variable {V L : Type*}
variable [AddCommGroup V] [Module (ZMod 2) V]
variable [AddCommGroup L] [Module (ZMod 2) L]

/-- The p=29 squareclass specialization.  Both containment of the actual
Selmer space in `W` and injectivity of the computed localization map on `W`
remain explicit hypotheses. -/
theorem p29_selmer_localization_injective
    (selmer W : Submodule (ZMod 2) V) (loc : V →ₗ[ZMod 2] L)
    (hselmerW : selmer ≤ W)
    (hW : Function.Injective (loc.domRestrict W)) :
    Function.Injective (loc.domRestrict selmer) :=
  linearMap_domRestrict_injective_of_le (k := ZMod 2) (V := V) (L := L)
    selmer W loc hselmerW hW

/-- Kernel form of the p=29 squareclass specialization. -/
theorem p29_selmer_localization_ker_eq_bot
    (selmer W : Submodule (ZMod 2) V) (loc : V →ₗ[ZMod 2] L)
    (hselmerW : selmer ≤ W)
    (hW : LinearMap.ker (loc.domRestrict W) = ⊥) :
    LinearMap.ker (loc.domRestrict selmer) = ⊥ :=
  linearMap_domRestrict_ker_eq_bot_of_le (k := ZMod 2) (V := V) (L := L)
    selmer W loc hselmerW hW

/-- Scalar dimension ledger anticipated by the p=29 global-to-dyadic
calculation.  It records arithmetic only: it does not assert that any
arithmetic space or matrix has one of these dimensions. -/
theorem pellChebyshevTwentyNine_globalDyadicDimensionLedger :
    (1 + 14 + 4 : ℕ) = 19 ∧
      (19 - 5 : ℕ) = 14 ∧
      (29 + 2 : ℕ) = 31 ∧
      (2 : ℕ) < 14 := by
  norm_num

end P29Squareclasses

#print axioms linearMap_domRestrict_injective_of_le
#print axioms linearMap_domRestrict_ker_eq_bot_of_le
#print axioms p29_selmer_localization_injective
#print axioms p29_selmer_localization_ker_eq_bot
#print axioms pellChebyshevTwentyNine_globalDyadicDimensionLedger

end IUTThreeClosures
