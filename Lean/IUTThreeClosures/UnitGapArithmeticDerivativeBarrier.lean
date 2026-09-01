/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.Tactic

/-!
# Integral arithmetic derivatives are sharp but tautological at unit gap

On a unit-gap point `1+M=C`, additive compatibility for a weighted arithmetic
derivative is simply `D(M)=D(C)`.  Each derivative value is divisible by the
corresponding powerful part.  Since the two powerful parts are coprime, every
nonzero common value is divisible by their product.

After normalization this lower bound is exactly `C/rad(MC)`, the amount that
the Wronskian inequality itself needs.  Thus a theorem producing merely an
integral compatible nonzero derivative cannot improve the unit-gap abc bound;
it must additionally control the common value at essentially the abc scale.
-/

namespace IUTThreeClosures
namespace UnitGapArithmeticDerivativeBarrier

/-- Equal derivative values on the two coprime large endpoints are divisible
by the product of their powerful parts. -/
theorem powerfulParts_mul_dvd_commonDerivative
    (P : ABCPoint) (x : ℕ → ℤ)
    (hcommon :
      weightedArithmeticDerivative x P.b =
        weightedArithmeticDerivative x P.c) :
    ((abcPowerfulPart P.b * abcPowerfulPart P.c : ℕ) : ℤ) ∣
      weightedArithmeticDerivative x P.b := by
  have hb : (abcPowerfulPart P.b : ℤ) ∣
      weightedArithmeticDerivative x P.b :=
    abcPowerfulPart_dvd_weightedArithmeticDerivative x P.b
  have hc : (abcPowerfulPart P.c : ℤ) ∣
      weightedArithmeticDerivative x P.b := by
    rw [hcommon]
    exact abcPowerfulPart_dvd_weightedArithmeticDerivative x P.c
  have hcop : IsCoprime (abcPowerfulPart P.b : ℤ)
      (abcPowerfulPart P.c : ℤ) :=
    P.coprime_powerfulPart_b_c.isCoprime
  simpa only [Nat.cast_mul] using hcop.mul_dvd hb hc

/-- Every nonzero common derivative has at least the product-powerful-part
size. -/
theorem powerfulParts_mul_le_commonDerivative_natAbs
    (P : ABCPoint) (x : ℕ → ℤ)
    (hcommon :
      weightedArithmeticDerivative x P.b =
        weightedArithmeticDerivative x P.c)
    (hnonzero : weightedArithmeticDerivative x P.b ≠ 0) :
    abcPowerfulPart P.b * abcPowerfulPart P.c ≤
      (weightedArithmeticDerivative x P.b).natAbs := by
  exact Int.natAbs_le_of_dvd_ne_zero
    (powerfulParts_mul_dvd_commonDerivative P x hcommon)
    hnonzero

/-- Scalar form of the exact normalization barrier. -/
theorem normalized_common_value_lower_bound
    {M C A B qM qC T : ℝ}
    (hM : 0 < M)
    (hA : 0 < A)
    (hB : 0 < B)
    (hqM : 0 ≤ qM)
    (hqC : 0 ≤ qC)
    (hfactorM : qM * A = M)
    (hfactorC : qC * B = C)
    (hcommon : qM * qC ≤ T) :
    C / (A * B) ≤ T / M := by
  have hAB : 0 < A * B := mul_pos hA hB
  have hqMpos : 0 < qM := by
    by_contra hnot
    have hzero : qM = 0 := le_antisymm (le_of_not_gt hnot) hqM
    rw [hzero, zero_mul] at hfactorM
    linarith
  have hleft : C / (A * B) = qC / A := by
    rw [← hfactorC]
    field_simp
  have hright : T / M = (T / qM) / A := by
    rw [← hfactorM]
    field_simp
  rw [hleft, hright]
  have hq : qC ≤ T / qM :=
    (le_div_iff₀ hqMpos).2 (by simpa [mul_comm] using hcommon)
  exact div_le_div_of_nonneg_right hq hA.le

#print axioms powerfulParts_mul_dvd_commonDerivative
#print axioms powerfulParts_mul_le_commonDerivative_natAbs
#print axioms normalized_common_value_lower_bound

end UnitGapArithmeticDerivativeBarrier
end IUTThreeClosures
