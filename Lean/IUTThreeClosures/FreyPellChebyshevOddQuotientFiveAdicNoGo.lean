/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevOddQuotientGcdLedger

/-!
# The odd Chebyshev quotient has no pure five-adic exclusion

This file kernel-checks the finite congruence input to the Hensel argument.
For the ramified equation

  `5 z^2 - 4 A H_m(5 A) - 1 = 0`,

the reduction modulo five is `A c_m - 1`, where
`c_m = (-1)^m (2m+1)`.  More strongly, changing `A` by one candidate digit
at depth `n` changes the equation by the unit slope `-4 c_m` modulo the next
power of five.  The companion audit states the standard Hensel consequence
over the five-adic integers and keeps that accepted theorem separate from the
kernel-checked finite arithmetic here.
-/

namespace IUTThreeClosures

/-- The ramified fixed-five equation after writing `X = 5 A` and `y = 5 z`. -/
def pellOddChebyshevFiveAdicEquation (m : ℕ) (A z : ℤ) : ℤ :=
  5 * z ^ 2 - 4 * A * pellOddChebyshevQuotient m (5 * A) - 1

/-- The recursively defined odd quotient respects every integer congruence. -/
theorem pellOddChebyshevQuotient_map_modEq
    (m : ℕ) {x y modulus : ℤ} (hxy : x ≡ y [ZMOD modulus]) :
    pellOddChebyshevQuotient m x ≡
      pellOddChebyshevQuotient m y [ZMOD modulus] := by
  induction m using Nat.twoStepInduction with
  | zero =>
      simp
  | one =>
      rw [pellOddChebyshevQuotient_one, pellOddChebyshevQuotient_one]
      exact ((Int.ModEq.refl 4).mul (hxy.pow 2)).sub (Int.ModEq.refl 3)
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two,
        pellOddChebyshevQuotient_add_two]
      have hfactor :
          4 * x ^ 2 - 2 ≡ 4 * y ^ 2 - 2 [ZMOD modulus] :=
        ((Int.ModEq.refl 4).mul (hxy.pow 2)).sub (Int.ModEq.refl 2)
      exact (hfactor.mul hm1).sub hm

/-- At a five-multiple base, the quotient reduces to its signed linear
coefficient modulo five. -/
theorem pellOddChebyshevQuotient_five_mul_mod_five
    (m : ℕ) (A : ℤ) :
    pellOddChebyshevQuotient m (5 * A) ≡
      pellOddChebyshevLinearCoefficient m [ZMOD 5] := by
  apply Int.ModEq.of_dvd (show (5 : ℤ) ∣ 5 * A by exact ⟨A, rfl⟩)
  exact pellOddChebyshevQuotient_mod_base m (5 * A)

/-- The ramified equation modulo five is exactly `A c_m - 1`; the `z`
coordinate disappears at this first digit. -/
theorem pellOddChebyshevFiveAdicEquation_mod_five
    (m : ℕ) (A z : ℤ) :
    pellOddChebyshevFiveAdicEquation m A z ≡
      A * pellOddChebyshevLinearCoefficient m - 1 [ZMOD 5] := by
  have hH := pellOddChebyshevQuotient_five_mul_mod_five m A
  rcases hH.dvd with ⟨k, hk⟩
  apply Int.modEq_of_dvd
  refine ⟨A * (pellOddChebyshevQuotient m (5 * A) + k) - z ^ 2, ?_⟩
  have hc :
      pellOddChebyshevLinearCoefficient m =
        pellOddChebyshevQuotient m (5 * A) + 5 * k := by
    linarith
  rw [hc]
  unfold pellOddChebyshevFiveAdicEquation
  ring

/-- If five does not divide the odd index, the Hensel slope `-4 c_m` is a
unit modulo five. -/
theorem pellOddChebyshevFiveAdicSlope_not_dvd_five
    (m : ℕ)
    (hp : ¬(5 : ℤ) ∣ 2 * (m : ℤ) + 1) :
    ¬(5 : ℤ) ∣ -4 * pellOddChebyshevLinearCoefficient m := by
  have hc : ¬(5 : ℤ) ∣ pellOddChebyshevLinearCoefficient m := by
    by_cases hm : Even m
    · simpa [pellOddChebyshevLinearCoefficient, hm.neg_one_pow] using hp
    · have hmOdd : Odd m := Nat.not_even_iff_odd.mp hm
      rw [pellOddChebyshevLinearCoefficient, hmOdd.neg_one_pow]
      simp only [neg_one_mul, dvd_neg]
      exact hp
  intro hslope
  apply hc
  have hcop : IsCoprime (5 : ℤ) (-4 : ℤ) := by
    norm_num
  exact hcop.dvd_of_dvd_mul_left hslope

