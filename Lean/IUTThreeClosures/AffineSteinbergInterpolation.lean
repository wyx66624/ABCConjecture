/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Affine Steinberg interpolation

For a finite field `F`, let `n` be a positive exponent such that every nonzero
field element has `n`-th power one and such that the cardinality of `F`
vanishes in `F`.  This module proves the coefficient-vanishing argument behind
the affine interpolation basis

`{(Y - t X)^n | t in F}`.

If a linear combination vanishes after evaluating at every affine point, then
all coefficients are zero.  For `F = ZMod ell`, `ell` prime and
`n = ell - 1`, the hypotheses are Fermat's theorem and characteristic `ell`.
This is the source-independent finite-field core of the explicit
Steinberg-to-symmetric-power bridge.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- The affine interpolation evaluation associated with coefficients `c` and
exponent `n`. -/
noncomputable def affineSteinbergEvaluation
    {F : Type*} [Field F] [Fintype F]
    (n : ℕ) (c : F → F) (s : F) : F :=
  ∑ t : F, c t * (s - t) ^ n

/-- **Affine Steinberg coefficient-vanishing theorem.**

Suppose `n > 0`, every nonzero element of the finite field has `n`-th power
one, and the cardinality of the field is zero after casting into the field.
If the affine interpolation evaluation vanishes at every point, then every
coefficient vanishes.

For `n = card F - 1` the first power hypothesis is the finite-field Fermat
theorem.  The proof is the elementary delta-function argument: at `s`, the
factor `(s-t)^n` is zero for `t=s` and one otherwise. -/
theorem affineSteinberg_coefficients_eq_zero
    {F : Type*} [Field F] [Fintype F]
    (n : ℕ)
    (hn : 0 < n)
    (hpow : ∀ x : F, x ≠ 0 → x ^ n = 1)
    (hcard : (Fintype.card F : F) = 0)
    (c : F → F)
    (hvanish : ∀ s : F, affineSteinbergEvaluation n c s = 0) :
    ∀ t : F, c t = 0 := by
  classical
  let S : F := ∑ t : F, c t
  have herase (s : F) :
      ∑ t in Finset.univ.erase s, c t = 0 := by
    calc
      ∑ t in Finset.univ.erase s, c t =
          ∑ t in Finset.univ.erase s, c t * (s - t) ^ n := by
        apply Finset.sum_congr rfl
        intro t ht
        have hts : t ≠ s := Finset.ne_of_mem_erase ht
        have hne : s - t ≠ 0 := sub_ne_zero.mpr hts.symm
        rw [hpow (s - t) hne, mul_one]
      _ = ∑ t in Finset.univ, c t * (s - t) ^ n := by
        let f : F → F := fun t => c t * (s - t) ^ n
        have hsplit :=
          Finset.sum_erase_add Finset.univ f (Finset.mem_univ s)
        change
          (∑ t in Finset.univ.erase s, f t) =
            ∑ t in Finset.univ, f t
        calc
          (∑ t in Finset.univ.erase s, f t) =
              (∑ t in Finset.univ.erase s, f t) + f s := by
            simp [f, hn.ne']
          _ = ∑ t in Finset.univ, f t := hsplit
      _ = 0 := by
        simpa [affineSteinbergEvaluation] using hvanish s
  have hSc (s : F) : S = c s := by
    calc
      S = ∑ t in Finset.univ.erase s, c t + c s := by
        dsimp [S]
        exact
          (Finset.sum_erase_add Finset.univ c
            (Finset.mem_univ s)).symm
      _ = c s := by rw [herase s, zero_add]
  have hS : S = 0 := by
    calc
      S = ∑ s : F, c s := rfl
      _ = ∑ _s : F, S := by
        apply Finset.sum_congr rfl
        intro s _hs
        exact (hSc s).symm
      _ = 0 := by
        simp [nsmul_eq_mul, hcard]
  intro t
  rw [← hSc t, hS]

/-- Injectivity packaging of `affineSteinberg_coefficients_eq_zero`. -/
theorem affineSteinbergEvaluation_injective
    {F : Type*} [Field F] [Fintype F]
    (n : ℕ)
    (hn : 0 < n)
    (hpow : ∀ x : F, x ≠ 0 → x ^ n = 1)
    (hcard : (Fintype.card F : F) = 0) :
    Function.Injective
      (fun c : F → F => fun s : F =>
        affineSteinbergEvaluation n c s) := by
  intro c d hcd
  funext t
  let e : F → F := fun x => c x - d x
  have heval : ∀ s : F, affineSteinbergEvaluation n e s = 0 := by
    intro s
    have hs := congrFun hcd s
    simp only [affineSteinbergEvaluation] at hs ⊢
    dsimp [e]
    rw [Finset.sum_sub_distrib]
    simpa [sub_mul] using sub_eq_zero.mpr hs
  have he := affineSteinberg_coefficients_eq_zero
    n hn hpow hcard e heval t
  dsimp [e] at he
  exact sub_eq_zero.mp he

end IUTThreeClosures
