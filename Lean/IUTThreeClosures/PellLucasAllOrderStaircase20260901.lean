/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# All-order Pell--Lucas support-unit staircases

The mathematical proofs precede this file in
`research/ABC_PELL_LUCAS_ALL_ORDER_STAIRCASE_2026_09_01.md`.

This module checks the reusable algebraic and finite core:

* splitting an even-power multiplication polynomial into a prefix and tail;
* preservation of Bezout coprimality in every normalized tail;
* the small-factor argument making an integral multiplication coefficient a
  unit at a larger prime;
* correlation of the `u` and companion-`v` fourth-order corrections;
* the two channel signs and the resulting square root of one;
* the logical refutation of fixed-zero rigidity from full local
  surjectivity;
* a kernel-reduced modular recurrence certificate for the actual
  `n=3, s=5, t=1, k=2451` counterexample.

The external all-orders Lucas multiplication theorem and Pell rank theorem
are never introduced as axioms.  Their outputs occur only as explicit
hypotheses of the algebraic results below.
-/

namespace IUTThreeClosures
namespace PellLucasAllOrderStaircase20260901

/-! ## Even-power polynomial tails -/

/-- Horner form of `sum_i a_i U^(2*i)`. -/
def evenPowerSum (U : ℤ) : List ℤ → ℤ
  | [] => 0
  | a :: as => a + U ^ 2 * evenPowerSum U as

/-- Appending coefficient packets separates a prefix from a shifted tail. -/
theorem evenPowerSum_append (U : ℤ) (as bs : List ℤ) :
    evenPowerSum U (as ++ bs) =
      evenPowerSum U as + U ^ (2 * as.length) * evenPowerSum U bs := by
  induction as with
  | nil => simp [evenPowerSum]
  | cons a as ih =>
      simp only [List.cons_append, evenPowerSum, List.length_cons]
      rw [ih]
      rw [show 2 * (as.length + 1) = 2 + 2 * as.length by omega, pow_add]
      ring

/-- Adding a multiple of `U^2` to a coefficient preserves its Bezout
coprimality with `U`. -/
theorem coprime_add_square_tail (U a h : ℤ) (ha : IsCoprime a U) :
    IsCoprime (a + U ^ 2 * h) U := by
  rcases ha with ⟨x, y, hxy⟩
  refine ⟨x, y - x * U * h, ?_⟩
  calc
    x * (a + U ^ 2 * h) + (y - x * U * h) * U =
        x * a + y * U := by ring
    _ = 1 := hxy

/-- A normalized nonempty all-order tail is a support unit as soon as its
leading coefficient is. -/
theorem evenPowerSum_coprime_of_leading
    (U a : ℤ) (as : List ℤ) (ha : IsCoprime a U) :
    IsCoprime (evenPowerSum U (a :: as)) U := by
  simpa [evenPowerSum] using
    coprime_add_square_tail U a (evenPowerSum U as) ha

/-- No nonunit divisor of `U` divides a normalized tail with a coprime
leading coefficient.  This is the divisibility form of the exact valuation
statement in the paper. -/
theorem support_not_dvd_normalized_tail
    (U a p : ℤ) (as : List ℤ)
    (ha : IsCoprime a U) (hpU : p ∣ U) (hpOne : ¬p ∣ (1 : ℤ)) :
    ¬p ∣ evenPowerSum U (a :: as) := by
  have hcop := evenPowerSum_coprime_of_leading U a as ha
  intro hpTail
  rcases hcop with ⟨x, y, hbezout⟩
  apply hpOne
  rw [← hbezout]
  exact dvd_add (dvd_mul_of_dvd_right hpTail x)
    (dvd_mul_of_dvd_right hpU y)

/-! ## The larger-prime coefficient argument -/

/-- A prime larger than every positive factor cannot divide their product. -/
theorem prime_not_dvd_list_prod_of_small
    (p : ℕ) (hp : p.Prime) (fs : List ℕ)
    (hsmall : ∀ x ∈ fs, 0 < x ∧ x < p) :
    ¬p ∣ fs.prod := by
  induction fs with
  | nil => simpa using hp.not_dvd_one
  | cons x xs ih =>
      have hx := hsmall x (by simp)
      have htail : ∀ y ∈ xs, 0 < y ∧ y < p := by
        intro y hy
        exact hsmall y (by simp [hy])
      intro hdiv
      rcases hp.dvd_mul.mp hdiv with hpx | hptail
      · exact (Nat.not_dvd_of_pos_of_lt hx.1 hx.2) hpx
      · exact (ih htail) hptail

