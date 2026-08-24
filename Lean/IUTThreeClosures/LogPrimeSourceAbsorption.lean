/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110

/-!
# Absorbing source terms controlled by the logarithm of the auxiliary prime

The two-local-inertia route produces a genuine auxiliary prime with

`log ell <= eta * height + O_eta(1)`

for every positive slope `eta`.  This module proves the exact final
quantitative implication needed from that result.

For every correction budget `delta > 0`, suppose a genuine public Theorem 1.10
source is selected and its remaining terms satisfy affine estimates

`different <= a_delta * logEll + D_delta`,
`error     <= b_delta * logEll + E_delta`,

with nonnegative slopes.  If `logEll` is uniformly sublinear in the abc height,
then the weighted source contribution

`(1+delta) * different + 20 * error`

is uniformly sublinear in the height as well.  Combining this with the verified
Frey discriminant--conductor comparison yields the logarithmic abc conjecture.

No actual IUT source estimate is asserted here.  The theorem identifies the
precise source-facing target: prove only affine logarithmic dependence on the
selected prime, rather than a point-independent upper bound for that prime.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- Genuine public Theorem 1.10 sources whose different and error terms have
affine growth in a uniformly sublinear auxiliary-prime logarithm. -/
structure LogPrimeControlledPublicFreyBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Select one genuine public source for every positive correction budget. -/
  bridge : ∀ δ : ℝ, 0 < δ → PublicFreyTheorem110Bridge F
  /-- The selected canonical prime correction is at most the budget. -/
  correction_le_delta :
    ∀ (δ : ℝ) (hδ : 0 < δ) (P : ABCPoint),
      publicFreyTheorem110Correction (bridge δ hδ) P ≤ δ
  /-- The logarithmic size of the selected auxiliary prime. -/
  primeLog : ∀ (δ : ℝ), 0 < δ → ABCPoint → ℝ
  /-- Point-independent affine coefficients for the different term. -/
  differentSlope : ∀ (δ : ℝ), 0 < δ → ℝ
  differentConstant : ∀ (δ : ℝ), 0 < δ → ℝ
  differentSlope_nonneg :
    ∀ (δ : ℝ) (hδ : 0 < δ), 0 ≤ differentSlope δ hδ
  different_le_logPrime :
    ∀ (δ : ℝ) (hδ : 0 < δ) (P : ABCPoint),
      (bridge δ hδ).different P ≤
        differentSlope δ hδ * primeLog δ hδ P +
          differentConstant δ hδ
  /-- Point-independent affine coefficients for the error term. -/
  errorSlope : ∀ (δ : ℝ), 0 < δ → ℝ
  errorConstant : ∀ (δ : ℝ), 0 < δ → ℝ
  errorSlope_nonneg :
    ∀ (δ : ℝ) (hδ : 0 < δ), 0 ≤ errorSlope δ hδ
  error_le_logPrime :
    ∀ (δ : ℝ) (hδ : 0 < δ) (P : ABCPoint),
      (bridge δ hδ).error P ≤
        errorSlope δ hδ * primeLog δ hδ P +
          errorConstant δ hδ
  /-- At each correction budget, the auxiliary-prime logarithm has an
  arbitrarily small uniform height slope. -/
  primeLog_sublinear :
    ∀ (δ : ℝ) (hδ : 0 < δ) (η : ℝ), 0 < η →
      ∃ C : ℝ, ∀ P : ABCPoint,
        primeLog δ hδ P ≤ η * P.height + C

namespace LogPrimeControlledPublicFreyBridge

/-- Affine logarithmic control of `different` and `error` turns into an
arbitrarily small height slope for their weighted source contribution. -/
theorem source_terms_sublinear
    (U : LogPrimeControlledPublicFreyBridge F)
    {δ : ℝ} (hδ : 0 < δ)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ, ∀ P : ABCPoint,
      (1 + δ) * (U.bridge δ hδ).different P +
          20 * (U.bridge δ hδ).error P ≤
        η * P.height + C := by
  let a : ℝ := U.differentSlope δ hδ
  let b : ℝ := U.errorSlope δ hδ
  let D : ℝ := U.differentConstant δ hδ
  let E : ℝ := U.errorConstant δ hδ
  let K : ℝ := (1 + δ) * a + 20 * b
  have ha : 0 ≤ a := by
    dsimp [a]
    exact U.differentSlope_nonneg δ hδ
  have hb : 0 ≤ b := by
    dsimp [b]
    exact U.errorSlope_nonneg δ hδ
  have honeδ : 0 ≤ 1 + δ := by linarith
  have hK : 0 ≤ K := by
    dsimp [K]
    positivity
  by_cases hKzero : K = 0
  · refine ⟨(1 + δ) * D + 20 * E, ?_⟩
    intro P
    have hd := U.different_le_logPrime δ hδ P
    have he := U.error_le_logPrime δ hδ P
    have hdscaled := mul_le_mul_of_nonneg_left hd honeδ
    have hescaled := mul_le_mul_of_nonneg_left he (by norm_num : (0 : ℝ) ≤ 20)
    have hcombined :
        (1 + δ) * (U.bridge δ hδ).different P +
            20 * (U.bridge δ hδ).error P ≤
          K * U.primeLog δ hδ P +
            ((1 + δ) * D + 20 * E) := by
      dsimp [a, b, D, E, K]
      linarith
    rw [hKzero, zero_mul, zero_add] at hcombined
    exact hcombined.trans (by linarith)
  · have hKpos : 0 < K := lt_of_le_of_ne hK (Ne.symm hKzero)
    have hetaK : 0 < η / K := div_pos hη hKpos
    rcases U.primeLog_sublinear δ hδ (η / K) hetaK with
      ⟨C₀, hC₀⟩
    refine ⟨K * C₀ + (1 + δ) * D + 20 * E, ?_⟩
    intro P
    have hd := U.different_le_logPrime δ hδ P
    have he := U.error_le_logPrime δ hδ P
    have hdscaled := mul_le_mul_of_nonneg_left hd honeδ
    have hescaled := mul_le_mul_of_nonneg_left he (by norm_num : (0 : ℝ) ≤ 20)
    have hcombined :
        (1 + δ) * (U.bridge δ hδ).different P +
            20 * (U.bridge δ hδ).error P ≤
          K * U.primeLog δ hδ P +
            ((1 + δ) * D + 20 * E) := by
      dsimp [a, b, D, E, K]
      linarith
    have hprime := hC₀ P
    have hprimeScaled := mul_le_mul_of_nonneg_left hprime hK
    have hslope :
        K * ((η / K) * P.height + C₀) =
          η * P.height + K * C₀ := by
      field_simp [ne_of_gt hKpos]
      ring
    rw [hslope] at hprimeScaled
    exact hcombined.trans (by linarith)

