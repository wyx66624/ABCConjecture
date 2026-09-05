/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import IUTThreeClosures.ThreeEndpointAggregateKthRoot
import Mathlib.Tactic

/-!
# Aggregate fourth-root gain across the three abc endpoints

The one-endpoint pigeonhole argument loses information by first selecting a
small radical share. Summing the exact fourth-power residue budgets over all
three endpoints is stronger.
-/

namespace IUTThreeClosures
namespace ThreeEndpointAggregateFourthRoot

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical fourth root of a finite exponent
profile. -/
def fourthRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight 4 s weight exponent

/-- The exact residue decomposition at modulus four gives three radical
layers plus four times the canonical fourth-root weight. -/
theorem totalWeight_le_three_mul_radical_add_four_mul_fourthRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent ≤
      3 * exponentRadicalWeight s weight +
        4 * fourthRootWeight s weight exponent := by
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      4 s weight exponent
  have hres :=
    exponentResidueWeight_le_radical_budget
      (n := 4) (by norm_num) s weight exponent hweight
  unfold fourthRootWeight
  norm_num at hres
  nlinarith

/-- Aggregate scalar fourth-root gain. -/
theorem aggregate_fourthRoot_gain
    {epsilon h C Lm LM Lc Tm TM Tc rm rM rc qm qM qc : ℝ}
    (hepsilon : -1 < epsilon)
    (hviolation :
      (1 + epsilon) * (rm + rM + rc) + C < h)
    (hm_lower :
      (2 + epsilon) * h - 2 * (1 + epsilon) * Lm ≤
        2 * (1 + epsilon) * Tm)
    (hM_lower : h - LM ≤ TM)
    (hc_lower : h - Lc ≤ Tc)
    (hm_upper : Tm ≤ 3 * rm + 4 * qm)
    (hM_upper : TM ≤ 3 * rM + 4 * qM)
    (hc_upper : Tc ≤ 3 * rc + 4 * qc) :
    5 * epsilon * h + 6 * C <
      8 * (1 + epsilon) * (qm + qM + qc) +
        2 * (1 + epsilon) * (Lm + LM + Lc) := by
  exact ThreeEndpointAggregateKthRoot.aggregate_fourthRoot_gain
    hepsilon hviolation hm_lower hM_lower hc_lower
      hm_upper hM_upper hc_upper

/-- If the aggregate fourth-root budget is positive, one endpoint carries at
least one third of it. -/
theorem one_of_three_fourthRoots_carries_aggregate_gain
    {epsilon A qm qM qc : ℝ}
    (hepsilon : -1 < epsilon)
    (hgain : A < 8 * (1 + epsilon) * (qm + qM + qc)) :
    A < 24 * (1 + epsilon) * qm ∨
      A < 24 * (1 + epsilon) * qM ∨
        A < 24 * (1 + epsilon) * qc := by
  by_contra hnot
  push_neg at hnot
  rcases hnot with ⟨hm, hM, hc⟩
  have hone : 0 < 1 + epsilon := by linarith
  nlinarith

/-- Direct one-endpoint consequence of the aggregate abc budget. -/
theorem one_endpoint_fourthRoot_gain
    {epsilon h C Lm LM Lc Tm TM Tc rm rM rc qm qM qc : ℝ}
    (hepsilon : -1 < epsilon)
    (hviolation :
      (1 + epsilon) * (rm + rM + rc) + C < h)
    (hm_lower :
      (2 + epsilon) * h - 2 * (1 + epsilon) * Lm ≤
        2 * (1 + epsilon) * Tm)
    (hM_lower : h - LM ≤ TM)
    (hc_lower : h - Lc ≤ Tc)
    (hm_upper : Tm ≤ 3 * rm + 4 * qm)
    (hM_upper : TM ≤ 3 * rM + 4 * qM)
    (hc_upper : Tc ≤ 3 * rc + 4 * qc) :
    let A :=
      5 * epsilon * h + 6 * C -
        2 * (1 + epsilon) * (Lm + LM + Lc)
    A < 24 * (1 + epsilon) * qm ∨
      A < 24 * (1 + epsilon) * qM ∨
        A < 24 * (1 + epsilon) * qc := by
  dsimp
  have haggregate :=
    aggregate_fourthRoot_gain hepsilon hviolation hm_lower hM_lower
      hc_lower hm_upper hM_upper hc_upper
  have hgain :
      5 * epsilon * h + 6 * C -
          2 * (1 + epsilon) * (Lm + LM + Lc) <
        8 * (1 + epsilon) * (qm + qM + qc) := by
    linarith
  exact one_of_three_fourthRoots_carries_aggregate_gain
    hepsilon hgain

#print axioms totalWeight_le_three_mul_radical_add_four_mul_fourthRootWeight
#print axioms aggregate_fourthRoot_gain
#print axioms one_of_three_fourthRoots_carries_aggregate_gain
#print axioms one_endpoint_fourthRoot_gain

end
end ThreeEndpointAggregateFourthRoot
end IUTThreeClosures
