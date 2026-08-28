/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor

/-!
# Prime-power low-radical-neighbour transfer for the abc conjecture

This file isolates the deterministic arithmetic core of a possible disproof route.
Given a prime power `p^k`, a coprime integer `c > p^k`, and
`a = c - p^k`, the triple `(a, p^k, c)` is a genuine `ABCPoint`.
If `a ≤ H` and `abcRadical c ≤ R`, then

`abcRadical (a * p^k * c) ≤ H * p * R`.

A separate logarithmic certificate records that the right-hand side has exponent
strictly below the abc threshold. An unbounded family of such certificates
contradicts `ABCConjecture`.

No theorem in this file asserts the analytic existence of low-radical neighbours.
That existence statement is intentionally left outside the deterministic transfer.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

/-- Arithmetic data for a neighbour immediately to the right of a prime power. -/
structure PrimePowerNeighbourData where
  p : ℕ
  k : ℕ
  c : ℕ
  prime_p : p.Prime
  k_pos : 0 < k
  power_lt_c : p ^ k < c
  p_not_dvd_c : ¬ p ∣ c

namespace PrimePowerNeighbourData

/-- The short additive gap `c - p^k`. -/
def a (D : PrimePowerNeighbourData) : ℕ := D.c - D.p ^ D.k

/-- The prime-power summand. -/
def b (D : PrimePowerNeighbourData) : ℕ := D.p ^ D.k

@[simp] theorem a_pos (D : PrimePowerNeighbourData) : 0 < D.a := by
  exact Nat.sub_pos_of_lt D.power_lt_c

@[simp] theorem b_pos (D : PrimePowerNeighbourData) : 0 < D.b := by
  exact pow_pos D.prime_p.pos D.k

@[simp] theorem c_pos (D : PrimePowerNeighbourData) : 0 < D.c := by
  exact D.b_pos.trans D.power_lt_c

@[simp] theorem sum_eq (D : PrimePowerNeighbourData) : D.a + D.b = D.c := by
  exact Nat.sub_add_cancel D.power_lt_c.le

/-- The prime power and its neighbour are coprime. -/
theorem b_c_coprime (D : PrimePowerNeighbourData) : Nat.Coprime D.b D.c := by
  unfold b
  exact (Nat.coprime_pow_left_iff D.k_pos D.p D.c).2
    (D.prime_p.coprime_iff_not_dvd.2 D.p_not_dvd_c)

/-- Subtracting the prime power preserves coprimality with it. -/
theorem a_b_coprime (D : PrimePowerNeighbourData) : Nat.Coprime D.a D.b := by
  unfold a b
  exact (Nat.coprime_sub_self_left D.power_lt_c.le).2 D.b_c_coprime.symm

/-- The neighbour and the additive gap are coprime. -/
theorem c_a_coprime (D : PrimePowerNeighbourData) : Nat.Coprime D.c D.a := by
  unfold a
  exact (Nat.coprime_self_sub_right D.power_lt_c.le).2 D.b_c_coprime.symm

/-- The canonical primitive abc point attached to the neighbour. -/
def point (D : PrimePowerNeighbourData) : ABCPoint where
  a := D.a
  b := D.b
  c := D.c
  a_pos := D.a_pos
  b_pos := D.b_pos
  c_pos := D.c_pos
  sum_eq := D.sum_eq
  pairwise_coprime := ⟨D.a_b_coprime, D.b_c_coprime, D.c_a_coprime⟩

@[simp] theorem point_a (D : PrimePowerNeighbourData) : D.point.a = D.a := rfl
@[simp] theorem point_b (D : PrimePowerNeighbourData) : D.point.b = D.b := rfl
@[simp] theorem point_c (D : PrimePowerNeighbourData) : D.point.c = D.c := rfl

/-- For this point the elementary height is exactly `log c`. -/
theorem point_height (D : PrimePowerNeighbourData) :
    D.point.height = Real.log (D.c : ℝ) := by
  simp [point, ABCPoint.height, a, b,
    max_eq_right D.power_lt_c.le,
    max_eq_right (Nat.sub_le D.c (D.p ^ D.k))]

end PrimePowerNeighbourData

