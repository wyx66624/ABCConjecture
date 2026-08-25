/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WronskianKernelLattice

/-!
# Multiple arithmetic derivations, exterior collapse, and the second energy layer

This file separates two facts which are easy to conflate.

* Taking several copies of the free prime-weight derivative does not create
  several independent avoiding directions.  Compatible derivative triples
  lie in a rank-two plane, their third exterior determinant vanishes, and a
  two-derivative minor still contains only one copy of the product of the
  three powerful parts.
* A genuinely second-order diagonal energy does retain two copies of the
  powerful part.  This is new local information, although no global abc
  estimate is assumed or obtained here.

The first section also records that compatibility modulo the powerful part of
`c` is already sufficient for the ordinary Wronskian argument.  Thus an
actual derivative value at `c` is not needed for that divisibility step.
-/

namespace IUTThreeClosures

/-! ## Modular compatibility is sufficient -/

/-- The exact equality `Da + Db = Dc` can be weakened to the congruence
`Da + Db = 0 mod pow(c)`.  This is the precise condition needed to acquire
the third powerful-part divisor of the Wronskian. -/
theorem powerfulProduct_dvd_arithmeticWronskian_of_modCompatibility
    (P : ABCPoint) (Da Db : ℤ)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hmod : (abcPowerfulPart P.c : ℤ) ∣ Da + Db) :
    ((abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c : ℕ) : ℤ) ∣
      arithmeticWronskian P Da Db := by
  exact powerfulProduct_dvd_arithmeticWronskian
    P Da Db (Da + Db) rfl hDa hDb hmod

