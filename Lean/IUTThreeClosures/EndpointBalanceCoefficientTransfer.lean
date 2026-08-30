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

transfers with denominator `2 + tau - eta`.  At coefficient three this gives
an exact critical balance exponent.  Thus any remaining violation under a
coefficient-three sublinear-error estimate must be endpoint-degenerate.

No product estimate, IUT theorem, or abc statement is assumed as an axiom or
stored in a structure in this module.
-/

namespace IUTThreeClosures

open SymmetricProductCoefficientBarrier

noncomputable section

namespace ABCPoint

/-- The smaller additive endpoint of a positive abc point. -/
def endpointMin (P : ABCPoint) : ℕ := min P.a P.b

/-- Logarithmic size of the smaller additive endpoint. -/
def endpointMinLog (P : ABCPoint) : ℝ :=
  Real.log (endpointMin P : ℝ)

@[simp]
theorem endpointMin_pos (P : ABCPoint) : 0 < endpointMin P := by
  unfold endpointMin
  omega

/-- The balance-sensitive integer-size inequality
`min(a,b) * c^2 <= 2*a*b*c`. -/
theorem endpointMin_mul_c_sq_le_two_abc (P : ABCPoint) :
    (endpointMin P : ℝ) * (P.c : ℝ) ^ 2 ≤
      2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
  by_cases hab : P.a ≤ P.b
  · have hmin : endpointMin P = P.a := by
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
  · have hba : P.b ≤ P.a := by omega
    have hmin : endpointMin P = P.b := by
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
    2 * P.height + endpointMinLog P - Real.log 2 ≤
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P := by
  have hminpos : 0 < (endpointMin P : ℝ) := by
    exact_mod_cast endpointMin_pos P
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have habcpos : 0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos)
  have hlog := Real.log_le_log
    (mul_pos hminpos (pow_pos hcpos 2))
    (endpointMin_mul_c_sq_le_two_abc P)
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hminpos.ne' (mul_pos hcpos hcpos).ne',
      Real.log_mul hcpos.ne' hcpos.ne',
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
    (hbalance : tau * P.height ≤ endpointMinLog P)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        lambda * P.conductor + eta * P.height + K) :
    P.height ≤
      (lambda * P.conductor + K + Real.log 2) /
        (2 + tau - eta) := by
  have hlower :=
    two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog P
  have hraw :
      (2 + tau - eta) * P.height ≤
        lambda * P.conductor + K + Real.log 2 := by
    nlinarith
  have hdenpos : 0 < 2 + tau - eta := by
    linarith
  apply (le_div_iff₀ hdenpos).2
  simpa [mul_comm] using hraw

/-- On triples with `log min(a,b) >= (1-epsilon/2) log c`, a coefficient-three
product estimate with relative error `epsilon/2` gives the standard
`1+epsilon` abc coefficient.  This convenient specialization is superseded by
the exact critical exponent below, but is retained as a simple corollary. -/
theorem height_le_one_add_epsilon_of_coefficient_three_balanced
    (P : ABCPoint)
    {epsilon K : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilon_one : epsilon ≤ 1)
    (hbalance :
      (1 - epsilon / 2) * P.height ≤ endpointMinLog P)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + (epsilon / 2) * P.height + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (K + Real.log 2) / (3 - epsilon) := by
  have htransfer :=
    height_le_of_balanced_symmetricProduct_bound P
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
    mul_le_mul_of_nonneg_right hcoef (conductor_nonneg P)
  have hsplit :
      (3 * P.conductor + K + Real.log 2) / (3 - epsilon) =
        (3 / (3 - epsilon)) * P.conductor +
          (K + Real.log 2) / (3 - epsilon) := by
    ring
  rw [hsplit] at htransfer
  exact htransfer.trans
    (add_le_add_right hscaled ((K + Real.log 2) / (3 - epsilon)))

/-- Contrapositive localization for the convenient balance exponent. -/
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
    endpointMinLog P < (1 - epsilon / 2) * P.height := by
  by_contra hnot
  have hbalance :
      (1 - epsilon / 2) * P.height ≤ endpointMinLog P :=
    le_of_not_gt hnot
  have hbound :=
    height_le_one_add_epsilon_of_coefficient_three_balanced
      P hepsilon hepsilon_one hbalance hproduct
  linarith

end ABCPoint

namespace EndpointBalanceCoefficientTransfer

/-- Exact balance exponent at which a coefficient-three product estimate with
relative height error `eta` transfers to target abc coefficient `1+epsilon`. -/
def criticalBalanceExponent (epsilon eta : ℝ) : ℝ :=
  3 / (1 + epsilon) - 2 + eta

