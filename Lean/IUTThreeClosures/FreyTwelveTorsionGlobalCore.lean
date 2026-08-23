/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FixedCoreOrbicurveDecomposition
import IUTThreeClosures.ABCFreyCurve

/-!
# A twelve-torsion route to the fixed Frey global core

For an abc point `P`, let `E_P` be the integral Frey curve and base change it
to a number field `F`.  The standard arithmetic route to the global portion
of initial theta-data is to take a field over which the full 12-torsion is
rational.  Three consequences are then needed:

* full 12-torsion rationality implies the public six-torsion rationality
  condition; this implication is proved here;
* full 4-torsion rationality, together with the Weil pairing, supplies a
  square root of `-1`;
* the semistable-reduction theorem applied at levels 3 and 4 gives stable
  reduction away from residue characteristics 3 and 2 respectively.  These
  two complements cover every finite place; the covering argument is proved
  here.

The current imported libraries do not yet contain the Weil-pairing and
semistable-reduction theorems in the required elliptic-curve form.  The
structure `FreyTwelveTorsionGlobalInput` therefore exposes exactly those two
source-facing consequences, rather than storing the final
`IsInitialThetaGlobalData` object as an opaque field.

A single odd multiplicative bad moduli place is then enough to construct the
nonempty bad locus.  The module assembles an actual `FixedIUTCore` and proves
that its source curve has the genuine rational Frey j-invariant.  No
admissible-prime, orbicurve, tempered, IUT III, Corollary 3.12, or abc
inequality is assumed.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

/-- The actual Frey curve after base change from `ℚ` to a field `F`. -/
noncomputable def freyCurveOver
    (P : ABCPoint)
    (F : Type u) [Field F] [Algebra ℚ F] :
    WeierstrassCurve F :=
  (abcFreyCurve P).baseChange F

noncomputable instance freyCurveOver_isElliptic
    (P : ABCPoint)
    (F : Type u) [Field F] [Algebra ℚ F] :
    (freyCurveOver P F).IsElliptic := by
  change ((abcFreyCurve P).map (algebraMap ℚ F)).IsElliptic
  infer_instance

/-- Base change preserves the genuine Frey j-invariant. -/
@[simp]
theorem freyCurveOver_j
    (P : ABCPoint)
    (F : Type u) [Field F] [Algebra ℚ F] :
    (freyCurveOver P F).j =
      algebraMap ℚ F (abcFreyCurve P).j := by
  simpa [freyCurveOver, WeierstrassCurve.baseChange] using
    (WeierstrassCurve.map_j
      (abcFreyCurve P) (algebraMap ℚ F))

