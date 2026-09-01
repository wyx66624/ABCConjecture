/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTFullGaloisWordLift20260830
import IUTThreeClosures.IUTThreeLabelMinimumLayer20260830
import IUTThreeClosures.Frey139Tate210Realization20260830
import IUTThreeClosures.SL2TransvectionGeneration20260830
import IUTThreeClosures.Frey43BalancedRealization20260830
import IUTThreeClosures.IUTGeneralTameSquareLabels20260830
import IUTThreeClosures.TraceDualPreidealHull20260831

/-! Dependency audit for the separately accepted Galois-lift continuation. -/

#print IUTThreeClosures.ABCConjecture

-- IUTFullGaloisWordLift20260830
section
open IUTThreeClosures.IUTFullGaloisWordLift20260830
#check forward_a
#print axioms forward_a
#check backward_a
#print axioms backward_a
#check forward_backward
#print axioms forward_backward
#check backward_forward
#print axioms backward_forward
#check forward_boundary
#print axioms forward_boundary
#check backward_boundary
#print axioms backward_boundary
#check map_forward
#print axioms map_forward
#check map_backward
#print axioms map_backward
#check map_boundary
#print axioms map_boundary
#check commutative_forward
#print axioms commutative_forward
#check abelian_image
#print axioms abelian_image
#check evaluate_map
#print axioms evaluate_map
#check evaluate_generators
#print axioms evaluate_generators
#check forwardHom_generators
#print axioms forwardHom_generators
#check backwardHom_generators
#print axioms backwardHom_generators
#check backwardHom_comp_forwardHom
#print axioms backwardHom_comp_forwardHom
#check forwardHom_comp_backwardHom
#print axioms forwardHom_comp_backwardHom
#check crossHandleAut_fixes_first
#print axioms crossHandleAut_fixes_first
#check crossHandleAut_fixes_boundary
#print axioms crossHandleAut_fixes_boundary
#check crossHandleAut_abelian_image
#print axioms crossHandleAut_abelian_image
end

-- IUTThreeLabelMinimumLayer20260830
section
open IUTThreeClosures.IUTThreeLabelMinimumLayer20260830
#check cross_comp
#print axioms cross_comp
#check central_comp
#print axioms central_comp
#check central_cross_comm
#print axioms central_cross_comm
#check central_zero
#print axioms central_zero
#check cross_zero
#print axioms cross_zero
#check central_corrected_cross_comp
#print axioms central_corrected_cross_comp
#check cross_neg_comp
#print axioms cross_neg_comp
#check cross_comp_neg
#print axioms cross_comp_neg
#check transvectionMap_apply
#print axioms transvectionMap_apply
#check transvection_preserves
#print axioms transvection_preserves
#check exists_outside_subspaces
#print axioms exists_outside_subspaces
#check exists_common_nonzero
#print axioms exists_common_nonzero
#check exists_common_nonzero_with_projection
#print axioms exists_common_nonzero_with_projection
#check exists_common_transvection_projection
#print axioms exists_common_transvection_projection
#check three_labels_common_transvection
#print axioms three_labels_common_transvection
end

