import IUTThreeClosures.FreyPellChebyshevIndexNineteenDyadicObstruction

/-!
# Prime-nineteen pure-field dyadic no-go: scalar companion

The accompanying exact Sage transcript and mathematical note reduce the
global pure-field square question by Capelli and prove that the entire target
dyadic congruence disc is locally soluble by strong Hensel.  This file checks
only the scalar identities, the rational coordinate normalization, the two
exceptional polynomial factorizations, and the finite arithmetic ledgers.  It
does not formalize number fields, Hensel's lemma, Capelli's theorem, or the
Galois action on the neutral cover.
-/

namespace IUTThreeClosures

/-- The scalar coordinate change behind
`(a/2)*(X-theta)=a^2+(X/2)*a+1`, with
`theta=-2*(a+a^{-1})`. -/
theorem pellChebyshevNineteen_pureFieldCoordinateIdentity
    (a X : ℚ) (ha : a ≠ 0) :
    (a / 2) * (X + 2 * (a + a⁻¹)) =
      a ^ 2 + (X / 2) * a + 1 := by
  field_simp
  ring

/-- The residual congruence `X=-4+96*k` becomes
`t=-2+48*k`, and `X=2*t`. -/
theorem pellChebyshevNineteen_targetDyadicParametrization (k : ℤ) :
    2 * (-2 + 48 * k) = -4 + 96 * k ∧
      (-2 + 48 * k) + 2 = 48 * k := by
  constructor <;> ring

/-- The strict valuation inequality needed by strong Hensel once
`v_2(t+2)=s>=2`. -/
theorem pellChebyshevNineteen_strongHenselValuationLedger
    (s : ℕ) (hs : 2 ≤ s) :
    2 * 19 < 19 * s + 1 := by
  omega

/-- On the actual congruence disc, `s>=4`, giving the copied valuations
`77 > 38`. -/
theorem pellChebyshevNineteen_targetHenselValuationLedger :
    19 * 4 + 1 = 77 ∧ 2 * 19 = 38 ∧ 38 < 77 := by
  norm_num

/-- The two visible pure-field fibres are elementary squares. -/
theorem pellChebyshevNineteen_visiblePureFieldFibres (a : ℚ) :
    a ^ 2 + 2 * a + 1 = (a + 1) ^ 2 ∧
      a ^ 2 - 2 * a + 1 = (a - 1) ^ 2 := by
  constructor <;> ring

/-- The cancelled Capelli polynomial at `t=2`. -/
theorem pellChebyshevNineteen_capelliExceptionalPlus (Z : ℤ) :
    (Z ^ 2 - 1) ^ 19 - 2 * (2 * Z + 2) ^ 19 =
      (Z + 1) ^ 19 * ((Z - 1) ^ 19 - 2 ^ 20) := by
  have hquad : Z ^ 2 - 1 = (Z - 1) * (Z + 1) := by ring
  have hlin : 2 * Z + 2 = 2 * (Z + 1) := by ring
  rw [hquad, hlin, mul_pow, mul_pow]
  rw [mul_sub]
  congr 1
  · exact mul_comm _ _
  · calc
      2 * (2 ^ 19 * (Z + 1) ^ 19) = (2 * 2 ^ 19) * (Z + 1) ^ 19 := by
        rw [mul_assoc]
      _ = 2 ^ 20 * (Z + 1) ^ 19 := by norm_num
      _ = (Z + 1) ^ 19 * 2 ^ 20 := by rw [mul_comm]

/-- The cancelled Capelli polynomial at `t=-2`. -/
theorem pellChebyshevNineteen_capelliExceptionalMinus (Z : ℤ) :
    (Z ^ 2 - 1) ^ 19 - 2 * (2 * Z - 2) ^ 19 =
      (Z - 1) ^ 19 * ((Z + 1) ^ 19 - 2 ^ 20) := by
  have hquad : Z ^ 2 - 1 = (Z - 1) * (Z + 1) := by ring
  have hlin : 2 * Z - 2 = 2 * (Z - 1) := by ring
  rw [hquad, hlin, mul_pow, mul_pow]
  rw [mul_sub]
  congr 1
  calc
    2 * (2 ^ 19 * (Z - 1) ^ 19) = (2 * 2 ^ 19) * (Z - 1) ^ 19 := by
      rw [mul_assoc]
    _ = 2 ^ 20 * (Z - 1) ^ 19 := by norm_num
    _ = (Z - 1) ^ 19 * 2 ^ 20 := by rw [mul_comm]

/-- Exact order ledger: two has multiplicative order eighteen modulo
nineteen.  It is enough to exclude the proper divisors `1, 2, 3, 6, 9` of
eighteen. -/
theorem pellChebyshevNineteen_twoOrderModuloNineteenLedger :
    (2 ^ 18 : ℕ) % 19 = 1 ∧
      (2 ^ 1 : ℕ) % 19 ≠ 1 ∧
      (2 ^ 2 : ℕ) % 19 ≠ 1 ∧
      (2 ^ 3 : ℕ) % 19 ≠ 1 ∧
      (2 ^ 6 : ℕ) % 19 ≠ 1 ∧
      (2 ^ 9 : ℕ) % 19 ≠ 1 := by
  norm_num

/-- Degree and Riemann--Hurwitz arithmetic for the full neutral cover. -/
theorem pellChebyshevNineteen_neutralCoverArithmeticLedger :
    2 ^ (2 * 9) = 262144 ∧
      1 + 2 ^ 18 * (9 - 1) = 2097153 := by
  norm_num

#print axioms pellChebyshevNineteen_pureFieldCoordinateIdentity
#print axioms pellChebyshevNineteen_targetDyadicParametrization
#print axioms pellChebyshevNineteen_strongHenselValuationLedger
#print axioms pellChebyshevNineteen_targetHenselValuationLedger
#print axioms pellChebyshevNineteen_visiblePureFieldFibres
#print axioms pellChebyshevNineteen_capelliExceptionalPlus
#print axioms pellChebyshevNineteen_capelliExceptionalMinus
#print axioms pellChebyshevNineteen_twoOrderModuloNineteenLedger
#print axioms pellChebyshevNineteen_neutralCoverArithmeticLedger

end IUTThreeClosures
