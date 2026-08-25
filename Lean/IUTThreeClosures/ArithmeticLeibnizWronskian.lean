/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.RingTheory.Coprime.Lemmas

/-!
# Arithmetic Leibniz--Wronskian bridge

This file proves an exact, non-circular arithmetic Wronskian chain.  Divisibility
of three integer derivative values by the corresponding powerful parts, one
additive compatibility equation, and a nonzero Wronskian imply an explicit
height--radical inequality.  A free prime-weight derivative is then constructed
and shown to satisfy the required divisibility and Leibniz identities.

The final section formalizes a three-dimensional obstruction showing why an
ordinary short-kernel-vector theorem does not ensure Wronskian nondegeneracy.
No small-vector existence theorem or abc estimate is assumed as a field.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

/-! ## Powerful parts and primitive triples -/

/-- The part of `n` left after removing one copy of every prime divisor. -/
def abcPowerfulPart (n : ℕ) : ℕ :=
  n / abcRadical n

/-- Radical times powerful part recovers the original natural number. -/
theorem abcRadical_mul_abcPowerfulPart (n : ℕ) :
    abcRadical n * abcPowerfulPart n = n := by
  unfold abcPowerfulPart
  apply Nat.mul_div_cancel'
  rw [abcRadical_eq_natRadical]
  exact radical_dvd_self

/-- The powerful part divides the original number. -/
theorem abcPowerfulPart_dvd (n : ℕ) : abcPowerfulPart n ∣ n := by
  refine ⟨abcRadical n, ?_⟩
  rw [mul_comm, abcRadical_mul_abcPowerfulPart]

namespace ABCPoint

/-- Powerful parts of `a` and `b` remain coprime. -/
theorem coprime_powerfulPart_a_b (P : ABCPoint) :
    Nat.Coprime (abcPowerfulPart P.a) (abcPowerfulPart P.b) :=
  Nat.Coprime.of_dvd (abcPowerfulPart_dvd P.a)
    (abcPowerfulPart_dvd P.b) P.pairwise_coprime.1

/-- Powerful parts of `a` and `c` remain coprime. -/
theorem coprime_powerfulPart_a_c (P : ABCPoint) :
    Nat.Coprime (abcPowerfulPart P.a) (abcPowerfulPart P.c) :=
  Nat.Coprime.of_dvd (abcPowerfulPart_dvd P.a)
    (abcPowerfulPart_dvd P.c) P.pairwise_coprime.2.2.symm

/-- Powerful parts of `b` and `c` remain coprime. -/
theorem coprime_powerfulPart_b_c (P : ABCPoint) :
    Nat.Coprime (abcPowerfulPart P.b) (abcPowerfulPart P.c) :=
  Nat.Coprime.of_dvd (abcPowerfulPart_dvd P.b)
    (abcPowerfulPart_dvd P.c) P.pairwise_coprime.2.1

/-- The elementary radical is multiplicative across a primitive abc triple. -/
theorem abcRadical_abcProduct (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) =
      abcRadical P.a * abcRadical P.b * abcRadical P.c := by
  simp only [abcRadical_eq_natRadical]
  have hab : IsRelPrime P.a P.b :=
    Nat.coprime_iff_isRelPrime.mp P.pairwise_coprime.1
  have habcNat : Nat.Coprime (P.a * P.b) P.c := by
    rw [Nat.coprime_mul_iff_left]
    exact ⟨P.pairwise_coprime.2.2.symm,
      P.pairwise_coprime.2.1⟩
  have habc : IsRelPrime (P.a * P.b) P.c :=
    Nat.coprime_iff_isRelPrime.mp habcNat
  rw [radical_mul habc, radical_mul hab]

/-- Exact factorization of `abc` into its radical and the three powerful
parts. -/
theorem radical_mul_powerfulProduct (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) *
        (abcPowerfulPart P.a * abcPowerfulPart P.b *
          abcPowerfulPart P.c) =
      P.a * P.b * P.c := by
  rw [P.abcRadical_abcProduct]
  calc
    (abcRadical P.a * abcRadical P.b * abcRadical P.c) *
          (abcPowerfulPart P.a * abcPowerfulPart P.b *
            abcPowerfulPart P.c) =
        (abcRadical P.a * abcPowerfulPart P.a) *
          (abcRadical P.b * abcPowerfulPart P.b) *
            (abcRadical P.c * abcPowerfulPart P.c) := by ring
    _ = P.a * P.b * P.c := by
      rw [abcRadical_mul_abcPowerfulPart,
        abcRadical_mul_abcPowerfulPart,
        abcRadical_mul_abcPowerfulPart]

