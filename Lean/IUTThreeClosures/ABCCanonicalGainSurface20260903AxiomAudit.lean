/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCCanonicalGainSurface20260903

/-! Axiom audit for the canonical gain-surface checkpoint. -/

namespace IUTThreeClosures
namespace ABCCanonicalGainSurface20260903

#print axioms canonicalProduct
#print axioms canonicalApproximationGain
#print axioms canonicalPowerGain
#print axioms canonicalPowerExcess
#print axioms canonicalApproximationSlack

#print axioms PrimitiveABC.one_lt_canonicalProduct
#print axioms PrimitiveABC.c_sq_lt_canonicalProduct
#print axioms PrimitiveABC.canonicalProduct_lt_c_cube
#print axioms PrimitiveABC.log_c_pos
#print axioms PrimitiveABC.log_canonicalProduct_pos
#print axioms PrimitiveABC.log_abcRadical_pos
#print axioms PrimitiveABC.two_log_c_lt_log_canonicalProduct
#print axioms PrimitiveABC.log_canonicalProduct_lt_three_log_c
#print axioms PrimitiveABC.standardQuality_eq_gainProduct
#print axioms PrimitiveABC.canonicalApproximationGain_lt_one_half
#print axioms PrimitiveABC.one_third_lt_canonicalApproximationGain
#print axioms PrimitiveABC.canonicalPowerGain_pos
#print axioms PrimitiveABC.standardQuality_lt_half_powerGain
#print axioms PrimitiveABC.one_third_powerGain_lt_standardQuality
#print axioms PrimitiveABC.powerGain_gt_two_mul_of_transgression
#print axioms PrimitiveABC.quality_lt_one_add_of_powerGain_le
#print axioms PrimitiveABC.standardQuality_eq_one_add_powerExcess_sub_slack
#print axioms PrimitiveABC.logarithmicABC_iff_defectBarrier

#print axioms AdditiveScaleCocycle
#print axioms endpointDifferenceCocycle
#print axioms endpointDifferenceCocycle_apply
#print axioms ratioTransition
#print axioms ratioTransition_self
#print axioms ratioTransition_comp

#print axioms defectFlagTotal
#print axioms defectFlagEndpoint
#print axioms defectFlagTotal_eq_endpoint_sub_base
#print axioms defectFlagBudget_iff_heightBound
#print axioms defectFlagBudget_of_total_le_sum
#print axioms UniformDefectFlagBudget
#print axioms uniformDefectFlagBudget_iff_ABCConjecture
#print axioms independentGainBounds_do_not_force_threeHalves
#print axioms powerThreeCounterexample
#print axioms powerThreeCounterexample_product
#print axioms powerThreeCounterexample_radical
#print axioms powerThreeCounterexample_powerGain_gt_three

end ABCCanonicalGainSurface20260903
end IUTThreeClosures