/-- If an integral coefficient times its denominator is a product of
positive factors all smaller than `p`, then `p` cannot divide the
coefficient.  In the Pell specialization these factors are
`ell`, `ell-(2*j-1)`, and `ell+(2*j-1)`. -/
theorem integral_coefficient_not_dvd_of_small_numerator
    (p ell denominator c : ℕ) (fs : List ℕ)
    (hp : p.Prime)
    (hell : 0 < ell ∧ ell < p)
    (hsmall : ∀ x ∈ fs, 0 < x ∧ x < p)
    (hcoeff : denominator * c = ell * fs.prod) :
    ¬p ∣ c := by
  intro hpc
  have hnum : p ∣ ell * fs.prod := by
    rw [← hcoeff]
    exact dvd_mul_of_dvd_right hpc denominator
  rcases hp.dvd_mul.mp hnum with hpell | hpprod
  · exact (Nat.not_dvd_of_pos_of_lt hell.1 hell.2) hpell
  · exact prime_not_dvd_list_prod_of_small p hp fs hsmall hpprod

/-! ## Paired fourth-order corrections and channel signs -/

/-- If the two leading correction coefficients obey `ell*d=3*c`, the
normalized `u` and companion corrections obey the paired congruence. -/
theorem paired_correction_modEq
    (U ell v W S c d : ℤ)
    (hW : W ≡ c [ZMOD U ^ 2])
    (hS : S ≡ v * d [ZMOD U ^ 2])
    (hcoeff : ell * d = 3 * c) :
    ell * S ≡ 3 * v * W [ZMOD U ^ 2] := by
  calc
    ell * S ≡ ell * (v * d) [ZMOD U ^ 2] := hS.mul_left ell
    _ = v * (ell * d) := by ring
    _ = v * (3 * c) := by rw [hcoeff]
    _ = 3 * v * c := by ring
    _ ≡ 3 * v * W [ZMOD U ^ 2] := (hW.mul_left (3 * v)).symm

/-- The two channel squares divide the square of their product. -/
theorem channel_square_divisors (U A B : ℤ) (hU : U = A * B) :
    A ^ 2 ∣ U ^ 2 ∧ B ^ 2 ∣ U ^ 2 := by
  constructor
  · refine ⟨B ^ 2, ?_⟩
    rw [hU]
    ring
  · refine ⟨A ^ 2, ?_⟩
    rw [hU]
    ring

