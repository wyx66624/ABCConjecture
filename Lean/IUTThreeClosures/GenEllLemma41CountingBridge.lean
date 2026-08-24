/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ChebyshevMultiplePrimeEscape
import IUTThreeClosures.GenEllLemma41ScalarCore

/-!
# From the GenEll scalar estimate to several escaping primes

The proof of GenEll Lemma 4.1 has two logically independent parts already
formalized in this project:

1. a finite-set counting theorem which turns a Chebyshev logarithmic-mass
   margin into several distinct primes outside the exceptional set;
2. the exact real-algebraic contradiction for the printed radius
   `y_A = (1 + 6*epsilon)*x_A + 8*h`.

This module joins the two.  Once

* `x_A` is identified with the logarithmic mass of the forbidden primes;
* the logarithmic mass of at most `M-1` candidate primes is bounded by
  `epsilon*y_A`;
* the upper and lower Chebyshev estimates used in the printed proof hold;

there are at least `M` distinct primes in `(h,X]` outside the forbidden set.

The theorem deliberately leaves the endpoint choice `X` and the two
Chebyshev estimates explicit.  Thus the remaining analytic task is precisely
to choose an integer endpoint representing the printed real radius and verify
those estimates; the remaining arithmetic task is to bound the exceptional
prime mass `x_A`.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The scalar GenEll inequalities imply the exact Chebyshev margin consumed
by the multiple-prime counting theorem. -/
theorem genEllLemma41_chebyshev_margin
    (A : Finset ℕ)
    (h X M : ℕ)
    {ε xε Cε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA h)
    (hthetaH :
      Chebyshev.theta h <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * (h : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA h <
        Chebyshev.theta X) :
    Chebyshev.theta h + primeLogMass A +
        (((M - 1 : ℕ) : ℝ) * Real.log X) <
      Chebyshev.theta X := by
  have hscalar :
      xA <
        -(((M - 1 : ℕ) : ℝ) * Real.log X) -
          Chebyshev.theta h + Chebyshev.theta X := by
    exact genEllLemma41_lt_offending_bound
      hεpos hεlt hxεpos hCε hxA
      (by positivity : (0 : ℝ) ≤ h)
      hMlog hthetaH hthetaX
  rw [hxA_mass] at hscalar
  linarith

/-- **Counting form of GenEll Lemma 4.1.**  Under the printed scalar
hypotheses, at least `M` distinct primes lie in `(h,X]` and avoid `A`. -/
theorem genEllLemma41_card_escapingPrimes_ge
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (h X M : ℕ)
    (hX : 1 ≤ X)
    {ε xε Cε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA h)
    (hthetaH :
      Chebyshev.theta h <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * (h : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA h <
        Chebyshev.theta X) :
    M ≤ (escapingPrimes A h X).card := by
  apply card_escapingPrimes_ge_of_theta_gt A hA h X M hX
  exact genEllLemma41_chebyshev_margin
    A h X M hεpos hεlt hxεpos hCε hxA hxA_mass
      hMlog hthetaH hthetaX

/-- The same conclusion expanded into the exact membership properties of the
resulting finite set. -/
theorem genEllLemma41_many_primes
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (h X M : ℕ)
    (hX : 1 ≤ X)
    {ε xε Cε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA h)
    (hthetaH :
      Chebyshev.theta h <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * (h : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA h <
        Chebyshev.theta X) :
    ∃ S : Finset ℕ,
      M ≤ S.card ∧
      ∀ p ∈ S, p.Prime ∧ h < p ∧ p ≤ X ∧ p ∉ A := by
  refine ⟨escapingPrimes A h X, ?_, ?_⟩
  · exact genEllLemma41_card_escapingPrimes_ge
      A hA h X M hX hεpos hεlt hxεpos hCε hxA
        hxA_mass hMlog hthetaH hthetaX
  · intro p hp
    exact (mem_escapingPrimes_iff A h X p).mp hp

end IUTThreeClosures
