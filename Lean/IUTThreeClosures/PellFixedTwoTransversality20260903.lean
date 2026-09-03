/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellPolynomialAllIndexFormalization20260902
import IUTThreeClosures.PellSquareRootDescent20260831
import IUTThreeClosures.PellPrimeIndexDichotomy20260831
import Mathlib.Algebra.CharP.Lemmas

/-!
# Fixed-parameter Pell support transversality

The ordinary mathematical proof precedes this module in
`research/ABC_PELL_FIXED_TWO_TRANSVERSALITY_2026_09_03.md`.

For an odd prime `ell = 2*m+1`, the matrix Frobenius calculation in this
file proves the exact congruences

`A_ell = 1 (mod ell)` and `B_ell = 2^m (mod ell)`

for `(1+sqrt 2)^ell = A_ell+B_ell*sqrt 2`.  In particular the index does
not divide either coordinate.  Combined with coordinate coprimality and
the already formalized polynomial derivative identities, this proves
derivative transversality at every actual support prime for the fixed
parameter `T=2`, without assuming a rank-of-apparition theorem.

The file then instantiates the all-support squarefull/zero-displacement
equivalence.  It deliberately leaves that equivalent exclusion as a named
open proposition.  The actual `(ell,p)=(7,13)` collision refutes only the
stronger assertion that no individual support displacement can vanish.
No squarefull Pell term, abc counterexample, or abc theorem is asserted.
-/

namespace IUTThreeClosures
namespace PellFixedTwoTransversality20260903

open Matrix
open IUTThreeClosures.PellSquareRootDescent20260831
open IUTThreeClosures.PellPolynomialAllIndexFormalization20260902
open IUTThreeClosures.PellPolynomialHenselSpecialization20260902

def stepMatrix : Matrix (Fin 2) (Fin 2) ℤ := !![1, 2; 1, 1]
def sqrtMatrix : Matrix (Fin 2) (Fin 2) ℤ := !![0, 2; 1, 0]

theorem step_eq_one_add : stepMatrix = 1 + sqrtMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [stepMatrix, sqrtMatrix]

theorem sqrt_sq : sqrtMatrix ^ 2 = !![2, 0; 0, 2] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [pow_two, sqrtMatrix, Matrix.mul_apply, Fin.sum_univ_two]

theorem two_matrix : (2 : Matrix (Fin 2) (Fin 2) ℤ) = !![2, 0; 0, 2] := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [Matrix.ofNat_apply]

theorem sqrt_pow_odd (m : ℕ) :
    sqrtMatrix ^ (2 * m + 1) =
      (2 : Matrix (Fin 2) (Fin 2) ℤ) ^ m * sqrtMatrix := by
  rw [pow_add, pow_mul, sqrt_sq, ← two_matrix]
  simp

theorem two_matrix_pow (m : ℕ) :
    (2 : Matrix (Fin 2) (Fin 2) ℤ) ^ m =
      !![(2 : ℤ) ^ m, 0; 0, (2 : ℤ) ^ m] := by
  induction m with
  | zero =>
      ext i j
      fin_cases i <;> fin_cases j <;>
        simp
  | succ m ih =>
      rw [pow_succ, ih, two_matrix]
      ext i j
      fin_cases i <;> fin_cases j <;>
        simp [Matrix.mul_apply, Fin.sum_univ_two, pow_succ]

theorem sqrt_pow_odd_explicit (m : ℕ) :
    sqrtMatrix ^ (2 * m + 1) =
      !![0, (2 : ℤ) ^ (m + 1); (2 : ℤ) ^ m, 0] := by
  rw [sqrt_pow_odd]
  rw [two_matrix_pow]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two, sqrtMatrix, pow_succ]

theorem sqrt_pow_odd_first_col (m : ℕ) :
    (sqrtMatrix ^ (2 * m + 1)) 0 0 = 0 ∧
      (sqrtMatrix ^ (2 * m + 1)) 1 0 = (2 : ℤ) ^ m := by
  rw [sqrt_pow_odd_explicit]
  simp

