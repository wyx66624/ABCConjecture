/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Elementary exclusions for three-prime generalized Fermat signatures

The mathematical proofs precede this module in
`research/ANALYTIC_THREE_PRIME_SUPPORT_2026_08_31.md`, Sections 4 and 9.
For pairwise distinct prime bases, this file excludes every placement of the
signatures `(2,3,3)` and `(2,3,6)` by elementary factorization.

The common-exponent theorem in that report uses Fermat's Last Theorem, and
the complete `(2,2,n)` classification uses a published exponential-equation
theorem.  Neither result is asserted here.  This module imports no abc,
Fermat--Catalan, Catalan, or external-classification hypothesis.
-/

namespace IUTThreeClosures.ABCThreePrimeSignatures20260831

/-- If two ordered factors multiply to a prime square and the first is smaller,
then the first factor is one. -/
theorem left_eq_one_of_mul_eq_prime_sq_of_lt {x y p : ℕ}
    (hp : p.Prime) (hxy : x < y) (hmul : x * y = p ^ 2) : x = 1 := by
  by_contra hx
  have hx0 : x ≠ 0 := by
    intro hx0
    subst x
    have hp0 : p ^ 2 ≠ 0 := pow_ne_zero _ hp.ne_zero
    apply hp0
    simpa using hmul.symm
  have hxpos : 0 < x := Nat.pos_of_ne_zero hx0
  have hy : y ≠ 1 := by omega
  have h := (hp.mul_eq_prime_sq_iff hx hy).mp hmul
  omega

/-- Two nonunit factors of a prime square must be equal. -/
theorem factors_eq_of_mul_eq_prime_sq {x y p : ℕ}
    (hp : p.Prime) (hx : 1 < x) (hy : 1 < y)
    (hmul : x * y = p ^ 2) : x = y := by
  exact ((hp.mul_eq_prime_sq_iff (by omega) (by omega)).mp hmul).1.trans
    (((hp.mul_eq_prime_sq_iff (by omega) (by omega)).mp hmul).2.symm)

/-- A natural-number square cannot be prime. -/
theorem prime_not_square {x p : ℕ} (hp : p.Prime) : x ^ 2 ≠ p := by
  intro h
  have hx : (x ^ 2).Prime := by simpa [h] using hp
  exact Nat.Prime.not_prime_pow (by norm_num) hx

/-- The only two primes differing by one are two and three. -/
theorem consecutive_primes {q r : ℕ} (hq : q.Prime) (hr : r.Prime)
    (h : q + 1 = r) : q = 2 ∧ r = 3 := by
  rcases hq.eq_two_or_odd' with hq2 | hqodd
  · subst q
    omega
  · have hreven : Even r := by
      rcases hqodd with ⟨k, hk⟩
      refine ⟨k + 1, ?_⟩
      omega
    have hr2 : r = 2 := hr.even_iff.mp hreven
    have hqge : 2 ≤ q := hq.two_le
    exfalso
    omega

/-- The only prime square one above another prime is `2^2 = 3 + 1`. -/
theorem prime_sq_eq_prime_add_one {q r : ℕ} (hq : q.Prime) (hr : r.Prime)
    (h : q + 1 = r ^ 2) : q = 3 ∧ r = 2 := by
  rcases hr.eq_two_or_odd' with hr2 | hrodd
  · subst r
    omega
  · have hqeven : Even q := by
      rcases hrodd with ⟨k, hk⟩
      refine ⟨2 * k * k + 2 * k, ?_⟩
      nlinarith
    have hq2 : q = 2 := hq.even_iff.mp hqeven
    have hrsq : r ^ 2 = 3 := by omega
    exact (prime_not_square (by decide : Nat.Prime 3) hrsq).elim

/-- The only prime whose square plus one is prime is `2`, giving `5`. -/
theorem prime_sq_add_one_eq_prime {q r : ℕ} (hq : q.Prime) (hr : r.Prime)
    (h : q ^ 2 + 1 = r) : q = 2 ∧ r = 5 := by
  rcases hq.eq_two_or_odd' with hq2 | hqodd
  · subst q
    omega
  · have hreven : Even r := by
      rcases hqodd with ⟨k, hk⟩
      refine ⟨2 * k * k + 2 * k + 1, ?_⟩
      nlinarith
    have hr2 : r = 2 := hr.even_iff.mp hreven
    have hqge : 2 ≤ q := hq.two_le
    exfalso
    nlinarith

