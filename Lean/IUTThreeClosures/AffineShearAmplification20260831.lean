/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSubcriticalLocusUniformity20260831

/-!
# The deterministic arithmetic core of the affine-shear amplifier

The mathematical proof precedes this file in
`research/ABC_AMPLIFICATION_GATE_ATTACK_2026_08_31.md`, Theorems 2.1--2.2.

From a primitive positive seed `a + b = c`, put `P = a*b*c` and

`U = 1 + P*h`, `V = 1 + P*(h + c*k)`, `W = 1 + P*(h + b*k)`.

When `U` is coprime to `k`, the three scaled coordinates
`a*U`, `b*V`, `c*W` form a positive pairwise-coprime abc point.  The map from
the parameter pair `(h,k)` to its first two coordinates is injective.

This file formalizes only these unconditional integer statements.  The
analytic lower bound for the actual low-radical subfibre remains an explicit
open premise in the paper and is not introduced here as an axiom.
-/

namespace IUTThreeClosures
namespace AffineShearAmplification20260831

/-- A positive primitive seed for the affine shear. -/
structure Seed where
  a : ℕ
  b : ℕ
  c : ℕ
  a_pos : 0 < a
  b_pos : 0 < b
  c_pos : 0 < c
  sum_eq : a + b = c
  coprime : Nat.Coprime a b

namespace Seed

/-- Product of the three seed coordinates. -/
def P (S : Seed) : ℕ := S.a * S.b * S.c

/-- First affine cofactor. -/
def U (S : Seed) (h : ℕ) : ℕ := 1 + S.P * h

/-- Second affine cofactor. -/
def V (S : Seed) (h k : ℕ) : ℕ := 1 + S.P * (h + S.c * k)

/-- Third affine cofactor. -/
def W (S : Seed) (h k : ℕ) : ℕ := 1 + S.P * (h + S.b * k)

@[simp] theorem P_pos (S : Seed) : 0 < S.P := by
  exact mul_pos (mul_pos S.a_pos S.b_pos) S.c_pos

theorem a_dvd_P (S : Seed) : S.a ∣ S.P := by
  refine ⟨S.b * S.c, ?_⟩
  simp [P, Nat.mul_assoc]

theorem b_dvd_P (S : Seed) : S.b ∣ S.P := by
  refine ⟨S.a * S.c, ?_⟩
  simp [P, Nat.mul_comm, Nat.mul_left_comm]

theorem c_dvd_P (S : Seed) : S.c ∣ S.P := by
  refine ⟨S.a * S.b, ?_⟩
  simp [P]
  ring

/-- Every integer of the form `1 + P*q` is coprime to `P`. -/
theorem one_add_P_mul_coprime_P (S : Seed) (q : ℕ) :
    Nat.Coprime (1 + S.P * q) S.P := by
  rw [Nat.mul_comm S.P q]
  exact (Nat.coprime_add_mul_right_left (m := 1) (n := S.P) (k := q)).2
    (Nat.coprime_one_left S.P)

theorem U_coprime_P (S : Seed) (h : ℕ) :
    Nat.Coprime (S.U h) S.P := by
  exact S.one_add_P_mul_coprime_P h

theorem V_coprime_P (S : Seed) (h k : ℕ) :
    Nat.Coprime (S.V h k) S.P := by
  exact S.one_add_P_mul_coprime_P (h + S.c * k)

theorem W_coprime_P (S : Seed) (h k : ℕ) :
    Nat.Coprime (S.W h k) S.P := by
  exact S.one_add_P_mul_coprime_P (h + S.b * k)

/-- Exact affine relation among the first two cofactors. -/
theorem V_eq_U_add (S : Seed) (h k : ℕ) :
    S.V h k = S.U h + S.P * S.c * k := by
  simp [V, U]
  ring

/-- Exact affine relation among the first and third cofactors. -/
theorem W_eq_U_add (S : Seed) (h k : ℕ) :
    S.W h k = S.U h + S.P * S.b * k := by
  simp [W, U]
  ring

/-- Exact difference relation between the last two cofactors. -/
theorem V_eq_W_add (S : Seed) (h k : ℕ) :
    S.V h k = S.W h k + S.P * S.a * k := by
  change 1 + S.P * (h + S.c * k) =
    1 + S.P * (h + S.b * k) + S.P * S.a * k
  rw [← S.sum_eq]
  ring

