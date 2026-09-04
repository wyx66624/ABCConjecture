/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic

/-!
# Exact cross-endpoint contact depths

For canonical data

`R*A + m = S*B`,

with `A` and `B` squarefree, a prime shared by `R` and `A` occurs in `R*A`
with exponent exactly `v_p(R)+1`.  Consequently its exact contact depth in
`S*B-m` is `v_p(R)+1`.  The right side is symmetric.

Thus the two modulus exponent vectors are precisely the excess p-adic contact
depths of the opposite endpoint against the gap.  No height estimate or abc
hypothesis is introduced.
-/

namespace IUTThreeClosures
namespace CanonicalEndpointContactDepth

open scoped BigOperators

/-- Multiplication by a squarefree residual containing `p` adds exactly one to
the `p`-adic exponent. -/
theorem factorization_mul_squarefree_eq_add_one
    {U A p : ℕ}
    (hU : U ≠ 0)
    (hA : A ≠ 0)
    (hp : p.Prime)
    (hAsq : Squarefree A)
    (hpA : p ∣ A) :
    (U * A).factorization p = U.factorization p + 1 := by
  rw [Nat.factorization_mul hU hA]
  rw [Nat.factorization_eq_one_of_squarefree hAsq hp hpA]
  rfl

/-- Exact left cross-contact depth. -/
theorem left_cross_contact_depth
    {R S A B m p : ℕ}
    (hR : R ≠ 0)
    (hA : A ≠ 0)
    (hAsq : Squarefree A)
    (hp : p.Prime)
    (hpA : p ∣ A)
    (hsum : R * A + m = S * B) :
    (S * B - m).factorization p = R.factorization p + 1 := by
  have hsub : S * B - m = R * A := by omega
  rw [hsub]
  exact factorization_mul_squarefree_eq_add_one hR hA hp hAsq hpA

/-- Exact right cross-contact depth. -/
theorem right_cross_contact_depth
    {R S A B m q : ℕ}
    (hS : S ≠ 0)
    (hB : B ≠ 0)
    (hBsq : Squarefree B)
    (hq : q.Prime)
    (hqB : q ∣ B)
    (hsum : R * A + m = S * B) :
    (R * A + m).factorization q = S.factorization q + 1 := by
  rw [hsum]
  exact factorization_mul_squarefree_eq_add_one hS hB hq hBsq hqB

/-- The exact left contact prime power divides the opposite endpoint minus the
gap. -/
theorem left_contact_prime_pow_dvd
    {R S A B m p : ℕ}
    (hR : 0 < R)
    (hA : 0 < A)
    (hAsq : Squarefree A)
    (hp : p.Prime)
    (hpA : p ∣ A)
    (hsum : R * A + m = S * B) :
    p ^ (R.factorization p + 1) ∣ S * B - m := by
  have htarget : S * B - m ≠ 0 := by
    have hsub : S * B - m = R * A := by omega
    rw [hsub]
    exact (mul_pos hR hA).ne'
  apply (hp.pow_dvd_iff_le_factorization htarget).2
  rw [left_cross_contact_depth hR.ne' hA.ne' hAsq hp hpA hsum]

/-- The next left prime power does not divide. -/
theorem left_contact_next_prime_pow_not_dvd
    {R S A B m p : ℕ}
    (hR : 0 < R)
    (hA : 0 < A)
    (hAsq : Squarefree A)
    (hp : p.Prime)
    (hpA : p ∣ A)
    (hsum : R * A + m = S * B) :
    ¬ p ^ (R.factorization p + 2) ∣ S * B - m := by
  have htarget : S * B - m ≠ 0 := by
    have hsub : S * B - m = R * A := by omega
    rw [hsub]
    exact (mul_pos hR hA).ne'
  intro hdiv
  have hle := (hp.pow_dvd_iff_le_factorization htarget).1 hdiv
  rw [left_cross_contact_depth hR.ne' hA.ne' hAsq hp hpA hsum] at hle
  omega

/-- The exact right contact prime power divides the opposite endpoint plus the
gap. -/
theorem right_contact_prime_pow_dvd
    {R S A B m q : ℕ}
    (hS : 0 < S)
    (hB : 0 < B)
    (hBsq : Squarefree B)
    (hq : q.Prime)
    (hqB : q ∣ B)
    (hsum : R * A + m = S * B) :
    q ^ (S.factorization q + 1) ∣ R * A + m := by
  have htarget : R * A + m ≠ 0 := by
    rw [hsum]
    exact (mul_pos hS hB).ne'
  apply (hq.pow_dvd_iff_le_factorization htarget).2
  rw [right_cross_contact_depth hS.ne' hB.ne' hBsq hq hqB hsum]

/-- The next right prime power does not divide. -/
theorem right_contact_next_prime_pow_not_dvd
    {R S A B m q : ℕ}
    (hS : 0 < S)
    (hB : 0 < B)
    (hBsq : Squarefree B)
    (hq : q.Prime)
    (hqB : q ∣ B)
    (hsum : R * A + m = S * B) :
    ¬ q ^ (S.factorization q + 2) ∣ R * A + m := by
  have htarget : R * A + m ≠ 0 := by
    rw [hsum]
    exact (mul_pos hS hB).ne'
  intro hdiv
  have hle := (hq.pow_dvd_iff_le_factorization htarget).1 hdiv
  rw [right_cross_contact_depth hS.ne' hB.ne' hBsq hq hqB hsum] at hle
  omega

/-- Contact depth minus the squarefree residual layer is exactly the weighted
modulus-exponent height. -/
theorem weighted_contact_excess_eq_exponent_height
    {ι : Type*}
    (s : Finset ι)
    (weight : ι → ℝ)
    (exponent depth : ι → ℕ)
    (hdepth : ∀ i ∈ s, depth i = exponent i + 1) :
    ∑ i ∈ s, ((depth i : ℝ) - 1) * weight i =
      ∑ i ∈ s, (exponent i : ℝ) * weight i := by
  apply Finset.sum_congr rfl
  intro i hi
  rw [hdepth i hi]
  push_cast
  ring

#print axioms factorization_mul_squarefree_eq_add_one
#print axioms left_cross_contact_depth
#print axioms right_cross_contact_depth
#print axioms left_contact_prime_pow_dvd
#print axioms left_contact_next_prime_pow_not_dvd
#print axioms right_contact_prime_pow_dvd
#print axioms right_contact_next_prime_pow_not_dvd
#print axioms weighted_contact_excess_eq_exponent_height

end CanonicalEndpointContactDepth
end IUTThreeClosures
