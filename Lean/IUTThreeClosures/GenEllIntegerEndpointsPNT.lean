/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41CountingBridge

/-!
# Integer endpoints and the PNT window in GenEll Lemma 4.1

The printed radius in GenEll Lemma 4.1 is real, whereas the Chebyshev function
formalized in Mathlib is evaluated at natural-number endpoints. This file
separates that harmless discretization from the arithmetic exceptional-set
estimates.

For a nonnegative real number `x`, choose the natural endpoint `ceil x`. It
lies in the half-open interval `[x, x+1)`. At the lower endpoint this produces
an additive error of at most `5/4` in the printed Chebyshev upper estimate; at
the upper endpoint there is no loss in the lower estimate because the
coefficient `1-epsilon` is positive.

We also prove the exact analytic interface needed from the prime number
theorem. If

`theta(n) / n -> 1`,

then, for every positive `epsilon`, there is a common threshold above which

`(1-epsilon)n < theta(n) < (5/4)n`.

Combining this eventual window with the ceiling bounds and the already
verified scalar/counting bridge yields the complete integer-endpoint form of
GenEll Lemma 4.1. The only remaining hypotheses in the final theorem are the
large-enough conditions for the two selected endpoints and the logarithmic
term `(M-1) log X <= epsilon y_A`.
-/

namespace IUTThreeClosures

open Filter Finset Nat Real Set
open scoped BigOperators Nat.Prime Topology

/-- The natural-number ceiling endpoint of a real radius. -/
noncomputable def naturalCeilingEndpoint (x : ℝ) : ℕ :=
  ⌈x⌉₊

/-- A nonnegative real radius and its natural ceiling differ by less than one. -/
theorem naturalCeilingEndpoint_bounds
    {x : ℝ} (hx : 0 ≤ x) :
    x ≤ (naturalCeilingEndpoint x : ℝ) ∧
      (naturalCeilingEndpoint x : ℝ) < x + 1 := by
  constructor
  · simpa [naturalCeilingEndpoint] using Nat.le_ceil x
  · simpa [naturalCeilingEndpoint] using Nat.ceil_lt_add_one hx

/-- Convergence of the Chebyshev ratio to one gives the usual two-sided
multiplicative window with any positive relative error. -/
theorem eventual_chebyshev_ratio_window
    (hPNT :
      Tendsto
        (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
        atTop (𝓝 1))
    {δ : ℝ} (hδ : 0 < δ) :
    ∀ᶠ n : ℕ in atTop,
      (1 - δ) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + δ) * (n : ℝ) := by
  have hratio :
      ∀ᶠ n : ℕ in atTop,
        1 - δ < Chebyshev.theta n / (n : ℝ) ∧
          Chebyshev.theta n / (n : ℝ) < 1 + δ := by
    apply hPNT.eventually
    exact Ioo_mem_nhds (by linarith) (by linarith)
  have hpositive : ∀ᶠ n : ℕ in atTop, 1 ≤ n :=
    eventually_atTop.2 ⟨1, fun n hn => hn⟩
  filter_upwards [hratio, hpositive] with n hnratio hn
  have hnpos : (0 : ℝ) < n := by exact_mod_cast hn
  constructor
  · exact (lt_div_iff₀ hnpos).mp hnratio.1
  · exact (div_lt_iff₀ hnpos).mp hnratio.2

/-- A single PNT threshold simultaneously supplies the printed lower
coefficient `1-epsilon` and the convenient upper coefficient `5/4`. -/
theorem exists_chebyshev_pnt_window_threshold
    (hPNT :
      Tendsto
        (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
        atTop (𝓝 1))
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - ε) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (5 / 4 : ℝ) * (n : ℝ) := by
  have hlower := eventual_chebyshev_ratio_window hPNT hε
  have hupper := eventual_chebyshev_ratio_window hPNT
    (by norm_num : (0 : ℝ) < 1 / 4)
  have hboth :
      ∀ᶠ n : ℕ in atTop,
        (1 - ε) * (n : ℝ) < Chebyshev.theta n ∧
          Chebyshev.theta n < (5 / 4 : ℝ) * (n : ℝ) := by
    filter_upwards [hlower, hupper] with n hnε hnquarter
    constructor
    · exact hnε.1
    · nlinarith [hnquarter.2]
  exact eventually_atTop.1 hboth

