/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyModifiedSzpiroRoute

/-!
# The three displayed rational two-quotients of the Frey curve

The positive primitive Frey model

`y² = x(x-a)(x+b)`

has three nonzero rational two-torsion points, at `x=0`, `x=a`, and `x=-b`.
The quotient model for the first point was computed previously.  This file
computes the other two displayed models and proves that the first quotient
already has the largest absolute discriminant of the three.

It also proves the exact product of the three discriminants and a numerical
endpoint obstruction: even the maximum of the original model and all three
displayed quotients has only fifth-power growth.  No actual isogeny object,
minimal discriminant, Neron conductor, modular parametrization, Faltings
height, Szpiro estimate, or abc statement occurs here.
-/

namespace IUTThreeClosures

open WeierstrassCurve

/-! ## Quotient model attached to the point `x=a` -/

/-- Integral displayed quotient after translating `x=a` to the origin. -/
def abcFreyAtAQuotientCurveZ (P : ABCPoint) : WeierstrassCurve ℤ where
  a₁ := 0
  a₂ := -2 * ((P.a : ℤ) + P.c)
  a₃ := 0
  a₄ := (P.b : ℤ) ^ 2
  a₆ := 0

/-- Rational version of the displayed `x=a` quotient model. -/
def abcFreyAtAQuotientCurve (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 0
  a₂ := -2 * ((P.a : ℚ) + P.c)
  a₃ := 0
  a₄ := (P.b : ℚ) ^ 2
  a₆ := 0

@[simp] theorem abcFreyAtAQuotientZ_b₂ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).b₂ =
      -8 * ((P.a : ℤ) + P.c) := by
  simp [abcFreyAtAQuotientCurveZ, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyAtAQuotientZ_b₄ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).b₄ = 2 * (P.b : ℤ) ^ 2 := by
  simp [abcFreyAtAQuotientCurveZ, WeierstrassCurve.b₄]

@[simp] theorem abcFreyAtAQuotientZ_b₆ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).b₆ = 0 := by
  simp [abcFreyAtAQuotientCurveZ, WeierstrassCurve.b₆]

@[simp] theorem abcFreyAtAQuotientZ_b₈ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).b₈ = -(P.b : ℤ) ^ 4 := by
  simp [abcFreyAtAQuotientCurveZ, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyAtAQuotientZ_c₄ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).c₄ =
      16 * (16 * (P.a : ℤ) ^ 2 + 16 * P.a * P.b + (P.b : ℤ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyAtAQuotientZ_b₂,
    abcFreyAtAQuotientZ_b₄]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtAQuotientZ_Δ (P : ABCPoint) :
    (abcFreyAtAQuotientCurveZ P).Δ =
      256 * (P.a : ℤ) * P.c * (P.b : ℤ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyAtAQuotientZ_b₂,
    abcFreyAtAQuotientZ_b₄, abcFreyAtAQuotientZ_b₆,
    abcFreyAtAQuotientZ_b₈]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtAQuotient_b₂ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).b₂ =
      -8 * ((P.a : ℚ) + P.c) := by
  simp [abcFreyAtAQuotientCurve, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyAtAQuotient_b₄ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).b₄ = 2 * (P.b : ℚ) ^ 2 := by
  simp [abcFreyAtAQuotientCurve, WeierstrassCurve.b₄]

@[simp] theorem abcFreyAtAQuotient_b₆ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).b₆ = 0 := by
  simp [abcFreyAtAQuotientCurve, WeierstrassCurve.b₆]

