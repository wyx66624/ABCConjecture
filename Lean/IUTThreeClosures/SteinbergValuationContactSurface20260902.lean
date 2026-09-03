/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.Tactic

/-!
# The Steinberg valuation contact surface of an abc point

For divisor vectors `A, B, C`, this file models the affine exterior area

`Omega(A,B,C) = (A-C) wedge (B-C)`

coefficient by coefficient.  It proves the three-leg expansion, affine and
`S_3` symmetries, the Steinberg--Bloch five-term gluing identity, and its
quadratic Veronese-peeling specialization.  The scalar section formalizes
the full mixed area, radical-skeleton area, a non-circular sufficient gate,
and an infinite full-premise family refuting that gate.  The primitive point
`9+16=25` separately refutes universal coefficient-one thinness.

The mathematical proofs and the scope audit precede this module in
`research/ABC_STEINBERG_VALUATION_CONTACT_SURFACE_2026_09_02.md`.
-/

namespace IUTThreeClosures
namespace SteinbergValuationContactSurface20260902

noncomputable section

/-! ## Coefficient model of the exterior surface -/

/-- A finite-prime divisor vector is represented coefficientwise.  The
algebraic identities below do not need a finite-support hypothesis. -/
abbrev DivisorVector := ℕ → ℤ

/-- Coefficient of `X wedge Y` on the ordered pair `(p,q)`. -/
def wedgeCoefficient (X Y : DivisorVector) (p q : ℕ) : ℤ :=
  X p * Y q - X q * Y p

/-- Coefficient of the affine area bivector
`(A-C) wedge (B-C)`. -/
def contactCoefficient
    (A B C : DivisorVector) (p q : ℕ) : ℤ :=
  wedgeCoefficient (A - C) (B - C) p q

/-- The affine contact surface is alternating in its coordinate pair. -/
theorem wedgeCoefficient_swap
    (X Y : DivisorVector) (p q : ℕ) :
    wedgeCoefficient X Y q p = -wedgeCoefficient X Y p q := by
  unfold wedgeCoefficient
  ring

/-- Every diagonal coefficient vanishes. -/
@[simp] theorem wedgeCoefficient_self_coordinate
    (X Y : DivisorVector) (p : ℕ) :
    wedgeCoefficient X Y p p = 0 := by
  unfold wedgeCoefficient
  ring

/-- Three-leg expansion
`(A-C) wedge (B-C) = A wedge B + B wedge C + C wedge A`. -/
theorem contactCoefficient_threeLeg
    (A B C : DivisorVector) (p q : ℕ) :
    contactCoefficient A B C p q =
      wedgeCoefficient A B p q + wedgeCoefficient B C p q +
        wedgeCoefficient C A p q := by
  unfold contactCoefficient wedgeCoefficient
  simp only [Pi.sub_apply]
  ring

/-- Translating all three divisor vertices leaves the surface unchanged. -/
theorem contactCoefficient_translate
    (A B C T : DivisorVector) (p q : ℕ) :
    contactCoefficient (A + T) (B + T) (C + T) p q =
      contactCoefficient A B C p q := by
  unfold contactCoefficient wedgeCoefficient
  simp only [Pi.add_apply, Pi.sub_apply]
  ring

/-- Scaling the divisor triangle scales its oriented area quadratically. -/
theorem contactCoefficient_scale
    (m : ℤ) (A B C : DivisorVector) (p q : ℕ) :
    contactCoefficient (m • A) (m • B) (m • C) p q =
      m ^ 2 * contactCoefficient A B C p q := by
  unfold contactCoefficient wedgeCoefficient
  simp only [Pi.smul_apply, smul_eq_mul, Pi.sub_apply]
  ring

/-- Cyclically permuting the three vertices preserves orientation. -/
theorem contactCoefficient_cyclic
    (A B C : DivisorVector) (p q : ℕ) :
    contactCoefficient B C A p q = contactCoefficient A B C p q := by
  rw [contactCoefficient_threeLeg, contactCoefficient_threeLeg]
  ring

/-- A transposition reverses orientation. -/
theorem contactCoefficient_swap_vertices
    (A B C : DivisorVector) (p q : ℕ) :
    contactCoefficient B A C p q = -contactCoefficient A B C p q := by
  unfold contactCoefficient wedgeCoefficient
  ring

/-! ## Positive rectangular support blocks -/

/-- On an `A-B` support rectangle, the contact coefficient is the product of
the two nonzero leg coefficients. -/
theorem contactCoefficient_left_middle
    (A B C : DivisorVector) (p q : ℕ)
    (hAq : A q = 0) (hBp : B p = 0)
    (hCp : C p = 0) (hCq : C q = 0) :
    contactCoefficient A B C p q = A p * B q := by
  unfold contactCoefficient wedgeCoefficient
  simp only [Pi.sub_apply, hAq, hBp, hCp, hCq]
  ring

/-- On a `B-C` support rectangle, the coefficient is the corresponding
product, with its ordered orientation. -/
theorem contactCoefficient_middle_right
    (A B C : DivisorVector) (p q : ℕ)
    (hAp : A p = 0) (hAq : A q = 0)
    (hBq : B q = 0) (hCp : C p = 0) :
    contactCoefficient A B C p q = B p * C q := by
  rw [contactCoefficient_threeLeg]
  unfold wedgeCoefficient
  simp only [hAp, hAq, hBq, hCp]
  ring

