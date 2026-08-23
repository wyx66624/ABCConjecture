/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ShiftedJAdmissibleCurve
import IUTThreeClosures.AdmissiblePrimeSelection
import Iut.Cor312.ThetaData.Basic
import Mathlib.NumberTheory.NumberField.Basic

/-!
# The shifted-j route to admissible primes and pointwise initial theta-data

For an abc point `P`, the curve `abcShiftedJCurve P` has rational
j-invariant

`2 + P.a / P.c`.

The preceding module proves that this rational number is not an integer. The
classical CM-integrality theorem says that the j-invariant of a CM elliptic
curve is an algebraic integer; the ring of integers of `ℚ` is `ℤ`. Hence the
shifted-j curve is non-CM. Serre's open-image theorem then says that its
mod-ell image is maximal for every sufficiently large prime ell.

Those two deep theorems are not presently declarations of Mathlib, so this
module packages their exact statements as a reusable source theorem rather
than replacing them by an arbitrary final inequality. The rational
specialization from `IsIntegral ℤ j` to an actual integer is proved here using
Mathlib's equivalence `𝓞 ℚ ≃+* ℤ`. All further deductions are also proved:

* the shifted-j curve is non-CM;
* it has eventual large mod-ell image;
* one may simultaneously choose a prime ell >= 5 with large image and prime
  to every member of a finite nonzero family of local orders;
* any genuine geometric assembler using precisely those data produces
  pointwise `InitialThetaData` outside its finite exceptional set.

Thus the arithmetic seam is reduced exactly to CM integrality and Serre open
image; the remaining source seam is the construction of the actual
anabelian/tempered orbicurves, cores, Tate models and local theta data.
-/

namespace IUTThreeClosures

open Iut NumberField

universe u

/-- The two classical arithmetic theorems needed by the shifted-j route.

`HasCM` and `LargeImageAt` are separated from the conclusions, so later a
formalization of elliptic-curve endomorphisms and torsion representations can
instantiate this package without changing downstream code. -/
structure RationalCMOpenImagePackage where
  /-- The intended complex-multiplication predicate on elliptic curves over
  `ℚ`. -/
  HasCM : WeierstrassCurve ℚ → Prop
  /-- The intended maximal/large mod-ell image predicate. -/
  LargeImageAt : WeierstrassCurve ℚ → ℕ → Prop
  /-- CM j-invariants are algebraic integers. -/
  cm_j_integral : ∀ (E : WeierstrassCurve ℚ) [E.IsElliptic],
    HasCM E → IsIntegral ℤ E.j
  /-- Serre open image in the form used here: a non-CM rational elliptic curve
  has large mod-ell image at every sufficiently large prime. -/
  serre_eventual_large_image : ∀ (E : WeierstrassCurve ℚ) [E.IsElliptic],
    ¬ HasCM E →
      ∃ N : ℕ, ∀ ell : ℕ, ell.Prime → N < ell → LargeImageAt E ell

namespace RationalCMOpenImagePackage

/-- A rational algebraic integer is an integer, specialized to a CM
j-invariant. This step is fully formalized; it is not an extra source field. -/
theorem cm_j_integer
    (S : RationalCMOpenImagePackage)
    (E : WeierstrassCurve ℚ)
    [E.IsElliptic]
    (hCM : S.HasCM E) :
    ∃ z : ℤ, E.j = (z : ℚ) := by
  let zO : 𝓞 ℚ := ⟨E.j, S.cm_j_integral E hCM⟩
  refine ⟨Rat.ringOfIntegersEquiv zO, ?_⟩
  have h := Rat.ringOfIntegersEquiv_apply_coe zO
  simpa [zO] using h.symm

/-- **Shifted-j non-CM theorem.** CM integrality contradicts the already
proved fact that the shifted rational j-invariant has denominator `P.c >= 2`. -/
theorem shiftedJCurve_nonCM
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint) :
    ¬ S.HasCM (abcShiftedJCurve P) := by
  intro hCM
  rcases S.cm_j_integer (abcShiftedJCurve P) hCM with ⟨z, hz⟩
  exact abcShiftedJCurve_j_not_integer P ⟨z, hz⟩

