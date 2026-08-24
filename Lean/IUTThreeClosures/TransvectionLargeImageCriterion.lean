/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# A transvection-and-mover criterion for full `SL₂` image

For a field `F`, write

`U(x) = [[1,x],[0,1]]`,
`L(x) = [[1,0],[x,1]]`.

Every determinant-one matrix whose lower-left entry is nonzero has the exact
factorization

`A = U((a-1)/c) L(c) U((d-1)/c)`.

Over `ZMod p`, one nonzero upper transvection generates the complete upper
root subgroup. A determinant-one image element moving its fixed line isolates
a nonzero lower transvection, hence the complete lower root subgroup. The two
root subgroups contain every determinant-one matrix.
-/

namespace IUTThreeClosures

namespace TransvectionLargeImage

universe u

@[ext]
structure Matrix2 (F : Type u) where
  a : F
  b : F
  c : F
  d : F

namespace Matrix2

variable {F : Type u}

def mul [Semiring F] (A B : Matrix2 F) : Matrix2 F where
  a := A.a * B.a + A.b * B.c
  b := A.a * B.b + A.b * B.d
  c := A.c * B.a + A.d * B.c
  d := A.c * B.b + A.d * B.d

def identity [Zero F] [One F] : Matrix2 F where
  a := 1
  b := 0
  c := 0
  d := 1

instance [Semiring F] : Monoid (Matrix2 F) where
  one := identity
  mul := mul
  one_mul A := by
    apply Matrix2.ext <;> dsimp [identity, mul] <;> noncomm_ring
  mul_one A := by
    apply Matrix2.ext <;> dsimp [identity, mul] <;> noncomm_ring
  mul_assoc A B C := by
    apply Matrix2.ext <;> dsimp [mul] <;> noncomm_ring

def det [CommRing F] (A : Matrix2 F) : F :=
  A.a * A.d - A.b * A.c

def upper [Zero F] [One F] (x : F) : Matrix2 F where
  a := 1
  b := x
  c := 0
  d := 1

def lower [Zero F] [One F] (x : F) : Matrix2 F where
  a := 1
  b := 0
  c := x
  d := 1

@[simp]
theorem upper_zero [Semiring F] : upper (0 : F) = 1 := by
  apply Matrix2.ext <;> rfl

@[simp]
theorem lower_zero [Semiring F] : lower (0 : F) = 1 := by
  apply Matrix2.ext <;> rfl

@[simp]
theorem upper_mul_upper [Semiring F] (x y : F) :
    upper x * upper y = upper (x + y) := by
  apply Matrix2.ext <;> dsimp [upper, mul] <;> noncomm_ring

@[simp]
theorem lower_mul_lower [Semiring F] (x y : F) :
    lower x * lower y = lower (x + y) := by
  apply Matrix2.ext <;> dsimp [lower, mul] <;> noncomm_ring

@[simp]
theorem det_upper [CommRing F] (x : F) :
    det (upper x) = 1 := by
  dsimp [det, upper]
  ring

@[simp]
theorem det_lower [CommRing F] (x : F) :
    det (lower x) = 1 := by
  dsimp [det, lower]
  ring

theorem det_mul [CommRing F] (A B : Matrix2 F) :
    det (A * B) = det A * det B := by
  dsimp [det, mul]
  ring

theorem factor_of_det_one_of_c_ne_zero
    [Field F]
    (A : Matrix2 F)
    (hdet : det A = 1)
    (hc : A.c ≠ 0) :
    A =
      upper ((A.a - 1) / A.c) *
        lower A.c *
          upper ((A.d - 1) / A.c) := by
  change A.a * A.d - A.b * A.c = 1 at hdet
  apply Matrix2.ext
  · dsimp [upper, lower, mul]
    field_simp [hc] <;> ring
  · dsimp [upper, lower, mul]
    field_simp [hc]
    linear_combination -hdet
  · dsimp [upper, lower, mul]
    ring
  · dsimp [upper, lower, mul]
    field_simp [hc] <;> ring

