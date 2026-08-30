/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyRationalThreeTorsionCore
import Mathlib.Tactic

/-!
# Fixed cancellation in the rational three-torsion Frey pair

The two source-derived degree-four `j`-maps have raw numerator/denominator
pairs

`27*a*|a-8b|^3 / (b*c^3)` and
`27*b*|b-8a|^3 / (a*c^3)`.

This module proves that cancellation in either fraction is bounded by one
absolute integer.  The key arithmetic facts are

* `gcd(|a-8b|, b) = 1`;
* `gcd(|a-8b|, c) | 9`;

and their swapped analogues.  Consequently the reduced denominator pair still
has quartic source height.  These are unconditional arithmetic statements; no
height--conductor inequality or abc statement is assumed.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

namespace ABCPoint

/-- Swap the two additive summands of an abc point. -/
def swapAB (P : ABCPoint) : ABCPoint where
  a := P.b
  b := P.a
  c := P.c
  a_pos := P.b_pos
  b_pos := P.a_pos
n  c_pos := P.c_pos
  sum_eq := by simpa [Nat.add_comm] using P.sum_eq
  pairwise_coprime :=
    ⟨P.pairwise_coprime.1.symm,
      P.pairwise_coprime.2.2.symm,
      P.pairwise_coprime.2.1.symm⟩

@[simp] theorem swapAB_a (P : ABCPoint) : P.swapAB.a = P.b := rfl
@[simp] theorem swapAB_b (P : ABCPoint) : P.swapAB.b = P.a := rfl
@[simp] theorem swapAB_c (P : ABCPoint) : P.swapAB.c = P.c := rfl

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

/-- Any common divisor of `|a-8b|` and `c` divides the fixed integer `9`. -/
theorem gcd_threeTorsionJDistanceA_c_dvd_nine (P : ABCPoint) :
    Nat.gcd P.threeTorsionJDistanceA P.c ∣ 9 := by
  let d : ℕ := Nat.gcd P.threeTorsionJDistanceA P.c
  have hdx : d ∣ P.threeTorsionJDistanceA := by
    exact Nat.gcd_dvd_left _ _
  have hdc : d ∣ P.c := by
    exact Nat.gcd_dvd_right _ _
  have hd9a : d ∣ 9 * P.a := by
    by_cases h : P.a ≤ 8 * P.b
    · have hdist :
          P.threeTorsionJDistanceA = 8 * P.b - P.a := by
        exact Nat.dist_eq_sub_of_le h
      have hsum :
          P.threeTorsionJDistanceA + 9 * P.a = 8 * P.c := by
        rw [hdist, ← P.sum_eq]
        omega
      have hd8c : d ∣ 8 * P.c :=
        dvd_mul_of_dvd_right hdc 8
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
      have hd8c : d ∣ 8 * P.c :=
        dvd_mul_of_dvd_right hdc 8
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

/-- A deliberately coarse but absolute power bound for the cubed distance
against `c^3`.  Applying the generic gcd-power inequality twice gives the
ninth power of the base gcd. -/
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

/-- Raw absolute numerator of the first rational `j` expression. -/
def threeTorsionJRawNumA (P : ABCPoint) : ℕ :=
  27 * P.a * P.threeTorsionJDistanceA ^ 3

/-- Raw absolute numerator after swapping the two summands. -/
def threeTorsionJRawNumB (P : ABCPoint) : ℕ :=
  27 * P.b * P.threeTorsionJDistanceB ^ 3

@[simp] theorem threeTorsionJRawNumA_swapAB (P : ABCPoint) :
    P.swapAB.threeTorsionJRawNumA = P.threeTorsionJRawNumB := by
  rfl

@[simp] theorem threeTorsionJRawDenA_swapAB (P : ABCPoint) :
    P.swapAB.threeTorsionJRawDenA = P.threeTorsionJRawDenB := by
  rfl

/-- Absolute cancellation constant used below.  The value is intentionally
coarse: only source-independence matters for the height corridor. -/
def threeTorsionCancellationConstant : ℕ :=
  27 * (27 * ((9 ^ 3) ^ 3))

