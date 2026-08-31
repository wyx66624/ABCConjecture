/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FirstLayerGCDRefinement
import Mathlib.Tactic

/-!
# Both endpoints reach square depth and one reaches cube depth

Every abc violation forces a large first multiplicity quotient on both large
adjacent endpoints.  The signed exponent-two localization additionally forces
one of those endpoints to have a large second-layer quotient.  Refining that
quotient once more gives a genuine cube divisor or a still deeper remainder.

The construction is factorization-free: all layers are defined by gcd and
natural-number division.
-/

namespace IUTThreeClosures

noncomputable section

namespace ThirdLayerGCDRefinement

open FirstLayerExcessQuotient FirstLayerGCDRefinement

/-- Support occurring for a third time. -/
def thirdSupportLayer (n : ℕ) : ℕ :=
  Nat.gcd (secondSupportLayer n) (secondLayerExcessQuotient n)

/-- Quotient left after removing the third support layer. -/
def thirdLayerExcessQuotient (n : ℕ) : ℕ :=
  secondLayerExcessQuotient n / thirdSupportLayer n

/-- The third support times the third quotient is the second quotient. -/
theorem thirdSupport_mul_thirdExcess_eq_secondExcess (n : ℕ) :
    thirdSupportLayer n * thirdLayerExcessQuotient n =
      secondLayerExcessQuotient n := by
  unfold thirdLayerExcessQuotient thirdSupportLayer
  exact Nat.mul_div_cancel'
    (Nat.gcd_dvd_right (secondSupportLayer n)
      (secondLayerExcessQuotient n))

/-- The third support is positive on positive inputs. -/
theorem thirdSupportLayer_pos {n : ℕ} (hn : 0 < n) :
    0 < thirdSupportLayer n := by
  unfold thirdSupportLayer
  exact Nat.gcd_pos_of_pos_left _ (secondSupportLayer_pos hn)

/-- The third quotient is positive on positive inputs. -/
theorem thirdLayerExcessQuotient_pos {n : ℕ} (hn : 0 < n) :
    0 < thirdLayerExcessQuotient n := by
  unfold thirdLayerExcessQuotient
  apply Nat.div_pos
  · exact Nat.gcd_le_right _ _
  · exact Nat.gcd_pos_of_pos_left _ (secondSupportLayer_pos hn)

/-- The third support gives an actual cube divisor. -/
theorem thirdSupportLayer_cube_dvd (n : ℕ) :
    thirdSupportLayer n ^ 3 ∣ n := by
  have h32 : thirdSupportLayer n ∣ secondSupportLayer n :=
    Nat.gcd_dvd_left _ _
  have h21 : secondSupportLayer n ∣ firstSupportLayer n :=
    Nat.gcd_dvd_left _ _
  have h31 : thirdSupportLayer n ∣ firstSupportLayer n :=
    h32.trans h21
  obtain ⟨x, hx⟩ := h31
  obtain ⟨y, hy⟩ := h32
  refine ⟨x * y * thirdLayerExcessQuotient n, ?_⟩
  rw [← firstSupport_mul_secondSupport_mul_secondExcess_eq n,
    ← thirdSupport_mul_thirdExcess_eq_secondExcess n, hx, hy]
  ring

/-- The first support layer is bounded by the ordinary radical. -/
theorem firstSupportLayer_le_radical (n : ℕ) :
    firstSupportLayer n ≤ abcRadical n := by
  unfold firstSupportLayer
  exact Nat.gcd_le_right _ _

/-- The second support layer is also bounded by the ordinary radical. -/
theorem secondSupportLayer_le_radical (n : ℕ) :
    secondSupportLayer n ≤ abcRadical n := by
  exact (Nat.gcd_le_left _ _).trans (firstSupportLayer_le_radical n)

/-- Two radical layers and the second quotient dominate the integer. -/
theorem le_radical_sq_mul_secondLayerExcessQuotient (n : ℕ) :
    n ≤ abcRadical n ^ 2 * secondLayerExcessQuotient n := by
  rw [← firstSupport_mul_secondSupport_mul_secondExcess_eq n]
  have h1 := firstSupportLayer_le_radical n
  have h2 := secondSupportLayer_le_radical n
  nlinarith [Nat.mul_le_mul h1 h2]

/-- Exact logarithmic split of the second quotient. -/
theorem log_secondExcess_eq_log_thirdSupport_add_log_thirdExcess
    {n : ℕ} (hn : 0 < n) :
    Real.log (secondLayerExcessQuotient n : ℝ) =
      Real.log (thirdSupportLayer n : ℝ) +
        Real.log (thirdLayerExcessQuotient n : ℝ) := by
  have hs : 0 < (thirdSupportLayer n : ℝ) := by
    exact_mod_cast thirdSupportLayer_pos hn
  have hq : 0 < (thirdLayerExcessQuotient n : ℝ) := by
    exact_mod_cast thirdLayerExcessQuotient_pos hn
  have hprod :
      (secondLayerExcessQuotient n : ℝ) =
        (thirdSupportLayer n : ℝ) *
          (thirdLayerExcessQuotient n : ℝ) := by
    exact_mod_cast
      (thirdSupport_mul_thirdExcess_eq_secondExcess n).symm
  rw [hprod, Real.log_mul hs.ne' hq.ne']

