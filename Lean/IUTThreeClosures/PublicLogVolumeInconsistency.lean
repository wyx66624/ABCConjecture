import Iut.Cor312.LogVolume
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.QuantifierCorrectClosure

/-!
# Inconsistency of the public total log-volume translation law

`Iut.LogVolumeData.componentVol_prime_preimage` is quantified over every set
`U`. Taking `U = ∅`, multiplication-preimage preserves the empty set, so the
axiom states

`vol(∅) = vol(∅) + log p`.

For a rational prime `p`, `log p > 0`, hence this is impossible. Moreover the
normalization of the place weights forces every rational-place fiber to be
nonempty. Consequently every container with a nonempty procession has a
nonarchimedean packet component, so its public `LogVolumeData` is uninhabited.
Since the standard procession attached to initial theta data has positive
length for `ℓ ≥ 5`, the current public generated IUT III source types are
uninhabited without any additional arithmetic-place hypothesis.

This is not a counterexample to the Haar-volume calculation used in IUT. It is
a formal specification bug: the translation law must be restricted to the
finite, positive-volume domain (or the codomain must include infinities).
-/

namespace IUTThreeClosures

open Iut

universe u₁ u₂ v w z

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

/-- One nonarchimedean packet component contradicts the current total
translation law. -/
theorem not_logVolumeData_of_nonarch_component
    (i : Fin D.proc.length) (p : Nat.Primes)
    (c : D.Components i (.finite p)) :
    ¬ Nonempty (LogVolumeData D) := by
  rintro ⟨vol⟩
  have h := vol.componentVol_prime_preimage i p c
    (∅ : Set ((D.packet i (.finite p)).Summand c))
  have heq :
      vol.componentVol i (.finite p) c ∅ =
        vol.componentVol i (.finite p) c ∅ + Real.log (p : ℕ) := by
    simpa using h
  have hp : 0 < Real.log (p : ℕ) := by
    apply Real.log_pos
    exact_mod_cast p.2.one_lt
  linarith

/-- An inhabited component type at a finite rational place rules out public
log-volume data. -/
theorem not_logVolumeData_of_nonempty_components
    (i : Fin D.proc.length) (p : Nat.Primes)
    [Nonempty (D.Components i (.finite p))] :
    ¬ Nonempty (LogVolumeData D) := by
  rcases (inferInstance : Nonempty (D.Components i (.finite p))) with ⟨c⟩
  exact not_logVolumeData_of_nonarch_component i p c

/-- The normalized weight sum forces every rational-place fiber to be
nonempty. -/
theorem nonempty_fiber_of_logVolumeData
    (vol : LogVolumeData D) (vQ : RationalPlace) :
    Nonempty (D.Fiber vQ) := by
  classical
  by_contra h
  have hzero :
      (∑ x : D.Fiber vQ, vol.weight vQ x) = 0 := by
    apply Finset.sum_eq_zero
    intro x hx
    exact (h ⟨x⟩).elim
  have hone := vol.weight_sum_one vQ
  rw [hzero] at hone
  norm_num at hone

/-- Every finite rational place therefore has a packet component. -/
theorem nonempty_components_of_logVolumeData
    (vol : LogVolumeData D)
    (i : Fin D.proc.length) (p : Nat.Primes) :
    Nonempty (D.Components i (.finite p)) := by
  let x : D.Fiber (.finite p) :=
    Classical.choice (nonempty_fiber_of_logVolumeData vol (.finite p))
  exact ⟨fun _ => x⟩

/-- A nonempty procession is enough to rule out the current public
`LogVolumeData`: use the rational prime `2` and the fiber supplied by the
weight normalization. -/
theorem not_logVolumeData_of_procession_pos
    (hlen : 0 < D.proc.length) :
    ¬ Nonempty (LogVolumeData D) := by
  rintro ⟨vol⟩
  let i : Fin D.proc.length := ⟨0, hlen⟩
  let p : Nat.Primes := ⟨2, Nat.prime_two⟩
  rcases nonempty_components_of_logVolumeData vol i p with ⟨c⟩
  exact not_logVolumeData_of_nonarch_component i p c ⟨vol⟩

/-- Any generated RHS whose container has a finite packet component is
uninhabited, because it contains public `LogVolumeData`. -/
theorem not_generatedRHSData_of_nonarch_component
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    {Dθ : InitialThetaData AG TG}
    (G : GeneratedRHSData.{u₂, v, w} Dθ)
    (i : Fin G.container.proc.length) (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) : False := by
  exact not_logVolumeData_of_nonarch_component i p c ⟨G.vol⟩

/-- Every current public generated RHS over initial theta data is uninhabited.
The standard procession has positive length because the admissible prime is at
least five. -/
theorem not_nonempty_generatedRHSData
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    (Dθ : InitialThetaData AG TG) :
    ¬ Nonempty (GeneratedRHSData.{u₂, v, w} Dθ) := by
  rintro ⟨G⟩
  have hn : 0 < (Dθ.ℓ - 1) / 2 := by
    have h5 := Dθ.prime.five_le
    omega
  have hlen : 0 < G.container.proc.length := by
    rw [G.proc_standard]
    simpa using hn
  exact (not_logVolumeData_of_procession_pos
    (D := G.container) hlen) ⟨G.vol⟩

/-- Hence no current public generated native source can be constructed. -/
theorem not_nonempty_generatedNativeSource
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    (Dθ : InitialThetaData AG TG)
    (Q : QPilotData Dθ) :
    ¬ Nonempty (GeneratedNativeSource.{u₂, v, w} Dθ Q) := by
  rintro ⟨S⟩
  exact not_nonempty_generatedRHSData Dθ ⟨S.rhs⟩

/-- On every inhabited input type, the current public pointwise IUT III source
family is uninhabited. -/
theorem not_nonempty_pointwiseIUTIIIFamily
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    (Input : Type z) [Nonempty Input] :
    ¬ Nonempty
      (PointwiseIUTIIIFamily.{u₂, v, w, z}
        (AG := AG) (TG := TG) Input) := by
  rintro ⟨F⟩
  rcases (inferInstance : Nonempty Input) with ⟨x⟩
  exact not_nonempty_generatedNativeSource (F.data x) (F.qPilot x)
    ⟨F.source x⟩

end IUTThreeClosures