/-- **Eventual large-image theorem for the shifted-j family.** -/
theorem shiftedJCurve_eventual_largeImage
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint) :
    ∃ N : ℕ, ∀ ell : ℕ, ell.Prime → N < ell →
      S.LargeImageAt (abcShiftedJCurve P) ell :=
  S.serre_eventual_large_image
    (abcShiftedJCurve P)
    (S.shiftedJCurve_nonCM P)

/-- Simultaneous admissible-prime selection for one shifted-j curve.

The chosen prime is at least five, has the eventual large-image property, and
is coprime to every specified nonzero residue characteristic, Tate order, or
extension degree. -/
theorem exists_shiftedJ_largeImage_prime_coprime
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0) :
    ∃ ell : ℕ,
      ell.Prime ∧
      5 ≤ ell ∧
      S.LargeImageAt (abcShiftedJCurve P) ell ∧
      ∀ n ∈ orders, Nat.Coprime ell n := by
  classical
  rcases S.shiftedJCurve_eventual_largeImage P with ⟨N, hN⟩
  let B : ℕ := max N 5
  let Good : ℕ → Prop := fun ell =>
    5 ≤ ell ∧ S.LargeImageAt (abcShiftedJCurve P) ell
  rcases exists_prime_of_eventual_finite_exception_and_coprimality
      B ∅ orders horders Good
      (by
        intro ell hell hBell hellNot
        constructor
        · have h5B : 5 ≤ B := by simp [B]
          exact h5B.trans (Nat.le_of_lt hBell)
        · apply hN ell hell
          have hNB : N ≤ B := by simp [B]
          exact lt_of_le_of_lt hNB hBell) with
    ⟨ell, hell, hGood, hellNot, hcop⟩
  exact ⟨ell, hell, hGood.1, hGood.2, hcop⟩

end RationalCMOpenImagePackage

/-! ## Pointwise source assembly outside an exceptional set -/

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- Exact remaining source-facing assembler.

This structure does not store an abc inequality or a Corollary 3.12 proof. It
states what the actual geometric construction must consume: a nonexceptional
abc point, a prime at least five, the large-image theorem, and all required
finite coprimality conditions. Its output is the full `InitialThetaData`, so
implementing `assemble` requires the genuine orbicurve/core/tempered geometry
and local theta models. -/
structure ShiftedJInitialThetaAssembly
    (S : RationalCMOpenImagePackage)
    (AG : AnabelianGeometry.{u})
    (TG : TemperedGeometry AG) where
  exceptional : Finset ABCPoint
  localOrders : ABCPoint → Finset ℕ
  localOrders_ne_zero : ∀ P n, n ∈ localOrders P → n ≠ 0
  assemble : ∀ P : ABCPoint,
    P ∉ exceptional →
    ∀ ell : ℕ,
      ell.Prime →
      5 ≤ ell →
      S.LargeImageAt (abcShiftedJCurve P) ell →
      (∀ n ∈ localOrders P, Nat.Coprime ell n) →
      InitialThetaData AG TG

namespace ShiftedJInitialThetaAssembly

/-- **Pointwise initial theta-data outside the exceptional set**, reduced to
its genuine source assembler. All prime-existence and simultaneous
coprimality work is discharged by the preceding theorems. -/
theorem shiftedJ_initialThetaData_outside_exceptional
    {S : RationalCMOpenImagePackage}
    (A : ShiftedJInitialThetaAssembly S AG TG)
    (P : ABCPoint)
    (hP : P ∉ A.exceptional) :
    Nonempty (InitialThetaData AG TG) := by
  rcases S.exists_shiftedJ_largeImage_prime_coprime P
      (A.localOrders P)
      (A.localOrders_ne_zero P) with
    ⟨ell, hell, hfive, hlarge, hcop⟩
  exact ⟨A.assemble P hP ell hell hfive hlarge hcop⟩

/-- Family form of the pointwise construction. -/
theorem shiftedJ_initialThetaData_family_outside_exceptional
    {S : RationalCMOpenImagePackage}
    (A : ShiftedJInitialThetaAssembly S AG TG) :
    ∀ P : ABCPoint, P ∉ A.exceptional →
      Nonempty (InitialThetaData AG TG) := by
  intro P hP
  exact A.shiftedJ_initialThetaData_outside_exceptional P hP

end ShiftedJInitialThetaAssembly

end IUTThreeClosures
