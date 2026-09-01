/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJReducedData

/-!
# Elementary parts of the geometry uniformity continuation

The mathematical arguments were written first in
`research/GEOMETRY_UNIFORMITY_CONTINUATION_2026_08_30.md`.

This module checks logarithmic absorption, the scalar combination of
explicit height hypotheses, and the normalized Mordell point attached to
an actual primitive abc triple. Its weighted primitivity and the complete
factorization of its binary cubic use no external Diophantine estimate.

Pasten's approximation and small-generator theorems, the quadratic
regulator bound, and Bennett--Walsh are NOT declared as axioms. In
particular, supplied scalar height bounds below are explicit arguments,
not formal proofs of the external inputs in the mathematical report.
-/

namespace IUTThreeClosures

/-- A uniform elementary estimate used to absorb the logarithmic factor. -/
theorem geometry_log_le_half (t : ℝ) (ht : 0 < t) :
    Real.log t ≤ t / 2 := by
  have h := Real.log_le_sub_one_of_pos (div_pos ht (by norm_num : (0 : ℝ) < 2))
  rw [Real.log_div ht.ne' (by norm_num : (2 : ℝ) ≠ 0)] at h
  have htwo := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
  linarith

/-- Exact absorption of `X <= M log(3X)`. Neither parameter is allowed
to vanish; no unproved height statement is used. -/
theorem geometry_logAbsorption
    (X M : ℝ) (hX : 0 < X) (hM : 0 < M)
    (h : X ≤ M * Real.log (3 * X)) :
    X ≤ 2 * M * Real.log (3 * M) := by
  have ht : 0 < X / M := div_pos hX hM
  have hhalf := geometry_log_le_half (X / M) ht
  have hsplit : Real.log (3 * X) =
      Real.log (3 * M) + Real.log (X / M) := by
    rw [← Real.log_mul (by positivity : (3 : ℝ) * M ≠ 0) ht.ne']
    congr 1
    field_simp
  have hdiv : X / M ≤ Real.log (3 * X) :=
    (div_le_iff₀ hM).mpr (by simpa [mul_comm] using h)
  rw [hsplit] at hdiv
  have hbound : X / M ≤ 2 * Real.log (3 * M) := by linarith
  calc
    X = (X / M) * M := (div_mul_cancel₀ X hM.ne').symm
    _ ≤ (2 * Real.log (3 * M)) * M :=
      mul_le_mul_of_nonneg_right hbound hM.le
    _ = 2 * M * Real.log (3 * M) := by ring

/-- Combining the squared A-bound (four logarithmic powers) and the
squared B-bound (two) gives six powers, using exactly `D=3AB`.
The height bounds remain explicit hypotheses. -/
theorem geometry_jointSixthLogCorridor
    (H A B D KA KB L : ℝ) (hD : D = 3 * A * B)
    (hA : H ^ 2 ≤ KA * A * L ^ 4)
    (hB : H ^ 2 ≤ KB * B * L ^ 2) :
    3 * H ^ 4 ≤ KA * KB * D * L ^ 6 := by
  have hprod : H ^ 4 ≤ (KA * A * L ^ 4) * (KB * B * L ^ 2) := by
    calc
      H ^ 4 = H ^ 2 * H ^ 2 := by ring
      _ ≤ (KA * A * L ^ 4) * (KB * B * L ^ 2) :=
        mul_le_mul hA hB (sq_nonneg H) ((sq_nonneg H).trans hA)
  calc
    3 * H ^ 4 ≤ 3 * ((KA * A * L ^ 4) * (KB * B * L ^ 2)) :=
      mul_le_mul_of_nonneg_left hprod (by norm_num)
    _ = KA * KB * D * L ^ 6 := by rw [hD]; ring

/-- The integer norm-three element used before any analytic input. -/
theorem geometry_pellNormThree
    (b A u s : ℤ) (hA : b = A * u ^ 2) (hs : b + 3 = s ^ 2) :
    s ^ 2 - A * u ^ 2 = 3 := by
  nlinarith

/-- The fixed quadratic field contributes an actual norm-one unit. -/
theorem geometry_pellFixedNormOne
    (b r s : ℤ) (hr : b + 2 = 3 * r ^ 2) (hs : b + 3 = s ^ 2) :
    s ^ 2 - 3 * r ^ 2 = 1 := by
  nlinarith

/-- The chosen real embedding gives a strict approximation to one.
The nonnegative coordinates explicitly stand for `sqrt b`, `sqrt(b+2)`,
and `sqrt(b+3)`. The statement does not assume an abstract height model. -/
theorem geometry_normThreeRatioBounds
    (b u r s : ℝ) (hb : 0 < b)
    (hu : 0 ≤ u) (hr : 0 ≤ r) (hs : 0 ≤ s)
    (hu2 : u ^ 2 = b) (hr2 : r ^ 2 = b + 2) (hs2 : s ^ 2 = b + 3) :
    0 < (s + u) / (s + r) ∧ (s + u) / (s + r) < 1 ∧
      2 * b * (1 - (s + u) / (s + r)) < 1 := by
  have hup : 0 < u := by nlinarith
  have hur : u < r := by nlinarith
  have hus : u < s := by nlinarith
  have hden : 0 < s + r := by linarith
  have hpos : 0 < (s + u) / (s + r) := div_pos (by linarith) hden
  have hlt : (s + u) / (s + r) < 1 :=
    (div_lt_one hden).mpr (by linarith)
  refine ⟨hpos, hlt, ?_⟩
  have hgap : 1 - (s + u) / (s + r) = (r - u) / (s + r) := by
    field_simp
    ring
  have hidentity : (1 - (s + u) / (s + r)) * ((r + u) * (s + r)) = 2 := by
    rw [hgap]
    field_simp
    nlinarith [hu2, hr2]
  have hfirst : 2 * u < r + u := by linarith
  have hsecond : 2 * u < s + r := by linarith
  have hprod : (2 * u) * (2 * u) < (r + u) * (s + r) := by
    gcongr
  have hdenprod : 4 * b < (r + u) * (s + r) := by nlinarith [hprod, hu2]
  have hgapPos : 0 < 1 - (s + u) / (s + r) := by linarith
  have hweighted := mul_lt_mul_of_pos_right hdenprod hgapPos
  nlinarith [hidentity]

/-- Passing to the subgroup index, which is one or two, preserves
the strict approximation needed by the mathematical argument. -/
theorem geometry_indexTwoRatioBound
    (b γ : ℝ) (hb : 0 < b) (hγ0 : 0 < γ) (hγ1 : γ < 1)
    (hgap : 2 * b * (1 - γ) < 1)
    (N : ℕ) (hN0 : 1 ≤ N) (hN2 : N ≤ 2) :
    0 < γ ^ N ∧ γ ^ N < 1 ∧ b * (1 - γ ^ N) < 1 := by
  have hcases : N = 1 ∨ N = 2 := by omega
  rcases hcases with rfl | rfl
  · simp only [pow_one]
    refine ⟨hγ0, hγ1, ?_⟩
    nlinarith
  · have hsmall : γ ^ 2 < 1 := by nlinarith
    refine ⟨pow_pos hγ0 _, hsmall, ?_⟩
    have hpositive : 0 < b * (1 - γ) ^ 2 := mul_pos hb (sq_pos_of_pos (by linarith))
    nlinarith [hpositive]

/-- The cubic expression defining the normalized Frey y-coordinate. -/
def geometryFreyT (a b : ℤ) : ℤ :=
  (a - b) * (2 * a + b) * (a + 2 * b)

theorem geometry_two_dvd_product_add (a b : ℕ) :
    2 ∣ a * b * (a + b) := by
  have ha : a % 2 = 0 ∨ a % 2 = 1 := by omega
  have hb : b % 2 = 0 ∨ b % 2 = 1 := by omega
  rcases ha with ha | ha <;> rcases hb with hb | hb <;>
    simp [Nat.dvd_iff_mod_eq_zero, Nat.mul_mod, Nat.add_mod, ha, hb]

theorem geometry_two_dvd_freyT (a b : ℤ) :
    2 ∣ geometryFreyT a b := by
  have ha : a % 2 = 0 ∨ a % 2 = 1 := by omega
  have hb : b % 2 = 0 ∨ b % 2 = 1 := by omega
  rcases ha with ha | ha <;> rcases hb with hb | hb <;>
    simp [geometryFreyT, Int.dvd_iff_emod_eq_zero, Int.mul_emod,
      Int.add_emod, Int.sub_emod, ha, hb]

/-- Polynomial identity before dividing the even coordinates by two. -/
theorem geometry_freyMordellIdentity (a b : ℤ) :
    4 * (a ^ 2 + a * b + b ^ 2) ^ 3 - geometryFreyT a b ^ 2 =
      27 * (a * b * (a + b)) ^ 2 := by
  unfold geometryFreyT
  ring

/-- The actual binary cubic used in the Mordell-to-Thue construction is
completely split for the normalized Frey point. -/
theorem geometry_freySplitCubic (a b U V : ℤ) :
    U ^ 3 - 3 * (a ^ 2 + a * b + b ^ 2) * U * V ^ 2 +
        geometryFreyT a b * V ^ 3 =
      (U - (a - b) * V) * (U - (a + 2 * b) * V) *
        (U + (2 * a + b) * V) := by
  unfold geometryFreyT
  ring

/-- Coprimality makes an integral Mordell point with coefficient `-27m^2`
primitive for integer rescaling of weights two and three. -/
theorem geometry_weightedPrimitive
    (X m z : ℕ) (Y : ℤ) (hcop : Nat.Coprime X m)
    (heq : Y ^ 2 = (X : ℤ) ^ 3 - 27 * (m : ℤ) ^ 2)
    (hz : 0 < z) (hZX : z ^ 2 ∣ X) (hZY : (z : ℤ) ^ 3 ∣ Y) :
    z = 1 := by
  have hzx : z ∣ X := (show z ∣ z ^ 2 from ⟨z, by ring⟩).trans hZX
  have hcopzm : Nat.Coprime z m := hcop.of_dvd_left hzx
  have hcopPow : Nat.Coprime (z ^ 6) (m ^ 2) :=
    (hcopzm.pow_left 6).pow_right 2
  obtain ⟨q, hq⟩ := hZX
  obtain ⟨w, hw⟩ := hZY
  have hX : (X : ℤ) = (z : ℤ) ^ 2 * (q : ℤ) := by exact_mod_cast hq
  have hrel : 27 * (m : ℤ) ^ 2 =
      (z : ℤ) ^ 6 * ((q : ℤ) ^ 3 - w ^ 2) := by
    calc
      27 * (m : ℤ) ^ 2 = (X : ℤ) ^ 3 - Y ^ 2 := by linarith [heq]
      _ = (z : ℤ) ^ 6 * ((q : ℤ) ^ 3 - w ^ 2) := by rw [hX, hw]; ring
  have hdvdInt : (z : ℤ) ^ 6 ∣ 27 * (m : ℤ) ^ 2 := ⟨_, hrel⟩
  have hdvdNat : z ^ 6 ∣ 27 * m ^ 2 := by exact_mod_cast hdvdInt
  have hsmallDiv : z ^ 6 ∣ 27 := hcopPow.dvd_of_dvd_mul_right hdvdNat
  have hsmall : z ^ 6 ≤ 27 := Nat.le_of_dvd (by norm_num) hsmallDiv
  by_contra hne
  have hzTwo : 2 ≤ z := by omega
  have hlarge : 64 ≤ z ^ 6 := by
    calc
      64 = (2 : ℕ) ^ 6 := by norm_num
      _ ≤ z ^ 6 := by gcongr
  omega

namespace ABCPoint

/-- The positive integer `abc/2` of the actual primitive Frey triple. -/
def geometryFreyHalfProduct (P : ABCPoint) : ℕ :=
  (P.a * P.b * P.c) / 2

/-- The integral ordinate of the normalized Mordell point. -/
def geometryFreyY (P : ABCPoint) : ℤ :=
  geometryFreyT (P.a : ℤ) (P.b : ℤ) / 2

theorem geometryFrey_two_dvd_product (P : ABCPoint) :
    2 ∣ P.a * P.b * P.c := by
  rw [← P.sum_eq]
  exact geometry_two_dvd_product_add P.a P.b

theorem geometryFrey_two_mul_halfProduct (P : ABCPoint) :
    2 * P.geometryFreyHalfProduct = P.a * P.b * P.c := by
  simpa [geometryFreyHalfProduct, mul_comm] using
    Nat.div_mul_cancel P.geometryFrey_two_dvd_product

theorem geometryFreyHalfProduct_pos (P : ABCPoint) :
    0 < P.geometryFreyHalfProduct := by
  have hprod : 0 < P.a * P.b * P.c := mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos
  have htwo := P.geometryFrey_two_mul_halfProduct
  omega

theorem geometryFrey_two_mul_Y (P : ABCPoint) :
    2 * P.geometryFreyY = geometryFreyT (P.a : ℤ) (P.b : ℤ) := by
  simpa [geometryFreyY, mul_comm] using
    Int.ediv_mul_cancel (geometry_two_dvd_freyT (P.a : ℤ) (P.b : ℤ))

/-- The normalized point comes from the actual integral Frey invariants
by weights two and three with scaling parameter four. -/
theorem geometryFrey_invariantNormalization (P : ABCPoint) :
    (abcFreyCurveZ P).c₄ = 4 ^ 2 * (P.legendreCore : ℤ) ∧
      (abcFreyCurveZ P).c₆ = 4 ^ 3 * P.geometryFreyY := by
  constructor
  · norm_num
  · calc
      (abcFreyCurveZ P).c₆ = 32 * geometryFreyT (P.a : ℤ) (P.b : ℤ) := by
        rw [WeierstrassCurve.c₆, abcFreyZ_b₂, abcFreyZ_b₄, abcFreyZ_b₆]
        unfold geometryFreyT
        ring
      _ = 4 ^ 3 * P.geometryFreyY := by rw [← P.geometryFrey_two_mul_Y]; ring

theorem geometryFrey_core_coprime_halfProduct (P : ABCPoint) :
    Nat.Coprime P.legendreCore P.geometryFreyHalfProduct := by
  have hdiv : P.geometryFreyHalfProduct ∣ P.a * P.b * P.c :=
    ⟨2, by simpa [mul_comm] using P.geometryFrey_two_mul_halfProduct.symm⟩
  exact P.coprime_abc_legendreCore.symm.of_dvd_right hdiv

/-- A concrete integral Mordell point; no existence interface or
external Diophantine estimate is assumed. -/
theorem geometryFrey_normalizedMordellPoint (P : ABCPoint) :
    P.geometryFreyY ^ 2 = (P.legendreCore : ℤ) ^ 3 -
      27 * (P.geometryFreyHalfProduct : ℤ) ^ 2 := by
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  have hraw : 4 * (P.legendreCore : ℤ) ^ 3 -
      geometryFreyT (P.a : ℤ) (P.b : ℤ) ^ 2 =
        27 * ((P.a : ℤ) * P.b * P.c) ^ 2 := by
    simpa only [legendreCore, Nat.cast_add, Nat.cast_mul, Nat.cast_pow, hsum] using
      geometry_freyMordellIdentity (P.a : ℤ) (P.b : ℤ)
  have hm : 2 * (P.geometryFreyHalfProduct : ℤ) =
      (P.a : ℤ) * P.b * P.c := by exact_mod_cast P.geometryFrey_two_mul_halfProduct
  rw [← P.geometryFrey_two_mul_Y, ← hm] at hraw
  nlinarith [hraw]

/-- The weighted primitivity conclusion for the genuine Frey triple. -/
theorem geometryFrey_weightedPrimitive
    (P : ABCPoint) (z : ℕ) (hz : 0 < z)
    (hZX : z ^ 2 ∣ P.legendreCore)
    (hZY : (z : ℤ) ^ 3 ∣ P.geometryFreyY) : z = 1 :=
  geometry_weightedPrimitive P.legendreCore P.geometryFreyHalfProduct z
    P.geometryFreyY P.geometryFrey_core_coprime_halfProduct
    P.geometryFrey_normalizedMordellPoint hz hZX hZY

/-- Factorization of the binary cubic of this actual normalized point. -/
theorem geometryFrey_normalizedCubicSplit (P : ABCPoint) (U V : ℤ) :
    U ^ 3 - 3 * (P.legendreCore : ℤ) * U * V ^ 2 +
        2 * P.geometryFreyY * V ^ 3 =
      (U - ((P.a : ℤ) - P.b) * V) *
        (U - ((P.a : ℤ) + 2 * P.b) * V) *
        (U + (2 * (P.a : ℤ) + P.b) * V) := by
  rw [P.geometryFrey_two_mul_Y]
  simpa only [legendreCore, Nat.cast_add, Nat.cast_mul, Nat.cast_pow] using
    geometry_freySplitCubic (P.a : ℤ) (P.b : ℤ) U V

end ABCPoint

#print axioms geometry_logAbsorption
#print axioms geometry_jointSixthLogCorridor
#print axioms geometry_normThreeRatioBounds
#print axioms geometry_indexTwoRatioBound
#print axioms geometry_weightedPrimitive
#print axioms ABCPoint.geometryFrey_invariantNormalization
#print axioms ABCPoint.geometryFrey_normalizedMordellPoint
#print axioms ABCPoint.geometryFrey_weightedPrimitive
#print axioms ABCPoint.geometryFrey_normalizedCubicSplit

end IUTThreeClosures
