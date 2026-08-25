/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteFermatIrreducibility
import IUTThreeClosures.ConcreteGenEllTripodCover
import Mathlib.RingTheory.Localization.Away.Basic

/-!
# The honest affine open Fermat ring

Starting from the integral-domain presentation

`K[X][Y] / (Y^n - (1 - X^n))`,

this module inverts the boundary element `x * (1 - x^n) = x * y^n`.
The resulting localization is an actual nontrivial domain in which both
Fermat coordinates are units and still satisfy `x^n + y^n = 1`.

This is only an affine open coordinate ring.  No compactification, points at
infinity, ramification theorem, or Belyi map is asserted here.
-/

namespace IUTThreeClosures
namespace ConcreteFermatOpenRing

noncomputable section

open Polynomial

universe u

variable (K : Type u) [Field K]

namespace CFI

abbrev boundaryPolynomial :=
  ConcreteFermatIrreducibility.boundaryPolynomial

abbrev fermatPolynomial :=
  ConcreteFermatIrreducibility.fermatPolynomial

abbrev FermatAffineRing :=
  ConcreteFermatIrreducibility.FermatAffineRing

end CFI

/-- The image of the coefficient variable `X` in the affine Fermat ring. -/
def affineX (n : ℕ) : CFI.FermatAffineRing K n :=
  algebraMap K[X] (CFI.FermatAffineRing K n) X

/-- The adjoined root, i.e. the `Y` coordinate in the affine Fermat ring. -/
def affineY (n : ℕ) : CFI.FermatAffineRing K n :=
  AdjoinRoot.root (CFI.fermatPolynomial K n)

/-- The defining polynomial has positive degree `n` in the `Y` variable. -/
theorem fermatPolynomial_degree {n : ℕ} (hn : 0 < n) :
    (CFI.fermatPolynomial K n).degree = n := by
  rw [CFI.fermatPolynomial,
    ConcreteFermatIrreducibility.fermatPolynomial,
    degree_X_pow_sub_C hn]

/-- Because the defining polynomial has positive degree, the coefficient
ring `K[X]` embeds in the affine Fermat ring. -/
theorem coefficientMap_injective {n : ℕ} (hn : 0 < n) :
    Function.Injective
      (algebraMap K[X] (CFI.FermatAffineRing K n)) := by
  change Function.Injective
    (AdjoinRoot.of (CFI.fermatPolynomial K n))
  apply AdjoinRoot.of.injective_of_degree_ne_zero
  rw [fermatPolynomial_degree K hn]
  exact_mod_cast (Nat.ne_of_gt hn)

/-- The coefficient `1-X^n` is nonzero for positive `n`. -/
theorem boundaryPolynomial_ne_zero {n : ℕ} (hn : 0 < n) :
    CFI.boundaryPolynomial K n ≠ 0 := by
  intro h
  have hval := congrArg (fun p : K[X] => p.eval 0) h
  simp [CFI.boundaryPolynomial,
    ConcreteFermatIrreducibility.boundaryPolynomial,
    Nat.ne_of_gt hn] at hval

/-- The affine `x` coordinate is nonzero. -/
theorem affineX_ne_zero {n : ℕ} (hn : 0 < n) :
    affineX K n ≠ 0 := by
  simpa [affineX] using
    (coefficientMap_injective K hn).ne X_ne_zero

/-- The second boundary factor `1-x^n` is nonzero. -/
theorem one_sub_affineX_pow_ne_zero {n : ℕ} (hn : 0 < n) :
    1 - affineX K n ^ n ≠ 0 := by
  have h := (coefficientMap_injective K hn).ne
    (boundaryPolynomial_ne_zero K hn)
  simpa [affineX, CFI.boundaryPolynomial,
    ConcreteFermatIrreducibility.boundaryPolynomial,
    map_sub, map_pow] using h

/-- The adjoined coordinate satisfies `y^n = 1-x^n`. -/
theorem affineY_pow_eq_one_sub_affineX_pow (n : ℕ) :
    affineY K n ^ n = 1 - affineX K n ^ n := by
  have hf : CFI.fermatPolynomial K n =
      X ^ n - C (CFI.boundaryPolynomial K n) := by
    rw [CFI.fermatPolynomial,
      ConcreteFermatIrreducibility.fermatPolynomial]
  have hroot :
      eval₂ (AdjoinRoot.of (CFI.fermatPolynomial K n))
        (AdjoinRoot.root (CFI.fermatPolynomial K n))
        (X ^ n - C (CFI.boundaryPolynomial K n)) = 0 := by
    rw [← hf]
    exact AdjoinRoot.eval₂_root (CFI.fermatPolynomial K n)
  rw [eval₂_sub, eval₂_X_pow, eval₂_C] at hroot
  have hroot' : affineY K n ^ n -
      algebraMap K[X] (CFI.FermatAffineRing K n)
        (CFI.boundaryPolynomial K n) = 0 := by
    simpa [affineY, CFI.FermatAffineRing] using hroot
  calc
    affineY K n ^ n =
        algebraMap K[X] (CFI.FermatAffineRing K n)
          (CFI.boundaryPolynomial K n) := sub_eq_zero.mp hroot'
    _ = 1 - affineX K n ^ n := by
      simp [affineX, CFI.boundaryPolynomial,
        ConcreteFermatIrreducibility.boundaryPolynomial,
        map_sub, map_pow]

