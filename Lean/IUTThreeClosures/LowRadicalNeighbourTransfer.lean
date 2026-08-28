/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerSmoothNeighbour

/-!
# General low-radical-neighbour transfer for the abc conjecture

The prime-power route is a special case of a more flexible deterministic
principle.  Let `b < c` be positive and coprime, and put `a = c-b`.  Then
`(a,b,c)` is a primitive abc triple.  If

* `a ≤ H`,
* `abcRadical b ≤ B`, and
* `abcRadical c ≤ R`,

then

`abcRadical (a*b*c) ≤ H*B*R`.

Thus any unbounded family of coprime adjacent pairs with a strict logarithmic
budget for the gap and both radicals disproves `ABCConjecture`.  A second
section specializes the centre to an arbitrary perfect power `u^k`; its
radical cost is exactly `abcRadical u`, not the base `u` itself.

No existence or distribution theorem for such neighbours is assumed here.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

/-- Two positive coprime integers with the second strictly larger. -/
structure CoprimeNeighbourData where
  b : ℕ
  c : ℕ
  b_pos : 0 < b
  b_lt_c : b < c
  coprime_bc : Nat.Coprime b c

namespace CoprimeNeighbourData

/-- The additive gap. -/
def a (D : CoprimeNeighbourData) : ℕ := D.c - D.b

@[simp] theorem a_pos (D : CoprimeNeighbourData) : 0 < D.a := by
  exact Nat.sub_pos_of_lt D.b_lt_c

@[simp] theorem c_pos (D : CoprimeNeighbourData) : 0 < D.c :=
  D.b_pos.trans D.b_lt_c

@[simp] theorem sum_eq (D : CoprimeNeighbourData) : D.a + D.b = D.c := by
  exact Nat.sub_add_cancel D.b_lt_c.le

/-- The gap and the centre are coprime. -/
theorem a_b_coprime (D : CoprimeNeighbourData) : Nat.Coprime D.a D.b := by
  unfold a
  exact (Nat.coprime_sub_self_left D.b_lt_c.le).2 D.coprime_bc.symm

/-- The endpoint and the gap are coprime. -/
theorem c_a_coprime (D : CoprimeNeighbourData) : Nat.Coprime D.c D.a := by
  unfold a
  exact (Nat.coprime_self_sub_right D.b_lt_c.le).2 D.coprime_bc.symm

/-- The primitive abc point associated with a coprime adjacent pair. -/
def point (D : CoprimeNeighbourData) : ABCPoint where
  a := D.a
  b := D.b
  c := D.c
  a_pos := D.a_pos
  b_pos := D.b_pos
  c_pos := D.c_pos
  sum_eq := D.sum_eq
  pairwise_coprime := ⟨D.a_b_coprime, D.coprime_bc, D.c_a_coprime⟩

@[simp] theorem point_a (D : CoprimeNeighbourData) : D.point.a = D.a := rfl
@[simp] theorem point_b (D : CoprimeNeighbourData) : D.point.b = D.b := rfl
@[simp] theorem point_c (D : CoprimeNeighbourData) : D.point.c = D.c := rfl

/-- The height of this point is `log c`. -/
theorem point_height (D : CoprimeNeighbourData) :
    D.point.height = Real.log (D.c : ℝ) := by
  simp [point, ABCPoint.height, a,
    max_eq_right D.b_lt_c.le,
    max_eq_right (Nat.sub_le D.c D.b)]

end CoprimeNeighbourData

/-- Radical is unchanged by a positive power. -/
theorem abcRadical_pow {u k : ℕ} (hk : k ≠ 0) :
    abcRadical (u ^ k) = abcRadical u := by
  simp only [abcRadical_eq_natRadical]
  exact radical_pow u hk

