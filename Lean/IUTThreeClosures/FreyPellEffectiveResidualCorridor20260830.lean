/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJReducedData

/-!
# Effective concentration and the small-j-denominator applicability boundary

The mathematical proofs are in
`research/ARITHMETIC_GEOMETRY_SESSION_2026_08_30.md`, written first.

This module checks:

* the integral genus-one map from the first three Pell square decompositions;
* descent of an integer square factor in the coefficient of that cubic;
* the elementary combination of two **explicitly supplied** effective-height
  estimates with the variable-index Pell size inequality; and
* the actual reduced-denominator lower bound `c^4 <= 1024 den(j_Frey)`.

The Berczes--Evertse--Gyory theorem, Siegel's theorem, Pasten's 2026 results,
and the CM non-isogeny argument are not axioms or imported proof interfaces.
In particular, the scalar implications below do not certify the effective
Diophantine input and do not produce a proof of `ABCConjecture`.
-/

namespace IUTThreeClosures

/-- The first three square decompositions give an integral point on
`Y^2 = D * (x^3 - x)`, with `D = 3*A*B`, `x = b+1`, `Y = D*u*v*r`.
No squarefreeness or unproved Diophantine assertion is required. -/
theorem pellEffective_genusOnePoint
    (b A B u v r : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2) :
    (3 * A * B * u * v * r) ^ 2 =
      (3 * A * B) * ((b + 1) ^ 3 - (b + 1)) := by
  have hprod : b * (b + 1) * (b + 2) =
      (3 * A * B) * (u * v * r) ^ 2 := by
    rw [hB, hthree, hA]
    ring
  calc
    (3 * A * B * u * v * r) ^ 2 =
        (3 * A * B) * ((3 * A * B) * (u * v * r) ^ 2) := by ring
    _ = (3 * A * B) * (b * (b + 1) * (b + 2)) := by rw [hprod]
    _ = (3 * A * B) * ((b + 1) ^ 3 - (b + 1)) := by ring

/-- A nonzero integer square factor of the coefficient can be removed
without leaving integral points. In the mathematical application `d` is
the positive squarefree part of `D`; the algebraic descent itself needs
neither squarefreeness nor positivity. No effective height theorem is used. -/
theorem pellEffective_squareFactorDescent
    (d t x Y : ℤ) (ht : t ≠ 0)
    (h : Y ^ 2 = d * t ^ 2 * (x ^ 3 - x)) :
    ∃ y : ℤ, Y = t * y ∧ y ^ 2 = d * (x ^ 3 - x) := by
  have hdivsq : t ^ 2 ∣ Y ^ 2 := by
    refine ⟨d * (x ^ 3 - x), ?_⟩
    calc
      Y ^ 2 = d * t ^ 2 * (x ^ 3 - x) := h
      _ = t ^ 2 * (d * (x ^ 3 - x)) := by ring
  obtain ⟨y, hy⟩ := (Int.pow_dvd_pow_iff two_ne_zero).mp hdivsq
  refine ⟨y, hy, ?_⟩
  apply mul_left_cancel₀ (pow_ne_zero 2 ht)
  calc
    t ^ 2 * y ^ 2 = Y ^ 2 := by rw [hy, mul_pow]
    _ = d * t ^ 2 * (x ^ 3 - x) := h
    _ = t ^ 2 * (d * (x ^ 3 - x)) := by ring

/-- The coefficient l1-norm recurrence used in the mathematical proof has
the coarse majorant `3^n`. This lemma formalizes the recurrence implication,
not the identification of a particular polynomial norm with `M`. -/
theorem pellEffective_coefficientMajorant
    (M : ℕ → ℝ)
    (hzero : M 0 ≤ 1) (hone : M 1 ≤ 1)
    (hstep : ∀ n, M (n + 2) ≤ 2 * M (n + 1) + M n) :
    ∀ n, M n ≤ 3 ^ n := by
  intro n
  induction n using Nat.twoStepInduction with
  | zero => simpa using hzero
  | one => norm_num only [pow_one]; linarith
  | more n hn hn1 =>
      calc
        M (n + 2) ≤ 2 * M (n + 1) + M n := hstep n
        _ ≤ 2 * 3 ^ (n + 1) + 3 ^ n := by linarith
        _ ≤ 3 ^ (n + 2) := by
          simp only [pow_succ]
          nlinarith [pow_nonneg (by norm_num : (0 : ℝ) ≤ 3) n]