theorem upper_pow [Semiring F] (x : F) (n : ℕ) :
    upper x ^ n = upper ((n : F) * x) := by
  induction n with
  | zero =>
      rw [pow_zero, Nat.cast_zero, zero_mul, upper_zero]
  | succ n ih =>
      rw [pow_succ, ih, upper_mul_upper]
      apply congrArg upper
      simp only [Nat.cast_succ, add_mul, one_mul]

theorem lower_pow [Semiring F] (x : F) (n : ℕ) :
    lower x ^ n = lower ((n : F) * x) := by
  induction n with
  | zero =>
      rw [pow_zero, Nat.cast_zero, zero_mul, lower_zero]
  | succ n ih =>
      rw [pow_succ, ih, lower_mul_lower]
      apply congrArg lower
      simp only [Nat.cast_succ, add_mul, one_mul]

end Matrix2

open Matrix2

structure MultiplicativeCarrier (M : Type*) [Monoid M] where
  carrier : Set M
  one_mem : (1 : M) ∈ carrier
  mul_mem : ∀ {x y : M}, x ∈ carrier → y ∈ carrier → x * y ∈ carrier

namespace MultiplicativeCarrier

variable {M : Type*} [Monoid M]

theorem pow_mem
    (C : MultiplicativeCarrier M)
    {x : M} (hx : x ∈ C.carrier) :
    ∀ n : ℕ, x ^ n ∈ C.carrier := by
  intro n
  induction n with
  | zero =>
      rw [pow_zero]
      exact C.one_mem
  | succ n ih =>
      rw [pow_succ]
      exact C.mul_mem ih hx

end MultiplicativeCarrier

theorem all_upper_of_one_nonzero
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u : ZMod p} (hu : u ≠ 0)
    (hupper : upper u ∈ C.carrier) :
    ∀ x : ZMod p, upper x ∈ C.carrier := by
  intro x
  let y : ZMod p := x / u
  have hpow := C.pow_mem hupper y.val
  rw [upper_pow] at hpow
  have hparameter : (y.val : ZMod p) * u = x := by
    rw [ZMod.natCast_zmod_val]
    exact div_mul_cancel₀ x hu
  rw [hparameter] at hpow
  exact hpow

theorem all_lower_of_one_nonzero
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u : ZMod p} (hu : u ≠ 0)
    (hlower : lower u ∈ C.carrier) :
    ∀ x : ZMod p, lower x ∈ C.carrier := by
  intro x
  let y : ZMod p := x / u
  have hpow := C.pow_mem hlower y.val
  rw [lower_pow] at hpow
  have hparameter : (y.val : ZMod p) * u = x := by
    rw [ZMod.natCast_zmod_val]
    exact div_mul_cancel₀ x hu
  rw [hparameter] at hpow
  exact hpow

theorem lower_of_upper_and_mover
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    (hupper : ∀ x : ZMod p, upper x ∈ C.carrier)
    (g : Matrix2 (ZMod p))
    (hg : g ∈ C.carrier)
    (hdet : det g = 1)
    (hgc : g.c ≠ 0) :
    lower g.c ∈ C.carrier := by
  let x : ZMod p := (g.a - 1) / g.c
  let y : ZMod p := (g.d - 1) / g.c
  have hfactor : g = upper x * lower g.c * upper y := by
    simpa [x, y] using
      factor_of_det_one_of_c_ne_zero g hdet hgc
  have hmem : upper (-x) * g * upper (-y) ∈ C.carrier :=
    C.mul_mem (C.mul_mem (hupper (-x)) hg) (hupper (-y))
  have hisolate : upper (-x) * g * upper (-y) = lower g.c := by
    calc
      upper (-x) * g * upper (-y) =
          upper (-x) * (upper x * lower g.c * upper y) * upper (-y) := by
            rw [hfactor]
      _ = (upper (-x) * upper x) * lower g.c *
            (upper y * upper (-y)) := by
            ac_rfl
      _ = lower g.c := by
            rw [upper_mul_upper, upper_mul_upper, neg_add_cancel,
              add_neg_cancel, upper_zero, upper_zero, one_mul, mul_one]
  rw [hisolate] at hmem
  exact hmem

