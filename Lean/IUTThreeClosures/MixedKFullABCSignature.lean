/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KFullABCThreshold

/-!
# Mixed k-full signatures and the Fermat--Catalan threshold

The homogeneous `k`-full route requires `k > 3`.  A stronger and more useful
form allows the three coordinates of an abc point to have different radical
exponents.  If

`rad(a)^ka ∣ a`, `rad(b)^kb ∣ b`, and `rad(c)^kc ∣ c`,

then, since `a,b ≤ c`,

`ka*kb*kc * conductor ≤ (kb*kc + ka*kc + ka*kb) * height`.

Thus the strict reciprocal-exponent condition

`1/ka + 1/kb + 1/kc < 1`

is exactly the coefficient-saving boundary.  In particular, an unbounded
primitive family with signature `(3,3,4)` would already disprove abc.  This is
strictly weaker than asking all three coordinates to be `4`-full and gives a
more focused successor to Nitaj's critical `(3,3,3)` construction.

No existence theorem for such a mixed family is asserted here.
-/

namespace IUTThreeClosures

/-- A primitive abc point with independently specified radical exponents on
its three coordinates. -/
structure MixedKFullABCPoint (ka kb kc : ℕ) where
  point : ABCPoint
  full_a : IsKFull ka point.a
  full_b : IsKFull kb point.b
  full_c : IsKFull kc point.c

namespace MixedKFullABCPoint

variable {ka kb kc : ℕ}

/-- The radical of the total product is bounded by the product of the three
coordinate radicals. -/
theorem radical_product_le (D : MixedKFullABCPoint ka kb kc) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      abcRadical D.point.a * abcRadical D.point.b *
        abcRadical D.point.c := by
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
        abcRadical (D.point.a * D.point.b) *
          abcRadical D.point.c :=
      abcRadical_mul_le_mul (D.point.a * D.point.b) D.point.c
    _ ≤ (abcRadical D.point.a * abcRadical D.point.b) *
          abcRadical D.point.c :=
      Nat.mul_le_mul_right _
        (abcRadical_mul_le_mul D.point.a D.point.b)

/-- One coordinate which is `k`-full contributes at most `height/k` to the
logarithmic radical budget.  The statement is kept without division so that
it also remains meaningful at `k = 0`. -/
theorem coordinate_exponent_mul_logRadical_le_height
    (P : ABCPoint) {k n : ℕ}
    (hfull : IsKFull k n)
    (hn : 0 < n)
    (hnc : n ≤ P.c) :
    (k : ℝ) * Real.log (abcRadical n : ℝ) ≤ P.height := by
  have hpowNat : abcRadical n ^ k ≤ n :=
    hfull.radical_pow_le hn
  have hpowC : abcRadical n ^ k ≤ P.c :=
    hpowNat.trans hnc
  have hRadPos : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hReal :
      (abcRadical n : ℝ) ^ k ≤ (P.c : ℝ) := by
    exact_mod_cast hpowC
  have hlog := Real.log_le_log (pow_pos hRadPos k) hReal
  rw [Real.log_pow, P.height_eq_log_c] at hlog
  simpa using hlog

/-- The three coordinate bounds specialized to the point's own entries. -/
theorem a_exponent_mul_logRadical_le_height
    (D : MixedKFullABCPoint ka kb kc) :
    (ka : ℝ) * Real.log (abcRadical D.point.a : ℝ) ≤
      D.point.height :=
  coordinate_exponent_mul_logRadical_le_height
    D.point D.full_a D.point.a_pos D.point.a_lt_c.le

theorem b_exponent_mul_logRadical_le_height
    (D : MixedKFullABCPoint ka kb kc) :
    (kb : ℝ) * Real.log (abcRadical D.point.b : ℝ) ≤
      D.point.height :=
  coordinate_exponent_mul_logRadical_le_height
    D.point D.full_b D.point.b_pos D.point.b_lt_c.le

theorem c_exponent_mul_logRadical_le_height
    (D : MixedKFullABCPoint ka kb kc) :
    (kc : ℝ) * Real.log (abcRadical D.point.c : ℝ) ≤
      D.point.height :=
  coordinate_exponent_mul_logRadical_le_height
    D.point D.full_c D.point.c_pos le_rfl

/-- The total conductor is at most the sum of the three coordinate radical
logs.  Pairwise coprimality would give equality, but submultiplicativity is
sufficient and keeps this lemma independent of an exact radical-product API. -/
theorem conductor_le_coordinate_log_sum
    (D : MixedKFullABCPoint ka kb kc) :
    D.point.conductor ≤
      Real.log (abcRadical D.point.a : ℝ) +
        Real.log (abcRadical D.point.b : ℝ) +
          Real.log (abcRadical D.point.c : ℝ) := by
  have hTotalPos :
      0 < (abcRadical
        (D.point.a * D.point.b * D.point.c) : ℝ) := by
    exact_mod_cast abcRadical_pos
      (D.point.a * D.point.b * D.point.c)
  have haPos : 0 < (abcRadical D.point.a : ℝ) := by
    exact_mod_cast abcRadical_pos D.point.a
  have hbPos : 0 < (abcRadical D.point.b : ℝ) := by
    exact_mod_cast abcRadical_pos D.point.b
  have hcPos : 0 < (abcRadical D.point.c : ℝ) := by
    exact_mod_cast abcRadical_pos D.point.c
  have hReal :
      (abcRadical
        (D.point.a * D.point.b * D.point.c) : ℝ) ≤
      (abcRadical D.point.a : ℝ) *
        (abcRadical D.point.b : ℝ) *
          (abcRadical D.point.c : ℝ) := by
    exact_mod_cast D.radical_product_le
  have hlog := Real.log_le_log hTotalPos hReal
  rw [Real.log_mul (mul_ne_zero haPos.ne' hbPos.ne') hcPos.ne',
    Real.log_mul haPos.ne' hbPos.ne'] at hlog
  simpa [ABCPoint.conductor, add_assoc] using hlog

