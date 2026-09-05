/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# The actual arithmetic bridge in the split-square branch

Let `0 < x < y` with `gcd(x,y)=1`, and put

`d = y-x`, `s = y+x`.

Then

`d*s + x^2 = y^2`

is a primitive abc equation, while

`d+x=y`

is the associated primitive root triple.  The four linear factors satisfy

* `d` and `x`, `d` and `y`, `s` and `x`, `s` and `y` are coprime;
* `gcd(d,s)` divides two;
* the radical of the root triple divides the radical of the square triple.

This supplies actual integer objects for the scalar split-square descent.  No
ABC estimate or radical-growth statement is assumed.
-/

namespace IUTThreeClosures
namespace SplitSquareArithmeticBridge

noncomputable section

/-- Primitive coprime roots underlying a split-square abc point. -/
structure Data where
  x : ℕ
  y : ℕ
  x_pos : 0 < x
  x_lt_y : x < y
  coprime : Nat.Coprime x y

namespace Data

/-- Difference of the square roots. -/
def gap (D : Data) : ℕ := D.y - D.x

/-- Sum of the square roots. -/
def sum (D : Data) : ℕ := D.y + D.x

@[simp]
theorem gap_pos (D : Data) : 0 < D.gap := by
  unfold gap
  omega

@[simp]
theorem sum_pos (D : Data) : 0 < D.sum := by
  unfold sum
  omega

/-- The root gap reconstructs the larger root. -/
theorem gap_add_x_eq_y (D : Data) : D.gap + D.x = D.y := by
  unfold gap
  omega

/-- The sum is the gap plus twice the smaller root. -/
theorem gap_add_two_mul_x_eq_sum (D : Data) :
    D.gap + 2 * D.x = D.sum := by
  unfold gap sum
  omega

/-- The gap plus the sum is twice the larger root. -/
theorem gap_add_sum_eq_two_mul_y (D : Data) :
    D.gap + D.sum = 2 * D.y := by
  unfold gap sum
  omega

/-- Difference-of-squares identity in natural numbers. -/
theorem gap_mul_sum_add_x_sq_eq_y_sq (D : Data) :
    D.gap * D.sum + D.x ^ 2 = D.y ^ 2 := by
  have hsub : ((D.y - D.x : ℕ) : ℤ) = (D.y : ℤ) - D.x := by
    omega
  have hint :
      (((D.gap * D.sum + D.x ^ 2 : ℕ) : ℤ)) =
        ((D.y ^ 2 : ℕ) : ℤ) := by
    unfold gap sum
    push_cast [hsub]
    ring
  exact_mod_cast hint

/-- A common divisor of the gap and the smaller root also divides the larger
root, hence is one. -/
theorem gap_coprime_x (D : Data) : Nat.Coprime D.gap D.x := by
  rw [Nat.coprime_iff_gcd_eq_one]
  apply Nat.eq_one_of_dvd_coprimes D.coprime
  · exact Nat.gcd_dvd_right D.gap D.x
  · rw [← D.gap_add_x_eq_y]
    exact Nat.dvd_add
      (Nat.gcd_dvd_left D.gap D.x)
      (Nat.gcd_dvd_right D.gap D.x)

/-- The gap is also coprime to the larger root. -/
theorem gap_coprime_y (D : Data) : Nat.Coprime D.gap D.y := by
  rw [Nat.coprime_iff_gcd_eq_one]
  apply Nat.eq_one_of_dvd_coprimes D.coprime
  · have hy : Nat.gcd D.gap D.y ∣ D.y :=
      Nat.gcd_dvd_right D.gap D.y
    rw [← D.gap_add_x_eq_y] at hy
    exact (Nat.dvd_add_iff_right
      (Nat.gcd_dvd_left D.gap D.y)).mp hy
  · exact Nat.gcd_dvd_right D.gap D.y

/-- The sum of the roots is coprime to the smaller root. -/
theorem sum_coprime_x (D : Data) : Nat.Coprime D.sum D.x := by
  rw [Nat.coprime_iff_gcd_eq_one]
  apply Nat.eq_one_of_dvd_coprimes D.coprime
  · exact Nat.gcd_dvd_right D.sum D.x
  · have hs : Nat.gcd D.sum D.x ∣ D.y + D.x := by
      simpa [sum] using Nat.gcd_dvd_left D.sum D.x
    exact (Nat.dvd_add_iff_left
      (Nat.gcd_dvd_right D.sum D.x)).mp hs

/-- The sum of the roots is coprime to the larger root. -/
theorem sum_coprime_y (D : Data) : Nat.Coprime D.sum D.y := by
  rw [Nat.coprime_iff_gcd_eq_one]
  apply Nat.eq_one_of_dvd_coprimes D.coprime
  · have hs : Nat.gcd D.sum D.y ∣ D.y + D.x := by
      simpa [sum, Nat.add_comm] using Nat.gcd_dvd_left D.sum D.y
    exact (Nat.dvd_add_iff_right
      (Nat.gcd_dvd_right D.sum D.y)).mp hs
  · exact Nat.gcd_dvd_right D.sum D.y

