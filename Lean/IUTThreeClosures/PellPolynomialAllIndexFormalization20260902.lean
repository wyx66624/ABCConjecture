/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellPolynomialHenselSpecialization20260902
import Mathlib.Algebra.Polynomial.Taylor

/-!
# All-index polynomial Pell identities and the complete moving witness

The ordinary proofs precede this module in
`research/ABC_PELL_ALL_INDEX_FORMALIZATION_2026_09_02.md`.

This file defines the Fibonacci and Lucas polynomials over `Z[X]` at every
natural index, proves their norm and derivative identities, proves the full
one-digit polynomial Taylor--Hensel law, and packages every concrete premise
of the index-three `H-global-move` counterexample in one structure.

No squarefreeness theorem for polynomial sequences, rank-of-apparition
theorem, fixed-parameter squarefull exclusion, or abc statement is assumed.
-/

namespace IUTThreeClosures
namespace PellPolynomialAllIndexFormalization20260902

open Polynomial
open PellPolynomialHenselSpecialization20260902

/-! ## Polynomial Fibonacci and Lucas sequences -/

/-- Fibonacci polynomials with characteristic equation `u^2-X*u-1`. -/
noncomputable def pellF : ℕ → ℤ[X]
  | 0 => 0
  | 1 => 1
  | n + 2 => X * pellF (n + 1) + pellF n

/-- Companion Lucas polynomials for the same characteristic equation. -/
noncomputable def pellL : ℕ → ℤ[X]
  | 0 => 2
  | 1 => X
  | n + 2 => X * pellL (n + 1) + pellL n

@[simp] theorem pellF_zero : pellF 0 = 0 := rfl
@[simp] theorem pellF_one : pellF 1 = 1 := rfl
@[simp] theorem pellF_add_two (n : ℕ) :
    pellF (n + 2) = X * pellF (n + 1) + pellF n := rfl

@[simp] theorem pellL_zero : pellL 0 = 2 := rfl
@[simp] theorem pellL_one : pellL 1 = X := rfl
@[simp] theorem pellL_add_two (n : ℕ) :
    pellL (n + 2) = X * pellL (n + 1) + pellL n := rfl

/-- Integer specialization of the Fibonacci polynomial. -/
noncomputable def pellFValue (t : ℤ) (n : ℕ) : ℤ := (pellF n).eval t

/-- Integer specialization of the companion polynomial. -/
noncomputable def pellLValue (t : ℤ) (n : ℕ) : ℤ := (pellL n).eval t

@[simp] theorem pellFValue_zero (t : ℤ) : pellFValue t 0 = 0 := by
  simp [pellFValue]

@[simp] theorem pellFValue_one (t : ℤ) : pellFValue t 1 = 1 := by
  simp [pellFValue]

@[simp] theorem pellFValue_add_two (t : ℤ) (n : ℕ) :
    pellFValue t (n + 2) = t * pellFValue t (n + 1) + pellFValue t n := by
  simp [pellFValue]

@[simp] theorem pellLValue_zero (t : ℤ) : pellLValue t 0 = 2 := by
  simp [pellLValue]

@[simp] theorem pellLValue_one (t : ℤ) : pellLValue t 1 = t := by
  simp [pellLValue]

@[simp] theorem pellLValue_add_two (t : ℤ) (n : ℕ) :
    pellLValue t (n + 2) = t * pellLValue t (n + 1) + pellLValue t n := by
  simp [pellLValue]

/-- The polynomial recurrence specializes to the scalar `F3` used by the
moving witness. -/
theorem pellF_three_polynomial : pellF 3 = X ^ 2 + 1 := by
  simp [pellF]
  ring_nf

/-- The companion recurrence specializes to the scalar `L3`. -/
theorem pellL_three_polynomial : pellL 3 = X ^ 3 + 3 * X := by
  simp [pellL]
  ring_nf

theorem pellFValue_three_eq_F3 (t : ℤ) : pellFValue t 3 = F3 t := by
  rw [pellFValue, pellF_three_polynomial]
  simp [F3]

theorem pellLValue_three_eq_L3 (t : ℤ) : pellLValue t 3 = L3 t := by
  rw [pellLValue, pellL_three_polynomial]
  simp [L3]

/-- The companion is expressed without division through consecutive
Fibonacci polynomials. -/
theorem pellL_eq_two_mul_next_sub_X_mul (n : ℕ) :
    pellL n = 2 * pellF (n + 1) - X * pellF n := by
  induction n using Nat.twoStepInduction with
  | zero => simp
  | one => simp; ring_nf
  | more n hn hn1 =>
      rw [show n + 1 + 1 = n + 2 by omega] at hn1
      rw [pellL_add_two, hn1, hn]
      rw [show n + 2 + 1 = (n + 1) + 2 by omega,
        pellF_add_two n, pellF_add_two (n + 1)]
      rw [show n + 1 + 1 = n + 2 by omega, pellF_add_two n]
      ring_nf

