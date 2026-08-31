/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SquarePartExponentWeight
import Mathlib.Tactic

/-!
# From simultaneous square parts to a moving Pell norm equation

Every finite exponent profile has the canonical decomposition

`N = parityKernel * canonicalSquareRoot^2`.

Applying this separately to two integers `M,c` with `m+M=c` yields

`m + u*x^2 = v*y^2`.

Multiplication by `v` gives the norm-form identity

`(v*y)^2 = (u*v)*x^2 + v*m`.

This is the exact moving-coefficient Pell equation forced by simultaneous
large square parts.  The file proves only the algebraic bridge; it does not
assume a uniform theorem for the resulting moving quadratic fields.
-/

namespace IUTThreeClosures
namespace PowerSquareGapPellBridge

noncomputable section

variable {ι : Type*}

/-- The squarefree-parity coefficient of a finite exponent profile. -/
def parityKernel
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  exponentResidueKernel 2 s base exponent

/-- The canonical extracted square root of a finite exponent profile. -/
def canonicalSquareRoot
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  exponentQuotientRoot 2 s base exponent

/-- Exact canonical square decomposition of a finite profile. -/
theorem exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
    (s : Finset ι) (base exponent : ι → ℕ) :
    exponentProfileProduct s base exponent =
      parityKernel s base exponent *
        canonicalSquareRoot s base exponent ^ 2 := by
  simpa [parityKernel, canonicalSquareRoot] using
    exponentProfileProduct_eq_kernel_mul_root_pow
      2 s base exponent

/-- Elementary square-gap identity. -/
theorem square_gap_equation
    {m M c u v x y : ℕ}
    (hM : M = u * x ^ 2)
    (hc : c = v * y ^ 2)
    (hgap : m + M = c) :
    m + u * x ^ 2 = v * y ^ 2 := by
  calc
    m + u * x ^ 2 = m + M := by rw [hM]
    _ = c := hgap
    _ = v * y ^ 2 := hc

/-- The square-gap equation is equivalently a positive Pell norm equation. -/
theorem square_gap_to_pell_norm_equation
    {m u v x y : ℕ}
    (hgap : m + u * x ^ 2 = v * y ^ 2) :
    (v * y) ^ 2 = (u * v) * x ^ 2 + v * m := by
  calc
    (v * y) ^ 2 = v * (v * y ^ 2) := by ring
    _ = v * (m + u * x ^ 2) := by rw [← hgap]
    _ = (u * v) * x ^ 2 + v * m := by ring

/-- Two finite profiles separated by an additive gap produce the canonical
moving Pell norm identity. -/
theorem profile_gap_to_pell_norm_equation
    (sM sc : Finset ι)
    (baseM exponentM basec exponentc : ι → ℕ)
    (m : ℕ)
    (hgap :
      m + exponentProfileProduct sM baseM exponentM =
        exponentProfileProduct sc basec exponentc) :
    let u := parityKernel sM baseM exponentM
    let x := canonicalSquareRoot sM baseM exponentM
    let v := parityKernel sc basec exponentc
    let y := canonicalSquareRoot sc basec exponentc
    (v * y) ^ 2 = (u * v) * x ^ 2 + v * m := by
  dsimp
  have hM :=
    exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
      sM baseM exponentM
  have hc :=
    exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
      sc basec exponentc
  have hsquare :
      m + parityKernel sM baseM exponentM *
          canonicalSquareRoot sM baseM exponentM ^ 2 =
        parityKernel sc basec exponentc *
          canonicalSquareRoot sc basec exponentc ^ 2 := by
    calc
      m + parityKernel sM baseM exponentM *
          canonicalSquareRoot sM baseM exponentM ^ 2 =
        m + exponentProfileProduct sM baseM exponentM := by rw [hM]
      _ = exponentProfileProduct sc basec exponentc := hgap
      _ = parityKernel sc basec exponentc *
          canonicalSquareRoot sc basec exponentc ^ 2 := hc
  exact square_gap_to_pell_norm_equation hsquare

#print axioms exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
#print axioms square_gap_equation
#print axioms square_gap_to_pell_norm_equation
#print axioms profile_gap_to_pell_norm_equation

end
end PowerSquareGapPellBridge
end IUTThreeClosures
