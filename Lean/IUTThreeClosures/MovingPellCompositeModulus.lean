/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MovingPellLocalResidue
import Mathlib.Tactic

/-!
# Composite-modulus square locks for the moving Pell witness

The primewise residue constraints can be strengthened without any analytic
input.  For

`m=w*z^2`, `M=u*x^2`, `c=v*y^2`,

pairwise coprimality allows cancellation modulo the full endpoints, giving

* `w*v` is a square modulo `M`;
* `u*v` is a square modulo `m`;
* `-u*w` is a square modulo `c`.

Thus a hypothetical abc counterexample would not merely satisfy independent
conditions at a few primes: the three coupled square classes are locked modulo
the complete pairwise-coprime endpoint moduli.  These are necessary
congruences, not a global height estimate.
-/

namespace IUTThreeClosures
namespace MovingPellCompositeModulus

open MovingPellLocalResidue

noncomputable section

/-- Cancel a square factor modulo an arbitrary positive coprime modulus. -/
theorem isSquareMod_of_mul_square_mod_square_of_coprime
    {n a z t : ℕ}
    (hn : n ≠ 0) (hzn : Nat.Coprime z n)
    (h : a * z ^ 2 ≡ t ^ 2 [MOD n]) :
    IsSquareMod n a := by
  obtain ⟨r, _hrlt, hr⟩ :=
    Nat.exists_mul_mod_eq_of_coprime 1 hzn hn
  have hzr : z * r ≡ 1 [MOD n] := by
    unfold Nat.ModEq
    simpa using hr
  have hscaled :
      a * (z * r) ^ 2 ≡ (t * r) ^ 2 [MOD n] := by
    have hs := h.mul_right (r ^ 2)
    convert hs using 1 <;> ring
  have hunit : a * (z * r) ^ 2 ≡ a [MOD n] := by
    have hs := (Nat.ModEq.refl a).mul (hzr.pow 2)
    simpa using hs
  exact ⟨t * r, hunit.symm.trans hscaled⟩

/-- Cancel a square factor from a negative-square relation modulo an arbitrary
positive coprime modulus. -/
theorem isNegativeSquareMod_of_mul_square_add_square_of_coprime
    {n a z t : ℕ}
    (hn : n ≠ 0) (hzn : Nat.Coprime z n)
    (h : a * z ^ 2 + t ^ 2 ≡ 0 [MOD n]) :
    IsNegativeSquareMod n a := by
  obtain ⟨r, _hrlt, hr⟩ :=
    Nat.exists_mul_mod_eq_of_coprime 1 hzn hn
  have hzr : z * r ≡ 1 [MOD n] := by
    unfold Nat.ModEq
    simpa using hr
  have hscaled :
      a * (z * r) ^ 2 + (t * r) ^ 2 ≡ 0 [MOD n] := by
    have hs := h.mul_right (r ^ 2)
    convert hs using 1 <;> ring
  have hunit :
      a * (z * r) ^ 2 + (t * r) ^ 2 ≡
        a + (t * r) ^ 2 [MOD n] := by
    have hs :=
      ((Nat.ModEq.refl a).mul (hzr.pow 2)).add
        (Nat.ModEq.refl ((t * r) ^ 2))
    simpa using hs
  exact ⟨t * r, hunit.symm.trans hscaled⟩

namespace ABCPoint

/-- The small square root is invertible modulo the full large summand. -/
theorem SquarefreePellWitness.z_coprime_largeEndpoint
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.z P.largeEndpoint := by
  have hzdvd : W.z ∣ P.endpointMin := by
    refine ⟨W.w * W.z, ?_⟩
    rw [W.small_eq]
    ring
  exact Nat.Coprime.of_dvd hzdvd (dvd_refl _)
    P.signedLayer_endpointMin_coprime_largeEndpoint

/-- The large-summand square root is invertible modulo the small endpoint. -/
theorem SquarefreePellWitness.x_coprime_endpointMin
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.x P.endpointMin := by
  have hxdvd : W.x ∣ P.largeEndpoint := by
    refine ⟨W.u * W.x, ?_⟩
    rw [W.large_eq]
    ring
  exact Nat.Coprime.of_dvd hxdvd (dvd_refl _)
    P.signedLayer_endpointMin_coprime_largeEndpoint.symm