-- Frey139Tate210Realization20260830
section
open IUTThreeClosures.Frey139Tate210Realization20260830
#check freyModel_equation
#print axioms freyModel_equation
#check freyModel_discriminant
#print axioms freyModel_discriminant
#check freyModel_c4
#print axioms freyModel_c4
#check firstCurve_discriminant
#print axioms firstCurve_discriminant
#check firstCurve_c4
#print axioms firstCurve_c4
#check firstCurve_j
#print axioms firstCurve_j
#check firstCurve_cubic_mod139
#print axioms firstCurve_cubic_mod139
#check firstCurve_tangent_cone
#print axioms firstCurve_tangent_cone
#check tangent_slopes_distinct
#print axioms tangent_slopes_distinct
#check firstCurve5_equation
#print axioms firstCurve5_equation
#check firstCurve5_affine_card
#print axioms firstCurve5_affine_card
#check firstCurve5_point_card
#print axioms firstCurve5_point_card
#check firstCurve5_count_trace
#print axioms firstCurve5_count_trace
#check first_frobenius_polynomial_no_root
#print axioms first_frobenius_polynomial_no_root
#check level_degree_bound_prime_to_seven
#print axioms level_degree_bound_prime_to_seven
#check local_210_numerics
#print axioms local_210_numerics
#check first_height_integer_certificate
#print axioms first_height_integer_certificate
#check log_window_of_integer_certificate
#print axioms log_window_of_integer_certificate
#check first_tate_height_window
#print axioms first_tate_height_window
#check directCurve_equation
#print axioms directCurve_equation
#check directCurve_discriminant
#print axioms directCurve_discriminant
#check directCurve_c4
#print axioms directCurve_c4
#check directCurve_j
#print axioms directCurve_j
#check directTriple_factorization
#print axioms directTriple_factorization
#check directCurve_cubic_mod139
#print axioms directCurve_cubic_mod139
#check directCurve_translated_tangent_cone
#print axioms directCurve_translated_tangent_cone
#check directCurve_discriminant_mod7_ne_zero
#print axioms directCurve_discriminant_mod7_ne_zero
#check directCurve5_equation
#print axioms directCurve5_equation
#check directCurve5_affine_card
#print axioms directCurve5_affine_card
#check directCurve5_point_card
#print axioms directCurve5_point_card
#check directCurve5_count_trace
#print axioms directCurve5_count_trace
#check direct_frobenius_polynomial_no_root
#print axioms direct_frobenius_polynomial_no_root
#check direct_height_integer_certificate
#print axioms direct_height_integer_certificate
#check direct_tate_height_window
#print axioms direct_tate_height_window
end

-- SL2TransvectionGeneration20260830
section
open IUTThreeClosures.SL2TransvectionGeneration20260830
#check transvection_nat_pow
#print axioms transvection_nat_pow
#check transvection_parameter_mem
#print axioms transvection_parameter_mem
#check subgroup_eq_top_of_upper_lower
#print axioms subgroup_eq_top_of_upper_lower
#check transvection_pow_prime
#print axioms transvection_pow_prime
#check hom_mem_of_upper_lower
#print axioms hom_mem_of_upper_lower
#check hom_range_le_of_upper_lower
#print axioms hom_range_le_of_upper_lower
#check toGL_mem_of_upper_lower
#print axioms toGL_mem_of_upper_lower
#check mem_normal_of_pow_eq_one_of_coprime_index
#print axioms mem_normal_of_pow_eq_one_of_coprime_index
#check hom_mem_normal_of_coprime_index
#print axioms hom_mem_normal_of_coprime_index
#check hom_range_le_normal_of_coprime_index
#print axioms hom_range_le_normal_of_coprime_index
#check normal_eq_top_of_coprime_index
#print axioms normal_eq_top_of_coprime_index
#check toGL_mem_normal_of_coprime_index
#print axioms toGL_mem_normal_of_coprime_index
end

-- Frey43BalancedRealization20260830
section
open IUTThreeClosures.Frey43BalancedRealization20260830
#check balancedA_pos
#print axioms balancedA_pos
#check endpoints_pos
#print axioms endpoints_pos
#check endpoints_sum
#print axioms endpoints_sum
#check endpoints_pairwise_coprime
#print axioms endpoints_pairwise_coprime
#check chosen_primes
#print axioms chosen_primes
#check balancedA_residues
#print axioms balancedA_residues
#check balancedA_at_1289
#print axioms balancedA_at_1289
#check balancedA_sandwich
#print axioms balancedA_sandwich
#check endpoints_lt_two_pow
#print axioms endpoints_lt_two_pow
#check endpointProduct_gcd_primorial
#print axioms endpointProduct_gcd_primorial
#check small_prime_support
#print axioms small_prime_support
#check small_prime_43_powers_not_dvd
#print axioms small_prime_43_powers_not_dvd
#check prime_power_dvd_endpoint
#print axioms prime_power_dvd_endpoint
#check prime_43_power_not_dvd
#print axioms prime_43_power_not_dvd
#check endpointProduct_factorization_lt
#print axioms endpointProduct_factorization_lt
#check level_degree_bound_prime_to_43
#print axioms level_degree_bound_prime_to_43
#check local_1290_numerics
#print axioms local_1290_numerics
#check balancedCurve_discriminant
#print axioms balancedCurve_discriminant
#check balancedCurve_c4
#print axioms balancedCurve_c4
#check balancedCurve5_eq_directCurve5
#print axioms balancedCurve5_eq_directCurve5
#check balancedCurve5_point_card
#print axioms balancedCurve5_point_card
#check balancedCurve_discriminant_mod43_ne_zero
#print axioms balancedCurve_discriminant_mod43_ne_zero
#check frobenius_polynomial_mod43_no_root
#print axioms frobenius_polynomial_mod43_no_root
#check normalizedTateBase_pos
#print axioms normalizedTateBase_pos
#check height_integer_certificates
#print axioms height_integer_certificates
#check normalized_tate_height_window
#print axioms normalized_tate_height_window
end

