/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCFlaggedCRTSurplusResidueCube20260904
import Mathlib.Combinatorics.Pigeonhole

/-!
# Anchored prefix fibres for proper-face CRT flags

The ordinary definitions and proofs precede this module in
`research/ABC_ANCHORED_PREFIX_FLAGGED_CRT_2026_09_04.md`.

This module proves the finite kernel used there: Bae's anchored-fibre
avoidance lemma, its application to additive prefix labels with an abstract
weight-cell code, the complement dictionary from a zero-label deletion to a
proper compatible packet, and the capped-credit inequalities.  It also
checks the complete-premise arithmetic counterexample `(1,4715,4716)` to the
raw Boolean-cardinality shortcut.

No uniform endpoint entropy estimate, concrete endpoint unit-group
construction, `FCRT-1` gate, or unconditional `ABCConjecture` is assumed.
-/

namespace IUTThreeClosures
namespace ABCAnchoredPrefixFlaggedCRT20260904

open scoped BigOperators
open ABCFlaggedCRTSurplusResidueCube20260904

theorem anchoredCodeFibreAvoidance
    {Omega : Type*} [Fintype Omega]
    (J : Nat) (code : Nat -> Omega) (forbidden : Finset Nat)
    (hcount : Fintype.card Omega * (forbidden.card + 1) < J + 1) :
    ∃ i j : Nat,
      i ≤ J ∧ j ≤ J ∧ i < j ∧
      code i = code j ∧ j - i ∉ forbidden := by
  classical
  let s : Finset Nat := Finset.range (J + 1)
  obtain ⟨label, _hlabel, hfibre⟩ :=
    Finset.exists_lt_card_fiber_of_mul_lt_card_of_maps_to
      (s := s) (t := (Finset.univ : Finset Omega)) (f := code)
      (n := forbidden.card + 1)
      (by simp)
      (by simpa [s] using hcount)
  let A : Finset Nat := s.filter fun k => code k = label
  have hAcard : forbidden.card + 1 < A.card := by
    simpa [A] using hfibre
  have hAnonempty : A.Nonempty := by
    exact Finset.card_pos.mp (by omega)
  let i : Nat := A.min' hAnonempty
  have hiA : i ∈ A := Finset.min'_mem A hAnonempty
  let B : Finset Nat := A.erase i
  have hBcard : forbidden.card < B.card := by
    have herase : B.card = A.card - 1 := by
      simpa [B] using Finset.card_erase_of_mem hiA
    omega
  have hilt (j : Nat) (hjB : j ∈ B) : i < j := by
    have hjA : j ∈ A := (Finset.mem_erase.mp hjB).2
    have hile : i ≤ j := Finset.min'_le A j hjA
    have hne : j ≠ i := (Finset.mem_erase.mp hjB).1
    omega
  have hinj : Set.InjOn (fun j : Nat => j - i) (B : Set Nat) := by
    intro a ha b hb hab
    have hia : i ≤ a := (hilt a ha).le
    have hib : i ≤ b := (hilt b hb).le
    change a - i = b - i at hab
    calc
      a = (a - i) + i := (Nat.sub_add_cancel hia).symm
      _ = (b - i) + i := congrArg (fun n : Nat => n + i) hab
      _ = b := Nat.sub_add_cancel hib
  have hexists : ∃ j ∈ B, j - i ∉ forbidden := by
    by_contra hnone
    have hnone' : ∀ j, j ∈ B → j - i ∈ forbidden := by
      intro j hj
      by_contra hsafe
      exact hnone ⟨j, hj, hsafe⟩
    have himage : B.image (fun j : Nat => j - i) ⊆ forbidden := by
      intro d hd
      obtain ⟨j, hjB, rfl⟩ := Finset.mem_image.mp hd
      exact hnone' j hjB
    have hcardImage : (B.image (fun j : Nat => j - i)).card = B.card :=
      Finset.card_image_of_injOn hinj
    have hle : B.card ≤ forbidden.card := by
      rw [← hcardImage]
      exact Finset.card_le_card himage
    omega
  obtain ⟨j, hjB, hsafe⟩ := hexists
  have hiRange : i ∈ s := (Finset.mem_filter.mp hiA).1
  have hjA : j ∈ A := (Finset.mem_erase.mp hjB).2
  have hjRange : j ∈ s := (Finset.mem_filter.mp hjA).1
  have hicode : code i = label := (Finset.mem_filter.mp hiA).2
  have hjcode : code j = label := (Finset.mem_filter.mp hjA).2
  refine ⟨i, j, ?_, ?_, hilt j hjB, hicode.trans hjcode.symm, hsafe⟩
  · simpa [s] using hiRange
  · simpa [s] using hjRange

