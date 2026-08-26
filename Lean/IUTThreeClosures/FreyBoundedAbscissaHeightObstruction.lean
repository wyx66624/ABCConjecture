/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WeightedPoitouTateSelectorAudit

/-!
# Fixed-abscissa height obstruction: algebraic ledger

This module formalizes the unconditional algebraic identities and scalar
consequences used in the paper companion
`FREY_BOUNDED_ABSCISSA_HEIGHT_OBSTRUCTION.md`.

The paper proves, using an elliptic-surface calculation and Tate's variation
theorem, that for fixed `j ≠ 0, 1` on

`y^2 = x * (x - 1) * (x + b)`

the quadratic point with abscissa `j` has canonical height

`(1 / 4) * log b + O_j(1)`.

Lean does not model that elliptic surface, Shioda's pairing, specialization,
number fields, or local canonical heights.  Accordingly, no theorem below
asserts the paper-only height estimate.  Lean checks the duplication and
twist identities, the exact finite/archimedean coefficient ledger, and the
logical consequence of an explicitly supplied bounded-error estimate.
-/

namespace IUTThreeClosures

/-! ## Exact algebra of the Frey duplication map -/

/-- The cross-multiplied polynomial identity behind duplication on
`y^2 = x * (x - a) * (x + b)`. -/
theorem freyDuplication_crossIdentity (a b x : ℝ) :
    (3 * x ^ 2 + 2 * (b - a) * x - a * b) ^ 2 -
        4 * x * (x - a) * (x + b) * ((b - a) + 2 * x) =
      (x ^ 2 + a * b) ^ 2 := by
  ring

/-- Quotient form of the exact doubled abscissa.  The left side is
`slope^2 - (b-a) - 2x` after replacing `4y^2` by
`4x(x-a)(x+b)`. -/
theorem freyDuplication_xFormula
    {a b x : ℝ}
    (hdenom : 4 * x * (x - a) * (x + b) ≠ 0) :
    (3 * x ^ 2 + 2 * (b - a) * x - a * b) ^ 2 /
          (4 * x * (x - a) * (x + b)) -
        (b - a) - 2 * x =
      (x ^ 2 + a * b) ^ 2 /
        (4 * x * (x - a) * (x + b)) := by
  let d : ℝ := 4 * x * (x - a) * (x + b)
  have hd : d ≠ 0 := by simpa [d] using hdenom
  change
    (3 * x ^ 2 + 2 * (b - a) * x - a * b) ^ 2 / d -
          (b - a) - 2 * x =
      (x ^ 2 + a * b) ^ 2 / d
  rw [sub_sub]
  apply (eq_div_iff hd).2
  rw [sub_mul, div_mul_cancel₀ _ hd]
  dsimp [d]
  ring

/-! ## Exact quadratic-twist point identity -/

/-- If the selector radicand has square decomposition
`j(j-a)(j+b) = D r^2`, then `(Dj,D^2r)` lies on the displayed `D`-twist. -/
theorem freyBoundedAbscissa_twistPoint
    {a b j D r : ℝ}
    (hrad : j * (j - a) * (j + b) = D * r ^ 2) :
    (D ^ 2 * r) ^ 2 =
      (D * j) * (D * j - D * a) * (D * j + D * b) := by
  calc
    (D ^ 2 * r) ^ 2 = D ^ 3 * (D * r ^ 2) := by ring
    _ = D ^ 3 * (j * (j - a) * (j + b)) := by rw [← hrad]
    _ = (D * j) * (D * j - D * a) * (D * j + D * b) := by ring

/-! ## Exact leading-coefficient ledger -/

/-- The simultaneous finite and archimedean leading terms found in the
paper add to the canonical-height coefficient `1/4`. -/
theorem fixedAbscissa_heightCoefficientLedger (logScale : ℝ) :
    logScale / 3 - logScale / 12 = logScale / 4 := by
  ring

/-- If the total and finite parts have explicit error terms, subtraction
forces the archimedean term and its `-1/12` leading coefficient. -/
theorem fixedAbscissa_archimedeanErrorLedger
    (logScale totalError finiteError : ℝ) :
    (logScale / 4 + totalError) - (logScale / 3 + finiteError) =
      -logScale / 12 + (totalError - finiteError) := by
  ring

/-- The retained deep-prime coefficient `1/6` is strictly smaller than the
fixed-abscissa canonical-height coefficient `1/4`. -/
theorem fixedAbscissa_deepPrimeCoefficient_lt_heightCoefficient :
    (1 / 6 : ℝ) < 1 / 4 := by
  norm_num

/-! ## Bounded error forces the strict slope obstruction -/

/-- An explicitly supplied `1/4`-slope estimate with bounded error rules out
every smaller slope once the logarithmic scale is large enough. -/
theorem quarterSlope_strict_of_boundedError
    {height logScale errorBound slope : ℝ}
    (herror : |height - logScale / 4| ≤ errorBound)
    (hslope : slope < 1 / 4)
    (hlarge : errorBound / (1 / 4 - slope) < logScale) :
    slope * logScale < height := by
  have hgap : 0 < (1 / 4 : ℝ) - slope := by linarith
  have hscaled : errorBound < logScale * (1 / 4 - slope) :=
    (div_lt_iff₀ hgap).mp hlarge
  have hlower : -errorBound ≤ height - logScale / 4 :=
    (abs_le.mp herror).1
  nlinarith

/-- The preceding obstruction applies simultaneously to every member of a
finite candidate family once a common error bound has been supplied.  This
is the scalar conclusion used after taking the maximum of finitely many
specialization constants in the paper. -/
theorem allFixedCandidates_quarterSlope_strict
    {Candidate : Type*}
    (candidates : Finset Candidate)
    (height : Candidate → ℝ)
    {logScale errorBound slope : ℝ}
    (herror : ∀ candidate ∈ candidates,
      |height candidate - logScale / 4| ≤ errorBound)
    (hslope : slope < 1 / 4)
    (hlarge : errorBound / (1 / 4 - slope) < logScale) :
    ∀ candidate ∈ candidates, slope * logScale < height candidate := by
  intro candidate hc
  exact quarterSlope_strict_of_boundedError
    (herror candidate hc) hslope hlarge

/-- A common bounded error gives a lower bound for every fixed candidate,
and hence for any selector that is required to choose one of them. -/
theorem everyFixedCandidate_quarterSlope_lower
    {Candidate : Type*}
    (candidates : Finset Candidate)
    (height : Candidate → ℝ)
    {logScale errorBound : ℝ}
    (herror : ∀ candidate ∈ candidates,
      |height candidate - logScale / 4| ≤ errorBound) :
    ∀ candidate ∈ candidates,
      logScale / 4 - errorBound ≤ height candidate := by
  intro candidate hc
  have hlower : -errorBound ≤ height candidate - logScale / 4 :=
    (abs_le.mp (herror candidate hc)).1
  linarith

end IUTThreeClosures
