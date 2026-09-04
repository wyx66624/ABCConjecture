import IUTThreeClosures.ABCPrimePacketBoundaryLinnikObstruction20260903

/-!
# Axiom audit: Linnik obstruction to exclusive endpoint packets

Compile this file directly with `-DwarningAsError=true`.  The inventory is
one-for-one with every public `def` and `theorem` in the implementation
module.  `LinnikPrimeNeighborEscape` is printed as a proposition and is never
installed as an axiom.
-/

open IUTThreeClosures
open ABCPrimePacketBoundaryLinnikObstruction20260903

#print axioms PrimePacketAssignment.clippedReward
#print axioms PrimePacketAssignment.packetResidual_eq_source_sub_min
#print axioms PrimePacketAssignment.totalResidual_eq_sourceMass_sub_clippedReward
#print axioms PrimePacketAssignment.packetMass_eq_of_unique_sink
#print axioms PrimePacketAssignment.sum_sub_cap_le_totalResidual_of_unique_sink

#print axioms primeNeighborPoint
#print axioms primeNeighborPoint_a
#print axioms primeNeighborPoint_b
#print axioms primeNeighborPoint_c
#print axioms primeNeighborPoint_positive
#print axioms primeNeighborPoint_pairwise_coprime
#print axioms primeNeighborPoint_endpoint_even
#print axioms primeNeighborSinkToken
#print axioms primeNeighborSinkToken_unique

#print axioms finitePrimeProduct
#print axioms primeSquare_dvd_finitePrimeProduct_sq
#print axioms primeSquare_dvd_endpoint_of_product_sq_dvd
#print axioms forcedEndpointToken
#print axioms forcedEndpointTokenEmbedding
#print axioms log_prime_le_forcedEndpointToken_weight
#print axioms forcedPrimeLogSum_sub_cap_le_packetResidual

#print axioms primeNeighbor_totalRadical_le_product
#print axioms primeNeighbor_conductor_le_two_log_succ
#print axioms primeNeighbor_height_le_conductor_of_ne_two
#print axioms primeNeighbor_positive_height_defect_eq_zero

#print axioms LinnikPrimeNeighborEscape
#print axioms not_uniformEndpointPrimePacketBound_of_linnikEscape
