/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SUnitAnchoredDescentBarrier
import IUTThreeClosures.FreyJHeightCorridor

/-!
# Global abc / finite-tripod / Frey audit companion

This file records the unconditional scalar implications used in the global
endgame audit.  In particular, it does not postulate an abc estimate in a
structure field.

* An abstract finite selector family with an exact anchor, unchanged counting
  mass, and at most `log 2` height loss has a uniform bound if and only if the
  ordinary rational tripod has one.  Hence its uniform bound is equivalent to
  `ABCConjecture`.
* A uniform radical bound for the actual normalized height of the Frey
  `j`-invariant is equivalent to `ABCConjecture`, by the already proved
  `FreyJHeightCorridor` inequalities.
* The squarebase ternary equation gives the Pell scalar identity, while the
  degenerate case `A*C=1` over positive natural coefficients gives the split
  factorization `(w+u)(w-u)=B*v^2`.

No finiteness theorem, orbit-height comparison, Frey estimate, or abc bound is
stored as data below.  The abstract selector fields state only the elementary
finite-orbit comparison hypotheses being audited.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Abstract finite selectors and the `log 2` absorption -/

/--
Elementary comparison data for a finite family of candidate representatives
of each rational tripod point.

The anchor makes the family no stronger than the original tripod statement.
Conversely, every listed representative has the same counting mass and loses
at most `log 2` when its selected height is used to recover the source height.
For the usual six-point orbit, `ι` can be taken to be `Fin 6`; no assertion
that a particular arithmetic orbit realizes these fields is made here.
-/
structure LogTwoFiniteTripodSelector (ι : Type*) [DecidableEq ι] where
  candidates : ℚ → Finset ι
  anchor : ℚ → ι
  anchor_mem : ∀ x, anchor x ∈ candidates x
  selectedHeight : ℚ → ι → ℝ
  selectedCounting : ℚ → ι → ℝ
  anchor_height : ∀ x,
    selectedHeight x (anchor x) = rationalTripodHeight x
  anchor_counting : ∀ x,
    selectedCounting x (anchor x) = rationalTripodCounting x
  source_height_le : ∀ x i, i ∈ candidates x →
    rationalTripodHeight x ≤ selectedHeight x i + Real.log 2
  counting_eq : ∀ x i, i ∈ candidates x →
    selectedCounting x i = rationalTripodCounting x

/-- The uniform bound obtained by selecting one member of each finite family. -/
def UniformLogTwoFiniteTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteTripodSelector ι) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ x : ℚ, 0 < x → x < 1 →
      ∃ i : ι, i ∈ F.candidates x ∧
        F.selectedHeight x i ≤
          (1 + ε) * F.selectedCounting x i + C

/-- The ordinary rational tripod bound supplies a bound for the anchor in any
abstract finite selector family. -/
theorem uniformLogTwoFiniteTripodSelectorBound_of_uniformRational
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteTripodSelector ι)
    (htripod : UniformRationalSUnitTripodBound) :
    UniformLogTwoFiniteTripodSelectorBound F := by
  intro ε hε
  obtain ⟨C, hC⟩ := htripod ε hε
  refine ⟨C, ?_⟩
  intro x hx0 hx1
  refine ⟨F.anchor x, F.anchor_mem x, ?_⟩
  rw [F.anchor_height, F.anchor_counting]
  exact hC x hx0 hx1

/-- A selected bound recovers the ordinary rational tripod bound after adding
the single universal constant `log 2`. -/
theorem uniformRationalSUnitTripodBound_of_uniformLogTwoFinite
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteTripodSelector ι)
    (hselector : UniformLogTwoFiniteTripodSelectorBound F) :
    UniformRationalSUnitTripodBound := by
  intro ε hε
  obtain ⟨C, hC⟩ := hselector ε hε
  refine ⟨C + Real.log 2, ?_⟩
  intro x hx0 hx1
  obtain ⟨i, hi, hibound⟩ := hC x hx0 hx1
  have hrecover := F.source_height_le x i hi
  have hcount := F.counting_eq x i hi
  rw [hcount] at hibound
  linarith

/-- Exact equivalence between the abstract finite-selector estimate and the
ordinary uniform rational tripod estimate. -/
theorem uniformRationalSUnitTripodBound_iff_uniformLogTwoFinite
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteTripodSelector ι) :
    UniformRationalSUnitTripodBound ↔
      UniformLogTwoFiniteTripodSelectorBound F :=
  ⟨uniformLogTwoFiniteTripodSelectorBound_of_uniformRational F,
    uniformRationalSUnitTripodBound_of_uniformLogTwoFinite F⟩

