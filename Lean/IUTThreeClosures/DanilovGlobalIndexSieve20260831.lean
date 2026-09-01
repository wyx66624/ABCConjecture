/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HallSquarefullCounterexample20260831
import Mathlib.Data.ZMod.Basic

/-!
# A global modular index sieve for the Danilov--Hall route

The complete mathematical proof precedes this file in
`research/ABC_DANILOV_GLOBAL_INDEX_SIEVE_2026_08_31.md`.

This module formalizes an all-index congruence obstruction.  It does not
infer an infinite statement from a finite search and does not assert that the
surviving residue class contains, or does not contain, a squarefull term.
-/

set_option maxRecDepth 20000

namespace IUTThreeClosures
namespace DanilovGlobalIndexSieve20260831

open KFullRadicalCompression

/-- The quadratic algebra with formal basis `1, sqrt 5`. -/
@[ext] structure Quad (R : Type*) where
  re : R
  im : R
deriving DecidableEq

namespace Quad

variable {R : Type*} [CommSemiring R]

def one : Quad R := ⟨1, 0⟩

def mul (x y : Quad R) : Quad R :=
  ⟨x.re * y.re + 5 * x.im * y.im, x.re * y.im + x.im * y.re⟩

def pow (x : Quad R) : ℕ → Quad R
  | 0 => one
  | n + 1 => mul (pow x n) x

@[simp] theorem pow_zero (x : Quad R) : pow x 0 = one := rfl

@[simp] theorem pow_succ (x : Quad R) (n : ℕ) :
    pow x (n + 1) = mul (pow x n) x := rfl

@[simp] theorem one_mul (x : Quad R) : mul one x = x := by
  ext <;> simp [one, mul]

@[simp] theorem mul_one (x : Quad R) : mul x one = x := by
  ext <;> simp [one, mul]

theorem mul_assoc (x y z : Quad R) : mul (mul x y) z = mul x (mul y z) := by
  ext <;> simp [mul] <;> ring

theorem mul_comm (x y : Quad R) : mul x y = mul y x := by
  ext <;> simp [mul] <;> ring

theorem pow_add (x : Quad R) (m n : ℕ) :
    pow x (m + n) = mul (pow x m) (pow x n) := by
  induction n with
  | zero => exact (mul_one (pow x m)).symm
  | succ n ih =>
      rw [Nat.add_succ, pow_succ, pow_succ, ih, mul_assoc]

theorem pow_mul (x : Quad R) (m n : ℕ) :
    pow x (m * n) = pow (pow x m) n := by
  induction n with
  | zero => simp [one]
  | succ n ih =>
      rw [Nat.mul_succ, pow_add, pow_succ, ih]

/-- A nilpotent first-order unit has a linear power formula. -/
theorem pow_one_im_of_five_sq_eq_zero (u : R)
    (hu : 5 * u * u = 0) (n : ℕ) :
    pow (⟨1, u⟩ : Quad R) n = ⟨1, (n : R) * u⟩ := by
  induction n with
  | zero => simp [one]
  | succ n ih =>
      rw [pow_succ, ih]
      apply Quad.ext
      · dsimp [mul]
        have hzero : 5 * ((n : R) * u) * u = 0 := by
          calc
            5 * ((n : R) * u) * u = (n : R) * (5 * u * u) := by ring
            _ = 0 := by rw [hu]; simp
        rw [hzero]
        simp
      · dsimp [mul]
        push_cast
        ring

end Quad

/-- The norm-one step preserving the Danilov congruence. -/
def etaNat : Quad ℕ := ⟨1730726404001, 774004377960⟩

/-- The initial norm-minus-one Pell point. -/
def alphaZeroNat : Quad ℕ := ⟨682, 305⟩

/-- The exact positive Pell orbit. -/
def alphaNat (t : ℕ) : Quad ℕ :=
  Quad.mul alphaZeroNat (Quad.pow etaNat t)

def z (t : ℕ) : ℕ := (alphaNat t).re
def w (t : ℕ) : ℕ := (alphaNat t).im
def L (t : ℕ) : ℕ := 2 * z t + 11
def K (t : ℕ) : ℕ := 27 * (L t / 125)

/-- Reduction of a natural quadratic pair modulo `m`. -/
def Quad.castZMod (m : ℕ) (x : Quad ℕ) : Quad (ZMod m) :=
  ⟨x.re, x.im⟩

