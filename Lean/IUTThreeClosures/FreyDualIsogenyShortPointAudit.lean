/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyKummerPacketClassification
import IUTThreeClosures.FreyNearSingularHeightLatticeAudit
import IUTThreeClosures.WeightedPoitouTateSelectorAudit

/-!
# Short points in the three dual two-isogeny images

For every rational two-isogeny `phi` with dual `dualPhi`, the factorization
`dualPhi (phi P) = 2 P` puts every doubled rational point in the dual image.
Thus, after a non-torsion rational point is known to exist, one and the same
doubled point lies in all three dual images of a full-two-torsion Frey curve.
Its canonical height is four times the height of the original point.  The
paper companion interprets this as the exact reduction of the adaptive
heavy-line problem to the first *integral* Mordell--Weil minimum.

The module also records a strict local separation.  A rational half has a
one-element Galois-difference orbit and hence one packet at all three
collision types, but this does not put the half in the identity component.
In an `I_4` component model, a point on component `1` and its antipodal
two-torsion translate on component `3` both have Bernoulli coefficient
`-1/48`.  Therefore neither the one-packet condition nor two-torsion
translation alone certifies a positive local-height term.

Lean formalizes only additive-group factorization, scalar height identities,
the finite packet table, and the `I_4`/Bernoulli calculation.  Elliptic
curves, isogenies, canonical heights, Mordell--Weil ranks and minima, Tate
uniformization, Neron components, conductors, discriminants, and abc are
paper interpretations, not hidden assumptions here.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The factor-four simultaneous dual-image selector -/

