/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTCorrectedVolumeHolonomy20260901

/-!
# A prime-unit-label vector bridge for the IUT same-pilot problem

This module retains the valuation exponent, the complete multiplicative unit
part, and the packet label before applying a scalar log-volume.  It proves:

* exact prime-unit decomposition and reconstruction in `ℚˣ` and in the
  genuine local field `ℚ_[p]`, together with a valuation-free
  scale-complement reconstruction in every field summand;
* injectivity of the resulting labelled packet signature;
* an abstract same-pilot bound bridge for every faithful prime-unit
  fingerprint;
* composition and pointed zero holonomy for labelled exponent shifts and unit
  twists;
* full counterexamples when the unit coordinate is deleted, truncated to one
  residue, or matched only up to a label permutation.

The module does not assert that an IUT theta/log-Kummer/Ind1--Ind3 transport
preserves this signature.  Establishing that preservation on the actual
source-defined carrier remains the open IUT obligation.
-/

namespace IUTThreeClosures
namespace IUTPrimeUnitLabelVectorBridge20260901

open scoped BigOperators

/-! ## Exact rational prime-unit coordinates -/

/-- A nonzero rational, used as the concrete local multiplicative carrier. -/
abbrev NonzeroRational := {x : ℚ // x ≠ 0}

/-- The rational `p`-adic exponent of a nonzero rational. -/
def localExponent (p : ℕ) (x : NonzeroRational) : ℤ :=
  padicValRat p x.1

/-- The complete unit part complementary to the `p`-adic exponent. -/
def localUnit (p : ℕ) (x : NonzeroRational) : ℚ :=
  x.1 / (p : ℚ) ^ localExponent p x

/-- The complete exponent-unit coordinate at a fixed rational prime. -/
structure PrimeUnitCoordinate (p : ℕ) where
  exponent : ℤ
  unitPart : ℚ
  unit_ne_zero : unitPart ≠ 0
  unit_valuation_zero : padicValRat p unitPart = 0

/-- The complete normalized local coordinate of a nonzero rational. -/
def primeUnitCoordinate (p : ℕ) (hp : p.Prime)
    (x : NonzeroRational) : PrimeUnitCoordinate p := by
  letI : Fact p.Prime := ⟨hp⟩
  refine
    { exponent := localExponent p x
      unitPart := localUnit p x
      unit_ne_zero := ?_
      unit_valuation_zero := ?_ }
  · exact div_ne_zero x.property
      (zpow_ne_zero _ (by exact_mod_cast hp.ne_zero))
  · have hpQ : (p : ℚ) ≠ 0 := by exact_mod_cast hp.ne_zero
    have hpow : ((p : ℚ) ^ localExponent p x) ≠ 0 :=
      zpow_ne_zero _ hpQ
    rw [localUnit, padicValRat.div x.property hpow,
      padicValRat.zpow, padicValRat.self hp.one_lt]
    simp [localExponent]

/-- Reconstruction of a rational from an exponent-unit coordinate. -/
def PrimeUnitCoordinate.reconstruct {p : ℕ}
    (c : PrimeUnitCoordinate p) : ℚ :=
  (p : ℚ) ^ c.exponent * c.unitPart

/-- The complete local coordinate reconstructs its input exactly. -/
@[simp]
theorem reconstruct_primeUnitCoordinate
    (p : ℕ) (hp : p.Prime) (x : NonzeroRational) :
    (primeUnitCoordinate p hp x).reconstruct = x.1 := by
  simp only [PrimeUnitCoordinate.reconstruct, primeUnitCoordinate,
    localUnit]
  have hpQ : (p : ℚ) ≠ 0 := by exact_mod_cast hp.ne_zero
  have hpow : ((p : ℚ) ^ localExponent p x) ≠ 0 :=
    zpow_ne_zero _ hpQ
  field_simp

/-- Complete prime-unit coordinates are injective at one rational prime. -/
theorem primeUnitCoordinate_injective (p : ℕ) (hp : p.Prime) :
    Function.Injective (primeUnitCoordinate p hp) := by
  intro x y hxy
  apply Subtype.ext
  have hreconstruct := congrArg PrimeUnitCoordinate.reconstruct hxy
  simpa using hreconstruct

/-- The unit part is nonzero. -/
theorem localUnit_ne_zero (p : ℕ) (hp : p.Prime)
    (x : NonzeroRational) : localUnit p x ≠ 0 := by
  exact (primeUnitCoordinate p hp x).unit_ne_zero

/-- The unit part really has zero `p`-adic exponent. -/
theorem localUnit_valuation_zero (p : ℕ) (hp : p.Prime)
    (x : NonzeroRational) : padicValRat p (localUnit p x) = 0 := by
  exact (primeUnitCoordinate p hp x).unit_valuation_zero

/-! ## The same coordinate on the actual p-adic local field -/

/-- A nonzero element of the genuine `p`-adic local field. -/
abbrev NonzeroPadic (p : ℕ) [Fact p.Prime] :=
  {x : ℚ_[p] // x ≠ 0}

/-- The integral additive valuation of a nonzero `p`-adic number. -/
noncomputable def padicLocalExponent {p : ℕ} [Fact p.Prime]
    (x : NonzeroPadic p) : ℤ :=
  Padic.valuation x.1

/-- The complete `p`-adic unit part after removing the uniformizer power. -/
noncomputable def padicLocalUnit {p : ℕ} [Fact p.Prime]
    (x : NonzeroPadic p) : ℚ_[p] :=
  x.1 / (p : ℚ_[p]) ^ padicLocalExponent x

/-- The complete unit part of a nonzero `p`-adic number has valuation zero. -/
theorem padicLocalUnit_valuation_zero
    {p : ℕ} [Fact p.Prime] (x : NonzeroPadic p) :
    Padic.valuation (padicLocalUnit x) = 0 := by
  have hp0 : (p : ℚ_[p]) ≠ 0 := by
    exact_mod_cast (Fact.out : p.Prime).ne_zero
  have hpow : ((p : ℚ_[p]) ^ padicLocalExponent x) ≠ 0 :=
    zpow_ne_zero _ hp0
  rw [padicLocalUnit, div_eq_mul_inv,
    Padic.valuation_mul x.property (inv_ne_zero hpow),
    Padic.valuation_inv, Padic.valuation_zpow, Padic.valuation_p]
  simp [padicLocalExponent]

/-- Uniformizer power times the complete `p`-adic unit part reconstructs the
original local-field element. -/
theorem padic_reconstruct_primeUnit
    {p : ℕ} [Fact p.Prime] (x : NonzeroPadic p) :
    (p : ℚ_[p]) ^ padicLocalExponent x * padicLocalUnit x = x.1 := by
  have hp0 : (p : ℚ_[p]) ≠ 0 := by
    exact_mod_cast (Fact.out : p.Prime).ne_zero
  have hpow : ((p : ℚ_[p]) ^ padicLocalExponent x) ≠ 0 :=
    zpow_ne_zero _ hp0
  rw [padicLocalUnit]
  field_simp

/-- Equality of the exponent and complete unit coordinates reconstructs an
actual nonzero `p`-adic number. -/
theorem padic_eq_of_primeUnit_eq
    {p : ℕ} [Fact p.Prime] {x y : NonzeroPadic p}
    (hexponent : padicLocalExponent x = padicLocalExponent y)
    (hunit : padicLocalUnit x = padicLocalUnit y) :
    x = y := by
  apply Subtype.ext
  calc
    x.1 = (p : ℚ_[p]) ^ padicLocalExponent x * padicLocalUnit x :=
      (padic_reconstruct_primeUnit x).symm
    _ = (p : ℚ_[p]) ^ padicLocalExponent y * padicLocalUnit y := by
      rw [hexponent, hunit]
    _ = y.1 := padic_reconstruct_primeUnit y

/-! ## A reusable field-summand reconstruction template -/

universe uK

/-- A nonzero element of an arbitrary field summand. -/
abbrev NonzeroFieldElement (K : Type uK) [Field K] :=
  {x : K // x ≠ 0}

/-- The complete complementary coordinate relative to a nonzero scale and an
integer-valued exponent map.  It becomes a valuation unit only after adding
the appropriate valued-field hypotheses. -/
def fieldScaleUnit
    {K : Type uK} [Field K]
    (π : K) (exponent : NonzeroFieldElement K → ℤ)
    (x : NonzeroFieldElement K) : K :=
  x.1 / π ^ exponent x

/-- The complete field-scale complement is nonzero. -/
theorem fieldScaleUnit_ne_zero
    {K : Type uK} [Field K]
    {π : K} (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ)
    (x : NonzeroFieldElement K) :
    fieldScaleUnit π exponent x ≠ 0 := by
  exact div_ne_zero x.property (zpow_ne_zero _ hπ)

/-- A scale power and its complete complementary unit reconstruct the input
in every field summand. -/
theorem fieldScale_reconstruct
    {K : Type uK} [Field K]
    {π : K} (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ)
    (x : NonzeroFieldElement K) :
    π ^ exponent x * fieldScaleUnit π exponent x = x.1 := by
  have hpow : π ^ exponent x ≠ 0 := zpow_ne_zero _ hπ
  rw [fieldScaleUnit]
  field_simp

/-- The exponent together with the complete complementary field element is
an injective coordinate, for any nonzero chosen scale. -/
theorem fieldScaleCoordinate_injective
    {K : Type uK} [Field K]
    {π : K} (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ) :
    Function.Injective
      (fun x : NonzeroFieldElement K =>
        (exponent x, fieldScaleUnit π exponent x)) := by
  intro x y hxy
  apply Subtype.ext
  have hexponent : exponent x = exponent y := by
    exact congrArg Prod.fst hxy
  have hunit : fieldScaleUnit π exponent x =
      fieldScaleUnit π exponent y := by
    exact congrArg Prod.snd hxy
  calc
    x.1 = π ^ exponent x * fieldScaleUnit π exponent x :=
      (fieldScale_reconstruct hπ exponent x).symm
    _ = π ^ exponent y * fieldScaleUnit π exponent y := by
      rw [hexponent, hunit]
    _ = y.1 := fieldScale_reconstruct hπ exponent y

/-! ## Generic faithful fingerprints and labelled packets -/

universe uP uX uU uL uM

/-- An explicitly proof-carrying prime-unit fingerprint.  Faithfulness is a
premise to be established by an actual arithmetic carrier, not an axiom. -/
structure PrimeUnitFingerprint
    (Place : Type uP) (X : Type uX) (UnitTag : Type uU) where
  exponent : Place → X → ℤ
  unit : Place → X → UnitTag
  faithful : ∀ {x y : X},
    (∀ v, exponent v x = exponent v y) →
    (∀ v, unit v x = unit v y) → x = y

/-- Every field summand with a nonzero chosen scale and an integer exponent
map has a faithful one-place complete-unit fingerprint. -/
def fieldScaleFingerprint
    {K : Type uK} [Field K]
    (π : K) (hπ : π ≠ 0)
    (exponent : NonzeroFieldElement K → ℤ) :
    PrimeUnitFingerprint Unit (NonzeroFieldElement K) K where
  exponent _ x := exponent x
  unit _ x := fieldScaleUnit π exponent x
  faithful := by
    intro x y hexponent hunit
    apply fieldScaleCoordinate_injective hπ exponent
    exact Prod.ext (hexponent ()) (hunit ())

/-- The full prime-unit-label signature of a packet. -/
def labelledSignature
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} (P : Label → X) :
    (Label → Place → ℤ) × (Label → Place → UnitTag) :=
  (fun i v => F.exponent v (P i), fun i v => F.unit v (P i))

/-- A faithful fingerprint remains injective after retaining every label. -/
theorem labelledSignature_injective
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} :
    Function.Injective (labelledSignature F (Label := Label)) := by
  intro P Q hPQ
  apply funext
  intro i
  apply F.faithful
  · intro v
    exact congrFun (congrFun (congrArg Prod.fst hPQ) i) v
  · intro v
    exact congrFun (congrFun (congrArg Prod.snd hPQ) i) v

/-- Inclusion of the complete signature images lifts to inclusion of the
underlying packet regions. -/
theorem region_subset_of_labelledSignature_image_subset
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} {A B : Set (Label → X)}
    (himage : labelledSignature F '' A ⊆ labelledSignature F '' B) :
    A ⊆ B := by
  intro P hP
  have hsigP : labelledSignature F P ∈ labelledSignature F '' A :=
    ⟨P, hP, rfl⟩
  rcases himage hsigP with ⟨Q, hQ, hsignature⟩
  have hPQ : P = Q :=
    labelledSignature_injective F hsignature.symm
  simpa [hPQ] using hQ