end ABCPoint

/-! ## Exact conditional Wronskian chain -/

/-- The arithmetic Wronskian attached to two integer derivative values. -/
def arithmeticWronskian (P : ABCPoint) (Da Db : ℤ) : ℤ :=
  (P.a : ℤ) * Db - (P.b : ℤ) * Da

/-- The three powerful parts divide the Wronskian product whenever the
derivative values have the required local divisibility and additive
compatibility. -/
theorem powerfulProduct_dvd_arithmeticWronskian
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc) :
    ((abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c : ℕ) : ℤ) ∣
      arithmeticWronskian P Da Db := by
  have hqa_a : (abcPowerfulPart P.a : ℤ) ∣ (P.a : ℤ) := by
    exact_mod_cast abcPowerfulPart_dvd P.a
  have hqb_b : (abcPowerfulPart P.b : ℤ) ∣ (P.b : ℤ) := by
    exact_mod_cast abcPowerfulPart_dvd P.b
  have hqc_c : (abcPowerfulPart P.c : ℤ) ∣ (P.c : ℤ) := by
    exact_mod_cast abcPowerfulPart_dvd P.c
  have hqaW : (abcPowerfulPart P.a : ℤ) ∣
      arithmeticWronskian P Da Db := by
    exact dvd_sub (dvd_mul_of_dvd_left hqa_a Db)
      (dvd_mul_of_dvd_right hDa (P.b : ℤ))
  have hqbW : (abcPowerfulPart P.b : ℤ) ∣
      arithmeticWronskian P Da Db := by
    exact dvd_sub (dvd_mul_of_dvd_right hDb (P.a : ℤ))
      (dvd_mul_of_dvd_left hqb_b Da)
  have hWalt : arithmeticWronskian P Da Db =
      (P.c : ℤ) * Db - (P.b : ℤ) * Dc := by
    unfold arithmeticWronskian
    have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
    linear_combination Db * hsum - (P.b : ℤ) * hadd
  have hqcW : (abcPowerfulPart P.c : ℤ) ∣
      arithmeticWronskian P Da Db := by
    rw [hWalt]
    exact dvd_sub (dvd_mul_of_dvd_left hqc_c Db)
      (dvd_mul_of_dvd_right hDc (P.b : ℤ))
  have habInt : IsCoprime (abcPowerfulPart P.a : ℤ)
      (abcPowerfulPart P.b : ℤ) :=
    P.coprime_powerfulPart_a_b.isCoprime
  have habW :
      (abcPowerfulPart P.a : ℤ) * abcPowerfulPart P.b ∣
        arithmeticWronskian P Da Db :=
    habInt.mul_dvd hqaW hqbW
  have habcNat : Nat.Coprime
      (abcPowerfulPart P.a * abcPowerfulPart P.b)
      (abcPowerfulPart P.c) := by
    rw [Nat.coprime_mul_iff_left]
    exact ⟨P.coprime_powerfulPart_a_c,
      P.coprime_powerfulPart_b_c⟩
  have habcInt : IsCoprime
      ((abcPowerfulPart P.a * abcPowerfulPart P.b : ℕ) : ℤ)
      (abcPowerfulPart P.c : ℤ) := habcNat.isCoprime
  simpa only [Nat.cast_mul] using habcInt.mul_dvd habW hqcW

/-- A nonzero arithmetic Wronskian dominates the product of powerful parts. -/
theorem powerfulProduct_le_natAbs_arithmeticWronskian
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc)
    (hW : arithmeticWronskian P Da Db ≠ 0) :
    abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c ≤
      (arithmeticWronskian P Da Db).natAbs := by
  have hdiv := powerfulProduct_dvd_arithmeticWronskian
    P Da Db Dc hadd hDa hDb hDc
  exact Int.natAbs_le_of_dvd_ne_zero hdiv hW

