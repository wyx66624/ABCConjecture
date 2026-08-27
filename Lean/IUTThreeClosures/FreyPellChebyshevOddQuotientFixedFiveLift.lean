/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevFixedFiveResidualConsequences
import IUTThreeClosures.FreyPellChebyshevOddQuotientGcdLedger

/-!
# Odd-quotient depth inside the fixed-five residual

This file combines the exact congruence of the odd Chebyshev quotient modulo
the square of its base with the fixed-five mixed-coordinate residual.

The main new arithmetic output is a second ramified-five digit: when the
base is `5*A`, the signed odd index `c` must satisfy

`(A*c) % 25 ∈ {1, 6, 11}`.

It also proves that, away from a common divisor of `r` and `X`, the mixed
quadratic congruence determines its floor coordinate in a unique class
modulo `X^2`.  No uniform exclusion is asserted.
-/

namespace IUTThreeClosures

/-! ## Elementary residue kernels -/

/-- The complete list of integer square residues modulo five. -/
theorem intSquare_emod_five (z : ℤ) :
    z ^ 2 % 5 = 0 ∨ z ^ 2 % 5 = 1 ∨ z ^ 2 % 5 = 4 := by
  have hzNonneg : 0 ≤ z % 5 := Int.emod_nonneg z (by norm_num)
  have hzLt : z % 5 < 5 := Int.emod_lt_of_pos z (by norm_num)
  have hreduce : z ^ 2 % 5 = ((z % 5) ^ 2) % 5 := by
    simp [pow_two, Int.mul_emod]
  rw [hreduce]
  interval_cases h : z % 5 <;> norm_num [h]

/-- Scalar ramified-five lift.  Congruence depth `(5*A)^2`, together with
the shifted square equation, leaves only three of the five lifts of the
first modulo-five class. -/
theorem ramifiedFive_secondDigit_of_modSq
    (A H c y : ℤ)
    (hH : H ≡ c [ZMOD (5 * A) ^ 2])
    (hy : y ^ 2 = 4 * (5 * A) * H + 5) :
    (A * c) % 25 = 1 ∨
      (A * c) % 25 = 6 ∨
      (A * c) % 25 = 11 := by
  have hfiveSq : (5 : ℤ) ∣ y ^ 2 := by
    refine ⟨4 * A * H + 1, ?_⟩
    calc
      y ^ 2 = 4 * (5 * A) * H + 5 := hy
      _ = 5 * (4 * A * H + 1) := by ring
  have hfiveY : (5 : ℤ) ∣ y :=
    Int.Prime.dvd_pow' Nat.prime_five hfiveSq
  rcases hfiveY with ⟨z, hz⟩
  rcases hH.symm.dvd with ⟨k, hk⟩
  have hHexp : H = c + (5 * A) ^ 2 * k := by
    nlinarith [hk]
  let q : ℤ := z ^ 2 - 20 * A ^ 3 * k
  have hqEq : 4 * A * c + 1 = 5 * q := by
    rw [hz, hHexp] at hy
    dsimp [q]
    ring_nf at hy ⊢
    nlinarith [hy]
  have hqMod : q ≡ z ^ 2 [ZMOD 5] := by
    apply Int.modEq_of_dvd
    refine ⟨4 * A ^ 3 * k, ?_⟩
    dsimp [q]
    ring
  let t : ℤ := A * c
  have htq : 4 * t + 1 = 5 * q := by
    simpa [t, mul_assoc] using hqEq
  rcases intSquare_emod_five z with hzSq | hzSq | hzSq
  · have hq : q % 5 = 0 := hqMod.eq.trans hzSq
    right
    left
    change t % 25 = 6
    omega
  · have hq : q % 5 = 1 := hqMod.eq.trans hzSq
    left
    change t % 25 = 1
    omega
  · have hq : q % 5 = 4 := hqMod.eq.trans hzSq
    right
    right
    change t % 25 = 11
    omega

/-- The actual odd Chebyshev quotient supplies the required square-depth
congruence, so the ramified-five lift applies with its signed index. -/
theorem pellOddChebyshevQuotient_ramifiedFive_secondDigit
    (m : ℕ) (A y : ℤ)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient m (5 * A) + 5) :
    (A * pellOddChebyshevLinearCoefficient m) % 25 = 1 ∨
      (A * pellOddChebyshevLinearCoefficient m) % 25 = 6 ∨
      (A * pellOddChebyshevLinearCoefficient m) % 25 = 11 := by
  exact ramifiedFive_secondDigit_of_modSq A
    (pellOddChebyshevQuotient m (5 * A))
    (pellOddChebyshevLinearCoefficient m) y
    (pellOddChebyshevQuotient_mod_sq m (5 * A)) hy

/-! ## Mixed-coordinate square-depth congruence -/

/-- The quadratic expression appearing in the mixed-coordinate identity. -/
def pellFixedFiveMixedPolynomial (X r b : ℤ) : ℤ :=
  X * b ^ 2 + r * b + 1

