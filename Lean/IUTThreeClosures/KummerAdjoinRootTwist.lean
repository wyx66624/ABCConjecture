/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.AdjoinRoot

/-!
# The universal Kummer root twist

For

`A = K[X] / (X^ell - q)`

and an `ell`-th root of unity `zeta`, substitution `X |-> zeta*X`
preserves the defining equation.  This module constructs the corresponding
endomorphism of the universal Kummer algebra and the inverse twist by
`zeta⁻¹`.

This is the algebraic source of the local inertia element used in the Tate
transvection formula.  A later local-field theorem must identify a concrete
Kummer extension and its Galois automorphism with this universal twist.
-/

namespace IUTThreeClosures

open Polynomial

universe u

namespace KummerAdjoinRoot

variable (K : Type u) [Field K]

/-- The Kummer polynomial `X^ell-q`. -/
def polynomial (ell : ℕ) (q : K) : K[X] :=
  X ^ ell - C q

/-- The universal Kummer algebra. -/
abbrev Algebra (ell : ℕ) (q : K) :=
  AdjoinRoot (polynomial K ell q)

variable {K}

/-- The canonical root has `ell`-th power `q`. -/
theorem root_pow_eq
    (ell : ℕ) (q : K) :
    (AdjoinRoot.root (polynomial K ell q)) ^ ell =
      algebraMap K (Algebra K ell q) q := by
  have h := AdjoinRoot.eval₂_root (polynomial K ell q)
  simpa [polynomial] using h

/-- Evaluation of the Kummer polynomial at a twisted root is zero. -/
theorem eval₂_twisted_root_eq_zero
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1) :
    Polynomial.eval₂
      (algebraMap K (Algebra K ell q))
      (algebraMap K (Algebra K ell q) ζ *
        AdjoinRoot.root (polynomial K ell q))
      (polynomial K ell q) = 0 := by
  rw [polynomial, eval₂_sub, eval₂_pow, eval₂_X, eval₂_C]
  rw [mul_pow, ← map_pow, hζ, map_one, one_mul]
  rw [root_pow_eq]
  ring

/-- The universal twist sending the Kummer root to `zeta*root`. -/
noncomputable def twistHom
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1) :
    Algebra K ell q →+* Algebra K ell q :=
  AdjoinRoot.liftHom
    (polynomial K ell q)
    (algebraMap K (Algebra K ell q))
    (algebraMap K (Algebra K ell q) ζ *
      AdjoinRoot.root (polynomial K ell q))
    (eval₂_twisted_root_eq_zero ell q ζ hζ)

@[simp]
theorem twistHom_root
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1) :
    twistHom ell q ζ hζ
        (AdjoinRoot.root (polynomial K ell q)) =
      algebraMap K (Algebra K ell q) ζ *
        AdjoinRoot.root (polynomial K ell q) := by
  simp [twistHom]

@[simp]
theorem twistHom_algebraMap
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1)
    (x : K) :
    twistHom ell q ζ hζ (algebraMap K (Algebra K ell q) x) =
      algebraMap K (Algebra K ell q) x := by
  simp [twistHom]

/-- The inverse root of unity also has `ell`-th power one. -/
theorem inv_pow_eq_one
    (ell : ℕ) (ζ : K)
    (hζ : ζ ^ ell = 1) :
    ζ⁻¹ ^ ell = 1 := by
  rw [inv_pow, hζ, inv_one]

/-- Twisting by `zeta⁻¹` after twisting by `zeta` fixes the canonical root. -/
theorem inv_twist_comp_root
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1)
    (hζ0 : ζ ≠ 0) :
    twistHom ell q ζ⁻¹ (inv_pow_eq_one ell ζ hζ)
        (twistHom ell q ζ hζ
          (AdjoinRoot.root (polynomial K ell q))) =
      AdjoinRoot.root (polynomial K ell q) := by
  rw [twistHom_root, map_mul, twistHom_algebraMap, twistHom_root]
  rw [← mul_assoc, inv_mul_cancel₀ hζ0, one_mul]

/-- Twisting by `zeta` after twisting by `zeta⁻¹` fixes the canonical root. -/
theorem twist_comp_inv_root
    (ell : ℕ) (q ζ : K)
    (hζ : ζ ^ ell = 1)
    (hζ0 : ζ ≠ 0) :
    twistHom ell q ζ hζ
        (twistHom ell q ζ⁻¹ (inv_pow_eq_one ell ζ hζ)
          (AdjoinRoot.root (polynomial K ell q))) =
      AdjoinRoot.root (polynomial K ell q) := by
  rw [twistHom_root, map_mul, twistHom_algebraMap, twistHom_root]
  rw [mul_assoc, mul_inv_cancel₀ hζ0, one_mul]

end KummerAdjoinRoot

end IUTThreeClosures