@[simp] theorem abcFreyAtAQuotient_b₈ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).b₈ = -(P.b : ℚ) ^ 4 := by
  simp [abcFreyAtAQuotientCurve, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyAtAQuotient_c₄ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).c₄ =
      16 * (16 * (P.a : ℚ) ^ 2 + 16 * P.a * P.b + (P.b : ℚ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyAtAQuotient_b₂,
    abcFreyAtAQuotient_b₄]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtAQuotient_Δ (P : ABCPoint) :
    (abcFreyAtAQuotientCurve P).Δ =
      256 * (P.a : ℚ) * P.c * (P.b : ℚ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyAtAQuotient_b₂,
    abcFreyAtAQuotient_b₄, abcFreyAtAQuotient_b₆,
    abcFreyAtAQuotient_b₈]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

/-! ## Quotient model attached to the point `x=-b` -/

/-- Integral displayed quotient after translating `x=-b` to the origin. -/
def abcFreyAtNegBQuotientCurveZ (P : ABCPoint) : WeierstrassCurve ℤ where
  a₁ := 0
  a₂ := 2 * ((P.b : ℤ) + P.c)
  a₃ := 0
  a₄ := (P.a : ℤ) ^ 2
  a₆ := 0

/-- Rational version of the displayed `x=-b` quotient model. -/
def abcFreyAtNegBQuotientCurve (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 0
  a₂ := 2 * ((P.b : ℚ) + P.c)
  a₃ := 0
  a₄ := (P.a : ℚ) ^ 2
  a₆ := 0

@[simp] theorem abcFreyAtNegBQuotientZ_b₂ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).b₂ =
      8 * ((P.b : ℤ) + P.c) := by
  simp [abcFreyAtNegBQuotientCurveZ, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyAtNegBQuotientZ_b₄ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).b₄ = 2 * (P.a : ℤ) ^ 2 := by
  simp [abcFreyAtNegBQuotientCurveZ, WeierstrassCurve.b₄]

@[simp] theorem abcFreyAtNegBQuotientZ_b₆ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).b₆ = 0 := by
  simp [abcFreyAtNegBQuotientCurveZ, WeierstrassCurve.b₆]

@[simp] theorem abcFreyAtNegBQuotientZ_b₈ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).b₈ = -(P.a : ℤ) ^ 4 := by
  simp [abcFreyAtNegBQuotientCurveZ, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyAtNegBQuotientZ_c₄ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).c₄ =
      16 * ((P.a : ℤ) ^ 2 + 16 * P.a * P.b + 16 * (P.b : ℤ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyAtNegBQuotientZ_b₂,
    abcFreyAtNegBQuotientZ_b₄]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtNegBQuotientZ_Δ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurveZ P).Δ =
      256 * (P.b : ℤ) * P.c * (P.a : ℤ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyAtNegBQuotientZ_b₂,
    abcFreyAtNegBQuotientZ_b₄, abcFreyAtNegBQuotientZ_b₆,
    abcFreyAtNegBQuotientZ_b₈]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtNegBQuotient_b₂ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).b₂ =
      8 * ((P.b : ℚ) + P.c) := by
  simp [abcFreyAtNegBQuotientCurve, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyAtNegBQuotient_b₄ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).b₄ = 2 * (P.a : ℚ) ^ 2 := by
  simp [abcFreyAtNegBQuotientCurve, WeierstrassCurve.b₄]

@[simp] theorem abcFreyAtNegBQuotient_b₆ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).b₆ = 0 := by
  simp [abcFreyAtNegBQuotientCurve, WeierstrassCurve.b₆]

