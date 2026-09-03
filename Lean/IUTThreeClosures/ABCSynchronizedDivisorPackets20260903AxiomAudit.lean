import IUTThreeClosures.ABCSynchronizedDivisorPackets20260903

/-!
# Axiom audit: synchronized divisor packets

Compile this file directly with `-DwarningAsError=true`.  The inventory covers
the exact finite algebraic/combinatorial layer and its real-log finite-spectrum
quality majorant.  No asymptotic radical-compression gate or uniform upper
bound for minimum packet energy is declared in the imported module.
-/

namespace IUTThreeClosures
namespace ABCSynchronizedDivisorPackets20260903AxiomAudit

open ABCSynchronizedDivisorPackets20260903

#print axioms PrimitiveABC.coprime_ac
#print axioms PrimitiveABC.coprime_bc
#print axioms PrimitiveABC.c_pos
#print axioms PrimitiveABC.a_lt_c
#print axioms PrimitiveABC.b_lt_c
#print axioms PrimitiveABC.c_lt_mul_ab

#print axioms squareGap_comm
#print axioms squareGap_pos
#print axioms squareGap_le_max_sq
#print axioms squareGap_of_le

#print axioms SynchronizedPacket.ext
#print axioms SynchronizedPacket.coprime_xy
#print axioms SynchronizedPacket.coprime_xz
#print axioms SynchronizedPacket.coprime_yz
#print axioms SynchronizedPacket.x_ne_y
#print axioms SynchronizedPacket.x_ne_z
#print axioms SynchronizedPacket.y_ne_z
#print axioms SynchronizedPacket.modulusProduct_dvd_gapProduct
#print axioms SynchronizedPacket.gapProduct_pos
#print axioms SynchronizedPacket.modulusProduct_le_gapProduct
#print axioms SynchronizedPacket.gapProduct_le_pairMaxBound
#print axioms SynchronizedPacket.pairMax_le_height
#print axioms SynchronizedPacket.pairMaxBound_le_height_pow_six
#print axioms SynchronizedPacket.modulusProduct_le_pairMaxBound
#print axioms SynchronizedPacket.modulusProduct_le_height_pow_six
#print axioms SynchronizedPacket.synchronizationIndex_pos
#print axioms SynchronizedPacket.modulusProduct_mul_synchronizationIndex
#print axioms SynchronizedPacket.synchronizationIndex_eq_one_iff
#print axioms SynchronizedPacket.exactGaps_of_synchronizationIndex_eq_one
#print axioms SynchronizedPacket.synchronizationIndex_eq_one_of_exactGaps
#print axioms SynchronizedPacket.synchronizationIndex_eq_one_iff_exactGaps
#print axioms SynchronizedPacket.coordinate_bounds
#print axioms SynchronizedPacket.canonicalOrientation_rigid
#print axioms SynchronizedPacket.finiteCoordinates
#print axioms SynchronizedPacket.finiteCoordinates_injective
#print axioms synchronizedPacketFintype
#print axioms finite_synchronizedPacket

#print axioms fullPacket
#print axioms fullPacket_canonicallyOriented
#print axioms synchronizedPacketNonempty
#print axioms abcRadical
#print axioms abcRadical_gt_one
#print axioms standardQuality
#print axioms packetEnergy
#print axioms standardQuality_le_packetEnergy
#print axioms minimumPacketEnergy
#print axioms standardQuality_le_minimumPacketEnergy
#print axioms primePower_orientation_channel
#print axioms coprime_channel_allocation

#print axioms family_sum
#print axioms family_coprime
#print axioms family_exact_gaps
#print axioms familyDatum
#print axioms familyPacket
#print axioms familyPacket_y_ne_full

#print axioms cornerCounterexampleDatum
#print axioms cornerCounterexamplePacket
#print axioms cornerCounterexamplePacket_ne_full
#print axioms cubicCounterexampleDatum
#print axioms cubicCounterexamplePacket
#print axioms cubicCounterexamplePacket_fails_height_pow_three
#print axioms quarticCounterexampleDatum
#print axioms quarticCounterexamplePacket
#print axioms quarticCounterexamplePacket_exactGaps
#print axioms quarticCounterexamplePacket_fails_height_pow_four
#print axioms quarticCounterexamplePacket_fails_coordinateProduct_sq
#print axioms quinticCounterexampleDatum
#print axioms quinticCounterexamplePacket
#print axioms quinticCounterexamplePacket_exactGaps
#print axioms quinticCounterexamplePacket_fails_height_pow_five

end ABCSynchronizedDivisorPackets20260903AxiomAudit
end IUTThreeClosures
