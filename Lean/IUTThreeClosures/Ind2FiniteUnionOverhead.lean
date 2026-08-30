/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HonestFinitePositiveLogVolume
import IUTThreeClosures.PermutationOrbitUnionCounterexample
import Mathlib.Data.ENNReal.BigOperators
import Mathlib.Tactic

/-!
# Finite Ind2 orbit unions cost only logarithmic cardinality

Orbitwise equality of volumes does not imply equality for the union of the
orbit.  The correct universal statement is subadditivity:

`μ (⋃ i ∈ s, U i) ≤ ∑ i ∈ s, μ (U i)`.

If all orbit pieces have the same finite positive measure, the logarithmic
volume of the union is at most the logarithmic volume of one piece plus
`log |s|`.  Thus a fixed finite Ind2 permutation orbit contributes only an
additive constant; no false union-equality assertion is needed.
-/

namespace IUTThreeClosures
namespace Ind2FiniteUnionOverhead

open MeasureTheory

universe u v

variable {α : Type u} {ι : Type v}
  [MeasurableSpace α] {μ : Measure α}

/-- Measurability of a finite indexed union. -/
theorem measurable_finset_iUnion
    (s : Finset ι) (U : ι → FinitePositiveRegion α μ) :
    MeasurableSet (⋃ i ∈ s, (U i : Set α)) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
      simpa [ha] using (U a).measurable.union ih

/-- Finite subadditivity in the exact orbit-union form. -/
theorem measure_finset_iUnion_le_sum
    (s : Finset ι) (U : ι → Set α) :
    μ (⋃ i ∈ s, U i) ≤ ∑ i ∈ s, μ (U i) := by
  exact measure_biUnion_finset_le

/-- The finite sum of finite-positive orbit measures is finite. -/
theorem measure_sum_ne_top
    (s : Finset ι) (U : ι → FinitePositiveRegion α μ) :
    (∑ i ∈ s, μ (U i).carrier) ≠ ⊤ := by
  exact ENNReal.sum_ne_top.2 fun i hi => (U i).measure_ne_top

/-- The union of a nonempty finite collection of finite-positive regions is
again a finite-positive region. -/
noncomputable def finsetUnionRegion
    (s : Finset ι) (hs : s.Nonempty)
    (U : ι → FinitePositiveRegion α μ) :
    FinitePositiveRegion α μ where
  carrier := ⋃ i ∈ s, (U i : Set α)
  measurable := measurable_finset_iUnion s U
  measure_ne_zero := by
    obtain ⟨i, hi⟩ := hs
    have hsub : (U i : Set α) ⊆ ⋃ j ∈ s, (U j : Set α) := by
      intro x hx
      simp only [Set.mem_iUnion]
      exact ⟨i, ⟨hi, hx⟩⟩
    have hle : μ (U i).carrier ≤ μ (⋃ j ∈ s, (U j : Set α)) :=
      measure_mono hsub
    intro hzero
    apply (U i).measure_ne_zero
    apply bot_unique
    simpa [hzero] using hle
  measure_ne_top := by
    have hle :
        μ (⋃ i ∈ s, (U i : Set α)) ≤
          ∑ i ∈ s, μ (U i).carrier :=
      measure_finset_iUnion_le_sum s fun i => (U i : Set α)
    intro htop
    rw [htop] at hle
    exact (measure_sum_ne_top s U) (top_unique hle)

/-- Equal-volume orbit pieces give the real measure estimate
`volume(union) ≤ |s| * volume(piece)`. -/
theorem toReal_measure_finsetUnion_le_card_mul
    (s : Finset ι) (hs : s.Nonempty)
    (U : ι → FinitePositiveRegion α μ)
    (V : FinitePositiveRegion α μ)
    (hEq : ∀ i ∈ s, μ (U i).carrier = μ V.carrier) :
    (μ (finsetUnionRegion s hs U).carrier).toReal ≤
      (s.card : ℝ) * (μ V.carrier).toReal := by
  have hmeasure :
      μ (finsetUnionRegion s hs U).carrier ≤
        ∑ i ∈ s, μ (U i).carrier := by
    exact measure_finset_iUnion_le_sum s fun i => (U i : Set α)
  have hreal := ENNReal.toReal_mono (measure_sum_ne_top s U) hmeasure
  rw [ENNReal.toReal_sum
    (fun i hi => (U i).measure_ne_top)] at hreal
  calc
    (μ (finsetUnionRegion s hs U).carrier).toReal ≤
        ∑ i ∈ s, (μ (U i).carrier).toReal := hreal
    _ = ∑ i ∈ s, (μ V.carrier).toReal := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [hEq i hi]
    _ = (s.card : ℝ) * (μ V.carrier).toReal := by
      simp

/-- Correct logarithmic replacement for false orbit-union volume equality. -/
theorem logVolume_finsetUnion_le_log_card_add
    (s : Finset ι) (hs : s.Nonempty)
    (U : ι → FinitePositiveRegion α μ)
    (V : FinitePositiveRegion α μ)
    (hEq : ∀ i ∈ s, μ (U i).carrier = μ V.carrier) :
    (finsetUnionRegion s hs U).logVolume ≤
      Real.log (s.card : ℝ) + V.logVolume := by
  have hcardNat : 0 < s.card := hs.card_pos
  have hcard : 0 < (s.card : ℝ) := by exact_mod_cast hcardNat
  have hunionPos := (finsetUnionRegion s hs U).measure_toReal_pos
  have hVPos := V.measure_toReal_pos
  have hreal :=
    toReal_measure_finsetUnion_le_card_mul s hs U V hEq
  have hlog := Real.log_le_log hunionPos hreal
  rw [FinitePositiveRegion.logVolume,
      FinitePositiveRegion.logVolume]
  calc
    Real.log (μ (finsetUnionRegion s hs U).carrier).toReal ≤
        Real.log ((s.card : ℝ) * (μ V.carrier).toReal) := hlog
    _ = Real.log (s.card : ℝ) + Real.log (μ V.carrier).toReal := by
      rw [Real.log_mul hcard.ne' hVPos.ne']

/-- A uniform finite orbit-size bound contributes only one fixed additive
logarithmic constant. -/
theorem logVolume_finsetUnion_le_of_card_le
    (s : Finset ι) (hs : s.Nonempty)
    (U : ι → FinitePositiveRegion α μ)
    (V : FinitePositiveRegion α μ)
    (hEq : ∀ i ∈ s, μ (U i).carrier = μ V.carrier)
    {B : ℕ} (hBpos : 0 < B) (hcard : s.card ≤ B) :
    (finsetUnionRegion s hs U).logVolume ≤
      Real.log (B : ℝ) + V.logVolume := by
  have hbase := logVolume_finsetUnion_le_log_card_add s hs U V hEq
  have hcardR : (s.card : ℝ) ≤ B := by exact_mod_cast hcard
  have hcardPos : 0 < (s.card : ℝ) := by exact_mod_cast hs.card_pos
  have hlogCard : Real.log (s.card : ℝ) ≤ Real.log (B : ℝ) :=
    Real.log_le_log hcardPos hcardR
  linarith

#print axioms measurable_finset_iUnion
#print axioms measure_finset_iUnion_le_sum
#print axioms finsetUnionRegion
#print axioms toReal_measure_finsetUnion_le_card_mul
#print axioms logVolume_finsetUnion_le_log_card_add
#print axioms logVolume_finsetUnion_le_of_card_le

end Ind2FiniteUnionOverhead
end IUTThreeClosures
