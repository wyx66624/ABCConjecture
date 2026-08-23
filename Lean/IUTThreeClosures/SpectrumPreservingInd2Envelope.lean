/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArbitraryInd2ComponentCollapse

/-!
# Spectrum-preserving Ind2 retains the native q-envelope

The component-collapse theorem shows that arbitrary label permutations are too
large: every coordinate can be moved to a zero label, so its independently
unioned possible image becomes the full norm unit ball.

The natural replacement is to require Ind2 to preserve the theta-label
spectrum `labelNat`.  This matches the spectral-norm interpretation of genuine
local field automorphisms: conjugation may change a generator, but it does not
change its radius.

Under this restriction the output power at coordinate `j` is

`labelNat j ^ 2 + ind3 j`.

Thus Ind3 can only increase the exponent and shrink the Tate-power region.
The identity Ind2 with zero Ind3 realizes the original exponent.  Consequently
the componentwise union over all spectrum-preserving choices is **exactly**
the native region `q^(labelNat j)^2 O`, not the whole unit ball.

This provides a positive, non-collapsing candidate envelope for the actual
IUT III possible-image construction.  No volume estimate, Corollary 3.12, or
abc inequality is assumed.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

namespace ThetaIndeterminacyChoice

/-- An Ind2 choice preserves the theta-label spectrum. -/
def PreservesLabelNat
    (C : ThetaIndeterminacyChoice K Label)
    (labelNat : Label → ℕ) : Prop :=
  ∀ j : Label, labelNat (C.ind2 j) = labelNat j

/-- Under spectrum preservation, Ind2 disappears from the output exponent. -/
theorem outputPower_eq_of_preservesLabelNat
    (C : ThetaIndeterminacyChoice K Label)
    (labelNat : Label → ℕ)
    (hC : C.PreservesLabelNat labelNat)
    (j : Label) :
    C.outputPower labelNat j = labelNat j ^ 2 + C.ind3 j := by
  simp [outputPower, hC j]

/-- Spectrum-preserving choices never decrease the native theta exponent. -/
theorem nativePower_le_outputPower
    (C : ThetaIndeterminacyChoice K Label)
    (labelNat : Label → ℕ)
    (hC : C.PreservesLabelNat labelNat)
    (j : Label) :
    labelNat j ^ 2 ≤ C.outputPower labelNat j := by
  rw [C.outputPower_eq_of_preservesLabelNat labelNat hC j]
  exact Nat.le_add_right _ _

/-- Every spectrum-preserving candidate output is contained in the native
Tate-power region at that coordinate. -/
theorem outputRegion_subset_native_qPowerRegion
    (t : TateParameter K)
    (C : ThetaIndeterminacyChoice K Label)
    (labelNat : Label → ℕ)
    (hC : C.PreservesLabelNat labelNat)
    (j : Label) :
    C.outputRegion t labelNat j ⊆
      t.qPowerRegion (labelNat j ^ 2) := by
  rw [C.outputRegion_eq_qPowerRegion t labelNat j]
  exact t.qPowerRegion_antitone
    (C.nativePower_le_outputPower labelNat hC j)

/-- The unmodified candidate packet. -/
def nativeChoice : ThetaIndeterminacyChoice K Label where
  ind1 := NormOneKummerUnit.one
  ind2 := Equiv.refl Label
  ind3 := fun _ => 0

/-- The native choice preserves every label spectrum. -/
@[simp]
theorem nativeChoice_preservesLabelNat
    (labelNat : Label → ℕ) :
    (nativeChoice (K := K) (Label := Label)).PreservesLabelNat labelNat := by
  intro j
  rfl

/-- The native choice realizes the original Tate-power region exactly. -/
theorem nativeChoice_outputRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j : Label) :
    (nativeChoice (K := K) (Label := Label)).outputRegion
        t labelNat j =
      t.qPowerRegion (labelNat j ^ 2) := by
  rw [outputRegion_eq_qPowerRegion]
  simp [nativeChoice, outputPower]

/-- The coordinatewise union over all spectrum-preserving choices. -/
def spectrumPreservingComponentUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j : Label) : Set K :=
  ⋃ (C : ThetaIndeterminacyChoice K Label),
    ⋃ (_hC : C.PreservesLabelNat labelNat),
      C.outputRegion t labelNat j

/-- **Non-collapsing envelope theorem.**  Restricting Ind2 to preserve the
label spectrum makes the independently unioned component exactly the native
q-power region. -/
theorem spectrumPreservingComponentUnion_eq_native_qPowerRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j : Label) :
    spectrumPreservingComponentUnion t labelNat j =
      t.qPowerRegion (labelNat j ^ 2) := by
  apply Set.Subset.antisymm
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
    rcases Set.mem_iUnion.mp hxC with ⟨hC, hxOut⟩
    exact C.outputRegion_subset_native_qPowerRegion
      t labelNat hC j hxOut
  · intro x hx
    apply Set.mem_iUnion.mpr
    refine ⟨nativeChoice (K := K) (Label := Label), ?_⟩
    apply Set.mem_iUnion.mpr
    refine ⟨nativeChoice_preservesLabelNat
      (K := K) (Label := Label) labelNat, ?_⟩
    rw [nativeChoice_outputRegion t labelNat j]
    exact hx

end ThetaIndeterminacyChoice

end IUTThreeClosures
