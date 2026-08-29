/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalLabelStabilizer
import Iut.Cor312.Procession
import Mathlib.Tactic

/-!
# Coherent Ind2 actions on the standard procession

The standard procession is the nested chain

`{0,1} ⊆ {0,1,2} ⊆ ... ⊆ {0,...,n}`.

If label permutations at successive capsules commute with the procession
inclusion maps, then every newly added label is fixed.  Indeed, the old label
set is carried bijectively to itself, so its one-point complement cannot be
moved into the old set.

This observation substantially narrows the terminal-label interface.  Full
independent permutation symmetry destroys terminal concentration, but a
procession-coherent Ind2 action automatically lies in the stabilizer of each
new label, including the terminal label of the last capsule.  The remaining
source theorem is therefore to prove that the genuine global Ind2 ambiguity
acts naturally on the procession diagram, rather than as unrelated
permutations of its capsules.
-/

namespace IUTThreeClosures
namespace IUTProcessionCoherentInd2

open Iut

noncomputable section

/-- A family of label permutations natural with respect to every inclusion in
a procession. -/
structure CoherentPermutation {ι : Type*} (P : Procession ι) where
  perm : ∀ i : Fin P.length, Equiv.Perm (P.capsule i).LabelType
  naturality : ∀ {i j : Fin P.length} (h : i ≤ j)
    (x : (P.capsule i).LabelType),
    P.inclusion h (perm i x) = perm j (P.inclusion h x)

namespace CoherentPermutation

/-- The uniquely new label in capsule `i` of the standard procession. -/
def standardNewLabel (n : ℕ) (i : Fin n) :
    ((Procession.standard n).capsule i).LabelType := by
  refine ⟨i.1 + 1, ?_⟩
  change i.1 + 1 ∈ procLabels (i.1 + 1)
  exact mem_procLabels.mpr le_rfl

@[simp]
theorem standardNewLabel_val (n : ℕ) (i : Fin n) :
    (standardNewLabel n i).1 = i.1 + 1 := rfl

/-- Naturality across two successive capsules forces the new label of the
larger capsule to be fixed. -/
theorem fixes_new_label_of_successive
    {n : ℕ}
    (A : CoherentPermutation (Procession.standard n))
    {previous current : Fin n}
    (hsucc : previous.1 + 1 = current.1) :
    A.perm current (standardNewLabel n current) =
      standardNewLabel n current := by
  let terminal := standardNewLabel n current
  by_contra hmove
  let y : ℕ := (A.perm current terminal).1
  have hyTop : y ≤ current.1 + 1 := by
    have hyMem := (A.perm current terminal).2
    change y ∈ procLabels (current.1 + 1) at hyMem
    exact mem_procLabels.mp hyMem
  have hyNe : y ≠ current.1 + 1 := by
    intro hy
    apply hmove
    apply Subtype.ext
    exact hy
  have hyOld : y ≤ current.1 := by omega
  have hyPrevious : y ≤ previous.1 + 1 := by omega
  let oldLabel :
      ((Procession.standard n).capsule previous).LabelType := by
    refine ⟨y, ?_⟩
    change y ∈ procLabels (previous.1 + 1)
    exact mem_procLabels.mpr hyPrevious
  let x : ((Procession.standard n).capsule previous).LabelType :=
    (A.perm previous).symm oldLabel
  have hprevCurrent : previous ≤ current := by
    apply Fin.le_iff_val_le_val.mpr
    omega
  have hnat := A.naturality hprevCurrent x
  have hpermPrevious : A.perm previous x = oldLabel :=
    (A.perm previous).apply_symm_apply oldLabel
  rw [hpermPrevious] at hnat
  have holdToMoved :
      (Procession.standard n).inclusion hprevCurrent oldLabel =
        A.perm current terminal := by
    apply Subtype.ext
    rfl
  have hequalImages :
      A.perm current
          ((Procession.standard n).inclusion hprevCurrent x) =
        A.perm current terminal := by
    exact hnat.symm.trans holdToMoved
  have hinclusion :
      (Procession.standard n).inclusion hprevCurrent x = terminal :=
    (A.perm current).injective hequalImages
  have hxMem := x.2
  have hxLePrevious : x.1 ≤ previous.1 + 1 := by
    change x.1 ∈ procLabels (previous.1 + 1) at hxMem
    exact mem_procLabels.mp hxMem
  have hxLeCurrent : x.1 ≤ current.1 := by omega
  have hxEq : x.1 = current.1 + 1 := by
    exact congrArg Subtype.val hinclusion
  omega

/-- In particular, every noninitial capsule's newly added label is fixed by a
coherent permutation family. -/
theorem fixes_new_label
    {n : ℕ}
    (A : CoherentPermutation (Procession.standard n))
    (current : Fin n)
    (hcurrent : 0 < current.1) :
    A.perm current (standardNewLabel n current) =
      standardNewLabel n current := by
  let previous : Fin n :=
    ⟨current.1 - 1, by omega⟩
  apply fixes_new_label_of_successive A
  dsimp [previous]
  omega

/-- The terminal new label of every standard procession of length at least two
is fixed by every coherent permutation family. -/
theorem fixes_terminal_label
    {n : ℕ}
    (hn : 2 ≤ n)
    (A : CoherentPermutation (Procession.standard n)) :
    let terminalIndex : Fin n := ⟨n - 1, by omega⟩
    A.perm terminalIndex (standardNewLabel n terminalIndex) =
      standardNewLabel n terminalIndex := by
  dsimp
  apply fixes_new_label A
  omega

/-- Apart from a possible swap of the two labels in the first capsule, every
label introduced later in the standard procession is pointwise fixed. -/
theorem fixes_all_later_new_labels
    {n : ℕ}
    (A : CoherentPermutation (Procession.standard n)) :
    ∀ i : Fin n, 0 < i.1 →
      A.perm i (standardNewLabel n i) = standardNewLabel n i := by
  intro i hi
  exact fixes_new_label A i hi

#print axioms fixes_new_label_of_successive
#print axioms fixes_new_label
#print axioms fixes_terminal_label
#print axioms fixes_all_later_new_labels

end CoherentPermutation

end
end IUTProcessionCoherentInd2
end IUTThreeClosures