@[simp] theorem Quad.castZMod_mul (m : ℕ) (x y : Quad ℕ) :
    Quad.castZMod m (Quad.mul x y) =
      Quad.mul (Quad.castZMod m x) (Quad.castZMod m y) := by
  ext <;> simp [Quad.castZMod, Quad.mul]

@[simp] theorem Quad.castZMod_pow (m : ℕ) (x : Quad ℕ) (n : ℕ) :
    Quad.castZMod m (Quad.pow x n) = Quad.pow (Quad.castZMod m x) n := by
  induction n with
  | zero => simp [Quad.castZMod, Quad.one]
  | succ n ih => simp [Quad.pow_succ, ih]

def etaMod (m : ℕ) : Quad (ZMod m) := Quad.castZMod m etaNat
def alphaZeroMod (m : ℕ) : Quad (ZMod m) := Quad.castZMod m alphaZeroNat

def alphaMod (m t : ℕ) : Quad (ZMod m) :=
  Quad.mul (alphaZeroMod m) (Quad.pow (etaMod m) t)

@[simp] theorem castZMod_alphaNat (m t : ℕ) :
    Quad.castZMod m (alphaNat t) = alphaMod m t := by
  simp [alphaNat, alphaMod, etaMod, alphaZeroMod]

theorem alphaMod_add (m t u : ℕ) :
    alphaMod m (t + u) =
      Quad.mul (alphaMod m t) (Quad.pow (etaMod m) u) := by
  simp only [alphaMod, Quad.pow_add, Quad.mul_assoc]

theorem L_cast_eq (m t : ℕ) :
    (L t : ZMod m) = 2 * (alphaMod m t).re + 11 := by
  have h := congrArg Quad.re (castZMod_alphaNat m t)
  simpa [L, z, Quad.castZMod] using congrArg (fun q : ZMod m => 2 * q + 11) h

/-! ## Uniform divisibility by 125 -/

theorem etaMod_125 :
    etaMod 125 = (⟨1, 85⟩ : Quad (ZMod 125)) := by
  decide

theorem alphaZeroMod_125 :
    alphaZeroMod 125 = (⟨57, 55⟩ : Quad (ZMod 125)) := by
  decide

theorem etaPow_125 (t : ℕ) :
    Quad.pow (etaMod 125) t =
      (⟨1, (t : ZMod 125) * 85⟩ : Quad (ZMod 125)) := by
  rw [etaMod_125]
  apply Quad.pow_one_im_of_five_sq_eq_zero
  decide

/-- The normalization denominator in `K(t)` divides `L(t)` for every index. -/
theorem one_hundred_twenty_five_dvd_L (t : ℕ) : 125 ∣ L t := by
  apply (ZMod.natCast_eq_zero_iff (L t) 125).1
  rw [L_cast_eq]
  simp only [alphaMod, alphaZeroMod_125, etaPow_125]
  change 2 * (57 * 1 + 5 * 55 * ((t : ZMod 125) * 85)) + 11 = 0
  ring_nf
  rw [show (125 : ZMod 125) = 0 by decide]
  rw [show (46750 : ZMod 125) = 0 by decide]
  simp