/-- Equality of complete signature images reconstructs the whole packet
region, not merely one scalar volume. -/
theorem region_eq_of_labelledSignature_image_eq
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} {A B : Set (Label → X)}
    (himage : labelledSignature F '' A = labelledSignature F '' B) :
    A = B := by
  apply Set.Subset.antisymm
  · apply region_subset_of_labelledSignature_image_subset F
    rw [himage]
  · apply region_subset_of_labelledSignature_image_subset F
    rw [himage]

/-- A monotone region functional transfers an output upper bound once
complete signature-image containment has been proved independently. -/
theorem region_bound_of_labelledSignature_image_subset
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL}
    (volume : Set (Label → X) → ℝ) (hmono : Monotone volume)
    {input output : Set (Label → X)} {T : ℝ}
    (himage :
      labelledSignature F '' input ⊆ labelledSignature F '' output)
    (houtput : volume output ≤ T) :
    volume input ≤ T :=
  (hmono (region_subset_of_labelledSignature_image_subset F himage)).trans
    houtput

/-- Equality of a faithful labelled signature transfers any numerical output
bound to the input pilot without first quotienting by that number. -/
theorem bound_of_labelledSignature_eq
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} {P Q : Label → X}
    (hsignature : labelledSignature F P = labelledSignature F Q)
    (observable : (Label → X) → ℝ) {T : ℝ}
    (houtput : observable Q ≤ T) :
    observable P ≤ T := by
  have hPQ := labelledSignature_injective F hsignature
  simpa [hPQ] using houtput

