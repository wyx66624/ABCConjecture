/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZOrbitProperness
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# The finite-period radial cycle quotient of the theta-root cover

The normalized radial coordinate is measured in units of a chosen root `r`
with `r^ell = q`.  Thus the Tate `q`-period is not one radial unit but `ell`
radial units.  After quotienting by the original Tate period, the correct
radial skeleton is therefore

`R / ell Z`.

Equivalently, divide the radial coordinate by `ell` and map it to the unit
additive circle `R / Z`.  Under this map one corrected theta-root deck step
adds `1/ell`, precisely the standard embedding

`ZMod ell -> R / Z`.

Consequently:

* the `ell`-th deck iterate is invisible on the Tate-cycle quotient;
* the residual finite deck coordinate is faithfully indexed by `ZMod ell`;
* the quotient skeleton is compact and path connected;
* for prime `ell`, the one-step residual deck coordinate is nonzero.

This is a genuine topological quotient of the one-dimensional radial
skeleton.  It is not yet an identification of the complete theta-root analytic
space with a Berkovich skeleton, nor a construction of an orbicurve or its
tempered fundamental group.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- The radial coordinate on the Tate-period quotient, represented in the
unit additive circle after division by the period length `ell`. -/
noncomputable def cycleCoordinate
    (t : TateParameter K) (ell : ℕ) [NeZero ell]
    (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : UnitAddCircle :=
  ((coordinate t ell r z / (ell : ℝ) : ℝ) : UnitAddCircle)

/-- Integer deck translation on the theta-root locus becomes the standard
`ZMod ell` translation on the unit circle. -/
theorem cycleCoordinate_shiftInt
    (t : TateParameter K) (ell : ℕ) [NeZero ell]
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    cycleCoordinate t ell r (shiftInt t ell r hr n z) =
      cycleCoordinate t ell r z +
        ZMod.toAddCircle (n : ZMod ell) := by
  rw [cycleCoordinate, cycleCoordinate,
    coordinate_shiftInt, ZMod.toAddCircle_intCast]
  have hell : (ell : ℝ) ≠ 0 := by
    exact_mod_cast (NeZero.ne ell)
  calc
    (((coordinate t ell r z + (n : ℝ)) / (ell : ℝ) : ℝ) :
        UnitAddCircle) =
        (((coordinate t ell r z / (ell : ℝ)) +
          ((n : ℝ) / (ell : ℝ)) : ℝ) : UnitAddCircle) := by
          congr 1
          field_simp [hell]
          ring
    _ = ((coordinate t ell r z / (ell : ℝ) : ℝ) :
          UnitAddCircle) +
        (((n : ℝ) / (ell : ℝ) : ℝ) : UnitAddCircle) := by
          simp

/-- One corrected deck step adds the canonical point `1/ell` on the quotient
circle. -/
theorem cycleCoordinate_shift
    (t : TateParameter K) (ell : ℕ) [NeZero ell]
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    cycleCoordinate t ell r
        (TateThetaRootPullbackPoint.shift t ell r hr z) =
      cycleCoordinate t ell r z +
        ZMod.toAddCircle (1 : ZMod ell) := by
  simpa [shiftInt] using
    cycleCoordinate_shiftInt t ell r hr (1 : ℤ) z

/-- The original Tate period is the `ell`-th corrected deck iterate, hence it
is trivial on the radial cycle quotient. -/
theorem cycleCoordinate_shift_period
    (t : TateParameter K) (ell : ℕ) [NeZero ell]
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    cycleCoordinate t ell r
        (shiftInt t ell r hr (ell : ℤ) z) =
      cycleCoordinate t ell r z := by
  rw [cycleCoordinate_shiftInt]
  simp

/-- The standard residual deck-coordinate map is injective. -/
theorem residualDeckCoordinate_injective
    (ell : ℕ) [NeZero ell] :
    Function.Injective
      (ZMod.toAddCircle : ZMod ell → UnitAddCircle) :=
  ZMod.toAddCircle_injective ell

/-- Distinct residual deck labels act by distinct translations on the radial
cycle. -/
theorem residualDeckCoordinate_eq_iff
    (ell : ℕ) [NeZero ell]
    (i j : ZMod ell) :
    ZMod.toAddCircle i = ZMod.toAddCircle j ↔ i = j :=
  ZMod.toAddCircle_inj

/-- For prime `ell`, the one-step residual deck coordinate is nonzero. -/
theorem residualDeckGenerator_ne_zero
    {ell : ℕ} (hell : ell.Prime) :
    ZMod.toAddCircle (1 : ZMod ell) ≠ 0 := by
  letI : NeZero ell := ⟨hell.ne_zero⟩
  rw [ZMod.toAddCircle_eq_zero]
  exact one_ne_zero

/-- The radial Tate-cycle quotient is compact. -/
theorem cycleQuotient_isCompact :
    IsCompact (Set.univ : Set UnitAddCircle) :=
  isCompact_univ

/-- The radial Tate-cycle quotient is path connected. -/
theorem cycleQuotient_pathConnected :
    IsPathConnected (Set.univ : Set UnitAddCircle) := by
  simpa using isPathConnected_univ

end TateThetaRootRadialSkeleton

end IUTThreeClosures
