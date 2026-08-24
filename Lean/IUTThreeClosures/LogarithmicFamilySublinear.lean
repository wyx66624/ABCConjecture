/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LogOnePlusSublinear

/-!
# Uniform logarithmic growth implies sublinear family growth

This file packages the analytic lemma in the form used by a family of genuine
IUT source terms.  If a nonnegative height `H(x)` and a source term `S(x)`
satisfy

`S(x) <= A * log (1 + H(x)) + B`

uniformly in `x`, with `A >= 0`, then for every `eta > 0` there is a uniform
constant `C_eta` such that

`S(x) <= eta * H(x) + C_eta`.

Thus any source theorem reducing the combined different/error contribution to
logarithmic growth in the Frey height automatically satisfies the
sublinear-height closure condition.
-/

namespace IUTThreeClosures

universe u

/-- A uniform affine logarithmic bound for a family. -/
structure AffineLogarithmicFamilyBound
    (X : Type u)
    (height source : X → ℝ) where
  coefficient : ℝ
  coefficient_nonneg : 0 ≤ coefficient
  constant : ℝ
  height_nonneg : ∀ x : X, 0 ≤ height x
  source_le :
    ∀ x : X,
      source x ≤
        coefficient * Real.log (1 + height x) + constant

namespace AffineLogarithmicFamilyBound

/-- Uniform logarithmic growth is uniformly sublinear. -/
theorem sublinear
    {X : Type u}
    {height source : X → ℝ}
    (L : AffineLogarithmicFamilyBound X height source)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ, ∀ x : X,
      source x ≤ η * height x + C := by
  rcases affine_log_one_add_sublinear
      L.coefficient_nonneg hη with ⟨C, hC⟩
  refine ⟨C + L.constant, ?_⟩
  intro x
  have hlog := hC (height x) (L.height_nonneg x)
  have hsource := L.source_le x
  linarith

/-- Any smaller source term inherits the same logarithmic family bound. -/
def mono
    {X : Type u}
    {height source source' : X → ℝ}
    (L : AffineLogarithmicFamilyBound X height source)
    (h : ∀ x, source' x ≤ source x) :
    AffineLogarithmicFamilyBound X height source' where
  coefficient := L.coefficient
  coefficient_nonneg := L.coefficient_nonneg
  constant := L.constant
  height_nonneg := L.height_nonneg
  source_le := fun x => (h x).trans (L.source_le x)

/-- Sum of two affine logarithmic family bounds. -/
def add
    {X : Type u}
    {height source₁ source₂ : X → ℝ}
    (L₁ : AffineLogarithmicFamilyBound X height source₁)
    (L₂ : AffineLogarithmicFamilyBound X height source₂) :
    AffineLogarithmicFamilyBound X height
      (fun x => source₁ x + source₂ x) where
  coefficient := L₁.coefficient + L₂.coefficient
  coefficient_nonneg :=
    add_nonneg L₁.coefficient_nonneg L₂.coefficient_nonneg
  constant := L₁.constant + L₂.constant
  height_nonneg := L₁.height_nonneg
  source_le := by
    intro x
    have h₁ := L₁.source_le x
    have h₂ := L₂.source_le x
    ring_nf at h₁ h₂ ⊢
    linarith

/-- Multiplication by a nonnegative scalar preserves affine logarithmic growth. -/
def nonnegSMul
    {X : Type u}
    {height source : X → ℝ}
    (L : AffineLogarithmicFamilyBound X height source)
    (a : ℝ) (ha : 0 ≤ a) :
    AffineLogarithmicFamilyBound X height
      (fun x => a * source x) where
  coefficient := a * L.coefficient
  coefficient_nonneg := mul_nonneg ha L.coefficient_nonneg
  constant := a * L.constant
  height_nonneg := L.height_nonneg
  source_le := by
    intro x
    exact mul_le_mul_of_nonneg_left (L.source_le x) ha

end AffineLogarithmicFamilyBound

end IUTThreeClosures
