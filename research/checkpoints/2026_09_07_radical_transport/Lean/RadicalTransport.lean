import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Actual integer radicals under two successive norm transforms

The elementary gcd proof is the same argument as the repository's
`FreyBranchQuarticINat_coprime_branchProduct`. We give its small standalone dependency here.
This module does not assert existence of a compressed family or an ABC counterexample.
-/

namespace RadicalTransport

open UniqueFactorizationMonoid

def normForm (a b : ℕ) : ℕ := a ^ 2 + a * b + b ^ 2

/-- The norm transform preserves addition. -/
theorem transform_addition (a b : ℕ) : a * b + normForm a b = (a + b) ^ 2 := by
  simp [normForm]
  ring

/-- The norm is coprime to the entire original boundary. -/
theorem norm_coprime_boundary {a b : ℕ} (hab : a.Coprime b) :
    (normForm a b).Coprime (a * b * (a + b)) := by
  have ha : (normForm a b).Coprime a := by
    rw [Nat.coprime_comm]
    unfold normForm
    rw [show a ^ 2 + a * b + b ^ 2 = b ^ 2 + a * (a + b) by ring]
    simpa using hab.pow_right 2
  have hb : (normForm a b).Coprime b := by
    unfold normForm
    rw [show a ^ 2 + a * b + b ^ 2 = a ^ 2 + b * (a + b) by ring]
    simpa using hab.pow_left 2
  have hc : (normForm a b).Coprime (a + b) := by
    rw [Nat.coprime_comm]
    unfold normForm
    rw [show a ^ 2 + a * b + b ^ 2 = b ^ 2 + a * (a + b) by ring]
    rw [Nat.coprime_add_mul_right_right]
    simpa using (Nat.coprime_add_self_left.mpr hab).pow_right 2
  exact (ha.mul_right hb).mul_right hc

/-- In particular the transformed summands remain coprime. -/
theorem transform_coprime {a b : ℕ} (hab : a.Coprime b) :
    (a * b).Coprime (normForm a b) := by
  exact ((Nat.coprime_mul_iff_right.mp (norm_coprime_boundary hab)).1).symm

/-- Radicals of overlapping positive factors satisfy the required product bound. -/
theorem radical_product_le {x y : ℕ} (hx : 0 < x) (hy : 0 < y) :
    radical (x * y) ≤ x * y := by
  exact Nat.radical_le_self_iff.mpr (Nat.mul_pos hx hy).ne'

/-- Shared support is allowed in the actual radical compression bound. -/
theorem compressed_radical_le {d V Q g : ℕ} (hd : 0 < d) (hV : 0 < V)
    (hQ : 0 < Q) (hg : 0 < g) : radical (d * V * Q ^ g) ≤ d * V * Q := by
  have hdiv : radical (d * V * Q ^ g) ∣ radical (d * V) * radical Q := by
    simpa only [radical_pow Q hg.ne'] using
      (radical_mul_dvd (a := d * V) (b := Q ^ g))
  exact (Nat.le_of_dvd (Nat.mul_pos (Nat.radical_pos _) (Nat.radical_pos _)) hdiv).trans
    (Nat.mul_le_mul (radical_product_le hd hV) (Nat.radical_le_self_iff.mpr hQ.ne'))

/-- The first transform charges the new norm radical exactly once. -/
theorem one_step_radical {a b : ℕ} (hab : a.Coprime b) :
    radical (a * b * normForm a b * (a + b) ^ 2) =
      radical (a * b * (a + b)) * radical (normForm a b) := by
  have hn := norm_coprime_boundary hab
  have hnc := (Nat.coprime_mul_iff_right.mp hn).2
  have hnab := (Nat.coprime_mul_iff_right.mp hn).1
  have habc : (a * b).Coprime (a + b) :=
    (Nat.coprime_self_add_right.mpr hab).mul_left
      (Nat.coprime_add_self_right.mpr hab.symm)
  rw [show a * b * normForm a b * (a + b) ^ 2 =
    (a * b * (a + b) ^ 2) * normForm a b by ring]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    ((hnab.mul_right (hnc.pow_right 2)).symm))]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp (habc.pow_right 2)),
    radical_pow (a + b) (by decide : (2 : ℕ) ≠ 0),
    radical_mul (Nat.coprime_iff_isRelPrime.mp habc)]

/-- The second transformed triple has height equal to the fourth power of the seed height. -/
theorem two_step_addition (a b : ℕ) :
    a * b * normForm a b + normForm (a * b) (normForm a b) = (a + b) ^ 4 := by
  rw [transform_addition, transform_addition]
  ring

/-- Two consecutive norm radicals have disjoint prime support from the old boundary. -/
theorem two_step_radical {a b : ℕ} (hab : a.Coprime b) :
    radical (a * b * normForm a b * normForm (a * b) (normForm a b) * (a + b) ^ 4) =
      radical (a * b * (a + b)) * radical (normForm a b) *
        radical (normForm (a * b) (normForm a b)) := by
  have hs := one_step_radical (transform_coprime hab)
  rw [transform_addition] at hs
  rw [show ((a + b) ^ 2) ^ 2 = (a + b) ^ 4 by ring] at hs
  rw [hs, one_step_radical hab]

/-- An explicit integer gate gives the full second boundary radical bound. -/
theorem two_step_radical_gate {a b : ℕ} (ha : 0 < a) (hb : 0 < b)
    (hab : a.Coprime b)
    (hgate : (radical (normForm a b) * radical (normForm (a * b) (normForm a b))) ^ 5 ≤
      a + b) :
    radical (a * b * normForm a b * normForm (a * b) (normForm a b) * (a + b) ^ 4) ^ 5 ≤
      (a + b) ^ 16 := by
  have hbase : radical (a * b * (a + b)) ≤ (a + b) ^ 3 := by
    apply (Nat.radical_le_self_iff.mpr (by positivity)).trans
    nlinarith [Nat.mul_le_mul (Nat.le_add_right a b) (Nat.le_add_left b a)]
  rw [two_step_radical hab, mul_assoc, mul_pow]
  calc
    radical (a * b * (a + b)) ^ 5 *
        (radical (normForm a b) * radical (normForm (a * b) (normForm a b))) ^ 5 ≤
        ((a + b) ^ 3) ^ 5 * (a + b) := Nat.mul_le_mul (Nat.pow_le_pow_left hbase 5) hgate
    _ = (a + b) ^ 16 := by ring

end RadicalTransport

#print axioms RadicalTransport.transform_addition
#print axioms RadicalTransport.norm_coprime_boundary
#print axioms RadicalTransport.transform_coprime
#print axioms RadicalTransport.radical_product_le
#print axioms RadicalTransport.compressed_radical_le
#print axioms RadicalTransport.one_step_radical
#print axioms RadicalTransport.two_step_addition
#print axioms RadicalTransport.two_step_radical
#print axioms RadicalTransport.two_step_radical_gate
