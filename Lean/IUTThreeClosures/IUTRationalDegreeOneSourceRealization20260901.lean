/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTRationalTripodShadowComparison20260901
import Genl.GeneralPosition.ProofPackage

/-!
# A source-faithful rational degree-one tripod realization

The mathematical proofs precede this module in
`research/ABC_IUT_RATIONAL_DEGREE_ONE_SOURCE_REALIZATION_2026_09_01.md`.

This file isolates the abstract core of the genuine rational-tripod source
calculation.  A realization maps open rational points to exact-degree-one
tripod points, identifies the pulled-back log-canonical height and conductor
with the elementary rational functions up to bounded discrepancy, and makes
the rational different zero.  Its restricted Statement I is exactly integer
abc.  No intended arithmetic `Genl.HeightTheory`, IUT theorem, Statement I, or
abc assertion is postulated here.
-/

namespace IUTThreeClosures
namespace IUTRationalDegreeOneSourceRealization20260901

open IUTAdmissibleVolumeIntegerBridge20260901
open IUTRationalTripodShadowComparison20260901

/-! ## Degree one is forced by the abstract recurrence -/

/-- In every `Genl.HeightTheory`, the degree-at-most-one and exact-degree-one
loci coincide.  This follows solely from `ptLE_zero` and `ptLE_succ`. -/
theorem ptLE_one_eq_ptEQ_one (T : Genl.HeightTheory) (X : T.Curve) :
    T.ptLE X 1 = T.ptEQ X 1 := by
  have h := T.ptLE_succ X 0
  simpa [T.ptLE_zero X] using h

/-- Exact-degree-one membership therefore supplies the degree-at-most-one
membership used by Statement I. -/
theorem mem_ptLE_one_of_mem_ptEQ_one
    (T : Genl.HeightTheory) (X : T.Curve) {x : T.Pt X}
    (hx : x ∈ T.ptEQ X 1) : x ∈ T.ptLE X 1 := by
  rwa [ptLE_one_eq_ptEQ_one T X]

/-! ## Source-faithful realization and restricted Statement I -/

/-- Source-faithful data for the positive rational chart of the genuine
degree-one tripod.

The exact arithmetic construction of these fields from
`(ℙ¹_ℚ, {0,1,∞})` is proved in the companion research note.  This structure is
an explicit interface; it is not asserted to be inhabited by the current
abstract LANA `HeightTheory`. -/
structure RationalDegreeOneSourceRealization (T : Genl.HeightTheory) where
  point : OpenUnitRational → T.Pt T.tripod
  point_mem_degreeOne : ∀ x, point x ∈ T.ptEQ T.tripod 1
  height_equiv :
    (fun x => T.htCan T.tripod (point x)) ≈[(Set.univ : Set OpenUnitRational)]
      openUnitHeight
  logDiff_eq_zero : ∀ x, T.logDiff T.tripod (point x) = 0
  conductor_equiv :
    (fun x => T.logCond T.tripod (point x)) ≈[(Set.univ : Set OpenUnitRational)]
      openUnitCounting

namespace RationalDegreeOneSourceRealization

variable {T : Genl.HeightTheory} (R : RationalDegreeOneSourceRealization T)

/-- Pulled-back source height. -/
noncomputable def sourceHeight (x : OpenUnitRational) : ℝ :=
  T.htCan T.tripod (R.point x)

/-- Pulled-back source different. -/
noncomputable def sourceDifferent (x : OpenUnitRational) : ℝ :=
  T.logDiff T.tripod (R.point x)

/-- Pulled-back source conductor. -/
noncomputable def sourceConductor (x : OpenUnitRational) : ℝ :=
  T.logCond T.tripod (R.point x)

/-- Statement I restricted to the realized positive rational degree-one
tripod chart.  The additive constant may depend on `ε`, but not on the point. -/
def RestrictedStatementI : Prop :=
  UniformOpenUnitBound R.sourceHeight R.sourceDifferent R.sourceConductor

