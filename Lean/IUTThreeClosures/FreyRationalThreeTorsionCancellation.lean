/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyRationalThreeTorsionCore
import Mathlib.Tactic

/-!
# Fixed linear-factor cancellation in the rational three-torsion Frey pair

For the two degree-four source-derived `j`-maps, the variable numerator
factors are `|a-8b|` and `|b-8a|`.  This file proves unconditionally that

* `gcd(|a-8b|, b) = 1`;
* `gcd(|a-8b|, c) | 9`;

and the swapped analogues.  It also records a coarse absolute bound for the
gcd of the cubed linear factor and `c^3`.  No height--conductor estimate is
assumed.
-/

namespace IUTThreeClosures
namespace ABCPoint

/-- Swap the two additive summands of an abc point. -/
def swapAB (P : ABCPoint) : ABCPoint where
  a := P.b
  b := P.a
  c := P.c
  a_pos := P.b_pos
  b_pos := P.a_pos
  c_pos := P.c_pos
  sum_eq := by simpa [Nat.add_comm] using P.sum_eq
  pairwise_coprime :=
    ⟨P.pairwise_coprime.1.symm,
      P.pairwise_coprime.2.2.symm,
      P.pairwise_coprime.2.1.symm⟩

/-- Absolute linear factor in the first oriented `j`-numerator. -/
def threeTorsionJDistanceA (P : ABCPoint) : ℕ :=
  Nat.dist P.a (8 * P.b)

/-- Absolute linear factor after swapping `a` and `b`. -/
def threeTorsionJDistanceB (P : ABCPoint) : ℕ :=
  Nat.dist P.b (8 * P.a)

@[simp] theorem threeTorsionJDistanceA_swapAB (P : ABCPoint) :
    P.swapAB.threeTorsionJDistanceA = P.threeTorsionJDistanceB := by
  rfl

/-- The first distance is coprime to the opposite summand. -/
theorem threeTorsionJDistanceA_coprime_b (P : ABCPoint) :
    Nat.Coprime P.threeTorsionJDistanceA P.b := by
  rw [Nat.coprime_iff_gcd_eq_one]
  apply Nat.eq_one_of_dvd_coprimes P.pairwise_coprime.1
  · by_cases h : P.a ≤ 8 * P.b
    · have hdist :
          P.threeTorsionJDistanceA = 8 * P.b - P.a := by
        exact Nat.dist_eq_sub_of_le h
      have hsum : P.threeTorsionJDistanceA + P.a = 8 * P.b := by
        rw [hdist]
        omega
      have hd8b :
          Nat.gcd P.threeTorsionJDistanceA P.b ∣ 8 * P.b :=
        dvd_mul_of_dvd_right
          (Nat.gcd_dvd_right P.threeTorsionJDistanceA P.b) 8
      have hdsum :
          Nat.gcd P.threeTorsionJDistanceA P.b ∣
            P.threeTorsionJDistanceA + P.a := by
        rw [hsum]
        exact hd8b
      exact
        (Nat.dvd_add_iff_left
          (Nat.gcd_dvd_left P.threeTorsionJDistanceA P.b)).mp hdsum
    · have hle : 8 * P.b ≤ P.a := Nat.le_of_not_ge h
      have hdist :
          P.threeTorsionJDistanceA = P.a - 8 * P.b := by
        exact Nat.dist_eq_sub_of_le_right hle
      have hsum : P.threeTorsionJDistanceA + 8 * P.b = P.a := by
        rw [hdist]
        omega
      have hd8b :
          Nat.gcd P.threeTorsionJDistanceA P.b ∣ 8 * P.b :=
        dvd_mul_of_dvd_right
          (Nat.gcd_dvd_right P.threeTorsionJDistanceA P.b) 8
      have hda :
          Nat.gcd P.threeTorsionJDistanceA P.b ∣
            P.threeTorsionJDistanceA + 8 * P.b :=
        dvd_add (Nat.gcd_dvd_left _ _) hd8b
      rw [hsum] at hda
      exact hda
  · exact Nat.gcd_dvd_right _ _

/-- Swapped coprimality statement. -/
theorem threeTorsionJDistanceB_coprime_a (P : ABCPoint) :
    Nat.Coprime P.threeTorsionJDistanceB P.a := by
  simpa using P.swapAB.threeTorsionJDistanceA_coprime_b

