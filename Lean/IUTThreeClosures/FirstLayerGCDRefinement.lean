/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BothEndpointFirstLayerExcessQuotient
import Mathlib.Tactic

/-!
# A factorization-free second radical layer

Starting from `Q₁(n) = n / gcd(n, rad(n))`, define

`L₂(n) = gcd(gcd(n,rad(n)), Q₁(n))`

and `Q₂(n) = Q₁(n) / L₂(n)`.  Then

`n = L₁(n) * L₂(n) * Q₂(n)`, `L₂(n)^2 | n`, and

`log Q₁(n) = log L₂(n) + log Q₂(n)`.
-/

namespace IUTThreeClosures

noncomputable section

namespace FirstLayerGCDRefinement

open FirstLayerExcessQuotient

/-- First support layer; on positive inputs this is the ordinary radical. -/
def firstSupportLayer (n : ℕ) : ℕ :=
  Nat.gcd n (abcRadical n)

/-- Support repeated in the first excess quotient. -/
def secondSupportLayer (n : ℕ) : ℕ :=
  Nat.gcd (firstSupportLayer n) (firstLayerExcessQuotient n)

/-- Quotient remaining after removing the second support layer. -/
def secondLayerExcessQuotient (n : ℕ) : ℕ :=
  firstLayerExcessQuotient n / secondSupportLayer n

/-- The first support layer times the first quotient is the original integer. -/
theorem firstSupport_mul_firstExcess_eq (n : ℕ) :
    firstSupportLayer n * firstLayerExcessQuotient n = n := by
  simpa [firstSupportLayer] using
    gcd_mul_firstLayerExcessQuotient_eq n

/-- The second support layer times the deeper quotient is the first quotient. -/
theorem secondSupport_mul_secondExcess_eq_firstExcess (n : ℕ) :
    secondSupportLayer n * secondLayerExcessQuotient n =
      firstLayerExcessQuotient n := by
  unfold secondLayerExcessQuotient secondSupportLayer
  exact Nat.mul_div_cancel'
    (Nat.gcd_dvd_right (firstSupportLayer n)
      (firstLayerExcessQuotient n))

/-- Three-factor layer decomposition. -/
theorem firstSupport_mul_secondSupport_mul_secondExcess_eq (n : ℕ) :
    firstSupportLayer n * secondSupportLayer n *
        secondLayerExcessQuotient n = n := by
  rw [mul_assoc, secondSupport_mul_secondExcess_eq_firstExcess,
    firstSupport_mul_firstExcess_eq]

/-- The first support is positive on positive inputs. -/
theorem firstSupportLayer_pos {n : ℕ} (hn : 0 < n) :
    0 < firstSupportLayer n := by
  unfold firstSupportLayer
  exact Nat.gcd_pos_of_pos_left _ hn

/-- The repeated-support layer is positive on positive inputs. -/
theorem secondSupportLayer_pos {n : ℕ} (hn : 0 < n) :
    0 < secondSupportLayer n := by
  unfold secondSupportLayer
  exact Nat.gcd_pos_of_pos_left _ (firstSupportLayer_pos hn)

/-- The deeper quotient is positive on positive inputs. -/
theorem secondLayerExcessQuotient_pos {n : ℕ} (hn : 0 < n) :
    0 < secondLayerExcessQuotient n := by
  unfold secondLayerExcessQuotient
  apply Nat.div_pos
  · exact Nat.gcd_le_right _ _
  · exact Nat.gcd_pos_of_pos_left _ (firstSupportLayer_pos hn)

/-- The repeated support gives a genuine square divisor of the integer. -/
theorem secondSupportLayer_sq_dvd (n : ℕ) :
    secondSupportLayer n ^ 2 ∣ n := by
  have hdiv : secondSupportLayer n ∣ firstSupportLayer n :=
    Nat.gcd_dvd_left _ _
  obtain ⟨u, hu⟩ := hdiv
  refine ⟨u * secondLayerExcessQuotient n, ?_⟩
  rw [← firstSupport_mul_secondSupport_mul_secondExcess_eq n, hu]
  ring

/-- Exact logarithmic splitting of the first quotient. -/
theorem log_firstExcess_eq_log_secondSupport_add_log_secondExcess
    {n : ℕ} (hn : 0 < n) :
    Real.log (firstLayerExcessQuotient n : ℝ) =
      Real.log (secondSupportLayer n : ℝ) +
        Real.log (secondLayerExcessQuotient n : ℝ) := by
  have hs : 0 < (secondSupportLayer n : ℝ) := by
    exact_mod_cast secondSupportLayer_pos hn
  have hq : 0 < (secondLayerExcessQuotient n : ℝ) := by
    exact_mod_cast secondLayerExcessQuotient_pos hn
  have hprod :
      (firstLayerExcessQuotient n : ℝ) =
        (secondSupportLayer n : ℝ) *
          (secondLayerExcessQuotient n : ℝ) := by
    exact_mod_cast
      (secondSupport_mul_secondExcess_eq_firstExcess n).symm
  rw [hprod, Real.log_mul hs.ne' hq.ne']

/-- Quantitative two-way split. -/
theorem firstExcess_dichotomy
    {n : ℕ} (hn : 0 < n) {T : ℝ}
    (hlower : T < Real.log (firstLayerExcessQuotient n : ℝ)) :
    (T / 2 < Real.log (secondSupportLayer n : ℝ) ∧
        secondSupportLayer n ^ 2 ∣ n) ∨
      T / 2 < Real.log (secondLayerExcessQuotient n : ℝ) := by
  have hsplit :=
    log_firstExcess_eq_log_secondSupport_add_log_secondExcess hn
  rw [hsplit] at hlower
  by_cases hleft : T / 2 < Real.log (secondSupportLayer n : ℝ)
  · exact Or.inl ⟨hleft, secondSupportLayer_sq_dvd n⟩
  · right
    have hleftle := le_of_not_gt hleft
    linarith

#print axioms firstSupport_mul_firstExcess_eq
#print axioms secondSupport_mul_secondExcess_eq_firstExcess
#print axioms firstSupport_mul_secondSupport_mul_secondExcess_eq
#print axioms secondSupportLayer_sq_dvd
#print axioms log_firstExcess_eq_log_secondSupport_add_log_secondExcess
#print axioms firstExcess_dichotomy

end FirstLayerGCDRefinement
end
end IUTThreeClosures
