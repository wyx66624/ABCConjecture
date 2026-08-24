/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllIntegerEndpoint
import Mathlib.NumberTheory.PrimeCounting

/-!
# GenEll Lemma 4.1 from the Chebyshev prime number theorem

The scalar contradiction, finite counting theorem, and integer endpoint
bookkeeping have already been separated.  This module supplies the remaining
analytic assembly.

Assume the ratio form of the prime number theorem

`theta n / n -> 1`.

For fixed `M` and `0 < epsilon < 1/4`, we construct constants
`x_epsilon, C_epsilon` such that every finite forbidden set of primes of
logarithmic mass greater than `x_epsilon`, and every nonnegative base height,
admits at least `M` distinct primes in the printed bounded interval.

Two elementary constructions make the proof uniform at all endpoints:

* the finitely many failures of the global upper estimate
  `theta n < 5/4 n` are absorbed in the explicit finite defect constant
  `1 + sum_{n < N} |theta n - 5/4 n|`;
* `A * log (1+y) = o(y)` is proved directly from `log z <= z-1`, with an
  explicit threshold.

Thus the analytic and finite-counting content of GenEll Lemma 4.1 is reduced
to the standard Chebyshev PNT ratio limit, with no hidden endpoint convention.
-/

namespace IUTThreeClosures

open Filter Finset Nat Real
open scoped Topology BigOperators Nat.Prime

/-- The ratio form of the Chebyshev prime number theorem used in this file. -/
def GenEllChebyshevPNT : Prop :=
  Tendsto
    (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
    atTop (𝓝 1)

/-- Eventual two-sided Chebyshev window obtained from the ratio limit. -/
theorem genEll_chebyshev_window_eventually
    (hPNT : GenEllChebyshevPNT)
    {η : ℝ} (hη : 0 < η) :
    ∀ᶠ n : ℕ in atTop,
      (1 - η) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + η) * (n : ℝ) := by
  have hlo :
      ∀ᶠ n : ℕ in atTop,
        1 - η < Chebyshev.theta n / (n : ℝ) :=
    (tendsto_order.1 hPNT).1 (by linarith)
  have hup :
      ∀ᶠ n : ℕ in atTop,
        Chebyshev.theta n / (n : ℝ) < 1 + η :=
    (tendsto_order.1 hPNT).2 (by linarith)
  have hnpos : ∀ᶠ n : ℕ in atTop, 0 < n :=
    eventually_atTop.2
      ⟨1, fun n hn => Nat.zero_lt_one.trans_le hn⟩
  filter_upwards [hlo, hup, hnpos] with n hnlo hnup hn
  have hnreal : (0 : ℝ) < n := by exact_mod_cast hn
  exact ⟨(lt_div_iff₀ hnreal).mp hnlo,
    (div_lt_iff₀ hnreal).mp hnup⟩

/-- Threshold form of the PNT window. -/
theorem genEll_exists_chebyshev_window_threshold
    (hPNT : GenEllChebyshevPNT)
    {η : ℝ} (hη : 0 < η) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - η) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + η) * (n : ℝ) :=
  eventually_atTop.1 (genEll_chebyshev_window_eventually hPNT hη)

/-- Explicit positive constant absorbing all failures of the upper
`5/4`-Chebyshev estimate below a threshold. -/
noncomputable def chebyshevUpperDefect (N : ℕ) : ℝ :=
  1 + ∑ n ∈ Finset.range N,
    |Chebyshev.theta n - (5 / 4 : ℝ) * n|

/-- The finite upper-defect constant is positive. -/
theorem chebyshevUpperDefect_pos (N : ℕ) :
    0 < chebyshevUpperDefect N := by
  unfold chebyshevUpperDefect
  have : 0 ≤ ∑ n ∈ Finset.range N,
      |Chebyshev.theta n - (5 / 4 : ℝ) * n| := by
    positivity
  linarith

/-- An eventual `5/4` upper estimate extends to all natural endpoints after
adding the finite defect constant. -/
theorem theta_lt_five_fourths_add_defect
    {N : ℕ}
    (hupper : ∀ n ≥ N,
      Chebyshev.theta n < (5 / 4 : ℝ) * n)
    (n : ℕ) :
    Chebyshev.theta n <
      (5 / 4 : ℝ) * n + chebyshevUpperDefect N := by
  by_cases hn : N ≤ n
  · exact (hupper n hn).trans <| by
      linarith [chebyshevUpperDefect_pos N]
  · have hnmem : n ∈ Finset.range N := by
      exact Finset.mem_range.mpr (Nat.lt_of_not_ge hn)
    have hsingle :
        |Chebyshev.theta n - (5 / 4 : ℝ) * n| ≤
          ∑ m ∈ Finset.range N,
            |Chebyshev.theta m - (5 / 4 : ℝ) * m| := by
      apply Finset.single_le_sum
      · intro m hm
        positivity
      · exact hnmem
    have habs :
        Chebyshev.theta n - (5 / 4 : ℝ) * n ≤
          |Chebyshev.theta n - (5 / 4 : ℝ) * n| :=
      le_abs_self _
    unfold chebyshevUpperDefect
    linarith

