/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# Arbitrary Ind2 collapses componentwise and packet-level product hulls

The concrete candidate model in `ActualHodgeTheaterOutput` currently permits
`Ind2` to be an arbitrary permutation of the theta-label type.  If one first
projects to one coordinate and unions independently over all choices, every
coordinate can be permuted to a zero label.  The earlier component theorem
therefore identifies every independent coordinate union with the norm unit
ball.

The packet-level theorem below removes the possible objection that the public
construction keeps complete packets before applying the holomorphic hull.  It
forms the literal union of complete packet regions and proves that its least
rectangular/product envelope is still the full product of norm unit balls.
The proof is genuinely joint: for every coordinate and every unit-ball value,
one concrete packet realizes that value at the chosen coordinate and zero at
all remaining coordinates.  Hence every product region containing the packet
union must contain the entire unit packet.

Thus an arbitrary-permutation Ind2 model loses all q-radii when passed through
a product-valued mono-analytic hull, even if one never interchanges a product
with a union.  A source-faithful model must retain additional cross-coordinate
structure or restrict Ind2.

No volume inequality, IUT IV estimate, or abc statement is assumed here.
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

/-! ## Complete packets and their least product envelope -/

/-- Literal union of the complete packet regions over all Ind1/Ind2/Ind3
choices. -/
def packetChoiceUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  ⋃ C : ThetaIndeterminacyChoice K Label,
    C.packetRegion t labelNat

/-- Product of normalized integer balls at all packet coordinates. -/
def unitPacketRegion : Set (Label → K) :=
  {x | ∀ j, x j ∈ normIntegralRegion (K := K)}

/-- Rectangular packet region with prescribed coordinate sets. -/
def productRegion (component : Label → Set K) : Set (Label → K) :=
  {x | ∀ j, x j ∈ component j}

/-- Predicate saying that a packet region is a direct product of component
regions. -/
def IsProductRegion (U : Set (Label → K)) : Prop :=
  ∃ component : Label → Set K, U = productRegion component

/-- Every concrete complete packet is contained in the normalized unit
packet. -/
theorem packetRegion_subset_unitPacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label) :
    C.packetRegion t labelNat ⊆ unitPacketRegion := by
  intro x hx j
  exact C.outputRegion_subset_normIntegralRegion t labelNat j (hx j)

/-- Hence the literal complete-packet union is contained in the unit packet. -/
theorem packetChoiceUnion_subset_unitPacketRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    packetChoiceUnion t labelNat ⊆ unitPacketRegion := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨C, hxC⟩
  exact packetRegion_subset_unitPacketRegion t labelNat C hxC

/-- Packet supported at one coordinate. -/
def coordinateSpike
    [DecidableEq Label]
    (j : Label) (z : K) : Label → K :=
  fun k => if k = j then z else 0

@[simp]
theorem coordinateSpike_apply_self
    [DecidableEq Label]
    (j : Label) (z : K) :
    coordinateSpike j z j = z := by
  simp [coordinateSpike]

@[simp]
theorem coordinateSpike_apply_of_ne
    [DecidableEq Label]
    {j k : Label} (hkj : k ≠ j) (z : K) :
    coordinateSpike j z k = 0 := by
  simp [coordinateSpike, hkj]

/-- With one zero label, every unit-ball value can be realized at an arbitrary
coordinate by one genuine complete packet; all other coordinates are zero,
which belongs to every Tate-power region. -/
theorem coordinateSpike_mem_packetChoiceUnion
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (zeroLabel j : Label)
    (hzero : labelNat zeroLabel = 0)
    {z : K}
    (hz : z ∈ normIntegralRegion (K := K)) :
    coordinateSpike j z ∈ packetChoiceUnion t labelNat := by
  apply Set.mem_iUnion.mpr
  let C : ThetaIndeterminacyChoice K Label :=
    zeroTargetChoice (K := K) j zeroLabel
  refine ⟨C, ?_⟩
  intro k
  by_cases hkj : k = j
  · subst k
    rw [coordinateSpike_apply_self]
    simpa [C] using
      (show z ∈
        (zeroTargetChoice (K := K) j zeroLabel).outputRegion
          t labelNat j by
        rw [zeroTargetChoice_outputRegion t labelNat j zeroLabel hzero]
        exact hz)
  · rw [coordinateSpike_apply_of_ne hkj]
    rw [C.outputRegion_eq_qPowerRegion t labelNat k]
    exact t.zero_mem_qPowerRegion _

/-- **Packet-level collapse theorem.**  The unit packet is the least product
region containing the literal union of all complete arbitrary-Ind2 packets.
Thus retaining joint packets before taking a rectangular holomorphic hull does
not rescue the q-radii in this candidate model. -/
theorem unitPacketRegion_isLeastProductHull
    [DecidableEq Label]
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (zeroLabel : Label)
    (hzero : labelNat zeroLabel = 0) :
    packetChoiceUnion t labelNat ⊆ unitPacketRegion ∧
      ∀ V : Set (Label → K),
        IsProductRegion V →
        packetChoiceUnion t labelNat ⊆ V →
        unitPacketRegion ⊆ V := by
  constructor
  · exact packetChoiceUnion_subset_unitPacketRegion t labelNat
  · intro V hV hUnion x hx
    rcases hV with ⟨component, rfl⟩
    intro j
    have hspike :
        coordinateSpike j (x j) ∈ productRegion component :=
      hUnion
        (coordinateSpike_mem_packetChoiceUnion
          t labelNat zeroLabel j hzero (hx j))
    simpa [productRegion] using hspike j

/-- The product-unit packet is itself a product region. -/
theorem unitPacketRegion_isProductRegion :
    IsProductRegion (unitPacketRegion (K := K) (Label := Label)) := by
  refine ⟨fun _ => normIntegralRegion (K := K), ?_⟩
  rfl

#print axioms componentChoiceUnion_eq_normIntegralRegion
#print axioms packetRegion_subset_unitPacketRegion
#print axioms packetChoiceUnion_subset_unitPacketRegion
#print axioms coordinateSpike_mem_packetChoiceUnion
#print axioms unitPacketRegion_isLeastProductHull
#print axioms unitPacketRegion_isProductRegion

end ThetaIndeterminacyChoice

end IUTThreeClosures
