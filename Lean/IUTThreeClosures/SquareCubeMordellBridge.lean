/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PowerSquareGapPellBridge
import IUTThreeClosures.LargeEndpointCubeRootSelector
import Mathlib.Tactic

/-!
# Mixed square-cube decompositions and integral Mordell points

If one large endpoint is written as a canonical cube times a cubic residue
kernel and the other as a canonical square times a parity kernel, the additive
abc relation becomes a mixed `(3,2)` or `(2,3)` equation.

A direct integral scaling embeds either equation into a Mordell curve:

* `m + A*X^3 = B*Y^2` gives
  `(A*B^2*Y)^2 = (A*B*X)^3 + A^2*B^3*m`;
* `m + A*X^2 = B*Y^3` gives
  `(A*B*Y)^3 = (A^2*B*X)^2 + A^3*B^2*m`.

The file proves only these exact identities.  It does not assume a uniform
height bound for integral points in the resulting moving Mordell family.
-/

namespace IUTThreeClosures
namespace SquareCubeMordellBridge

open PowerSquareGapPellBridge

noncomputable section

variable {ι : Type*}

/-- The cubic residue kernel of a finite exponent profile. -/
def cubicKernel
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  exponentResidueKernel 3 s base exponent

/-- The canonical extracted cube root of a finite exponent profile. -/
def canonicalCubeRoot
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  exponentQuotientRoot 3 s base exponent

/-- Exact canonical cubic decomposition of a finite profile. -/
theorem exponentProfileProduct_eq_cubicKernel_mul_cubeRoot_cube
    (s : Finset ι) (base exponent : ι → ℕ) :
    exponentProfileProduct s base exponent =
      cubicKernel s base exponent *
        canonicalCubeRoot s base exponent ^ 3 := by
  simpa [cubicKernel, canonicalCubeRoot] using
    exponentProfileProduct_eq_kernel_mul_root_pow
      3 s base exponent

/-- A mixed cube-square gap gives an integral point on a positive Mordell
curve. -/
theorem cube_square_gap_to_mordell_identity
    {m A B X Y : ℕ}
    (hgap : m + A * X ^ 3 = B * Y ^ 2) :
    (A * B ^ 2 * Y) ^ 2 =
      (A * B * X) ^ 3 + A ^ 2 * B ^ 3 * m := by
  calc
    (A * B ^ 2 * Y) ^ 2 = A ^ 2 * B ^ 3 * (B * Y ^ 2) := by ring
    _ = A ^ 2 * B ^ 3 * (m + A * X ^ 3) := by rw [← hgap]
    _ = (A * B * X) ^ 3 + A ^ 2 * B ^ 3 * m := by ring

/-- A mixed square-cube gap gives the corresponding negative Mordell identity,
written without natural-number subtraction. -/
theorem square_cube_gap_to_mordell_identity
    {m A B X Y : ℕ}
    (hgap : m + A * X ^ 2 = B * Y ^ 3) :
    (A * B * Y) ^ 3 =
      (A ^ 2 * B * X) ^ 2 + A ^ 3 * B ^ 2 * m := by
  calc
    (A * B * Y) ^ 3 = A ^ 3 * B ^ 2 * (B * Y ^ 3) := by ring
    _ = A ^ 3 * B ^ 2 * (m + A * X ^ 2) := by rw [← hgap]
    _ = (A ^ 2 * B * X) ^ 2 + A ^ 3 * B ^ 2 * m := by ring