/-- The affine shear preserves the equation `A+B=C`. -/
theorem shear_equation (S : Seed) (h k : ℕ) :
    S.a * S.U h + S.b * S.V h k = S.c * S.W h k := by
  change S.a * (1 + S.P * h) +
    S.b * (1 + S.P * (h + S.c * k)) =
      S.c * (1 + S.P * (h + S.b * k))
  rw [← S.sum_eq]
  ring

/-- Admissibility of one parameter pair. -/
structure Parameter (S : Seed) where
  h : ℕ
  k : ℕ
  h_pos : 0 < h
  k_pos : 0 < k
  admissible : Nat.Coprime (S.U h) k

namespace Parameter

variable {S : Seed}

theorem V_coprime_k (q : Parameter S) :
    Nat.Coprime (S.V q.h q.k) q.k := by
  rw [S.V_eq_U_add]
  simpa [Nat.mul_assoc] using
    (Nat.coprime_add_mul_right_left
      (m := S.U q.h) (n := q.k) (k := S.P * S.c)).2 q.admissible

theorem W_coprime_k (q : Parameter S) :
    Nat.Coprime (S.W q.h q.k) q.k := by
  rw [S.W_eq_U_add]
  simpa [Nat.mul_assoc] using
    (Nat.coprime_add_mul_right_left
      (m := S.U q.h) (n := q.k) (k := S.P * S.b)).2 q.admissible

theorem U_coprime_V (q : Parameter S) :
    Nat.Coprime (S.U q.h) (S.V q.h q.k) := by
  have hUP : Nat.Coprime (S.U q.h) S.P := S.U_coprime_P q.h
  have hUc : Nat.Coprime (S.U q.h) S.c :=
    hUP.of_dvd_right S.c_dvd_P
  have hUdiff : Nat.Coprime (S.U q.h) (S.P * S.c * q.k) :=
    (hUP.mul_right hUc).mul_right q.admissible
  rw [S.V_eq_U_add, Nat.coprime_self_add_right]
  exact hUdiff

theorem U_coprime_W (q : Parameter S) :
    Nat.Coprime (S.U q.h) (S.W q.h q.k) := by
  have hUP : Nat.Coprime (S.U q.h) S.P := S.U_coprime_P q.h
  have hUb : Nat.Coprime (S.U q.h) S.b :=
    hUP.of_dvd_right S.b_dvd_P
  have hUdiff : Nat.Coprime (S.U q.h) (S.P * S.b * q.k) :=
    (hUP.mul_right hUb).mul_right q.admissible
  rw [S.W_eq_U_add, Nat.coprime_self_add_right]
  exact hUdiff

theorem V_coprime_W (q : Parameter S) :
    Nat.Coprime (S.V q.h q.k) (S.W q.h q.k) := by
  have hWP : Nat.Coprime (S.W q.h q.k) S.P := S.W_coprime_P q.h q.k
  have hWa : Nat.Coprime (S.W q.h q.k) S.a :=
    hWP.of_dvd_right S.a_dvd_P
  have hWdiff : Nat.Coprime (S.W q.h q.k) (S.P * S.a * q.k) :=
    (hWP.mul_right hWa).mul_right q.W_coprime_k
  rw [S.V_eq_W_add, Nat.coprime_self_add_left]
  exact hWdiff.symm

/-- The first scaled endpoint. -/
def A (q : Parameter S) : ℕ := S.a * S.U q.h

/-- The second scaled endpoint. -/
def B (q : Parameter S) : ℕ := S.b * S.V q.h q.k

/-- The third scaled endpoint. -/
def C (q : Parameter S) : ℕ := S.c * S.W q.h q.k

@[simp] theorem A_pos (q : Parameter S) : 0 < q.A :=
  mul_pos S.a_pos (by simp [Seed.U])

@[simp] theorem B_pos (q : Parameter S) : 0 < q.B :=
  mul_pos S.b_pos (by simp [Seed.V])

@[simp] theorem C_pos (q : Parameter S) : 0 < q.C :=
  mul_pos S.c_pos (by simp [Seed.W])

theorem A_add_B_eq_C (q : Parameter S) : q.A + q.B = q.C := by
  simpa [A, B, C] using S.shear_equation q.h q.k