@[simp] theorem threeTorsionCancellationConstant_pos :
    0 < threeTorsionCancellationConstant := by
  norm_num [threeTorsionCancellationConstant]

/-- The raw first numerator shares with `b` only a divisor of `27`. -/
theorem gcd_threeTorsionJRawNumA_b_dvd_twentySeven (P : ABCPoint) :
    Nat.gcd P.threeTorsionJRawNumA P.b ∣ 27 := by
  let d : ℕ := Nat.gcd P.threeTorsionJRawNumA P.b
  have hdr : d ∣ P.threeTorsionJRawNumA := Nat.gcd_dvd_left _ _
  have hdb : d ∣ P.b := Nat.gcd_dvd_right _ _
  have hprodCop : Nat.Coprime (P.a * P.threeTorsionJDistanceA ^ 3) P.b := by
    rw [Nat.coprime_mul_iff_left]
    exact ⟨P.pairwise_coprime.1,
      P.threeTorsionJDistanceA_coprime_b.pow_left 3⟩
  have hcop : Nat.Coprime d (P.a * P.threeTorsionJDistanceA ^ 3) :=
    hprodCop.symm.of_dvd_left hdb
  have hdr' : d ∣ 27 * (P.a * P.threeTorsionJDistanceA ^ 3) := by
    simpa [threeTorsionJRawNumA, mul_assoc] using hdr
  exact hcop.dvd_mul_right.mp hdr'

/-- Swapped version of the opposite-summand cancellation bound. -/
theorem gcd_threeTorsionJRawNumB_a_dvd_twentySeven (P : ABCPoint) :
    Nat.gcd P.threeTorsionJRawNumB P.a ∣ 27 := by
  simpa using P.swapAB.gcd_threeTorsionJRawNumA_b_dvd_twentySeven

/-- The first raw numerator and `c^3` have uniformly bounded gcd. -/
theorem gcd_threeTorsionJRawNumA_c_cube_dvd (P : ABCPoint) :
    Nat.gcd P.threeTorsionJRawNumA (P.c ^ 3) ∣
      27 * ((9 ^ 3) ^ 3) := by
  have hsplit₁ :
      Nat.gcd (P.c ^ 3) P.threeTorsionJRawNumA ∣
        Nat.gcd (P.c ^ 3) 27 *
          Nat.gcd (P.c ^ 3)
            (P.a * P.threeTorsionJDistanceA ^ 3) := by
    simpa [threeTorsionJRawNumA, mul_assoc] using
      (gcd_mul_dvd_mul_gcd (P.c ^ 3) 27
        (P.a * P.threeTorsionJDistanceA ^ 3))
  have hca : Nat.gcd (P.c ^ 3) P.a = 1 :=
    (P.coprime_a_c.symm.pow_left 3).gcd_eq_one
  have hsplit₂ :
      Nat.gcd (P.c ^ 3)
          (P.a * P.threeTorsionJDistanceA ^ 3) ∣
        Nat.gcd (P.c ^ 3) P.a *
          Nat.gcd (P.c ^ 3) (P.threeTorsionJDistanceA ^ 3) :=
    gcd_mul_dvd_mul_gcd (P.c ^ 3) P.a
      (P.threeTorsionJDistanceA ^ 3)
  have hsecond :
      Nat.gcd (P.c ^ 3)
          (P.a * P.threeTorsionJDistanceA ^ 3) ∣
        (9 ^ 3) ^ 3 := by
    rw [hca, one_mul] at hsplit₂
    exact hsplit₂.trans <| by
      simpa [Nat.gcd_comm] using
        P.gcd_threeTorsionJDistanceA_cube_c_cube_dvd
  have hproduct :
      Nat.gcd (P.c ^ 3) 27 *
          Nat.gcd (P.c ^ 3)
            (P.a * P.threeTorsionJDistanceA ^ 3) ∣
        27 * ((9 ^ 3) ^ 3) :=
    Nat.mul_dvd_mul (Nat.gcd_dvd_right _ _) hsecond
  have hcomm :
      Nat.gcd P.threeTorsionJRawNumA (P.c ^ 3) ∣
        Nat.gcd (P.c ^ 3) P.threeTorsionJRawNumA := by
    rw [Nat.gcd_comm]
  exact hcomm.trans (hsplit₁.trans hproduct)