/-- Triangle bound for the arithmetic Wronskian after casting to `ℝ`. -/
theorem arithmeticWronskian_natAbs_le
    (P : ABCPoint) (Da Db : ℤ) :
    ((arithmeticWronskian P Da Db).natAbs : ℝ) ≤
      (P.a : ℝ) * (Db.natAbs : ℝ) +
        (P.b : ℝ) * (Da.natAbs : ℝ) := by
  have haAbs : |(P.a : ℝ)| = (P.a : ℝ) :=
    abs_of_nonneg (by positivity)
  have hbAbs : |(P.b : ℝ)| = (P.b : ℝ) :=
    abs_of_nonneg (by positivity)
  have hDaAbs : |(Da : ℝ)| = (Da.natAbs : ℝ) := by
    symm
    rw [← Int.cast_abs]
    exact Nat.cast_natAbs Da
  have hDbAbs : |(Db : ℝ)| = (Db.natAbs : ℝ) := by
    symm
    rw [← Int.cast_abs]
    exact Nat.cast_natAbs Db
  rw [Nat.cast_natAbs]
  unfold arithmeticWronskian
  push_cast
  calc
    |(P.a : ℝ) * (Db : ℝ) - (P.b : ℝ) * (Da : ℝ)| ≤
        |(P.a : ℝ) * (Db : ℝ)| + |(P.b : ℝ) * (Da : ℝ)| :=
      abs_sub _ _
    _ = (P.a : ℝ) * (Db.natAbs : ℝ) +
        (P.b : ℝ) * (Da.natAbs : ℝ) := by
      rw [abs_mul, abs_mul, haAbs, hbAbs, hDaAbs, hDbAbs]

/-- Exact real cancellation consequence of a compatible nonzero Wronskian. -/
theorem c_le_radical_mul_normalizedDerivative
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc)
    (hW : arithmeticWronskian P Da Db ≠ 0) :
    (P.c : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
      ((Da.natAbs : ℝ) / (P.a : ℝ) +
        (Db.natAbs : ℝ) / (P.b : ℝ)) := by
  let q : ℕ := abcPowerfulPart P.a * abcPowerfulPart P.b *
    abcPowerfulPart P.c
  have hqNat : q ≤ (arithmeticWronskian P Da Db).natAbs := by
    exact powerfulProduct_le_natAbs_arithmeticWronskian
      P Da Db Dc hadd hDa hDb hDc hW
  have hq : (q : ℝ) ≤ ((arithmeticWronskian P Da Db).natAbs : ℝ) := by
    exact_mod_cast hqNat
  have hfactorNat := P.radical_mul_powerfulProduct
  have hfactor :
      (abcRadical (P.a * P.b * P.c) : ℝ) * (q : ℝ) =
        (P.a : ℝ) * P.b * P.c := by
    exact_mod_cast hfactorNat
  have hprod :
      (P.a : ℝ) * P.b * P.c ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) *
          ((P.a : ℝ) * (Db.natAbs : ℝ) +
            (P.b : ℝ) * (Da.natAbs : ℝ)) := by
    calc
      (P.a : ℝ) * P.b * P.c =
          (abcRadical (P.a * P.b * P.c) : ℝ) * q := hfactor.symm
      _ ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
          ((arithmeticWronskian P Da Db).natAbs : ℝ) :=
        mul_le_mul_of_nonneg_left hq (Nat.cast_nonneg _)
      _ ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
          ((P.a : ℝ) * (Db.natAbs : ℝ) +
            (P.b : ℝ) * (Da.natAbs : ℝ)) :=
        mul_le_mul_of_nonneg_left
          (arithmeticWronskian_natAbs_le P Da Db) (Nat.cast_nonneg _)
  have ha : (0 : ℝ) < P.a := by exact_mod_cast P.a_pos
  have hb : (0 : ℝ) < P.b := by exact_mod_cast P.b_pos
  apply le_of_mul_le_mul_left ?_ (mul_pos ha hb)
  calc
    (P.a : ℝ) * P.b * P.c ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) *
          ((P.a : ℝ) * (Db.natAbs : ℝ) +
            (P.b : ℝ) * (Da.natAbs : ℝ)) := hprod
    _ = (P.a : ℝ) * P.b *
        ((abcRadical (P.a * P.b * P.c) : ℝ) *
          ((Da.natAbs : ℝ) / (P.a : ℝ) +
            (Db.natAbs : ℝ) / (P.b : ℝ))) := by
      field_simp
      ring