/-- Exact-degree-one source points lie in the locus on which full Statement I
with `d = 1` is stated. -/
theorem point_mem_degreeAtMostOne (x : OpenUnitRational) :
    R.point x ∈ T.ptLE T.tripod 1 :=
  mem_ptLE_one_of_mem_ptEQ_one T T.tripod (R.point_mem_degreeOne x)

/-- The source-faithful realization extracts the earlier one-sided comparison.
The selected errors are the needed directions of the two BD equivalences. -/
noncomputable def toOpenUnitTripodComparison : OpenUnitTripodComparison T := by
  refine
    { encode := R.point
      encode_mem_degreeAtMostOne := R.point_mem_degreeAtMostOne
      heightError := Classical.choose R.height_equiv.ge
      radicalError := Classical.choose R.conductor_equiv.le
      height_le := ?_
      logDiff_add_logCond_le := ?_ }
  · intro x
    exact (Classical.choose_spec R.height_equiv.ge) x (Set.mem_univ x)
  · intro x
    have hc := (Classical.choose_spec R.conductor_equiv.le) x (Set.mem_univ x)
    rw [R.logDiff_eq_zero x, zero_add]
    exact hc

/-- Full Statement I restricts to the realized degree-one chart. -/
theorem restrictedStatementI_of_statementI
    (hI : T.StatementI) : R.RestrictedStatementI := by
  intro ε hε
  obtain ⟨C, hC⟩ := hI T.tripod T.hyperbolic_tripod 1 ε hε
  refine ⟨C, ?_⟩
  intro x
  have h := hC (R.point x) (R.point_mem_degreeAtMostOne x)
  simpa only [sourceHeight, sourceDifferent, sourceConductor,
    Pi.smul_apply, Pi.add_apply, smul_eq_mul] using h

/-- The source-restricted Statement I is exactly the repository's integer abc
statement.  Both directions keep every additive error uniform in the rational
point. -/
theorem restrictedStatementI_iff_abc :
    R.RestrictedStatementI ↔ ABCConjecture := by
  constructor
  · intro hsource
    apply abc_of_uniformRationalSUnitTripodBound
    intro ε hε
    obtain ⟨C, hC⟩ := hsource ε hε
    obtain ⟨AH, hAH⟩ := R.height_equiv.ge
    obtain ⟨BN, hBN⟩ := R.conductor_equiv.le
    refine ⟨C + AH + (1 + ε) * BN, ?_⟩
    intro x hx0 hx1
    let y : OpenUnitRational := ⟨x, hx0, hx1⟩
    have hheight := hAH y (Set.mem_univ y)
    have hbound := hC y
    have hcond := hBN y (Set.mem_univ y)
    change openUnitHeight y ≤ R.sourceHeight y + AH at hheight
    change R.sourceHeight y ≤
      (1 + ε) * (R.sourceDifferent y + R.sourceConductor y) + C at hbound
    change R.sourceConductor y ≤ openUnitCounting y + BN at hcond
    have hdiff : R.sourceDifferent y = 0 := R.logDiff_eq_zero y
    rw [hdiff, zero_add] at hbound
    have hcoefficient : 0 ≤ 1 + ε := by linarith
    have hscaled := mul_le_mul_of_nonneg_left hcond hcoefficient
    change rationalTripodHeight x ≤
      (1 + ε) * rationalTripodCounting x +
        (C + AH + (1 + ε) * BN)
    dsimp [openUnitHeight, openUnitCounting, y] at hheight hscaled
    linarith
  · intro habc ε hε
    obtain ⟨C, hC⟩ :=
      uniformRationalSUnitTripodBound_of_abc habc ε hε
    obtain ⟨AH, hAH⟩ := R.height_equiv.le
    obtain ⟨BN, hBN⟩ := R.conductor_equiv.ge
    refine ⟨C + AH + (1 + ε) * BN, ?_⟩
    intro x
    have htarget := hC x.1 x.2.1 x.2.2
    have hheight := hAH x (Set.mem_univ x)
    have hcond := hBN x (Set.mem_univ x)
    change R.sourceHeight x ≤ openUnitHeight x + AH at hheight
    change openUnitCounting x ≤ R.sourceConductor x + BN at hcond
    have hcoefficient : 0 ≤ 1 + ε := by linarith
    have hscaled := mul_le_mul_of_nonneg_left hcond hcoefficient
    change R.sourceHeight x ≤
      (1 + ε) * (R.sourceDifferent x + R.sourceConductor x) +
        (C + AH + (1 + ε) * BN)
    rw [sourceDifferent, R.logDiff_eq_zero x, zero_add]
    dsimp [openUnitHeight, openUnitCounting] at hheight hscaled
    linarith

