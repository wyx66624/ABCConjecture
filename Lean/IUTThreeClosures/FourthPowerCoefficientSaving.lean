/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ThreeEndpointAggregateFourthRoot
import Mathlib.Tactic

/-!
# Coefficient saving from the aggregate fourth-root gain

If an endpoint has logarithmic decomposition

`T = K + 4*q`,

where `q` is the logarithm of an extracted fourth root and `K` is the
logarithm of the remaining fourth-power-free coefficient, then the v35
aggregate gain gives an explicit power saving for `K`.

The denominator-free form is

`6*(1+epsilon)*K
  < (6+epsilon)*h - 6*C + 2*(1+epsilon)*L`.

No existence or height estimate is assumed beyond the displayed scalar
hypotheses.
-/

namespace IUTThreeClosures
namespace FourthPowerCoefficientSaving

noncomputable section

/-- A one-endpoint fourth-root gain gives an exact coefficient-height saving. -/
theorem coefficient_saving_of_fourthRoot_gain
    {epsilon h C L T K q : ℝ}
    (hepsilon : -1 < epsilon)
    (hT : T ≤ h)
    (hdecomp : T = K + 4 * q)
    (hgain :
      5 * epsilon * h + 6 * C - 2 * (1 + epsilon) * L <
        24 * (1 + epsilon) * q) :
    6 * (1 + epsilon) * K <
      (6 + epsilon) * h - 6 * C +
        2 * (1 + epsilon) * L := by
  have hone : 0 < 1 + epsilon := by linarith
  nlinarith

/-- Applying the three-way fourth-root selection to endpoint decompositions
produces a three-way coefficient-saving conclusion. -/
theorem one_endpoint_fourthPowerFreeCoefficient_small
    {epsilon h C Lm LM Lc Tm TM Tc rm rM rc qm qM qc Km KM Kc : ℝ}
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
    (hc_upper : Tc ≤ 3 * rc + 4 * qc)
    (hm_le : Tm ≤ h) (hM_le : TM ≤ h) (hc_le : Tc ≤ h)
    (hm_decomp : Tm = Km + 4 * qm)
    (hM_decomp : TM = KM + 4 * qM)
    (hc_decomp : Tc = Kc + 4 * qc) :
    let L := Lm + LM + Lc
    6 * (1 + epsilon) * Km <
        (6 + epsilon) * h - 6 * C + 2 * (1 + epsilon) * L ∨
      6 * (1 + epsilon) * KM <
        (6 + epsilon) * h - 6 * C + 2 * (1 + epsilon) * L ∨
      6 * (1 + epsilon) * Kc <
        (6 + epsilon) * h - 6 * C + 2 * (1 + epsilon) * L := by
  dsimp
  have hselect :=
    ThreeEndpointAggregateFourthRoot.one_endpoint_fourthRoot_gain
      hepsilon hviolation hm_lower hM_lower hc_lower
      hm_upper hM_upper hc_upper
  rcases hselect with hm | hM | hc
  · exact Or.inl
      (coefficient_saving_of_fourthRoot_gain hepsilon hm_le hm_decomp hm)
  · exact Or.inr (Or.inl
      (coefficient_saving_of_fourthRoot_gain hepsilon hM_le hM_decomp hM))
  · exact Or.inr (Or.inr
      (coefficient_saving_of_fourthRoot_gain hepsilon hc_le hc_decomp hc))

#print axioms coefficient_saving_of_fourthRoot_gain
#print axioms one_endpoint_fourthPowerFreeCoefficient_small

end
end FourthPowerCoefficientSaving
end IUTThreeClosures