/-- On a `C-A` support rectangle, the coefficient is the corresponding
product, with its ordered orientation. -/
theorem contactCoefficient_right_left
    (A B C : DivisorVector) (p q : ℕ)
    (hAq : A q = 0) (hBp : B p = 0) (hBq : B q = 0)
    (hCp : C p = 0) :
    contactCoefficient A B C p q = -(C q * A p) := by
  rw [contactCoefficient_threeLeg]
  unfold wedgeCoefficient
  simp only [hAq, hBp, hBq, hCp]
  ring

/-! ## The five-term two-cell gluing identity -/

/-- Coefficientwise form of the Steinberg--Bloch five-term relation.

If `X,U,Y,V,Z` are respectively the divisor vectors of
`x, 1-x, y, 1-y, x-y`, the five wedge terms below are the surfaces of
`x`, `y`, `y/x`, `y(1-x)/(x(1-y))`, and `(1-x)/(1-y)`. -/
theorem steinberg_fiveTerm_surface
    (X U Y V Z : DivisorVector) (p q : ℕ) :
    wedgeCoefficient X U p q - wedgeCoefficient Y V p q +
        wedgeCoefficient (Y - X) (Z - X) p q -
        wedgeCoefficient (Y + U - X - V) (Z - X - V) p q +
        wedgeCoefficient (U - V) (Z - V) p q = 0 := by
  unfold wedgeCoefficient
  simp only [Pi.add_apply, Pi.sub_apply]
  ring

/-- Quadratic Veronese peeling, coefficientwise.  In the five-term relation
specialize `y=x^2`, write `X=d(x)`, `U=d(1-x)`, and `W=d(1+x)`.  Then
`d(y)=X+X`, `d(1-y)=U+W`, `d(x-y)=X+U`, and the last two five-term cells are
complements.  Thus the square contact cell is twice the `x` cell minus twice
the `x/(1+x)` cell. -/
theorem quadraticVeronese_peeling
    (X U W : DivisorVector) (p q : ℕ) :
    wedgeCoefficient (X + X) (U + W) p q =
      2 * wedgeCoefficient X U p q -
        2 * wedgeCoefficient (X - W) (-W) p q := by
  have h :=
    steinberg_fiveTerm_surface X U (X + X) (U + W) (X + U) p q
  unfold wedgeCoefficient at h ⊢
  simp only [Pi.add_apply, Pi.sub_apply, Pi.neg_apply] at h ⊢
  linear_combination -h

/-! ## Valuation and radical divisor surfaces -/

/-- The finite divisor vector of a natural number. -/
def valuationDivisor (n : ℕ) : DivisorVector :=
  fun p => (n.factorization p : ℤ)

/-- The coefficient-one truncation of the finite divisor vector. -/
def radicalDivisor (n : ℕ) : DivisorVector :=
  fun p => if p ∈ n.primeFactors then 1 else 0

/-- Valuation contact surface of an actual abc point. -/
def abcValuationContact (P : ABCPoint) (p q : ℕ) : ℤ :=
  contactCoefficient (valuationDivisor P.a) (valuationDivisor P.b)
    (valuationDivisor P.c) p q

/-- Radical-skeleton contact surface of an actual abc point. -/
def abcRadicalContact (P : ABCPoint) (p q : ℕ) : ℤ :=
  contactCoefficient (radicalDivisor P.a) (radicalDivisor P.b)
    (radicalDivisor P.c) p q

/-- The overstrong universal thinness predicate. -/
def ThinContact (P : ABCPoint) : Prop :=
  ∀ p q, (abcValuationContact P p q).natAbs ≤ 1

/-- The full-premise primitive counterexample used in the thinness audit. -/
def nineSixteenTwentyFive : ABCPoint where
  a := 9
  b := 16
  c := 25
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by norm_num [PairwiseCoprimeABC]

/-- At the `(3,2)` coordinate, the valuation surface of `9+16=25` has
absolute coefficient eight. -/
theorem nineSixteenTwentyFive_contact_3_2 :
    abcValuationContact nineSixteenTwentyFive 3 2 = 8 := by
  have h93 : (Nat.factorization 9) 3 = 2 := by
    change (Nat.factorization (3 ^ 2)) 3 = 2
    exact Nat.factorization_pow_self Nat.prime_three
  have h162 : (Nat.factorization 16) 2 = 4 := by
    change (Nat.factorization (2 ^ 4)) 2 = 4
    exact Nat.factorization_pow_self Nat.prime_two
  have h92 : (Nat.factorization 9) 2 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd (by norm_num)
  have h163 : (Nat.factorization 16) 3 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd (by norm_num)
  have h253 : (Nat.factorization 25) 3 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd (by norm_num)
  have h252 : (Nat.factorization 25) 2 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd (by norm_num)
  simp [abcValuationContact, contactCoefficient, wedgeCoefficient,
    valuationDivisor, nineSixteenTwentyFive, h93, h162, h92, h163, h253,
    h252]

/-- The corresponding radical-skeleton coefficient is one. -/
theorem nineSixteenTwentyFive_radicalContact_3_2 :
    abcRadicalContact nineSixteenTwentyFive 3 2 = 1 := by
  simp [abcRadicalContact, contactCoefficient, wedgeCoefficient,
    radicalDivisor, nineSixteenTwentyFive, Nat.mem_primeFactors,
    Nat.prime_two, Nat.prime_three]

/-- Universal coefficient-one thin contact is false even on a positive,
pairwise-coprime abc point. -/
theorem nineSixteenTwentyFive_not_thin :
    ¬ ThinContact nineSixteenTwentyFive := by
  intro h
  have hthin := h 3 2
  rw [nineSixteenTwentyFive_contact_3_2] at hthin
  norm_num at hthin

