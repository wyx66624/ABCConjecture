/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SplitSquareArithmeticBridge
import Mathlib.Tactic

/-!
# Fixed-prime radical overlap in the split-square branch

For positive integers `a,b`, the product of their radicals is bounded by the
product of `gcd(a,b)` and the radical of `a*b`.  Hence, if `gcd(a,b)` divides
two,

`rad(a) * rad(b) <= 2 * rad(a*b)`.

Applying this to the root gap `d=y-x` and root sum `s=y+x`, and then using the
coprimality of `x,y` with both factors, gives the exact split-square support
bound

`rad(d*x*y) * rad(s) <= 2 * rad(d*s*x*y)`.

Taking logarithms shows that the radical omitted in the root descent differs
from the full radical of `s` by at most `log 2`.  No ABC estimate is assumed.
-/

namespace IUTThreeClosures
namespace SplitSquareRadicalOverlap

open UniqueFactorizationMonoid
open SplitSquareArithmeticBridge

noncomputable section

/-- The product of two radicals is bounded by `gcd(a,b)` times the radical of
the product. -/
theorem radical_mul_le_gcd_mul_radical_product
    {a b : ℕ} (ha : 0 < a) (hb : 0 < b) :
    radical a * radical b ≤ Nat.gcd a b * radical (a * b) := by
  have habpos : 0 < a * b := mul_pos ha hb
  have hra_dvd : radical a ∣ radical (a * b) := by
    apply radical_dvd_radical
    · exact ⟨b, by ring⟩
    · exact habpos.ne'
  have hrb_dvd : radical b ∣ radical (a * b) := by
    apply radical_dvd_radical
    · exact ⟨a, by ring⟩
    · exact habpos.ne'
  have hlcm_dvd :
      Nat.lcm (radical a) (radical b) ∣ radical (a * b) :=
    Nat.lcm_dvd hra_dvd hrb_dvd
  have hlcm_le :
      Nat.lcm (radical a) (radical b) ≤ radical (a * b) :=
    Nat.le_of_dvd (Nat.radical_pos (a * b)) hlcm_dvd
  have hra_self : radical a ∣ a := radical_dvd a
  have hrb_self : radical b ∣ b := radical_dvd b
  have hgcd_dvd :
      Nat.gcd (radical a) (radical b) ∣ Nat.gcd a b := by
    apply Nat.dvd_gcd
    · exact (Nat.gcd_dvd_left (radical a) (radical b)).trans hra_self
    · exact (Nat.gcd_dvd_right (radical a) (radical b)).trans hrb_self
  have hgcd_le :
      Nat.gcd (radical a) (radical b) ≤ Nat.gcd a b :=
    Nat.le_of_dvd (Nat.gcd_pos_of_pos_left b ha) hgcd_dvd
  calc
    radical a * radical b =
        Nat.gcd (radical a) (radical b) *
          Nat.lcm (radical a) (radical b) := by
      symm
      exact Nat.gcd_mul_lcm (radical a) (radical b)
    _ ≤ Nat.gcd a b * radical (a * b) :=
      Nat.mul_le_mul hgcd_le hlcm_le

/-- If the common divisor is supported at two, the radical overlap costs at
most a factor two. -/
theorem radical_mul_le_two_mul_radical_product
    {a b : ℕ} (ha : 0 < a) (hb : 0 < b)
    (hgcd : Nat.gcd a b ∣ 2) :
    radical a * radical b ≤ 2 * radical (a * b) := by
  have hgcd_le : Nat.gcd a b ≤ 2 :=
    Nat.le_of_dvd (by norm_num) hgcd
  have hbase := radical_mul_le_gcd_mul_radical_product ha hb
  have hmul := Nat.mul_le_mul_right (radical (a * b)) hgcd_le
  exact hbase.trans hmul

namespace SplitSquareArithmeticBridge.Data

/-- Radical of the root triple splits over its three pairwise-coprime
coordinates. -/
theorem rootRadical_eq_factor_product (D : Data) :
    abcRadical (D.gap * D.x * D.y) =
      abcRadical D.gap * (abcRadical D.x * abcRadical D.y) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
    abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have hgap_xy : Nat.Coprime D.gap (D.x * D.y) :=
    D.gap_coprime_x.mul_right D.gap_coprime_y
  rw [show D.gap * D.x * D.y = D.gap * (D.x * D.y) by ring]
  rw [radical_mul
    (Nat.coprime_iff_isRelPrime.mp hgap_xy)]
  rw [radical_mul
    (Nat.coprime_iff_isRelPrime.mp D.coprime)]

