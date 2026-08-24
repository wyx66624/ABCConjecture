/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110

/-!
# Absorbable source errors in the final Frey/IUT IV bridge

A quantitative upper bound for the first auxiliary large-image prime is one
way to make the source different and error terms uniform in the abc input, but
it is not the only possible route.  It is enough that the parts of those terms
which grow with the logarithmic conductor have arbitrarily small slopes.

For a selected public Theorem 1.10 source, write

* `c` for the correction `20 * d_mod / ell`;
* `d` for the genuine different term;
* `e` for the genuine remaining error term;
* `C` for the abc logarithmic conductor.

The already verified public estimate has the form

`height <= (1+c) * (d + freyDiscriminantConductor) + 20*e + log 8 / 6`.

Assume, for one positive target epsilon, that

`c <= alpha`, `d <= beta*C + D`, and `e <= gamma*C + E`,

where

`(1+alpha)*(1+beta) + 20*gamma <= 1+epsilon`.

Then the conductor-dependent portions are absorbed into `(1+epsilon)*C`,
while `D` and `E` contribute only to the allowed epsilon-dependent additive
constant.  This gives a second, strictly weaker sufficient route to the final
quantifier-correct theorem: one may prove asymptotically absorbable source
bounds instead of a uniform bound for every source term.

No large-image theorem, anabelian/tempered construction, IUT III source, or abc
inequality is stored as data.  The only source assumptions are the displayed
pointwise numerical bounds and their explicit coefficient budget.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- Epsilon-dependent public Theorem 1.10 sources whose different and error
terms have absorbably small conductor slopes. -/
structure AbsorbablePublicFreyTheorem110Bridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Select an actual public source for every positive target epsilon. -/
  bridge : ∀ ε : ℝ, 0 < ε → PublicFreyTheorem110Bridge F
  /-- Explicit slope and constant bounds for the selected source. -/
  source_bounds :
    ∀ (ε : ℝ) (hε : 0 < ε),
      ∃ α β γ D E : ℝ,
        0 ≤ α ∧
        0 ≤ β ∧
        0 ≤ γ ∧
        (1 + α) * (1 + β) + 20 * γ ≤ 1 + ε ∧
        (∀ P : ABCPoint,
          publicFreyTheorem110Correction (bridge ε hε) P ≤ α) ∧
        (∀ P : ABCPoint,
          (bridge ε hε).different P ≤ β * P.conductor + D) ∧
        (∀ P : ABCPoint,
          (bridge ε hε).error P ≤ γ * P.conductor + E)

namespace AbsorbablePublicFreyTheorem110Bridge

/-- Pointwise absorption of correction, different and error slopes into the
target conductor coefficient. -/
theorem pointwise_height_bound
    (U : AbsorbablePublicFreyTheorem110Bridge F)
    {ε α β γ D E : ℝ}
    (hε : 0 < ε)
    (hα : 0 ≤ α)
    (_hβ : 0 ≤ β)
    (_hγ : 0 ≤ γ)
    (hbudget : (1 + α) * (1 + β) + 20 * γ ≤ 1 + ε)
    (hcorrection :
      ∀ P : ABCPoint,
        publicFreyTheorem110Correction (U.bridge ε hε) P ≤ α)
    (hdifferent :
      ∀ P : ABCPoint,
        (U.bridge ε hε).different P ≤ β * P.conductor + D)
    (herror :
      ∀ P : ABCPoint,
        (U.bridge ε hε).error P ≤ γ * P.conductor + E)
    (P : ABCPoint)
    (hconductor : 0 ≤ P.conductor) :
    P.height ≤
      (1 + ε) * P.conductor +
        ((1 + α) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
  let B : PublicFreyTheorem110Bridge F := U.bridge ε hε
  have hpoint :
      P.height ≤
        (1 + publicFreyTheorem110Correction B P) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
    simpa [B, publicFreyTheorem110Correction] using
      B.pointwise_height_bound P
  have hcorrection' :
      publicFreyTheorem110Correction B P ≤ α := by
    simpa [B] using hcorrection P
  have hdifferent' :
      B.different P ≤ β * P.conductor + D := by
    simpa [B] using hdifferent P
  have herror' :
      B.error P ≤ γ * P.conductor + E := by
    simpa [B] using herror P
  have hbase_nonneg :
      0 ≤ B.different P + P.freyDiscriminantConductor :=
    add_nonneg (B.different_nonneg P)
      (freyDiscriminantConductor_nonneg P)
  have hcoefficient :
      1 + publicFreyTheorem110Correction B P ≤ 1 + α := by
    linarith
  have hcoefficient_term :
      (1 + publicFreyTheorem110Correction B P) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + α) *
          (B.different P + P.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right hcoefficient hbase_nonneg
  have hsource_sum :
      B.different P + P.freyDiscriminantConductor ≤
        (1 + β) * P.conductor + (D + Real.log 16) := by
    have hfrey := P.freyDiscriminantConductor_le
    linarith
  have hone_alpha : 0 ≤ 1 + α := by linarith
  have hsource_term :
      (1 + α) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + α) *
          ((1 + β) * P.conductor + (D + Real.log 16)) :=
    mul_le_mul_of_nonneg_left hsource_sum hone_alpha
  have herror_term :
      20 * B.error P ≤ 20 * (γ * P.conductor + E) :=
    mul_le_mul_of_nonneg_left herror' (by norm_num)
  have hbudget_term :
      ((1 + α) * (1 + β) + 20 * γ) * P.conductor ≤
        (1 + ε) * P.conductor :=
    mul_le_mul_of_nonneg_right hbudget hconductor
  calc
    P.height ≤
        (1 + publicFreyTheorem110Correction B P) *
            (B.different P + P.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := hpoint
    _ ≤ (1 + α) *
          (B.different P + P.freyDiscriminantConductor) +
        20 * B.error P + Real.log 8 / 6 := by
      linarith
    _ ≤ (1 + α) *
          ((1 + β) * P.conductor + (D + Real.log 16)) +
        20 * (γ * P.conductor + E) + Real.log 8 / 6 := by
      linarith
    _ = ((1 + α) * (1 + β) + 20 * γ) * P.conductor +
        ((1 + α) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      ring
    _ ≤ (1 + ε) * P.conductor +
        ((1 + α) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      linarith

/-- The absorbable-slope source condition implies the logarithmic abc
conjecture.  Nonnegativity of the logarithmic conductor is kept as an explicit
arithmetic lemma so that this module does not depend on a particular radical
implementation. -/
theorem abc
    (U : AbsorbablePublicFreyTheorem110Bridge F)
    (hconductor : ∀ P : ABCPoint, 0 ≤ P.conductor) :
    ABCConjecture := by
  intro ε hε
  rcases U.source_bounds ε hε with
    ⟨α, β, γ, D, E, hα, hβ, hγ, hbudget,
      hcorrection, hdifferent, herror⟩
  refine ⟨(1 + α) * (D + Real.log 16) +
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
  have h := U.pointwise_height_bound hε hα hβ hγ hbudget
    hcorrection hdifferent herror P (hconductor P)
  simpa [ABCPoint.height, ABCPoint.conductor, P] using h

end AbsorbablePublicFreyTheorem110Bridge

end IUTThreeClosures