/-- Exact coordinate matching along a specified label equivalence reconstructs
the packet along that same equivalence. -/
theorem reconstruct_under_relabeling
    {Place : Type uP} {X : Type uX} {UnitTag : Type uU}
    (F : PrimeUnitFingerprint Place X UnitTag)
    {Label : Type uL} {OtherLabel : Type uM}
    (σ : Label ≃ OtherLabel) (P : Label → X) (Q : OtherLabel → X)
    (hexponent : ∀ i v,
      F.exponent v (P i) = F.exponent v (Q (σ i)))
    (hunit : ∀ i v, F.unit v (P i) = F.unit v (Q (σ i))) :
    ∀ i, P i = Q (σ i) := by
  intro i
  exact F.faithful (hexponent i) (hunit i)

/-- The concrete one-place rational fingerprint. -/
def rationalPrimeUnitFingerprint (p : ℕ) (hp : p.Prime) :
    PrimeUnitFingerprint Unit NonzeroRational ℚ where
  exponent _ x := localExponent p x
  unit _ x := localUnit p x
  faithful := by
    intro x y hexponent hunit
    apply Subtype.ext
    calc
      x.1 = (p : ℚ) ^ localExponent p x * localUnit p x :=
        (reconstruct_primeUnitCoordinate p hp x).symm
      _ = (p : ℚ) ^ localExponent p y * localUnit p y := by
        rw [hexponent (), hunit ()]
      _ = y.1 := reconstruct_primeUnitCoordinate p hp y

