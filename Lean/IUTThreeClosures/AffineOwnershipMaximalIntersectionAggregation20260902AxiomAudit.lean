/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineOwnershipMaximalIntersectionAggregation20260902

/-!
Separate axiom audit for the ownership-preserving maximal-intersection
aggregation module.  No analytic asymptotic statement from the paper report
is imported as an axiom.
-/

namespace IUTThreeClosures
namespace AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit

open AffineOwnershipMaximalIntersectionAggregation20260902

#print axioms cofinalSubcatalogue_maximal_iff
#print axioms maximalSupport_pairTop_eq
#print axioms distinctMaximalSupports_commonPoint_unique
#print axioms ownerPartition_sum
#print axioms ownedCharge_le_envelope
#print axioms ownedMass_sq_le_energy_mul_cap_div_cube
#print axioms ownershipCauchy
#print axioms ownershipCauchy_of_caps
#print axioms pairMultiplicity_le_cubicExcess
#print axioms catalogueMultiplicityEnergy_bound
#print axioms strictRayClosure_mass
#print axioms strictRayClosure_energy
#print axioms globalShiftedEnergy_le
#print axioms normalizedMaximalTopGate
#print axioms normalizedPressure_le_beta_mul_unionWeight
#print axioms treeOwnerCap
#print axioms treeOwnerCaps_sum
#print axioms periodDirection_numeric_certificate
#print axioms periodDirection_mass_certificate
#print axioms threePairCollapse_numeric_certificate
#print axioms threePairCubicPressure_sharp
#print axioms oneClass_twoMaximalTops_numeric_certificate
#print axioms catalogueInflationAboveTwo_numeric_certificate
#print axioms completeGraphLedger_sharp_certificate

end AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit
end IUTThreeClosures