/-- Radical of the four-factor support splits into the gap-sum part and the two
coprime roots. -/
theorem supportRadical_eq_factor_product (D : Data) :
    abcRadical ((D.gap * D.sum) * D.x * D.y) =
      abcRadical (D.gap * D.sum) *
        (abcRadical D.x * abcRadical D.y) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
    abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have hsupport_xy :
      Nat.Coprime (D.gap * D.sum) (D.x * D.y) :=
    D.gap_mul_sum_coprime_x.mul_right D.gap_mul_sum_coprime_y
  rw [show (D.gap * D.sum) * D.x * D.y =
      (D.gap * D.sum) * (D.x * D.y) by ring]
  rw [radical_mul
    (Nat.coprime_iff_isRelPrime.mp hsupport_xy)]
  rw [radical_mul
    (Nat.coprime_iff_isRelPrime.mp D.coprime)]

/-- Exact integer overlap bound for the root radical and companion-sum
radical. -/
theorem rootRadical_mul_sumRadical_le_two_mul_supportRadical
    (D : Data) :
    abcRadical (D.gap * D.x * D.y) * abcRadical D.sum ≤
      2 * abcRadical ((D.gap * D.sum) * D.x * D.y) := by
  have hgap_sum :
      abcRadical D.gap * abcRadical D.sum ≤
        2 * abcRadical (D.gap * D.sum) := by
    rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
      abcRadical_eq_natRadical]
    exact radical_mul_le_two_mul_radical_product
      D.gap_pos D.sum_pos D.gcd_gap_sum_dvd_two
  have hmul := Nat.mul_le_mul_right
    (abcRadical D.x * abcRadical D.y) hgap_sum
  rw [D.rootRadical_eq_factor_product,
    D.supportRadical_eq_factor_product]
  nlinarith

/-- Logarithmic fixed-overlap bound. -/
theorem log_rootRadical_add_log_sumRadical_le_log_supportRadical_add_log_two
    (D : Data) :
    Real.log (abcRadical (D.gap * D.x * D.y) : ℝ) +
        Real.log (abcRadical D.sum : ℝ) ≤
      Real.log (abcRadical ((D.gap * D.sum) * D.x * D.y) : ℝ) +
        Real.log 2 := by
  have hroot :
      0 < (abcRadical (D.gap * D.x * D.y) : ℝ) := by
    exact_mod_cast abcRadical_pos (D.gap * D.x * D.y)
  have hsum : 0 < (abcRadical D.sum : ℝ) := by
    exact_mod_cast abcRadical_pos D.sum
  have hsupport :
      0 < (abcRadical ((D.gap * D.sum) * D.x * D.y) : ℝ) := by
    exact_mod_cast abcRadical_pos ((D.gap * D.sum) * D.x * D.y)
  have hreal :
      (abcRadical (D.gap * D.x * D.y) : ℝ) *
          (abcRadical D.sum : ℝ) ≤
        2 * (abcRadical ((D.gap * D.sum) * D.x * D.y) : ℝ) := by
    exact_mod_cast D.rootRadical_mul_sumRadical_le_two_mul_supportRadical
  have hlog := Real.log_le_log (mul_pos hroot hsum) hreal
  rw [Real.log_mul hroot.ne' hsum.ne',
    Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hsupport.ne'] at hlog
  linarith

#print axioms radical_mul_le_gcd_mul_radical_product
#print axioms radical_mul_le_two_mul_radical_product
#print axioms Data.rootRadical_eq_factor_product
#print axioms Data.supportRadical_eq_factor_product
#print axioms Data.rootRadical_mul_sumRadical_le_two_mul_supportRadical
#print axioms Data.log_rootRadical_add_log_sumRadical_le_log_supportRadical_add_log_two

end SplitSquareArithmeticBridge.Data
end
end SplitSquareRadicalOverlap
end IUTThreeClosures