theorem freshman_remainder_first_col
    (ell : ℕ) (R : Matrix (Fin 2) (Fin 2) ℤ) :
    (((ell : Matrix (Fin 2) (Fin 2) ℤ) *
        (1 : Matrix (Fin 2) (Fin 2) ℤ) * sqrtMatrix * R) 0 0 =
      (ell : ℤ) * (2 * R 1 0)) ∧
    (((ell : Matrix (Fin 2) (Fin 2) ℤ) *
        (1 : Matrix (Fin 2) (Fin 2) ℤ) * sqrtMatrix * R) 1 0 =
      (ell : ℤ) * R 0 0) := by
  constructor
  · simp [Matrix.mul_apply, Fin.sum_univ_two, sqrtMatrix,
      Matrix.natCast_apply]
    ring
  · simp [Matrix.mul_apply, Fin.sum_univ_two, sqrtMatrix,
      Matrix.natCast_apply]

theorem step_mul_first_col (M : Matrix (Fin 2) (Fin 2) ℤ) :
    (stepMatrix * M) 0 0 = M 0 0 + 2 * M 1 0 ∧
      (stepMatrix * M) 1 0 = M 0 0 + M 1 0 := by
  constructor <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two, stepMatrix]

theorem step_pow_first_col (n : ℕ) :
    (stepMatrix ^ n) 0 0 = ((sqrtTwoOrbit n).1 : ℤ) ∧
      (stepMatrix ^ n) 1 0 = ((sqrtTwoOrbit n).2 : ℤ) := by
  induction n with
  | zero => simp [stepMatrix, sqrtTwoOrbit]
  | succ n ih =>
      rw [pow_succ']
      rw [sqrtTwoOrbit_succ]
      rw [(step_mul_first_col (stepMatrix ^ n)).1,
        (step_mul_first_col (stepMatrix ^ n)).2, ih.1, ih.2]
      simp

theorem prime_index_coordinate_expansion
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    ∃ rA rB : ℤ,
      ((sqrtTwoOrbit ell).1 : ℤ) = 1 + ell * rA ∧
      ((sqrtTwoOrbit ell).2 : ℤ) = (2 : ℤ) ^ m + ell * rB := by
  subst ell
  have hcomm : Commute (1 : Matrix (Fin 2) (Fin 2) ℤ) sqrtMatrix :=
    Commute.one_left sqrtMatrix
  rcases hcomm.exists_add_pow_prime_eq hprime with ⟨R, hR⟩
  rw [← step_eq_one_add] at hR
  have hA := congrArg (fun M : Matrix (Fin 2) (Fin 2) ℤ => M 0 0) hR
  have hB := congrArg (fun M : Matrix (Fin 2) (Fin 2) ℤ => M 1 0) hR
  simp only [Matrix.add_apply] at hA hB
  rw [(step_pow_first_col (2 * m + 1)).1,
    (sqrt_pow_odd_first_col m).1,
    (freshman_remainder_first_col (2 * m + 1) R).1] at hA
  rw [(step_pow_first_col (2 * m + 1)).2,
    (sqrt_pow_odd_first_col m).2,
    (freshman_remainder_first_col (2 * m + 1) R).2] at hB
  simp only [one_pow, Matrix.one_apply_eq, add_zero] at hA
  simp only [one_pow,
    Matrix.one_apply_ne (show (1 : Fin 2) ≠ 0 by decide), zero_add] at hB
  exact ⟨2 * R 1 0, R 0 0, hA, hB⟩

theorem prime_index_not_dvd_coordinates
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    ¬ ell ∣ (sqrtTwoOrbit ell).1 ∧
      ¬ ell ∣ (sqrtTwoOrbit ell).2 := by
  rcases prime_index_coordinate_expansion ell m hprime hell with
    ⟨rA, rB, hA, hB⟩
  constructor
  · intro hdA
    have hdAZ : (ell : ℤ) ∣ ((sqrtTwoOrbit ell).1 : ℤ) := by
      exact_mod_cast hdA
    have hmod : (1 : ℤ) ≡ ((sqrtTwoOrbit ell).1 : ℤ) [ZMOD ell] :=
      Int.modEq_iff_add_fac.mpr ⟨rA, hA⟩
    have hdOneZ : (ell : ℤ) ∣ 1 :=
      Int.modEq_zero_iff_dvd.mp (hmod.trans hdAZ.modEq_zero_int)
    have hdOne : ell ∣ 1 := by
      exact_mod_cast hdOneZ
    exact hprime.not_dvd_one hdOne
  · intro hdB
    have hdBZ : (ell : ℤ) ∣ ((sqrtTwoOrbit ell).2 : ℤ) := by
      exact_mod_cast hdB
    have hmod : ((2 : ℤ) ^ m) ≡
        ((sqrtTwoOrbit ell).2 : ℤ) [ZMOD ell] :=
      Int.modEq_iff_add_fac.mpr ⟨rB, hB⟩
    have hdPowZ : (ell : ℤ) ∣ (2 : ℤ) ^ m :=
      Int.modEq_zero_iff_dvd.mp (hmod.trans hdBZ.modEq_zero_int)
    have hdPow : ell ∣ 2 ^ m := by
      exact_mod_cast hdPowZ
    have hdTwo : ell ∣ 2 := hprime.dvd_of_dvd_pow hdPow
    have heq : ell = 2 :=
      (Nat.prime_dvd_prime_iff_eq hprime Nat.prime_two).mp hdTwo
    omega

theorem sqrtTwoOrbit_mod_two (n : ℕ) :
    (sqrtTwoOrbit n).1 % 2 = 1 ∧
      (sqrtTwoOrbit n).2 % 2 = n % 2 := by
  induction n with
  | zero => norm_num [sqrtTwoOrbit]
  | succ n ih =>
      rw [sqrtTwoOrbit_succ]
      constructor <;> omega

theorem odd_index_coordinates_odd
    (ell m : ℕ) (hell : ell = 2 * m + 1) :
    Odd (sqrtTwoOrbit ell).1 ∧ Odd (sqrtTwoOrbit ell).2 := by
  rw [Nat.odd_iff, Nat.odd_iff]
  rw [(sqrtTwoOrbit_mod_two ell).1, (sqrtTwoOrbit_mod_two ell).2, hell]
  omega

theorem sqrtTwoOrbit_fst_add_two (n : ℕ) :
    (sqrtTwoOrbit (n + 2)).1 =
      2 * (sqrtTwoOrbit (n + 1)).1 + (sqrtTwoOrbit n).1 := by
  rw [show n + 2 = (n + 1) + 1 by omega,
    sqrtTwoOrbit_succ, sqrtTwoOrbit_succ]
  omega

theorem sqrtTwoOrbit_snd_add_two (n : ℕ) :
    (sqrtTwoOrbit (n + 2)).2 =
      2 * (sqrtTwoOrbit (n + 1)).2 + (sqrtTwoOrbit n).2 := by
  rw [show n + 2 = (n + 1) + 1 by omega,
    sqrtTwoOrbit_succ, sqrtTwoOrbit_succ]
  omega

theorem pellFValue_two_eq_sqrtTwoOrbit_snd (n : ℕ) :
    pellFValue 2 n = ((sqrtTwoOrbit n).2 : ℤ) := by
  induction n using Nat.twoStepInduction with
  | zero => simp [sqrtTwoOrbit]
  | one => simp [sqrtTwoOrbit]
  | more n hn hn1 =>
      rw [pellFValue_add_two, sqrtTwoOrbit_snd_add_two, hn, hn1]
      push_cast
      ring

theorem pellLValue_two_eq_two_mul_sqrtTwoOrbit_fst (n : ℕ) :
    pellLValue 2 n = 2 * ((sqrtTwoOrbit n).1 : ℤ) := by
  induction n using Nat.twoStepInduction with
  | zero => simp [sqrtTwoOrbit]
  | one => simp [sqrtTwoOrbit]
  | more n hn hn1 =>
      rw [pellLValue_add_two, sqrtTwoOrbit_fst_add_two, hn, hn1]
      push_cast
      ring

theorem fixed_two_lucas_all_support_transverse
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    ∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).1 →
      IsCoprime ((pellL ell).derivative.eval 2) (p : ℤ) := by
  intro p hp hpA
  have hAB := sqrtTwoOrbit_coprime ell
  have hnEll := (prime_index_not_dvd_coordinates ell m hprime hell).1
  have hpne : p ≠ ell := by
    intro h
    subst p
    exact hnEll hpA
  have hpEll : p.Coprime ell := (Nat.coprime_primes hp hprime).2 hpne
  have hpB : p.Coprime (sqrtTwoOrbit ell).2 :=
    Nat.Coprime.of_dvd_left hpA hAB
  have hcopNat : p.Coprime (ell * (sqrtTwoOrbit ell).2) :=
    hpEll.mul_right hpB
  have hcopInt : IsCoprime (p : ℤ)
      ((ell : ℤ) * ((sqrtTwoOrbit ell).2 : ℤ)) := by
    exact Nat.isCoprime_iff_coprime.2 hcopNat
  have hread : (pellL ell).derivative.eval 2 =
      (ell : ℤ) * ((sqrtTwoOrbit ell).2 : ℤ) := by
    rw [pellL_derivative_eval, pellFValue_two_eq_sqrtTwoOrbit_snd]
  exact (lucas_derivative_transverse (p : ℤ) (ell : ℤ)
    ((sqrtTwoOrbit ell).2 : ℤ) ((pellL ell).derivative.eval 2)
    hcopInt hread).symm

