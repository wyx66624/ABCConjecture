/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCThreeArmComplementTransportObstruction20260903

/-!
# Axiom audit for the ordered prime-transport obstruction

Every public declaration in the companion module is queried exactly once.
In particular, the two final declarations are negations of the former EPF
and CT-3C gates; no inhabitant of either gate is introduced.
-/

namespace IUTThreeClosures
namespace ABCThreeArmComplementTransportObstruction20260903

#print axioms primeSquareEndpointPoint
#print axioms primeSquareEndpointPoint_a
#print axioms primeSquareEndpointPoint_b
#print axioms primeSquareEndpointPoint_c
#print axioms primeDivisor_sq_sub_one_lt

#print axioms selectedDefectTailLog
#print axioms complementRadicalTailLog
#print axioms selectedRadicalTailLog
#print axioms selectedFullModulusTailLog
#print axioms totalRadicalTailLog
#print axioms complementTransport_sourceTailMass_eq_selectedDefectTailLog
#print axioms complementTransport_sinkTailMass_eq_complementRadicalTailLog
#print axioms selectedDefectTailLog_add_selectedRadicalTailLog
#print axioms selectedRadicalTailLog_add_complementRadicalTailLog
#print axioms complementTransport_tailDeficit_eq_fullModulus_sub_totalRadical

#print axioms primeSquareEndpoint_c_primeFactors
#print axioms primeSquareEndpoint_c_factorization
#print axioms primeSquareEndpointExcessToken
#print axioms primeSquareEndpointExcessToken_prime
#print axioms primeSquareEndpointExcessToken_weight
#print axioms primeSquareEndpoint_sinkPrime_lt
#print axioms primeSquareEndpoint_endpointSinkTail_eq_zero
#print axioms primeSquareEndpoint_log_p_le_endpointSourceTail
#print axioms primeSquareEndpoint_log_p_le_endpointUnmatched
#print axioms primeSquareEndpoint_totalRadical_le_cube
#print axioms primeSquareEndpoint_conductor_le_three_log
#print axioms not_uniformEndpointPrimeFlowBound

#print axioms primeSquareEndpoint_p_mem_C_of_cover
#print axioms primeSquareEndpoint_face_C_valuation
#print axioms primeSquareFaceExcessToken
#print axioms primeSquareFaceExcessToken_prime
#print axioms primeSquareFaceExcessToken_weight
#print axioms primeSquareFace_complementPrime_lt
#print axioms primeSquareFace_sinkTail_eq_zero
#print axioms primeSquareFace_log_p_le_sourceTail
#print axioms primeSquareFace_log_p_le_unmatched
#print axioms not_uniformThreeArmComplementTransportBound

end ABCThreeArmComplementTransportObstruction20260903
end IUTThreeClosures
