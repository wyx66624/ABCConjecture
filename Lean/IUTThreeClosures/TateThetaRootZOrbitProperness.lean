/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton

/-!
# Two-sided radial properness of the theta-root deck action

The corrected theta-root deck generator acts by translation by one on the
normalized logarithmic radial coordinate.  This file extends the positive
natural iterates to the complete integer orbit and proves the finiteness
statements needed before forming an analytic quotient.

For a chosen root `r` with `r^ell = q`, write `T` for the corrected deck
self-equivalence and `rho` for the normalized radial coordinate.  We construct
negative natural iterates and integer iterates and prove

`rho(T^n z) = rho(z) + n`

for every integer `n`.  It follows that

* negative iterates escape every radially bounded annulus toward `-infinity`;
* positive iterates escape toward `+infinity`;
* only finitely many members of a complete integer orbit meet a fixed radial
  annulus;
* for any two radially bounded subsets, only finitely many deck translates of
  the first meet the second.

The last result is the compact-intersection finiteness statement underlying
proper discontinuity, with `compact` replaced by the exact property used in
the proof: boundedness of the radial coordinate.  A later topological or
Berkovich realization only has to prove that its compact subsets are radially
bounded.

No quotient topology, Berkovich space, orbicurve, tempered fundamental group,
graph cusp, IUT source theorem, or abc conclusion is assumed here.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- Negative natural deck iteration, implemented by repeated application of
the inverse corrected deck equivalence. -/
noncomputable def shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℕ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | 0, z => z
  | n + 1, z =>
      shiftNegNat t ell r hr n
        ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z)

/-- One inverse deck step translates the radial coordinate by `-1`. -/
theorem coordinate_shiftEquiv_symm
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z) =
      coordinate t ell r z - 1 := by
  have h := coordinate_shiftEquiv t ell r hr
    ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z)
  have h' :
      coordinate t ell r z =
        coordinate t ell r
          ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z) + 1 := by
    simpa using h
  linarith

/-- The `n`-th inverse deck iterate translates the radial coordinate by
`-n`. -/
theorem coordinate_shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftNegNat t ell r hr n z) =
      coordinate t ell r z - n := by
  induction n generalizing z with
  | zero => simp [shiftNegNat]
  | succ n ih =>
      rw [shiftNegNat, ih, coordinate_shiftEquiv_symm]
      push_cast
      ring

/-- Complete integer iteration of the corrected theta-root deck generator. -/
noncomputable def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootPullbackPoint t ell :=
  match n with
  | Int.ofNat k => TateThetaRootPullbackPoint.shiftNat t ell r hr k z
  | Int.negSucc k => shiftNegNat t ell r hr (k + 1) z

/-- Every integer deck iterate acts by the corresponding integer translation
on the normalized radial coordinate. -/
theorem coordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftInt t ell r hr n z) =
      coordinate t ell r z + n := by
  cases n with
  | ofNat k =>
      simpa [shiftInt] using coordinate_shiftNat t ell r hr k z
  | negSucc k =>
      change
        coordinate t ell r (shiftNegNat t ell r hr (k + 1) z) =
          coordinate t ell r z + ((Int.negSucc k : ℤ) : ℝ)
      rw [coordinate_shiftNegNat]
      push_cast
      ring

/-- Positive iterates eventually lie above every prescribed radial level. -/
theorem exists_shiftNat_coordinate_gt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (A : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      A < coordinate t ell r
        (TateThetaRootPullbackPoint.shiftNat t ell r hr n z) := by
  obtain ⟨N, hN⟩ := exists_nat_gt (A - coordinate t ell r z)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftNat]
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  linarith

/-- Negative iterates eventually lie below every prescribed radial level. -/
theorem exists_shiftNegNat_coordinate_lt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (A : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      coordinate t ell r (shiftNegNat t ell r hr n z) < A := by
  obtain ⟨N, hN⟩ := exists_nat_gt (coordinate t ell r z - A)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftNegNat]
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  linarith

/-- A closed annulus in the normalized logarithmic radial coordinate. -/
def radialAnnulus
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b}

@[simp]
theorem mem_radialAnnulus
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) (z : TateThetaRootPullbackPoint t ell) :
    z ∈ radialAnnulus t ell r a b ↔
      a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b :=
  Iff.rfl