/-- Hence the universal thin-contact shortcut is refuted with all abc
premises present. -/
theorem not_universal_thinContact : ¬ ∀ P : ABCPoint, ThinContact P := by
  intro h
  exact nineSixteenTwentyFive_not_thin (h nineSixteenTwentyFive)

/-! ## Scalar mixed areas and the first closure gate -/

/-- Scalar coefficient norm of a positive three-leg contact surface. -/
def fullContactArea (ha hb hc : ℝ) : ℝ :=
  ha * hb + hb * hc + hc * ha

/-- First polarization between full leg masses and radical leg masses.  It
equals twice `fullContactArea` when all three legs are squarefree. -/
def mixedRadicalContactArea
    (ha hb hc ra rb rc : ℝ) : ℝ :=
  ha * rb + ra * hb + hb * rc + rb * hc + hc * ra + rc * ha

/-- Area of the coefficient-one radical skeleton. -/
def radicalSkeletonArea (ra rb rc : ℝ) : ℝ :=
  ra * rb + rb * rc + rc * ra

/-- The full-minus-skeleton mixed-depth expansion. -/
theorem fullContactArea_sub_radicalSkeletonArea
    (ra rb rc da db dc : ℝ) :
    fullContactArea (ra + da) (rb + db) (rc + dc) -
        radicalSkeletonArea ra rb rc =
      (ra * db + da * rb + da * db) +
      (rb * dc + db * rc + db * dc) +
      (rc * da + dc * ra + dc * da) := by
  unfold fullContactArea radicalSkeletonArea
  ring

/-- Exact polarization identity: the loss from replacing one side of each
pair by its radical is the defect on the other side. -/
theorem two_fullContactArea_sub_mixedRadicalContactArea
    (ha hb hc ra rb rc : ℝ) :
    2 * fullContactArea ha hb hc -
        mixedRadicalContactArea ha hb hc ra rb rc =
      ((ha - ra) * hb + (hb - rb) * ha) +
      ((hb - rb) * hc + (hc - rc) * hb) +
      ((hc - rc) * ha + (ha - ra) * hc) := by
  unfold fullContactArea mixedRadicalContactArea
  ring

/-- The radical triangle area is at most one third of the square of its
perimeter. -/
theorem three_mul_radicalSkeletonArea_le_perimeter_sq
    {ra rb rc : ℝ} :
    3 * radicalSkeletonArea ra rb rc ≤ (ra + rb + rc) ^ 2 := by
  unfold radicalSkeletonArea
  nlinarith [sq_nonneg (ra - rb), sq_nonneg (rb - rc),
    sq_nonneg (rc - ra)]

/-- Logarithmic mass of one integer leg. -/
def legHeight (n : ℕ) : ℝ := Real.log (n : ℝ)

/-- Logarithmic mass of its coefficient-one prime divisor. -/
def legRadicalMass (n : ℕ) : ℝ := Real.log (abcRadical n : ℝ)

/-- Full logarithmic valuation-contact area of an abc point. -/
def fullLogContactArea (P : ABCPoint) : ℝ :=
  fullContactArea (legHeight P.a) (legHeight P.b) (legHeight P.c)

/-- Full/radical polarized contact area of an abc point. -/
def mixedLogRadicalContactArea (P : ABCPoint) : ℝ :=
  mixedRadicalContactArea
    (legHeight P.a) (legHeight P.b) (legHeight P.c)
    (legRadicalMass P.a) (legRadicalMass P.b) (legRadicalMass P.c)

/-- Radical-skeleton area of an abc point. -/
def logRadicalSkeletonArea (P : ABCPoint) : ℝ :=
  radicalSkeletonArea (legRadicalMass P.a) (legRadicalMass P.b)
    (legRadicalMass P.c)

theorem legHeight_nonneg {n : ℕ} (hn : 0 < n) :
    0 ≤ legHeight n := by
  unfold legHeight
  apply Real.log_nonneg
  exact_mod_cast hn

theorem legRadicalMass_nonneg (n : ℕ) : 0 ≤ legRadicalMass n := by
  unfold legRadicalMass
  apply Real.log_nonneg
  exact_mod_cast (abcRadical_pos n)

/-- Radical truncation cannot increase logarithmic leg mass. -/
theorem legRadicalMass_le_legHeight {n : ℕ} (hn : 0 < n) :
    legRadicalMass n ≤ legHeight n := by
  have hdvd : abcRadical n ∣ n := by
    rw [abcRadical_eq_natRadical]
    exact UniqueFactorizationMonoid.radical_dvd_self
  have hle : abcRadical n ≤ n := Nat.le_of_dvd hn hdvd
  apply Real.log_le_log
  · exact_mod_cast (abcRadical_pos n)
  · exact_mod_cast hle

/-- On a primitive abc point, the radical perimeter is exactly the standard
conductor. -/
theorem radicalPerimeter_eq_conductor (P : ABCPoint) :
    legRadicalMass P.a + legRadicalMass P.b + legRadicalMass P.c =
      P.conductor := by
  have hra : 0 < (abcRadical P.a : ℝ) := by
    exact_mod_cast abcRadical_pos P.a
  have hrb : 0 < (abcRadical P.b : ℝ) := by
    exact_mod_cast abcRadical_pos P.b
  have hrc : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  unfold legRadicalMass ABCPoint.conductor
  rw [P.abcRadical_abcProduct]
  push_cast
  rw [Real.log_mul (mul_pos hra hrb).ne' hrc.ne',
    Real.log_mul hra.ne' hrb.ne']

