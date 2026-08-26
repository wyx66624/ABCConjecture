/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WeightedPoitouTateSelectorAudit

/-!
# Adaptive pair-square selectors

For the Frey cubic

    f(x) = x * (x - a) * (x + b), with a + b = c,

three coefficient-adaptive abscissas force the square of one root
difference into f(x):

* x = k * a;
* x = -k * b;
* x = a + (k - 1) * c.

The paper companion proves that a weighted CRT choice of a bounded
coefficient k, followed by removal of degree-at-most-two torsion
abscissas, gives a non-torsion quadratic point. Its signed squarefree
carrier is linear in c, while at most a 1/3 + δ fraction of the total
odd multiplicative-depth mass is lost.

This module formalizes the three polynomial identities, the exact
one-of-three averaging and survivor ledgers, the retained local-height
coefficient, and the elementary linear carrier bounds. It does not model
elliptic curves, squarefree kernels, Néron models, CRT, Merel's theorem, or
Tate's algorithm.
-/

namespace IUTThreeClosures

/-! ## The three exact pair-square identities -/

/-- The a-oriented abscissa x = k a puts a² into the cubic value. -/
theorem adaptiveA_pairSquare_identity (a b k : ℤ) :
    (k * a) * (k * a - a) * (k * a + b) =
      a ^ 2 * (k * (k - 1) * (k * a + b)) := by
  ring

/-- The b-oriented abscissa x = -k b puts b² into the cubic value. -/
theorem adaptiveB_pairSquare_identity (a b k : ℤ) :
    (-k * b) * (-k * b - a) * (-k * b + b) =
      -(b ^ 2 * (k * (k - 1) * (a + k * b))) := by
  ring

/-- The c-oriented abscissa x = a + (k-1)c puts c² into the
cubic value, using c = a + b. -/
theorem adaptiveC_pairSquare_identity
    (a b c k : ℤ) (hc : c = a + b) :
    (a + (k - 1) * c) *
        (a + (k - 1) * c - a) *
        (a + (k - 1) * c + b) =
      c ^ 2 * (k * (k - 1) * (a + (k - 1) * c)) := by
  rw [hc]
  ring

/-- The completely smooth-at-odd-bad-primes trial abscissa a-b has a
cubic-size squareclass carrier. -/
theorem differenceAbscissa_identity (a b : ℤ) :
    (a - b) * (a - b - a) * (a - b + b) =
      -a * b * (a - b) := by
  ring

/-! ## The structural one-third loss -/

/-- One of three real masses is at most their average. In the paper the
three masses are the odd multiplicative-depth masses on the supports of
a, b, and c. -/
theorem one_of_three_le_third (massA massB massC : ℝ) :
    massA ≤ (massA + massB + massC) / 3 ∨
      massB ≤ (massA + massB + massC) / 3 ∨
      massC ≤ (massA + massB + massC) / 3 := by
  by_cases hA : massA ≤ (massA + massB + massC) / 3
  · exact Or.inl hA
  by_cases hB : massB ≤ (massA + massB + massC) / 3
  · exact Or.inr (Or.inl hB)
  · exact Or.inr (Or.inr (by
      have hA' : (massA + massB + massC) / 3 < massA :=
        lt_of_not_ge hA
      have hB' : (massA + massB + massC) / 3 < massB :=
        lt_of_not_ge hB
      linarith))

/-- Losing at most one third structurally and an additional δ fraction
from CRT collisions loses at most 1/3 + δ in total. -/
theorem adaptivePairSquare_badMass_bound
    {lost residual total δ : ℝ}
    (hlost : lost ≤ total / 3)
    (hresidual : residual ≤ δ * total) :
    lost + residual ≤ ((1 : ℝ) / 3 + δ) * total := by
  nlinarith

/-! ## Removing torsion rows and taking a surviving average -/

/-- A cardinality-scaled residual bound and enough surviving rows give the
requested fractional residual bound. This is the scalar core left after
the owner double count and degree-two torsion removal. -/
theorem survivorResidual_le_fraction
    {survivorCount residual total δ : ℝ}
    (hresidual : 0 ≤ residual)
    (hscaled : survivorCount * residual ≤ total)
    (hcard : 1 ≤ δ * survivorCount)
    (hδ : 0 ≤ δ) :
    residual ≤ δ * total := by
  have hfirst : residual ≤ (δ * survivorCount) * residual :=
    by simpa using mul_le_mul_of_nonneg_right hcard hresidual
  have hsecond :
      δ * (survivorCount * residual) ≤ δ * total :=
    mul_le_mul_of_nonneg_left hscaled hδ
  calc
    residual ≤ (δ * survivorCount) * residual := hfirst
    _ = δ * (survivorCount * residual) := by ring
    _ ≤ δ * total := hsecond

