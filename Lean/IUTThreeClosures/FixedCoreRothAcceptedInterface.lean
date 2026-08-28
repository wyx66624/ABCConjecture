/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FixedCoreRothGapBridge
import Mathlib.RingTheory.Algebraic.Basic

/-!
# Accepted Thue--Siegel--Roth theorem interface

This file contains one named external mathematical interface, admissible under
`../ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`.

Primary source:
K. F. Roth, "Rational approximations to algebraic numbers",
Mathematika 2 (1955), 1--20; Corrigendum, p. 168.

Exact form used: for every irrational algebraic real `alpha` and every positive
integer `N`, there is `C > 0` such that for all positive natural denominators
`x` and all natural numerators `y`,

`C <= |alpha*x-y|^N * x^(N+1)`.

This is obtained from the usual exponent `2 + 1/N` statement by multiplying by
`x`, raising to the `N`th power, reducing the fraction if necessary, and
absorbing the finite exceptional set into the positive constant.

The interface is not abc, Szpiro, a height--conductor estimate, or any disputed
IUT comparison.  Endpoints using it must be labelled "closed relative to the
accepted Roth interface", not purely Lean-kernel closed.
-/

namespace IUTThreeClosures
namespace FixedCoreRothGapBridge

/-- Thue--Siegel--Roth in the exact denominator-free powered normalization used
by `fixedCore_poweredGap_of_rothPoint`. -/
axiom thueSiegelRoth_powerApproximation
    (alpha : ℝ)
    (hirr : Irrational alpha)
    (halg : IsAlgebraic ℚ alpha)
    (N : ℕ) (hN : 0 < N) :
    ∃ C : ℝ, RothPowerApproximation alpha N C

/-- The fixed-core powered gap bound, closed relative to the accepted Roth
interface. -/
theorem exists_fixedCore_poweredGap_lower_bound_of_roth
    {alpha s t : ℝ} {k N : ℕ}
    (hk : 0 < k) (hN : 0 < N)
    (halpha : 0 ≤ alpha) (ht : 0 ≤ t)
    (hcore : t * alpha ^ k = s)
    (hirr : Irrational alpha)
    (halg : IsAlgebraic ℚ alpha) :
    ∃ C : ℝ, 0 < C ∧
      ∀ x y : ℕ, 0 < x →
        alpha * (x : ℝ) ≤ (y : ℝ) →
        (t * (alpha * (x : ℝ)) ^ (k - 1)) ^ N * C ≤
          (t * (y : ℝ) ^ k - s * (x : ℝ) ^ k) ^ N *
            (x : ℝ) ^ (N + 1) := by
  rcases thueSiegelRoth_powerApproximation alpha hirr halg N hN with
    ⟨C, hC⟩
  refine ⟨C, hC.1, ?_⟩
  intro x y hx hxy
  exact fixedCore_poweredGap_of_rothPoint hk halpha ht hcore hC hx hxy

end FixedCoreRothGapBridge
end IUTThreeClosures
