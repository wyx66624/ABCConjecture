import IUTThreeClosures.ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge

/-!
# Axiom audit: independent flagged-CRT owner and endpoint bridges

The inventory below is one-for-one with the public declarations in the
bridge module.  Compile directly with `-DwarningAsError=true`.
-/

open IUTThreeClosures
open ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge

#print axioms ownedMass_nonneg
#print axioms sub_min_eq_clippedResidual
#print axioms tautologicalEndpointCertificate
#print axioms ownedSourceCredit_nonneg
#print axioms cappedSourceCredit
#print axioms cappedSourceCredit_nonneg
#print axioms cappedSourceCredit_le_sourceWeight
#print axioms cappedSourceCredit_le_sourceCredit
#print axioms toFlaggedSurplusCertificate
#print axioms toFlaggedSurplusCertificate_sourceMass
#print axioms toFlaggedSurplusCertificate_sinkMass
#print axioms toFlaggedSurplusCertificate_boundary
#print axioms owner_massBridge_via_aggregate
#print axioms endpointCertificateOfAggregate
#print axioms endpointCertificateOfAggregate_boundary
#print axioms endpointCertificateOfOwned
#print axioms endpointCertificateOfOwned_boundary
#print axioms height_le_conductor_add_ownedBoundary