/-- Swapped numerator--`c^3` bound. -/
theorem gcd_threeTorsionJRawNumB_c_cube_dvd (P : ABCPoint) :
    Nat.gcd P.threeTorsionJRawNumB (P.c ^ 3) ∣
      27 * ((9 ^ 3) ^ 3) := by
  simpa using P.swapAB.gcd_threeTorsionJRawNumA_c_cube_dvd

/-- Gcd content removed from the first raw rational `j` expression. -/
def threeTorsionJContentA (P : ABCPoint) : ℕ :=
  Nat.gcd P.threeTorsionJRawNumA P.threeTorsionJRawDenA

/-- Swapped gcd content. -/
def threeTorsionJContentB (P : ABCPoint) : ℕ :=
  Nat.gcd P.threeTorsionJRawNumB P.threeTorsionJRawDenB

@[simp] theorem threeTorsionJContentA_swapAB (P : ABCPoint) :
    P.swapAB.threeTorsionJContentA = P.threeTorsionJContentB := by
  rfl

/-- Cancellation in the first orientation is bounded by one absolute integer. -/
theorem threeTorsionJContentA_dvd_constant (P : ABCPoint) :
    P.threeTorsionJContentA ∣ threeTorsionCancellationConstant := by
  have hsplit :
      Nat.gcd P.threeTorsionJRawNumA
          (P.b * P.c ^ 3) ∣
        Nat.gcd P.threeTorsionJRawNumA P.b *
          Nat.gcd P.threeTorsionJRawNumA (P.c ^ 3) :=
    gcd_mul_dvd_mul_gcd P.threeTorsionJRawNumA P.b (P.c ^ 3)
  have hproduct :
      Nat.gcd P.threeTorsionJRawNumA P.b *
          Nat.gcd P.threeTorsionJRawNumA (P.c ^ 3) ∣
        threeTorsionCancellationConstant := by
    unfold threeTorsionCancellationConstant
    exact Nat.mul_dvd_mul
      P.gcd_threeTorsionJRawNumA_b_dvd_twentySeven
      P.gcd_threeTorsionJRawNumA_c_cube_dvd
  simpa [threeTorsionJContentA, threeTorsionJRawDenA] using
    hsplit.trans hproduct

/-- Swapped fixed cancellation bound. -/
theorem threeTorsionJContentB_dvd_constant (P : ABCPoint) :
    P.threeTorsionJContentB ∣ threeTorsionCancellationConstant := by
  simpa using P.swapAB.threeTorsionJContentA_dvd_constant

/-- Reduced denominator in the first orientation. -/
def threeTorsionJReducedDenA (P : ABCPoint) : ℕ :=
  P.threeTorsionJRawDenA / P.threeTorsionJContentA

/-- Reduced denominator in the swapped orientation. -/
def threeTorsionJReducedDenB (P : ABCPoint) : ℕ :=
  P.threeTorsionJRawDenB / P.threeTorsionJContentB

@[simp] theorem threeTorsionJReducedDenA_swapAB (P : ABCPoint) :
    P.swapAB.threeTorsionJReducedDenA = P.threeTorsionJReducedDenB := by
  rfl

@[simp] theorem threeTorsionJRawDenA_pos (P : ABCPoint) :
    0 < P.threeTorsionJRawDenA := by
  unfold threeTorsionJRawDenA
  exact mul_pos P.b_pos (pow_pos P.c_pos 3)

@[simp] theorem threeTorsionJRawDenB_pos (P : ABCPoint) :
    0 < P.threeTorsionJRawDenB := by
  unfold threeTorsionJRawDenB
  exact mul_pos P.a_pos (pow_pos P.c_pos 3)

@[simp] theorem threeTorsionJContentA_pos (P : ABCPoint) :
    0 < P.threeTorsionJContentA := by
  unfold threeTorsionJContentA
  exact Nat.gcd_pos_of_pos_right _ P.threeTorsionJRawDenA_pos

@[simp] theorem threeTorsionJContentB_pos (P : ABCPoint) :
    0 < P.threeTorsionJContentB := by
  unfold threeTorsionJContentB
  exact Nat.gcd_pos_of_pos_right _ P.threeTorsionJRawDenB_pos