/-- The two affine coordinates satisfy the Fermat equation. -/
theorem affine_fermat_equation (n : ℕ) :
    affineX K n ^ n + affineY K n ^ n = 1 := by
  rw [affineY_pow_eq_one_sub_affineX_pow]
  ring

/-- The honest affine boundary element whose nonvanishing removes both
`x = 0` and `y = 0`. -/
def affineBoundary (n : ℕ) : CFI.FermatAffineRing K n :=
  affineX K n * (1 - affineX K n ^ n)

theorem affineBoundary_eq_x_mul_y_pow (n : ℕ) :
    affineBoundary K n = affineX K n * affineY K n ^ n := by
  rw [affineBoundary, affineY_pow_eq_one_sub_affineX_pow]

/-- The localization element is nonzero in the affine Fermat domain. -/
theorem affineBoundary_ne_zero [CharZero K] {n : ℕ} (hn : 0 < n) :
    affineBoundary K n ≠ 0 := by
  letI : NeZero n := ⟨Nat.ne_of_gt hn⟩
  letI : IsDomain (CFI.FermatAffineRing K n) :=
    ConcreteFermatIrreducibility.fermatAffineRing_isDomain K
  exact mul_ne_zero (affineX_ne_zero K hn)
    (one_sub_affineX_pow_ne_zero K hn)

/-- The affine Fermat coordinate ring with `x(1-x^n)` inverted. -/
abbrev FermatOpenRing (n : ℕ) :=
  Localization.Away (affineBoundary K n)

/-- Localizing the affine Fermat domain at its nonzero boundary element
produces another integral domain. -/
noncomputable instance fermatOpenRing_isDomain
    [CharZero K] {n : ℕ} [NeZero n] :
    IsDomain (FermatOpenRing K n) := by
  letI : IsDomain (CFI.FermatAffineRing K n) :=
    ConcreteFermatIrreducibility.fermatAffineRing_isDomain K
  exact Localization.Away.isDomain
    (affineBoundary_ne_zero K (NeZero.pos n))

/-- In particular, the open Fermat ring is nontrivial. -/
theorem fermatOpenRing_nontrivial
    [CharZero K] {n : ℕ} [NeZero n] :
    Nontrivial (FermatOpenRing K n) := by
  infer_instance

/-- The `x` coordinate in the open Fermat ring. -/
def openX (n : ℕ) : FermatOpenRing K n :=
  algebraMap (CFI.FermatAffineRing K n) (FermatOpenRing K n)
    (affineX K n)

/-- The `y` coordinate in the open Fermat ring. -/
def openY (n : ℕ) : FermatOpenRing K n :=
  algebraMap (CFI.FermatAffineRing K n) (FermatOpenRing K n)
    (affineY K n)

/-- The defining relation survives localization. -/
theorem openY_pow_eq_one_sub_openX_pow (n : ℕ) :
    openY K n ^ n = 1 - openX K n ^ n := by
  rw [openY, openX, ← map_pow,
    affineY_pow_eq_one_sub_affineX_pow, map_sub, map_one, map_pow]

/-- The localized coordinates still satisfy the Fermat equation. -/
theorem open_fermat_equation (n : ℕ) :
    openX K n ^ n + openY K n ^ n = 1 := by
  rw [openY_pow_eq_one_sub_openX_pow]
  ring

/-- The image of the localization element is a unit by construction. -/
theorem openBoundary_isUnit (n : ℕ) :
    IsUnit
      (algebraMap (CFI.FermatAffineRing K n) (FermatOpenRing K n)
        (affineBoundary K n)) :=
  IsLocalization.Away.algebraMap_isUnit
    (R := CFI.FermatAffineRing K n) (S := FermatOpenRing K n)
      (affineBoundary K n)

