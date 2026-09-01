/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineTemplateEntropy20260901
import IUTThreeClosures.ArithmeticLeibnizWronskian

/-!
# Determinant layers for fixed affine templates

The mathematical proofs precede this file in
`research/ABC_AFFINE_DETERMINANT_LAYER_ENTROPY_2026_09_01.md`.

This module starts with the arithmetic core: all determinants of two
difference vectors in one complete three-form template are divisible by the
product modulus.  It then records the exact zero-layer consequence and the
finite weighted-cover algebra used by the canonical-kernel entropy argument.
The canonical constant and repeated-kernel seams are developed in the same
route without inserting an unproved adaptive-template estimate.
-/

namespace IUTThreeClosures
namespace AffineDeterminantLayerEntropy20260901

open scoped BigOperators
open AffineTemplateEntropy20260901

/-- Determinant of two signed parameter vectors. -/
def signedPairDet (v w : ℤ × ℤ) : ℤ :=
  v.1 * w.2 - v.2 * w.1

/-- The product of the three pairwise-coprime affine moduli divides every
determinant formed from two fixed-template difference vectors. -/
theorem threeForm_modulusProduct_dvd_det
    {dU dV dW B C : ℕ} {v w : ℤ × ℤ}
    (hUV : Nat.Coprime dU dV)
    (hUW : Nat.Coprime dU dW)
    (hVW : Nat.Coprime dV dW)
    (hvU : (dU : ℤ) ∣ v.1)
    (hvV : (dV : ℤ) ∣ v.1 + (C : ℤ) * v.2)
    (hvW : (dW : ℤ) ∣ v.1 + (B : ℤ) * v.2)
    (hwU : (dU : ℤ) ∣ w.1)
    (hwV : (dV : ℤ) ∣ w.1 + (C : ℤ) * w.2)
    (hwW : (dW : ℤ) ∣ w.1 + (B : ℤ) * w.2) :
    ((dU * dV * dW : ℕ) : ℤ) ∣ signedPairDet v w := by
  have hUdet : (dU : ℤ) ∣ signedPairDet v w := by
    unfold signedPairDet
    exact dvd_sub (dvd_mul_of_dvd_left hvU w.2)
      (dvd_mul_of_dvd_right hwU v.2)
  have hVdet : (dV : ℤ) ∣ signedPairDet v w := by
    have hrewrite :
        signedPairDet v w =
          (v.1 + (C : ℤ) * v.2) * w.2 -
            v.2 * (w.1 + (C : ℤ) * w.2) := by
      unfold signedPairDet
      ring
    rw [hrewrite]
    exact dvd_sub (dvd_mul_of_dvd_left hvV w.2)
      (dvd_mul_of_dvd_right hwV v.2)
  have hWdet : (dW : ℤ) ∣ signedPairDet v w := by
    have hrewrite :
        signedPairDet v w =
          (v.1 + (B : ℤ) * v.2) * w.2 -
            v.2 * (w.1 + (B : ℤ) * w.2) := by
      unfold signedPairDet
      ring
    rw [hrewrite]
    exact dvd_sub (dvd_mul_of_dvd_left hvW w.2)
      (dvd_mul_of_dvd_right hwW v.2)
  have hUabs : dU ∣ (signedPairDet v w).natAbs :=
    nat_dvd_natAbs_of_intCast_dvd hUdet
  have hVabs : dV ∣ (signedPairDet v w).natAbs :=
    nat_dvd_natAbs_of_intCast_dvd hVdet
  have hWabs : dW ∣ (signedPairDet v w).natAbs :=
    nat_dvd_natAbs_of_intCast_dvd hWdet
  have hUVabs : dU * dV ∣ (signedPairDet v w).natAbs :=
    hUV.mul_dvd_of_dvd_of_dvd hUabs hVabs
  have hUVW : Nat.Coprime (dU * dV) dW := hUW.mul_left hVW
  have hNat : dU * dV * dW ∣ (signedPairDet v w).natAbs :=
    hUVW.mul_dvd_of_dvd_of_dvd hUVabs hWabs
  apply Int.dvd_natAbs.mp
  exact_mod_cast hNat

#print axioms threeForm_modulusProduct_dvd_det

/-- A multiple of a modulus with smaller absolute value is zero. -/
theorem eq_zero_of_modulus_dvd_and_natAbs_lt
    {D : ℕ} {z : ℤ}
    (hdvd : (D : ℤ) ∣ z) (hsmall : z.natAbs < D) :
    z = 0 := by
  by_contra hz
  have habsPos : 0 < z.natAbs := Int.natAbs_pos.mpr hz
  have hNat : D ∣ z.natAbs := nat_dvd_natAbs_of_intCast_dvd hdvd
  have hle : D ≤ z.natAbs := Nat.le_of_dvd habsPos hNat
  omega