/-- Exact one-digit finite-difference formula.  It is the discrete form of
`∂F/∂A ≡ -4 c_m (mod 5)` and is valid at every depth, including depth zero. -/
theorem pellOddChebyshevFiveAdicEquation_lift_digit
    (m n : ℕ) (A z t : ℤ) :
    pellOddChebyshevFiveAdicEquation m
          (A + (5 : ℤ) ^ n * t) z -
        pellOddChebyshevFiveAdicEquation m A z ≡
      -4 * (5 : ℤ) ^ n * t * pellOddChebyshevLinearCoefficient m
        [ZMOD (5 : ℤ) ^ (n + 1)] := by
  have hbase :
      5 * (A + (5 : ℤ) ^ n * t) ≡ 5 * A
        [ZMOD (5 : ℤ) ^ (n + 1)] := by
    apply Int.modEq_of_dvd
    refine ⟨-t, ?_⟩
    rw [pow_succ]
    ring
  have hH := pellOddChebyshevQuotient_map_modEq m hbase
  rcases hH.dvd with ⟨k, hk⟩
  have hc := pellOddChebyshevQuotient_five_mul_mod_five m
    (A + (5 : ℤ) ^ n * t)
  rcases hc.dvd with ⟨l, hl⟩
  have hHdiff :
      pellOddChebyshevQuotient m
            (5 * (A + (5 : ℤ) ^ n * t)) -
          pellOddChebyshevQuotient m (5 * A) =
        -((5 : ℤ) ^ (n + 1) * k) := by
    calc
      pellOddChebyshevQuotient m
            (5 * (A + (5 : ℤ) ^ n * t)) -
          pellOddChebyshevQuotient m (5 * A) =
          -(pellOddChebyshevQuotient m (5 * A) -
            pellOddChebyshevQuotient m
              (5 * (A + (5 : ℤ) ^ n * t))) := by ring
      _ = -((5 : ℤ) ^ (n + 1) * k) := by rw [hk]
  have hHcoefficient :
      pellOddChebyshevQuotient m
            (5 * (A + (5 : ℤ) ^ n * t)) -
          pellOddChebyshevLinearCoefficient m = -(5 * l) := by
    calc
      pellOddChebyshevQuotient m
            (5 * (A + (5 : ℤ) ^ n * t)) -
          pellOddChebyshevLinearCoefficient m =
          -(pellOddChebyshevLinearCoefficient m -
            pellOddChebyshevQuotient m
              (5 * (A + (5 : ℤ) ^ n * t))) := by ring
      _ = -(5 * l) := by rw [hl]
  apply Int.modEq_of_dvd
  refine ⟨-4 * (A * k + t * l), ?_⟩
  calc
    (-4 * (5 : ℤ) ^ n * t * pellOddChebyshevLinearCoefficient m) -
        (pellOddChebyshevFiveAdicEquation m
            (A + (5 : ℤ) ^ n * t) z -
          pellOddChebyshevFiveAdicEquation m A z) =
      4 *
        (A *
            (pellOddChebyshevQuotient m
                (5 * (A + (5 : ℤ) ^ n * t)) -
              pellOddChebyshevQuotient m (5 * A)) +
          (5 : ℤ) ^ n * t *
            (pellOddChebyshevQuotient m
                (5 * (A + (5 : ℤ) ^ n * t)) -
              pellOddChebyshevLinearCoefficient m)) := by
        unfold pellOddChebyshevFiveAdicEquation
        ring
    _ = (5 : ℤ) ^ (n + 1) * (-4 * (A * k + t * l)) := by
      rw [hHdiff, hHcoefficient, pow_succ]
      ring

