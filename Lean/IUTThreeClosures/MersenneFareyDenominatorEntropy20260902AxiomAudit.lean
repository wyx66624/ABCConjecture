/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneFareyDenominatorEntropy20260902

/-!
Separate axiom audit for the finite denominator-entropy kernel.  The expected
dependency union is the standard Mathlib quotient/extensionality basis:
`Classical.choice`, `Quot.sound`, and `propext`.  In particular, no open
Wieferich-count estimate or asymptotic Farey hypothesis is an axiom.
-/

namespace IUTThreeClosures
namespace MersenneFareyDenominatorEntropy20260902AxiomAudit

open MersenneFareyDenominatorEntropy20260902

#print axioms fibreSlopeMass_eq_numeratorMass_div
#print axioms triangularCapacity_eq
#print axioms numeratorMass_le_triangularCapacity
#print axioms prefixFareyEnergy_le_triangular_mul_harmonic
#print axioms natSlope_le_of_cutoffs
#print axioms fibreSlopeMass_le_card_mul_cutoff
#print axioms tailFareyEnergy_le_count_mul_cutoff
#print axioms tailRowCount_forced_product
#print axioms cutoff_mul_energyDefect_le_count_mul_height
#print axioms exactOrder_depthThree_implies_superWieferich
#print axioms endpointRow_depthThree_implies_superWieferich
#print axioms endpointExactOrderRow_eq_of_prime_eq
#print axioms endpointPrime_injective
#print axioms endpointRow_tail_prime_crossBound
#print axioms wieferich_1093_not_superWieferich_at_exactOrder
#print axioms wieferich_3511_not_superWieferich_at_exactOrder

end MersenneFareyDenominatorEntropy20260902AxiomAudit
end IUTThreeClosures
