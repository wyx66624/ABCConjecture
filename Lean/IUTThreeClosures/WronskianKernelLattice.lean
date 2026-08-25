/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian

/-!
# The nondegenerate kernel lattice behind the arithmetic Wronskian

This file isolates the honest geometry-of-numbers content of the free-weight
Wronskian route.  It proves an explicit two-coordinate minor construction and
the determinant identity satisfied after projecting derivative values to their
powerful-part quotients.

The normalized lower bound is deliberately a conclusion, not a stored target
estimate.  It shows that the first nondegenerate quotient direction already
has size at least `c / rad(abc)` in the relaxed powerful-part lattice.
-/

namespace IUTThreeClosures

/-! ## A completely explicit minor witness -/

/-- If the two rows `(Ai, Aj)` and `(Bi, Bj)` have a nonzero minor, then the
standard perpendicular vector is in the first kernel but not the second.  Its
sup norm is bounded linearly by the coefficients of the first row. -/
theorem twoCoordinateKernelWitness
    (Ai Aj Bi Bj : ℤ)
    (hminor : Bi * Aj - Bj * Ai ≠ 0) :
    ∃ xi xj : ℤ,
      Ai * xi + Aj * xj = 0 ∧
      Bi * xi + Bj * xj ≠ 0 ∧
      max xi.natAbs xj.natAbs ≤ max Ai.natAbs Aj.natAbs := by
  refine ⟨Aj, -Ai, ?_, ?_, ?_⟩
  · ring
  · simpa [sub_eq_add_neg] using hminor
  · simp [max_comm]

/-! ## The projected powerful-part lattice -/

/-- The determinant identity for

`A * x + B * y = C * z`,  `A * ra + B * rb = C * rc`.

In the abc application, `A,B,C` are the powerful parts and `ra,rb,rc` are
the three radicals. -/
theorem powerfulLatticeDeterminantIdentity
    (A B C ra rb rc : ℕ) (x y z : ℤ)
    (hsum : A * ra + B * rb = C * rc)
    (hcompat : (A : ℤ) * x + (B : ℤ) * y = (C : ℤ) * z) :
    (A : ℤ) * ((ra : ℤ) * y - (rb : ℤ) * x) =
      (C : ℤ) * ((rc : ℤ) * y - (rb : ℤ) * z) := by
  have hsumInt :
      (A : ℤ) * ra + (B : ℤ) * rb = (C : ℤ) * rc := by
    exact_mod_cast hsum
  linear_combination (y : ℤ) * hsumInt - (rb : ℤ) * hcompat

/-- Coprimality cancels `A` from the determinant identity.  Thus `C` divides
the Wronskian quotient `ra*y-rb*x`. -/
theorem powerfulLatticeC_dvd_wronskianQuotient
    (A B C ra rb rc : ℕ) (x y z : ℤ)
    (hsum : A * ra + B * rb = C * rc)
    (hcompat : (A : ℤ) * x + (B : ℤ) * y = (C : ℤ) * z)
    (hAC : Nat.Coprime A C) :
    (C : ℤ) ∣ (ra : ℤ) * y - (rb : ℤ) * x := by
  let q : ℤ := (ra : ℤ) * y - (rb : ℤ) * x
  have hid := powerfulLatticeDeterminantIdentity
    A B C ra rb rc x y z hsum hcompat
  have hdiv : (C : ℤ) ∣ (A : ℤ) * q := by
    refine ⟨(rc : ℤ) * y - (rb : ℤ) * z, ?_⟩
    exact hid
  exact hAC.isCoprime.symm.dvd_of_dvd_mul_left hdiv

