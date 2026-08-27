/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevOddQuotientFixedFiveLift

/-!
# Fourth-order odd-quotient depth and two further ramified-five digits

This file proves the exact coefficient of `X^2` in the odd Chebyshev
quotient, upgrades its endpoint congruence from `X^2` to `X^4`, and extracts
all the resulting five-adic information available after the substitution
`X = 5*A` in the shifted-square equation.

The branch `A*c = 6 (mod 25)` is singular.  In that branch the fourth-order
quotient congruence forces first a class modulo `125` and then a square class
modulo `625`.  These correspond respectively to new base conditions modulo
`625` and `3125`.  No uniform exclusion is asserted.
-/

namespace IUTThreeClosures

/-! ## The exact quadratic coefficient of the odd quotient -/

/-- The coefficient of `x^2` in the odd Chebyshev quotient.  Its recurrence
is the coefficient recurrence obtained from the exact quotient recurrence. -/
def pellOddChebyshevQuadraticCoefficient : ℕ → ℤ
  | 0 => 0
  | 1 => 4
  | m + 2 =>
      4 * pellOddChebyshevLinearCoefficient (m + 1) -
        2 * pellOddChebyshevQuadraticCoefficient (m + 1) -
          pellOddChebyshevQuadraticCoefficient m

@[simp]
theorem pellOddChebyshevQuadraticCoefficient_zero :
    pellOddChebyshevQuadraticCoefficient 0 = 0 := by
  rfl

@[simp]
theorem pellOddChebyshevQuadraticCoefficient_one :
    pellOddChebyshevQuadraticCoefficient 1 = 4 := by
  rfl

theorem pellOddChebyshevQuadraticCoefficient_add_two (m : ℕ) :
    pellOddChebyshevQuadraticCoefficient (m + 2) =
      4 * pellOddChebyshevLinearCoefficient (m + 1) -
        2 * pellOddChebyshevQuadraticCoefficient (m + 1) -
          pellOddChebyshevQuadraticCoefficient m := by
  rfl

/-- Closed-form check for the quadratic coefficient.  For `p = 2*m+1`
this says exactly

`d_m = (-1)^(m+1) * p * (p^2 - 1) / 6`.

Writing the identity after multiplication by six avoids any convention about
integer division and also proves the required divisibility. -/
theorem pellOddChebyshevQuadraticCoefficient_closed (m : ℕ) :
    6 * pellOddChebyshevQuadraticCoefficient m =
      (-1 : ℤ) ^ (m + 1) * (2 * (m : ℤ) + 1) *
        ((2 * (m : ℤ) + 1) ^ 2 - 1) := by
  induction m using Nat.twoStepInduction with
  | zero => norm_num
  | one => norm_num
  | more m hm hm1 =>
      rw [pellOddChebyshevQuadraticCoefficient_add_two]
      calc
        6 * (4 * pellOddChebyshevLinearCoefficient (m + 1) -
              2 * pellOddChebyshevQuadraticCoefficient (m + 1) -
                pellOddChebyshevQuadraticCoefficient m) =
            24 * pellOddChebyshevLinearCoefficient (m + 1) -
              2 * (6 * pellOddChebyshevQuadraticCoefficient (m + 1)) -
                6 * pellOddChebyshevQuadraticCoefficient m := by ring
        _ = (-1 : ℤ) ^ (m + 2 + 1) *
              (2 * ((m + 2 : ℕ) : ℤ) + 1) *
                ((2 * ((m + 2 : ℕ) : ℤ) + 1) ^ 2 - 1) := by
          rw [hm1, hm]
          simp [pellOddChebyshevLinearCoefficient, pow_add]
          ring

