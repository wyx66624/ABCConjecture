/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.RelativeSourceTermAbsorption

/-!
# Uniform asymptotic source decay implies the relative-decay ABC criterion

The relative source-term theorem asks that, for every positive tolerance, one
common source index makes the correction, different slope, and weighted error
slope small.  In applications these quantities will normally be obtained as
uniform scalar majorants along a strictly increasing admissible-prime family.

This module proves that ordinary convergence of those three scalar majorants
to zero automatically gives the required simultaneous index.  It therefore
turns the final quantitative problem into three uniform asymptotic estimates:

* `correctionBound n → 0`;
* `differentSlope n → 0`;
* `20 * errorSlope n → 0`.

No rate of convergence and no upper bound on the selected prime is required.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut Filter Set
open scoped Topology

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- A sequence of genuine public Theorem 1.10 sources equipped with uniform
scalar majorants converging to zero.  The point-dependent source terms are
bounded by these scalar slopes plus index-dependent additive constants. -/
structure AsymptoticRelativeDecayPublicFreyTheorem110Bridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  bridge : ℕ → PublicFreyTheorem110Bridge F
  correctionBound : ℕ → ℝ
  differentSlope : ℕ → ℝ
  differentConstant : ℕ → ℝ
  errorSlope : ℕ → ℝ
  errorConstant : ℕ → ℝ
  differentConstant_nonneg : ∀ n, 0 ≤ differentConstant n
  errorConstant_nonneg : ∀ n, 0 ≤ errorConstant n
  correction_le : ∀ (n : ℕ) (P : ABCPoint),
    publicFreyTheorem110Correction (bridge n) P ≤ correctionBound n
  different_le : ∀ (n : ℕ) (P : ABCPoint),
    (bridge n).different P ≤
      differentSlope n * P.conductor + differentConstant n
  error_le : ∀ (n : ℕ) (P : ABCPoint),
    (bridge n).error P ≤
      errorSlope n * P.conductor + errorConstant n
  correction_tendsto : Tendsto correctionBound atTop (𝓝 0)
  differentSlope_tendsto : Tendsto differentSlope atTop (𝓝 0)
  weightedErrorSlope_tendsto :
    Tendsto (fun n => 20 * errorSlope n) atTop (𝓝 0)

namespace AsymptoticRelativeDecayPublicFreyTheorem110Bridge

/-- Convergence of the three uniform scalar majorants produces one common
index for every positive tolerance. -/
theorem simultaneous_decay
    (U : AsymptoticRelativeDecayPublicFreyTheorem110Bridge F)
    (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ n : ℕ,
      U.correctionBound n ≤ ρ ∧
      U.differentSlope n ≤ ρ ∧
      20 * U.errorSlope n ≤ ρ := by
  have hcorrection :
      ∀ᶠ n in atTop, U.correctionBound n < ρ :=
    U.correction_tendsto.eventually (Iio_mem_nhds hρ)
  have hdifferent :
      ∀ᶠ n in atTop, U.differentSlope n < ρ :=
    U.differentSlope_tendsto.eventually (Iio_mem_nhds hρ)
  have herror :
      ∀ᶠ n in atTop, 20 * U.errorSlope n < ρ :=
    U.weightedErrorSlope_tendsto.eventually (Iio_mem_nhds hρ)
  filter_upwards [hcorrection, hdifferent, herror] with n hncorrection hndifferent hnerror
  exact ⟨n, hncorrection.le, hndifferent.le, hnerror.le⟩

/-- Forget the convergence proofs and retain the simultaneous relative-decay
package consumed by the previously verified ABC theorem. -/
def toRelativeDecay
    (U : AsymptoticRelativeDecayPublicFreyTheorem110Bridge F) :
    RelativeDecayPublicFreyTheorem110Bridge F where
  bridge := U.bridge
  correctionBound := U.correctionBound
  differentSlope := U.differentSlope
  differentConstant := U.differentConstant
  errorSlope := U.errorSlope
  errorConstant := U.errorConstant
  differentConstant_nonneg := U.differentConstant_nonneg
  errorConstant_nonneg := U.errorConstant_nonneg
  correction_le := U.correction_le
  different_le := U.different_le
  error_le := U.error_le
  simultaneous_decay := U.simultaneous_decay

/-- Uniform convergence of all three conductor-relative source defects is
sufficient for the logarithmic abc conjecture. -/
theorem abc
    (U : AsymptoticRelativeDecayPublicFreyTheorem110Bridge F) :
    ABCConjecture :=
  U.toRelativeDecay.abc

end AsymptoticRelativeDecayPublicFreyTheorem110Bridge

end IUTThreeClosures
