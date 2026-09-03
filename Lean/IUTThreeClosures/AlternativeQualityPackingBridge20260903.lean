/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

namespace IUTThreeClosures
namespace AlternativeQualityPackingBridge20260903

/-!
# Packing efficiency for alternative abc quality metrics

The mathematical proofs precede this module in
`research/ABC_ALTERNATIVE_QUALITY_PACKING_AUDIT_2026_09_03.md`.

We isolate the exact algebraic content of the identity
`standard = efficiency * dgm`.  The final theorem constructs an abstract
full-premise countermodel to the invalid inference from unbounded DGM
quality to standard-quality excess.  It is not a family of arithmetic abc
triples.
-/

/-- Pointwise packing identity between standard and alternative qualities. -/
def PackingIdentity (standard dgm efficiency : ℕ → ℝ) : Prop :=
  ∀ n, standard n = efficiency n * dgm n

/-- With positive efficiency, a standard-quality bound and the reciprocal
efficiency DGM bound are exactly equivalent. -/
theorem packing_bound_iff
    {standard dgm efficiency : ℕ → ℝ}
    (hident : PackingIdentity standard dgm efficiency)
    (heff : ∀ n, 0 < efficiency n) (B : ℝ) (n : ℕ) :
    standard n ≤ B ↔ dgm n ≤ B / efficiency n := by
  rw [hident n]
  constructor
  · intro h
    exact (le_div_iff₀ (heff n)).2 (by simpa [mul_comm] using h)
  · intro h
    have hmul := (le_div_iff₀ (heff n)).1 h
    simpa [mul_comm] using hmul

/-- AM--GM range data gives the one-sided pointwise comparison. -/
theorem standard_nonneg_and_le_dgm
    {standard dgm efficiency : ℕ → ℝ}
    (hident : PackingIdentity standard dgm efficiency)
    (heffNonneg : ∀ n, 0 ≤ efficiency n)
    (heffOne : ∀ n, efficiency n ≤ 1)
    (hdgm : ∀ n, 0 ≤ dgm n) (n : ℕ) :
    0 ≤ standard n ∧ standard n ≤ dgm n := by
  rw [hident n]
  exact ⟨mul_nonneg (heffNonneg n) (hdgm n),
    mul_le_of_le_one_left (hdgm n) (heffOne n)⟩

/-- If the logarithmic prime coordinates lie in a fixed-width interval,
packing efficiency has a lower bound independent of their number. -/
theorem clustered_efficiency_lower
    {L C G A : ℝ} (hL : 0 < L) (hC : 0 ≤ C)
    (hG : L ≤ G) (hA : A ≤ L + C) (hApos : 0 < A) :
    L / (L + C) ≤ G / A := by
  have hLCpos : 0 < L + C := add_pos_of_pos_of_nonneg hL hC
  apply (le_div_iff₀ hApos).2
  calc
    L / (L + C) * A ≤ L / (L + C) * (L + C) := by
      exact mul_le_mul_of_nonneg_left hA
        (div_nonneg (le_of_lt hL) (le_of_lt hLCpos))
    _ = L := by field_simp
    _ ≤ G := hG

def dgmWitness (n : ℕ) : ℝ := n + 1

noncomputable def efficiencyWitness (n : ℕ) : ℝ := 1 / (n + 1)

def standardWitness (_n : ℕ) : ℝ := 1

theorem witness_packing_identity :
    PackingIdentity standardWitness dgmWitness efficiencyWitness := by
  intro n
  have hpos : 0 < (n : ℝ) + 1 := by positivity
  simp [standardWitness, dgmWitness, efficiencyWitness, ne_of_gt hpos]

theorem witness_efficiency_pos (n : ℕ) : 0 < efficiencyWitness n := by
  unfold efficiencyWitness
  exact one_div_pos.mpr (by positivity)

theorem witness_efficiency_le_one (n : ℕ) : efficiencyWitness n ≤ 1 := by
  unfold efficiencyWitness
  have hden : 0 < (n : ℝ) + 1 := by positivity
  rw [div_le_one hden]
  norm_num

theorem witness_dgm_pos (n : ℕ) : 0 < dgmWitness n := by
  unfold dgmWitness
  positivity

theorem witness_dgm_unbounded :
    ∀ K : ℝ, ∃ n : ℕ, K < dgmWitness n := by
  intro K
  obtain ⟨n, hn⟩ := exists_nat_gt K
  exact ⟨n, hn.trans_le (by simp [dgmWitness])⟩

/-- Exact abstract countermodel: the alternative quality is unbounded while
the standard quality remains exactly one because packing efficiency tends
to zero.  The theorem quantifies over real sequences, not abc triples. -/
theorem exists_unboundedDGM_constantStandard :
    ∃ efficiency dgm standard : ℕ → ℝ,
      PackingIdentity standard dgm efficiency ∧
      (∀ n, 0 < efficiency n ∧ efficiency n ≤ 1) ∧
      (∀ n, 0 < dgm n) ∧
      (∀ K : ℝ, ∃ n : ℕ, K < dgm n) ∧
      (∀ n, standard n = 1) := by
  exact ⟨efficiencyWitness, dgmWitness, standardWitness,
    witness_packing_identity,
    fun n => ⟨witness_efficiency_pos n, witness_efficiency_le_one n⟩,
    witness_dgm_pos, witness_dgm_unbounded, fun _n => rfl⟩

#print axioms packing_bound_iff
#print axioms standard_nonneg_and_le_dgm
#print axioms clustered_efficiency_lower
#print axioms witness_packing_identity
#print axioms witness_efficiency_pos
#print axioms witness_efficiency_le_one
#print axioms witness_dgm_pos
#print axioms witness_dgm_unbounded
#print axioms exists_unboundedDGM_constantStandard

end AlternativeQualityPackingBridge20260903
end IUTThreeClosures
