/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSynchronizedDivisorPackets20260903
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Canonical gain surfaces and finite defect flags

For a primitive nonunit abc triple this module inserts the canonical
intermediate scale `a*b*c` between the height `c` and the radical.  It proves
the exact gain factorization, the strict canonical approximation corridor
`1/3 < A < 1/2`, the coefficient-two necessary condition for a transgression,
and the affine power-excess/approximation-slack cancellation identity.

It also formalizes arbitrary finite defect flags.  Their local increments
sum to the endpoint defect, so merely splitting a cost into more layers cannot
create an abc saving.  The module contains an abstract full-premise
countermodel to independent fixed gain bounds and an actual primitive abc
triple refuting a universal canonical power-gain-three cap.  Neither
countermodel is an abc counterexample.
-/

namespace IUTThreeClosures
namespace ABCCanonicalGainSurface20260903

open ABCSynchronizedDivisorPackets20260903

noncomputable section

/-- The canonical multiplicative intermediate scale `a*b*c`. -/
def canonicalProduct (P : PrimitiveABC) : ℕ :=
  P.a * P.b * P.c

/-- Height-to-product factor in logarithmic coordinates. -/
def canonicalApproximationGain (P : PrimitiveABC) : ℝ :=
  Real.log (P.c : ℝ) / Real.log (canonicalProduct P : ℝ)

/-- Product-to-radical factor in logarithmic coordinates. -/
def canonicalPowerGain (P : PrimitiveABC) : ℝ :=
  Real.log (canonicalProduct P : ℝ) /
    Real.log (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ)

/-- Product multiplicity beyond the radical, normalized by radical log mass. -/
def canonicalPowerExcess (P : PrimitiveABC) : ℝ :=
  (Real.log (canonicalProduct P : ℝ) -
      Real.log (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ)) /
    Real.log (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ)

/-- Product-to-height slack, normalized by radical log mass. -/
def canonicalApproximationSlack (P : PrimitiveABC) : ℝ :=
  (Real.log (canonicalProduct P : ℝ) - Real.log (P.c : ℝ)) /
    Real.log (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ)

namespace PrimitiveABC

/-- The canonical product is nontrivial. -/
theorem one_lt_canonicalProduct (P : PrimitiveABC) :
    1 < canonicalProduct P := by
  have hbc : 0 < P.b * P.c :=
    Nat.mul_pos (lt_trans Nat.zero_lt_one P.b_gt_one) P.c_pos
  have ha : P.a ≤ P.a * (P.b * P.c) :=
    Nat.le_mul_of_pos_right P.a hbc
  exact P.a_gt_one.trans_le (by simpa [canonicalProduct, mul_assoc] using ha)

/-- On the primitive nonunit scope the product is strictly above `c^2`. -/
theorem c_sq_lt_canonicalProduct (P : PrimitiveABC) :
    P.c ^ 2 < canonicalProduct P := by
  have h := Nat.mul_lt_mul_of_pos_right P.c_lt_mul_ab P.c_pos
  simpa [canonicalProduct, pow_two, mul_assoc] using h

/-- Each additive arm is below `c`, so the product is strictly below `c^3`. -/
theorem canonicalProduct_lt_c_cube (P : PrimitiveABC) :
    canonicalProduct P < P.c ^ 3 := by
  have hab : P.a * P.b < P.c * P.c := by
    exact mul_lt_mul P.a_lt_c (Nat.le_of_lt P.b_lt_c)
      (lt_trans Nat.zero_lt_one P.b_gt_one) (Nat.zero_le P.c)
  have h := Nat.mul_lt_mul_of_pos_right hab P.c_pos
  simpa [canonicalProduct, pow_succ, mul_assoc] using h

/-- The height log is positive on the nonunit scope. -/
theorem log_c_pos (P : PrimitiveABC) : 0 < Real.log (P.c : ℝ) := by
  apply Real.log_pos
  exact_mod_cast (P.a_gt_one.trans P.a_lt_c)

/-- The canonical product log is positive. -/
theorem log_canonicalProduct_pos (P : PrimitiveABC) :
    0 < Real.log (canonicalProduct P : ℝ) := by
  apply Real.log_pos
  exact_mod_cast one_lt_canonicalProduct P

/-- The actual radical log is positive. -/
theorem log_abcRadical_pos (P : PrimitiveABC) :
    0 < Real.log
      (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) := by
  apply Real.log_pos
  exact_mod_cast ABCSynchronizedDivisorPackets20260903.abcRadical_gt_one P

