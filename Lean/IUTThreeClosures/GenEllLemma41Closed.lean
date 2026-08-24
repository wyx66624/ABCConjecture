/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41CountingBridge
import IUTThreeClosures.ChebyshevPNTBounds
import IUTThreeClosures.LogOnePlusSublinear
import Mathlib.Algebra.Order.Floor.Ring

/-!
# A closed integer-endpoint form of GenEll Lemma 4.1

This module combines the real-algebraic contradiction, the finite Chebyshev
counting theorem, Mathlib's prime number theorem, and exact floor/ceiling
rounding.

For every `0 < epsilon < 1/4` and every requested number `M` of primes, we
construct constants `x_epsilon` and `C_epsilon` such that every finite set of
forbidden primes of logarithmic mass above `x_epsilon`, and every natural base
height `h`, admit at least `M` distinct primes outside the forbidden set in the
printed interval

`h < p <= (1 + 6*epsilon) * x_A + 8*h`.

The lower Chebyshev endpoint is the ceiling of `(1+6*epsilon)h`; the upper
endpoint is the floor of the printed real radius.  A stronger PNT lower bound
with error `epsilon/2` absorbs the floor error exactly, so there is no remaining
`+1` in the final prime bound.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- Natural floor endpoint for a nonnegative real radius. -/
noncomputable def genEllFloorEndpoint (Y : ℝ) : ℕ :=
  ⌊Y⌋₊

/-- Exact floor bounds. -/
theorem genEllFloorEndpoint_bounds
    {Y : ℝ} (hY : 0 ≤ Y) :
    (genEllFloorEndpoint Y : ℝ) ≤ Y ∧
      Y < (genEllFloorEndpoint Y : ℝ) + 1 := by
  constructor
  · exact Nat.floor_le hY
  · exact Nat.lt_floor_add_one Y

/-- A real lower bound transfers to the natural floor. -/
theorem le_genEllFloorEndpoint
    {Y : ℝ} {N : ℕ} (h : (N : ℝ) ≤ Y) :
    N ≤ genEllFloorEndpoint Y := by
  exact (Nat.le_floor).2 h

/-- The floor endpoint has no larger logarithm than the original radius. -/
theorem log_genEllFloorEndpoint_le
    {Y : ℝ} (hY : 1 ≤ Y) :
    Real.log (genEllFloorEndpoint Y) ≤ Real.log Y := by
  have hX : 1 ≤ genEllFloorEndpoint Y :=
    le_genEllFloorEndpoint hY
  have hXpos : (0 : ℝ) < genEllFloorEndpoint Y := by
    exact_mod_cast hX
  exact Real.log_le_log hXpos
    (genEllFloorEndpoint_bounds (zero_le_one.trans hY)).1

/-- The stronger `epsilon/2` PNT estimate absorbs the one-unit floor error
once `2/epsilon < Y`. -/
theorem floor_lower_absorption
    {ε Y X thetaX : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1)
    (hY : 2 / ε < Y)
    (hfloor : Y < X + 1)
    (hPNT : (1 - ε / 2) * X < thetaX) :
    (1 - ε) * Y < thetaX := by
  have hmul : 2 < ε * Y :=
    (div_lt_iff₀ hεpos).mp hY
  have hcoef : 0 < 1 - ε / 2 := by
    linarith
  have hYX : Y - 1 < X := by
    linarith
  have hscaled :
      (1 - ε / 2) * (Y - 1) <
        (1 - ε / 2) * X :=
    mul_lt_mul_of_pos_left hYX hcoef
  have hround :
      (1 - ε) * Y < (1 - ε / 2) * (Y - 1) := by
    nlinarith
  exact hround.trans (hscaled.trans hPNT)