/-- Rationality over `F` of all `n`-torsion points after passage to an
algebraic closure `Fbar`. -/
open scoped Classical in
def TorsionRationalAt
    (F : Type u) [Field F]
    (E : WeierstrassCurve F) [E.IsElliptic]
    (Fbar : Type u) [Field Fbar] [Algebra F Fbar]
    (n : ℕ) : Prop :=
  ∀ Q ∈ AddSubgroup.torsionBy
      (Affine.Point (Affine.baseChange E Fbar)) n,
    Q ∈ (Affine.Point.baseChange (W' := E) F Fbar).range

/-- If `m ∣ n`, every `m`-torsion point is an `n`-torsion point. -/
theorem torsionBy_le_of_dvd
    {A : Type*} [AddCommGroup A]
    {m n : ℕ} (hmn : m ∣ n) :
    AddSubgroup.torsionBy A m ≤ AddSubgroup.torsionBy A n := by
  intro x hx
  rw [AddSubgroup.torsionBy.nsmul_iff] at hx ⊢
  rcases hmn with ⟨k, rfl⟩
  calc
    (m * k) • x = k • (m • x) := by
      rw [Nat.mul_comm, mul_nsmul]
    _ = 0 := by rw [hx, nsmul_zero]

/-- Rationality of a larger torsion level implies rationality of every
sublevel dividing it. -/
theorem torsionRationalAt_of_dvd
    {F : Type u} [Field F]
    {E : WeierstrassCurve F} [E.IsElliptic]
    {Fbar : Type u} [Field Fbar] [Algebra F Fbar]
    {m n : ℕ}
    (hmn : m ∣ n)
    (hn : TorsionRationalAt F E Fbar n) :
    TorsionRationalAt F E Fbar m := by
  classical
  unfold TorsionRationalAt at hn ⊢
  intro Q hQ
  exact hn Q (torsionBy_le_of_dvd hmn hQ)

/-- Full 12-torsion rationality implies the six-torsion rationality required
by public initial theta-data. -/
theorem sixTorsionRational_of_twelve
    {F : Type u} [Field F]
    {E : WeierstrassCurve F} [E.IsElliptic]
    {Fbar : Type u} [Field Fbar] [Algebra F Fbar]
    (h12 : TorsionRationalAt F E Fbar 12) :
    SixTorsionRational F E Fbar := by
  classical
  unfold SixTorsionRational TorsionRationalAt at h12 ⊢
  intro Q hQ
  exact h12 Q (torsionBy_le_of_dvd (by norm_num : 6 ∣ 12) hQ)

/-- Stable reduction away from 2 and stable reduction away from 3 together
cover every finite place.  This is the elementary local patching step behind
the levels 4 and 3 semistability route. -/
theorem stableReduction_of_away_two_and_three
    {F : Type u} [Field F] [NumberField F]
    (E : WeierstrassCurve F) [E.IsElliptic]
    (hAwayTwo : ∀ w : FinitePlace F,
      residueChar w ≠ 2 → HasStableReductionAt E w)
    (hAwayThree : ∀ w : FinitePlace F,
      residueChar w ≠ 3 → HasStableReductionAt E w) :
    ∀ w : FinitePlace F, HasStableReductionAt E w := by
  intro w
  by_cases h2 : residueChar w = 2
  · apply hAwayThree w
    intro h3
    omega
  · exact hAwayTwo w h2

/-- Exact arithmetic input for constructing the fixed global core of a Frey
initial-theta datum.

The fields `sqrt_neg_one`, `stable_away_two`, and `stable_away_three` are the
precise outputs expected respectively from the Weil pairing and the two
semistable-reduction applications.  They are not replaced by a preassembled
`IsInitialThetaGlobalData` field. -/
structure FreyTwelveTorsionGlobalInput (P : ABCPoint) : Type (u + 1) where
  F : Type u
  [fieldF : Field F]
  [numberFieldF : NumberField F]
  Fbar : Type u
  [fieldFbar : Field Fbar]
  [algebraFbar : Algebra F Fbar]
  [isAlgClosure : IsAlgClosure F Fbar]
  twelve_torsion_rational :
    TorsionRationalAt F (freyCurveOver P F) Fbar 12
  sqrt_neg_one : IsSquare (-1 : F)
  stable_away_two : ∀ w : FinitePlace F,
    residueChar w ≠ 2 →
      HasStableReductionAt (freyCurveOver P F) w
  stable_away_three : ∀ w : FinitePlace F,
    residueChar w ≠ 3 →
      HasStableReductionAt (freyCurveOver P F) w
  badModPlace :
    FinitePlace ↥(fieldOfModuli F (freyCurveOver P F))
  bad_odd : Odd (residueChar badModPlace)
  bad_multiplicative : ∀ w : FinitePlace F,
    w.1.LiesOver badModPlace.1 →
      HasMultiplicativeReductionAt (freyCurveOver P F) w

namespace FreyTwelveTorsionGlobalInput

attribute [instance]
  fieldF numberFieldF fieldFbar algebraFbar isAlgClosure

variable {P : ABCPoint}
variable (D : FreyTwelveTorsionGlobalInput.{u} P)

/-- The chosen bad moduli-place locus is the singleton containing the supplied
odd multiplicative place. -/
noncomputable def VBad :
    Set (FinitePlace ↥(fieldOfModuli D.F (freyCurveOver P D.F))) :=
  {D.badModPlace}

/-- The two semistable complements give stable reduction at every finite
place. -/
theorem stable_reduction :
    ∀ w : FinitePlace D.F,
      HasStableReductionAt (freyCurveOver P D.F) w :=
  stableReduction_of_away_two_and_three
    (freyCurveOver P D.F)
    D.stable_away_two D.stable_away_three

/-- The full global conditions of public initial theta-data, assembled from
the explicit twelve-torsion source inputs. -/
noncomputable def global :
    IsInitialThetaGlobalData
      D.F (freyCurveOver P D.F) D.Fbar D.VBad where
  sqrt_neg_one := D.sqrt_neg_one
  stable_reduction := D.stable_reduction
  six_torsion_rational :=
    sixTorsionRational_of_twelve D.twelve_torsion_rational
  bad_nonempty := by
    exact ⟨D.badModPlace, Set.mem_singleton _⟩
  bad_odd := by
    intro v hv
    have hv' : v = D.badModPlace := Set.mem_singleton_iff.mp hv
    subst v
    exact D.bad_odd
  bad_multiplicative := by
    intro v hv w hw
    have hv' : v = D.badModPlace := Set.mem_singleton_iff.mp hv
    subst v
    exact D.bad_multiplicative w hw

/-- The resulting actual fixed global core for the Frey input. -/
noncomputable def fixedCore : FixedIUTCore.{u} where
  F := D.F
  fieldF := D.fieldF
  numberFieldF := D.numberFieldF
  Fbar := D.Fbar
  fieldFbar := D.fieldFbar
  algebraFbar := D.algebraFbar
  isAlgClosure := D.isAlgClosure
  E := freyCurveOver P D.F
  isElliptic := inferInstance
  VBad := D.VBad
  global := D.global

/-- The fixed core is calibrated to the actual rational Frey j-invariant. -/
theorem fixedCore_j_calibration :
    D.fixedCore.E.j =
      algebraMap ℚ D.fixedCore.F (abcFreyCurve P).j := by
  exact freyCurveOver_j P D.F

/-- In particular, the fixed core has rational j-invariant in the exact form
used by the moduli-degree-one theorem. -/
theorem fixedCore_j_rational :
    ∃ q : ℚ,
      D.fixedCore.E.j = algebraMap ℚ D.fixedCore.F q :=
  ⟨(abcFreyCurve P).j, D.fixedCore_j_calibration⟩

end FreyTwelveTorsionGlobalInput

end IUTThreeClosures