/-- Real lower and upper bounds on an integer variable are covered by one
explicit finite symmetric integer interval. -/
theorem exists_integerInterval_cover
    (L U : ℝ) :
    ∃ S : Finset ℤ, ∀ n : ℤ,
      L ≤ (n : ℝ) → (n : ℝ) ≤ U → n ∈ S := by
  obtain ⟨N, hN⟩ := exists_nat_gt (max |L| |U|)
  refine ⟨Finset.Icc (-(N : ℤ)) (N : ℤ), ?_⟩
  intro n hnL hnU
  have hL_abs : |L| < (N : ℝ) :=
    (le_max_left |L| |U|).trans_lt hN
  have hU_abs : |U| < (N : ℝ) :=
    (le_max_right |L| |U|).trans_lt hN
  have hlowerReal : -(N : ℝ) ≤ (n : ℝ) := by
    have hneg : -(N : ℝ) < L := by
      have hnegAbs : -|L| ≤ L := neg_abs_le L
      linarith
    linarith
  have hupperReal : (n : ℝ) ≤ (N : ℝ) := by
    have hu : U < (N : ℝ) :=
      (le_abs_self U).trans_lt hU_abs
    linarith
  have hlowerInt : -(N : ℤ) ≤ n := by
    exact_mod_cast hlowerReal
  have hupperInt : n ≤ (N : ℤ) := by
    exact_mod_cast hupperReal
  simpa using And.intro hlowerInt hupperInt

/-- Only finitely many members of a complete integer deck orbit meet one
closed radial annulus. -/
theorem exists_finite_shiftInt_meeting_radialAnnulus
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    ∃ S : Finset ℤ, ∀ n : ℤ,
      shiftInt t ell r hr n z ∈ radialAnnulus t ell r a b →
        n ∈ S := by
  obtain ⟨S, hS⟩ :=
    exists_integerInterval_cover
      (a - coordinate t ell r z)
      (b - coordinate t ell r z)
  refine ⟨S, ?_⟩
  intro n hn
  have hbounds :=
    (mem_radialAnnulus t ell r a b _).mp hn
  rw [coordinate_shiftInt] at hbounds
  apply hS n <;> linarith

/-- Set-theoretic finite form of the preceding complete-orbit theorem. -/
theorem shiftInt_meeting_radialAnnulus_finite
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    {n : ℤ |
      shiftInt t ell r hr n z ∈ radialAnnulus t ell r a b}.Finite := by
  obtain ⟨S, hS⟩ :=
    exists_finite_shiftInt_meeting_radialAnnulus
      t ell r hr z a b
  exact S.finite_toSet.subset fun n hn => hS n hn

/-- A subset is radially bounded when all its points lie between two finite
normalized radial levels. -/
def IsRadiallyBounded
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (U : Set (TateThetaRootPullbackPoint t ell)) : Prop :=
  ∃ a b : ℝ, ∀ z ∈ U,
    a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b

/-- Integer shifts for which some point of `U` is carried into `V`. -/
def meetingShiftIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (U V : Set (TateThetaRootPullbackPoint t ell)) : Set ℤ :=
  {n | ∃ z ∈ U, shiftInt t ell r hr n z ∈ V}

/-- **Radial properness theorem.**  Between two radially bounded subsets, only
finitely many complete integer deck translates can meet. -/
theorem meetingShiftIndices_finite_of_radiallyBounded
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    {U V : Set (TateThetaRootPullbackPoint t ell)}
    (hU : IsRadiallyBounded t ell r U)
    (hV : IsRadiallyBounded t ell r V) :
    (meetingShiftIndices t ell r hr U V).Finite := by
  rcases hU with ⟨a, b, hU⟩
  rcases hV with ⟨c, d, hV⟩
  obtain ⟨S, hS⟩ :=
    exists_integerInterval_cover (c - b) (d - a)
  refine S.finite_toSet.subset ?_
  intro n hn
  rcases hn with ⟨z, hzU, hzV⟩
  have hzU' := hU z hzU
  have hzV' := hV (shiftInt t ell r hr n z) hzV
  rw [coordinate_shiftInt] at hzV'
  apply hS n <;> linarith

/-- The exact proper-discontinuity property established by the radial
coordinate.  Any topology in which compact sets are radially bounded inherits
the usual compact-intersection finiteness criterion for the deck action. -/
def RadiallyProperDeckAction
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) : Prop :=
  ∀ U V : Set (TateThetaRootPullbackPoint t ell),
    IsRadiallyBounded t ell r U →
    IsRadiallyBounded t ell r V →
      (meetingShiftIndices t ell r hr U V).Finite

/-- The corrected theta-root deck action is radially proper. -/
theorem radiallyProperDeckAction
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    RadiallyProperDeckAction t ell r hr := by
  intro U V hU hV
  exact meetingShiftIndices_finite_of_radiallyBounded
    t ell r hr hU hV

end TateThetaRootRadialSkeleton

end IUTThreeClosures