/-- Full Statement I plus the source realization proves integer abc. -/
theorem abc_of_statementI
    (R : RationalDegreeOneSourceRealization T)
    (hI : T.StatementI) : ABCConjecture :=
  (restrictedStatementI_iff_abc R).mp (restrictedStatementI_of_statementI R hI)

end RationalDegreeOneSourceRealization

/-! ## Consistency witness: the exact rational shadow -/

/-- The previously constructed exact rational shadow realizes every field of
the source interface with zero discrepancy.  This is a consistency witness,
not an identification with an intended arithmetic or IUT height theory. -/
noncomputable def rationalTripodShadowSourceRealization :
    RationalDegreeOneSourceRealization rationalTripodShadow where
  point := id
  point_mem_degreeOne x := by
    change x ∈ shadowPtEQ 1
    simp [shadowPtEQ]
  height_equiv := by
    simpa [rationalTripodShadow, openUnitShadowHeightTheory] using
      (DiscrepancyEquiv.refl openUnitHeight (Set.univ : Set OpenUnitRational))
  logDiff_eq_zero x := by
    simp [rationalTripodShadow, openUnitShadowHeightTheory]
  conductor_equiv := by
    simpa [rationalTripodShadow, openUnitShadowHeightTheory] using
      (DiscrepancyEquiv.refl openUnitCounting (Set.univ : Set OpenUnitRational))

/-! ## The abstract proof package does not force source semantics -/

/-- Even the degree-empty pressure model admits every field of the abstract
`Genl.HeightTheory.ProofPackage`.  Its degree loci are empty, and the Belyi
failure premise contradicts the vacuous BD inequality. -/
noncomputable def degreeEmptyProofPackage :
    Genl.HeightTheory.ProofPackage degreeEmptyHeightTheory where
  covering X hX d ε hε :=
    { Y := ()
      hyperbolic := True.intro
      divisorFree := True.intro
      d' := 0
      π := fun _ => ()
      surjOn := by
        intro x hx
        change x ∈ (∅ : Set Unit) at hx
        exact hx.elim
      logDiff_le := DiscrepancyLE.empty
      htCan_le := DiscrepancyLE.empty }
  belyi X hX hD d ε hε hnot :=
    False.elim (hnot DiscrepancyLE.empty)

/-- Full `HeightTheory`, full `ProofPackage`, and Statement I still do not
manufacture a rational degree-one realization in the degree-empty model. -/
theorem degreeEmpty_fullGenlPremise_countermodel :
    degreeEmptyHeightTheory.StatementI ∧
      Nonempty (Genl.HeightTheory.ProofPackage degreeEmptyHeightTheory) ∧
      ¬ Nonempty (OpenUnitTripodComparison degreeEmptyHeightTheory) :=
  ⟨degreeEmptyHeightTheory_statementI, ⟨degreeEmptyProofPackage⟩,
    degreeEmptyHeightTheory_no_openUnitComparison⟩