/-- Simultaneous arithmetic budgets for the gap, centre and endpoint. -/
structure LowRadicalNeighbourBudget (D : CoprimeNeighbourData) where
  H : ℕ
  B : ℕ
  R : ℕ
  gap_le : D.a ≤ H
  radical_b_le : abcRadical D.b ≤ B
  radical_c_le : abcRadical D.c ≤ R

namespace LowRadicalNeighbourBudget

variable {D : CoprimeNeighbourData}

@[simp] theorem H_pos (L : LowRadicalNeighbourBudget D) : 0 < L.H :=
  D.a_pos.trans_le L.gap_le

@[simp] theorem B_pos (L : LowRadicalNeighbourBudget D) : 0 < L.B :=
  (abcRadical_pos D.b).trans_le L.radical_b_le

@[simp] theorem R_pos (L : LowRadicalNeighbourBudget D) : 0 < L.R :=
  (abcRadical_pos D.c).trans_le L.radical_c_le

/-- Exact radical transfer for a general coprime neighbour pair. -/
theorem point_radical_le (L : LowRadicalNeighbourBudget D) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      L.H * L.B * L.R := by
  have ha : abcRadical D.a ≤ L.H :=
    (abcRadical_le_self D.a_pos.ne').trans L.gap_le
  have hab : abcRadical (D.a * D.b) ≤
      abcRadical D.a * abcRadical D.b :=
    abcRadical_mul_le_mul D.a D.b
  have habc : abcRadical (D.a * D.b * D.c) ≤
      abcRadical (D.a * D.b) * abcRadical D.c :=
    abcRadical_mul_le_mul (D.a * D.b) D.c
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) =
        abcRadical (D.a * D.b * D.c) := by rfl
    _ ≤ abcRadical (D.a * D.b) * abcRadical D.c := habc
    _ ≤ (abcRadical D.a * abcRadical D.b) * abcRadical D.c :=
      Nat.mul_le_mul_right _ hab
    _ ≤ (L.H * L.B) * L.R :=
      Nat.mul_le_mul
        (Nat.mul_le_mul ha L.radical_b_le)
        L.radical_c_le
    _ = L.H * L.B * L.R := rfl

/-- Logarithmic form of the general radical budget. -/
theorem point_conductor_le (L : LowRadicalNeighbourBudget D) :
    D.point.conductor ≤ Real.log ((L.H * L.B * L.R : ℕ) : ℝ) := by
  unfold ABCPoint.conductor
  have hpos :
      0 < ((abcRadical (D.point.a * D.point.b * D.point.c) : ℕ) : ℝ) := by
    exact_mod_cast
      (abcRadical_pos (D.point.a * D.point.b * D.point.c))
  have hle :
      ((abcRadical (D.point.a * D.point.b * D.point.c) : ℕ) : ℝ) ≤
        ((L.H * L.B * L.R : ℕ) : ℝ) := by
    exact_mod_cast L.point_radical_le
  exact Real.log_le_log hpos hle

end LowRadicalNeighbourBudget

/-- A general neighbour budget normalized to a logarithmic exponent. -/
structure LowRadicalNeighbourLogBudget
    (D : CoprimeNeighbourData) (δ : ℝ) where
  H : ℕ
  B : ℕ
  R : ℕ
  gap_le : D.a ≤ H
  radical_b_le : abcRadical D.b ≤ B
  radical_c_le : abcRadical D.c ≤ R
  log_budget_le :
    Real.log ((H * B * R : ℕ) : ℝ) ≤
      δ * Real.log (D.b : ℝ)

namespace LowRadicalNeighbourLogBudget

variable {D : CoprimeNeighbourData} {δ : ℝ}

/-- Forget the logarithmic normalization. -/
def toBudget (L : LowRadicalNeighbourLogBudget D δ) :
    LowRadicalNeighbourBudget D where
  H := L.H
  B := L.B
  R := L.R
  gap_le := L.gap_le
  radical_b_le := L.radical_b_le
  radical_c_le := L.radical_c_le

