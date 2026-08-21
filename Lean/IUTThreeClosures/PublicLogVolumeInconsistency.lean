import Iut.Cor312.LogVolume
import IUTThreeClosures.GeneratedSource

/-!
# Inconsistency of the public total log-volume translation law

`Iut.LogVolumeData.componentVol_prime_preimage` is quantified over every set
`U`. Taking `U = ∅`, multiplication-preimage preserves the empty set, so the
axiom states

`vol(∅) = vol(∅) + log p`.

For a rational prime `p`, `log p > 0`, hence this is impossible. Therefore a
public `LogVolumeData D` cannot exist as soon as one nonarchimedean packet has
a component.

For an actual initial theta datum the stronger conclusion is unconditional.
Its valuation section supplies a finite place of the torsion field, the
container compatibility sends this place to a finite rational place, and the
standard procession is nonempty because `ℓ ≥ 5`. Thus every public
`GeneratedRHSData`, every `GeneratedNativeSource`, and every pointwise source
family on a nonempty input type are uninhabited.

This is not a counterexample to the Haar-volume calculation used in IUT. It is
a formal specification bug: the translation law must be restricted to the
finite, positive-volume domain (or the codomain must include infinities).
Until the interface is repaired, an actual IUT III source inhabitant cannot be
constructed honestly in the public types.
-/

namespace IUTThreeClosures

open Iut NumberField

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

private theorem residueChar_ne_zero
    {K : Type*} [Field K] [NumberField K]
    (wK : FinitePlace K) : Iut.residueChar wK ≠ 0 := by
  unfold Iut.residueChar
  exact CharP.char_ne_zero_of_finite _ _

/-- Every public generated RHS over actual initial theta data is impossible.
The finite component is constructed from the valuation section at one chosen
bad place. -/
theorem not_nonempty_generatedRHSData
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    (Dθ : InitialThetaData AG TG) :
    ¬ Nonempty (GeneratedRHSData.{u₂, v, w} Dθ) := by
  rintro ⟨G⟩
  have hn : 0 < (Dθ.ℓ - 1) / 2 := by
    have h5 := Dθ.prime.five_le
    omega
  have hlen : G.container.proc.length = (Dθ.ℓ - 1) / 2 := by
    rw [G.proc_standard]
    rfl
  have hlenpos : 0 < G.container.proc.length := by
    rw [hlen]
    exact hn
  let i : Fin G.container.proc.length := ⟨0, hlenpos⟩
  rcases Dθ.global.bad_nonempty with ⟨vmod, hvmod⟩
  let wK : FinitePlace ↥Dθ.prime.torsionField :=
    Dθ.localData.sect.sectFin vmod
  have hres := G.toRational_finite wK
  cases hq : G.container.toRational (Place.finite wK) with
  | infinite =>
      rw [hq, RationalPlace.residueChar_infinite] at hres
      exact residueChar_ne_zero wK hres.symm
  | finite p =>
      let fv : G.container.Fiber (.finite p) :=
        ⟨Place.finite wK, hq⟩
      let c : G.container.Components i (.finite p) := fun _ => fv
      exact not_generatedRHSData_of_nonarch_component G i p c

/-- No actual public generated native source can be constructed. -/
theorem not_nonempty_generatedNativeSource
    {AG : AnabelianGeometry.{u₂}}
    {TG : TemperedGeometry AG}
    (Dθ : InitialThetaData AG TG)
    (Q : QPilotData Dθ) :
    ¬ Nonempty (GeneratedNativeSource.{u₂, v, w} Dθ Q) := by
  rintro ⟨S⟩
  exact not_nonempty_generatedRHSData Dθ ⟨S.rhs⟩

/-- On every inhabited arithmetic input type, the public pointwise IUT III
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