import IUTThreeClosures.SteinbergIntegerFiniteChain20260902

/-!
# Axiom audit: integer exponent gcds and concrete finite Steinberg chains

Compile this file with `-DwarningAsError=true`.  The inventory covers the
S-I2 arithmetic bridge, the S-I4 finite-support norm identity, and the
concrete exact-boundary instantiation of the earlier abstract filling lemma.
-/

namespace IUTThreeClosures
namespace SteinbergIntegerFiniteChain20260902AxiomAudit

open SteinbergIntegerFiniteChain20260902

#print axioms exponentGCD_one
#print axioms primitiveBase_one
#print axioms rawExponentGCD_pos
#print axioms exponentGCD_pos
#print axioms exponentGCD_dvd_factorization
#print axioms primitiveBase_factorization
#print axioms primitiveBase_pow_exponentGCD
#print axioms exponentGCD_power_decomposition
#print axioms primitiveBase_pos
#print axioms primitiveBase_support_eq
#print axioms primitiveBase_exponent_gcd_one
#print axioms primitiveBase_radical_eq
#print axioms primitiveBaseHeight_one
#print axioms coherentThickness_one
#print axioms primitiveResidualThickness_one
#print axioms legHeight_eq_exponentGCD_mul_primitiveBaseHeight
#print axioms primitiveBaseHeight_eq_height_div_exponentGCD
#print axioms exponentDefect_integer_veronese_residual
#print axioms primitiveBaseHeight_nonneg
#print axioms coherentThickness_nonneg
#print axioms primitiveResidualThickness_nonneg

#print axioms finiteTensor_apply
#print axioms finiteWedge_apply
#print axioms finiteContact_apply
#print axioms finiteValuationDivisor_apply
#print axioms positiveRationalCell_pairwiseDisjoint
#print axioms effectiveContactSurface_natAbs
#print axioms weightedContactNormOn_eq_mixedArea
#print axioms weightedMassOn_factorization_eq_legHeight
#print axioms PositiveRationalCell.logWeightedNorm_eq_fullContactArea
#print axioms PositiveRationalCell.two_logWeightedNorm_eq_mixed_coherent_residual
#print axioms sum_abs_restrictedWeightedCoordinate
#print axioms FiniteRationalCellChain.coordinateNorm_eq_cellNorm
#print axioms FiniteRationalCellChain.coordinate_boundary
#print axioms FiniteRationalCellChain.boundary_le_calibratedCost

end SteinbergIntegerFiniteChain20260902AxiomAudit
end IUTThreeClosures
