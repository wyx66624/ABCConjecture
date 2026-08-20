import Iut.Cor312.LeftHandSide
import Iut.Cor312.LogVolume

/-!
# From capsule-wise q-pilot calibration to procession calibration
-/

namespace Iut

universe u₁ u₂ v

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

theorem LogVolumeData.processionVol_eq_of_globalVol_eq
    (vol : LogVolumeData D)
    (R : ∀ i : Fin D.proc.length, D.AdmissibleRegion i)
    (q : ℝ)
    (hglobal : ∀ i, vol.globalVol (R i) = q)
    (hlength : 0 < D.proc.length) :
    vol.processionVol R = q := by
  have hsum :
      (∑ i : Fin D.proc.length, vol.globalVol (R i)) =
        (D.proc.length : ℝ) * q := by
    simp [hglobal]
  rw [LogVolumeData.processionVol, hsum]
  have hne : (D.proc.length : ℝ) ≠ 0 := by
    exact_mod_cast hlength.ne'
  field_simp

structure NativeQPilotCalibration
    (vol : LogVolumeData D)
    (R : ∀ i : Fin D.proc.length, D.AdmissibleRegion i)
    (qSigned : ℝ) where
  procession_nonempty : 0 < D.proc.length
  capsule_global_volume : ∀ i, vol.globalVol (R i) = qSigned

namespace NativeQPilotCalibration

theorem processionVolume
    {vol : LogVolumeData D}
    {R : ∀ i : Fin D.proc.length, D.AdmissibleRegion i}
    {qSigned : ℝ}
    (C : NativeQPilotCalibration vol R qSigned) :
    vol.processionVol R = qSigned :=
  vol.processionVol_eq_of_globalVol_eq R qSigned
    C.capsule_global_volume C.procession_nonempty

end NativeQPilotCalibration
end Iut