/-- Any common divisor of `|a-8b|` and `c` divides `9`. -/
theorem gcd_threeTorsionJDistanceA_c_dvd_nine (P : ABCPoint) :
    Nat.gcd P.threeTorsionJDistanceA P.c ∣ 9 := by
  let d : ℕ := Nat.gcd P.threeTorsionJDistanceA P.c
  have hdx : d ∣ P.threeTorsionJDistanceA := Nat.gcd_dvd_left _ _
  have hdc : d ∣ P.c := Nat.gcd_dvd_right _ _
  have hd9a : d ∣ 9 * P.a := by
    by_cases h : P.a ≤ 8 * P.b
    · have hdist :
          P.threeTorsionJDistanceA = 8 * P.b - P.a := by
        exact Nat.dist_eq_sub_of_le h
      have hsum :
          P.threeTorsionJDistanceA + 9 * P.a = 8 * P.c := by
        rw [hdist, ← P.sum_eq]
        omega
      have hd8c : d ∣ 8 * P.c := dvd_mul_of_dvd_right hdc 8
      have hdsum :
          d ∣ P.threeTorsionJDistanceA + 9 * P.a := by
        rw [hsum]
        exact hd8c
      exact (Nat.dvd_add_iff_left hdx).mp hdsum
    · have hle : 8 * P.b ≤ P.a := Nat.le_of_not_ge h
      have hdist :
          P.threeTorsionJDistanceA = P.a - 8 * P.b := by
        exact Nat.dist_eq_sub_of_le_right hle
      have hsum :
          P.threeTorsionJDistanceA + 8 * P.c = 9 * P.a := by
        rw [hdist, ← P.sum_eq]
        omega
      have hd8c : d ∣ 8 * P.c := dvd_mul_of_dvd_right hdc 8
      have hd : d ∣ P.threeTorsionJDistanceA + 8 * P.c :=
        dvd_add hdx hd8c
      rw [hsum] at hd
      exact hd
  have hcop : Nat.Coprime d P.a :=
    P.coprime_a_c.symm.of_dvd_left hdc
  exact hcop.dvd_mul_right.mp hd9a

/-- Swapped fixed gcd statement. -/
theorem gcd_threeTorsionJDistanceB_c_dvd_nine (P : ABCPoint) :
    Nat.gcd P.threeTorsionJDistanceB P.c ∣ 9 := by
  simpa using P.swapAB.gcd_threeTorsionJDistanceA_c_dvd_nine

/-- Coarse absolute bound after cubing both factors. -/
theorem gcd_threeTorsionJDistanceA_cube_c_cube_dvd (P : ABCPoint) :
    Nat.gcd (P.threeTorsionJDistanceA ^ 3) (P.c ^ 3) ∣
      (9 ^ 3) ^ 3 := by
  have h₁ :
      Nat.gcd (P.threeTorsionJDistanceA ^ 3) (P.c ^ 3) ∣
        Nat.gcd P.threeTorsionJDistanceA (P.c ^ 3) ^ 3 :=
    gcd_pow_left_dvd_pow_gcd
  have h₂ :
      Nat.gcd P.threeTorsionJDistanceA (P.c ^ 3) ∣
        Nat.gcd P.threeTorsionJDistanceA P.c ^ 3 :=
    gcd_pow_right_dvd_pow_gcd
  exact h₁.trans <|
    (pow_dvd_pow_of_dvd h₂ 3).trans <|
      pow_dvd_pow_of_dvd
        (pow_dvd_pow_of_dvd P.gcd_threeTorsionJDistanceA_c_dvd_nine 3) 3

/-- Swapped cube-gcd bound. -/
theorem gcd_threeTorsionJDistanceB_cube_c_cube_dvd (P : ABCPoint) :
    Nat.gcd (P.threeTorsionJDistanceB ^ 3) (P.c ^ 3) ∣
      (9 ^ 3) ^ 3 := by
  simpa using P.swapAB.gcd_threeTorsionJDistanceA_cube_c_cube_dvd

#print axioms ABCPoint.threeTorsionJDistanceA_coprime_b
#print axioms ABCPoint.threeTorsionJDistanceB_coprime_a
#print axioms ABCPoint.gcd_threeTorsionJDistanceA_c_dvd_nine
#print axioms ABCPoint.gcd_threeTorsionJDistanceB_c_dvd_nine
#print axioms ABCPoint.gcd_threeTorsionJDistanceA_cube_c_cube_dvd
#print axioms ABCPoint.gcd_threeTorsionJDistanceB_cube_c_cube_dvd

end ABCPoint
end IUTThreeClosures