variable {G Cell : Type*}

/-- Additive label accumulated along the first `k` steps of an ordered
packet reservoir. -/
def prefixLabel [AddCommMonoid G] (label : Nat → G) (k : Nat) : G :=
  ∑ r ∈ Finset.range k, label r

/-- Label of the half-open ordered packet interval `[i,j)`. -/
def intervalLabel [AddCommMonoid G]
    (label : Nat → G) (i j : Nat) : G :=
  ∑ r ∈ Finset.Ico i j, label r

/-- Prefix cancellation turns an equal-code pair into a zero-sum interval. -/
theorem intervalLabel_eq_zero_of_prefix_eq
    [AddCommGroup G] (label : Nat → G) {i j : Nat}
    (hij : i ≤ j)
    (heq : prefixLabel label i = prefixLabel label j) :
    intervalLabel label i j = 0 := by
  have hsum :
      prefixLabel label i + intervalLabel label i j = prefixLabel label j := by
    simpa [prefixLabel, intervalLabel] using
      Finset.sum_range_add_sum_Ico label hij
  apply add_left_cancel (a := prefixLabel label i)
  simpa [heq] using hsum

/-- Abstract weighted version of Bae's selection step.  A finite cell code
is allowed to encode a logarithmic prefix-weight cell.  Equal cells are
required to certify the desired interval-weight bound. -/
theorem exists_zeroInterval_avoiding_forbidden
    [Fintype G] [AddCommGroup G]
    [Fintype Cell]
    (m : Nat) (label : Nat → G) (cell : Nat → Cell)
    (prefixWeight : Nat → Real) (L : Real) (forbidden : Finset Nat)
    (hcount :
      Fintype.card G * Fintype.card Cell * (forbidden.card + 1) < m + 1)
    (hcell : ∀ i j,
      i ≤ m → j ≤ m → i < j → cell i = cell j →
        prefixWeight j - prefixWeight i ≤ L) :
    ∃ i j : Nat,
      i ≤ m ∧ j ≤ m ∧ i < j ∧ j - i ∉ forbidden ∧
      intervalLabel label i j = 0 ∧
      prefixWeight j - prefixWeight i ≤ L := by
  have hcount' :
      Fintype.card (G × Cell) * (forbidden.card + 1) < m + 1 := by
    simpa [Fintype.card_prod, Nat.mul_assoc] using hcount
  obtain ⟨i, j, hi, hj, hij, hcode, hsafe⟩ :=
    anchoredCodeFibreAvoidance m
      (fun k => (prefixLabel label k, cell k)) forbidden hcount'
  have hprefix : prefixLabel label i = prefixLabel label j :=
    congrArg Prod.fst hcode
  have hsameCell : cell i = cell j := congrArg Prod.snd hcode
  exact ⟨i, j, hi, hj, hij, hsafe,
    intervalLabel_eq_zero_of_prefix_eq label hij.le hprefix,
    hcell i j hi hj hij hsameCell⟩

section ComplementDictionary

variable {ι : Type*} [DecidableEq ι] [Fintype ι]

