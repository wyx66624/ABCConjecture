/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.Ind2PermutationVolumeQuotient

/-!
# Packet-volume invariance does not imply componentwise-union invariance

Arbitrary label permutations preserve the total or average volume of each
individual packet.  It does **not** follow that taking the componentwise union
of all permuted packets preserves this volume.

The finite counterexample has two labels and a two-point carrier.  One label
contains one point and the other contains two points.  Swapping the labels
preserves total cardinality `3`.  The componentwise union of the original and
swapped packets contains two points at both labels, so its total cardinality is
`4`.

Thus a proof of Theorem 3.11/Corollary 3.12 may use arbitrary Ind2 only if the
possible-image object is interpreted as a permutation orbit/coarse quotient, or
if an additional correlated-packet theorem prevents replacing the orbit by a
componentwise union.  Volume invariance of individual packets alone is not
sufficient for a literal componentwise-union model.
-/

namespace IUTThreeClosures

namespace Ind2UnionVolumeCounterexample

/-- Two labels. -/
abbrev Label := Bool

/-- Two-point component carrier. -/
abbrev Point := Fin 2

/-- The base packet: one point at `false`, two points at `true`. -/
def baseRegion : Label → Finset Point
  | false => {0}
  | true => {0, 1}

/-- The nontrivial label permutation. -/
def swapLabel : Equiv.Perm Label :=
  Equiv.swap false true

/-- Relabeled packet. -/
def swappedRegion : Label → Finset Point :=
  fun i => baseRegion (swapLabel i)

/-- Componentwise union of the two packets. -/
def unionRegion : Label → Finset Point :=
  fun i => baseRegion i ∪ swappedRegion i

/-- Total counting volume of a finite packet. -/
def countingTotal (R : Label → Finset Point) : ℕ :=
  ∑ i, (R i).card

/-- The original packet has total cardinality three. -/
theorem countingTotal_base :
    countingTotal baseRegion = 3 := by
  native_decide

/-- The permuted packet has the same total cardinality. -/
theorem countingTotal_swapped :
    countingTotal swappedRegion = 3 := by
  native_decide

/-- The componentwise union has strictly larger total cardinality four. -/
theorem countingTotal_union :
    countingTotal unionRegion = 4 := by
  native_decide

/-- Explicit failure of componentwise-union volume invariance. -/
theorem union_strictly_larger_than_each_packet :
    countingTotal baseRegion < countingTotal unionRegion ∧
      countingTotal swappedRegion < countingTotal unionRegion := by
  rw [countingTotal_base, countingTotal_swapped, countingTotal_union]
  norm_num

/-- Therefore no general principle can infer preservation of componentwise
union volume solely from equality of the volumes of each orbit member. -/
theorem no_general_orbit_to_union_volume_principle :
    ¬ (∀
      (R S : Label → Finset Point),
      countingTotal R = countingTotal S →
      countingTotal (fun i => R i ∪ S i) = countingTotal R) := by
  intro h
  have heq := h baseRegion swappedRegion
    (countingTotal_base.trans countingTotal_swapped.symm)
  rw [show (fun i => baseRegion i ∪ swappedRegion i) = unionRegion from rfl,
    countingTotal_union, countingTotal_base] at heq
  norm_num at heq

end Ind2UnionVolumeCounterexample

end IUTThreeClosures
