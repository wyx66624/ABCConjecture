/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevOddQuotientFiveAdicNoGo

/-!
# Moving primitive divisors: exact scalar no-go core

This module records the elementary part of the moving-primitive-divisor
audit.  It has four purposes.

* It proves that no coprime integral Lucas reparameterization preserving
  either relevant root ratio can satisfy Granville's condition
  `c = 2 (mod 4)`.
* It gives a polynomial Pell template which can retain the actual
  squarefree-kernel residue pattern while congruence conditions move.
* It records the modulo-24 consequence of the odd Chebyshev quotient and
  the resulting restriction on a hypothetical `p * square` shape.
* It kernel-checks the finite scalar part of one `p = 41` diagnostic.  The
  diagnostic has a primitive-order residue, an odd `q`-valuation, a genuine
  finite five-adic target solution, and the Pell template, but the global
  shifted-square equation already fails modulo seven.

The root-ratio derivation, Carmichael/BHV, Dirichlet, Hensel, quadratic and
quartic reciprocity, the simultaneous squarefree sieve, quadratic-field
fundamental-unit language, and the primality certification of the large
displayed factors remain explicit accepted interfaces in the companion
note.  No such result is introduced as a Lean axiom here.
-/

namespace IUTThreeClosures

namespace MovingPrimitiveNoGo

/-! ## Granville's parity hypothesis is invariantly unavailable -/

/-- If an integral Lucas pair with coprime parameters has the same root
ratio as the standard `lambda^2` pair, the resulting trace/product identity
cannot coexist with `c = 2 (mod 4)`.

The companion note derives `b^2 = -4*c*X^2` from the root ratio.  This
theorem checks the exact integral parity obstruction, including negative
values of `c`. -/
theorem granville_lucasRatio_no_coprime
    (b c X : ℤ)
    (hcop : IsCoprime b c)
    (hc : c % 4 = 2)
    (hratio : b ^ 2 = -4 * c * X ^ 2) :
    False := by
  have hcTwo : (2 : ℤ) ∣ c := by
    apply Int.dvd_iff_emod_eq_zero.mpr
    omega
  have hbSq : (2 : ℤ) ∣ b ^ 2 := by
    refine ⟨-2 * c * X ^ 2, ?_⟩
    nlinarith
  have hbTwo : (2 : ℤ) ∣ b :=
    Int.Prime.dvd_pow' Nat.prime_two hbSq
  have hunit : IsUnit (2 : ℤ) :=
    hcop.isUnit_of_dvd' hbTwo hcTwo
  exact (by norm_num [Int.isUnit_iff] : ¬ IsUnit (2 : ℤ)) hunit

/-- The analogous obstruction for the Lehmer root ratio `-lambda^2`.
The root-ratio calculation now gives `b^2 = 4*c*(X^2-1)`, but the same
common factor two contradicts coprimality. -/
theorem granville_lehmerRatio_no_coprime
    (b c X : ℤ)
    (hcop : IsCoprime b c)
    (hc : c % 4 = 2)
    (hratio : b ^ 2 = 4 * c * (X ^ 2 - 1)) :
    False := by
  have hcTwo : (2 : ℤ) ∣ c := by
    apply Int.dvd_iff_emod_eq_zero.mpr
    omega
  have hbSq : (2 : ℤ) ∣ b ^ 2 := by
    refine ⟨2 * c * (X ^ 2 - 1), ?_⟩
    nlinarith
  have hbTwo : (2 : ℤ) ∣ b :=
    Int.Prime.dvd_pow' Nat.prime_two hbSq
  have hunit : IsUnit (2 : ℤ) :=
    hcop.isUnit_of_dvd' hbTwo hcTwo
  exact (by norm_num [Int.isUnit_iff] : ¬ IsUnit (2 : ℤ)) hunit

/-! ## A moving Pell template -/

/-- First squarefree-kernel slot `K = X - 1` in the template.  It is
deliberately not named `A`: the ramified five-adic parameter `A₅ = X / 5`
is a different integer. -/
def primitivePellTemplateK (B : ℤ) : ℤ :=
  2 * (24 * B - 1)

/-- Pell first coordinate in the template. -/
def primitivePellTemplateX (B : ℤ) : ℤ :=
  48 * B - 1

/-- Moving Pell radicand in the template. -/
def primitivePellTemplateD (B : ℤ) : ℤ :=
  6 * B * (24 * B - 1)

