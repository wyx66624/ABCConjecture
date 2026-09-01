import IUTThreeClosures.ABCStatement
import IUTThreeClosures.AnalyticActualRadicalUniformGate20260830
import IUTThreeClosures.GeometryGlobalUniformGate20260830
import IUTThreeClosures.IUTAdmissibleGaloisUniformGate20260830
import IUTThreeClosures.IUTTracePreservingTransvection20260830
import IUTThreeClosures.IUTAllOpenLatticeRigidity20260830

/-!
# Uniformity continuation: complete public-theorem audit

Every public theorem in the five new modules is printed with its full
type and kernel dependencies. Imported source theorems are not assumed
as new axioms. The standard ABC target is displayed, not proved.
-/

#print IUTThreeClosures.ABCConjecture

section
open IUTThreeClosures.AnalyticActualRadicalUniformGate20260830

#check @newPrimeRadical_pos
#print axioms newPrimeRadical_pos
#check @newPrimeRadical_dvd
#print axioms newPrimeRadical_dvd
#check @newPrimeRadical_coprime
#print axioms newPrimeRadical_coprime
#check @radical_mul_eq_newPrimeRadical
#print axioms radical_mul_eq_newPrimeRadical
#check @radical_mul_sq_eq_newPrimeRadical
#print axioms radical_mul_sq_eq_newPrimeRadical
#check @newPrimeRadical_mul_primeExcess
#print axioms newPrimeRadical_mul_primeExcess
#check @primeExcess_pos
#print axioms primeExcess_pos
#check @square_completion_radical_eq_newPrimeRadical
#print axioms square_completion_radical_eq_newPrimeRadical
#check @square_completion_retains_seed_radical
#print axioms square_completion_retains_seed_radical
#check @square_completion_radical_mul_excess
#print axioms square_completion_radical_mul_excess
#check @square_completion_actual_excess_budget
#print axioms square_completion_actual_excess_budget
#check @bbltExponent_pos
#print axioms bbltExponent_pos
#check @bbltExponent_ge_half
#print axioms bbltExponent_ge_half
#check @bbltExponent_eq_two_thirds
#print axioms bbltExponent_eq_two_thirds
#check @actual_conic_exponent_window
#print axioms actual_conic_exponent_window
#check @actual_conic_min_exponent_le
#print axioms actual_conic_min_exponent_le
#check @rational_completion_support_loss_coordinates
#print axioms rational_completion_support_loss_coordinates
#check @quadratic_quality_separator_powers
#print axioms quadratic_quality_separator_powers

end

section
open IUTThreeClosures.GeometryGlobalUniformGate