/-- The localized `x` coordinate is a unit. -/
theorem openX_isUnit (n : ℕ) : IsUnit (openX K n) := by
  have h := openBoundary_isUnit K n
  have hprod : IsUnit (openX K n * (1 - openX K n ^ n)) := by
    simpa [affineBoundary, openX, map_mul, map_sub, map_pow] using h
  exact (IsUnit.mul_iff.mp hprod).1

/-- The localized value `1-x^n = y^n` is a unit. -/
theorem openOneSubXPow_isUnit (n : ℕ) :
    IsUnit (1 - openX K n ^ n) := by
  have h := openBoundary_isUnit K n
  have hprod : IsUnit (openX K n * (1 - openX K n ^ n)) := by
    simpa [affineBoundary, openX, map_mul, map_sub, map_pow] using h
  exact (IsUnit.mul_iff.mp hprod).2

/-- The localized `y` coordinate is a unit because its positive power is the
unit `1-x^n`. -/
theorem openY_isUnit {n : ℕ} (hn : 0 < n) : IsUnit (openY K n) := by
  apply (isUnit_pow_iff (Nat.ne_of_gt hn)).mp
  rw [openY_pow_eq_one_sub_openX_pow]
  exact openOneSubXPow_isUnit K n

/-- The `x` coordinate packaged as a unit. -/
def openXUnit (n : ℕ) : (FermatOpenRing K n)ˣ :=
  (openX_isUnit K n).unit

/-- The `y` coordinate packaged as a unit. -/
def openYUnit {n : ℕ} (hn : 0 < n) : (FermatOpenRing K n)ˣ :=
  (openY_isUnit K hn).unit

@[simp]
theorem coe_openXUnit (n : ℕ) :
    (openXUnit K n : FermatOpenRing K n) = openX K n :=
  (openX_isUnit K n).unit_spec

@[simp]
theorem coe_openYUnit {n : ℕ} (hn : 0 < n) :
    (openYUnit K hn : FermatOpenRing K n) = openY K n :=
  (openY_isUnit K hn).unit_spec

/-! ## Start of the comparison with the iterated tripod Kummer algebra

The following constructs the forward ring homomorphism.  Constructing its
inverse and proving the two maps inverse are deliberately left as separate
theorems; no algebra equivalence is asserted prematurely.
-/

namespace TripodComparison

namespace T

abbrev FermatRing :=
  ConcreteGenEllTripodCover.FermatAffineRing

abbrev fermatX :=
  ConcreteGenEllTripodCover.fermatX

abbrev fermatY :=
  ConcreteGenEllTripodCover.fermatY

end T

variable [CharZero K]

/-- The existing iterated-Kummer `x` coordinate is a unit because its
positive `n`-th power is the lifted tripod unit `t`. -/
theorem tripodFermatX_isUnit
    {n : ℕ} (hn : n ≠ 0) :
    IsUnit (T.fermatX K n hn) := by
  apply (isUnit_pow_iff hn).mp
  rw [ConcreteGenEllTripodCover.fermatX_pow_eq_t]
  exact ((ConcreteGenEllTripodCover.tripodT_isUnit K).map
    (algebraMap
      (ConcreteGenEllTripodCover.TripodRing K)
      (ConcreteGenEllTripodCover.TripodFirstKummerRing K n hn))).map
        (algebraMap
          (ConcreteGenEllTripodCover.TripodFirstKummerRing K n hn)
          (T.FermatRing K n hn))

/-- The existing iterated-Kummer `y` coordinate is a unit because its
positive `n`-th power is the lifted tripod unit `1-t`. -/
theorem tripodFermatY_isUnit
    {n : ℕ} (hn : n ≠ 0) :
    IsUnit (T.fermatY K n hn) := by
  apply (isUnit_pow_iff hn).mp
  rw [ConcreteGenEllTripodCover.fermatY_pow_eq_one_sub_t]
  have hunit := ((ConcreteGenEllTripodCover.tripodOneSubT_isUnit K).map
    (algebraMap
      (ConcreteGenEllTripodCover.TripodRing K)
      (ConcreteGenEllTripodCover.TripodFirstKummerRing K n hn))).map
        (algebraMap
          (ConcreteGenEllTripodCover.TripodFirstKummerRing K n hn)
          (T.FermatRing K n hn))
  simpa [ConcreteGenEllTripodCover.fermatT,
    ConcreteGenEllTripodCover.tripodOneSubT, map_sub] using hunit

/-- Evaluate the coefficient polynomial variable at the existing tripod
Fermat coordinate `x`. -/
def baseToTripodRingHom
    {n : ℕ} (hn : n ≠ 0) :
    K →+* T.FermatRing K n hn :=
  (ConcreteGenEllTripodCover.tripodToFermatRingHom K n hn).comp
    ((algebraMap K[X] (ConcreteGenEllTripodCover.TripodRing K)).comp
      (algebraMap K K[X]))