/-- The scalar skeleton inequality in the repository's conductor
normalization. -/
theorem three_mul_logRadicalSkeletonArea_le_conductor_sq (P : ABCPoint) :
    3 * logRadicalSkeletonArea P ≤ P.conductor ^ 2 := by
  have h := three_mul_radicalSkeletonArea_le_perimeter_sq
    (ra := legRadicalMass P.a) (rb := legRadicalMass P.b)
    (rc := legRadicalMass P.c)
  rw [radicalPerimeter_eq_conductor P] at h
  exact h

/-- Elementary positive-triangle estimate used to extract height from area. -/
theorem log_c_sub_log_two_le_log_a_add_log_b (P : ABCPoint) :
    legHeight P.c - Real.log 2 ≤ legHeight P.a + legHeight P.b := by
  have hcNat : P.c ≤ 2 * (P.a * P.b) := by
    rw [← P.sum_eq]
    have ha_le : P.a ≤ P.a * P.b :=
      Nat.le_mul_of_pos_right P.a P.b_pos
    have hb_le : P.b ≤ P.a * P.b :=
      Nat.le_mul_of_pos_left P.b P.a_pos
    omega
  have hcR : (P.c : ℝ) ≤ 2 * ((P.a : ℝ) * P.b) := by
    exact_mod_cast hcNat
  have hlog : Real.log (P.c : ℝ) ≤
      Real.log (2 * ((P.a : ℝ) * P.b)) :=
    Real.log_le_log (by exact_mod_cast P.c_pos) hcR
  have haR : (P.a : ℝ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
  have hbR : (P.b : ℝ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
      (mul_ne_zero haR hbR), Real.log_mul haR hbR] at hlog
  unfold legHeight
  linarith

/-- The full contact area dominates the asymptotically sharp quadratic
height corridor `H*(H-log 2)`. -/
theorem height_mul_height_sub_log_two_le_fullLogContactArea (P : ABCPoint) :
    P.height * (P.height - Real.log 2) ≤ fullLogContactArea P := by
  have ha0 := legHeight_nonneg P.a_pos
  have hb0 := legHeight_nonneg P.b_pos
  have hc0 := legHeight_nonneg P.c_pos
  have hside := log_c_sub_log_two_le_log_a_add_log_b P
  have hmul := mul_le_mul_of_nonneg_left hside hc0
  calc
    P.height * (P.height - Real.log 2) =
        legHeight P.c * (legHeight P.c - Real.log 2) := by
      rw [P.height_eq_log_c]
      rfl
    _ ≤ legHeight P.c * (legHeight P.a + legHeight P.b) := hmul
    _ ≤ fullLogContactArea P := by
      unfold fullLogContactArea fullContactArea
      nlinarith [mul_nonneg ha0 hb0]

/-- The mixed full/radical area is at most twice height times conductor. -/
theorem mixedLogRadicalContactArea_le_two_height_conductor (P : ABCPoint) :
    mixedLogRadicalContactArea P ≤ 2 * P.height * P.conductor := by
  have hra0 : 0 ≤ legRadicalMass P.a := legRadicalMass_nonneg P.a
  have hrb0 : 0 ≤ legRadicalMass P.b := legRadicalMass_nonneg P.b
  have hrc0 : 0 ≤ legRadicalMass P.c := legRadicalMass_nonneg P.c
  have ha_le : legHeight P.a ≤ P.height := by
    rw [P.height_eq_log_c]
    unfold legHeight
    apply Real.log_le_log
    · exact_mod_cast P.a_pos
    · exact_mod_cast (Nat.le_of_lt P.a_lt_c)
  have hb_le : legHeight P.b ≤ P.height := by
    rw [P.height_eq_log_c]
    unfold legHeight
    apply Real.log_le_log
    · exact_mod_cast P.b_pos
    · exact_mod_cast (Nat.le_of_lt P.b_lt_c)
  have hc_eq : legHeight P.c = P.height := by
    exact P.height_eq_log_c.symm
  have h1 := mul_le_mul_of_nonneg_right ha_le hrb0
  have h2 := mul_le_mul_of_nonneg_right ha_le hrc0
  have h3 := mul_le_mul_of_nonneg_right hb_le hra0
  have h4 := mul_le_mul_of_nonneg_right hb_le hrc0
  have hper : legRadicalMass P.a + legRadicalMass P.b +
      legRadicalMass P.c = P.conductor := by
    exact radicalPerimeter_eq_conductor P
  have hperMul := congrArg (fun x : ℝ => P.height * x) hper
  unfold mixedLogRadicalContactArea mixedRadicalContactArea
  rw [hc_eq]
  nlinarith

/-- The first, single-cell mixed-area closure gate.  It is non-circular and
implies abc below, but a later theorem records the precise square-family
obstruction to this proposed estimate. -/
def UniformSingleCellMixedAreaGate : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ P : ABCPoint,
    fullLogContactArea P ≤
      ((1 + ε) / 2) * mixedLogRadicalContactArea P + C * P.height

/-- The earlier single-cell skeleton gate, with its constant quantified
uniformly over all primitive abc points.  A later theorem refutes it on the
same genuine Pythagorean-square family. -/
def UniformSingleCellSkeletonGate : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ K : ℝ, ∀ P : ABCPoint,
    fullLogContactArea P ≤
      3 * (1 + ε) ^ 2 * logRadicalSkeletonArea P + K ^ 2

/-- Pointwise extraction of the abc height bound from a single-cell mixed
area inequality. -/
theorem height_le_of_singleCellMixedArea
    (P : ABCPoint) {ε C : ℝ} (hε : 0 < ε)
    (hgate : fullLogContactArea P ≤
      ((1 + ε) / 2) * mixedLogRadicalContactArea P + C * P.height) :
    P.height ≤ (1 + ε) * P.conductor + C + Real.log 2 := by
  have hcoef : 0 ≤ (1 + ε) / 2 := by linarith
  have hM := mixedLogRadicalContactArea_le_two_height_conductor P
  have hscaled := mul_le_mul_of_nonneg_left hM hcoef
  have hlower := height_mul_height_sub_log_two_le_fullLogContactArea P
  have hHpos : 0 < P.height := by
    rw [P.height_eq_log_c]
    apply Real.log_pos
    have hc_two : 2 ≤ P.c := by
      calc
        2 = 1 + 1 := by norm_num
        _ ≤ P.a + P.b := Nat.add_le_add P.a_pos P.b_pos
        _ = P.c := P.sum_eq
    exact_mod_cast hc_two
  have hraw :
      P.height * (P.height - Real.log 2) ≤
        ((1 + ε) * P.conductor + C) * P.height := by
    calc
      P.height * (P.height - Real.log 2) ≤ fullLogContactArea P := hlower
      _ ≤ ((1 + ε) / 2) * mixedLogRadicalContactArea P +
          C * P.height := hgate
      _ ≤ ((1 + ε) / 2) * (2 * P.height * P.conductor) +
          C * P.height := by linarith
      _ = ((1 + ε) * P.conductor + C) * P.height := by ring
  have hcancel : P.height - Real.log 2 ≤
      (1 + ε) * P.conductor + C := by
    apply le_of_mul_le_mul_right _ hHpos
    nlinarith
  linarith

/-- The non-circular single-cell mixed-area gate would imply the standard
logarithmic abc conjecture. -/
theorem abcConjecture_of_uniformSingleCellMixedAreaGate
    (G : UniformSingleCellMixedAreaGate) : ABCConjecture := by
  intro ε hε
  rcases G ε hε with ⟨C, hC⟩
  refine ⟨C + Real.log 2, ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  have h := height_le_of_singleCellMixedArea P hε (hC P)
  simpa [ABCPoint.height, ABCPoint.conductor, P, add_assoc] using h

/-! ## The full-premise Pythagorean-square obstruction -/

/-- Euclid's consecutive-parameter odd leg. -/
def pythagoreanX (t : ℕ) : ℕ := 2 * t + 1

/-- Euclid's consecutive-parameter even leg. -/
def pythagoreanY (t : ℕ) : ℕ := 2 * t * (t + 1)

/-- Euclid's consecutive-parameter hypotenuse. -/
def pythagoreanZ (t : ℕ) : ℕ := 2 * t ^ 2 + 2 * t + 1

/-- Exact Pythagorean identity for consecutive parameters. -/
theorem pythagorean_identity (t : ℕ) :
    pythagoreanX t ^ 2 + pythagoreanY t ^ 2 =
      pythagoreanZ t ^ 2 := by
  unfold pythagoreanX pythagoreanY pythagoreanZ
  ring

/-- The two Euclidean legs are coprime for every parameter. -/
theorem pythagoreanX_coprime_pythagoreanY (t : ℕ) :
    Nat.Coprime (pythagoreanX t) (pythagoreanY t) := by
  have hx2 : Nat.Coprime (pythagoreanX t) 2 := by
    apply Nat.Coprime.symm
    exact (Nat.coprime_mul_left_add_right 2 1 t).2 (by simp)
  have hxt : Nat.Coprime (pythagoreanX t) t := by
    exact (Nat.coprime_mul_right_add_left 1 t 2).2 (by simp)
  have hxsucc : Nat.Coprime (pythagoreanX t) (pythagoreanX t + 1) := by
    exact Nat.coprime_self_add_right.mpr (by simp)
  have ht1dvd : t + 1 ∣ pythagoreanX t + 1 := by
    refine ⟨2, ?_⟩
    simp [pythagoreanX]
    ring
  have hxt1 : Nat.Coprime (pythagoreanX t) (t + 1) :=
    hxsucc.coprime_dvd_right ht1dvd
  have hprod :
      Nat.Coprime (pythagoreanX t) (2 * (t * (t + 1))) :=
    hx2.mul_right (hxt.mul_right hxt1)
  simpa [pythagoreanY, mul_assoc] using hprod

/-- Squaring a primitive Pythagorean triple gives a pairwise-coprime abc
triple. -/
theorem pythagoreanSquares_pairwise (t : ℕ) :
    PairwiseCoprimeABC (pythagoreanX t ^ 2) (pythagoreanY t ^ 2)
      (pythagoreanZ t ^ 2) := by
  have hab : Nat.Coprime (pythagoreanX t ^ 2)
      (pythagoreanY t ^ 2) :=
    (pythagoreanX_coprime_pythagoreanY t).pow 2 2
  have hbc : Nat.Coprime (pythagoreanY t ^ 2)
      (pythagoreanZ t ^ 2) := by
    rw [← pythagorean_identity]
    exact Nat.coprime_add_self_right.mpr hab.symm
  have hca : Nat.Coprime (pythagoreanZ t ^ 2)
      (pythagoreanX t ^ 2) := by
    rw [← pythagorean_identity]
    exact Nat.coprime_self_add_left.mpr hab.symm
  exact ⟨hab, hbc, hca⟩

/-- The actual positive abc point in the obstruction family. -/
def pythagoreanSquarePoint (t : ℕ) (ht : 0 < t) : ABCPoint where
  a := pythagoreanX t ^ 2
  b := pythagoreanY t ^ 2
  c := pythagoreanZ t ^ 2
  a_pos := by simp [pythagoreanX]
  b_pos := by
    unfold pythagoreanY
    positivity
  c_pos := by simp [pythagoreanZ]
  sum_eq := pythagorean_identity t
  pairwise_coprime := pythagoreanSquares_pairwise t

/-- On a square, radical mass is at most half of full logarithmic mass. -/
theorem square_legRadicalMass_le_half_legHeight
    (x : ℕ) (hx : 0 < x) :
    legRadicalMass (x ^ 2) ≤ legHeight (x ^ 2) / 2 := by
  have hradDvd : abcRadical x ∣ x := by
    rw [abcRadical_eq_natRadical]
    exact UniqueFactorizationMonoid.radical_dvd_self
  have hradLe : abcRadical x ≤ x := Nat.le_of_dvd hx hradDvd
  have hlog : Real.log (abcRadical x : ℝ) ≤ Real.log (x : ℝ) := by
    apply Real.log_le_log
    · exact_mod_cast abcRadical_pos x
    · exact_mod_cast hradLe
  unfold legRadicalMass legHeight
  rw [abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow x (by norm_num : (2 : ℕ) ≠ 0)]
  push_cast
  rw [Real.log_pow]
  norm_num
  simpa only [abcRadical_eq_natRadical] using hlog

/-- If each radical leg is at most half of its full leg, the polarized
mixed area is at most the full contact area. -/
theorem mixedRadicalContactArea_le_fullContactArea_of_half
    {ha hb hc ra rb rc : ℝ}
    (ha0 : 0 ≤ ha) (hb0 : 0 ≤ hb) (hc0 : 0 ≤ hc)
    (hra : ra ≤ ha / 2) (hrb : rb ≤ hb / 2) (hrc : rc ≤ hc / 2) :
    mixedRadicalContactArea ha hb hc ra rb rc ≤
      fullContactArea ha hb hc := by
  have h1 := mul_le_mul_of_nonneg_left hrb ha0
  have h2 := mul_le_mul_of_nonneg_right hra hb0
  have h3 := mul_le_mul_of_nonneg_left hrc hb0
  have h4 := mul_le_mul_of_nonneg_right hrb hc0
  have h5 := mul_le_mul_of_nonneg_left hra hc0
  have h6 := mul_le_mul_of_nonneg_right hrc ha0
  unfold mixedRadicalContactArea fullContactArea
  nlinarith

/-- If all three radical legs are at most half their full legs, the
radical-skeleton area is at most one quarter of full contact area. -/
theorem four_mul_radicalSkeletonArea_le_fullContactArea_of_half
    {ha hb hc ra rb rc : ℝ}
    (ha0 : 0 ≤ ha) (hb0 : 0 ≤ hb) (hc0 : 0 ≤ hc)
    (ra0 : 0 ≤ ra) (rb0 : 0 ≤ rb) (rc0 : 0 ≤ rc)
    (hra : ra ≤ ha / 2) (hrb : rb ≤ hb / 2) (hrc : rc ≤ hc / 2) :
    4 * radicalSkeletonArea ra rb rc ≤ fullContactArea ha hb hc := by
  have haHalf0 : 0 ≤ ha / 2 := by positivity
  have hbHalf0 : 0 ≤ hb / 2 := by positivity
  have hcHalf0 : 0 ≤ hc / 2 := by positivity
  have hab1 : ra * rb ≤ (ha / 2) * rb :=
    mul_le_mul_of_nonneg_right hra rb0
  have hab2 : (ha / 2) * rb ≤ (ha / 2) * (hb / 2) :=
    mul_le_mul_of_nonneg_left hrb haHalf0
  have hbc1 : rb * rc ≤ (hb / 2) * rc :=
    mul_le_mul_of_nonneg_right hrb rc0
  have hbc2 : (hb / 2) * rc ≤ (hb / 2) * (hc / 2) :=
    mul_le_mul_of_nonneg_left hrc hbHalf0
  have hca1 : rc * ra ≤ (hc / 2) * ra :=
    mul_le_mul_of_nonneg_right hrc ra0
  have hca2 : (hc / 2) * ra ≤ (hc / 2) * (ha / 2) :=
    mul_le_mul_of_nonneg_left hra hcHalf0
  unfold radicalSkeletonArea fullContactArea
  nlinarith

/-- Every member of the Pythagorean-square family has polarized radical area
at most its full contact area. -/
theorem pythagoreanSquare_mixedArea_le_fullArea
    (t : ℕ) (ht : 0 < t) :
    mixedLogRadicalContactArea (pythagoreanSquarePoint t ht) ≤
      fullLogContactArea (pythagoreanSquarePoint t ht) := by
  apply mixedRadicalContactArea_le_fullContactArea_of_half
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).a_pos
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).b_pos
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).c_pos
  · exact square_legRadicalMass_le_half_legHeight _ (by
      simp [pythagoreanX])
  · exact square_legRadicalMass_le_half_legHeight _ (by
      unfold pythagoreanY
      positivity)
  · exact square_legRadicalMass_le_half_legHeight _ (by
      simp [pythagoreanZ])