/-- Submultiplicativity of the repository radical on natural numbers. -/
theorem abcRadical_mul_le_mul (m n : ℕ) :
    abcRadical (m * n) ≤ abcRadical m * abcRadical n := by
  simp only [abcRadical_eq_natRadical]
  exact Nat.le_of_dvd
    (mul_pos (Nat.radical_pos m) (Nat.radical_pos n))
    (radical_mul_dvd (a := m) (b := n))

/-- The radical of a nonzero natural number is at most that number. -/
theorem abcRadical_le_self {n : ℕ} (hn : n ≠ 0) :
    abcRadical n ≤ n := by
  rw [abcRadical_eq_natRadical]
  exact (Nat.radical_le_self_iff).2 hn

/-- The radical of a positive power of a prime is the prime. -/
theorem abcRadical_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 0 < k) :
    abcRadical (p ^ k) = p := by
  rw [abcRadical_eq_natRadical]
  simpa using
    (radical_pow_of_prime (Nat.prime_iff.mp hp) (Nat.ne_of_gt hk))

/-- A concrete upper budget for the gap and the radical of the neighbour. -/
structure PrimePowerNeighbourBudget (D : PrimePowerNeighbourData) where
  H : ℕ
  R : ℕ
  a_le_H : D.a ≤ H
  radical_c_le_R : abcRadical D.c ≤ R

namespace PrimePowerNeighbourBudget

variable {D : PrimePowerNeighbourData}

@[simp] theorem H_pos (B : PrimePowerNeighbourBudget D) : 0 < B.H := by
  exact D.a_pos.trans_le B.a_le_H

@[simp] theorem R_pos (B : PrimePowerNeighbourBudget D) : 0 < B.R := by
  exact (abcRadical_pos D.c).trans_le B.radical_c_le_R

/-- The exact deterministic radical transfer

`rad((c-p^k) p^k c) ≤ H p R`.
-/
theorem point_radical_le (B : PrimePowerNeighbourBudget D) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      B.H * D.p * B.R := by
  have ha : abcRadical D.a ≤ B.H :=
    (abcRadical_le_self D.a_pos.ne').trans B.a_le_H
  have hb : abcRadical D.b = D.p := by
    simpa [PrimePowerNeighbourData.b] using
      (abcRadical_prime_pow D.prime_p D.k_pos)
  have hab : abcRadical (D.a * D.b) ≤
      abcRadical D.a * abcRadical D.b :=
    abcRadical_mul_le_mul D.a D.b
  have habc : abcRadical (D.a * D.b * D.c) ≤
      abcRadical (D.a * D.b) * abcRadical D.c :=
    abcRadical_mul_le_mul (D.a * D.b) D.c
  have hbudget :
      (abcRadical D.a * abcRadical D.b) * abcRadical D.c ≤
        (B.H * D.p) * B.R :=
    Nat.mul_le_mul (Nat.mul_le_mul ha hb.le) B.radical_c_le_R
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) =
        abcRadical (D.a * D.b * D.c) := by rfl
    _ ≤ abcRadical (D.a * D.b) * abcRadical D.c := habc
    _ ≤ (abcRadical D.a * abcRadical D.b) * abcRadical D.c :=
      Nat.mul_le_mul_right _ hab
    _ ≤ (B.H * D.p) * B.R := hbudget
    _ = B.H * D.p * B.R := rfl

/-- Logarithmic form of the radical budget. -/
theorem point_conductor_le (B : PrimePowerNeighbourBudget D) :
    D.point.conductor ≤ Real.log ((B.H * D.p * B.R : ℕ) : ℝ) := by
  unfold ABCPoint.conductor
  have hpos :
      0 < ((abcRadical (D.point.a * D.point.b * D.point.c) : ℕ) : ℝ) := by
    exact_mod_cast
      (abcRadical_pos (D.point.a * D.point.b * D.point.c))
  have hle :
      ((abcRadical (D.point.a * D.point.b * D.point.c) : ℕ) : ℝ) ≤
        ((B.H * D.p * B.R : ℕ) : ℝ) := by
    exact_mod_cast B.point_radical_le
  exact Real.log_le_log hpos hle

end PrimePowerNeighbourBudget

/-- A point whose height and conductor are controlled at a common scale `X`. -/
structure LogRadicalGapCertificate (P : ABCPoint) (X δ : ℝ) : Prop where
  X_pos : 0 < X
  height_lower : Real.log X ≤ P.height
  conductor_upper : P.conductor ≤ δ * Real.log X