theorem L_eq_125_mul_normalized (t : ℕ) :
    L t = 125 * (L t / 125) := by
  exact (Nat.mul_div_cancel' (one_hundred_twenty_five_dvd_L t)).symm

/-- Away from the fixed factor `3³5³`, squarefullness of `K(t)` upgrades
any prime divisor of `L(t)` to a square divisor of `L(t)`. -/
theorem prime_sq_dvd_L_of_K_twoFull {p t : ℕ}
    (hp : p.Prime) (hp_fixed : ¬ p ∣ 3375)
    (hK : IsKFull 2 (K t)) (hpL : p ∣ L t) :
    p ^ 2 ∣ L t := by
  have hp125 : ¬ p ∣ 125 := by
    intro h
    apply hp_fixed
    simpa using h.mul_left 27
  have hp27 : ¬ p ∣ 27 := by
    intro h
    apply hp_fixed
    simpa [Nat.mul_comm] using h.mul_right 125
  have hpM : p ∣ L t / 125 := by
    have hprod : p ∣ 125 * (L t / 125) := by
      simpa [← L_eq_125_mul_normalized t] using hpL
    rcases (hp.dvd_mul.mp hprod) with hbad | hgood
    · exact False.elim (hp125 hbad)
    · exact hgood
  have hpK : p ∣ K t := by
    simpa [K] using hpM.mul_left 27
  have hp2K : p ^ 2 ∣ K t :=
    (IsKFull.iff_prime_pow_dvd hK.ne_zero).1 hK p hp hpK
  have hcop : Nat.Coprime (p ^ 2) 27 :=
    (hp.coprime_iff_not_dvd.mpr hp27).pow_left 2
  have hp2M : p ^ 2 ∣ L t / 125 := by
    apply hcop.dvd_of_dvd_mul_left
    simpa [K] using hp2K
  rw [L_eq_125_mul_normalized]
  exact hp2M.mul_left 125

/-! ## The first all-index obstruction, modulo 11² -/

theorem etaMod_121 :
    etaMod 121 = (⟨1, 44⟩ : Quad (ZMod 121)) := by
  decide

theorem alphaZeroMod_121 :
    alphaZeroMod 121 = (⟨77, 63⟩ : Quad (ZMod 121)) := by
  decide

theorem etaPow_121 (t : ℕ) :
    Quad.pow (etaMod 121) t =
      (⟨1, (t : ZMod 121) * 44⟩ : Quad (ZMod 121)) := by
  rw [etaMod_121]
  apply Quad.pow_one_im_of_five_sq_eq_zero
  decide

/-- Exact linearization of the Danilov remainder modulo `11²`. -/
theorem L_cast_121 (t : ℕ) :
    (L t : ZMod 121) = 11 * ((t : ZMod 121) + 4) := by
  rw [L_cast_eq]
  simp only [alphaMod, alphaZeroMod_121, etaPow_121]
  change 2 * (77 * 1 + 5 * 63 * ((t : ZMod 121) * 44)) + 11 =
    11 * ((t : ZMod 121) + 4)
  ring_nf
  rw [show (165 : ZMod 121) = 44 by decide]
  rw [show (27720 : ZMod 121) = 11 by decide]

theorem L_modEq_121 (t : ℕ) :
    L t ≡ 11 * (t + 4) [MOD 121] := by
  apply (ZMod.natCast_eq_natCast_iff (L t) (11 * (t + 4)) 121).1
  simpa only [Nat.cast_mul, Nat.cast_add, Nat.cast_ofNat] using L_cast_121 t

theorem eleven_dvd_L (t : ℕ) : 11 ∣ L t := by
  have h := (L_modEq_121 t).of_dvd (by norm_num : 11 ∣ 121)
  have hz : 11 * (t + 4) ≡ 0 [MOD 11] :=
    (Nat.modEq_zero_iff_dvd).2 (Nat.dvd_mul_right 11 (t + 4))
  exact (Nat.modEq_zero_iff_dvd).1 (h.trans hz)

/-- If the normalized Danilov remainder is squarefull, then the orbit index
lies in the unique residue class `7 mod 11`. -/
theorem index_mod_eleven_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    t ≡ 7 [MOD 11] := by
  have h121L : 121 ∣ L t :=
    prime_sq_dvd_L_of_K_twoFull (p := 11) (t := t)
      (by decide) (by decide) hK (eleven_dvd_L t)
  have hzeroL : L t ≡ 0 [MOD 121] :=
    (Nat.modEq_zero_iff_dvd).2 h121L
  have hzeroR : 11 * (t + 4) ≡ 0 [MOD 121] :=
    (L_modEq_121 t).symm.trans hzeroL
  have hprod : 121 ∣ 11 * (t + 4) :=
    (Nat.modEq_zero_iff_dvd).1 hzeroR
  have hsum : 11 ∣ t + 4 := by
    apply (Nat.mul_dvd_mul_iff_left (by norm_num : 0 < 11)).1
    norm_num
    exact hprod
  apply (ZMod.natCast_eq_natCast_iff t 7 11).1
  have hz : ((t + 4 : ℕ) : ZMod 11) = 0 :=
    (ZMod.natCast_eq_zero_iff (t + 4) 11).2 hsum
  push_cast at hz
  have hseven : (7 : ZMod 11) + 4 = 0 := by decide
  linear_combination hz - hseven

/-! ## The second all-index obstruction, modulo 89² -/

theorem alphaMod_7921_seven :
    alphaMod 7921 7 = (⟨39, 3785⟩ : Quad (ZMod 7921)) := by
  decide

theorem etaPow_7921_eleven :
    Quad.pow (etaMod 7921) 11 =
      (⟨1, 89 * 41⟩ : Quad (ZMod 7921)) := by
  decide

theorem etaPow_7921_eleven_mul (s : ℕ) :
    Quad.pow (etaMod 7921) (11 * s) =
      (⟨1, (s : ZMod 7921) * (89 * 41)⟩ : Quad (ZMod 7921)) := by
  rw [Quad.pow_mul, etaPow_7921_eleven]
  apply Quad.pow_one_im_of_five_sq_eq_zero
  decide

/-- Exact linearization on the residue class surviving the 11-adic sieve. -/
theorem L_cast_7921_seven_add_eleven_mul (s : ℕ) :
    (L (7 + 11 * s) : ZMod 7921) =
      89 * (1 + 46 * (s : ZMod 7921)) := by
  rw [L_cast_eq, alphaMod_add]
  rw [alphaMod_7921_seven, etaPow_7921_eleven_mul]
  change 2 * (39 * 1 + 5 * 3785 * ((s : ZMod 7921) * (89 * 41))) + 11 =
    89 * (1 + 46 * (s : ZMod 7921))
  ring_nf
  rw [show (138114650 : ZMod 7921) = 4094 by decide]

theorem L_modEq_7921_seven_add_eleven_mul (s : ℕ) :
    L (7 + 11 * s) ≡ 89 * (1 + 46 * s) [MOD 7921] := by
  apply (ZMod.natCast_eq_natCast_iff
    (L (7 + 11 * s)) (89 * (1 + 46 * s)) 7921).1
  simpa only [Nat.cast_mul, Nat.cast_add, Nat.cast_ofNat, Nat.cast_one] using
    L_cast_7921_seven_add_eleven_mul s

theorem eighty_nine_dvd_L_seven_add_eleven_mul (s : ℕ) :
    89 ∣ L (7 + 11 * s) := by
  have h := (L_modEq_7921_seven_add_eleven_mul s).of_dvd
    (by norm_num : 89 ∣ 7921)
  have hz : 89 * (1 + 46 * s) ≡ 0 [MOD 89] :=
    (Nat.modEq_zero_iff_dvd).2 (Nat.dvd_mul_right 89 (1 + 46 * s))
  exact (Nat.modEq_zero_iff_dvd).1 (h.trans hz)

/-- Squarefullness upgrades the second local condition to `s = 29 mod 89`. -/
theorem secondary_index_mod_eighty_nine_of_K_twoFull {s : ℕ}
    (hK : IsKFull 2 (K (7 + 11 * s))) :
    s ≡ 29 [MOD 89] := by
  have h7921L : 7921 ∣ L (7 + 11 * s) :=
    prime_sq_dvd_L_of_K_twoFull (p := 89) (t := 7 + 11 * s)
      (by decide) (by decide) hK
      (eighty_nine_dvd_L_seven_add_eleven_mul s)
  have hzeroL : L (7 + 11 * s) ≡ 0 [MOD 7921] :=
    (Nat.modEq_zero_iff_dvd).2 h7921L
  have hzeroR : 89 * (1 + 46 * s) ≡ 0 [MOD 7921] :=
    (L_modEq_7921_seven_add_eleven_mul s).symm.trans hzeroL
  have hprod : 7921 ∣ 89 * (1 + 46 * s) :=
    (Nat.modEq_zero_iff_dvd).1 hzeroR
  have hsum : 89 ∣ 1 + 46 * s := by
    apply (Nat.mul_dvd_mul_iff_left (by norm_num : 0 < 89)).1
    norm_num
    exact hprod
  apply (ZMod.natCast_eq_natCast_iff s 29 89).1
  have hz : ((1 + 46 * s : ℕ) : ZMod 89) = 0 :=
    (ZMod.natCast_eq_zero_iff (1 + 46 * s) 89).2 hsum
  push_cast at hz
  have hroot : (1 : ZMod 89) + 46 * 29 = 0 := by decide
  have hmul : (46 : ZMod 89) * (s : ZMod 89) = 46 * 29 := by
    linear_combination hz - hroot
  have hinv : (60 : ZMod 89) * 46 = 1 := by decide
  calc
    (s : ZMod 89) = 1 * (s : ZMod 89) := by simp
    _ = (60 * 46) * (s : ZMod 89) := by rw [hinv]
    _ = 60 * (46 * (s : ZMod 89)) := by ring
    _ = 60 * (46 * 29) := by rw [hmul]
    _ = (29 : ZMod 89) := by decide

theorem exists_eq_residue_add_modulus_mul_of_modEq
    {n a r : ℕ} (h : a ≡ r [MOD n]) (hr : r < n) :
    ∃ q : ℕ, a = r + n * q := by
  refine ⟨a / n, ?_⟩
  have hrem : a % n = r := by
    change a % n = r % n at h
    simpa [Nat.mod_eq_of_lt hr] using h
  calc
    a = a % n + n * (a / n) := (Nat.mod_add_div a n).symm
    _ = r + n * (a / n) := by rw [hrem]

/-- The first two local obstructions combine to a full integer progression,
without any finite-search inference. -/
theorem index_shape_326_add_979_mul_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    ∃ r : ℕ, t = 326 + 979 * r := by
  obtain ⟨s, ht⟩ := exists_eq_residue_add_modulus_mul_of_modEq
    (index_mod_eleven_of_K_twoFull hK) (by norm_num : 7 < 11)
  have hKs : IsKFull 2 (K (7 + 11 * s)) := by
    simpa [ht] using hK
  obtain ⟨r, hs⟩ := exists_eq_residue_add_modulus_mul_of_modEq
    (secondary_index_mod_eighty_nine_of_K_twoFull hKs) (by norm_num : 29 < 89)
  refine ⟨r, ?_⟩
  rw [ht, hs]
  ring

theorem index_mod_979_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    t ≡ 326 [MOD 979] := by
  obtain ⟨r, rfl⟩ := index_shape_326_add_979_mul_of_K_twoFull hK
  change (326 + 979 * r) % 979 = 326 % 979
  simp

/-! ## Uniform prime-square lifting after `t = 326 + 979 r` -/

/-- A completely checkable local lifting packet.  Its fields are precisely
the finite congruences used by the symbolic proof below. -/
structure LiftCertificate where
  p : ℕ
  x : ℕ
  y : ℕ
  c : ℕ
  d : ℕ
  a : ℕ
  rho : ℕ
  invA : ℕ
  prime : p.Prime
  away_fixed : ¬ p ∣ 3375
  alpha_base :
    alphaMod (p ^ 2) 326 = (⟨x, y⟩ : Quad (ZMod (p ^ 2)))
  eta_step :
    Quad.pow (etaMod (p ^ 2)) 979 =
      (⟨1, p * d⟩ : Quad (ZMod (p ^ 2)))
  step_nilpotent :
    (5 : ZMod (p ^ 2)) * (p * d) * (p * d) = 0
  base_remainder :
    (2 * x + 11 : ZMod (p ^ 2)) = p * c
  scaled_slope :
    (p : ZMod (p ^ 2)) * (10 * y * d) = p * a
  root :
    (c : ZMod p) + a * rho = 0
  inverse_slope :
    (invA : ZMod p) * a = 1
  rho_lt : rho < p

namespace LiftCertificate

theorem etaPow_step_mul (C : LiftCertificate) (r : ℕ) :
    Quad.pow (etaMod (C.p ^ 2)) (979 * r) =
      (⟨1, (r : ZMod (C.p ^ 2)) * (C.p * C.d)⟩ :
        Quad (ZMod (C.p ^ 2))) := by
  rw [Quad.pow_mul, C.eta_step]
  exact Quad.pow_one_im_of_five_sq_eq_zero
    (C.p * C.d : ZMod (C.p ^ 2)) C.step_nilpotent r

/-- The whole infinite progression is linear modulo `p²`; only the packet's
finite base and step congruences are evaluated computationally. -/
theorem L_cast (C : LiftCertificate) (r : ℕ) :
    (L (326 + 979 * r) : ZMod (C.p ^ 2)) =
      C.p * (C.c + C.a * (r : ZMod (C.p ^ 2))) := by
  rw [L_cast_eq, alphaMod_add]
  rw [C.alpha_base, C.etaPow_step_mul]
  change 2 * (C.x * 1 + 5 * C.y *
      ((r : ZMod (C.p ^ 2)) * (C.p * C.d))) + 11 =
    C.p * (C.c + C.a * (r : ZMod (C.p ^ 2)))
  calc
    2 * (C.x * 1 + 5 * C.y *
        ((r : ZMod (C.p ^ 2)) * (C.p * C.d))) + 11 =
        (2 * C.x + 11 : ZMod (C.p ^ 2)) +
          C.p * (10 * C.y * C.d) * r := by ring
    _ = C.p * C.c + C.p * C.a * r := by
      rw [C.base_remainder, C.scaled_slope]
    _ = C.p * (C.c + C.a * r) := by ring

theorem L_modEq (C : LiftCertificate) (r : ℕ) :
    L (326 + 979 * r) ≡ C.p * (C.c + C.a * r) [MOD C.p ^ 2] := by
  apply (ZMod.natCast_eq_natCast_iff
    (L (326 + 979 * r)) (C.p * (C.c + C.a * r)) (C.p ^ 2)).1
  simpa only [Nat.cast_mul, Nat.cast_add, Nat.cast_ofNat] using C.L_cast r

theorem p_dvd_L (C : LiftCertificate) (r : ℕ) :
    C.p ∣ L (326 + 979 * r) := by
  have hmod := (C.L_modEq r).of_dvd (by
    exact dvd_pow_self C.p (by norm_num : 2 ≠ 0))
  have hz : C.p * (C.c + C.a * r) ≡ 0 [MOD C.p] :=
    (Nat.modEq_zero_iff_dvd).2
      (Nat.dvd_mul_right C.p (C.c + C.a * r))
  exact (Nat.modEq_zero_iff_dvd).1 (hmod.trans hz)

/-- A squarefull normalized remainder forces the unique local root recorded
in the certificate. -/
theorem parameter_mod_prime_of_K_twoFull
    (C : LiftCertificate) {r : ℕ}
    (hK : IsKFull 2 (K (326 + 979 * r))) :
    r ≡ C.rho [MOD C.p] := by
  have hp2L : C.p ^ 2 ∣ L (326 + 979 * r) :=
    prime_sq_dvd_L_of_K_twoFull C.prime C.away_fixed hK (C.p_dvd_L r)
  have hzeroL : L (326 + 979 * r) ≡ 0 [MOD C.p ^ 2] :=
    (Nat.modEq_zero_iff_dvd).2 hp2L
  have hzeroR : C.p * (C.c + C.a * r) ≡ 0 [MOD C.p ^ 2] :=
    (C.L_modEq r).symm.trans hzeroL
  have hprod : C.p ^ 2 ∣ C.p * (C.c + C.a * r) :=
    (Nat.modEq_zero_iff_dvd).1 hzeroR
  have hsum : C.p ∣ C.c + C.a * r := by
    apply (Nat.mul_dvd_mul_iff_left C.prime.pos).1
    simpa [pow_two] using hprod
  apply (ZMod.natCast_eq_natCast_iff r C.rho C.p).1
  have hz : ((C.c + C.a * r : ℕ) : ZMod C.p) = 0 :=
    (ZMod.natCast_eq_zero_iff (C.c + C.a * r) C.p).2 hsum
  push_cast at hz
  have hmul : (C.a : ZMod C.p) * (r : ZMod C.p) =
      C.a * (C.rho : ZMod C.p) := by
    linear_combination hz - C.root
  calc
    (r : ZMod C.p) = 1 * (r : ZMod C.p) := by simp
    _ = (C.invA * C.a) * (r : ZMod C.p) := by rw [C.inverse_slope]
    _ = C.invA * (C.a * (r : ZMod C.p)) := by ring
    _ = C.invA * (C.a * (C.rho : ZMod C.p)) := by rw [hmul]
    _ = (C.invA * C.a) * (C.rho : ZMod C.p) := by ring
    _ = (C.rho : ZMod C.p) := by rw [C.inverse_slope]; simp

end LiftCertificate

/-! ## The ten independently checkable local packets -/

def cert179 : LiftCertificate where
  p := 179
  x := 25502
  y := 14412
  c := 106
  d := 70
  a := 139
  rho := 119
  invA := 85
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert199 : LiftCertificate where
  p := 199
  x := 29745
  y := 15425
  c := 100
  d := 12
  a := 101
  rho := 66
  invA := 67
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert331 : LiftCertificate where
  p := 331
  x := 98136
  y := 83911
  c := 262
  d := 283
  a := 124
  rho := 110
  invA := 323
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert661 : LiftCertificate where
  p := 661
  x := 418077
  y := 165583
  c := 604
  d := 284
  a := 490
  rho := 220
  invA := 201
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert1069 : LiftCertificate where
  p := 1069
  x := 536098
  y := 495484
  c := 1003
  d := 719
  a := 871
  rho := 356
  invA := 1042
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert9791 : LiftCertificate where
  p := 9791
  x := 81984933
  y := 82797594
  c := 6956
  d := 1618
  a := 1286
  rho := 6527
  invA := 8215
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert39161 : LiftCertificate where
  p := 39161
  x := 1403079883
  y := 364138561
  c := 32496
  d := 30529
  a := 19166
  rho := 26107
  invA := 3165
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert68531 : LiftCertificate where
  p := 68531
  x := 1868669037
  y := 117085216
  c := 54535
  d := 61369
  a := 26543
  rho := 45687
  invA := 22150
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert474541 : LiftCertificate where
  p := 474541
  x := 172756888315
  y := 131160996968
  c := 253560
  d := 410060
  a := 286139
  rho := 158180
  invA := 459980
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

def cert1801361 : LiftCertificate where
  p := 1801361
  x := 2913131286738
  y := 1443939453785
  c := 1433006
  d := 1036614
  a := 696296
  rho := 1200907
  invA := 632234
  prime := by norm_num
  away_fixed := by decide
  alpha_base := by decide
  eta_step := by decide
  step_nilpotent := by decide
  base_remainder := by decide
  scaled_slope := by decide
  root := by decide
  inverse_slope := by decide
  rho_lt := by decide

structure TenPrimeResidues (r : ℕ) : Prop where
  mod179 : r ≡ 119 [MOD 179]
  mod199 : r ≡ 66 [MOD 199]
  mod331 : r ≡ 110 [MOD 331]
  mod661 : r ≡ 220 [MOD 661]
  mod1069 : r ≡ 356 [MOD 1069]
  mod9791 : r ≡ 6527 [MOD 9791]
  mod39161 : r ≡ 26107 [MOD 39161]
  mod68531 : r ≡ 45687 [MOD 68531]
  mod474541 : r ≡ 158180 [MOD 474541]
  mod1801361 : r ≡ 1200907 [MOD 1801361]

/-- Every one of the ten prime-square packets applies to the same progression
parameter forced by squarefullness. -/
theorem ten_prime_residues_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    ∃ r : ℕ, t = 326 + 979 * r ∧ TenPrimeResidues r := by
  obtain ⟨r, ht⟩ := index_shape_326_add_979_mul_of_K_twoFull hK
  have hKr : IsKFull 2 (K (326 + 979 * r)) := by
    simpa [ht] using hK
  refine ⟨r, ht, ?_⟩
  constructor
  · simpa only [cert179] using cert179.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert199] using cert199.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert331] using cert331.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert661] using cert661.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert1069] using cert1069.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert9791] using cert9791.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert39161] using cert39161.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert68531] using cert68531.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert474541] using cert474541.parameter_mod_prime_of_K_twoFull hKr
  · simpa only [cert1801361] using cert1801361.parameter_mod_prime_of_K_twoFull hKr

