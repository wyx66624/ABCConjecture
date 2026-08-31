/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Sharpness of the aggregate fourth-root frontier

For every `epsilon` with `0 < epsilon < 2/5`, there is an explicit positive
scalar model satisfying

* the abc-violation budget;
* the non-short-gap lower bound;
* the two large-endpoint lower bounds;
* all three fifth-power residue budgets `T <= 4*r + 5*q`;

while all three fifth-root weights are zero.

Thus no argument using only these scalar size/radical/residue inequalities can
force a fifth root for the small epsilon range relevant to abc.  Any advance
beyond the quartic frontier must use the additive equation or its arithmetic
consequences.
-/

namespace IUTThreeClosures
namespace FifthRootAggregateSharpness

noncomputable section

/-- Explicit zero-fifth-root model below the exact threshold
`5 * epsilon = 2`. -/
theorem exists_zero_fifthRoot_aggregate_model
    {epsilon : ℝ}
    (hepsilon : 0 < epsilon)
    (hcritical : 5 * epsilon < 2) :
    ∃ h Tm TM Tc rm rM rc qm qM qc : ℝ,
      0 < h ∧
      (1 + epsilon) * (rm + rM + rc) < h ∧
      (2 + epsilon) * h ≤ 2 * (1 + epsilon) * Tm ∧
      h ≤ TM ∧
      h ≤ Tc ∧
      Tm ≤ 4 * rm + 5 * qm ∧
      TM ≤ 4 * rM + 5 * qM ∧
      Tc ≤ 4 * rc + 5 * qc ∧
      qm = 0 ∧ qM = 0 ∧ qc = 0 := by
  refine ⟨2 * (1 + epsilon),
    2 + epsilon,
    2 * (1 + epsilon),
    2 * (1 + epsilon),
    (2 + epsilon) / 4,
    (1 + epsilon) / 2,
    (1 + epsilon) / 2,
    0, 0, 0,
    ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, rfl, rfl, rfl⟩
  · nlinarith
  · nlinarith
  · ring_nf
  · exact le_rfl
  · exact le_rfl
  · ring_nf
  · ring_nf
  · ring_nf

/-- In particular, positivity of `epsilon` alone cannot force a positive
fifth-root weight from the aggregate scalar hypotheses. -/
theorem not_every_aggregate_model_has_positive_fifthRoot
    {epsilon : ℝ}
    (hepsilon : 0 < epsilon)
    (hcritical : 5 * epsilon < 2) :
    ¬ ∀ h Tm TM Tc rm rM rc qm qM qc : ℝ,
      0 < h →
      (1 + epsilon) * (rm + rM + rc) < h →
      (2 + epsilon) * h ≤ 2 * (1 + epsilon) * Tm →
      h ≤ TM → h ≤ Tc →
      Tm ≤ 4 * rm + 5 * qm →
      TM ≤ 4 * rM + 5 * qM →
      Tc ≤ 4 * rc + 5 * qc →
      0 < qm ∨ 0 < qM ∨ 0 < qc := by
  intro hall
  obtain ⟨h, Tm, TM, Tc, rm, rM, rc, qm, qM, qc,
    hh, hv, hm, hM, hc, hmq, hMq, hcq, rfl, rfl, rfl⟩ :=
    exists_zero_fifthRoot_aggregate_model hepsilon hcritical
  have hpositive := hall h Tm TM Tc rm rM rc 0 0 0
    hh hv hm hM hc hmq hMq hcq
  norm_num at hpositive

#print axioms exists_zero_fifthRoot_aggregate_model
#print axioms not_every_aggregate_model_has_positive_fifthRoot

end
end FifthRootAggregateSharpness
end IUTThreeClosures
