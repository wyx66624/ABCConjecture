/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The closed-ray approximation bridge for IUT III, Corollary 3.12

This module formalizes the elementary real-analysis step isolated first in
`research/IUT_CLOSED_RAY_APPROXIMATION_BRIDGE_2026_09_01.md`.

Arbitrarily accurate approximation of `q` by points of the closed lower ray
`(-∞, T]` is equivalent to `q ≤ T`.  A vanishing one-sided upper error is
also sufficient.  In contrast, a single fixed tolerance and a bare bijective
link of underlying data are both insufficient; explicit counterexamples are
proved below.

Nothing in this file asserts that the published multiradial construction
provides the quantitative approximation hypothesis.  No IUT theorem or abc
statement is assumed as a field or axiom.
-/

namespace IUTThreeClosures
namespace IUTClosedRayApproximationBridge20260901

/-- Scalar content of a source-defined hull approximant: an intermediate
log-volume `h` lies above the input log-volume `q` and inside the output lower
ray with endpoint `T`. -/
def OrderedHullApproximation (q T : ℝ) : Prop :=
  ∃ h : ℝ, q ≤ h ∧ h ≤ T

/-- A correctly typed ordered hull approximant gives the desired lower-ray
membership by transitivity. -/
theorem le_of_orderedHullApproximation {q T : ℝ}
    (h : OrderedHullApproximation q T) : q ≤ T := by
  rcases h with ⟨x, hqx, hxT⟩
  exact hqx.trans hxT

/-- Exact membership supplies the input value itself as the intermediate hull
log-volume. -/
theorem orderedHullApproximation_of_le {q T : ℝ} (h : q ≤ T) :
    OrderedHullApproximation q T :=
  ⟨q, le_rfl, h⟩

/-- At the scalar level, the source-defined ordered approximation condition is
equivalent to the desired inequality. -/
theorem orderedHullApproximation_iff {q T : ℝ} :
    OrderedHullApproximation q T ↔ q ≤ T :=
  ⟨le_of_orderedHullApproximation, orderedHullApproximation_of_le⟩