/-- Canonical cube decomposition on the first profile and square decomposition
on the second profile produce a positive Mordell identity. -/
theorem profile_cube_square_gap_to_mordell_identity
    (s₁ s₂ : Finset ι)
    (base₁ exponent₁ base₂ exponent₂ : ι → ℕ)
    (m : ℕ)
    (hgap :
      m + exponentProfileProduct s₁ base₁ exponent₁ =
        exponentProfileProduct s₂ base₂ exponent₂) :
    let A := cubicKernel s₁ base₁ exponent₁
    let X := canonicalCubeRoot s₁ base₁ exponent₁
    let B := parityKernel s₂ base₂ exponent₂
    let Y := canonicalSquareRoot s₂ base₂ exponent₂
    (A * B ^ 2 * Y) ^ 2 =
      (A * B * X) ^ 3 + A ^ 2 * B ^ 3 * m := by
  dsimp
  have hcube :=
    exponentProfileProduct_eq_cubicKernel_mul_cubeRoot_cube
      s₁ base₁ exponent₁
  have hsquare :=
    exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
      s₂ base₂ exponent₂
  have hmixed :
      m + cubicKernel s₁ base₁ exponent₁ *
          canonicalCubeRoot s₁ base₁ exponent₁ ^ 3 =
        parityKernel s₂ base₂ exponent₂ *
          canonicalSquareRoot s₂ base₂ exponent₂ ^ 2 := by
    calc
      m + cubicKernel s₁ base₁ exponent₁ *
          canonicalCubeRoot s₁ base₁ exponent₁ ^ 3 =
        m + exponentProfileProduct s₁ base₁ exponent₁ := by rw [hcube]
      _ = exponentProfileProduct s₂ base₂ exponent₂ := hgap
      _ = parityKernel s₂ base₂ exponent₂ *
          canonicalSquareRoot s₂ base₂ exponent₂ ^ 2 := hsquare
  exact cube_square_gap_to_mordell_identity hmixed

/-- Canonical square decomposition on the first profile and cube decomposition
on the second profile produce the complementary Mordell identity. -/
theorem profile_square_cube_gap_to_mordell_identity
    (s₁ s₂ : Finset ι)
    (base₁ exponent₁ base₂ exponent₂ : ι → ℕ)
    (m : ℕ)
    (hgap :
      m + exponentProfileProduct s₁ base₁ exponent₁ =
        exponentProfileProduct s₂ base₂ exponent₂) :
    let A := parityKernel s₁ base₁ exponent₁
    let X := canonicalSquareRoot s₁ base₁ exponent₁
    let B := cubicKernel s₂ base₂ exponent₂
    let Y := canonicalCubeRoot s₂ base₂ exponent₂
    (A * B * Y) ^ 3 =
      (A ^ 2 * B * X) ^ 2 + A ^ 3 * B ^ 2 * m := by
  dsimp
  have hsquare :=
    exponentProfileProduct_eq_parityKernel_mul_squareRoot_sq
      s₁ base₁ exponent₁
  have hcube :=
    exponentProfileProduct_eq_cubicKernel_mul_cubeRoot_cube
      s₂ base₂ exponent₂
  have hmixed :
      m + parityKernel s₁ base₁ exponent₁ *
          canonicalSquareRoot s₁ base₁ exponent₁ ^ 2 =
        cubicKernel s₂ base₂ exponent₂ *
          canonicalCubeRoot s₂ base₂ exponent₂ ^ 3 := by
    calc
      m + parityKernel s₁ base₁ exponent₁ *
          canonicalSquareRoot s₁ base₁ exponent₁ ^ 2 =
        m + exponentProfileProduct s₁ base₁ exponent₁ := by rw [hsquare]
      _ = exponentProfileProduct s₂ base₂ exponent₂ := hgap
      _ = cubicKernel s₂ base₂ exponent₂ *
          canonicalCubeRoot s₂ base₂ exponent₂ ^ 3 := hcube
  exact square_cube_gap_to_mordell_identity hmixed

#print axioms exponentProfileProduct_eq_cubicKernel_mul_cubeRoot_cube
#print axioms cube_square_gap_to_mordell_identity
#print axioms square_cube_gap_to_mordell_identity
#print axioms profile_cube_square_gap_to_mordell_identity
#print axioms profile_square_cube_gap_to_mordell_identity

end
end SquareCubeMordellBridge
end IUTThreeClosures
