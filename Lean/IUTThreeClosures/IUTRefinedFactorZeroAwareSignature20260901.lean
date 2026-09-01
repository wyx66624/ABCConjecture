/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTPrimeUnitLabelVectorBridge20260901
import IUTThreeClosures.SemisimplePacketCoordinates

/-!
# Refined-factor zero-aware prime-unit signatures

This module isolates the algebraic part of an all-component
prime-unit signature.  It does not assert that an IUT theta-link or
log-Kummer correspondence supplies the field equivalences used by the
covariance theorem below.

The two points addressed here are:

* packet regions contain zero, so the nonzero scale/unit coordinate must be
  extended by a zero tag;
* a place-tuple tensor algebra may have several primitive field factors, so
  the signature is indexed by `TupleFiniteEtalePacket.RefinedComponent`.
-/

namespace IUTThreeClosures

open IUTPrimeUnitLabelVectorBridge20260901

universe u v w u' v'

/-! ## One field factor, including zero -/

/-- A zero-aware scale coordinate.  `none` records zero; `some (n, u)`
records an exponent and the complete complementary field element. -/
def ZeroAwareScaleCoordinate (K : Type u) := Option (ℤ × K)

/-- Extend `fieldScaleUnit` from nonzero field elements to the whole field by
using an explicit zero tag. -/
noncomputable def zeroAwareScaleCoordinate
    {K : Type u} [Field K]
    (π : K) (exponent : NonzeroFieldElement K → ℤ)
    (x : K) : ZeroAwareScaleCoordinate K := by
  classical
  exact if hx : x = 0 then none
    else some (exponent ⟨x, hx⟩, fieldScaleUnit π exponent ⟨x, hx⟩)

/-- Reconstruct a field element from a zero-aware scale coordinate. -/
def reconstructZeroAware
    {K : Type u} [Field K] (π : K) :
    ZeroAwareScaleCoordinate K → K
  | none => 0
  | some eu => π ^ eu.1 * eu.2

/-- The zero-aware coordinate reconstructs its input. -/
theorem reconstruct_zeroAwareScaleCoordinate
    {K : Type u} [Field K]
    {π : K} (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ)
    (x : K) :
    reconstructZeroAware π (zeroAwareScaleCoordinate π exponent x) = x := by
  classical
  by_cases hx : x = 0
  · subst x
    simp [zeroAwareScaleCoordinate, reconstructZeroAware]
  · simp only [zeroAwareScaleCoordinate, hx, ↓reduceDIte,
      reconstructZeroAware]
    exact fieldScale_reconstruct hπ exponent ⟨x, hx⟩

/-- For every nonzero scale, the exponent together with the complete
complement, augmented by a zero tag, is a faithful coordinate on the whole
field. -/
theorem zeroAwareScaleCoordinate_injective
    {K : Type u} [Field K]
    {π : K} (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ) :
    Function.Injective (zeroAwareScaleCoordinate π exponent) := by
  intro x y hxy
  rw [← reconstruct_zeroAwareScaleCoordinate hπ exponent x,
      ← reconstruct_zeroAwareScaleCoordinate hπ exponent y,
      hxy]

/-! ## Covariance under a field equivalence -/