/-- The height-zero pressure model also admits the full abstract proof package.
The identity covering supplies its comparisons, and the Belyi failure premise
is impossible because zero is BD-dominated by zero. -/
noncomputable def heightZeroProofPackage :
    Genl.HeightTheory.ProofPackage heightZeroShadow where
  covering X hX d ε hε :=
    { Y := ()
      hyperbolic := True.intro
      divisorFree := True.intro
      d' := d
      π := id
      surjOn := by
        intro x hx
        exact ⟨x, hx, rfl⟩
      logDiff_le := DiscrepancyLE.of_forall_le (by
        intro x hx
        change (0 : ℝ) ≤ 0 + openUnitCounting x
        simpa using openUnitCounting_nonneg x)
      htCan_le := DiscrepancyLE.of_forall_le (by
        intro x hx
        change (0 : ℝ) ≤ (1 + ε) * 0
        simp) }
  belyi X hX hD d ε hε hnot :=
    False.elim (hnot (DiscrepancyLE.of_forall_le (by
      intro x hx
      change (0 : ℝ) ≤ (1 + ε) * 0
      simp)))

/-- Adding the full abstract proof package does not repair the missing uniform
height comparison in the height-zero model. -/
theorem heightZero_fullGenlPremise_countermodel :
    heightZeroShadow.StatementI ∧
      Nonempty (Genl.HeightTheory.ProofPackage heightZeroShadow) ∧
      (∀ x : OpenUnitRational,
        x ∈ heightZeroShadow.ptLE heightZeroShadow.tripod 1) ∧
      (∀ x : OpenUnitRational,
        heightZeroShadow.logDiff heightZeroShadow.tripod x +
          heightZeroShadow.logCond heightZeroShadow.tripod x =
            openUnitCounting x) ∧
      ¬ ∃ A : ℝ, ∀ x : OpenUnitRational,
        openUnitHeight x ≤
          heightZeroShadow.htCan heightZeroShadow.tripod x + A :=
  ⟨heightZeroShadow_statementI, ⟨heightZeroProofPackage⟩,
    heightZeroShadow_degree_mem, heightZeroShadow_radical_exact,
    heightZeroShadow_no_uniform_height_error⟩

/-- The different-inflated pressure model likewise admits the full abstract
proof package.  Its inflated different makes the negated Belyi premise
impossible. -/
noncomputable def radicalInflatedProofPackage :
    Genl.HeightTheory.ProofPackage radicalInflatedShadow where
  covering X hX d ε hε :=
    { Y := ()
      hyperbolic := True.intro
      divisorFree := True.intro
      d' := d
      π := id
      surjOn := by
        intro x hx
        exact ⟨x, hx, rfl⟩
      logDiff_le := DiscrepancyLE.of_forall_le (by
        intro x hx
        change inflatedDifferent x ≤ inflatedDifferent x + openUnitCounting x
        linarith [openUnitCounting_nonneg x])
      htCan_le := DiscrepancyLE.of_forall_le (by
        intro x hx
        change openUnitHeight x ≤ (1 + ε) * openUnitHeight x
        have hH := openUnitHeight_nonneg x
        nlinarith) }
  belyi X hX hD d ε hε hnot :=
    False.elim (hnot (DiscrepancyLE.of_forall_le (by
      intro x hx
      change openUnitHeight x ≤ (1 + ε) * inflatedDifferent x
      have hH := openUnitHeight_nonneg x
      have hExp := Real.add_one_le_exp (2 * openUnitHeight x)
      have hPos := Real.exp_pos (2 * openUnitHeight x)
      dsimp [inflatedDifferent]
      nlinarith)))

/-! ## Full-premise pressure test for conductor normalization -/

/-- Actual rational height and exact zero different, with an unbounded term
inserted specifically into the conductor field. -/
noncomputable def conductorInflatedShadow : Genl.HeightTheory :=
  openUnitShadowHeightTheory openUnitHeight (fun _ => 0)
    (fun x => openUnitCounting x + inflatedDifferent x)