/-- The actual `p`-adic local field supplies a faithful one-place
prime-unit fingerprint. -/
noncomputable def padicPrimeUnitFingerprint (p : ℕ) [Fact p.Prime] :
    PrimeUnitFingerprint Unit (NonzeroPadic p) ℚ_[p] where
  exponent _ x := padicLocalExponent x
  unit _ x := padicLocalUnit x
  faithful := by
    intro x y hexponent hunit
    exact padic_eq_of_primeUnit_eq (hexponent ()) (hunit ())

/-- The complete prime-unit-label signature is injective for packets of
actual nonzero `p`-adic numbers. -/
theorem padic_labelledSignature_injective
    (p : ℕ) [Fact p.Prime] {Label : Type uL} :
    Function.Injective
      (labelledSignature (padicPrimeUnitFingerprint p) (Label := Label)) :=
  labelledSignature_injective (padicPrimeUnitFingerprint p)

/-- The rational labelled signature is injective at a single prime. -/
theorem rational_labelledSignature_injective
    (p : ℕ) (hp : p.Prime) {Label : Type uL} :
    Function.Injective
      (labelledSignature (rationalPrimeUnitFingerprint p hp)
        (Label := Label)) :=
  labelledSignature_injective (rationalPrimeUnitFingerprint p hp)