def coefficientToTripodRingHom
    {n : ℕ} (hn : n ≠ 0) :
    K[X] →+* T.FermatRing K n hn :=
  eval₂RingHom (baseToTripodRingHom K hn)
    (T.fermatX K n hn)

@[simp]
theorem coefficientToTripodRingHom_X
    {n : ℕ} (hn : n ≠ 0) :
    coefficientToTripodRingHom K hn X = T.fermatX K n hn := by
  simp [coefficientToTripodRingHom]

@[simp]
theorem coefficientToTripodRingHom_boundary
    {n : ℕ} (hn : n ≠ 0) :
    coefficientToTripodRingHom K hn (CFI.boundaryPolynomial K n) =
      1 - T.fermatX K n hn ^ n := by
  simp [coefficientToTripodRingHom, CFI.boundaryPolynomial,
    ConcreteFermatIrreducibility.boundaryPolynomial]

/-- The existing `y` coordinate is a root of the Fermat polynomial after
evaluating its coefficient variable at the existing `x` coordinate. -/
theorem fermatPolynomial_eval₂_tripod_eq_zero
    {n : ℕ} (hn : n ≠ 0) :
    (CFI.fermatPolynomial K n).eval₂
        (coefficientToTripodRingHom K hn) (T.fermatY K n hn) = 0 := by
  rw [CFI.fermatPolynomial,
    ConcreteFermatIrreducibility.fermatPolynomial,
    eval₂_sub, eval₂_X_pow, eval₂_C,
    coefficientToTripodRingHom_boundary]
  apply sub_eq_zero.mpr
  rw [ConcreteGenEllTripodCover.fermatY_pow_eq_one_sub_t,
    ConcreteGenEllTripodCover.fermatX_pow_eq_t]

/-- The universal property of `AdjoinRoot` gives the comparison map from the
integral affine Fermat presentation to the existing iterated Kummer ring. -/
def affineToTripodRingHom
    {n : ℕ} (hn : n ≠ 0) :
    CFI.FermatAffineRing K n →+* T.FermatRing K n hn :=
  AdjoinRoot.lift (coefficientToTripodRingHom K hn)
    (T.fermatY K n hn) (fermatPolynomial_eval₂_tripod_eq_zero K hn)

@[simp]
theorem affineToTripodRingHom_affineX
    {n : ℕ} (hn : n ≠ 0) :
    affineToTripodRingHom K hn (affineX K n) =
      T.fermatX K n hn := by
  simp [affineToTripodRingHom, affineX,
    coefficientToTripodRingHom]

@[simp]
theorem affineToTripodRingHom_affineY
    {n : ℕ} (hn : n ≠ 0) :
    affineToTripodRingHom K hn (affineY K n) =
      T.fermatY K n hn := by
  simp [affineToTripodRingHom, affineY]

/-- The affine boundary maps to a unit in the existing iterated Kummer
ring. -/
theorem affineBoundary_mapsTo_isUnit
    {n : ℕ} (hn : n ≠ 0) :
    IsUnit (affineToTripodRingHom K hn (affineBoundary K n)) := by
  rw [affineBoundary, map_mul, map_sub, map_one, map_pow,
    affineToTripodRingHom_affineX]
  rw [ConcreteGenEllTripodCover.fermatX_pow_eq_t,
    ← ConcreteGenEllTripodCover.fermatY_pow_eq_one_sub_t]
  exact (tripodFermatX_isUnit K hn).mul
    ((tripodFermatY_isUnit K hn).pow n)

/-- Localizing the affine comparison map gives the canonical forward map
from the honest open Fermat ring to the existing iterated tripod Kummer
algebra. -/
noncomputable def openToTripodRingHom
    {n : ℕ} (hn : n ≠ 0) :
    FermatOpenRing K n →+* T.FermatRing K n hn :=
  IsLocalization.Away.lift
    (S := FermatOpenRing K n) (g := affineToTripodRingHom K hn)
    (affineBoundary K n) (affineBoundary_mapsTo_isUnit K hn)

@[simp]
theorem openToTripodRingHom_openX
    {n : ℕ} (hn : n ≠ 0) :
    openToTripodRingHom K hn (openX K n) =
      T.fermatX K n hn := by
  simp [openToTripodRingHom, openX]

@[simp]
theorem openToTripodRingHom_openY
    {n : ℕ} (hn : n ≠ 0) :
    openToTripodRingHom K hn (openY K n) =
      T.fermatY K n hn := by
  simp [openToTripodRingHom, openY]

end TripodComparison

end

end ConcreteFermatOpenRing
end IUTThreeClosures