#print axioms eq_zero_of_modulus_dvd_and_natAbs_lt

/-- Abstract forced-zero determinant layer.  This is the exact final step in
the collinearity argument once the box estimate gives `|det| < D`. -/
theorem signedPairDet_eq_zero_of_template_and_bound
    {dU dV dW B C : ℕ} {v w : ℤ × ℤ}
    (hUV : Nat.Coprime dU dV)
    (hUW : Nat.Coprime dU dW)
    (hVW : Nat.Coprime dV dW)
    (hvU : (dU : ℤ) ∣ v.1)
    (hvV : (dV : ℤ) ∣ v.1 + (C : ℤ) * v.2)
    (hvW : (dW : ℤ) ∣ v.1 + (B : ℤ) * v.2)
    (hwU : (dU : ℤ) ∣ w.1)
    (hwV : (dV : ℤ) ∣ w.1 + (C : ℤ) * w.2)
    (hwW : (dW : ℤ) ∣ w.1 + (B : ℤ) * w.2)
    (hsmall : (signedPairDet v w).natAbs < dU * dV * dW) :
    signedPairDet v w = 0 := by
  apply eq_zero_of_modulus_dvd_and_natAbs_lt
  · exact threeForm_modulusProduct_dvd_det hUV hUW hVW
      hvU hvV hvW hwU hwV hwW
  · exact hsmall

#print axioms signedPairDet_eq_zero_of_template_and_bound

/-- Finite fractional-cover inequality.  Each point has total covering
weight at least one and each template has at most `capacity` points, so the
total point mass is bounded by capacity times total template weight. -/
theorem fractionalTemplateCover_card_le
    {α ι : Type*} [DecidableEq α]
    (points : Finset α) (templates : Finset ι)
    (covers : ι → Finset α) (weight : ι → ℝ)
    (capacity : ℕ)
    (hweight : ∀ i ∈ templates, 0 ≤ weight i)
    (hcapacity : ∀ i ∈ templates,
      ((covers i ∩ points).card : ℝ) ≤ capacity)
    (hcovered : ∀ x ∈ points,
      1 ≤ ∑ i ∈ templates with x ∈ covers i, weight i) :
    (points.card : ℝ) ≤
      capacity * ∑ i ∈ templates, weight i := by
  calc
    (points.card : ℝ) = ∑ x ∈ points, (1 : ℝ) := by simp
    _ ≤ ∑ x ∈ points,
        ∑ i ∈ templates with x ∈ covers i, weight i := by
      exact Finset.sum_le_sum hcovered
    _ = ∑ i ∈ templates,
        ((covers i ∩ points).card : ℝ) * weight i := by
      simp_rw [Finset.sum_filter]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro i hi
      rw [← Finset.sum_filter]
      simp only [Finset.sum_const, nsmul_eq_mul]
      congr 1
      norm_cast
      congr 1
      ext x
      simp [and_comm]
    _ ≤ ∑ i ∈ templates, (capacity : ℝ) * weight i := by
      apply Finset.sum_le_sum
      intro i hi
      exact mul_le_mul_of_nonneg_right (hcapacity i hi) (hweight i hi)
    _ = capacity * ∑ i ∈ templates, weight i := by
      rw [Finset.mul_sum]

#print axioms fractionalTemplateCover_card_le


/-- Coordinate bounds put the determinant in the interval
`[-2*N^2, 2*N^2]`.  A modulus larger than that interval therefore forces
collinearity. -/
theorem signedPairDet_eq_zero_of_dvd_of_coordinateBounds
    {D N : ℕ} {v w : ℤ × ℤ}
    (hD : (D : ℤ) ∣ signedPairDet v w)
    (hv1 : v.1.natAbs ≤ N) (hv2 : v.2.natAbs ≤ N)
    (hw1 : w.1.natAbs ≤ N) (hw2 : w.2.natAbs ≤ N)
    (hlarge : 2 * N ^ 2 < D) :
    signedPairDet v w = 0 := by
  have habs : (signedPairDet v w).natAbs ≤ 2 * N ^ 2 := by
    calc
      (signedPairDet v w).natAbs ≤
          (v.1 * w.2).natAbs + (v.2 * w.1).natAbs := by
        simpa [signedPairDet, sub_eq_add_neg] using
          Int.natAbs_add_le (v.1 * w.2) (-(v.2 * w.1))
      _ = v.1.natAbs * w.2.natAbs + v.2.natAbs * w.1.natAbs := by
        simp [Int.natAbs_mul]
      _ ≤ N * N + N * N := by
        exact Nat.add_le_add (Nat.mul_le_mul hv1 hw2)
          (Nat.mul_le_mul hv2 hw1)
      _ = 2 * N ^ 2 := by ring
  exact eq_zero_of_modulus_dvd_and_natAbs_lt hD (habs.trans_lt hlarge)

