/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteFermatOpenRing
import IUTThreeClosures.ConcreteGenEllTripodCover

/-!
# The three boundary fibres of the Fermat power map

Let `K` be a field, let `n > 0`, and consider the homogeneous Fermat
equation

`X^n + Y^n = Z^n`.

The classical power map is given in homogeneous coordinates by

`beta [X:Y:Z] = [X^n : Z^n]`.

This file records the following elementary mathematical proof before
formalizing its coordinate-ring consequences.

## Mathematical proof

First, the displayed pair cannot be `(0,0)` at a nonzero Fermat triple.  If
`X^n = Z^n = 0`, then `X = Z = 0`; the Fermat equation then gives `Y^n = 0`,
and hence `Y = 0`, a contradiction.

On the chart `Z != 0`, put `x = X/Z`, `y = Y/Z`, and `t = beta = x^n`.
The Fermat equation becomes

`x^n + y^n = 1`,

so `1-t = y^n`.  Consequently the fibres over the three distinguished
values have the following coordinate descriptions:

* over `0`: `X = 0`, and the equation reduces to `Y^n = Z^n`;
* over `1`: `Y = 0`, and the equation reduces to `X^n = Z^n`;
* over `infinity`: `Z = 0`, and the equation reduces to
  `X^n + Y^n = 0`.

The complement of these fibres is exactly `XYZ != 0`.  Its base has
coordinate ring

`A = K[t, t^{-1}, (1-t)^{-1}]`.

Over `A`, the Fermat algebra is obtained by adjoining successively

`x^n = t` and `y^n = 1-t`.

Both right-hand sides are units.  In characteristic zero, `n` is a unit as
well, so the two derivatives `n*x^(n-1)` and `n*y^(n-1)` are units.  The
explicit Kummer Bezout identities constructed in
`ConcreteGenEllKummerCover` therefore make both steps standard etale.  Their
composite is finite etale, free of rank `n^2`.  Thus the power map has no
ramification away from `0`, `1`, and `infinity` on this affine open.

Finally, the three local power identities are

`t = x^n`, `1-t = y^n`, and `1/t = (Z/X)^n`.

They are the coordinate-level source of ramification exponent `n` at the
three boundary fibres.  We do **not** promote these identities here to a
theorem about discrete valuation rings, ramification indices, projective
schemes, or a scheme-level Belyi cover.  Such a promotion still requires a
projective compactification and local-ring/valuation arguments.
-/

namespace IUTThreeClosures
namespace ConcreteFermatBelyiRamification

noncomputable section

universe u

variable {K : Type u} [Field K]

/-! ## Coordinate description of the homogeneous map -/

/-- The homogeneous Fermat equation at a coordinate triple. -/
def IsHomogeneousFermatTriple (n : ℕ) (x y z : K) : Prop :=
  x ^ n + y ^ n = z ^ n

/-- The elementary nonzero-coordinate condition for a projective
representative. -/
def IsNonzeroTriple (x y z : K) : Prop :=
  x ≠ 0 ∨ y ≠ 0 ∨ z ≠ 0

/-- The homogeneous coordinate pair `[X^n:Z^n]` underlying the power map.
No projective-space quotient is constructed by this definition. -/
def betaCoordinatePair (n : ℕ) (x z : K) : K × K :=
  (x ^ n, z ^ n)