/-- On the Pythagorean-square family the radical skeleton has at most one
quarter of the full contact area. -/
theorem four_mul_pythagoreanSquare_skeletonArea_le_fullArea
    (t : ℕ) (ht : 0 < t) :
    4 * logRadicalSkeletonArea (pythagoreanSquarePoint t ht) ≤
      fullLogContactArea (pythagoreanSquarePoint t ht) := by
  apply four_mul_radicalSkeletonArea_le_fullContactArea_of_half
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).a_pos
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).b_pos
  · exact legHeight_nonneg (pythagoreanSquarePoint t ht).c_pos
  · exact legRadicalMass_nonneg _
  · exact legRadicalMass_nonneg _
  · exact legRadicalMass_nonneg _
  · exact square_legRadicalMass_le_half_legHeight _ (by
      simp [pythagoreanX])
  · exact square_legRadicalMass_le_half_legHeight _ (by
      unfold pythagoreanY
      positivity)
  · exact square_legRadicalMass_le_half_legHeight _ (by
      simp [pythagoreanZ])

/-- The even squared leg has unbounded logarithmic height. -/
theorem pythagoreanY_square_legHeight_unbounded (B : ℝ) :
    ∃ t : ℕ, 0 < t ∧ B < legHeight (pythagoreanY t ^ 2) := by
  obtain ⟨t, ht⟩ := exists_nat_gt (Real.exp (B / 2))
  have hexpPos : 0 < Real.exp (B / 2) := Real.exp_pos _
  have htPosR : 0 < (t : ℝ) := lt_trans hexpPos ht
  have htPos : 0 < t := by exact_mod_cast htPosR
  have htYNat : t ≤ pythagoreanY t := by
    rw [show pythagoreanY t = t * (2 * (t + 1)) by
      unfold pythagoreanY
      ring]
    exact Nat.le_mul_of_pos_right t (by positivity)
  have htYR : (t : ℝ) ≤ (pythagoreanY t : ℝ) := by exact_mod_cast htYNat
  have hsquare : (Real.exp (B / 2)) ^ 2 < (t : ℝ) ^ 2 := by
    nlinarith [sq_nonneg ((t : ℝ) - Real.exp (B / 2))]
  have hexpSquare : (Real.exp (B / 2)) ^ 2 = Real.exp B := by
    rw [pow_two, ← Real.exp_add]
    congr 1
    ring
  have htarget : Real.exp B < ((pythagoreanY t ^ 2 : ℕ) : ℝ) := by
    rw [← hexpSquare]
    push_cast
    nlinarith [sq_nonneg ((pythagoreanY t : ℝ) - t)]
  refine ⟨t, htPos, ?_⟩
  unfold legHeight
  have hypos : 0 < pythagoreanY t := by
    unfold pythagoreanY
    positivity
  have hysqpos : 0 < ((pythagoreanY t ^ 2 : ℕ) : ℝ) := by
    exact_mod_cast pow_pos hypos 2
  exact (Real.lt_log_iff_exp_lt hysqpos).2 htarget