/-- Convert a concrete neighbour budget into the common logarithmic gap API. -/
def toLogRadicalGapCertificate
    (L : LowRadicalNeighbourLogBudget D δ) :
    LogRadicalGapCertificate D.point (D.b : ℝ) δ where
  X_pos := by exact_mod_cast D.b_pos
  height_lower := by
    rw [D.point_height]
    have hbpos : 0 < (D.b : ℝ) := by exact_mod_cast D.b_pos
    have hbc : (D.b : ℝ) ≤ D.c := by exact_mod_cast D.b_lt_c.le
    exact Real.log_le_log hbpos hbc
  conductor_upper :=
    (L.toBudget.point_conductor_le).trans L.log_budget_le

end LowRadicalNeighbourLogBudget

/-- An unbounded strict-gap family of arbitrary coprime neighbours disproves
abc. -/
theorem not_abc_of_unbounded_lowRadicalNeighbours
    {ε δ : ℝ}
    (hε : 0 < ε)
    (D : ℕ → CoprimeNeighbourData)
    (L : ∀ n, LowRadicalNeighbourLogBudget (D n) δ)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ,
        C < (1 - (1 + ε) * δ) * Real.log ((D n).b : ℝ)) :
    ¬ ABCConjecture := by
  exact not_abc_of_unbounded_logRadicalGaps
    hε
    (fun n => (D n).point)
    (fun n => ((D n).b : ℝ))
    (fun n => (L n).toLogRadicalGapCertificate)
    hunbounded

/-! ## Perfect-power centres -/

/-- A coprime endpoint immediately to the right of an arbitrary positive
perfect power `u^k`. -/
structure PerfectPowerNeighbourData where
  u : ℕ
  k : ℕ
  c : ℕ
  u_pos : 0 < u
  k_pos : 0 < k
  power_lt_c : u ^ k < c
  coprime_uc : Nat.Coprime u c

namespace PerfectPowerNeighbourData

/-- Forget that the centre is a perfect power. -/
def toNeighbour (D : PerfectPowerNeighbourData) : CoprimeNeighbourData where
  b := D.u ^ D.k
  c := D.c
  b_pos := pow_pos D.u_pos D.k
  b_lt_c := D.power_lt_c
  coprime_bc :=
    (Nat.coprime_pow_left_iff D.k_pos D.u D.c).2 D.coprime_uc

/-- The radical cost of the perfect-power centre is exactly the radical of its
base. -/
theorem radical_center (D : PerfectPowerNeighbourData) :
    abcRadical D.toNeighbour.b = abcRadical D.u := by
  exact abcRadical_pow D.k_pos.ne'

end PerfectPowerNeighbourData

/-- Budgets adapted to a perfect-power centre. -/
structure PerfectPowerNeighbourBudget (D : PerfectPowerNeighbourData) where
  H : ℕ
  U : ℕ
  R : ℕ
  gap_le : D.toNeighbour.a ≤ H
  radical_u_le : abcRadical D.u ≤ U
  radical_c_le : abcRadical D.c ≤ R

namespace PerfectPowerNeighbourBudget

variable {D : PerfectPowerNeighbourData}

/-- Every perfect-power budget is a general low-radical-neighbour budget. -/
def toLowRadicalBudget (L : PerfectPowerNeighbourBudget D) :
    LowRadicalNeighbourBudget D.toNeighbour where
  H := L.H
  B := L.U
  R := L.R
  gap_le := L.gap_le
  radical_b_le := by
    rw [D.radical_center]
    exact L.radical_u_le
  radical_c_le := L.radical_c_le

/-- Radical transfer specialized to a perfect-power centre. -/
theorem point_radical_le (L : PerfectPowerNeighbourBudget D) :
    abcRadical
        (D.toNeighbour.point.a * D.toNeighbour.point.b *
          D.toNeighbour.point.c) ≤
      L.H * L.U * L.R :=
  L.toLowRadicalBudget.point_radical_le

end PerfectPowerNeighbourBudget

end IUTThreeClosures
