import Mathlib

namespace IUTThreeClosures

/-- The scalar last step of IUT IV Theorem 1.10. -/
theorem q_bound_of_coefficient_expression
    {factor A q CTheta : ℝ}
    (hfactor : 0 < factor)
    (hCTheta : -1 ≤ CTheta)
    (hformula : CTheta = factor * (A - q / 6) - 1) :
    q / 6 ≤ A := by
  rw [hformula] at hCTheta
  nlinarith

end IUTThreeClosures