/-- The exact odd quotient through degree two, as a congruence modulo the
fourth power of the base. -/
theorem pellOddChebyshevQuotient_mod_fourth (m : ℕ) (x : ℤ) :
    pellOddChebyshevQuotient m x ≡
      pellOddChebyshevLinearCoefficient m +
        pellOddChebyshevQuadraticCoefficient m * x ^ 2 [ZMOD x ^ 4] := by
  induction m using Nat.twoStepInduction with
  | zero =>
      simp [pellOddChebyshevLinearCoefficient]
  | one =>
      rw [pellOddChebyshevQuotient_one]
      rw [pellOddChebyshevQuadraticCoefficient_one]
      rw [show pellOddChebyshevLinearCoefficient 1 = -3 by
        norm_num [pellOddChebyshevLinearCoefficient]]
      rw [show 4 * x ^ 2 - 3 = -3 + 4 * x ^ 2 by ring]
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two]
      rw [pellOddChebyshevLinearCoefficient_add_two]
      rw [pellOddChebyshevQuadraticCoefficient_add_two]
      have htransport :=
        ((Int.ModEq.refl (4 * x ^ 2 - 2)).mul hm1).sub hm
      have hreduce :
          (4 * x ^ 2 - 2) *
                (pellOddChebyshevLinearCoefficient (m + 1) +
                  pellOddChebyshevQuadraticCoefficient (m + 1) * x ^ 2) -
              (pellOddChebyshevLinearCoefficient m +
                pellOddChebyshevQuadraticCoefficient m * x ^ 2) ≡
            (-2 * pellOddChebyshevLinearCoefficient (m + 1) -
                pellOddChebyshevLinearCoefficient m) +
              (4 * pellOddChebyshevLinearCoefficient (m + 1) -
                  2 * pellOddChebyshevQuadraticCoefficient (m + 1) -
                    pellOddChebyshevQuadraticCoefficient m) * x ^ 2
              [ZMOD x ^ 4] := by
        apply Int.modEq_of_dvd
        refine ⟨-4 * pellOddChebyshevQuadraticCoefficient (m + 1), ?_⟩
        ring
      exact htransport.trans hreduce

/-! ## The singular ramified-five branch through modulus 625 -/

/-- Scalar fourth-order lift.  In the singular old branch `A*c = 6 (mod 25)`,
the expression `E = 4*A*c + 1 + 100*d*A^3` must be `125` times a square
modulo five.  The three displayed residues are exactly `125 * {0,1,4}`
modulo `625`. -/
theorem ramifiedFive_fourthDigit_of_modFourth
    (A H c d y : ℤ)
    (hH : H ≡ c + d * (5 * A) ^ 2 [ZMOD (5 * A) ^ 4])
    (hy : y ^ 2 = 4 * (5 * A) * H + 5) :
    (A * c) % 25 = 1 ∨
      ((A * c) % 25 = 6 ∧
        ((4 * A * c + 1 + 100 * d * A ^ 3) % 625 = 0 ∨
          (4 * A * c + 1 + 100 * d * A ^ 3) % 625 = 125 ∨
          (4 * A * c + 1 + 100 * d * A ^ 3) % 625 = 500)) ∨
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
  have hHexp :
      H = c + d * (5 * A) ^ 2 + (5 * A) ^ 4 * k := by
    nlinarith [hk]
  let q : ℤ := z ^ 2 - 20 * d * A ^ 3 - 500 * A ^ 5 * k
  have hqEq : 4 * A * c + 1 = 5 * q := by
    rw [hz, hHexp] at hy
    dsimp [q]
    ring_nf at hy ⊢
    nlinarith [hy]
  have hqMod : q ≡ z ^ 2 [ZMOD 5] := by
    apply Int.modEq_of_dvd
    refine ⟨4 * d * A ^ 3 + 100 * A ^ 5 * k, ?_⟩
    dsimp [q]
    ring
  let t : ℤ := A * c
  have htq : 4 * t + 1 = 5 * q := by
    simpa [t, mul_assoc] using hqEq
  let E : ℤ := 4 * A * c + 1 + 100 * d * A ^ 3
  have hEeq : E = 5 * z ^ 2 - 2500 * A ^ 5 * k := by
    calc
      E = 5 * q + 100 * d * A ^ 3 := by
        rw [← hqEq]
      _ = 5 * z ^ 2 - 2500 * A ^ 5 * k := by
        dsimp [q]
        ring
  rcases intSquare_emod_five z with hzSq | hzSq | hzSq
  · have hq : q % 5 = 0 := hqMod.eq.trans hzSq
    right
    left
    constructor
    · change t % 25 = 6
      omega
    · have hfiveZSq : (5 : ℤ) ∣ z ^ 2 :=
        Int.dvd_of_emod_eq_zero hzSq
      have hfiveZ : (5 : ℤ) ∣ z :=
        Int.Prime.dvd_pow' Nat.prime_five hfiveZSq
      rcases hfiveZ with ⟨w, hw⟩
      have hEw : E = 125 * w ^ 2 - 625 * (4 * A ^ 5 * k) := by
        rw [hEeq, hw]
        ring
      change E % 625 = 0 ∨ E % 625 = 125 ∨ E % 625 = 500
      rcases intSquare_emod_five w with hwSq | hwSq | hwSq
      · left
        omega
      · right
        left
        omega
      · right
        right
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