/-- Take the logarithm of a supplied effective height bound. The bound is
an argument, not a concealed invocation of a Diophantine theorem. -/
theorem pellEffective_logHeightOfBound
    (H P : ℝ) (hH : 0 < H)
    (heffective : H ≤ Real.exp (4300 * P ^ 5)) :
    Real.log H ≤ 4300 * P ^ 5 := by
  have hlog := Real.log_le_log hH heffective
  simpa using hlog

/-- Division-free form of the uniform upper corridor. In the application
`H=log(b+2)`, `L=log(D+1)`, `G=log H`, and `P` is the real prime index. -/
theorem pellEffective_kernelFifthCorridor
    (H L P G : ℝ)
    (hL : 0 ≤ L) (hP : 0 ≤ P)
    (hsize : P * L ≤ 4 * H)
    (heffective : G ≤ 4300 * P ^ 5) :
    G * L ^ 5 ≤ 4300 * (4 * H) ^ 5 := by
  have hLfive : 0 ≤ L ^ 5 := pow_nonneg hL _
  have hpow : (P * L) ^ 5 ≤ (4 * H) ^ 5 := by
    gcongr
  calc
    G * L ^ 5 ≤ (4300 * P ^ 5) * L ^ 5 :=
      mul_le_mul_of_nonneg_right heffective hLfive
    _ = 4300 * (P * L) ^ 5 := by ring
    _ ≤ 4300 * (4 * H) ^ 5 := by linarith

/-- The fixed-degree estimate supplies the complementary index bound.
Here `R=log D`, `G=log H`, and `K=log(2*12^331776)` in the application. -/
theorem pellEffective_indexUpper
    (H P G K R : ℝ)
    (hP : 0 ≤ P)
    (heffective : G ≤ K + 4050 * R)
    (hsize : P * R ≤ 4 * H) :
    P * (G - K) ≤ 16200 * H := by
  have hmul := mul_le_mul_of_nonneg_left heffective hP
  nlinarith

/-- Above the explicit logarithmic threshold the additive constant is
absorbed without a point-dependent choice of constant. -/
theorem pellEffective_indexUpperEventually
    (H P G K R : ℝ)
    (hP : 0 ≤ P)
    (heffective : G ≤ K + 4050 * R)
    (hsize : P * R ≤ 4 * H)
    (hthreshold : 2 * K ≤ G) :
    P * G ≤ 32400 * H := by
  have hbound := pellEffective_indexUpper H P G K R hP heffective hsize
  have hmul := mul_le_mul_of_nonneg_left hthreshold hP
  nlinarith

/-- A bounded index and an explicit effective estimate give a uniform
height bound. This is the exact fixed-fibre implication used in the note. -/
theorem pellEffective_boundedIndexHeight
    (H P M : ℝ)
    (hP : 0 ≤ P) (hPM : P ≤ M)
    (heffective : H ≤ Real.exp (4300 * P ^ 5)) :
    H ≤ Real.exp (4300 * M ^ 5) := by
  apply heffective.trans
  apply Real.exp_le_exp.mpr
  gcongr

namespace ABCPoint

/-- Positive summands satisfy the uniform product bound `c <= 2ab`. -/
theorem c_le_two_ab_for_jDenominator (P : ABCPoint) :
    P.c ≤ 2 * (P.a * P.b) := by
  have ha : (1 : ℝ) ≤ P.a := by exact_mod_cast P.a_pos
  have hb : (1 : ℝ) ≤ P.b := by exact_mod_cast P.b_pos
  have hsum : (P.a : ℝ) + P.b = P.c := by exact_mod_cast P.sum_eq
  have hprod : 0 ≤ ((P.a : ℝ) - 1) * ((P.b : ℝ) - 1) :=
    mul_nonneg (by linarith) (by linarith)
  have hreal : (P.c : ℝ) ≤ 2 * ((P.a : ℝ) * P.b) := by nlinarith
  exact_mod_cast hreal

