/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalNeighbourTransfer

/-!
# Exponent budgets for low-radical neighbours

The deterministic neighbour transfer bounds the radical of the primitive point
attached to `b < c` by a product `H * B * R`, where `H` bounds the gap and
`B,R` bound the radicals of the two endpoints.  This file converts separate
logarithmic exponents for these three factors into the single strict exponent
needed to contradict the abc conjecture.

The principal threshold is

`theta + 1 / r + 1 / s < 1`.

Here `theta` controls the gap, while `r` and `s` certify radical compression of
the two endpoints.  Exact `r`-th and `s`-th powers automatically satisfy the
corresponding compression inequalities.  Consequently an unbounded family of
coprime close perfect powers crossing this threshold would rigorously disprove
abc.

No existence theorem for such a family is assumed.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Adding three independent logarithmic budgets -/

/-- Separate logarithmic upper bounds add exactly at the product level. -/
theorem log_mul_three_le_exponent_sum
    {H B R X theta beta sigma : ℝ}
    (hH : 0 < H) (hB : 0 < B) (hR : 0 < R)
    (hHlog : Real.log H ≤ theta * Real.log X)
    (hBlog : Real.log B ≤ beta * Real.log X)
    (hRlog : Real.log R ≤ sigma * Real.log X) :
    Real.log (H * B * R) ≤
      (theta + beta + sigma) * Real.log X := by
  calc
    Real.log (H * B * R) =
        (Real.log H + Real.log B) + Real.log R := by
      rw [Real.log_mul (mul_pos hH hB).ne' hR.ne',
        Real.log_mul hH.ne' hB.ne']
    _ ≤ (theta * Real.log X + beta * Real.log X) +
        sigma * Real.log X :=
      add_le_add (add_le_add hHlog hBlog) hRlog
    _ = (theta + beta + sigma) * Real.log X := by ring

/-- A neighbour budget whose three factors are each controlled relative to the
actual height scale `c`. -/
structure LowRadicalHeightExponentBudget
    (D : CoprimeNeighbourData) (theta beta sigma : ℝ) where
  H : ℕ
  B : ℕ
  R : ℕ
  gap_le : D.a ≤ H
  radical_b_le : abcRadical D.b ≤ B
  radical_c_le : abcRadical D.c ≤ R
  gap_log_le :
    Real.log (H : ℝ) ≤ theta * Real.log (D.c : ℝ)
  radical_b_log_le :
    Real.log (B : ℝ) ≤ beta * Real.log (D.c : ℝ)
  radical_c_log_le :
    Real.log (R : ℝ) ≤ sigma * Real.log (D.c : ℝ)

namespace LowRadicalHeightExponentBudget

variable {D : CoprimeNeighbourData} {theta beta sigma : ℝ}

