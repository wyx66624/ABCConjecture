/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Odd-kernel and third-order localization for the balancing-Pell packet

The mathematical proofs precede this module in
`research/ABC_PELL_ODD_KERNEL_THIRD_ORDER_PACKET_2026_09_01.md`.

This file checks the reusable integer core:

* the cubic-square normal form of a finite squarefull factor packet;
* transport of the odd-exponent kernel through congruences;
* the quadratic-reciprocity steps used by the index--kernel triangle;
* the third-order expansion of an arbitrary finite product;
* cancellation to the quotient and the third-order two-channel coupling.

No existence or nonexistence assertion for a squarefull Pell packet is
assumed.
-/

namespace IUTThreeClosures
namespace PellOddKernelThirdOrderPacket20260901

/-! ## Cubic-square encoding of squarefull exponent vectors -/

/-- A squarefull exponent is either `2 + 2*tail` or `3 + 2*tail`.
The Boolean records whether it is odd. -/
structure SquarefullFactor where
  base : ℤ
  tail : ℕ
  oddDepth : Bool
deriving DecidableEq

def SquarefullFactor.exponent (f : SquarefullFactor) : ℕ :=
  if f.oddDepth then 3 + 2 * f.tail else 2 + 2 * f.tail

def SquarefullFactor.kernelTerm (f : SquarefullFactor) : ℤ :=
  if f.oddDepth then f.base else 1

def SquarefullFactor.coreTerm (f : SquarefullFactor) : ℤ :=
  f.base ^ (if f.oddDepth then f.tail else f.tail + 1)

def packetValue (fs : List SquarefullFactor) : ℤ :=
  (fs.map fun f => f.base ^ f.exponent).prod

def oddKernel (fs : List SquarefullFactor) : ℤ :=
  (fs.map SquarefullFactor.kernelTerm).prod

def squareCore (fs : List SquarefullFactor) : ℤ :=
  (fs.map SquarefullFactor.coreTerm).prod

/-- Each encoded squarefull prime power is its odd-kernel contribution
cubed times a square. -/
theorem factor_value_eq_kernel_cube_mul_core_square (f : SquarefullFactor) :
    f.base ^ f.exponent = f.kernelTerm ^ 3 * f.coreTerm ^ 2 := by
  cases h : f.oddDepth
  · simp only [SquarefullFactor.exponent, SquarefullFactor.kernelTerm,
      SquarefullFactor.coreTerm, h, Bool.false_eq_true, ↓reduceIte]
    rw [show 2 + 2 * f.tail = (f.tail + 1) + (f.tail + 1) by omega, pow_add]
    ring
  · simp only [SquarefullFactor.exponent, SquarefullFactor.kernelTerm,
      SquarefullFactor.coreTerm, h, ↓reduceIte]
    rw [show 3 + 2 * f.tail = 3 + f.tail + f.tail by omega, pow_add, pow_add]
    ring

/-- The complete finite packet has the canonical shape `D^3*C^2`. -/
theorem packetValue_eq_oddKernel_cube_mul_squareCore_square
    (fs : List SquarefullFactor) :
    packetValue fs = oddKernel fs ^ 3 * squareCore fs ^ 2 := by
  induction fs with
  | nil => simp [packetValue, oddKernel, squareCore]
  | cons f fs ih =>
      simp only [packetValue, oddKernel, squareCore] at ih
      simp only [packetValue, oddKernel, squareCore, List.map_cons, List.prod_cons]
      rw [factor_value_eq_kernel_cube_mul_core_square, ih]
      ring

/-- A factor marked as odd has an odd exponent at least three. -/
theorem odd_depth_exponent_packet (f : SquarefullFactor)
    (hodd : f.oddDepth = true) :
    Odd f.exponent ∧ 3 ≤ f.exponent := by
  simp only [SquarefullFactor.exponent, hodd, ↓reduceIte]
  constructor
  · refine ⟨f.tail + 1, ?_⟩
    omega
  · omega

/-! ## Congruence transport for the odd kernel -/

/-- If every base is one modulo `m`, so is the odd-exponent kernel. -/
theorem oddKernel_modEq_one (m : ℤ) (fs : List SquarefullFactor)
    (hbase : ∀ f ∈ fs, f.base ≡ 1 [ZMOD m]) :
    oddKernel fs ≡ 1 [ZMOD m] := by
  induction fs with
  | nil => simp [oddKernel]
  | cons f fs ih =>
      have hfmem : f ∈ f :: fs := by simp
      have htail : ∀ g ∈ fs, g.base ≡ 1 [ZMOD m] := by
        intro g hg
        exact hbase g (by simp [hg])
      have hi := ih htail
      have hf : f.kernelTerm ≡ 1 [ZMOD m] := by
        cases h : f.oddDepth
        · simp [SquarefullFactor.kernelTerm, h]
        · simpa [SquarefullFactor.kernelTerm, h] using hbase f hfmem
      simpa [oddKernel] using hf.mul hi