/-- The prime-to-five ramified CRT condition is compatible with every finite
five-adic residue: `A ≡ 19 (mod 24)` is the same as `5 A ≡ 23 (mod 24)`. -/
theorem exists_ramifiedCRT_lift_of_five_power
    (n A : ℕ) :
    ∃ a : ℕ, a ≡ A [MOD 5 ^ n] ∧ a ≡ 19 [MOD 24] := by
  have hcop : Nat.Coprime (5 ^ n) 24 :=
    (by norm_num : Nat.Coprime 5 24).pow_left n
  let a := Nat.chineseRemainder hcop A 19
  exact ⟨a, a.property.1, a.property.2⟩

/-- Multiplication by five identifies the ramified base class
`A ≡ 19 (mod 24)` with `X = 5 A ≡ 23 (mod 24)`. -/
theorem five_mul_ramifiedClass_iff (A : ℕ) :
    A ≡ 19 [MOD 24] ↔ 5 * A ≡ 23 [MOD 24] := by
  constructor
  · intro hA
    exact (hA.mul_left 5).trans (by norm_num [Nat.ModEq])
  · intro hX
    have hmul : 25 * A ≡ 115 [MOD 24] := by
      simpa only [← mul_assoc, Nat.reduceMul] using hX.mul_left 5
    have hreduce : 25 * A ≡ A [MOD 24] := by
      simpa using
        ((by norm_num [Nat.ModEq] : 25 ≡ 1 [MOD 24]).mul
          (Nat.ModEq.refl A))
    exact hreduce.symm.trans (hmul.trans (by norm_num [Nat.ModEq]))

/-- Every odd quotient equals one at the negative endpoint. -/
theorem pellOddChebyshevQuotient_neg_one (m : ℕ) :
    pellOddChebyshevQuotient m (-1) = 1 := by
  induction m using Nat.twoStepInduction with
  | zero => simp
  | one => norm_num [pellOddChebyshevQuotient]
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two, hm1, hm]
      norm_num

/-- The full divided equation also passes the prime-to-five check when
`A ≡ 19` and `z ≡ 1` modulo 24. -/
theorem pellOddChebyshevFiveAdicEquation_mod_twentyfour
    (m : ℕ) (A z : ℤ)
    (hA : A ≡ 19 [ZMOD 24])
    (hz : z ≡ 1 [ZMOD 24]) :
    pellOddChebyshevFiveAdicEquation m A z ≡ 0 [ZMOD 24] := by
  have hX : 5 * A ≡ -1 [ZMOD 24] :=
    (hA.mul_left 5).trans (by norm_num [Int.ModEq])
  have hH := pellOddChebyshevQuotient_map_modEq m hX
  rw [pellOddChebyshevQuotient_neg_one] at hH
  have hzterm := (Int.ModEq.refl 5).mul (hz.pow 2)
  have hAHterm := ((Int.ModEq.refl 4).mul hA).mul hH
  have hF := (hzterm.sub hAHterm).sub (Int.ModEq.refl 1)
  have hF' :
      pellOddChebyshevFiveAdicEquation m A z ≡ -72 [ZMOD 24] := by
    simpa [pellOddChebyshevFiveAdicEquation] using hF
  exact hF'.trans (by norm_num [Int.ModEq])

/-- Every finite five-adic `z` residue is compatible with the convenient
prime-to-five choice `z ≡ 1 (mod 24)`. -/
theorem exists_mod_twentyfour_one_lift_of_five_power
    (n z : ℕ) :
    ∃ w : ℕ, w ≡ z [MOD 5 ^ n] ∧ w ≡ 1 [MOD 24] := by
  have hcop : Nat.Coprime (5 ^ n) 24 :=
    (by norm_num : Nat.Coprime 5 24).pow_left n
  let w := Nat.chineseRemainder hcop z 1
  exact ⟨w, w.property.1, w.property.2⟩

#print axioms pellOddChebyshevQuotient_map_modEq
#print axioms pellOddChebyshevQuotient_five_mul_mod_five
#print axioms pellOddChebyshevFiveAdicEquation_mod_five
#print axioms pellOddChebyshevFiveAdicSlope_not_dvd_five
#print axioms pellOddChebyshevFiveAdicEquation_lift_digit
#print axioms exists_ramifiedCRT_lift_of_five_power
#print axioms five_mul_ramifiedClass_iff
#print axioms pellOddChebyshevQuotient_neg_one
#print axioms pellOddChebyshevFiveAdicEquation_mod_twentyfour
#print axioms exists_mod_twentyfour_one_lift_of_five_power

end IUTThreeClosures
