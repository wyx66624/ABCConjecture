/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalLocalPossibleImage
import Mathlib

/-!
# Ind2 symmetry rigidity for the terminal-label route

The terminal square label is the optimal nonnegative label reading, but a
point mass at that label is not invariant under arbitrary label permutations.
This file proves the exact finite symmetry statement:

* a real weight invariant under the full permutation group is constant;
* if its total mass is one, it is the uniform weight;
* every invariant linear label reading is therefore the ordinary arithmetic
  average;
* concentration at one terminal label breaks full Ind2 symmetry as soon as a
  second label exists.

Consequently, the coefficient-two terminal route cannot be obtained merely by
changing the weights inside a fully permutation-invariant public packet.  A
successful geometric construction must produce a source-derived distinguished
terminal label, a quotient that remembers it, or a theorem reducing the Ind2
ambiguity before the terminal projection is taken.
-/

namespace IUTThreeClosures
namespace IUTTerminalLabelInd2Rigidity

open scoped BigOperators

noncomputable section

universe u

variable {Label : Type u}

/-- Unit point mass at a selected label. -/
def pointWeight [DecidableEq Label] (terminal : Label) (i : Label) : ℝ :=
  if i = terminal then 1 else 0

/-- Invariance under the full permutation group forces a weight to be
constant on the label type. -/
theorem permutationInvariant_weight_constant
    [Fintype Label] [DecidableEq Label]
    (weight : Label → ℝ)
    (hinvariant : ∀ σ : Equiv.Perm Label, ∀ i : Label,
      weight (σ i) = weight i) :
    ∀ i j : Label, weight i = weight j := by
  intro i j
  have h := hinvariant (Equiv.swap i j) i
  simpa using h.symm

/-- A normalized fully permutation-invariant weight is the uniform weight. -/
theorem permutationInvariant_weight_eq_uniform
    [Fintype Label] [DecidableEq Label] [Nonempty Label]
    (weight : Label → ℝ)
    (hinvariant : ∀ σ : Equiv.Perm Label, ∀ i : Label,
      weight (σ i) = weight i)
    (hnormalized : ∑ i, weight i = 1) :
    ∀ i : Label,
      weight i = 1 / (Fintype.card Label : ℝ) := by
  intro i
  have hconstant := permutationInvariant_weight_constant weight hinvariant
  have hsum :
      (Fintype.card Label : ℝ) * weight i = 1 := by
    calc
      (Fintype.card Label : ℝ) * weight i =
          ∑ _j : Label, weight i := by simp
      _ = ∑ j : Label, weight j := by
        apply Finset.sum_congr rfl
        intro j hj
        exact (hconstant j i).symm
      _ = 1 := hnormalized
  have hcardNat : Fintype.card Label ≠ 0 := Fintype.card_ne_zero
  have hcard : (Fintype.card Label : ℝ) ≠ 0 := by
    exact_mod_cast hcardNat
  apply (eq_div_iff hcard).2
  simpa [mul_comm] using hsum

/-- Every normalized fully permutation-invariant linear reading is the
arithmetic mean of the label values. -/
theorem permutationInvariant_reading_eq_average
    [Fintype Label] [DecidableEq Label] [Nonempty Label]
    (weight value : Label → ℝ)
    (hinvariant : ∀ σ : Equiv.Perm Label, ∀ i : Label,
      weight (σ i) = weight i)
    (hnormalized : ∑ i, weight i = 1) :
    (∑ i, weight i * value i) =
      (1 / (Fintype.card Label : ℝ)) * ∑ i, value i := by
  have huniform :=
    permutationInvariant_weight_eq_uniform weight hinvariant hnormalized
  calc
    (∑ i, weight i * value i) =
        ∑ i, (1 / (Fintype.card Label : ℝ)) * value i := by
          apply Finset.sum_congr rfl
          intro i hi
          rw [huniform i]
    _ = (1 / (Fintype.card Label : ℝ)) * ∑ i, value i := by
      rw [Finset.mul_sum]

/-- A terminal point mass is not invariant under the full permutation group
when another label exists. -/
theorem pointWeight_not_permutationInvariant
    [DecidableEq Label]
    {terminal other : Label}
    (hne : terminal ≠ other) :
    ¬ ∀ σ : Equiv.Perm Label, ∀ i : Label,
      pointWeight terminal (σ i) = pointWeight terminal i := by
  intro hinvariant
  have h := hinvariant (Equiv.swap terminal other) terminal
  simp [pointWeight, hne, hne.symm] at h

/-- Hence a normalized full-Ind2-invariant reading cannot equal a terminal
point mass on a label type with at least two distinct elements. -/
theorem invariant_weight_ne_terminal_pointWeight
    [Fintype Label] [DecidableEq Label]
    (weight : Label → ℝ)
    (hinvariant : ∀ σ : Equiv.Perm Label, ∀ i : Label,
      weight (σ i) = weight i)
    {terminal other : Label}
    (hne : terminal ≠ other) :
    weight ≠ pointWeight terminal := by
  intro hweight
  apply pointWeight_not_permutationInvariant hne
  intro σ i
  rw [← hweight]
  exact hinvariant σ i

#print axioms permutationInvariant_weight_constant
#print axioms permutationInvariant_weight_eq_uniform
#print axioms permutationInvariant_reading_eq_average
#print axioms pointWeight_not_permutationInvariant
#print axioms invariant_weight_ne_terminal_pointWeight

end
end IUTTerminalLabelInd2Rigidity
end IUTThreeClosures
