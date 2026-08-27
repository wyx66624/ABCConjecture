/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SUnitAnchoredDescentBarrier

/-!
# Finite rational tripod selectors with a logarithmic two-defect

This module packages an at-most-six-point selector whose chosen heights differ
from the ordinary rational tripod height by at most `log 2`.  The additive
defect is absorbed into the uniform constant, giving an exact equivalence with
the ordinary uniform tripod bound and hence with the logarithmic abc statement.
-/

namespace IUTThreeClosures

noncomputable section

/-- Abstract data carried by a finite (in particular, at most six-point)
tripod selector. -/
structure LogTwoFiniteRationalTripodSelector
    (ι : Type*) [DecidableEq ι] where
  candidates : ℚ → Finset ι
  candidates_card_le_six : ∀ x, (candidates x).card ≤ 6
  anchor : ℚ → ι
  anchor_mem : ∀ x, anchor x ∈ candidates x
  selectedHeight : ℚ → ι → ℝ
  selectedCounting : ℚ → ι → ℝ
  anchor_height : ∀ x,
    selectedHeight x (anchor x) = rationalTripodHeight x
  anchor_counting : ∀ x,
    selectedCounting x (anchor x) = rationalTripodCounting x
  source_height_le : ∀ x i, i ∈ candidates x →
    rationalTripodHeight x ≤ selectedHeight x i + Real.log 2
  counting_eq : ∀ x i, i ∈ candidates x →
    selectedCounting x i = rationalTripodCounting x

/-- Uniform coefficient-one bound after choosing one member of the finite
tripod candidate set. -/
def UniformLogTwoFiniteRationalTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteRationalTripodSelector ι) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ x : ℚ, 0 < x → x < 1 →
      ∃ i : ι, i ∈ F.candidates x ∧
        F.selectedHeight x i ≤
          (1 + ε) * F.selectedCounting x i + C

/-- The ordinary uniform tripod bound supplies the finite-selector bound by
choosing the exact anchor. -/
theorem uniformLogTwoFiniteRationalTripodSelectorBound_of_uniformRationalSUnitTripodBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteRationalTripodSelector ι)
    (htripod : UniformRationalSUnitTripodBound) :
    UniformLogTwoFiniteRationalTripodSelectorBound F := by
  intro ε hε
  obtain ⟨C, hC⟩ := htripod ε hε
  refine ⟨C, ?_⟩
  intro x hx0 hx1
  refine ⟨F.anchor x, F.anchor_mem x, ?_⟩
  rw [F.anchor_height x, F.anchor_counting x]
  exact hC x hx0 hx1

/-- A finite-selector bound recovers the ordinary tripod bound; the sole
loss is the additive constant `log 2`. -/
theorem uniformRationalSUnitTripodBound_of_uniformLogTwoFiniteRationalTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteRationalTripodSelector ι)
    (hselector : UniformLogTwoFiniteRationalTripodSelectorBound F) :
    UniformRationalSUnitTripodBound := by
  intro ε hε
  obtain ⟨C, hC⟩ := hselector ε hε
  refine ⟨C + Real.log 2, ?_⟩
  intro x hx0 hx1
  obtain ⟨i, hi, hibound⟩ := hC x hx0 hx1
  have hrecover := F.source_height_le x i hi
  have hcount := F.counting_eq x i hi
  rw [hcount] at hibound
  linarith

/-- Exact equivalence of the ordinary uniform rational tripod bound and its
finite-selector version. -/
theorem uniformRationalSUnitTripodBound_iff_uniformLogTwoFiniteRationalTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteRationalTripodSelector ι) :
    UniformRationalSUnitTripodBound ↔
      UniformLogTwoFiniteRationalTripodSelectorBound F :=
  ⟨uniformLogTwoFiniteRationalTripodSelectorBound_of_uniformRationalSUnitTripodBound F,
    uniformRationalSUnitTripodBound_of_uniformLogTwoFiniteRationalTripodSelectorBound F⟩

/-- The abstract at-most-six-point selector statement is equivalent to the
logarithmic abc conjecture. -/
theorem abcConjecture_iff_uniformLogTwoFiniteRationalTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteRationalTripodSelector ι) :
    ABCConjecture ↔ UniformLogTwoFiniteRationalTripodSelectorBound F :=
  abcConjecture_iff_uniformRationalSUnitTripodBound.trans
    (uniformRationalSUnitTripodBound_iff_uniformLogTwoFiniteRationalTripodSelectorBound F)

end

end IUTThreeClosures
