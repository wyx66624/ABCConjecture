/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The signed cyclic deck group

The oriented `ell`-cycle has translation deck group `ZMod ell`.  Passing to the
orbifold/sign quotient adjoins a reflection acting by inversion.  We construct
the resulting finite dihedral-type group explicitly as pairs

`(a,e)`, `a : ZMod ell`, `e : ZMod 2`,

with multiplication

`(a,e)(b,f) = (a + (-1)^e b, e+f)`.

The translation subgroup is canonically `ZMod ell`; conjugation by the
reflection sends a translation by `a` to translation by `-a`.  Thus the
canonical one-step generator has the signed orbit `±1`, exactly the finite
graph/orbifold ambiguity expected in type `(1,ell-tors)^±`.

This is a concrete deck-group model.  It does not identify the actual etale or
tempered fundamental group with this model.
-/

namespace IUTThreeClosures

/-- The sign action of `ZMod 2` on an additive group: zero acts trivially and
the nonzero sign acts by negation. -/
def cycleSignAction
    {A : Type*} [AddCommGroup A]
    (e : ZMod 2) (a : A) : A :=
  if e = 0 then a else -a

namespace cycleSignAction

variable {A : Type*} [AddCommGroup A]

@[simp]
theorem zero (a : A) :
    cycleSignAction (0 : ZMod 2) a = a := by
  simp [cycleSignAction]

@[simp]
theorem one (a : A) :
    cycleSignAction (1 : ZMod 2) a = -a := by
  norm_num [cycleSignAction]

@[simp]
theorem map_zero (e : ZMod 2) :
    cycleSignAction e (0 : A) = 0 := by
  by_cases he : e = 0 <;> simp [cycleSignAction, he]

@[simp]
theorem map_add (e : ZMod 2) (a b : A) :
    cycleSignAction e (a + b) =
      cycleSignAction e a + cycleSignAction e b := by
  by_cases he : e = 0 <;> simp [cycleSignAction, he]

@[simp]
theorem map_neg (e : ZMod 2) (a : A) :
    cycleSignAction e (-a) = -cycleSignAction e a := by
  by_cases he : e = 0 <;> simp [cycleSignAction, he]

/-- Addition of signs corresponds to composition of sign actions. -/
theorem add (e f : ZMod 2) (a : A) :
    cycleSignAction (e + f) a =
      cycleSignAction e (cycleSignAction f a) := by
  fin_cases e <;> fin_cases f <;> norm_num [cycleSignAction]

/-- Every sign is its own inverse. -/
theorem neg_eq_self (e : ZMod 2) : -e = e := by
  fin_cases e <;> norm_num

end cycleSignAction

/-- The signed deck group of an oriented `ell`-cycle. -/
@[ext]
structure SignedCycleDeck (ell : ℕ) where
  shift : ZMod ell
  sign : ZMod 2

namespace SignedCycleDeck

variable {ell : ℕ}

/-- Semidirect-product multiplication. -/
def mul (g h : SignedCycleDeck ell) : SignedCycleDeck ell where
  shift := g.shift + cycleSignAction g.sign h.shift
  sign := g.sign + h.sign

/-- Identity signed deck transformation. -/
def one : SignedCycleDeck ell where
  shift := 0
  sign := 0

/-- Explicit inverse in the signed semidirect product. -/
def inv (g : SignedCycleDeck ell) : SignedCycleDeck ell where
  shift := cycleSignAction (-g.sign) (-g.shift)
  sign := -g.sign

instance : Group (SignedCycleDeck ell) where
  one := one
  mul := mul
  inv := inv
  one_mul g := by
    apply SignedCycleDeck.ext <;>
      simp [one, mul]
  mul_one g := by
    apply SignedCycleDeck.ext
    · simp [one, mul]
    · simp [one, mul]
  mul_assoc g h k := by
    apply SignedCycleDeck.ext
    · dsimp [mul]
      rw [cycleSignAction.add, cycleSignAction.map_add]
      abel
    · dsimp [mul]
      abel
  inv_mul_cancel g := by
    apply SignedCycleDeck.ext
    · dsimp [inv, mul]
      rw [cycleSignAction.map_neg]
      rw [← cycleSignAction.add]
      simp
    · dsimp [inv, mul]
      simp