/-- At a nonzero homogeneous Fermat triple, the two coordinates defining
`beta` cannot vanish simultaneously.  This is the coordinate-level
well-definedness check for `[X^n:Z^n]`. -/
theorem betaCoordinatePair_not_both_zero
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z)
    (hxyz : IsNonzeroTriple x y z) :
    x ^ n ≠ 0 ∨ z ^ n ≠ 0 := by
  by_contra h
  push Not at h
  have hx : x = 0 := (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp h.1
  have hz : z = 0 := (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp h.2
  have hyPow : y ^ n = 0 := by
    simpa [IsHomogeneousFermatTriple, hx, hz, Nat.ne_of_gt hn] using hF
  have hy : y = 0 := (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hyPow
  exact hxyz.elim (fun hxn => hxn hx)
    (fun hyz => hyz.elim (fun hyn => hyn hy) (fun hzn => hzn hz))

/-- The fibre over zero is described by `X = 0`; on that fibre the Fermat
equation becomes `Y^n = Z^n`. -/
theorem zeroFiber_coordinates
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z) :
    x ^ n = 0 ↔ x = 0 ∧ y ^ n = z ^ n := by
  constructor
  · intro hxPow
    have hx : x = 0 :=
      (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hxPow
    refine ⟨hx, ?_⟩
    simpa [IsHomogeneousFermatTriple, hx, Nat.ne_of_gt hn] using hF
  · rintro ⟨hx, -⟩
    simp [hx, Nat.ne_of_gt hn]

/-- On the finite chart `Z != 0`, the fibre over one is exactly `Y = 0`.
The hypothesis `Z != 0` records that `[X^n:Z^n]` is being compared with
`[1:1]`; the coordinate equivalence itself follows from the Fermat
equation. -/
theorem oneFiber_coordinates
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z) (_hz : z ≠ 0) :
    x ^ n = z ^ n ↔ y = 0 := by
  constructor
  · intro hxz
    have hyPow : y ^ n = 0 := by
      rw [IsHomogeneousFermatTriple, hxz] at hF
      apply add_left_cancel (a := z ^ n)
      simpa using hF
    exact (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hyPow
  · intro hy
    simpa [IsHomogeneousFermatTriple, hy, Nat.ne_of_gt hn] using hF

/-- The fibre over infinity is described by `Z = 0`; there the equation is
`X^n + Y^n = 0`. -/
theorem infinityFiber_coordinates
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z) :
    z ^ n = 0 ↔ z = 0 ∧ x ^ n + y ^ n = 0 := by
  constructor
  · intro hzPow
    have hz : z = 0 :=
      (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hzPow
    refine ⟨hz, ?_⟩
    simpa [IsHomogeneousFermatTriple, hz, Nat.ne_of_gt hn] using hF
  · rintro ⟨hz, -⟩
    simp [hz, Nat.ne_of_gt hn]

/-- At a nonzero Fermat triple in the infinity fibre, both `X` and `Y` are
nonzero.  Hence the `X != 0` chart used for the inverse-beta parameter is
available. -/
theorem infinityFiber_XY_ne_zero
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z)
    (hxyz : IsNonzeroTriple x y z) (hz : z = 0) :
    x ≠ 0 ∧ y ≠ 0 := by
  have hsum : x ^ n + y ^ n = 0 := by
    simpa [IsHomogeneousFermatTriple, hz, Nat.ne_of_gt hn] using hF
  constructor
  · intro hx
    have hyPow : y ^ n = 0 := by
      simpa [hx, Nat.ne_of_gt hn] using hsum
    have hy : y = 0 :=
      (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hyPow
    exact hxyz.elim (fun hxn => hxn hx)
      (fun hyz => hyz.elim (fun hyn => hyn hy) (fun hzn => hzn hz))
  · intro hy
    have hxPow : x ^ n = 0 := by
      simpa [hy, Nat.ne_of_gt hn] using hsum
    have hx : x = 0 :=
      (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hxPow
    exact hxyz.elim (fun hxn => hxn hx)
      (fun hyz => hyz.elim (fun hyn => hyn hy) (fun hzn => hzn hz))

/-- Outside the three target values `0`, `1`, and `infinity`, all three
Fermat coordinates are nonzero, and conversely.  The right side is the
homogeneous-coordinate formulation of
`[X^n:Z^n] notin {0,1,infinity}`. -/
theorem outsideThreeFibres_iff_XYZ_ne_zero
    {n : ℕ} (hn : 0 < n) {x y z : K}
    (hF : IsHomogeneousFermatTriple n x y z) :
    (x ^ n ≠ 0 ∧ z ^ n ≠ 0 ∧ x ^ n ≠ z ^ n) ↔
      (x ≠ 0 ∧ y ≠ 0 ∧ z ≠ 0) := by
  constructor
  · rintro ⟨hxPow, hzPow, hxz⟩
    have hx : x ≠ 0 := by
      simpa [pow_eq_zero_iff (Nat.ne_of_gt hn)] using hxPow
    have hz : z ≠ 0 := by
      simpa [pow_eq_zero_iff (Nat.ne_of_gt hn)] using hzPow
    have hy : y ≠ 0 := by
      intro hy
      apply hxz
      simpa [IsHomogeneousFermatTriple, hy, Nat.ne_of_gt hn] using hF
    exact ⟨hx, hy, hz⟩
  · rintro ⟨hx, hy, hz⟩
    refine ⟨pow_ne_zero n hx, pow_ne_zero n hz, ?_⟩
    intro hxz
    have hyPow : y ^ n = 0 := by
      rw [IsHomogeneousFermatTriple, hxz] at hF
      apply add_left_cancel (a := z ^ n)
      simpa using hF
    exact (pow_ne_zero n hy) hyPow

/-! ## Affine and boundary local power identities -/

/-- On `Z = 1`, the power-map coordinate is `beta = x^n`. -/
def affineBeta (n : ℕ) (x : K) : K :=
  x ^ n

/-- The affine Fermat equation. -/
def IsAffineFermatPoint (n : ℕ) (x y : K) : Prop :=
  x ^ n + y ^ n = 1

/-- The zero-boundary local power identity `beta = x^n`. -/
theorem zeroParameter_power_law (n : ℕ) (x : K) :
    affineBeta n x = x ^ n := rfl

/-- The one-boundary local power identity `1-beta = y^n`. -/
theorem oneParameter_power_law
    {n : ℕ} {x y : K} (hF : IsAffineFermatPoint n x y) :
    1 - affineBeta n x = y ^ n := by
  rw [affineBeta, sub_eq_iff_eq_add]
  simpa [IsAffineFermatPoint, add_comm] using hF.symm

/-- On the affine Fermat curve, `beta = 0` is equivalent to `x = 0`. -/
theorem affineBeta_eq_zero_iff
    {n : ℕ} (hn : 0 < n) (x : K) :
    affineBeta n x = 0 ↔ x = 0 := by
  exact pow_eq_zero_iff (Nat.ne_of_gt hn)

/-- On the affine Fermat curve, `beta = 1` is equivalent to `y = 0`. -/
theorem affineBeta_eq_one_iff
    {n : ℕ} (hn : 0 < n) {x y : K}
    (hF : IsAffineFermatPoint n x y) :
    affineBeta n x = 1 ↔ y = 0 := by
  constructor
  · intro hbeta
    have hyPow : y ^ n = 0 := by
      rw [← oneParameter_power_law hF, hbeta, sub_self]
    exact (pow_eq_zero_iff (Nat.ne_of_gt hn)).mp hyPow
  · intro hy
    have h := oneParameter_power_law hF
    rw [hy, zero_pow (Nat.ne_of_gt hn)] at h
    exact (sub_eq_zero.mp h).symm

/-- The local coordinate at infinity on the `X != 0` chart. -/
def infinityParameter (x z : K) : K :=
  z / x

/-- The inverse of the homogeneous power-map coordinate on the `X != 0`
chart. -/
def inverseBeta (n : ℕ) (x z : K) : K :=
  z ^ n / x ^ n

/-- The infinity-boundary local power identity
`1/beta = (Z/X)^n`. -/
theorem infinityParameter_power_law (n : ℕ) (x z : K) :
    inverseBeta n x z = infinityParameter x z ^ n := by
  simp [inverseBeta, infinityParameter, div_pow]

/-! ## Derivative units on the honest affine Fermat open -/

namespace OpenRing

open ConcreteFermatOpenRing

variable (K)

/-- The power-map coordinate in the honest localized affine Fermat ring. -/
def beta (n : ℕ) : FermatOpenRing K n :=
  openX K n ^ n

/-- The complement of the power-map coordinate is the `n`-th power of the
second Fermat coordinate. -/
theorem one_sub_beta_eq_openY_pow (n : ℕ) :
    1 - beta K n = openY K n ^ n := by
  rw [beta, ConcreteFermatOpenRing.openY_pow_eq_one_sub_openX_pow]

/-- The power-map coordinate is a unit on the open where `x != 0`. -/
theorem beta_isUnit (n : ℕ) : IsUnit (beta K n) :=
  (ConcreteFermatOpenRing.openX_isUnit K n).pow n

/-- The complementary coordinate `1-beta` is a unit on the open where
`y != 0`. -/
theorem one_sub_beta_isUnit (n : ℕ) : IsUnit (1 - beta K n) := by
  simpa [beta] using ConcreteFermatOpenRing.openOneSubXPow_isUnit K n

/-- The formal derivative `n*x^(n-1)` of `x^n=t`, evaluated in the honest
open Fermat ring. -/
def betaDerivativeX (n : ℕ) : FermatOpenRing K n :=
  (n : FermatOpenRing K n) * openX K n ^ (n - 1)

/-- The formal derivative `n*y^(n-1)` of `y^n=1-t`, evaluated in the honest
open Fermat ring. -/
def betaDerivativeY (n : ℕ) : FermatOpenRing K n :=
  (n : FermatOpenRing K n) * openY K n ^ (n - 1)

/-- In characteristic zero, the first Kummer derivative is a unit on the
honest affine open. -/
theorem betaDerivativeX_isUnit
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    IsUnit (betaDerivativeX K n) := by
  have hnK : IsUnit (n : K) :=
    isUnit_iff_ne_zero.mpr (Nat.cast_ne_zero.mpr (Nat.ne_of_gt hn))
  have hnOpen : IsUnit (n : FermatOpenRing K n) := by
    simpa using hnK.map (algebraMap K (FermatOpenRing K n))
  exact hnOpen.mul ((ConcreteFermatOpenRing.openX_isUnit K n).pow (n - 1))

/-- In characteristic zero, the second Kummer derivative is a unit on the
honest affine open. -/
theorem betaDerivativeY_isUnit
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    IsUnit (betaDerivativeY K n) := by
  have hnK : IsUnit (n : K) :=
    isUnit_iff_ne_zero.mpr (Nat.cast_ne_zero.mpr (Nat.ne_of_gt hn))
  have hnOpen : IsUnit (n : FermatOpenRing K n) := by
    simpa using hnK.map (algebraMap K (FermatOpenRing K n))
  exact hnOpen.mul
    ((ConcreteFermatOpenRing.openY_isUnit K hn).pow (n - 1))

end OpenRing

/-! ## The finite-etale certificate on the punctured target -/

namespace TripodCertificate

open ConcreteGenEllTripodCover

variable (K) [CharZero K]

/-- The two explicit Kummer steps prove that the Fermat power map is etale
over `Spec K[t,t^-1,(1-t)^-1]`.  This is precisely the algebraic
nonramification certificate away from the three boundary values. -/
theorem beta_etale_away_from_zero_one_infinity
    (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Algebra.Etale (TripodRing K) (FermatAffineRing K n hn) :=
  fermat_etale_over_tripod K n hn

/-- The same affine-open map is finite. -/
theorem beta_finite_away_from_zero_one_infinity
    (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.Finite (TripodRing K) (FermatAffineRing K n hn) :=
  fermat_finite_over_tripod K n hn

/-- Its exact module rank over the punctured target is `n^2`. -/
theorem beta_finrank_away_from_zero_one_infinity
    (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.finrank (TripodRing K) (FermatAffineRing K n hn) = n ^ 2 :=
  fermat_finrank_over_tripod K n hn

/-- In the finite-etale presentation, the base coordinate is exactly the
`n`-th power of the Fermat `x` coordinate. -/
theorem beta_eq_fermatX_pow
    (n : ℕ) (hn : n ≠ 0) :
    fermatT K n hn = fermatX K n hn ^ n :=
  (fermatX_pow_eq_t K n hn).symm

/-- The complementary target coordinate is exactly the `n`-th power of the
Fermat `y` coordinate. -/
theorem one_sub_beta_eq_fermatY_pow
    (n : ℕ) (hn : n ≠ 0) :
    1 - fermatT K n hn = fermatY K n hn ^ n :=
  (fermatY_pow_eq_one_sub_t K n hn).symm

end TripodCertificate

end

end ConcreteFermatBelyiRamification
end IUTThreeClosures
