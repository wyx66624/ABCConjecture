/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KFullABCThreshold
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.ZMod.Basic

/-!
# Nitaj's 3-full recurrence cannot reach a 4-full coordinate

Nitaj's recurrence produces infinitely many primitive 3-full solutions from
`(37,17,21)`.  This file formalizes a route-specific obstruction: the first
coordinate permanently has exact 37-adic order one before cubing, the second
permanently has exact 17-adic order one, and the third permanently has exact
7-adic order one.  Therefore the three positive coordinates

`|x_n|^3`, `|y_n|^3`, and `6 |z_n|^3`

all contain a prime to exact exponent three and none is 4-full.

This eliminates only the displayed Nitaj recurrence as a source of an
all-4-full or `(3,3,4)`-full family.  It does not eliminate other recurrences
or other constructions of mixed k-full abc points.
-/

namespace IUTThreeClosures

/-- One state of Nitaj's recurrence. -/
structure NitajState where
  x : ℤ
  y : ℤ
  z : ℤ

namespace NitajState

/-- The cubic self-map used in Nitaj's proof. -/
def step (S : NitajState) : NitajState where
  x := S.x * (S.x ^ 3 + 2 * S.y ^ 3)
  y := -S.y * (2 * S.x ^ 3 + S.y ^ 3)
  z := S.z * (S.x ^ 3 - S.y ^ 3)

/-- The initial integral point on `x^3 + y^3 = 6 z^3`. -/
def initial : NitajState := ⟨37, 17, 21⟩

/-- The iterated Nitaj orbit. -/
def orbit : ℕ → NitajState
  | 0 => initial
  | n + 1 => step (orbit n)

@[simp] theorem orbit_zero : orbit 0 = initial := rfl
@[simp] theorem orbit_succ (n : ℕ) : orbit (n + 1) = step (orbit n) := rfl

/-- The polynomial identity underlying the recurrence. -/
theorem cubic_identity (X Y : ℤ) :
    X ^ 3 * (X ^ 3 + 2 * Y ^ 3) ^ 3 -
        Y ^ 3 * (2 * X ^ 3 + Y ^ 3) ^ 3 =
      (X ^ 3 + Y ^ 3) * (X ^ 3 - Y ^ 3) ^ 3 := by
  ring

/-- The recurrence preserves `x^3 + y^3 = 6 z^3`. -/
theorem step_preserves_cubic
    {S : NitajState}
    (hS : S.x ^ 3 + S.y ^ 3 = 6 * S.z ^ 3) :
    (step S).x ^ 3 + (step S).y ^ 3 =
      6 * (step S).z ^ 3 := by
  calc
    (step S).x ^ 3 + (step S).y ^ 3 =
        S.x ^ 3 * (S.x ^ 3 + 2 * S.y ^ 3) ^ 3 -
          S.y ^ 3 * (2 * S.x ^ 3 + S.y ^ 3) ^ 3 := by
      simp only [step]
      ring
    _ = (S.x ^ 3 + S.y ^ 3) *
          (S.x ^ 3 - S.y ^ 3) ^ 3 := cubic_identity S.x S.y
    _ = 6 * (step S).z ^ 3 := by
      rw [hS]
      simp only [step]
      ring

@[simp] theorem initial_cubic :
    initial.x ^ 3 + initial.y ^ 3 = 6 * initial.z ^ 3 := by
  norm_num [initial]

/-- Every iterate remains on the cubic surface. -/
theorem orbit_cubic (n : ℕ) :
    (orbit n).x ^ 3 + (orbit n).y ^ 3 =
      6 * (orbit n).z ^ 3 := by
  induction n with
  | zero => exact initial_cubic
  | succ n ih => exact step_preserves_cubic ih

/-- The three positive 3-full coordinates extracted from a signed state. -/
def xCubeNat (S : NitajState) : ℕ := S.x.natAbs ^ 3
def yCubeNat (S : NitajState) : ℕ := S.y.natAbs ^ 3
def sixZCubeNat (S : NitajState) : ℕ := 6 * S.z.natAbs ^ 3

