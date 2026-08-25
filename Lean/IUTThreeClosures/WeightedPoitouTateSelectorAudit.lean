/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NonCircularDownstream

/-!
# A weighted Poitou--Tate selector audit

This module records the finite arithmetic behind a strict rank-zero
obstruction to a universal non-torsion local-height selector.

For the Frey curve attached to `(a,b,c)=(1,8,9)`, full `2`-descent reduces
the possible squareclass triples to classes supported on `{-1,2,3}`.  The
paper companion explains the standard descent map.  Here we independently
check its finite local table: primitive solubility modulo `16` and modulo
`9` leaves exactly four squareclass triples.  We also record that the
three-adic excess of the actual abc point is positive.

Lean does **not** formalize the Mordell--Weil group, its rank, the Kummer
map, local Tate duality, Poitou--Tate, the Cassels--Tate pairing, Neron local
heights, or the standard theorem identifying the descent table with the
rational-point quotient.  In particular no abc, Szpiro, rank, or height
estimate is assumed as a structure field.
-/

namespace IUTThreeClosures

/-! ## The actual endpoint and its positive exponent excess -/

/-- The primitive abc point `(1,8,9)`. -/
def oneEightNineABCPoint : ABCPoint where
  a := 1
  b := 8
  c := 9
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by
    norm_num [PairwiseCoprimeABC]

@[simp] theorem oneEightNineABCPoint_a : oneEightNineABCPoint.a = 1 := rfl
@[simp] theorem oneEightNineABCPoint_b : oneEightNineABCPoint.b = 8 := rfl
@[simp] theorem oneEightNineABCPoint_c : oneEightNineABCPoint.c = 9 := rfl

/-- At `3`, the exponent of `abc=72` is two. -/
theorem oneEightNineABCPoint_abc_factorization_three :
    (oneEightNineABCPoint.a * oneEightNineABCPoint.b *
      oneEightNineABCPoint.c).factorization 3 = 2 := by
  change (Nat.factorization 72) 3 = 2
  have h9 : (Nat.factorization 9) 3 = 2 := by
    change (Nat.factorization (3 ^ 2)) 3 = 2
    exact Nat.factorization_pow_self Nat.prime_three
  rw [show 72 = 8 * 9 by norm_num,
    Nat.factorization_mul (by norm_num : 8 ≠ 0) (by norm_num : 9 ≠ 0)]
  simp only [Finsupp.add_apply]
  rw [
    Nat.factorization_eq_zero_of_not_dvd (by norm_num : ¬ 3 ∣ 8), h9]

/-- Hence the depth beyond reduced support, `e_3-1`, is already positive. -/
theorem oneEightNineABCPoint_three_exponentExcess :
    (oneEightNineABCPoint.a * oneEightNineABCPoint.b *
      oneEightNineABCPoint.c).factorization 3 - 1 = 1 := by
  rw [oneEightNineABCPoint_abc_factorization_three]

/-- Its corresponding real logarithmic excess is strictly positive. -/
theorem oneEightNineABCPoint_three_weightedExcess_pos :
    0 < (((oneEightNineABCPoint.a * oneEightNineABCPoint.b *
      oneEightNineABCPoint.c).factorization 3 - 1 : ℕ) : ℝ) *
        Real.log 3 := by
  rw [oneEightNineABCPoint_three_exponentExcess]
  norm_num
  exact Real.log_pos (by norm_num)

/-! ## The finite full-two-descent candidate table -/

/-- A squareclass supported on `{-1,2,3}`, encoded by the three parity
bits for `-1`, `2`, and `3`. -/
abbrev SquareClass23 := Bool × Bool × Bool

/-- The squarefree integer representative of a supported squareclass. -/
def squareClass23Rep (u : SquareClass23) : ℤ :=
  (if u.1 then -1 else 1) *
    (if u.2.1 then 2 else 1) *
      (if u.2.2 then 3 else 1)

/-- Multiplication of squareclasses is xor of exponent parities. -/
def squareClass23Mul (u v : SquareClass23) : SquareClass23 :=
  (u.1.xor v.1, u.2.1.xor v.2.1, u.2.2.xor v.2.2)

/-- The 64 full-descent candidates.  The first two squareclasses are free;
the third is their product because the three coordinates multiply to a
square. -/
abbrev FullTwoDescentCandidate := SquareClass23 × SquareClass23

