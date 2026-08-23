/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyNonCMOutsideFinite
import IUTThreeClosures.PublicFreyTheorem110Bridge

/-!
# Calibrated Frey initial theta-data assembly

The arithmetic prime-selection theorem produces arbitrarily large primes with
large mod-ell image for the actual Frey curve outside the explicit finite
exceptional set.  To use that theorem in IUT IV, an actual geometric assembler
must not be allowed to ignore the selected prime or replace the Frey curve by
an unrelated curve.

This module records the exact remaining source boundary:

* a selected prime is prime, at least seven, large-image for the Frey curve,
  and coprime to every required finite local order;
* the geometric assembler consumes precisely this package;
* the resulting `InitialThetaData.ℓ` is definitionally calibrated by a proof to
  the selected prime;
* the resulting source curve has j-invariant equal to the image of the actual
  rational Frey j-invariant in its base field.

All prime existence and arbitrary-lower-bound work is then derived.  The
structure still requires the genuine anabelian/tempered orbicurves, cores,
Tate models and local theta data through its `assemble` field; no IUT source
existence, q-bound, or abc inequality is assumed.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u

/-- The complete arithmetic input consumed by a Frey initial-theta assembler. -/
structure FreyAdmissiblePrimeInput
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (orders : Finset ℕ) where
  ell : ℕ
  ell_prime : ell.Prime
  ell_ge_seven : 7 ≤ ell
  largeImage : S.LargeImageAt (abcFreyCurve P) ell
  coprime_orders : ∀ n ∈ orders, Nat.Coprime ell n

namespace FreyAdmissiblePrimeInput

/-- Outside the explicit finite exceptional set, such arithmetic inputs exist
above every prescribed natural lower bound. -/
theorem exists_above
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (M : ℕ)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0) :
    ∃ I : FreyAdmissiblePrimeInput S P orders, M < I.ell := by
  rcases S.exists_frey_largeImage_prime_coprime_above
      P hP (max M 7) orders horders with
    ⟨ell, hellPrime, hbound, _hfive, hlarge, hcop⟩
  have hM : M < ell :=
    lt_of_le_of_lt (Nat.le_max_left M 7) hbound
  have hseven : 7 ≤ ell :=
    (Nat.le_max_right M 7).trans (Nat.le_of_lt hbound)
  refine ⟨{
    ell := ell
    ell_prime := hellPrime
    ell_ge_seven := hseven
    largeImage := hlarge
    coprime_orders := hcop
  }, hM⟩

end FreyAdmissiblePrimeInput

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- Exact source-facing assembler for actual Frey initial theta-data outside
the finite possible-CM locus.

The two calibration fields prevent a formally valid implementation from
ignoring its selected prime or swapping in an unrelated elliptic curve. -/
structure FreyInitialThetaAssembly
    (S : RationalCMOpenImagePackage)
    (AG : AnabelianGeometry.{u})
    (TG : TemperedGeometry AG) where
  /-- Finite local residue characteristics, Tate orders and extension degrees
to be avoided by the selected prime. -/
  localOrders : ABCPoint → Finset ℕ
  localOrders_ne_zero : ∀ P n, n ∈ localOrders P → n ≠ 0
  /-- Genuine geometric construction of the full initial theta-data. -/
  assemble : ∀ (P : ABCPoint),
    P ∉ freyCMExceptional →
    FreyAdmissiblePrimeInput S P (localOrders P) →
    InitialThetaData AG TG
  /-- The prime stored by the output data is exactly the selected prime. -/
  ell_calibration : ∀ (P : ABCPoint)
      (hP : P ∉ freyCMExceptional)
      (I : FreyAdmissiblePrimeInput S P (localOrders P)),
    (assemble P hP I).ℓ = I.ell
  /-- The output curve is calibrated to the actual Frey j-invariant. -/
  j_calibration : ∀ (P : ABCPoint)
      (hP : P ∉ freyCMExceptional)
      (I : FreyAdmissiblePrimeInput S P (localOrders P)),
    (assemble P hP I).E.j =
      algebraMap ℚ (assemble P hP I).F (abcFreyCurve P).j

namespace FreyInitialThetaAssembly

variable {S : RationalCMOpenImagePackage}
variable (A : FreyInitialThetaAssembly S AG TG)

/-- The assembled source curve has rational j-invariant in its actual base
field, in the exact existential form used by the moduli-degree theorem. -/
theorem assemble_j_rational
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (I : FreyAdmissiblePrimeInput S P (A.localOrders P)) :
    ∃ q : ℚ,
      (A.assemble P hP I).E.j =
        algebraMap ℚ (A.assemble P hP I).F q := by
  exact ⟨(abcFreyCurve P).j, A.j_calibration P hP I⟩

/-- The canonical real prime projection of the assembled data is the selected
natural prime. -/
theorem initialThetaEllReal_assemble
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (I : FreyAdmissiblePrimeInput S P (A.localOrders P)) :
    initialThetaEllReal (A.assemble P hP I) = (I.ell : ℝ) := by
  simp [initialThetaEllReal, A.ell_calibration P hP I]

/-- **Calibrated pointwise source existence above every lower bound.**
All arithmetic selection work is discharged; the only remaining source seam
is the genuine implementation of `A.assemble` and its two calibrations. -/
theorem exists_calibrated_initialThetaData_above
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (M : ℕ) :
    ∃ I : FreyAdmissiblePrimeInput S P (A.localOrders P),
      M < I.ell ∧
      (A.assemble P hP I).ℓ = I.ell ∧
      (A.assemble P hP I).E.j =
        algebraMap ℚ (A.assemble P hP I).F
          (abcFreyCurve P).j := by
  rcases FreyAdmissiblePrimeInput.exists_above
      S P hP M (A.localOrders P) (A.localOrders_ne_zero P) with
    ⟨I, hMI⟩
  exact ⟨I, hMI, A.ell_calibration P hP I,
    A.j_calibration P hP I⟩

end FreyInitialThetaAssembly

end IUTThreeClosures