/-- Exact mixed-signature slope inequality.  Its right coefficient divided by
its left coefficient is `1/ka + 1/kb + 1/kc` when the exponents are positive. -/
theorem mixed_exponent_mul_conductor_le
    (D : MixedKFullABCPoint ka kb kc) :
    ((ka : ℝ) * (kb : ℝ) * (kc : ℝ)) * D.point.conductor ≤
      ((kb : ℝ) * (kc : ℝ) +
        (ka : ℝ) * (kc : ℝ) +
          (ka : ℝ) * (kb : ℝ)) * D.point.height := by
  have hKnonneg :
      0 ≤ (ka : ℝ) * (kb : ℝ) * (kc : ℝ) := by positivity
  have hcond := mul_le_mul_of_nonneg_left
    D.conductor_le_coordinate_log_sum hKnonneg
  have ha := D.a_exponent_mul_logRadical_le_height
  have hb := D.b_exponent_mul_logRadical_le_height
  have hc := D.c_exponent_mul_logRadical_le_height
  have hwa :
      ((kb : ℝ) * (kc : ℝ)) *
          ((ka : ℝ) * Real.log (abcRadical D.point.a : ℝ)) ≤
        ((kb : ℝ) * (kc : ℝ)) * D.point.height :=
    mul_le_mul_of_nonneg_left ha (by positivity)
  have hwb :
      ((ka : ℝ) * (kc : ℝ)) *
          ((kb : ℝ) * Real.log (abcRadical D.point.b : ℝ)) ≤
        ((ka : ℝ) * (kc : ℝ)) * D.point.height :=
    mul_le_mul_of_nonneg_left hb (by positivity)
  have hwc :
      ((ka : ℝ) * (kb : ℝ)) *
          ((kc : ℝ) * Real.log (abcRadical D.point.c : ℝ)) ≤
        ((ka : ℝ) * (kb : ℝ)) * D.point.height :=
    mul_le_mul_of_nonneg_left hc (by positivity)
  calc
    ((ka : ℝ) * (kb : ℝ) * (kc : ℝ)) * D.point.conductor ≤
        ((ka : ℝ) * (kb : ℝ) * (kc : ℝ)) *
          (Real.log (abcRadical D.point.a : ℝ) +
            Real.log (abcRadical D.point.b : ℝ) +
              Real.log (abcRadical D.point.c : ℝ)) := hcond
    _ = ((kb : ℝ) * (kc : ℝ)) *
          ((ka : ℝ) * Real.log (abcRadical D.point.a : ℝ)) +
        ((ka : ℝ) * (kc : ℝ)) *
          ((kb : ℝ) * Real.log (abcRadical D.point.b : ℝ)) +
        ((ka : ℝ) * (kb : ℝ)) *
          ((kc : ℝ) * Real.log (abcRadical D.point.c : ℝ)) := by ring
    _ ≤ ((kb : ℝ) * (kc : ℝ)) * D.point.height +
        ((ka : ℝ) * (kc : ℝ)) * D.point.height +
        ((ka : ℝ) * (kb : ℝ)) * D.point.height :=
      add_le_add (add_le_add hwa hwb) hwc
    _ = ((kb : ℝ) * (kc : ℝ) +
        (ka : ℝ) * (kc : ℝ) +
          (ka : ℝ) * (kb : ℝ)) * D.point.height := by ring

/-- The first mixed strict signature: two `3`-full coordinates and one
`4`-full coordinate give conductor slope `11/12`. -/
theorem thirtySix_mul_conductor_le_thirtyThree_mul_height
    (D : MixedKFullABCPoint 3 3 4) :
    36 * D.point.conductor ≤ 33 * D.point.height := by
  simpa using D.mixed_exponent_mul_conductor_le

end MixedKFullABCPoint

/-- An unbounded primitive family of mixed signature `(3,3,4)` disproves the
abc conjecture.  The explicit epsilon `1/24` leaves a strict coefficient gap. -/
theorem not_abc_of_unbounded_threeThreeFourFullABC
    (D : ℕ → MixedKFullABCPoint 3 3 4)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ, C < (D n).point.height) :
    ¬ ABCConjecture := by
  intro hABC
  have hε : 0 < (1 / 24 : ℝ) := by norm_num
  rcases hABC (1 / 24 : ℝ) hε with ⟨C, hC⟩
  rcases hunbounded (max (24 * C) 1) with ⟨n, hn⟩
  let P : ABCPoint := (D n).point
  have hnC : 24 * C < P.height := by
    exact (lt_of_le_of_lt (le_max_left _ _) hn)
  have hnOne : 1 < P.height := by
    exact (lt_of_le_of_lt (le_max_right _ _) hn)
  have hABCRaw := hC
    P.a P.b P.c
    P.a_pos P.b_pos P.c_pos
    P.sum_eq P.pairwise_coprime
  have hABCPoint :
      P.height ≤ (1 + (1 / 24 : ℝ)) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hABCRaw
  have hSlope : 36 * P.conductor ≤ 33 * P.height := by
    simpa [P] using
      (D n).thirtySix_mul_conductor_le_thirtyThree_mul_height
  linarith

end IUTThreeClosures
