/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110

/-!
# Sublinear-height absorption of prime-dependent source terms

An effective open-image theorem need not bound the auxiliary prime directly in
terms of the conductor.  A different route is available when the logarithmic
size of the selected prime, and hence the remaining IUT source terms, is
sublinear in the Frey height.

For every `delta > 0`, suppose that a genuine public Theorem 1.10 source can be
selected with correction at most `delta`.  Suppose moreover that, for every
`eta > 0`, its combined source contribution satisfies

`(1 + delta) * different + 20 * error <= eta * height + C(delta, eta)`

uniformly in the abc point.  The verified Theorem 1.10 and Frey
Discriminant--conductor estimates then give

`(1 - eta) * height <= (1 + delta) * conductor + O(1)`.

For a target `epsilon > 0`, the choices

`delta = epsilon / 2`,
`eta = epsilon / (2 * (1 + epsilon))`

satisfy the exact identity

`(1 + delta) / (1 - eta) = 1 + epsilon`.

Thus the standard logarithmic abc conjecture follows.  This isolates a second
route around the quantitative auxiliary-prime obstruction: prove sublinear
height growth of the genuine different/error terms, for example from an
effective open-image bound whose selected prime is polynomial in the Frey
height.

No such effective arithmetic or IUT source estimate is asserted here.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- Public Theorem 1.10 sources whose remaining source terms are uniformly
sublinear in the abc height. -/
structure SublinearHeightPublicFreyBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Select a genuine public source for every positive correction budget. -/
  bridge : ∀ δ : ℝ, 0 < δ → PublicFreyTheorem110Bridge F
  /-- The selected canonical correction is at most the prescribed budget. -/
  correction_le_delta :
    ∀ (δ : ℝ) (hδ : 0 < δ) (P : ABCPoint),
      publicFreyTheorem110Correction (bridge δ hδ) P ≤ δ
  /-- At a fixed correction budget, the combined different/error contribution
  is sublinear in the Frey/abc height, uniformly in the abc point. -/
  source_terms_sublinear :
    ∀ (δ : ℝ) (hδ : 0 < δ) (η : ℝ), 0 < η →
      ∃ C : ℝ, ∀ P : ABCPoint,
        (1 + δ) * (bridge δ hδ).different P +
            20 * (bridge δ hδ).error P ≤
          η * P.height + C

namespace SublinearHeightPublicFreyBridge

/-- Sublinear-height source control is sufficient for the logarithmic abc
conjecture. -/
theorem abc
    (U : SublinearHeightPublicFreyBridge F) :
    ABCConjecture := by
  intro ε hε
  let δ : ℝ := ε / 2
  let η : ℝ := ε / (2 * (1 + ε))
  have hδ : 0 < δ := by
    dsimp [δ]
    linarith
  have honeε : 0 < 1 + ε := by
    linarith
  have hη : 0 < η := by
    dsimp [η]
    positivity
  have hη_lt_one : η < 1 := by
    dsimp [η]
    apply (div_lt_one (by positivity : 0 < 2 * (1 + ε))).2
    nlinarith
  have hden : 0 < 1 - η := by
    linarith
  have hcoefficient_identity :
      1 + δ = (1 - η) * (1 + ε) := by
    dsimp [δ, η]
    field_simp [ne_of_gt honeε]
    ring
  rcases U.source_terms_sublinear δ hδ η hη with ⟨C, hC⟩
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
  have hcoefficient_term :
      (1 + publicFreyTheorem110Correction B P) *
          (B.different P + P.freyDiscriminantConductor) ≤
        (1 + δ) *
          (B.different P + P.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right (by linarith) hbase_nonneg
  have hsource :
      (1 + δ) * B.different P + 20 * B.error P ≤
        η * P.height + C := by
    simpa [B] using hC P
  have hcoef_nonneg : 0 ≤ 1 + δ := by
    linarith
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
    rw [hcoefficient_identity]
    field_simp [ne_of_gt hden]
  rw [hquotient] at hdiv
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hdiv

end SublinearHeightPublicFreyBridge

end IUTThreeClosures
