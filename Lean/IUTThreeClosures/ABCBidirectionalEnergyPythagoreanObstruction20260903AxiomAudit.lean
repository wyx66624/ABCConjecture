import IUTThreeClosures.ABCBidirectionalEnergyPythagoreanObstruction20260903

/-!
# Axiom audit: prime-hypotenuse obstruction to bidirectional energy

Compile this file directly with `-DwarningAsError=true`.  The inventory is
one-for-one with every public `structure`, `def`, and `theorem` in the
implementation module.  In particular it audits the complete-premise
negation of `UniformBidirectionalEndpointEnergyBound`.
-/

open IUTThreeClosures
open ABCBidirectionalEnergyPythagoreanObstruction20260903
open PrimeHypotenuseDatum

#print axioms PrimeHypotenuseDatum
#print axioms twoSquare_left_pos
#print axioms twoSquare_right_pos
#print axioms twoSquare_coprime
#print axioms twoSquare_oppositeParity
#print axioms primeHypotenuseDatum_exists
#print axioms exists_primeHypotenuseDatum_gt

#print axioms PrimeHypotenuseDatum.X
#print axioms PrimeHypotenuseDatum.Y
#print axioms PrimeHypotenuseDatum.m_pos
#print axioms PrimeHypotenuseDatum.n_sq_lt_m_sq
#print axioms PrimeHypotenuseDatum.X_pos
#print axioms PrimeHypotenuseDatum.Y_pos
#print axioms PrimeHypotenuseDatum.p_pos
#print axioms PrimeHypotenuseDatum.p_ne_two
#print axioms PrimeHypotenuseDatum.four_le_p
#print axioms PrimeHypotenuseDatum.X_odd
#print axioms PrimeHypotenuseDatum.X_coprime_Y
#print axioms PrimeHypotenuseDatum.pythagorean_identity
#print axioms PrimeHypotenuseDatum.square_point_pairwise
#print axioms PrimeHypotenuseDatum.point
#print axioms PrimeHypotenuseDatum.point_a
#print axioms PrimeHypotenuseDatum.point_b
#print axioms PrimeHypotenuseDatum.point_c
#print axioms PrimeHypotenuseDatum.X_factorization
#print axioms PrimeHypotenuseDatum.X_le_p
#print axioms PrimeHypotenuseDatum.Y_le_p
#print axioms PrimeHypotenuseDatum.endpointSinkPrime_dvd_X_or_Y
#print axioms PrimeHypotenuseDatum.endpointSinkPrime_le_m_add_n
#print axioms PrimeHypotenuseDatum.m_add_n_sq_le_two_mul_p
#print axioms PrimeHypotenuseDatum.endpointSinkPrime_fourth_le_p_cube
#print axioms PrimeHypotenuseDatum.endpointSourcePrime_eq_p
#print axioms PrimeHypotenuseDatum.point_endpointCore_eq_p
#print axioms PrimeHypotenuseDatum.four_log_endpointSinkPrime_le_three_log_p
#print axioms PrimeHypotenuseDatum.quarter_le_endpoint_relativeLogDrop
#print axioms PrimeHypotenuseDatum.quarter_mul_carriedMass_le_endpointDownwardCost
#print axioms PrimeHypotenuseDatum.quarter_log_p_le_endpointBidirectionalEnergy
#print axioms PrimeHypotenuseDatum.point_totalRadical_le_p_cube
#print axioms PrimeHypotenuseDatum.point_conductor_le_three_log_p

#print axioms not_uniformBidirectionalEndpointEnergyBound
