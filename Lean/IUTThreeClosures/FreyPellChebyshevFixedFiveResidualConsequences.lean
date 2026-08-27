/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevPrimeIndexUniformGenusAudit

/-!
# Fixed-five norm residual: exact scalar consequences

This file isolates the polynomial and Bezout consequences of the integral
system

`r^2 - 5*s^2 = 4*X`, `u^2 - 5*v^2 = 4*H`, and `r*v + s*u = 2`.

No ideal factorization in `Q(sqrt 5)`, class-number computation, Chebyshev
identity, primitive-divisor theorem, or uniform prime-index exclusion is
assumed here.  The parity hypotheses in the two cross-coordinate coprimality
theorems are explicit integer congruences.
-/

namespace IUTThreeClosures

/-! ## Elimination identities -/

/-- Eliminating the two norm equations before using the cross coefficient
gives a denominator-free product identity. -/
theorem pellFixedFiveResidual_scaledElimination
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H) :
    4 * (X * v ^ 2 - H * s ^ 2) =
      (r * v - s * u) * (r * v + s * u) := by
  calc
    4 * (X * v ^ 2 - H * s ^ 2) =
        (4 * X) * v ^ 2 - (4 * H) * s ^ 2 := by ring
    _ = (r ^ 2 - 5 * s ^ 2) * v ^ 2 -
        (u ^ 2 - 5 * v ^ 2) * s ^ 2 := by rw [hX, hH]
    _ = (r * v - s * u) * (r * v + s * u) := by ring

/-- The complete pair of mixed-coordinate identities forced by the fixed-five
norm residual. -/
theorem pellFixedFiveResidual_mixedCoordinateIdentities
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    X * v ^ 2 = H * s ^ 2 - s * u + 1 ∧
      X * v ^ 2 = H * s ^ 2 + r * v - 1 := by
  have hscaled := pellFixedFiveResidual_scaledElimination
    X H r s u v hX hH
  rw [hcross] at hscaled
  constructor <;> nlinarith [hscaled, hcross]

/-- First projection of the mixed-coordinate identity. -/
theorem pellFixedFiveResidual_mixedCoordinate_su
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    X * v ^ 2 = H * s ^ 2 - s * u + 1 :=
  (pellFixedFiveResidual_mixedCoordinateIdentities
    X H r s u v hX hH hcross).1

/-- Second projection of the mixed-coordinate identity. -/
theorem pellFixedFiveResidual_mixedCoordinate_rv
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    X * v ^ 2 = H * s ^ 2 + r * v - 1 :=
  (pellFixedFiveResidual_mixedCoordinateIdentities
    X H r s u v hX hH hcross).2

/-! ## Congruences and explicit Bezout certificates -/

/-- Modulo `s`, the first mixed identity is the inverse relation
`X*v^2 = 1`. -/
theorem pellFixedFiveResidual_X_mul_v_sq_mod_s
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    X * v ^ 2 ≡ 1 [ZMOD s] := by
  rw [Int.modEq_iff_dvd]
  refine ⟨u - H * s, ?_⟩
  have hmix := pellFixedFiveResidual_mixedCoordinate_su
    X H r s u v hX hH hcross
  nlinarith [hmix]

/-- Modulo `v`, the second mixed identity is the inverse relation
`H*s^2 = 1`. -/
theorem pellFixedFiveResidual_H_mul_s_sq_mod_v
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    H * s ^ 2 ≡ 1 [ZMOD v] := by
  rw [Int.modEq_iff_dvd]
  refine ⟨r - X * v, ?_⟩
  have hmix := pellFixedFiveResidual_mixedCoordinate_rv
    X H r s u v hX hH hcross
  nlinarith [hmix]

/-- The first mixed identity supplies the explicit Bezout coefficients
`u-H*s` and `v^2`; no parity or positivity assumption is needed. -/
theorem pellFixedFiveResidual_isCoprime_s_X
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    IsCoprime s X := by
  refine ⟨u - H * s, v ^ 2, ?_⟩
  have hmix := pellFixedFiveResidual_mixedCoordinate_su
    X H r s u v hX hH hcross
  nlinarith [hmix]

/-- The second mixed identity supplies the explicit Bezout coefficients
`r-X*v` and `s^2`; no parity or positivity assumption is needed. -/
theorem pellFixedFiveResidual_isCoprime_v_H
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    IsCoprime v H := by
  refine ⟨r - X * v, s ^ 2, ?_⟩
  have hmix := pellFixedFiveResidual_mixedCoordinate_rv
    X H r s u v hX hH hcross
  nlinarith [hmix]