def forcedR : ℕ := 124756848858595532142808426058059599119

def forcedRModulus : ℕ := 187135273287893298214212639087089398679

namespace TenPrimeResidues

/-- Finite CRT assembly of the ten independently proved congruences. -/
theorem modEq_forcedR {r : ℕ} (h : TenPrimeResidues r) :
    r ≡ forcedR [MOD forcedRModulus] := by
  have h179 : r ≡ forcedR [MOD 179] := h.mod179.trans (by decide)
  have h199 : r ≡ forcedR [MOD 199] := h.mod199.trans (by decide)
  have h331 : r ≡ forcedR [MOD 331] := h.mod331.trans (by decide)
  have h661 : r ≡ forcedR [MOD 661] := h.mod661.trans (by decide)
  have h1069 : r ≡ forcedR [MOD 1069] := h.mod1069.trans (by decide)
  have h9791 : r ≡ forcedR [MOD 9791] := h.mod9791.trans (by decide)
  have h39161 : r ≡ forcedR [MOD 39161] := h.mod39161.trans (by decide)
  have h68531 : r ≡ forcedR [MOD 68531] := h.mod68531.trans (by decide)
  have h474541 : r ≡ forcedR [MOD 474541] :=
    h.mod474541.trans (by decide)
  have h1801361 : r ≡ forcedR [MOD 1801361] :=
    h.mod1801361.trans (by decide)
  have h12 : r ≡ forcedR [MOD 35621] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 179 199)).1 ⟨h179, h199⟩
  have h123 : r ≡ forcedR [MOD 11790551] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 35621 331)).1 ⟨h12, h331⟩
  have h1234 : r ≡ forcedR [MOD 7793554211] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 11790551 661)).1 ⟨h123, h661⟩
  have h12345 : r ≡ forcedR [MOD 8331309451559] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 7793554211 1069)).1 ⟨h1234, h1069⟩
  have h123456 : r ≡ forcedR [MOD 81571850840214169] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 8331309451559 9791)).1 ⟨h12345, h9791⟩
  have h1234567 : r ≡ forcedR [MOD 3194435250753627072209] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 81571850840214169 39161)).1
        ⟨h123456, h39161⟩
  have h12345678 : r ≡ forcedR [MOD 218917842169396816885554979] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 3194435250753627072209 68531)).1
        ⟨h1234567, h68531⟩
  have h123456789 :
      r ≡ forcedR [MOD 103885491740907734881688145289639] := by
    simpa using (Nat.modEq_and_modEq_iff_modEq_mul
      (by decide : Nat.Coprime 218917842169396816885554979 474541)).1
        ⟨h12345678, h474541⟩
  change r ≡ forcedR [MOD 187135273287893298214212639087089398679]
  simpa using (Nat.modEq_and_modEq_iff_modEq_mul
    (by decide :
      Nat.Coprime 103885491740907734881688145289639 1801361)).1
      ⟨h123456789, h1801361⟩

