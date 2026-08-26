import Mathlib

/-!
# Uniform Chebyshev Selmer exact residual: scalar audit

The companion note proves, using external accepted descent theory, an exact
dimension formula

`selmerDim = 2 + unitKernelDim + classKernelDim`.

This file checks only its elementary numerical consequences and the scalar
range behind the dimension-only no-go example.  It does not formalize
number fields, S-class groups, local Kummer maps, exact sequences, Jacobians,
Selmer groups, BSPT, Stoll, or the asserted dimension formula itself.
-/

namespace IUTThreeClosures

/-- Once the exact residual formula is supplied, a Selmer upper bound of two
is equivalent to the vanishing of both residual kernels. -/
theorem pellChebyshevSelmer_le_two_iff_residual_kernels_vanish
    (selmerDim unitKernelDim classKernelDim : ℕ)
    (hExact : selmerDim = 2 + unitKernelDim + classKernelDim) :
    selmerDim ≤ 2 ↔ unitKernelDim = 0 ∧ classKernelDim = 0 := by
  omega

/-- The same exact formula gives equality with two precisely when both
residual kernels vanish. -/
theorem pellChebyshevSelmer_eq_two_iff_residual_kernels_vanish
    (selmerDim unitKernelDim classKernelDim : ℕ)
    (hExact : selmerDim = 2 + unitKernelDim + classKernelDim) :
    selmerDim = 2 ↔ unitKernelDim = 0 ∧ classKernelDim = 0 := by
  omega

/-- A conditional BSPT injection disjoint from the two explicit classes
forces the pure-field 2-class rank to vanish if the Selmer dimension is at
most two. -/
theorem pellChebyshevClassRank_zero_of_bspt_lower_and_selmer_upper
    (selmerDim classRank : ℕ)
    (hBSPT : 2 + classRank ≤ selmerDim)
    (hUpper : selmerDim ≤ 2) :
    classRank = 0 := by
  omega

/-- For genus at least three, the same ambient, Lagrangian, and candidate
dimensions are numerically compatible with intersection dimensions `2` and
`g`; dimensions alone cannot select the desired one.  The companion note
constructs the actual subspaces. -/
theorem pellChebyshevLagrangian_dimension_data_do_not_choose_intersection
    (g : ℕ) (hg : 3 ≤ g) :
    2 < g ∧ 2 ≤ g ∧ g + 2 ≤ 2 * g := by
  omega

#print axioms pellChebyshevSelmer_le_two_iff_residual_kernels_vanish
#print axioms pellChebyshevSelmer_eq_two_iff_residual_kernels_vanish
#print axioms pellChebyshevClassRank_zero_of_bspt_lower_and_selmer_upper
#print axioms pellChebyshevLagrangian_dimension_data_do_not_choose_intersection

end IUTThreeClosures
