/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllIntegerEndpointsPNT
import PrimeNumberTheoremAnd.Consequences

/-!
# Instantiating the GenEll Chebyshev window from a formal PNT

`PrimeNumberTheoremAnd.Consequences` proves the real Chebyshev asymptotic

`Chebyshev.theta ~ id`

in Lean 4.32.  This module composes that theorem with the natural-number
embedding and converts asymptotic equivalence into the exact ratio convergence
used by `GenEllIntegerEndpointsPNT`.

Consequently the integer-endpoint form of GenEll Lemma 4.1 no longer carries a
PNT theorem parameter.  The remaining hypotheses are the arithmetic
exceptional-prime mass bound, sufficiently large endpoints, and the elementary
logarithmic budget appearing in the printed lemma.
-/

namespace IUTThreeClosures

open Filter Finset Nat Real Set
open Asymptotics
open scoped BigOperators Nat.Prime Topology Chebyshev

/-- The formally verified Chebyshev prime number theorem in the precise
natural-number ratio form consumed by the GenEll endpoint argument. -/
theorem chebyshev_nat_ratio_tendsto_one :
    Tendsto
      (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
      atTop (𝓝 1) := by
  have hcomp :
      (fun n : ℕ => Chebyshev.theta (n : ℝ)) ~[atTop]
        (fun n : ℕ => (n : ℝ)) := by
    simpa [Function.comp_def] using
      (chebyshev_asymptotic.comp_tendsto
        (show Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop from
          tendsto_natCast_atTop_atTop))
  have hne : ∀ᶠ n : ℕ in atTop, (n : ℝ) ≠ 0 := by
    filter_upwards [eventually_atTop.2 ⟨1, fun n hn => hn⟩] with n hn
    have hnpos : (0 : ℝ) < n := by
      exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hn)
    exact hnpos.ne'
  exact (isEquivalent_iff_tendsto_one hne).mp hcomp

/-- **PNT-instantiated integer-endpoint GenEll Lemma 4.1.**  This is the
ceiling-endpoint theorem with its analytic PNT parameter discharged by the
formal Chebyshev asymptotic. -/
theorem genEllLemma41_ceiling_endpoints_of_formalPNT
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase : ℝ)
    (M : ℕ)
    {ε xε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hendpointBudget : (5 / 4 : ℝ) < ε * xε)
    (hxA : xε < xA)
    (hhBase : 0 ≤ hBase)
    (hxA_mass : xA = primeLogMass A)
    (hradius_nonneg :
      0 ≤ genEllLemma41Radius ε xA hBase)
    (hradius_one :
      1 ≤ genEllLemma41Radius ε xA hBase)
    (hlarge :
      let N := Classical.choose
        (exists_chebyshev_pnt_window_threshold
          chebyshev_nat_ratio_tendsto_one hεpos)
      N ≤ naturalCeilingEndpoint ((1 + 6 * ε) * hBase) ∧
      N ≤ naturalCeilingEndpoint
        (genEllLemma41Radius ε xA hBase))
    (hMlog :
      (((M - 1 : ℕ) : ℝ) *
          Real.log (naturalCeilingEndpoint
            (genEllLemma41Radius ε xA hBase))) ≤
        ε * genEllLemma41Radius ε xA hBase) :
    M ≤
      (escapingPrimes A
        (naturalCeilingEndpoint ((1 + 6 * ε) * hBase))
        (naturalCeilingEndpoint
          (genEllLemma41Radius ε xA hBase))).card := by
  exact genEllLemma41_ceiling_endpoints
    A hA hBase M chebyshev_nat_ratio_tendsto_one
      hεpos hεlt hxεpos hendpointBudget hxA hhBase hxA_mass
      hradius_nonneg hradius_one hlarge hMlog

end IUTThreeClosures