theorem fixed_two_fibonacci_all_support_transverse
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    ∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).2 →
      IsCoprime ((pellF ell).derivative.eval 2) (p : ℤ) := by
  intro p hp hpB
  have hAB := sqrtTwoOrbit_coprime ell
  have hnEll := (prime_index_not_dvd_coordinates ell m hprime hell).2
  have hpne : p ≠ ell := by
    intro h
    subst p
    exact hnEll hpB
  have hpEll : p.Coprime ell := (Nat.coprime_primes hp hprime).2 hpne
  have hpA : p.Coprime (sqrtTwoOrbit ell).1 :=
    Nat.Coprime.of_dvd_left hpB hAB.symm
  have hcopNat : p.Coprime (ell * (sqrtTwoOrbit ell).1) :=
    hpEll.mul_right hpA
  have hcopInt : IsCoprime (p : ℤ)
      ((ell : ℤ) * ((sqrtTwoOrbit ell).1 : ℤ)) := by
    exact Nat.isCoprime_iff_coprime.2 hcopNat
  have hpBInt : (p : ℤ) ∣ ((sqrtTwoOrbit ell).2 : ℤ) := by
    exact_mod_cast hpB
  have hdelta := delta_mul_pellF_derivative_eval 2 ell
  rw [pellLValue_two_eq_two_mul_sqrtTwoOrbit_fst,
    pellFValue_two_eq_sqrtTwoOrbit_snd] at hdelta
  have hread : 4 * (pellF ell).derivative.eval 2 +
      ((sqrtTwoOrbit ell).2 : ℤ) =
      (ell : ℤ) * ((sqrtTwoOrbit ell).1 : ℤ) := by
    linarith
  exact (fibonacci_derivative_transverse (p : ℤ) (ell : ℤ)
    ((sqrtTwoOrbit ell).1 : ℤ) ((sqrtTwoOrbit ell).2 : ℤ)
    ((pellF ell).derivative.eval 2) hcopInt hpBInt hread).symm