/-! ## The complete scalar gcd ledger -/

/-- A reusable integer kernel: if `a*c+b*d=2` and the two coordinate pairs
have matching parity, then `a` and `b` are coprime. -/
theorem pellFixedFiveResidual_isCoprime_of_cross_and_parity
    (a b c d : ℤ)
    (hcross : a * c + b * d = 2)
    (had : a ≡ d [ZMOD 2])
    (hbc : b ≡ c [ZMOD 2]) :
    IsCoprime a b := by
  apply Int.isCoprime_iff_gcd_eq_one.mpr
  have hgDvd : Int.gcd a b ∣ 2 := by
    apply Int.gcd_dvd_iff.mpr
    refine ⟨c, d, ?_⟩
    norm_num
    exact hcross.symm
  have hgLe : Int.gcd a b ≤ 2 :=
    Nat.le_of_dvd (by norm_num) hgDvd
  have habNe : a ≠ 0 ∨ b ≠ 0 := by
    by_cases ha : a = 0
    · right
      intro hb
      rw [ha, hb] at hcross
      norm_num at hcross
    · exact Or.inl ha
  have hgPos : 0 < Int.gcd a b := by
    rcases habNe with ha | hb
    · exact Int.gcd_pos_of_ne_zero_left b ha
    · exact Int.gcd_pos_of_ne_zero_right a hb
  rcases (show Int.gcd a b = 1 ∨ Int.gcd a b = 2 by omega) with hgOne | hgTwo
  · exact hgOne
  · exfalso
    have haDvd : (2 : ℤ) ∣ a := by
      have h := Int.gcd_dvd_left a b
      simpa [hgTwo] using h
    have hbDvd : (2 : ℤ) ∣ b := by
      have h := Int.gcd_dvd_right a b
      simpa [hgTwo] using h
    have hdDvd : (2 : ℤ) ∣ d := by
      apply Int.modEq_zero_iff_dvd.mp
      exact had.symm.trans (Int.modEq_zero_iff_dvd.mpr haDvd)
    have hcDvd : (2 : ℤ) ∣ c := by
      apply Int.modEq_zero_iff_dvd.mp
      exact hbc.symm.trans (Int.modEq_zero_iff_dvd.mpr hbDvd)
    rcases haDvd with ⟨a0, ha0⟩
    rcases hbDvd with ⟨b0, hb0⟩
    rcases hcDvd with ⟨c0, hc0⟩
    rcases hdDvd with ⟨d0, hd0⟩
    rw [ha0, hb0, hc0, hd0] at hcross
    ring_nf at hcross
    omega

/-- Under the two integral-coordinate parity conditions, the cross
coordinates `s` and `v` are coprime. -/
theorem pellFixedFiveResidual_isCoprime_s_v
    (r s u v : ℤ)
    (hcross : r * v + s * u = 2)
    (hrs : r ≡ s [ZMOD 2])
    (huv : u ≡ v [ZMOD 2]) :
    IsCoprime s v := by
  apply pellFixedFiveResidual_isCoprime_of_cross_and_parity s v u r
  · simpa [add_comm, mul_comm] using hcross
  · exact hrs.symm
  · exact huv.symm

/-- Under the same parity conditions, the other cross-coordinate pair
`r,u` is coprime as well. -/
theorem pellFixedFiveResidual_isCoprime_r_u
    (r s u v : ℤ)
    (hcross : r * v + s * u = 2)
    (hrs : r ≡ s [ZMOD 2])
    (huv : u ≡ v [ZMOD 2]) :
    IsCoprime r u := by
  apply pellFixedFiveResidual_isCoprime_of_cross_and_parity r u v s
  · simpa [mul_comm] using hcross
  · exact hrs
  · exact huv

/-- Each same-factor coordinate gcd divides the cross coefficient `2`.
The result is stated as divisibility because it is sharper than a bound. -/
theorem pellFixedFiveResidual_sameFactorGcds_dvd_two
    (r s u v : ℤ)
    (hcross : r * v + s * u = 2) :
    Int.gcd r s ∣ 2 ∧ Int.gcd u v ∣ 2 := by
  constructor
  · apply Int.gcd_dvd_iff.mpr
    refine ⟨v, u, ?_⟩
    norm_num
    exact hcross.symm
  · apply Int.gcd_dvd_iff.mpr
    refine ⟨s, r, ?_⟩
    norm_num
    nlinarith [hcross]

