/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTTerminalOutputEnvelope

/-!
# Terminal envelopes in public packet coordinates

The concrete terminal envelope can be transported through the explicit carrier
equivalence of `PublicPacketKummerCoordinates`.  This file defines the public
terminal cylinder and proves that every terminal-stabilizing concrete
Hodge-theater output, as a region of the public direct-sum carrier, lies in
that cylinder.  The literal union of all such public realizations satisfies
the same bound, and the ordinary squared-label output belongs to the union.

No public `RHSData`, log-volume inequality or Corollary 3.12 theorem is assumed.
The remaining step is to construct these coordinates and the compatible
terminal-stabilizing output family simultaneously for the actual global
large-volume container, then prove that its public hull respects terminal
projection.
-/

namespace IUTThreeClosures
namespace IUTTerminalPublicPacketEnvelope

open Iut TateCurvesTheta

noncomputable section

universe u v w

variable {Carrier : Type u}
variable {P : DirectSumPresentation.{u, v} Carrier}
variable {K : Type v} [NormedField K]
variable {Label : Type w}

/-- The terminal cylinder in the public packet carrier, defined through the
source-derived Kummer coordinates. -/
def publicTerminalCylinder
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) : Set P.Total :=
  {x | M.coordinates x terminal ∈
    t.qPowerRegion ((labelNat terminal) ^ 2)}

/-- Public realization of one terminal-stabilizing output choice. -/
def terminalStabilizedPublicRealization
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label)
    (choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal}) : Set P.Total :=
  M.realize t labelNat choice.1

/-- Literal public union over every concrete terminal-stabilizing output
choice. -/
def terminalStabilizedPublicUnion
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) : Set P.Total :=
  ⋃ choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal},
    terminalStabilizedPublicRealization M t labelNat terminal choice

/-- Every individual public terminal-stabilizing output lies in the public
terminal cylinder. -/
theorem terminalStabilizedPublicRealization_le_cylinder
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label)
    (choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal}) :
    terminalStabilizedPublicRealization M t labelNat terminal choice ⊆
      publicTerminalCylinder M t labelNat terminal := by
  intro x hx
  change M.coordinates x terminal ∈
    t.qPowerRegion ((labelNat terminal) ^ 2)
  apply IUTTerminalOutputEnvelope.packetRegion_terminal_mem
    t labelNat choice.1 terminal choice.2
  exact hx

/-- The complete public union of terminal-stabilizing concrete outputs remains
inside the terminal cylinder. -/
theorem terminalStabilizedPublicUnion_le_cylinder
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) :
    terminalStabilizedPublicUnion M t labelNat terminal ⊆
      publicTerminalCylinder M t labelNat terminal := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨choice, hxchoice⟩
  exact terminalStabilizedPublicRealization_le_cylinder
    M t labelNat terminal choice hxchoice

/-- The ordinary squared-label public output belongs to the
terminal-stabilizing public union. -/
theorem ordinary_public_realization_le_union
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label) :
    M.realize t labelNat
        (ThetaIndeterminacyChoice.ordinary :
          ThetaIndeterminacyChoice K Label) ⊆
      terminalStabilizedPublicUnion M t labelNat terminal := by
  intro x hx
  let choice : {C : ThetaIndeterminacyChoice K Label //
      C.ind2 terminal = terminal} :=
    ⟨ThetaIndeterminacyChoice.ordinary, rfl⟩
  exact Set.mem_iUnion.mpr ⟨choice, hx⟩

/-- In Kummer coordinates, the public terminal cylinder is exactly the
preimage of the concrete terminal coordinate condition. -/
theorem mem_publicTerminalCylinder_iff
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (terminal : Label)
    (x : P.Total) :
    x ∈ publicTerminalCylinder M t labelNat terminal ↔
      M.coordinates x terminal ∈
        t.qPowerRegion ((labelNat terminal) ^ 2) :=
  Iff.rfl

#print axioms terminalStabilizedPublicRealization_le_cylinder
#print axioms terminalStabilizedPublicUnion_le_cylinder
#print axioms ordinary_public_realization_le_union
#print axioms mem_publicTerminalCylinder_iff

end
end IUTTerminalPublicPacketEnvelope
end IUTThreeClosures