/-- The only possible common prime of the root gap and root sum is two. -/
theorem gcd_gap_sum_dvd_two (D : Data) :
    Nat.gcd D.gap D.sum ∣ 2 := by
  have hg2x : Nat.gcd D.gap D.sum ∣ 2 * D.x := by
    have hs := Nat.gcd_dvd_right D.gap D.sum
    rw [← D.gap_add_two_mul_x_eq_sum] at hs
    exact (Nat.dvd_add_iff_right
      (Nat.gcd_dvd_left D.gap D.sum)).mp hs
  have hg2y : Nat.gcd D.gap D.sum ∣ 2 * D.y := by
    rw [← D.gap_add_sum_eq_two_mul_y]
    exact Nat.dvd_add
      (Nat.gcd_dvd_left D.gap D.sum)
      (Nat.gcd_dvd_right D.gap D.sum)
  have hgcd :
      Nat.gcd D.gap D.sum ∣ Nat.gcd (2 * D.x) (2 * D.y) :=
    Nat.dvd_gcd hg2x hg2y
  have hxy : Nat.gcd D.x D.y = 1 := D.coprime
  simpa [Nat.gcd_mul_left, hxy] using hgcd

/-- The product `d*s` is coprime to the smaller root. -/
theorem gap_mul_sum_coprime_x (D : Data) :
    Nat.Coprime (D.gap * D.sum) D.x :=
  D.gap_coprime_x.mul_left D.sum_coprime_x

/-- The product `d*s` is coprime to the larger root. -/
theorem gap_mul_sum_coprime_y (D : Data) :
    Nat.Coprime (D.gap * D.sum) D.y :=
  D.gap_coprime_y.mul_left D.sum_coprime_y

/-- The primitive root triple `d+x=y`. -/
def rootPoint (D : Data) : ABCPoint where
  a := D.gap
  b := D.x
  c := D.y
  a_pos := D.gap_pos
  b_pos := D.x_pos
  c_pos := lt_trans D.x_pos D.x_lt_y
  sum_eq := D.gap_add_x_eq_y
  pairwise_coprime :=
    ⟨D.gap_coprime_x, D.coprime, D.gap_coprime_y.symm⟩

/-- The primitive split-square triple `d*s+x^2=y^2`. -/
def squarePoint (D : Data) : ABCPoint where
  a := D.gap * D.sum
  b := D.x ^ 2
  c := D.y ^ 2
  a_pos := mul_pos D.gap_pos D.sum_pos
  b_pos := pow_pos D.x_pos 2
  c_pos := pow_pos (lt_trans D.x_pos D.x_lt_y) 2
  sum_eq := D.gap_mul_sum_add_x_sq_eq_y_sq
  pairwise_coprime := by
    refine ⟨?_, ?_, ?_⟩
    · exact D.gap_mul_sum_coprime_x.pow_right 2
    · exact D.coprime.pow_left 2 |>.pow_right 2
    · exact (D.gap_mul_sum_coprime_y.pow_right 2).symm

/-- The root-triple product divides the split-square abc product. -/
theorem rootProduct_dvd_squareProduct (D : Data) :
    D.gap * D.x * D.y ∣
      (D.gap * D.sum) * D.x ^ 2 * D.y ^ 2 := by
  refine ⟨D.sum * D.x * D.y, ?_⟩
  ring

/-- Consequently, the root radical divides the split-square radical. -/
theorem rootRadical_dvd_squareRadical (D : Data) :
    abcRadical (D.gap * D.x * D.y) ∣
      abcRadical ((D.gap * D.sum) * D.x ^ 2 * D.y ^ 2) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  apply radical_dvd_radical D.rootProduct_dvd_squareProduct
  exact (mul_pos
    (mul_pos (mul_pos D.gap_pos D.sum_pos) (pow_pos D.x_pos 2))
    (pow_pos (lt_trans D.x_pos D.x_lt_y) 2)).ne'

/-- Numerical radical monotonicity between the root and square triples. -/
theorem rootRadical_le_squareRadical (D : Data) :
    abcRadical (D.gap * D.x * D.y) ≤
      abcRadical ((D.gap * D.sum) * D.x ^ 2 * D.y ^ 2) :=
  Nat.le_of_dvd
    (abcRadical_pos ((D.gap * D.sum) * D.x ^ 2 * D.y ^ 2))
    D.rootRadical_dvd_squareRadical

/-- The conductor of the root triple does not exceed that of the split-square
triple. -/
theorem rootPoint_conductor_le_squarePoint_conductor (D : Data) :
    D.rootPoint.conductor ≤ D.squarePoint.conductor := by
  unfold ABCPoint.conductor rootPoint squarePoint
  apply Real.log_le_log
  · exact_mod_cast abcRadical_pos (D.gap * D.x * D.y)
  · exact_mod_cast D.rootRadical_le_squareRadical

/-- The root point has logarithmic height `log y`. -/
theorem rootPoint_height_eq_log_y (D : Data) :
    D.rootPoint.height = Real.log (D.y : ℝ) := by
  exact D.rootPoint.height_eq_log_c

/-- The split-square point has twice the root height. -/
theorem squarePoint_height_eq_two_log_y (D : Data) :
    D.squarePoint.height = 2 * Real.log (D.y : ℝ) := by
  rw [D.squarePoint.height_eq_log_c]
  change Real.log (((D.y ^ 2 : ℕ) : ℝ)) = _
  push_cast
  rw [Real.log_pow]
  norm_num

#print axioms Data.gap_mul_sum_add_x_sq_eq_y_sq
#print axioms Data.gap_coprime_x
#print axioms Data.gap_coprime_y
#print axioms Data.sum_coprime_x
#print axioms Data.sum_coprime_y
#print axioms Data.gcd_gap_sum_dvd_two
#print axioms Data.rootPoint
#print axioms Data.squarePoint
#print axioms Data.rootRadical_dvd_squareRadical
#print axioms Data.rootPoint_conductor_le_squarePoint_conductor
#print axioms Data.squarePoint_height_eq_two_log_y

end Data
end
end SplitSquareArithmeticBridge
end IUTThreeClosures