omit [Fintype ι] in
/-- In a jointly compatible target fibre, deleting a nonempty zero-label
subpacket produces a nonempty proper compatible face. -/
theorem zeroDeletion_gives_compatibleProperFace
    [AddCommGroup G] (label : ι → G) (eta : G)
    {T D : Finset ι}
    (heta : eta ≠ 0)
    (hT : IsCompatiblePacket label eta T)
    (hDT : D ⊆ T) (hDnonempty : D.Nonempty)
    (hDzero : packetLabel label D = 0) :
    IsCompatiblePacket label eta (T \ D) ∧
      (T \ D).Nonempty ∧ T \ D ⊂ T := by
  have hdecomp := packetLabel_inter_add_sdiff label T D
  have hinter : T ∩ D = D := Finset.inter_eq_right.mpr hDT
  have hcompatible : IsCompatiblePacket label eta (T \ D) := by
    unfold IsCompatiblePacket at hT ⊢
    rw [hinter, hDzero, zero_add] at hdecomp
    exact hdecomp.trans hT
  have hnonempty : (T \ D).Nonempty := by
    by_contra hempty
    have hEmpty : T \ D = ∅ := Finset.not_nonempty_iff_eq_empty.mp hempty
    have hzero : packetLabel label (T \ D) = 0 := by
      simp [hEmpty, packetLabel]
    exact heta ((show packetLabel label (T \ D) = eta from hcompatible).symm.trans hzero)
  exact ⟨hcompatible, hnonempty, Finset.sdiff_ssubset hDT hDnonempty⟩

omit [Fintype ι] in
/-- Conversely, two nested packets in the same target fibre differ by a
zero-label deletion. -/
theorem compatibleProperFace_gives_zeroDeletion
    [AddCommGroup G] (label : ι → G) (eta : G)
    {T U : Finset ι} (hUT : U ⊆ T)
    (hT : IsCompatiblePacket label eta T)
    (hU : IsCompatiblePacket label eta U) :
    packetLabel label (T \ U) = 0 := by
  have hdecomp := packetLabel_inter_add_sdiff label T U
  have hinter : T ∩ U = U := Finset.inter_eq_right.mpr hUT
  unfold IsCompatiblePacket at hT hU
  rw [hinter, hU, hT] at hdecomp
  apply add_left_cancel (a := eta)
  simpa using hdecomp

end ComplementDictionary

/-- The deletion-weight estimate becomes the lower bound on capped FCRT
reuse credit in the ordinary theorem. -/
theorem reuseCredit_lower_bound_of_deletion_le
    (blockWeight sourceWeight deletionWeight L : Real)
    (hdeletion : deletionWeight ≤ L) :
    min (blockWeight - sourceWeight) (blockWeight - L) ≤
      min (blockWeight - sourceWeight) (blockWeight - deletionWeight) := by
  exact min_le_min le_rfl (sub_le_sub_left hdeletion blockWeight)

/-- If the zero-sum deletion weighs no more than the covered source face,
the witness-face cap does not reduce the block surplus. -/
theorem reuseCredit_eq_surplus_of_deletion_le_source
    (blockWeight sourceWeight deletionWeight : Real)
    (hdeletion : deletionWeight ≤ sourceWeight) :
    min (blockWeight - sourceWeight) (blockWeight - deletionWeight) =
      blockWeight - sourceWeight := by
  exact min_eq_left (sub_le_sub_left hdeletion blockWeight)

/-- Covering every source except the flag target and reusing the full block
surplus leaves exactly the scalar endpoint defect. -/
theorem fullSurplus_targetResidual_eq_scalarDefect
    (targetWeight coveredWeight sinkWeight : Real) :
    max (targetWeight - (sinkWeight - coveredWeight)) 0 =
      max ((targetWeight + coveredWeight) - sinkWeight) 0 := by
  congr 1
  ring

/-! ## Exact arithmetic counterexample to the raw Boolean threshold -/

theorem witness4715_sum : (1 : Nat) + 4715 = 4716 := by
  norm_num