/-- Direct composition of the congruence determinant divisor with the
large-determinant collinearity criterion. -/
theorem threeForm_signedPairDet_eq_zero_of_large_modulusProduct
    {dU dV dW B C N : ℕ} {v w : ℤ × ℤ}
    (hUV : Nat.Coprime dU dV)
    (hUW : Nat.Coprime dU dW)
    (hVW : Nat.Coprime dV dW)
    (hUv : (dU : ℤ) ∣ v.1)
    (hUw : (dU : ℤ) ∣ w.1)
    (hVv : (dV : ℤ) ∣ v.1 + (C : ℤ) * v.2)
    (hVw : (dV : ℤ) ∣ w.1 + (C : ℤ) * w.2)
    (hWv : (dW : ℤ) ∣ v.1 + (B : ℤ) * v.2)
    (hWw : (dW : ℤ) ∣ w.1 + (B : ℤ) * w.2)
    (hv1 : v.1.natAbs ≤ N) (hv2 : v.2.natAbs ≤ N)
    (hw1 : w.1.natAbs ≤ N) (hw2 : w.2.natAbs ≤ N)
    (hlarge : 2 * N ^ 2 < dU * dV * dW) :
    signedPairDet v w = 0 := by
  apply signedPairDet_eq_zero_of_dvd_of_coordinateBounds
    (threeForm_modulusProduct_dvd_det hUV hUW hVW
      hUv hVv hWv hUw hVw hWw) hv1 hv2 hw1 hw2
  exact hlarge

/-! ## One-dimensional cardinality after collinearity -/

/-- A finite set in `[0,M]` whose distinct elements are farther apart than
`L` occupies at most one point in each interval cell of length `L+1`. -/
theorem oneDimSeparated_card_le
    (S : Finset ℕ) (M L : ℕ)
    (hbox : ∀ x ∈ S, x ≤ M)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → L < Nat.dist x y) :
    S.card ≤ M / (L + 1) + 1 := by
  classical
  let cells : Finset ℕ := Finset.range (M / (L + 1) + 1)
  have hmaps : Set.MapsTo (fun x : ℕ ↦ x / (L + 1))
      (S : Set ℕ) (cells : Set ℕ) := by
    intro x hx
    rw [Finset.mem_coe, Finset.mem_range]
    exact Nat.lt_succ_of_le (Nat.div_le_div_right (hbox x hx))
  have hinj : Set.InjOn (fun x : ℕ ↦ x / (L + 1)) (S : Set ℕ) := by
    intro x hx y hy hcell
    by_contra hxy
    have hfar := hsep x hx y hy hxy
    have hnear := dist_le_of_same_cell hcell
    omega
  have hcard := Finset.card_le_card_of_injOn
    (fun x : ℕ ↦ x / (L + 1)) hmaps hinj
  simpa [cells] using hcard

/-- Cardinal interface used after a collinearity proof has selected a
dominant coordinate. -/
theorem dominantFirstCoordinate_card_le
    (S : Finset (ℕ × ℕ)) (M L : ℕ)
    (hbox : ∀ p ∈ S, p.1 ≤ M)
    (hsep : ∀ p ∈ S, ∀ q ∈ S, p ≠ q →
      L < Nat.dist p.1 q.1) :
    S.card ≤ M / (L + 1) + 1 := by
  classical
  let cells : Finset ℕ := Finset.range (M / (L + 1) + 1)
  have hmaps : Set.MapsTo (fun p : ℕ × ℕ ↦ p.1 / (L + 1))
      (S : Set (ℕ × ℕ)) (cells : Set ℕ) := by
    intro p hp
    rw [Finset.mem_coe, Finset.mem_range]
    exact Nat.lt_succ_of_le (Nat.div_le_div_right (hbox p hp))
  have hinj : Set.InjOn (fun p : ℕ × ℕ ↦ p.1 / (L + 1))
      (S : Set (ℕ × ℕ)) := by
    intro p hp q hq hcell
    by_contra hpq
    have hfar := hsep p hp q hq hpq
    have hnear := dist_le_of_same_cell hcell
    omega
  have hcard := Finset.card_le_card_of_injOn
    (fun p : ℕ × ℕ ↦ p.1 / (L + 1)) hmaps hinj
  simpa [cells] using hcard

