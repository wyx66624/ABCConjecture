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

This is not a counterexample to the Haar-volume calculation used in IUT. It is
a formal specification bug: the translation law must be restricted to the
finite, positive-volume domain (or the codomain must include infinities).
Until the interface is repaired, an actual IUT III source inhabitant cannot be
constructed honestly whenever its container contains a finite packet
component.
-/

namespace IUTThreeClosures

open Iut

universe u₁ u₂ v w

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

end IUTThreeClosures