/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The cyclic Kummer root torsor

The local theta-root model required by initial theta-data is geometrically much
richer than a single scalar equation, but its basic algebraic mechanism is the
Kummer torsor obtained by extracting an `ell`-th root.

For a field `K`, a nonzero scalar `x : Kˣ`, and a positive integer `ell`, let

`Root_ell(x) = { y : Kˣ | y^ell = x }`

and

`Mu_ell(K) = { zeta : Kˣ | zeta^ell = 1 }`.

Multiplication defines an action of `Mu_ell(K)` on `Root_ell(x)`.  This module
proves directly that the action is free and transitive whenever the fiber is
inhabited.  Thus an inhabited root fiber is a genuine principal homogeneous
space for the `ell`-th roots of unity.

This is the concrete algebraic core of an `ell`-th-root theta cover.  It does
not yet construct the theta function on a Tate curve, the associated analytic
or orbicurve cover, its tempered fundamental group, or the canonical graph
cusp.  Those are separate geometric/topological realization theorems.
-/

namespace IUTThreeClosures

universe u

namespace KummerRootTorsor

variable (K : Type u) [Field K]

/-- The subgroup of `ell`-th roots of unity in `Kˣ`. -/
def rootGroup (ell : ℕ) : Subgroup Kˣ where
  carrier := {zeta | zeta ^ ell = 1}
  one_mem' := by simp
  mul_mem' := by
    intro a b ha hb
    simp only [Set.mem_setOf_eq] at ha hb ⊢
    rw [mul_pow, ha, hb, one_mul]
  inv_mem' := by
    intro a ha
    simp only [Set.mem_setOf_eq] at ha ⊢
    rw [inv_pow, ha, inv_one]

/-- The fiber of the `ell`-th power map over a nonzero scalar `x`. -/
def rootFiber (ell : ℕ) (x : Kˣ) : Type u :=
  {y : Kˣ // y ^ ell = x}

variable {K}
variable {ell : ℕ} {x : Kˣ}

/-- Multiplication by a root of unity preserves the Kummer root fiber. -/
def act
    (zeta : rootGroup K ell)
    (y : rootFiber K ell x) :
    rootFiber K ell x where
  val := (zeta : Kˣ) * (y : Kˣ)
  property := by
    rw [mul_pow, zeta.property, y.property, one_mul]

@[simp]
theorem coe_act
    (zeta : rootGroup K ell)
    (y : rootFiber K ell x) :
    ((act zeta y : rootFiber K ell x) : Kˣ) =
      (zeta : Kˣ) * (y : Kˣ) :=
  rfl

/-- The identity root acts trivially. -/
@[simp]
theorem one_act (y : rootFiber K ell x) :
    act (1 : rootGroup K ell) y = y := by
  apply Subtype.ext
  simp [act]

/-- Multiplication of roots of unity agrees with composition of the actions. -/
@[simp]
theorem mul_act
    (a b : rootGroup K ell)
    (y : rootFiber K ell x) :
    act (a * b) y = act a (act b y) := by
  apply Subtype.ext
  simp [act, mul_assoc]

/-- The Kummer action is free. -/
theorem act_eq_self_iff
    (zeta : rootGroup K ell)
    (y : rootFiber K ell x) :
    act zeta y = y ↔ zeta = 1 := by
  constructor
  · intro h
    have hcoe := congrArg
      (fun z : rootFiber K ell x => (z : Kˣ)) h
    change (zeta : Kˣ) * (y : Kˣ) = (y : Kˣ) at hcoe
    have hzeta : (zeta : Kˣ) = 1 := by
      apply mul_right_cancel (b := (y : Kˣ))
      simpa using hcoe
    exact Subtype.ext hzeta
  · rintro rfl
    exact one_act y

/-- The unique root of unity carrying one root to another. -/
def transporter
    (y z : rootFiber K ell x) :
    rootGroup K ell where
  val := (z : Kˣ) * (y : Kˣ)⁻¹
  property := by
    rw [mul_pow, inv_pow, z.property, y.property, mul_inv_cancel]

/-- The transporter carries its source root to its target root. -/
theorem transporter_act
    (y z : rootFiber K ell x) :
    act (transporter y z) y = z := by
  apply Subtype.ext
  simp [act, transporter, mul_assoc]

/-- The action is transitive. -/
theorem exists_act_eq
    (y z : rootFiber K ell x) :
    ∃ zeta : rootGroup K ell,
      act zeta y = z :=
  ⟨transporter y z, transporter_act y z⟩

/-- The transporter is unique. -/
theorem transporter_unique
    (y z : rootFiber K ell x)
    (zeta : rootGroup K ell)
    (h : act zeta y = z) :
    zeta = transporter y z := by
  have htransport : act (transporter y z) y = z :=
    transporter_act y z
  have heq : act zeta y = act (transporter y z) y :=
    h.trans htransport.symm
  have hcoe := congrArg
    (fun t : rootFiber K ell x => (t : Kˣ)) heq
  change (zeta : Kˣ) * (y : Kˣ) =
    (transporter y z : Kˣ) * (y : Kˣ) at hcoe
  exact Subtype.ext (mul_right_cancel hcoe)

/-- An inhabited Kummer root fiber is a principal homogeneous space: between
any two points there is a unique acting root of unity. -/
theorem existsUnique_act_eq
    (y z : rootFiber K ell x) :
    ∃! zeta : rootGroup K ell,
      act zeta y = z := by
  refine ⟨transporter y z, transporter_act y z, ?_⟩
  intro zeta h
  exact transporter_unique y z zeta h

/-- Coordinate the whole root fiber by the root-of-unity group after choosing
one base root. -/
noncomputable def equivRootGroup
    (y₀ : rootFiber K ell x) :
    rootGroup K ell ≃ rootFiber K ell x where
  toFun zeta := act zeta y₀
  invFun y := transporter y₀ y
  left_inv zeta := by
    apply transporter_unique y₀ (act zeta y₀)
    rfl
  right_inv y := transporter_act y₀ y

end KummerRootTorsor

end IUTThreeClosures
