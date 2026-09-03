/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuadraticVeronesePeeling20260902

/-! One-for-one declaration-level axiom audit for quadratic Veronese peeling. -/

open IUTThreeClosures
open IUTThreeClosures.QuadraticVeronesePeeling20260902

#print axioms fiveTermAdmissible_square_iff
#print axioms quadratic_fiveTerm_arguments
#print axioms quadratic_auxiliary_cells_admissible
#print axioms complement_contact_reverses
#print axioms quadratic_contact_peeling
#print axioms valuationDivisor_sq
#print axioms valuationDivisor_mul
#print axioms quadraticTransform_contact
#print axioms sum_range_layer_indicator
#print axioms sum_valuationLayerMass_eq_exponentWeightedMass
#print axioms exponentWeightedMass_eq_firstLayer_add_higherLayers
#print axioms valuationLayerMass_double_odd
#print axioms valuationLayerMass_double_even
#print axioms fullContactArea_sum_layers
#print axioms fullContactArea_eq_valuationLayerPairs
#print axioms pythagoreanY_add_one_eq_Z
#print axioms pythagoreanY_add_Z_eq_X_sq
#print axioms quadraticTransform_consecutive_coordinates
#print axioms pythagoreanSquare_contact_peeling
#print axioms not_uniformPythagoreanSquareLayerCutoff
#print axioms peeledFullCost_eq_squareFullCost
#print axioms peeledCoherentCost_lt_half_squareCoherentCost
#print axioms peeledResidualCost_sub_squareResidualCost
#print axioms squareResidualCost_le_peeledResidualCost
#print axioms peeledCalibratedCost_eq_two_full_sub_residual
#print axioms peeledCalibratedCost_sub_boundaryTerm
#print axioms four_mul_u_v_le_boundaryExcess
#print axioms pythagoreanY_lt_Z
#print axioms pythagoreanZ_le_X_mul_Y
#print axioms xLog_nonneg
#print axioms yLog_pos
#print axioms zLog_pos
#print axioms yLog_le_zLog
#print axioms zLog_le_xLog_add_yLog
#print axioms two_mul_zLog_le_three_mul_yLog
#print axioms legHeight_mono
#print axioms legHeight_pow
#print axioms powerTwo_natural_corridor
#print axioms powerTwo_log_corridor
#print axioms natRadical_mul_le
#print axioms abcRadical_pythagoreanY_powTwo_le
#print axioms powerTwo_yLog_sub_radical_lower
#print axioms powerTwo_legHeight_unbounded
#print axioms xLog_unbounded
#print axioms four_mul_xLog_yLog_le_actualSquareFullCost
#print axioms not_fixedQuadraticPositiveAreaContraction
#print axioms actualPeeledResidualCost_nonneg
#print axioms actualPeeledCalibratedCost_eq_two_full_sub_residual
#print axioms actualPeeledCalibratedCost_le_two_full
#print axioms powerTwo_actualResidual_lower
#print axioms powerTwo_actualSquareFull_upper
#print axioms not_fixedOuterSquareResidualSubcriticality
#print axioms not_fixedQuadraticBoundaryGate