def oddSignProduct (sign : SquarefullFactor → ℤ)
    (fs : List SquarefullFactor) : ℤ :=
  (fs.map fun f => if f.oddDepth then sign f else 1).prod

/-- Base congruences with individual signs collapse, after parity reduction,
to the corresponding product over the odd-exponent kernel. -/
theorem oddKernel_modEq_oddSignProduct
    (m : ℤ) (sign : SquarefullFactor → ℤ) (fs : List SquarefullFactor)
    (hbase : ∀ f ∈ fs, f.base ≡ sign f [ZMOD m]) :
    oddKernel fs ≡ oddSignProduct sign fs [ZMOD m] := by
  induction fs with
  | nil => simp [oddKernel, oddSignProduct]
  | cons f fs ih =>
      have hfmem : f ∈ f :: fs := by simp
      have htail : ∀ g ∈ fs, g.base ≡ sign g [ZMOD m] := by
        intro g hg
        exact hbase g (by simp [hg])
      have hi := ih htail
      have hf : f.kernelTerm ≡ (if f.oddDepth then sign f else 1) [ZMOD m] := by
        cases h : f.oddDepth
        · simp [SquarefullFactor.kernelTerm, h]
        · simpa [SquarefullFactor.kernelTerm, h] using hbase f hfmem
      simpa [oddKernel, oddSignProduct] using hf.mul hi

/-- Once the kernel and the packet have the same sign modulo `m`, the square
core has square one modulo `m`. -/
theorem squareCore_sq_modEq_one_of_signed_packet
    (m s : ℤ) (fs : List SquarefullFactor)
    (hsign : s = 1 ∨ s = -1)
    (hkernel : oddKernel fs ≡ s [ZMOD m])
    (hvalue : packetValue fs ≡ s [ZMOD m]) :
    squareCore fs ^ 2 ≡ 1 [ZMOD m] := by
  have hpacket : oddKernel fs ^ 3 * squareCore fs ^ 2 ≡ s [ZMOD m] := by
    simpa [packetValue_eq_oddKernel_cube_mul_squareCore_square] using hvalue
  have hreplace : oddKernel fs ^ 3 * squareCore fs ^ 2 ≡
      s ^ 3 * squareCore fs ^ 2 [ZMOD m] :=
    (hkernel.pow 3).mul_right (squareCore fs ^ 2)
  have hsigned : s ^ 3 * squareCore fs ^ 2 ≡ s [ZMOD m] :=
    hreplace.symm.trans hpacket
  rcases hsign with rfl | rfl
  · simpa using hsigned
  · have hneg := hsigned.neg
    simpa using hneg

/-! ## Jacobi reciprocity steps for the index--kernel triangle -/

open scoped NumberTheorySymbols

/-- A numerator congruent to one has Jacobi symbol one. -/
theorem jacobi_eq_one_of_mod_eq_one (a b : ℕ) (hmod : a % b = 1) :
    J((a : ℤ) | b) = 1 := by
  have hz : (a : ℤ) % (b : ℤ) = 1 := by exact_mod_cast hmod
  calc
    J((a : ℤ) | b) = J(((a : ℤ) % b) | b) := jacobiSym.mod_left _ _
    _ = J(1 | b) := by rw [hz]
    _ = 1 := jacobiSym.one_left b

/-- If both odd arguments are `3 mod 4` and the forward symbol is one,
reciprocity makes the reverse symbol negative. -/
theorem jacobi_reverse_neg_of_both_three_mod_four
    (ell D : ℕ)
    (hell : ell % 4 = 3) (hD : D % 4 = 3)
    (hforward : J((D : ℤ) | ell) = 1) :
    J((ell : ℤ) | D) = -1 := by
  have hrec := jacobiSym.quadratic_reciprocity_three_mod_four hell hD
  rw [hforward] at hrec
  simpa using hrec

/-- A denominator `1 mod 4` introduces no reciprocity sign. -/
theorem jacobi_reverse_eq_of_denominator_one_mod_four
    (ell D : ℕ) (hellOdd : Odd ell) (hD : D % 4 = 1) :
    J((ell : ℤ) | D) = J((D : ℤ) | ell) :=
  jacobiSym.quadratic_reciprocity_one_mod_four' hellOdd hD

