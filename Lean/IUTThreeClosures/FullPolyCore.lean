/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Full-poly conjugation and generated ordinary output

This module formalizes the generic categorical core used in the source-shaped
reconstruction of the IUT III pilot bridge.
-/

namespace IUTThreeClosures

universe u₀ u₁ u₂ u₃ u₄

/-- Kummer conjugation of one horizontal equivalence. -/
def kummerConjugate
    {A₀ : Type u₀} {A₁ : Type u₁}
    {C₀ : Type u₂} {C₁ : Type u₃}
    (k₀ : A₀ ≃ C₀) (k₁ : A₁ ≃ C₁) (h : A₀ ≃ A₁) : C₀ ≃ C₁ :=
  k₀.symm.trans (h.trans k₁)

@[simp]
theorem kummerConjugate_apply_kummer
    {A₀ : Type u₀} {A₁ : Type u₁}
    {C₀ : Type u₂} {C₁ : Type u₃}
    (k₀ : A₀ ≃ C₀) (k₁ : A₁ ≃ C₁)
    (h : A₀ ≃ A₁) (x : A₀) :
    kummerConjugate k₀ k₁ h (k₀ x) = k₁ (h x) := by
  simp [kummerConjugate]

/-- A generated choice type with one ordinary constructor and arbitrary extra choices. -/
inductive GeneratedChoice
    {C₀ : Type u₂} {C₁ : Type u₃}
    (Extra : Type u₄) where
  | ordinary (p : C₀ ≃ C₁)
  | extra (e : Extra)

namespace GeneratedChoice

variable {A₀ : Type u₀} {A₁ : Type u₁}
variable {C₀ : Type u₂} {C₁ : Type u₃}
variable {Extra : Type u₄}

/-- Output of an ordinary or extra generated choice. -/
def output
    (k₀ : A₀ ≃ C₀) (theta : A₀)
    (extraOutput : Extra → C₁) :
    GeneratedChoice (C₀ := C₀) (C₁ := C₁) Extra → C₁
  | .ordinary p => p (k₀ theta)
  | .extra e => extraOutput e

/-- The Kummer-conjugate ordinary branch maps the theta pilot to the Kummer image of
its horizontal image. -/
theorem ordinary_conjugate_output
    (k₀ : A₀ ≃ C₀) (k₁ : A₁ ≃ C₁)
    (h : A₀ ≃ A₁) (theta : A₀)
    (extraOutput : Extra → C₁) :
    output k₀ theta extraOutput
      (.ordinary (kummerConjugate k₀ k₁ h)) = k₁ (h theta) := by
  simp [output]

/-- The native Kummer image belongs to the generated output range whenever the chosen
horizontal representative maps the theta pilot to the q pilot. -/
theorem native_mem_range
    (k₀ : A₀ ≃ C₀) (k₁ : A₁ ≃ C₁)
    (h : A₀ ≃ A₁) (theta : A₀) (qPilot : A₁)
    (hpilot : h theta = qPilot)
    (extraOutput : Extra → C₁) :
    k₁ qPilot ∈ Set.range (output k₀ theta extraOutput) := by
  refine ⟨.ordinary (kummerConjugate k₀ k₁ h), ?_⟩
  simpa [hpilot] using ordinary_conjugate_output
    (Extra := Extra) k₀ k₁ h theta extraOutput

end GeneratedChoice

/-- Generic monotone-volume bridge from singleton membership in a generated region. -/
theorem singleton_volume_le_generated
    {α : Type*} (volume : Set α → ℝ) (hmono : Monotone volume)
    {x : α} {U : Set α} (hx : x ∈ U) :
    volume {x} ≤ volume U := by
  apply hmono
  intro y hy
  have hyx : y = x := by simpa using hy
  simpa [hyx] using hx

/-- Scalar consequence used in Corollary 3.12. -/
theorem coefficient_ge_neg_one_of_bridge
    {Q theta C : ℝ} (hQ : 0 < Q)
    (hbridge : -Q ≤ theta) (hupper : theta ≤ C * Q) :
    -1 ≤ C := by
  nlinarith

end IUTThreeClosures
