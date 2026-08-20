import Mathlib

/-!
# Ramification obstruction for a local-degree weighted integer order

If an integer Tate order is normalized by a uniformizer, the arithmetic-divisor
contribution is proportional to the residue degree `f`, not the local degree
`e*f`. Equality of the two positive local contributions forces ramification
index `e = 1`.
-/

namespace IUTThreeClosures

noncomputable def arithmeticLocalContribution
    (n f d logp : ℝ) : ℝ :=
  (f / d) * n * logp

noncomputable def documentedLocalDegreeContribution
    (n e f d logp : ℝ) : ℝ :=
  (e * f / d) * n * logp

/-- If the positive arithmetic and local-degree weighted contributions agree,
the ramification index must be one. -/
theorem equality_forces_unramified
    {n e f d logp : ℝ}
    (hn : 0 < n) (hf : 0 < f) (hd : 0 < d) (hlogp : 0 < logp)
    (hEq : documentedLocalDegreeContribution n e f d logp =
      arithmeticLocalContribution n f d logp) :
    e = 1 := by
  have hbase : 0 < arithmeticLocalContribution n f d logp := by
    exact mul_pos (mul_pos (div_pos hf hd) hn) hlogp
  unfold documentedLocalDegreeContribution arithmeticLocalContribution at hEq
  have hfactor :
      (e * f / d) * n * logp =
        e * ((f / d) * n * logp) := by ring
  rw [hfactor] at hEq
  unfold arithmeticLocalContribution at hbase
  nlinarith

/-- At a genuinely ramified positive place, the documented local-degree
weighted integer-order term cannot equal normalized arithmetic degree. -/
theorem ramified_terms_ne
    {n e f d logp : ℝ}
    (hn : 0 < n) (he : 1 < e) (hf : 0 < f)
    (hd : 0 < d) (hlogp : 0 < logp) :
    documentedLocalDegreeContribution n e f d logp ≠
      arithmeticLocalContribution n f d logp := by
  intro h
  have := equality_forces_unramified hn hf hd hlogp h
  linarith

/-- Concrete factor-two counterexample. -/
theorem ramification_two_obstruction :
    documentedLocalDegreeContribution 1 2 1 1 (Real.log 2) ≠
      arithmeticLocalContribution 1 1 1 (Real.log 2) := by
  apply ramified_terms_ne
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · exact Real.log_pos (by norm_num)

end IUTThreeClosures