/-- Pointwise equality of both rational local coordinates at every fixed
label reconstructs the whole packet. -/
theorem rational_packet_eq_of_local_coordinates
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational}
    (hexponent : ∀ i,
      localExponent p (P i) = localExponent p (Q i))
    (hunit : ∀ i, localUnit p (P i) = localUnit p (Q i)) :
    P = Q := by
  apply funext
  intro i
  exact (rationalPrimeUnitFingerprint p hp).faithful
    (fun _ => hexponent i) (fun _ => hunit i)

/-- Equality of rational labelled signatures implies equality of every
weighted observable, without any positivity assumption on the weights. -/
theorem weightedObservable_eq_of_signature_eq
    (p : ℕ) (hp : p.Prime)
    {Label : Type uL} [Fintype Label]
    {P Q : Label → NonzeroRational}
    (hsignature :
      labelledSignature (rationalPrimeUnitFingerprint p hp) P =
        labelledSignature (rationalPrimeUnitFingerprint p hp) Q)
    (weight : Label → ℝ) (observable : NonzeroRational → ℝ) :
    (∑ i, weight i * observable (P i)) =
      ∑ i, weight i * observable (Q i) := by
  have hPQ := rational_labelledSignature_injective p hp hsignature
  subst Q
  rfl

/-- Strictly positive normalized weights, matching the packet-volume regime. -/
structure PositiveNormalizedWeights (Label : Type uL) [Fintype Label] where
  weight : Label → ℝ
  positive : ∀ i, 0 < weight i
  normalized : ∑ i, weight i = 1

/-- The exact labelled signature bridge applies, in particular, to every
strictly positive normalized packet weight. -/
theorem positiveNormalizedObservable_eq_of_signature_eq
    (p : ℕ) (hp : p.Prime)
    {Label : Type uL} [Fintype Label]
    {P Q : Label → NonzeroRational}
    (hsignature :
      labelledSignature (rationalPrimeUnitFingerprint p hp) P =
        labelledSignature (rationalPrimeUnitFingerprint p hp) Q)
    (W : PositiveNormalizedWeights Label)
    (observable : NonzeroRational → ℝ) :
    (∑ i, W.weight i * observable (P i)) =
      ∑ i, W.weight i * observable (Q i) :=
  weightedObservable_eq_of_signature_eq p hp hsignature W.weight observable

/-! ## Labelled vector holonomy -/

/-- A transport records exponent shifts and complete-unit twists separately
at every fixed label. -/
structure PrimeUnitVectorTransport
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    (source target : Label → NonzeroRational)
    (exponentShift : Label → ℤ) (unitTwist : Label → ℚ) : Prop where
  exponent_shift : ∀ i,
    localExponent p (target i) =
      localExponent p (source i) + exponentShift i
  unit_twist : ∀ i,
    localUnit p (target i) = localUnit p (source i) * unitTwist i

/-- Every unit twist in an actual vector transport is nonzero. -/
theorem PrimeUnitVectorTransport.unitTwist_ne_zero
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational} {δ : Label → ℤ} {τ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ) :
    ∀ i, τ i ≠ 0 := by
  intro i hzero
  apply localUnit_ne_zero p hp (Q i)
  rw [A.unit_twist i, hzero, mul_zero]

/-- Every unit twist has zero `p`-adic valuation, so it is itself a genuine
local unit. -/
theorem PrimeUnitVectorTransport.unitTwist_valuation_zero
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational} {δ : Label → ℤ} {τ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ) :
    ∀ i, padicValRat p (τ i) = 0 := by
  letI : Fact p.Prime := ⟨hp⟩
  intro i
  have hτ : τ i ≠ 0 := A.unitTwist_ne_zero p hp i
  have hvaluation := congrArg (padicValRat p) (A.unit_twist i)
  rw [localUnit_valuation_zero p hp (Q i),
    padicValRat.mul (localUnit_ne_zero p hp (P i)) hτ,
    localUnit_valuation_zero p hp (P i), zero_add] at hvaluation
  exact hvaluation.symm