/-- The combined scalar theorem used after choosing the lightest
orientation and then a low-loss non-torsion survivor. -/
theorem adaptivePairSquare_survivor_badMass
    {lost residual total survivorCount δ : ℝ}
    (hlost : lost ≤ total / 3)
    (hresidual : 0 ≤ residual)
    (hscaled : survivorCount * residual ≤ total)
    (hcard : 1 ≤ δ * survivorCount)
    (hδ : 0 ≤ δ) :
    lost + residual ≤ ((1 : ℝ) / 3 + δ) * total := by
  apply adaptivePairSquare_badMass_bound hlost
  exact survivorResidual_le_fraction hresidual hscaled hcard hδ

/-! ## The retained local-height coefficient -/

/-- Identity-component mass contributes 1/6 and arbitrary bad-component
mass is bounded below with coefficient -1/12. -/
theorem adaptivePairSquare_localHeightLedger
    (total bad : ℝ) :
    (total - bad) / 6 - bad / 12 = (2 * total - 3 * bad) / 12 := by
  ring

/-- A bad fraction at most 1/3 + δ retains the exact positive coefficient
(1 - 3δ)/12. -/
theorem adaptivePairSquare_localHeight_lower
    {total bad δ : ℝ}
    (_htotal : 0 ≤ total)
    (hbad : bad ≤ ((1 : ℝ) / 3 + δ) * total) :
    (1 - 3 * δ) / 12 * total ≤
      (total - bad) / 6 - bad / 12 := by
  rw [adaptivePairSquare_localHeightLedger]
  nlinarith

/-! ## Bounded coefficients give a carrier linear in the source height -/

/-- The positive a-oriented carrier is bounded by H³ c when
a + b = c and 1 ≤ k ≤ H. -/
theorem adaptiveA_carrier_le
    {a b c k H : ℕ}
    (hc : a + b = c) (hkone : 1 ≤ k) (hk : k ≤ H) :
    k * (k - 1) * (k * a + b) ≤ H * H * (H * c) := by
  have hbscale : b ≤ k * b := by
    calc
      b = 1 * b := by simp
      _ ≤ k * b := Nat.mul_le_mul_right b hkone
  have hlinear : k * a + b ≤ k * c := by
    calc
      k * a + b ≤ k * a + k * b := Nat.add_le_add_left hbscale (k * a)
      _ = k * (a + b) := by ring
      _ = k * c := by rw [hc]
  have hkpred : k - 1 ≤ H := (Nat.sub_le k 1).trans hk
  have hkc : k * c ≤ H * c := Nat.mul_le_mul_right c hk
  exact Nat.mul_le_mul (Nat.mul_le_mul hk hkpred) (hlinear.trans hkc)

/-- The positive absolute b-oriented carrier has the same bound. -/
theorem adaptiveB_carrier_le
    {a b c k H : ℕ}
    (hc : a + b = c) (hkone : 1 ≤ k) (hk : k ≤ H) :
    k * (k - 1) * (a + k * b) ≤ H * H * (H * c) := by
  have hascale : a ≤ k * a := by
    calc
      a = 1 * a := by simp
      _ ≤ k * a := Nat.mul_le_mul_right a hkone
  have hlinear : a + k * b ≤ k * c := by
    calc
      a + k * b ≤ k * a + k * b := Nat.add_le_add_right hascale (k * b)
      _ = k * (a + b) := by ring
      _ = k * c := by rw [hc]
  have hkpred : k - 1 ≤ H := (Nat.sub_le k 1).trans hk
  have hkc : k * c ≤ H * c := Nat.mul_le_mul_right c hk
  exact Nat.mul_le_mul (Nat.mul_le_mul hk hkpred) (hlinear.trans hkc)

/-- The positive c-oriented carrier has the same bound. -/
theorem adaptiveC_carrier_le
    {a c k H : ℕ}
    (ha : a ≤ c) (hkone : 1 ≤ k) (hk : k ≤ H) :
    k * (k - 1) * (a + (k - 1) * c) ≤ H * H * (H * c) := by
  have hlinear : a + (k - 1) * c ≤ k * c := by
    calc
      a + (k - 1) * c ≤ c + (k - 1) * c :=
        Nat.add_le_add_right ha ((k - 1) * c)
      _ = ((k - 1) + 1) * c := by ring
      _ = k * c := by rw [Nat.sub_add_cancel hkone]
  have hkpred : k - 1 ≤ H := (Nat.sub_le k 1).trans hk
  have hkc : k * c ≤ H * c := Nat.mul_le_mul_right c hk
  exact Nat.mul_le_mul (Nat.mul_le_mul hk hkpred) (hlinear.trans hkc)

end IUTThreeClosures