/-- Therefore every finite selector family satisfying the explicit elementary
comparison data has a uniform selected bound if and only if abc holds. -/
theorem abcConjecture_iff_uniformLogTwoFiniteTripodSelectorBound
    {ι : Type*} [DecidableEq ι]
    (F : LogTwoFiniteTripodSelector ι) :
    ABCConjecture ↔ UniformLogTwoFiniteTripodSelectorBound F := by
  rw [abcConjecture_iff_uniformRationalSUnitTripodBound]
  exact uniformRationalSUnitTripodBound_iff_uniformLogTwoFinite F

/-! ## The canonical Frey `j`-radical reformulation -/

/-- A uniform radical bound for the actual normalized Weil height of the Frey
`j`-invariant.  The factor six is the exact degree visible in the established
Frey height corridor. -/
def UniformFreyJRadicalBound : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ P : ABCPoint,
      Heights.normalizedLogHeight ℚ (abcFreyCurve P).j ≤
        6 * (1 + ε) * P.conductor + C

/-- Abc implies the uniform Frey `j`-radical bound, using the upper side of
the canonical height corridor. -/
theorem uniformFreyJRadicalBound_of_abc
    (habc : ABCConjecture) : UniformFreyJRadicalBound := by
  intro ε hε
  obtain ⟨C, hC⟩ := habc ε hε
  refine ⟨6 * C + Real.log 256, ?_⟩
  intro P
  have hPraw := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
    P.sum_eq P.pairwise_coprime
  have hP : P.height ≤ (1 + ε) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hPraw
  have hj := P.normalizedLogHeight_abcFrey_j_div_six_le
  nlinarith

/-- The uniform Frey `j`-radical bound implies abc, using the lower side of
the canonical height corridor. -/
theorem abc_of_uniformFreyJRadicalBound
    (hfrey : UniformFreyJRadicalBound) : ABCConjecture := by
  intro ε hε
  obtain ⟨C, hC⟩ := hfrey ε hε
  refine ⟨C / 6 + Real.log 8 / 6, ?_⟩
  intro a b c ha hb hc hsum hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcop }
  have hjbound := hC P
  have hheight := P.height_le_normalizedLogHeight_abcFrey_j
  have hP : P.height ≤
      (1 + ε) * P.conductor + (C / 6 + Real.log 8 / 6) := by
    nlinarith
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hP

/-- The canonical Frey `j`-radical bound is exactly equivalent to logarithmic
abc; it is not an independent weaker input. -/
theorem abcConjecture_iff_uniformFreyJRadicalBound :
    ABCConjecture ↔ UniformFreyJRadicalBound :=
  ⟨uniformFreyJRadicalBound_of_abc,
    abc_of_uniformFreyJRadicalBound⟩

/-! ## Squarebase and split scalar identities -/

/-- The ternary squarebase equation gives the scalar Pell identity `(5.3)`
after passage from natural numbers to integers. -/
theorem squarebase_pell_scalar_identity
    (A B C u v w : ℕ)
    (h : A * u ^ 2 + B * v ^ 2 = C * w ^ 2) :
    ((C : ℤ) * (w : ℤ)) ^ 2 -
        (A : ℤ) * (C : ℤ) * (u : ℤ) ^ 2 =
      (B : ℤ) * (C : ℤ) * (v : ℤ) ^ 2 := by
  have hz :
      (A : ℤ) * (u : ℤ) ^ 2 + (B : ℤ) * (v : ℤ) ^ 2 =
        (C : ℤ) * (w : ℤ) ^ 2 := by
    exact_mod_cast h
  linear_combination -(C : ℤ) * hz

/-- If positive natural squarebase coefficients satisfy `A*C=1`, then
`A=C=1` and the quadratic algebra is split: the scalar equation factors as
`(w+u)(w-u)=B*v^2`. -/
theorem squarebase_split_AC_one_scalar_identity
    (A B C u v w : ℕ)
    (hAC : A * C = 1)
    (h : A * u ^ 2 + B * v ^ 2 = C * w ^ 2) :
    ((w : ℤ) + (u : ℤ)) * ((w : ℤ) - (u : ℤ)) =
      (B : ℤ) * (v : ℤ) ^ 2 := by
  have hA : A = 1 :=
    Nat.eq_one_of_dvd_one ⟨C, hAC.symm⟩
  have hC : C = 1 :=
    Nat.eq_one_of_dvd_one ⟨A, by rw [Nat.mul_comm]; exact hAC.symm⟩
  subst A
  subst C
  norm_num at h
  have hz :
      (u : ℤ) ^ 2 + (B : ℤ) * (v : ℤ) ^ 2 = (w : ℤ) ^ 2 := by
    exact_mod_cast h
  nlinarith

end

end IUTThreeClosures
