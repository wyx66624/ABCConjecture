import IUTThreeClosures.CompleteGlobalJPacket
import IUTThreeClosures.TateLocalQJContribution

/-!
# Reconstructing the global `j`-height from selected bad-place Tate data

A selected bad-place Tate packet is only part of the finite contribution to a
global Weil height. This module makes the missing complement canonical:

`omittedFinite = completeFinite - selectedBad`.

It then proves an exact all-place reconstruction using the selected Tate
q-sizes, the omitted finite contribution, and the weighted archimedean
contribution. No real-valued error function is supplied independently; every
term is derived from the initial theta data and the number-field height.

To turn this identity into the uniform reverse q-pilot bound required by abc,
one must still prove that the omitted-finite, procession, different and root
normalization terms of the actual multiradial packet have a point-independent
upper bound. The exact identity here prevents those terms from being hidden
inside an opaque bridge field.
-/

namespace IUTThreeClosures

open Iut NumberField

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- The canonical finite-place contribution omitted by the selected bad-place
set. It is defined from the complete height decomposition and the actual
selected places, not as an arbitrary correction. -/
noncomputable def omittedFiniteJContribution
    (D : InitialThetaData AG TG) (Q : QPilotData D) : ℝ :=
  completeFiniteJContribution D.F D.E.j -
    selectedBadPlaceJContribution D Q

/-- Selected and omitted finite contributions reconstruct the complete finite
part exactly. -/
theorem selected_add_omitted_eq_completeFinite
    (D : InitialThetaData AG TG) (Q : QPilotData D) :
    selectedBadPlaceJContribution D Q +
        omittedFiniteJContribution D Q =
      completeFiniteJContribution D.F D.E.j := by
  unfold omittedFiniteJContribution
  ring

/-- The selected-place reconstruction of the normalized global height. -/
noncomputable def selectedBadPlaceGlobalPacket
    (D : InitialThetaData AG TG) (Q : QPilotData D) : ℝ :=
  (selectedBadPlaceJContribution D Q +
      omittedFiniteJContribution D Q +
      completeArchimedeanJContribution D.F D.E.j) /
    (Module.finrank ℚ D.F : ℝ)

/-- The selected-place packet plus its canonical complement is exactly the
complete all-place packet. -/
theorem selectedBadPlaceGlobalPacket_eq_complete
    (D : InitialThetaData AG TG) (Q : QPilotData D) :
    selectedBadPlaceGlobalPacket D Q =
      completeGlobalJPacket D.F D.E.j := by
  unfold selectedBadPlaceGlobalPacket completeGlobalJPacket
  rw [selected_add_omitted_eq_completeFinite]
  ring

/-- Therefore the reconstructed selected-place packet is the actual absolute
normalized Weil height of the global elliptic `j`-invariant. -/
theorem selectedBadPlaceGlobalPacket_eq_height
    (D : InitialThetaData AG TG) (Q : QPilotData D) :
    selectedBadPlaceGlobalPacket D Q =
      Heights.normalizedLogHeight D.F D.E.j := by
  rw [selectedBadPlaceGlobalPacket_eq_complete,
    completeGlobalJPacket_eq_normalizedLogHeight]

/-- Reconstructed packet using the actual selected Tate q-sizes rather than
local `j`-values. -/
noncomputable def selectedTateGlobalPacket
    (D : InitialThetaData AG TG) (Q : QPilotData D) : ℝ :=
  (selectedBadPlaceTateAbsLogQ D Q +
      omittedFiniteJContribution D Q +
      completeArchimedeanJContribution D.F D.E.j) /
    (Module.finrank ℚ D.F : ℝ)

/-- Away from the current Tate library's residue-characteristic `2,3`
exception, the actual selected Tate q-packet reconstructs the global
normalized `j`-height exactly after adjoining the canonical finite and
archimedean complements. -/
theorem selectedTateGlobalPacket_eq_height
    (D : InitialThetaData AG TG) (Q : QPilotData D)
    (h12 : ∀ w : FinitePlace D.F,
      w ∈ Q.badFinset → ‖(12 : Iut.localCompletion w)‖ = 1) :
    selectedTateGlobalPacket D Q =
      Heights.normalizedLogHeight D.F D.E.j := by
  rw [selectedTateGlobalPacket,
    selectedBadPlaceTateAbsLogQ_eq_JContribution D Q h12]
  simpa [selectedBadPlaceGlobalPacket] using
    selectedBadPlaceGlobalPacket_eq_height D Q

/-- If the canonical omitted finite and archimedean complement is uniformly
bounded above, then the selected Tate q-size controls the global `j`-height in
the required direction. -/
theorem normalizedLogHeight_le_selectedTate_add
    (D : InitialThetaData AG TG) (Q : QPilotData D)
    (h12 : ∀ w : FinitePlace D.F,
      w ∈ Q.badFinset → ‖(12 : Iut.localCompletion w)‖ = 1)
    {C : ℝ}
    (hcomplement :
      omittedFiniteJContribution D Q +
          completeArchimedeanJContribution D.F D.E.j ≤ C) :
    Heights.normalizedLogHeight D.F D.E.j ≤
      selectedBadPlaceTateAbsLogQ D Q /
          (Module.finrank ℚ D.F : ℝ) +
        C / (Module.finrank ℚ D.F : ℝ) := by
  have hdeg : (0 : ℝ) < Module.finrank ℚ D.F :=
    Heights.numberFieldDegree_pos D.F
  rw [← selectedTateGlobalPacket_eq_height D Q h12]
  unfold selectedTateGlobalPacket
  calc
    (selectedBadPlaceTateAbsLogQ D Q +
          omittedFiniteJContribution D Q +
          completeArchimedeanJContribution D.F D.E.j) /
        (Module.finrank ℚ D.F : ℝ) ≤
      (selectedBadPlaceTateAbsLogQ D Q + C) /
        (Module.finrank ℚ D.F : ℝ) := by
          apply (div_le_div_iff_of_pos_right hdeg).2
          linarith
    _ = selectedBadPlaceTateAbsLogQ D Q /
          (Module.finrank ℚ D.F : ℝ) +
        C / (Module.finrank ℚ D.F : ℝ) := by ring

end IUTThreeClosures
