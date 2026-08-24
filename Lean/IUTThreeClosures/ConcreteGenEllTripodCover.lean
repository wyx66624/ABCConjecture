/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteGenEllKummerCover
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.RingTheory.Flat.FaithfullyFlat.Algebra

/-!
# The concrete affine Fermat cover of the tripod

For a characteristic-zero field `K`, the tripod has coordinate ring

`A = K[t, t⁻¹, (1-t)⁻¹]`.

We realize `A` as the localization of `K[X]` away from `X(1-X)`, construct
the two units `t` and `1-t`, and apply the finite étale Kummer construction
twice.  In the resulting iterated algebra the distinguished generators satisfy

`x^n = t`, `y^n = 1-t`, and hence `x^n + y^n = 1`.

This is the honest affine covering algebra used by the GenEll/Fermat route.
Projective compactification, connectedness, boundary ramification, heights,
and noncritical Belyi descent remain separate theorems.
-/

namespace IUTThreeClosures.ConcreteGenEllTripodCover

open Polynomial
open ConcreteGenEllKummerCover

noncomputable section

universe u

variable (K : Type u) [Field K]

/-- The coordinate ring of the affine tripod. -/
abbrev TripodRing :=
  Localization.Away (X * (1 - X) : K[X])

/-- The tripod localization is nontrivial: its localization element
`X(1-X)` is nonzero in the polynomial domain. -/
theorem tripodRing_nontrivial : Nontrivial (TripodRing K) := by
  have hOneSubX : (1 - X : K[X]) ≠ 0 := by
    intro h
    have hcoeff := congrArg (fun p : K[X] => p.coeff 0) h
    simp at hcoeff
  have hden : (X * (1 - X) : K[X]) ≠ 0 :=
    mul_ne_zero X_ne_zero hOneSubX
  have hinj : Function.Injective (algebraMap K[X] (TripodRing K)) :=
    IsLocalization.injective (TripodRing K)
      (powers_le_nonZeroDivisors_of_noZeroDivisors hden)
  exact hinj.nontrivial

/-- The coordinate `t` on the tripod. -/
def tripodT : TripodRing K :=
  algebraMap K[X] (TripodRing K) X

/-- The second distinguished unit `1-t`. -/
def tripodOneSubT : TripodRing K :=
  1 - tripodT K

/-- By construction, `t(1-t)` is invertible in the tripod localization. -/
theorem tripod_product_isUnit :
    IsUnit (tripodT K * tripodOneSubT K) := by
  have h := IsLocalization.Away.algebraMap_isUnit
    (R := K[X]) (S := TripodRing K) (X * (1 - X))
  simpa [tripodT, tripodOneSubT, map_sub] using h

/-- The coordinate `t` is a unit on the tripod. -/
theorem tripodT_isUnit : IsUnit (tripodT K) :=
  (IsUnit.mul_iff.mp (tripod_product_isUnit K)).1

/-- The coordinate `1-t` is a unit on the tripod. -/
theorem tripodOneSubT_isUnit : IsUnit (tripodOneSubT K) :=
  (IsUnit.mul_iff.mp (tripod_product_isUnit K)).2

/-- `t`, packaged as a unit. -/
def tripodTUnit : (TripodRing K)ˣ :=
  (tripodT_isUnit K).unit

/-- `1-t`, packaged as a unit. -/
def tripodOneSubTUnit : (TripodRing K)ˣ :=
  (tripodOneSubT_isUnit K).unit

@[simp]
theorem coe_tripodTUnit :
    (tripodTUnit K : TripodRing K) = tripodT K :=
  (tripodT_isUnit K).unit_spec

@[simp]
theorem coe_tripodOneSubTUnit :
    (tripodOneSubTUnit K : TripodRing K) = tripodOneSubT K :=
  (tripodOneSubT_isUnit K).unit_spec

variable [CharZero K]