/-- Integer representatives `(b₁,b₂,b₃)` for a candidate. -/
def fullTwoDescentCandidateRep
    (C : FullTwoDescentCandidate) : ℤ × ℤ × ℤ :=
  (squareClass23Rep C.1, squareClass23Rep C.2,
    squareClass23Rep (squareClass23Mul C.1 C.2))

/-- The homogeneous two-quadric covering attached to a candidate has a
primitive solution modulo `n`.  The search is made over the finite square
residue set rather than over four square roots; this is definitionally the
same congruence test and makes the exhaustive certificate small.  For the
prime powers `16` and `9`, at least one square is a unit exactly when the
corresponding four coordinates are primitive. -/
def descentCoveringSquareSearch
    {R : Type*} [CommRing R] [DecidableEq R]
    (squares unitSquares : List R) (b₁ b₂ b₃ : R) : Bool :=
  squares.any fun q₀ =>
    squares.any fun q₁ =>
      squares.any fun q₂ =>
        squares.any fun q₃ =>
          b₁ * q₁ - b₂ * q₂ = q₀ ∧
            b₃ * q₃ - b₁ * q₁ = 8 * q₀ ∧
            (q₀ ∈ unitSquares ∨ q₁ ∈ unitSquares ∨
              q₂ ∈ unitSquares ∨ q₃ ∈ unitSquares)

/-- The four square residues modulo `16`. -/
def squareResidues16 : List (ZMod 16) := [0, 1, 4, 9]

/-- The unit square residues modulo `16`. -/
def unitSquareResidues16 : List (ZMod 16) := [1, 9]

/-- The four square residues modulo `9`. -/
def squareResidues9 : List (ZMod 9) := [0, 1, 4, 7]

/-- The unit square residues modulo `9`. -/
def unitSquareResidues9 : List (ZMod 9) := [1, 4, 7]

/-- Completeness of the displayed square-residue list modulo `16`. -/
theorem mem_squareResidues16_iff (q : ZMod 16) :
    q ∈ squareResidues16 ↔ ∃ z : ZMod 16, z ^ 2 = q := by
  decide +revert

/-- Completeness of the displayed unit-square list modulo `16`. -/
theorem mem_unitSquareResidues16_iff (q : ZMod 16) :
    q ∈ unitSquareResidues16 ↔
      ∃ z : ZMod 16, IsUnit z ∧ z ^ 2 = q := by
  decide +revert

/-- Completeness of the displayed square-residue list modulo `9`. -/
theorem mem_squareResidues9_iff (q : ZMod 9) :
    q ∈ squareResidues9 ↔ ∃ z : ZMod 9, z ^ 2 = q := by
  decide +revert

/-- Completeness of the displayed unit-square list modulo `9`. -/
theorem mem_unitSquareResidues9_iff (q : ZMod 9) :
    q ∈ unitSquareResidues9 ↔
      ∃ z : ZMod 9, IsUnit z ∧ z ^ 2 = q := by
  decide +revert

/-- Primitive covering solubility modulo `16`. -/
def descentCoveringPrimitiveSolvableMod16
    (C : FullTwoDescentCandidate) : Bool :=
  let b := fullTwoDescentCandidateRep C
  descentCoveringSquareSearch squareResidues16 unitSquareResidues16
    (b.1 : ZMod 16) (b.2.1 : ZMod 16) (b.2.2 : ZMod 16)

/-- Primitive covering solubility modulo `9`. -/
def descentCoveringPrimitiveSolvableMod9
    (C : FullTwoDescentCandidate) : Bool :=
  let b := fullTwoDescentCandidateRep C
  descentCoveringSquareSearch squareResidues9 unitSquareResidues9
    (b.1 : ZMod 9) (b.2.1 : ZMod 9) (b.2.2 : ZMod 9)

private def scOne : SquareClass23 := (false, false, false)
private def scNegOne : SquareClass23 := (true, false, false)
private def scThree : SquareClass23 := (false, false, true)
private def scNegTwo : SquareClass23 := (true, true, false)
private def scNegThree : SquareClass23 := (true, false, true)

/-- The four candidate encodings surviving both local congruence tests. -/
def endpointDescentSurvivors : Finset FullTwoDescentCandidate :=
  {(scOne, scOne), (scOne, scThree),
    (scNegTwo, scNegOne), (scNegTwo, scNegThree)}