/-- The complete three-negative aggregate triangle forced in the
`ell = 3 mod 8` class, expressed at the exact Jacobi interface. -/
theorem three_negative_character_triangle
    (ell DA DB : ℕ)
    (hell3 : ell % 4 = 3)
    (hDA3 : DA % 4 = 3)
    (hDB1 : DB % 4 = 1)
    (hellOdd : Odd ell)
    (hDAForward : J((DA : ℤ) | ell) = 1)
    (hDBForward : J((DB : ℤ) | ell) = -1)
    (hCross : J((DA : ℤ) | DB) = -1) :
    J((DA : ℤ) | DB) = -1 ∧
      J((ell : ℤ) | DA) = -1 ∧
      J((ell : ℤ) | DB) = -1 := by
  refine ⟨hCross, jacobi_reverse_neg_of_both_three_mod_four ell DA hell3 hDA3
    hDAForward, ?_⟩
  rw [jacobi_reverse_eq_of_denominator_one_mod_four ell DB hellOdd hDB1]
  exact hDBForward

/-- The all-positive aggregate triangle in the `ell = 1 mod 8` class. -/
theorem all_positive_character_triangle
    (ell DA DB : ℕ)
    (hell1 : ell % 4 = 1)
    (hDAOdd : Odd DA) (hDB1 : DB % 4 = 1)
    (hellOdd : Odd ell)
    (hDAForward : J((DA : ℤ) | ell) = 1)
    (hDBForward : J((DB : ℤ) | ell) = 1)
    (hCross : J((DA : ℤ) | DB) = 1) :
    J((DA : ℤ) | DB) = 1 ∧
      J((ell : ℤ) | DA) = 1 ∧
      J((ell : ℤ) | DB) = 1 := by
  refine ⟨hCross, ?_, ?_⟩
  · rw [jacobiSym.quadratic_reciprocity_one_mod_four hell1 hDAOdd]
    exact hDAForward
  · rw [jacobi_reverse_eq_of_denominator_one_mod_four ell DB hellOdd hDB1]
    exact hDBForward

/-- The aggregate sign row in the `ell = 5 mod 8` class. -/
theorem cross_only_negative_character_triangle
    (ell DA DB : ℕ)
    (hell1 : ell % 4 = 1)
    (hDAOdd : Odd DA) (hDB1 : DB % 4 = 1)
    (hellOdd : Odd ell)
    (hDAForward : J((DA : ℤ) | ell) = 1)
    (hDBForward : J((DB : ℤ) | ell) = 1)
    (hCross : J((DA : ℤ) | DB) = -1) :
    J((DA : ℤ) | DB) = -1 ∧
      J((ell : ℤ) | DA) = 1 ∧
      J((ell : ℤ) | DB) = 1 := by
  refine ⟨hCross, ?_, ?_⟩
  · rw [jacobiSym.quadratic_reciprocity_one_mod_four hell1 hDAOdd]
    exact hDAForward
  · rw [jacobi_reverse_eq_of_denominator_one_mod_four ell DB hellOdd hDB1]
    exact hDBForward

/-- The aggregate sign row in the `ell = 7 mod 8` class. -/
theorem index_A_only_negative_character_triangle
    (ell DA DB : ℕ)
    (hell3 : ell % 4 = 3)
    (hDA3 : DA % 4 = 3) (hDB1 : DB % 4 = 1)
    (hellOdd : Odd ell)
    (hDAForward : J((DA : ℤ) | ell) = 1)
    (hDBForward : J((DB : ℤ) | ell) = 1)
    (hCross : J((DA : ℤ) | DB) = 1) :
    J((DA : ℤ) | DB) = 1 ∧
      J((ell : ℤ) | DA) = -1 ∧
      J((ell : ℤ) | DB) = 1 := by
  refine ⟨hCross, jacobi_reverse_neg_of_both_three_mod_four ell DA hell3 hDA3
    hDAForward, ?_⟩
  rw [jacobi_reverse_eq_of_denominator_one_mod_four ell DB hellOdd hDB1]
  exact hDBForward

/-! ## Third-order finite products and the coupled quotient ledger -/

/-- Degree-two elementary coefficient of `prod_i (1+x*t_i)`. -/
def pairCoefficient : List ℤ → ℤ
  | [] => 0
  | t :: ts => t * ts.sum + pairCoefficient ts

