/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# A transvection-and-mover criterion for full `SL₂` image

This module isolates the final finite-group step in the Frey large-image
argument without invoking the full Dickson subgroup classification.

For a field `F`, write

`U(x) = [[1,x],[0,1]]`,
`L(x) = [[1,0],[x,1]]`.

Every determinant-one matrix whose lower-left entry is nonzero has the exact
factorization

`A = U((a-1)/c) L(c) U((d-1)/c)`.

Over the prime field `ZMod p`, one nonzero upper transvection generates every
upper transvection by taking powers. If the image also contains a
determinant-one matrix whose lower-left entry is nonzero, the displayed
factorization isolates one nonzero lower transvection; its powers generate all
lower transvections. The same factorization, together with a one-step lower
shift in the triangular case, then puts every determinant-one matrix in the
image.
-/

namespace IUTThreeClosures

namespace TransvectionLargeImage

universe u

/-- A lightweight concrete `2 × 2` matrix. -/
@[ext]
structure Matrix2 (F : Type u) where
  a : F
  b : F
  c : F
  d : F

namespace Matrix2

variable {F : Type u}

/-- Concrete multiplication. -/
def mul [Semiring F] (A B : Matrix2 F) : Matrix2 F where
  a := A.a * B.a + A.b * B.c
  b := A.a * B.b + A.b * B.d
  c := A.c * B.a + A.d * B.c
  d := A.c * B.b + A.d * B.d

/-- Concrete identity matrix. -/
def identity [Zero F] [One F] : Matrix2 F where
  a := 1
  b := 0
  c := 0
  d := 1

instance [Semiring F] : Monoid (Matrix2 F) where
  one := identity
  mul := mul
  one_mul := by
    intro A
    change mul identity A = A
    apply Matrix2.ext <;> dsimp [mul, identity] <;> noncomm_ring
  mul_one := by
    intro A
    change mul A identity = A
    apply Matrix2.ext <;> dsimp [mul, identity] <;> noncomm_ring
  mul_assoc := by
    intro A B C
    change mul (mul A B) C = mul A (mul B C)
    apply Matrix2.ext <;> dsimp [mul] <;> noncomm_ring

/-- Determinant. -/
def det [CommRing F] (A : Matrix2 F) : F :=
  A.a * A.d - A.b * A.c

/-- Upper unipotent. -/
def upper [Zero F] [One F] (x : F) : Matrix2 F where
  a := 1
  b := x
  c := 0
  d := 1

/-- Lower unipotent. -/
def lower [Zero F] [One F] (x : F) : Matrix2 F where
  a := 1
  b := 0
  c := x
  d := 1

@[simp]
theorem upper_zero [Semiring F] : upper (0 : F) = 1 := by
  change upper (0 : F) = identity
  apply Matrix2.ext <;> rfl

@[simp]
theorem lower_zero [Semiring F] : lower (0 : F) = 1 := by
  change lower (0 : F) = identity
  apply Matrix2.ext <;> rfl

@[simp]
theorem upper_mul_upper [Semiring F] (x y : F) :
    upper x * upper y = upper (x + y) := by
  change mul (upper x) (upper y) = upper (x + y)
  apply Matrix2.ext <;> dsimp [mul, upper] <;> noncomm_ring

@[simp]
theorem lower_mul_lower [Semiring F] (x y : F) :
    lower x * lower y = lower (x + y) := by
  change mul (lower x) (lower y) = lower (x + y)
  apply Matrix2.ext <;> dsimp [mul, lower] <;> noncomm_ring

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

/-- Determinant is multiplicative. -/
theorem det_mul [CommRing F] (A B : Matrix2 F) :
    det (A * B) = det A * det B := by
  change det (mul A B) = det A * det B
  dsimp [det, mul]
  ring

/-- Exact three-unipotent factorization in the nontriangular cell. -/
theorem factor_of_det_one_of_c_ne_zero
    [Field F]
    (A : Matrix2 F)
    (hdet : det A = 1)
    (hc : A.c ≠ 0) :
    A =
      upper ((A.a - 1) / A.c) *
        lower A.c *
          upper ((A.d - 1) / A.c) := by
  have hdet' : A.a * A.d - A.b * A.c = 1 := by
    simpa [det] using hdet
  change A =
    mul
      (mul (upper ((A.a - 1) / A.c)) (lower A.c))
      (upper ((A.d - 1) / A.c))
  apply Matrix2.ext
  · dsimp [mul, upper, lower]
    field_simp [hc] <;> ring
  · dsimp [mul, upper, lower]
    field_simp [hc]
    linear_combination hdet'
  · dsimp [mul, upper, lower]
    ring
  · dsimp [mul, upper, lower]
    field_simp [hc] <;> ring

