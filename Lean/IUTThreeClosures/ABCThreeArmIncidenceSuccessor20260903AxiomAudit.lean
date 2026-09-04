/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903

/-!
# Axiom audit for the three-arm incidence successor

Every public declaration in the companion module is queried exactly once.
The CT-3C proposition is printed as a definition; no inhabitant of it is
introduced.  Its negation is audited in the companion obstruction module.
-/

namespace IUTThreeClosures
namespace ABCThreeArmIncidenceSuccessor20260903

#print axioms Arm
#print axioms coordinate
#print axioms coordinate_pos
#print axioms Face

#print axioms Face.valuation
#print axioms Face.armRadical
#print axioms Face.armComplementRadical
#print axioms Face.armDefect
#print axioms Face.armModulus
#print axioms Face.selectedRadical
#print axioms Face.complementRadical
#print axioms Face.selectedDefect
#print axioms Face.selectedModulus
#print axioms Face.CoversEndpoint
#print axioms Face.StrictlyReconstructsEndpoint
#print axioms Face.prime_of_mem_support
#print axioms Face.valuation_pos_of_mem_support
#print axioms Face.armRadical_pos
#print axioms Face.armComplementRadical_pos
#print axioms Face.armDefect_pos
#print axioms Face.selectedRadical_pos
#print axioms Face.complementRadical_pos
#print axioms Face.selectedDefect_pos
#print axioms Face.armRadical_mul_armDefect
#print axioms Face.armModulus_dvd_coordinate
#print axioms Face.localIncidenceSignature
#print axioms Face.coprime_modulus_AB
#print axioms Face.coprime_modulus_AC
#print axioms Face.coprime_modulus_BC
#print axioms Face.eq_c_of_strictThreeArmReconstruction
#print axioms Face.selectedRadical_mul_selectedDefect
#print axioms Face.armRadical_mul_armComplementRadical
#print axioms Face.selectedRadical_mul_complementRadical
#print axioms Face.height_le_conductor_add_log_selectedDefect

#print axioms UniformRawThreeArmDefectBound
#print axioms abc_of_uniformRawThreeArmDefectBound
#print axioms SelectedPrimeToken
#print axioms SelectedExcessToken
#print axioms ComplementPrimeToken
#print axioms selectedExcessPrime
#print axioms complementPrime
#print axioms selectedExcessWeight
#print axioms complementPrimeWeight
#print axioms ComplementTransport
#print axioms selectedExcessPrime_prime
#print axioms complementPrime_prime
#print axioms zeroComplementTransport

#print axioms Face.log_armDefect_eq_weightSum
#print axioms Face.log_armComplementRadical_eq_weightSum
#print axioms Face.complementTransport_sourceMass_eq_log_selectedDefect
#print axioms Face.complementTransport_sinkMass_eq_log_complementRadical
#print axioms Face.log_selectedDefect_le_log_complementRadical_add_unmatchedMass
#print axioms Face.complementTransport_threshold_obstruction
#print axioms Face.height_le_conductor_add_complementTransport_unmatchedMass

#print axioms UniformThreeArmComplementTransportBound
#print axioms abc_of_uniformThreeArmComplementTransportBound
#print axioms two_le_factorization_square_of_mem_primeFactors
#print axioms pythagoreanSquare_coordinate
#print axioms pythagoreanSquare_valuation_ge_two
#print axioms Face.selectedRadical_le_selectedDefect_of_valuation_ge_two
#print axioms Face.selectedModulus_le_selectedDefect_sq_of_valuation_ge_two
#print axioms pythagoreanZ_le_selectedDefect_of_cover
#print axioms abcRadical_square_le_base
#print axioms pythagoreanSquare_totalRadical_le_z_cube
#print axioms not_uniformRawThreeArmDefectBound

end ABCThreeArmIncidenceSuccessor20260903
end IUTThreeClosures