/-- Shifted form of the companion/Fibonacci relation. -/
theorem pellL_succ_eq_X_mul_succ_add_two_mul (n : ℕ) :
    pellL (n + 1) = X * pellF (n + 1) + 2 * pellF n := by
  rw [pellL_eq_two_mul_next_sub_X_mul, pellF_add_two]
  ring

/-- Cassini's identity in the normalization with recurrence sign `+1`. -/
theorem pellF_cassini (n : ℕ) :
    pellF (n + 1) ^ 2 - X * pellF (n + 1) * pellF n - pellF n ^ 2 =
      (-1 : ℤ[X]) ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [show n + 1 + 1 = n + 2 by omega, pellF_add_two]
      conv_rhs => rw [pow_succ]
      rw [← ih]
      ring_nf

/-- Polynomial Pell norm identity for every natural index. -/
theorem pell_norm_identity (n : ℕ) :
    pellL n ^ 2 - (X ^ 2 + 4) * pellF n ^ 2 =
      4 * (-1 : ℤ[X]) ^ n := by
  rw [pellL_eq_two_mul_next_sub_X_mul, ← pellF_cassini n]
  ring

/-- A second companion identity used in the derivative induction. -/
theorem delta_mul_pellF_succ (n : ℕ) :
    (X ^ 2 + 4) * pellF (n + 1) = X * pellL (n + 1) + 2 * pellL n := by
  rw [pellL_eq_two_mul_next_sub_X_mul n,
    pellL_succ_eq_X_mul_succ_add_two_mul n]
  ring_nf

/-- The derivative of the companion polynomial is `n*F_n`. -/
theorem pellL_derivative (n : ℕ) :
    (pellL n).derivative = C (n : ℤ) * pellF n := by
  induction n using Nat.twoStepInduction with
  | zero => simp
  | one => simp
  | more n hn hn1 =>
      rw [pellL_add_two, derivative_add, derivative_mul, derivative_X,
        one_mul, hn1, hn]
      rw [pellL_succ_eq_X_mul_succ_add_two_mul]
      rw [pellF_add_two]
      have hc1 : C (((n + 1 : ℕ) : ℤ)) = C (n : ℤ) + 1 := by
        simp
      have hc2 : C (((n + 2 : ℕ) : ℤ)) = C (n : ℤ) + 2 := by
        simp
      rw [hc1, hc2]
      ring_nf

/-- Differential identity for the Fibonacci polynomial. -/
theorem delta_mul_pellF_derivative (n : ℕ) :
    (X ^ 2 + 4) * (pellF n).derivative =
      C (n : ℤ) * pellL n - X * pellF n := by
  induction n using Nat.twoStepInduction with
  | zero => simp
  | one => simp
  | more n hn hn1 =>
      rw [pellF_add_two, derivative_add, derivative_mul, derivative_X,
        one_mul]
      calc
        (X ^ 2 + 4) *
            (pellF (n + 1) + X * (pellF (n + 1)).derivative +
              (pellF n).derivative) =
            (X ^ 2 + 4) * pellF (n + 1) +
              X * ((X ^ 2 + 4) * (pellF (n + 1)).derivative) +
              (X ^ 2 + 4) * (pellF n).derivative := by ring_nf
        _ = (X ^ 2 + 4) * pellF (n + 1) +
              X * (C ((n + 1 : ℕ) : ℤ) * pellL (n + 1) -
                X * pellF (n + 1)) +
              (C (n : ℤ) * pellL n - X * pellF n) := by rw [hn1, hn]
        _ = C ((n + 2 : ℕ) : ℤ) * pellL (n + 2) -
              X * pellF (n + 2) := by
            rw [pellF_add_two, pellL_add_two, delta_mul_pellF_succ]
            have hc1 : C (((n + 1 : ℕ) : ℤ)) = C (n : ℤ) + 1 := by
              simp
            have hc2 : C (((n + 2 : ℕ) : ℤ)) = C (n : ℤ) + 2 := by
              simp
            rw [hc1, hc2]
            ring_nf

/-- Evaluation of the all-index norm identity at an arbitrary integer. -/
theorem pell_norm_identity_eval (t : ℤ) (n : ℕ) :
    pellLValue t n ^ 2 - (t ^ 2 + 4) * pellFValue t n ^ 2 =
      4 * (-1 : ℤ) ^ n := by
  have h := congrArg (fun P : ℤ[X] => P.eval t) (pell_norm_identity n)
  simpa [pellFValue, pellLValue] using h

/-- Evaluated companion derivative identity. -/
theorem pellL_derivative_eval (t : ℤ) (n : ℕ) :
    (pellL n).derivative.eval t = (n : ℤ) * pellFValue t n := by
  have h := congrArg (fun P : ℤ[X] => P.eval t) (pellL_derivative n)
  simpa [pellFValue] using h

