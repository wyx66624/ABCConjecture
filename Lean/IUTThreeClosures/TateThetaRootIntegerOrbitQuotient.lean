/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# Integer theta-root orbits and the radial topological quotient

The corrected theta-root deck generator acts by translation by one on the
normalized logarithmic radius.  This file extends the positive-iterate result
to the complete integer orbit.

We prove:

* inverse iterates translate the radial coordinate by negative integers;
* negative iterates escape every lower radial bound;
* positive iterates escape every upper radial bound;
* the complete `ℤ`-orbit meets every closed radial band, and hence every
  positive norm annulus, in only finitely many indices;
* the standard integer-translation skeleton is properly discontinuous;
* its compact topological quotient is Mathlib's unit additive circle
  `ℝ / ℤ`;
* the actual theta-root radial coordinate maps invariantly to this circle.

This closes the orbit-theoretic and radial-topological part of the analytic
quotient.  It does not identify the full Berkovich theta-root space with this
skeleton or prove that the Berkovich quotient deformation retracts to it.
Those are now isolated geometric comparison theorems rather than missing
integer-action estimates.
-/

namespace IUTThreeClosures

open TateCurvesTheta Set
open AddSubgroup

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootIntegerOrbit

open TateThetaRootRadialSkeleton

/-- Natural iterates of the inverse corrected deck generator. -/
def shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℕ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | 0 => fun z => z
  | n + 1 => fun z =>
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm
        (shiftNegNat t ell r hr n z)

@[simp]
theorem shiftNegNat_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNegNat t ell r hr 0 z = z :=
  rfl

@[simp]
theorem shiftNegNat_succ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    shiftNegNat t ell r hr (n + 1) z =
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm
        (shiftNegNat t ell r hr n z) :=
  rfl

/-- One inverse deck step translates the normalized radius by `-1`. -/
theorem coordinate_shiftInv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z) =
      coordinate t ell r z - 1 := by
  have h := coordinate_shiftEquiv t ell r hr
    ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z)
  rw [(TateThetaRootPullbackPoint.shiftEquiv t ell r hr).apply_symm_apply] at h
  linarith

/-- The `n`-th inverse iterate translates the normalized radius by `-n`. -/
theorem coordinate_shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftNegNat t ell r hr n z) =
      coordinate t ell r z - n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [shiftNegNat_succ, coordinate_shiftInv, ih]
      push_cast
      ring

/-- Complete integer iterate of the corrected deck generator.  `negSucc n`
means `-(n+1)`, hence is represented by `n+1` inverse steps. -/
def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℤ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | .ofNat n => TateThetaRootPullbackPoint.shiftNat t ell r hr n
  | .negSucc n => shiftNegNat t ell r hr (n + 1)

@[simp]
theorem shiftInt_ofNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    shiftInt t ell r hr (Int.ofNat n) z =
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z :=
  rfl

@[simp]
theorem shiftInt_negSucc
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    shiftInt t ell r hr (Int.negSucc n) z =
      shiftNegNat t ell r hr (n + 1) z :=
  rfl

/-- Every integer deck iterate acts by the corresponding integer translation
on the normalized radial coordinate. -/
theorem coordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (k : ℤ) (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftInt t ell r hr k z) =
      coordinate t ell r z + (k : ℝ) := by
  cases k with
  | ofNat n =>
      simpa using coordinate_shiftNat t ell r hr n z
  | negSucc n =>
      rw [shiftInt_negSucc, coordinate_shiftNegNat]
      push_cast
      ring

/-- Negative iterates eventually lie below every prescribed radial level. -/
theorem exists_shiftNegNat_coordinate_lt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (B : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      coordinate t ell r (shiftNegNat t ell r hr n z) < B := by
  obtain ⟨N, hN⟩ :
      ∃ N : ℕ, coordinate t ell r z - B < N :=
    exists_nat_gt (coordinate t ell r z - B)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftNegNat]
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  linarith

/-- Positive iterates eventually lie above every prescribed radial level. -/
theorem exists_shiftNat_coordinate_gt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (B : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      B < coordinate t ell r
        (TateThetaRootPullbackPoint.shiftNat t ell r hr n z) := by
  obtain ⟨N, hN⟩ :
      ∃ N : ℕ, B - coordinate t ell r z < N :=
    exists_nat_gt (B - coordinate t ell r z)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftNat]
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  linarith

/-- Closed band in the normalized radial skeleton. -/
def radialBand
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b}

@[simp]
theorem mem_radialBand
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) (z : TateThetaRootPullbackPoint t ell) :
    z ∈ radialBand t ell r a b ↔
      a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b :=
  Iff.rfl

/-- A finite explicit window containing every integer index whose orbit point
lies in a radial band. -/
noncomputable def integerWindow
    (Nneg Npos : ℕ) : Finset ℤ :=
  (Finset.range Npos).image (fun n : ℕ => (n : ℤ)) ∪
    (Finset.range Nneg).image Int.negSucc

