/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Integer core of the balancing-Pell four-prime coupling

This module formalizes the self-contained algebraic core proved first in
`research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md`.

It checks:

* the exact Pell quotient-coordinate identity;
* transfer of two second-order channel congruences to the coupled congruence
  modulo `4 * ell^2`;
* the complete second-order numerical certificate at prime index seven.

The factorization expansions which produce the two input congruences are
finite binomial identities in the paper.  No perfect-power classification,
number-field infinitude theorem, or statement about abc is assumed here.
-/

namespace IUTThreeClosures
namespace PellFourPrimeCoupling20260901

/-- The degree-two elementary coefficient of a product
`prod_i (1 + x * t_i)`, written recursively to avoid an arbitrary ordering
of pairs. -/
def pairCoefficient : List ℤ → ℤ
  | [] => 0
  | t :: ts => t * ts.sum + pairCoefficient ts

/-- Truncation of an arbitrary finite product after its quadratic term.
This is the list form of the two channel binomial expansions in the paper;
repeating a quotient `k` exactly `e` times represents `(1+x*k)^e`. -/
theorem product_one_add_secondOrder (x : ℤ) (ts : List ℤ) :
    (ts.map fun t => 1 + x * t).prod ≡
      1 + x * ts.sum + x ^ 2 * pairCoefficient ts [ZMOD x ^ 3] := by
  induction ts with
  | nil => simp [pairCoefficient]
  | cons t ts ih =>
      have hmul := ih.mul_left (1 + x * t)
      have htruncate :
          (1 + x * t) *
              (1 + x * ts.sum + x ^ 2 * pairCoefficient ts) ≡
            1 + x * (t + ts.sum) +
              x ^ 2 * (t * ts.sum + pairCoefficient ts) [ZMOD x ^ 3] := by
        apply Int.modEq_of_dvd
        refine ⟨-(t * pairCoefficient ts), ?_⟩
        ring
      simpa [pairCoefficient] using hmul.trans htruncate

/-- Cancelling the common nonzero factor `x` turns the product expansion
modulo `x^3` into its quotient expansion modulo `x^2`. -/
theorem quotient_secondOrder_of_product
    (x a : ℤ) (ts : List ℤ) (hx : x ≠ 0)
    (hprod : 1 + x * a = (ts.map fun t => 1 + x * t).prod) :
    a ≡ ts.sum + x * pairCoefficient ts [ZMOD x ^ 2] := by
  have hfull :
      1 + x * a ≡ 1 + x * ts.sum + x ^ 2 * pairCoefficient ts
        [ZMOD x ^ 3] := by
    rw [hprod]
    exact product_one_add_secondOrder x ts
  apply Int.modEq_of_dvd
  rcases hfull.dvd with ⟨k, hk⟩
  refine ⟨k, ?_⟩
  have hcancel :
      x * (ts.sum + x * pairCoefficient ts - a) =
        x * (x ^ 2 * k) := by
    calc
      x * (ts.sum + x * pairCoefficient ts - a) =
          (1 + x * ts.sum + x ^ 2 * pairCoefficient ts) -
            (1 + x * a) := by ring
      _ = x ^ 3 * k := hk
      _ = x * (x ^ 2 * k) := by ring
  exact mul_left_cancel₀ hx hcancel

/-- Substituting signed quotient coordinates into the negative Pell equation
gives the exact conic identity used by both the first- and second-order
ledgers. -/
theorem pellChannelQuotient_exact
    (ell A B s a b : ℤ)
    (hell : ell ≠ 0)
    (hA : A = 1 + 2 * ell * a)
    (hB : s * B = 1 + 2 * ell * b)
    (hs : s ^ 2 = 1)
    (hPell : A ^ 2 - 2 * B ^ 2 = -1) :
    a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2) = 0 := by
  rw [hA] at hPell
  have hBsq : B ^ 2 = (1 + 2 * ell * b) ^ 2 := by
    calc
      B ^ 2 = s ^ 2 * B ^ 2 := by rw [hs]; ring
      _ = (s * B) ^ 2 := by ring
      _ = (1 + 2 * ell * b) ^ 2 := by rw [hB]
  rw [hBsq] at hPell
  have hfactor :
      (4 * ell) * (a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2)) = 0 := by
    nlinarith
  exact (mul_eq_zero.mp hfactor).resolve_left
    (mul_ne_zero (by norm_num) hell)

