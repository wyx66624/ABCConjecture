/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaKummerFiber

/-!
# Root-of-unity torsors on geometric Tate theta Kummer fibers

Away from the theta zero orbit, the geometric solutions of

`y ^ ell = thetaProd(u)`

form a principal homogeneous space under the `ell`-th roots of unity.  This
is the precise Kummer-theoretic symmetry underlying the cyclic local
`theta`-root cover.

The proof is elementary but source-relevant:

* multiplication by an `ell`-th root of unity preserves every geometric
  fiber;
* every geometric root is nonzero away from the theta divisor;
* the action is free;
* the ratio of any two roots is an `ell`-th root of unity, hence the action is
  transitive;
* consequently there is a unique root-of-unity element carrying one root to
  another.

This gives the exact pointwise torsor theorem.  It does not yet identify the
root-of-unity group with `ZMod ell`, construct the analytic family or quotient,
or prove the tempered/orbicurve type and graph-cusp statements.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u v

variable {K : Type u} [NormedField K]
variable {L : Type v} [Field L] [Algebra K L]

/-- The `ell`-th power homomorphism on the multiplicative group of a field. -/
def ellPowerHom (L : Type v) [Field L] (ell : ℕ) : Lˣ →* Lˣ where
  toFun z := z ^ ell
  map_one' := one_pow ell
  map_mul' a b := by
    rw [mul_pow]

/-- The subgroup of `ell`-th roots of unity in `L`. -/
abbrev EllRootUnity (L : Type v) [Field L] (ell : ℕ) : Type v :=
  (ellPowerHom L ell).ker

/-- A geometric point of one theta Kummer fiber. -/
structure ThetaKummerGeometricPoint
    (t : TateParameter K) (u : Kˣ) (ell : ℕ)
    (L : Type v) [Field L] [Algebra K L] where
  root : L
  root_pow : root ^ ell = algebraMap K L (t.thetaProd u)

namespace ThetaKummerGeometricPoint

@[ext]
theorem ext
    {t : TateParameter K} {u : Kˣ} {ell : ℕ}
    {x y : ThetaKummerGeometricPoint t u ell L}
    (hroot : x.root = y.root) :
    x = y := by
  cases x
  cases y
  simp_all

/-- Multiplication by a root of unity preserves a geometric theta Kummer
fiber. -/
def rootUnitySmul
    {t : TateParameter K} {u : Kˣ} {ell : ℕ}
    (ζ : EllRootUnity L ell)
    (x : ThetaKummerGeometricPoint t u ell L) :
    ThetaKummerGeometricPoint t u ell L where
  root := (ζ.1 : L) * x.root
  root_pow := by
    have hζUnits : ζ.1 ^ ell = (1 : Lˣ) := ζ.2
    have hζ : ((ζ.1 : L) ^ ell) = 1 := by
      simpa using congrArg (fun z : Lˣ => (z : L)) hζUnits
    rw [mul_pow, hζ, one_mul, x.root_pow]

instance
    {t : TateParameter K} {u : Kˣ} {ell : ℕ} :
    SMul (EllRootUnity L ell)
      (ThetaKummerGeometricPoint t u ell L) where
  smul := rootUnitySmul

instance
    {t : TateParameter K} {u : Kˣ} {ell : ℕ} :
    MulAction (EllRootUnity L ell)
      (ThetaKummerGeometricPoint t u ell L) where
  one_smul x := by
    apply ext
    simp [rootUnitySmul]
  mul_smul a b x := by
    apply ext
    simp [rootUnitySmul, mul_assoc]