/-- Their displayed squarefree triples are exactly
`(1,1,1)`, `(1,3,3)`, `(-2,-1,2)`, and `(-2,-3,6)`. -/
theorem endpointDescentSurvivor_representatives :
    endpointDescentSurvivors.image fullTwoDescentCandidateRep =
      {(1, 1, 1), (1, 3, 3), (-2, -1, 2), (-2, -3, 6)} := by
  decide

/-- Exhaustive local table: among all 64 supported squareclass candidates,
primitive solubility both modulo `16` and modulo `9` leaves precisely the
four displayed survivors.  Any rational or `Q₂`/`Q₃` solution gives
such a primitive residue solution after clearing denominators and dividing
out the common prime power; that arithmetic passage is stated in the paper
audit, not modeled here. -/
theorem endpointDescent_localTable (C : FullTwoDescentCandidate) :
    (descentCoveringPrimitiveSolvableMod16 C = true ∧
      descentCoveringPrimitiveSolvableMod9 C = true) ↔
        C ∈ endpointDescentSurvivors := by
  decide +revert

/-! ## Two boundaries after local Kummer globalization -/

/-- The second Bernoulli polynomial occurring in the Tate local-height
formula.  This is only its scalar expression, not a local-height API. -/
noncomputable def tateBernoulliTwo (r : ℝ) : ℝ := r ^ 2 - r + 1 / 6

/-- Adding twice the quarter-component moves parameter zero to parameter
one half, while the Bernoulli contribution changes from positive to
negative.  On a split Tate curve with `q=p^(4m)`, this is the scalar shadow
of two points in the same local Kummer class. -/
theorem tateKummerDoubleShift_flipsBernoulliSign :
    (0 : ℝ) + 2 * (1 / 4) = 1 / 2 ∧
      tateBernoulliTwo 0 = 1 / 6 ∧
      tateBernoulliTwo (1 / 2) = -1 / 12 ∧
      0 < tateBernoulliTwo 0 ∧ tateBernoulliTwo (1 / 2) < 0 := by
  norm_num [tateBernoulliTwo]

/-- If nonnegative selector mass is divided among the three globally fixed
nonzero two-torsion labels, one label carries at least one third.  The
statement needs no positivity hypothesis: it is the elementary maximum
principle for three real numbers.  The paper audit explains why this easy
torsion-valued alignment neither produces a non-torsion point nor controls
local height. -/
theorem one_of_three_labels_carries_one_third
    (mass₀ mass₁ mass₂ : ℝ) :
    (mass₀ + mass₁ + mass₂) / 3 ≤ mass₀ ∨
      (mass₀ + mass₁ + mass₂) / 3 ≤ mass₁ ∨
      (mass₀ + mass₁ + mass₂) / 3 ≤ mass₂ := by
  by_contra h
  push Not at h
  linarith

/-! ## The exact logical boundary of a rank-zero obstruction -/

/-- If every global point is torsion, no condition whatsoever can select a
non-torsion global point.  Applied on paper to the rank-zero endpoint proved
by the explicit descent table, this refutes the universally quantified
non-torsion selector statement even though its local excess mass is
strictly positive. -/
theorem no_nonTorsion_selector_of_all_torsion
    {Point : Type*} (IsTorsion Selector : Point → Prop)
    (hrankZero : ∀ P, IsTorsion P) :
    ¬ ∃ P, ¬ IsTorsion P ∧ Selector P := by
  rintro ⟨P, hnonTorsion, -⟩
  exact hnonTorsion (hrankZero P)

/-- Quantitative decorations cannot repair the rank-zero failure: if the
global point is required to be non-torsion, even a positive target mass and
an arbitrary retained-fraction predicate leave the existential empty. -/
theorem no_weighted_nonTorsion_selector_of_all_torsion
    {Point : Type*} (IsTorsion : Point → Prop)
    (retainedMass : Point → ℝ) (targetMass proportion : ℝ)
    (hrankZero : ∀ P, IsTorsion P) :
    ¬ ∃ P, ¬ IsTorsion P ∧
      proportion * targetMass ≤ retainedMass P := by
  rintro ⟨P, hnonTorsion, -⟩
  exact hnonTorsion (hrankZero P)

end IUTThreeClosures