/-- The first consequence of the preceding square class: the singular branch
has a unique new lift modulo `125`.  Since `X = 5*A`, this is the new
condition modulo `625` on the base. -/
theorem ramifiedFive_thirdDigit_of_modFourth
    (A H c d y : ℤ)
    (hH : H ≡ c + d * (5 * A) ^ 2 [ZMOD (5 * A) ^ 4])
    (hy : y ^ 2 = 4 * (5 * A) * H + 5) :
    (A * c) % 25 = 1 ∨
      ((A * c) % 25 = 6 ∧
        (4 * A * c + 1 + 100 * d * A ^ 3) % 125 = 0) ∨
      (A * c) % 25 = 11 := by
  rcases ramifiedFive_fourthDigit_of_modFourth A H c d y hH hy with
    hOne | hSix | hEleven
  · exact Or.inl hOne
  · right
    left
    refine ⟨hSix.1, ?_⟩
    let E : ℤ := 4 * A * c + 1 + 100 * d * A ^ 3
    change E % 125 = 0
    rcases hSix.2 with hE | hE | hE
    · change E % 625 = 0 at hE
      omega
    · change E % 625 = 125 at hE
      omega
    · change E % 625 = 500 at hE
      omega
  · exact Or.inr (Or.inr hEleven)

/-- If five divides the quadratic coefficient (as it does for the active
indices 31 and 41), the singular third digit simplifies to `A*c = 31
(mod 125)`. -/
theorem ramifiedFive_thirdDigit_of_five_dvd_coefficient
    (A H c d y : ℤ)
    (hd : (5 : ℤ) ∣ d)
    (hH : H ≡ c + d * (5 * A) ^ 2 [ZMOD (5 * A) ^ 4])
    (hy : y ^ 2 = 4 * (5 * A) * H + 5) :
    (A * c) % 25 = 1 ∨
      (A * c) % 125 = 31 ∨
      (A * c) % 25 = 11 := by
  rcases ramifiedFive_thirdDigit_of_modFourth A H c d y hH hy with
    hOne | hSix | hEleven
  · exact Or.inl hOne
  · right
    left
    rcases hd with ⟨e, he⟩
    have hEdiv : (125 : ℤ) ∣ 4 * A * c + 1 + 100 * d * A ^ 3 :=
      Int.dvd_of_emod_eq_zero hSix.2
    have hterm : (125 : ℤ) ∣ 100 * d * A ^ 3 := by
      refine ⟨4 * e * A ^ 3, ?_⟩
      rw [he]
      ring
    have hbase : (125 : ℤ) ∣ 4 * (A * c) + 1 := by
      simpa [mul_assoc] using dvd_sub hEdiv hterm
    rcases hbase with ⟨j, hj⟩
    let t : ℤ := A * c
    change t % 125 = 31
    have htj : 4 * t + 1 = 125 * j := by
      simpa [t, mul_assoc] using hj
    omega
  · exact Or.inr (Or.inr hEleven)

/-! ## Substitution of the actual quotient -/

/-- The fourth-order ramified-five condition for the actual odd quotient. -/
theorem pellOddChebyshevQuotient_ramifiedFive_fourthDigit
    (m : ℕ) (A y : ℤ)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient m (5 * A) + 5) :
    (A * pellOddChebyshevLinearCoefficient m) % 25 = 1 ∨
      ((A * pellOddChebyshevLinearCoefficient m) % 25 = 6 ∧
        ((4 * A * pellOddChebyshevLinearCoefficient m + 1 +
              100 * pellOddChebyshevQuadraticCoefficient m * A ^ 3) % 625 = 0 ∨
          (4 * A * pellOddChebyshevLinearCoefficient m + 1 +
              100 * pellOddChebyshevQuadraticCoefficient m * A ^ 3) % 625 = 125 ∨
          (4 * A * pellOddChebyshevLinearCoefficient m + 1 +
              100 * pellOddChebyshevQuadraticCoefficient m * A ^ 3) % 625 = 500)) ∨
      (A * pellOddChebyshevLinearCoefficient m) % 25 = 11 := by
  exact ramifiedFive_fourthDigit_of_modFourth A
    (pellOddChebyshevQuotient m (5 * A))
    (pellOddChebyshevLinearCoefficient m)
    (pellOddChebyshevQuadraticCoefficient m) y
    (pellOddChebyshevQuotient_mod_fourth m (5 * A)) hy

