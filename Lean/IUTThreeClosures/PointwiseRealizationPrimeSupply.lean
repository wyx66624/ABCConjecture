/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AdmissiblePrimeSelection

/-!
# Pointwise realizations and cofinite admissible-prime supply

This module isolates two purely logical/arithmetic layers of the remaining
IUT construction.

First, a dependent `Realization` packages a prime object, an orbicurve object,
a local theta object depending on both, and a source theorem depending on all
three.  A target theorem needs only pointwise nonemptiness of this package.
Classical choice can turn pointwise nonemptiness into a noncanonical family;
any additional compatibility between different inputs must still be stated as
a separate predicate and is not manufactured here.

Second, `PrimeSupply P` means that a prime satisfying `P` can be found above
any bound while avoiding any prescribed finite set.  A
`CofinitePrimeCondition Q` records that `Q` fails at only finitely many primes.
The theorem `PrimeSupply.andCofinite` proves the exact closure principle used
in admissible-prime assembly:

`PrimeSupply P -> Q cofinite on primes -> PrimeSupply (P and Q)`.

Thus Frobenius/Chebotarev supply may be proved once for the genuinely
arithmetic condition, while residue-characteristic, Tate-order and other
finite-exception requirements are added without intersecting unrelated
infinite prime sets.
-/

namespace IUTThreeClosures

universe u v₁ v₂ v₃

namespace PointwiseRealization

variable {Input : Type u}
variable
  (PrimeData : Input → Type v₁)
  (OrbicurveData : (x : Input) → PrimeData x → Type v₂)
  (ThetaData :
    (x : Input) →
    (p : PrimeData x) →
    OrbicurveData x p →
    Type v₃)
  (Source :
    (x : Input) →
    (p : PrimeData x) →
    (o : OrbicurveData x p) →
    ThetaData x p o →
    Prop)

/-- The four dependent stages required at one arithmetic input. -/
structure Realization (x : Input) where
  prime : PrimeData x
  orbicurve : OrbicurveData x prime
  theta : ThetaData x prime orbicurve
  source : Source x prime orbicurve theta

/-- A pointwise realization is enough for every pointwise target consequence. -/
theorem target_of_pointwise_realization
    {Target : Input → Prop}
    (hSound :
      ∀ (x : Input)
        (p : PrimeData x)
        (o : OrbicurveData x p)
        (t : ThetaData x p o),
        Source x p o t → Target x)
    (hReal :
      ∀ x : Input,
        Nonempty
          (Realization PrimeData OrbicurveData ThetaData Source x)) :
    ∀ x : Input, Target x := by
  intro x
  rcases hReal x with ⟨R⟩
  exact hSound x R.prime R.orbicurve R.theta R.source

/-- Pointwise nonemptiness gives a noncanonical global choice family.  This
uses only classical choice; it does not prove any cross-input coherence. -/
noncomputable def chooseFamily
    (hReal :
      ∀ x : Input,
        Nonempty
          (Realization PrimeData OrbicurveData ThetaData Source x)) :
    ∀ x : Input,
      Realization PrimeData OrbicurveData ThetaData Source x :=
  fun x => Classical.choice (hReal x)

/-- Pointwise nonemptiness is equivalent to nonemptiness of a choice family.
The forward implication is deliberately only existential/noncanonical. -/
theorem pointwise_nonempty_iff_family_nonempty :
    (∀ x : Input,
      Nonempty
        (Realization PrimeData OrbicurveData ThetaData Source x)) ↔
      Nonempty
        (∀ x : Input,
          Realization PrimeData OrbicurveData ThetaData Source x) := by
  constructor
  · intro h
    exact ⟨chooseFamily PrimeData OrbicurveData ThetaData Source h⟩
  · rintro ⟨F⟩ x
    exact ⟨F x⟩

end PointwiseRealization

/-- Primes satisfying `P` occur above every bound and outside every finite
forbidden set.  This is stronger and more composable than bare infinitude. -/
structure PrimeSupply (P : ℕ → Prop) : Prop where
  select :
    ∀ (B : ℕ) (forbidden : Finset ℕ),
      ∃ ℓ : ℕ,
        Nat.Prime ℓ ∧
        B < ℓ ∧
        ℓ ∉ forbidden ∧
        P ℓ

/-- A prime condition that holds outside one finite exceptional set.  This is
a data structure rather than a proposition because the exceptional finset is
used by later constructions. -/
structure CofinitePrimeCondition (Q : ℕ → Prop) where
  exceptional : Finset ℕ
  holds :
    ∀ {ℓ : ℕ},
      Nat.Prime ℓ →
      ℓ ∉ exceptional →
      Q ℓ

namespace CofinitePrimeCondition

