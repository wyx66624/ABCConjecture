/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MovingPellApproximationIdentity
import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic

/-!
# Local quadratic-residue constraints on a concrete moving Pell witness

For a primitive squarefree moving conic

`w*z^2 + u*x^2 = v*y^2`,

all primes in one term are forced to split in a quadratic extension determined
by the other two squarefree coefficients.  More precisely:

* if a prime divides `u*x`, then `w*v` is a square modulo that prime;
* if a prime divides `w*z`, then `u*v` is a square modulo that prime;
* if a prime divides `v*y`, then `-u*w` is a square modulo that prime.

The statements are proved directly with natural-number congruences and the
pairwise coprimality of the concrete abc witness.  They are necessary local
conditions, not a global estimate for the Pell equation.
-/

namespace IUTThreeClosures
namespace MovingPellLocalResidue

open MovingPellApproximationIdentity

noncomputable section

/-- `a` is represented by a square modulo `p`. -/
def IsSquareMod (p a : ℕ) : Prop :=
  ∃ t : ℕ, a ≡ t ^ 2 [MOD p]

/-- `-a` is represented by a square modulo `p`, written without integer
subtraction as `a+t^2 ≡ 0`. -/
def IsNegativeSquareMod (p a : ℕ) : Prop :=
  ∃ t : ℕ, a + t ^ 2 ≡ 0 [MOD p]

/-- Cancel a coprime square factor from a twisted square congruence. -/
theorem isSquareMod_of_mul_square_mod_square
    {p a z t : ℕ}
    (hp : p.Prime) (hzp : Nat.Coprime z p)
    (h : a * z ^ 2 ≡ t ^ 2 [MOD p]) :
    IsSquareMod p a := by
  obtain ⟨r, _hrlt, hr⟩ :=
    Nat.exists_mul_mod_eq_one_of_coprime hzp hp.one_lt
  have hzr : z * r ≡ 1 [MOD p] := by
    unfold Nat.ModEq
    simpa [Nat.mod_eq_of_lt hp.one_lt] using hr
  have hscaled :
      a * (z * r) ^ 2 ≡ (t * r) ^ 2 [MOD p] := by
    have hs := h.mul_right (r ^ 2)
    convert hs using 1 <;> ring
  have hunit : a * (z * r) ^ 2 ≡ a [MOD p] := by
    have hs := (Nat.ModEq.refl a).mul (hzr.pow 2)
    simpa using hs
  exact ⟨t * r, hunit.symm.trans hscaled⟩

/-- Cancel a coprime square factor from a twisted negative-square
congruence. -/
theorem isNegativeSquareMod_of_mul_square_add_square
    {p a z t : ℕ}
    (hp : p.Prime) (hzp : Nat.Coprime z p)
    (h : a * z ^ 2 + t ^ 2 ≡ 0 [MOD p]) :
    IsNegativeSquareMod p a := by
  obtain ⟨r, _hrlt, hr⟩ :=
    Nat.exists_mul_mod_eq_one_of_coprime hzp hp.one_lt
  have hzr : z * r ≡ 1 [MOD p] := by
    unfold Nat.ModEq
    simpa [Nat.mod_eq_of_lt hp.one_lt] using hr
  have hscaled :
      a * (z * r) ^ 2 + (t * r) ^ 2 ≡ 0 [MOD p] := by
    have hs := h.mul_right (r ^ 2)
    convert hs using 1 <;> ring
  have hunit :
      a * (z * r) ^ 2 + (t * r) ^ 2 ≡
        a + (t * r) ^ 2 [MOD p] := by
    have hs :=
      ((Nat.ModEq.refl a).mul (hzr.pow 2)).add
        (Nat.ModEq.refl ((t * r) ^ 2))
    simpa using hs
  exact ⟨t * r, hunit.symm.trans hscaled⟩

/-- Removing a summand divisible by the modulus preserves the other side of
an additive equality. -/
theorem left_modEq_total_of_add_eq_of_dvd_right
    {p A B C : ℕ} (hadd : A + B = C) (hdiv : p ∣ B) :
    A ≡ C [MOD p] := by
  have hzero : B ≡ 0 [MOD p] := hdiv.modEq_zero_nat
  have hsum : A + B ≡ A + 0 [MOD p] :=
    (Nat.ModEq.refl A).add hzero
  rw [hadd] at hsum
  simpa using hsum.symm

/-- Symmetric summand-removal lemma. -/
theorem right_modEq_total_of_add_eq_of_dvd_left
    {p A B C : ℕ} (hadd : A + B = C) (hdiv : p ∣ A) :
    B ≡ C [MOD p] := by
  have hzero : A ≡ 0 [MOD p] := hdiv.modEq_zero_nat
  have hsum : A + B ≡ 0 + B [MOD p] :=
    hzero.add (Nat.ModEq.refl B)
  rw [hadd] at hsum
  simpa using hsum.symm

