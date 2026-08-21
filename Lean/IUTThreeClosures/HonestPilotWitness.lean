import IUTThreeClosures.HonestFinitePositiveLogVolume

/-!
# Honest pilot witnesses

The numerical core of Corollary 3.12 needs only two finite-positive measured
regions: a distinguished native q-pilot output and a theta-pilot region that
contains it.  Their logarithmic volumes are canonical measure-derived values.

This module proves the monotonicity step without a total real-valued volume on
arbitrary sets.  It is the consistent replacement for the public witness
layer while the full local-field packet construction is being formalized.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u

/-- A measure-derived pilot witness. -/
structure HonestPilotWitness
    (α : Type u) [MeasurableSpace α] (μ : Measure α) where
  native : FinitePositiveRegion α μ
  theta : FinitePositiveRegion α μ
  native_le_theta : (native : Set α) ⊆ theta
  qLHS : ℝ
  nativeVolume : native.logVolume = qLHS

namespace HonestPilotWitness

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- The honest witness proves the numerical pilot inequality. -/
theorem qLHS_le_thetaVolume (W : HonestPilotWitness α μ) :
    W.qLHS ≤ W.theta.logVolume := by
  rw [← W.nativeVolume]
  exact W.native.logVolume_mono W.native_le_theta

end HonestPilotWitness

/-- Capsule-indexed honest witnesses.  The average is defined directly from
canonical log-volumes, so procession monotonicity is a theorem rather than a
field. -/
structure HonestProcessionWitness
    (I : Type*) [Fintype I]
    (α : I → Type u)
    [∀ i, MeasurableSpace (α i)]
    (μ : ∀ i, Measure (α i)) where
  native : ∀ i, FinitePositiveRegion (α i) (μ i)
  theta : ∀ i, FinitePositiveRegion (α i) (μ i)
  native_le_theta : ∀ i, (native i : Set (α i)) ⊆ theta i
  qLHS : ℝ
  nativeAverage :
    (∑ i, (native i).logVolume) / Fintype.card I = qLHS

namespace HonestProcessionWitness

open scoped BigOperators

variable {I : Type*} [Fintype I]
variable {α : I → Type u} [∀ i, MeasurableSpace (α i)]
variable {μ : ∀ i, Measure (α i)}

/-- Average theta log-volume. -/
noncomputable def thetaAverage
    (W : HonestProcessionWitness I α μ) : ℝ :=
  (∑ i, (W.theta i).logVolume) / Fintype.card I

/-- The native average is bounded by the theta average. -/
theorem qLHS_le_thetaAverage
    (W : HonestProcessionWitness I α μ) :
    W.qLHS ≤ W.thetaAverage := by
  rw [← W.nativeAverage, thetaAverage]
  by_cases hI : Fintype.card I = 0
  · simp [hI]
  · have hpos : (0 : ℝ) < Fintype.card I := by
      exact_mod_cast Nat.pos_of_ne_zero hI
    apply (div_le_div_iff_of_pos_right hpos).2
    apply Finset.sum_le_sum
    intro i hi
    exact (W.native i).logVolume_mono (W.native_le_theta i)

end HonestProcessionWitness

end IUTThreeClosures