theorem fixed_two_lucas_support_scale_unit
    (ell m : ℕ) (hell : ell = 2 * m + 1) :
    ∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).1 →
      IsCoprime (2 : ℤ) (p : ℤ) := by
  intro p _hp hpA
  have hoddA := (odd_index_coordinates_odd ell m hell).1
  have hcopNat : Nat.Coprime 2 p :=
    Nat.Coprime.of_dvd_right hpA hoddA.coprime_two_left
  exact Nat.isCoprime_iff_coprime.2 hcopNat

def FixedPrimeIndexAllZeroDisplacements (ell : ℕ) : Prop :=
  (∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).1 →
    FirstHenselDisplacementZero (pellL ell) 2 p) ∧
  (∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).2 →
    FirstHenselDisplacementZero (pellF ell) 2 p)

theorem fixed_two_squarefull_iff_all_zero_displacements
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    NatSquarefull
        ((sqrtTwoOrbit ell).1 * (sqrtTwoOrbit ell).2) ↔
      FixedPrimeIndexAllZeroDisplacements ell := by
  apply pell_squarefull_packet_iff_all_support_displacements
    ell (sqrtTwoOrbit ell).1 (sqrtTwoOrbit ell).2
  · exact sqrtTwoOrbit_coprime ell
  · exact pellLValue_two_eq_two_mul_sqrtTwoOrbit_fst ell
  · exact pellFValue_two_eq_sqrtTwoOrbit_snd ell
  · exact fixed_two_lucas_support_scale_unit ell m hell
  · exact fixed_two_lucas_all_support_transverse ell m hprime hell
  · exact fixed_two_fibonacci_all_support_transverse ell m hprime hell

