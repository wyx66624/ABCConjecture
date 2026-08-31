/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SquarefreePellCoefficientSupport
import IUTThreeClosures.SmallGapOrThreeSquareParts
import Mathlib.Tactic

/-!
# Height-scale roots in the concrete moving-Pell witness

The scalar v31 square-root bounds are instantiated here on the actual
squarefree decomposition

`min(a,b)=w*z^2`, `max(a,b)=u*x^2`, `c=v*y^2`.

The squarefree coefficients divide the corresponding endpoint radicals, so

`log endpoint - log radical(endpoint) <= 2 log(root)`.

Consequently every logarithmic abc violation gives explicit lower bounds for
the two large roots `x,y`; and either the additive endpoint is in a precise
power-saving range or the third root `z` has a height-scale lower bound as
well.  No estimate for the resulting moving Pell equation is assumed.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- The logarithm of the large summand is within `log 2` of the abc height. -/
theorem height_sub_log_two_le_log_largeEndpoint (P : ABCPoint) :
    P.height - Real.log 2 ≤ Real.log (P.largeEndpoint : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hMpos : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hreal : (P.c : ℝ) ≤ 2 * (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.c_le_two_mul_largeEndpoint
  have hlog := Real.log_le_log hcpos hreal
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hMpos.ne'] at hlog
  rw [P.height_eq_log_c]
  linarith

/-- The small-endpoint radical contribution is bounded by the full
conductor. -/
theorem log_smallRadical_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.endpointMin : ℝ) ≤ P.conductor := by
  have hfullpos : 0 < abcRadical (P.a * P.b * P.c) :=
    abcRadical_pos _
  have hdiv :
      abcRadical P.endpointMin ∣
        abcRadical (P.a * P.b * P.c) := by
    refine ⟨abcRadical P.largeEndpoint * abcRadical P.c, ?_⟩
    rw [P.abcRadical_eq_signedLayer_threeFactors]
    ring
  have hle :
      abcRadical P.endpointMin ≤
        abcRadical (P.a * P.b * P.c) :=
    Nat.le_of_dvd hfullpos hdiv
  have hsmallpos : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hleR :
      (abcRadical P.endpointMin : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hle
  unfold ABCPoint.conductor
  exact Real.log_le_log hsmallpos hleR

/-- The large-summand radical contribution is bounded by the full
conductor. -/
theorem log_largeRadical_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.largeEndpoint : ℝ) ≤ P.conductor := by
  have hfullpos : 0 < abcRadical (P.a * P.b * P.c) :=
    abcRadical_pos _
  have hdiv :
      abcRadical P.largeEndpoint ∣
        abcRadical (P.a * P.b * P.c) := by
    refine ⟨abcRadical P.endpointMin * abcRadical P.c, ?_⟩
    rw [P.abcRadical_eq_signedLayer_threeFactors]
    ring
  have hle :
      abcRadical P.largeEndpoint ≤
        abcRadical (P.a * P.b * P.c) :=
    Nat.le_of_dvd hfullpos hdiv
  have hlargepos : 0 < (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast abcRadical_pos P.largeEndpoint
  have hleR :
      (abcRadical P.largeEndpoint : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hle
  unfold ABCPoint.conductor
  exact Real.log_le_log hlargepos hleR

/-- The output radical contribution is bounded by the full conductor. -/
theorem log_cRadical_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.c : ℝ) ≤ P.conductor := by
  have hfullpos : 0 < abcRadical (P.a * P.b * P.c) :=
    abcRadical_pos _
  have hdiv :
      abcRadical P.c ∣ abcRadical (P.a * P.b * P.c) := by
    refine ⟨abcRadical P.endpointMin * abcRadical P.largeEndpoint, ?_⟩
    rw [P.abcRadical_eq_signedLayer_threeFactors]
    ring
  have hle :
      abcRadical P.c ≤ abcRadical (P.a * P.b * P.c) :=
    Nat.le_of_dvd hfullpos hdiv
  have hcpos : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  have hleR :
      (abcRadical P.c : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hle
  unfold ABCPoint.conductor
  exact Real.log_le_log hcpos hleR

/-- Square extraction on the small endpoint controls its height minus
radical. -/
theorem SquarefreePellWitness.log_small_sub_radical_le_two_log_z
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Real.log (P.endpointMin : ℝ) -
        Real.log (abcRadical P.endpointMin : ℝ) ≤
      2 * Real.log (W.z : ℝ) := by
  have hwpos : 0 < (W.w : ℝ) := by exact_mod_cast W.w_pos
  have hzpos : 0 < (W.z : ℝ) := by exact_mod_cast W.z_pos
  have hradpos : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hwleNat : W.w ≤ abcRadical P.endpointMin :=
    Nat.le_of_dvd (abcRadical_pos P.endpointMin) W.w_dvd_smallRadical
  have hwle : (W.w : ℝ) ≤ (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast hwleNat
  have hlogw := Real.log_le_log hwpos hwle
  have hcast :
      (P.endpointMin : ℝ) = (W.w : ℝ) * (W.z : ℝ) ^ 2 := by
    exact_mod_cast W.small_eq
  rw [hcast, Real.log_mul hwpos.ne' (pow_pos hzpos 2).ne',
    Real.log_pow]
  linarith

/-- Square extraction on the large summand controls its height minus
radical. -/
theorem SquarefreePellWitness.log_large_sub_radical_le_two_log_x
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Real.log (P.largeEndpoint : ℝ) -
        Real.log (abcRadical P.largeEndpoint : ℝ) ≤
      2 * Real.log (W.x : ℝ) := by
  have hupos : 0 < (W.u : ℝ) := by exact_mod_cast W.u_pos
  have hxpos : 0 < (W.x : ℝ) := by exact_mod_cast W.x_pos
  have hradpos : 0 < (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast abcRadical_pos P.largeEndpoint
  have huleNat : W.u ≤ abcRadical P.largeEndpoint :=
    Nat.le_of_dvd (abcRadical_pos P.largeEndpoint) W.u_dvd_largeRadical
  have hule : (W.u : ℝ) ≤ (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast huleNat
  have hlogu := Real.log_le_log hupos hule
  have hcast :
      (P.largeEndpoint : ℝ) = (W.u : ℝ) * (W.x : ℝ) ^ 2 := by
    exact_mod_cast W.large_eq
  rw [hcast, Real.log_mul hupos.ne' (pow_pos hxpos 2).ne',
    Real.log_pow]
  linarith

/-- Square extraction on `c` controls its height minus radical. -/
theorem SquarefreePellWitness.log_c_sub_radical_le_two_log_y
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    P.height - Real.log (abcRadical P.c : ℝ) ≤
      2 * Real.log (W.y : ℝ) := by
  have hvpos : 0 < (W.v : ℝ) := by exact_mod_cast W.v_pos
  have hypos : 0 < (W.y : ℝ) := by exact_mod_cast W.y_pos
  have hradpos : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  have hvleNat : W.v ≤ abcRadical P.c :=
    Nat.le_of_dvd (abcRadical_pos P.c) W.v_dvd_cRadical
  have hvle : (W.v : ℝ) ≤ (abcRadical P.c : ℝ) := by
    exact_mod_cast hvleNat
  have hlogv := Real.log_le_log hvpos hvle
  have hcast : (P.c : ℝ) = (W.v : ℝ) * (W.y : ℝ) ^ 2 := by
    exact_mod_cast W.c_eq
  rw [P.height_eq_log_c, hcast,
    Real.log_mul hvpos.ne' (pow_pos hypos 2).ne', Real.log_pow]
  linarith

/-- Every abc violation gives explicit lower bounds for the two large roots of
its concrete moving-Pell witness. -/
theorem SquarefreePellWitness.large_roots_height_scale
    {P : ABCPoint} (W : P.SquarefreePellWitness)
    {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (epsilon * P.height + C) / (2 * (1 + epsilon)) -
          Real.log 2 / 2 < Real.log (W.x : ℝ) ∧
      (epsilon * P.height + C) / (2 * (1 + epsilon)) <
          Real.log (W.y : ℝ) := by
  apply HeightViolationSquareRootScale.simultaneous_endpoint_squareRootScale
    hepsilon hviolation P.log_largeRadical_le_conductor
      P.log_cRadical_le_conductor
  · have hM := P.height_sub_log_two_le_log_largeEndpoint
    have hroot := W.log_large_sub_radical_le_two_log_x
    linarith
  · exact W.log_c_sub_radical_le_two_log_y

/-- Concrete short-gap/three-root dichotomy for an actual abc point. -/
theorem SquarefreePellWitness.shortGap_or_three_roots_height_scale
    {P : ABCPoint} (W : P.SquarefreePellWitness)
    {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * (1 + epsilon) * Real.log (P.endpointMin : ℝ) <
        (2 + epsilon) * P.height ∨
      ((epsilon * P.height + 2 * C) / (4 * (1 + epsilon)) <
          Real.log (W.z : ℝ) ∧
        (epsilon * P.height + C) / (2 * (1 + epsilon)) -
            Real.log 2 / 2 < Real.log (W.x : ℝ) ∧
        (epsilon * P.height + C) / (2 * (1 + epsilon)) <
            Real.log (W.y : ℝ)) := by
  apply SmallGapOrThreeSquareParts.shortGap_or_three_endpoint_squareRootScale
    hepsilon hviolation P.log_smallRadical_le_conductor
      P.log_largeRadical_le_conductor P.log_cRadical_le_conductor
      W.log_small_sub_radical_le_two_log_z
  · have hM := P.height_sub_log_two_le_log_largeEndpoint
    have hroot := W.log_large_sub_radical_le_two_log_x
    linarith
  · exact W.log_c_sub_radical_le_two_log_y

#print axioms height_sub_log_two_le_log_largeEndpoint
#print axioms log_smallRadical_le_conductor
#print axioms log_largeRadical_le_conductor
#print axioms log_cRadical_le_conductor
#print axioms SquarefreePellWitness.log_small_sub_radical_le_two_log_z
#print axioms SquarefreePellWitness.log_large_sub_radical_le_two_log_x
#print axioms SquarefreePellWitness.log_c_sub_radical_le_two_log_y
#print axioms SquarefreePellWitness.large_roots_height_scale
#print axioms SquarefreePellWitness.shortGap_or_three_roots_height_scale

end ABCPoint
end
end IUTThreeClosures