/-- Logarithmic form of the real cancellation theorem.  The nonzero
Wronskian forces the normalized derivative mass to be strictly positive, so
no positivity assumption is hidden in the logarithm. -/
theorem log_c_le_log_radical_add_log_normalizedDerivative
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc)
    (hW : arithmeticWronskian P Da Db ≠ 0) :
    Real.log (P.c : ℝ) ≤
      Real.log (abcRadical (P.a * P.b * P.c) : ℝ) +
        Real.log ((Da.natAbs : ℝ) / (P.a : ℝ) +
          (Db.natAbs : ℝ) / (P.b : ℝ)) := by
  let mass : ℝ := (Da.natAbs : ℝ) / (P.a : ℝ) +
    (Db.natAbs : ℝ) / (P.b : ℝ)
  have hreal : (P.c : ℝ) ≤
      (abcRadical (P.a * P.b * P.c) : ℝ) * mass := by
    exact c_le_radical_mul_normalizedDerivative
      P Da Db Dc hadd hDa hDb hDc hW
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hrad :
      (0 : ℝ) < abcRadical (P.a * P.b * P.c) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hmassNonneg : 0 ≤ mass := by
    dsimp [mass]
    positivity
  have hmass : 0 < mass := by
    by_contra hnot
    have hmzero : mass = 0 :=
      le_antisymm (le_of_not_gt hnot) hmassNonneg
    rw [hmzero, mul_zero] at hreal
    linarith
  have hlog := Real.log_le_log hc hreal
  rw [Real.log_mul hrad.ne' hmass.ne'] at hlog
  exact hlog

/-! ## Concrete free prime-weight arithmetic derivative -/

/-- The ordinary Leibniz arithmetic derivative with freely chosen integer
prime weights.  The sum is finite because it is taken over the actual prime
support of `n`. -/
def weightedArithmeticDerivative (x : ℕ → ℤ) (n : ℕ) : ℤ :=
  ∑ p ∈ n.primeFactors,
    (((n / p) * n.factorization p : ℕ) : ℤ) * x p

/-- Rational logarithmic derivative used only to prove the integer Leibniz
identity. -/
noncomputable def weightedLogDerivative (x : ℕ → ℤ) (n : ℕ) : ℚ :=
  n.factorization.sum fun p e =>
    (e : ℚ) * (x p : ℚ) / (p : ℚ)

/-- The logarithmic derivative turns multiplication into addition. -/
theorem weightedLogDerivative_mul (x : ℕ → ℤ) {m n : ℕ}
    (hm : m ≠ 0) (hn : n ≠ 0) :
    weightedLogDerivative x (m * n) =
      weightedLogDerivative x m + weightedLogDerivative x n := by
  classical
  unfold weightedLogDerivative
  rw [Nat.factorization_mul hm hn]
  apply Finsupp.sum_add_index'
  · intro p
    simp
  · intro p e f
    push_cast
    ring

/-- After casting to `ℚ`, the integer derivative is `n` times its logarithmic
derivative. -/
theorem weightedArithmeticDerivative_cast (x : ℕ → ℤ) {n : ℕ}
    (hn : n ≠ 0) :
    (weightedArithmeticDerivative x n : ℚ) =
      (n : ℚ) * weightedLogDerivative x n := by
  classical
  unfold weightedArithmeticDerivative weightedLogDerivative
  change
    (↑(∑ p ∈ n.primeFactors,
      (((n / p) * n.factorization p : ℕ) : ℤ) * x p) : ℚ) =
      (n : ℚ) *
        ∑ p ∈ n.primeFactors,
          (n.factorization p : ℚ) * (x p : ℚ) / (p : ℚ)
  rw [Int.cast_sum]
  simp only [Int.cast_mul, Int.cast_natCast, Nat.cast_mul]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro p hp
  have hpDiv : p ∣ n := Nat.dvd_of_mem_primeFactors hp
  have hpPrime : p.Prime := (Nat.mem_primeFactors.mp hp).1
  have hpRat : (p : ℚ) ≠ 0 := by exact_mod_cast hpPrime.ne_zero
  rw [Nat.cast_div hpDiv hpRat]
  field_simp

/-- The free prime-weight derivative satisfies the ordinary Leibniz rule. -/
theorem weightedArithmeticDerivative_mul (x : ℕ → ℤ) {m n : ℕ}
    (hm : m ≠ 0) (hn : n ≠ 0) :
    weightedArithmeticDerivative x (m * n) =
      (m : ℤ) * weightedArithmeticDerivative x n +
        (n : ℤ) * weightedArithmeticDerivative x m := by
  have hq :
      (weightedArithmeticDerivative x (m * n) : ℚ) =
        (((m : ℤ) * weightedArithmeticDerivative x n +
          (n : ℤ) * weightedArithmeticDerivative x m : ℤ) : ℚ) := by
    rw [weightedArithmeticDerivative_cast x (mul_ne_zero hm hn),
      weightedLogDerivative_mul x hm hn]
    push_cast
    rw [weightedArithmeticDerivative_cast x hn,
      weightedArithmeticDerivative_cast x hm]
    ring
  exact_mod_cast hq

