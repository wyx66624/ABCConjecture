/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WronskianKernelLattice
import IUTThreeClosures.ShearedFourFormArithmetic
import Mathlib.Algebra.GCDMonoid.Finset

/-!
# Polyrelational arithmetic Wronskians under fixed shears

For a primitive point `a+b=c`, this file studies simultaneous additive
compatibility for the relations

`a+b=c` and `u*a+(c-u*a)=c`.

When a weighted arithmetic derivative kills the fixed coefficient `u`, the
Leibniz rule turns compatibility for the second relation into
`u*D(a)+D(c-u*a)=D(c)`.  The powerful part of every positive remainder then
divides the *same* source Wronskian `a*D(c)-c*D(a)`.  A finite collection of
such divisors therefore contributes only their least common multiple.

The pairwise determinant formula below makes the rank-one collapse exact:
the Wronskian of two remainders is `(u-v)` times the source Wronskian.  Thus
fixed resultants control overlap, but the shears do not create independent
normal directions.

The final theorem gives a strict obstruction for the fixed shears `2,3`.
On an unbounded primitive family with remainders `2^(n+1),1`, imposing
`D(2)=D(3)=0` and both additive compatibilities forces the source Wronskian
to vanish.  No abc estimate or nondegenerate selector is assumed here.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## One common source Wronskian -/

/-- The Wronskian written in the two source coordinates `a,c`. -/
def sourceArithmeticWronskian (P : ABCPoint) (Da Dc : ℤ) : ℤ :=
  (P.a : ℤ) * Dc - (P.c : ℤ) * Da