/-! ## Canonical arithmetic checks -/

private theorem radical_30 : abcRadical 30 = 30 := by
  rw [show 30 = 2 * (3 * 5) by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_two.prime),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_three.prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 5).prime)]
  norm_num
private theorem radical_42 : abcRadical 42 = 42 := by
  rw [show 42 = 2 * (3 * 7) by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_two.prime),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_three.prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num
private theorem radical_56 : abcRadical 56 = 14 := by
  rw [show 56 = 2 ^ 3 * 7 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact Nat.prime_two.prime) (by norm_num),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num
private theorem radical_70 : abcRadical 70 = 70 := by
  rw [show 70 = 2 * (5 * 7) by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_two.prime),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 5).prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num
private theorem radical_84 : abcRadical 84 = 42 := by
  rw [show 84 = 2 ^ 2 * (3 * 7) by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact Nat.prime_two.prime) (by norm_num),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_three.prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num
private theorem radical_120 : abcRadical 120 = 30 := by
  rw [show 120 = 2 ^ 3 * (3 * 5) by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact Nat.prime_two.prime) (by norm_num),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact Nat.prime_three.prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 5).prime)]
  norm_num

/-- The apparent abstract endpoints `c = 6,7,8` do not occur for an actual
positive primitive seed whose radical is strictly smaller than `c`. -/
theorem primitive_subcritical_c_ge_nine
    {a b c R : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hsum : a + b = c)
    (hcop : Nat.Coprime a b) (hc : 6 ≤ c)
    (hR : R = abcRadical (a * b * c)) (hsub : R < c) :
    9 ≤ c := by
  by_contra hnot
  have hcases : c = 6 ∨ c = 7 ∨ c = 8 := by omega
  rcases hcases with rfl | rfl | rfl
  · have hale : a ≤ 6 := by omega
    have hble : b ≤ 6 := by omega
    interval_cases a <;> interval_cases b <;>
      norm_num [radical_30] at * <;> omega
  · have hale : a ≤ 7 := by omega
    have hble : b ≤ 7 := by omega
    interval_cases a <;> interval_cases b <;>
      norm_num [radical_42, radical_70, radical_84] at * <;> omega
  · have hale : a ≤ 8 := by omega
    have hble : b ≤ 8 := by omega
    interval_cases a <;> interval_cases b <;>
      norm_num [radical_56, radical_120] at * <;> omega

/-- Once the seed-specific small cases have supplied `c ≥ 9`, scale `12`
is valid in the cubic branch. -/
theorem canonical_cubicThreshold_scale12 {c R : ℕ}
    (hc : 9 ≤ c) (hR : 6 ≤ R) :
    8192 * (c + 1) ^ 2 * (c ^ 4 / 12) ^ 3 < R * c ^ 14 := by
  let L := c ^ 4 / 12
  have hside : 9 * (c + 1) ≤ 10 * c := by omega
  have hsidesq : (9 * (c + 1)) ^ 2 ≤ (10 * c) ^ 2 :=
    Nat.pow_le_pow_left hside 2
  have hL : 12 * L ≤ c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hL3 : (12 * L) ^ 3 ≤ (c ^ 4) ^ 3 :=
    Nat.pow_le_pow_left hL 3
  have hprod :
      (9 * (c + 1)) ^ 2 * (12 * L) ^ 3 ≤
        (10 * c) ^ 2 * (c ^ 4) ^ 3 :=
    Nat.mul_le_mul hsidesq hL3
  have hcore : 81 * 12 ^ 3 * ((c + 1) ^ 2 * L ^ 3) ≤
      100 * c ^ 14 := by
    nlinarith [hprod]
  have hconst : 100 * 8192 < 81 * 12 ^ 3 * R := by
    nlinarith
  have hc14pos : 0 < c ^ 14 := pow_pos (by omega) _
  have hconstScaled : (100 * 8192) * c ^ 14 <
      (81 * 12 ^ 3 * R) * c ^ 14 :=
    (Nat.mul_lt_mul_right hc14pos).2 hconst
  have hleft : (81 * 12 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) ≤
      (100 * 8192) * c ^ 14 := by
    nlinarith [hcore]
  have hchain : (81 * 12 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) <
      (81 * 12 ^ 3) * (R * c ^ 14) := by
    calc
      _ ≤ (100 * 8192) * c ^ 14 := hleft
      _ < (81 * 12 ^ 3 * R) * c ^ 14 := hconstScaled
      _ = (81 * 12 ^ 3) * (R * c ^ 14) := by ring
  have hfactor : 0 < 81 * 12 ^ 3 := by norm_num
  exact (Nat.mul_lt_mul_left hfactor).1
    (by simpa [L, mul_assoc] using hchain)

