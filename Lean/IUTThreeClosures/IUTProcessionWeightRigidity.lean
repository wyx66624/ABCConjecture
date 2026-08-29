/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalArithmeticGain
import Iut.Cor312.Procession
import Mathlib

/-!
# Procession inclusions force equal capsule weights

IUT III, Remark 3.9.3 explains why the procession normalization cannot be
replaced by arbitrary capsule weights: the same labeled log-shell occurs in
many different capsules, so compatibility with the procession inclusions
forces those capsules to receive the same weight.

For the standard nested procession every pair of capsules contains label zero.
Thus the compatibility condition already forces every capsule weight to be
equal.  If the total weight is one, the only possible normalization is the
ordinary uniform average.  In particular, a terminal point mass is not a
procession-compatible normalization.

This is a genuine no-go theorem for using the terminal coefficient merely by
reweighting the standard procession.  It does not rule out a new relative,
quotient or determinant construction that changes the geometric object before
log-volume normalization.
-/

namespace IUTThreeClosures
namespace IUTProcessionWeightRigidity

open Iut
open scoped BigOperators

noncomputable section

/-- Compatibility of capsule weights with the fact that one label may be read
inside either of two capsules containing it. -/
def InclusionCompatibleWeight
    {n : ℕ} (weight : Fin n → ℝ) : Prop :=
  ∀ i j : Fin n, ∀ label : ℕ,
    label ∈ procLabels (i.1 + 1) →
    label ∈ procLabels (j.1 + 1) →
    weight i = weight j

/-- Every inclusion-compatible weight on the standard procession is constant,
because label zero occurs in every capsule. -/
theorem inclusionCompatibleWeight_constant
    {n : ℕ} (weight : Fin n → ℝ)
    (hcompat : InclusionCompatibleWeight weight) :
    ∀ i j : Fin n, weight i = weight j := by
  intro i j
  apply hcompat i j 0
  · exact mem_procLabels.mpr (Nat.zero_le _)
  · exact mem_procLabels.mpr (Nat.zero_le _)

/-- A normalized inclusion-compatible weight is the uniform capsule weight. -/
theorem inclusionCompatibleWeight_eq_uniform
    {n : ℕ} [NeZero n]
    (weight : Fin n → ℝ)
    (hcompat : InclusionCompatibleWeight weight)
    (hnormalized : ∑ i, weight i = 1) :
    ∀ i : Fin n, weight i = 1 / (n : ℝ) := by
  intro i
  have hconstant := inclusionCompatibleWeight_constant weight hcompat
  have hsum : (n : ℝ) * weight i = 1 := by
    calc
      (n : ℝ) * weight i = ∑ _j : Fin n, weight i := by simp
      _ = ∑ j : Fin n, weight j := by
        apply Finset.sum_congr rfl
        intro j hj
        exact (hconstant j i).symm
      _ = 1 := hnormalized
  have hnNat : n ≠ 0 := NeZero.ne n
  have hn : (n : ℝ) ≠ 0 := by exact_mod_cast hnNat
  apply (eq_div_iff hn).2
  simpa [mul_comm] using hsum

/-- Terminal point mass on the capsule index set. -/
def terminalCapsuleWeight (n : ℕ) (i : Fin n) : ℝ :=
  if i.1 = n - 1 then 1 else 0

/-- For a procession with at least two capsules, terminal concentration is not
compatible with the procession inclusion maps. -/
theorem terminalCapsuleWeight_not_inclusionCompatible
    {n : ℕ} (hn : 2 ≤ n) :
    ¬ InclusionCompatibleWeight (terminalCapsuleWeight n) := by
  intro hcompat
  let first : Fin n := ⟨0, by omega⟩
  let terminal : Fin n := ⟨n - 1, by omega⟩
  have heq := hcompat first terminal 0
    (mem_procLabels.mpr (Nat.zero_le _))
    (mem_procLabels.mpr (Nat.zero_le _))
  have hne : (0 : ℕ) ≠ n - 1 := by omega
  simp [terminalCapsuleWeight, first, terminal, hne] at heq

/-- More generally, every nonconstant capsule weighting violates inclusion
compatibility. -/
theorem nonconstant_weight_not_inclusionCompatible
    {n : ℕ} (weight : Fin n → ℝ)
    (hnonconstant : ∃ i j : Fin n, weight i ≠ weight j) :
    ¬ InclusionCompatibleWeight weight := by
  intro hcompat
  rcases hnonconstant with ⟨i, j, hij⟩
  exact hij (inclusionCompatibleWeight_constant weight hcompat i j)

#print axioms inclusionCompatibleWeight_constant
#print axioms inclusionCompatibleWeight_eq_uniform
#print axioms terminalCapsuleWeight_not_inclusionCompatible
#print axioms nonconstant_weight_not_inclusionCompatible

end
end IUTProcessionWeightRigidity
end IUTThreeClosures