@[simp]
theorem H_pos (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    0 < E.H :=
  D.a_pos.trans_le E.gap_le

@[simp]
theorem B_pos (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    0 < E.B :=
  (abcRadical_pos D.b).trans_le E.radical_b_le

@[simp]
theorem R_pos (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    0 < E.R :=
  (abcRadical_pos D.c).trans_le E.radical_c_le

/-- Forget the exponent decomposition. -/
def toBudget (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    LowRadicalNeighbourBudget D where
  H := E.H
  B := E.B
  R := E.R
  gap_le := E.gap_le
  radical_b_le := E.radical_b_le
  radical_c_le := E.radical_c_le

/-- The three separate exponents give the required product exponent. -/
theorem log_product_le
    (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    Real.log (((E.H * E.B * E.R : ℕ) : ℝ)) ≤
      (theta + beta + sigma) * Real.log (D.c : ℝ) := by
  simpa only [Nat.cast_mul] using
    (log_mul_three_le_exponent_sum
      (H := (E.H : ℝ)) (B := (E.B : ℝ)) (R := (E.R : ℝ))
      (X := (D.c : ℝ))
      (theta := theta) (beta := beta) (sigma := sigma)
      (by exact_mod_cast E.H_pos)
      (by exact_mod_cast E.B_pos)
      (by exact_mod_cast E.R_pos)
      E.gap_log_le E.radical_b_log_le E.radical_c_log_le)

/-- Convert the exponent budget into the common logarithmic-gap certificate,
using the exact endpoint height scale `X=c`. -/
def toLogRadicalGapCertificate
    (E : LowRadicalHeightExponentBudget D theta beta sigma) :
    LogRadicalGapCertificate D.point (D.c : ℝ)
      (theta + beta + sigma) where
  X_pos := by exact_mod_cast D.c_pos
  height_lower := by
    rw [D.point_height]
  conductor_upper :=
    E.toBudget.point_conductor_le.trans E.log_product_le

end LowRadicalHeightExponentBudget

/-- Every nonnegative exponent strictly below one admits a positive abc
parameter that preserves the strict gap. -/
theorem exists_positive_abcEpsilon_of_budget_lt_one
    {delta : ℝ} (hdelta0 : 0 ≤ delta) (hdelta1 : delta < 1) :
    ∃ epsilon : ℝ, 0 < epsilon ∧ (1 + epsilon) * delta < 1 := by
  refine ⟨(1 - delta) / 2, by linarith, ?_⟩
  nlinarith

/-- An unbounded family with total exponent below one disproves abc. -/
theorem not_abc_of_unbounded_heightExponentBudgets
    {theta beta sigma : ℝ}
    (hsum_nonneg : 0 ≤ theta + beta + sigma)
    (hsum_lt_one : theta + beta + sigma < 1)
    (D : ℕ → CoprimeNeighbourData)
    (E : ∀ n,
      LowRadicalHeightExponentBudget (D n) theta beta sigma)
    (hunbounded :
      ∀ T : ℝ, ∃ n : ℕ, T < Real.log ((D n).c : ℝ)) :
    ¬ ABCConjecture := by
  obtain ⟨epsilon, hepsilon, hstrict⟩ :=
    exists_positive_abcEpsilon_of_budget_lt_one
      hsum_nonneg hsum_lt_one
  refine not_abc_of_unbounded_logRadicalGaps
    hepsilon
    (fun n => (D n).point)
    (fun n => ((D n).c : ℝ))
    (fun n => (E n).toLogRadicalGapCertificate)
    ?_
  intro C
  let kappa : ℝ :=
    1 - (1 + epsilon) * (theta + beta + sigma)
  have hkappa : 0 < kappa := by
    dsimp [kappa]
    linarith
  obtain ⟨n, hn⟩ := hunbounded (C / kappa)
  refine ⟨n, ?_⟩
  have hscaled : C < Real.log ((D n).c : ℝ) * kappa :=
    (div_lt_iff₀ hkappa).mp hn
  simpa [kappa, mul_comm] using hscaled

/-! ## Reciprocal radical-compression exponents -/

/-- A gap exponent together with the compression inequalities

`r * log B ≤ log c`, `s * log R ≤ log c`.

These imply endpoint exponents `1/r` and `1/s`. -/
structure ReciprocalRadicalBudget
    (D : CoprimeNeighbourData) (theta : ℝ) (r s : ℕ) where
  H : ℕ
  B : ℕ
  R : ℕ
  r_pos : 0 < r
  s_pos : 0 < s
  gap_le : D.a ≤ H
  radical_b_le : abcRadical D.b ≤ B
  radical_c_le : abcRadical D.c ≤ R
  gap_log_le :
    Real.log (H : ℝ) ≤ theta * Real.log (D.c : ℝ)
  radical_b_power_log_le :
    (r : ℝ) * Real.log (B : ℝ) ≤ Real.log (D.c : ℝ)
  radical_c_power_log_le :
    (s : ℝ) * Real.log (R : ℝ) ≤ Real.log (D.c : ℝ)

namespace ReciprocalRadicalBudget

variable {D : CoprimeNeighbourData} {theta : ℝ} {r s : ℕ}

/-- Divide the first compression inequality by its positive exponent. -/
theorem radical_b_log_le
    (E : ReciprocalRadicalBudget D theta r s) :
    Real.log (E.B : ℝ) ≤
      (r : ℝ)⁻¹ * Real.log (D.c : ℝ) := by
  have hr : 0 < (r : ℝ) := by exact_mod_cast E.r_pos
  have hdiv :
      Real.log (E.B : ℝ) ≤ Real.log (D.c : ℝ) / (r : ℝ) :=
    (le_div_iff₀ hr).2 (by
      simpa [mul_comm] using E.radical_b_power_log_le)
  simpa [div_eq_mul_inv, mul_comm] using hdiv

/-- Divide the second compression inequality by its positive exponent. -/
theorem radical_c_log_le
    (E : ReciprocalRadicalBudget D theta r s) :
    Real.log (E.R : ℝ) ≤
      (s : ℝ)⁻¹ * Real.log (D.c : ℝ) := by
  have hs : 0 < (s : ℝ) := by exact_mod_cast E.s_pos
  have hdiv :
      Real.log (E.R : ℝ) ≤ Real.log (D.c : ℝ) / (s : ℝ) :=
    (le_div_iff₀ hs).2 (by
      simpa [mul_comm] using E.radical_c_power_log_le)
  simpa [div_eq_mul_inv, mul_comm] using hdiv

/-- A reciprocal compression budget is a three-exponent height budget. -/
def toHeightExponentBudget
    (E : ReciprocalRadicalBudget D theta r s) :
    LowRadicalHeightExponentBudget D theta (r : ℝ)⁻¹ (s : ℝ)⁻¹ where
  H := E.H
  B := E.B
  R := E.R
  gap_le := E.gap_le
  radical_b_le := E.radical_b_le
  radical_c_le := E.radical_c_le
  gap_log_le := E.gap_log_le
  radical_b_log_le := E.radical_b_log_le
  radical_c_log_le := E.radical_c_log_le

end ReciprocalRadicalBudget

/-- The exact `theta + 1/r + 1/s` threshold. -/
theorem not_abc_of_unbounded_reciprocalRadicalBudgets
    {theta : ℝ} {r s : ℕ}
    (htheta : 0 ≤ theta)
    (hsum_lt_one : theta + (r : ℝ)⁻¹ + (s : ℝ)⁻¹ < 1)
    (D : ℕ → CoprimeNeighbourData)
    (E : ∀ n, ReciprocalRadicalBudget (D n) theta r s)
    (hunbounded :
      ∀ T : ℝ, ∃ n : ℕ, T < Real.log ((D n).c : ℝ)) :
    ¬ ABCConjecture := by
  have hr : 0 < (r : ℝ) := by
    exact_mod_cast (E 0).r_pos
  have hs : 0 < (s : ℝ) := by
    exact_mod_cast (E 0).s_pos
  have hsum_nonneg :
      0 ≤ theta + (r : ℝ)⁻¹ + (s : ℝ)⁻¹ := by
    have hir : 0 ≤ (r : ℝ)⁻¹ := (inv_pos.mpr hr).le
    have his : 0 ≤ (s : ℝ)⁻¹ := (inv_pos.mpr hs).le
    linarith
  exact not_abc_of_unbounded_heightExponentBudgets
    hsum_nonneg hsum_lt_one D
    (fun n => (E n).toHeightExponentBudget)
    hunbounded

/-! ## Exact perfect-power endpoints -/

/-- Two coprime exact powers with the second strictly larger. -/
structure CoprimePerfectPowerNeighbourData (r s : ℕ) where
  u : ℕ
  v : ℕ
  u_pos : 0 < u
  v_pos : 0 < v
  r_pos : 0 < r
  s_pos : 0 < s
  power_lt : u ^ r < v ^ s
  coprime_uv : Nat.Coprime u v

namespace CoprimePerfectPowerNeighbourData

variable {r s : ℕ}

/-- Forget the exact-power presentations. -/
def toNeighbour (D : CoprimePerfectPowerNeighbourData r s) :
    CoprimeNeighbourData where
  b := D.u ^ r
  c := D.v ^ s
  b_pos := pow_pos D.u_pos r
  b_lt_c := D.power_lt
  coprime_bc := by
    have hvpow_u : Nat.Coprime (D.v ^ s) D.u :=
      (Nat.coprime_pow_left_iff D.s_pos D.v D.u).2
        D.coprime_uv.symm
    have hu_vpow : Nat.Coprime D.u (D.v ^ s) := hvpow_u.symm
    exact
      (Nat.coprime_pow_left_iff D.r_pos D.u (D.v ^ s)).2 hu_vpow

/-- The first endpoint radical is exactly the radical of its base. -/
theorem radical_b (D : CoprimePerfectPowerNeighbourData r s) :
    abcRadical D.toNeighbour.b = abcRadical D.u := by
  simpa [toNeighbour] using
    (abcRadical_pow (u := D.u) (k := r) D.r_pos.ne')

/-- The second endpoint radical is exactly the radical of its base. -/
theorem radical_c (D : CoprimePerfectPowerNeighbourData r s) :
    abcRadical D.toNeighbour.c = abcRadical D.v := by
  simpa [toNeighbour] using
    (abcRadical_pow (u := D.v) (k := s) D.s_pos.ne')

end CoprimePerfectPowerNeighbourData

/-- The base radical of an exact power has reciprocal logarithmic exponent. -/
theorem radical_base_log_mul_le_power_log
    {u r : ℕ} (hu : 0 < u) :
    (r : ℝ) * Real.log ((abcRadical u : ℕ) : ℝ) ≤
      Real.log (((u ^ r : ℕ) : ℝ)) := by
  have hradPos : 0 < ((abcRadical u : ℕ) : ℝ) := by
    exact_mod_cast abcRadical_pos u
  have hradLe :
      ((abcRadical u : ℕ) : ℝ) ≤ (u : ℝ) := by
    exact_mod_cast abcRadical_le_self hu.ne'
  have hlog :
      Real.log ((abcRadical u : ℕ) : ℝ) ≤ Real.log (u : ℝ) :=
    Real.log_le_log hradPos hradLe
  rw [Nat.cast_pow, Real.log_pow]
  exact mul_le_mul_of_nonneg_left hlog (Nat.cast_nonneg r)

/-- A concrete gap bound for a pair of exact powers. -/
structure PerfectPowerPairGapBudget
    {r s : ℕ} (D : CoprimePerfectPowerNeighbourData r s)
    (theta : ℝ) where
  H : ℕ
  gap_le : D.toNeighbour.a ≤ H
  gap_log_le :
    Real.log (H : ℝ) ≤ theta * Real.log (D.toNeighbour.c : ℝ)

namespace PerfectPowerPairGapBudget

variable {r s : ℕ} {theta : ℝ}
variable {D : CoprimePerfectPowerNeighbourData r s}

/-- Exact powers automatically supply both reciprocal radical-compression
certificates. -/
def toReciprocalRadicalBudget
    (G : PerfectPowerPairGapBudget D theta) :
    ReciprocalRadicalBudget D.toNeighbour theta r s where
  H := G.H
  B := abcRadical D.u
  R := abcRadical D.v
  r_pos := D.r_pos
  s_pos := D.s_pos
  gap_le := G.gap_le
  radical_b_le := by
    exact le_of_eq D.radical_b
  radical_c_le := by
    exact le_of_eq D.radical_c
  gap_log_le := G.gap_log_le
  radical_b_power_log_le := by
    have hbase :=
      radical_base_log_mul_le_power_log (u := D.u) (r := r) D.u_pos
    have hbpos : 0 < (((D.u ^ r : ℕ) : ℝ)) := by
      exact_mod_cast pow_pos D.u_pos r
    have hbc :
        (((D.u ^ r : ℕ) : ℝ)) ≤ (((D.v ^ s : ℕ) : ℝ)) := by
      exact_mod_cast D.power_lt.le
    have hlogbc := Real.log_le_log hbpos hbc
    simpa [CoprimePerfectPowerNeighbourData.toNeighbour] using
      hbase.trans hlogbc
  radical_c_power_log_le := by
    simpa [CoprimePerfectPowerNeighbourData.toNeighbour] using
      (radical_base_log_mul_le_power_log
        (u := D.v) (r := s) D.v_pos)

end PerfectPowerPairGapBudget

/-- An unbounded close coprime perfect-power family crossing
`theta + 1/r + 1/s < 1` disproves abc. -/
theorem not_abc_of_unbounded_coprimePerfectPowerNeighbours
    {theta : ℝ} {r s : ℕ}
    (htheta : 0 ≤ theta)
    (hsum_lt_one : theta + (r : ℝ)⁻¹ + (s : ℝ)⁻¹ < 1)
    (D : ℕ → CoprimePerfectPowerNeighbourData r s)
    (G : ∀ n, PerfectPowerPairGapBudget (D n) theta)
    (hunbounded :
      ∀ T : ℝ, ∃ n : ℕ,
        T < Real.log ((D n).toNeighbour.c : ℝ)) :
    ¬ ABCConjecture := by
  exact not_abc_of_unbounded_reciprocalRadicalBudgets
    htheta hsum_lt_one
    (fun n => (D n).toNeighbour)
    (fun n => (G n).toReciprocalRadicalBudget)
    hunbounded

end
end IUTThreeClosures