theorem A_coprime_B (q : Parameter S) : Nat.Coprime q.A q.B := by
  have haV : Nat.Coprime S.a (S.V q.h q.k) :=
    ((S.V_coprime_P q.h q.k).of_dvd_right S.a_dvd_P).symm
  have hUb : Nat.Coprime (S.U q.h) S.b :=
    (S.U_coprime_P q.h).of_dvd_right S.b_dvd_P
  exact (S.coprime.mul_right haV).mul_left (hUb.mul_right q.U_coprime_V)

theorem B_coprime_C (q : Parameter S) : Nat.Coprime q.B q.C := by
  have hbc : Nat.Coprime S.b S.c := by
    rw [← S.sum_eq]
    exact Nat.coprime_add_self_right.mpr S.coprime.symm
  have hbW : Nat.Coprime S.b (S.W q.h q.k) :=
    ((S.W_coprime_P q.h q.k).of_dvd_right S.b_dvd_P).symm
  have hVc : Nat.Coprime (S.V q.h q.k) S.c :=
    (S.V_coprime_P q.h q.k).of_dvd_right S.c_dvd_P
  exact (hbc.mul_right hbW).mul_left (hVc.mul_right q.V_coprime_W)

theorem C_coprime_A (q : Parameter S) : Nat.Coprime q.C q.A := by
  have hca : Nat.Coprime S.c S.a := by
    rw [← S.sum_eq]
    exact Nat.coprime_self_add_left.mpr S.coprime.symm
  have hcU : Nat.Coprime S.c (S.U q.h) :=
    ((S.U_coprime_P q.h).of_dvd_right S.c_dvd_P).symm
  have hWa : Nat.Coprime (S.W q.h q.k) S.a :=
    (S.W_coprime_P q.h q.k).of_dvd_right S.a_dvd_P
  exact (hca.mul_right hcU).mul_left (hWa.mul_right q.U_coprime_W.symm)

/-- The output of every admissible parameter is an actual primitive abc
point, with no extra arithmetic premise. -/
def point (q : Parameter S) : ABCPoint where
  a := q.A
  b := q.B
  c := q.C
  a_pos := q.A_pos
  b_pos := q.B_pos
  c_pos := q.C_pos
  sum_eq := q.A_add_B_eq_C
  pairwise_coprime := ⟨q.A_coprime_B, q.B_coprime_C, q.C_coprime_A⟩

@[simp] theorem point_a (q : Parameter S) : q.point.a = q.A := rfl
@[simp] theorem point_b (q : Parameter S) : q.point.b = q.B := rfl
@[simp] theorem point_c (q : Parameter S) : q.point.c = q.C := rfl

end Parameter

/-- The first two scaled coordinates recover both natural-number parameters.
This is the exact injectivity statement used by the counting argument. -/
theorem shear_parameter_injective (S : Seed) :
    Function.Injective
      (fun hk : ℕ × ℕ =>
        (S.a * S.U hk.1, S.b * S.V hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hfirst : S.a * S.U h = S.a * S.U h' := congrArg Prod.fst heq
  have hU : S.U h = S.U h' := Nat.mul_left_cancel S.a_pos hfirst
  have hPh : S.P * h = S.P * h' := by
    simpa [U] using hU
  have hh : h = h' := Nat.mul_left_cancel S.P_pos hPh
  subst h'
  have hsecond : S.b * S.V h k = S.b * S.V h k' := congrArg Prod.snd heq
  have hV : S.V h k = S.V h k' := Nat.mul_left_cancel S.b_pos hsecond
  have hPc : 0 < S.P * S.c := mul_pos S.P_pos S.c_pos
  have hPk : S.P * S.c * k = S.P * S.c * k' := by
    simpa [S.V_eq_U_add] using hV
  have hk : k = k' := Nat.mul_left_cancel hPc hPk
  subst k'
  rfl

#print axioms Seed.shear_equation
#print axioms Seed.Parameter.U_coprime_V
#print axioms Seed.Parameter.U_coprime_W
#print axioms Seed.Parameter.V_coprime_W
#print axioms Seed.Parameter.A_coprime_B
#print axioms Seed.Parameter.B_coprime_C
#print axioms Seed.Parameter.C_coprime_A
#print axioms Seed.Parameter.point
#print axioms Seed.shear_parameter_injective

end Seed
end AffineShearAmplification20260831
end IUTThreeClosures
