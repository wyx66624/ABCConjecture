/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExplicitBoundedPrimeAvoidance
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Quantitative large image from a uniform Tate-order criterion

For a semistable elliptic curve over `ℚ` with a multiplicative place of Tate
order `n`, the standard proposed uniform route to large image is the following
three-theorem package:

1. Mazur irreducibility above the finite list of rational prime-degree
   isogenies;
2. Tate inertia supplies a transvection when `ell ∤ n`;
3. an irreducible subgroup of `GL₂(F_ell)` containing a transvection contains
   `SL₂(F_ell)` (and the cyclotomic determinant gives the desired full image).

This file does not assume those deep theorems individually.  It isolates their
exact combined output as `UniformLargeImageOffTateOrder` and proves that this
output, together with explicit factorial-bounded prime avoidance, yields a
quantitatively bounded large-image prime.

The selected prime satisfies

`ell <= n * B! + 1`,

where `B` is any threshold above the uniform large-image constant and the
required epsilon threshold.  Its logarithm is therefore bounded by

`log(n+1) + log(B!+1)`.

Thus dependence on the selected prime is only logarithmic in the local Tate
order.  This is the bridge between the Mazur--Tate--Dickson route and the
logarithmic source-error absorption theorem.
-/

namespace IUTThreeClosures

/-- The exact source theorem required from the uniform semistable
Mazur--Tate-inertia--Dickson argument. -/
def UniformLargeImageOffTateOrder
    (GoodImage : ℕ → Prop)
    (uniformThreshold order : ℕ) : Prop :=
  ∀ ell : ℕ,
    ell.Prime →
    uniformThreshold < ell →
    ¬ ell ∣ order →
    GoodImage ell

/-- A uniform large-image criterion off one positive Tate order yields a
large-image prime with an explicit upper bound. -/
theorem exists_quantitative_largeImage_prime
    {GoodImage : ℕ → Prop}
    {uniformThreshold order B : ℕ}
    (horder : 0 < order)
    (hthreshold : uniformThreshold ≤ B)
    (hlarge :
      UniformLargeImageOffTateOrder
        GoodImage uniformThreshold order) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      GoodImage ell ∧
      ell ≤ order * B.factorial + 1 := by
  obtain ⟨ell, hellPrime, hBell, hellOrder, hellBound⟩ :=
    exists_prime_above_avoiding_one_bounded B order horder
  refine ⟨ell, hellPrime, hBell, ?_, hellBound⟩
  exact hlarge ell hellPrime (lt_of_le_of_lt hthreshold hBell) hellOrder

/-- The elementary product bound used to separate the Tate-order and
threshold contributions to the logarithm of the selected prime. -/
theorem order_mul_factorial_add_one_le
    (order B : ℕ) :
    order * B.factorial + 1 ≤
      (order + 1) * (B.factorial + 1) := by
  nlinarith

/-- Any quantitatively selected prime has logarithm at most the sum of a local
Tate-order logarithm and an epsilon-dependent factorial constant. -/
theorem log_prime_le_log_order_add_factorial
    {ell order B : ℕ}
    (hell_pos : 0 < ell)
    (hellBound : ell ≤ order * B.factorial + 1) :
    Real.log ell ≤
      Real.log (order + 1) +
        Real.log (B.factorial + 1) := by
  have horder_pos : 0 < (order + 1 : ℝ) := by positivity
  have hfac_pos : 0 < (B.factorial + 1 : ℝ) := by positivity
  have hboundNat :
      ell ≤ (order + 1) * (B.factorial + 1) :=
    hellBound.trans (order_mul_factorial_add_one_le order B)
  have hboundReal :
      (ell : ℝ) ≤
        (order + 1 : ℝ) * (B.factorial + 1 : ℝ) := by
    exact_mod_cast hboundNat
  have hlog := Real.strictMonoOn_log.monotoneOn
    (by exact_mod_cast hell_pos)
    (mul_pos horder_pos hfac_pos)
    hboundReal
  rw [Real.log_mul horder_pos.ne' hfac_pos.ne'] at hlog
  exact hlog

/-- Combined quantitative conclusion including the logarithmic bound. -/
theorem exists_quantitative_largeImage_prime_with_log_bound
    {GoodImage : ℕ → Prop}
    {uniformThreshold order B : ℕ}
    (horder : 0 < order)
    (hthreshold : uniformThreshold ≤ B)
    (hlarge :
      UniformLargeImageOffTateOrder
        GoodImage uniformThreshold order) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      GoodImage ell ∧
      ell ≤ order * B.factorial + 1 ∧
      Real.log ell ≤
        Real.log (order + 1) +
          Real.log (B.factorial + 1) := by
  obtain ⟨ell, hellPrime, hBell, hGood, hellBound⟩ :=
    exists_quantitative_largeImage_prime
      horder hthreshold hlarge
  refine ⟨ell, hellPrime, hBell, hGood, hellBound, ?_⟩
  exact log_prime_le_log_order_add_factorial
    hellPrime.pos hellBound

end IUTThreeClosures
