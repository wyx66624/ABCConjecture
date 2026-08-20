import IUTThreeClosures.FiniteExceptionalSet
import Genl.GeneralPosition.HeightTheory

/-!
# Statement II from an estimate outside finite exceptional sets

This closes the finite-exception bookkeeping in Corollary 2.2. The source
must still prove that its Galois-finite exceptional locus has finite
intersection with the compact bounded-degree locus and must construct the
estimate outside that locus.
-/

namespace IUTThreeClosures

universe u

structure StatementIIOutsideFinite (T : Genl.HeightTheory.{u}) where
  exceptional : ∀ (d : ℕ) (ε : ℝ) (K : T.CBS), Finset (T.Pt T.tripod)
  estimate : ∀ (d : ℕ) (ε : ℝ), 0 < ε → ∀ K : T.CBS,
    ∃ B : ℝ, ∀ P ∈ T.cbsSet K ∩ T.ptLE T.tripod d,
      P ∉ exceptional d ε K →
      T.htCan T.tripod P ≤
        (1 + ε) *
          (T.logDiff T.tripod P + T.logCond T.tripod P) + B

namespace StatementIIOutsideFinite

/-- Finite exceptional sets can be absorbed into the BD constant on the
compact bounded-degree locus. -/
theorem statementII
    {T : Genl.HeightTheory.{u}}
    (D : StatementIIOutsideFinite T) : T.StatementII := by
  classical
  intro d ε hε K
  rcases D.estimate d ε hε K with ⟨B, hB⟩
  let S : Set (T.Pt T.tripod) := T.cbsSet K ∩ T.ptLE T.tripod d
  let rhs : T.Pt T.tripod → ℝ :=
    (1 + ε) • (T.logDiff T.tripod + T.logCond T.tripod)
  let E : Finset (T.Pt T.tripod) :=
    (D.exceptional d ε K).filter fun P => P ∈ S
  rcases exists_upper_bound_on_finset E
      (fun P => T.htCan T.tripod P - rhs P) with ⟨Cin, hCin⟩
  refine ⟨max B Cin, ?_⟩
  intro P hP
  by_cases hExc : P ∈ D.exceptional d ε K
  · have hPE : P ∈ E := by
      apply Finset.mem_filter.mpr
      refine ⟨hExc, ?_⟩
      simpa [S] using hP
    have h := hCin P hPE
    have hmax : Cin ≤ max B Cin := le_max_right _ _
    linarith
  · have h := hB P hP hExc
    have hmax : B ≤ max B Cin := le_max_left _ _
    simpa [rhs, Pi.add_apply, Pi.smul_apply, smul_eq_mul] using
      (show T.htCan T.tripod P ≤
        (1 + ε) *
          (T.logDiff T.tripod P + T.logCond T.tripod P) + max B Cin by
        linarith)

end StatementIIOutsideFinite
end IUTThreeClosures