/-- Exact neighboring-kernel and norm-one identities.  If `B` and
`24*B-1` are squarefree, the companion note explains why these are the
actual coprime squarefree kernels and why `D = 3*K*B`. -/
theorem primitivePellTemplate_identities (B : ℤ) :
    primitivePellTemplateX B - 1 = primitivePellTemplateK B ∧
      primitivePellTemplateX B + 1 = 3 * B * 4 ^ 2 ∧
      primitivePellTemplateD B = 3 * primitivePellTemplateK B * B ∧
      primitivePellTemplateX B ^ 2 -
          primitivePellTemplateD B * 4 ^ 2 = 1 := by
  simp only [primitivePellTemplateK, primitivePellTemplateX,
    primitivePellTemplateD]
  constructor
  · ring
  constructor
  · ring
  constructor <;> ring

/-- The required modulo-24 kernel pattern and `D = 6 (mod 8)` follow from
the single progression `B = 23 (mod 24)`. -/
theorem primitivePellTemplate_residues
    (B : ℤ) (hB : B % 24 = 23) :
    (primitivePellTemplateK B) % 24 = 22 ∧
      (primitivePellTemplateX B) % 24 = 23 ∧
      (primitivePellTemplateD B) % 8 = 6 := by
  have hB8 : B % 8 = 7 := by omega
  constructor
  · norm_num [primitivePellTemplateK, Int.mul_emod, Int.sub_emod, hB]
  constructor
  · norm_num [primitivePellTemplateX, Int.mul_emod, Int.sub_emod, hB]
  · simp only [primitivePellTemplateD]
    rw [Int.mul_emod, Int.mul_emod]
    norm_num [Int.mul_emod, Int.sub_emod, hB8]

/-- Congruences on the moving parameter `B` transport directly to the Pell
base.  This is the scalar input used before CRT and the squarefree sieve. -/
theorem primitivePellTemplateX_map_modEq
    {modulus B C : ℤ} (h : B ≡ C [ZMOD modulus]) :
    primitivePellTemplateX B ≡
      primitivePellTemplateX C [ZMOD modulus] := by
  simpa [primitivePellTemplateX] using
    (h.mul_left 48).sub (Int.ModEq.refl 1)

/-! ## The modulo-24 square-shape residue -/

/-- At `X = -1 (mod 24)`, every odd Chebyshev quotient is `1 (mod 24)`.
The proof reuses the recurrence congruence and exact endpoint value. -/
theorem pellOddChebyshevQuotient_mod_twentyFour_of_negOne
    (m : ℕ) (X : ℤ)
    (hX : X ≡ -1 [ZMOD 24]) :
    pellOddChebyshevQuotient m X ≡ 1 [ZMOD 24] := by
  have h := pellOddChebyshevQuotient_map_modEq m hX
  simpa [pellOddChebyshevQuotient_neg_one] using h

/-- Every invertible square modulo 24 is one; hence if `p*z^2 = 1`, then
`p = 1`.  The finite ring statement is exhaustively kernel-checked. -/
theorem mul_sq_mod_twentyFour_eq_one
    (p z : ℤ)
    (h : p * z ^ 2 ≡ 1 [ZMOD 24]) :
    p ≡ 1 [ZMOD 24] := by
  have hcast : (p : ZMod 24) * (z : ZMod 24) ^ 2 = 1 := by
    have h' : ((p * z ^ 2 : ℤ) : ZMod 24) =
        ((1 : ℤ) : ZMod 24) :=
      (ZMod.intCast_eq_intCast_iff (p * z ^ 2) 1 24).2 h
    simpa using h'
  have hfinite : ∀ a b : ZMod 24, a * b ^ 2 = 1 → a = 1 := by
    decide
  have hp : (p : ZMod 24) = 1 := hfinite p z hcast
  exact (ZMod.intCast_eq_intCast_iff p 1 24).1 (by simpa using hp)

/-- Consequently the conditional Granville alternative `H_p = p*z^2`
forces `p = 1 (mod 24)` on the actual Pell base. -/
theorem primeSquareShape_forces_index_mod_twentyFour
    (m : ℕ) (X p z : ℤ)
    (hX : X ≡ -1 [ZMOD 24])
    (hshape : pellOddChebyshevQuotient m X = p * z ^ 2) :
    p ≡ 1 [ZMOD 24] := by
  apply mul_sq_mod_twentyFour_eq_one p z
  simpa [hshape] using
    pellOddChebyshevQuotient_mod_twentyFour_of_negOne m X hX

/-- Combining the active five-split classes with `p = 1 (mod 24)` leaves
only `1` and `49` modulo `120`. -/
theorem primeSquareShape_active_crt
    (p : ℤ)
    (h24 : p % 24 = 1)
    (h5 : p % 5 = 1 ∨ p % 5 = 4) :
    p % 120 = 1 ∨ p % 120 = 49 := by
  rcases h5 with h5 | h5 <;> omega