/-- The conductor-inflated shadow still satisfies Statement I. -/
theorem conductorInflatedShadow_statementI :
    conductorInflatedShadow.StatementI := by
  change (openUnitShadowHeightTheory openUnitHeight (fun _ => 0)
    (fun x => openUnitCounting x + inflatedDifferent x)).StatementI
  rw [openUnitShadow_statementI_iff]
  intro ε hε
  refine ⟨0, ?_⟩
  intro x
  have hH : 0 ≤ openUnitHeight x := openUnitHeight_nonneg x
  have hcount : 0 ≤ openUnitCounting x := openUnitCounting_nonneg x
  have hexp : 1 + 2 * openUnitHeight x ≤ inflatedDifferent x := by
    simpa [inflatedDifferent, add_comm] using
      (Real.add_one_le_exp (2 * openUnitHeight x))
  have hmass : 0 ≤ openUnitCounting x + inflatedDifferent x :=
    add_nonneg hcount (Real.exp_pos _).le
  have hheightMass :
      openUnitHeight x ≤ openUnitCounting x + inflatedDifferent x := by
    linarith
  have hscale :
      openUnitCounting x + inflatedDifferent x ≤
        (1 + ε) * (openUnitCounting x + inflatedDifferent x) := by
    nlinarith
  change openUnitHeight x ≤
    (1 + ε) * (0 + (openUnitCounting x + inflatedDifferent x)) + 0
  linarith

theorem conductorInflatedShadow_degreeOne (x : OpenUnitRational) :
    x ∈ conductorInflatedShadow.ptEQ conductorInflatedShadow.tripod 1 := by
  change x ∈ shadowPtEQ 1
  simp [shadowPtEQ]

theorem conductorInflatedShadow_height_exact (x : OpenUnitRational) :
    conductorInflatedShadow.htCan conductorInflatedShadow.tripod x =
      openUnitHeight x := by
  rfl

theorem conductorInflatedShadow_different_zero (x : OpenUnitRational) :
    conductorInflatedShadow.logDiff conductorInflatedShadow.tripod x = 0 := by
  rfl

/-- No uniform upper conductor discrepancy exists in the inflated model. -/
theorem conductorInflatedShadow_no_uniform_conductor_upper :
    ¬ ∃ B : ℝ, ∀ x : OpenUnitRational,
      conductorInflatedShadow.logCond conductorInflatedShadow.tripod x ≤
        openUnitCounting x + B := by
  rintro ⟨B, hB⟩
  obtain ⟨x, hx⟩ := openUnitHeight_unbounded ((B - 1) / 2)
  have hexpLower := Real.add_one_le_exp (2 * openUnitHeight x)
  have hexpGt : B < inflatedDifferent x := by
    dsimp [inflatedDifferent]
    linarith
  have hle := hB x
  change openUnitCounting x + inflatedDifferent x ≤
    openUnitCounting x + B at hle
  linarith

/-- All retained premises of the conductor-normalization pressure test in one
statement. -/
theorem conductorInflatedShadow_fullPremise_countermodel :
    conductorInflatedShadow.StatementI ∧
      (∀ x : OpenUnitRational,
        x ∈ conductorInflatedShadow.ptEQ conductorInflatedShadow.tripod 1) ∧
      (∀ x : OpenUnitRational,
        conductorInflatedShadow.htCan conductorInflatedShadow.tripod x =
          openUnitHeight x) ∧
      (∀ x : OpenUnitRational,
        conductorInflatedShadow.logDiff conductorInflatedShadow.tripod x = 0) ∧
      ¬ ∃ B : ℝ, ∀ x : OpenUnitRational,
        conductorInflatedShadow.logCond conductorInflatedShadow.tripod x ≤
          openUnitCounting x + B :=
  ⟨conductorInflatedShadow_statementI,
    conductorInflatedShadow_degreeOne,
    conductorInflatedShadow_height_exact,
    conductorInflatedShadow_different_zero,
    conductorInflatedShadow_no_uniform_conductor_upper⟩

/-! ## The current record does not force zero different -/

