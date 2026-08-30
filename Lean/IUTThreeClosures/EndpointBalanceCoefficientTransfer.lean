/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Tactic

/-!
# Endpoint balance and coefficient-three product estimates

A coefficient-three estimate for `log (a*b*c)` does not by itself imply the
standard abc coefficient one.  The missing information is precisely how far
the triple lies from an endpoint.  Writing `m = min a b`, every positive abc
point satisfies

`2 * height + log m - log 2 <= log (a*b*c)`.

Consequently, on the balanced region `tau * height <= log m`, a product
estimate

`log (a*b*c) <= lambda * conductor + eta * height + K`

transfers with denominator `2 + tau - eta`.  At coefficient three, taking
`tau = 1 - epsilon/2` and `eta = epsilon/2` yields the standard
`1 + epsilon` abc coefficient.  Thus any remaining violation under a
coefficient-three sublinear-error estimate must be endpoint-degenerate.

No product estimate, IUT theorem, or abc statement is assumed as an axiom or
stored in a structure in this module.
-/

namespace IUTThreeClosures
namespace EndpointBalanceCoefficientTransfer

open SymmetricProductCoefficientBarrier

noncomputable section

namespace ABCPoint

/-- The smaller additive endpoint of a positive abc point. -/
def endpointMin (P : ABCPoint) : ℕ := min P.a P.b

/-- Logarithmic size of the smaller additive endpoint. -/
def endpointMinLog (P : ABCPoint) : ℝ :=
  Real.log (P.endpointMin : ℝ)

@[simp]
theorem endpointMin_pos (P : ABCPoint) : 0 < P.endpointMin := by
  unfold endpointMin
  exact lt_min P.a_pos P.b_pos

/-- The balance-sensitive integer-size inequality
`min(a,b) * c^2 <= 2*a*b*c`. -/
theorem endpointMin_mul_c_sq_le_two_abc (P : ABCPoint) :
    (P.endpointMin : ℝ) * (P.c : ℝ) ^ 2 ≤
      2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
  by_cases hab : P.a ≤ P.b
  · have hmin : P.endpointMin = P.a := by
      simp [endpointMin, hab]
    rw [hmin]
    have hsum : (P.a : ℝ) + P.b = P.c := by
      exact_mod_cast P.sum_eq
    have habR : (P.a : ℝ) ≤ P.b := by
      exact_mod_cast hab
    have hc_le : (P.c : ℝ) ≤ 2 * (P.b : ℝ) := by
      linarith
    have hnonneg : 0 ≤ (P.a : ℝ) * (P.c : ℝ) := by
      positivity
    have hmul := mul_le_mul_of_nonneg_left hc_le hnonneg
    calc
      (P.a : ℝ) * (P.c : ℝ) ^ 2 =
          ((P.a : ℝ) * (P.c : ℝ)) * (P.c : ℝ) := by ring
      _ ≤ ((P.a : ℝ) * (P.c : ℝ)) * (2 * (P.b : ℝ)) := hmul
      _ = 2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
        push_cast
        ring
  · have hba : P.b ≤ P.a :=
      Nat.le_of_lt (lt_of_not_ge hab)
    have hmin : P.endpointMin = P.b := by
      simp [endpointMin, hba]
    rw [hmin]
    have hsum : (P.a : ℝ) + P.b = P.c := by
      exact_mod_cast P.sum_eq
    have hbaR : (P.b : ℝ) ≤ P.a := by
      exact_mod_cast hba
    have hc_le : (P.c : ℝ) ≤ 2 * (P.a : ℝ) := by
      linarith
    have hnonneg : 0 ≤ (P.b : ℝ) * (P.c : ℝ) := by
      positivity
    have hmul := mul_le_mul_of_nonneg_left hc_le hnonneg
    calc
      (P.b : ℝ) * (P.c : ℝ) ^ 2 =
          ((P.b : ℝ) * (P.c : ℝ)) * (P.c : ℝ) := by ring
      _ ≤ ((P.b : ℝ) * (P.c : ℝ)) * (2 * (P.a : ℝ)) := hmul
      _ = 2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
        push_cast
        ring

/-- The exact balance-sensitive lower corridor for the symmetric product. -/
theorem two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
    (P : ABCPoint) :
    2 * P.height + P.endpointMinLog - Real.log 2 ≤
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P := by
  have hminpos : 0 < (P.endpointMin : ℝ) := by
    exact_mod_cast P.endpointMin_pos
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have habcpos : 0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    positivity
  have hlog := Real.log_le_log
    (mul_pos hminpos (pow_pos hcpos 2))
    P.endpointMin_mul_c_sq_le_two_abc
  rw [Real.log_mul hminpos.ne' (pow_pos hcpos 2).ne',
      Real.log_pow,
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) habcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold endpointMinLog
  unfold SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog
  linarith

/-- The elementary abc conductor is nonnegative. -/
theorem conductor_nonneg (P : ABCPoint) : 0 ≤ P.conductor := by
  unfold ABCPoint.conductor
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (abcRadical_pos (P.a * P.b * P.c)).ne')