/-- **Logarithmic-prime source absorption theorem.**  The displayed
source-facing estimates imply the logarithmic abc conjecture. -/
theorem abc
    (U : LogPrimeControlledPublicFreyBridge F) :
    ABCConjecture := by
  intro ε hε
  let δ : ℝ := ε / 2
  let η : ℝ := ε / (2 * (1 + ε))
  have hδ : 0 < δ := by
    dsimp [δ]
    linarith
  have honeε : 0 < 1 + ε := by linarith
  have hη : 0 < η := by
    dsimp [η]
    positivity
  have hηlt : η < 1 := by
    dsimp [η]
    apply (div_lt_one (by positivity : 0 < 2 * (1 + ε))).2
    nlinarith
  have hden : 0 < 1 - η := by linarith
  have hcoefficient :
      1 + δ = (1 - η) * (1 + ε) := by
    dsimp [δ, η]
    field_simp [ne_of_gt honeε]
    ring
  rcases U.source_terms_sublinear hδ hη with ⟨C, hC⟩
  let C₀ : ℝ := C + (1 + δ) * Real.log 16 + Real.log 8 / 6
  refine ⟨C₀ / (1 - η), ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  let B : PublicFreyTheorem110Bridge F := U.bridge δ hδ
  have hpoint :
      P.height ≤
        (1 + publicFreyTheorem110Correction B P) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
    simpa [B, publicFreyTheorem110Correction] using
      B.pointwise_height_bound P
  have hcorrection :
      publicFreyTheorem110Correction B P ≤ δ := by
    simpa [B] using U.correction_le_delta δ hδ P
  have hbase_nonneg :
      0 ≤ B.different P + P.freyDiscriminantConductor :=
    add_nonneg (B.different_nonneg P)
      (freyDiscriminantConductor_nonneg P)
  have hcoefficientTerm :
      (1 + publicFreyTheorem110Correction B P) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + δ) *
          (B.different P + P.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right (by linarith) hbase_nonneg
  have hsource :
      (1 + δ) * B.different P + 20 * B.error P ≤
        η * P.height + C := by
    simpa [B] using hC P
  have hcoef_nonneg : 0 ≤ 1 + δ := by linarith
  have hfrey :
      (1 + δ) * P.freyDiscriminantConductor ≤
        (1 + δ) * (P.conductor + Real.log 16) :=
    mul_le_mul_of_nonneg_left P.freyDiscriminantConductor_le
      hcoef_nonneg
  have hraw :
      P.height ≤ η * P.height +
        (1 + δ) * P.conductor + C₀ := by
    calc
      P.height ≤
          (1 + publicFreyTheorem110Correction B P) *
              (B.different P + P.freyDiscriminantConductor) +
            20 * B.error P + Real.log 8 / 6 := hpoint
      _ ≤ (1 + δ) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
        linarith
      _ = ((1 + δ) * B.different P + 20 * B.error P) +
            (1 + δ) * P.freyDiscriminantConductor +
            Real.log 8 / 6 := by
        ring
      _ ≤ (η * P.height + C) +
            (1 + δ) * (P.conductor + Real.log 16) +
            Real.log 8 / 6 := by
        linarith
      _ = η * P.height + (1 + δ) * P.conductor + C₀ := by
        simp only [C₀]
        ring
  have hrearranged :
      (1 - η) * P.height ≤
        (1 + δ) * P.conductor + C₀ := by
    linarith
  have hdiv :
      P.height ≤
        ((1 + δ) * P.conductor + C₀) / (1 - η) := by
    apply (le_div_iff₀ hden).2
    simpa [mul_comm] using hrearranged
  have hquotient :
      ((1 + δ) * P.conductor + C₀) / (1 - η) =
        (1 + ε) * P.conductor + C₀ / (1 - η) := by
    rw [add_div]
    congr 1
    rw [hcoefficient]
    field_simp [ne_of_gt hden]
  rw [hquotient] at hdiv
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hdiv

end LogPrimeControlledPublicFreyBridge

end IUTThreeClosures
