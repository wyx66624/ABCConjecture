import IUTThreeClosures.BarycentricPacketReading
import IUTThreeClosures.StandardZeroLabel

/-!
# A zero-label allocation is barycentric
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v
variable {L : Type u} {V : Type v}

noncomputable def pointMassCoefficient [DecidableEq L] (j₀ : L) : L → ℝ :=
  fun j => if j = j₀ then 1 else 0

@[simp]
theorem sum_pointMassCoefficient
    [Fintype L] [DecidableEq L] (j₀ : L) :
    ∑ j, pointMassCoefficient j₀ j = 1 := by
  simp [pointMassCoefficient]

/-- Product packet weights collapse a zero-label allocation to the ordinary
weighted place reading. -/
theorem product_weight_pointMass
    [Fintype L] [DecidableEq L] [Fintype V] [DecidableEq V]
    (j₀ : L) (weight value : V → ℝ)
    (hweight : ∑ v, weight v = 1) :
    (∑ c : L → V,
        (∏ j, weight (c j)) *
          (∑ j, pointMassCoefficient j₀ j * value (c j))) =
      ∑ v, weight v * value v := by
  exact product_weight_barycentric_of_sum_one
    (pointMassCoefficient j₀) weight value
    (sum_pointMassCoefficient j₀) hweight

end IUTThreeClosures