/-- The small square root is invertible modulo the full output endpoint. -/
theorem SquarefreePellWitness.z_coprime_c
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.z P.c := by
  have hzdvd : W.z ∣ P.endpointMin := by
    refine ⟨W.w * W.z, ?_⟩
    rw [W.small_eq]
    ring
  exact Nat.Coprime.of_dvd hzdvd (dvd_refl _)
    P.signedLayer_endpointMin_coprime_c

/-- The coefficient `w*v` is a square modulo the entire large summand. -/
theorem SquarefreePellWitness.w_mul_v_isSquareMod_largeEndpoint
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    IsSquareMod P.largeEndpoint (W.w * W.v) := by
  have hterm : P.largeEndpoint ∣ W.u * W.x ^ 2 := by
    rw [← W.large_eq]
  have hbase :
      W.w * W.z ^ 2 ≡ W.v * W.y ^ 2 [MOD P.largeEndpoint] :=
    MovingPellLocalResidue.left_modEq_total_of_add_eq_of_dvd_right
      W.conic_eq hterm
  have htwisted :
      (W.w * W.v) * W.z ^ 2 ≡
        (W.v * W.y) ^ 2 [MOD P.largeEndpoint] := by
    have hm := hbase.mul_left W.v
    convert hm using 1 <;> ring
  exact isSquareMod_of_mul_square_mod_square_of_coprime
    P.largeEndpoint_pos.ne' W.z_coprime_largeEndpoint htwisted

/-- The coefficient `u*v` is a square modulo the entire small endpoint. -/
theorem SquarefreePellWitness.u_mul_v_isSquareMod_endpointMin
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    IsSquareMod P.endpointMin (W.u * W.v) := by
  have hterm : P.endpointMin ∣ W.w * W.z ^ 2 := by
    rw [← W.small_eq]
  have hbase :
      W.u * W.x ^ 2 ≡ W.v * W.y ^ 2 [MOD P.endpointMin] :=
    MovingPellLocalResidue.right_modEq_total_of_add_eq_of_dvd_left
      W.conic_eq hterm
  have htwisted :
      (W.u * W.v) * W.x ^ 2 ≡
        (W.v * W.y) ^ 2 [MOD P.endpointMin] := by
    have hm := hbase.mul_left W.v
    convert hm using 1 <;> ring
  exact isSquareMod_of_mul_square_mod_square_of_coprime
    P.endpointMin_pos.ne' W.x_coprime_endpointMin htwisted

/-- The negative coefficient `-u*w` is a square modulo the entire output
endpoint. -/
theorem SquarefreePellWitness.u_mul_w_isNegativeSquareMod_c
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    IsNegativeSquareMod P.c (W.u * W.w) := by
  have hterm : P.c ∣ W.v * W.y ^ 2 := by
    rw [← W.c_eq]
  have hsum :
      W.w * W.z ^ 2 + W.u * W.x ^ 2 ≡ 0 [MOD P.c] := by
    rw [W.conic_eq]
    exact hterm.modEq_zero_nat
  have htwisted :
      (W.u * W.w) * W.z ^ 2 + (W.u * W.x) ^ 2 ≡
        0 [MOD P.c] := by
    have hm := hsum.mul_left W.u
    convert hm using 1 <;> ring
  exact isNegativeSquareMod_of_mul_square_add_square_of_coprime
    P.c_pos.ne' W.z_coprime_c htwisted

#print axioms isSquareMod_of_mul_square_mod_square_of_coprime
#print axioms isNegativeSquareMod_of_mul_square_add_square_of_coprime
#print axioms ABCPoint.SquarefreePellWitness.z_coprime_largeEndpoint
#print axioms ABCPoint.SquarefreePellWitness.x_coprime_endpointMin
#print axioms ABCPoint.SquarefreePellWitness.z_coprime_c
#print axioms ABCPoint.SquarefreePellWitness.w_mul_v_isSquareMod_largeEndpoint
#print axioms ABCPoint.SquarefreePellWitness.u_mul_v_isSquareMod_endpointMin
#print axioms ABCPoint.SquarefreePellWitness.u_mul_w_isNegativeSquareMod_c

end ABCPoint
end
end MovingPellCompositeModulus
end IUTThreeClosures
