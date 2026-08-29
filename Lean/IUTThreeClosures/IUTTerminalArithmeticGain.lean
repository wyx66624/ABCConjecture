/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalPublicPacketEnvelope

/-!
# The terminal q-gain is an actual arithmetic divisor identity

The coefficient-two computation uses the gain `n^2-1` between the terminal
square-label mass and the q-pilot left side.  This file proves that the gain is
not a formal placeholder.  For the source-faithful finite bad-place packet,
the terminal normalized Haar mass is exactly

`n^2 * arithmeticLogQ`,

where `n = (ell-1)/2`, and hence its excess over the normalized q-pilot mass is
exactly

`(n^2-1) * arithmeticLogQ`.

The proof uses the genuine finite-positive terminal square-label regions, the
actual completed local Haar measures and the already proved reconstruction of
the arithmetic q-divisor.  It does not supply a global IUT IV comparison or an
upper bound for the non-q terms.
-/

namespace IUTThreeClosures
namespace IUTTerminalArithmeticGain

open Iut

noncomputable section

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Number-field-normalized positive mass of the terminal distinguished-label
packet. -/
noncomputable def terminalNormalizedMass (Q : QPilotData D) : ℝ :=
  -ActualBadPlaceProcessionAssembly.distinguishedLabelPacketLog Q
      (ActualBadPlaceProcessionAssembly.processionLength D - 1) /
    (Module.finrank ℚ D.F : ℝ)

/-- The terminal mass is the exact square of the procession length times the
normalized arithmetic q-divisor degree. -/
theorem terminalNormalizedMass_eq_square_mul_arithmeticLogQ
    (Q : QPilotData D) :
    terminalNormalizedMass Q =
      (ActualBadPlaceProcessionAssembly.processionLength D : ℝ) ^ 2 *
        ActualBadPlaceQPilotPacket.arithmeticLogQ Q := by
  rw [terminalNormalizedMass,
    IUTTerminalLabelCoefficientTwo.terminalLabelPacketLog_eq Q,
    ← ActualBadPlaceQPilotPacket.normalizedHaarLogQ_eq_arithmeticLogQ Q]
  unfold ActualBadPlaceQPilotPacket.normalizedHaarLogQ
  ring

/-- Positive excess of the terminal square-label mass over the ordinary
q-pilot mass. -/
noncomputable def terminalArithmeticGain (Q : QPilotData D) : ℝ :=
  terminalNormalizedMass Q -
    ActualBadPlaceQPilotPacket.arithmeticLogQ Q

/-- The terminal excess has the exact scalar coefficient `n^2-1`. -/
theorem terminalArithmeticGain_eq
    (Q : QPilotData D) :
    terminalArithmeticGain Q =
      ((ActualBadPlaceProcessionAssembly.processionLength D : ℝ) ^ 2 - 1) *
        ActualBadPlaceQPilotPacket.arithmeticLogQ Q := by
  rw [terminalArithmeticGain,
    terminalNormalizedMass_eq_square_mul_arithmeticLogQ]
  ring

/-- The arithmetic q-divisor degree is nonnegative. -/
theorem arithmeticLogQ_nonneg (Q : QPilotData D) :
    0 ≤ ActualBadPlaceQPilotPacket.arithmeticLogQ Q := by
  rw [← ActualBadPlaceQPilotPacket.normalizedHaarLogQ_eq_arithmeticLogQ Q]
  unfold ActualBadPlaceQPilotPacket.normalizedHaarLogQ
  have hsum := ActualBadPlaceQPilotPacket.signedHaarLogSum_le_zero Q
  have hrank : 0 < (Module.finrank ℚ D.F : ℝ) := by
    exact_mod_cast NumberField.finrank_pos (K := D.F)
  exact div_nonneg (neg_nonneg.mpr hsum) hrank.le

/-- For a procession of length at least two and a positive arithmetic q-degree,
the terminal gain is strictly positive. -/
theorem terminalArithmeticGain_pos
    (Q : QPilotData D)
    (hlength : 2 ≤ ActualBadPlaceProcessionAssembly.processionLength D)
    (hQ : 0 < ActualBadPlaceQPilotPacket.arithmeticLogQ Q) :
    0 < terminalArithmeticGain Q := by
  rw [terminalArithmeticGain_eq]
  have hn : (2 : ℝ) ≤
      (ActualBadPlaceProcessionAssembly.processionLength D : ℝ) := by
    exact_mod_cast hlength
  have hfactor :
      0 < (ActualBadPlaceProcessionAssembly.processionLength D : ℝ) ^ 2 - 1 := by
    nlinarith
  exact mul_pos hfactor hQ

#print axioms terminalNormalizedMass_eq_square_mul_arithmeticLogQ
#print axioms terminalArithmeticGain_eq
#print axioms arithmeticLogQ_nonneg
#print axioms terminalArithmeticGain_pos

end
end IUTTerminalArithmeticGain
end IUTThreeClosures
