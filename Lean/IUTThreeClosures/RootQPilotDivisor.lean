import Mathlib

/-!
# The root q-divisor calibration

IUT I defines the local pilot generator by a `2ℓ`-th root of the Tate
parameter.  IUT IV identifies `|log q|` with `1/(2ℓ)` times the normalized
degree of the arithmetic q-divisor.  This module formalizes the purely linear
part of that identification.
-/

namespace IUTThreeClosures

universe u

variable {A : Type u} [AddCommGroup A] [Module ℝ A]

structure RootQPilotDegreeData where
  degree : A →ₗ[ℝ] ℝ
  qDivisor : A
  ell : ℕ
  ell_pos : 0 < ell
  logQ : ℝ
  qDivisor_degree : degree qDivisor = logQ

namespace RootQPilotDegreeData

noncomputable def scale (D : RootQPilotDegreeData (A := A)) : ℝ :=
  1 / (2 * (D.ell : ℝ))

noncomputable def qPilotDivisor (D : RootQPilotDegreeData (A := A)) : A :=
  D.scale • D.qDivisor

noncomputable def absLogQ (D : RootQPilotDegreeData (A := A)) : ℝ :=
  D.logQ / (2 * (D.ell : ℝ))

theorem scale_eq (D : RootQPilotDegreeData (A := A)) :
    D.scale = 1 / (2 * (D.ell : ℝ)) := rfl

theorem degree_qPilotDivisor
    (D : RootQPilotDegreeData (A := A)) :
    D.degree D.qPilotDivisor = D.absLogQ := by
  rw [qPilotDivisor, map_smul, D.qDivisor_degree]
  unfold scale absLogQ
  ring

theorem signedVolume_qPilotDivisor
    (D : RootQPilotDegreeData (A := A))
    (signedVolume : A → ℝ)
    (hVolume : ∀ x, signedVolume x = -D.degree x) :
    signedVolume D.qPilotDivisor = -D.absLogQ := by
  rw [hVolume, D.degree_qPilotDivisor]

end RootQPilotDegreeData
end IUTThreeClosures
