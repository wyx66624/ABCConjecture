/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# Arbitrary Ind2 collapses a componentwise possible-image union

The concrete candidate model in `ActualHodgeTheaterOutput` currently permits
`Ind2` to be an arbitrary permutation of the theta-label type.  This is safe
only while the complete packet is retained.  If one first projects to one
coordinate and then unions independently over all choices, every coordinate
can be permuted to a zero label.

Since the zero-label output power is zero, its output region is the full norm
unit ball `O`.  Conversely every nonnegative Tate-power region is contained
in `O`.  Hence the componentwise union over arbitrary `Ind2` is exactly `O`
at every coordinate.

This is a formal no-go theorem for replacing the joint possible-image packet
by independent coordinate unions.  Such a replacement erases all q-scaling
information before the public theta-hull volume is read.  A valid model must
therefore retain packet-level compatibility, such as the existing
barycentric/zero-label coupling, or restrict `Ind2` substantially.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

namespace ThetaIndeterminacyChoice

/-- The union of one fixed output coordinate over all candidate
Ind1/Ind2/Ind3 choices. -/
def componentChoiceUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j : Label) : Set K :=
  ⋃ C : ThetaIndeterminacyChoice K Label,
    C.outputRegion t labelNat j

/-- Every individual candidate region is contained in the norm unit ball,
because its output power is nonnegative. -/
theorem outputRegion_subset_normIntegralRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) :
    C.outputRegion t labelNat j ⊆
      normIntegralRegion (K := K) := by
  rw [C.outputRegion_eq_qPowerRegion t labelNat j]
  simpa using
    (t.qPowerRegion_antitone
      (Nat.zero_le (C.outputPower labelNat j)))

/-- A choice which sends the observed coordinate `j` to a specified zero
label `z`, with trivial Ind1 and Ind3. -/
def zeroTargetChoice
    [DecidableEq Label]
    (j z : Label) : ThetaIndeterminacyChoice K Label where
  ind1 := NormOneKummerUnit.one
  ind2 := Equiv.swap j z
  ind3 := fun _ => 0

/-- The zero-target choice has output power zero. -/
@[simp]
theorem zeroTargetChoice_outputPower
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j z : Label)
    (hz : labelNat z = 0) :
    (zeroTargetChoice (K := K) j z).outputPower labelNat j = 0 := by
  simp [zeroTargetChoice, outputPower, hz]

/-- The zero-target candidate region is exactly the norm unit ball. -/
theorem zeroTargetChoice_outputRegion
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (j z : Label)
    (hz : labelNat z = 0) :
    (zeroTargetChoice (K := K) j z).outputRegion t labelNat j =
      normIntegralRegion (K := K) := by
  rw [outputRegion_eq_qPowerRegion,
    zeroTargetChoice_outputPower t labelNat j z hz,
    t.qPowerRegion_zero]

/-- **Component-collapse theorem.**  In the presence of one zero label,
allowing arbitrary Ind2 permutations makes the independently unioned possible
image of every coordinate equal to the entire norm unit ball. -/
theorem componentChoiceUnion_eq_normIntegralRegion
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (z : Label)
    (hz : labelNat z = 0)
    (j : Label) :
    componentChoiceUnion t labelNat j =
      normIntegralRegion (K := K) := by
  apply Set.Subset.antisymm
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
    exact C.outputRegion_subset_normIntegralRegion t labelNat j hxC
  · intro x hx
    apply Set.mem_iUnion.mpr
    refine ⟨zeroTargetChoice (K := K) j z, ?_⟩
    rw [zeroTargetChoice_outputRegion t labelNat j z hz]
    exact hx

end ThetaIndeterminacyChoice

end IUTThreeClosures