/-- Recover the first raw denominator from its reduced denominator and content. -/
theorem threeTorsionJReducedDenA_mul_content (P : ABCPoint) :
    P.threeTorsionJReducedDenA * P.threeTorsionJContentA =
      P.threeTorsionJRawDenA := by
  exact Nat.div_mul_cancel
    (Nat.gcd_dvd_right P.threeTorsionJRawNumA P.threeTorsionJRawDenA)

/-- Swapped reconstruction identity. -/
theorem threeTorsionJReducedDenB_mul_content (P : ABCPoint) :
    P.threeTorsionJReducedDenB * P.threeTorsionJContentB =
      P.threeTorsionJRawDenB := by
  exact Nat.div_mul_cancel
    (Nat.gcd_dvd_right P.threeTorsionJRawNumB P.threeTorsionJRawDenB)

/-- The first raw denominator is at most the fixed cancellation constant times
the reduced denominator. -/
theorem threeTorsionJRawDenA_le_constant_mul_reducedDen (P : ABCPoint) :
    P.threeTorsionJRawDenA ≤
      threeTorsionCancellationConstant * P.threeTorsionJReducedDenA := by
  have hcontent :
      P.threeTorsionJContentA ≤ threeTorsionCancellationConstant :=
    Nat.le_of_dvd threeTorsionCancellationConstant_pos
      P.threeTorsionJContentA_dvd_constant
  rw [← P.threeTorsionJReducedDenA_mul_content]
  simpa [Nat.mul_comm] using
    Nat.mul_le_mul_left P.threeTorsionJReducedDenA hcontent

/-- Swapped raw-to-reduced denominator comparison. -/
theorem threeTorsionJRawDenB_le_constant_mul_reducedDen (P : ABCPoint) :
    P.threeTorsionJRawDenB ≤
      threeTorsionCancellationConstant * P.threeTorsionJReducedDenB := by
  simpa using P.swapAB.threeTorsionJRawDenA_le_constant_mul_reducedDen

/-- The pair of actual reduced denominators retains quartic source growth. -/
theorem c_pow_four_le_fixed_mul_max_threeTorsionJReducedDen (P : ABCPoint) :
    P.c ^ 4 ≤
      (2 * threeTorsionCancellationConstant) *
        max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB := by
  have hA :
      P.threeTorsionJRawDenA ≤
        threeTorsionCancellationConstant *
          max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB :=
    P.threeTorsionJRawDenA_le_constant_mul_reducedDen.trans
      (Nat.mul_le_mul_left _ (le_max_left _ _))
  have hB :
      P.threeTorsionJRawDenB ≤
        threeTorsionCancellationConstant *
          max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB :=
    P.threeTorsionJRawDenB_le_constant_mul_reducedDen.trans
      (Nat.mul_le_mul_left _ (le_max_right _ _))
  have hmax :
      max P.threeTorsionJRawDenA P.threeTorsionJRawDenB ≤
        threeTorsionCancellationConstant *
          max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB :=
    max_le hA hB
  calc
    P.c ^ 4 ≤
        2 * max P.threeTorsionJRawDenA P.threeTorsionJRawDenB :=
      P.c_pow_four_le_two_mul_max_threeTorsionJRawDen
    _ ≤ 2 *
        (threeTorsionCancellationConstant *
          max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB) :=
      Nat.mul_le_mul_left 2 hmax
    _ = (2 * threeTorsionCancellationConstant) *
        max P.threeTorsionJReducedDenA P.threeTorsionJReducedDenB := by
      ring

#print axioms ABCPoint.threeTorsionJDistanceA_coprime_b
#print axioms ABCPoint.gcd_threeTorsionJDistanceA_c_dvd_nine
#print axioms ABCPoint.gcd_threeTorsionJDistanceA_cube_c_cube_dvd
#print axioms ABCPoint.threeTorsionJContentA_dvd_constant
#print axioms ABCPoint.threeTorsionJContentB_dvd_constant
#print axioms ABCPoint.c_pow_four_le_fixed_mul_max_threeTorsionJReducedDen

end ABCPoint
end IUTThreeClosures