/-- Logarithmic form of the strict lower product corridor. -/
theorem two_log_c_lt_log_canonicalProduct (P : PrimitiveABC) :
    2 * Real.log (P.c : ℝ) < Real.log (canonicalProduct P : ℝ) := by
  have hc : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hprod : 0 < (canonicalProduct P : ℝ) := by
    exact_mod_cast (Nat.zero_lt_one.trans (one_lt_canonicalProduct P))
  have hcast : (P.c : ℝ) ^ 2 < (canonicalProduct P : ℝ) := by
    exact_mod_cast c_sq_lt_canonicalProduct P
  have hlog := Real.strictMonoOn_log (pow_pos hc 2) hprod hcast
  rw [Real.log_pow] at hlog
  norm_num at hlog ⊢
  exact hlog

/-- Logarithmic form of the strict upper product corridor. -/
theorem log_canonicalProduct_lt_three_log_c (P : PrimitiveABC) :
    Real.log (canonicalProduct P : ℝ) < 3 * Real.log (P.c : ℝ) := by
  have hc : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hprod : 0 < (canonicalProduct P : ℝ) := by
    exact_mod_cast (Nat.zero_lt_one.trans (one_lt_canonicalProduct P))
  have hcast : (canonicalProduct P : ℝ) < (P.c : ℝ) ^ 3 := by
    exact_mod_cast canonicalProduct_lt_c_cube P
  have hlog := Real.strictMonoOn_log hprod (pow_pos hc 3) hcast
  rw [Real.log_pow] at hlog
  norm_num at hlog ⊢
  exact hlog

/-- Exact factorization of standard quality through the canonical product. -/
theorem standardQuality_eq_gainProduct (P : PrimitiveABC) :
    standardQuality P =
      canonicalApproximationGain P * canonicalPowerGain P := by
  have hm : Real.log (canonicalProduct P : ℝ) ≠ 0 :=
    (log_canonicalProduct_pos P).ne'
  have hr : Real.log
      (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) ≠ 0 :=
    (log_abcRadical_pos P).ne'
  unfold standardQuality canonicalApproximationGain canonicalPowerGain
  field_simp

/-- The canonical height-to-product factor is strictly below one half. -/
theorem canonicalApproximationGain_lt_one_half (P : PrimitiveABC) :
    canonicalApproximationGain P < (1 : ℝ) / 2 := by
  unfold canonicalApproximationGain
  apply (div_lt_iff₀ (log_canonicalProduct_pos P)).2
  have h := two_log_c_lt_log_canonicalProduct P
  linarith

/-- The canonical height-to-product factor is strictly above one third. -/
theorem one_third_lt_canonicalApproximationGain (P : PrimitiveABC) :
    (1 : ℝ) / 3 < canonicalApproximationGain P := by
  unfold canonicalApproximationGain
  apply (lt_div_iff₀ (log_canonicalProduct_pos P)).2
  have h := log_canonicalProduct_lt_three_log_c P
  linarith

/-- The canonical power factor is positive. -/
theorem canonicalPowerGain_pos (P : PrimitiveABC) :
    0 < canonicalPowerGain P := by
  exact div_pos (log_canonicalProduct_pos P) (log_abcRadical_pos P)

/-- Quality lies strictly below one half of canonical power gain. -/
theorem standardQuality_lt_half_powerGain (P : PrimitiveABC) :
    standardQuality P < (1 / 2 : ℝ) * canonicalPowerGain P := by
  rw [standardQuality_eq_gainProduct]
  exact mul_lt_mul_of_pos_right
    (canonicalApproximationGain_lt_one_half P) (canonicalPowerGain_pos P)

/-- Quality lies strictly above one third of canonical power gain. -/
theorem one_third_powerGain_lt_standardQuality (P : PrimitiveABC) :
    (1 / 3 : ℝ) * canonicalPowerGain P < standardQuality P := by
  rw [standardQuality_eq_gainProduct]
  exact mul_lt_mul_of_pos_right
    (one_third_lt_canonicalApproximationGain P) (canonicalPowerGain_pos P)

/-- Any fixed-epsilon transgression requires power gain above `2*(1+eps)`. -/
theorem powerGain_gt_two_mul_of_transgression (P : PrimitiveABC) {eps : ℝ}
    (htransgression : 1 + eps ≤ standardQuality P) :
    2 * (1 + eps) < canonicalPowerGain P := by
  have hcorridor := standardQuality_lt_half_powerGain P
  linarith

/-- A coefficient-two power-gain bound is sufficient for the quality target. -/
theorem quality_lt_one_add_of_powerGain_le (P : PrimitiveABC) {eps : ℝ}
    (hpower : canonicalPowerGain P ≤ 2 * (1 + eps)) :
    standardQuality P < 1 + eps := by
  have hcorridor := standardQuality_lt_half_powerGain P
  linarith