/-- Every prime-support summand retains the full powerful part of `n`. -/
theorem abcPowerfulPart_dvd_div_of_mem_primeFactors {n p : ℕ}
    (hp : p ∈ n.primeFactors) :
    abcPowerfulPart n ∣ n / p := by
  rw [Nat.dvd_div_iff_mul_dvd (Nat.dvd_of_mem_primeFactors hp)]
  have hpRad : p ∣ abcRadical n := by
    unfold abcRadical
    exact Finset.dvd_prod_of_mem id hp
  have hmul := mul_dvd_mul_right hpRad (abcPowerfulPart n)
  simpa only [abcRadical_mul_abcPowerfulPart] using hmul

/-- The powerful part divides every concrete free-weight derivative value. -/
theorem abcPowerfulPart_dvd_weightedArithmeticDerivative
    (x : ℕ → ℤ) (n : ℕ) :
    (abcPowerfulPart n : ℤ) ∣ weightedArithmeticDerivative x n := by
  classical
  unfold weightedArithmeticDerivative
  apply Finset.dvd_sum
  intro p hp
  have hdivNat : abcPowerfulPart n ∣ n / p :=
    abcPowerfulPart_dvd_div_of_mem_primeFactors hp
  have hdivInt : (abcPowerfulPart n : ℤ) ∣ ((n / p : ℕ) : ℤ) := by
    exact_mod_cast hdivNat
  have hterm : (abcPowerfulPart n : ℤ) ∣
      ((n / p : ℕ) : ℤ) * (n.factorization p : ℤ) * x p :=
    dvd_mul_of_dvd_left
      (dvd_mul_of_dvd_left hdivInt (n.factorization p : ℤ)) (x p)
  simpa only [Nat.cast_mul] using hterm

/-- The abstract Wronskian height bound specialized to the concrete
free-prime-weight derivative.  The only remaining hypothesis is the one
integer linear relation on the weights, together with nondegeneracy. -/
theorem weightedArithmeticDerivative_abc_bound
    (P : ABCPoint) (x : ℕ → ℤ)
    (hadd : weightedArithmeticDerivative x P.a +
      weightedArithmeticDerivative x P.b =
        weightedArithmeticDerivative x P.c)
    (hW : arithmeticWronskian P
      (weightedArithmeticDerivative x P.a)
      (weightedArithmeticDerivative x P.b) ≠ 0) :
    (P.c : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
      (((weightedArithmeticDerivative x P.a).natAbs : ℝ) /
          (P.a : ℝ) +
        ((weightedArithmeticDerivative x P.b).natAbs : ℝ) /
          (P.b : ℝ)) := by
  exact c_le_radical_mul_normalizedDerivative P
    (weightedArithmeticDerivative x P.a)
    (weightedArithmeticDerivative x P.b)
    (weightedArithmeticDerivative x P.c)
    hadd
    (abcPowerfulPart_dvd_weightedArithmeticDerivative x P.a)
    (abcPowerfulPart_dvd_weightedArithmeticDerivative x P.b)
    (abcPowerfulPart_dvd_weightedArithmeticDerivative x P.c)
    hW

/-! ## A three-dimensional obstruction to naive Siegel selection -/

/-- The kernel of `(X,Y,Z) ↦ H X + Y` always contains a sup-norm-one vector
annihilated by `B(X,Y,Z)=X`. -/
theorem siegel_short_kernel_vector_is_degenerate (H : ℕ) :
    ∃ X Y Z : ℤ,
      (H : ℤ) * X + Y = 0 ∧ X = 0 ∧
        max X.natAbs (max Y.natAbs Z.natAbs) = 1 := by
  exact ⟨0, 0, 1, by simp⟩

/-- Every kernel vector not annihilated by `B(X,Y,Z)=X` has a coordinate of
size at least `H`. -/
theorem siegel_nondegenerate_kernel_lower_bound
    (H : ℕ) {X Y _Z : ℤ}
    (hker : (H : ℤ) * X + Y = 0) (hB : X ≠ 0) :
    H ≤ Y.natAbs := by
  have hY : Y = -(H : ℤ) * X := by linear_combination hker
  rw [hY, Int.natAbs_mul, Int.natAbs_neg, Int.natAbs_natCast]
  exact Nat.le_mul_of_pos_right H (Int.natAbs_pos.mpr hB)

end IUTThreeClosures