/-- Exact critical transfer.  Unlike the convenient `1-epsilon/2`
specialization, this loses no coefficient: the denominator is precisely
`3/(1+epsilon)`. -/
theorem height_le_one_add_epsilon_of_coefficient_three_criticalBalance
    (P : ABCPoint)
    {epsilon eta K : ℝ}
    (hepsilon : 0 < epsilon)
    (hbalance :
      criticalBalanceExponent epsilon eta * P.height ≤
        ABCPoint.endpointMinLog P)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + eta * P.height + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (1 + epsilon) * (K + Real.log 2) / 3 := by
  have honepos : 0 < 1 + epsilon := by linarith
  have hquotpos : 0 < 3 / (1 + epsilon) := by positivity
  have hden : eta < 2 + criticalBalanceExponent epsilon eta := by
    unfold criticalBalanceExponent
    linarith
  have htransfer :=
    ABCPoint.height_le_of_balanced_symmetricProduct_bound P
      (tau := criticalBalanceExponent epsilon eta)
      (lambda := 3) (eta := eta) (K := K)
      hden hbalance hproduct
  have hdeneq :
      2 + criticalBalanceExponent epsilon eta - eta =
        3 / (1 + epsilon) := by
    unfold criticalBalanceExponent
    ring
  rw [hdeneq] at htransfer
  have hidentity :
      (3 * P.conductor + K + Real.log 2) / (3 / (1 + epsilon)) =
        (1 + epsilon) * P.conductor +
          (1 + epsilon) * (K + Real.log 2) / 3 := by
    field_simp [honepos.ne']
    ring
  rw [hidentity] at htransfer
  exact htransfer

/-- A concrete uniform sublinear-error formulation of a coefficient-three
symmetric-product estimate.  It contains no abc conclusion. -/
def UniformCoefficientThreeSublinearProduct : Prop :=
  ∀ eta : ℝ, 0 < eta →
    ∃ H K : ℝ, ∀ P : ABCPoint,
      H ≤ P.height →
        SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
          3 * P.conductor + eta * P.height + K

/-- Any uniform coefficient-three product theorem with arbitrarily small
relative height error closes the convenient eventual balanced region. -/
theorem eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct
    (hproduct : UniformCoefficientThreeSublinearProduct) :
    ∀ epsilon : ℝ, 0 < epsilon → epsilon ≤ 1 →
      ∃ H C : ℝ, ∀ P : ABCPoint,
        H ≤ P.height →
        (1 - epsilon / 2) * P.height ≤ ABCPoint.endpointMinLog P →
          P.height ≤ (1 + epsilon) * P.conductor + C := by
  intro epsilon hepsilon hepsilon_one
  obtain ⟨H, K, hK⟩ :=
    hproduct (epsilon / 2) (by positivity)
  refine ⟨H, (K + Real.log 2) / (3 - epsilon), ?_⟩
  intro P hheight hbalance
  exact ABCPoint.height_le_one_add_epsilon_of_coefficient_three_balanced
    P hepsilon hepsilon_one hbalance (hK P hheight)

/-- Exact eventual balance frontier supplied by a uniform coefficient-three
sublinear-error theorem.  Choosing `eta=epsilon^2` leaves the endpoint exponent
`3/(1+epsilon)-2+epsilon^2 = 1-3epsilon+O(epsilon^2)`. -/
theorem eventual_criticalBalanced_abc_of_uniformCoefficientThreeSublinearProduct
    (hproduct : UniformCoefficientThreeSublinearProduct) :
    ∀ epsilon : ℝ, 0 < epsilon →
      ∃ H C : ℝ, ∀ P : ABCPoint,
        H ≤ P.height →
        criticalBalanceExponent epsilon (epsilon ^ 2) * P.height ≤
            ABCPoint.endpointMinLog P →
          P.height ≤ (1 + epsilon) * P.conductor + C := by
  intro epsilon hepsilon
  obtain ⟨H, K, hK⟩ :=
    hproduct (epsilon ^ 2) (by positivity)
  refine ⟨H, (1 + epsilon) * (K + Real.log 2) / 3, ?_⟩
  intro P hheight hbalance
  exact height_le_one_add_epsilon_of_coefficient_three_criticalBalance
    P hepsilon hbalance (hK P hheight)

#print axioms ABCPoint.endpointMin_mul_c_sq_le_two_abc
#print axioms ABCPoint.two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
#print axioms ABCPoint.conductor_nonneg
#print axioms ABCPoint.height_le_of_balanced_symmetricProduct_bound
#print axioms ABCPoint.height_le_one_add_epsilon_of_coefficient_three_balanced
#print axioms ABCPoint.endpoint_unbalanced_of_coefficient_three_violation
#print axioms height_le_one_add_epsilon_of_coefficient_three_criticalBalance
#print axioms eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct
#print axioms eventual_criticalBalanced_abc_of_uniformCoefficientThreeSublinearProduct

end EndpointBalanceCoefficientTransfer
end
end IUTThreeClosures