/-- Consequently the two same-factor positive gcds are at most two. -/
theorem pellFixedFiveResidual_sameFactorGcds_le_two
    (r s u v : ℤ)
    (hcross : r * v + s * u = 2) :
    Int.gcd r s ≤ 2 ∧ Int.gcd u v ≤ 2 := by
  rcases pellFixedFiveResidual_sameFactorGcds_dvd_two
    r s u v hcross with ⟨hrs, huv⟩
  exact ⟨Nat.le_of_dvd (by norm_num) hrs,
    Nat.le_of_dvd (by norm_num) huv⟩

/-! ## Pointwise floor-reduction kernel -/

/-- In the sign-normalized natural-coordinate residual, the reduced first
factor forces the rational coordinate below `2*X`.  The assumptions are
entirely pointwise and contain no uniformity assertion. -/
theorem pellFixedFiveResidual_pointwise_r_lt_two_mul_X
    (X r a : ℕ)
    (ha : 1 ≤ a)
    (haX : a ^ 2 < X)
    (hr : r ^ 2 = 4 * X + 5 * a ^ 2) :
    r < 2 * X := by
  have hXtwo : 2 ≤ X := by nlinarith
  have haSq : a ^ 2 + 1 ≤ X := by omega
  have hrSq : r ^ 2 + 5 ≤ 9 * X := by nlinarith [hr, haSq]
  by_contra hbound
  have hle : 2 * X ≤ r := Nat.le_of_not_gt hbound
  have hsq : (2 * X) ^ 2 ≤ r ^ 2 := Nat.pow_le_pow_left hle 2
  rcases (show X = 2 ∨ 3 ≤ X by omega) with hX | hX
  · subst X
    norm_num at hrSq hsq
    omega
  · have hXX : 3 * X ≤ X ^ 2 := by
      simpa [pow_two, mul_comm] using Nat.mul_le_mul_right X hX
    nlinarith [hrSq, hsq, hXX]

/-- The exact integer sandwich underlying the pointwise floor formula.
Here `a=s` and `b=-v` in the sign-normalized residual. -/
theorem pellFixedFiveResidual_pointwiseFloorSandwich
    (X H r a b : ℕ)
    (ha : 1 ≤ a)
    (haX : a ^ 2 < X)
    (hr : r ^ 2 = 4 * X + 5 * a ^ 2)
    (hcoordinate : a ^ 2 * H = X * b ^ 2 + r * b + 1) :
    X * b ^ 2 < a ^ 2 * H ∧
      a ^ 2 * H < X * (b + 1) ^ 2 := by
  have hXtwo : 2 ≤ X := by nlinarith
  have hrBound : r < 2 * X :=
    pellFixedFiveResidual_pointwise_r_lt_two_mul_X X r a ha haX hr
  have hrStep : r + 1 ≤ 2 * X := by omega
  have hmul : (r + 1) * b ≤ (2 * X) * b :=
    Nat.mul_le_mul_right b hrStep
  constructor <;> nlinarith [hcoordinate, hmul]