/-- Any cofinite prime condition itself has prime supply. -/
theorem toPrimeSupply
    {Q : ℕ → Prop}
    (C : CofinitePrimeCondition Q) :
    PrimeSupply Q := by
  constructor
  intro B forbidden
  obtain ⟨ℓ, hPrime, hLarge, hAvoid⟩ :=
    exists_prime_above_not_mem B (forbidden ∪ C.exceptional)
  have hForbidden : ℓ ∉ forbidden := by
    intro h
    apply hAvoid
    simp [h]
  have hExceptional : ℓ ∉ C.exceptional := by
    intro h
    apply hAvoid
    simp [h]
  exact ⟨ℓ, hPrime, hLarge, hForbidden,
    C.holds hPrime hExceptional⟩

/-- The conjunction of two cofinite prime conditions is cofinite. -/
def and
    {P Q : ℕ → Prop}
    (A : CofinitePrimeCondition P)
    (B : CofinitePrimeCondition Q) :
    CofinitePrimeCondition (fun ℓ => P ℓ ∧ Q ℓ) where
  exceptional := A.exceptional ∪ B.exceptional
  holds := by
    intro ℓ hPrime hAvoid
    have hA : ℓ ∉ A.exceptional := by
      intro h
      apply hAvoid
      simp [h]
    have hB : ℓ ∉ B.exceptional := by
      intro h
      apply hAvoid
      simp [h]
    exact ⟨A.holds hPrime hA, B.holds hPrime hB⟩

end CofinitePrimeCondition

namespace PrimeSupply

/-- Add a condition that fails at only finitely many primes to an existing
unbounded prime supply. -/
theorem andCofinite
    {P Q : ℕ → Prop}
    (S : PrimeSupply P)
    (C : CofinitePrimeCondition Q) :
    PrimeSupply (fun ℓ => P ℓ ∧ Q ℓ) := by
  constructor
  intro B forbidden
  obtain ⟨ℓ, hPrime, hLarge, hAvoid, hP⟩ :=
    S.select B (forbidden ∪ C.exceptional)
  have hForbidden : ℓ ∉ forbidden := by
    intro h
    apply hAvoid
    simp [h]
  have hExceptional : ℓ ∉ C.exceptional := by
    intro h
    apply hAvoid
    simp [h]
  exact ⟨ℓ, hPrime, hLarge, hForbidden,
    hP, C.holds hPrime hExceptional⟩

/-- Forget the finite-avoidance clause and obtain an arbitrarily large
satisfying prime. -/
theorem exists_above
    {P : ℕ → Prop}
    (S : PrimeSupply P)
    (B : ℕ) :
    ∃ ℓ : ℕ, Nat.Prime ℓ ∧ B < ℓ ∧ P ℓ := by
  obtain ⟨ℓ, hPrime, hLarge, _hAvoid, hP⟩ :=
    S.select B ∅
  exact ⟨ℓ, hPrime, hLarge, hP⟩

/-- A canonical-by-choice next satisfying prime above a bound. -/
noncomputable def next
    {P : ℕ → Prop}
    (S : PrimeSupply P)
    (B : ℕ) : ℕ :=
  Exists.choose (S.exists_above B)

/-- Specification of the chosen next prime. -/
theorem next_spec
    {P : ℕ → Prop}
    (S : PrimeSupply P)
    (B : ℕ) :
    Nat.Prime (S.next B) ∧
      B < S.next B ∧
      P (S.next B) :=
  Exists.choose_spec (S.exists_above B)

/-- Recursively choose a strictly increasing sequence from a prime supply. -/
noncomputable def sequence
    {P : ℕ → Prop}
    (S : PrimeSupply P) : ℕ → ℕ
  | 0 => S.next 0
  | n + 1 => S.next (S.sequence n)

/-- Every selected sequence term is prime and satisfies the supplied
condition. -/
theorem sequence_spec
    {P : ℕ → Prop}
    (S : PrimeSupply P)
    (n : ℕ) :
    Nat.Prime (S.sequence n) ∧ P (S.sequence n) := by
  cases n with
  | zero =>
      exact ⟨(S.next_spec 0).1, (S.next_spec 0).2.2⟩
  | succ n =>
      exact ⟨
        (S.next_spec (S.sequence n)).1,
        (S.next_spec (S.sequence n)).2.2⟩

/-- Consecutive selected primes are strictly increasing. -/
theorem sequence_lt_succ
    {P : ℕ → Prop}
    (S : PrimeSupply P)
    (n : ℕ) :
    S.sequence n < S.sequence (n + 1) :=
  (S.next_spec (S.sequence n)).2.1

/-- The recursively selected prime sequence is strictly monotone. -/
theorem sequence_strictMono
    {P : ℕ → Prop}
    (S : PrimeSupply P) :
    StrictMono S.sequence :=
  strictMono_nat_of_lt_succ S.sequence_lt_succ

end PrimeSupply

end IUTThreeClosures