/-! ## An exact `p = 41` finite diagnostic -/

def p41ExampleB : ℤ := 12317469801647
def p41ExampleK : ℤ := primitivePellTemplateK p41ExampleB
def p41ExampleX : ℤ := primitivePellTemplateX p41ExampleB
def p41ExampleD : ℤ := primitivePellTemplateD p41ExampleB
def p41ExampleQ : ℕ := 19681

/-- The small moving prime is genuinely prime. -/
theorem p41ExampleQ_prime : Nat.Prime p41ExampleQ := by
  norm_num [p41ExampleQ]

/-- Exact factorization data used by the external squarefree certification.
The primality of the largest displayed factor is kept in the reproducible
accepted computation ledger rather than hidden in this theorem. -/
theorem p41Example_factorizations :
    p41ExampleB = 23 * 31 * 907 * 2357 * 8081 ∧
      24 * p41ExampleB - 1 = 19 * 71 * 219139566523 := by
  norm_num [p41ExampleB]

/-- The large diagnostic is an exact instance of the Pell template. -/
theorem p41Example_pellData :
    p41ExampleK = 591238550479054 ∧
      p41ExampleX = 591238550479055 ∧
      p41ExampleD = 21847688973285879210624605814 ∧
      p41ExampleX - 1 = p41ExampleK ∧
      p41ExampleX + 1 = 3 * p41ExampleB * 4 ^ 2 ∧
      p41ExampleX ^ 2 - p41ExampleD * 4 ^ 2 = 1 := by
  norm_num [p41ExampleK, p41ExampleX, p41ExampleD,
    p41ExampleB, primitivePellTemplateK, primitivePellTemplateX,
    primitivePellTemplateD]

/-- The diagnostic lies in the actual ramified CRT class and in a genuine
finite `p = 41`, `z = 1` five-adic solution class. -/
theorem p41Example_baseResidues :
    p41ExampleB % 24 = 23 ∧
      p41ExampleK % 24 = 22 ∧
      p41ExampleX % 24 = 23 ∧
      p41ExampleX % 600 = 455 ∧
      p41ExampleX % 625 = 305 ∧
      p41ExampleX % 3125 = 930 := by
  norm_num [p41ExampleK, p41ExampleX, p41ExampleB,
    primitivePellTemplateK, primitivePellTemplateX]

/-- A Lucas-order certificate in `F_q`.  The three displayed powers imply
that `3109` has exact order `164 = 4*41`: every proper divisor of `164`
divides `82`, except `4`, and both possibilities are excluded here. -/
theorem p41Example_lambdaPowerCertificate :
    (3109 : ZMod 19681) ^ 164 = 1 ∧
      (3109 : ZMod 19681) ^ 82 = -1 ∧
      (3109 : ZMod 19681) ^ 4 = 2180 := by
  set_option maxRecDepth 100000 in
    decide

/-- Trace, inverse, and Pell splitting data at `q`. -/
theorem p41Example_traceAndPellModQ :
    (3109 : ZMod 19681)⁻¹ = 17573 ∧
      ((3109 : ZMod 19681) + (3109 : ZMod 19681)⁻¹) *
          (2 : ZMod 19681)⁻¹ = 10341 ∧
      (p41ExampleX : ZMod 19681) = 10341 ∧
      (17873 : ZMod 19681) ^ 2 = (p41ExampleD : ZMod 19681) ∧
      (p41ExampleX : ZMod 19681) + 4 * 17873 = 3109 := by
  have hInv : (3109 : ZMod 19681)⁻¹ = 17573 :=
    ZMod.inv_eq_of_mul_eq_one 19681 3109 17573 (by decide)
  have hTwoInv : (2 : ZMod 19681)⁻¹ = 9841 :=
    ZMod.inv_eq_of_mul_eq_one 19681 2 9841 (by decide)
  rw [hInv, hTwoInv]
  set_option maxRecDepth 100000 in
    decide

/-- The same `q` splits in `Q(sqrt(5))`; this exact norm identity also
shows directly that odd `q`-valuation is compatible with that norm. -/
theorem p41Example_q_splits_five_norm :
    (287 : ℤ) ^ 2 - 5 * 27 ^ 2 = 4 * (p41ExampleQ : ℤ) := by
  norm_num [p41ExampleQ]

/-- Even the stronger requirement that five be a fourth power modulo the
moving prime is compatible with the diagnostic. -/
theorem p41Example_five_is_fourthPower_modQ :
    (3016 : ZMod 19681) ^ 4 = 5 := by
  decide

