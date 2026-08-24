/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZOrbitProperness

/-!
# The genuine integer deck action on the theta-root pullback

The corrected deck transformation is a self-equivalence of the theta-root
pullback. Integer powers of this equivalence define an honest `Z`-action.

The deck group is implemented as an indexed type synonym for
`Multiplicative Z`.  Indexing the group by the chosen theta root keeps the
choice `r^ell=q` visible to typeclass inference and avoids an ambiguous global
action instance on the unindexed point type.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- The corrected deck permutation. -/
noncomputable def deckGenerator
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Equiv.Perm (TateThetaRootPullbackPoint t ell) :=
  TateThetaRootPullbackPoint.shiftEquiv t ell r hr

/-- Integer powers of the corrected deck permutation. -/
noncomputable def deckZEquiv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ) :
    Equiv.Perm (TateThetaRootPullbackPoint t ell) :=
  deckGenerator t ell r hr ^ n

@[simp]
theorem deckZEquiv_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    deckZEquiv t ell r hr 0 = Equiv.refl _ := by
  change deckGenerator t ell r hr ^ (0 : ℤ) = 1
  exact zpow_zero _

/-- Integer addition is composition of deck equivalences. -/
theorem deckZEquiv_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℤ) :
    deckZEquiv t ell r hr (m + n) =
      (deckZEquiv t ell r hr n).trans
        (deckZEquiv t ell r hr m) := by
  change deckGenerator t ell r hr ^ (m + n) =
    deckGenerator t ell r hr ^ m * deckGenerator t ell r hr ^ n
  exact zpow_add _ _ _

/-- Point form of the integer deck action. -/
noncomputable def deckZ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootPullbackPoint t ell :=
  deckZEquiv t ell r hr n z

@[simp]
theorem deckZ_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr 0 z = z := by
  change (deckZEquiv t ell r hr 0) z = z
  rw [deckZEquiv_zero]
  rfl

/-- Pointwise action law. -/
theorem deckZ_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (m + n) z =
      deckZ t ell r hr m (deckZ t ell r hr n z) := by
  change (deckZEquiv t ell r hr (m + n)) z =
    (deckZEquiv t ell r hr m)
      ((deckZEquiv t ell r hr n) z)
  rw [deckZEquiv_add]
  rfl

@[simp]
theorem deckZ_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr 1 z =
      TateThetaRootPullbackPoint.shift t ell r hr z := by
  change (deckGenerator t ell r hr ^ (1 : ℤ)) z = _
  rw [zpow_one]
  rfl

@[simp]
theorem deckZ_neg_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (-1) z =
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z := by
  change (deckGenerator t ell r hr ^ (-1 : ℤ)) z = _
  rw [zpow_neg_one]
  rfl

/-- A nonnegative integer power agrees with the existing natural iteration. -/
theorem deckZ_ofNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (n : ℤ) z =
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z := by
  induction n with
  | zero => simp
  | succ n ih =>
      have hcast : ((n + 1 : ℕ) : ℤ) = 1 + (n : ℤ) := by omega
      rw [hcast, deckZ_add, deckZ_one, ih]
      rfl

/-- A negative integer power agrees with repeated inverse iteration. -/
theorem deckZ_negSucc
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (k : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (Int.negSucc k) z =
      shiftNegNat t ell r hr (k + 1) z := by
  induction k generalizing z with
  | zero =>
      simpa [shiftNegNat] using deckZ_neg_one t ell r hr z
  | succ k ih =>
      have hneg :
          Int.negSucc (k + 1) = Int.negSucc k + (-1) := by
        omega
      rw [hneg, deckZ_add, deckZ_neg_one, ih]
      rfl

/-- The permutation-power action and the existing piecewise integer iteration
agree. -/
theorem deckZ_eq_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr n z = shiftInt t ell r hr n z := by
  cases n with
  | ofNat k =>
      simpa [shiftInt] using deckZ_ofNat t ell r hr k z
  | negSucc k =>
      simpa [shiftInt] using deckZ_negSucc t ell r hr k z

/-- The genuine integer action has the exact normalized radial translation
formula. -/
theorem coordinate_deckZ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (deckZ t ell r hr n z) =
      coordinate t ell r z + n := by
  rw [deckZ_eq_shiftInt]
  exact coordinate_shiftInt t ell r hr n z

/-- The genuine integer deck action is free. -/
theorem deckZ_fixed_iff_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr n z = z ↔ n = 0 := by
  constructor
  · intro h
    have hcoord := congrArg (coordinate t ell r) h
    rw [coordinate_deckZ] at hcoord
    have hnreal : (n : ℝ) = 0 := by linarith
    exact_mod_cast hnreal
  · rintro rfl
    simp

/-- The deck group, indexed by the chosen theta root so that the action is
unambiguous to typeclass synthesis. -/
def DeckGroup
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :=
  Multiplicative ℤ

namespace DeckGroup

instance (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Group (DeckGroup t ell r hr) :=
  inferInstanceAs (Group (Multiplicative ℤ))

/-- Forget the indexing and recover the underlying integer. -/
def toInt
    {t : TateParameter K} {ell : ℕ}
    {r : Kˣ} {hr : r ^ ell = t.q}
    (g : DeckGroup t ell r hr) : ℤ :=
  Multiplicative.toAdd g

/-- The indexed deck group is canonically equivalent to the multiplicative
copy of the integers. -/
def equivMultiplicativeInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    DeckGroup t ell r hr ≃ Multiplicative ℤ :=
  Equiv.refl _

end DeckGroup

/-- The honest action of the indexed deck group. -/
noncomputable instance deckGroupAction
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    MulAction (DeckGroup t ell r hr)
      (TateThetaRootPullbackPoint t ell) where
  smul g z := deckZ t ell r hr (DeckGroup.toInt g) z
  one_smul z := by
    change deckZ t ell r hr 0 z = z
    simp
  mul_smul g h z := by
    change
      deckZ t ell r hr
          (DeckGroup.toInt g + DeckGroup.toInt h) z =
        deckZ t ell r hr (DeckGroup.toInt g)
          (deckZ t ell r hr (DeckGroup.toInt h) z)
    exact deckZ_add t ell r hr _ _ z

/-- The canonical orbit setoid of the genuine integer deck action. -/
noncomputable def deckOrbitSetoid
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Setoid (TateThetaRootPullbackPoint t ell) :=
  MulAction.orbitRel (DeckGroup t ell r hr)
    (TateThetaRootPullbackPoint t ell)

/-- The genuine set-theoretic integer deck quotient. -/
abbrev DeckOrbitQuotient
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :=
  Quotient (deckOrbitSetoid t ell r hr)

end TateThetaRootRadialSkeleton

end IUTThreeClosures