namespace LogRadicalGapCertificate

variable {P : ABCPoint} {X δ ε C : ℝ}

/-- A strict logarithmic gap contradicts the abc inequality at one point. -/
theorem violates_at
    (G : LogRadicalGapCertificate P X δ)
    (hε : 0 ≤ ε)
    (hgap : C < (1 - (1 + ε) * δ) * Real.log X) :
    ¬ P.height ≤ (1 + ε) * P.conductor + C := by
  intro habc
  have hcoef : 0 ≤ 1 + ε := by linarith
  have hmul :
      (1 + ε) * P.conductor ≤
        (1 + ε) * (δ * Real.log X) :=
    mul_le_mul_of_nonneg_left G.conductor_upper hcoef
  linarith [G.height_lower]

end LogRadicalGapCertificate

/-- A prime-power neighbour budget already normalized to a logarithmic exponent. -/
structure PrimePowerNeighbourLogBudget
    (D : PrimePowerNeighbourData) (δ : ℝ) where
  H : ℕ
  R : ℕ
  a_le_H : D.a ≤ H
  radical_c_le_R : abcRadical D.c ≤ R
  log_budget_le :
    Real.log ((H * D.p * R : ℕ) : ℝ) ≤
      δ * Real.log (D.b : ℝ)

namespace PrimePowerNeighbourLogBudget

variable {D : PrimePowerNeighbourData} {δ : ℝ}

/-- Forget the logarithmic normalization. -/
def toBudget (L : PrimePowerNeighbourLogBudget D δ) :
    PrimePowerNeighbourBudget D where
  H := L.H
  R := L.R
  a_le_H := L.a_le_H
  radical_c_le_R := L.radical_c_le_R

/-- Convert the arithmetic data into the abstract logarithmic gap certificate. -/
def toLogRadicalGapCertificate
    (L : PrimePowerNeighbourLogBudget D δ) :
    LogRadicalGapCertificate D.point (D.b : ℝ) δ where
  X_pos := by exact_mod_cast D.b_pos
  height_lower := by
    rw [D.point_height]
    have hbpos : 0 < (D.b : ℝ) := by exact_mod_cast D.b_pos
    have hbcNat : D.b ≤ D.c := by
      simpa [PrimePowerNeighbourData.b] using D.power_lt_c.le
    have hbc : (D.b : ℝ) ≤ D.c := by
      exact_mod_cast hbcNat
    exact Real.log_le_log hbpos hbc
  conductor_upper :=
    (L.toBudget.point_conductor_le).trans L.log_budget_le

end PrimePowerNeighbourLogBudget

/-- Any unbounded family of fixed-exponent logarithmic gap certificates disproves abc. -/
theorem not_abc_of_unbounded_logRadicalGaps
    {ε δ : ℝ}
    (hε : 0 < ε)
    (P : ℕ → ABCPoint)
    (X : ℕ → ℝ)
    (G : ∀ n, LogRadicalGapCertificate (P n) (X n) δ)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ,
        C < (1 - (1 + ε) * δ) * Real.log (X n)) :
    ¬ ABCConjecture := by
  intro hABC
  rcases hABC ε hε with ⟨C, hC⟩
  rcases hunbounded C with ⟨n, hn⟩
  have hPnRaw := hC
    (P n).a (P n).b (P n).c
    (P n).a_pos (P n).b_pos (P n).c_pos
    (P n).sum_eq (P n).pairwise_coprime
  have hPn :
      (P n).height ≤ (1 + ε) * (P n).conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hPnRaw
  exact (G n).violates_at hε.le hn hPn

/-- Specialization of the preceding theorem to prime-power neighbours. -/
theorem not_abc_of_unbounded_primePowerNeighbours
    {ε δ : ℝ}
    (hε : 0 < ε)
    (D : ℕ → PrimePowerNeighbourData)
    (L : ∀ n, PrimePowerNeighbourLogBudget (D n) δ)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ,
        C < (1 - (1 + ε) * δ) *
          Real.log ((D n).b : ℝ)) :
    ¬ ABCConjecture := by
  exact not_abc_of_unbounded_logRadicalGaps
    hε
    (fun n => (D n).point)
    (fun n => ((D n).b : ℝ))
    (fun n => (L n).toLogRadicalGapCertificate)
    hunbounded

end IUTThreeClosures