/-- The simplified third digit for every index whose quadratic coefficient is
divisible by five. -/
theorem pellOddChebyshevQuotient_ramifiedFive_thirdDigit_of_five_dvd
    (m : ℕ) (A y : ℤ)
    (hd : (5 : ℤ) ∣ pellOddChebyshevQuadraticCoefficient m)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient m (5 * A) + 5) :
    (A * pellOddChebyshevLinearCoefficient m) % 25 = 1 ∨
      (A * pellOddChebyshevLinearCoefficient m) % 125 = 31 ∨
      (A * pellOddChebyshevLinearCoefficient m) % 25 = 11 := by
  exact ramifiedFive_thirdDigit_of_five_dvd_coefficient A
    (pellOddChebyshevQuotient m (5 * A))
    (pellOddChebyshevLinearCoefficient m)
    (pellOddChebyshevQuadraticCoefficient m) y hd
    (pellOddChebyshevQuotient_mod_fourth m (5 * A)) hy

theorem pellOddChebyshevQuadraticCoefficient_fifteen :
    pellOddChebyshevQuadraticCoefficient 15 = 4960 := by
  have h := pellOddChebyshevQuadraticCoefficient_closed 15
  norm_num at h
  omega

theorem pellOddChebyshevQuadraticCoefficient_twenty :
    pellOddChebyshevQuadraticCoefficient 20 = -11480 := by
  have h := pellOddChebyshevQuadraticCoefficient_closed 20
  norm_num at h
  omega

/-! ## Kernel-checked active-prime residue lists -/

/-- At half-index `15` (`p = 31`), the third digit leaves exactly eleven
base classes modulo `625`. -/
theorem pellOddChebyshevQuotient_p31_base_mod625
    (A y : ℤ)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient 15 (5 * A) + 5) :
    (5 * A) % 625 = 20 ∨
      (5 * A) % 625 = 95 ∨
      (5 * A) % 625 = 145 ∨
      (5 * A) % 625 = 220 ∨
      (5 * A) % 625 = 270 ∨
      (5 * A) % 625 = 345 ∨
      (5 * A) % 625 = 395 ∨
      (5 * A) % 625 = 470 ∨
      (5 * A) % 625 = 520 ∨
      (5 * A) % 625 = 595 ∨
      (5 * A) % 625 = 620 := by
  have hd : (5 : ℤ) ∣ pellOddChebyshevQuadraticCoefficient 15 := by
    rw [pellOddChebyshevQuadraticCoefficient_fifteen]
    norm_num
  have h :=
    pellOddChebyshevQuotient_ramifiedFive_thirdDigit_of_five_dvd
      15 A y hd hy
  have hc : pellOddChebyshevLinearCoefficient 15 = -31 := by
    norm_num [pellOddChebyshevLinearCoefficient]
  rw [hc] at h
  omega

/-- At half-index `20` (`p = 41`), the third digit leaves exactly eleven
base classes modulo `625`. -/
theorem pellOddChebyshevQuotient_p41_base_mod625
    (A y : ℤ)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient 20 (5 * A) + 5) :
    (5 * A) % 625 = 55 ∨
      (5 * A) % 625 = 80 ∨
      (5 * A) % 625 = 105 ∨
      (5 * A) % 625 = 180 ∨
      (5 * A) % 625 = 230 ∨
      (5 * A) % 625 = 305 ∨
      (5 * A) % 625 = 355 ∨
      (5 * A) % 625 = 430 ∨
      (5 * A) % 625 = 480 ∨
      (5 * A) % 625 = 555 ∨
      (5 * A) % 625 = 605 := by
  have hd : (5 : ℤ) ∣ pellOddChebyshevQuadraticCoefficient 20 := by
    rw [pellOddChebyshevQuadraticCoefficient_twenty]
    norm_num
  have h :=
    pellOddChebyshevQuotient_ramifiedFive_thirdDigit_of_five_dvd
      20 A y hd hy
  have hc : pellOddChebyshevLinearCoefficient 20 = 41 := by
    norm_num [pellOddChebyshevLinearCoefficient]
  rw [hc] at h
  omega