/-- The height--radical consequence likewise requires only modular
compatibility. -/
theorem c_le_radical_mul_normalizedDerivative_of_modCompatibility
    (P : ABCPoint) (Da Db : ℤ)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hmod : (abcPowerfulPart P.c : ℤ) ∣ Da + Db)
    (hW : arithmeticWronskian P Da Db ≠ 0) :
    (P.c : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
      ((Da.natAbs : ℝ) / (P.a : ℝ) +
        (Db.natAbs : ℝ) / (P.b : ℝ)) := by
  exact c_le_radical_mul_normalizedDerivative
    P Da Db (Da + Db) rfl hDa hDb hmod hW

/-- Modular compatibility specialized to the concrete free prime-weight
derivative.  Weights on the prime support of `c` play no role in this
version. -/
theorem weightedArithmeticDerivative_abc_bound_of_modCompatibility
    (P : ABCPoint) (x : ℕ → ℤ)
    (hmod : (abcPowerfulPart P.c : ℤ) ∣
      weightedArithmeticDerivative x P.a +
        weightedArithmeticDerivative x P.b)
    (hW : arithmeticWronskian P
      (weightedArithmeticDerivative x P.a)
      (weightedArithmeticDerivative x P.b) ≠ 0) :
    (P.c : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) *
      (((weightedArithmeticDerivative x P.a).natAbs : ℝ) /
          (P.a : ℝ) +
        ((weightedArithmeticDerivative x P.b).natAbs : ℝ) /
          (P.b : ℝ)) := by
  exact c_le_radical_mul_normalizedDerivative_of_modCompatibility
    P (weightedArithmeticDerivative x P.a)
      (weightedArithmeticDerivative x P.b)
    (abcPowerfulPart_dvd_weightedArithmeticDerivative x P.a)
    (abcPowerfulPart_dvd_weightedArithmeticDerivative x P.b)
    hmod hW

/-! ## Two- and three-fold exterior algebra -/

/-- The alternating minor of two pairs of derivative values. -/
def derivativeValueExterior
    (Da₁ Db₁ Da₂ Db₂ : ℤ) : ℤ :=
  Da₁ * Db₂ - Db₁ * Da₂

/-- Two modularly compatible derivative pairs still acquire only one copy
of each powerful part in their exterior minor. -/
theorem powerfulProduct_dvd_derivativeValueExterior
    (P : ABCPoint) (Da₁ Db₁ Da₂ Db₂ : ℤ)
    (hDa₁ : (abcPowerfulPart P.a : ℤ) ∣ Da₁)
    (hDb₁ : (abcPowerfulPart P.b : ℤ) ∣ Db₁)
    (hDa₂ : (abcPowerfulPart P.a : ℤ) ∣ Da₂)
    (hDb₂ : (abcPowerfulPart P.b : ℤ) ∣ Db₂)
    (hmod₁ : (abcPowerfulPart P.c : ℤ) ∣ Da₁ + Db₁)
    (hmod₂ : (abcPowerfulPart P.c : ℤ) ∣ Da₂ + Db₂) :
    ((abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c : ℕ) : ℤ) ∣
      derivativeValueExterior Da₁ Db₁ Da₂ Db₂ := by
  have hqa : (abcPowerfulPart P.a : ℤ) ∣
      derivativeValueExterior Da₁ Db₁ Da₂ Db₂ := by
    unfold derivativeValueExterior
    exact dvd_sub (dvd_mul_of_dvd_left hDa₁ Db₂)
      (dvd_mul_of_dvd_right hDa₂ Db₁)
  have hqb : (abcPowerfulPart P.b : ℤ) ∣
      derivativeValueExterior Da₁ Db₁ Da₂ Db₂ := by
    unfold derivativeValueExterior
    exact dvd_sub (dvd_mul_of_dvd_right hDb₂ Da₁)
      (dvd_mul_of_dvd_left hDb₁ Da₂)
  have hqc : (abcPowerfulPart P.c : ℤ) ∣
      derivativeValueExterior Da₁ Db₁ Da₂ Db₂ := by
    have hid : derivativeValueExterior Da₁ Db₁ Da₂ Db₂ =
        Da₁ * (Da₂ + Db₂) - Da₂ * (Da₁ + Db₁) := by
      unfold derivativeValueExterior
      ring
    rw [hid]
    exact dvd_sub (dvd_mul_of_dvd_right hmod₂ Da₁)
      (dvd_mul_of_dvd_right hmod₁ Da₂)
  have habInt : IsCoprime (abcPowerfulPart P.a : ℤ)
      (abcPowerfulPart P.b : ℤ) :=
    P.coprime_powerfulPart_a_b.isCoprime
  have hab :
      (abcPowerfulPart P.a : ℤ) * abcPowerfulPart P.b ∣
        derivativeValueExterior Da₁ Db₁ Da₂ Db₂ :=
    habInt.mul_dvd hqa hqb
  have habcNat : Nat.Coprime
      (abcPowerfulPart P.a * abcPowerfulPart P.b)
      (abcPowerfulPart P.c) := by
    rw [Nat.coprime_mul_iff_left]
    exact ⟨P.coprime_powerfulPart_a_c,
      P.coprime_powerfulPart_b_c⟩
  have habcInt : IsCoprime
      ((abcPowerfulPart P.a * abcPowerfulPart P.b : ℕ) : ℤ)
      (abcPowerfulPart P.c : ℤ) := habcNat.isCoprime
  simpa only [Nat.cast_mul] using habcInt.mul_dvd hab hqc

/-- A nonzero two-derivative exterior minor dominates the same product of
powerful parts as a single Wronskian. -/
theorem powerfulProduct_le_natAbs_derivativeValueExterior
    (P : ABCPoint) (Da₁ Db₁ Da₂ Db₂ : ℤ)
    (hDa₁ : (abcPowerfulPart P.a : ℤ) ∣ Da₁)
    (hDb₁ : (abcPowerfulPart P.b : ℤ) ∣ Db₁)
    (hDa₂ : (abcPowerfulPart P.a : ℤ) ∣ Da₂)
    (hDb₂ : (abcPowerfulPart P.b : ℤ) ∣ Db₂)
    (hmod₁ : (abcPowerfulPart P.c : ℤ) ∣ Da₁ + Db₁)
    (hmod₂ : (abcPowerfulPart P.c : ℤ) ∣ Da₂ + Db₂)
    (hminor : derivativeValueExterior Da₁ Db₁ Da₂ Db₂ ≠ 0) :
    abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c ≤
      (derivativeValueExterior Da₁ Db₁ Da₂ Db₂).natAbs := by
  exact Int.natAbs_le_of_dvd_ne_zero
    (powerfulProduct_dvd_derivativeValueExterior P
      Da₁ Db₁ Da₂ Db₂ hDa₁ hDb₁ hDa₂ hDb₂ hmod₁ hmod₂)
    hminor

/-- The two-derivative exterior is controlled by the two ordinary
Wronskians.  This is the explicit rank-one quotient identity. -/
theorem derivativeValueExterior_wronskianIdentity
    (P : ABCPoint) (Da₁ Db₁ Da₂ Db₂ : ℤ) :
    (P.a : ℤ) * derivativeValueExterior Da₁ Db₁ Da₂ Db₂ =
      Da₁ * arithmeticWronskian P Da₂ Db₂ -
        Da₂ * arithmeticWronskian P Da₁ Db₁ := by
  unfold derivativeValueExterior arithmeticWronskian
  ring

/-- For one compatible derivative triple, all three pairwise Wronskians are
the same transverse scalar up to orientation.  This is the literal
rank-one-normal statement behind the exterior obstruction. -/
theorem compatiblePairWronskians_rankOne
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hcompat : Da + Db = Dc) :
    (P.a : ℤ) * Dc - (P.c : ℤ) * Da =
        arithmeticWronskian P Da Db ∧
      (P.b : ℤ) * Dc - (P.c : ℤ) * Db =
        -arithmeticWronskian P Da Db := by
  have hsum : (P.a : ℤ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  constructor
  · rw [← hsum, ← hcompat]
    unfold arithmeticWronskian
    ring
  · rw [← hsum, ← hcompat]
    unfold arithmeticWronskian
    ring

/-- Expanded determinant of three value triples. -/
def threeValueDeterminant
    (a₁ b₁ c₁ a₂ b₂ c₂ a₃ b₃ c₃ : ℤ) : ℤ :=
  a₁ * (b₂ * c₃ - c₂ * b₃) -
    b₁ * (a₂ * c₃ - c₂ * a₃) +
      c₁ * (a₂ * b₃ - b₂ * a₃)

/-- Three compatible derivative triples have zero exterior volume: they all
lie in the plane `a+b=c`. -/
theorem threeValueDeterminant_eq_zero_of_compatible
    (a₁ b₁ c₁ a₂ b₂ c₂ a₃ b₃ c₃ : ℤ)
    (h₁ : a₁ + b₁ = c₁)
    (h₂ : a₂ + b₂ = c₂)
    (h₃ : a₃ + b₃ = c₃) :
    threeValueDeterminant a₁ b₁ c₁ a₂ b₂ c₂ a₃ b₃ c₃ = 0 := by
  subst c₁
  subst c₂
  subst c₃
  unfold threeValueDeterminant
  ring

/-! ## A genuinely second-order local energy -/

/-- Polarized diagonal energy of two prime-weight directions.  For equal
directions it is the sum of the valuation-weighted squares
`v_p(n) ((n/p) x_p)^2`. -/
def weightedArithmeticEnergy
    (x y : ℕ → ℤ) (n : ℕ) : ℤ :=
  ∑ p ∈ n.primeFactors,
    (n.factorization p : ℤ) *
      (((n / p : ℕ) : ℤ) * x p) *
      (((n / p : ℕ) : ℤ) * y p)

/-- The second energy is symmetric. -/
theorem weightedArithmeticEnergy_comm
    (x y : ℕ → ℤ) (n : ℕ) :
    weightedArithmeticEnergy x y n =
      weightedArithmeticEnergy y x n := by
  classical
  unfold weightedArithmeticEnergy
  apply Finset.sum_congr rfl
  intro p hp
  ring

/-- Diagonal energy is nonnegative. -/
theorem weightedArithmeticEnergy_self_nonneg
    (x : ℕ → ℤ) (n : ℕ) :
    0 ≤ weightedArithmeticEnergy x x n := by
  classical
  unfold weightedArithmeticEnergy
  apply Finset.sum_nonneg
  intro p hp
  calc
    0 ≤ (n.factorization p : ℤ) *
        ((((n / p : ℕ) : ℤ) * x p) ^ 2) :=
      mul_nonneg (by positivity) (sq_nonneg _)
    _ = (n.factorization p : ℤ) *
        (((n / p : ℕ) : ℤ) * x p) *
        (((n / p : ℕ) : ℤ) * x p) := by ring

/-- Unlike a first derivative, the second diagonal energy retains two copies
of the powerful part. -/
theorem abcPowerfulPart_sq_dvd_weightedArithmeticEnergy
    (x y : ℕ → ℤ) (n : ℕ) :
    (abcPowerfulPart n : ℤ) ^ 2 ∣
      weightedArithmeticEnergy x y n := by
  classical
  unfold weightedArithmeticEnergy
  apply Finset.dvd_sum
  intro p hp
  have hdivNat : abcPowerfulPart n ∣ n / p :=
    abcPowerfulPart_dvd_div_of_mem_primeFactors hp
  have hdivInt : (abcPowerfulPart n : ℤ) ∣
      ((n / p : ℕ) : ℤ) := by
    exact_mod_cast hdivNat
  rcases hdivInt with ⟨u, hu⟩
  refine ⟨(n.factorization p : ℤ) * (u * x p) * (u * y p), ?_⟩
  rw [hu]
  ring

/-- The alternating determinant of a two-direction energy matrix. -/
def weightedArithmeticEnergyExterior
    (x₁ x₂ : ℕ → ℤ) (n : ℕ) : ℤ :=
  weightedArithmeticEnergy x₁ x₁ n *
      weightedArithmeticEnergy x₂ x₂ n -
    weightedArithmeticEnergy x₁ x₂ n *
      weightedArithmeticEnergy x₂ x₁ n

/-- A two-direction energy determinant retains four copies of the powerful
part.  This is a local exterior statement; no cross-term relation among
`a,b,c` is asserted. -/
theorem abcPowerfulPart_fourth_dvd_weightedArithmeticEnergyExterior
    (x₁ x₂ : ℕ → ℤ) (n : ℕ) :
    (abcPowerfulPart n : ℤ) ^ 4 ∣
      weightedArithmeticEnergyExterior x₁ x₂ n := by
  rcases abcPowerfulPart_sq_dvd_weightedArithmeticEnergy x₁ x₁ n with
    ⟨u₁₁, hu₁₁⟩
  rcases abcPowerfulPart_sq_dvd_weightedArithmeticEnergy x₂ x₂ n with
    ⟨u₂₂, hu₂₂⟩
  rcases abcPowerfulPart_sq_dvd_weightedArithmeticEnergy x₁ x₂ n with
    ⟨u₁₂, hu₁₂⟩
  rcases abcPowerfulPart_sq_dvd_weightedArithmeticEnergy x₂ x₁ n with
    ⟨u₂₁, hu₂₁⟩
  refine ⟨u₁₁ * u₂₂ - u₁₂ * u₂₁, ?_⟩
  unfold weightedArithmeticEnergyExterior
  rw [hu₁₁, hu₂₂, hu₁₂, hu₂₁]
  ring

/-! ## Abstract second-jet identity -/

/-- The energy associated with a first derivative value `D` and a second
derivative value `H`.  For the prime-monomial Hessian this equals the concrete
diagonal energy above. -/
def arithmeticJetEnergy (n : ℕ) (D H : ℤ) : ℤ :=
  D ^ 2 - (n : ℤ) * H

/-- If both the first and second derivative values respect `a+b=c`, the
ordinary Wronskian square is an exact signed combination of the three local
jet energies.  This is the second-order analogue of the first Wronskian
identity; it is algebra, not an assumed estimate. -/
theorem secondJetWronskianIdentity
    (P : ABCPoint) (Da Db Dc Ha Hb Hc : ℤ)
    (hD : Da + Db = Dc)
    (hH : Ha + Hb = Hc) :
    (P.b : ℤ) * P.c * arithmeticJetEnergy P.a Da Ha +
        (P.a : ℤ) * P.c * arithmeticJetEnergy P.b Db Hb -
        (P.a : ℤ) * P.b * arithmeticJetEnergy P.c Dc Hc =
      arithmeticWronskian P Da Db ^ 2 := by
  have hsum : (P.a : ℤ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  unfold arithmeticJetEnergy arithmeticWronskian
  rw [← hsum, ← hD, ← hH]
  ring

end IUTThreeClosures
