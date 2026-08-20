/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BridgeInhabitationAudit

/-!
# Empty-region obstruction in the public log-volume interface

`Iut.LogVolumeData.componentVol_prime_preimage` currently requires the prime-scaling
identity for every set. Substituting the empty set makes the preimage equal to the
empty set and forces `x = x + log p` for a rational prime `p`. Since `p > 1`, this is
impossible whenever a finite-prime packet component exists.

The weight-sum axiom independently forces every rational-place fiber to be inhabited.
Thus any `LogVolumeData` on a nonempty procession is contradictory. In particular,
the public `GeneratedRHSData`, `GeneratedNativeSource`, inhabited pointwise IUT III
families, upstream certificates, and four-stage programs are uninhabited in the current
interface.

The repair obligation lies in the dependency: the prime-scaling law must be restricted
to an appropriate nonempty finite-positive-volume class (or the codomain must model
zero/infinite volume), rather than quantified over all sets.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u₁ u₂ u v w z

/-- The all-sets prime-scaling axiom in `LogVolumeData` is inconsistent as soon as a
finite-prime component exists. -/
theorem logVolumeData_empty_region_contradiction_of_component
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}
    (vol : LogVolumeData D)
    (i : Fin D.proc.length)
    (p : Nat.Primes)
    (c : D.Components i (.finite p)) : False := by
  have h :
      vol.componentVol i (.finite p) c (∅) =
        vol.componentVol i (.finite p) c (∅) + Real.log (p : ℝ) := by
    simpa using vol.componentVol_prime_preimage i p c (∅)
  have hp : (1 : ℝ) < (p : ℝ) := by
    exact_mod_cast p.2.one_lt
  have hlog : 0 < Real.log (p : ℝ) := Real.log_pos hp
  linarith

/-- The equation saying that the weights in a fiber sum to one forces the fiber to be
inhabited. -/
theorem logVolumeData_fiber_nonempty
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}
    (vol : LogVolumeData D)
    (vQ : RationalPlace) : Nonempty (D.Fiber vQ) := by
  classical
  by_contra h
  have hz : ∀ x : D.Fiber vQ, vol.weight vQ x = 0 := by
    intro x
    exact (h ⟨x⟩).elim
  have hsum := vol.weight_sum_one vQ
  simpa [hz] using hsum

/-- A nonempty procession and one place over a finite rational prime produce a packet
component, so the empty-region contradiction applies. -/
theorem logVolumeData_empty_region_contradiction_of_fiber
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}
    (vol : LogVolumeData D)
    (hlen : 0 < D.proc.length)
    (p : Nat.Primes)
    (v₀ : D.Fiber (.finite p)) : False := by
  let i : Fin D.proc.length := ⟨0, hlen⟩
  let c : D.Components i (.finite p) := fun _ => v₀
  exact logVolumeData_empty_region_contradiction_of_component vol i p c

/-- Consequently, every public log-volume datum on a nonempty procession is
contradictory. -/
theorem logVolumeData_contradiction_of_nonempty_procession
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}
    (vol : LogVolumeData D)
    (hlen : 0 < D.proc.length) : False := by
  let p : Nat.Primes := ⟨2, by norm_num⟩
  rcases logVolumeData_fiber_nonempty vol (.finite p) with ⟨v₀⟩
  exact logVolumeData_empty_region_contradiction_of_fiber vol hlen p v₀

namespace GeneratedRHSData

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The current public `GeneratedRHSData` type is uninhabited. Its standard procession
is nonempty because the admissible prime is at least five, and its log-volume field is
already contradictory on any nonempty procession. -/
theorem contradiction (G : GeneratedRHSData.{u, v, w} D) : False := by
  have hfive : 5 ≤ D.ℓ := D.prime.five_le
  have hn : 0 < (D.ℓ - 1) / 2 := by omega
  have hlen : 0 < G.container.proc.length := by
    rw [G.proc_standard]
    exact hn
  exact logVolumeData_contradiction_of_nonempty_procession G.vol hlen

end GeneratedRHSData

namespace GeneratedNativeSource

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG} {Q : QPilotData D}

/-- No generated native source can inhabit the current interface. -/
theorem contradiction (S : GeneratedNativeSource.{u, v, w} D Q) : False :=
  S.rhs.contradiction

end GeneratedNativeSource

namespace PointwiseIUTIIIFamily

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- An inhabited input type rules out the current generated pointwise IUT III family. -/
theorem contradiction
    [Nonempty Input]
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) : False := by
  rcases (inferInstance : Nonempty Input) with ⟨x⟩
  exact (F.source x).contradiction

end PointwiseIUTIIIFamily

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- The current upstream certificate is uninhabited for every inhabited input type. -/
theorem not_nonempty_upstreamCertificate
    [Nonempty Input] :
    ¬ Nonempty (UpstreamCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨U⟩
  exact U.family.contradiction

/-- Consequently the current four-stage program cannot be inhabited, independently of
the downstream abc-equivalent bridge. -/
theorem not_nonempty_fourStageProgram
    [Nonempty Input] :
    ¬ Nonempty (FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨P⟩
  exact P.upstream.family.contradiction

end IUTThreeClosures