/-- In the singular `p = 31` branch, the fourth digit leaves exactly three
base classes modulo `3125`. -/
theorem pellOddChebyshevQuotient_p31_singular_base_mod3125
    (A y : ℤ)
    (hsingular : (A * (-31)) % 25 = 6)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient 15 (5 * A) + 5) :
    (5 * A) % 3125 = 620 ∨
      (5 * A) % 3125 = 1245 ∨
      (5 * A) % 3125 = 1870 := by
  have h := pellOddChebyshevQuotient_ramifiedFive_fourthDigit 15 A y hy
  have hc : pellOddChebyshevLinearCoefficient 15 = -31 := by
    norm_num [pellOddChebyshevLinearCoefficient]
  rw [hc, pellOddChebyshevQuadraticCoefficient_fifteen] at h
  have hA5 : A % 5 = 4 := by
    omega
  let q : ℤ := A / 5
  have hAeq : A = 5 * q + 4 := by
    dsimp [q]
    omega
  have htermMod : 496000 * A ^ 3 ≡ 250 [ZMOD 625] := by
    apply Int.modEq_of_dvd
    refine ⟨-(99200 * q ^ 3 + 238080 * q ^ 2 + 190464 * q + 50790), ?_⟩
    rw [hAeq]
    ring
  have htermRem : (496000 * A ^ 3) % 625 = 250 := by
    simpa using htermMod.eq
  rcases h with hOne | hSix | hEleven
  · omega
  · rcases hSix with ⟨_, hE⟩
    have hnormalize :
        4 * A * (-31) + 1 + 100 * 4960 * A ^ 3 =
          -124 * A + 1 + 496000 * A ^ 3 := by
      ring
    rw [hnormalize] at hE
    have hAclasses :
        A % 625 = 124 ∨ A % 625 = 249 ∨ A % 625 = 374 := by
      rcases hE with hZero | hOneTwoFive | hFiveHundred
      · have hEmod :
            -124 * A + 1 + 496000 * A ^ 3 ≡ 0 [ZMOD 625] := by
          simpa [Int.ModEq] using hZero
        have hsub := hEmod.sub htermMod
        have hbaseMod : -124 * A + 1 ≡ -250 [ZMOD 625] := by
          have hleft :
              (-124 * A + 1 + 496000 * A ^ 3) - 496000 * A ^ 3 =
                -124 * A + 1 := by ring
          have hright : (0 : ℤ) - 250 = -250 := by ring
          rw [hleft, hright] at hsub
          exact hsub
        rcases hbaseMod.dvd with ⟨j, hj⟩
        omega
      · have hEmod :
            -124 * A + 1 + 496000 * A ^ 3 ≡ 125 [ZMOD 625] := by
          simpa [Int.ModEq] using hOneTwoFive
        have hsub := hEmod.sub htermMod
        have hbaseMod : -124 * A + 1 ≡ -125 [ZMOD 625] := by
          have hleft :
              (-124 * A + 1 + 496000 * A ^ 3) - 496000 * A ^ 3 =
                -124 * A + 1 := by ring
          have hright : (125 : ℤ) - 250 = -125 := by ring
          rw [hleft, hright] at hsub
          exact hsub
        rcases hbaseMod.dvd with ⟨j, hj⟩
        omega
      · have hEmod :
            -124 * A + 1 + 496000 * A ^ 3 ≡ 500 [ZMOD 625] := by
          simpa [Int.ModEq] using hFiveHundred
        have hsub := hEmod.sub htermMod
        have hbaseMod : -124 * A + 1 ≡ 250 [ZMOD 625] := by
          have hleft :
              (-124 * A + 1 + 496000 * A ^ 3) - 496000 * A ^ 3 =
                -124 * A + 1 := by ring
          have hright : (500 : ℤ) - 250 = 250 := by ring
          rw [hleft, hright] at hsub
          exact hsub
        rcases hbaseMod.dvd with ⟨j, hj⟩
        omega
    rcases hAclasses with hA | hA | hA <;> omega
  · omega