/-- The weakest canonical individual size cap at scale `12`. -/
theorem canonical_longCapThreshold_scale12 {c R : ℕ}
    (hc : 9 ≤ c) (hR : 6 ≤ R) :
    8192 * (c ^ 4 / 12) * c ^ 7 < R * c ^ 14 := by
  let L := c ^ 4 / 12
  have hL : 12 * L ≤ c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hc3 : 9 ^ 3 ≤ c ^ 3 := Nat.pow_le_pow_left hc 3
  have hconst : 8192 < 12 * R * c ^ 3 := by
    nlinarith
  have hc11pos : 0 < c ^ 11 := pow_pos (by omega) _
  have hconstScaled : 8192 * c ^ 11 <
      (12 * R * c ^ 3) * c ^ 11 :=
    (Nat.mul_lt_mul_right hc11pos).2 hconst
  have hleft : 12 * (8192 * L * c ^ 7) ≤ 8192 * c ^ 11 := by
    calc
      12 * (8192 * L * c ^ 7) = 8192 * (12 * L) * c ^ 7 := by ring
      _ ≤ 8192 * c ^ 4 * c ^ 7 :=
        Nat.mul_le_mul_right (c ^ 7) (Nat.mul_le_mul_left 8192 hL)
      _ = 8192 * c ^ 11 := by ring
  have hchain : 12 * (8192 * L * c ^ 7) <
      12 * (R * c ^ 14) := by
    calc
      _ ≤ 8192 * c ^ 11 := hleft
      _ < (12 * R * c ^ 3) * c ^ 11 := hconstScaled
      _ = 12 * (R * c ^ 14) := by ring
  exact (Nat.mul_lt_mul_left (by norm_num : 0 < 12)).1
    (by simpa [L] using hchain)

/-- A cube-root lower parameter `s^3 ≤ R` permits the larger scale
`floor(s*c^4/22)`. -/
theorem canonical_cubicThreshold_scale22
    {c R s : ℕ} (hc : 9 ≤ c) (hspos : 1 ≤ s) (hs : s ^ 3 ≤ R) :
    8192 * (c + 1) ^ 2 * (s * c ^ 4 / 22) ^ 3 < R * c ^ 14 := by
  let L := s * c ^ 4 / 22
  have hside : 9 * (c + 1) ≤ 10 * c := by omega
  have hsidesq : (9 * (c + 1)) ^ 2 ≤ (10 * c) ^ 2 :=
    Nat.pow_le_pow_left hside 2
  have hL : 22 * L ≤ s * c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hL3 : (22 * L) ^ 3 ≤ (s * c ^ 4) ^ 3 :=
    Nat.pow_le_pow_left hL 3
  have hprod :
      (9 * (c + 1)) ^ 2 * (22 * L) ^ 3 ≤
        (10 * c) ^ 2 * (s * c ^ 4) ^ 3 :=
    Nat.mul_le_mul hsidesq hL3
  have hcore : 81 * 22 ^ 3 * ((c + 1) ^ 2 * L ^ 3) ≤
      100 * s ^ 3 * c ^ 14 := by
    nlinarith [hprod]
  have hconst : 100 * 8192 < 81 * 22 ^ 3 := by norm_num
  have hc14pos : 0 < c ^ 14 := pow_pos (by omega) _
  have hsScaled : s ^ 3 * c ^ 14 ≤ R * c ^ 14 :=
    Nat.mul_le_mul_right _ hs
  have htarget : (100 * 8192) * (s ^ 3 * c ^ 14) <
      (81 * 22 ^ 3) * (R * c ^ 14) := by
    have hs3c14pos : 0 < s ^ 3 * c ^ 14 := by positivity
    calc
      _ < (81 * 22 ^ 3) * (s ^ 3 * c ^ 14) :=
        (Nat.mul_lt_mul_right hs3c14pos).2 hconst
      _ ≤ (81 * 22 ^ 3) * (R * c ^ 14) :=
        Nat.mul_le_mul_left _ hsScaled
  have hleft : (81 * 22 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) ≤
      (100 * 8192) * (s ^ 3 * c ^ 14) := by
    nlinarith [hcore]
  have hchain : (81 * 22 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) <
      (81 * 22 ^ 3) * (R * c ^ 14) := hleft.trans_lt htarget
  exact (Nat.mul_lt_mul_left (by norm_num : 0 < 81 * 22 ^ 3)).1
    (by simpa [L, mul_assoc] using hchain)

