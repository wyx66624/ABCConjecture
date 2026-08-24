/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActionGroupoidPullbackMorphisms

/-!
# The two-element sign group

The stacky quotient used in the punctured elliptic-curve square is the action
groupoid of the involution `x ↦ -x`.  This file supplies a concrete two-element
group and its canonical action on every additive group, so that the generic
action-groupoid pullback theorem can be applied without encoding the sign as
an unstructured Boolean witness.
-/

namespace IUTThreeClosures

/-- The multiplicative group with elements `+1` and `-1`. -/
inductive Sign where
  | positive
  | negative
  deriving DecidableEq, Fintype

namespace Sign

instance : One Sign := ⟨positive⟩

instance : Mul Sign where
  mul
    | positive, s => s
    | negative, positive => negative
    | negative, negative => positive

instance : Inv Sign := ⟨fun s => s⟩

@[simp]
theorem positive_mul (s : Sign) : positive * s = s := rfl

@[simp]
theorem mul_positive (s : Sign) : s * positive = s := by
  cases s <;> rfl

@[simp]
theorem negative_mul_negative :
    negative * negative = positive := rfl

@[simp]
theorem inv_eq (s : Sign) : s⁻¹ = s := rfl

instance : Group Sign where
  mul_assoc := by
    intro a b c
    cases a <;> cases b <;> cases c <;> rfl
  one_mul := positive_mul
  mul_one := mul_positive
  inv_mul_cancel := by
    intro a
    cases a <;> rfl

/-- The sign action on an additive group. -/
def act {A : Type*} [AddGroup A] : Sign → A → A
  | positive, x => x
  | negative, x => -x

instance {A : Type*} [AddGroup A] : SMul Sign A where
  smul := act

@[simp]
theorem positive_smul
    {A : Type*} [AddGroup A] (x : A) :
    (positive : Sign) • x = x := rfl

@[simp]
theorem negative_smul
    {A : Type*} [AddGroup A] (x : A) :
    (negative : Sign) • x = -x := rfl

instance {A : Type*} [AddGroup A] : MulAction Sign A where
  one_smul := positive_smul
  mul_smul := by
    intro a b x
    cases a <;> cases b <;> simp

/-- An additive homomorphism is automatically equivariant for the sign
involution. -/
theorem additive_equivariant
    {A B : Type*} [AddGroup A] [AddGroup B]
    (f : A →+ B)
    (s : Sign) (x : A) :
    f (s • x) = s • f x := by
  cases s <;> simp

/-- Multiplication by a natural number is sign-equivariant. -/
theorem nsmul_equivariant
    {A : Type*} [AddGroup A]
    (n : ℕ) (s : Sign) (x : A) :
    n • (s • x) = s • (n • x) := by
  cases s <;> simp

end Sign

end IUTThreeClosures