end NitajState

/-- Rational p-adic valuation of an integer.  Using the rational interface
makes the ultrametric sum lemma available without changing the recurrence. -/
def nitaQVal (p : ℕ) (a : ℤ) : ℤ :=
  padicValRat p (a : ℚ)

namespace nitaQVal

variable {p : ℕ} [Fact p.Prime]

@[simp] theorem neg (a : ℤ) : nitaQVal p (-a) = nitaQVal p a := by
  simp [nitaQVal]

/-- Multiplicativity for nonzero integers. -/
theorem mul {a b : ℤ} (ha : a ≠ 0) (hb : b ≠ 0) :
    nitaQVal p (a * b) = nitaQVal p a + nitaQVal p b := by
  have haQ : (a : ℚ) ≠ 0 := by exact_mod_cast ha
  have hbQ : (b : ℚ) ≠ 0 := by exact_mod_cast hb
  simpa [nitaQVal] using
    (padicValRat.mul (p := p) haQ hbQ)

/-- Valuation of an integer power. -/
theorem pow (a : ℤ) (m : ℕ) :
    nitaQVal p (a ^ m) = (m : ℤ) * nitaQVal p a := by
  simpa [nitaQVal] using
    (padicValRat.pow (p := p) (a : ℚ) (k := m))

/-- A non-divisibility certificate gives valuation zero. -/
theorem eq_zero_of_not_dvd {a : ℤ} (h : ¬(p : ℤ) ∣ a) :
    nitaQVal p a = 0 := by
  simpa [nitaQVal] using
    (padicValInt.eq_zero_of_not_dvd (p := p) h)

/-- If one nonzero summand has valuation zero and the other has strictly
positive valuation, then their sum is nonzero and has valuation zero. -/
theorem add_eq_zero_of_zero_lt
    {a b : ℤ}
    (ha : a ≠ 0) (hb : b ≠ 0)
    (hva : nitaQVal p a = 0)
    (hvb : 0 < nitaQVal p b) :
    a + b ≠ 0 ∧ nitaQVal p (a + b) = 0 := by
  have haQ : (a : ℚ) ≠ 0 := by exact_mod_cast ha
  have hbQ : (b : ℚ) ≠ 0 := by exact_mod_cast hb
  have hsumQ : (a : ℚ) + (b : ℚ) ≠ 0 := by
    intro hsum
    have hab : (a : ℚ) = -(b : ℚ) := by linarith
    have hvalEq := congrArg (padicValRat p) hab
    have : nitaQVal p a = nitaQVal p b := by
      simpa [nitaQVal] using hvalEq
    linarith
  have hlt :
      padicValRat p (a : ℚ) < padicValRat p (b : ℚ) := by
    change nitaQVal p a < nitaQVal p b
    linarith
  have hval := padicValRat.add_eq_of_lt
    (p := p) hsumQ haQ hbQ hlt
  constructor
  · intro hsum
    apply hsumQ
    exact_mod_cast hsum
  · simpa [nitaQVal, hva] using hval

/-- Symmetric form of the preceding ultrametric lemma. -/
theorem add_eq_zero_of_lt_zero
    {a b : ℤ}
    (ha : a ≠ 0) (hb : b ≠ 0)
    (hva : 0 < nitaQVal p a)
    (hvb : nitaQVal p b = 0) :
    a + b ≠ 0 ∧ nitaQVal p (a + b) = 0 := by
  have h := add_eq_zero_of_zero_lt
    (p := p) hb ha hvb hva
  simpa [add_comm] using h

end nitaQVal

/-- The exact 37-adic invariant carried by the first coordinate. -/
structure Nitaj37Invariant (S : NitajState) : Prop where
  x_ne : S.x ≠ 0
  y_ne : S.y ≠ 0
  z_ne : S.z ≠ 0
  val_x : nitaQVal 37 S.x = 1
  val_y : nitaQVal 37 S.y = 0
  val_z : nitaQVal 37 S.z = 0