theorem mem_of_det_one_of_c_ne_zero
    {F : Type*} [Field F]
    (C : MultiplicativeCarrier (Matrix2 F))
    (hupper : ∀ x : F, upper x ∈ C.carrier)
    (hlower : ∀ x : F, lower x ∈ C.carrier)
    (A : Matrix2 F)
    (hdet : det A = 1)
    (hc : A.c ≠ 0) :
    A ∈ C.carrier := by
  rw [factor_of_det_one_of_c_ne_zero A hdet hc]
  exact C.mul_mem
    (C.mul_mem (hupper _) (hlower _)) (hupper _)

theorem all_det_one_mem_of_upper_lower
    {F : Type*} [Field F]
    (C : MultiplicativeCarrier (Matrix2 F))
    (hupper : ∀ x : F, upper x ∈ C.carrier)
    (hlower : ∀ x : F, lower x ∈ C.carrier) :
    ∀ A : Matrix2 F, det A = 1 → A ∈ C.carrier := by
  intro A hdet
  by_cases hc : A.c = 0
  · have ha : A.a ≠ 0 := by
      intro ha
      have hzero : (0 : F) = 1 := by
        simpa [det, ha, hc] using hdet
      exact zero_ne_one hzero
    let B : Matrix2 F := lower 1 * A
    have hBc : B.c ≠ 0 := by
      change (lower (1 : F) * A).c ≠ 0
      dsimp [lower, Matrix2.mul]
      simpa [hc] using ha
    have hBdet : det B = 1 := by
      calc
        det B = det (lower (1 : F)) * det A := by
          exact det_mul (lower (1 : F)) A
        _ = 1 := by rw [det_lower, hdet, one_mul]
    have hBmem :=
      mem_of_det_one_of_c_ne_zero C hupper hlower B hBdet hBc
    have hrecover : lower (-1 : F) * B = A := by
      change lower (-1 : F) * (lower (1 : F) * A) = A
      rw [← mul_assoc, lower_mul_lower, neg_add_cancel,
        lower_zero, one_mul]
    have hleft := C.mul_mem (hlower (-1)) hBmem
    rw [hrecover] at hleft
    exact hleft
  · exact mem_of_det_one_of_c_ne_zero C hupper hlower A hdet hc

theorem all_det_one_mem_of_transvection_and_mover
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u : ZMod p} (hu : u ≠ 0)
    (htransvection : upper u ∈ C.carrier)
    (g : Matrix2 (ZMod p))
    (hg : g ∈ C.carrier)
    (hdet : det g = 1)
    (hgc : g.c ≠ 0) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  have hupper := all_upper_of_one_nonzero p C hu htransvection
  have hLowerOne := lower_of_upper_and_mover
    p C hupper g hg hdet hgc
  have hlower := all_lower_of_one_nonzero p C hgc hLowerOne
  exact all_det_one_mem_of_upper_lower C hupper hlower

def MovesUpperFixedLine
    {F : Type*} [Field F]
    (C : MultiplicativeCarrier (Matrix2 F)) : Prop :=
  ∃ g ∈ C.carrier, det g = 1 ∧ g.c ≠ 0

theorem all_det_one_mem_of_moves_fixed_line
    (p : ℕ) [Fact p.Prime]
    (C : MultiplicativeCarrier (Matrix2 (ZMod p)))
    {u : ZMod p} (hu : u ≠ 0)
    (htransvection : upper u ∈ C.carrier)
    (hmove : MovesUpperFixedLine C) :
    ∀ A : Matrix2 (ZMod p), det A = 1 → A ∈ C.carrier := by
  rcases hmove with ⟨g, hg, hdet, hgc⟩
  exact all_det_one_mem_of_transvection_and_mover
    p C hu htransvection g hg hdet hgc

end TransvectionLargeImage

end IUTThreeClosures