/-- Evaluated Fibonacci derivative identity. -/
theorem delta_mul_pellF_derivative_eval (t : ℤ) (n : ℕ) :
    (t ^ 2 + 4) * (pellF n).derivative.eval t =
      (n : ℤ) * pellLValue t n - t * pellFValue t n := by
  have h := congrArg (fun P : ℤ[X] => P.eval t)
    (delta_mul_pellF_derivative n)
  simpa [pellFValue, pellLValue] using h

/-! ## Exact arbitrary-polynomial Taylor--Hensel law -/

/-- Integral first-order Taylor expansion with a quadratic remainder. -/
theorem polynomial_taylor_exact (f : ℤ[X]) (t z : ℤ) :
    ∃ G : ℤ,
      f.eval (t + z) = f.eval t + z * f.derivative.eval t + z ^ 2 * G := by
  rcases Polynomial.exists_mul_sq_add_linear_part_eq_eval_add f t z with
    ⟨G, hG⟩
  refine ⟨G, ?_⟩
  linarith

/-- The full first-order Taylor congruence at the `e`th digit. -/
theorem polynomial_taylor_hensel_mod
    (f : ℤ[X]) (p t h : ℤ) (e : ℕ) (he : 1 ≤ e) :
    f.eval (t + p ^ e * h) ≡
      f.eval t + p ^ e * h * f.derivative.eval t [ZMOD p ^ (e + 1)] := by
  rcases polynomial_taylor_exact f t (p ^ e * h) with ⟨G, hG⟩
  apply Int.modEq_of_dvd
  have hpow : p ^ (e + 1) ∣ p ^ (e + e) :=
    pow_dvd_pow p (by omega)
  have hrem : p ^ (e + 1) ∣ (p ^ e * h) ^ 2 * G := by
    have hdiv := hpow.mul_right (h ^ 2 * G)
    have heq : p ^ (e + e) * (h ^ 2 * G) = (p ^ e * h) ^ 2 * G := by
      rw [pow_add]
      ring
    rw [← heq]
    exact hdiv
  rcases hrem with ⟨q, hq⟩
  refine ⟨-q, ?_⟩
  rw [hG, hq]
  ring

/-- Full polynomial Hensel divisibility law after naming the old residual
quotient `c`. -/
theorem polynomial_hensel_dvd_iff
    (f : ℤ[X]) (p t c h : ℤ) (e : ℕ)
    (he : 1 ≤ e) (hp : p ≠ 0)
    (hold : f.eval t = p ^ e * c) :
    p ^ (e + 1) ∣ f.eval (t + p ^ e * h) ↔
      p ∣ c + h * f.derivative.eval t := by
  rcases polynomial_taylor_exact f t (p ^ e * h) with ⟨G, hG⟩
  have hpow : p ^ (e + 1) ∣ p ^ (e + e) :=
    pow_dvd_pow p (by omega)
  have hrem : p ^ (e + 1) ∣ (p ^ e * h) ^ 2 * G := by
    have hdiv := hpow.mul_right (h ^ 2 * G)
    have heq : p ^ (e + e) * (h ^ 2 * G) = (p ^ e * h) ^ 2 * G := by
      rw [pow_add]
      ring
    rw [← heq]
    exact hdiv
  have hmain :
      f.eval (t + p ^ e * h) =
        p ^ e * (c + h * f.derivative.eval t) + (p ^ e * h) ^ 2 * G := by
    rw [hG, hold]
    ring
  rw [hmain]
  constructor
  · intro htotal
    have hscaled : p ^ (e + 1) ∣ p ^ e *
        (c + h * f.derivative.eval t) := by
      have := dvd_sub htotal hrem
      simpa using this
    exact (pow_succ_dvd_scaled_iff p
      (c + h * f.derivative.eval t) e hp).mp hscaled
  · intro hdigit
    have hscaled : p ^ (e + 1) ∣ p ^ e *
        (c + h * f.derivative.eval t) := by
      exact (pow_succ_dvd_scaled_iff p
        (c + h * f.derivative.eval t) e hp).mpr hdigit
    exact dvd_add hscaled hrem

/-- A coprime derivative gives an existing and unique next digit modulo
`p`; primality of `p` is unnecessary for this algebraic statement. -/
theorem polynomial_hensel_exists_unique_digit
    (f : ℤ[X]) (p t c : ℤ) (e : ℕ)
    (he : 1 ≤ e) (hp : p ≠ 0)
    (hold : f.eval t = p ^ e * c)
    (hcop : IsCoprime (f.derivative.eval t) p) :
    ∃ h : ℤ,
      p ^ (e + 1) ∣ f.eval (t + p ^ e * h) ∧
      ∀ k : ℤ, p ^ (e + 1) ∣ f.eval (t + p ^ e * k) →
        k ≡ h [ZMOD p] := by
  have hcop' := hcop
  rcases hcop with ⟨a, b, hab⟩
  let h : ℤ := -c * a
  have hdigit : p ∣ c + h * f.derivative.eval t := by
    refine ⟨c * b, ?_⟩
    dsimp [h]
    calc
      c + (-c * a) * f.derivative.eval t =
          c * (1 - a * f.derivative.eval t) := by ring
      _ = c * (b * p) := by rw [← hab]; ring
      _ = p * (c * b) := by ring
  refine ⟨h, (polynomial_hensel_dvd_iff f p t c h e he hp hold).2 hdigit, ?_⟩
  intro k hk
  have hkDigit := (polynomial_hensel_dvd_iff f p t c k e he hp hold).1 hk
  exact hensel_digit_unique_mod p c (f.derivative.eval t) k h hcop' hkDigit hdigit

