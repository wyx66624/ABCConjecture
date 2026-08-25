/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteFermatOpenRing

/-!
# Comparison of the honest open Fermat ring with the tripod Kummer algebra

This module constructs the reverse map from the existing iterated tripod
Kummer algebra to the integral open Fermat ring and proves that it is inverse
to the forward map in `ConcreteFermatOpenRing`, yielding explicit `K`-algebra
and ring equivalences.  No compactification, boundary ramification, or Belyi
theorem is asserted here.
-/

namespace IUTThreeClosures
namespace ConcreteFermatTripodEquiv

noncomputable section

open Polynomial
open ConcreteFermatOpenRing

universe u

variable (K : Type u) [Field K] [CharZero K]

namespace T

abbrev TripodRing := ConcreteGenEllTripodCover.TripodRing
abbrev FirstRing := ConcreteGenEllTripodCover.TripodFirstKummerRing
abbrev FermatRing := ConcreteGenEllTripodCover.FermatAffineRing
abbrev firstPair := ConcreteGenEllTripodCover.tripodFirstKummerPair
abbrev secondPair := ConcreteGenEllTripodCover.fermatSecondKummerPair
abbrev fermatX := ConcreteGenEllTripodCover.fermatX
abbrev fermatY := ConcreteGenEllTripodCover.fermatY

end T

namespace O

abbrev Ring := ConcreteFermatOpenRing.FermatOpenRing

abbrev forward :=
  ConcreteFermatOpenRing.TripodComparison.openToTripodRingHom

end O