/-- The exact companion identity `v=4*A^2+2` gives the positive channel
sign. -/
theorem companion_mod_A (v A : ℤ) (hv : v = 4 * A ^ 2 + 2) :
    v ≡ 2 [ZMOD A ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨-4, ?_⟩
  rw [hv]
  ring

/-- The exact companion identity `v=8*B^2-2` gives the negative channel
sign. -/
theorem companion_mod_B (v B : ℤ) (hv : v = 8 * B ^ 2 - 2) :
    v ≡ -2 [ZMOD B ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨-8, ?_⟩
  rw [hv]
  ring

/-- Reduction of the paired correction to the positive channel. -/
theorem channel_A_sign
    (U A ell v W S : ℤ)
    (hAdiv : A ^ 2 ∣ U ^ 2)
    (hpair : ell * S ≡ 3 * v * W [ZMOD U ^ 2])
    (hvA : v ≡ 2 [ZMOD A ^ 2]) :
    ell * S ≡ 6 * W [ZMOD A ^ 2] := by
  have hp := Int.ModEq.of_dvd hAdiv hpair
  have hv : 3 * v * W ≡ 6 * W [ZMOD A ^ 2] := by
    have h := (hvA.mul_left 3).mul_right W
    calc
      3 * v * W = 3 * (v * W) := by ring
      _ ≡ 6 * W [ZMOD A ^ 2] := by simpa [mul_assoc] using h
  exact hp.trans hv

/-- Reduction of the paired correction to the negative channel. -/
theorem channel_B_sign
    (U B ell v W S : ℤ)
    (hBdiv : B ^ 2 ∣ U ^ 2)
    (hpair : ell * S ≡ 3 * v * W [ZMOD U ^ 2])
    (hvB : v ≡ -2 [ZMOD B ^ 2]) :
    ell * S ≡ -6 * W [ZMOD B ^ 2] := by
  have hp := Int.ModEq.of_dvd hBdiv hpair
  have hv : 3 * v * W ≡ -6 * W [ZMOD B ^ 2] := by
    have h := (hvB.mul_left 3).mul_right W
    calc
      3 * v * W ≡ (3 * (-2)) * W [ZMOD B ^ 2] := h
      _ = -6 * W := by ring
  exact hp.trans hv

/-- The exact two-channel splitter derived from the companion identities. -/
theorem paired_correction_channel_splitter
    (U A B ell v W S : ℤ)
    (hU : U = A * B)
    (hvA : v = 4 * A ^ 2 + 2)
    (hvB : v = 8 * B ^ 2 - 2)
    (hpair : ell * S ≡ 3 * v * W [ZMOD U ^ 2]) :
    ell * S ≡ 6 * W [ZMOD A ^ 2] ∧
      ell * S ≡ -6 * W [ZMOD B ^ 2] := by
  rcases channel_square_divisors U A B hU with ⟨hA, hB⟩
  exact ⟨channel_A_sign U A ell v W S hA hpair
      (companion_mod_A v A hvA),
    channel_B_sign U B ell v W S hB hpair
      (companion_mod_B v B hvB)⟩

/-! ## Cancellation and the reconstructed square root of one -/

/-- A factor coprime to the modulus cancels from a modular equality. -/
theorem cancel_coprime_factor_modEq
    (m c x y : ℤ) (hc : IsCoprime c m)
    (h : c * x ≡ c * y [ZMOD m]) : x ≡ y [ZMOD m] := by
  apply Int.modEq_of_dvd
  have hd : m ∣ c * (y - x) := by
    simpa [mul_sub] using h.dvd
  apply hc.symm.dvd_of_dvd_mul_right
  simpa [mul_comm] using hd

/-- Separate coprimality of `6` and `W` with `U` makes `6*W` a unit
modulo `U^2`. -/
theorem six_mul_tail_unit_mod_square
    (U W : ℤ) (h6 : IsCoprime 6 U) (hW : IsCoprime W U) :
    IsCoprime (6 * W) (U ^ 2) :=
  (h6.mul_left hW).pow_right

/-- Dividing the paired correction by its support unit recovers the half
companion residue. -/
theorem splitter_recovers_half_companion
    (U ell v W S Z Z0 : ℤ)
    (hv : v = 2 * Z0)
    (hunit : IsCoprime (6 * W) (U ^ 2))
    (hpair : ell * S ≡ 3 * v * W [ZMOD U ^ 2])
    (hZ : 6 * W * Z ≡ ell * S [ZMOD U ^ 2]) :
    Z ≡ Z0 [ZMOD U ^ 2] := by
  have hright : ell * S ≡ 6 * W * Z0 [ZMOD U ^ 2] := by
    calc
      ell * S ≡ 3 * v * W [ZMOD U ^ 2] := hpair
      _ = 6 * W * Z0 := by rw [hv]; ring
  have hmul : (6 * W) * Z ≡ (6 * W) * Z0 [ZMOD U ^ 2] :=
    hZ.trans hright
  exact cancel_coprime_factor_modEq (U ^ 2) (6 * W) Z Z0 hunit hmul

/-- Opposite signs on two coprime channel squares combine to a square root
of one modulo the complete product square. -/
theorem channel_signs_give_square_root
    (A B U Z : ℤ)
    (hU : U = A * B)
    (hAB : IsCoprime A B)
    (hZA : Z ≡ 1 [ZMOD A ^ 2])
    (hZB : Z ≡ -1 [ZMOD B ^ 2]) :
    Z ^ 2 ≡ 1 [ZMOD U ^ 2] := by
  have hA : Z ^ 2 ≡ 1 [ZMOD A ^ 2] := by
    simpa using hZA.pow 2
  have hB : Z ^ 2 ≡ 1 [ZMOD B ^ 2] := by
    simpa using hZB.pow 2
  have hcop : IsCoprime (A ^ 2) (B ^ 2) := hAB.pow_left.pow_right
  have hd : A ^ 2 * B ^ 2 ∣ 1 - Z ^ 2 :=
    hcop.mul_dvd hA.dvd hB.dvd
  apply Int.modEq_of_dvd
  rw [hU]
  simpa [mul_pow] using hd

/-! ## Exact logical boundary of local surjectivity -/

/-- Full local surjectivity, including all admissibility premises, refutes
the assertion that every admissible correction is zero.  It refutes only
this exact fixed-zero claim. -/
theorem no_fixed_zero_of_full_local_surjectivity
    (s : ℤ) (Admissible : ℤ → Prop) (corr : ℤ → ℤ)
    (hsurj : ∀ c : ℤ, ∃ k : ℤ,
      Admissible k ∧ corr k ≡ c [ZMOD s])
    (hone : ¬(1 : ℤ) ≡ 0 [ZMOD s]) :
    ¬∀ k : ℤ, Admissible k → corr k ≡ 0 [ZMOD s] := by
  intro hrigid
  rcases hsurj 1 with ⟨k, hk, hcorr⟩
  exact hone (hcorr.symm.trans (hrigid k hk))

/-! ## Kernel-reduced actual recurrence certificate -/

/-- The norm-one Lucas recurrence over an arbitrary ring. -/
def lucasU {R : Type*} [Ring R] : ℕ → R
  | 0 => 0
  | 1 => 1
  | n + 2 => 6 * lucasU (n + 1) - lucasU n

/-- Companion matrix for `u_(n+2)=6*u_(n+1)-u_n`. -/
def lucasMatrix (R : Type*) [CommRing R] :
    Matrix (Fin 2) (Fin 2) R :=
  !![(6 : R), -1; 1, 0]

/-- The first column of the companion power contains two consecutive Lucas
terms. -/
theorem lucasMatrix_firstColumn
    {R : Type*} [CommRing R] (n : ℕ) :
    (lucasMatrix R ^ n) 0 0 = lucasU (R := R) (n + 1) ∧
    (lucasMatrix R ^ n) 1 0 = lucasU (R := R) n := by
  induction n with
  | zero => simp [lucasMatrix, lucasU]
  | succ n ih =>
      rw [pow_succ']
      simp only [Matrix.mul_apply, Fin.sum_univ_two]
      rcases ih with ⟨ih0, ih1⟩
      constructor
      · rw [show (lucasMatrix R) 0 0 = 6 by simp [lucasMatrix],
            show (lucasMatrix R) 0 1 = -1 by simp [lucasMatrix], ih0, ih1]
        simp only [lucasU]
        ring
      · rw [show (lucasMatrix R) 1 0 = 1 by simp [lucasMatrix],
            show (lucasMatrix R) 1 1 = 0 by simp [lucasMatrix], ih0]
        simp

/-- The lower-left companion entry is the Lucas term. -/
theorem lucasMatrix_entry
    {R : Type*} [CommRing R] (n : ℕ) :
    (lucasMatrix R ^ n) 1 0 = lucasU (R := R) n :=
  (lucasMatrix_firstColumn n).2

set_option maxHeartbeats 0 in
-- Kernel reduction of the displayed index 7353 recurrence needs an unbounded
-- heartbeat budget; this is a finite `decide` certificate, not `native_decide`.
set_option maxRecDepth 170000 in
-- The same kernel computation expands a deeply nested binary matrix power.
theorem u7353_mod_214375_certificate :
    lucasU (R := ZMod 214375) 7353 = (85785 : ZMod 214375) := by
  rw [← lucasMatrix_entry]
  decide

/-- The remaining arithmetic in the fixed-zero counterexample: `k=2451`
is positive odd and congruent to one modulo `35^2`, while the frozen
quotient residue has normalized correction two modulo five. -/
theorem fixedZeroCounterexample_arithmetic :
    (2451 : ℤ) = 1 + 2 * 35 ^ 2 ∧
      0 < (2451 : ℤ) ∧ Odd (2451 : ℤ) ∧
      (85785 : ℤ) = 35 * 2451 ∧
      (2451 - 1) / 35 ^ 2 = 2 ∧
      ¬(2 : ℤ) ≡ 0 [ZMOD 5] := by
  norm_num [Int.ModEq, Odd]

#check evenPowerSum_append
#check coprime_add_square_tail
#check evenPowerSum_coprime_of_leading
#check support_not_dvd_normalized_tail
#check prime_not_dvd_list_prod_of_small
#check integral_coefficient_not_dvd_of_small_numerator
#check paired_correction_modEq
#check channel_square_divisors
#check companion_mod_A
#check companion_mod_B
#check paired_correction_channel_splitter
#check cancel_coprime_factor_modEq
#check six_mul_tail_unit_mod_square
#check splitter_recovers_half_companion
#check channel_signs_give_square_root
#check no_fixed_zero_of_full_local_surjectivity
#check lucasMatrix_firstColumn
#check lucasMatrix_entry
#check u7353_mod_214375_certificate
#check fixedZeroCounterexample_arithmetic

#print axioms evenPowerSum_append
#print axioms coprime_add_square_tail
#print axioms evenPowerSum_coprime_of_leading
#print axioms support_not_dvd_normalized_tail
#print axioms prime_not_dvd_list_prod_of_small
#print axioms integral_coefficient_not_dvd_of_small_numerator
#print axioms paired_correction_modEq
#print axioms channel_square_divisors
#print axioms companion_mod_A
#print axioms companion_mod_B
#print axioms paired_correction_channel_splitter
#print axioms cancel_coprime_factor_modEq
#print axioms six_mul_tail_unit_mod_square
#print axioms splitter_recovers_half_companion
#print axioms channel_signs_give_square_root
#print axioms no_fixed_zero_of_full_local_surjectivity
#print axioms lucasMatrix_firstColumn
#print axioms lucasMatrix_entry
#print axioms u7353_mod_214375_certificate
#print axioms fixedZeroCounterexample_arithmetic

end PellLucasAllOrderStaircase20260901
end IUTThreeClosures
