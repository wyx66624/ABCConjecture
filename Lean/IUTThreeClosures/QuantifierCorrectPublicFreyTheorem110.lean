/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PublicFreyTheorem110Bridge

/-!
# Quantifier-correct public Frey Theorem 1.10 closure

The coefficient correction in the public form of IUT IV, Theorem 1.10 is

`20 * d_mod / ell`.

A single fixed initial-theta datum cannot make this correction smaller than
every positive epsilon.  The source selection must therefore depend on
`epsilon` (as well as on the abc point), or equivalently provide arbitrarily
large admissible primes with the required geometric data.

This module records that quantifier order explicitly.  For each positive
`epsilon` it selects an actual `PublicFreyTheorem110Bridge`, requires its
correction coefficient to be at most `epsilon`, and asks only for uniform
upper bounds on the genuine different and error terms.  The exact public
Theorem 1.10 estimate, the complete Frey packet, and the Frey discriminant
conductor are inherited from the selected bridge.

No abc inequality, q-bound, arbitrary height function, or arbitrary conductor
function is a field.  The resulting logarithmic abc theorem is derived from:

* the actual componentwise public theta-hull estimate;
* epsilon-dependent prime selection;
* uniform different and error bounds;
* the already formalized Frey height and radical-conductor comparisons.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The varying numerical correction in the final public Theorem 1.10
q-bound.  Both the moduli degree and the admissible prime are canonical
projections of the selected actual initial-theta datum. -/
noncomputable def publicFreyTheorem110Correction
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint) : ℝ :=
  20 * initialThetaModuliDegree (F.data (B.encode P)) /
    initialThetaEllReal (F.data (B.encode P))

/-- The public Theorem 1.10 correction is nonnegative. -/
theorem publicFreyTheorem110Correction_nonneg
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint) :
    0 ≤ publicFreyTheorem110Correction B P := by
  have hdegree :
      0 ≤ initialThetaModuliDegree (F.data (B.encode P)) := by
    linarith [initialThetaModuliDegree_ge_one (F.data (B.encode P))]
  have hell :
      0 ≤ initialThetaEllReal (F.data (B.encode P)) := by
    linarith [B.ell_ge_seven P]
  exact div_nonneg (mul_nonneg (by norm_num) hdegree) hell

/-- Epsilon-dependent source data for the exact public Frey specialization of
IUT IV, Theorem 1.10.

The bridge selected for `epsilon` may choose different initial-theta data for
each abc point.  The correction field enforces the prime-choice quantifier.
The final field asks for finite uniform bounds only on the actual source
different and error terms; these bounds may depend on `epsilon`, as the
constant in the abc conjecture is allowed to do. -/
structure QuantifierCorrectPublicFreyTheorem110Bridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- For every positive epsilon, select an actual public Theorem 1.10 source. -/
  bridge : ∀ ε : ℝ, 0 < ε → PublicFreyTheorem110Bridge F
  /-- The selected source prime is large enough relative to its moduli degree. -/
  correction_le_epsilon :
    ∀ (ε : ℝ) (hε : 0 < ε) (P : ABCPoint),
      publicFreyTheorem110Correction (bridge ε hε) P ≤ ε
  /-- The remaining genuine different and error terms are uniformly bounded
  for the source selected at a fixed epsilon. -/
  bounded_different_error :
    ∀ (ε : ℝ) (hε : 0 < ε),
      ∃ D E : ℝ,
        (∀ P : ABCPoint, (bridge ε hε).different P ≤ D) ∧
        (∀ P : ABCPoint, (bridge ε hε).error P ≤ E)

namespace QuantifierCorrectPublicFreyTheorem110Bridge

/-- Pointwise height estimate after the quantifier-correct prime choice and
uniform source-term bounds.  All constants are displayed explicitly. -/
theorem pointwise_height_bound
    (U : QuantifierCorrectPublicFreyTheorem110Bridge F)
    {ε : ℝ} (hε : 0 < ε)
    {D E : ℝ}
    (hD : ∀ P : ABCPoint, (U.bridge ε hε).different P ≤ D)
    (hE : ∀ P : ABCPoint, (U.bridge ε hε).error P ≤ E)
    (P : ABCPoint) :
    P.height ≤
      (1 + ε) * P.conductor +
        ((1 + ε) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
  let B : PublicFreyTheorem110Bridge F := U.bridge ε hε
  have hpoint :
      P.height ≤
        (1 + publicFreyTheorem110Correction B P) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
    simpa [B, publicFreyTheorem110Correction] using
      B.pointwise_height_bound P
  have hcorrection :
      publicFreyTheorem110Correction B P ≤ ε := by
    simpa [B] using U.correction_le_epsilon ε hε P
  have hbase_nonneg :
      0 ≤ B.different P + P.freyDiscriminantConductor :=
    add_nonneg (B.different_nonneg P)
      (freyDiscriminantConductor_nonneg P)
  have hcoefficient :
      1 + publicFreyTheorem110Correction B P ≤ 1 + ε := by
    linarith
  have hcoefficient_term :
      (1 + publicFreyTheorem110Correction B P) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + ε) *
          (B.different P + P.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right hcoefficient hbase_nonneg
  have hD' : B.different P ≤ D := by
    simpa [B] using hD P
  have hE' : B.error P ≤ E := by
    simpa [B] using hE P
  have hsum :
      B.different P + P.freyDiscriminantConductor ≤
        D + (P.conductor + Real.log 16) :=
    add_le_add hD' P.freyDiscriminantConductor_le
  have htarget_coefficient_nonneg : 0 ≤ 1 + ε := by
    linarith
  have hsum_term :
      (1 + ε) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + ε) * (D + (P.conductor + Real.log 16)) :=
    mul_le_mul_of_nonneg_left hsum htarget_coefficient_nonneg
  have herror_term : 20 * B.error P ≤ 20 * E :=
    mul_le_mul_of_nonneg_left hE' (by norm_num)
  calc
    P.height ≤
        (1 + publicFreyTheorem110Correction B P) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := hpoint
    _ ≤ (1 + ε) *
          (B.different P + P.freyDiscriminantConductor) +
        20 * B.error P + Real.log 8 / 6 := by
      linarith
    _ ≤ (1 + ε) * (D + (P.conductor + Real.log 16)) +
        20 * E + Real.log 8 / 6 := by
      linarith
    _ = (1 + ε) * P.conductor +
        ((1 + ε) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      ring

/-- The quantifier-correct public Theorem 1.10 source family implies the
standard logarithmic abc conjecture. -/
theorem abc
    (U : QuantifierCorrectPublicFreyTheorem110Bridge F) :
    ABCConjecture := by
  intro ε hε
  rcases U.bounded_different_error ε hε with
    ⟨D, E, hD, hE⟩
  refine ⟨(1 + ε) * (D + Real.log 16) +
      20 * E + Real.log 8 / 6, ?_⟩
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
  have h := U.pointwise_height_bound hε hD hE P
  simpa [ABCPoint.height, ABCPoint.conductor, P] using h

end QuantifierCorrectPublicFreyTheorem110Bridge

end IUTThreeClosures