/-! ## All-support squarefull/displacement equivalence -/

/-- Elementary squarefullness, stated through every prime in the support. -/
def NatSquarefull (N : ℕ) : Prop :=
  ∀ p : ℕ, Nat.Prime p → p ∣ N → p ^ 2 ∣ N

/-- At a support prime, the fixed representative has zero first Hensel
displacement precisely when it is a simple root that persists modulo the
prime square. -/
def FirstHenselDisplacementZero (f : ℤ[X]) (t : ℤ) (p : ℕ) : Prop :=
  (p : ℤ) ∣ f.eval t ∧
  IsCoprime (f.derivative.eval t) (p : ℤ) ∧
  (p : ℤ) ^ 2 ∣ f.eval t

/-- Squarefullness is multiplicative across coprime factors. -/
theorem natSquarefull_mul_iff {A B : ℕ} (hAB : A.Coprime B) :
    NatSquarefull (A * B) ↔ NatSquarefull A ∧ NatSquarefull B := by
  constructor
  · intro hprod
    constructor
    · intro p hp hpA
      have hpAB : p ∣ A * B := dvd_mul_of_dvd_left hpA B
      have hpSqAB := hprod p hp hpAB
      have hpB : p.Coprime B := Nat.Coprime.of_dvd_left hpA hAB
      exact (hpB.pow_left 2).dvd_of_dvd_mul_right hpSqAB
    · intro p hp hpB
      have hpAB : p ∣ A * B := dvd_mul_of_dvd_right hpB A
      have hpSqAB := hprod p hp hpAB
      have hpA : p.Coprime A := Nat.Coprime.of_dvd_left hpB hAB.symm
      exact (hpA.pow_left 2).dvd_of_dvd_mul_left hpSqAB
  · rintro ⟨hA, hB⟩ p hp hpAB
    rcases hp.dvd_mul.mp hpAB with hpA | hpB
    · exact dvd_mul_of_dvd_left (hA p hp hpA) B
    · exact dvd_mul_of_dvd_right (hB p hp hpB) A

/-- Exact all-support equivalence, allowing a fixed scale `u`.  The scale
is required to be a unit modulo every support prime; this covers the
companion evaluation `L_ell(2)=2*A_ell` at odd support primes. -/
theorem natSquarefull_iff_all_support_zero_displacement_scaled
    (N : ℕ) (u t : ℤ) (f : ℤ[X])
    (heval : f.eval t = u * (N : ℤ))
    (hscale : ∀ p : ℕ, Nat.Prime p → p ∣ N →
      IsCoprime u (p : ℤ))
    (htrans : ∀ p : ℕ, Nat.Prime p → p ∣ N →
      IsCoprime (f.derivative.eval t) (p : ℤ)) :
    NatSquarefull N ↔
      ∀ p : ℕ, Nat.Prime p → p ∣ N →
        FirstHenselDisplacementZero f t p := by
  constructor
  · intro hfull p hp hpN
    have hpNInt : (p : ℤ) ∣ (N : ℤ) := by exact_mod_cast hpN
    have hpSqNInt : (p : ℤ) ^ 2 ∣ (N : ℤ) := by
      exact_mod_cast hfull p hp hpN
    refine ⟨?_, htrans p hp hpN, ?_⟩
    · rw [heval]
      exact dvd_mul_of_dvd_right hpNInt u
    · rw [heval]
      exact dvd_mul_of_dvd_right hpSqNInt u
  · intro hzero p hp hpN
    have hz := hzero p hp hpN
    have hpSqEval : (p : ℤ) ^ 2 ∣ f.eval t := hz.2.2
    rw [heval] at hpSqEval
    have hcopSq : IsCoprime ((p : ℤ) ^ 2) u :=
      (hscale p hp hpN).symm.pow_left
    have hpSqNInt : (p : ℤ) ^ 2 ∣ (N : ℤ) :=
      hcopSq.dvd_of_dvd_mul_left hpSqEval
    exact_mod_cast hpSqNInt