/-- The gain hyperbola becomes an affine power-excess/slack plane. -/
theorem standardQuality_eq_one_add_powerExcess_sub_slack (P : PrimitiveABC) :
    standardQuality P =
      1 + canonicalPowerExcess P - canonicalApproximationSlack P := by
  have hr : Real.log
      (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) ≠ 0 :=
    (log_abcRadical_pos P).ne'
  unfold standardQuality canonicalPowerExcess canonicalApproximationSlack
  field_simp
  ring

/-- Exact effective abc barrier in affine defect coordinates. -/
theorem logarithmicABC_iff_defectBarrier (P : PrimitiveABC) (eps C : ℝ) :
    Real.log (P.c : ℝ) ≤
        (1 + eps) * Real.log
          (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) + C ↔
      canonicalPowerExcess P - canonicalApproximationSlack P ≤
        eps + C / Real.log
          (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) := by
  have hrpos := log_abcRadical_pos P
  have hquality := standardQuality_eq_one_add_powerExcess_sub_slack P
  have hscale :
      standardQuality P ≤ 1 + eps + C / Real.log
          (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) ↔
        Real.log (P.c : ℝ) ≤
          (1 + eps) * Real.log
            (ABCSynchronizedDivisorPackets20260903.abcRadical P : ℝ) + C := by
    unfold standardQuality
    rw [div_le_iff₀ hrpos]
    field_simp
  rw [← hscale]
  rw [hquality]
  constructor <;> intro h <;> linarith

end PrimitiveABC

/-! ## The scale groupoid and its exact cocycles -/

/-- An additive transition law on the pair groupoid of real scale
coordinates. -/
structure AdditiveScaleCocycle where
  transition : ℝ → ℝ → ℝ
  transition_self : ∀ x, transition x x = 0
  transition_comp : ∀ x y z,
    transition x z = transition x y + transition y z

/-- Endpoint difference is the canonical exact additive scale cocycle. -/
def endpointDifferenceCocycle : AdditiveScaleCocycle where
  transition x y := y - x
  transition_self x := by ring
  transition_comp x y z := by ring

@[simp]
theorem endpointDifferenceCocycle_apply (x y : ℝ) :
    endpointDifferenceCocycle.transition x y = y - x := rfl

/-- Multiplicative transport on nonzero real scale coordinates. -/
def ratioTransition (x y : ℝˣ) : ℝˣ :=
  y * x⁻¹

@[simp]
theorem ratioTransition_self (x : ℝˣ) : ratioTransition x x = 1 := by
  simp [ratioTransition]

/-- Ratio transport is a multiplicative cocycle. -/
theorem ratioTransition_comp (x y z : ℝˣ) :
    ratioTransition x z = ratioTransition x y * ratioTransition y z := by
  simp only [ratioTransition]
  rw [show y * x⁻¹ * (z * y⁻¹) = (y * y⁻¹) * (z * x⁻¹) by ac_rfl]
  simp

/-! ## Arbitrary-dimensional defect flags -/

/-- Sum of adjacent increments along a finite scale flag beginning at `base`. -/
def defectFlagTotal : ℝ → List ℝ → ℝ
  | _, [] => 0
  | base, next :: rest => (next - base) + defectFlagTotal next rest

/-- Endpoint of a finite scale flag, with `base` as the empty endpoint. -/
def defectFlagEndpoint : ℝ → List ℝ → ℝ
  | base, [] => base
  | _, next :: rest => defectFlagEndpoint next rest

/-- Local defect increments telescope exactly to endpoint minus base. -/
theorem defectFlagTotal_eq_endpoint_sub_base (base : ℝ) (layers : List ℝ) :
    defectFlagTotal base layers = defectFlagEndpoint base layers - base := by
  induction layers generalizing base with
  | nil => simp [defectFlagTotal, defectFlagEndpoint]
  | cons next rest ih =>
      simp only [defectFlagTotal, defectFlagEndpoint]
      rw [ih]
      ring

/-- The higher-dimensional budget half-space is exactly the height inequality. -/
theorem defectFlagBudget_iff_heightBound
    (base height eps C : ℝ) (layers : List ℝ) :
    defectFlagTotal base layers ≤
        (defectFlagEndpoint base layers - height) + eps * base + C ↔
      height ≤ (1 + eps) * base + C := by
  rw [defectFlagTotal_eq_endpoint_sub_base]
  constructor <;> intro h <;> linarith

/-- Any upper bound on the total flag cost may be combined with a summed
budget bound.  The preceding path-independence theorem is what converts
layerwise arithmetic estimates into the `htotal` premise. -/
theorem defectFlagBudget_of_total_le_sum
    {base height eps C : ℝ} {layers : List ℝ} {budgets : List ℝ}
    (htotal : defectFlagTotal base layers ≤ budgets.sum)
    (hsum : budgets.sum ≤
      (defectFlagEndpoint base layers - height) + eps * base + C) :
    height ≤ (1 + eps) * base + C := by
  apply (defectFlagBudget_iff_heightBound base height eps C layers).1
  exact htotal.trans hsum