/-- A compatible projected lattice point has a unique integral Wronskian
quotient `k`. -/
theorem exists_powerfulLatticeWronskianQuotient
    (A B C ra rb rc : ℕ) (x y z : ℤ)
    (hsum : A * ra + B * rb = C * rc)
    (hcompat : (A : ℤ) * x + (B : ℤ) * y = (C : ℤ) * z)
    (hAC : Nat.Coprime A C) :
    ∃ k : ℤ,
      (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k := by
  rcases powerfulLatticeC_dvd_wronskianQuotient
      A B C ra rb rc x y z hsum hcompat hAC with ⟨k, hk⟩
  exact ⟨k, by simpa [mul_comm] using hk⟩

/-! ## Exact normalized gap and its unavoidable lower bound -/

/-- Dividing the Wronskian quotient identity by the two positive radicals
gives an exact normalized gap. -/
theorem normalizedPowerfulLatticeGap
    (C ra rb : ℕ) (x y k : ℤ)
    (hra : 0 < ra) (hrb : 0 < rb)
    (hk : (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k) :
    (y : ℝ) / (rb : ℝ) - (x : ℝ) / (ra : ℝ) =
      (C : ℝ) * (k : ℝ) / ((ra : ℝ) * (rb : ℝ)) := by
  have hraReal : (ra : ℝ) ≠ 0 := by positivity
  have hrbReal : (rb : ℝ) ≠ 0 := by positivity
  have hkReal :
      (ra : ℝ) * (y : ℝ) - (rb : ℝ) * (x : ℝ) =
        (C : ℝ) * (k : ℝ) := by
    exact_mod_cast hk
  field_simp
  linear_combination hkReal

/-- The triangle inequality says that the normalized derivative cost is at
least the absolute determinant gap. -/
theorem normalizedPowerfulLatticeGap_le_cost
    (C ra rb : ℕ) (x y k : ℤ)
    (hra : 0 < ra) (hrb : 0 < rb)
    (hk : (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k) :
    (C : ℝ) * |(k : ℝ)| / ((ra : ℝ) * (rb : ℝ)) ≤
      |(x : ℝ)| / (ra : ℝ) + |(y : ℝ)| / (rb : ℝ) := by
  have hraReal : (0 : ℝ) < ra := by exact_mod_cast hra
  have hrbReal : (0 : ℝ) < rb := by exact_mod_cast hrb
  have hgap := normalizedPowerfulLatticeGap C ra rb x y k hra hrb hk
  have hCabs : |(C : ℝ)| = (C : ℝ) :=
    abs_of_nonneg (Nat.cast_nonneg C)
  have hraAbs : |(ra : ℝ)| = (ra : ℝ) := abs_of_pos hraReal
  have hrbAbs : |(rb : ℝ)| = (rb : ℝ) := abs_of_pos hrbReal
  calc
    (C : ℝ) * |(k : ℝ)| / ((ra : ℝ) * (rb : ℝ)) =
        |(C : ℝ) * (k : ℝ) /
          ((ra : ℝ) * (rb : ℝ))| := by
      rw [abs_div, abs_mul (C : ℝ) (k : ℝ),
        abs_mul (ra : ℝ) (rb : ℝ), hCabs, hraAbs, hrbAbs]
    _ = |(y : ℝ) / (rb : ℝ) - (x : ℝ) / (ra : ℝ)| := by
      rw [hgap]
    _ ≤ |(y : ℝ) / (rb : ℝ)| + |(x : ℝ) / (ra : ℝ)| :=
      abs_sub _ _
    _ = |(x : ℝ)| / (ra : ℝ) + |(y : ℝ)| / (rb : ℝ) := by
      rw [abs_div, abs_div, abs_of_pos hraReal, abs_of_pos hrbReal]
      ring

/-- On every nondegenerate quotient direction (`k != 0`), the normalized
cost is at least `C/(ra*rb)`, which is `c/rad(abc)` in the application. -/
theorem normalizedPowerfulLatticeNondegenerateLowerBound
    (C ra rb : ℕ) (x y k : ℤ)
    (hra : 0 < ra) (hrb : 0 < rb)
    (hk : (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k)
    (hk0 : k ≠ 0) :
    (C : ℝ) / ((ra : ℝ) * (rb : ℝ)) ≤
      |(x : ℝ)| / (ra : ℝ) + |(y : ℝ)| / (rb : ℝ) := by
  have hkOneInt : (1 : ℤ) ≤ |k| := Int.one_le_abs hk0
  have hkOne : (1 : ℝ) ≤ |(k : ℝ)| := by
    exact_mod_cast hkOneInt
  calc
    (C : ℝ) / ((ra : ℝ) * (rb : ℝ)) =
        (C : ℝ) * 1 / ((ra : ℝ) * (rb : ℝ)) := by ring
    _ ≤ (C : ℝ) * |(k : ℝ)| /
        ((ra : ℝ) * (rb : ℝ)) := by
      gcongr
    _ ≤ |(x : ℝ)| / (ra : ℝ) + |(y : ℝ)| / (rb : ℝ) :=
      normalizedPowerfulLatticeGap_le_cost C ra rb x y k hra hrb hk

/-- The determinant gap `C/(ra*rb)` is exactly the height-to-radical ratio
`(C*rc)/(ra*rb*rc)`. -/
theorem powerfulLatticeGap_eq_heightRadicalRatio
    (C ra rb rc : ℕ) (hra : 0 < ra) (hrb : 0 < rb) (hrc : 0 < rc) :
    (C : ℝ) / ((ra : ℝ) * (rb : ℝ)) =
      ((C * rc : ℕ) : ℝ) / ((ra * rb * rc : ℕ) : ℝ) := by
  have hraReal : (ra : ℝ) ≠ 0 := by positivity
  have hrbReal : (rb : ℝ) ≠ 0 := by positivity
  have hrcReal : (rc : ℝ) ≠ 0 := by positivity
  push_cast
  field_simp

/-- Rewriting the nondegenerate lower bound in the literal abc
height/radical form. -/
theorem normalizedPowerfulLatticeHeightRadicalLowerBound
    (C ra rb rc : ℕ) (x y k : ℤ)
    (hra : 0 < ra) (hrb : 0 < rb) (hrc : 0 < rc)
    (hk : (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k)
    (hk0 : k ≠ 0) :
    ((C * rc : ℕ) : ℝ) / ((ra * rb * rc : ℕ) : ℝ) ≤
      |(x : ℝ)| / (ra : ℝ) + |(y : ℝ)| / (rb : ℝ) := by
  rw [← powerfulLatticeGap_eq_heightRadicalRatio C ra rb rc hra hrb hrc]
  exact normalizedPowerfulLatticeNondegenerateLowerBound
    C ra rb x y k hra hrb hk hk0

/-- The line `(ra*t, rb*t, rc*t)` is always a degenerate compatible line.
It is the projected form of the derivative assignment `D(n)=n*t`. -/
theorem powerfulLatticeDegenerateLine
    (A B C ra rb rc : ℕ) (t : ℤ)
    (hsum : A * ra + B * rb = C * rc) :
    (A : ℤ) * ((ra : ℤ) * t) +
        (B : ℤ) * ((rb : ℤ) * t) =
      (C : ℤ) * ((rc : ℤ) * t) ∧
    (ra : ℤ) * ((rb : ℤ) * t) -
        (rb : ℤ) * ((ra : ℤ) * t) = 0 := by
  have hsumInt :
      (A : ℤ) * ra + (B : ℤ) * rb = (C : ℤ) * rc := by
    exact_mod_cast hsum
  constructor
  · calc
      (A : ℤ) * ((ra : ℤ) * t) +
          (B : ℤ) * ((rb : ℤ) * t) =
        ((A : ℤ) * ra + (B : ℤ) * rb) * t := by ring
      _ = ((C : ℤ) * rc) * t := by rw [hsumInt]
      _ = (C : ℤ) * ((rc : ℤ) * t) := by ring
  · ring

/-! ## An actual prime-weight obstruction family -/

/-- On a power of two, the free prime-weight derivative has its expected
single coefficient. -/
theorem weightedArithmeticDerivative_two_pow
    (x : ℕ → ℤ) (m : ℕ) (hm : m ≠ 0) :
    weightedArithmeticDerivative x (2 ^ m) =
      (((m * 2 ^ (m - 1) : ℕ) : ℤ) * x 2) := by
  classical
  unfold weightedArithmeticDerivative
  rw [Nat.primeFactors_prime_pow hm Nat.prime_two]
  simp only [Finset.sum_singleton,
    Nat.factorization_pow_self Nat.prime_two]
  rw [← Nat.pow_sub_one (x := 2) (a := m) (by norm_num) hm]
  push_cast
  ring

/-- In the Mersenne family `(1,2^m-1,2^m)`, compatibility and
nondegeneracy force the derivative numerator to contain the full coefficient
`m*2^(m-1)`. -/
theorem mersenneCompatibleDerivativeNatAbsLower
    (x : ℕ → ℤ) (m : ℕ) (hm : m ≠ 0)
    (hcompat : weightedArithmeticDerivative x (2 ^ m - 1) =
      weightedArithmeticDerivative x (2 ^ m))
    (hnonzero : weightedArithmeticDerivative x (2 ^ m - 1) ≠ 0) :
    m * 2 ^ (m - 1) ≤
      (weightedArithmeticDerivative x (2 ^ m - 1)).natAbs := by
  have hformula := weightedArithmeticDerivative_two_pow x m hm
  have hx : x 2 ≠ 0 := by
    intro hx0
    apply hnonzero
    rw [hcompat, hformula, hx0, mul_zero]
  rw [hcompat, hformula, Int.natAbs_mul, Int.natAbs_natCast]
  exact Nat.le_mul_of_pos_right _ (Int.natAbs_pos.mpr hx)

/-- The elementary real inequality converting the Mersenne coefficient lower
bound to a normalized cost strictly larger than `m/2`. -/
theorem mersenneCoefficientNormalizedLower
    (m N : ℕ) (hm : m ≠ 0)
    (hN : m * 2 ^ (m - 1) ≤ N) :
    (m : ℝ) / 2 < (N : ℝ) / (2 ^ m - 1 : ℕ) := by
  have hmPos : 0 < m := Nat.pos_of_ne_zero hm
  have hpow : 2 * 2 ^ (m - 1) = 2 ^ m := mul_pow_sub_one hm 2
  have hpowPos : 0 < 2 ^ m := by positivity
  have hsubLt : 2 ^ m - 1 < 2 ^ m := Nat.sub_lt hpowPos (by norm_num)
  have hstrictNat :
      m * (2 ^ m - 1) < 2 * (m * 2 ^ (m - 1)) := by
    calc
      m * (2 ^ m - 1) < m * 2 ^ m :=
        (Nat.mul_lt_mul_left hmPos).2 hsubLt
      _ = 2 * (m * 2 ^ (m - 1)) := by rw [← hpow]; ring
  have hbPosNat : 0 < 2 ^ m - 1 :=
    Nat.sub_pos_of_lt (Nat.one_lt_pow hm (by norm_num))
  have hbPos : (0 : ℝ) < (2 ^ m - 1 : ℕ) := by
    exact_mod_cast hbPosNat
  apply (div_lt_div_iff₀ (by norm_num : (0 : ℝ) < 2) hbPos).2
  have hstrictReal :
      (m : ℝ) * (2 ^ m - 1 : ℕ) <
        2 * ((m * 2 ^ (m - 1) : ℕ) : ℝ) := by
    exact_mod_cast hstrictNat
  have hNReal : ((m * 2 ^ (m - 1) : ℕ) : ℝ) ≤ N := by
    exact_mod_cast hN
  nlinarith

/-- Therefore every actual compatible nondegenerate prime-weight vector for
the Mersenne family has normalized derivative cost strictly larger than
`m/2`. -/
theorem mersenneCompatibleNormalizedDerivative_gt_half
    (x : ℕ → ℤ) (m : ℕ) (hm : m ≠ 0)
    (hcompat : weightedArithmeticDerivative x (2 ^ m - 1) =
      weightedArithmeticDerivative x (2 ^ m))
    (hnonzero : weightedArithmeticDerivative x (2 ^ m - 1) ≠ 0) :
    (m : ℝ) / 2 <
      ((weightedArithmeticDerivative x (2 ^ m - 1)).natAbs : ℝ) /
        (2 ^ m - 1 : ℕ) := by
  exact mersenneCoefficientNormalizedLower m _ hm
    (mersenneCompatibleDerivativeNatAbsLower x m hm hcompat hnonzero)

end IUTThreeClosures