/-- Two-channel fixed-point form of the squarefull packet.  All support
quantifiers are present; transversality and scale-unit facts are explicit
hypotheses rather than a hidden Lucas-rank invocation. -/
theorem coprime_product_squarefull_iff_all_channel_displacements
    (A B : ℕ) (hAB : A.Coprime B)
    (uA uB t : ℤ) (fA fB : ℤ[X])
    (hevalA : fA.eval t = uA * (A : ℤ))
    (hevalB : fB.eval t = uB * (B : ℤ))
    (hscaleA : ∀ p : ℕ, Nat.Prime p → p ∣ A →
      IsCoprime uA (p : ℤ))
    (hscaleB : ∀ p : ℕ, Nat.Prime p → p ∣ B →
      IsCoprime uB (p : ℤ))
    (htransA : ∀ p : ℕ, Nat.Prime p → p ∣ A →
      IsCoprime (fA.derivative.eval t) (p : ℤ))
    (htransB : ∀ p : ℕ, Nat.Prime p → p ∣ B →
      IsCoprime (fB.derivative.eval t) (p : ℤ)) :
    NatSquarefull (A * B) ↔
      (∀ p : ℕ, Nat.Prime p → p ∣ A →
        FirstHenselDisplacementZero fA t p) ∧
      (∀ p : ℕ, Nat.Prime p → p ∣ B →
        FirstHenselDisplacementZero fB t p) := by
  rw [natSquarefull_mul_iff hAB,
    natSquarefull_iff_all_support_zero_displacement_scaled
      A uA t fA hevalA hscaleA htransA,
    natSquarefull_iff_all_support_zero_displacement_scaled
      B uB t fB hevalB hscaleB htransB]

/-- The fixed-parameter Pell specialization of the preceding equivalence.
The odd-support scale fact and derivative transversality are arguments;
nothing here invokes a Lucas rank theorem. -/
theorem pell_squarefull_packet_iff_all_support_displacements
    (ell A B : ℕ) (hAB : A.Coprime B)
    (hevalL : pellLValue 2 ell = 2 * (A : ℤ))
    (hevalF : pellFValue 2 ell = (B : ℤ))
    (hscaleL : ∀ p : ℕ, Nat.Prime p → p ∣ A →
      IsCoprime (2 : ℤ) (p : ℤ))
    (htransL : ∀ p : ℕ, Nat.Prime p → p ∣ A →
      IsCoprime ((pellL ell).derivative.eval 2) (p : ℤ))
    (htransF : ∀ p : ℕ, Nat.Prime p → p ∣ B →
      IsCoprime ((pellF ell).derivative.eval 2) (p : ℤ)) :
    NatSquarefull (A * B) ↔
      (∀ p : ℕ, Nat.Prime p → p ∣ A →
        FirstHenselDisplacementZero (pellL ell) 2 p) ∧
      (∀ p : ℕ, Nat.Prime p → p ∣ B →
        FirstHenselDisplacementZero (pellF ell) 2 p) := by
  apply coprime_product_squarefull_iff_all_channel_displacements
    A B hAB 2 1 2 (pellL ell) (pellF ell)
  · simpa [pellLValue] using hevalL
  · simpa [pellFValue] using hevalF
  · exact hscaleL
  · intro p hp hpB
    exact ⟨1, 0, by ring⟩
  · exact htransL
  · exact htransF

/-! ## Finite indexed simultaneous Hensel steering -/

/-- Polynomial evaluation respects an integer congruence of arguments. -/
theorem polynomial_eval_modEq (f : ℤ[X]) {m a b : ℤ}
    (hab : a ≡ b [ZMOD m]) :
    f.eval a ≡ f.eval b [ZMOD m] := by
  induction f using Polynomial.induction_on' with
  | add p q hp hq => simpa using hp.add hq
  | monomial n c =>
      simp only [eval_monomial]
      exact (hab.pow n).mul_left c

/-- Two-modulus integer CRT, including uniqueness modulo the product. -/
theorem integer_crt_pair
    (m n a b : ℤ) (hmn : IsCoprime m n) :
    ∃ t : ℤ,
      t ≡ a [ZMOD m] ∧
      t ≡ b [ZMOD n] ∧
      ∀ u : ℤ, u ≡ a [ZMOD m] → u ≡ b [ZMOD n] →
        u ≡ t [ZMOD m * n] := by
  have hmn' := hmn
  rcases hmn with ⟨x, y, hxy⟩
  let t : ℤ := b * x * m + a * y * n
  have htm : t ≡ a [ZMOD m] := by
    apply Int.modEq_of_dvd
    refine ⟨x * (a - b), ?_⟩
    calc
      a - t = a * (x * m + y * n) -
          (b * x * m + a * y * n) := by rw [hxy]; ring
      _ = m * (x * (a - b)) := by ring
  have htn : t ≡ b [ZMOD n] := by
    apply Int.modEq_of_dvd
    refine ⟨y * (b - a), ?_⟩
    calc
      b - t = b * (x * m + y * n) -
          (b * x * m + a * y * n) := by rw [hxy]; ring
      _ = n * (y * (b - a)) := by ring
  refine ⟨t, htm, htn, ?_⟩
  intro u hum hun
  apply Int.modEq_of_dvd
  exact hmn'.mul_dvd (hum.trans htm.symm).dvd (hun.trans htn.symm).dvd

