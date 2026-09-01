/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCTwoPrimeSupport20260831
import IUTThreeClosures.TraceCovariantRationalReturn20260831
import IUTThreeClosures.ABCOddPartFibre20260831
import IUTThreeClosures.FreyEntireIsogenyArithmetic20260831
import IUTThreeClosures.FreyIsogenyWeilHeight20260831

/-! Types and kernel dependency reports for this separately scoped continuation.
This file supplies no proof of ABCConjecture or its negation. -/

#print IUTThreeClosures.ABCConjecture

-- ABCTwoPrimeSupport20260831
section
open IUTThreeClosures.ABCTwoPrimeSupport20260831
#check primeFactors_card_mul_three
#print axioms primeFactors_card_mul_three
#check one_addend_eq_one
#print axioms one_addend_eq_one
#check two_prime_powers_of_small_support
#print axioms two_prime_powers_of_small_support
#check int_eq_one_or_neg_one_of_dvd_two_pow
#print axioms int_eq_one_or_neg_one_of_dvd_two_pow
#check odd_geometric_gap_eq_base_gap
#print axioms odd_geometric_gap_eq_base_gap
#check odd_exponent_eq_one_of_pow_add_one
#print axioms odd_exponent_eq_one_of_pow_add_one
#check odd_exponent_eq_one_of_pow_eq_two_pow_add_one
#print axioms odd_exponent_eq_one_of_pow_eq_two_pow_add_one
#check odd_square_add_one_ne_two_pow
#print axioms odd_square_add_one_ne_two_pow
#check two_pow_add_two_eq_two_pow
#print axioms two_pow_add_two_eq_two_pow
#check even_exponent_exception
#print axioms even_exponent_exception
#check exponent_eq_one_of_prime_pow_add_one
#print axioms exponent_eq_one_of_prime_pow_add_one
#check exponent_eq_one_or_eight_nine
#print axioms exponent_eq_one_or_eight_nine
#check power_two_and_odd_prime_power
#print axioms power_two_and_odd_prime_power
#check radical_two_prime_powers
#print axioms radical_two_prime_powers
#check radical_seventy_two
#print axioms radical_seventy_two
#check one_addend_bound_or_exception
#print axioms one_addend_bound_or_exception
#check radical_bound_or_exception
#print axioms radical_bound_or_exception
#check c_le_radical_of_not_exception
#print axioms c_le_radical_of_not_exception
#check two_mul_c_le_three_mul_radical
#print axioms two_mul_c_le_three_mul_radical
#check two_mul_c_eq_three_mul_radical_iff
#print axioms two_mul_c_eq_three_mul_radical_iff
#check pairwise_coprime_of_add
#print axioms pairwise_coprime_of_add
#check two_mul_c_le_three_mul_radical_of_coprime
#print axioms two_mul_c_le_three_mul_radical_of_coprime
end

-- TraceCovariantRationalReturn20260831
section
open IUTThreeClosures.TraceCovariantRationalReturn20260831
#check scalar_return_trace_balance
#print axioms scalar_return_trace_balance
#check scalar_return_of_equal_finrank
#print axioms scalar_return_of_equal_finrank
#check map_one_of_nonzero_scalar_return
#print axioms map_one_of_nonzero_scalar_return
#check scalar_line_of_nonzero_return
#print axioms scalar_line_of_nonzero_return
#check exists_nonzero_return_iff_scalar_line
#print axioms exists_nonzero_return_iff_scalar_line
#check scalar_return_addValuation
#print axioms scalar_return_addValuation
#check no_scalar_return_of_addValuation_ne
#print axioms no_scalar_return_of_addValuation_ne
end

-- ABCOddPartFibre20260831
section
open IUTThreeClosures.ABCOddPartFibre20260831
#check oddPart_le
#print axioms oddPart_le
#check oddPart_eq_self_of_odd
#print axioms oddPart_eq_self_of_odd
#check oddPart_lt_self_of_even
#print axioms oddPart_lt_self_of_even
#check point_eq_of_coordinates
#print axioms point_eq_of_coordinates
#check parity_cases
#print axioms parity_cases
#check sameOddParts_symm
#print axioms sameOddParts_symm
#check eq_of_sameOddParts_even_a
#print axioms eq_of_sameOddParts_even_a
#check eq_of_sameOddParts_even_b
#print axioms eq_of_sameOddParts_even_b
#check eq_of_sameOddParts_even_c
#print axioms eq_of_sameOddParts_even_c
#check not_sameOddParts_even_b_even_c
#print axioms not_sameOddParts_even_b_even_c
#check eq_of_sameOddParts_mod_a
#print axioms eq_of_sameOddParts_mod_a
#check parityMap_injective
#print axioms parityMap_injective
#check fibre_card_le_two
#print axioms fibre_card_le_two
#check exampleP_oddParts
#print axioms exampleP_oddParts
#check exampleQ_oddParts
#print axioms exampleQ_oddParts
#check exampleP_ne_exampleQ
#print axioms exampleP_ne_exampleQ
#check fibre_one_three_seven_classification
#print axioms fibre_one_three_seven_classification
#check fibre_one_three_seven_card
#print axioms fibre_one_three_seven_card