/-- Compatibility for the original tripod identifies its usual Wronskian
with the source-coordinate Wronskian. -/
theorem arithmeticWronskian_eq_sourceArithmeticWronskian
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc) :
    arithmeticWronskian P Da Db =
      sourceArithmeticWronskian P Da Dc := by
  unfold arithmeticWronskian sourceArithmeticWronskian
  have hsum : (P.a : ℤ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  linear_combination (P.a : ℤ) * hadd - Da * hsum

/-- Hence the old product of three powerful parts divides the common source
Wronskian. -/
theorem powerfulProduct_dvd_sourceArithmeticWronskian
    (P : ABCPoint) (Da Db Dc : ℤ)
    (hadd : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc) :
    ((abcPowerfulPart P.a * abcPowerfulPart P.b *
        abcPowerfulPart P.c : ℕ) : ℤ) ∣
      sourceArithmeticWronskian P Da Dc := by
  rw [← arithmeticWronskian_eq_sourceArithmeticWronskian
    P Da Db Dc hadd]
  exact powerfulProduct_dvd_arithmeticWronskian
    P Da Db Dc hadd hDa hDb hDc

/-- For a positive shear relation `u*a+d=c`, additive compatibility writes
the same Wronskian as `a*D(d)-d*D(a)`. -/
theorem sourceArithmeticWronskian_eq_shear
    (P : ABCPoint) (u d : ℕ) (Da Dd Dc : ℤ)
    (hsum : u * P.a + d = P.c)
    (hadd : (u : ℤ) * Da + Dd = Dc) :
    sourceArithmeticWronskian P Da Dc =
      (P.a : ℤ) * Dd - (d : ℤ) * Da := by
  unfold sourceArithmeticWronskian
  have hsumInt : (u : ℤ) * P.a + d = P.c := by
    exact_mod_cast hsum
  have hDc : Dc = (u : ℤ) * Da + Dd := hadd.symm
  have hc : (P.c : ℤ) = (u : ℤ) * P.a + d := hsumInt.symm
  rw [hDc, hc]
  ring

/-- The powerful part of a new positive shear remainder divides the common
source Wronskian. -/
theorem shearPowerfulPart_dvd_sourceArithmeticWronskian
    (P : ABCPoint) (u d : ℕ) (Da Dd Dc : ℤ)
    (hsum : u * P.a + d = P.c)
    (hadd : (u : ℤ) * Da + Dd = Dc)
    (hDd : (abcPowerfulPart d : ℤ) ∣ Dd) :
    (abcPowerfulPart d : ℤ) ∣
      sourceArithmeticWronskian P Da Dc := by
  rw [sourceArithmeticWronskian_eq_shear P u d Da Dd Dc hsum hadd]
  have hd : (abcPowerfulPart d : ℤ) ∣ (d : ℤ) := by
    exact_mod_cast abcPowerfulPart_dvd d
  exact dvd_sub
    (dvd_mul_of_dvd_right hDd (P.a : ℤ))
    (dvd_mul_of_dvd_left hd Da)

/-! ## A finite family contributes one least common multiple -/

/-- The old powerful product together with all new remainder powerful parts,
combined by least common multiple. -/
def polyrelationalPowerfulLCM
    (P : ABCPoint) (U : Finset ℕ) (d : ℕ → ℕ) : ℕ :=
  Nat.lcm
    (abcPowerfulPart P.a * abcPowerfulPart P.b *
      abcPowerfulPart P.c)
    (U.lcm fun u ↦ abcPowerfulPart (d u))

/-- An integral divisor of an integer also divides its natural absolute
value after forgetting the cast. -/
theorem nat_dvd_natAbs_of_intCast_dvd
    {m : ℕ} {z : ℤ} (h : (m : ℤ) ∣ z) :
    m ∣ z.natAbs := by
  rcases h with ⟨k, rfl⟩
  refine ⟨k.natAbs, ?_⟩
  simp [Int.natAbs_mul]

/-- Simultaneous shear compatibilities make the finite LCM, rather than the
product of the new powerful parts, divide the one common Wronskian. -/
theorem polyrelationalPowerfulLCM_dvd_sourceWronskian_natAbs
    (P : ABCPoint) (U : Finset ℕ) (d : ℕ → ℕ)
    (Da Db Dc : ℤ) (Dd : ℕ → ℤ)
    (hbase : Da + Db = Dc)
    (hDa : (abcPowerfulPart P.a : ℤ) ∣ Da)
    (hDb : (abcPowerfulPart P.b : ℤ) ∣ Db)
    (hDc : (abcPowerfulPart P.c : ℤ) ∣ Dc)
    (hsum : ∀ u ∈ U, u * P.a + d u = P.c)
    (hshear : ∀ u ∈ U, (u : ℤ) * Da + Dd u = Dc)
    (hDd : ∀ u ∈ U, (abcPowerfulPart (d u) : ℤ) ∣ Dd u) :
    polyrelationalPowerfulLCM P U d ∣
      (sourceArithmeticWronskian P Da Dc).natAbs := by
  apply Nat.lcm_dvd
  · exact nat_dvd_natAbs_of_intCast_dvd
      (powerfulProduct_dvd_sourceArithmeticWronskian
        P Da Db Dc hbase hDa hDb hDc)
  · apply Finset.lcm_dvd
    intro u hu
    exact nat_dvd_natAbs_of_intCast_dvd
      (shearPowerfulPart_dvd_sourceArithmeticWronskian
        P u (d u) Da (Dd u) Dc (hsum u hu) (hshear u hu) (hDd u hu))

/-! ## Rank-one collapse and exact resultants -/

/-- The Wronskian between two compatible shear remainders is only a fixed
parameter difference times the source Wronskian. -/
theorem compatibleShearPairWronskian_rankOne
    (a c u v Da Du Dv Dc : ℤ)
    (hu : u * Da + Du = Dc)
    (hv : v * Da + Dv = Dc) :
    (c - v * a) * Du - (c - u * a) * Dv =
      (u - v) * (a * Dc - c * Da) := by
  linear_combination
    (c - v * a) * hu - (c - u * a) * hv

/-- A useful abstract conversion from an overlap/resultant bound to the
corresponding two-factor LCM estimate. -/
theorem product_le_resultant_mul_lcm
    (M E K : ℕ) (hoverlap : Nat.gcd M E ≤ K) :
    M * E ≤ K * Nat.lcm M E := by
  calc
    M * E = Nat.gcd M E * Nat.lcm M E :=
      (Nat.gcd_mul_lcm M E).symm
    _ ≤ K * Nat.lcm M E := Nat.mul_le_mul_right _ hoverlap

/-- Consequently a common LCM divisor of a nonzero integer gives the exact
resultant-loss inequality for two divisor packets. -/
theorem product_le_resultant_mul_natAbs_of_lcm_dvd
    (M E K : ℕ) (W : ℤ)
    (hoverlap : Nat.gcd M E ≤ K)
    (hW : W ≠ 0)
    (hlcm : Nat.lcm M E ∣ W.natAbs) :
    M * E ≤ K * W.natAbs := by
  exact (product_le_resultant_mul_lcm M E K hoverlap).trans
    (Nat.mul_le_mul_left K
      (Nat.le_of_dvd (Int.natAbs_pos.mpr hW) hlcm))

/-! ## The actual weighted derivative and a strict degeneracy family -/

/-- If the weighted derivative kills `u`, its Leibniz rule converts actual
compatibility for `u*a+d=c` into the scalar compatibility used above. -/
theorem weightedShearCompatibility_of_coefficient_zero
    (x : ℕ → ℤ) (u a d c : ℕ)
    (hu : u ≠ 0) (ha : a ≠ 0)
    (hDu : weightedArithmeticDerivative x u = 0)
    (hadd : weightedArithmeticDerivative x (u * a) +
      weightedArithmeticDerivative x d =
        weightedArithmeticDerivative x c) :
    (u : ℤ) * weightedArithmeticDerivative x a +
      weightedArithmeticDerivative x d =
        weightedArithmeticDerivative x c := by
  rw [weightedArithmeticDerivative_mul x hu ha] at hadd
  rw [hDu, mul_zero, add_zero] at hadd
  exact hadd

/-- A direct weighted-derivative specialization: the only hypotheses are
coefficient killing and additive compatibility for the displayed shear. -/
theorem weightedShearPowerfulPart_dvd_sourceArithmeticWronskian
    (P : ABCPoint) (x : ℕ → ℤ) (u : ℕ)
    (hu : u ≠ 0) (hua : u * P.a ≤ P.c)
    (hDu : weightedArithmeticDerivative x u = 0)
    (hadd : weightedArithmeticDerivative x (u * P.a) +
      weightedArithmeticDerivative x (P.c - u * P.a) =
        weightedArithmeticDerivative x P.c) :
    (abcPowerfulPart (P.c - u * P.a) : ℤ) ∣
      sourceArithmeticWronskian P
        (weightedArithmeticDerivative x P.a)
        (weightedArithmeticDerivative x P.c) := by
  apply shearPowerfulPart_dvd_sourceArithmeticWronskian P u
    (P.c - u * P.a)
    (weightedArithmeticDerivative x P.a)
    (weightedArithmeticDerivative x (P.c - u * P.a))
    (weightedArithmeticDerivative x P.c)
  · exact Nat.add_sub_of_le hua
  · exact weightedShearCompatibility_of_coefficient_zero
      x u P.a (P.c - u * P.a) P.c hu P.a_pos.ne' hDu hadd
  · exact abcPowerfulPart_dvd_weightedArithmeticDerivative x _

/-- The finite simultaneous specialization for the actual free prime-weight
derivative.  The hypotheses display every additive equation and every
coefficient-killing condition; no selector or height estimate is hidden. -/
theorem weightedPolyrelationalPowerfulLCM_dvd_sourceWronskian_natAbs
    (P : ABCPoint) (x : ℕ → ℤ) (U : Finset ℕ)
    (hbase : weightedArithmeticDerivative x P.a +
      weightedArithmeticDerivative x P.b =
        weightedArithmeticDerivative x P.c)
    (hu : ∀ u ∈ U, u ≠ 0)
    (hua : ∀ u ∈ U, u * P.a ≤ P.c)
    (hDu : ∀ u ∈ U, weightedArithmeticDerivative x u = 0)
    (hadd : ∀ u ∈ U,
      weightedArithmeticDerivative x (u * P.a) +
        weightedArithmeticDerivative x (P.c - u * P.a) =
          weightedArithmeticDerivative x P.c) :
    polyrelationalPowerfulLCM P U (fun u ↦ P.c - u * P.a) ∣
      (sourceArithmeticWronskian P
        (weightedArithmeticDerivative x P.a)
        (weightedArithmeticDerivative x P.c)).natAbs := by
  apply polyrelationalPowerfulLCM_dvd_sourceWronskian_natAbs
    P U (fun u ↦ P.c - u * P.a)
    (weightedArithmeticDerivative x P.a)
    (weightedArithmeticDerivative x P.b)
    (weightedArithmeticDerivative x P.c)
    (fun u ↦ weightedArithmeticDerivative x (P.c - u * P.a))
  · exact hbase
  · exact abcPowerfulPart_dvd_weightedArithmeticDerivative x _
  · exact abcPowerfulPart_dvd_weightedArithmeticDerivative x _
  · exact abcPowerfulPart_dvd_weightedArithmeticDerivative x _
  · intro u huU
    exact Nat.add_sub_of_le (hua u huU)
  · intro u huU
    exact weightedShearCompatibility_of_coefficient_zero
      x u P.a (P.c - u * P.a) P.c
      (hu u huU) P.a_pos.ne' (hDu u huU) (hadd u huU)
  · intro u _huU
    exact abcPowerfulPart_dvd_weightedArithmeticDerivative x _

/-- Killing the weight derivative at `2` kills it on every positive power of
`2`. -/
theorem weightedArithmeticDerivative_two_pow_eq_zero_of_two_eq_zero
    (x : ℕ → ℤ) (m : ℕ) (hm : m ≠ 0)
    (hDtwo : weightedArithmeticDerivative x 2 = 0) :
    weightedArithmeticDerivative x (2 ^ m) = 0 := by
  have htwo := weightedArithmeticDerivative_two_pow x 1 (by norm_num)
  have hx : x 2 = 0 := by
    simpa using htwo.symm.trans hDtwo
  rw [weightedArithmeticDerivative_two_pow x m hm, hx, mul_zero]

/-- On the unbounded adjacent-shear family with parameters `2,3`, requiring
`D(2)=D(3)=0` and both actual additive compatibilities forces the common
Wronskian to vanish.  This strictly refutes a universal nondegenerate
selector based only on imposing these fixed shear equations. -/
theorem adjacentTwoThreeShears_force_sourceWronskian_zero
    (x : ℕ → ℤ) (n : ℕ)
    (hDtwo : weightedArithmeticDerivative x 2 = 0)
    (hDthree : weightedArithmeticDerivative x 3 = 0)
    (haddTwo :
      weightedArithmeticDerivative x
          (2 * (adjacentShearPowerPoint 2 n).a) +
        weightedArithmeticDerivative x
          ((adjacentShearPowerPoint 2 n).c -
            2 * (adjacentShearPowerPoint 2 n).a) =
        weightedArithmeticDerivative x
          (adjacentShearPowerPoint 2 n).c)
    (haddThree :
      weightedArithmeticDerivative x
          (3 * (adjacentShearPowerPoint 2 n).a) +
        weightedArithmeticDerivative x
          ((adjacentShearPowerPoint 2 n).c -
            3 * (adjacentShearPowerPoint 2 n).a) =
        weightedArithmeticDerivative x
          (adjacentShearPowerPoint 2 n).c) :
    sourceArithmeticWronskian (adjacentShearPowerPoint 2 n)
      (weightedArithmeticDerivative x
        (adjacentShearPowerPoint 2 n).a)
      (weightedArithmeticDerivative x
        (adjacentShearPowerPoint 2 n).c) = 0 := by
  let P := adjacentShearPowerPoint 2 n
  let Da := weightedArithmeticDerivative x P.a
  let Dc := weightedArithmeticDerivative x P.c
  have hpow : weightedArithmeticDerivative x (2 ^ (n + 1)) = 0 :=
    weightedArithmeticDerivative_two_pow_eq_zero_of_two_eq_zero
      x (n + 1) (by omega) hDtwo
  have htwoCompat : (2 : ℤ) * Da = Dc := by
    have h := weightedShearCompatibility_of_coefficient_zero
      x 2 P.a (P.c - 2 * P.a) P.c (by norm_num) P.a_pos.ne'
      hDtwo haddTwo
    have hd : P.c - 2 * P.a = 2 ^ (n + 1) := by
      have hq : 1 < 2 ^ (n + 1) :=
        one_lt_pow₀ (by norm_num) (by omega)
      dsimp [P, adjacentShearPowerPoint]
      omega
    rw [hd, hpow, add_zero] at h
    exact h
  have hthreeCompat : (3 : ℤ) * Da = Dc := by
    have h := weightedShearCompatibility_of_coefficient_zero
      x 3 P.a (P.c - 3 * P.a) P.c (by norm_num) P.a_pos.ne'
      hDthree haddThree
    have hd : P.c - 3 * P.a = 1 := by
      have hq : 1 < 2 ^ (n + 1) :=
        one_lt_pow₀ (by norm_num) (by omega)
      dsimp [P, adjacentShearPowerPoint]
      omega
    have hOne : weightedArithmeticDerivative x 1 = 0 := by
      simp [weightedArithmeticDerivative]
    rw [hd, hOne, add_zero] at h
    exact h
  have hDa : Da = 0 := by linarith
  have hDc : Dc = 0 := by linarith
  unfold sourceArithmeticWronskian
  change (P.a : ℤ) * Dc - (P.c : ℤ) * Da = 0
  rw [hDa, hDc]
  ring

end IUTThreeClosures