@[simp] theorem abcFreyAtNegBQuotient_b₈ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).b₈ = -(P.a : ℚ) ^ 4 := by
  simp [abcFreyAtNegBQuotientCurve, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyAtNegBQuotient_c₄ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).c₄ =
      16 * ((P.a : ℚ) ^ 2 + 16 * P.a * P.b + 16 * (P.b : ℚ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyAtNegBQuotient_b₂,
    abcFreyAtNegBQuotient_b₄]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyAtNegBQuotient_Δ (P : ABCPoint) :
    (abcFreyAtNegBQuotientCurve P).Δ =
      256 * (P.b : ℚ) * P.c * (P.a : ℚ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyAtNegBQuotient_b₂,
    abcFreyAtNegBQuotient_b₄, abcFreyAtNegBQuotient_b₆,
    abcFreyAtNegBQuotient_b₈]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

namespace ABCPoint

/-! ## Exact absolute discriminants, product, and optimality -/

/-- Absolute discriminant of the displayed quotient attached to `x=a`. -/
def freyAtAQuotientDiscriminantNat (P : ABCPoint) : ℕ :=
  256 * P.a * P.c * P.b ^ 4

/-- Absolute discriminant of the displayed quotient attached to `x=-b`. -/
def freyAtNegBQuotientDiscriminantNat (P : ABCPoint) : ℕ :=
  256 * P.b * P.c * P.a ^ 4

theorem freyAtAQuotientDiscriminantNat_eq_natAbs (P : ABCPoint) :
    P.freyAtAQuotientDiscriminantNat =
      (abcFreyAtAQuotientCurveZ P).Δ.natAbs := by
  rw [abcFreyAtAQuotientZ_Δ]
  simp only [Int.natAbs_mul, Int.natAbs_pow, Int.natAbs_natCast]
  norm_num [freyAtAQuotientDiscriminantNat]

theorem freyAtNegBQuotientDiscriminantNat_eq_natAbs (P : ABCPoint) :
    P.freyAtNegBQuotientDiscriminantNat =
      (abcFreyAtNegBQuotientCurveZ P).Δ.natAbs := by
  rw [abcFreyAtNegBQuotientZ_Δ]
  simp only [Int.natAbs_mul, Int.natAbs_pow, Int.natAbs_natCast]
  norm_num [freyAtNegBQuotientDiscriminantNat]

/-- The quotient attached to `x=a` never has larger displayed absolute
discriminant than the quotient attached to `x=0`. -/
theorem freyAtAQuotientDiscriminantNat_le_zeroQuotient (P : ABCPoint) :
    P.freyAtAQuotientDiscriminantNat ≤
      P.freyTwoIsogenousDiscriminantNat := by
  have hpow : P.b ^ 3 ≤ P.c ^ 3 :=
    Nat.pow_le_pow_left (Nat.le_of_lt P.b_lt_c) 3
  have hmul := Nat.mul_le_mul_left (256 * P.a * P.b * P.c) hpow
  rw [freyAtAQuotientDiscriminantNat,
    freyTwoIsogenousDiscriminantNat]
  convert hmul using 1 <;> ring

/-- The quotient attached to `x=-b` never has larger displayed absolute
discriminant than the quotient attached to `x=0`. -/
theorem freyAtNegBQuotientDiscriminantNat_le_zeroQuotient (P : ABCPoint) :
    P.freyAtNegBQuotientDiscriminantNat ≤
      P.freyTwoIsogenousDiscriminantNat := by
  have hpow : P.a ^ 3 ≤ P.c ^ 3 :=
    Nat.pow_le_pow_left (Nat.le_of_lt P.a_lt_c) 3
  have hmul := Nat.mul_le_mul_left (256 * P.a * P.b * P.c) hpow
  rw [freyAtNegBQuotientDiscriminantNat,
    freyTwoIsogenousDiscriminantNat]
  convert hmul using 1 <;> ring

/-- Maximum of the three immediate displayed quotient discriminants. -/
def freyImmediateTwoQuotientDiscriminantMax (P : ABCPoint) : ℕ :=
  max P.freyTwoIsogenousDiscriminantNat
    (max P.freyAtAQuotientDiscriminantNat
      P.freyAtNegBQuotientDiscriminantNat)

/-- The existing `(0,0)` quotient is exactly the optimal immediate choice. -/
theorem freyImmediateTwoQuotientDiscriminantMax_eq_zeroQuotient
    (P : ABCPoint) :
    P.freyImmediateTwoQuotientDiscriminantMax =
      P.freyTwoIsogenousDiscriminantNat := by
  apply max_eq_left
  exact max_le P.freyAtAQuotientDiscriminantNat_le_zeroQuotient
    P.freyAtNegBQuotientDiscriminantNat_le_zeroQuotient

/-- Exact product of all three immediate displayed quotient discriminants. -/
theorem product_three_twoQuotientDiscriminants (P : ABCPoint) :
    P.freyTwoIsogenousDiscriminantNat *
        P.freyAtAQuotientDiscriminantNat *
        P.freyAtNegBQuotientDiscriminantNat =
      256 ^ 3 * (P.a * P.b * P.c) ^ 6 := by
  simp [freyTwoIsogenousDiscriminantNat,
    freyAtAQuotientDiscriminantNat,
    freyAtNegBQuotientDiscriminantNat]
  ring

end ABCPoint

/-! ## Numerical endpoint ceiling for all four displayed models -/

/-- Endpoint discriminant for the quotient attached to `x=a`. -/
def endpointAtAQuotientDiscriminantNat (c : ℕ) : ℕ :=
  256 * c * (c - 1) ^ 4

/-- Endpoint discriminant for the quotient attached to `x=-b`. -/
def endpointAtNegBQuotientDiscriminantNat (c : ℕ) : ℕ :=
  256 * (c - 1) * c

/-- Maximum of the original endpoint model and all three immediate displayed
quotient models. -/
def endpointFullTwoGraphDisplayedDiscriminantMax (c : ℕ) : ℕ :=
  max (endpointFreyDiscriminantNat c)
    (max (endpointTwoIsogenousDiscriminantNat c)
      (max (endpointAtAQuotientDiscriminantNat c)
        (endpointAtNegBQuotientDiscriminantNat c)))

theorem endpointAtAQuotientDiscriminantNat_le
    (c : ℕ) :
    endpointAtAQuotientDiscriminantNat c ≤ 256 * c ^ 5 := by
  unfold endpointAtAQuotientDiscriminantNat
  have hpow : (c - 1) ^ 4 ≤ c ^ 4 :=
    Nat.pow_le_pow_left (Nat.sub_le c 1) 4
  calc
    256 * c * (c - 1) ^ 4 ≤ 256 * c * c ^ 4 := by gcongr
    _ = 256 * c ^ 5 := by ring

theorem endpointAtNegBQuotientDiscriminantNat_le
    (c : ℕ) (hc : 0 < c) :
    endpointAtNegBQuotientDiscriminantNat c ≤ 256 * c ^ 5 := by
  unfold endpointAtNegBQuotientDiscriminantNat
  have hsub : c - 1 ≤ c := Nat.sub_le c 1
  have hc3 : 0 < c ^ 3 := pow_pos hc 3
  calc
    256 * (c - 1) * c ≤ 256 * c * c := by gcongr
    _ ≤ (256 * c * c) * c ^ 3 :=
      Nat.le_mul_of_pos_right _ hc3
    _ = 256 * c ^ 5 := by ring

theorem endpointFreyDiscriminantNat_le_two_fifty_six_c_pow_five
    (c : ℕ) (hc : 0 < c) :
    endpointFreyDiscriminantNat c ≤ 256 * c ^ 5 := by
  have hc4 : 0 < c ^ 4 := pow_pos hc 4
  calc
    endpointFreyDiscriminantNat c ≤ 16 * c ^ 4 :=
      endpointFreyDiscriminantNat_le c
    _ ≤ 256 * c ^ 4 :=
      Nat.mul_le_mul_right (c ^ 4) (by norm_num)
    _ ≤ (256 * c ^ 4) * c := Nat.le_mul_of_pos_right _ hc
    _ = 256 * c ^ 5 := by ring

/-- All four canonical displayed endpoint discriminants have at most
fifth-power growth. -/
theorem endpointFullTwoGraphDisplayedDiscriminantMax_le
    (c : ℕ) (hc : 0 < c) :
    endpointFullTwoGraphDisplayedDiscriminantMax c ≤ 256 * c ^ 5 := by
  apply max_le
  · exact endpointFreyDiscriminantNat_le_two_fifty_six_c_pow_five c hc
  · apply max_le
    · exact endpointTwoIsogenousDiscriminantNat_le c
    · exact max_le (endpointAtAQuotientDiscriminantNat_le c)
        (endpointAtNegBQuotientDiscriminantNat_le c hc)

/-- Strict numerical obstruction to every proposed uniform sixth-power
lower bound, even after optimizing over the original model and all three
canonical displayed rational two-quotients. -/
theorem no_uniform_c_pow_six_lower_for_endpointFullTwoGraph (K : ℕ) :
    let c := 256 * K + 2
    K * endpointFullTwoGraphDisplayedDiscriminantMax c < c ^ 6 := by
  dsimp
  let c := 256 * K + 2
  have hc : 0 < c := by simp [c]
  have hKc : 256 * K < c := by simp [c]
  calc
    K * endpointFullTwoGraphDisplayedDiscriminantMax c ≤
        K * (256 * c ^ 5) :=
      Nat.mul_le_mul_left K
        (endpointFullTwoGraphDisplayedDiscriminantMax_le c hc)
    _ = (256 * K) * c ^ 5 := by ring
    _ < c * c ^ 5 := Nat.mul_lt_mul_of_pos_right hKc (pow_pos hc 5)
    _ = c ^ 6 := by ring

end IUTThreeClosures