/-- Degree-three elementary coefficient of `prod_i (1+x*t_i)`. -/
def tripleCoefficient : List ℤ → ℤ
  | [] => 0
  | t :: ts => t * pairCoefficient ts + tripleCoefficient ts

/-- Truncation of an arbitrary finite product after the cubic term. -/
theorem product_one_add_thirdOrder (x : ℤ) (ts : List ℤ) :
    (ts.map fun t => 1 + x * t).prod ≡
      1 + x * ts.sum + x ^ 2 * pairCoefficient ts +
        x ^ 3 * tripleCoefficient ts [ZMOD x ^ 4] := by
  induction ts with
  | nil => simp [pairCoefficient, tripleCoefficient]
  | cons t ts ih =>
      have hmul := ih.mul_left (1 + x * t)
      have htruncate :
          (1 + x * t) *
              (1 + x * ts.sum + x ^ 2 * pairCoefficient ts +
                x ^ 3 * tripleCoefficient ts) ≡
            1 + x * (t + ts.sum) +
              x ^ 2 * (t * ts.sum + pairCoefficient ts) +
              x ^ 3 * (t * pairCoefficient ts + tripleCoefficient ts)
              [ZMOD x ^ 4] := by
        apply Int.modEq_of_dvd
        refine ⟨-(t * tripleCoefficient ts), ?_⟩
        ring
      simpa [pairCoefficient, tripleCoefficient] using hmul.trans htruncate

/-- Cancelling `x` turns a product expansion modulo `x^4` into a quotient
expansion modulo `x^3`. -/
theorem quotient_thirdOrder_of_product
    (x a : ℤ) (ts : List ℤ) (hx : x ≠ 0)
    (hprod : 1 + x * a = (ts.map fun t => 1 + x * t).prod) :
    a ≡ ts.sum + x * pairCoefficient ts + x ^ 2 * tripleCoefficient ts
      [ZMOD x ^ 3] := by
  have hfull :
      1 + x * a ≡
        1 + x * ts.sum + x ^ 2 * pairCoefficient ts +
          x ^ 3 * tripleCoefficient ts [ZMOD x ^ 4] := by
    rw [hprod]
    exact product_one_add_thirdOrder x ts
  apply Int.modEq_of_dvd
  rcases hfull.dvd with ⟨k, hk⟩
  refine ⟨k, ?_⟩
  have hcancel :
      x * (ts.sum + x * pairCoefficient ts +
          x ^ 2 * tripleCoefficient ts - a) =
        x * (x ^ 3 * k) := by
    calc
      x * (ts.sum + x * pairCoefficient ts +
          x ^ 2 * tripleCoefficient ts - a) =
          (1 + x * ts.sum + x ^ 2 * pairCoefficient ts +
            x ^ 3 * tripleCoefficient ts) - (1 + x * a) := by ring
      _ = x ^ 4 * k := hk
      _ = x * (x ^ 3 * k) := by ring
  exact mul_left_cancel₀ hx hcancel

/-- Transfer of the two third-order channel congruences through the exact
negative-Pell quotient conic. -/
theorem thirdOrderCoupling_of_channelCongruences
    (ell a b KA KB CA CB HA HB : ℤ)
    (ha : a ≡ KA + 2 * ell * CA + 4 * ell ^ 2 * HA [ZMOD 8 * ell ^ 3])
    (hb : b ≡ KB + 2 * ell * CB + 4 * ell ^ 2 * HB [ZMOD 8 * ell ^ 3])
    (hExact : a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2) = 0) :
    KA - 2 * KB + ell * (KA ^ 2 - 2 * KB ^ 2) +
        2 * ell * (CA - 2 * CB) +
        4 * ell ^ 2 * (HA - 2 * HB + KA * CA - 2 * KB * CB) +
        4 * ell ^ 3 * (CA ^ 2 - 2 * CB ^ 2) ≡ 0 [ZMOD 8 * ell ^ 3] := by
  let a0 := KA + 2 * ell * CA + 4 * ell ^ 2 * HA
  let b0 := KB + 2 * ell * CB + 4 * ell ^ 2 * HB
  have hlinear : a - 2 * b ≡ a0 - 2 * b0 [ZMOD 8 * ell ^ 3] :=
    ha.sub (hb.mul_left 2)
  have hquadratic :
      ell * (a ^ 2 - 2 * b ^ 2) ≡
        ell * (a0 ^ 2 - 2 * b0 ^ 2) [ZMOD 8 * ell ^ 3] :=
    ((ha.pow 2).sub ((hb.pow 2).mul_left 2)).mul_left ell
  have hsum := hlinear.add hquadratic
  have htruncate :
      a0 - 2 * b0 + ell * (a0 ^ 2 - 2 * b0 ^ 2) ≡
        KA - 2 * KB + ell * (KA ^ 2 - 2 * KB ^ 2) +
          2 * ell * (CA - 2 * CB) +
          4 * ell ^ 2 * (HA - 2 * HB + KA * CA - 2 * KB * CB) +
          4 * ell ^ 3 * (CA ^ 2 - 2 * CB ^ 2)
          [ZMOD 8 * ell ^ 3] := by
    apply Int.modEq_of_dvd
    refine ⟨-((KA * HA - 2 * KB * HB) +
      2 * ell * (CA * HA - 2 * CB * HB) +
      2 * ell ^ 2 * (HA ^ 2 - 2 * HB ^ 2)), ?_⟩
    dsimp [a0, b0]
    ring
  have hzero :
      a - 2 * b + ell * (a ^ 2 - 2 * b ^ 2) ≡ 0
        [ZMOD 8 * ell ^ 3] := by
    rw [hExact]
  exact htruncate.symm.trans (hsum.symm.trans hzero)