/-- The weakest canonical individual size cap at the `s/22` scale. -/
theorem canonical_longCapThreshold_scale22
    {c R s : ℕ} (hc : 9 ≤ c) (hspos : 1 ≤ s) (hs : s ^ 3 ≤ R) :
    8192 * (s * c ^ 4 / 22) * c ^ 7 < R * c ^ 14 := by
  let L := s * c ^ 4 / 22
  have hL : 22 * L ≤ s * c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hs_self_cube : s ≤ s ^ 3 := by
    have hs2pos : 0 < s ^ 2 := pow_pos (by omega) _
    have hs2 : 1 ≤ s ^ 2 := by omega
    calc
      s = s * 1 := by ring
      _ ≤ s * s ^ 2 := Nat.mul_le_mul_left s hs2
      _ = s ^ 3 := by ring
  have hsR : s ≤ R := hs_self_cube.trans hs
  have hc3 : 9 ^ 3 ≤ c ^ 3 := Nat.pow_le_pow_left hc 3
  have hconst : 8192 * s < 22 * R * c ^ 3 := by
    nlinarith
  have hc11pos : 0 < c ^ 11 := pow_pos (by omega) _
  have hconstScaled : (8192 * s) * c ^ 11 <
      (22 * R * c ^ 3) * c ^ 11 :=
    (Nat.mul_lt_mul_right hc11pos).2 hconst
  have hleft : 22 * (8192 * L * c ^ 7) ≤
      (8192 * s) * c ^ 11 := by
    calc
      22 * (8192 * L * c ^ 7) = 8192 * (22 * L) * c ^ 7 := by ring
      _ ≤ 8192 * (s * c ^ 4) * c ^ 7 :=
        Nat.mul_le_mul_right (c ^ 7) (Nat.mul_le_mul_left 8192 hL)
      _ = (8192 * s) * c ^ 11 := by ring
  have hchain : 22 * (8192 * L * c ^ 7) <
      22 * (R * c ^ 14) := by
    calc
      _ ≤ (8192 * s) * c ^ 11 := hleft
      _ < (22 * R * c ^ 3) * c ^ 11 := hconstScaled
      _ = 22 * (R * c ^ 14) := by ring
  exact (Nat.mul_lt_mul_left (by norm_num : 0 < 22)).1
    (by simpa [L] using hchain)

/-- The full canonical excess threshold is already larger than twice the
square of the canonical parameter side. -/
theorem canonical_threshold_forces_twice_boxSq
    {c R D : ℕ} (hc : 9 ≤ c) (hR : 6 ≤ R)
    (hthreshold : R * c ^ 14 < 8192 * D) :
    2 * (canonicalBoxM c R) ^ 2 < D := by
  let M := canonicalBoxM c R
  have hM : (4 * R) * M ≤ c ^ 6 := by
    dsimp [M, canonicalBoxM]
    exact Nat.mul_div_le _ _
  have hMsq : ((4 * R) * M) ^ 2 ≤ (c ^ 6) ^ 2 :=
    Nat.pow_le_pow_left hM 2
  have hR3 : 6 ^ 3 ≤ R ^ 3 := Nat.pow_le_pow_left hR 3
  have hc2 : 9 ^ 2 ≤ c ^ 2 := Nat.pow_le_pow_left hc 2
  have hconst : 1024 < R ^ 3 * c ^ 2 := by
    nlinarith
  have hscaledM : 1024 * (((4 * R) * M) ^ 2) ≤
      1024 * ((c ^ 6) ^ 2) := Nat.mul_le_mul_left 1024 hMsq
  have hc12pos : 0 < c ^ 12 := pow_pos (by omega) _
  have hscaledConst : 1024 * c ^ 12 <
      (R ^ 3 * c ^ 2) * c ^ 12 :=
    (Nat.mul_lt_mul_right hc12pos).2 hconst
  have hcancelled : 16384 * M ^ 2 < R * c ^ 14 := by
    have hR2pos : 0 < R ^ 2 := pow_pos (by omega) _
    apply (Nat.mul_lt_mul_left hR2pos).1
    calc
      R ^ 2 * (16384 * M ^ 2) =
          1024 * (((4 * R) * M) ^ 2) := by ring
      _ ≤ 1024 * ((c ^ 6) ^ 2) := hscaledM
      _ = 1024 * c ^ 12 := by ring
      _ < (R ^ 3 * c ^ 2) * c ^ 12 := hscaledConst
      _ = R ^ 2 * (R * c ^ 14) := by ring
  have hfinal : 16384 * M ^ 2 < 8192 * D :=
    hcancelled.trans hthreshold
  change 2 * M ^ 2 < D
  nlinarith