namespace Nitaj37Invariant

local instance : Fact (Nat.Prime 37) := ⟨by norm_num⟩

/-- One Nitaj step preserves the exact 37-adic invariant. -/
theorem step {S : NitajState} (I : Nitaj37Invariant S) :
    Nitaj37Invariant S.step := by
  have h2 : nitaQVal 37 (2 : ℤ) = 0 :=
    nitaQVal.eq_zero_of_not_dvd (p := 37) (by norm_num)
  have hx3ne : S.x ^ 3 ≠ 0 := pow_ne_zero _ I.x_ne
  have hy3ne : S.y ^ 3 ≠ 0 := pow_ne_zero _ I.y_ne
  have hx3v : nitaQVal 37 (S.x ^ 3) = 3 := by
    rw [nitaQVal.pow, I.val_x]
    norm_num
  have hy3v : nitaQVal 37 (S.y ^ 3) = 0 := by
    rw [nitaQVal.pow, I.val_y]
    norm_num
  have h2y3ne : (2 : ℤ) * S.y ^ 3 ≠ 0 :=
    mul_ne_zero (by norm_num) hy3ne
  have h2y3v : nitaQVal 37 ((2 : ℤ) * S.y ^ 3) = 0 := by
    rw [nitaQVal.mul (by norm_num) hy3ne, h2, hy3v]
    norm_num
  have hxFactor := nitaQVal.add_eq_zero_of_lt_zero
    (p := 37) hx3ne h2y3ne (by rw [hx3v]; norm_num) h2y3v
  have h2x3ne : (2 : ℤ) * S.x ^ 3 ≠ 0 :=
    mul_ne_zero (by norm_num) hx3ne
  have h2x3v : nitaQVal 37 ((2 : ℤ) * S.x ^ 3) = 3 := by
    rw [nitaQVal.mul (by norm_num) hx3ne, h2, hx3v]
    norm_num
  have hyFactor := nitaQVal.add_eq_zero_of_lt_zero
    (p := 37) h2x3ne hy3ne (by rw [h2x3v]; norm_num) hy3v
  have hnegY3ne : -(S.y ^ 3) ≠ 0 := neg_ne_zero.mpr hy3ne
  have hnegY3v : nitaQVal 37 (-(S.y ^ 3)) = 0 := by
    simpa using hy3v
  have hzFactor := nitaQVal.add_eq_zero_of_lt_zero
    (p := 37) hx3ne hnegY3ne (by rw [hx3v]; norm_num) hnegY3v
  refine
    { x_ne := mul_ne_zero I.x_ne hxFactor.1
      y_ne := neg_ne_zero.mpr (mul_ne_zero I.y_ne hyFactor.1)
      z_ne := mul_ne_zero I.z_ne hzFactor.1
      val_x := ?_
      val_y := ?_
      val_z := ?_ }
  · change nitaQVal 37 (S.x * (S.x ^ 3 + 2 * S.y ^ 3)) = 1
    rw [nitaQVal.mul I.x_ne hxFactor.1, I.val_x, hxFactor.2]
    norm_num
  · change nitaQVal 37 (-S.y * (2 * S.x ^ 3 + S.y ^ 3)) = 0
    rw [nitaQVal.mul (neg_ne_zero.mpr I.y_ne) hyFactor.1,
      nitaQVal.neg, I.val_y, hyFactor.2]
    norm_num
  · change nitaQVal 37 (S.z * (S.x ^ 3 - S.y ^ 3)) = 0
    rw [show S.x ^ 3 - S.y ^ 3 = S.x ^ 3 + -(S.y ^ 3) by ring,
      nitaQVal.mul I.z_ne hzFactor.1, I.val_z, hzFactor.2]
    norm_num