/-- Arbitrarily accurate approximation of `q` by members of the lower closed
ray `(-∞, T]`. -/
def RayApproximation (q T : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ x : ℝ, x ≤ T ∧ |x - q| < ε

/-- Arbitrarily accurate approximation from a closed lower ray forces exact
membership in that ray. -/
theorem le_of_rayApproximation {q T : ℝ}
    (h : RayApproximation q T) : q ≤ T := by
  by_contra hn
  have hTq : T < q := lt_of_not_ge hn
  have hε : 0 < (q - T) / 2 := by linarith
  rcases h ((q - T) / 2) hε with ⟨x, hxT, hxq⟩
  have hdist : q - x ≤ |x - q| := by
    calc
      q - x ≤ |q - x| := le_abs_self (q - x)
      _ = |x - q| := abs_sub_comm q x
  linarith

/-- Exact membership supplies the constant approximating family. -/
theorem rayApproximation_of_le {q T : ℝ} (h : q ≤ T) :
    RayApproximation q T := by
  intro ε hε
  exact ⟨q, h, by simpa using hε⟩

/-- Quantified approximation inside a closed lower ray is exactly ray
membership. -/
theorem rayApproximation_iff {q T : ℝ} :
    RayApproximation q T ↔ q ≤ T :=
  ⟨le_of_rayApproximation, rayApproximation_of_le⟩

/-- The equivalent topological formulation: the closure of any subset of a
closed lower ray is still contained in that ray. -/
theorem mem_lowerRay_of_mem_closure
    {S : Set ℝ} {q T : ℝ}
    (hS : S ⊆ Set.Iic T) (hq : q ∈ closure S) :
    q ≤ T := by
  have hClosure : closure S ⊆ Set.Iic T :=
    closure_minimal hS isClosed_Iic
  exact hClosure hq

/-- A weaker, one-sided approximation condition tailored to an upper bound. -/
def VanishingUpperError (q T : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ x : ℝ, x ≤ T ∧ q ≤ x + ε

/-- A vanishing one-sided upper error also forces membership in the closed
lower ray. -/
theorem le_of_vanishingUpperError {q T : ℝ}
    (h : VanishingUpperError q T) : q ≤ T := by
  by_contra hn
  have hTq : T < q := lt_of_not_ge hn
  have hε : 0 < (q - T) / 2 := by linarith
  rcases h ((q - T) / 2) hε with ⟨x, hxT, hqx⟩
  linarith

/-- Exact membership also supplies vanishing one-sided approximants. -/
theorem vanishingUpperError_of_le {q T : ℝ} (h : q ≤ T) :
    VanishingUpperError q T := by
  intro ε hε
  exact ⟨q, h, by linarith⟩

/-- The one-sided vanishing-error formulation is likewise equivalent to
closed-ray membership. -/
theorem vanishingUpperError_iff {q T : ℝ} :
    VanishingUpperError q T ↔ q ≤ T :=
  ⟨le_of_vanishingUpperError, vanishingUpperError_of_le⟩

/-- In the notation `Q = |log q|`, `H = |log Θ|`, the closed-ray bridge and
the printed upper comparison imply the normalized coefficient bound. -/
theorem coefficient_ge_neg_one_of_rayApproximation
    {Q H C : ℝ} (hQ : 0 < Q)
    (hApprox : RayApproximation (-Q) (-H))
    (hUpper : -H ≤ C * Q) :
    -1 ≤ C := by
  have hRay : -Q ≤ -H := le_of_rayApproximation hApprox
  have hChain : -Q ≤ C * Q := hRay.trans hUpper
  have hMul : (-1 : ℝ) * Q ≤ C * Q := by simpa using hChain
  have hDiv : (-1 : ℝ) ≤ (C * Q) / Q := (le_div_iff₀ hQ).2 hMul
  simpa [hQ.ne'] using hDiv

/-- The source-defined ordered hull-approximant reading gives the same
coefficient conclusion. -/
theorem coefficient_ge_neg_one_of_orderedHullApproximation
    {Q H C : ℝ} (hQ : 0 < Q)
    (hApprox : OrderedHullApproximation (-Q) (-H))
    (hUpper : -H ≤ C * Q) :
    -1 ≤ C := by
  have hRay : -Q ≤ -H := le_of_orderedHullApproximation hApprox
  have hChain : -Q ≤ C * Q := hRay.trans hUpper
  have hMul : (-1 : ℝ) * Q ≤ C * Q := by simpa using hChain
  have hDiv : (-1 : ℝ) ≤ (C * Q) / Q := (le_div_iff₀ hQ).2 hMul
  simpa [hQ.ne'] using hDiv

/-- A single fixed positive tolerance does not force closed-ray membership.
This is a full counterexample to precisely that weakened implication. -/
theorem fixedTolerance_counterexample (δ : ℝ) (hδ : 0 < δ) :
    ∃ q T x : ℝ,
      x ≤ T ∧ |x - q| < δ ∧ ¬ q ≤ T := by
  refine ⟨δ / 2, 0, 0, by norm_num, ?_, ?_⟩
  · have hhalf : 0 < δ / 2 := by linarith
    rw [abs_sub_comm]
    simp only [sub_zero, abs_of_pos hhalf]
    linarith
  · linarith

/-- Minimal abstract data for testing what follows from a qualitative
bijection and an output log bound alone. -/
structure LinkedLogData where
  Input : Type
  Output : Type
  link : Input ≃ Output
  inputLog : Input → ℝ
  outputLog : Output → ℝ
  threshold : ℝ
  output_le : ∀ b, outputLog b ≤ threshold

/-- Exact numerical compatibility upgrades a qualitative link to the desired
input bound. -/
theorem input_le_threshold_of_logCompatible
    (D : LinkedLogData)
    (hCompatible : ∀ a, D.inputLog a = D.outputLog (D.link a))
    (a : D.Input) :
    D.inputLog a ≤ D.threshold := by
  rw [hCompatible a]
  exact D.output_le (D.link a)

/-- A singleton qualitative link whose input log is `1` and output log is
`0`. -/
def singletonQualitativeCountermodel : LinkedLogData where
  Input := Unit
  Output := Unit
  link := Equiv.refl Unit
  inputLog := fun _ => 1
  outputLog := fun _ => 0
  threshold := 0
  output_le := by intro b; norm_num

/-- A bijective link plus a bound for every output log does not, without log
compatibility, bound the linked input log. -/
theorem qualitativeLink_counterexample :
    ¬ (∀ a : singletonQualitativeCountermodel.Input,
      singletonQualitativeCountermodel.inputLog a ≤
        singletonQualitativeCountermodel.threshold) := by
  intro h
  have hbad := h ()
  change (1 : ℝ) ≤ 0 at hbad
  norm_num at hbad

end IUTClosedRayApproximationBridge20260901
end IUTThreeClosures

namespace IUTThreeClosures.IUTClosedRayApproximationBridge20260901

#print axioms orderedHullApproximation_iff
#print axioms rayApproximation_iff
#print axioms mem_lowerRay_of_mem_closure
#print axioms vanishingUpperError_iff
#print axioms coefficient_ge_neg_one_of_rayApproximation
#print axioms coefficient_ge_neg_one_of_orderedHullApproximation
#print axioms fixedTolerance_counterexample
#print axioms qualitativeLink_counterexample

end IUTThreeClosures.IUTClosedRayApproximationBridge20260901