/-- Pure congruence transfer behind the second-order two-channel ledger.

`KA,KB` are the linear prime-factor coefficients and `CA,CB` are the
quadratic product coefficients.  Once the two channel products have been
expanded modulo `(2*ell)^3`, their quotient coordinates obey `ha` and `hb`.
The exact Pell quotient identity then forces the displayed coupling modulo
`4*ell^2`. -/
theorem secondOrderCoupling_of_channelCongruences
    (ell a b KA KB CA CB : ℤ)
    (ha : a ≡ KA + 2 * ell * CA [ZMOD 4 * ell ^ 2])
    (hb : b ≡ KB + 2 * ell * CB [ZMOD 4 * ell ^ 2])
    (hExact : a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2) = 0) :
    KA - 2 * KB + ell * (KA ^ 2 - 2 * KB ^ 2) +
        2 * ell * (CA - 2 * CB) ≡ 0 [ZMOD 4 * ell ^ 2] := by
  have hlinear :
      a - 2 * b ≡
        (KA + 2 * ell * CA) - 2 * (KB + 2 * ell * CB)
          [ZMOD 4 * ell ^ 2] :=
    ha.sub (hb.mul_left 2)
  have hquadratic :
      ell * (a ^ 2 - 2 * b ^ 2) ≡
        ell * ((KA + 2 * ell * CA) ^ 2 -
          2 * (KB + 2 * ell * CB) ^ 2)
          [ZMOD 4 * ell ^ 2] :=
    ((ha.pow 2).sub ((hb.pow 2).mul_left 2)).mul_left ell
  have hsum := hlinear.add hquadratic
  have htruncate :
      (KA + 2 * ell * CA) - 2 * (KB + 2 * ell * CB) +
          ell * ((KA + 2 * ell * CA) ^ 2 -
            2 * (KB + 2 * ell * CB) ^ 2) ≡
        KA - 2 * KB + ell * (KA ^ 2 - 2 * KB ^ 2) +
          2 * ell * (CA - 2 * CB)
          [ZMOD 4 * ell ^ 2] := by
    apply Int.modEq_of_dvd
    refine ⟨-((KA * CA - 2 * KB * CB) +
        ell * (CA ^ 2 - 2 * CB ^ 2)), ?_⟩
    ring
  have hzero :
      a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2) ≡ 0
        [ZMOD 4 * ell ^ 2] := by
    rw [hExact]
  exact htruncate.symm.trans (hsum.symm.trans hzero)

/-- The exact quotient conic at `ell=7`, where
`A_7=239=1+14*17` and `B_7=169=1+14*12`. -/
theorem indexSeven_exactQuotientCertificate :
    (17 : ℤ) - 2 * 12 + 7 * (17 ^ 2 - 2 * 12 ^ 2) = 0 := by
  norm_num

/-- The complete second-order ledger at index seven.  Here the `A` channel
has `(KA,CA)=(17,0)` and the repeated factor `B_7=13^2`, with
`13=-1+14`, gives `(KB,CB)=(-2,1)`. -/
theorem indexSeven_secondOrderCertificate :
    (17 : ℤ) - 2 * (-2) + 7 * (17 ^ 2 - 2 * (-2) ^ 2) +
        2 * 7 * (0 - 2 * 1) ≡ 0 [ZMOD 4 * 7 ^ 2] := by
  norm_num [Int.ModEq]

#check pellChannelQuotient_exact
#check pairCoefficient
#check product_one_add_secondOrder
#check quotient_secondOrder_of_product
#check secondOrderCoupling_of_channelCongruences
#check indexSeven_exactQuotientCertificate
#check indexSeven_secondOrderCertificate

#print axioms pellChannelQuotient_exact
#print axioms product_one_add_secondOrder
#print axioms quotient_secondOrder_of_product
#print axioms secondOrderCoupling_of_channelCongruences
#print axioms indexSeven_exactQuotientCertificate
#print axioms indexSeven_secondOrderCertificate

end PellFourPrimeCoupling20260901
end IUTThreeClosures