/-! ## Exact arithmetic counterexamples -/

private theorem radical_49 : abcRadical 49 = 7 := by
  rw [show 49 = 7 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime) (by norm_num)]
  norm_num

private theorem radical_121 : abcRadical 121 = 11 := by
  rw [show 121 = 11 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 11).prime) (by norm_num)]
  norm_num

private theorem radical_169 : abcRadical 169 = 13 := by
  rw [show 169 = 13 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 13).prime) (by norm_num)]
  norm_num

private theorem radical_289 : abcRadical 289 = 17 := by
  rw [show 289 = 17 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 17).prime) (by norm_num)]
  norm_num

private theorem radical_361 : abcRadical 361 = 19 := by
  rw [show 361 = 19 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 19).prime) (by norm_num)]
  norm_num

private theorem radical_529 : abcRadical 529 = 23 := by
  rw [show 529 = 23 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 23).prime) (by norm_num)]
  norm_num

private theorem radical_841 : abcRadical 841 = 29 := by
  rw [show 841 = 29 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 29).prime) (by norm_num)]
  norm_num

/-- A nonempty, fully certified template can have `4*M^2/D < 1`; hence an
area-only estimate cannot replace all boundary terms. -/
theorem areaOnlyTemplateBound_counterexample :
    let B : ℕ := 1
    let C : ℕ := 2
    let Q : ℕ := 2
    let p : ℕ × ℕ := (24, 60)
    let dU : ℕ := 49
    let dV : ℕ := 289
    let dW : ℕ := 169
    let L : ℕ := 5
    let T : ℕ := 1500
    let M : ℕ := 60
    0 < B ∧ B < C ∧ 0 < Q ∧ 0 < L ∧ L < T ∧ 0 < M ∧
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M ∧
      Nat.Coprime dU dV ∧ Nat.Coprime dU dW ∧
      Nat.Coprime dV dW ∧
      Nat.Coprime dV C ∧ Nat.Coprime dW B ∧
      Nat.Coprime dU C ∧ Nat.Coprime dW (C - B) ∧
      Nat.Coprime dU B ∧ Nat.Coprime dV (C - B) ∧
      Nat.Coprime dU Q ∧ Nat.Coprime dV Q ∧ Nat.Coprime dW Q ∧
      dU ∣ affineU Q p ∧ dV ∣ affineV Q C p ∧
      dW ∣ affineW Q B p ∧ Nat.Coprime (affineU Q p) p.2 ∧
      affineU Q p = 49 ∧ affineV Q C p = 289 ∧
      affineW Q B p = 169 ∧
      Nat.Coprime (affineU Q p) (affineV Q C p) ∧
      Nat.Coprime (affineU Q p) (affineW Q B p) ∧
      Nat.Coprime (affineV Q C p) (affineW Q B p) ∧
      abcRadical dU = 7 ∧ abcRadical dV = 17 ∧
      abcRadical dW = 13 ∧
      T < dU * dV * dW ∧ (C + 1) ^ 2 * L ^ 3 < T ∧
      L * dU < T ∧ L * dV < T ∧ L * dW < T ∧
      dU / abcRadical dU * (dV / abcRadical dV) *
        (dW / abcRadical dW) = 1547 ∧ T < 1547 ∧
      4 * M ^ 2 < dU * dV * dW := by
  norm_num [affineU, affineV, affineW, radical_49, radical_169,
    radical_289]

