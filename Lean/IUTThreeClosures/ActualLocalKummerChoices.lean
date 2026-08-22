/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateParameterPowerRegions
import Iut.Cor312.PacketPresentation

/-!
# Factorwise local Kummer choices on an actual packet decomposition

Once a tensor packet has been decomposed into its primitive local-field
factors, no further arbitrary carrier equivalence is needed: the public packet
total is already the dependent product of its factor fields.

This module constructs the ordinary Kummer output and a source-explicit family
of factorwise Ind1/Ind3 choices directly on those fields.  A norm-one unit is
the Ind1 ambiguity and a nonnegative integer is the resulting q-exponent on
one primitive factor.  The exact norm and principal-region formulas are
proved, not stored.

Ind2 acts before the semisimple factor decomposition, by permuting the capsule
labels.  Its only input to the factorwise component calculation is the
resulting exponent function, so it is intentionally absent from this local
normal form.  A genuine IUT coverage theorem must prove that every ordinary
possible image has this factorwise normal form, while full Ind3 images may use
the already formalized hull-envelope inclusion route.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise

universe u v

/-! ## Canonical Kummer translations -/

namespace KummerTorsor

variable {K : Type v} [NormedField K]

/-- Left translation on the multiplicative Kummer torsor. -/
def leftMulEquiv (a : Kˣ) : Kˣ ≃ Kˣ where
  toFun x := a * x
  invFun x := a⁻¹ * x
  left_inv x := by simp [mul_assoc]
  right_inv x := by simp [mul_assoc]

@[simp]
theorem leftMulEquiv_apply (a x : Kˣ) :
    leftMulEquiv a x = a * x := rfl

/-- Distinguished theta-pilot Kummer point at label `j`. -/
noncomputable def thetaPoint (t : TateParameter K) (j : ℕ) : Kˣ :=
  Units.mk0 ((t.q : K) ^ (j ^ 2)) (pow_ne_zero _ t.q.ne_zero)

@[simp]
theorem thetaPoint_coe (t : TateParameter K) (j : ℕ) :
    ((thetaPoint t j : Kˣ) : K) = (t.q : K) ^ (j ^ 2) := rfl

/-- Canonical translation multiplier from label `j` to label `k`. -/
noncomputable def horizontalMultiplier
    (t : TateParameter K) (j k : ℕ) : Kˣ :=
  thetaPoint t k * (thetaPoint t j)⁻¹

/-- Canonical horizontal Kummer translation. -/
noncomputable def horizontalEquiv
    (t : TateParameter K) (j k : ℕ) : Kˣ ≃ Kˣ :=
  leftMulEquiv (horizontalMultiplier t j k)

@[simp]
theorem horizontalEquiv_apply
    (t : TateParameter K) (j k : ℕ) (x : Kˣ) :
    horizontalEquiv t j k x =
      (thetaPoint t k * (thetaPoint t j)⁻¹) * x := rfl

/-- The horizontal translation sends the source theta point to the target
point. -/
@[simp]
theorem horizontalEquiv_thetaPoint
    (t : TateParameter K) (j k : ℕ) :
    horizontalEquiv t j k (thetaPoint t j) = thetaPoint t k := by
  simp [horizontalEquiv_apply, mul_assoc]

/-- Pointwise identity law. -/
@[simp]
theorem horizontalEquiv_refl_apply
    (t : TateParameter K) (j : ℕ) (x : Kˣ) :
    horizontalEquiv t j j x = x := by
  simp [horizontalEquiv_apply, mul_assoc]

/-- Pointwise inverse law. -/
theorem horizontalEquiv_symm_apply
    (t : TateParameter K) (j k : ℕ) (x : Kˣ) :
    (horizontalEquiv t j k).symm x = horizontalEquiv t k j x := by
  simp [horizontalEquiv, horizontalMultiplier, leftMulEquiv,
    mul_assoc, mul_comm, mul_left_comm]

/-- Pointwise cocycle law. -/
theorem horizontalEquiv_trans_apply
    (t : TateParameter K) (i j k : ℕ) (x : Kˣ) :
    horizontalEquiv t j k (horizontalEquiv t i j x) =
      horizontalEquiv t i k x := by
  simp [horizontalEquiv_apply, mul_assoc, mul_comm, mul_left_comm]

end KummerTorsor

/-! ## Factorwise Kummer normal form -/

/-- A norm-one multiplicative ambiguity. -/
structure NormOneKummerUnit (K : Type v) [NormedField K] where
  unit : Kˣ
  norm_eq_one : ‖(unit : K)‖ = 1

namespace NormOneKummerUnit

variable {K : Type v} [NormedField K]

/-- Trivial ambiguity. -/
def one : NormOneKummerUnit K where
  unit := 1
  norm_eq_one := norm_one

end NormOneKummerUnit

/-- Factorwise normal form of an ordinary theta/Kummer output after the
semisimple packet decomposition. -/
structure FactorKummerChoice
    (C : Type u) (K : C → Type v)
    [∀ c, NormedField (K c)] : Type (max u (v + 1)) where
  /-- Actual Tate parameter on each primitive field factor. -/
  tate : ∀ c, TateParameter (K c)
  /-- Ind1 ambiguity on each factor. -/
  ind1 : ∀ c, NormOneKummerUnit (K c)
  /-- Source-derived nonnegative q-exponent on each factor. -/
  power : C → ℕ