end TenPrimeResidues

def forcedT : ℕ := 122136955032565025967809449110840347537827

def forcedTModulus : ℕ := 183205432548847538951714173666260521306741

/-- The global symbolic index sieve: squarefullness forces one explicit
nonnegative arithmetic progression.  It makes no claim about whether that
surviving progression actually contains a squarefull value. -/
theorem global_index_shape_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    ∃ q : ℕ, t = forcedT + forcedTModulus * q := by
  obtain ⟨r, ht, hr⟩ := ten_prime_residues_of_K_twoFull hK
  have hcrt : r ≡ forcedR [MOD forcedRModulus] := hr.modEq_forcedR
  obtain ⟨q, hrq⟩ := exists_eq_residue_add_modulus_mul_of_modEq hcrt
    (by decide : forcedR < forcedRModulus)
  refine ⟨q, ?_⟩
  rw [ht, hrq]
  change 326 + 979 *
      (124756848858595532142808426058059599119 +
        187135273287893298214212639087089398679 * q) =
    122136955032565025967809449110840347537827 +
      183205432548847538951714173666260521306741 * q
  ring

theorem global_index_modEq_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    t ≡ forcedT [MOD forcedTModulus] := by
  obtain ⟨q, rfl⟩ := global_index_shape_of_K_twoFull hK
  change (forcedT + forcedTModulus * q) % forcedTModulus =
    forcedT % forcedTModulus
  simp

theorem forcedT_le_of_K_twoFull {t : ℕ}
    (hK : IsKFull 2 (K t)) :
    forcedT ≤ t := by
  obtain ⟨q, rfl⟩ := global_index_shape_of_K_twoFull hK
  exact Nat.le_add_right forcedT (forcedTModulus * q)

/-- Consequently every nonnegative index strictly below the explicit
threshold is ruled out by proof, not by interval enumeration. -/
theorem not_K_twoFull_below_forcedT {t : ℕ} (ht : t < forcedT) :
    ¬ IsKFull 2 (K t) := by
  intro hK
  exact (Nat.not_lt_of_ge (forcedT_le_of_K_twoFull hK)) ht

theorem forcedT_pos : 0 < forcedT := by decide

theorem forcedT_lt_modulus : forcedT < forcedTModulus := by decide

#print axioms global_index_shape_of_K_twoFull
#print axioms not_K_twoFull_below_forcedT

end DanilovGlobalIndexSieve20260831
end IUTThreeClosures