-- Actual proof-bearing definitions and instances, including the two local prime Facts.
#check parityMap
#print axioms parityMap
#check fibreFinite
#print axioms fibreFinite
#check exampleP
#print axioms exampleP
#check exampleQ
#print axioms exampleQ
end

-- FreyEntireIsogenyArithmetic20260831
section
open IUTThreeClosures.FreyEntireIsogenyArithmetic20260831
#check endpointC_strictMono
#print axioms endpointC_strictMono
#check endpointC_ge_two
#print axioms endpointC_ge_two
#check endpointC_ge_1794
#print axioms endpointC_ge_1794
#check endpointC_mod_eight
#print axioms endpointC_mod_eight
#check endpointC_cast_mod_seven
#print axioms endpointC_cast_mod_seven
#check model_map
#print axioms model_map
#check model_c4
#print axioms model_c4
#check model_discriminant
#print axioms model_discriminant
#check familyCurve_eq_canonical
#print axioms familyCurve_eq_canonical
#check residueCurve_discriminant
#print axioms residueCurve_discriminant
#check canonical_reduction_seven
#print axioms canonical_reduction_seven
#check residueCurve_equation
#print axioms residueCurve_equation
#check residueCurve_affine_card
#print axioms residueCurve_affine_card
#check residueCurve_point_card
#print axioms residueCurve_point_card
#check residueCurve_count_trace
#print axioms residueCurve_count_trace
#check degree_three_polynomial_no_root
#print axioms degree_three_polynomial_no_root
#check model_discriminant_abs
#print axioms model_discriminant_abs
#check model_discriminant_upper
#print axioms model_discriminant_upper
#check model_c4_lower
#print axioms model_c4_lower
#check model_discriminant_ne_zero
#print axioms model_discriminant_ne_zero
#check familyCurve_abs_j
#print axioms familyCurve_abs_j
#check familyCurve_j_lower
#print axioms familyCurve_j_lower
#check zeroKernel_j_upper
#print axioms zeroKernel_j_upper

-- Actual proof-bearing definitions and instances, including the two local prime Facts.
#check prime3
#print axioms prime3
#check prime7
#print axioms prime7
#check familyTriple
#print axioms familyTriple
#check residueCurve_isElliptic
#print axioms residueCurve_isElliptic
#check familyCurve_isElliptic
#print axioms familyCurve_isElliptic
end

-- FreyIsogenyWeilHeight20260831
section
open IUTThreeClosures.FreyIsogenyWeilHeight20260831
#check endpoint_eq_two_half
#print axioms endpoint_eq_two_half
#check halfEndpoint_pos
#print axioms halfEndpoint_pos
#check reducedDenominator_pos
#print axioms reducedDenominator_pos
#check two_coprime_halfEndpoint
#print axioms two_coprime_halfEndpoint
#check two_coprime_endpoint_sub_one
#print axioms two_coprime_endpoint_sub_one
#check corePolynomial_coprime_halfEndpoint
#print axioms corePolynomial_coprime_halfEndpoint
#check corePolynomial_coprime_endpoint_sub_one
#print axioms corePolynomial_coprime_endpoint_sub_one
#check reduced_coprime
#print axioms reduced_coprime
#check familyCurve_j_eq_reduced
#print axioms familyCurve_j_eq_reduced
#check familyCurve_j_num
#print axioms familyCurve_j_num
#check familyCurve_j_den
#print axioms familyCurve_j_den
#check familyCurve_den_le_num_natAbs
#print axioms familyCurve_den_le_num_natAbs
#check familyCurve_mulHeight_eq_abs_reducedNumerator
#print axioms familyCurve_mulHeight_eq_abs_reducedNumerator
#check corePolynomial_pos
#print axioms corePolynomial_pos
#check zeroKernel_corePolynomial_lt
#print axioms zeroKernel_corePolynomial_lt
#check familyCurve_mulHeight
#print axioms familyCurve_mulHeight
#check familyCurve_logHeight
#print axioms familyCurve_logHeight
#check zeroKernel_mulHeight_lt
#print axioms zeroKernel_mulHeight_lt
#check zeroKernel_logHeight_lt
#print axioms zeroKernel_logHeight_lt
#check familyCurve_logHeight_isLeast
#print axioms familyCurve_logHeight_isLeast
#check familyCurve_mulHeight_isLeast
#print axioms familyCurve_mulHeight_isLeast
#check familyCurve_logHeight_eq_min_iff
#print axioms familyCurve_logHeight_eq_min_iff
#check familyCurve_normalizedLogHeight
#print axioms familyCurve_normalizedLogHeight
#check familyCurve_normalizedLogHeight_isLeast
#print axioms familyCurve_normalizedLogHeight_isLeast
#check familyCurve_normalizedLogHeight_eq_min_iff
#print axioms familyCurve_normalizedLogHeight_eq_min_iff
#check zeroKernel_corePolynomial_bounds
#print axioms zeroKernel_corePolynomial_bounds
#check zeroKernel_logHeight_bounds
#print axioms zeroKernel_logHeight_bounds
end
