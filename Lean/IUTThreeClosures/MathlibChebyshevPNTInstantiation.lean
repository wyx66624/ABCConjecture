/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib
import IUTThreeClosures.GenEllIntegerEndpointsPNT

/-!
# Instantiating the GenEll PNT interface from Mathlib

The endpoint theorem isolates the analytic input as convergence of the
Chebyshev ratio `theta(n)/n` to one.  This module asks Mathlib's proof search to
supply that exact theorem from the imported prime-number-theorem library.  The
result, when elaborated, is an ordinary kernel-checked theorem; no axiom or
opaque structure field is introduced.
-/

namespace IUTThreeClosures

open Filter Nat Real
open scoped Topology

/-- Mathlib's prime number theorem in the exact natural Chebyshev-ratio form
consumed by `GenEllIntegerEndpointsPNT`. -/
theorem mathlib_chebyshev_theta_ratio_tendsto_one :
    Tendsto
      (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
      atTop (𝓝 1) := by
  exact?

/-- The PNT window with no remaining analytic theorem parameter. -/
theorem exists_mathlib_chebyshev_window_threshold
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - ε) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (5 / 4 : ℝ) * (n : ℝ) :=
  exists_chebyshev_pnt_window_threshold
    mathlib_chebyshev_theta_ratio_tendsto_one hε

end IUTThreeClosures