/-- The mixed identity transports any quotient congruence modulo `X^2` to
an exact congruence for the floor coordinate. -/
theorem pellFixedFiveMixedPolynomial_mod_sq
    (X H r a b c : ℤ)
    (hcoordinate : a ^ 2 * H = pellFixedFiveMixedPolynomial X r b)
    (hH : H ≡ c [ZMOD X ^ 2]) :
    pellFixedFiveMixedPolynomial X r b ≡ c * a ^ 2 [ZMOD X ^ 2] := by
  have hscaled := hH.mul_left (a ^ 2)
  rw [hcoordinate] at hscaled
  simpa [mul_comm] using hscaled

/-- The pointwise natural floor and its square-depth residue class, packaged
together for the actual odd Chebyshev quotient. -/
theorem pellOddChebyshevQuotient_pointwiseFloor_mod_sq
    (m X H r a b : ℕ)
    (ha : 1 ≤ a)
    (haX : a ^ 2 < X)
    (hr : r ^ 2 = 4 * X + 5 * a ^ 2)
    (hcoordinate : a ^ 2 * H = X * b ^ 2 + r * b + 1)
    (hH : (H : ℤ) = pellOddChebyshevQuotient m (X : ℤ)) :
    ⌊(a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ))⌋₊ = b ∧
      pellFixedFiveMixedPolynomial (X : ℤ) (r : ℤ) (b : ℤ) ≡
        pellOddChebyshevLinearCoefficient m * (a : ℤ) ^ 2
          [ZMOD (X : ℤ) ^ 2] := by
  constructor
  · exact pellFixedFiveResidual_pointwiseNatFloor
      X H r a b ha haX hr hcoordinate
  · apply pellFixedFiveMixedPolynomial_mod_sq
      (X : ℤ) (H : ℤ) (r : ℤ) (a : ℤ) (b : ℤ)
      (pellOddChebyshevLinearCoefficient m)
    · change (a : ℤ) ^ 2 * (H : ℤ) =
        (X : ℤ) * (b : ℤ) ^ 2 + (r : ℤ) * (b : ℤ) + 1
      exact_mod_cast hcoordinate
    · rw [hH]
      exact pellOddChebyshevQuotient_mod_sq m (X : ℤ)

/-! ## The derivative is a unit away from five -/

/-- Every common divisor of `r` and `X` is supported at five once
`r^2 - 5*a^2 = 4*X` and `a` is coprime to `X`. -/
theorem pellFixedFive_commonDivisor_r_X_dvd_five
    (X r a d : ℤ)
    (hnorm : r ^ 2 - 5 * a ^ 2 = 4 * X)
    (haX : IsCoprime a X)
    (hdr : d ∣ r)
    (hdX : d ∣ X) :
    d ∣ 5 := by
  have hdrSq : d ∣ r ^ 2 := by
    simpa [pow_two] using dvd_mul_of_dvd_left hdr r
  have hdFourX : d ∣ 4 * X := dvd_mul_of_dvd_right hdX 4
  have hdFiveASq : d ∣ 5 * a ^ 2 := by
    have hdiff : d ∣ r ^ 2 - 4 * X := dvd_sub hdrSq hdFourX
    convert hdiff using 1; nlinarith [hnorm]
  have had : IsCoprime a d :=
    IsCoprime.of_isCoprime_of_dvd_right haX hdX
  have hdaSq : IsCoprime d (a ^ 2) := had.symm.pow_right
  exact hdaSq.dvd_of_dvd_mul_right hdFiveASq

/-- In particular, the positive gcd of `r` and `X` divides five. -/
theorem pellFixedFive_gcd_r_X_dvd_five
    (X r a : ℤ)
    (hnorm : r ^ 2 - 5 * a ^ 2 = 4 * X)
    (haX : IsCoprime a X) :
    (Int.gcd r X : ℤ) ∣ 5 := by
  exact pellFixedFive_commonDivisor_r_X_dvd_five X r a
    (Int.gcd r X : ℤ) hnorm haX
    (Int.gcd_dvd_left r X) (Int.gcd_dvd_right r X)

/-- Away from the ramified prime five, the coefficient `r` is coprime to
the base `X`; equivalently, the derivative of the mixed quadratic is a unit
modulo `X`. -/
theorem pellFixedFive_isCoprime_r_X_of_five_not_dvd
    (X r a : ℤ)
    (hnorm : r ^ 2 - 5 * a ^ 2 = 4 * X)
    (haX : IsCoprime a X)
    (hfive : ¬(5 : ℤ) ∣ X) :
    IsCoprime r X := by
  apply Int.isCoprime_iff_gcd_eq_one.mpr
  have hgInt := pellFixedFive_gcd_r_X_dvd_five X r a hnorm haX
  have hgNat : Int.gcd r X ∣ 5 :=
    Int.natCast_dvd_natCast.mp hgInt
  rcases (Nat.dvd_prime Nat.prime_five).mp hgNat with hg | hg
  · exact hg
  · exfalso
    apply hfive
    have hdiv := Int.gcd_dvd_right r X
    simpa [hg] using hdiv