/-- The integer sandwich gives the strict real interval whose natural floor
is `b`.  No extra positivity hypothesis on `H` is needed: natural-number
nonnegativity and `X > 0` make the square-root argument nonnegative. -/
theorem pellFixedFiveResidual_pointwiseSqrtInterval
    (X H r a b : ℕ)
    (ha : 1 ≤ a)
    (haX : a ^ 2 < X)
    (hr : r ^ 2 = 4 * X + 5 * a ^ 2)
    (hcoordinate : a ^ 2 * H = X * b ^ 2 + r * b + 1) :
    (b : ℝ) < (a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ)) ∧
      (a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ)) < (b : ℝ) + 1 := by
  have hsandwich := pellFixedFiveResidual_pointwiseFloorSandwich
    X H r a b ha haX hr hcoordinate
  have hXposNat : 0 < X := by nlinarith
  have hXpos : (0 : ℝ) < (X : ℝ) := by exact_mod_cast hXposNat
  have hradicand : 0 ≤ (H : ℝ) / (X : ℝ) :=
    div_nonneg (Nat.cast_nonneg H) hXpos.le
  let z : ℝ := (a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ))
  have hzNonneg : 0 ≤ z := by
    dsimp [z]
    positivity
  have hzSq : z ^ 2 =
      (a : ℝ) ^ 2 * ((H : ℝ) / (X : ℝ)) := by
    dsimp [z]
    rw [mul_pow, Real.sq_sqrt hradicand]
  have hlowerReal :
      (X : ℝ) * (b : ℝ) ^ 2 < (a : ℝ) ^ 2 * (H : ℝ) := by
    exact_mod_cast hsandwich.1
  have hupperReal :
      (a : ℝ) ^ 2 * (H : ℝ) <
        (X : ℝ) * ((b : ℝ) + 1) ^ 2 := by
    exact_mod_cast hsandwich.2
  have hlowerSq :
      (b : ℝ) ^ 2 <
        (a : ℝ) ^ 2 * ((H : ℝ) / (X : ℝ)) := by
    calc
      (b : ℝ) ^ 2 <
          ((a : ℝ) ^ 2 * (H : ℝ)) / (X : ℝ) := by
        apply (lt_div_iff₀ hXpos).2
        simpa [mul_comm] using hlowerReal
      _ = (a : ℝ) ^ 2 * ((H : ℝ) / (X : ℝ)) := by ring
  have hupperSq :
      (a : ℝ) ^ 2 * ((H : ℝ) / (X : ℝ)) <
        ((b : ℝ) + 1) ^ 2 := by
    calc
      (a : ℝ) ^ 2 * ((H : ℝ) / (X : ℝ)) =
          ((a : ℝ) ^ 2 * (H : ℝ)) / (X : ℝ) := by ring
      _ < ((b : ℝ) + 1) ^ 2 := by
        apply (div_lt_iff₀ hXpos).2
        simpa [mul_comm] using hupperReal
  have hlowerZSq : (b : ℝ) ^ 2 < z ^ 2 := by
    rw [hzSq]
    exact hlowerSq
  have hupperZSq : z ^ 2 < ((b : ℝ) + 1) ^ 2 := by
    rw [hzSq]
    exact hupperSq
  have hlowerZ : (b : ℝ) < z :=
    (sq_lt_sq₀ (Nat.cast_nonneg b) hzNonneg).mp hlowerZSq
  have hupperZ : z < (b : ℝ) + 1 :=
    (sq_lt_sq₀ hzNonneg (by positivity)).mp hupperZSq
  simpa [z] using And.intro hlowerZ hupperZ

/-- Exact pointwise natural-floor identity for the reduced fixed-five
residual. -/
theorem pellFixedFiveResidual_pointwiseNatFloor
    (X H r a b : ℕ)
    (ha : 1 ≤ a)
    (haX : a ^ 2 < X)
    (hr : r ^ 2 = 4 * X + 5 * a ^ 2)
    (hcoordinate : a ^ 2 * H = X * b ^ 2 + r * b + 1) :
    ⌊(a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ))⌋₊ = b := by
  have hinterval := pellFixedFiveResidual_pointwiseSqrtInterval
    X H r a b ha haX hr hcoordinate
  have hnonneg :
      0 ≤ (a : ℝ) * Real.sqrt ((H : ℝ) / (X : ℝ)) := by
    positivity
  apply (Nat.floor_eq_iff hnonneg).2
  exact ⟨hinterval.1.le, hinterval.2⟩

#print axioms pellFixedFiveResidual_scaledElimination
#print axioms pellFixedFiveResidual_mixedCoordinateIdentities
#print axioms pellFixedFiveResidual_mixedCoordinate_su
#print axioms pellFixedFiveResidual_mixedCoordinate_rv
#print axioms pellFixedFiveResidual_X_mul_v_sq_mod_s
#print axioms pellFixedFiveResidual_H_mul_s_sq_mod_v
#print axioms pellFixedFiveResidual_isCoprime_s_X
#print axioms pellFixedFiveResidual_isCoprime_v_H
#print axioms pellFixedFiveResidual_isCoprime_of_cross_and_parity
#print axioms pellFixedFiveResidual_isCoprime_s_v
#print axioms pellFixedFiveResidual_isCoprime_r_u
#print axioms pellFixedFiveResidual_sameFactorGcds_dvd_two
#print axioms pellFixedFiveResidual_sameFactorGcds_le_two
#print axioms pellFixedFiveResidual_pointwise_r_lt_two_mul_X
#print axioms pellFixedFiveResidual_pointwiseFloorSandwich
#print axioms pellFixedFiveResidual_pointwiseSqrtInterval
#print axioms pellFixedFiveResidual_pointwiseNatFloor

end IUTThreeClosures
