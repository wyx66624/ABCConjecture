/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneFareyQuantitativeSwarm20260903

/-!
# Axiom audit for the quantitative Mersenne Farey swarm transfer
-/

namespace IUTThreeClosures
namespace MersenneFareyQuantitativeSwarm20260903AxiomAudit

open MersenneFareyQuantitativeSwarm20260903

#print axioms harmonicPrefix_eq_harmonic
#print axioms log_lcmUpto_lower
#print axioms log_lcmUpto_upper
#print axioms harmonicPrefix_le_one_add_log
#print axioms triangularCapacity_le_square
#print axioms triangularCapacity_nonneg
#print axioms prefixFareyEnergy_le_square_mul_one_add_log
#print axioms quantitativeSwarm_cleared
#print axioms quantitativeSwarm_count_lower
#print axioms mem_superWieferichPrimesUpTo
#print axioms endpointPrime_mem_superWieferichPrimesUpTo
#print axioms endpointRows_card_le_superWieferichPrimesUpTo
#print axioms fullNumeratorRows_prefix_eq
#print axioms not_uniformStrictPrefixImprovement
#print axioms not_isLittleO_iff_exists_frequently_gt
#print axioms frequent_quantitativeSwarm_cleared
#print axioms notLittleO_forces_frequentSwarm_of_negligiblePrefix

end MersenneFareyQuantitativeSwarm20260903AxiomAudit
end IUTThreeClosures
