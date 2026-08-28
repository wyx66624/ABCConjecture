/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.PrimeCounting

/-!
# Explicit Chebyshev windows from the prime number theorem

The analytic input used by GenEll Lemma 4.1 is a pair of eventual inequalities
for the first Chebyshev function:

`(1 - epsilon) * n < theta n < (1 + epsilon) * n`.

This module proves that exact statement from the ratio form of the prime number
theorem

`theta n / n -> 1`.

Keeping the ratio limit as an argument makes the endpoint and real-algebraic
parts independent of the precise theorem name or real/natural interpolation
used by a particular PNT library.  A final adapter from Mathlib's PNT theorem
to `ChebyshevThetaRatioPNT` is the only remaining library-facing step.
-/

namespace IUTThreeClosures

open Filter Nat Real
open scoped Topology

/-- Ratio form of the prime number theorem for the first Chebyshev function. -/
def ChebyshevThetaRatioPNT : Prop :=
  Tendsto
    (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
    atTop (𝓝 1)

/-- Every positive relative error gives an eventual two-sided Chebyshev
window. -/
theorem chebyshev_window_eventually
    (hPNT : ChebyshevThetaRatioPNT)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop,
      (1 - ε) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + ε) * (n : ℝ) := by
  have hlowerRatio :
      ∀ᶠ n : ℕ in atTop,
        1 - ε < Chebyshev.theta n / (n : ℝ) :=
    (tendsto_order.1 hPNT).1 (by linarith)
  have hupperRatio :
      ∀ᶠ n : ℕ in atTop,
        Chebyshev.theta n / (n : ℝ) < 1 + ε :=
    (tendsto_order.1 hPNT).2 (by linarith)
  have hpositive : ∀ᶠ n : ℕ in atTop, 0 < n :=
    eventually_atTop.2 ⟨1, fun n hn => Nat.zero_lt_of_lt hn⟩
  filter_upwards [hlowerRatio, hupperRatio, hpositive] with n hlo hup hn
  have hnreal : (0 : ℝ) < n := by exact_mod_cast hn
  constructor
  · exact (lt_div_iff₀ hnreal).mp hlo
  · exact (div_lt_iff₀ hnreal).mp hup

/-- Threshold form of the two-sided Chebyshev window. -/
theorem exists_chebyshev_window_threshold
    (hPNT : ChebyshevThetaRatioPNT)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - ε) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + ε) * (n : ℝ) := by
  exact eventually_atTop.1 (chebyshev_window_eventually hPNT hε)

/-- The lower estimate in the exact form consumed by GenEll. -/
theorem exists_chebyshev_lower_threshold
    (hPNT : ChebyshevThetaRatioPNT)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - ε) * (n : ℝ) < Chebyshev.theta n := by
  rcases exists_chebyshev_window_threshold hPNT hε with ⟨N, hN⟩
  exact ⟨N, fun n hn => (hN n hn).1⟩

/-- The upper estimate with an arbitrary coefficient above one. -/
theorem exists_chebyshev_upper_threshold
    (hPNT : ChebyshevThetaRatioPNT)
    {η : ℝ} (hη : 0 < η) :
    ∃ N : ℕ, ∀ n ≥ N,
      Chebyshev.theta n < (1 + η) * (n : ℝ) := by
  rcases exists_chebyshev_window_threshold hPNT hη with ⟨N, hN⟩
  exact ⟨N, fun n hn => (hN n hn).2⟩

/-- In particular the printed upper coefficient `5/4` is available beyond a
fixed threshold. -/
theorem exists_chebyshev_upper_five_fourths
    (hPNT : ChebyshevThetaRatioPNT) :
    ∃ N : ℕ, ∀ n ≥ N,
      Chebyshev.theta n < (5 / 4 : ℝ) * (n : ℝ) := by
  simpa only [show (1 + (1 / 4 : ℝ)) = 5 / 4 by ring] using
    exists_chebyshev_upper_threshold hPNT
      (show (0 : ℝ) < 1 / 4 by norm_num)

end IUTThreeClosures
