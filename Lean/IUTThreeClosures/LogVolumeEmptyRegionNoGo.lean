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
impossible.

The consequences formalized below are stronger than a missing implementation:

* every log-volume datum with one finite-prime packet component is contradictory;
* every `GeneratedRHSData` for actual initial theta-data is contradictory;
* therefore `GeneratedNativeSource`, an inhabited pointwise IUT III family, an
  upstream certificate, and the current four-stage program are uninhabited whenever
  the arithmetic input type is inhabited.

This no-go theorem identifies a precise repair obligation in the dependency: the
prime-scaling law must be restricted to an appropriate nonempty finite-positive-volume
class (or the codomain must model zero/infinite volume), rather than quantified over all
sets.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut
open NumberField

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

/-- Every number field has at least one finite place. -/
theorem finitePlace_nonempty
    (K : Type u) [Field K] [NumberField K] :
    Nonempty (FinitePlace K) := by
  have hbot : (⊥ : Ideal (𝓞 K)) ≠ ⊤ := bot_ne_top
  obtain ⟨P, _⟩ :=
    (IsDedekindDomain.HeightOneSpectrum.ideal_ne_top_iff_exists
      (NumberField.RingOfIntegers.not_isField K) (⊥ : Ideal (𝓞 K))).1 hbot
  exact ⟨FinitePlace.mk P⟩

/-- The residue characteristic of a finite place of a number field is nonzero. -/
theorem finitePlace_residueChar_ne_zero
    {K : Type u} [Field K] [NumberField K]
    (x : FinitePlace K) : residueChar x ≠ 0 := by
  unfold residueChar
  exact CharP.ringChar_ne_zero_of_finite
    (𝓞 K ⧸ x.maximalIdeal.asIdeal)

namespace GeneratedRHSData

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The current public `GeneratedRHSData` type is uninhabited. Its standard procession
is nonempty because the admissible prime is at least five, while every number field has
a finite place. The required rational-place compatibility puts that place into a
finite-prime fiber, where the empty-region log-volume contradiction applies. -/
theorem contradiction (G : GeneratedRHSData.{u, v, w} D) : False := by
  have hfive : 5 ≤ D.ℓ := D.prime.five_le
  have hn : 0 < (D.ℓ - 1) / 2 := by omega
  have hlen : 0 < G.container.proc.length := by
    rw [G.proc_standard]
    exact hn
  rcases finitePlace_nonempty (↥D.prime.torsionField) with ⟨x⟩
  cases hq : G.container.toRational (Place.finite x) with
  | finite p =>
      let v₀ : G.container.Fiber (.finite p) := ⟨Place.finite x, hq⟩
      exact logVolumeData_empty_region_contradiction_of_fiber G.vol hlen p v₀
  | infinite =>
      have h := G.toRational_finite x
      rw [hq] at h
      have hzero : residueChar x = 0 := by simpa using h.symm
      exact finitePlace_residueChar_ne_zero x hzero

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
