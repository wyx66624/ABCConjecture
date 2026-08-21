import IUTThreeClosures.HonestFinitePositiveLogVolume
import Mathlib.MeasureTheory.Constructions.Pi

/-!
# Finite product regions and additive logarithmic volume

For a finite family of sigma-finite measures, the product measure of a
measurable rectangle is the product of its coordinate measures. On the
finite-positive domain this implies that logarithmic volume is exactly
additive:

`logVol (∏ i, U i) = ∑ i, logVol (U i)`.

This is the measure-theoretic local theorem required by the multiradial packet
route. It replaces a freely supplied component-volume formula by the genuine
Jacobian-one formula for rectangular tensor regions. Identifying the actual
theta/Kummer output region with such a rectangle, or with a controlled image
of one, remains a separate geometric step.
-/

namespace IUTThreeClosures

open MeasureTheory Set
open scoped BigOperators ENNReal

universe u v

variable {ι : Type v} [Fintype ι]
variable {α : ι → Type u}
variable [∀ i, MeasurableSpace (α i)]
variable (μ : ∀ i, Measure (α i)) [∀ i, SigmaFinite (μ i)]

/-- The finite-positive rectangular region in the finite product measure. -/
noncomputable def FinitePositiveRegion.pi
    (U : ∀ i, FinitePositiveRegion (α i) (μ i)) :
    FinitePositiveRegion (∀ i, α i) (Measure.pi μ) where
  carrier := Set.pi Set.univ fun i => (U i : Set (α i))
  measurable :=
    MeasurableSet.pi countable_univ fun i _ => (U i).measurable
  measure_ne_zero := by
    rw [Measure.pi_pi]
    apply Finset.prod_ne_zero_iff.mpr
    intro i hi
    exact (U i).measure_ne_zero
  measure_ne_top := by
    rw [Measure.pi_pi]
    exact ENNReal.prod_ne_top fun i _ => (U i).measure_ne_top

namespace FinitePositiveRegion

variable {μ}

@[simp]
theorem coe_pi
    (U : ∀ i, FinitePositiveRegion (α i) (μ i)) :
    ((FinitePositiveRegion.pi μ U :
      FinitePositiveRegion (∀ i, α i) (Measure.pi μ)) :
        Set (∀ i, α i)) =
      Set.pi Set.univ fun i => (U i : Set (α i)) := rfl

/-- Product-measure logarithmic volume is the sum of the coordinate
logarithmic volumes. -/
theorem logVolume_pi
    (U : ∀ i, FinitePositiveRegion (α i) (μ i)) :
    (FinitePositiveRegion.pi μ U).logVolume =
      ∑ i, (U i).logVolume := by
  calc
    (FinitePositiveRegion.pi μ U).logVolume =
        Real.log ((∏ i, μ i (U i : Set (α i))).toReal) := by
      simp [FinitePositiveRegion.logVolume, FinitePositiveRegion.pi,
        Measure.pi_pi]
    _ = Real.log (∏ i, (μ i (U i : Set (α i))).toReal) := by
      rw [ENNReal.toReal_prod]
    _ = ∑ i, Real.log ((μ i (U i : Set (α i))).toReal) := by
      rw [Real.log_prod]
      intro i hi
      exact (U i).measure_toReal_pos.ne'
    _ = ∑ i, (U i).logVolume := by
      simp only [FinitePositiveRegion.logVolume]

/-- A rectangular component therefore satisfies the exact labelwise component
formula with coefficient one at every label. -/
theorem logVolume_pi_eq_sum
    (U : ∀ i, FinitePositiveRegion (α i) (μ i)) :
    (FinitePositiveRegion.pi μ U).logVolume -
        ∑ i, (U i).logVolume = 0 := by
  rw [logVolume_pi]
  ring

end FinitePositiveRegion

end IUTThreeClosures