/-- Complete third-order coefficient certificate at index seven:
`T_A=[17]` and `T_B=[-1,-1]`. -/
theorem indexSeven_thirdOrderCoefficientCertificate :
    ([17].sum, pairCoefficient [17], tripleCoefficient [17],
      ([-1, -1] : List ℤ).sum, pairCoefficient [-1, -1],
      tripleCoefficient [-1, -1]) =
      ((17 : ℤ), 0, 0, -2, 1, 0) := by
  norm_num [pairCoefficient, tripleCoefficient]

/-- The resulting third-order coupling is exact, hence in particular zero
modulo `8*7^3`. -/
theorem indexSeven_thirdOrderCouplingCertificate :
    (17 : ℤ) - 2 * (-2) + 7 * (17 ^ 2 - 2 * (-2) ^ 2) +
        2 * 7 * (0 - 2 * 1) +
        4 * 7 ^ 2 * (0 - 2 * 0 + 17 * 0 - 2 * (-2) * 1) +
        4 * 7 ^ 3 * (0 ^ 2 - 2 * 1 ^ 2) ≡ 0 [ZMOD 8 * 7 ^ 3] := by
  norm_num [Int.ModEq]

#check packetValue_eq_oddKernel_cube_mul_squareCore_square
#check factor_value_eq_kernel_cube_mul_core_square
#check odd_depth_exponent_packet
#check oddKernel_modEq_one
#check oddKernel_modEq_oddSignProduct
#check squareCore_sq_modEq_one_of_signed_packet
#check jacobi_eq_one_of_mod_eq_one
#check jacobi_reverse_neg_of_both_three_mod_four
#check jacobi_reverse_eq_of_denominator_one_mod_four
#check three_negative_character_triangle
#check all_positive_character_triangle
#check cross_only_negative_character_triangle
#check index_A_only_negative_character_triangle
#check product_one_add_thirdOrder
#check quotient_thirdOrder_of_product
#check thirdOrderCoupling_of_channelCongruences
#check indexSeven_thirdOrderCoefficientCertificate
#check indexSeven_thirdOrderCouplingCertificate

#print axioms packetValue_eq_oddKernel_cube_mul_squareCore_square
#print axioms factor_value_eq_kernel_cube_mul_core_square
#print axioms odd_depth_exponent_packet
#print axioms oddKernel_modEq_one
#print axioms oddKernel_modEq_oddSignProduct
#print axioms squareCore_sq_modEq_one_of_signed_packet
#print axioms jacobi_eq_one_of_mod_eq_one
#print axioms jacobi_reverse_neg_of_both_three_mod_four
#print axioms jacobi_reverse_eq_of_denominator_one_mod_four
#print axioms three_negative_character_triangle
#print axioms all_positive_character_triangle
#print axioms cross_only_negative_character_triangle
#print axioms index_A_only_negative_character_triangle
#print axioms product_one_add_thirdOrder
#print axioms quotient_thirdOrder_of_product
#print axioms thirdOrderCoupling_of_channelCongruences
#print axioms indexSeven_thirdOrderCoefficientCertificate
#print axioms indexSeven_thirdOrderCouplingCertificate

end PellOddKernelThirdOrderPacket20260901
end IUTThreeClosures