/-- Full contact area divided by abc height is unbounded on the genuine
primitive Pythagorean-square family. -/
theorem pythagoreanSquare_fullArea_over_height_unbounded (B : ℝ) :
    ∃ t : ℕ, ∃ ht : 0 < t,
      B * (pythagoreanSquarePoint t ht).height <
        fullLogContactArea (pythagoreanSquarePoint t ht) := by
  obtain ⟨t, ht, hB⟩ := pythagoreanY_square_legHeight_unbounded B
  refine ⟨t, ht, ?_⟩
  let P := pythagoreanSquarePoint t ht
  have ha0 : 0 ≤ legHeight P.a := legHeight_nonneg P.a_pos
  have hb0 : 0 ≤ legHeight P.b := legHeight_nonneg P.b_pos
  have hc0 : 0 ≤ legHeight P.c := legHeight_nonneg P.c_pos
  have hcpos : 0 < legHeight P.c := by
    unfold legHeight
    apply Real.log_pos
    have hz : 1 < pythagoreanZ t := by
      unfold pythagoreanZ
      nlinarith
    have hzsq : 1 < pythagoreanZ t ^ 2 := by nlinarith
    exact_mod_cast hzsq
  have hB' : B < legHeight P.b := by
    exact hB
  have hmul : B * legHeight P.c < legHeight P.b * legHeight P.c :=
    mul_lt_mul_of_pos_right hB' hcpos
  rw [P.height_eq_log_c]
  change B * legHeight P.c < fullLogContactArea P
  unfold fullLogContactArea fullContactArea
  nlinarith [mul_nonneg ha0 hb0, mul_nonneg hc0 ha0]