/-- Vector transports compose by labelwise addition of exponent shifts and
multiplication of unit twists. -/
theorem PrimeUnitVectorTransport.comp
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q R : Label → NonzeroRational}
    {δ ε : Label → ℤ} {τ υ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ)
    (B : PrimeUnitVectorTransport p hp Q R ε υ) :
    PrimeUnitVectorTransport p hp P R (fun i => δ i + ε i)
      (fun i => τ i * υ i) := by
  constructor
  · intro i
    rw [B.exponent_shift i, A.exponent_shift i]
    omega
  · intro i
    rw [B.unit_twist i, A.unit_twist i]
    ring

/-- A closed pointed labelled loop has zero exponent shift at every label. -/
theorem PrimeUnitVectorTransport.exponentShift_eq_zero_of_closed
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational} {δ : Label → ℤ} {τ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ)
    (hclosed : Q = P) :
    ∀ i, δ i = 0 := by
  subst Q
  intro i
  have h := A.exponent_shift i
  omega

/-- A closed pointed labelled loop has trivial complete-unit twist at every
label. -/
theorem PrimeUnitVectorTransport.unitTwist_eq_one_of_closed
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational} {δ : Label → ℤ} {τ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ)
    (hclosed : Q = P) :
    ∀ i, τ i = 1 := by
  subst Q
  intro i
  have hunit := localUnit_ne_zero p hp (P i)
  apply (mul_left_cancel₀ hunit)
  simpa using (A.unit_twist i).symm

/-- The combined pointed vector zero-holonomy theorem. -/
theorem PrimeUnitVectorTransport.vectorHolonomy_eq_identity_of_closed
    (p : ℕ) (hp : p.Prime) {Label : Type uL}
    {P Q : Label → NonzeroRational} {δ : Label → ℤ} {τ : Label → ℚ}
    (A : PrimeUnitVectorTransport p hp P Q δ τ)
    (hclosed : Q = P) :
    (∀ i, δ i = 0) ∧ (∀ i, τ i = 1) :=
  ⟨A.exponentShift_eq_zero_of_closed p hp hclosed,
    A.unitTwist_eq_one_of_closed p hp hclosed⟩

/-! ## Explicit counterexamples to weakened interfaces -/

def rationalOne : NonzeroRational := ⟨1, by norm_num⟩
def rationalTwo : NonzeroRational := ⟨2, by norm_num⟩
def rationalSix : NonzeroRational := ⟨6, by norm_num⟩

@[simp] theorem localExponent_five_one : localExponent 5 rationalOne = 0 := by
  norm_num [localExponent, rationalOne]

@[simp] theorem localExponent_five_two : localExponent 5 rationalTwo = 0 := by
  norm_num [localExponent, rationalTwo, padicValRat]

@[simp] theorem localExponent_five_six : localExponent 5 rationalSix = 0 := by
  change padicValRat 5 (6 : ℚ) = 0
  letI : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  calc
    padicValRat 5 (6 : ℚ) =
        padicValRat 5 ((2 : ℚ) * (3 : ℚ)) := by norm_num
    _ = padicValRat 5 (2 : ℚ) + padicValRat 5 (3 : ℚ) := by
      rw [padicValRat.mul (by norm_num) (by norm_num)]
    _ = 0 := by
      have h2 : padicValRat 5 (2 : ℚ) = 0 := by
        simpa using
          (IUTCorrectedVolumeHolonomy20260901.padicValRat_natPrime
            (p := 5) (q := 2) (by norm_num) (by norm_num))
      have h3 : padicValRat 5 (3 : ℚ) = 0 := by
        simpa using
          (IUTCorrectedVolumeHolonomy20260901.padicValRat_natPrime
            (p := 5) (q := 3) (by norm_num) (by norm_num))
      rw [h2, h3, add_zero]

@[simp] theorem localUnit_five_one : localUnit 5 rationalOne = 1 := by
  change (1 : ℚ) / (5 : ℚ) ^ localExponent 5 rationalOne = 1
  rw [localExponent_five_one]
  norm_num

@[simp] theorem localUnit_five_two : localUnit 5 rationalTwo = 2 := by
  change (2 : ℚ) / (5 : ℚ) ^ localExponent 5 rationalTwo = 2
  rw [localExponent_five_two]
  norm_num

@[simp] theorem localUnit_five_six : localUnit 5 rationalSix = 6 := by
  change (6 : ℚ) / (5 : ℚ) ^ localExponent 5 rationalSix = 6
  rw [localExponent_five_six]
  norm_num