/-- The endpoint error calculation independent of the particular ceiling
constructor. The hypotheses say that `H` is less than one above the printed
lower real endpoint and that `X` is at least the printed upper radius. -/
theorem genEllLemma41_integer_endpoint_error
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase : ℝ)
    (H X M : ℕ)
    (hXone : 1 ≤ X)
    {ε xε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hendpointBudget : (5 / 4 : ℝ) < ε * xε)
    (hxA : xε < xA)
    (hhBase : 0 ≤ hBase)
    (hxA_mass : xA = primeLogMass A)
    (hHupper :
      (H : ℝ) < (1 + 6 * ε) * hBase + 1)
    (hXlower :
      genEllLemma41Radius ε xA hBase ≤ (X : ℝ))
    (hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H < (5 / 4 : ℝ) * (H : ℝ))
    (hthetaX :
      (1 - ε) * (X : ℝ) < Chebyshev.theta X) :
    M ≤ (escapingPrimes A H X).card := by
  have hthetaH_printed :
      Chebyshev.theta H <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * hBase) + 5 / 4 := by
    nlinarith
  have honeMinus : 0 < 1 - ε := by
    linarith
  have hthetaX_printed :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta X := by
    have hscaled :
        (1 - ε) * genEllLemma41Radius ε xA hBase ≤
          (1 - ε) * (X : ℝ) :=
      mul_le_mul_of_nonneg_left hXlower honeMinus.le
    exact hscaled.trans_lt hthetaX
  have hscalar :
      xA <
        -(((M - 1 : ℕ) : ℝ) * Real.log X) -
          Chebyshev.theta H + Chebyshev.theta X := by
    exact genEllLemma41_lt_offending_bound
      hεpos hεlt hxεpos hendpointBudget hxA hhBase
        hMlog hthetaH_printed hthetaX_printed
  rw [hxA_mass] at hscalar
  apply card_escapingPrimes_ge_of_theta_gt A hA H X M hXone
  linarith

/-- **Ceiling/PNT form of GenEll Lemma 4.1.** The lower and upper integer
endpoints are the ceilings of the corresponding printed real quantities.
Once both lie beyond the PNT threshold and the elementary logarithmic term is
small enough, there are at least `M` distinct escaping primes. -/
theorem genEllLemma41_ceiling_endpoints
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase : ℝ)
    (M : ℕ)
    {ε xε xA : ℝ}
    (hPNT :
      Tendsto
        (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
        atTop (𝓝 1))
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
        (exists_chebyshev_pnt_window_threshold hPNT hεpos)
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
  let N : ℕ := Classical.choose
    (exists_chebyshev_pnt_window_threshold hPNT hεpos)
  have hN := Classical.choose_spec
    (exists_chebyshev_pnt_window_threshold hPNT hεpos)
  let H : ℕ := naturalCeilingEndpoint ((1 + 6 * ε) * hBase)
  let X : ℕ := naturalCeilingEndpoint
    (genEllLemma41Radius ε xA hBase)
  have hbaseEndpoint_nonneg :
      0 ≤ (1 + 6 * ε) * hBase := by positivity
  have hHbounds :=
    naturalCeilingEndpoint_bounds hbaseEndpoint_nonneg
  have hXbounds := naturalCeilingEndpoint_bounds hradius_nonneg
  have hlarge' : N ≤ H ∧ N ≤ X := by
    simpa [N, H, X] using hlarge
  have hwindowH := hN H hlarge'.1
  have hwindowX := hN X hlarge'.2
  have hXone : 1 ≤ X := by
    have hreal : (1 : ℝ) ≤ X := hradius_one.trans hXbounds.1
    exact_mod_cast hreal
  apply genEllLemma41_integer_endpoint_error
    A hA hBase H X M hXone
      hεpos hεlt hxεpos hendpointBudget hxA hhBase hxA_mass
  · simpa [H] using hHbounds.2
  · simpa [X] using hXbounds.1
  · simpa [X] using hMlog
  · exact hwindowH.2
  · exact hwindowX.1

end IUTThreeClosures