#check @cubeBase_pos
#print axioms cubeBase_pos
#check @cubeBase_cube_dvd
#print axioms cubeBase_cube_dvd
#check @cube_decomposition
#print axioms cube_decomposition
#check @cubeCoefficient_pos
#print axioms cubeCoefficient_pos
#check @cubeBase_dvd
#print axioms cubeBase_dvd
#check @cubeCoefficient_dvd
#print axioms cubeCoefficient_dvd
#check @cubeCoefficient_factorization
#print axioms cubeCoefficient_factorization
#check @pair_decomposition
#print axioms pair_decomposition
#check @pairCoefficient_pos
#print axioms pairCoefficient_pos
#check @pairX_cube
#print axioms pairX_cube
#check @pairX_pos
#print axioms pairX_pos
#check @pair_mordell_difference
#print axioms pair_mordell_difference
#check @pair_mordell_sum
#print axioms pair_mordell_sum
#check @mordell_omit_a
#print axioms mordell_omit_a
#check @mordell_omit_b
#print axioms mordell_omit_b
#check @mordell_omit_c
#print axioms mordell_omit_c
#check @selected_pair_height
#print axioms selected_pair_height
#check @all_three_points_retain_height
#print axioms all_three_points_retain_height
#check @trace_matrix_determinant
#print axioms trace_matrix_determinant
#check @plus_order_matrix_determinant
#print axioms plus_order_matrix_determinant
#check @minus_order_matrix_determinant
#print axioms minus_order_matrix_determinant
#check @radical_factorization
#print axioms radical_factorization
#check @radical_mul_cube
#print axioms radical_mul_cube
#check @three_cost_radical_product
#print axioms three_cost_radical_product
#check @coefficientProduct_pos
#print axioms coefficientProduct_pos
#check @baseProduct_pos
#print axioms baseProduct_pos
#check @abc_cube_decomposition
#print axioms abc_cube_decomposition
#check @costA_eq
#print axioms costA_eq
#check @costB_eq
#print axioms costB_eq
#check @costC_eq
#print axioms costC_eq
#check @actual_three_cost_product
#print axioms actual_three_cost_product
#check @truncatedTwo_factorization
#print axioms truncatedTwo_factorization
#check @radical_mul_square
#print axioms radical_mul_square
#check @truncated_mordell_parameter
#print axioms truncated_mordell_parameter
#check @cubic_root_cubes
#print axioms cubic_root_cubes
#check @cubic_plus_root
#print axioms cubic_plus_root
#check @cubic_minus_root
#print axioms cubic_minus_root
#check @cubic_plus_square_coordinates
#print axioms cubic_plus_square_coordinates
#check @cubic_minus_square_coordinates
#print axioms cubic_minus_square_coordinates
#check @scale_mordell
#print axioms scale_mordell
#check @parameterA_identity
#print axioms parameterA_identity
#check @parameterB_identity
#print axioms parameterB_identity
#check @parameterC_identity
#print axioms parameterC_identity
#check @common_curve_omit_a
#print axioms common_curve_omit_a
#check @common_curve_omit_b
#print axioms common_curve_omit_b
#check @common_curve_omit_c
#print axioms common_curve_omit_c
#check @cubeCoefficient_mul
#print axioms cubeCoefficient_mul
#check @coefficientProduct_eq_cubeCoefficient
#print axioms coefficientProduct_eq_cubeCoefficient
#check @prime_dvd_residualSupport_iff
#print axioms prime_dvd_residualSupport_iff
#check @cubeCoefficient_dvd_residualSupport_sq
#print axioms cubeCoefficient_dvd_residualSupport_sq
#check @coefficientProduct_le_residualSupport_sq
#print axioms coefficientProduct_le_residualSupport_sq
#check @auxiliary_isogeny_polynomial
#print axioms auxiliary_isogeny_polynomial
#check @auxiliary_isogeny_equation
#print axioms auxiliary_isogeny_equation

end

section
open IUTThreeClosures.IUTAdmissibleGaloisUniformGate20260830

#check @trace_zero_iff
#print axioms trace_zero_iff
#check @trace_kernel_comap
#print axioms trace_kernel_comap
#check @trace_transport_comp
#print axioms trace_transport_comp
#check @trace_addValuation
#print axioms trace_addValuation
#check @not_maps_of_trace_addValuation_ne
#print axioms not_maps_of_trace_addValuation_ne
#check @affine_traceDepth_injective
#print axioms affine_traceDepth_injective
#check @no_transport_between_affine_trace_depths
#print axioms no_transport_between_affine_trace_depths
#check @span_unitScalarOrbit
#print axioms span_unitScalarOrbit

end

section
open IUTThreeClosures.IUTTracePreservingTransvection20260830

#check @exists_dual_nonzero_pair
#print axioms exists_dual_nonzero_pair
#check @exists_dual_nonzero_when_nonzero
#print axioms exists_dual_nonzero_when_nonzero
#check @exists_scalar_avoiding_two_affine
#print axioms exists_scalar_avoiding_two_affine
#check @exists_trace_preserving_common_avoidance
#print axioms exists_trace_preserving_common_avoidance

end

section
open IUTThreeClosures.IUTAllOpenLatticeRigidity20260830

#check @off_diagonal_eq_zero
#print axioms off_diagonal_eq_zero
#check @diagonal_eq
#print axioms diagonal_eq
#check @exists_scalar_of_line_neighborhoods
#print axioms exists_scalar_of_line_neighborhoods
#check @exists_unit_scalar_of_line_neighborhoods
#print axioms exists_unit_scalar_of_line_neighborhoods
#check @padic_eq_zero_of_all_power_dvd
#print axioms padic_eq_zero_of_all_power_dvd
#check @padic_exists_unit_scalar
#print axioms padic_exists_unit_scalar

end