/-- The unique strictly positive normalized weight on `Fin 1` used by the
exponent-only and residue-unit counterexamples. -/
def singletonPositiveWeight : PositiveNormalizedWeights (Fin 1) where
  weight _ := 1
  positive _ := by norm_num
  normalized := by simp

/-- Full counterexample to labelled exponent-only reconstruction at `p = 5`:
all exponents and labels match and the weight is positive normalized, but the
packets differ because their complete unit parts differ. -/
theorem exponentOnly_labelled_counterexample :
    ∃ P Q : Fin 1 → NonzeroRational,
      P ≠ Q ∧
      (∀ i, localExponent 5 (P i) = localExponent 5 (Q i)) ∧
      (∀ i, 0 < singletonPositiveWeight.weight i) ∧
      (∑ i, singletonPositiveWeight.weight i) = 1 := by
  refine ⟨fun _ => rationalOne, fun _ => rationalTwo, ?_, ?_, ?_, ?_⟩
  · intro h
    have h0 := congrFun h 0
    have hv := congrArg Subtype.val h0
    norm_num [rationalOne, rationalTwo] at hv
  · intro i
    simp
  · exact singletonPositiveWeight.positive
  · exact singletonPositiveWeight.normalized

/-- The omitted unit coordinate is visibly different in the exponent-only
counterexample. -/
theorem exponentOnly_counterexample_unit_parts_differ :
    localUnit 5 rationalOne ≠ localUnit 5 rationalTwo := by
  norm_num

/-- Even the exponent together with the first unit residue modulo `5` does
not distinguish `1` from `6`. -/
theorem residueUnit_counterexample :
    localExponent 5 rationalOne = localExponent 5 rationalSix ∧
      ((1 : ZMod 5) = (6 : ZMod 5)) ∧ rationalOne ≠ rationalSix ∧
      (∀ i, 0 < singletonPositiveWeight.weight i) ∧
      (∑ i, singletonPositiveWeight.weight i) = 1 := by
  refine ⟨by simp, by decide, ?_, singletonPositiveWeight.positive,
    singletonPositiveWeight.normalized⟩
  · intro h
    have hv := congrArg Subtype.val h
    norm_num [rationalOne, rationalSix] at hv

/-- Symmetric positive normalized weights on two labels. -/
noncomputable def twoLabelPositiveWeight : PositiveNormalizedWeights (Fin 2) where
  weight _ := (1 : ℝ) / 2
  positive _ := by norm_num
  normalized := by norm_num [Fin.sum_univ_two]

/-- A two-label packet `(1,2)`. -/
def packetOneTwo : Fin 2 → NonzeroRational
  | 0 => rationalOne
  | 1 => rationalTwo

/-- The label-swapped packet `(2,1)`. -/
def packetTwoOne : Fin 2 → NonzeroRational
  | 0 => rationalTwo
  | 1 => rationalOne

/-- Transposition of the two labels. -/
def swapFinTwo : Fin 2 ≃ Fin 2 where
  toFun i := if i = 0 then 1 else 0
  invFun i := if i = 0 then 1 else 0
  left_inv i := by fin_cases i <;> simp
  right_inv i := by fin_cases i <;> simp

/-- Complete prime-unit coordinates agree after forgetting the labels and
matching by the transposition. -/
theorem unlabelled_coordinates_match_after_swap :
    ∀ i,
      primeUnitCoordinate 5 (by norm_num) (packetOneTwo i) =
        primeUnitCoordinate 5 (by norm_num) (packetTwoOne (swapFinTwo i)) := by
  intro i
  fin_cases i <;> rfl

/-- The packets whose complete coordinates match after transposition are not
equal as labelled packets. -/
theorem swapped_packets_ne : packetOneTwo ≠ packetTwoOne := by
  intro h
  have h0 := congrFun h 0
  have hv := congrArg Subtype.val h0
  norm_num [packetOneTwo, packetTwoOne, rationalOne, rationalTwo] at hv

/-- The fixed-label transport from `(1,2)` to `(2,1)` has zero exponent
shifts but reciprocal nontrivial unit twists. -/
theorem swappedPacket_vectorTransport :
    PrimeUnitVectorTransport 5 (by norm_num) packetOneTwo packetTwoOne
      (fun _ => 0) (fun i => if i = 0 then 2 else (1 : ℚ) / 2) := by
  constructor
  · intro i
    fin_cases i <;> simp [packetOneTwo, packetTwoOne]
  · intro i
    fin_cases i <;> norm_num [packetOneTwo, packetTwoOne]