/-! ## Exact bridge to the repository target -/

/-- A uniform arithmetic budget on a flag from the radical log to the
symmetric-product log.  No inhabitant or bound for this predicate is assumed. -/
def UniformDefectFlagBudget : Prop :=
  ∀ eps : ℝ, 0 < eps →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ layers : List ℝ,
        defectFlagEndpoint P.conductor layers =
            SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ∧
          defectFlagTotal P.conductor layers ≤
            (defectFlagEndpoint P.conductor layers - P.height) +
              eps * P.conductor + C

/-- The defect-flag budget has exactly the quantifiers and strength of the
standard logarithmic abc conjecture.  This is an equivalence, not a proof of
either side. -/
theorem uniformDefectFlagBudget_iff_ABCConjecture :
    UniformDefectFlagBudget ↔ ABCConjecture := by
  constructor
  · intro hflag eps heps
    rcases hflag eps heps with ⟨C, hC⟩
    refine ⟨C, ?_⟩
    intro a b c ha hb hc hsum hcoprime
    let P : ABCPoint :=
      { a := a
        b := b
        c := c
        a_pos := ha
        b_pos := hb
        c_pos := hc
        sum_eq := hsum
        pairwise_coprime := hcoprime }
    rcases hC P with ⟨layers, _, hbudget⟩
    have hheight :=
      (defectFlagBudget_iff_heightBound
        P.conductor P.height eps C layers).1 hbudget
    simpa [ABCPoint.height, ABCPoint.conductor, P] using hheight
  · intro habc eps heps
    rcases habc eps heps with ⟨C, hC⟩
    refine ⟨C, ?_⟩
    intro P
    let productLog : ℝ :=
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P
    refine ⟨[productLog], ?_, ?_⟩
    · simp [defectFlagEndpoint, productLog]
    · apply (defectFlagBudget_iff_heightBound
        P.conductor P.height eps C [productLog]).2
      have hpoint := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
        P.sum_eq P.pairwise_coprime
      simpa [ABCPoint.height, ABCPoint.conductor] using hpoint

/-! ## Exact counterexample boundaries -/

/-- Complete log-coordinate countermodel: strict independent fixed bounds do
not force a coefficient-`3/2` target, even with ordered positive scales.  By
exponentiating, the witnesses are actual positive scales. -/
theorem independentGainBounds_do_not_force_threeHalves :
    ∃ r h n : ℝ,
      0 < r ∧ r < h ∧ h < n ∧
      h / n < 3 / 2 ∧ n / r < 3 ∧ 3 / 2 < h / r := by
  refine ⟨2, 4, 5, ?_⟩
  norm_num

/-- The primitive abc hit `3 + 125 = 128`. -/
def powerThreeCounterexample : PrimitiveABC where
  a := 3
  b := 125
  c := 128
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

@[simp]
theorem powerThreeCounterexample_product :
    canonicalProduct powerThreeCounterexample = 48000 := by
  norm_num [canonicalProduct, powerThreeCounterexample]

@[simp]
theorem powerThreeCounterexample_radical :
    ABCSynchronizedDivisorPackets20260903.abcRadical
      powerThreeCounterexample = 30 := by
  change UniqueFactorizationMonoid.radical (3 * 125 * 128 : ℕ) = 30
  rw [show 3 * 125 * 128 = 2 ^ 7 * (3 * 5 ^ 3) by norm_num,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow (2 : ℕ) (by norm_num),
    UniqueFactorizationMonoid.radical_of_prime Nat.prime_two.prime,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime Nat.prime_three.prime,
    UniqueFactorizationMonoid.radical_pow (5 : ℕ) (by norm_num),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 5).prime)]
  norm_num

/-- The actual primitive triple refutes a universal canonical power-gain-three
cap.  It does not refute abc. -/
theorem powerThreeCounterexample_powerGain_gt_three :
    3 < canonicalPowerGain powerThreeCounterexample := by
  have h30 : 0 < Real.log (30 : ℝ) := Real.log_pos (by norm_num)
  have hlog : 3 * Real.log (30 : ℝ) < Real.log (48000 : ℝ) := by
    have hmono := Real.strictMonoOn_log
      (show 0 < (30 : ℝ) ^ 3 by positivity)
      (show 0 < (48000 : ℝ) by positivity)
      (show (30 : ℝ) ^ 3 < (48000 : ℝ) by norm_num)
    rw [Real.log_pow] at hmono
    norm_num at hmono ⊢
    exact hmono
  unfold canonicalPowerGain
  rw [powerThreeCounterexample_product, powerThreeCounterexample_radical]
  exact (lt_div_iff₀ h30).2 hlog

end

end ABCCanonicalGainSurface20260903
end IUTThreeClosures
