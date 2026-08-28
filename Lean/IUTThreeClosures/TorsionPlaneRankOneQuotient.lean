/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The standard rank-one quotient of the `ell`-torsion plane

Over the full `ell`-torsion field, the geometric deck module of an elliptic
curve is modeled by the two-dimensional `ZMod ell`-module

`V_ell = ZMod ell × ZMod ell`.

Choosing one cyclic torsion direction gives the exact sequence

`0 -> ZMod ell -> V_ell -> ZMod ell -> 0`,

where the inclusion is the first coordinate and the quotient is the second
coordinate.  This is the elementary algebraic model of the rank-one quotient
that appears in the orbicurve package.

The module proves the exactness, surjectivity, compatibility with the global
sign involution, and nontriviality of the canonical quotient generator for
prime `ell`.  It does not identify an actual etale/tempered fundamental-group
quotient with this model; that identification remains the anabelian source
theorem.
-/

namespace IUTThreeClosures

/-- The standard two-dimensional torsion plane. -/
abbrev TorsionPlane (ell : ℕ) := ZMod ell × ZMod ell

namespace TorsionPlane

variable (ell : ℕ)

/-- Inclusion of the chosen first cyclic torsion direction. -/
def lineIncl : ZMod ell →+ TorsionPlane ell where
  toFun x := (x, 0)
  map_zero' := rfl
  map_add' x y := by ext <;> simp

/-- Projection to the complementary rank-one quotient. -/
def rankOneQuotient : TorsionPlane ell →+ ZMod ell where
  toFun x := x.2
  map_zero' := rfl
  map_add' x y := rfl

/-- The rank-one quotient is surjective. -/
theorem rankOneQuotient_surjective :
    Function.Surjective (rankOneQuotient ell) := by
  intro y
  exact ⟨(0, y), rfl⟩

/-- The chosen line is killed by the quotient. -/
theorem rankOneQuotient_lineIncl (x : ZMod ell) :
    rankOneQuotient ell (lineIncl ell x) = 0 :=
  rfl

/-- The kernel of the rank-one quotient is exactly the chosen cyclic line. -/
theorem ker_rankOneQuotient_eq_range_lineIncl :
    (rankOneQuotient ell).ker = (lineIncl ell).range := by
  ext x
  constructor
  · intro hx
    have hx2 : x.2 = 0 := hx
    refine ⟨x.1, ?_⟩
    ext
    · rfl
    · simpa [hx2]
  · rintro ⟨y, rfl⟩
    rfl

/-- Exactness of the standard line/quotient sequence. -/
theorem exact_lineIncl_rankOneQuotient :
    Function.Exact (lineIncl ell) (rankOneQuotient ell) := by
  rw [LinearMap.exact_iff]
  exact ker_rankOneQuotient_eq_range_lineIncl ell

/-- The quotient map commutes with the global sign involution. -/
theorem rankOneQuotient_neg (x : TorsionPlane ell) :
    rankOneQuotient ell (-x) =
      -rankOneQuotient ell x := by
  rfl

/-- The selected line is also stable under the sign involution. -/
theorem lineIncl_neg (x : ZMod ell) :
    lineIncl ell (-x) =
      -lineIncl ell x := by
  rfl

/-- A canonical lift of a quotient coordinate. -/
def quotientSection : ZMod ell →+ TorsionPlane ell where
  toFun y := (0, y)
  map_zero' := rfl
  map_add' x y := by ext <;> simp

/-- The canonical lift is a right inverse to the quotient. -/
@[simp]
theorem rankOneQuotient_quotientSection (y : ZMod ell) :
    rankOneQuotient ell (quotientSection ell y) = y :=
  rfl

/-- Every torsion-plane point decomposes uniquely into its line component and
its quotient lift. -/
theorem line_quotient_decomposition (x : TorsionPlane ell) :
    x = lineIncl ell x.1 +
      quotientSection ell (rankOneQuotient ell x) := by
  ext <;> simp [lineIncl, quotientSection, rankOneQuotient]

/-- The canonical quotient generator. -/
def quotientGenerator : ZMod ell := 1

/-- The canonical generator is nonzero for prime `ell`. -/
theorem quotientGenerator_ne_zero
    (hell : ell.Prime) :
    quotientGenerator ell ≠ 0 := by
  letI : NeZero ell := ⟨hell.ne_zero⟩
  exact one_ne_zero

/-- The canonical lift of the quotient generator maps to `1`. -/
@[simp]
theorem quotientGenerator_lift_spec :
    rankOneQuotient ell
      (quotientSection ell (quotientGenerator ell)) = 1 :=
  rfl

/-- The two sign choices `±1` give the canonical unoriented generator orbit. -/
def signedGeneratorSet : Set (ZMod ell) :=
  {quotientGenerator ell, -quotientGenerator ell}

/-- The positive generator belongs to the signed orbit. -/
theorem quotientGenerator_mem_signedGeneratorSet :
    quotientGenerator ell ∈ signedGeneratorSet ell := by
  simp [signedGeneratorSet]

/-- The negative generator belongs to the signed orbit. -/
theorem neg_quotientGenerator_mem_signedGeneratorSet :
    -quotientGenerator ell ∈ signedGeneratorSet ell := by
  simp [signedGeneratorSet]

end TorsionPlane

end IUTThreeClosures