/-- The aggregate unit twist in the swapped-packet counterexample is one. -/
theorem swappedPacket_unitTwist_product_one :
    (∏ i : Fin 2, (if i = 0 then (2 : ℚ) else (1 : ℚ) / 2)) = 1 := by
  norm_num [Fin.prod_univ_two]

/-- Nevertheless neither labelwise unit twist is forced to be one. -/
theorem swappedPacket_nontrivial_labelwise_unitTwist :
    (if (0 : Fin 2) = 0 then (2 : ℚ) else (1 : ℚ) / 2) ≠ 1 ∧
      (if (1 : Fin 2) = 0 then (2 : ℚ) else (1 : ℚ) / 2) ≠ 1 := by
  norm_num

/-- Full counterexample to reconstruction from an unordered multiset of exact
coordinates, even with positive normalized symmetric weights and aggregate
unit twist one. -/
theorem unlabelled_exact_coordinate_counterexample :
    packetOneTwo ≠ packetTwoOne ∧
      (∀ i,
        primeUnitCoordinate 5 (by norm_num) (packetOneTwo i) =
          primeUnitCoordinate 5 (by norm_num)
            (packetTwoOne (swapFinTwo i))) ∧
      (∀ i, 0 < twoLabelPositiveWeight.weight i) ∧
      (∑ i, twoLabelPositiveWeight.weight i) = 1 ∧
      (∏ i : Fin 2,
        (if i = 0 then (2 : ℚ) else (1 : ℚ) / 2)) = 1 :=
  ⟨swapped_packets_ne,
    unlabelled_coordinates_match_after_swap,
    twoLabelPositiveWeight.positive,
    twoLabelPositiveWeight.normalized,
    swappedPacket_unitTwist_product_one⟩

#print axioms localUnit_valuation_zero
#print axioms padicLocalUnit_valuation_zero
#print axioms padic_reconstruct_primeUnit
#print axioms padic_eq_of_primeUnit_eq
#print axioms fieldScaleUnit_ne_zero
#print axioms fieldScale_reconstruct
#print axioms fieldScaleCoordinate_injective
#print axioms fieldScaleFingerprint
#print axioms reconstruct_primeUnitCoordinate
#print axioms primeUnitCoordinate_injective
#print axioms labelledSignature_injective
#print axioms region_subset_of_labelledSignature_image_subset
#print axioms region_eq_of_labelledSignature_image_eq
#print axioms region_bound_of_labelledSignature_image_subset
#print axioms bound_of_labelledSignature_eq
#print axioms reconstruct_under_relabeling
#print axioms rational_labelledSignature_injective
#print axioms padic_labelledSignature_injective
#print axioms rational_packet_eq_of_local_coordinates
#print axioms weightedObservable_eq_of_signature_eq
#print axioms positiveNormalizedObservable_eq_of_signature_eq
#print axioms PrimeUnitVectorTransport.comp
#print axioms PrimeUnitVectorTransport.unitTwist_ne_zero
#print axioms PrimeUnitVectorTransport.unitTwist_valuation_zero
#print axioms PrimeUnitVectorTransport.vectorHolonomy_eq_identity_of_closed
#print axioms exponentOnly_labelled_counterexample
#print axioms residueUnit_counterexample
#print axioms unlabelled_coordinates_match_after_swap
#print axioms swappedPacket_vectorTransport
#print axioms unlabelled_exact_coordinate_counterexample
#print axioms localUnit_ne_zero
#print axioms PrimeUnitVectorTransport.exponentShift_eq_zero_of_closed
#print axioms PrimeUnitVectorTransport.unitTwist_eq_one_of_closed
#print axioms localExponent_five_one
#print axioms localExponent_five_two
#print axioms localExponent_five_six
#print axioms localUnit_five_one
#print axioms localUnit_five_two
#print axioms localUnit_five_six
#print axioms exponentOnly_counterexample_unit_parts_differ
#print axioms swapped_packets_ne
#print axioms swappedPacket_unitTwist_product_one
#print axioms swappedPacket_nontrivial_labelwise_unitTwist

end IUTPrimeUnitLabelVectorBridge20260901
end IUTThreeClosures