/-- Powers of one upper transvection add its parameter. -/
theorem upper_pow [Semiring F] (x : F) (n : ℕ) :
    upper x ^ n = upper ((n : F) * x) := by
  induction n with
  | zero => simp
  | succ n ih =>
      calc
        upper x ^ (n + 1) = upper ((n : F) * x) * upper x := by
          rw [pow_succ, ih]
        _ = upper ((n : F) * x + x) := upper_mul_upper _ _
        _ = upper (((n + 1 : ℕ) : F) * x) := by
          congr 1
          rw [Nat.cast_succ]
          ring

/-- Powers of one lower transvection add its parameter. -/
theorem lower_pow [Semiring F] (x : F) (n : ℕ) :
    lower x ^ n = lower ((n : F) * x) := by
  induction n with
  | zero => simp
  | succ n ih =>
      calc
        lower x ^ (n + 1) = lower ((n : F) * x) * lower x := by
          rw [pow_succ, ih]
        _ = lower ((n : F) * x + x) := lower_mul_lower _ _
        _ = lower (((n + 1 : ℕ) : F) * x) := by
          congr 1
          rw [Nat.cast_succ]
          ring

end Matrix2

open Matrix2

/-- A multiplicatively closed candidate image. -/
structure MultiplicativeCarrier (M : Type*) [Monoid M] where
  carrier : Set M
  one_mem : (1 : M) ∈ carrier
  mul_mem : ∀ {x y : M}, x ∈ carrier → y ∈ carrier → x * y ∈ carrier

namespace MultiplicativeCarrier

variable {M : Type*} [Monoid M]

/-- Multiplicative closure contains every natural power. -/
theorem pow_mem
    (C : MultiplicativeCarrier M)
    {x : M} (hx : x ∈ C.carrier) :
    ∀ n : ℕ, x ^ n ∈ C.carrier := by
  intro n
  induction n with
  | zero => simpa using C.one_mem
  | succ n ih =>
      rw [pow_succ]
      exact C.mul_mem ih hx

end MultiplicativeCarrier

/-- Over `ZMod p`, one nonzero upper transvection generates the complete upper
root subgroup. -/
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
    dsimp [y]
    exact div_mul_cancel₀ x hu
  simpa [hparameter] using hpow

/-- The lower-root analogue. -/
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
    dsimp [y]
    exact div_mul_cancel₀ x hu
  simpa [hparameter] using hpow

/-- A complete upper root subgroup and one determinant-one element moving its
fixed line produce one nonzero lower transvection. -/
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
          upper (-x) * (upper x * lower g.c * upper y) *
            upper (-y) := by rw [hfactor]
      _ = (upper (-x) * upper x) * lower g.c *
            (upper y * upper (-y)) := by
          simp only [mul_assoc]
      _ = lower g.c := by simp
  rwa [hisolate] at hmem

/-- If both complete unipotent root subgroups are present, then every
nontriangular determinant-one matrix is present. -/
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

/-- Complete upper and lower root subgroups contain every determinant-one
matrix, including the triangular Bruhat cell. -/
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
        simpa [det, hc, ha] using hdet
      exact zero_ne_one hzero
    let B : Matrix2 F := lower 1 * A
    have hBc : B.c ≠ 0 := by
      intro hBzero
      change (lower (1 : F) * A).c = 0 at hBzero
      change A.a + A.c = 0 at hBzero
      rw [hc, add_zero] at hBzero
      exact ha hBzero
    have hBdet : det B = 1 := by
      calc
        det B = det (lower (1 : F)) * det A := by
          simpa [B] using det_mul (lower (1 : F)) A
        _ = 1 := by simp [hdet]
    have hBmem :=
      mem_of_det_one_of_c_ne_zero C hupper hlower B hBdet hBc
    have hrecover : lower (-1 : F) * B = A := by
      calc
        lower (-1 : F) * B =
            (lower (-1 : F) * lower 1) * A := by
          rw [B, ← mul_assoc]
        _ = A := by simp
    have hleft := C.mul_mem (hlower (-1)) hBmem
    rwa [hrecover] at hleft
  · exact mem_of_det_one_of_c_ne_zero
      C hupper hlower A hdet hc

/-- **Transvection-and-mover large-image criterion.** One nonzero upper
transvection and one determinant-one matrix with nonzero lower-left entry force
the image to contain every determinant-one matrix over `ZMod p`. -/
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

/-- Chosen-basis irreducibility interface. -/
def MovesUpperFixedLine
    {F : Type*} [Field F]
    (C : MultiplicativeCarrier (Matrix2 F)) : Prop :=
  ∃ g ∈ C.carrier, det g = 1 ∧ g.c ≠ 0

/-- Large image in the concise transvection/irreducibility form. -/
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
