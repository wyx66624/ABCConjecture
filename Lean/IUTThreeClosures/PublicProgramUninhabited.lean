import IUTThreeClosures.PublicLogVolumeInconsistency
import IUTThreeClosures.FourOpenConstructions

/-!
# Finite-component obstruction for the current public source programme

The current public `LogVolumeData` translation law is inconsistent as soon as
one nonarchimedean packet component exists.  This file propagates that precise
obstruction to the research-level source and four-stage programme types.

Unlike an earlier draft, it does not assert that every abstract public source
has such a component.  That final existence step depends on the intended
number-field packet construction and must be proved separately.  The results
below say exactly what follows once a concrete finite component has been
constructed.
-/

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- A concrete nonarchimedean component in one member of a pointwise public
IUT III source family. -/
structure PublicFiniteComponent
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) where
  x : Input
  i : Fin (F.source x).rhs.container.proc.length
  p : Nat.Primes
  c : (F.source x).rhs.container.Components i (.finite p)

namespace PublicFiniteComponent

/-- A concrete finite component contradicts the public total log-volume law. -/
theorem false
    {F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input}
    (W : PublicFiniteComponent F) : False :=
  not_generatedRHSData_of_nonarch_component
    (F.source W.x).rhs W.i W.p W.c

end PublicFiniteComponent

/-- An upstream certificate is impossible whenever one constructs a finite
component in its associated public source family. -/
theorem upstreamCertificate_false_of_finite_component
    (U : UpstreamCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input))
    (W : PublicFiniteComponent U.family) : False :=
  W.false

/-- A four-stage programme is impossible whenever one constructs a finite
component in its associated public source family. -/
theorem fourStageProgram_false_of_finite_component
    (P : FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input))
    (W : PublicFiniteComponent P.upstream.family) : False :=
  W.false

/-- If every candidate upstream certificate necessarily carries a concrete
finite component, then the current public upstream type is uninhabited. -/
theorem not_nonempty_upstreamCertificate_of_finite_components
    (hcomponent :
      ∀ U : UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input),
        Nonempty (PublicFiniteComponent U.family)) :
    ¬ Nonempty
      (UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨U⟩
  rcases hcomponent U with ⟨W⟩
  exact W.false

/-- The corresponding conditional obstruction for the four-stage programme. -/
theorem not_nonempty_fourStageProgram_of_finite_components
    (hcomponent :
      ∀ P : FourStageProgram.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input),
        Nonempty (PublicFiniteComponent P.upstream.family)) :
    ¬ Nonempty
      (FourStageProgram.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨P⟩
  rcases hcomponent P with ⟨W⟩
  exact W.false

end IUTThreeClosures