@[simp] theorem initial : Nitaj37Invariant NitajState.initial := by
  refine
    { x_ne := by norm_num [NitajState.initial]
      y_ne := by norm_num [NitajState.initial]
      z_ne := by norm_num [NitajState.initial]
      val_x := ?_
      val_y := ?_
      val_z := ?_ }
  · simpa [NitajState.initial, nitaQVal] using
      (padicValRat.self (p := 37) (by norm_num : 1 < 37))
  · exact nitaQVal.eq_zero_of_not_dvd (p := 37) (by norm_num)
  · exact nitaQVal.eq_zero_of_not_dvd (p := 37) (by norm_num)

/-- Every Nitaj iterate satisfies the 37-adic invariant. -/
theorem orbit (n : ℕ) : Nitaj37Invariant (NitajState.orbit n) := by
  induction n with
  | zero => exact initial
  | succ n ih => exact step ih

end Nitaj37Invariant

/-- The exact 17-adic invariant carried by the second coordinate. -/
structure Nitaj17Invariant (S : NitajState) : Prop where
  x_ne : S.x ≠ 0
  y_ne : S.y ≠ 0
  z_ne : S.z ≠ 0
  val_x : nitaQVal 17 S.x = 0
  val_y : nitaQVal 17 S.y = 1
  val_z : nitaQVal 17 S.z = 0

namespace Nitaj17Invariant

local instance : Fact (Nat.Prime 17) := ⟨by norm_num⟩

/-- One Nitaj step preserves the exact 17-adic invariant. -/
theorem step {S : NitajState} (I : Nitaj17Invariant S) :
    Nitaj17Invariant S.step := by
  have h2 : nitaQVal 17 (2 : ℤ) = 0 :=
    nitaQVal.eq_zero_of_not_dvd (p := 17) (by norm_num)
  have hx3ne : S.x ^ 3 ≠ 0 := pow_ne_zero _ I.x_ne
  have hy3ne : S.y ^ 3 ≠ 0 := pow_ne_zero _ I.y_ne
  have hx3v : nitaQVal 17 (S.x ^ 3) = 0 := by
    rw [nitaQVal.pow, I.val_x]
    norm_num
  have hy3v : nitaQVal 17 (S.y ^ 3) = 3 := by
    rw [nitaQVal.pow, I.val_y]
    norm_num
  have h2y3ne : (2 : ℤ) * S.y ^ 3 ≠ 0 :=
    mul_ne_zero (by norm_num) hy3ne
  have h2y3v : nitaQVal 17 ((2 : ℤ) * S.y ^ 3) = 3 := by
    rw [nitaQVal.mul (by norm_num) hy3ne, h2, hy3v]
    norm_num
  have hxFactor := nitaQVal.add_eq_zero_of_zero_lt
    (p := 17) hx3ne h2y3ne hx3v (by rw [h2y3v]; norm_num)
  have h2x3ne : (2 : ℤ) * S.x ^ 3 ≠ 0 :=
    mul_ne_zero (by norm_num) hx3ne
  have h2x3v : nitaQVal 17 ((2 : ℤ) * S.x ^ 3) = 0 := by
    rw [nitaQVal.mul (by norm_num) hx3ne, h2, hx3v]
    norm_num
  have hyFactor := nitaQVal.add_eq_zero_of_zero_lt
    (p := 17) h2x3ne hy3ne h2x3v (by rw [hy3v]; norm_num)
  have hnegY3ne : -(S.y ^ 3) ≠ 0 := neg_ne_zero.mpr hy3ne
  have hnegY3v : nitaQVal 17 (-(S.y ^ 3)) = 3 := by
    simpa using hy3v
  have hzFactor := nitaQVal.add_eq_zero_of_zero_lt
    (p := 17) hx3ne hnegY3ne hx3v (by rw [hnegY3v]; norm_num)
  refine
    { x_ne := mul_ne_zero I.x_ne hxFactor.1
      y_ne := neg_ne_zero.mpr (mul_ne_zero I.y_ne hyFactor.1)
      z_ne := mul_ne_zero I.z_ne hzFactor.1
      val_x := ?_
      val_y := ?_
      val_z := ?_ }
  · change nitaQVal 17 (S.x * (S.x ^ 3 + 2 * S.y ^ 3)) = 0
    rw [nitaQVal.mul I.x_ne hxFactor.1, I.val_x, hxFactor.2]
    norm_num
  · change nitaQVal 17 (-S.y * (2 * S.x ^ 3 + S.y ^ 3)) = 1
    rw [nitaQVal.mul (neg_ne_zero.mpr I.y_ne) hyFactor.1,
      nitaQVal.neg, I.val_y, hyFactor.2]
    norm_num
  · change nitaQVal 17 (S.z * (S.x ^ 3 - S.y ^ 3)) = 0
    rw [show S.x ^ 3 - S.y ^ 3 = S.x ^ 3 + -(S.y ^ 3) by ring,
      nitaQVal.mul I.z_ne hzFactor.1, I.val_z, hzFactor.2]
    norm_num