/-! ## Hensel uniqueness away from the ramified derivative -/

/-- If `r` is coprime to `X`, the mixed quadratic congruence has at most one
solution class modulo `X^2`. -/
theorem pellFixedFiveMixedPolynomial_mod_sq_unique
    (X r b₁ b₂ C : ℤ)
    (hrX : IsCoprime r X)
    (h₁ : pellFixedFiveMixedPolynomial X r b₁ ≡ C [ZMOD X ^ 2])
    (h₂ : pellFixedFiveMixedPolynomial X r b₂ ≡ C [ZMOD X ^ 2]) :
    b₁ ≡ b₂ [ZMOD X ^ 2] := by
  have hpoly : pellFixedFiveMixedPolynomial X r b₁ ≡
      pellFixedFiveMixedPolynomial X r b₂ [ZMOD X ^ 2] :=
    h₁.trans h₂.symm
  have hdvd : X ^ 2 ∣
      pellFixedFiveMixedPolynomial X r b₂ -
        pellFixedFiveMixedPolynomial X r b₁ := hpoly.dvd
  have hfactor : IsCoprime (X * (b₂ + b₁) + r) X := by
    rcases hrX with ⟨α, β, hbezout⟩
    refine ⟨α, β - α * (b₂ + b₁), ?_⟩
    calc
      α * (X * (b₂ + b₁) + r) +
          (β - α * (b₂ + b₁)) * X =
        α * r + β * X := by ring
      _ = 1 := hbezout
  have hfactorSq : IsCoprime (X ^ 2) (X * (b₂ + b₁) + r) :=
    hfactor.pow_right.symm
  have hfactored :
      pellFixedFiveMixedPolynomial X r b₂ -
          pellFixedFiveMixedPolynomial X r b₁ =
        (b₂ - b₁) * (X * (b₂ + b₁) + r) := by
    simp only [pellFixedFiveMixedPolynomial]
    ring
  rw [hfactored] at hdvd
  exact Int.modEq_of_dvd (hfactorSq.dvd_of_dvd_mul_right hdvd)

/-- The norm equation and `5 ∤ X` supply the coprimality hypothesis needed
by the preceding uniqueness theorem. -/
theorem pellFixedFiveMixedPolynomial_mod_sq_unique_of_five_not_dvd
    (X r a b₁ b₂ C : ℤ)
    (hnorm : r ^ 2 - 5 * a ^ 2 = 4 * X)
    (haX : IsCoprime a X)
    (hfive : ¬(5 : ℤ) ∣ X)
    (h₁ : pellFixedFiveMixedPolynomial X r b₁ ≡ C [ZMOD X ^ 2])
    (h₂ : pellFixedFiveMixedPolynomial X r b₂ ≡ C [ZMOD X ^ 2]) :
    b₁ ≡ b₂ [ZMOD X ^ 2] := by
  exact pellFixedFiveMixedPolynomial_mod_sq_unique X r b₁ b₂ C
    (pellFixedFive_isCoprime_r_X_of_five_not_dvd
      X r a hnorm haX hfive) h₁ h₂

/-! ## Strictness witness -/

/-- The old shifted-square equation and first ramified-five residue do not
imply the new second digit.  This exact example even lies in the old
`p = 41` CRT class `X = 455 (mod 600)`. -/
theorem ramifiedFive_secondDigit_not_shiftSquare_restatement :
    let p : ℤ := 41
    let c : ℤ := 41
    let A : ℤ := 451
    let X : ℤ := 5 * A
    let H : ℤ := 1
    let y : ℤ := 95
    y ^ 2 = 4 * X * H + 5 ∧
      X % 600 = 455 ∧
      H % 5 = c % 5 ∧
      (A * c) % 25 = 16 ∧
      p = 41 := by
  norm_num

#print axioms intSquare_emod_five
#print axioms ramifiedFive_secondDigit_of_modSq
#print axioms pellOddChebyshevQuotient_ramifiedFive_secondDigit
#print axioms pellFixedFiveMixedPolynomial_mod_sq
#print axioms pellOddChebyshevQuotient_pointwiseFloor_mod_sq
#print axioms pellFixedFive_commonDivisor_r_X_dvd_five
#print axioms pellFixedFive_gcd_r_X_dvd_five
#print axioms pellFixedFive_isCoprime_r_X_of_five_not_dvd
#print axioms pellFixedFiveMixedPolynomial_mod_sq_unique
#print axioms pellFixedFiveMixedPolynomial_mod_sq_unique_of_five_not_dvd
#print axioms ramifiedFive_secondDigit_not_shiftSquare_restatement

end IUTThreeClosures