/-- A lower bound for the second quotient yields a large cube support or a
large third quotient. -/
theorem secondExcess_dichotomy
    {n : ℕ} (hn : 0 < n) {T : ℝ}
    (hlower : T < Real.log (secondLayerExcessQuotient n : ℝ)) :
    (T / 2 < Real.log (thirdSupportLayer n : ℝ) ∧
        thirdSupportLayer n ^ 3 ∣ n) ∨
      T / 2 < Real.log (thirdLayerExcessQuotient n : ℝ) := by
  have hsplit :=
    log_secondExcess_eq_log_thirdSupport_add_log_thirdExcess hn
  rw [hsplit] at hlower
  by_cases hleft : T / 2 < Real.log (thirdSupportLayer n : ℝ)
  · exact Or.inl ⟨hleft, thirdSupportLayer_cube_dvd n⟩
  · right
    have hleftle := le_of_not_gt hleft
    linarith

end ThirdLayerGCDRefinement

open FirstLayerGCDRefinement ThirdLayerGCDRefinement

namespace ABCPoint

/-- The signed square-radical defect is bounded above by the concrete
second-layer quotient. -/
theorem singleEndpointSquareRadicalDefect_le_log_secondLayerExcessQuotient
    {n : ℕ} (hn : 0 < n) :
    singleEndpointSquareRadicalDefect n ≤
      Real.log (secondLayerExcessQuotient n : ℝ) := by
  have hnreal : 0 < (n : ℝ) := by exact_mod_cast hn
  have hrad : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hq : 0 < (secondLayerExcessQuotient n : ℝ) := by
    exact_mod_cast secondLayerExcessQuotient_pos hn
  have hreal :
      (n : ℝ) ≤
        (abcRadical n : ℝ) ^ 2 *
          (secondLayerExcessQuotient n : ℝ) := by
    exact_mod_cast le_radical_sq_mul_secondLayerExcessQuotient n
  have hlog := Real.log_le_log hnreal hreal
  rw [Real.log_mul (pow_pos hrad 2).ne' hq.ne', Real.log_pow] at hlog
  unfold singleEndpointSquareRadicalDefect
  nlinarith

/-- Every abc violation forces cube depth, or deeper multiplicity, on one of
the two large adjacent endpoints. -/
theorem one_largeEndpoint_cubeDepth_or_deeper_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let T :=
      Real.log (abcRadical P.endpointMin : ℝ) +
        epsilon * P.conductor + C - Real.log 2 / 2
    ((T / 2 < Real.log (thirdSupportLayer P.largeEndpoint : ℝ) ∧
          thirdSupportLayer P.largeEndpoint ^ 3 ∣ P.largeEndpoint) ∨
        T / 2 <
          Real.log (thirdLayerExcessQuotient P.largeEndpoint : ℝ)) ∨
      ((T / 2 < Real.log (thirdSupportLayer P.c : ℝ) ∧
          thirdSupportLayer P.c ^ 3 ∣ P.c) ∨
        T / 2 < Real.log (thirdLayerExcessQuotient P.c : ℝ)) := by
  dsimp
  have hsigned :=
    P.endpoint_signed_defect_large_of_height_violation hviolation
  rcases hsigned with hM | hc
  · left
    have hMupper :=
      singleEndpointSquareRadicalDefect_le_log_secondLayerExcessQuotient
        P.largeEndpoint_pos
    exact secondExcess_dichotomy P.largeEndpoint_pos
      (lt_of_lt_of_le hM hMupper)
  · right
    have hcupper :=
      singleEndpointSquareRadicalDefect_le_log_secondLayerExcessQuotient
        P.c_pos
    exact secondExcess_dichotomy P.c_pos
      (lt_of_lt_of_le hc hcupper)

#print axioms thirdSupport_mul_thirdExcess_eq_secondExcess
#print axioms thirdSupportLayer_cube_dvd
#print axioms le_radical_sq_mul_secondLayerExcessQuotient
#print axioms log_secondExcess_eq_log_thirdSupport_add_log_thirdExcess
#print axioms secondExcess_dichotomy
#print axioms ABCPoint.singleEndpointSquareRadicalDefect_le_log_secondLayerExcessQuotient
#print axioms ABCPoint.one_largeEndpoint_cubeDepth_or_deeper_of_height_violation

end ABCPoint
end
end IUTThreeClosures