@[simp] theorem initial : Nitaj17Invariant NitajState.initial := by
  refine
    { x_ne := by norm_num [NitajState.initial]
      y_ne := by norm_num [NitajState.initial]
      z_ne := by norm_num [NitajState.initial]
      val_x := ?_
      val_y := ?_
      val_z := ?_ }
  · exact nitaQVal.eq_zero_of_not_dvd (p := 17) (by norm_num)
  · simpa [NitajState.initial, nitaQVal] using
      (padicValRat.self (p := 17) (by norm_num : 1 < 17))
  · exact nitaQVal.eq_zero_of_not_dvd (p := 17) (by norm_num)

/-- Every Nitaj iterate satisfies the 17-adic invariant. -/
theorem orbit (n : ℕ) : Nitaj17Invariant (NitajState.orbit n) := by
  induction n with
  | zero => exact initial
  | succ n ih => exact step ih

end Nitaj17Invariant

/-- After the first step, the residue pair is fixed modulo 7 and the third
coordinate retains exact 7-adic order one. -/
structure Nitaj7Invariant (S : NitajState) : Prop where
  x_mod : (S.x : ZMod 7) = 5
  y_mod : (S.y : ZMod 7) = 4
  z_ne : S.z ≠ 0
  val_z : nitaQVal 7 S.z = 1

namespace Nitaj7Invariant

local instance : Fact (Nat.Prime 7) := ⟨by norm_num⟩

/-- The fixed residue pair `(5,4)` and exact 7-adic order are preserved. -/
theorem step {S : NitajState} (I : Nitaj7Invariant S) :
    Nitaj7Invariant S.step := by
  have hfactorCast :
      ((S.x ^ 3 - S.y ^ 3 : ℤ) : ZMod 7) = 5 := by
    change (S.x : ZMod 7) ^ 3 - (S.y : ZMod 7) ^ 3 = 5
    rw [I.x_mod, I.y_mod]
    norm_num
  have hfactorNotDvd : ¬(7 : ℤ) ∣ S.x ^ 3 - S.y ^ 3 := by
    intro hd
    have hz : ((S.x ^ 3 - S.y ^ 3 : ℤ) : ZMod 7) = 0 :=
      (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).2 hd
    rw [hfactorCast] at hz
    norm_num at hz
  have hfactorNe : S.x ^ 3 - S.y ^ 3 ≠ 0 := by
    intro hz
    apply hfactorNotDvd
    rw [hz]
    exact dvd_zero 7
  have hfactorVal : nitaQVal 7 (S.x ^ 3 - S.y ^ 3) = 0 :=
    nitaQVal.eq_zero_of_not_dvd hfactorNotDvd
  refine
    { x_mod := ?_
      y_mod := ?_
      z_ne := mul_ne_zero I.z_ne hfactorNe
      val_z := ?_ }
  · change
      (S.x : ZMod 7) *
          ((S.x : ZMod 7) ^ 3 + 2 * (S.y : ZMod 7) ^ 3) = 5
    rw [I.x_mod, I.y_mod]
    norm_num
  · change
      -(S.y : ZMod 7) *
          (2 * (S.x : ZMod 7) ^ 3 + (S.y : ZMod 7) ^ 3) = 4
    rw [I.x_mod, I.y_mod]
    norm_num
  · change nitaQVal 7 (S.z * (S.x ^ 3 - S.y ^ 3)) = 1
    rw [nitaQVal.mul I.z_ne hfactorNe, I.val_z, hfactorVal]
    norm_num