/-- A number coprime to every entry is coprime to their product. -/
theorem isCoprime_list_product
    {ι : Type*} (m : ι → ℤ) (i : ι) (l : List ι)
    (h : ∀ j ∈ l, IsCoprime (m i) (m j)) :
    IsCoprime (m i) (l.map m).prod := by
  induction l with
  | nil =>
      simp only [List.map_nil, List.prod_nil]
      exact ⟨0, 1, by ring⟩
  | cons j l ih =>
      rw [List.map_cons, List.prod_cons]
      exact (h j List.mem_cons_self).mul_right
        (ih (fun k hk => h k (List.mem_cons_of_mem j hk)))

/-- Finite integer CRT over a list of pairwise coprime moduli. -/
theorem integer_crt_list
    {ι : Type*} (l : List ι) (m a : ι → ℤ)
    (hpair : l.Pairwise (fun i j => IsCoprime (m i) (m j))) :
    ∃ t : ℤ,
      (∀ i ∈ l, t ≡ a i [ZMOD m i]) ∧
      ∀ u : ℤ, (∀ i ∈ l, u ≡ a i [ZMOD m i]) →
        u ≡ t [ZMOD (l.map m).prod] := by
  induction l with
  | nil =>
      refine ⟨0, by simp, ?_⟩
      intro u hu
      apply Int.modEq_of_dvd
      exact one_dvd _
  | cons i l ih =>
      have hhead : ∀ j ∈ l, IsCoprime (m i) (m j) :=
        (List.pairwise_cons.mp hpair).1
      have htail := (List.pairwise_cons.mp hpair).2
      rcases ih htail with ⟨tTail, htTail, htTailUnique⟩
      have hcop : IsCoprime (m i) (l.map m).prod :=
        isCoprime_list_product m i l hhead
      rcases integer_crt_pair (m i) (l.map m).prod (a i) tTail hcop with
        ⟨t, hti, htprod, htunique⟩
      refine ⟨t, ?_, ?_⟩
      · intro j hj
        rcases List.mem_cons.mp hj with rfl | hj
        · exact hti
        · have hjdvd : m j ∣ (l.map m).prod := by
            exact List.dvd_prod (List.mem_map.mpr ⟨j, hj, rfl⟩)
          exact (Int.ModEq.of_dvd hjdvd htprod).trans (htTail j hj)
      · intro u hu
        have hui : u ≡ a i [ZMOD m i] := hu i List.mem_cons_self
        have hutail : ∀ j ∈ l, u ≡ a j [ZMOD m j] := by
          intro j hj
          exact hu j (List.mem_cons_of_mem i hj)
        have huProd : u ≡ tTail [ZMOD (l.map m).prod] :=
          htTailUnique u hutail
        simpa using htunique u hui huProd

