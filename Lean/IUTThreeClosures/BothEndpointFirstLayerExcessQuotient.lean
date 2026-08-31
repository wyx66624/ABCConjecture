/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BothLargeEndpointMultiplicityExcess
import Mathlib.Tactic

/-!
# Concrete first-layer excess quotients on both large endpoints

Define

`Q₁(n) = n / gcd(n, rad(n))`.

The gcd identity gives `n <= rad(n) * Q₁(n)`, hence

`log n - log rad(n) <= log Q₁(n)`

for positive `n`. Every abc violation therefore forces `Q₁(max(a,b))` and
`Q₁(c)` both to have a fixed positive height slope.
-/

namespace IUTThreeClosures

noncomputable section

namespace FirstLayerExcessQuotient

/-- Integer quotient left after removing the gcd with the first radical layer. -/
def firstLayerExcessQuotient (n : ℕ) : ℕ :=
  n / Nat.gcd n (abcRadical n)

/-- Exact gcd-times-quotient identity. -/
theorem gcd_mul_firstLayerExcessQuotient_eq (n : ℕ) :
    Nat.gcd n (abcRadical n) * firstLayerExcessQuotient n = n := by
  unfold firstLayerExcessQuotient
  exact Nat.mul_div_cancel' (Nat.gcd_dvd_left n (abcRadical n))

/-- The quotient is positive on positive inputs. -/
theorem firstLayerExcessQuotient_pos {n : ℕ} (hn : 0 < n) :
    0 < firstLayerExcessQuotient n := by
  unfold firstLayerExcessQuotient
  apply Nat.div_pos
  · exact Nat.gcd_le_left _ _
  · exact Nat.gcd_pos_of_pos_left _ hn

/-- The original integer is bounded by its radical times the concrete excess
quotient. -/
theorem le_radical_mul_firstLayerExcessQuotient (n : ℕ) :
    n ≤ abcRadical n * firstLayerExcessQuotient n := by
  calc
    n = Nat.gcd n (abcRadical n) * firstLayerExcessQuotient n :=
      (gcd_mul_firstLayerExcessQuotient_eq n).symm
    _ ≤ abcRadical n * firstLayerExcessQuotient n :=
      Nat.mul_le_mul_right _ (Nat.gcd_le_right n (abcRadical n))

end FirstLayerExcessQuotient

open FirstLayerExcessQuotient

namespace ABCPoint

/-- Logarithmic multiplicity excess is bounded by the logarithm of the
concrete first-layer quotient. -/
theorem singleEndpointMultiplicityExcess_le_log_firstLayerExcessQuotient
    {n : ℕ} (hn : 0 < n) :
    singleEndpointMultiplicityExcess n ≤
      Real.log (firstLayerExcessQuotient n : ℝ) := by
  have hnreal : 0 < (n : ℝ) := by exact_mod_cast hn
  have hrad : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hq : 0 < (firstLayerExcessQuotient n : ℝ) := by
    exact_mod_cast firstLayerExcessQuotient_pos hn
  have hreal :
      (n : ℝ) ≤
        (abcRadical n : ℝ) * (firstLayerExcessQuotient n : ℝ) := by
    exact_mod_cast le_radical_mul_firstLayerExcessQuotient n
  have hlog := Real.log_le_log hnreal hreal
  rw [Real.log_mul hrad.ne' hq.ne'] at hlog
  unfold singleEndpointMultiplicityExcess
  linarith

/-- Every abc violation forces a large concrete first-layer quotient on both
large adjacent endpoints. -/
theorem both_firstLayerExcessQuotient_scaled_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.height + C <
        (1 + epsilon) *
          Real.log (firstLayerExcessQuotient P.c : ℝ) ∧
      epsilon * P.height + C - (1 + epsilon) * Real.log 2 <
        (1 + epsilon) *
          Real.log (firstLayerExcessQuotient P.largeEndpoint : ℝ) := by
  have hmult :=
    P.both_largeEndpoint_multiplicityExcess_scaled_of_height_violation
      hepsilon hviolation
  have hc :=
    singleEndpointMultiplicityExcess_le_log_firstLayerExcessQuotient P.c_pos
  have hM :=
    singleEndpointMultiplicityExcess_le_log_firstLayerExcessQuotient
      P.largeEndpoint_pos
  have hscale : 0 ≤ 1 + epsilon := by linarith
  have hcScaled := mul_le_mul_of_nonneg_left hc hscale
  have hMScaled := mul_le_mul_of_nonneg_left hM hscale
  exact ⟨lt_of_lt_of_le hmult.1 hcScaled,
    lt_of_lt_of_le hmult.2 hMScaled⟩

#print axioms gcd_mul_firstLayerExcessQuotient_eq
#print axioms firstLayerExcessQuotient_pos
#print axioms le_radical_mul_firstLayerExcessQuotient
#print axioms ABCPoint.singleEndpointMultiplicityExcess_le_log_firstLayerExcessQuotient
#print axioms ABCPoint.both_firstLayerExcessQuotient_scaled_of_height_violation

end ABCPoint
end
end IUTThreeClosures