/-- An abstract dual two-isogeny factorization.  On elliptic curves the two
maps are an isogeny and its dual, and the displayed equation is
`dualPhi o phi = [2]`. -/
structure DualTwoFactorization (E E' : Type*)
    [AddCommGroup E] [AddCommGroup E'] where
  phi : E →+ E'
  dualPhi : E' →+ E
  dual_phi_eq_double : ∀ P : E, dualPhi (phi P) = 2 • P

/-- Every doubled point lies in the dual image. -/
theorem double_mem_dualImage
    {E E' : Type*} [AddCommGroup E] [AddCommGroup E']
    (F : DualTwoFactorization E E') (P : E) :
    2 • P ∈ Set.range F.dualPhi := by
  exact ⟨F.phi P, F.dual_phi_eq_double P⟩

/-- The same doubled point lies simultaneously in three prescribed dual
two-isogeny images. -/
theorem double_mem_threeDualImages
    {E E₀ E₁ E₂ : Type*}
    [AddCommGroup E] [AddCommGroup E₀]
    [AddCommGroup E₁] [AddCommGroup E₂]
    (F₀ : DualTwoFactorization E E₀)
    (F₁ : DualTwoFactorization E E₁)
    (F₂ : DualTwoFactorization E E₂) (P : E) :
    2 • P ∈ Set.range F₀.dualPhi ∩
      Set.range F₁.dualPhi ∩ Set.range F₂.dualPhi := by
  exact ⟨⟨double_mem_dualImage F₀ P,
    double_mem_dualImage F₁ P⟩, double_mem_dualImage F₂ P⟩

/-- Abstract data sufficient to say that doubling preserves non-torsion and
quadruples height.  These are standard canonical-height facts on an elliptic
curve, but are hypotheses rather than an elliptic-curve API in this module. -/
structure QuadraticDoubleData (E : Type*) [AddCommGroup E] where
  IsTorsion : E → Prop
  height : E → ℝ
  double_nonTorsion : ∀ {P : E}, ¬ IsTorsion P → ¬ IsTorsion (2 • P)
  height_double : ∀ P : E, height (2 • P) = 4 * height P

/-- Any supplied non-torsion point of height at most `B` gives a non-torsion
point in one dual image of height at most `4B`. -/
theorem shortPoint_in_dualImage
    {E E' : Type*} [AddCommGroup E] [AddCommGroup E']
    (F : DualTwoFactorization E E') (Q : QuadraticDoubleData E)
    {P : E} {B : ℝ} (hnon : ¬ Q.IsTorsion P)
    (hshort : Q.height P ≤ B) :
    ∃ R : E, R ∈ Set.range F.dualPhi ∧
      ¬ Q.IsTorsion R ∧ Q.height R ≤ 4 * B := by
  refine ⟨2 • P, double_mem_dualImage F P,
    Q.double_nonTorsion hnon, ?_⟩
  rw [Q.height_double]
  exact mul_le_mul_of_nonneg_left hshort (by norm_num)

/-- More strongly, the factor-four point works simultaneously for all three
dual images.  Hence selecting the heaviest collision type costs nothing
beyond the common factor four once a short non-torsion point is available. -/
theorem shortPoint_in_threeDualImages
    {E E₀ E₁ E₂ : Type*}
    [AddCommGroup E] [AddCommGroup E₀]
    [AddCommGroup E₁] [AddCommGroup E₂]
    (F₀ : DualTwoFactorization E E₀)
    (F₁ : DualTwoFactorization E E₁)
    (F₂ : DualTwoFactorization E E₂)
    (Q : QuadraticDoubleData E) {P : E} {B : ℝ}
    (hnon : ¬ Q.IsTorsion P) (hshort : Q.height P ≤ B) :
    ∃ R : E, R ∈ Set.range F₀.dualPhi ∩
        Set.range F₁.dualPhi ∩ Set.range F₂.dualPhi ∧
      ¬ Q.IsTorsion R ∧ Q.height R ≤ 4 * B := by
  refine ⟨2 • P, double_mem_threeDualImages F₀ F₁ F₂ P,
    Q.double_nonTorsion hnon, ?_⟩
  rw [Q.height_double]
  exact mul_le_mul_of_nonneg_left hshort (by norm_num)

/-- A rational half has the trivial difference orbit, so the finite Kummer
table gives one packet at all three collision types. -/
theorem rationalHalf_has_onePacket_at_allTypes :
    (freyLocalPacketCount freyPacketA freyOrbitTrivial,
      freyLocalPacketCount freyPacketB freyOrbitTrivial,
      freyLocalPacketCount freyPacketC freyOrbitTrivial) = (1, 1, 1) :=
  freyPacketTable_trivial

/-! ## One packet is not an identity-component or sign certificate -/

/-- In the component group of an `I_4` fiber, a point on component `1`
remains nonidentity after either available component shift `0` or `2` from
rational two-torsion. -/
theorem I4_quarterComponent_no_identity_twoTorsionTranslate :
    (1 : ZMod 4) + 0 ≠ 0 ∧
      (1 : ZMod 4) + 2 ≠ 0 ∧
      (1 : ZMod 4) + 0 = 1 ∧
      (1 : ZMod 4) + 2 = 3 := by
  decide

/-- The Bernoulli depth coefficient is adverse at both antipodal quarter
components. -/
theorem tateBernoulliTwo_quarter_and_threeQuarter :
    tateBernoulliTwo (1 / 4) = -1 / 48 ∧
      tateBernoulliTwo (3 / 4) = -1 / 48 ∧
      tateBernoulliTwo (1 / 4) < 0 ∧
      tateBernoulliTwo (3 / 4) < 0 := by
  norm_num [tateBernoulliTwo]

/-- The finite one-packet table and the `I_4` calculation coexist: packet
number one does not logically imply that a two-torsion translate reaches
the identity component or a nonnegative Bernoulli coefficient. -/
theorem onePacket_without_identity_or_positiveBernoulli :
    (freyLocalPacketCount freyPacketA freyOrbitTrivial,
      freyLocalPacketCount freyPacketB freyOrbitTrivial,
      freyLocalPacketCount freyPacketC freyOrbitTrivial) = (1, 1, 1) ∧
    ((1 : ZMod 4) + 0 ≠ 0 ∧ (1 : ZMod 4) + 2 ≠ 0) ∧
    tateBernoulliTwo (1 / 4) < 0 ∧
      tateBernoulliTwo (3 / 4) < 0 := by
  refine ⟨freyPacketTable_trivial, ?_,
    tateBernoulliTwo_quarter_and_threeQuarter.2.2⟩
  exact ⟨I4_quarterComponent_no_identity_twoTorsionTranslate.1,
    I4_quarterComponent_no_identity_twoTorsionTranslate.2.1⟩

/-! ## The existing actual rank-zero endpoint remains decisive -/

/-- The primitive endpoint `(1,8,9)` has its only odd bad support at the
`c`-collision prime `3`, with positive exponent excess. -/
theorem oneEightNine_heaviestOddType_is_c :
    3 ∣ oneEightNineABCPoint.c ∧
      ¬ 3 ∣ oneEightNineABCPoint.a ∧
      ¬ 3 ∣ oneEightNineABCPoint.b ∧
      (oneEightNineABCPoint.a * oneEightNineABCPoint.b *
        oneEightNineABCPoint.c).factorization 3 - 1 = 1 := by
  refine ⟨by norm_num [oneEightNineABCPoint],
    by norm_num [oneEightNineABCPoint],
    by norm_num [oneEightNineABCPoint], ?_⟩
  exact oneEightNineABCPoint_three_exponentExcess

/-- Specializing the abstract rank-zero no-go to the heaviest collision
predicate shows that dual-image decoration cannot create a non-torsion
point on an all-torsion Mordell--Weil group. -/
theorem no_heaviestDualImage_shortPoint_of_all_torsion
    {Point : Type*} (IsTorsion InHeaviestDualImage : Point → Prop)
    (height : Point → ℝ) (B : ℝ)
    (hrankZero : ∀ P, IsTorsion P) :
    ¬ ∃ P, ¬ IsTorsion P ∧ InHeaviestDualImage P ∧ height P ≤ B := by
  rintro ⟨P, hnon, -⟩
  exact hnon (hrankZero P)

end

end IUTThreeClosures