/-- **Closed prescribed-size prime theorem (GenEll Lemma 4.1, natural-height
form).** -/
theorem genEllLemma41_closed
    (M : ℕ) {ε : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4) :
    ∃ xε Cε : ℝ,
      0 < xε ∧
      Cε < ε * xε ∧
      ∀ (A : Finset ℕ),
        (∀ p ∈ A, p.Prime) →
        ∀ hBase : ℕ,
          xε < primeLogMass A →
          ∃ S : Finset ℕ,
            M ≤ S.card ∧
            ∀ p ∈ S,
              p.Prime ∧
              hBase < p ∧
              (p : ℝ) ≤
                genEllLemma41Radius ε (primeLogMass A) hBase ∧
              p ∉ A := by
  have hhalfε : 0 < ε / 2 := by positivity
  obtain ⟨Nlower, hNlower⟩ :=
    eventually_chebyshevTheta_lower hhalfε
  obtain ⟨Cupper, hCupper⟩ :=
    exists_global_chebyshevTheta_nineEighths_upper
  let Acoef : ℝ := ((M - 1 : ℕ) : ℝ)
  have hAcoef : 0 ≤ Acoef := by positivity
  obtain ⟨Clog, hClog⟩ :=
    mul_log_one_add_sublinear hAcoef hhalfε
  let ClogPos : ℝ := max Clog 0
  let Cε : ℝ := Cupper + 9 / 8
  let xε : ℝ :=
    max 1 <|
      max ((Cε + 1) / ε) <|
        max ((Nlower : ℝ) + 2) <|
          max (2 / ε + 1) (2 * ClogPos / ε + 1)
  have hxε_one : 1 ≤ xε := by
    exact le_max_left _ _
  have hxεpos : 0 < xε := zero_lt_one.trans_le hxε_one
  have hxε_C : (Cε + 1) / ε ≤ xε := by
    exact (le_max_left ((Cε + 1) / ε)
      (max ((Nlower : ℝ) + 2)
        (max (2 / ε + 1) (2 * ClogPos / ε + 1)))).trans
      (le_max_right 1 _)
  have hCε : Cε < ε * xε := by
    have hmul :=
      (mul_le_mul_of_nonneg_left hxε_C hεpos.le)
    have hcancel : ε * ((Cε + 1) / ε) = Cε + 1 := by
      field_simp [hεpos.ne']
    rw [hcancel] at hmul
    linarith
  refine ⟨xε, Cε, hxεpos, hCε, ?_⟩
  intro A hA hBase hxA
  let xA : ℝ := primeLogMass A
  let T : ℝ := (1 + 6 * ε) * (hBase : ℝ)
  let Y : ℝ := genEllLemma41Radius ε xA hBase
  let H : ℕ := ⌈T⌉₊
  let X : ℕ := genEllFloorEndpoint Y
  have hεone : ε < 1 := hεlt.trans (by norm_num)
  have hcoef_pos : 0 < 1 + 6 * ε := by linarith
  have hh_nonneg : 0 ≤ (hBase : ℝ) := by positivity
  have hT_nonneg : 0 ≤ T := by
    dsimp [T]
    positivity
  have hxApos : 0 < xA := hxεpos.trans hxA
  have hY_gt_xA : xA < Y := by
    dsimp [Y, xA]
    unfold genEllLemma41Radius
    nlinarith
  have hYone : 1 < Y :=
    hxε_one.trans_lt (hxA.trans hY_gt_xA)
  have hXone : 1 ≤ X := by
    dsimp [X]
    exact le_genEllFloorEndpoint hYone.le
  have hxε_N : (Nlower : ℝ) + 2 ≤ xε := by
    exact (le_max_left ((Nlower : ℝ) + 2)
      (max (2 / ε + 1) (2 * ClogPos / ε + 1))).trans
      ((le_max_right ((Cε + 1) / ε) _).trans
        (le_max_right 1 _))
  have hN_Y : (Nlower : ℝ) ≤ Y := by
    have : (Nlower : ℝ) + 2 < Y :=
      hxε_N.trans_lt (hxA.trans hY_gt_xA)
    linarith
  have hN_X : Nlower ≤ X := by
    dsimp [X]
    exact le_genEllFloorEndpoint hN_Y
  have hPNT_X :
      (1 - ε / 2) * (X : ℝ) < Chebyshev.theta X :=
    hNlower X hN_X
  have hxε_floor : 2 / ε + 1 ≤ xε := by
    exact (le_max_left (2 / ε + 1) (2 * ClogPos / ε + 1)).trans
      ((le_max_right ((Nlower : ℝ) + 2) _).trans
        ((le_max_right ((Cε + 1) / ε) _).trans
          (le_max_right 1 _)))
  have htwo_Y : 2 / ε < Y := by
    have : 2 / ε + 1 < Y :=
      hxε_floor.trans_lt (hxA.trans hY_gt_xA)
    linarith
  have hfloorY : Y < (X : ℝ) + 1 := by
    dsimp [X]
    exact (genEllFloorEndpoint_bounds hYone.le).2
  have hthetaX :
      (1 - ε) * Y < Chebyshev.theta X :=
    floor_lower_absorption hεpos hεone htwo_Y hfloorY hPNT_X
  have hceilT : (H : ℝ) < T + 1 := by
    dsimp [H]
    exact Nat.ceil_lt_add_one hT_nonneg
  have hthetaH0 :
      Chebyshev.theta H < (9 / 8 : ℝ) * (H : ℝ) + Cupper :=
    hCupper H
  have hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) * T + Cε := by
    dsimp [Cε]
    have hcoeff :
        (9 / 8 : ℝ) * T ≤ (5 / 4 : ℝ) * T := by
      nlinarith
    nlinarith
  have hxε_log : 2 * ClogPos / ε + 1 ≤ xε := by
    exact (le_max_right (2 / ε + 1) (2 * ClogPos / ε + 1)).trans
      ((le_max_right ((Nlower : ℝ) + 2) _).trans
        ((le_max_right ((Cε + 1) / ε) _).trans
          (le_max_right 1 _)))
  have hlogscale : 2 * ClogPos < ε * Y := by
    have hdiv : 2 * ClogPos / ε < Y := by
      have : 2 * ClogPos / ε + 1 < Y :=
        hxε_log.trans_lt (hxA.trans hY_gt_xA)
      linarith
    exact (div_lt_iff₀ hεpos).mp hdiv
  have hClogPos : Clog ≤ ClogPos := le_max_left _ _
  have hClog_half : Clog < (ε / 2) * Y := by
    have hposhalf : ClogPos < (ε / 2) * Y := by
      nlinarith
    exact hClogPos.trans_lt hposhalf
  have hX_le_Y : (X : ℝ) ≤ Y := by
    dsimp [X]
    exact (genEllFloorEndpoint_bounds hYone.le).1
  have hlogX_le_logY : Real.log X ≤ Real.log Y := by
    have hXpos : (0 : ℝ) < X := by exact_mod_cast hXone
    exact Real.log_le_log hXpos hX_le_Y
  have hlogY_le_logOneY : Real.log Y ≤ Real.log (1 + Y) := by
    exact Real.log_le_log (zero_lt_one.trans hYone)
      (by linarith)
  have hcandidate_log :
      Acoef * Real.log X ≤ ε * Y := by
    have hlogmul : Acoef * Real.log X ≤ Acoef * Real.log (1 + Y) :=
      mul_le_mul_of_nonneg_left
        (hlogX_le_logY.trans hlogY_le_logOneY) hAcoef
    have hsub := hClog Y hYone.le
    have : Acoef * Real.log X ≤ (ε / 2) * Y + Clog :=
      hlogmul.trans hsub
    linarith
  obtain ⟨S, hcard, hS⟩ :=
    genEllLemma41_many_primes
      A hA hBase H X M hXone
      hεpos hεlt hxεpos hCε hxA
      (by rfl : xA = primeLogMass A)
      (by simpa [Acoef, Y] using hcandidate_log)
      (by simpa [T] using hthetaH)
      (by simpa [Y] using hthetaX)
  refine ⟨S, hcard, ?_⟩
  intro p hp
  rcases hS p hp with ⟨hpp, hHp, hpX, hpA⟩
  have hT_le_H : T ≤ (H : ℝ) := by
    dsimp [H]
    exact Nat.le_ceil T
  have hh_le_T : (hBase : ℝ) ≤ T := by
    dsimp [T]
    nlinarith
  have hHreal : (H : ℝ) < p := by exact_mod_cast hHp
  have hhreal : (hBase : ℝ) < p :=
    hh_le_T.trans_le hT_le_H |>.trans_lt hHreal
  have hhp : hBase < p := by exact_mod_cast hhreal
  have hpXreal : (p : ℝ) ≤ X := by exact_mod_cast hpX
  have hpY : (p : ℝ) ≤ Y := hpXreal.trans hX_le_Y
  exact ⟨hpp, hhp, by simpa [Y, xA] using hpY, hpA⟩

end IUTThreeClosures