/-- The remaining fixed-parameter gate, stated without hiding its
squarefullness content. -/
def FixedPrimeIndexZeroDisplacementExclusion : Prop :=
  ∀ ell m : ℕ, ell.Prime → ell = 2 * m + 1 →
    ¬ FixedPrimeIndexAllZeroDisplacements ell

/-- The original squarefull exclusion at odd prime indices. -/
def FixedPrimeIndexSquarefullExclusion : Prop :=
  ∀ ell m : ℕ, ell.Prime → ell = 2 * m + 1 →
    ¬ NatSquarefull ((sqrtTwoOrbit ell).1 * (sqrtTwoOrbit ell).2)

theorem fixed_zero_displacement_exclusion_iff_squarefull_exclusion :
    FixedPrimeIndexZeroDisplacementExclusion ↔
      FixedPrimeIndexSquarefullExclusion := by
  constructor
  · intro h ell m hprime hell hfull
    exact h ell m hprime hell
      ((fixed_two_squarefull_iff_all_zero_displacements
        ell m hprime hell).mp hfull)
  · intro h ell m hprime hell hzero
    exact h ell m hprime hell
      ((fixed_two_squarefull_iff_all_zero_displacements
        ell m hprime hell).mpr hzero)

/-- A deliberately stronger statement: no individual support prime ever
has zero first displacement.  The index-seven example below refutes it. -/
def FixedNoIndividualZeroDisplacement : Prop :=
  ∀ ell m : ℕ, ell.Prime → ell = 2 * m + 1 →
    (∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).1 →
      ¬ FirstHenselDisplacementZero (pellL ell) 2 p) ∧
    (∀ p : ℕ, p.Prime → p ∣ (sqrtTwoOrbit ell).2 →
      ¬ FirstHenselDisplacementZero (pellF ell) 2 p)

theorem index_seven_fibonacci_zero_displacement :
    FirstHenselDisplacementZero (pellF 7) 2 13 := by
  refine ⟨?_, ?_, ?_⟩
  · rw [← pellFValue]
    rw [pellFValue_two_eq_sqrtTwoOrbit_snd,
      IUTThreeClosures.PellPrimeIndexDichotomy20260831.sqrtTwoOrbit_seven]
    norm_num
  · apply fixed_two_fibonacci_all_support_transverse 7 3 (by norm_num) (by norm_num)
    · norm_num
    · rw [IUTThreeClosures.PellPrimeIndexDichotomy20260831.sqrtTwoOrbit_seven]
      norm_num
  · rw [← pellFValue]
    rw [pellFValue_two_eq_sqrtTwoOrbit_snd,
      IUTThreeClosures.PellPrimeIndexDichotomy20260831.sqrtTwoOrbit_seven]
    norm_num

theorem not_fixedNoIndividualZeroDisplacement :
    ¬ FixedNoIndividualZeroDisplacement := by
  intro h
  have hseven := h 7 3 (by norm_num) (by norm_num)
  exact hseven.2 13 (by norm_num) (by
    rw [IUTThreeClosures.PellPrimeIndexDichotomy20260831.sqrtTwoOrbit_seven]
    norm_num) index_seven_fibonacci_zero_displacement

end PellFixedTwoTransversality20260903
end IUTThreeClosures


