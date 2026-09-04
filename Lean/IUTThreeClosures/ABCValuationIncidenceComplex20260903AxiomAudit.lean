import IUTThreeClosures.ABCValuationIncidenceComplex20260903

/-!
# Axiom audit: labeled valuation-incidence complex

Compile directly with `-DwarningAsError=true`.  The imported module contains
only finite support combinatorics, natural-number factorization, local modular
signatures, and an exact reformulation of a rational-power height inequality.
It contains no eventual estimate and no assertion of the `abc` conjecture.
-/

namespace IUTThreeClosures
namespace ABCValuationIncidenceComplex20260903AxiomAudit

open ABCValuationIncidenceComplex20260903

#print axioms PrimitiveABC
#print axioms Arm
#print axioms coordinate
#print axioms coordinate_pos
#print axioms Face
#print axioms Face.ext
#print axioms Face.empty
#print axioms Face.full
#print axioms Face.union
#print axioms Face.inter
#print axioms Face.IsSubface
#print axioms Face.isSubface_refl
#print axioms Face.isSubface_trans
#print axioms Face.isSubface_antisymm
#print axioms Face.empty_isSubface
#print axioms Face.isSubface_full
#print axioms Face.isSubface_union_left
#print axioms Face.isSubface_union_right
#print axioms Face.union_isSubface
#print axioms Face.vertexCount
#print axioms Face.natDimension
#print axioms Face.valuation
#print axioms Face.armRadical
#print axioms Face.armDefect
#print axioms Face.armModulus
#print axioms Face.defectDegree
#print axioms Face.tropicalPoint
#print axioms Face.logarithmicPoint
#print axioms Face.prime_of_mem_support
#print axioms Face.valuation_pos_of_mem_support
#print axioms Face.armRadical_pos
#print axioms Face.armDefect_pos
#print axioms Face.armRadical_dvd_of_isSubface
#print axioms Face.armRadical_le_of_isSubface
#print axioms Face.armRadical_mul_armDefect
#print axioms Face.armModulus_dvd_coordinate
#print axioms Face.full_armModulus
#print axioms Face.full_armRadical
#print axioms Face.full_radical_mul_defect
#print axioms Face.ArmwiseDisjoint
#print axioms Face.armRadical_union
#print axioms Face.armDefect_union
#print axioms Face.armModulus_union
#print axioms Face.defectDegree_union
#print axioms Face.Budget
#print axioms Face.IsBudgetFace
#print axioms Face.isBudgetFace_of_isSubface
#print axioms Face.empty_isBudgetFace
#print axioms Face.zeroBudget_iff_valuation_one
#print axioms Face.union_isBudgetFace
#print axioms Face.localIncidenceSignature
#print axioms Face.coprime_modulus_AB
#print axioms Face.coprime_modulus_AC
#print axioms Face.coprime_modulus_BC
#print axioms Face.ABReconstructing
#print axioms Face.full_ABReconstructing
#print axioms Face.eq_c_of_ABReconstructing
#print axioms Face.complexRadical
#print axioms Face.complexRadical_eq_abcRadical
#print axioms Face.cPower_le_complexRadical_iff_sumArmDefect
#print axioms Face.cPower_le_abcRadical_iff_sumArmDefect
#print axioms Face.filteredFaceBound_forces_cPower

#print axioms twelveEightThirtyThreeEightFortyFive
#print axioms witness_primeFactors_A
#print axioms witness_primeFactors_B
#print axioms witness_primeFactors_C
#print axioms witness_valuation_A_two
#print axioms witness_valuation_A_three
#print axioms witness_valuation_B_seven
#print axioms witness_valuation_B_seventeen
#print axioms witness_valuation_C_five
#print axioms witness_valuation_C_thirteen
#print axioms witness_coordinate_radicals
#print axioms arm_univ
#print axioms witness_full_vertexCount
#print axioms witness_full_natDimension
#print axioms witness_armDefects
#print axioms witness_full_tropicalPoint
#print axioms witness_everyArm_defective
#print axioms witness_everyArm_has_mixedValuation
#print axioms witness_full_defectDegree
#print axioms witness_full_oneBudget_not_zeroBudget
#print axioms witnessSquarefreeFace
#print axioms witnessSquarefreeFace_vertexCount
#print axioms witnessSquarefreeFace_zeroBudget

end ABCValuationIncidenceComplex20260903AxiomAudit
end IUTThreeClosures
