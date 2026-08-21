import IUTThreeClosures.PublicLogVolumeInconsistency
import IUTThreeClosures.FourOpenConstructions

/-!
# The current public source programme is uninhabited

The empty-region contradiction in `PublicLogVolumeInconsistency` propagates to
the exact research-level certificate types. On any inhabited input type:

* no `UpstreamCertificate` exists;
* no `FourStageProgram` exists;
* hence the current public interfaces cannot yield a parameter-free
  `abc_conjecture` by inhabitation.

This is a theorem about the present Lean specification, not about the intended
finite-positive Haar-volume mathematics. The corrected programme must use the
honest finite-positive volume domain before the geometric inhabitants can be
constructed.
-/

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable (Input : Type z) [Nonempty Input]

/-- The current upstream certificate is impossible on a nonempty input type. -/
theorem not_nonempty_upstreamCertificate :
    ¬ Nonempty
      (UpstreamCertificate.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨U⟩
  have hfamily : Nonempty
      (PointwiseIUTIIIFamily.{u, v, w, z}
        (AG := AG) (TG := TG) Input) :=
    ⟨U.family⟩
  exact not_nonempty_pointwiseIUTIIIFamily
    (AG := AG) (TG := TG) (v := v) (w := w) Input hfamily

/-- The current four-stage record is impossible on a nonempty input type. -/
theorem not_nonempty_fourStageProgram :
    ¬ Nonempty
      (FourStageProgram.{u, v, w, z}
        (AG := AG) (TG := TG) (Input := Input)) := by
  rintro ⟨P⟩
  exact not_nonempty_upstreamCertificate
    (AG := AG) (TG := TG) (v := v) (w := w) Input ⟨P.upstream⟩

/-- The exact public inhabitation proposition is false. -/
theorem not_fourStagesInhabited :
    ¬ FourStagesInhabited.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input) :=
  not_nonempty_fourStageProgram
    (AG := AG) (TG := TG) (v := v) (w := w) Input

end IUTThreeClosures