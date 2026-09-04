import IUTThreeClosures.ABCFlaggedCRTSurplusResidueCube20260904

/-!
# Axiom audit: flagged CRT surplus and endpoint residue cubes

Compile this file directly with `-DwarningAsError=true`.  The inventory is
one-for-one with every public `abbrev`, `structure`, `def`, and `theorem` in
the implementation module.  The uniform FCRT-1 gate is printed as a
definition and is never assumed.
-/

open IUTThreeClosures
open ABCFlaggedCRTSurplusResidueCube20260904

#print axioms feasibleSourceSubsets
#print axioms exists_maximalFeasibleSourceSubset
#print axioms freeTarget_residualMass_eq_scalar

#print axioms ProperSubfaceFlag
#print axioms ProperSubfaceFlag.witness_ssubset
#print axioms ProperSubfaceFlag.witnessMass

#print axioms ownedMass
#print axioms sum_ownedMass_le_total
#print axioms clippedResidual
#print axioms sourceWeight_le_credit_add_clippedResidual

#print axioms OwnedFlaggedConfiguration
#print axioms OwnedFlaggedConfiguration.sourceCredit
#print axioms OwnedFlaggedConfiguration.residual
#print axioms OwnedFlaggedConfiguration.boundary
#print axioms OwnedFlaggedConfiguration.sourceMass
#print axioms OwnedFlaggedConfiguration.sinkMass
#print axioms OwnedFlaggedConfiguration.totalSourceCredit_le_sink_add_reuse
#print axioms OwnedFlaggedConfiguration.totalReuse_le_totalSurplus
#print axioms OwnedFlaggedConfiguration.sourceMass_sub_sinkMass_le_boundary

#print axioms FlaggedSurplusCertificate
#print axioms FlaggedSurplusCertificate.sourceMass
#print axioms FlaggedSurplusCertificate.sinkMass
#print axioms FlaggedSurplusCertificate.boundary
#print axioms FlaggedSurplusCertificate.boundary_nonneg
#print axioms FlaggedSurplusCertificate.totalReuse_le_totalSurplus
#print axioms FlaggedSurplusCertificate.totalReuse_le_totalWitness
#print axioms FlaggedSurplusCertificate.sourceMass_sub_sinkMass_le_boundary

#print axioms EndpointFlaggedCertificate
#print axioms height_le_conductor_add_flaggedBoundary
#print axioms EndpointFlaggedAdmissibility
#print axioms UniformAdmissibleFlaggedCRTBoundary
#print axioms abc_of_uniformAdmissibleFlaggedCRTBoundary

#print axioms packetLabel
#print axioms IsCompatiblePacket
#print axioms packetLabel_add_compl
#print axioms compatible_iff_compl_zero
#print axioms packetLabel_inter_add_sdiff
#print axioms packetLabel_sdiff_eq_of_eq
#print axioms compatiblePacket_sdiff_eq

#print axioms witness675_sum
#print axioms witness675_factor_b
#print axioms witness675_factor_c
#print axioms witness675_threeFace_for_two
#print axioms witness675_fiveFace_not_for_two
#print axioms witness675_threeFace_not_for_thirteen
#print axioms witness675_fiveFace_not_for_thirteen
#print axioms witness675_fullFace_for_both
#print axioms witness675_reuseCap_is_surplus
#print axioms witness675_flaggedBoundary_eq_scalarDefect

#print axioms witness224_sum
#print axioms witness224_factor_b
#print axioms witness224_factor_c
#print axioms witness224_twoFace_not_for_three
#print axioms witness224_sevenFace_not_for_three
#print axioms witness224_twoFace_not_for_five
#print axioms witness224_sevenFace_not_for_five
#print axioms witness224_fullFace_for_both
#print axioms witness224_boundary_strictly_above_scalarDefect

#print axioms witness65025_sum
#print axioms witness65025_factor_b
#print axioms witness65025_factor_c
#print axioms witness65025_twoFace_for_three
#print axioms witness65025_twoFace_not_for_five
#print axioms witness65025_twoFace_not_for_seventeen
#print axioms witness65025_127Face_not_for_three
#print axioms witness65025_127Face_not_for_five
#print axioms witness65025_127Face_not_for_seventeen
#print axioms witness65025_fullFace_for_all
#print axioms witness65025_reuseCap_is_witness
#print axioms witness65025_fourBoundaryLevels_strict
