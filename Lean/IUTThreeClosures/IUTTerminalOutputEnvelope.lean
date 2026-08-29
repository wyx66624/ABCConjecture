/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTProcessionCoherentInd2
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# Terminal envelopes for actual theta-output choices

The concrete output model already separates the three local indeterminacies:
norm-one Ind1 multiplication, an Ind2 label permutation, and nonnegative Ind3
exponent enlargement.  If the Ind2 permutation fixes a selected terminal
label, then the output exponent at that label is at least the original square
exponent.  Antitonicity of Tate-power regions therefore implies that every
such output remains inside the terminal `q^(j^2) O` region.

This proves an actual output-envelope theorem, not merely a scalar model.  It
also shows that the union over all terminal-stabilizing output choices has
terminal projection contained in the terminal Tate region.  Combined with the
coherent-procession theorem, the remaining source question is whether the
genuine global Ind2 ambiguity is exhausted by procession-coherent choices and
whether the public mono-analytic hull comparison respects this terminal
projection.
-/

namespace IUTThreeClosures
namespace IUTTerminalOutputEnvelope

open TateCurvesTheta

noncomputable section

universe u v

variable {K : Type u} [NormedField K]
variable {Label : Type v}

/-- Fixing the terminal label makes its output power at least the original
square-label exponent. -/
theorem terminal_square_le_outputPower
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label)
    (terminal : Label)
    (hfix : choice.ind2 terminal = terminal) :
    (labelNat terminal) ^ 2 ≤ choice.outputPower labelNat terminal := by
  unfold ThetaIndeterminacyChoice.outputPower
  rw [hfix]
  omega

/-- The actual output region at a fixed terminal label is contained in the
original terminal square-label Tate region. -/
theorem outputRegion_terminal_le
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label)
    (terminal : Label)
    (hfix : choice.ind2 terminal = terminal) :
    choice.outputRegion t labelNat terminal ⊆
      t.qPowerRegion ((labelNat terminal) ^ 2) := by
  rw [choice.outputRegion_eq_qPowerRegion]
  exact t.qPowerRegion_antitone
    (terminal_square_le_outputPower labelNat choice terminal hfix)

/-- Every point of an actual terminal-stabilizing output packet has terminal
coordinate in the terminal Tate region. -/
theorem packetRegion_terminal_mem
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label)
    (terminal : Label)
    (hfix : choice.ind2 terminal = terminal)
    {x : Label → K}
    (hx : x ∈ choice.packetRegion t labelNat) :
    x terminal ∈ t.qPowerRegion ((labelNat terminal) ^ 2) := by
  exact outputRegion_terminal_le t labelNat choice terminal hfix
    (hx terminal)

/-- Literal union of all concrete output packets whose Ind2 choice fixes the
selected terminal label. -/
def terminalStabilizedOutputUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) : Set (Label → K) :=
  ⋃ choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal},
    choice.1.packetRegion t labelNat

/-- The terminal projection of the complete stabilizer-output union is bounded
by the original terminal square-label Tate region. -/
theorem terminalStabilizedOutputUnion_le_terminalCylinder
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) :
    terminalStabilizedOutputUnion t labelNat terminal ⊆
      {x : Label → K |
        x terminal ∈ t.qPowerRegion ((labelNat terminal) ^ 2)} := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨choice, hxchoice⟩
  exact packetRegion_terminal_mem t labelNat choice.1 terminal
    choice.2 hxchoice

/-- The ordinary output choice belongs to the terminal-stabilizing union. -/
theorem ordinary_packetRegion_le_terminalStabilizedOutputUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) :
    (ThetaIndeterminacyChoice.ordinary :
        ThetaIndeterminacyChoice K Label).packetRegion t labelNat ⊆
      terminalStabilizedOutputUnion t labelNat terminal := by
  intro x hx
  let choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal} :=
    ⟨ThetaIndeterminacyChoice.ordinary, rfl⟩
  exact Set.mem_iUnion.mpr ⟨choice, hx⟩

#print axioms terminal_square_le_outputPower
#print axioms outputRegion_terminal_le
#print axioms packetRegion_terminal_mem
#print axioms terminalStabilizedOutputUnion_le_terminalCylinder
#print axioms ordinary_packetRegion_le_terminalStabilizedOutputUnion

end
end IUTTerminalOutputEnvelope
end IUTThreeClosures
