import IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903

/-!
# Axiom audit: prime-packet boundary transport successor

Compile this file directly with `-DwarningAsError=true`.  The inventory is
one-for-one with every public `abbrev`, `structure`, `def`, and `theorem` in
the implementation module.  The conditional packet gate is printed but is
not assumed.
-/

open IUTThreeClosures
open ABCPrimePacketBoundaryTransportSuccessor20260903

#print axioms PrimePacketAssignment
#print axioms PrimePacketAssignment.sourceMass
#print axioms PrimePacketAssignment.sinkMass
#print axioms PrimePacketAssignment.packetMass
#print axioms PrimePacketAssignment.packetResidual
#print axioms PrimePacketAssignment.totalResidual
#print axioms PrimePacketAssignment.allocatedMass
#print axioms PrimePacketAssignment.empty
#print axioms PrimePacketAssignment.allSinksTo
#print axioms PrimePacketAssignment.packetResidual_nonneg
#print axioms PrimePacketAssignment.source_sub_packetMass_le_packetResidual
#print axioms PrimePacketAssignment.sum_packetMass_eq_allocatedMass
#print axioms PrimePacketAssignment.allocatedMass_le_sinkMass
#print axioms PrimePacketAssignment.sourceMass_sub_sinkMass_le_totalResidual
#print axioms PrimePacketAssignment.empty_packetMass
#print axioms PrimePacketAssignment.allSinksTo_packetMass_self
#print axioms PrimePacketAssignment.allSinksTo_packetMass_of_ne
#print axioms PrimePacketAssignment.allSinksTo_totalResidual_of_unique

#print axioms EndpointPowerPrimeToken
#print axioms endpointPowerPrimeWeight
#print axioms EndpointPrimePacketAssignment
#print axioms endpointPowerPrimeWeight_nonneg
#print axioms endpointExternalPrimeWeight_nonneg
#print axioms emptyEndpointPrimePacketAssignment
#print axioms endpointPrimePacketAssignment_nonempty
#print axioms endpointPacket_sourceMass_eq_log_core
#print axioms endpointPacket_sinkMass_eq_log_externalRadical
#print axioms signedEndpointCoreDefect_le_packetResidual
#print axioms height_le_conductor_add_packetResidual
#print axioms UniformEndpointPrimePacketBound
#print axioms abc_of_uniformEndpointPrimePacketBound

#print axioms twoSourceOneSinkPacket
#print axioms one_le_twoSourceOneSink_totalResidual
#print axioms twoSourceOneSinkPacket_totalResidual
#print axioms twoSourceOneSink_scalarDefect_eq_zero

#print axioms primeSquarePacketToken
#print axioms primeSquarePacketToken_unique
#print axioms primeSquarePacketWeight
#print axioms primeSquare_allSinks_totalResidual