/-- Exact odd valuation of the primitive quotient factor. -/
theorem p41Example_quotient_q_exactlyOnce :
    (p41ExampleQ : ℤ) ∣
        pellOddChebyshevQuotient 20 p41ExampleX ∧
      ¬(p41ExampleQ : ℤ) ^ 2 ∣
        pellOddChebyshevQuotient 20 p41ExampleX := by
  set_option maxRecDepth 100000 in
  constructor <;>
    norm_num [p41ExampleQ, p41ExampleX, primitivePellTemplateX,
      p41ExampleB, Int.dvd_iff_emod_eq_zero,
      pellOddChebyshevQuotient]

/-- More precise residue behind the exact-valuation certificate. -/
theorem p41Example_quotient_mod_q_sq :
    pellOddChebyshevQuotient 20 p41ExampleX %
        ((p41ExampleQ : ℤ) ^ 2) =
      (p41ExampleQ : ℤ) * 15953 := by
  set_option maxRecDepth 100000 in
  norm_num [p41ExampleQ, p41ExampleX, primitivePellTemplateX,
    p41ExampleB, pellOddChebyshevQuotient]

/-- The target square equation really holds modulo `5^5` with `y = 5`.
This is a finite local statement, not an integer solution. -/
theorem p41Example_target_mod_3125 :
    (5 : ℤ) ^ 2 ≡
      4 * pellChebyshev 41 p41ExampleX + 5 [ZMOD 3125] := by
  set_option maxRecDepth 100000 in
  rw [show (41 : ℕ) = 2 * 20 + 1 by norm_num,
    pellChebyshev_odd_eq_mul_quotient]
  norm_num [p41ExampleX, primitivePellTemplateX, p41ExampleB,
    pellOddChebyshevQuotient, Int.ModEq]

/-- Three is not an integer square modulo seven. -/
theorem intSquare_mod_seven_ne_three (y : ℤ) :
    y ^ 2 % 7 ≠ 3 := by
  intro h
  have hcast : (y : ZMod 7) ^ 2 = 3 := by
    calc
      (y : ZMod 7) ^ 2 = ((y ^ 2 : ℤ) : ZMod 7) := by norm_num
      _ = (((y ^ 2) % 7 : ℤ) : ZMod 7) :=
        (ZMod.intCast_mod (y ^ 2) 7).symm
      _ = 3 := by rw [h]; norm_num
  have hfinite : ∀ z : ZMod 7, z ^ 2 ≠ 3 := by
    decide
  exact hfinite y hcast

/-- Despite all the preceding compatible data, this explicit integer base
is not a global shifted-square solution: modulo seven the right side is the
nonsquare `3`. -/
theorem p41Example_no_global_shiftedSquare (y : ℤ) :
    y ^ 2 ≠ 4 * pellChebyshev 41 p41ExampleX + 5 := by
  set_option maxRecDepth 100000 in
  intro hy
  have hT : pellChebyshev 41 p41ExampleX % 7 = 3 := by
    rw [show (41 : ℕ) = 2 * 20 + 1 by norm_num,
      pellChebyshev_odd_eq_mul_quotient]
    norm_num [p41ExampleX, primitivePellTemplateX, p41ExampleB,
      pellOddChebyshevQuotient]
  have hrem := congrArg (fun z : ℤ => z % 7) hy
  have hsquare : y ^ 2 % 7 = 3 := by
    rw [Int.add_emod, Int.mul_emod, hT] at hrem
    norm_num at hrem
    exact hrem
  exact intSquare_mod_seven_ne_three y hsquare

#print axioms granville_lucasRatio_no_coprime
#print axioms granville_lehmerRatio_no_coprime
#print axioms primitivePellTemplate_identities
#print axioms primitivePellTemplate_residues
#print axioms primitivePellTemplateX_map_modEq
#print axioms pellOddChebyshevQuotient_mod_twentyFour_of_negOne
#print axioms primeSquareShape_forces_index_mod_twentyFour
#print axioms primeSquareShape_active_crt
#print axioms p41ExampleQ_prime
#print axioms p41Example_factorizations
#print axioms p41Example_pellData
#print axioms p41Example_baseResidues
#print axioms p41Example_lambdaPowerCertificate
#print axioms p41Example_traceAndPellModQ
#print axioms p41Example_q_splits_five_norm
#print axioms p41Example_five_is_fourthPower_modQ
#print axioms p41Example_quotient_q_exactlyOnce
#print axioms p41Example_quotient_mod_q_sq
#print axioms p41Example_target_mod_3125
#print axioms p41Example_no_global_shiftedSquare

end MovingPrimitiveNoGo

end IUTThreeClosures
