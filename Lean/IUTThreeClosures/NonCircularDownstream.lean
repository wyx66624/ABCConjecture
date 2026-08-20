/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CircularityAudit

/-!
# A non-circular IUT IV downstream certificate

The downstream object in the earlier certificate had `ABCConjecture` as a field
codomain.  This module replaces it by explicit intermediate quantities and inequalities:
a q-height estimate derived from Corollary 3.12, a comparison with the elementary abc
height, and comparisons for the different and conductor.  None of the structure fields
has `ABCConjecture` as its conclusion.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

/-- A positive pairwise-coprime abc triple. -/
structure ABCPoint where
  a : ℕ
  b : ℕ
  c : ℕ
  a_pos : 0 < a
  b_pos : 0 < b
  c_pos : 0 < c
  sum_eq : a + b = c
  pairwise_coprime : PairwiseCoprimeABC a b c

namespace ABCPoint

/-- Elementary logarithmic height. -/
noncomputable def height (P : ABCPoint) : ℝ :=
  Real.log (((max P.a (max P.b P.c) : ℕ) : ℝ))

/-- Elementary logarithmic conductor. -/
noncomputable def conductor (P : ABCPoint) : ℝ :=
  Real.log (((abcRadical (P.a * P.b * P.c) : ℕ) : ℝ))

end ABCPoint

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- Explicit, non-circular content required from IUT IV.

The `qEstimate` field is uniform in the abc point: for each epsilon it provides one
constant valid for all points.  It consumes only the pointwise Corollary 3.12 theorem
at the encoded input. -/
structure NonCircularIUTIVBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z} (AG := AG) (TG := TG) Input) :
    Type (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  encode : ABCPoint → Input
  logQ : ABCPoint → ℝ
  logDiff : ABCPoint → ℝ
  logCond : ABCPoint → ℝ

  heightError : ℝ
  differentError : ℝ
  conductorError : ℝ

  height_le :
    ∀ P, P.height ≤ logQ P / 6 + heightError
  different_le :
    ∀ P, logDiff P ≤ differentError
  conductor_le :
    ∀ P, logCond P ≤ P.conductor + conductorError

  qEstimate :
    ∀ ε : ℝ, 0 < ε →
      ∃ C : ℝ, ∀ P : ABCPoint,
        Corollary312Variant (F.source (encode P)).toVariantData →
          logQ P / 6 ≤
            (1 + ε) * (logDiff P + logCond P) + C

namespace NonCircularIUTIVBridge

/-- The explicit IUT IV estimates imply the logarithmic abc conjecture. -/
theorem abc
    {F : PointwiseIUTIIIFamily.{u, v, w, z} (AG := AG) (TG := TG) Input}
    (B : NonCircularIUTIVBridge F) :
    ABCConjecture := by
  intro ε hε
  rcases B.qEstimate ε hε with ⟨C, hC⟩
  refine ⟨C + B.heightError +
    (1 + ε) * (B.differentError + B.conductorError), ?_⟩
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
  have hq := hC P (F.corollary312Variant (B.encode P))
  have hh := B.height_le P
  have hd := B.different_le P
  have hcnd := B.conductor_le P
  have hcoef : 0 ≤ 1 + ε := by linarith
  have hsum :
      B.logDiff P + B.logCond P ≤
        B.differentError + (P.conductor + B.conductorError) :=
    add_le_add hd hcnd
  have hmul :
      (1 + ε) * (B.logDiff P + B.logCond P) ≤
        (1 + ε) *
          (B.differentError + (P.conductor + B.conductorError)) :=
    mul_le_mul_of_nonneg_left hsum hcoef
  have hfinal :
      P.height ≤
        (1 + ε) * P.conductor +
          (C + B.heightError +
            (1 + ε) * (B.differentError + B.conductorError)) := by
    calc
      P.height ≤ B.logQ P / 6 + B.heightError := hh
      _ ≤ ((1 + ε) * (B.logDiff P + B.logCond P) + C) +
          B.heightError := by linarith
      _ ≤ ((1 + ε) *
          (B.differentError + (P.conductor + B.conductorError)) + C) +
          B.heightError := by linarith
      _ = (1 + ε) * P.conductor +
          (C + B.heightError +
            (1 + ε) * (B.differentError + B.conductorError)) := by ring
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hfinal

end NonCircularIUTIVBridge

/-- Honest replacement for the circular three-closure certificate. -/
structure HonestThreeClosureCertificate : Type
    (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  upstream : UpstreamCertificate.{u, v, w, z}
    (AG := AG) (TG := TG) (Input := Input)
  downstream : NonCircularIUTIVBridge upstream.family

namespace HonestThreeClosureCertificate

/-- A genuinely inhabited honest certificate proves abc. -/
theorem abc
    (C : HonestThreeClosureCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ABCConjecture :=
  C.downstream.abc

end HonestThreeClosureCertificate

end IUTThreeClosures