/-- A positive natural number as a unit of a characteristic-zero field. -/
def fieldNatUnit (n : ℕ) (hn : n ≠ 0) : Kˣ :=
  Units.mk0 (n : K) (Nat.cast_ne_zero.mpr hn)

/-- The same natural-number unit transported to the tripod ring. -/
def tripodNatUnit (n : ℕ) (hn : n ≠ 0) : (TripodRing K)ˣ :=
  Units.map (algebraMap K (TripodRing K)) (fieldNatUnit K n hn)

@[simp]
theorem coe_tripodNatUnit (n : ℕ) (hn : n ≠ 0) :
    (tripodNatUnit K n hn : TripodRing K) = (n : TripodRing K) := by
  simp [tripodNatUnit, fieldNatUnit]

/-- The first Kummer step, adjoining `x` with `x^n=t`. -/
abbrev tripodFirstKummerPair (n : ℕ) (hn : n ≠ 0) :
    StandardEtalePair (TripodRing K) :=
  kummerStandardEtalePair n hn (tripodTUnit K) (tripodNatUnit K n hn)
    (coe_tripodNatUnit K n hn)

/-- The first Kummer algebra. -/
abbrev TripodFirstKummerRing (n : ℕ) (hn : n ≠ 0) :=
  (tripodFirstKummerPair K n hn).Ring

/-- The unit `1-t`, transported to the first Kummer algebra. -/
def firstLiftedOneSubTUnit (n : ℕ) (hn : n ≠ 0) :
    (TripodFirstKummerRing K n hn)ˣ :=
  Units.map
    (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn))
    (tripodOneSubTUnit K)

/-- The natural-number unit transported to the first Kummer algebra. -/
def firstLiftedNatUnit (n : ℕ) (hn : n ≠ 0) :
    (TripodFirstKummerRing K n hn)ˣ :=
  Units.map
    (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn))
    (tripodNatUnit K n hn)

@[simp]
theorem coe_firstLiftedNatUnit (n : ℕ) (hn : n ≠ 0) :
    (firstLiftedNatUnit K n hn : TripodFirstKummerRing K n hn) =
      (n : TripodFirstKummerRing K n hn) := by
  simp [firstLiftedNatUnit]

/-- The second Kummer step, adjoining `y` with `y^n=1-t`. -/
abbrev fermatSecondKummerPair (n : ℕ) (hn : n ≠ 0) :
    StandardEtalePair (TripodFirstKummerRing K n hn) :=
  kummerStandardEtalePair n hn
    (firstLiftedOneSubTUnit K n hn)
    (firstLiftedNatUnit K n hn)
    (coe_firstLiftedNatUnit K n hn)

/-- The concrete affine Fermat covering ring, obtained by the two Kummer
steps. -/
abbrev FermatAffineRing (n : ℕ) (hn : n ≠ 0) :=
  (fermatSecondKummerPair K n hn).Ring

/-- The first Kummer step is finite étale over the tripod. -/
theorem first_kummer_etale (n : ℕ) (hn : n ≠ 0) :
    Algebra.Etale (TripodRing K) (TripodFirstKummerRing K n hn) := by
  infer_instance

/-- The first Kummer step is finite as a module over the tripod. -/
theorem first_kummer_finite (n : ℕ) (hn : n ≠ 0) :
    Module.Finite (TripodRing K) (TripodFirstKummerRing K n hn) := by
  exact kummer_module_finite n hn
    (tripodTUnit K) (tripodNatUnit K n hn)
    (coe_tripodNatUnit K n hn)

/-- The second Kummer step is finite étale over the first. -/
theorem second_kummer_etale (n : ℕ) (hn : n ≠ 0) :
    Algebra.Etale (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) := by
  infer_instance

/-- The second Kummer step is finite as a module over the first. -/
theorem second_kummer_finite (n : ℕ) (hn : n ≠ 0) :
    Module.Finite (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) := by
  exact kummer_module_finite n hn
    (firstLiftedOneSubTUnit K n hn)
    (firstLiftedNatUnit K n hn)
    (coe_firstLiftedNatUnit K n hn)

