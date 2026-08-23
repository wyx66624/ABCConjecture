/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Compatible Frobenius data in a common finite quotient

Congruence, splitting and Frobenius-class requirements must not be proved on
unrelated infinite sets of primes and then intersected. They are first pulled
back to one common finite Galois quotient `G`. Each requirement is represented
by a homomorphism `G -> H_i` and a conjugation-stable allowed subset of `H_i`.
The simultaneous allowed set is their common pullback in `G`.

The exact compatibility statement is finite-group theoretic:

* the combined set is conjugation invariant;
* it is nonempty exactly when the product of the allowed target sets meets the
  image of the joint quotient map;
* for finite `G`, compatibility is equivalent to nonemptiness of an explicit
  filtered finset and can therefore be checked by finite search.

`CompatibleFrobeniusDatum` stores a witness in this common pullback. A later
Chebotarev theorem may turn such a nonempty conjugation-stable subset into an
unbounded prime supply. No Chebotarev theorem or prime existence is asserted
here.

The final section gives an explicit two-element-group counterexample: two
conditions may each be nonempty while their simultaneous pullback is empty.
Thus the naive "each condition has infinitely many primes" intersection route
is genuinely invalid and is excluded by a proved counterexample.
-/

namespace IUTThreeClosures

universe u v w

/-- A finite-quotient presentation of several Frobenius, splitting or
congruence conditions on one common group `G`. -/
structure FrobeniusConditionSystem
    (ι : Type u)
    (G : Type v) [Group G]
    (H : ι → Type w) [∀ i, Group (H i)] where
  quotient : ∀ i, G →* H i
  allowed : ∀ i, Set (H i)
  allowed_conj :
    ∀ (i : ι) (h x : H i),
      x ∈ allowed i →
      h * x * h⁻¹ ∈ allowed i

namespace FrobeniusConditionSystem

variable {ι : Type u}
variable {G : Type v} [Group G]
variable {H : ι → Type w} [∀ i, Group (H i)]
variable (S : FrobeniusConditionSystem ι G H)

/-- The common pullback of every allowed Frobenius condition. -/
def combinedAllowed : Set G :=
  {g | ∀ i, S.quotient i g ∈ S.allowed i}

/-- The simultaneous quotient map into the product of all target groups. -/
def jointMap : G →* (∀ i, H i) where
  toFun g i := S.quotient i g
  map_one' := by
    funext i
    exact map_one (S.quotient i)
  map_mul' g h := by
    funext i
    exact map_mul (S.quotient i) g h

/-- The direct product of the allowed target subsets. -/
def allowedProduct : Set (∀ i, H i) :=
  {x | ∀ i, x i ∈ S.allowed i}

/-- The common allowed set is exactly the inverse image of the product target
under the joint quotient map. -/
theorem combinedAllowed_eq_preimage :
    S.combinedAllowed = S.jointMap ⁻¹' S.allowedProduct := by
  ext g
  rfl

/-- Simultaneous Frobenius compatibility is conjugation invariant in the
common quotient. -/
theorem combinedAllowed_conj
    {g : G}
    (hg : g ∈ S.combinedAllowed)
    (h : G) :
    h * g * h⁻¹ ∈ S.combinedAllowed := by
  intro i
  have hi :=
    S.allowed_conj i (S.quotient i h) (S.quotient i g) (hg i)
  simpa using hi

/-- The combined set is nonempty exactly when the allowed product meets the
image of the joint quotient map. This is the exact finite-group compatibility
criterion. -/
theorem combinedAllowed_nonempty_iff_range_inter_allowedProduct :
    S.combinedAllowed.Nonempty ↔
      (Set.range S.jointMap ∩ S.allowedProduct).Nonempty := by
  constructor
  · rintro ⟨g, hg⟩
    refine ⟨S.jointMap g, ?_, ?_⟩
    · exact ⟨g, rfl⟩
    · exact hg
  · rintro ⟨y, ⟨g, rfl⟩, hy⟩
    exact ⟨g, hy⟩

/-- Exact prescribed target values are compatible precisely when their tuple
belongs to the image of the joint quotient map. -/
theorem exactTargets_compatible_iff_mem_range
    (target : ∀ i, H i) :
    (∃ g : G, ∀ i, S.quotient i g = target i) ↔
      target ∈ Set.range S.jointMap := by
  constructor
  · rintro ⟨g, hg⟩
    refine ⟨g, ?_⟩
    funext i
    exact hg i
  · rintro ⟨g, hg⟩
    refine ⟨g, ?_⟩
    intro i
    exact congrFun hg i

end FrobeniusConditionSystem

/-- A witness that every pulled-back Frobenius, splitting and congruence
condition is simultaneously satisfiable in the common quotient. -/
structure CompatibleFrobeniusDatum
    {ι : Type u}
    {G : Type v} [Group G]
    {H : ι → Type w} [∀ i, Group (H i)]
    (S : FrobeniusConditionSystem ι G H) where
  witness : G
  witness_mem : witness ∈ S.combinedAllowed

namespace CompatibleFrobeniusDatum

variable {ι : Type u}
variable {G : Type v} [Group G]
variable {H : ι → Type w} [∀ i, Group (H i)]
variable {S : FrobeniusConditionSystem ι G H}