/-- The affine action on the cyclic skeleton. -/
def act (g : SignedCycleDeck ell) (x : ZMod ell) : ZMod ell :=
  g.shift + cycleSignAction g.sign x

@[simp]
theorem one_act (x : ZMod ell) :
    act (1 : SignedCycleDeck ell) x = x := by
  simp [act, one]

@[simp]
theorem mul_act (g h : SignedCycleDeck ell) (x : ZMod ell) :
    act (g * h) x = act g (act h x) := by
  dsimp [act, mul]
  rw [cycleSignAction.map_add, ← cycleSignAction.add]
  abel

/-- Pure translation by `a`. -/
def translation (a : ZMod ell) : SignedCycleDeck ell where
  shift := a
  sign := 0

/-- The standard reflection `x ↦ -x`. -/
def reflection : SignedCycleDeck ell where
  shift := 0
  sign := 1

@[simp]
theorem translation_shift (a : ZMod ell) :
    (translation a).shift = a := rfl

@[simp]
theorem translation_sign (a : ZMod ell) :
    (translation a).sign = 0 := rfl

@[simp]
theorem translation_mul (a b : ZMod ell) :
    translation a * translation b = translation (a + b) := by
  apply SignedCycleDeck.ext <;> simp [translation, mul]

@[simp]
theorem translation_zero :
    translation (0 : ZMod ell) = 1 := by
  apply SignedCycleDeck.ext <;> rfl

/-- Translation is injective. -/
theorem translation_injective :
    Function.Injective (translation : ZMod ell → SignedCycleDeck ell) := by
  intro a b h
  exact congrArg SignedCycleDeck.shift h

@[simp]
theorem reflection_act (x : ZMod ell) :
    act (reflection : SignedCycleDeck ell) x = -x := by
  norm_num [act, reflection, cycleSignAction]

@[simp]
theorem reflection_sq :
    (reflection : SignedCycleDeck ell) * reflection = 1 := by
  apply SignedCycleDeck.ext <;>
    norm_num [reflection, one, mul, cycleSignAction]

@[simp]
theorem reflection_inv :
    (reflection : SignedCycleDeck ell)⁻¹ = reflection := by
  apply SignedCycleDeck.ext <;>
    norm_num [reflection, inv, cycleSignAction]

/-- Reflection conjugates a translation to its inverse. -/
theorem reflection_conj_translation (a : ZMod ell) :
    (reflection : SignedCycleDeck ell) *
        translation a * reflection⁻¹ =
      translation (-a) := by
  apply SignedCycleDeck.ext <;>
    norm_num [reflection, translation, mul, inv, cycleSignAction]

/-- Projection to the sign quotient. -/
def signHom : SignedCycleDeck ell →* ZMod 2 where
  toFun := SignedCycleDeck.sign
  map_one' := rfl
  map_mul' _ _ := rfl

/-- The kernel of the sign projection consists exactly of translations. -/
theorem mem_ker_signHom_iff (g : SignedCycleDeck ell) :
    g ∈ signHom.ker ↔ ∃ a : ZMod ell, g = translation a := by
  constructor
  · intro hg
    have hsign : g.sign = 0 := hg
    exact ⟨g.shift, by
      apply SignedCycleDeck.ext
      · rfl
      · simpa [translation] using hsign⟩
  · rintro ⟨a, rfl⟩
    rfl

/-- The one-step translation is nontrivial for prime `ell`. -/
theorem translation_one_ne_one
    (ell : ℕ) [Fact ell.Prime] :
    translation (1 : ZMod ell) ≠ 1 := by
  intro h
  have hshift := congrArg SignedCycleDeck.shift h
  simpa [translation, one] using
    (one_ne_zero : (1 : ZMod ell) ≠ 0) hshift

/-- The signed conjugacy orbit of the canonical generator is `±1`. -/
theorem reflection_sends_generator_to_negative
    (ell : ℕ) :
    (reflection : SignedCycleDeck ell) *
        translation (1 : ZMod ell) * reflection⁻¹ =
      translation (-1 : ZMod ell) :=
  reflection_conj_translation 1

end SignedCycleDeck

end IUTThreeClosures