/-- Away from the theta zero orbit, every geometric Kummer root is nonzero. -/
theorem root_ne_zero
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k)
    (x : ThetaKummerGeometricPoint t u ell L) :
    x.root ≠ 0 := by
  have htheta : t.thetaProd u ≠ 0 :=
    thetaProd_ne_zero_of_not_zeroOrbit t u hu
  have hthetaL : algebraMap K L (t.thetaProd u) ≠ 0 := by
    intro hmap
    apply htheta
    apply (algebraMap K L).injective
    simpa using hmap
  intro hx
  have hp := x.root_pow
  rw [hx, zero_pow hell.ne'] at hp
  exact hthetaL hp.symm

/-- The root-of-unity action is free on every nonzero geometric root. -/
theorem smul_eq_self_iff
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k)
    (ζ : EllRootUnity L ell)
    (x : ThetaKummerGeometricPoint t u ell L) :
    ζ • x = x ↔ ζ = 1 := by
  constructor
  · intro h
    have hx0 := root_ne_zero t u hell hu x
    have hroot := congrArg
      (fun z : ThetaKummerGeometricPoint t u ell L => z.root) h
    change (ζ.1 : L) * x.root = x.root at hroot
    have hζ : (ζ.1 : L) = 1 := by
      apply mul_right_cancel₀ hx0
      simpa using hroot
    apply Subtype.ext
    apply Units.ext
    simpa using hζ
  · rintro rfl
    exact one_smul _ _

/-- Between any two nonzero geometric roots, their ratio is an `ell`-th root
of unity carrying the second root to the first. -/
theorem exists_rootUnity_smul
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k)
    (x y : ThetaKummerGeometricPoint t u ell L) :
    ∃ ζ : EllRootUnity L ell, ζ • y = x := by
  have hx0 := root_ne_zero t u hell hu x
  have hy0 := root_ne_zero t u hell hu y
  have htheta : t.thetaProd u ≠ 0 :=
    thetaProd_ne_zero_of_not_zeroOrbit t u hu
  have hthetaL : algebraMap K L (t.thetaProd u) ≠ 0 := by
    intro hmap
    apply htheta
    apply (algebraMap K L).injective
    simpa using hmap
  let ζu : Lˣ := Units.mk0 (x.root / y.root)
    (div_ne_zero hx0 hy0)
  have hζpowField : ((ζu : L) ^ ell) = 1 := by
    dsimp [ζu]
    rw [div_pow, x.root_pow, y.root_pow, div_self hthetaL]
  have hζpowUnits : ζu ^ ell = (1 : Lˣ) := by
    apply Units.ext
    simpa using hζpowField
  have hζmem : ζu ∈ (ellPowerHom L ell).ker := by
    change ζu ^ ell = 1
    exact hζpowUnits
  let ζ : EllRootUnity L ell := ⟨ζu, hζmem⟩
  refine ⟨ζ, ?_⟩
  apply ext
  change (x.root / y.root) * y.root = x.root
  exact div_mul_cancel₀ x.root hy0

/-- The root-of-unity element carrying one geometric root to another is
unique.  Thus every nonempty geometric fiber is a genuine torsor. -/
theorem existsUnique_rootUnity_smul
    [CompleteSpace K]
    (t : TateParameter K) (u : Kˣ) {ell : ℕ}
    (hell : 0 < ell)
    (hu : ¬ ∃ k : ℤ, (u : K) = -(t.q : K) ^ k)
    (x y : ThetaKummerGeometricPoint t u ell L) :
    ∃! ζ : EllRootUnity L ell, ζ • y = x := by
  obtain ⟨ζ, hζ⟩ := exists_rootUnity_smul t u hell hu x y
  refine ⟨ζ, hζ, ?_⟩
  intro η hη
  have hy0 := root_ne_zero t u hell hu y
  have hηroot := congrArg
    (fun z : ThetaKummerGeometricPoint t u ell L => z.root) hη
  have hζroot := congrArg
    (fun z : ThetaKummerGeometricPoint t u ell L => z.root) hζ
  change (η.1 : L) * y.root = x.root at hηroot
  change (ζ.1 : L) * y.root = x.root at hζroot
  have hunit : (η.1 : L) = (ζ.1 : L) := by
    apply mul_right_cancel₀ hy0
    exact hηroot.trans hζroot.symm
  apply Subtype.ext
  apply Units.ext
  exact hunit

end ThetaKummerGeometricPoint

end IUTThreeClosures
