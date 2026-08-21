import IUTThreeClosures.CorrectedQPilotDivisor
import IUTThreeClosures.RootQPilotDivisor

/-!
# Exact root-exponent normalization of the arithmetic q-pilot

The `2ℓ`-th-root normalization is not an asymptotic error.  Once the q-pilot
is defined from the arithmetic q-divisor, its absolute logarithm is exactly

`logQ / (2ℓ)`.

This file records the corresponding correction term and proves that it is
identically zero.  Under the explicit public weight-compatibility condition,
the source-faithful arithmetic normalization agrees exactly with the public
`QPilotData.absLogQ`.  Thus the root-normalization entry in the global packet
reconstruction has uniform bound `0`; the remaining work is the geometric
identification of the actual pilot object with this divisor normalization.
-/

namespace IUTThreeClosures

open Iut

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The discrepancy between the source-faithful arithmetic root normalization
and the prescribed `1/(2ℓ)` scalar. -/
noncomputable def arithmeticRootNormalizationError
    (Q : QPilotData D) : ℝ :=
  arithmeticAbsLogQ Q - arithmeticLogQ Q / (2 * (D.ℓ : ℝ))

/-- Root-exponent normalization is exact: its correction term is zero. -/
@[simp]
theorem arithmeticRootNormalizationError_eq_zero
    (Q : QPilotData D) :
    arithmeticRootNormalizationError Q = 0 := by
  unfold arithmeticRootNormalizationError arithmeticAbsLogQ
  ring

/-- Point-independent upper bound for the root-normalization correction. -/
theorem arithmeticRootNormalizationError_le_zero
    (Q : QPilotData D) :
    arithmeticRootNormalizationError Q ≤ 0 := by
  rw [arithmeticRootNormalizationError_eq_zero]

/-- The corresponding uniform boundedness statement. -/
theorem arithmeticRootNormalization_uniform :
    ∀ Q : QPilotData D, arithmeticRootNormalizationError Q ≤ 0 :=
  arithmeticRootNormalizationError_le_zero

/-- Under the exact arithmetic-place weight compatibility, the corrected
absolute q-logarithm equals the public absolute q-logarithm. -/
theorem arithmeticAbsLogQ_eq_publicAbsLogQ
    (Q : QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    arithmeticAbsLogQ Q = Q.absLogQ := by
  unfold arithmeticAbsLogQ QPilotData.absLogQ
  rw [arithmeticLogQ_eq_publicLogQ Q hcompat]

/-- Hence the public/source discrepancy in the root exponent also vanishes
under weight compatibility. -/
noncomputable def publicRootNormalizationError
    (Q : QPilotData D) : ℝ :=
  Q.absLogQ - arithmeticAbsLogQ Q

@[simp]
theorem publicRootNormalizationError_eq_zero
    (Q : QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    publicRootNormalizationError Q = 0 := by
  unfold publicRootNormalizationError
  rw [arithmeticAbsLogQ_eq_publicAbsLogQ Q hcompat]
  ring

/-- A ready-to-use reconstruction term: root normalization contributes no
error once the source/public weight comparison has been proved. -/
theorem publicRootNormalizationError_le_zero
    (Q : QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    publicRootNormalizationError Q ≤ 0 := by
  rw [publicRootNormalizationError_eq_zero Q hcompat]

end IUTThreeClosures