/-- The ring homomorphism from the tripod through the two successive Kummer
extensions. -/
def tripodToFermatRingHom (n : ℕ) (hn : n ≠ 0) :
    TripodRing K →+* FermatAffineRing K n hn :=
  (algebraMap (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn)).comp
    (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn))

/-- The composite tripod-algebra structure on the final Fermat ring. -/
@[reducible]
def fermatTripodAlgebra (n : ℕ) (hn : n ≠ 0) :
    Algebra (TripodRing K) (FermatAffineRing K n hn) :=
  (tripodToFermatRingHom K n hn).toAlgebra

/-- The two Kummer steps compose to an étale algebra over the tripod. -/
theorem fermat_etale_over_tripod (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Algebra.Etale (TripodRing K) (FermatAffineRing K n hn) := by
  letI := fermatTripodAlgebra K n hn
  letI : IsScalarTower (TripodRing K) (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : Algebra.Etale (TripodRing K) (TripodFirstKummerRing K n hn) :=
    first_kummer_etale K n hn
  letI : Algebra.Etale (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    second_kummer_etale K n hn
  exact Algebra.Etale.comp (TripodRing K)
    (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn)

/-- The two finite Kummer steps compose to a finite module over the tripod. -/
theorem fermat_finite_over_tripod (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.Finite (TripodRing K) (FermatAffineRing K n hn) := by
  letI := fermatTripodAlgebra K n hn
  letI : IsScalarTower (TripodRing K) (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : Module.Finite (TripodRing K) (TripodFirstKummerRing K n hn) :=
    first_kummer_finite K n hn
  letI : Module.Finite (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    second_kummer_finite K n hn
  exact Module.Finite.trans (TripodFirstKummerRing K n hn)
    (FermatAffineRing K n hn)

/-- The first Kummer algebra has exact module rank `n` over the tripod. -/
theorem first_kummer_finrank (n : ℕ) (hn : n ≠ 0) :
    Module.finrank (TripodRing K) (TripodFirstKummerRing K n hn) = n := by
  letI : Nontrivial (TripodRing K) := tripodRing_nontrivial K
  exact (kummerPowerBasis n hn
    (tripodTUnit K) (tripodNatUnit K n hn)
    (coe_tripodNatUnit K n hn)).finrank.trans
      (kummerPowerBasis_dim n hn
        (tripodTUnit K) (tripodNatUnit K n hn)
        (coe_tripodNatUnit K n hn))

/-- The second Kummer algebra has exact module rank `n` over the first. -/
theorem second_kummer_finrank (n : ℕ) (hn : n ≠ 0) :
    Module.finrank (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) = n := by
  letI : Nontrivial (TripodRing K) := tripodRing_nontrivial K
  letI : Nontrivial (TripodFirstKummerRing K n hn) :=
    kummer_ring_nontrivial n hn
      (tripodTUnit K) (tripodNatUnit K n hn)
      (coe_tripodNatUnit K n hn)
  exact (kummerPowerBasis n hn
    (firstLiftedOneSubTUnit K n hn)
    (firstLiftedNatUnit K n hn)
    (coe_firstLiftedNatUnit K n hn)).finrank.trans
      (kummerPowerBasis_dim n hn
        (firstLiftedOneSubTUnit K n hn)
        (firstLiftedNatUnit K n hn)
        (coe_firstLiftedNatUnit K n hn))

/-- The composite affine Fermat cover has exact rank `n^2` over the tripod. -/
theorem fermat_finrank_over_tripod (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.finrank (TripodRing K) (FermatAffineRing K n hn) = n ^ 2 := by
  letI := fermatTripodAlgebra K n hn
  letI : Nontrivial (TripodRing K) := tripodRing_nontrivial K
  letI : Nontrivial (TripodFirstKummerRing K n hn) :=
    kummer_ring_nontrivial n hn
      (tripodTUnit K) (tripodNatUnit K n hn)
      (coe_tripodNatUnit K n hn)
  letI : IsScalarTower (TripodRing K) (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : Module.Free (TripodRing K) (TripodFirstKummerRing K n hn) :=
    kummer_module_free n hn
      (tripodTUnit K) (tripodNatUnit K n hn)
      (coe_tripodNatUnit K n hn)
  letI : Module.Free (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    kummer_module_free n hn
      (firstLiftedOneSubTUnit K n hn)
      (firstLiftedNatUnit K n hn)
      (coe_firstLiftedNatUnit K n hn)
  rw [← Module.finrank_mul_finrank (TripodRing K)
    (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn),
    first_kummer_finrank, second_kummer_finrank, pow_two]

/-- The final Fermat algebra is nontrivial, as witnessed by the positive
power basis in the second Kummer step. -/
theorem fermat_nontrivial (n : ℕ) (hn : n ≠ 0) :
    Nontrivial (FermatAffineRing K n hn) := by
  letI : Nontrivial (TripodRing K) := tripodRing_nontrivial K
  letI : Nontrivial (TripodFirstKummerRing K n hn) :=
    kummer_ring_nontrivial n hn
      (tripodTUnit K) (tripodNatUnit K n hn)
      (coe_tripodNatUnit K n hn)
  exact kummer_ring_nontrivial n hn
    (firstLiftedOneSubTUnit K n hn)
    (firstLiftedNatUnit K n hn)
    (coe_firstLiftedNatUnit K n hn)

/-- The two explicit free Kummer modules compose to a free module over the
tripod. -/
theorem fermat_free_over_tripod (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.Free (TripodRing K) (FermatAffineRing K n hn) := by
  letI := fermatTripodAlgebra K n hn
  letI : IsScalarTower (TripodRing K) (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : Module.Free (TripodRing K) (TripodFirstKummerRing K n hn) :=
    kummer_module_free n hn
      (tripodTUnit K) (tripodNatUnit K n hn)
      (coe_tripodNatUnit K n hn)
  letI : Module.Free (TripodFirstKummerRing K n hn)
      (FermatAffineRing K n hn) :=
    kummer_module_free n hn
      (firstLiftedOneSubTUnit K n hn)
      (firstLiftedNatUnit K n hn)
      (coe_firstLiftedNatUnit K n hn)
  exact Module.Free.trans
    (R := TripodRing K)
    (S := TripodFirstKummerRing K n hn)
    (M := FermatAffineRing K n hn)

/-- Positive finite freeness makes the affine Fermat algebra faithfully flat
over the tripod. -/
theorem fermat_faithfullyFlat_over_tripod (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Module.FaithfullyFlat (TripodRing K) (FermatAffineRing K n hn) := by
  letI := fermatTripodAlgebra K n hn
  letI : Nontrivial (FermatAffineRing K n hn) :=
    fermat_nontrivial K n hn
  letI : Module.Free (TripodRing K) (FermatAffineRing K n hn) :=
    fermat_free_over_tripod K n hn
  infer_instance

/-- The affine Fermat morphism is surjective on prime spectra. -/
theorem fermat_primeSpectrum_surjective (n : ℕ) (hn : n ≠ 0) :
    letI := fermatTripodAlgebra K n hn
    Function.Surjective
      (PrimeSpectrum.comap
        (algebraMap (TripodRing K) (FermatAffineRing K n hn))) := by
  letI := fermatTripodAlgebra K n hn
  letI : Module.FaithfullyFlat (TripodRing K) (FermatAffineRing K n hn) :=
    fermat_faithfullyFlat_over_tripod K n hn
  exact PrimeSpectrum.comap_surjective_of_faithfullyFlat

/-- The first distinguished generator satisfies its defining equation before
the second base extension. -/
theorem firstKummer_X_pow_eq_t (n : ℕ) (hn : n ≠ 0) :
    (tripodFirstKummerPair K n hn).X ^ n =
      algebraMap (TripodRing K) (TripodFirstKummerRing K n hn) (tripodT K) := by
  let P := tripodFirstKummerPair K n hn
  change P.X ^ n = algebraMap (TripodRing K) P.Ring (tripodT K)
  have hroot := P.hasMap_X.1
  change aeval P.X (X ^ n - C (tripodTUnit K : TripodRing K)) = 0 at hroot
  rw [map_sub, aeval_X_pow, aeval_C, coe_tripodTUnit] at hroot
  exact sub_eq_zero.mp hroot

/-- The second distinguished generator satisfies its defining equation. -/
theorem secondKummer_X_pow_eq_one_sub_t (n : ℕ) (hn : n ≠ 0) :
    (fermatSecondKummerPair K n hn).X ^ n =
      algebraMap (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn)
        (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn)
          (tripodOneSubT K)) := by
  let Q := fermatSecondKummerPair K n hn
  change Q.X ^ n =
    algebraMap (TripodFirstKummerRing K n hn) Q.Ring
      (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn)
        (tripodOneSubT K))
  have hroot := Q.hasMap_X.1
  change aeval Q.X
    (X ^ n - C (firstLiftedOneSubTUnit K n hn :
      TripodFirstKummerRing K n hn)) = 0 at hroot
  rw [map_sub, aeval_X_pow, aeval_C] at hroot
  have hcoe :
      (firstLiftedOneSubTUnit K n hn : TripodFirstKummerRing K n hn) =
        algebraMap (TripodRing K) (TripodFirstKummerRing K n hn)
          (tripodOneSubT K) := by
    simp [firstLiftedOneSubTUnit]
  rw [hcoe] at hroot
  exact sub_eq_zero.mp hroot

/-- The `x` coordinate in the final iterated algebra. -/
def fermatX (n : ℕ) (hn : n ≠ 0) : FermatAffineRing K n hn :=
  algebraMap (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn)
    (tripodFirstKummerPair K n hn).X

/-- The `y` coordinate in the final iterated algebra. -/
def fermatY (n : ℕ) (hn : n ≠ 0) : FermatAffineRing K n hn :=
  (fermatSecondKummerPair K n hn).X

/-- The tripod coordinate in the final iterated algebra. -/
def fermatT (n : ℕ) (hn : n ≠ 0) : FermatAffineRing K n hn :=
  algebraMap (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn)
    (algebraMap (TripodRing K) (TripodFirstKummerRing K n hn) (tripodT K))

/-- The first coordinate satisfies `x^n=t` in the final algebra. -/
theorem fermatX_pow_eq_t (n : ℕ) (hn : n ≠ 0) :
    fermatX K n hn ^ n = fermatT K n hn := by
  unfold fermatX fermatT
  rw [← map_pow]
  exact congrArg
    (algebraMap (TripodFirstKummerRing K n hn) (FermatAffineRing K n hn))
    (firstKummer_X_pow_eq_t K n hn)

/-- The second coordinate satisfies `y^n=1-t` in the final algebra. -/
theorem fermatY_pow_eq_one_sub_t (n : ℕ) (hn : n ≠ 0) :
    fermatY K n hn ^ n = 1 - fermatT K n hn := by
  unfold fermatY fermatT
  rw [secondKummer_X_pow_eq_one_sub_t]
  simp [tripodOneSubT, map_sub]

/-- The final affine covering algebra lies on the Fermat equation. -/
theorem fermat_equation (n : ℕ) (hn : n ≠ 0) :
    fermatX K n hn ^ n + fermatY K n hn ^ n = 1 := by
  rw [fermatX_pow_eq_t, fermatY_pow_eq_one_sub_t]
  ring

end


end IUTThreeClosures.ConcreteGenEllTripodCover
