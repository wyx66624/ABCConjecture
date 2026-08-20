/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ThreeClosureTheorems

/-!
# Circularity audit for the third closure

The field called `actualIUTIVDownstream` in `ThreeClosureCertificate` already has the
abc conjecture as its codomain.  Once a pointwise IUT III family is available, the
inhabitation of `UniformDownstream F Target` is logically equivalent to `Target`.
Thus merely packaging the third closure does not prove any new mathematics.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {Target : Prop}

/-- For a fixed pointwise source family, a `UniformDownstream` object is inhabited if
and only if its target proposition is true. -/
theorem nonempty_uniformDownstream_iff_target
    (F : PointwiseIUTIIIFamily.{u, v, w, z} (AG := AG) (TG := TG) Input) :
    Nonempty (UniformDownstream F Target) ↔ Target := by
  constructor
  · rintro ⟨R⟩
    exact R.target
  · intro h
    exact ⟨{ close := fun _ => h }⟩

/-- The genuinely upstream portion of the original three-closure package. -/
structure UpstreamCertificate : Type
    (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  actualInitialThetaDataOf :
    Input → InitialThetaData AG TG
  actualQPilotDataOf :
    ∀ x, QPilotData (actualInitialThetaDataOf x)
  actualIUTIIIOutputSourceOf :
    ∀ x, GeneratedNativeSource.{u, v, w}
      (actualInitialThetaDataOf x)
      (actualQPilotDataOf x)

namespace UpstreamCertificate

/-- The pointwise IUT III family encoded by an upstream certificate. -/
noncomputable def family
    (U : UpstreamCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    PointwiseIUTIIIFamily.{u, v, w, z} (AG := AG) (TG := TG) Input where
  data := U.actualInitialThetaDataOf
  qPilot := U.actualQPilotDataOf
  source := U.actualIUTIIIOutputSourceOf

end UpstreamCertificate

namespace ThreeClosureCertificate

/-- Forget the downstream field. -/
noncomputable def toUpstream
    (C : ThreeClosureCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    UpstreamCertificate.{u, v, w, z} (AG := AG) (TG := TG) (Input := Input) where
  actualInitialThetaDataOf := C.actualInitialThetaDataOf
  actualQPilotDataOf := C.actualQPilotDataOf
  actualIUTIIIOutputSourceOf := C.actualIUTIIIOutputSourceOf

end ThreeClosureCertificate

/-- Exact circularity statement: the original three-closure certificate is inhabited
precisely when an upstream source family exists and the abc conjecture is already true. -/
theorem nonempty_threeClosureCertificate_iff :
    Nonempty (ThreeClosureCertificate.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) ↔
      Nonempty (UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) ∧ ABCConjecture := by
  constructor
  · rintro ⟨C⟩
    exact ⟨⟨C.toUpstream⟩, C.abc_conjecture_of_three_closures⟩
  · rintro ⟨⟨U⟩, habc⟩
    exact ⟨{
      actualInitialThetaDataOf := U.actualInitialThetaDataOf
      actualQPilotDataOf := U.actualQPilotDataOf
      actualIUTIIIOutputSourceOf := U.actualIUTIIIOutputSourceOf
      actualIUTIVDownstream := fun _ => habc
    }⟩

end IUTThreeClosures