/-- Transport a zero-aware coordinate through a field equivalence. -/
def mapZeroAwareScaleCoordinate
    {K : Type u} {K' : Type v} [Field K] [Field K']
    (φ : K ≃+* K') :
    ZeroAwareScaleCoordinate K → ZeroAwareScaleCoordinate K'
  | none => none
  | some eu => some (eu.1, φ eu.2)

/-- Transport a nonzero field element through a field equivalence. -/
def mapNonzeroFieldElement
    {K : Type u} {K' : Type v} [Field K] [Field K']
    (φ : K ≃+* K')
    (x : NonzeroFieldElement K) : NonzeroFieldElement K' :=
  ⟨φ x.1, by simpa using x.2⟩

/-- If a field equivalence transports the chosen scale and the exponent map,
then it transports the complete zero-aware scale coordinate.  This is the
minimal multiplicative/valuation covariance premise needed after a source has
provided the field equivalence. -/
theorem zeroAwareScaleCoordinate_covariant
    {K : Type u} {K' : Type v} [Field K] [Field K']
    (φ : K ≃+* K') (π : K)
    (exponent : NonzeroFieldElement K → ℤ)
    (exponent' : NonzeroFieldElement K' → ℤ)
    (hexponent : ∀ x,
      exponent' (mapNonzeroFieldElement φ x) = exponent x)
    (x : K) :
    zeroAwareScaleCoordinate (φ π) exponent' (φ x) =
      mapZeroAwareScaleCoordinate φ
        (zeroAwareScaleCoordinate π exponent x) := by
  classical
  by_cases hx : x = 0
  · subst x
    simp [zeroAwareScaleCoordinate, mapZeroAwareScaleCoordinate]
  · have hφx : φ x ≠ 0 := by simpa using hx
    simp only [zeroAwareScaleCoordinate, hx, hφx, ↓reduceDIte,
      mapZeroAwareScaleCoordinate]
    apply congrArg some
    apply Prod.ext
    · simpa [mapNonzeroFieldElement] using hexponent ⟨x, hx⟩
    · unfold fieldScaleUnit
      let xx : NonzeroFieldElement K' := ⟨φ x, hφx⟩
      let yy : NonzeroFieldElement K := ⟨x, hx⟩
      change φ x / φ π ^ exponent' xx =
        φ (x / π ^ exponent yy)
      have hxx : xx = mapNonzeroFieldElement φ yy := by
        apply Subtype.ext
        rfl
      rw [hxx, hexponent]
      simp [map_zpow₀]

/-! ## Dependent products of refined factors -/

/-- The all-factor signature of a dependent product of fields. -/
noncomputable def refinedPrimeUnitSignature
    {D : Type u} (K : D → Type v) [∀ d, Field (K d)]
    (π : ∀ d, K d)
    (exponent : ∀ d, NonzeroFieldElement (K d) → ℤ)
    (x : ∀ d, K d) :
    ∀ d, ZeroAwareScaleCoordinate (K d) :=
  fun d => zeroAwareScaleCoordinate (π d) (exponent d) (x d)

/-- The all-factor signature is faithful when every chosen scale is nonzero. -/
theorem refinedPrimeUnitSignature_injective
    {D : Type u} (K : D → Type v) [∀ d, Field (K d)]
    (π : ∀ d, K d) (hπ : ∀ d, π d ≠ 0)
    (exponent : ∀ d, NonzeroFieldElement (K d) → ℤ) :
    Function.Injective (refinedPrimeUnitSignature K π exponent) := by
  intro x y hxy
  funext d
  apply zeroAwareScaleCoordinate_injective (hπ d) (exponent d)
  exact congrFun hxy d

/-- Componentwise covariance after a refined-component reindexing.  The
target packet `y` and target scales need only agree with the transported source
packet and source scales on the image of `σ`; since `σ` is an equivalence, this
is the full target index set. -/
theorem refinedPrimeUnitSignature_covariant
    {D : Type u} {D' : Type u'}
    (K : D → Type v) (K' : D' → Type v')
    [∀ d, Field (K d)] [∀ d', Field (K' d')]
    (σ : D ≃ D')
    (φ : ∀ d, K d ≃+* K' (σ d))
    (π : ∀ d, K d) (π' : ∀ d', K' d')
    (exponent : ∀ d, NonzeroFieldElement (K d) → ℤ)
    (exponent' : ∀ d', NonzeroFieldElement (K' d') → ℤ)
    (hscale : ∀ d, π' (σ d) = φ d (π d))
    (hexponent : ∀ d x,
      exponent' (σ d) (mapNonzeroFieldElement (φ d) x) =
        exponent d x)
    (x : ∀ d, K d) (y : ∀ d', K' d')
    (hxy : ∀ d, y (σ d) = φ d (x d)) :
    ∀ d,
      refinedPrimeUnitSignature K' π' exponent' y (σ d) =
        mapZeroAwareScaleCoordinate (φ d)
          (refinedPrimeUnitSignature K π exponent x d) := by
  intro d
  rw [refinedPrimeUnitSignature, refinedPrimeUnitSignature,
    hxy d, hscale d]
  exact zeroAwareScaleCoordinate_covariant
    (φ d) (π d) (exponent d) (exponent' (σ d))
    (hexponent d) (x d)

/-! ## The corrected finite-etale tensor-packet index -/

namespace TupleFiniteEtalePacket

variable {k : Type u} [Field k] {Tuple : Type v}
variable (P : TupleFiniteEtalePacket.{u, v, w} k Tuple)

/-- The complete zero-aware signature on all primitive field factors of a
tuple-indexed finite-etale packet. -/
noncomputable def packetRefinedPrimeUnitSignature
    (π : ∀ d : P.RefinedComponent, P.Summand d)
    (exponent : ∀ d : P.RefinedComponent,
      NonzeroFieldElement (P.Summand d) → ℤ)
    (x : ∀ d : P.RefinedComponent, P.Summand d) :
    ∀ d : P.RefinedComponent,
      ZeroAwareScaleCoordinate (P.Summand d) :=
  refinedPrimeUnitSignature (fun d => P.Summand d) π exponent x

/-- The refined-factor signature is faithful on the product of all primitive
field factors. -/
theorem packetRefinedPrimeUnitSignature_injective
    (π : ∀ d : P.RefinedComponent, P.Summand d)
    (hπ : ∀ d, π d ≠ 0)
    (exponent : ∀ d : P.RefinedComponent,
      NonzeroFieldElement (P.Summand d) → ℤ) :
    Function.Injective
      (P.packetRefinedPrimeUnitSignature π exponent) :=
  refinedPrimeUnitSignature_injective
    (fun d => P.Summand d) π hπ exponent

/-- First split every place-tuple tensor algebra into its primitive field
factors, then record the complete zero-aware signature on every factor. -/
noncomputable def allTuplePrimeUnitSignature
    (π : ∀ d : P.RefinedComponent, P.Summand d)
    (exponent : ∀ d : P.RefinedComponent,
      NonzeroFieldElement (P.Summand d) → ℤ)
    (x : ∀ c : Tuple, P.AlgebraAt c) :
    ∀ d : P.RefinedComponent,
      ZeroAwareScaleCoordinate (P.Summand d) :=
  P.packetRefinedPrimeUnitSignature π exponent (P.allTupleCoordinates x)

/-- The all-tuple signature is faithful.  This combines the canonical
finite-etale semisimple equivalence with factorwise reconstruction. -/
theorem allTuplePrimeUnitSignature_injective
    (π : ∀ d : P.RefinedComponent, P.Summand d)
    (hπ : ∀ d, π d ≠ 0)
    (exponent : ∀ d : P.RefinedComponent,
      NonzeroFieldElement (P.Summand d) → ℤ) :
    Function.Injective (P.allTuplePrimeUnitSignature π exponent) := by
  intro x y hxy
  apply P.allTupleCoordinates.injective
  apply P.packetRefinedPrimeUnitSignature_injective π hπ exponent
  exact hxy

end TupleFiniteEtalePacket

end IUTThreeClosures

#print axioms IUTThreeClosures.zeroAwareScaleCoordinate_injective
#print axioms IUTThreeClosures.zeroAwareScaleCoordinate_covariant
#print axioms IUTThreeClosures.refinedPrimeUnitSignature_injective
#print axioms IUTThreeClosures.refinedPrimeUnitSignature_covariant
#print axioms IUTThreeClosures.TupleFiniteEtalePacket.allTuplePrimeUnitSignature_injective