/-- The first iterate enters the fixed residue class modulo 7. -/
theorem orbit_one : Nitaj7Invariant (NitajState.orbit 1) := by
  have h7 : nitaQVal 7 (7 : ℤ) = 1 := by
    simpa [nitaQVal] using
      (padicValRat.self (p := 7) (by norm_num : 1 < 7))
  have h3 : nitaQVal 7 (3 : ℤ) = 0 :=
    nitaQVal.eq_zero_of_not_dvd (p := 7) (by norm_num)
  have h21 : nitaQVal 7 (21 : ℤ) = 1 := by
    calc
      nitaQVal 7 (21 : ℤ) = nitaQVal 7 ((7 : ℤ) * 3) := by norm_num
      _ = nitaQVal 7 (7 : ℤ) + nitaQVal 7 (3 : ℤ) :=
        nitaQVal.mul (by norm_num) (by norm_num)
      _ = 1 := by rw [h7, h3]; norm_num
  have hdiff : nitaQVal 7 ((37 : ℤ) ^ 3 - 17 ^ 3) = 0 :=
    nitaQVal.eq_zero_of_not_dvd (p := 7) (by norm_num)
  refine
    { x_mod := by
        norm_num [NitajState.orbit, NitajState.step, NitajState.initial]
      y_mod := by
        norm_num [NitajState.orbit, NitajState.step, NitajState.initial]
      z_ne := by
        norm_num [NitajState.orbit, NitajState.step, NitajState.initial]
      val_z := ?_ }
  change nitaQVal 7 ((21 : ℤ) * (37 ^ 3 - 17 ^ 3)) = 1
  rw [nitaQVal.mul (by norm_num) (by norm_num), h21, hdiff]
  norm_num

/-- Every positive-index iterate satisfies the 7-adic invariant. -/
theorem orbit_succ (n : ℕ) :
    Nitaj7Invariant (NitajState.orbit (n + 1)) := by
  induction n with
  | zero => exact orbit_one
  | succ n ih => exact step ih

end Nitaj7Invariant

/-- A prime occurring to exact order three rules out 4-fullness. -/
theorem not_isKFull_four_of_padicValNat_eq_three
    {p n : ℕ}
    (hp : p.Prime)
    (hn : n ≠ 0)
    (hval : padicValNat p n = 3) :
    ¬ IsKFull 4 n := by
  letI : Fact p.Prime := ⟨hp⟩
  intro hfull
  have hpDvd : p ∣ n :=
    dvd_of_one_le_padicValNat (by omega)
  have hpRad : p ∣ abcRadical n := by
    rw [abcRadical_eq_natRadical]
    exact
      (UniqueFactorizationMonoid.dvd_radical_iff_of_irreducible
        (Nat.prime_iff.mp hp).irreducible hn).2 hpDvd
  have hpFourRad : p ^ 4 ∣ abcRadical n ^ 4 := by
    rcases hpRad with ⟨t, ht⟩
    refine ⟨t ^ 4, ?_⟩
    rw [ht, mul_pow]
  have hpFourN : p ^ 4 ∣ n := hpFourRad.trans hfull
  have hle : 4 ≤ padicValNat p n :=
    (padicValNat_dvd_iff_le hn).1 hpFourN
  omega