private theorem p41_singular_residue_kernel
    (A : ℤ)
    (hsingular : (A * 41) % 25 = 6)
    (hE :
      (164 * A + 1 + (-1148000 * A ^ 3)) % 625 = 0 ∨
        (164 * A + 1 + (-1148000 * A ^ 3)) % 625 = 125 ∨
        (164 * A + 1 + (-1148000 * A ^ 3)) % 625 = 500) :
    A % 625 = 141 ∨ A % 625 = 266 ∨ A % 625 = 391 := by
  have hA5 : A % 5 = 1 := by
    omega
  let q : ℤ := A / 5
  have hAeq : A = 5 * q + 1 := by
    dsimp [q]
    omega
  have htermMod : (-1148000 * A ^ 3) ≡ 125 [ZMOD 625] := by
    apply Int.modEq_of_dvd
    refine ⟨229600 * q ^ 3 + 137760 * q ^ 2 + 27552 * q + 1837, ?_⟩
    rw [hAeq]
    ring
  rcases hE with hZero | hOneTwoFive | hFiveHundred
  · have hEmod :
        164 * A + 1 + (-1148000 * A ^ 3) ≡ 0 [ZMOD 625] := by
      simpa [Int.ModEq] using hZero
    have hsub := hEmod.sub htermMod
    have hbaseMod : 164 * A + 1 ≡ -125 [ZMOD 625] := by
      have hleft :
          (164 * A + 1 + (-1148000 * A ^ 3)) -
              (-1148000 * A ^ 3) = 164 * A + 1 := by ring
      have hright : (0 : ℤ) - 125 = -125 := by ring
      rw [hleft, hright] at hsub
      exact hsub
    have hmul := hbaseMod.mul_left (-141)
    have hreduce :
        (-141) * (164 * A + 1) ≡ A - 141 [ZMOD 625] := by
      apply Int.modEq_of_dvd
      refine ⟨37 * A, ?_⟩
      ring
    have hshift := (hreduce.symm.trans hmul).add_right 141
    have hAraw : A ≡ 17766 [ZMOD 625] := by
      convert hshift using 1 <;> ring
    have hAmod : A ≡ 266 [ZMOD 625] :=
      hAraw.trans (by norm_num [Int.ModEq])
    exact Or.inr (Or.inl hAmod.eq)
  · have hEmod :
        164 * A + 1 + (-1148000 * A ^ 3) ≡ 125 [ZMOD 625] := by
      simpa [Int.ModEq] using hOneTwoFive
    have hsub := hEmod.sub htermMod
    have hbaseMod : 164 * A + 1 ≡ 0 [ZMOD 625] := by
      have hleft :
          (164 * A + 1 + (-1148000 * A ^ 3)) -
              (-1148000 * A ^ 3) = 164 * A + 1 := by ring
      have hright : (125 : ℤ) - 125 = 0 := by ring
      rw [hleft, hright] at hsub
      exact hsub
    have hmul := hbaseMod.mul_left (-141)
    have hreduce :
        (-141) * (164 * A + 1) ≡ A - 141 [ZMOD 625] := by
      apply Int.modEq_of_dvd
      refine ⟨37 * A, ?_⟩
      ring
    have hshift := (hreduce.symm.trans hmul).add_right 141
    have hAraw : A ≡ 141 [ZMOD 625] := by
      convert hshift using 1 <;> ring
    exact Or.inl hAraw.eq
  · have hEmod :
        164 * A + 1 + (-1148000 * A ^ 3) ≡ 500 [ZMOD 625] := by
      simpa [Int.ModEq] using hFiveHundred
    have hsub := hEmod.sub htermMod
    have hbaseMod : 164 * A + 1 ≡ 375 [ZMOD 625] := by
      have hleft :
          (164 * A + 1 + (-1148000 * A ^ 3)) -
              (-1148000 * A ^ 3) = 164 * A + 1 := by ring
      have hright : (500 : ℤ) - 125 = 375 := by ring
      rw [hleft, hright] at hsub
      exact hsub
    have hmul := hbaseMod.mul_left (-141)
    have hreduce :
        (-141) * (164 * A + 1) ≡ A - 141 [ZMOD 625] := by
      apply Int.modEq_of_dvd
      refine ⟨37 * A, ?_⟩
      ring
    have hshift := (hreduce.symm.trans hmul).add_right 141
    have hAraw : A ≡ -52734 [ZMOD 625] := by
      convert hshift using 1 <;> ring
    have hAmod : A ≡ 391 [ZMOD 625] :=
      hAraw.trans (by norm_num [Int.ModEq])
    exact Or.inr (Or.inr hAmod.eq)

