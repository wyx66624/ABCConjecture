import IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903

/-!
# Axiom audit: generated Steinberg five-term boundary bridge

Compile with `-DwarningAsError=true`.  The inventory covers the free-chain
boundary, the generated relation, the positive rational realization family,
the generated-filling conversion, and the full-premise counterexamples to
literal-chain cancellation and boundary injectivity.
-/

namespace IUTThreeClosures
namespace SteinbergFiveTermBoundaryBridge20260903AxiomAudit

open SteinbergFiveTermBoundaryBridge20260903

#print axioms DivisorSymbol.ext
#print axioms chainBoundary_single
#print axioms chainAugmentation_single
#print axioms fiveTermChain_augmentation
#print axioms fiveTermChain_ne_zero
#print axioms fiveTermChain_boundary
#print axioms fiveTermGenerator_mem
#print axioms fiveTermRelation_ne_bot
#print axioms fiveTermRelation_le_ker
#print axioms fiveTermEquivalent_refl
#print axioms fiveTermEquivalent_symm
#print axioms fiveTermEquivalent_trans
#print axioms chainBoundary_eq_of_fiveTermEquivalent

#print axioms chainBoundary_cellChain
#print axioms chainBoundary_encodedCellSum
#print axioms AlgebraicallyGeneratedRationalFilling.boundary
#print axioms AlgebraicallyGeneratedRationalFilling.boundary_le_calibratedCost

#print axioms PositiveFiveTermRealization.realizedChain_eq_fiveTermChain
#print axioms PositiveFiveTermRealization.realizedChain_mem_fiveTermRelation
#print axioms PositiveFiveTermRealization.realized_surface_boundary
#print axioms PositiveFiveTermRealization.encodedFiller_eq
#print axioms PositiveFiveTermRealization.generatedFilling_boundary

#print axioms positiveFiveTermGenerator_mem
#print axioms positiveFiveTermRelation_le_algebraic
#print axioms positiveFiveTermRelation_le_ker
#print axioms chainBoundary_eq_of_positiveFiveTermEquivalent
#print axioms PositivelyGeneratedRationalFilling.boundary
#print axioms PositivelyGeneratedRationalFilling.boundary_le_calibratedCost

#print axioms finiteValuationDivisor_one
#print axioms finiteValuationDivisor_mul
#print axioms CommonDenominatorFiveTermData.a_pos
#print axioms CommonDenominatorFiveTermData.c_pos
#print axioms CommonDenominatorFiveTermData.b_lt_c
#print axioms CommonDenominatorFiveTermData.c_sub_a_pos
#print axioms CommonDenominatorFiveTermData.c_sub_b_pos
#print axioms CommonDenominatorFiveTermData.a_sub_b_pos
#print axioms CommonDenominatorFiveTermData.fourth_sum
#print axioms CommonDenominatorFiveTermData.fifth_sum
#print axioms CommonDenominatorFiveTermData.firstCell_symbol
#print axioms CommonDenominatorFiveTermData.secondCell_symbol
#print axioms CommonDenominatorFiveTermData.thirdCell_symbol
#print axioms CommonDenominatorFiveTermData.fourthCell_symbol
#print axioms CommonDenominatorFiveTermData.fifthCell_symbol
#print axioms CommonDenominatorFiveTermData.actual_fiveTerm_surface_boundary
#print axioms oddDenominator_actual_fiveTerm_surface_boundary

#print axioms cellSymbol_oneHalf
#print axioms cellSymbol_oneSixth
#print axioms cellSymbol_oneThird
#print axioms cellSymbol_oneFifth
#print axioms cellSymbol_threeFifths
#print axioms halfSixth_surface_boundary
#print axioms cellSymbol_oneHalf_ne_oneSixth
#print axioms cellSymbol_oneHalf_ne_oneThird
#print axioms cellSymbol_oneHalf_ne_oneFifth
#print axioms cellSymbol_oneHalf_ne_threeFifths
#print axioms halfSixth_realizedChain_apply_oneHalf
#print axioms halfSixth_realizedChain_ne_zero
#print axioms positive_realizedChain_not_always_zero
#print axioms halfSixth_realizedChain_mem_positiveFiveTermRelation
#print axioms positiveFiveTermRelation_ne_bot

#print axioms fiveTermChain_all_zero_eq_single
#print axioms fiveTermChain_all_zero_ne_zero
#print axioms not_all_fiveTermChains_eq_zero
#print axioms fiveTermChain_all_zero_equivalent_zero
#print axioms fiveTermEquivalent_does_not_imply_chain_equality
#print axioms chainBoundary_not_injective

end SteinbergFiveTermBoundaryBridge20260903AxiomAudit
end IUTThreeClosures