/-- The first single-cell mixed-area gate is refuted by an infinite family of
positive pairwise-coprime abc points.  This is not a counterexample to abc;
it only retires this exact surface-to-own-skeleton inequality. -/
theorem not_uniformSingleCellMixedAreaGate :
    ¬ UniformSingleCellMixedAreaGate := by
  intro G
  obtain ⟨C, hC⟩ := G (1 / 2 : ℝ) (by norm_num)
  obtain ⟨t, ht, hlarge⟩ :=
    pythagoreanSquare_fullArea_over_height_unbounded (4 * C)
  let P := pythagoreanSquarePoint t ht
  have hgate := hC P
  have hMF := pythagoreanSquare_mixedArea_le_fullArea t ht
  have hquarter : fullLogContactArea P ≤ 4 * C * P.height := by
    dsimp only [P] at hgate hMF ⊢
    norm_num at hgate
    nlinarith
  exact (not_lt_of_ge hquarter) hlarge

/-- Every genuine Pythagorean-square point in the family has height greater
than one; this removes any hidden small-height issue in the uniform-constant
counterexample. -/
theorem one_lt_pythagoreanSquare_height (t : ℕ) (ht : 0 < t) :
    1 < (pythagoreanSquarePoint t ht).height := by
  rw [(pythagoreanSquarePoint t ht).height_eq_log_c]
  change 1 < Real.log (((pythagoreanZ t) ^ 2 : ℕ) : ℝ)
  have hzFive : 5 ≤ pythagoreanZ t := by
    unfold pythagoreanZ
    nlinarith
  have hzSqPos : 0 < ((pythagoreanZ t ^ 2 : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < pythagoreanZ t ^ 2 by nlinarith)
  apply (Real.lt_log_iff_exp_lt hzSqPos).2
  have hthree : (3 : ℝ) < ((pythagoreanZ t ^ 2 : ℕ) : ℝ) := by
    exact_mod_cast (show 3 < pythagoreanZ t ^ 2 by nlinarith)
  exact lt_trans Real.exp_one_lt_three hthree

/-- The single-cell coefficient-one skeleton gate is also refuted with all
of its quantifiers and every primitive abc premise realized.  This theorem
retires only this exact gate, not the multi-cell five-term route or abc. -/
theorem not_uniformSingleCellSkeletonGate :
    ¬ UniformSingleCellSkeletonGate := by
  intro G
  obtain ⟨K, hK⟩ := G (1 / 10 : ℝ) (by norm_num)
  obtain ⟨t, ht, hlarge⟩ :=
    pythagoreanSquare_fullArea_over_height_unbounded (12 * K ^ 2 + 1)
  let P := pythagoreanSquarePoint t ht
  have hheight : 1 < P.height := one_lt_pythagoreanSquare_height t ht
  have hfullLarge : 12 * K ^ 2 < fullLogContactArea P := by
    dsimp only [P] at hlarge hheight ⊢
    nlinarith [sq_nonneg K]
  have hskeleton :=
    four_mul_pythagoreanSquare_skeletonArea_le_fullArea t ht
  have hgate := hK P
  dsimp only [P] at hskeleton hgate hfullLarge
  norm_num at hgate
  nlinarith [sq_nonneg K]

/-! ## Veronese-ray versus primitive-base residual thickness -/

/-- Exact one-leg decomposition after writing a leg height as `g*u`.
The first term is coherent perfect-power (Veronese-ray) thickness; the
second is the residual thickness of the primitive base. -/
theorem exponentDefect_veronese_residual
    (g u r h : ℝ) (hh : h = g * u) :
    h - r = (g - 1) * u + (u - r) := by
  rw [hh]
  ring

/-- Bilinear loss contributed by three leg defects. -/
def contactLossFromDefects
    (da db dc ha hb hc : ℝ) : ℝ :=
  (da * hb + db * ha) + (db * hc + dc * hb) +
    (dc * ha + da * hc)

/-- The contact loss splits exactly into coherent Veronese-ray loss and
primitive-base residual loss.  This algebraic split is what survives the
Pythagorean-square counterexample. -/
theorem contactLoss_veronese_residual_split
    (ga gb gc ua ub uc ra rb rc ha hb hc : ℝ)
    (hha : ha = ga * ua) (hhb : hb = gb * ub)
    (hhc : hc = gc * uc) :
    contactLossFromDefects (ha - ra) (hb - rb) (hc - rc) ha hb hc =
      contactLossFromDefects ((ga - 1) * ua) ((gb - 1) * ub)
          ((gc - 1) * uc) ha hb hc +
        contactLossFromDefects (ua - ra) (ub - rb) (uc - rc) ha hb hc := by
  rw [hha, hhb, hhc]
  unfold contactLossFromDefects
  ring

/-! ## The automatic boundary inequality for finite fillings -/

/-- A finite-coordinate weighted `l1` triangle inequality turns an exact
signed filling relation into the third inequality of Gate VF.  Here `omega`
already includes the chosen nonnegative coordinate weights.  The two sums
on the right are respectively the calibrated boundary cost and the residual
cost.  Thus only their two uniform upper estimates remain open.

For actual divisor cells, take the finite coordinate set to contain the
union of their prime supports. -/
theorem finiteFilling_boundary_le_calibratedCost
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (n : ι → ℝ) (omega : ι → κ → ℝ) (omega0 : κ → ℝ)
    (mixed coherent residual : ι → ℝ)
    (hboundary : ∀ k, omega0 k = ∑ j, n j * omega j k)
    (hcell : ∀ j,
      2 * (∑ k, |omega j k|) =
        mixed j + coherent j + residual j) :
    (∑ k, |omega0 k|) ≤
      (1 / 2 : ℝ) *
        ((∑ j, |n j| * (mixed j + coherent j)) +
          ∑ j, |n j| * residual j) := by
  classical
  have hcoordinate (k : κ) :
      |omega0 k| ≤ ∑ j, |n j| * |omega j k| := by
    rw [hboundary k]
    calc
      |∑ j, n j * omega j k| ≤ ∑ j, |n j * omega j k| :=
        Finset.abs_sum_le_sum_abs (fun j => n j * omega j k) Finset.univ
      _ = ∑ j, |n j| * |omega j k| := by
        apply Finset.sum_congr rfl
        intro j _
        rw [abs_mul]
  have hcell' (j : ι) :
      (∑ k, |omega j k|) =
        (1 / 2 : ℝ) * (mixed j + coherent j + residual j) := by
    have hj := hcell j
    linarith
  calc
    (∑ k, |omega0 k|) ≤
        ∑ k, ∑ j, |n j| * |omega j k| := by
      exact Finset.sum_le_sum (fun k _ => hcoordinate k)
    _ = ∑ j, |n j| * (∑ k, |omega j k|) := by
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro j _
      rw [Finset.mul_sum]
    _ = ∑ j, |n j| *
        ((1 / 2 : ℝ) * (mixed j + coherent j + residual j)) := by
      apply Finset.sum_congr rfl
      intro j _
      rw [hcell' j]
    _ = (1 / 2 : ℝ) *
        ((∑ j, |n j| * (mixed j + coherent j)) +
          ∑ j, |n j| * residual j) := by
      rw [← Finset.sum_add_distrib, Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro j _
      ring

end
end SteinbergValuationContactSurface20260902
end IUTThreeClosures