/-- The complete integer orbit meets a closed radial band in only finitely many
indices. -/
theorem orbitIndices_radialBand_finite
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    {k : ℤ | shiftInt t ell r hr k z ∈ radialBand t ell r a b}.Finite := by
  obtain ⟨Nneg, hNneg⟩ :=
    exists_shiftNegNat_coordinate_lt t ell r hr z a
  obtain ⟨Npos, hNpos⟩ :=
    exists_shiftNat_coordinate_gt t ell r hr z b
  refine (integerWindow Nneg Npos).finite_toSet.subset ?_
  intro k hk
  cases k with
  | ofNat n =>
      have hband := (mem_radialBand t ell r a b _).mp hk
      have hnlt : n < Npos := by
        by_contra hnot
        have hn : Npos ≤ n := Nat.le_of_not_gt hnot
        exact (not_lt_of_ge hband.2) (hNpos n hn)
      apply Finset.mem_union_left
      exact Finset.mem_image.mpr ⟨n, Finset.mem_range.mpr hnlt, rfl⟩
  | negSucc n =>
      have hband := (mem_radialBand t ell r a b _).mp hk
      have hnlt : n < Nneg := by
        by_contra hnot
        have hn : Nneg ≤ n := Nat.le_of_not_gt hnot
        have hstep : Nneg ≤ n + 1 := hn.trans (Nat.le_succ n)
        have hescape := hNneg (n + 1) hstep
        rw [shiftInt_negSucc] at hband
        exact (not_lt_of_ge hband.1) hescape
      apply Finset.mem_union_right
      exact Finset.mem_image.mpr ⟨n, Finset.mem_range.mpr hnlt, rfl⟩

/-- Closed annulus in the norm of the actual theta-root base coordinate. -/
def normAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R}

@[simp]
theorem mem_normAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ) (z : TateThetaRootPullbackPoint t ell) :
    z ∈ normAnnulus t ell δ R ↔
      δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R :=
  Iff.rfl

/-- A positive norm annulus maps into a bounded normalized-radial band.  The
order reverses because `log ‖r‖ < 0`. -/
theorem normAnnulus_subset_radialBand
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    {δ R : ℝ} (hδ : 0 < δ) :
    normAnnulus t ell δ R ⊆
      radialBand t ell r
        (Real.log R / Real.log ‖(r : K)‖)
        (Real.log δ / Real.log ‖(r : K)‖) := by
  intro z hz
  rcases hz with ⟨hδz, hzR⟩
  have hzpos : 0 < ‖(z.base : K)‖ :=
    TateThetaRootRadialSkeleton.base_norm_pos z
  have hRpos : 0 < R := hzpos.trans_le hzR
  have hlogδz : Real.log δ ≤ Real.log ‖(z.base : K)‖ :=
    Real.log_le_log hδ hδz
  have hlogzR : Real.log ‖(z.base : K)‖ ≤ Real.log R :=
    Real.log_le_log hzpos hzR
  have hdneg : Real.log ‖(r : K)‖ < 0 :=
    log_root_norm_neg t ell r hr
  have hinvnonpos : (Real.log ‖(r : K)‖)⁻¹ ≤ 0 :=
    (inv_neg.mpr hdneg).le
  constructor
  · simpa [TateThetaRootRadialSkeleton.coordinate, div_eq_mul_inv]
      using mul_le_mul_of_nonpos_right hlogzR hinvnonpos
  · simpa [TateThetaRootRadialSkeleton.coordinate, div_eq_mul_inv]
      using mul_le_mul_of_nonpos_right hlogδz hinvnonpos

/-- **All-integer annulus local finiteness.**  For every point, the complete
`ℤ` deck orbit meets every closed norm annulus with positive inner radius at
only finitely many indices. -/
theorem orbitIndices_normAnnulus_finite
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ R : ℝ} (hδ : 0 < δ) :
    {k : ℤ | shiftInt t ell r hr k z ∈ normAnnulus t ell δ R}.Finite := by
  apply (orbitIndices_radialBand_finite t ell r hr z
    (Real.log R / Real.log ‖(r : K)‖)
    (Real.log δ / Real.log ‖(r : K)‖)).subset
  intro k hk
  exact normAnnulus_subset_radialBand t ell r hr hδ hk

/-- The compact radial quotient of the translation skeleton. -/
abbrev RadialCircle := UnitAddCircle

/-- Actual theta-root point mapped to the radial circle `ℝ / ℤ`. -/
noncomputable def radialCircleCoordinate
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : RadialCircle :=
  (coordinate t ell r z : UnitAddCircle)

/-- The radial-circle coordinate is invariant under every integer deck
iterate. -/
theorem radialCircleCoordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (k : ℤ) (z : TateThetaRootPullbackPoint t ell) :
    radialCircleCoordinate t ell r (shiftInt t ell r hr k z) =
      radialCircleCoordinate t ell r z := by
  rw [radialCircleCoordinate, coordinate_shiftInt]
  change
    ((coordinate t ell r z + (k : ℝ) : ℝ) : UnitAddCircle) =
      (coordinate t ell r z : UnitAddCircle)
  simp

/-- Mathlib's integer-translation skeleton is properly discontinuous. -/
theorem radialSkeleton_properlyDiscontinuous :
    ProperlyDiscontinuousVAdd (zmultiples (1 : ℝ)).op ℝ :=
  inferInstance

/-- The topological quotient of the unit radial skeleton is compact. -/
theorem radialCircle_compact : CompactSpace RadialCircle :=
  inferInstance

end TateThetaRootIntegerOrbit

end IUTThreeClosures