/-- Uniqueness of a simple Hensel lift: any representative in the old root
class that persists modulo `p^2` lies in the selected lifted class. -/
theorem simple_hensel_lift_unique
    (f : ℤ[X]) (p t c h u : ℤ) (hp : p ≠ 0)
    (hold : f.eval t = p * c)
    (hcop : IsCoprime (f.derivative.eval t) p)
    (hselected : p ^ 2 ∣ f.eval (t + p * h))
    (hubase : u ≡ t [ZMOD p])
    (hulift : p ^ 2 ∣ f.eval u) :
    u ≡ t + p * h [ZMOD p ^ 2] := by
  rcases hubase.dvd with ⟨q, hq⟩
  let k : ℤ := -q
  have huk : u = t + p * k := by
    dsimp [k]
    linarith
  have hkLift : p ^ 2 ∣ f.eval (t + p * k) := by
    rwa [← huk]
  have hcEq : f.eval t = p ^ (1 : ℕ) * c := by simpa using hold
  have hkDigit := (polynomial_hensel_dvd_iff f p t c k 1
    (by norm_num) hp hcEq).1 (by simpa using hkLift)
  have hhDigit := (polynomial_hensel_dvd_iff f p t c h 1
    (by norm_num) hp hcEq).1 (by simpa using hselected)
  have hkh : k ≡ h [ZMOD p] :=
    hensel_digit_unique_mod p c (f.derivative.eval t) k h
      hcop hkDigit hhDigit
  rw [huk]
  simpa [pow_two] using (hkh.mul_left' (c := p)).add_left t

/-- Pairwise distinct primes have pairwise coprime square moduli over the
integers. -/
theorem prime_squares_pairwise_coprime
    {ι : Type*} (l : List ι) (p : ι → ℕ)
    (hprime : ∀ i : ι, Nat.Prime (p i))
    (hdistinct : l.Pairwise (fun i j => p i ≠ p j)) :
    l.Pairwise (fun i j =>
      IsCoprime ((p i : ℤ) ^ 2) ((p j : ℤ) ^ 2)) := by
  apply hdistinct.imp
  intro i j hne
  have hnDiv : ¬ p i ∣ p j := by
    intro hdvd
    rcases (Nat.dvd_prime (hprime j)).mp hdvd with hone | heq
    · exact (hprime i).ne_one hone
    · exact hne heq
  have hnat : (p i).Coprime (p j) :=
    ((hprime i).coprime_iff_not_dvd).2 hnDiv
  have hint : IsCoprime (p i : ℤ) (p j : ℤ) :=
    Nat.isCoprime_iff_coprime.2 hnat
  exact hint.pow

/-- Finite simultaneous Hensel steering at the paper quantifiers.  For a
finite list of distinct simple prime roots, there is one joint residue class
modulo the product of the prime squares, characterized by retaining every
old root class and making every selected prime repeated. -/
theorem finite_simultaneous_hensel_steering
    {ι : Type*} (l : List ι) (p : ι → ℕ) (f : ι → ℤ[X]) (t0 : ℤ)
    (hprime : ∀ i : ι, Nat.Prime (p i))
    (hdistinct : l.Pairwise (fun i j => p i ≠ p j))
    (hroot : ∀ i : ι, (p i : ℤ) ∣ (f i).eval t0)
    (hsimple : ∀ i : ι,
      IsCoprime ((f i).derivative.eval t0) (p i : ℤ)) :
    ∃ t : ℤ,
      (∀ i ∈ l, t ≡ t0 [ZMOD (p i : ℤ)]) ∧
      (∀ i ∈ l, (p i : ℤ) ^ 2 ∣ (f i).eval t) ∧
      ∀ u : ℤ,
        (∀ i ∈ l, u ≡ t0 [ZMOD (p i : ℤ)]) →
        (∀ i ∈ l, (p i : ℤ) ^ 2 ∣ (f i).eval u) →
        u ≡ t [ZMOD (l.map (fun i => (p i : ℤ) ^ 2)).prod] := by
  classical
  let c : ι → ℤ := fun i => Classical.choose (hroot i)
  have hc : ∀ i : ι, (f i).eval t0 = (p i : ℤ) * c i := by
    intro i
    exact Classical.choose_spec (hroot i)
  have hp0 : ∀ i : ι, (p i : ℤ) ≠ 0 := by
    intro i
    exact_mod_cast (hprime i).ne_zero
  have hDigitExists : ∀ i : ι, ∃ h : ℤ,
      (p i : ℤ) ^ 2 ∣ (f i).eval (t0 + (p i : ℤ) * h) := by
    intro i
    have hex := polynomial_hensel_exists_unique_digit
      (f i) (p i : ℤ) t0 (c i) 1 (by norm_num) (hp0 i)
      (by simpa using hc i) (hsimple i)
    refine ⟨Classical.choose hex, ?_⟩
    simpa [pow_two] using (Classical.choose_spec hex).1
  let digit : ι → ℤ := fun i => Classical.choose (hDigitExists i)
  let residue : ι → ℤ := fun i => t0 + (p i : ℤ) * digit i
  have hResidueLift : ∀ i : ι,
      (p i : ℤ) ^ 2 ∣ (f i).eval (residue i) := by
    intro i
    exact Classical.choose_spec (hDigitExists i)
  have hpair := prime_squares_pairwise_coprime l p hprime hdistinct
  rcases integer_crt_list l (fun i => (p i : ℤ) ^ 2) residue hpair with
    ⟨t, htResidue, htUnique⟩
  refine ⟨t, ?_, ?_, ?_⟩
  · intro i hi
    have hpiSq : (p i : ℤ) ∣ (p i : ℤ) ^ 2 := by
      refine ⟨(p i : ℤ), ?_⟩
      ring
    have htr : t ≡ residue i [ZMOD (p i : ℤ)] :=
      Int.ModEq.of_dvd hpiSq (htResidue i hi)
    have hrt : residue i ≡ t0 [ZMOD (p i : ℤ)] := by
      apply Int.modEq_of_dvd
      refine ⟨-(digit i), ?_⟩
      simp [residue]
    exact htr.trans hrt
  · intro i hi
    have heval := polynomial_eval_modEq (f i) (htResidue i hi)
    exact Int.modEq_zero_iff_dvd.mp
      (heval.trans (Int.modEq_zero_iff_dvd.mpr (hResidueLift i)))
  · intro u huBase huLift
    apply htUnique u
    intro i hi
    exact simple_hensel_lift_unique (f i) (p i : ℤ) t0 (c i)
      (digit i) u (hp0 i) (hc i) (hsimple i) (hResidueLift i)
      (huBase i hi) (huLift i hi)

/-! ## Every concrete premise of the moving-parameter counterexample -/

/-- Complete, nonfragmented data used to refute the precise
`H-global-move` strengthening at index three. -/
structure HGlobalMoveWitness where
  indexPrime : Nat.Prime 3
  indexOdd : Odd (3 : ℕ)
  t : ℤ
  A : ℤ
  B : ℤ
  D : ℤ
  tPositive : 0 < t
  APositive : 0 < A
  BPositive : 0 < B
  DPositive : 0 < D
  prime2 : Nat.Prime 2
  prime3 : Nat.Prime 3
  prime5 : Nat.Prime 5
  prime7 : Nat.Prime 7
  prime47 : Nat.Prime 47
  prime541 : Nat.Prime 541
  prime3181 : Nat.Prime 3181
  prime9941 : Nat.Prime 9941
  baseLValue : L3 2 = 14
  baseLDerivative : L3prime 2 = 15
  baseFValue : F3 2 = 5
  baseFDerivative : F3prime 2 = 4
  baseLRoot : (7 : ℤ) ∣ L3 2
  baseFRoot : (5 : ℤ) ∣ F3 2
  baseLSimple : ¬ (7 : ℤ) ∣ L3prime 2
  baseFSimple : ¬ (5 : ℤ) ∣ F3prime 2
  jointLiftL : t ≡ 37 [ZMOD 49]
  jointLiftF : t ≡ 7 [ZMOD 25]
  retainsBaseL : t ≡ 2 [ZMOD 7]
  retainsBaseF : t ≡ 2 [ZMOD 5]
  coordinateL : 2 * A = L3 t
  coordinateF : B = F3 t
  coordinateLAllIndex : 2 * A = pellLValue t 3
  coordinateFAllIndex : B = pellFValue t 3
  coefficientIdentity : 4 * D = t ^ 2 + 4
  repeatedL : (7 : ℤ) ^ 2 ∣ A
  repeatedF : (5 : ℤ) ^ 2 ∣ B
  repeatedLPolynomial : (7 : ℤ) ^ 2 ∣ L3 t
  repeatedFPolynomial : (5 : ℤ) ^ 2 ∣ F3 t
  factorA : A = (3 : ℤ) ^ 2 * 7 ^ 2 * 47 * 541
  factorB : B = (5 : ℤ) ^ 2 * 3181
  factorD : D = 2 * 9941
  coefficientSquarefree : Squarefree D.natAbs
  globalNorm : A ^ 2 - D * B ^ 2 = -1
  factor3181ExponentOne : ¬ (3181 : ℤ) ^ 2 ∣ B
  factor47ExponentOne : ¬ (47 : ℤ) ^ 2 ∣ A
  factor541ExponentOne : ¬ (541 : ℤ) ^ 2 ∣ A

/-- The explicit joint lift supplies every premise in one object. -/
def indexThree_full_HGlobalMoveWitness : HGlobalMoveWitness := by
  refine
    { indexPrime := by norm_num
      indexOdd := by norm_num
      t := 282
      A := 11213307
      B := 79525
      D := 19882
      tPositive := by norm_num
      APositive := by norm_num
      BPositive := by norm_num
      DPositive := by norm_num
      prime2 := by norm_num
      prime3 := by norm_num
      prime5 := by norm_num
      prime7 := by norm_num
      prime47 := by norm_num
      prime541 := by norm_num
      prime3181 := by norm_num
      prime9941 := moving_coefficient_large_factor_prime
      baseLValue := by norm_num [L3]
      baseLDerivative := by norm_num [L3prime]
      baseFValue := by norm_num [F3]
      baseFDerivative := by norm_num [F3prime]
      baseLRoot := by norm_num [L3]
      baseFRoot := by norm_num [F3]
      baseLSimple := by norm_num [L3prime]
      baseFSimple := by norm_num [F3prime]
      jointLiftL := by norm_num [Int.ModEq]
      jointLiftF := by norm_num [Int.ModEq]
      retainsBaseL := by norm_num [Int.ModEq]
      retainsBaseF := by norm_num [Int.ModEq]
      coordinateL := by norm_num [L3]
      coordinateF := by norm_num [F3]
      coordinateLAllIndex := by
        rw [pellLValue_three_eq_L3]
        norm_num [L3]
      coordinateFAllIndex := by
        rw [pellFValue_three_eq_F3]
        norm_num [F3]
      coefficientIdentity := by norm_num
      repeatedL := by norm_num
      repeatedF := by norm_num
      repeatedLPolynomial := by norm_num [L3]
      repeatedFPolynomial := by norm_num [F3]
      factorA := by norm_num
      factorB := by norm_num
      factorD := by norm_num
      coefficientSquarefree := by
        simpa using moving_coefficient_squarefree
      globalNorm := by norm_num
      factor3181ExponentOne := by norm_num
      factor47ExponentOne := by norm_num
      factor541ExponentOne := by norm_num }

/-- The exact full-premise moving exclusion, stated independently of the
fixed coefficient-two Pell route. -/
def FullHGlobalMoveExclusion : Prop := ¬ Nonempty HGlobalMoveWitness

theorem indexThree_full_HGlobalMoveWitness_nonempty :
    Nonempty HGlobalMoveWitness :=
  ⟨indexThree_full_HGlobalMoveWitness⟩

/-- The bundled index-three object refutes exactly the full moving
strengthening. -/
theorem not_FullHGlobalMoveExclusion : ¬ FullHGlobalMoveExclusion := by
  intro h
  exact h indexThree_full_HGlobalMoveWitness_nonempty

end PellPolynomialAllIndexFormalization20260902
end IUTThreeClosures
