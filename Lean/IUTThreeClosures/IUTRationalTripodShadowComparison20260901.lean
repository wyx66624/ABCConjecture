/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTAdmissibleVolumeIntegerBridge20260901
import IUTThreeClosures.SUnitUniformTripod

/-!
# The rational-tripod shadow comparison

The mathematical proofs precede this formalization in
`research/ABC_IUT_RATIONAL_TRIPOD_SHADOW_COMPARISON_2026_09_01.md`.

This module constructs an explicit shadow `Genl.HeightTheory` on the actual
open rational tripod. Its degree-at-most-one encoding and its height and
radical comparisons are exact. Statement I for this shadow is equivalent to
integer abc. Separate full-premise models show why the current abstract
`HeightTheory` fields do not automatically provide degree realization or
uniform normalization constants for an intended arithmetic theory.

The shadow and the pressure models are audit interfaces. None is identified
with Mochizuki's IUT or with Project LANA's intended arithmetic height theory.
-/

namespace IUTThreeClosures
namespace IUTRationalTripodShadowComparison20260901

open IUTAdmissibleVolumeIntegerBridge20260901

/-! ## The actual open rational tripod and exact arithmetic conversions -/

/-- Rational points strictly between the three marked values `0` and `1`. -/
def OpenUnitRational := {x : ℚ // 0 < x ∧ x < 1}

/-- The rational point `1/2` witnesses that the open rational tripod is
inhabited. -/
def halfOpenUnitRational : OpenUnitRational :=
  ⟨1 / 2, by norm_num, by norm_num⟩

instance : Nonempty OpenUnitRational := ⟨halfOpenUnitRational⟩

/-- Actual normalized rational Weil height on the open tripod. -/
noncomputable def openUnitHeight (x : OpenUnitRational) : ℝ :=
  rationalTripodHeight x.1

/-- Actual truncated rational tripod counting function. -/
noncomputable def openUnitCounting (x : OpenUnitRational) : ℝ :=
  rationalTripodCounting x.1

/-- Both actual rational-tripod functions are nonnegative. -/
theorem openUnitHeight_nonneg (x : OpenUnitRational) :
    0 ≤ openUnitHeight x := by
  exact Heights.normalizedLogHeight_nonneg ℚ x.1

theorem openUnitCounting_nonneg (x : OpenUnitRational) :
    0 ≤ openUnitCounting x := by
  exact Real.log_natCast_nonneg _

/-- Forgetting the duplicate wrapper yields the repository's established
`ABCPoint` representation. -/
def tripleToABCPoint (t : PositivePrimitiveABCTriple) : ABCPoint where
  a := t.a
  b := t.b
  c := t.c
  a_pos := t.a_pos
  b_pos := t.b_pos
  c_pos := t.c_pos
  sum_eq := t.sum_eq
  pairwise_coprime := t.pairwiseCoprime

/-- The canonical open rational tripod coordinate of a primitive triple. -/
noncomputable def openUnitCoordinate
    (t : PositivePrimitiveABCTriple) : OpenUnitRational :=
  ⟨(tripleToABCPoint t).lambda, (tripleToABCPoint t).lambda_pos,
    (tripleToABCPoint t).lambda_lt_one⟩

/-- The actual rational height of the encoded coordinate is exactly the
integer height in `ABCConjecture`. -/
theorem openUnitHeight_coordinate (t : PositivePrimitiveABCTriple) :
    openUnitHeight (openUnitCoordinate t) = t.logHeight := by
  change rationalTripodHeight (tripleToABCPoint t).lambda = t.logHeight
  rw [ABCPoint.rationalTripodHeight_lambda]
  rfl

/-- The actual rational tripod count is exactly the logarithm of the integer
radical. -/
theorem openUnitCounting_coordinate (t : PositivePrimitiveABCTriple) :
    openUnitCounting (openUnitCoordinate t) = t.logRadical := by
  change rationalTripodCounting (tripleToABCPoint t).lambda = t.logRadical
  rw [ABCPoint.rationalTripodCounting_lambda]
  rfl

namespace OpenUnitRational

/-- The inverse reduced primitive triple attached to an open rational point. -/
def toABCPoint (x : OpenUnitRational) : ABCPoint :=
  ABCPoint.ofRat x.1 x.2.1 x.2.2

/-- The inverse point, expressed in the comparison module's triple wrapper. -/
def toPositivePrimitiveABCTriple
    (x : OpenUnitRational) : PositivePrimitiveABCTriple where
  a := x.toABCPoint.a
  b := x.toABCPoint.b
  c := x.toABCPoint.c
  a_pos := x.toABCPoint.a_pos
  b_pos := x.toABCPoint.b_pos
  c_pos := x.toABCPoint.c_pos
  sum_eq := x.toABCPoint.sum_eq
  pairwiseCoprime := x.toABCPoint.pairwise_coprime

/-- The inverse triple has exactly the original rational-tripod height. -/
theorem logHeight_toPositivePrimitiveABCTriple (x : OpenUnitRational) :
    x.toPositivePrimitiveABCTriple.logHeight = openUnitHeight x := by
  let P : ABCPoint := ABCPoint.ofRat x.1 x.2.1 x.2.2
  change P.height = rationalTripodHeight x.1
  have hcoord : P.lambda = x.1 :=
    ABCPoint.ofRat_lambda x.1 x.2.1 x.2.2
  calc
    P.height = rationalTripodHeight P.lambda :=
      P.rationalTripodHeight_lambda.symm
    _ = rationalTripodHeight x.1 := congrArg rationalTripodHeight hcoord

/-- The inverse triple has exactly the original rational-tripod count. -/
theorem logRadical_toPositivePrimitiveABCTriple (x : OpenUnitRational) :
    x.toPositivePrimitiveABCTriple.logRadical = openUnitCounting x := by
  let P : ABCPoint := ABCPoint.ofRat x.1 x.2.1 x.2.2
  change P.conductor = rationalTripodCounting x.1
  have hcoord : P.lambda = x.1 :=
    ABCPoint.ofRat_lambda x.1 x.2.1 x.2.2
  calc
    P.conductor = rationalTripodCounting P.lambda :=
      P.rationalTripodCounting_lambda.symm
    _ = rationalTripodCounting x.1 := congrArg rationalTripodCounting hcoord

/-- Passing to the reduced primitive triple and back recovers the original
open rational point. -/
theorem openUnitCoordinate_toPositivePrimitiveABCTriple
    (x : OpenUnitRational) :
    openUnitCoordinate x.toPositivePrimitiveABCTriple = x := by
  apply Subtype.ext
  change (ABCPoint.ofRat x.1 x.2.1 x.2.2).lambda = x.1
  exact ABCPoint.ofRat_lambda x.1 x.2.1 x.2.2

end OpenUnitRational

/-! ## The semantic comparison on all open rational points -/

/-- The minimal semantic realization of the standard rational tripod inside
an abstract height theory, with errors uniform over every rational point. -/
structure OpenUnitTripodComparison (T : Genl.HeightTheory) where
  encode : OpenUnitRational → T.Pt T.tripod
  encode_mem_degreeAtMostOne : ∀ x, encode x ∈ T.ptLE T.tripod 1
  heightError : ℝ
  radicalError : ℝ
  height_le : ∀ x,
    openUnitHeight x ≤ T.htCan T.tripod (encode x) + heightError
  logDiff_add_logCond_le : ∀ x,
    T.logDiff T.tripod (encode x) + T.logCond T.tripod (encode x) ≤
      openUnitCounting x + radicalError

namespace OpenUnitTripodComparison

/-- Restriction to primitive integer triples gives the earlier exact integer
comparison package without changing either error constant. -/
noncomputable def toStatementIIntegerComparison
    {T : Genl.HeightTheory} (B : OpenUnitTripodComparison T) :
    StatementIIntegerComparison T where
  encode t := B.encode (openUnitCoordinate t)
  encode_mem_degreeAtMostOne t :=
    B.encode_mem_degreeAtMostOne (openUnitCoordinate t)
  heightError := B.heightError
  radicalError := B.radicalError
  logHeight_le t := by
    rw [← openUnitHeight_coordinate t]
    exact B.height_le (openUnitCoordinate t)
  logDiff_add_logCond_le t := by
    rw [← openUnitCounting_coordinate t]
    exact B.logDiff_add_logCond_le (openUnitCoordinate t)

/-- Conversely, the inverse reduced triple construction upgrades an integer
comparison to all open rational points, preserving its constants. -/
noncomputable def ofStatementIIntegerComparison
    {T : Genl.HeightTheory} (B : StatementIIntegerComparison T) :
    OpenUnitTripodComparison T where
  encode x := B.encode x.toPositivePrimitiveABCTriple
  encode_mem_degreeAtMostOne x :=
    B.encode_mem_degreeAtMostOne x.toPositivePrimitiveABCTriple
  heightError := B.heightError
  radicalError := B.radicalError
  height_le x := by
    rw [← x.logHeight_toPositivePrimitiveABCTriple]
    exact B.logHeight_le x.toPositivePrimitiveABCTriple
  logDiff_add_logCond_le x := by
    rw [← x.logRadical_toPositivePrimitiveABCTriple]
    exact B.logDiff_add_logCond_le x.toPositivePrimitiveABCTriple

/-- At the level of existence, the rational and integer comparison packages
have exactly the same strength. -/
theorem nonempty_iff_statementIIntegerComparison
    (T : Genl.HeightTheory) :
    Nonempty (OpenUnitTripodComparison T) ↔
      Nonempty (StatementIIntegerComparison T) :=
  ⟨fun ⟨B⟩ => ⟨B.toStatementIIntegerComparison⟩,
    fun ⟨B⟩ => ⟨ofStatementIIntegerComparison B⟩⟩

end OpenUnitTripodComparison

/-! ## A family of one-curve shadow height theories -/

/-- Degree-at-most loci for a shadow in which every point has exact degree
one. -/
def shadowPtLE (d : ℕ) : Set OpenUnitRational :=
  if d = 0 then ∅ else Set.univ

/-- Exact-degree loci for a shadow in which every point has exact degree one. -/
def shadowPtEQ (d : ℕ) : Set OpenUnitRational :=
  if d = 1 then Set.univ else ∅

theorem shadowPtLE_zero : shadowPtLE 0 = ∅ := by
  simp [shadowPtLE]

theorem shadowPtLE_succ (d : ℕ) :
    shadowPtLE (d + 1) = shadowPtLE d ∪ shadowPtEQ (d + 1) := by
  cases d with
  | zero => simp [shadowPtLE, shadowPtEQ]
  | succ d => simp [shadowPtLE, shadowPtEQ]

/-- A one-curve `HeightTheory` with the actual open rational tripod as its
point type and caller-supplied numerical functions. This is an audit shadow,
not the intended arithmetic-geometric implementation. -/
noncomputable def openUnitShadowHeightTheory
    (height logDiff logCond : OpenUnitRational → ℝ) :
    Genl.HeightTheory where
  Curve := Unit
  Pt := fun _ => OpenUnitRational
  Hyperbolic := fun _ => True
  DivisorFree := fun _ => True
  ptLE := fun _ d => shadowPtLE d
  ptEQ := fun _ d => shadowPtEQ d
  ptLE_zero := fun _ => shadowPtLE_zero
  ptLE_succ := fun _ d => shadowPtLE_succ d
  htCan := fun _ => height
  logDiff := fun _ => logDiff
  logCond := fun _ => logCond
  tripod := ()
  hyperbolic_tripod := True.intro
  CBS := Unit
  cbsSet := fun _ => Set.univ

/-- The quantifier-correct pointwise form of Statement I on the one-curve
shadow. -/
def UniformOpenUnitBound
    (height logDiff logCond : OpenUnitRational → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ x : OpenUnitRational,
    height x ≤ (1 + ε) * (logDiff x + logCond x) + C

/-- Statement I for a one-curve shadow is exactly its uniform pointwise
inequality. -/
theorem openUnitShadow_statementI_iff
    (height logDiff logCond : OpenUnitRational → ℝ) :
    (openUnitShadowHeightTheory height logDiff logCond).StatementI ↔
      UniformOpenUnitBound height logDiff logCond := by
  constructor
  · intro hI ε hε
    obtain ⟨C, hC⟩ := hI () True.intro 1 ε hε
    refine ⟨C, ?_⟩
    intro x
    have hx : x ∈ (openUnitShadowHeightTheory height logDiff logCond).ptLE
        (openUnitShadowHeightTheory height logDiff logCond).tripod 1 := by
      change x ∈ shadowPtLE 1
      simp [shadowPtLE]
    have h := hC x hx
    change height x ≤ ((1 + ε) • (logDiff + logCond)) x + C at h
    simpa only [Pi.smul_apply, Pi.add_apply, smul_eq_mul] using h
  · intro hbound X hX d ε hε
    obtain ⟨C, hC⟩ := hbound ε hε
    refine ⟨C, ?_⟩
    intro x hx
    have h := hC x
    change height x ≤ ((1 + ε) • (logDiff + logCond)) x + C
    simpa only [Pi.smul_apply, Pi.add_apply, smul_eq_mul] using h

/-! ## The exact rational-tripod shadow -/

/-- The canonical rational shadow: actual Weil height, zero different, and
actual truncated tripod count. -/
noncomputable def rationalTripodShadow : Genl.HeightTheory :=
  openUnitShadowHeightTheory openUnitHeight (fun _ => 0) openUnitCounting

/-- All four comparison fields are inhabited with the identity encoding and
zero error. -/
noncomputable def rationalTripodShadowComparison :
    OpenUnitTripodComparison rationalTripodShadow where
  encode := id
  encode_mem_degreeAtMostOne x := by
    change x ∈ shadowPtLE 1
    simp [shadowPtLE]
  heightError := 0
  radicalError := 0
  height_le x := by
    simp [rationalTripodShadow, openUnitShadowHeightTheory]
  logDiff_add_logCond_le x := by
    simp [rationalTripodShadow, openUnitShadowHeightTheory]

/-- The earlier integer comparison package is therefore unconditionally
inhabited for the exact rational shadow. -/
noncomputable def rationalTripodShadowIntegerComparison :
    StatementIIntegerComparison rationalTripodShadow :=
  rationalTripodShadowComparison.toStatementIIntegerComparison

/-- Statement I for the exact rational shadow is exactly integer abc. -/
theorem rationalTripodShadow_statementI_iff_abc :
    rationalTripodShadow.StatementI ↔ ABCConjecture := by
  constructor
  · intro hI
    exact abcConjecture_of_statementI_comparison hI
      rationalTripodShadowIntegerComparison
  · intro habc
    change (openUnitShadowHeightTheory openUnitHeight (fun _ => 0)
      openUnitCounting).StatementI
    rw [openUnitShadow_statementI_iff]
    intro ε hε
    obtain ⟨C, hC⟩ :=
      uniformRationalSUnitTripodBound_of_abc habc ε hε
    refine ⟨C, ?_⟩
    intro x
    have hx := hC x.1 x.2.1 x.2.2
    simpa [openUnitHeight, openUnitCounting] using hx

/-! ## Unboundedness on actual open rational points -/

/-- The actual rational-tripod height is unbounded on `0 < x < 1`. -/
theorem openUnitHeight_unbounded (A : ℝ) :
    ∃ x : OpenUnitRational, A < openUnitHeight x := by
  have htendsto :
      Filter.Tendsto (fun n : ℕ => Real.log (n : ℝ))
        Filter.atTop Filter.atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  obtain ⟨N, hN⟩ :=
    Filter.eventually_atTop.1 (htendsto.eventually_gt_atTop A)
  let n : ℕ := max N 1
  have hnN : N ≤ n := le_max_left _ _
  have hn : 0 < n := lt_of_lt_of_le Nat.zero_lt_one (le_max_right _ _)
  have hlog : A < Real.log (n : ℝ) := hN n hnN
  let P : ABCPoint :=
    { a := 1
      b := n
      c := n + 1
      a_pos := by simp
      b_pos := hn
      c_pos := Nat.succ_pos n
      sum_eq := by omega
      pairwise_coprime := by simp [PairwiseCoprimeABC] }
  let x : OpenUnitRational :=
    ⟨P.lambda, P.lambda_pos, P.lambda_lt_one⟩
  refine ⟨x, ?_⟩
  change A < rationalTripodHeight P.lambda
  rw [P.rationalTripodHeight_lambda, P.height_eq_log_c]
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hnle : (n : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by
    exact_mod_cast Nat.le_succ n
  exact hlog.trans_le (Real.log_le_log hnR hnle)

/-! ## Full-premise pressure test: degree realization -/

/-- A full `HeightTheory` whose point type is inhabited but whose degree loci
are all empty. -/
noncomputable def degreeEmptyHeightTheory : Genl.HeightTheory where
  Curve := Unit
  Pt := fun _ => Unit
  Hyperbolic := fun _ => True
  DivisorFree := fun _ => True
  ptLE := fun _ _ => ∅
  ptEQ := fun _ _ => ∅
  ptLE_zero := by simp
  ptLE_succ := by simp
  htCan := fun _ _ => 0
  logDiff := fun _ _ => 0
  logCond := fun _ _ => 0
  tripod := ()
  hyperbolic_tripod := True.intro
  CBS := Unit
  cbsSet := fun _ => ∅

/-- Statement I is vacuously true in the degree-empty model. -/
theorem degreeEmptyHeightTheory_statementI :
    degreeEmptyHeightTheory.StatementI := by
  intro X hX d ε hε
  change DiscrepancyLE (fun _ : Unit => (0 : ℝ))
    ((1 + ε) • ((fun _ : Unit => (0 : ℝ)) + fun _ : Unit => 0)) ∅
  exact DiscrepancyLE.empty

/-- Nevertheless the nonempty open rational tripod cannot be encoded into its
empty degree-at-most-one locus. This refutes only automatic degree realization
from the current abstract fields and Statement I. -/
theorem degreeEmptyHeightTheory_no_openUnitComparison :
    ¬ Nonempty (OpenUnitTripodComparison degreeEmptyHeightTheory) := by
  rintro ⟨B⟩
  have hmem := B.encode_mem_degreeAtMostOne halfOpenUnitRational
  change B.encode halfOpenUnitRational ∈ (∅ : Set Unit) at hmem
  exact hmem

/-- A single existential countermodel to the claim that Statement I for the
current bare interface automatically supplies the rational comparison. -/
theorem statementI_does_not_force_openUnitComparison :
    ∃ T : Genl.HeightTheory.{0},
      T.StatementI ∧ ¬ Nonempty (OpenUnitTripodComparison T) :=
  ⟨degreeEmptyHeightTheory, degreeEmptyHeightTheory_statementI,
    degreeEmptyHeightTheory_no_openUnitComparison⟩

/-! ## Full-premise pressure test: uniform height normalization -/

/-- Actual rational points and counting, but a zero canonical-height field. -/
noncomputable def heightZeroShadow : Genl.HeightTheory :=
  openUnitShadowHeightTheory (fun _ => 0) (fun _ => 0) openUnitCounting

/-- Statement I holds unconditionally in the height-zero shadow. -/
theorem heightZeroShadow_statementI : heightZeroShadow.StatementI := by
  change (openUnitShadowHeightTheory (fun _ => 0) (fun _ => 0)
    openUnitCounting).StatementI
  rw [openUnitShadow_statementI_iff]
  intro ε hε
  refine ⟨0, ?_⟩
  intro x
  simp only [zero_add, add_zero]
  exact mul_nonneg (by linarith) (openUnitCounting_nonneg x)

theorem heightZeroShadow_degree_mem (x : OpenUnitRational) :
    x ∈ heightZeroShadow.ptLE heightZeroShadow.tripod 1 := by
  change x ∈ shadowPtLE 1
  simp [shadowPtLE]

/-- The radical comparison survives with error zero. -/
theorem heightZeroShadow_radical_exact (x : OpenUnitRational) :
    heightZeroShadow.logDiff heightZeroShadow.tripod x +
      heightZeroShadow.logCond heightZeroShadow.tripod x =
        openUnitCounting x := by
  simp [heightZeroShadow, openUnitShadowHeightTheory]

/-- A point-dependent height error makes the missing comparison hold
tautologically. -/
theorem heightZeroShadow_pointwise_height_error (x : OpenUnitRational) :
    openUnitHeight x ≤
      heightZeroShadow.htCan heightZeroShadow.tripod x + openUnitHeight x := by
  simp [heightZeroShadow, openUnitShadowHeightTheory]

/-- No single height error works on every actual open rational point. -/
theorem heightZeroShadow_no_uniform_height_error :
    ¬ ∃ A : ℝ, ∀ x : OpenUnitRational,
      openUnitHeight x ≤
        heightZeroShadow.htCan heightZeroShadow.tripod x + A := by
  rintro ⟨A, hA⟩
  obtain ⟨x, hx⟩ := openUnitHeight_unbounded A
  have hle := hA x
  change openUnitHeight x ≤ 0 + A at hle
  linarith

/-- All retained premises of the height-normalization test are displayed in
one theorem. -/
theorem heightZeroShadow_fullPremise_countermodel :
    heightZeroShadow.StatementI ∧
      (∀ x : OpenUnitRational,
        x ∈ heightZeroShadow.ptLE heightZeroShadow.tripod 1) ∧
      (∀ x : OpenUnitRational,
        heightZeroShadow.logDiff heightZeroShadow.tripod x +
          heightZeroShadow.logCond heightZeroShadow.tripod x =
            openUnitCounting x) ∧
      (∀ x : OpenUnitRational,
        openUnitHeight x ≤ heightZeroShadow.htCan
          heightZeroShadow.tripod x + openUnitHeight x) ∧
      ¬ ∃ A : ℝ, ∀ x : OpenUnitRational,
        openUnitHeight x ≤
          heightZeroShadow.htCan heightZeroShadow.tripod x + A :=
  ⟨heightZeroShadow_statementI, heightZeroShadow_degree_mem,
    heightZeroShadow_radical_exact,
    heightZeroShadow_pointwise_height_error,
    heightZeroShadow_no_uniform_height_error⟩

/-! ## Full-premise pressure test: uniform radical normalization -/

/-- An artificial positive different term used to test whether the bare
interface forces the arithmetic radical normalization. -/
noncomputable def inflatedDifferent (x : OpenUnitRational) : ℝ :=
  Real.exp (2 * openUnitHeight x)

/-- Actual rational height and counting, with an inflated different term. -/
noncomputable def radicalInflatedShadow : Genl.HeightTheory :=
  openUnitShadowHeightTheory openUnitHeight inflatedDifferent openUnitCounting

/-- The inflated shadow still satisfies Statement I unconditionally. -/
theorem radicalInflatedShadow_statementI :
    radicalInflatedShadow.StatementI := by
  change (openUnitShadowHeightTheory openUnitHeight inflatedDifferent
    openUnitCounting).StatementI
  rw [openUnitShadow_statementI_iff]
  intro ε hε
  refine ⟨0, ?_⟩
  intro x
  let H : ℝ := openUnitHeight x
  let M : ℝ := inflatedDifferent x + openUnitCounting x
  have hH : 0 ≤ H := openUnitHeight_nonneg x
  have hcount : 0 ≤ openUnitCounting x := openUnitCounting_nonneg x
  have hexp : 1 + 2 * H ≤ inflatedDifferent x := by
    simpa [inflatedDifferent, H, add_comm] using
      (Real.add_one_le_exp (2 * H))
  have hM : 0 ≤ M := by
    exact add_nonneg (Real.exp_pos _).le hcount
  have hHM : H ≤ M := by
    dsimp [M]
    linarith
  have hcoef : 1 ≤ 1 + ε := by linarith
  have hscale : M ≤ (1 + ε) * M := by
    nlinarith
  change H ≤ (1 + ε) * M + 0
  linarith

theorem radicalInflatedShadow_degree_mem (x : OpenUnitRational) :
    x ∈ radicalInflatedShadow.ptLE radicalInflatedShadow.tripod 1 := by
  change x ∈ shadowPtLE 1
  simp [shadowPtLE]

/-- The height comparison survives with error zero. -/
theorem radicalInflatedShadow_height_exact (x : OpenUnitRational) :
    openUnitHeight x =
      radicalInflatedShadow.htCan radicalInflatedShadow.tripod x := by
  rfl

/-- A point-dependent radical error makes the inflated comparison exact. -/
theorem radicalInflatedShadow_pointwise_radical_error
    (x : OpenUnitRational) :
    radicalInflatedShadow.logDiff radicalInflatedShadow.tripod x +
      radicalInflatedShadow.logCond radicalInflatedShadow.tripod x =
        openUnitCounting x + inflatedDifferent x := by
  change inflatedDifferent x + openUnitCounting x =
    openUnitCounting x + inflatedDifferent x
  ring

/-- No single radical error absorbs the inflated different term. -/
theorem radicalInflatedShadow_no_uniform_radical_error :
    ¬ ∃ A : ℝ, ∀ x : OpenUnitRational,
      radicalInflatedShadow.logDiff radicalInflatedShadow.tripod x +
        radicalInflatedShadow.logCond radicalInflatedShadow.tripod x ≤
          openUnitCounting x + A := by
  rintro ⟨A, hA⟩
  obtain ⟨x, hx⟩ := openUnitHeight_unbounded ((A - 1) / 2)
  have hexpLower := Real.add_one_le_exp (2 * openUnitHeight x)
  have hexpGt : A < inflatedDifferent x := by
    dsimp [inflatedDifferent]
    linarith
  have hle := hA x
  change inflatedDifferent x + openUnitCounting x ≤
    openUnitCounting x + A at hle
  linarith

/-- All retained premises of the radical-normalization test are displayed in
one theorem. -/
theorem radicalInflatedShadow_fullPremise_countermodel :
    radicalInflatedShadow.StatementI ∧
      (∀ x : OpenUnitRational,
        x ∈ radicalInflatedShadow.ptLE radicalInflatedShadow.tripod 1) ∧
      (∀ x : OpenUnitRational,
        openUnitHeight x = radicalInflatedShadow.htCan
          radicalInflatedShadow.tripod x) ∧
      (∀ x : OpenUnitRational,
        radicalInflatedShadow.logDiff radicalInflatedShadow.tripod x +
          radicalInflatedShadow.logCond radicalInflatedShadow.tripod x =
            openUnitCounting x + inflatedDifferent x) ∧
      ¬ ∃ A : ℝ, ∀ x : OpenUnitRational,
        radicalInflatedShadow.logDiff radicalInflatedShadow.tripod x +
          radicalInflatedShadow.logCond radicalInflatedShadow.tripod x ≤
            openUnitCounting x + A :=
  ⟨radicalInflatedShadow_statementI, radicalInflatedShadow_degree_mem,
    radicalInflatedShadow_height_exact,
    radicalInflatedShadow_pointwise_radical_error,
    radicalInflatedShadow_no_uniform_radical_error⟩

#print axioms openUnitHeight_coordinate
#print axioms openUnitCounting_coordinate
#print axioms OpenUnitRational.openUnitCoordinate_toPositivePrimitiveABCTriple
#print axioms OpenUnitTripodComparison.nonempty_iff_statementIIntegerComparison
#print axioms shadowPtLE_succ
#print axioms openUnitShadow_statementI_iff
#print axioms rationalTripodShadowComparison
#print axioms rationalTripodShadowIntegerComparison
#print axioms rationalTripodShadow_statementI_iff_abc
#print axioms openUnitHeight_unbounded
#print axioms statementI_does_not_force_openUnitComparison
#print axioms heightZeroShadow_fullPremise_countermodel
#print axioms radicalInflatedShadow_fullPremise_countermodel

end IUTRationalTripodShadowComparison20260901
end IUTThreeClosures