-- IUTGeneralTameSquareLabels20260830
section
open IUTThreeClosures.IUTGeneralTameSquareLabels20260830
#check two_halfLabels_add_one
#print axioms two_halfLabels_add_one
#check badIndexBudget_eq
#print axioms badIndexBudget_eq
#check badIndexBudget_lt
#print axioms badIndexBudget_lt
#check residue_card_gt_label_count
#print axioms residue_card_gt_label_count
#check exists_index_outside_bad
#print axioms exists_index_outside_bad
#check exceptional_half_label_unique
#print axioms exceptional_half_label_unique
#check prime_not_dvd_two_square
#print axioms prime_not_dvd_two_square
#check content_strict_sandwich
#print axioms content_strict_sandwich
#check wholeContent_add_one_le
#print axioms wholeContent_add_one_le
#check wholeExponent_eq_point_sub
#print axioms wholeExponent_eq_point_sub
#check pointExponent_le
#print axioms pointExponent_le
#check pointExponent_neg
#print axioms pointExponent_neg
#check wholeExponent_neg
#print axioms wholeExponent_neg
#check pointExponent_standard_scale
#print axioms pointExponent_standard_scale
#check wholeExponent_standard_scale
#print axioms wholeExponent_standard_scale
#check pointExponent_standard_pos
#print axioms pointExponent_standard_pos
#check wholeExponent_standard_pos
#print axioms wholeExponent_standard_pos
end

-- TraceDualPreidealHull20260831
section
open IUTThreeClosures.TraceDualPreidealHull20260831
#check mem_integralTraceDual
#print axioms mem_integralTraceDual
#check integralTraceDual_antitone
#print axioms integralTraceDual_antitone
#check integralTraceDual_prod
#print axioms integralTraceDual_prod
#check principalOrderIdeal_le_traceDual
#print axioms principalOrderIdeal_le_traceDual
#check principalOrderIdeal_le_scaled_traceDual
#print axioms principalOrderIdeal_le_scaled_traceDual
#check transportedOrderSpan_le
#print axioms transportedOrderSpan_le
end

-- IUTFullGaloisWordLift20260830
section
open IUTThreeClosures.IUTFullGaloisWordLift20260830
#check frameEquiv
#print axioms frameEquiv
#check crossHandleAut
#print axioms crossHandleAut
end

-- IUTThreeLabelMinimumLayer20260830
section
open IUTThreeClosures.IUTThreeLabelMinimumLayer20260830
#check crossEquiv
#print axioms crossEquiv
#check transvectionEquiv
#print axioms transvectionEquiv
end

-- Frey139Tate210Realization20260830
section
open IUTThreeClosures.Frey139Tate210Realization20260830
#check firstTriple
#print axioms firstTriple
#check firstCurve_isElliptic
#print axioms firstCurve_isElliptic
#check firstCurve5_isElliptic
#print axioms firstCurve5_isElliptic
#check directTriple
#print axioms directTriple
#check directCurve_isElliptic
#print axioms directCurve_isElliptic
#check directCurve5_isElliptic
#print axioms directCurve5_isElliptic
end

-- SL2TransvectionGeneration20260830
section
open IUTThreeClosures.SL2TransvectionGeneration20260830
#check upper
#print axioms upper
#check lower
#print axioms lower
end

-- Frey43BalancedRealization20260830
section
open IUTThreeClosures.Frey43BalancedRealization20260830
#check balancedTriple
#print axioms balancedTriple
#check balancedCurve_isElliptic
#print axioms balancedCurve_isElliptic
#check balancedCurve5_isElliptic
#print axioms balancedCurve5_isElliptic
end

-- IUTGeneralTameSquareLabels20260830
section
open IUTThreeClosures.IUTGeneralTameSquareLabels20260830
end

-- TraceDualPreidealHull20260831
section
open IUTThreeClosures.TraceDualPreidealHull20260831
end