/-- A compatible datum gives nonemptiness of the common Frobenius class. -/
theorem combinedAllowed_nonempty
    (D : CompatibleFrobeniusDatum S) :
    S.combinedAllowed.Nonempty :=
  ⟨D.witness, D.witness_mem⟩

/-- Compatibility data are equivalent to nonemptiness of the common pulled
back condition. -/
theorem nonempty_iff_combinedAllowed_nonempty :
    Nonempty (CompatibleFrobeniusDatum S) ↔
      S.combinedAllowed.Nonempty := by
  constructor
  · rintro ⟨D⟩
    exact D.combinedAllowed_nonempty
  · rintro ⟨g, hg⟩
    exact ⟨⟨g, hg⟩⟩

end CompatibleFrobeniusDatum

namespace FrobeniusConditionSystem

variable {ι : Type u}
variable {G : Type v} [Group G]
variable {H : ι → Type w} [∀ i, Group (H i)]
variable (S : FrobeniusConditionSystem ι G H)

section FiniteSearch

variable [Fintype G]
variable [DecidablePred fun g : G => g ∈ S.combinedAllowed]

/-- The finite set of all simultaneous Frobenius witnesses. -/
def compatibleElements : Finset G :=
  Finset.univ.filter fun g => g ∈ S.combinedAllowed

@[simp]
theorem mem_compatibleElements_iff (g : G) :
    g ∈ S.compatibleElements ↔ g ∈ S.combinedAllowed := by
  simp [compatibleElements]

/-- On a finite common quotient, compatibility is equivalent to nonemptiness
of an explicit finite search result. -/
theorem combinedAllowed_nonempty_iff_compatibleElements_nonempty :
    S.combinedAllowed.Nonempty ↔
      S.compatibleElements.Nonempty := by
  constructor
  · rintro ⟨g, hg⟩
    exact ⟨g, (S.mem_compatibleElements_iff g).2 hg⟩
  · rintro ⟨g, hg⟩
    exact ⟨g, (S.mem_compatibleElements_iff g).1 hg⟩

/-- The same finite search criterion stated directly for compatibility data. -/
theorem compatibleDatum_nonempty_iff_compatibleElements_nonempty :
    Nonempty (CompatibleFrobeniusDatum S) ↔
      S.compatibleElements.Nonempty := by
  rw [CompatibleFrobeniusDatum.nonempty_iff_combinedAllowed_nonempty]
  exact S.combinedAllowed_nonempty_iff_compatibleElements_nonempty

end FiniteSearch

end FrobeniusConditionSystem

/-! ## Counterexample to naive intersection of separate conditions -/

/-- The two-element multiplicative group used by the counterexample. -/
abbrev FrobeniusC2 := Multiplicative (ZMod 2)

/-- Two identity-quotient conditions on `C2`: one requires the identity and
the other requires the nonidentity element. Both allowed sets are nonempty
and conjugation invariant, but no common element satisfies them. -/
def incompatibleC2System :
    FrobeniusConditionSystem Bool FrobeniusC2
      (fun _ => FrobeniusC2) where
  quotient := fun _ => MonoidHom.id FrobeniusC2
  allowed := fun b =>
    if b then
      {Multiplicative.ofAdd (1 : ZMod 2)}
    else
      {1}
  allowed_conj := by
    intro b h x hx
    have hconj : h * x * h⁻¹ = x := by
      calc
        h * x * h⁻¹ = x * (h * h⁻¹) := by ac_rfl
        _ = x := by simp
    simpa [hconj] using hx

/-- Each of the two separate conditions has a witness. -/
theorem incompatibleC2_each_allowed_nonempty
    (b : Bool) :
    (incompatibleC2System.allowed b).Nonempty := by
  cases b <;> simp [incompatibleC2System]

/-- The identity and nonidentity elements of `C2` are distinct. -/
theorem frobeniusC2_one_ne_nontrivial :
    (1 : FrobeniusC2) ≠
      Multiplicative.ofAdd (1 : ZMod 2) := by
  intro h
  have h' : (0 : ZMod 2) = 1 := by
    simpa using congrArg Multiplicative.toAdd h
  norm_num at h'

/-- **Explicit finite-group counterexample.** Separate nonemptiness of every
allowed Frobenius condition does not imply simultaneous compatibility. -/
theorem incompatibleC2_combinedAllowed_empty :
    ¬ incompatibleC2System.combinedAllowed.Nonempty := by
  rintro ⟨g, hg⟩
  have hfalse := hg false
  have htrue := hg true
  simp [incompatibleC2System] at hfalse htrue
  exact frobeniusC2_one_ne_nontrivial (hfalse.symm.trans htrue)

/-- Consequently this finite system has no compatible Frobenius datum, even
though every individual condition is nonempty. -/
theorem incompatibleC2_no_compatibleDatum :
    ¬ Nonempty (CompatibleFrobeniusDatum incompatibleC2System) := by
  intro h
  exact incompatibleC2_combinedAllowed_empty
    (CompatibleFrobeniusDatum.nonempty_iff_combinedAllowed_nonempty.mp h)

end IUTThreeClosures