namespace FactorKummerChoice

variable {C : Type u} {K : C → Type v}
variable [∀ c, NormedField (K c)]

/-- Ordinary squared-label choice on a factor family. -/
noncomputable def ordinary
    (t : ∀ c, TateParameter (K c))
    (label : C → ℕ) : FactorKummerChoice C K where
  tate := t
  ind1 := fun _ => NormOneKummerUnit.one
  power c := (label c) ^ 2

/-- Actual factor value. -/
noncomputable def outputValue
    (A : FactorKummerChoice C K) (c : C) : K c :=
  (A.ind1 c).unit * ((A.tate c).q : K c) ^ A.power c

/-- Every actual factor value is nonzero. -/
theorem outputValue_ne_zero
    (A : FactorKummerChoice C K) (c : C) :
    A.outputValue c ≠ 0 := by
  unfold outputValue
  exact mul_ne_zero (Units.ne_zero (A.ind1 c).unit)
    (pow_ne_zero _ (A.tate c).q.ne_zero)

/-- Exact local theta/Kummer norm formula. -/
theorem norm_outputValue
    (A : FactorKummerChoice C K) (c : C) :
    ‖A.outputValue c‖ = ‖((A.tate c).q : K c)‖ ^ A.power c := by
  unfold outputValue
  rw [norm_mul, (A.ind1 c).norm_eq_one, one_mul, norm_pow]

/-- Principal region generated by one actual factor value. -/
def outputRegion
    (A : FactorKummerChoice C K) (c : C) : Set (K c) :=
  scaledRegion (A.outputValue c) (normIntegralRegion (K := K c))

/-- The Ind1 unit does not change the principal region. -/
theorem outputRegion_eq_qPowerRegion
    (A : FactorKummerChoice C K) (c : C) :
    A.outputRegion c = (A.tate c).qPowerRegion (A.power c) := by
  unfold outputRegion TateParameter.qPowerRegion
  apply scaledRegion_eq_of_norm_eq
  · exact pow_ne_zero _ (A.tate c).q.ne_zero
  · exact A.norm_outputValue c

/-- Product region of the complete factorwise output. -/
def packetRegion (A : FactorKummerChoice C K) : Set (∀ c, K c) :=
  {x | ∀ c, x c ∈ A.outputRegion c}

@[simp]
theorem mem_packetRegion
    (A : FactorKummerChoice C K) (x : ∀ c, K c) :
    x ∈ A.packetRegion ↔ ∀ c, x c ∈ A.outputRegion c := Iff.rfl

/-- The factor packet is exactly the product of the actual q-power regions. -/
theorem packetRegion_eq_qPowerProduct
    (A : FactorKummerChoice C K) :
    A.packetRegion =
      {x | ∀ c, x c ∈ (A.tate c).qPowerRegion (A.power c)} := by
  ext x
  simp only [mem_packetRegion]
  constructor
  · intro h c
    rw [← A.outputRegion_eq_qPowerRegion c]
    exact h c
  · intro h c
    rw [A.outputRegion_eq_qPowerRegion c]
    exact h c

end FactorKummerChoice

/-! ## Direct realization on a corrected public factor presentation -/

section PublicPacket

variable {C : Type u}
variable (P : DirectSumPresentation.{u, v} C)
variable [∀ c, NormedField (P.Summand c)]

/-- Source data identifying the public integral structures with the norm unit
balls on the corrected primitive field factors.  There is no carrier
coordinate equivalence: `P.Total` is already the dependent product of these
factors. -/
structure PublicFactorTateData : Type (max u (v + 1)) where
  tate : ∀ c, TateParameter (P.Summand c)
  integral_eq_normIntegral : ∀ c,
    (P.integral c : Set (P.Summand c)) =
      normIntegralRegion (K := P.Summand c)

namespace PublicFactorTateData

/-- An ordinary or Ind1/Ind3 factor choice on the actual public summands. -/
noncomputable def choice
    (D : PublicFactorTateData P)
    (unit : ∀ c, NormOneKummerUnit (P.Summand c))
    (power : C → ℕ) :
    FactorKummerChoice C P.Summand where
  tate := D.tate
  ind1 := unit
  power := power

/-- Public realization of a factorwise Kummer choice. -/
def realize
    (D : PublicFactorTateData P)
    (A : FactorKummerChoice C P.Summand) : Set P.Total :=
  A.packetRegion

@[simp]
theorem mem_realize
    (D : PublicFactorTateData P)
    (A : FactorKummerChoice C P.Summand) (x : P.Total) :
    x ∈ D.realize A ↔ ∀ c, x c ∈ A.outputRegion c := Iff.rfl

/-- The public realization is the literal product of the factor q-power
regions; no arbitrary coordinate transport remains. -/
theorem realize_eq_qPowerProduct
    (D : PublicFactorTateData P)
    (A : FactorKummerChoice C P.Summand) :
    D.realize A =
      {x | ∀ c, x c ∈ (A.tate c).qPowerRegion (A.power c)} :=
  A.packetRegion_eq_qPowerProduct

end PublicFactorTateData

end PublicPacket

end IUTThreeClosures