/-- The raw Frey denominator is at most 256 times its reduced value;
this reuses the actual coprimality and gcd-cancellation theorem. -/
theorem freyJRawDen_le_256_reducedDen (P : ABCPoint) :
    P.freyJRawDen ≤ 256 * P.freyJReducedDen := by
  calc
    P.freyJRawDen = P.freyJReducedDen * P.freyJContent :=
      P.freyJReducedDen_mul_content.symm
    _ ≤ P.freyJReducedDen * 256 :=
      Nat.mul_le_mul_left _ P.freyJContent_le_256
    _ = 256 * P.freyJReducedDen := Nat.mul_comm _ _

/-- A uniform lower bound on the **actual reduced** Frey j-denominator.
Together with `freyJReducedNum_le`, this rules out an unbounded Frey
family under any fixed polynomial-in-log-numerator denominator condition. -/
theorem c_pow_four_le_1024_freyJReducedDen (P : ABCPoint) :
    P.c ^ 4 ≤ 1024 * P.freyJReducedDen := by
  have hbase : P.c ^ 2 ≤ 2 * (P.a * P.b * P.c) := by
    have h := Nat.mul_le_mul_right P.c P.c_le_two_ab_for_jDenominator
    nlinarith
  have hraw : P.c ^ 4 ≤ 4 * P.freyJRawDen := by
    calc
      P.c ^ 4 = (P.c ^ 2) ^ 2 := by ring
      _ ≤ (2 * (P.a * P.b * P.c)) ^ 2 := by gcongr
      _ = 4 * P.freyJRawDen := by unfold freyJRawDen; ring
  calc
    P.c ^ 4 ≤ 4 * P.freyJRawDen := hraw
    _ ≤ 4 * (256 * P.freyJReducedDen) :=
      Nat.mul_le_mul_left 4 P.freyJRawDen_le_256_reducedDen
    _ = 1024 * P.freyJReducedDen := by ring

/-- Logarithmic version of the actual-denominator lower bound. -/
theorem four_height_le_log_1024_add_log_freyJReducedDen (P : ABCPoint) :
    4 * P.height ≤ Real.log 1024 + Real.log (P.freyJReducedDen : ℝ) := by
  rw [P.height_eq_log_c]
  have hcpos : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hdpos : (0 : ℝ) < P.freyJReducedDen := by
    exact_mod_cast P.freyJReducedDen_pos
  have hbound : (P.c : ℝ) ^ 4 ≤ 1024 * (P.freyJReducedDen : ℝ) := by
    exact_mod_cast P.c_pow_four_le_1024_freyJReducedDen
  calc
    4 * Real.log (P.c : ℝ) = Real.log ((P.c : ℝ) ^ 4) := by
      rw [Real.log_pow]
      norm_num
    _ ≤ Real.log (1024 * (P.freyJReducedDen : ℝ)) :=
      Real.log_le_log (pow_pos hcpos _) hbound
    _ = Real.log 1024 + Real.log (P.freyJReducedDen : ℝ) := by
      rw [Real.log_mul (by norm_num : (1024 : ℝ) ≠ 0) hdpos.ne']

end ABCPoint

#print axioms pellEffective_genusOnePoint
#print axioms pellEffective_squareFactorDescent
#print axioms pellEffective_coefficientMajorant
#print axioms pellEffective_kernelFifthCorridor
#print axioms pellEffective_indexUpperEventually
#print axioms ABCPoint.c_pow_four_le_1024_freyJReducedDen
#print axioms ABCPoint.four_height_le_log_1024_add_log_freyJReducedDen

end IUTThreeClosures
