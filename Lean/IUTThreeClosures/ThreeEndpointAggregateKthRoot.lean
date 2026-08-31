/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Exact aggregate `k`-th-root threshold

Summing the three endpoint residue budgets

`Ti <= (k-1) * ri + k * qi`

before selecting an endpoint gives the exact gain coefficient

`8 + 5*epsilon - 2*k`.

For `k=4` this is `5*epsilon`; for `k=5` it is `5*epsilon-2`.
The latter sign change explains, and the explicit v35 sharpness model confirms,
why scalar residue accounting stops at exponent four for small epsilon.
-/

namespace IUTThreeClosures
namespace ThreeEndpointAggregateKthRoot

noncomputable section

/-- General aggregate `k`-th-root inequality in denominator-free form. -/
theorem aggregate_kthRoot_gain
    {epsilon k h C Lm LM Lc Tm TM Tc rm rM rc qm qM qc : ℝ}
    (hepsilon : -1 < epsilon)
    (hk : 1 < k)
    (hviolation :
      (1 + epsilon) * (rm + rM + rc) + C < h)
    (hm_lower :
      (2 + epsilon) * h - 2 * (1 + epsilon) * Lm ≤
        2 * (1 + epsilon) * Tm)
    (hM_lower : h - LM ≤ TM)
    (hc_lower : h - Lc ≤ Tc)
    (hm_upper : Tm ≤ (k - 1) * rm + k * qm)
    (hM_upper : TM ≤ (k - 1) * rM + k * qM)
    (hc_upper : Tc ≤ (k - 1) * rc + k * qc) :
    (8 + 5 * epsilon - 2 * k) * h + 2 * (k - 1) * C <
      2 * k * (1 + epsilon) * (qm + qM + qc) +
        2 * (1 + epsilon) * (Lm + LM + Lc) := by
  have hone : 0 < 1 + epsilon := by linarith
  have hscale_nonneg : 0 ≤ 2 * (1 + epsilon) := by positivity
  have hkpos : 0 < 2 * (k - 1) := by nlinarith
  have hM_scaled :=
    mul_le_mul_of_nonneg_left hM_lower hscale_nonneg
  have hc_scaled :=
    mul_le_mul_of_nonneg_left hc_lower hscale_nonneg
  have hsum_upper :
      Tm + TM + Tc ≤
        (k - 1) * (rm + rM + rc) +
          k * (qm + qM + qc) := by
    nlinarith
  have hsum_scaled :=
    mul_le_mul_of_nonneg_left hsum_upper hscale_nonneg
  have hviolation_scaled :=
    mul_lt_mul_of_pos_left hviolation hkpos
  nlinarith

/-- Quartic specialization of the exact aggregate threshold. -/
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
  have h := aggregate_kthRoot_gain
    (k := (4 : ℝ)) hepsilon (by norm_num) hviolation
    hm_lower hM_lower hc_lower hm_upper hM_upper hc_upper
  norm_num at h ⊢
  nlinarith

/-- Fifth-root specialization, exhibiting the exact `5*epsilon-2` frontier. -/
theorem aggregate_fifthRoot_gain
    {epsilon h C Lm LM Lc Tm TM Tc rm rM rc qm qM qc : ℝ}
    (hepsilon : -1 < epsilon)
    (hviolation :
      (1 + epsilon) * (rm + rM + rc) + C < h)
    (hm_lower :
      (2 + epsilon) * h - 2 * (1 + epsilon) * Lm ≤
        2 * (1 + epsilon) * Tm)
    (hM_lower : h - LM ≤ TM)
    (hc_lower : h - Lc ≤ Tc)
    (hm_upper : Tm ≤ 4 * rm + 5 * qm)
    (hM_upper : TM ≤ 4 * rM + 5 * qM)
    (hc_upper : Tc ≤ 4 * rc + 5 * qc) :
    (5 * epsilon - 2) * h + 8 * C <
      10 * (1 + epsilon) * (qm + qM + qc) +
        2 * (1 + epsilon) * (Lm + LM + Lc) := by
  have h := aggregate_kthRoot_gain
    (k := (5 : ℝ)) hepsilon (by norm_num) hviolation
    hm_lower hM_lower hc_lower hm_upper hM_upper hc_upper
  norm_num at h ⊢
  nlinarith

#print axioms aggregate_kthRoot_gain
#print axioms aggregate_fourthRoot_gain
#print axioms aggregate_fifthRoot_gain

end
end ThreeEndpointAggregateKthRoot
end IUTThreeClosures
