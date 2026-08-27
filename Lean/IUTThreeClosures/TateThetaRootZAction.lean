/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZOrbitProperness

/-!
# The genuine integer deck action on the theta-root pullback

The corrected deck transformation is a self-equivalence of the theta-root
pullback. Integer powers of this equivalence therefore define an honest
integer action.

This file packages that action through the group of permutations, proves its
addition law, and proves the radial translation formula directly for positive
and negative powers.  The proof deliberately avoids recursively identifying
the permutation power with the older piecewise `shiftInt` definition.

The action is provided as an explicit `MulAction` value rather than a global
instance: it depends on the chosen root `r` and on the proof `r^ell=q`, neither
of which can be inferred from the acted-on type alone.
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
    deckZEquiv t ell r hr 0 =
      (1 : Equiv.Perm (TateThetaRootPullbackPoint t ell)) := by
  simp [deckZEquiv]

/-- Integer addition is multiplication of deck permutations. -/
theorem deckZEquiv_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℤ) :
    deckZEquiv t ell r hr (m + n) =
      deckZEquiv t ell r hr m *
        deckZEquiv t ell r hr n := by
  simp [deckZEquiv, zpow_add]

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
  simp [deckZ]

/-- Pointwise action law. -/
theorem deckZ_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (m + n) z =
      deckZ t ell r hr m (deckZ t ell r hr n z) := by
  change
    deckZEquiv t ell r hr (m + n) z =
      deckZEquiv t ell r hr m
        (deckZEquiv t ell r hr n z)
  rw [deckZEquiv_add]
  rfl

@[simp]
theorem deckZ_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr 1 z =
      TateThetaRootPullbackPoint.shiftEquiv t ell r hr z := by
  simp [deckZ, deckZEquiv, deckGenerator]

@[simp]
theorem deckZ_neg_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    deckZ t ell r hr (-1) z =
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z := by
  simp [deckZ, deckZEquiv, deckGenerator]

/-- Radial translation formula for nonnegative powers. -/
theorem coordinate_deckZ_nat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (deckZ t ell r hr (n : ℤ) z) =
      coordinate t ell r z + n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [show ((n + 1 : ℕ) : ℤ) = 1 + (n : ℤ) by omega,
        deckZ_add, deckZ_one, coordinate_shiftEquiv, ih]
      push_cast
      ring

/-- Radial translation formula for negative natural powers. -/
theorem coordinate_deckZ_negNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (deckZ t ell r hr (-((n : ℕ) : ℤ)) z) =
      coordinate t ell r z - n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [show (-((n + 1 : ℕ) : ℤ)) = (-1) + (-((n : ℕ) : ℤ)) by omega,
        deckZ_add, deckZ_neg_one, coordinate_shiftEquiv_symm, ih]
      push_cast
      ring

/-- The genuine integer action has the exact normalized radial translation
formula. -/
theorem coordinate_deckZ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (deckZ t ell r hr n z) =
      coordinate t ell r z + n := by
  cases n with
  | ofNat k =>
      simpa using coordinate_deckZ_nat t ell r hr k z
  | negSucc k =>
      rw [show (Int.negSucc k : ℤ) = -((k + 1 : ℕ) : ℤ) by omega,
        coordinate_deckZ_negNat]
      push_cast
      ring

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

/-- The action as an explicit multiplicative action of the multiplicative copy
of the integer additive group. -/
noncomputable def deckMultiplicativeIntAction
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    MulAction (Multiplicative ℤ)
      (TateThetaRootPullbackPoint t ell) where
  smul n z := deckZ t ell r hr n.toAdd z
  one_smul z := by
    change deckZ t ell r hr 0 z = z
    simp
  mul_smul m n z := by
    change
      deckZ t ell r hr (m.toAdd + n.toAdd) z =
        deckZ t ell r hr m.toAdd
          (deckZ t ell r hr n.toAdd z)
    exact deckZ_add t ell r hr m.toAdd n.toAdd z

/-- The canonical orbit setoid of the chosen genuine integer deck action. -/
noncomputable def deckOrbitSetoid
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Setoid (TateThetaRootPullbackPoint t ell) := by
  letI : MulAction (Multiplicative ℤ)
      (TateThetaRootPullbackPoint t ell) :=
    deckMultiplicativeIntAction t ell r hr
  exact MulAction.orbitRel (Multiplicative ℤ)
    (TateThetaRootPullbackPoint t ell)

/-- The genuine set-theoretic integer deck quotient. -/
abbrev DeckOrbitQuotient
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :=
  Quotient (deckOrbitSetoid t ell r hr)

end TateThetaRootRadialSkeleton

end IUTThreeClosures