namespace ABCPoint

/-- Every prime in the `u*x` term sees `w*v` as a quadratic residue. -/
theorem SquarefreePellWitness.w_mul_v_isSquareMod_of_prime_dvd_u_mul_x
    {P : ABCPoint} (W : P.SquarefreePellWitness)
    {p : ℕ} (hp : p.Prime) (hdiv : p ∣ W.u * W.x) :
    IsSquareMod p (W.w * W.v) := by
  have hterm : p ∣ W.u * W.x ^ 2 := by
    have hm := dvd_mul_of_dvd_left hdiv W.x
    simpa [pow_two, mul_assoc] using hm
  have hbase :
      W.w * W.z ^ 2 ≡ W.v * W.y ^ 2 [MOD p] :=
    left_modEq_total_of_add_eq_of_dvd_right W.conic_eq hterm
  have htwisted :
      (W.w * W.v) * W.z ^ 2 ≡ (W.v * W.y) ^ 2 [MOD p] := by
    have hm := hbase.mul_left W.v
    convert hm using 1 <;> ring
  have hzp : Nat.Coprime W.z p :=
    Nat.Coprime.of_dvd
      (show W.z ∣ W.w * W.z by exact dvd_mul_left _ _)
      hdiv W.small_large_coprime
  exact isSquareMod_of_mul_square_mod_square hp hzp htwisted

/-- Every prime in the `w*z` term sees `u*v` as a quadratic residue. -/
theorem SquarefreePellWitness.u_mul_v_isSquareMod_of_prime_dvd_w_mul_z
    {P : ABCPoint} (W : P.SquarefreePellWitness)
    {p : ℕ} (hp : p.Prime) (hdiv : p ∣ W.w * W.z) :
    IsSquareMod p (W.u * W.v) := by
  have hterm : p ∣ W.w * W.z ^ 2 := by
    have hm := dvd_mul_of_dvd_left hdiv W.z
    simpa [pow_two, mul_assoc] using hm
  have hbase :
      W.u * W.x ^ 2 ≡ W.v * W.y ^ 2 [MOD p] :=
    right_modEq_total_of_add_eq_of_dvd_left W.conic_eq hterm
  have htwisted :
      (W.u * W.v) * W.x ^ 2 ≡ (W.v * W.y) ^ 2 [MOD p] := by
    have hm := hbase.mul_left W.v
    convert hm using 1 <;> ring
  have hxp : Nat.Coprime W.x p :=
    Nat.Coprime.of_dvd
      (show W.x ∣ W.u * W.x by exact dvd_mul_left _ _)
      hdiv W.small_large_coprime.symm
  exact isSquareMod_of_mul_square_mod_square hp hxp htwisted

/-- Every prime in the `v*y` term sees `-u*w` as a quadratic residue. -/
theorem SquarefreePellWitness.u_mul_w_isNegativeSquareMod_of_prime_dvd_v_mul_y
    {P : ABCPoint} (W : P.SquarefreePellWitness)
    {p : ℕ} (hp : p.Prime) (hdiv : p ∣ W.v * W.y) :
    IsNegativeSquareMod p (W.u * W.w) := by
  have hterm : p ∣ W.v * W.y ^ 2 := by
    have hm := dvd_mul_of_dvd_left hdiv W.y
    simpa [pow_two, mul_assoc] using hm
  have hsum :
      W.w * W.z ^ 2 + W.u * W.x ^ 2 ≡ 0 [MOD p] := by
    rw [W.conic_eq]
    exact hterm.modEq_zero_nat
  have htwisted :
      (W.u * W.w) * W.z ^ 2 + (W.u * W.x) ^ 2 ≡ 0 [MOD p] := by
    have hm := hsum.mul_left W.u
    convert hm using 1 <;> ring
  have hzp : Nat.Coprime W.z p :=
    Nat.Coprime.of_dvd
      (show W.z ∣ W.w * W.z by exact dvd_mul_left _ _)
      hdiv W.small_c_coprime
  exact isNegativeSquareMod_of_mul_square_add_square hp hzp htwisted

#print axioms isSquareMod_of_mul_square_mod_square
#print axioms isNegativeSquareMod_of_mul_square_add_square
#print axioms left_modEq_total_of_add_eq_of_dvd_right
#print axioms right_modEq_total_of_add_eq_of_dvd_left
#print axioms ABCPoint.SquarefreePellWitness.w_mul_v_isSquareMod_of_prime_dvd_u_mul_x
#print axioms ABCPoint.SquarefreePellWitness.u_mul_v_isSquareMod_of_prime_dvd_w_mul_z
#print axioms ABCPoint.SquarefreePellWitness.u_mul_w_isNegativeSquareMod_of_prime_dvd_v_mul_y

end ABCPoint
end
end MovingPellLocalResidue
end IUTThreeClosures