theorem witness4715_factor_b : (4715 : Nat) = 5 * 23 * 41 := by
  norm_num

theorem witness4715_factor_c : (4716 : Nat) = 2 ^ 2 * 3 ^ 2 * 131 := by
  norm_num

theorem witness4715_sink_primes :
    Nat.Prime 5 ∧ Nat.Prime 23 ∧ Nat.Prime 41 := by
  norm_num

theorem witness4715_source_primes :
    Nat.Prime 2 ∧ Nat.Prime 3 ∧ Nat.Prime 131 := by
  norm_num

theorem witness4715_primitive : Nat.Coprime 1 4715 := by
  norm_num

theorem witness4715_source_three : (3 ^ 2 : Nat) ∣ 4716 := by
  norm_num

theorem witness4715_block_source_two : (2 ^ 2 : Nat) ∣ 4716 := by
  norm_num

theorem witness4715_unit_group_card : Nat.totient 9 = 6 := by
  decide

theorem witness4715_boolean_count_exceeds_unit_group :
    (2 : Nat) ^ 3 > Nat.totient 9 := by
  decide

/-- The three squarefree sink primes of `4715`. -/
def witness4715SinkPrime : Fin 3 → Nat := ![5, 23, 41]

/-- The `b`-arm associated with a Boolean packet of the three sinks. -/
def witness4715PacketArm (U : Finset (Fin 3)) : Nat :=
  U.prod witness4715SinkPrime

theorem witness4715_fullPacketArm :
    witness4715PacketArm Finset.univ = 4715 := by
  decide

/-- Every nonempty proper Boolean packet fails the complete modulus-nine
compatibility premise.  This quantifies over all eight packets. -/
theorem witness4715_no_nonemptyProperPacket_for_three :
    ∀ U : Finset (Fin 3),
      U.Nonempty → U ≠ Finset.univ →
        ¬(3 ^ 2 : Nat) ∣ 1 + witness4715PacketArm U := by
  decide

/-- Since every flag face is contained in its block, the preceding complete
enumeration rules out a target-three flag inside every Boolean block. -/
theorem witness4715_no_targetFlag_for_three :
    ∀ U T : Finset (Fin 3),
      U.Nonempty → U ⊆ T → U ≠ T →
        ¬(3 ^ 2 : Nat) ∣ 1 + witness4715PacketArm U := by
  intro U T hUnonempty hUT hUne
  apply witness4715_no_nonemptyProperPacket_for_three U hUnonempty
  intro hUuniv
  have hunivT : (Finset.univ : Finset (Fin 3)) ⊆ T := by
    simpa [hUuniv] using hUT
  have hTuniv : T = Finset.univ :=
    Finset.Subset.antisymm (Finset.subset_univ T) hunivT
  exact hUne (hUuniv.trans hTuniv.symm)

theorem witness4715_fullPacket_for_three :
    (3 ^ 2 : Nat) ∣ 1 + witness4715PacketArm Finset.univ := by
  rw [witness4715_fullPacketArm]
  norm_num

theorem witness4715_each_sink_inverse_is_two_mod_nine :
    ((5 : ZMod 9)⁻¹ = 2) ∧
      ((23 : ZMod 9)⁻¹ = 2) ∧
      ((41 : ZMod 9)⁻¹ = 2) := by
  constructor
  · exact ZMod.inv_eq_of_mul_eq_one 9 (5 : ZMod 9) (2 : ZMod 9) (by decide)
  constructor
  · exact ZMod.inv_eq_of_mul_eq_one 9 (23 : ZMod 9) (2 : ZMod 9) (by decide)
  · exact ZMod.inv_eq_of_mul_eq_one 9 (41 : ZMod 9) (2 : ZMod 9) (by decide)

theorem witness4715_fullBlock_saturated :
    Real.log 2 < Real.log 4715 := by
  exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)

end ABCAnchoredPrefixFlaggedCRT20260904
end IUTThreeClosures
