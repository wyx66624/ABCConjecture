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

This module joins the two. The base quantity `h` entering the printed radius
is kept separate from the integer lower endpoint `H` of the prime interval.
This is essential for the printed application, where `H` represents an
integer endpoint near `(1+6*epsilon)h`.

Once

* `x_A` is identified with the logarithmic mass of the forbidden primes;
* the logarithmic mass of at most `M-1` candidate primes is bounded by
  `epsilon*y_A`;
* the upper Chebyshev estimate holds at `H` with the printed scaled-height
  bound;
* the lower Chebyshev estimate holds at the integer upper endpoint `X`;

there are at least `M` distinct primes in `(H,X]` outside the forbidden set.
The remaining endpoint task is precisely to choose `H` and `X` around the
printed real radii and verify these two estimates.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The scalar GenEll inequalities imply the exact Chebyshev margin consumed
by the multiple-prime counting theorem. The real base-height parameter and
the integer lower endpoint are intentionally distinct. -/
theorem genEllLemma41_chebyshev_margin_between
    (A : Finset ℕ)
    (hBase H X M : ℕ)
    {ε xε Cε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) *
          ((1 + 6 * ε) * (hBase : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta X) :
    Chebyshev.theta H + primeLogMass A +
        (((M - 1 : ℕ) : ℝ) * Real.log X) <
      Chebyshev.theta X := by
  have hscalar :
      xA <
        -(((M - 1 : ℕ) : ℝ) * Real.log X) -
          Chebyshev.theta H + Chebyshev.theta X := by
    exact genEllLemma41_lt_offending_bound
      hεpos hεlt hxεpos hCε hxA
      (by positivity : (0 : ℝ) ≤ hBase)
      hMlog hthetaH hthetaX
  rw [hxA_mass] at hscalar
  linarith

/-- **Endpoint-correct counting form of GenEll Lemma 4.1.** Under the
printed scalar hypotheses, at least `M` distinct primes lie in `(H,X]` and
avoid `A`. -/
theorem genEllLemma41_card_escapingPrimes_between_ge
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase H X M : ℕ)
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
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) *
          ((1 + 6 * ε) * (hBase : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta X) :
    M ≤ (escapingPrimes A H X).card := by
  apply card_escapingPrimes_ge_of_theta_gt A hA H X M hX
  exact genEllLemma41_chebyshev_margin_between
    A hBase H X M hεpos hεlt hxεpos hCε hxA hxA_mass
      hMlog hthetaH hthetaX

/-- The endpoint-correct conclusion expanded into the exact membership
properties of the resulting finite set. -/
theorem genEllLemma41_many_primes_between
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase H X M : ℕ)
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
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) *
          ((1 + 6 * ε) * (hBase : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta X) :
    ∃ S : Finset ℕ,
      M ≤ S.card ∧
      ∀ p ∈ S, p.Prime ∧ H < p ∧ p ≤ X ∧ p ∉ A := by
  refine ⟨escapingPrimes A H X, ?_, ?_⟩
  · exact genEllLemma41_card_escapingPrimes_between_ge
      A hA hBase H X M hX hεpos hεlt hxεpos hCε hxA
        hxA_mass hMlog hthetaH hthetaX
  · intro p hp
    exact (mem_escapingPrimes_iff A H X p).mp hp

/-- Convenience specialization in which the base-height parameter itself is
the integer lower endpoint. -/
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
      Chebyshev.theta X :=
  genEllLemma41_chebyshev_margin_between
    A h h X M hεpos hεlt hxεpos hCε hxA hxA_mass
      hMlog hthetaH hthetaX

/-- Convenience counting specialization with the same base and lower
endpoint. -/
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
    M ≤ (escapingPrimes A h X).card :=
  genEllLemma41_card_escapingPrimes_between_ge
    A hA h h X M hX hεpos hεlt hxεpos hCε hxA
      hxA_mass hMlog hthetaH hthetaX

end IUTThreeClosures