/-- The already constructed different-inflated model keeps exact degree,
height, and conductor, satisfies Statement I, but its different is nowhere
zero. -/
theorem differentInflatedShadow_fullPremise_countermodel :
    radicalInflatedShadow.StatementI ∧
      Nonempty (Genl.HeightTheory.ProofPackage radicalInflatedShadow) ∧
      (∀ x : OpenUnitRational,
        x ∈ radicalInflatedShadow.ptEQ radicalInflatedShadow.tripod 1) ∧
      (∀ x : OpenUnitRational,
        radicalInflatedShadow.htCan radicalInflatedShadow.tripod x =
          openUnitHeight x) ∧
      (∀ x : OpenUnitRational,
        radicalInflatedShadow.logCond radicalInflatedShadow.tripod x =
          openUnitCounting x) ∧
      (∀ x : OpenUnitRational,
        radicalInflatedShadow.logDiff radicalInflatedShadow.tripod x ≠ 0) := by
  refine ⟨radicalInflatedShadow_statementI, ⟨radicalInflatedProofPackage⟩,
    ?_, ?_, ?_, ?_⟩
  · intro x
    change x ∈ shadowPtEQ 1
    simp [shadowPtEQ]
  · exact radicalInflatedShadow_height_exact
  · intro x
    rfl
  · intro x
    change inflatedDifferent x ≠ 0
    exact (Real.exp_pos _).ne'

/-! ## Reverse-direction full-premise sequence countermodels -/

/-- A target bound and exact radical comparison do not transport backwards if
the source height lacks a uniform upper comparison to the target height. -/
theorem counterexample_reverse_without_source_height_upper :
    ∃ (sourceHeight sourceRadical targetHeight targetRadical : ℕ → ℝ),
      UniformEpsilonBound targetHeight targetRadical ∧
      (∀ n, targetRadical n ≤ sourceRadical n) ∧
      ¬ UniformEpsilonBound sourceHeight sourceRadical := by
  refine ⟨(fun n => (n : ℝ)), (fun _ => 0), (fun _ => 0), (fun _ => 0),
    uniformEpsilonBound_zero, ?_, not_uniformEpsilonBound_nat_zero⟩
  simp

/-- A target bound and exact height comparison do not transport backwards if
the target radical lacks a uniform upper comparison to the source radical. -/
theorem counterexample_reverse_without_target_radical_upper :
    ∃ (sourceHeight sourceRadical targetHeight targetRadical : ℕ → ℝ),
      UniformEpsilonBound targetHeight targetRadical ∧
      (∀ n, sourceHeight n ≤ targetHeight n) ∧
      ¬ UniformEpsilonBound sourceHeight sourceRadical := by
  refine ⟨(fun n => (n : ℝ)), (fun _ => 0),
    (fun n => (n : ℝ)), (fun n => (n : ℝ)),
    uniformEpsilonBound_nat_self, ?_, not_uniformEpsilonBound_nat_zero⟩
  simp

#print axioms ptLE_one_eq_ptEQ_one
#print axioms mem_ptLE_one_of_mem_ptEQ_one
#print axioms RationalDegreeOneSourceRealization.toOpenUnitTripodComparison
#print axioms RationalDegreeOneSourceRealization.restrictedStatementI_of_statementI
#print axioms RationalDegreeOneSourceRealization.restrictedStatementI_iff_abc
#print axioms RationalDegreeOneSourceRealization.abc_of_statementI
#print axioms rationalTripodShadowSourceRealization
#print axioms degreeEmpty_fullGenlPremise_countermodel
#print axioms heightZero_fullGenlPremise_countermodel
#print axioms radicalInflatedProofPackage
#print axioms conductorInflatedShadow_fullPremise_countermodel
#print axioms differentInflatedShadow_fullPremise_countermodel
#print axioms counterexample_reverse_without_source_height_upper
#print axioms counterexample_reverse_without_target_radical_upper

end IUTRationalDegreeOneSourceRealization20260901
end IUTThreeClosures
