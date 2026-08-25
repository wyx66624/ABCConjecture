/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZOrbitProperness

/-!
# The genuine integer deck action on the theta-root pullback

The corrected deck transformation is a self-equivalence of the theta-root
pullback.  Integer powers of this equivalence therefore define an honest
`Z`-action, not merely a family of point maps.

This file packages that action through the group of permutations, proves its
zero and addition laws, identifies nonnegative powers with the previously
verified natural iterates, and proves the normalized radial coordinate formula
for all integer powers.

The action is then exposed as a multiplicative action of `Multiplicative Z`,
which gives Mathlib's canonical orbit setoid and hence a genuine orbit quotient
for subsequent topology and covering-space constructions.
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
  simp [deckZEquiv]

/-- Integer addition is composition of deck equivalences. -/
theorem deckZEquiv_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℤ) :
    deckZEquiv t ell r hr (m + n) =
      (deckZEquiv t ell r hr n).trans
        (deckZEquiv t ell r hr m) := by
  unfold deckZEquiv
  rw [zpow_add₀]
  rfl

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
  rw [deckZ, deckZ, deckZ, deckZEquiv_add]
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
  | zero => simp [deckZ]
  | succ n ih =>
      rw [Nat.cast_succ, deckZ_add, ih]
      change
        TateThetaRootPullbackPoint.shiftEquiv t ell r hr
            (TateThetaRootPullbackPoint.shiftNat t ell r hr n z) =
          TateThetaRootPullbackPoint.shiftNat t ell r hr (n + 1) z
      rw [TateThetaRootPullbackPoint.shiftNat_succ]

/-- The permutation-power action and the previously defined piecewise integer
iteration agree. -/
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
      induction k with
      | zero =>
          change
            (deckGenerator t ell r hr)⁻¹ z =
              (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z
          rfl
      | succ k ih =>
          have hstep := deckZ_add t ell r hr
            (-((k + 1 : ℕ) : ℤ)) (-1) z
          change
            deckZ t ell r hr (-((k + 2 : ℕ) : ℤ)) z =
              shiftNegNat t ell r hr (k + 2) z
          rw [show (-((k + 2 : ℕ) : ℤ)) =
              -((k + 1 : ℕ) : ℤ) + (-1) by omega,
            deckZ_add]
          rw [deckZ_eq_shiftInt]
          change
            shiftNegNat t ell r hr (k + 1)
                ((TateThetaRootPullbackPoint.shiftEquiv
                  t ell r hr).symm z) =
              shiftNegNat t ell r hr (k + 2) z
          rfl
termination_by n => Int.natAbs n

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

/-- The action as a multiplicative action of the multiplicative copy of the
integer additive group. -/
noncomputable instance deckMultiplicativeIntAction
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

/-- The canonical orbit setoid of the genuine integer deck action. -/
noncomputable def deckOrbitSetoid
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Setoid (TateThetaRootPullbackPoint t ell) :=
  MulAction.orbitRel (Multiplicative ℤ)
    (TateThetaRootPullbackPoint t ell)

/-- The genuine set-theoretic integer deck quotient. -/
abbrev DeckOrbitQuotient
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :=
  Quotient (deckOrbitSetoid t ell r hr)

end TateThetaRootRadialSkeleton

end IUTThreeClosures