/-- The first Nitaj coordinate is never 4-full. -/
theorem nita_xCube_not_fourFull (n : ℕ) :
    ¬ IsKFull 4 (NitajState.xCubeNat (NitajState.orbit n)) := by
  letI : Fact (Nat.Prime 37) := ⟨by norm_num⟩
  have I := Nitaj37Invariant.orbit n
  have hxVal : padicValNat 37 (NitajState.orbit n).x.natAbs = 1 := by
    simpa [nitaQVal, padicValInt] using I.val_x
  have hcubeVal :
      padicValNat 37 (NitajState.xCubeNat (NitajState.orbit n)) = 3 := by
    rw [NitajState.xCubeNat, padicValNat.pow, hxVal]
    norm_num
  apply not_isKFull_four_of_padicValNat_eq_three
    (p := 37) (n := NitajState.xCubeNat (NitajState.orbit n))
    (by norm_num)
  · exact pow_ne_zero _ (Int.natAbs_ne_zero.mpr I.x_ne)
  · exact hcubeVal

/-- The second Nitaj coordinate is never 4-full. -/
theorem nita_yCube_not_fourFull (n : ℕ) :
    ¬ IsKFull 4 (NitajState.yCubeNat (NitajState.orbit n)) := by
  letI : Fact (Nat.Prime 17) := ⟨by norm_num⟩
  have I := Nitaj17Invariant.orbit n
  have hyVal : padicValNat 17 (NitajState.orbit n).y.natAbs = 1 := by
    simpa [nitaQVal, padicValInt] using I.val_y
  have hcubeVal :
      padicValNat 17 (NitajState.yCubeNat (NitajState.orbit n)) = 3 := by
    rw [NitajState.yCubeNat, padicValNat.pow, hyVal]
    norm_num
  apply not_isKFull_four_of_padicValNat_eq_three
    (p := 17) (n := NitajState.yCubeNat (NitajState.orbit n))
    (by norm_num)
  · exact pow_ne_zero _ (Int.natAbs_ne_zero.mpr I.y_ne)
  · exact hcubeVal

/-- The third Nitaj coordinate is never 4-full at every positive index. -/
theorem nita_sixZCube_not_fourFull (n : ℕ) :
    ¬ IsKFull 4
      (NitajState.sixZCubeNat (NitajState.orbit (n + 1))) := by
  letI : Fact (Nat.Prime 7) := ⟨by norm_num⟩
  have I := Nitaj7Invariant.orbit_succ n
  have hzVal :
      padicValNat 7 (NitajState.orbit (n + 1)).z.natAbs = 1 := by
    simpa [nitaQVal, padicValInt] using I.val_z
  have h6 : padicValNat 7 6 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  have hzCubeNe :
      (NitajState.orbit (n + 1)).z.natAbs ^ 3 ≠ 0 :=
    pow_ne_zero _ (Int.natAbs_ne_zero.mpr I.z_ne)
  have hcubeVal :
      padicValNat 7
        (NitajState.sixZCubeNat (NitajState.orbit (n + 1))) = 3 := by
    rw [NitajState.sixZCubeNat,
      padicValNat.mul (by norm_num) hzCubeNe,
      h6, padicValNat.pow, hzVal]
    norm_num
  apply not_isKFull_four_of_padicValNat_eq_three
    (p := 7)
    (n := NitajState.sixZCubeNat (NitajState.orbit (n + 1)))
    (by norm_num)
  · exact mul_ne_zero (by norm_num) hzCubeNe
  · exact hcubeVal

/-- Route-level no-go: no positive-index Nitaj triple contains a 4-full
coordinate, hence this recurrence cannot realize the mixed `(3,3,4)` target. -/
theorem nita_orbit_no_fourFull_coordinate (n : ℕ) :
    ¬ IsKFull 4 (NitajState.xCubeNat (NitajState.orbit (n + 1))) ∧
    ¬ IsKFull 4 (NitajState.yCubeNat (NitajState.orbit (n + 1))) ∧
    ¬ IsKFull 4 (NitajState.sixZCubeNat (NitajState.orbit (n + 1))) :=
  ⟨nita_xCube_not_fourFull (n + 1),
    nita_yCube_not_fourFull (n + 1),
    nita_sixZCube_not_fourFull n⟩

end IUTThreeClosures