/-- A prime square plus a prime cube is never a prime cube. -/
theorem square_add_cube_ne_cube {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    P ^ 2 + Q ^ 3 ≠ R ^ 3 := by
  intro h
  have hQR : Q < R := by
    by_contra hn
    have hRQ : R ≤ Q := by omega
    have : R ^ 3 ≤ Q ^ 3 := Nat.pow_le_pow_left hRQ 3
    nlinarith [hP.two_le]
  have hfac : (R - Q) * (R ^ 2 + R * Q + Q ^ 2) = P ^ 2 := by
    have hsub : R - Q + Q = R := Nat.sub_add_cancel (by omega)
    nlinarith
  have hlt : R - Q < R ^ 2 + R * Q + Q ^ 2 := by
    have hRq : R - Q ≤ R := Nat.sub_le R Q
    have hR2 : R < R ^ 2 := by nlinarith [hR.two_le]
    nlinarith
  have hdiff : R - Q = 1 :=
    left_eq_one_of_mul_eq_prime_sq_of_lt hP hlt hfac
  have hsucc : Q + 1 = R := by omega
  obtain ⟨rfl, rfl⟩ := consecutive_primes hQ hR hsucc
  norm_num at h
  have hs : P ^ 2 = 19 := by omega
  exact prime_not_square (by decide : Nat.Prime 19) hs

/-- Cubes of two distinct nonunits cannot sum to the square of a prime. -/
theorem cube_add_cube_ne_prime_square_of_gt_one {P Q R : ℕ}
    (hP : 1 < P) (hQ : 1 < Q) (hR : R.Prime) (hPQ : P ≠ Q) :
    P ^ 3 + Q ^ 3 ≠ R ^ 2 := by
  intro h
  have hP2 : 2 ≤ P := by omega
  have hQ2 : 2 ≤ Q := by omega
  rcases lt_or_gt_of_ne hPQ with hPQlt | hQP
  · let D := Q * (Q - P) + P ^ 2
    have hsub : Q - P + P = Q := Nat.sub_add_cancel (by omega)
    have hfac : (P + Q) * D = R ^ 2 := by
      dsimp [D]
      calc
        (P + Q) * (Q * (Q - P) + P ^ 2) = P ^ 3 + Q ^ 3 := by
          rw [← hsub]
          simp only [Nat.add_sub_cancel]
          ring
        _ = R ^ 2 := h
    have hDgt : P + Q < D := by
      have hgap : 1 ≤ Q - P := by omega
      have hQle : Q ≤ Q * (Q - P) := by
        nlinarith [Nat.mul_le_mul_left Q hgap]
      have hPsq : P < P ^ 2 := by nlinarith
      dsimp [D]
      omega
    have hA : 1 < P + Q := by omega
    have hD : 1 < D := by omega
    have heq := factors_eq_of_mul_eq_prime_sq hR hA hD hfac
    omega
  · let D := P * (P - Q) + Q ^ 2
    have hsub : P - Q + Q = P := Nat.sub_add_cancel (by omega)
    have hfac : (Q + P) * D = R ^ 2 := by
      dsimp [D]
      calc
        (Q + P) * (P * (P - Q) + Q ^ 2) = P ^ 3 + Q ^ 3 := by
          rw [← hsub]
          simp only [Nat.add_sub_cancel]
          ring
        _ = R ^ 2 := h
    have hDgt : Q + P < D := by
      have hgap : 1 ≤ P - Q := by omega
      have hPle : P ≤ P * (P - Q) := by
        nlinarith [Nat.mul_le_mul_left P hgap]
      have hQsq : Q < Q ^ 2 := by nlinarith
      dsimp [D]
      omega
    have hA : 1 < Q + P := by omega
    have hD : 1 < D := by omega
    have heq := factors_eq_of_mul_eq_prime_sq hR hA hD hfac
    omega

/-- Cubes of two distinct primes cannot sum to a prime square. -/
theorem cube_add_cube_ne_square {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) (hPQ : P ≠ Q) :
    P ^ 3 + Q ^ 3 ≠ R ^ 2 :=
  cube_add_cube_ne_prime_square_of_gt_one hP.one_lt hQ.one_lt hR hPQ

/-- A prime square plus a prime cube is never a prime sixth power. -/
theorem square_add_cube_ne_sixth {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    P ^ 2 + Q ^ 3 ≠ R ^ 6 := by
  intro h
  have hQR : Q < R ^ 2 := by
    by_contra hn
    have hRQ : R ^ 2 ≤ Q := by omega
    have hpw : (R ^ 2) ^ 3 ≤ Q ^ 3 := Nat.pow_le_pow_left hRQ 3
    nlinarith [hP.two_le]
  have hfac : (R ^ 2 - Q) * (R ^ 4 + R ^ 2 * Q + Q ^ 2) = P ^ 2 := by
    have hsub : R ^ 2 - Q + Q = R ^ 2 := Nat.sub_add_cancel (by omega)
    nlinarith
  have hlt : R ^ 2 - Q < R ^ 4 + R ^ 2 * Q + Q ^ 2 := by
    have hRq : R ^ 2 - Q ≤ R ^ 2 := Nat.sub_le _ _
    have hR4 : R ^ 2 < R ^ 4 := by nlinarith [hR.two_le]
    nlinarith
  have hdiff : R ^ 2 - Q = 1 :=
    left_eq_one_of_mul_eq_prime_sq_of_lt hP hlt hfac
  have hsucc : Q + 1 = R ^ 2 := by omega
  obtain ⟨rfl, rfl⟩ := prime_sq_eq_prime_add_one hQ hR hsucc
  norm_num at h
  have hs : P ^ 2 = 37 := by omega
  exact prime_not_square (by decide : Nat.Prime 37) hs

/-- A prime square plus a prime sixth power is never a prime cube. -/
theorem square_add_sixth_ne_cube {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    P ^ 2 + Q ^ 6 ≠ R ^ 3 := by
  intro h
  have hQR : Q ^ 2 < R := by
    by_contra hn
    have hRQ : R ≤ Q ^ 2 := by omega
    have hpw : R ^ 3 ≤ (Q ^ 2) ^ 3 := Nat.pow_le_pow_left hRQ 3
    nlinarith [hP.two_le]
  have hfac : (R - Q ^ 2) * (R ^ 2 + R * Q ^ 2 + Q ^ 4) = P ^ 2 := by
    have hsub : R - Q ^ 2 + Q ^ 2 = R := Nat.sub_add_cancel (by omega)
    nlinarith
  have hlt : R - Q ^ 2 < R ^ 2 + R * Q ^ 2 + Q ^ 4 := by
    have hRq : R - Q ^ 2 ≤ R := Nat.sub_le _ _
    have hR2 : R < R ^ 2 := by nlinarith [hR.two_le]
    nlinarith
  have hdiff : R - Q ^ 2 = 1 :=
    left_eq_one_of_mul_eq_prime_sq_of_lt hP hlt hfac
  have hsucc : Q ^ 2 + 1 = R := by omega
  obtain ⟨rfl, rfl⟩ := prime_sq_add_one_eq_prime hQ hR hsucc
  norm_num at h
  have hs : P ^ 2 = 61 := by omega
  exact prime_not_square (by decide : Nat.Prime 61) hs

/-- A prime cube plus a prime sixth power is never a prime square. -/
theorem cube_add_sixth_ne_square {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    P ^ 3 + Q ^ 6 ≠ R ^ 2 := by
  have hpow : (Q ^ 2) ^ 3 = Q ^ 6 := by ring
  rw [← hpow]
  apply cube_add_cube_ne_prime_square_of_gt_one hP.one_lt
    (by nlinarith [hQ.two_le]) hR
  intro heq
  exact prime_not_square hP heq.symm

/-- All three output placements of the prime-base signature `(2,3,3)` fail. -/
theorem no_prime_signature_233 {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) (hPQ : P ≠ Q) :
    (P ^ 2 + Q ^ 3 ≠ R ^ 3) ∧
      (P ^ 3 + Q ^ 2 ≠ R ^ 3) ∧
      (P ^ 3 + Q ^ 3 ≠ R ^ 2) := by
  refine ⟨square_add_cube_ne_cube hP hQ hR, ?_,
    cube_add_cube_ne_square hP hQ hR hPQ⟩
  simpa [Nat.add_comm] using square_add_cube_ne_cube hQ hP hR

/-- Both input orders fail when exponent six is the output in signature `(2,3,6)`. -/
theorem no_prime_signature_236_output_sixth {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    (P ^ 2 + Q ^ 3 ≠ R ^ 6) ∧ (P ^ 3 + Q ^ 2 ≠ R ^ 6) := by
  refine ⟨square_add_cube_ne_sixth hP hQ hR, ?_⟩
  simpa [Nat.add_comm] using square_add_cube_ne_sixth hQ hP hR

/-- Both input orders fail when exponent three is the output in signature `(2,3,6)`. -/
theorem no_prime_signature_236_output_cube {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    (P ^ 2 + Q ^ 6 ≠ R ^ 3) ∧ (P ^ 6 + Q ^ 2 ≠ R ^ 3) := by
  refine ⟨square_add_sixth_ne_cube hP hQ hR, ?_⟩
  simpa [Nat.add_comm] using square_add_sixth_ne_cube hQ hP hR

/-- Both input orders fail when exponent two is the output in signature `(2,3,6)`. -/
theorem no_prime_signature_236_output_square {P Q R : ℕ}
    (hP : P.Prime) (hQ : Q.Prime) (hR : R.Prime) :
    (P ^ 3 + Q ^ 6 ≠ R ^ 2) ∧ (P ^ 6 + Q ^ 3 ≠ R ^ 2) := by
  refine ⟨cube_add_sixth_ne_square hP hQ hR, ?_⟩
  simpa [Nat.add_comm] using cube_add_sixth_ne_square hQ hP hR

#print axioms left_eq_one_of_mul_eq_prime_sq_of_lt
#print axioms no_prime_signature_233
#print axioms no_prime_signature_236_output_sixth
#print axioms no_prime_signature_236_output_cube
#print axioms no_prime_signature_236_output_square

end IUTThreeClosures.ABCThreePrimeSignatures20260831