/-- General balanced transfer.  The available height denominator is exactly
`2 + tau - eta`. -/
theorem height_le_of_balanced_symmetricProduct_bound
    (P : ABCPoint)
    {tau lambda eta K : ℝ}
    (hden : eta < 2 + tau)
    (hbalance : tau * P.height ≤ P.endpointMinLog)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        lambda * P.conductor + eta * P.height + K) :
    P.height ≤
      (lambda * P.conductor + K + Real.log 2) /
        (2 + tau - eta) := by
  have hlower :=
    P.two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
  have hraw :
      (2 + tau - eta) * P.height ≤
        lambda * P.conductor + K + Real.log 2 := by
    nlinarith
  have hdenpos : 0 < 2 + tau - eta := by
    linarith
  apply (le_div_iff₀ hdenpos).2
  simpa [mul_comm] using hraw

/-- On triples with `log min(a,b) >= (1-epsilon/2) log c`, a coefficient-three
product estimate with relative error `epsilon/2` already gives the standard
`1+epsilon` abc coefficient. -/
theorem height_le_one_add_epsilon_of_coefficient_three_balanced
    (P : ABCPoint)
    {epsilon K : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilon_one : epsilon ≤ 1)
    (hbalance :
      (1 - epsilon / 2) * P.height ≤ P.endpointMinLog)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + (epsilon / 2) * P.height + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (K + Real.log 2) / (3 - epsilon) := by
  have htransfer :=
    P.height_le_of_balanced_symmetricProduct_bound
      (tau := 1 - epsilon / 2)
      (lambda := 3)
      (eta := epsilon / 2)
      (K := K)
      (by linarith) hbalance hproduct
  have hdeneq :
      2 + (1 - epsilon / 2) - epsilon / 2 = 3 - epsilon := by
    ring
  rw [hdeneq] at htransfer
  have hdenpos : 0 < 3 - epsilon := by
    linarith
  have hcoef : 3 / (3 - epsilon) ≤ 1 + epsilon := by
    apply (div_le_iff₀ hdenpos).2
    have hprod : 0 ≤ epsilon * (2 - epsilon) :=
      mul_nonneg hepsilon.le (by linarith)
    nlinarith
  have hscaled :=
    mul_le_mul_of_nonneg_right hcoef P.conductor_nonneg
  have hsplit :
      (3 * P.conductor + K + Real.log 2) / (3 - epsilon) =
        (3 / (3 - epsilon)) * P.conductor +
          (K + Real.log 2) / (3 - epsilon) := by
    ring
  rw [hsplit] at htransfer
  exact htransfer.trans
    (add_le_add_right hscaled ((K + Real.log 2) / (3 - epsilon)))

/-- Contrapositive localization: under the same coefficient-three product
estimate, any violation of the resulting abc bound must lie in the endpoint
region. -/
theorem endpoint_unbalanced_of_coefficient_three_violation
    (P : ABCPoint)
    {epsilon K : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilon_one : epsilon ≤ 1)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + (epsilon / 2) * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor +
          (K + Real.log 2) / (3 - epsilon) < P.height) :
    P.endpointMinLog < (1 - epsilon / 2) * P.height := by
  by_contra hnot
  have hbalance :
      (1 - epsilon / 2) * P.height ≤ P.endpointMinLog :=
    le_of_not_gt hnot
  have hbound :=
    P.height_le_one_add_epsilon_of_coefficient_three_balanced
      hepsilon hepsilon_one hbalance hproduct
  linarith

end ABCPoint

/-- A concrete uniform sublinear-error formulation of a coefficient-three
symmetric-product estimate.  It contains no abc conclusion. -/
def UniformCoefficientThreeSublinearProduct : Prop :=
  ∀ eta : ℝ, 0 < eta →
    ∃ H K : ℝ, ∀ P : ABCPoint,
      H ≤ P.height →
        SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
          3 * P.conductor + eta * P.height + K

/-- Any uniform coefficient-three product theorem with arbitrarily small
relative height error closes the entire eventual balanced region. -/
theorem eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct
    (hproduct : UniformCoefficientThreeSublinearProduct) :
    ∀ epsilon : ℝ, 0 < epsilon → epsilon ≤ 1 →
      ∃ H C : ℝ, ∀ P : ABCPoint,
        H ≤ P.height →
        (1 - epsilon / 2) * P.height ≤ P.endpointMinLog →
          P.height ≤ (1 + epsilon) * P.conductor + C := by
  intro epsilon hepsilon hepsilon_one
  obtain ⟨H, K, hK⟩ :=
    hproduct (epsilon / 2) (by positivity)
  refine ⟨H, (K + Real.log 2) / (3 - epsilon), ?_⟩
  intro P hheight hbalance
  exact P.height_le_one_add_epsilon_of_coefficient_three_balanced
    hepsilon hepsilon_one hbalance (hK P hheight)

#print axioms ABCPoint.endpointMin_mul_c_sq_le_two_abc
#print axioms ABCPoint.two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
#print axioms ABCPoint.conductor_nonneg
#print axioms ABCPoint.height_le_of_balanced_symmetricProduct_bound
#print axioms ABCPoint.height_le_one_add_epsilon_of_coefficient_three_balanced
#print axioms ABCPoint.endpoint_unbalanced_of_coefficient_three_violation
#print axioms eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct

end
end EndpointBalanceCoefficientTransfer
end IUTThreeClosures
