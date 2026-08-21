import Iut.Cor312.ThetaData.AdmissiblePrime
import TateCurvesTheta.TateCurve.JInvariant
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace

/-!
# Local Tate q-size as a genuine finite-place `j`-height contribution

At a split multiplicative place, the Tate-curve identity

`‖j(E_q)‖ = ‖q‖⁻¹`

implies that the positive local logarithmic contribution of `j` is exactly
`-log ‖q‖`.  This file formalizes that identity first over an arbitrary
complete ultrametric field and then for every bad place carried by actual
initial theta data.

The theorem requires `‖12‖ = 1`, exactly as the current Tate-curve library's
norm theorem does.  Thus residue characteristics `2` and `3` must either be
handled separately as a finite exceptional contribution or covered by a
strengthened integral Tate-curve norm theorem.  The route is not discarded;
the exceptional-place term is one of the bounded complements isolated by
`GlobalQPilotReconstruction`.
-/

namespace IUTThreeClosures

open NumberField TateCurvesTheta Iut
open scoped BigOperators

/-- Over a complete ultrametric field, the local positive-log contribution of
the Tate `j`-invariant is exactly the absolute q-logarithm. -/
theorem posLog_norm_tateJ_eq_neg_log_norm_q
    {K : Type*} [NormedField K] [CompleteSpace K] [IsUltrametricDist K]
    (t : TateParameter K) (h12 : ‖(12 : K)‖ = 1) :
    Real.posLog ‖t.tateJ‖ = -Real.log ‖(t.q : K)‖ := by
  have hj : 1 < ‖t.tateJ‖ := t.one_lt_norm_tateJ h12
  have hjpos : 0 < ‖t.tateJ‖ := lt_trans zero_lt_one hj
  have hposlog : Real.posLog ‖t.tateJ‖ = Real.log ‖t.tateJ‖ := by
    apply Real.posLog_eq_log
    rw [abs_of_pos hjpos]
    exact hj.le
  rw [hposlog, t.norm_tateJ h12, Real.log_inv]

/-- Transport the local identity through the canonical embedding associated to
a finite place of a number field. -/
theorem finitePlace_posLog_eq_tateAbsLogQ
    {F : Type*} [Field F] [NumberField F]
    (w : FinitePlace F) (z : F)
    (t : TateParameter (Iut.localCompletion w))
    (hj : t.tateJ = FinitePlace.embedding w.maximalIdeal z)
    (h12 : ‖(12 : Iut.localCompletion w)‖ = 1) :
    Real.posLog (w z) = -Real.log ‖(t.q : Iut.localCompletion w)‖ := by
  calc
    Real.posLog (w z) =
        Real.posLog ‖FinitePlace.embedding w.maximalIdeal z‖ := by
      simpa using congrArg Real.posLog
        (FinitePlace.norm_embedding w.maximalIdeal z).symm
    _ = Real.posLog ‖t.tateJ‖ := by rw [hj]
    _ = -Real.log ‖(t.q : Iut.localCompletion w)‖ :=
      posLog_norm_tateJ_eq_neg_log_norm_q t h12

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- At every actual bad place of initial theta data, the local `j`-height
contribution is the norm q-size, away from the current library's `2,3`
exception. -/
theorem initialTheta_badPlace_posLog_eq_tateAbsLogQ
    (D : InitialThetaData AG TG)
    (w : FinitePlace D.F)
    (hw : w ∈ badPlacesOver D.F D.E D.VBad)
    (h12 : ‖(12 : Iut.localCompletion w)‖ = 1) :
    Real.posLog (w D.E.j) =
      -Real.log ‖((D.prime.tate w hw).q : Iut.localCompletion w)‖ := by
  exact finitePlace_posLog_eq_tateAbsLogQ w D.E.j
    (D.prime.tate w hw) (D.prime.tateJ_eq w hw) h12

/-- The selected bad-place packet built directly from the actual Tate
parameters, without an independent real weight function. -/
noncomputable def selectedBadPlaceTateAbsLogQ
    (D : InitialThetaData AG TG) (Q : QPilotData D) : ℝ :=
  ∑ w ∈ Q.badFinset.attach,
    -Real.log ‖((D.prime.tate w.1 (Q.mem_bad w.2)).q :
      Iut.localCompletion w.1)‖

/-- The corresponding selected finite-place positive-log contribution of the
global elliptic `j`-invariant. -/
noncomputable def selectedBadPlaceJContribution
    (D : InitialThetaData AG TG) (Q : QPilotData D) : ℝ :=
  ∑ w ∈ Q.badFinset.attach, Real.posLog (w.1 D.E.j)

/-- Away from residue characteristics where the current Tate norm theorem
needs a separate argument, the actual q-packet is exactly the selected
finite-place `j`-height contribution. -/
theorem selectedBadPlaceTateAbsLogQ_eq_JContribution
    (D : InitialThetaData AG TG) (Q : QPilotData D)
    (h12 : ∀ w : FinitePlace D.F,
      w ∈ Q.badFinset → ‖(12 : Iut.localCompletion w)‖ = 1) :
    selectedBadPlaceTateAbsLogQ D Q =
      selectedBadPlaceJContribution D Q := by
  classical
  rw [selectedBadPlaceTateAbsLogQ, selectedBadPlaceJContribution]
  apply Finset.sum_congr rfl
  intro w hw
  have hlocal := initialTheta_badPlace_posLog_eq_tateAbsLogQ
    D w.1 (Q.mem_bad w.2) (h12 w.1 (by simpa using w.2))
  linarith

end IUTThreeClosures