/-- In the singular `p = 41` branch, the fourth digit leaves exactly three
base classes modulo `3125`. -/
theorem pellOddChebyshevQuotient_p41_singular_base_mod3125
    (A y : ℤ)
    (hsingular : (A * 41) % 25 = 6)
    (hy : y ^ 2 =
      4 * (5 * A) * pellOddChebyshevQuotient 20 (5 * A) + 5) :
    (5 * A) % 3125 = 705 ∨
      (5 * A) % 3125 = 1330 ∨
      (5 * A) % 3125 = 1955 := by
  have h := pellOddChebyshevQuotient_ramifiedFive_fourthDigit 20 A y hy
  have hc : pellOddChebyshevLinearCoefficient 20 = 41 := by
    norm_num [pellOddChebyshevLinearCoefficient]
  rw [hc, pellOddChebyshevQuadraticCoefficient_twenty] at h
  rcases h with hOne | hSix | hEleven
  · omega
  · have hnormalize :
        4 * A * 41 + 1 + 100 * (-11480) * A ^ 3 =
          164 * A + 1 + (-1148000 * A ^ 3) := by
      ring
    rw [hnormalize] at hSix
    have hAclasses := p41_singular_residue_kernel A hsingular hSix.2
    rcases hAclasses with hA | hA | hA <;> omega
  · omega

/-! ## Strictness witnesses -/

/-- The old square-depth quotient congruence, shifted-square equation, and
`p = 41` CRT class do not imply the new third digit. -/
theorem ramifiedFive_thirdDigit_not_modSq_restatement :
    let A : ℤ := 691
    let X : ℤ := 5 * A
    let c : ℤ := 41
    let d : ℤ := -11480
    let K : ℤ := 227970758
    let H : ℤ := 2721292637514991
    let y : ℤ := 6132557725
    H = c + X ^ 2 * K ∧
      y ^ 2 = 4 * X * H + 5 ∧
      X % 600 = 455 ∧
      (A * c) % 25 = 6 ∧
      (4 * A * c + 1 + 100 * d * A ^ 3) % 125 = 75 := by
  norm_num

/-- Even after the new third digit has been imposed, the old square-depth
data do not imply the fourth digit. -/
theorem ramifiedFive_fourthDigit_not_thirdDigit_restatement :
    let A : ℤ := 1891
    let X : ℤ := 5 * A
    let c : ℤ := 41
    let d : ℤ := -11480
    let K : ℤ := 161240510
    let H : ℤ := 14414421903482791
    let y : ℤ := 23348521075
    H = c + X ^ 2 * K ∧
      y ^ 2 = 4 * X * H + 5 ∧
      X % 600 = 455 ∧
      (A * c) % 25 = 6 ∧
      (4 * A * c + 1 + 100 * d * A ^ 3) % 125 = 0 ∧
      (4 * A * c + 1 + 100 * d * A ^ 3) % 625 = 250 := by
  norm_num

#print axioms pellOddChebyshevQuadraticCoefficient_closed
#print axioms pellOddChebyshevQuotient_mod_fourth
#print axioms ramifiedFive_fourthDigit_of_modFourth
#print axioms ramifiedFive_thirdDigit_of_modFourth
#print axioms ramifiedFive_thirdDigit_of_five_dvd_coefficient
#print axioms pellOddChebyshevQuotient_ramifiedFive_fourthDigit
#print axioms pellOddChebyshevQuotient_ramifiedFive_thirdDigit_of_five_dvd
#print axioms pellOddChebyshevQuadraticCoefficient_fifteen
#print axioms pellOddChebyshevQuadraticCoefficient_twenty
#print axioms pellOddChebyshevQuotient_p31_base_mod625
#print axioms pellOddChebyshevQuotient_p41_base_mod625
#print axioms pellOddChebyshevQuotient_p31_singular_base_mod3125
#print axioms pellOddChebyshevQuotient_p41_singular_base_mod3125
#print axioms ramifiedFive_thirdDigit_not_modSq_restatement
#print axioms ramifiedFive_fourthDigit_not_thirdDigit_restatement

end IUTThreeClosures