/-- Explicit scaled logarithm inequality used to obtain a threshold for
`A * log(1+y) <= epsilon*y`. -/
theorem genEll_log_one_add_le_scaled
    {y ρ : ℝ} (hy : 0 ≤ y) (hρ : 0 < ρ) :
    Real.log (1 + y) ≤
      ρ * y + (ρ - 1 - Real.log ρ) := by
  have hy1 : 0 < 1 + y := by linarith
  have hprod : 0 < ρ * (1 + y) := mul_pos hρ hy1
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul hρ.ne' hy1.ne'] at hlog
  nlinarith

/-- Every nonnegative multiple of `log(1+y)` is eventually bounded by an
arbitrarily small positive multiple of `y`. -/
theorem exists_mul_log_one_add_linear_threshold
    {A ε : ℝ} (hA : 0 ≤ A) (hε : 0 < ε) :
    ∃ Y : ℝ, 0 ≤ Y ∧ ∀ y ≥ Y,
      A * Real.log (1 + y) ≤ ε * y := by
  rcases hA.eq_or_lt with hA0 | hApos
  · refine ⟨0, le_rfl, ?_⟩
    intro y hy
    simp [hA0, mul_nonneg hε.le hy]
  · let ρ : ℝ := ε / (2 * A)
    have hρ : 0 < ρ := by
      dsimp [ρ]
      positivity
    let C : ℝ := A * (ρ - 1 - Real.log ρ)
    let Y : ℝ := max 0 (2 * max C 0 / ε)
    refine ⟨Y, le_max_left _ _, ?_⟩
    intro y hyY
    have hy : 0 ≤ y := (le_max_left 0 _).trans hyY
    have hlog := genEll_log_one_add_le_scaled hy hρ
    have hmul := mul_le_mul_of_nonneg_left hlog hA
    have hρA : A * ρ = ε / 2 := by
      dsimp [ρ]
      field_simp [hApos.ne']
      ring
    have hC : C ≤ max C 0 := le_max_left _ _
    have hY : 2 * max C 0 / ε ≤ y :=
      (le_max_right 0 _).trans hyY
    have hCY : max C 0 ≤ ε * y / 2 := by
      apply (le_div_iff₀ (show (0 : ℝ) < 2 by norm_num)).2
      have := (div_le_iff₀ hε).1 hY
      nlinarith
    dsimp [C] at hC ⊢
    rw [hρA] at hmul
    nlinarith

/-- **Complete analytic and counting form of GenEll Lemma 4.1.**

For every fixed number `M` of required primes and every
`0 < epsilon < 1/4`, the Chebyshev PNT produces constants `x_epsilon` and
`C_epsilon`.  Every finite forbidden set of primes of mass exceeding
`x_epsilon` then admits at least `M` distinct primes in the endpoint-correct
printed interval. -/
theorem complete_genEllLemma41
    (hPNT : GenEllChebyshevPNT)
    (M : ℕ)
    {ε : ℝ} (hεpos : 0 < ε) (hεlt : ε < 1 / 4) :
    ∃ xε Cε : ℝ,
      0 < xε ∧
      Cε + 5 / 4 < ε * xε ∧
      ∀ (A : Finset ℕ),
        (∀ p ∈ A, p.Prime) →
        xε < primeLogMass A →
        ∀ hBase : ℝ, 0 ≤ hBase →
          ∃ S : Finset ℕ,
            M ≤ S.card ∧
            ∀ p ∈ S,
              p.Prime ∧
              genEllNaturalEndpoint
                  ((1 + 6 * ε) * hBase) < p ∧
              p ≤ genEllNaturalEndpoint
                (genEllLemma41Radius ε
                  (primeLogMass A) hBase) ∧
              p ∉ A := by
  rcases genEll_exists_chebyshev_window_threshold hPNT hεpos with
    ⟨Nlower, hwindowLower⟩
  rcases genEll_exists_chebyshev_window_threshold hPNT
      (show (0 : ℝ) < 1 / 4 by norm_num) with
    ⟨Nupper, hwindowUpper⟩
  let Cε : ℝ := chebyshevUpperDefect Nupper
  let Acoeff : ℝ := ((M - 1 : ℕ) : ℝ)
  have hAcoeff : 0 ≤ Acoeff := by positivity
  rcases exists_mul_log_one_add_linear_threshold
      hAcoeff hεpos with ⟨Ylog, hYlog0, hYlog⟩
  let B : ℝ :=
    max 1 <|
      max (Nlower : ℝ) <|
        max Ylog <|
          (Cε + 5 / 4 + 1) / ε
  obtain ⟨Nε : ℕ, hNε⟩ := exists_nat_gt B
  let xε : ℝ := Nε
  have hB1 : 1 ≤ B := le_max_left _ _
  have hxεpos : 0 < xε := by
    dsimp [xε]
    have : (1 : ℝ) < Nε := hB1.trans_lt hNε
    linarith
  have hBNlower : (Nlower : ℝ) ≤ B :=
    (le_max_left (Nlower : ℝ)
      (max Ylog ((Cε + 5 / 4 + 1) / ε))).trans
        (le_max_right 1 _)
  have hxNlowerReal : (Nlower : ℝ) < xε :=
    hBNlower.trans_lt hNε
  have hxNlower : Nlower ≤ Nε := by
    exact_mod_cast hxNlowerReal.le
  have hBYlog : Ylog ≤ B :=
    (le_max_left Ylog ((Cε + 5 / 4 + 1) / ε)).trans
      ((le_max_right (Nlower : ℝ) _).trans
        (le_max_right 1 _))
  have hxYlog : Ylog < xε := hBYlog.trans_lt hNε
  have hBC : (Cε + 5 / 4 + 1) / ε ≤ B :=
    (le_max_right Ylog ((Cε + 5 / 4 + 1) / ε)).trans
      ((le_max_right (Nlower : ℝ) _).trans
        (le_max_right 1 _))
  have hCε : Cε + 5 / 4 < ε * xε := by
    have hratio :
        (Cε + 5 / 4 + 1) / ε < xε :=
      hBC.trans_lt hNε
    have := (div_lt_iff₀ hεpos).1 hratio
    linarith
  refine ⟨xε, Cε, hxεpos, hCε, ?_⟩
  intro A hAprime hxA hBase hh
  let xA : ℝ := primeLogMass A
  let y : ℝ := genEllLemma41Radius ε xA hBase
  have honeSix : 0 < 1 + 6 * ε := by linarith
  have hxApos : 0 < xA := hxεpos.trans hxA
  have hy_ge_xA : xA ≤ y := by
    dsimp [y, xA, genEllLemma41Radius]
    nlinarith
  have hy_gt_xε : xε < y := hxA.trans_le hy_ge_xA
  have hy_one : 1 ≤ y := by
    have : (1 : ℝ) < xε := by
      exact hB1.trans_lt hNε
    linarith
  have hyYlog : Ylog ≤ y :=
    (hxYlog.le.trans hxA.le).trans hy_ge_xA
  have hlog :
      Acoeff * Real.log (y + 1) ≤ ε * y :=
    hYlog y hyYlog
  have hNlowerY : (Nlower : ℝ) ≤ y := by
    exact_mod_cast hxNlower
    linarith
  have hNlowerX :
      Nlower ≤ genEllNaturalEndpoint y := by
    have : (Nlower : ℝ) ≤
        (genEllNaturalEndpoint y : ℝ) :=
      hNlowerY.trans (le_genEllNaturalEndpoint y)
    exact_mod_cast this
  have hlower :
      (1 - ε) *
          (genEllNaturalEndpoint y : ℝ) <
        Chebyshev.theta (genEllNaturalEndpoint y) :=
    (hwindowLower (genEllNaturalEndpoint y) hNlowerX).1
  have hupper :
      Chebyshev.theta
          (genEllNaturalEndpoint ((1 + 6 * ε) * hBase)) <
        (5 / 4 : ℝ) *
          (genEllNaturalEndpoint ((1 + 6 * ε) * hBase) : ℝ) + Cε := by
    exact theta_lt_five_fourths_add_defect
      (fun n hn => by
        have := (hwindowUpper n hn).2
        norm_num at this ⊢
        exact this)
      _
  have hresult :=
    genEllLemma41_many_primes_with_ceiling_endpoints
      A hAprime M hεpos hεlt hxεpos hCε
      (show xε < xA by exact hxA)
      (show xA = primeLogMass A by rfl)
      hh hy_one
      (by simpa [Acoeff, y] using hlog)
      (by simpa using hupper)
      (by simpa [y] using hlower)
  simpa [xA, y] using hresult

end IUTThreeClosures