/-- Ring-homomorphism extensionality for a standard étale pair when the two
maps are known to agree on the coefficient ring and on the distinguished
root.  This is a ring-level wrapper around `StandardEtalePair.hom_ext`; it
does not assume either map is bijective. -/
theorem standardEtalePair_ringHom_ext
    {R S : Type*} [CommRing R] [CommRing S]
    (P : StandardEtalePair R) {f g : P.Ring →+* S}
    (hbase : f.comp (algebraMap R P.Ring) =
      g.comp (algebraMap R P.Ring))
    (hX : f P.X = g P.X) : f = g := by
  letI : Algebra R S :=
    (f.comp (algebraMap R P.Ring)).toAlgebra
  let fA : P.Ring →ₐ[R] S :=
    { toRingHom := f
      commutes' := fun _ => rfl }
  let gA : P.Ring →ₐ[R] S :=
    { toRingHom := g
      commutes' := fun r => (RingHom.congr_fun hbase r).symm }
  have hA : fA = gA := P.hom_ext (f := fA) (g := gA) hX
  exact congrArg (fun h : P.Ring →ₐ[R] S => h.toRingHom) hA

/-- Evaluate the polynomial tripod coordinate `t` at `openX^n`. -/
noncomputable def polynomialToOpenAlgHom
    {n : ℕ} : K[X] →ₐ[K] O.Ring K n :=
  Polynomial.aeval (openX K n ^ n)

omit [CharZero K] in
@[simp]
theorem polynomialToOpenAlgHom_X {n : ℕ} :
    polynomialToOpenAlgHom K (n := n) X = openX K n ^ n := by
  simp [polynomialToOpenAlgHom]

omit [CharZero K] in
/-- The tripod localization element maps to a unit in the open Fermat ring. -/
theorem polynomialToOpen_denominator_isUnit
    {n : ℕ} [NeZero n] :
    IsUnit
      (polynomialToOpenAlgHom K (n := n)
        (X * (1 - X))) := by
  have hx : IsUnit (openX K n ^ n) := (openX_isUnit K n).pow n
  have hy : IsUnit (openY K n ^ n) :=
    (openY_isUnit K (NeZero.pos n)).pow n
  have heq :
      polynomialToOpenAlgHom K (n := n) (X * (1 - X)) =
        openX K n ^ n * openY K n ^ n := by
    simp [polynomialToOpenAlgHom,
      openY_pow_eq_one_sub_openX_pow]
  rw [heq]
  exact hx.mul hy

/-- The tripod coordinate ring maps to the honest open Fermat ring by
`t |-> openX^n`. -/
noncomputable def tripodToOpenAlgHom
    {n : ℕ} [NeZero n] :
    T.TripodRing K →ₐ[K] O.Ring K n :=
  IsLocalization.Away.liftAlgHom (X * (1 - X))
    (polynomialToOpen_denominator_isUnit K)

omit [CharZero K] in
@[simp]
theorem tripodToOpenAlgHom_tripodT
    {n : ℕ} [NeZero n] :
    tripodToOpenAlgHom K
        (ConcreteGenEllTripodCover.tripodT K) =
      openX K n ^ n := by
  simp [tripodToOpenAlgHom, ConcreteGenEllTripodCover.tripodT,
    polynomialToOpenAlgHom]

omit [CharZero K] in
@[simp]
theorem tripodToOpenAlgHom_oneSubT
    {n : ℕ} [NeZero n] :
    tripodToOpenAlgHom K
        (ConcreteGenEllTripodCover.tripodOneSubT K) =
      1 - openX K n ^ n := by
  simp [ConcreteGenEllTripodCover.tripodOneSubT]

/-- The tripod algebra structure on the open Fermat ring induced by
`t |-> openX^n`. -/
@[reducible]
noncomputable def openTripodAlgebra
    {n : ℕ} [NeZero n] :
    Algebra (T.TripodRing K) (O.Ring K n) :=
  (tripodToOpenAlgHom K).toAlgebra

local instance openTripodAlgebraInstance
    {n : ℕ} [NeZero n] :
    Algebra (T.TripodRing K) (O.Ring K n) :=
  openTripodAlgebra K

/-- The open coordinate `x` satisfies the first Kummer presentation. -/
theorem firstPair_hasMap_openX
    {n : ℕ} [NeZero n] :
    (T.firstPair K n (NeZero.ne n)).HasMap (openX K n) := by
  constructor
  · change aeval (openX K n)
      (X ^ n - C
        (ConcreteGenEllTripodCover.tripodTUnit K : T.TripodRing K)) = 0
    rw [map_sub, aeval_X_pow, aeval_C]
    apply sub_eq_zero.mpr
    change openX K n ^ n =
      tripodToOpenAlgHom K
        (ConcreteGenEllTripodCover.tripodTUnit K : T.TripodRing K)
    rw [ConcreteGenEllTripodCover.coe_tripodTUnit,
      tripodToOpenAlgHom_tripodT]
  · change IsUnit (aeval (openX K n) (1 : (T.TripodRing K)[X]))
    rw [map_one]
    exact isUnit_one

/-- The first Kummer ring maps to the open Fermat ring by sending its root to
`openX`. -/
noncomputable def firstToOpenAlgHom
    {n : ℕ} [NeZero n] :
    T.FirstRing K n (NeZero.ne n) →ₐ[T.TripodRing K] O.Ring K n :=
  (T.firstPair K n (NeZero.ne n)).lift (openX K n)
    (firstPair_hasMap_openX K)

@[simp]
theorem firstToOpenAlgHom_X
    {n : ℕ} [NeZero n] :
    firstToOpenAlgHom K (T.firstPair K n (NeZero.ne n)).X =
      openX K n := by
  simp [firstToOpenAlgHom]

/-- The first-Kummer algebra structure on the open ring. -/
@[reducible]
noncomputable def openFirstAlgebra
    {n : ℕ} [NeZero n] :
    Algebra (T.FirstRing K n (NeZero.ne n)) (O.Ring K n) :=
  (firstToOpenAlgHom K).toAlgebra

local instance openFirstAlgebraInstance
    {n : ℕ} [NeZero n] :
    Algebra (T.FirstRing K n (NeZero.ne n)) (O.Ring K n) :=
  openFirstAlgebra K

/-- The open coordinate `y` satisfies the second Kummer presentation. -/
theorem secondPair_hasMap_openY
    {n : ℕ} [NeZero n] :
    (T.secondPair K n (NeZero.ne n)).HasMap (openY K n) := by
  constructor
  · change aeval (openY K n)
      (X ^ n - C
        (ConcreteGenEllTripodCover.firstLiftedOneSubTUnit K n (NeZero.ne n) :
          T.FirstRing K n (NeZero.ne n))) = 0
    rw [map_sub, aeval_X_pow, aeval_C]
    apply sub_eq_zero.mpr
    change openY K n ^ n =
      firstToOpenAlgHom K
        (ConcreteGenEllTripodCover.firstLiftedOneSubTUnit K n (NeZero.ne n) :
          T.FirstRing K n (NeZero.ne n))
    have hcoe :
        (ConcreteGenEllTripodCover.firstLiftedOneSubTUnit K n (NeZero.ne n) :
          T.FirstRing K n (NeZero.ne n)) =
        algebraMap (T.TripodRing K)
          (T.FirstRing K n (NeZero.ne n))
          (ConcreteGenEllTripodCover.tripodOneSubT K) := by
      simp [ConcreteGenEllTripodCover.firstLiftedOneSubTUnit]
    rw [hcoe, AlgHom.commutes, openY_pow_eq_one_sub_openX_pow]
    change 1 - openX K n ^ n =
      tripodToOpenAlgHom K
        (ConcreteGenEllTripodCover.tripodOneSubT K)
    exact (tripodToOpenAlgHom_oneSubT K).symm
  · change IsUnit
      (aeval (openY K n) (1 : (T.FirstRing K n (NeZero.ne n))[X]))
    rw [map_one]
    exact isUnit_one

/-- The reverse comparison map from the iterated tripod Kummer algebra to the
honest open Fermat ring. -/
noncomputable def tripodFermatToOpenAlgHom
    {n : ℕ} [NeZero n] :
    T.FermatRing K n (NeZero.ne n) →ₐ[T.FirstRing K n (NeZero.ne n)] O.Ring K n :=
  (T.secondPair K n (NeZero.ne n)).lift (openY K n)
    (secondPair_hasMap_openY K)

@[simp]
theorem tripodFermatToOpenAlgHom_fermatY
    {n : ℕ} [NeZero n] :
    tripodFermatToOpenAlgHom K (T.fermatY K n (NeZero.ne n)) =
      openY K n := by
  change (T.secondPair K n (NeZero.ne n)).lift (openY K n)
      (secondPair_hasMap_openY K)
      (T.secondPair K n (NeZero.ne n)).X = openY K n
  exact StandardEtalePair.lift_X _ _ _

@[simp]
theorem tripodFermatToOpenAlgHom_fermatX
    {n : ℕ} [NeZero n] :
    tripodFermatToOpenAlgHom K (T.fermatX K n (NeZero.ne n)) =
      openX K n := by
  unfold T.fermatX ConcreteGenEllTripodCover.fermatX
  rw [AlgHom.commutes]
  change firstToOpenAlgHom K (T.firstPair K n (NeZero.ne n)).X =
    openX K n
  exact firstToOpenAlgHom_X K

/-- The explicit coefficient-field algebra structure on the final iterated
Kummer ring. -/
@[reducible]
noncomputable def tripodFermatKAlgebra
    {n : ℕ} [NeZero n] :
    Algebra K (T.FermatRing K n (NeZero.ne n)) :=
  (ConcreteFermatOpenRing.TripodComparison.baseToTripodRingHom
    K (NeZero.ne n)).toAlgebra

local instance tripodFermatKAlgebraInstance
    {n : ℕ} [NeZero n] :
    Algebra K (T.FermatRing K n (NeZero.ne n)) :=
  tripodFermatKAlgebra K

/-- The forward comparison map preserves the coefficient field. -/
noncomputable def openToTripodKAlgHom
    {n : ℕ} [NeZero n] :
    O.Ring K n →ₐ[K] T.FermatRing K n (NeZero.ne n) where
  toRingHom := O.forward K (NeZero.ne n)
  commutes' := by
    intro r
    change O.forward K (NeZero.ne n) (algebraMap K (O.Ring K n) r) =
      ConcreteFermatOpenRing.TripodComparison.baseToTripodRingHom
        K (NeZero.ne n) r
    rw [IsScalarTower.algebraMap_apply K
      (ConcreteFermatIrreducibility.FermatAffineRing K n)
      (O.Ring K n),
      IsScalarTower.algebraMap_apply K K[X]
        (ConcreteFermatIrreducibility.FermatAffineRing K n)]
    simp [O.forward,
      ConcreteFermatOpenRing.TripodComparison.openToTripodRingHom,
      ConcreteFermatOpenRing.TripodComparison.affineToTripodRingHom,
      ConcreteFermatOpenRing.TripodComparison.coefficientToTripodRingHom,
      ConcreteFermatOpenRing.TripodComparison.baseToTripodRingHom]

/-- The reverse comparison map also preserves the coefficient field. -/
noncomputable def tripodFermatToOpenKAlgHom
    {n : ℕ} [NeZero n] :
    T.FermatRing K n (NeZero.ne n) →ₐ[K] O.Ring K n where
  toRingHom := (tripodFermatToOpenAlgHom K).toRingHom
  commutes' := by
    intro r
    change tripodFermatToOpenAlgHom K
      (algebraMap (T.FirstRing K n (NeZero.ne n))
        (T.FermatRing K n (NeZero.ne n))
        (algebraMap (T.TripodRing K)
          (T.FirstRing K n (NeZero.ne n))
          (algebraMap K[X] (T.TripodRing K) (C r)))) =
        algebraMap K (O.Ring K n) r
    rw [AlgHom.commutes]
    change firstToOpenAlgHom K
      (algebraMap (T.TripodRing K)
        (T.FirstRing K n (NeZero.ne n))
        (algebraMap K[X] (T.TripodRing K) (C r))) = _
    rw [AlgHom.commutes]
    change tripodToOpenAlgHom K
      (algebraMap K[X] (T.TripodRing K) (C r)) = _
    simp [tripodToOpenAlgHom, polynomialToOpenAlgHom]

@[simp]
theorem openToTripodKAlgHom_openX
    {n : ℕ} [NeZero n] :
    openToTripodKAlgHom K (openX K n) =
      T.fermatX K n (NeZero.ne n) :=
  ConcreteFermatOpenRing.TripodComparison.openToTripodRingHom_openX
    K (NeZero.ne n)

@[simp]
theorem openToTripodKAlgHom_openY
    {n : ℕ} [NeZero n] :
    openToTripodKAlgHom K (openY K n) =
      T.fermatY K n (NeZero.ne n) :=
  ConcreteFermatOpenRing.TripodComparison.openToTripodRingHom_openY
    K (NeZero.ne n)

@[simp]
theorem tripodFermatToOpenKAlgHom_fermatX
    {n : ℕ} [NeZero n] :
    tripodFermatToOpenKAlgHom K (T.fermatX K n (NeZero.ne n)) =
      openX K n :=
  tripodFermatToOpenAlgHom_fermatX K

@[simp]
theorem tripodFermatToOpenKAlgHom_fermatY
    {n : ℕ} [NeZero n] :
    tripodFermatToOpenKAlgHom K (T.fermatY K n (NeZero.ne n)) =
      openY K n :=
  tripodFermatToOpenAlgHom_fermatY K

omit [CharZero K] in
/-- A `K`-algebra map out of the honest open Fermat ring is determined by
the two open coordinates.  The proof uses `AdjoinRoot` extensionality before
localization and does not assume finite generation or bijectivity. -/
theorem openKAlgHom_ext
    {n : ℕ} [NeZero n]
    {S : Type*} [CommRing S] [Algebra K S]
    {f g : O.Ring K n →ₐ[K] S}
    (hx : f (openX K n) = g (openX K n))
    (hy : f (openY K n) = g (openY K n)) : f = g := by
  apply AlgHom.coe_ringHom_injective
  apply IsLocalization.ringHom_ext
    (Submonoid.powers (affineBoundary K n))
  apply AdjoinRoot.ringHom_ext
  · apply Polynomial.ringHom_ext
    · intro a
      change f (algebraMap
          (ConcreteFermatIrreducibility.FermatAffineRing K n)
          (O.Ring K n)
          (algebraMap K[X]
            (ConcreteFermatIrreducibility.FermatAffineRing K n)
            (C a))) =
        g (algebraMap
          (ConcreteFermatIrreducibility.FermatAffineRing K n)
          (O.Ring K n)
          (algebraMap K[X]
            (ConcreteFermatIrreducibility.FermatAffineRing K n)
            (C a)))
      rw [C_eq_algebraMap,
        ← IsScalarTower.algebraMap_apply K K[X]
          (ConcreteFermatIrreducibility.FermatAffineRing K n),
        ← IsScalarTower.algebraMap_apply K
          (ConcreteFermatIrreducibility.FermatAffineRing K n)
          (O.Ring K n)]
      exact (f.commutes a).trans (g.commutes a).symm
    · simpa [openX, affineX] using hx
  · simpa [openY, affineY] using hy

/-- The reverse comparison followed by the forward comparison is the
identity on the honest open Fermat ring. -/
theorem tripodFermatToOpen_comp_openToTripod
    {n : ℕ} [NeZero n] :
    (tripodFermatToOpenKAlgHom K).comp (openToTripodKAlgHom K) =
      AlgHom.id K (O.Ring K n) := by
  apply openKAlgHom_ext K
  · simp
  · simp

/-- A `K`-algebra map out of the iterated tripod Kummer ring is determined
by the two Fermat coordinates.  Extensionality is applied honestly in three
stages: tripod localization, first standard étale pair, second standard
étale pair. -/
theorem tripodFermatKAlgHom_ext
    {n : ℕ} [NeZero n]
    {S : Type*} [CommRing S] [Algebra K S]
    {f g : T.FermatRing K n (NeZero.ne n) →ₐ[K] S}
    (hx : f (T.fermatX K n (NeZero.ne n)) =
      g (T.fermatX K n (NeZero.ne n)))
    (hy : f (T.fermatY K n (NeZero.ne n)) =
      g (T.fermatY K n (NeZero.ne n))) : f = g := by
  apply AlgHom.coe_ringHom_injective
  apply standardEtalePair_ringHom_ext
    (T.secondPair K n (NeZero.ne n))
  · apply standardEtalePair_ringHom_ext
      (T.firstPair K n (NeZero.ne n))
    · apply IsLocalization.ringHom_ext
        (Submonoid.powers (X * (1 - X) : K[X]))
      apply Polynomial.ringHom_ext
      · intro a
        change f (algebraMap K
          (T.FermatRing K n (NeZero.ne n)) a) =
          g (algebraMap K
            (T.FermatRing K n (NeZero.ne n)) a)
        exact (f.commutes a).trans (g.commutes a).symm
      · change f (ConcreteGenEllTripodCover.fermatT
          K n (NeZero.ne n)) =
          g (ConcreteGenEllTripodCover.fermatT
            K n (NeZero.ne n))
        rw [← ConcreteGenEllTripodCover.fermatX_pow_eq_t,
          map_pow, map_pow, hx]
    · simpa [T.fermatX, ConcreteGenEllTripodCover.fermatX] using hx
  · exact hy

/-- The forward comparison followed by the reverse comparison is the
identity on the iterated tripod Kummer ring. -/
theorem openToTripod_comp_tripodFermatToOpen
    {n : ℕ} [NeZero n] :
    (openToTripodKAlgHom K).comp (tripodFermatToOpenKAlgHom K) =
      AlgHom.id K (T.FermatRing K n (NeZero.ne n)) := by
  apply tripodFermatKAlgHom_ext K
  · simp
  · simp

/-- The explicit `K`-algebra equivalence between the honest open Fermat
ring and the two-stage tripod Kummer algebra. -/
noncomputable def fermatOpenTripodAlgEquiv
    {n : ℕ} [NeZero n] :
    O.Ring K n ≃ₐ[K] T.FermatRing K n (NeZero.ne n) :=
  AlgEquiv.ofAlgHom (openToTripodKAlgHom K)
    (tripodFermatToOpenKAlgHom K)
    (openToTripod_comp_tripodFermatToOpen K)
    (tripodFermatToOpen_comp_openToTripod K)

/-- The underlying explicit ring equivalence. -/
noncomputable def fermatOpenTripodRingEquiv
    {n : ℕ} [NeZero n] :
    O.Ring K n ≃+* T.FermatRing K n (NeZero.ne n) :=
  (fermatOpenTripodAlgEquiv K).toRingEquiv

@[simp]
theorem fermatOpenTripodAlgEquiv_apply_openX
    {n : ℕ} [NeZero n] :
    fermatOpenTripodAlgEquiv K (openX K n) =
      T.fermatX K n (NeZero.ne n) :=
  openToTripodKAlgHom_openX K

@[simp]
theorem fermatOpenTripodAlgEquiv_apply_openY
    {n : ℕ} [NeZero n] :
    fermatOpenTripodAlgEquiv K (openY K n) =
      T.fermatY K n (NeZero.ne n) :=
  openToTripodKAlgHom_openY K

@[simp]
theorem fermatOpenTripodAlgEquiv_symm_apply_fermatX
    {n : ℕ} [NeZero n] :
    (fermatOpenTripodAlgEquiv K).symm
        (T.fermatX K n (NeZero.ne n)) = openX K n :=
  tripodFermatToOpenKAlgHom_fermatX K

@[simp]
theorem fermatOpenTripodAlgEquiv_symm_apply_fermatY
    {n : ℕ} [NeZero n] :
    (fermatOpenTripodAlgEquiv K).symm
        (T.fermatY K n (NeZero.ne n)) = openY K n :=
  tripodFermatToOpenKAlgHom_fermatY K

/-! ## Compatibility with the tripod base -/

/-- The forward comparison followed by the honest base map
`t |-> openX^n` is exactly the original composite tripod map into the
two-stage Kummer ring.  The proof checks the coefficient polynomial and its
generator, then uses localization extensionality; no commuting square is
assumed as structure data. -/
theorem openToTripod_comp_tripodToOpen_eq_tripodToFermat
    {n : ℕ} [NeZero n] :
    (O.forward K (NeZero.ne n)).comp
        (tripodToOpenAlgHom K).toRingHom =
      ConcreteGenEllTripodCover.tripodToFermatRingHom
        K n (NeZero.ne n) := by
  apply IsLocalization.ringHom_ext
    (Submonoid.powers (X * (1 - X) : K[X]))
  apply Polynomial.ringHom_ext
  · intro a
    simp only [RingHom.comp_apply]
    rw [C_eq_algebraMap,
      ← IsScalarTower.algebraMap_apply K K[X] (T.TripodRing K)]
    change O.forward K (NeZero.ne n)
        (tripodToOpenAlgHom K
          (algebraMap K (T.TripodRing K) a)) =
      ConcreteGenEllTripodCover.tripodToFermatRingHom
        K n (NeZero.ne n) (algebraMap K (T.TripodRing K) a)
    rw [(tripodToOpenAlgHom K).commutes]
    change openToTripodKAlgHom K
        (algebraMap K (O.Ring K n) a) =
      algebraMap K (T.FermatRing K n (NeZero.ne n)) a
    exact (openToTripodKAlgHom K).commutes a
  · simp only [RingHom.comp_apply]
    change O.forward K (NeZero.ne n)
        (tripodToOpenAlgHom K
          (ConcreteGenEllTripodCover.tripodT K)) =
      ConcreteGenEllTripodCover.tripodToFermatRingHom
        K n (NeZero.ne n) (ConcreteGenEllTripodCover.tripodT K)
    rw [tripodToOpenAlgHom_tripodT]
    change O.forward K (NeZero.ne n) (openX K n ^ n) =
      ConcreteGenEllTripodCover.fermatT K n (NeZero.ne n)
    rw [map_pow,
      ConcreteFermatOpenRing.TripodComparison.openToTripodRingHom_openX,
      ConcreteGenEllTripodCover.fermatX_pow_eq_t]

/-- The explicit equivalence is an equivalence over the actual tripod base:
the open side uses `t |-> openX^n`, while the Kummer side uses the original
composite `fermatTripodAlgebra`. -/
noncomputable def fermatOpenTripodBaseAlgEquiv
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
      K n (NeZero.ne n)
    O.Ring K n ≃ₐ[T.TripodRing K]
      T.FermatRing K n (NeZero.ne n) := by
  letI := openTripodAlgebra K (n := n)
  letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
    K n (NeZero.ne n)
  refine
    { fermatOpenTripodRingEquiv K with
      commutes' := ?_ }
  intro r
  exact RingHom.congr_fun
    (openToTripod_comp_tripodToOpen_eq_tripodToFermat K) r

@[simp]
theorem fermatOpenTripodBaseAlgEquiv_apply_openX
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
      K n (NeZero.ne n)
    fermatOpenTripodBaseAlgEquiv K (openX K n) =
      T.fermatX K n (NeZero.ne n) := by
  exact fermatOpenTripodAlgEquiv_apply_openX K

@[simp]
theorem fermatOpenTripodBaseAlgEquiv_apply_openY
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
      K n (NeZero.ne n)
    fermatOpenTripodBaseAlgEquiv K (openY K n) =
      T.fermatY K n (NeZero.ne n) := by
  exact fermatOpenTripodAlgEquiv_apply_openY K

/-! ## Transport of the finite-etale cover to the honest open ring -/

/-- The honest open Fermat ring is étale over the tripod for the base map
`t |-> openX^n`. -/
theorem fermatOpen_etale_over_tripod
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    Algebra.Etale (T.TripodRing K) (O.Ring K n) := by
  letI := openTripodAlgebra K (n := n)
  letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
    K n (NeZero.ne n)
  letI : Algebra.Etale (T.TripodRing K)
      (T.FermatRing K n (NeZero.ne n)) :=
    ConcreteGenEllTripodCover.fermat_etale_over_tripod
      K n (NeZero.ne n)
  exact Algebra.Etale.of_equiv
    (fermatOpenTripodBaseAlgEquiv K).symm

/-- The honest open Fermat ring is finite as a module over the tripod. -/
theorem fermatOpen_finite_over_tripod
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    Module.Finite (T.TripodRing K) (O.Ring K n) := by
  letI := openTripodAlgebra K (n := n)
  letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
    K n (NeZero.ne n)
  letI : Module.Finite (T.TripodRing K)
      (T.FermatRing K n (NeZero.ne n)) :=
    ConcreteGenEllTripodCover.fermat_finite_over_tripod
      K n (NeZero.ne n)
  exact Module.Finite.equiv
    (fermatOpenTripodBaseAlgEquiv K).symm.toLinearEquiv

/-- The honest open Fermat ring has exact rank `n^2` over the tripod. -/
theorem fermatOpen_finrank_over_tripod
    {n : ℕ} [NeZero n] :
    letI := openTripodAlgebra K (n := n)
    Module.finrank (T.TripodRing K) (O.Ring K n) = n ^ 2 := by
  letI := openTripodAlgebra K (n := n)
  letI := ConcreteGenEllTripodCover.fermatTripodAlgebra
    K n (NeZero.ne n)
  calc
    Module.finrank (T.TripodRing K) (O.Ring K n) =
        Module.finrank (T.TripodRing K)
          (T.FermatRing K n (NeZero.ne n)) :=
      (fermatOpenTripodBaseAlgEquiv K).toLinearEquiv.finrank_eq
    _ = n ^ 2 :=
      ConcreteGenEllTripodCover.fermat_finrank_over_tripod
        K n (NeZero.ne n)

end
end ConcreteFermatTripodEquiv
end IUTThreeClosures
