/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalLabelInd2Rigidity

/-!
# The exact Ind2 stabilizer of the terminal reading

Full permutation symmetry forces uniform averaging, but terminal concentration
does not require eliminating every Ind2 operation.  It is invariant precisely
under the stabilizer of the selected terminal label.

This module proves the exact equivalence.  Therefore the geometric input needed
by the coefficient-two programme can be reduced to a concrete symmetry
question: construct a source-derived terminal label and show that the relevant
Ind2 ambiguity acts through its stabilizer (or through a quotient with the same
effect on the terminal reading).
-/

namespace IUTThreeClosures
namespace IUTTerminalLabelStabilizer

noncomputable section

universe u

variable {Label : Type u}

open IUTTerminalLabelInd2Rigidity

/-- Permutations fixing a selected terminal label. -/
def TerminalStabilizer (terminal : Label) :=
  {σ : Equiv.Perm Label // σ terminal = terminal}

/-- A permutation preserves the terminal point-mass reading exactly when it
fixes the terminal label. -/
theorem pointWeight_invariant_iff_fixes
    [DecidableEq Label]
    (terminal : Label) (σ : Equiv.Perm Label) :
    (∀ i : Label,
      pointWeight terminal (σ i) = pointWeight terminal i) ↔
      σ terminal = terminal := by
  constructor
  · intro hinvariant
    have h := hinvariant terminal
    unfold pointWeight at h
    simp only [if_pos] at h
    by_contra hne
    rw [if_neg hne] at h
    norm_num at h
  · intro hfix i
    unfold pointWeight
    by_cases hi : i = terminal
    · subst i
      simp [hfix]
    · have himage : σ i ≠ terminal := by
        intro hbad
        apply hi
        apply σ.injective
        calc
          σ i = terminal := hbad
          _ = σ terminal := hfix.symm
      simp [hi, himage]

/-- The terminal point mass is invariant under every element of the terminal
stabilizer. -/
theorem pointWeight_invariant_under_stabilizer
    [DecidableEq Label]
    (terminal : Label) :
    ∀ σ : TerminalStabilizer terminal, ∀ i : Label,
      pointWeight terminal (σ.1 i) = pointWeight terminal i := by
  intro σ
  exact (pointWeight_invariant_iff_fixes terminal σ.1).2 σ.2

/-- Conversely, every collection of permutations preserving the terminal point
mass is contained pointwise in the terminal stabilizer. -/
theorem preserving_permutation_mem_stabilizer
    [DecidableEq Label]
    (terminal : Label) (σ : Equiv.Perm Label)
    (hpreserves : ∀ i : Label,
      pointWeight terminal (σ i) = pointWeight terminal i) :
    σ ∈ {τ : Equiv.Perm Label | τ terminal = terminal} := by
  exact (pointWeight_invariant_iff_fixes terminal σ).1 hpreserves

#print axioms pointWeight_invariant_iff_fixes
#print axioms pointWeight_invariant_under_stabilizer
#print axioms preserving_permutation_mem_stabilizer

end
end IUTTerminalLabelStabilizer
end IUTThreeClosures