/-- Two adjacent affine points can carry two different full certificates,
although each certificate separately satisfies every separation premise.
This refutes transfer of fixed-template separation to a point-adaptive
union. -/
theorem adaptiveTemplateUnion_not_separated_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let Q : ℕ := 6
    let L : ℕ := 1
    let T : ℕ := 2000
    let p : ℕ × ℕ := (861219583918648, 1)
    let q : ℕ × ℕ := (861219583918649, 1)
    let dUp : ℕ := 121
    let dVp : ℕ := 169
    let dWp : ℕ := 289
    let dUq : ℕ := 361
    let dVq : ℕ := 529
    let dWq : ℕ := 841
    let M : ℕ := 861219583918649
    0 < B ∧ B < C ∧ 0 < Q ∧ 0 < L ∧ L < T ∧ 0 < M ∧
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M ∧
      1 ≤ q.1 ∧ q.1 ≤ M ∧ 1 ≤ q.2 ∧ q.2 ≤ M ∧
      p ≠ q ∧ pairSupDist p q = L ∧
      Nat.Coprime (affineU Q p) p.2 ∧
      Nat.Coprime (affineU Q q) q.2 ∧
      affineU Q p = 5167317503511889 ∧
      affineV Q C p = 5167317503511943 ∧
      affineW Q B p = 5167317503511937 ∧
      affineU Q q = 5167317503511895 ∧
      affineV Q C q = 5167317503511949 ∧
      affineW Q B q = 5167317503511943 ∧
      Nat.Coprime (affineU Q p) (affineV Q C p) ∧
      Nat.Coprime (affineU Q p) (affineW Q B p) ∧
      Nat.Coprime (affineV Q C p) (affineW Q B p) ∧
      Nat.Coprime (affineU Q q) (affineV Q C q) ∧
      Nat.Coprime (affineU Q q) (affineW Q B q) ∧
      Nat.Coprime (affineV Q C q) (affineW Q B q) ∧
      dUp ∣ affineU Q p ∧ dVp ∣ affineV Q C p ∧
      dWp ∣ affineW Q B p ∧
      dUq ∣ affineU Q q ∧ dVq ∣ affineV Q C q ∧
      dWq ∣ affineW Q B q ∧
      Nat.Coprime dUp dVp ∧ Nat.Coprime dUp dWp ∧
      Nat.Coprime dVp dWp ∧
      Nat.Coprime dUq dVq ∧ Nat.Coprime dUq dWq ∧
      Nat.Coprime dVq dWq ∧
      Nat.Coprime dVp C ∧ Nat.Coprime dWp B ∧
      Nat.Coprime dUp C ∧ Nat.Coprime dWp (C - B) ∧
      Nat.Coprime dUp B ∧ Nat.Coprime dVp (C - B) ∧
      Nat.Coprime dVq C ∧ Nat.Coprime dWq B ∧
      Nat.Coprime dUq C ∧ Nat.Coprime dWq (C - B) ∧
      Nat.Coprime dUq B ∧ Nat.Coprime dVq (C - B) ∧
      Nat.Coprime dUp Q ∧ Nat.Coprime dVp Q ∧ Nat.Coprime dWp Q ∧
      Nat.Coprime dUq Q ∧ Nat.Coprime dVq Q ∧ Nat.Coprime dWq Q ∧
      abcRadical dUp = 11 ∧ abcRadical dVp = 13 ∧
      abcRadical dWp = 17 ∧ abcRadical dUq = 19 ∧
      abcRadical dVq = 23 ∧ abcRadical dWq = 29 ∧
      T < dUp * dVp * dWp ∧ T < dUq * dVq * dWq ∧
      (C + 1) ^ 2 * L ^ 3 < T ∧
      L * dUp < T ∧ L * dVp < T ∧ L * dWp < T ∧
      L * dUq < T ∧ L * dVq < T ∧ L * dWq < T ∧
      dUp / abcRadical dUp * (dVp / abcRadical dVp) *
        (dWp / abcRadical dWp) = 2431 ∧ T < 2431 ∧
      dUq / abcRadical dUq * (dVq / abcRadical dVq) *
        (dWq / abcRadical dWq) = 12673 ∧ T < 12673 := by
  norm_num [affineU, affineV, affineW, pairSupDist, Nat.dist,
    radical_121, radical_169, radical_289, radical_361, radical_529,
    radical_841]

/-- If the strict entropy conclusion is stated without `κ > 0`, the zero
density, empty-packet specialization satisfies its lower premise but not its
strict conclusion.  The three scale parameters abstract the positive factors
that multiply `κ` in the paper inequality. -/
theorem zeroDensityStrictEntropy_counterexample
    (lowerScale upperScale₁ upperScale₂ : ℝ) :
    let κ : ℝ := 0
    let exceptionalMass : ℝ := 0
    let kernelCount : ℝ := 0
    exceptionalMass ≥ κ * lowerScale ∧
      ¬ kernelCount > max (κ * upperScale₁) (κ * upperScale₂) := by
  simp
#print axioms signedPairDet_eq_zero_of_dvd_of_coordinateBounds
#print axioms threeForm_signedPairDet_eq_zero_of_large_modulusProduct
#print axioms oneDimSeparated_card_le
#print axioms dominantFirstCoordinate_card_le
#print axioms primitive_subcritical_c_ge_nine
#print axioms canonical_cubicThreshold_scale12
#print axioms canonical_longCapThreshold_scale12
#print axioms canonical_cubicThreshold_scale22
#print axioms canonical_longCapThreshold_scale22
#print axioms canonical_threshold_forces_twice_boxSq
#print axioms areaOnlyTemplateBound_counterexample
#print axioms adaptiveTemplateUnion_not_separated_counterexample
#print axioms zeroDensityStrictEntropy_counterexample
end AffineDeterminantLayerEntropy20260901
end IUTThreeClosures
