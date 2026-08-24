/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110

/-!
# Relative absorption of the source different and error terms

The existing quantifier-correct public Theorem 1.10 closure asks that, after
choosing the source prime for a fixed positive epsilon, the source `different`
and `error` terms be bounded by constants uniformly in the abc point.  That is
a sufficient condition, but it is stronger than what the final abc estimate
actually needs.

It is enough that the prime-dependent source terms admit an affine bound in
the abc conductor whose linear coefficient can be made arbitrarily small.
More precisely, for a parameter `delta > 0`, suppose that the selected source
satisfies

`correction <= delta`

and

`(1 + delta) * different + 20 * error <= delta * conductor + C_delta`.

Then the public Theorem 1.10 estimate and the verified Frey
Discriminant--conductor comparison give

`height <= (1 + 2 * delta) * conductor + O_delta(1)`.

Taking `delta = epsilon / 2` proves the logarithmic abc conjecture.  Thus an
upper bound for the selected auxiliary prime is not logically necessary if the
actual source theory yields relative conductor absorption of the remaining
terms.

This module supplies an alternative target for the quantitative-prime research
track.  It does not assert that genuine IUT different/error terms satisfy the
relative bound, and it introduces no source, height or abc inequality as an
opaque field beyond the displayed source-term estimate itself.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- Epsilon-dependent public Theorem 1.10 sources whose remaining source terms
can be absorbed into an arbitrarily small multiple of the abc conductor.

The constant supplied by `relative_different_error` may depend on `delta`, as
is permitted for the constant in the abc conjecture, but it is uniform in the
abc point. -/
structure RelativeDifferentErrorPublicFreyBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Select a genuine public Theorem 1.10 source for every positive budget. -/
  bridge : ∀ δ : ℝ, 0 < δ → PublicFreyTheorem110Bridge F
  /-- The selected source prime makes the canonical correction at most `δ`. -/
  correction_le_delta :
    ∀ (δ : ℝ) (hδ : 0 < δ) (P : ABCPoint),
      publicFreyTheorem110Correction (bridge δ hδ) P ≤ δ
  /-- The source different and error terms are absorbable into a `δ`-fraction
  of the conductor, up to a point-independent constant. -/
  relative_different_error :
    ∀ (δ : ℝ) (hδ : 0 < δ),
      ∃ C : ℝ, ∀ P : ABCPoint,
        (1 + δ) * (bridge δ hδ).different P +
            20 * (bridge δ hδ).error P ≤
          δ * P.conductor + C

namespace RelativeDifferentErrorPublicFreyBridge

/-- Pointwise height estimate obtained from relative absorption of the source
terms. -/
theorem pointwise_height_bound
    (U : RelativeDifferentErrorPublicFreyBridge F)
    {δ : ℝ} (hδ : 0 < δ)
    {C : ℝ}
    (hC : ∀ P : ABCPoint,
      (1 + δ) * (U.bridge δ hδ).different P +
          20 * (U.bridge δ hδ).error P ≤
        δ * P.conductor + C)
    (P : ABCPoint) :
    P.height ≤
      (1 + 2 * δ) * P.conductor +
        (C + (1 + δ) * Real.log 16 + Real.log 8 / 6) := by
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
  have hcoefficient_term :
      (1 + publicFreyTheorem110Correction B P) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + δ) *
          (B.different P + P.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right (by linarith) hbase_nonneg
  have habsorb :
      (1 + δ) * B.different P + 20 * B.error P ≤
        δ * P.conductor + C := by
    simpa [B] using hC P
  have hcoef_nonneg : 0 ≤ 1 + δ := by
    linarith
  have hfrey :
      (1 + δ) * P.freyDiscriminantConductor ≤
        (1 + δ) * (P.conductor + Real.log 16) :=
    mul_le_mul_of_nonneg_left P.freyDiscriminantConductor_le
      hcoef_nonneg
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
    _ ≤ (δ * P.conductor + C) +
          (1 + δ) * (P.conductor + Real.log 16) +
          Real.log 8 / 6 := by
      linarith
    _ = (1 + 2 * δ) * P.conductor +
        (C + (1 + δ) * Real.log 16 + Real.log 8 / 6) := by
      ring

/-- Relative source-term absorption is sufficient for the standard logarithmic
abc conjecture. -/
theorem abc
    (U : RelativeDifferentErrorPublicFreyBridge F) :
    ABCConjecture := by
  intro ε hε
  let δ : ℝ := ε / 2
  have hδ : 0 < δ := by
    dsimp [δ]
    linarith
  rcases U.relative_different_error δ hδ with ⟨C, hC⟩
  refine ⟨C + (1 + δ) * Real.log 16 + Real.log 8 / 6, ?_⟩
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
  have h := U.pointwise_height_bound hδ hC P
  have hcoefficient : (1 + 2 * δ : ℝ) = 1 + ε := by
    dsimp [δ]
    ring
  rw [hcoefficient] at h
  simpa [ABCPoint.height, ABCPoint.conductor, P] using h

end RelativeDifferentErrorPublicFreyBridge

end IUTThreeClosures
