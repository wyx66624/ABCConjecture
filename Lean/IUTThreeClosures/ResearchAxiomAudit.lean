/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConservativeTransferDefect
import IUTThreeClosures.LegendreSelectorDeterminantBudget

/-!
# Axiom audit for the v13 research modules

This file is executed directly by CI.  Its output must not contain `sorryAx`.
The audit is deliberately separate from a successful ordinary build: Lean
accepts declarations containing `sorry`, whereas the research closure standard
does not.
-/

#print axioms IUTThreeClosures.ConservativeTransferDefect.weightedMass_transfer
#print axioms IUTThreeClosures.ConservativeTransferDefect.weightedMass_transfer_add_defect
#print axioms IUTThreeClosures.ConservativeTransferDefect.globalChange_eq_defectMass
#print axioms IUTThreeClosures.ConservativeTransferDefect.strictGlobalGain_iff_positiveDefectMass
#print axioms IUTThreeClosures.ConservativeTransferDefect.noStrictGlobalGain_of_defectMass_nonpos
#print axioms IUTThreeClosures.ConservativeTransferDefect.twoStage_defectBudget
#print axioms IUTThreeClosures.ConservativeTransferDefect.twoStage_strictGlobalGain_iff

#print axioms IUTThreeClosures.max_mul_legendreResidualDeterminant
#print axioms IUTThreeClosures.mul_lt_legendreResidualDeterminant
#print axioms IUTThreeClosures.legendreResidualDeterminant_le_two_mul
#print axioms IUTThreeClosures.legendreResidualDeterminant_window
#print axioms IUTThreeClosures.height_le_legendreResidualDeterminant
#print axioms IUTThreeClosures.height_le_of_legendreResidualDeterminant_le
#print axioms IUTThreeClosures.balanced_legendreResidualDeterminant
#print axioms IUTThreeClosures.balanced_height_sq_le_three_residual
