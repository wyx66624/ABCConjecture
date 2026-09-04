/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSynchronizedDivisorPackets20260903
import Mathlib

/-!
# The labeled valuation-incidence complex of a primitive abc triple

For a primitive nonunit datum `a + b = c`, a face chooses an arbitrary
subset of the prime support on each of the three arms.  A chosen prime is
labeled by its arm and carries its actual factorization exponent.  Every face
has six multiplicative tropical coordinates: a selected radical and a
selected multiplicity defect on each arm.  The face modulus is their product.

The module proves the face-poset laws, exact radical/defect factorization,
the three local congruence signatures, pairwise coprimality of their moduli,
and downward closure of the three-parameter defect filtration.  It also gives
an exact rational-power reformulation of the abc height target in the top
face coordinates and a six-vertex complete-premise example.

There is no asymptotic or `abc` assumption here.  In particular, the module
does not bound the top-face defect for an arbitrary primitive datum.
-/

namespace IUTThreeClosures
namespace ABCValuationIncidenceComplex20260903

open UniqueFactorizationMonoid
open ABCSynchronizedDivisorPackets20260903

abbrev PrimitiveABC :=
  ABCSynchronizedDivisorPackets20260903.PrimitiveABC

/-- The three labeled arms of `a + b = c`. -/
inductive Arm where
  | A
  | B
  | C
  deriving DecidableEq, Fintype, Repr

/-- The natural-number coordinate carried by an arm. -/
def coordinate (P : PrimitiveABC) : Arm → ℕ
  | .A => P.a
  | .B => P.b
  | .C => P.c

/-- Every arm coordinate is positive. -/
theorem coordinate_pos (P : PrimitiveABC) (r : Arm) : 0 < coordinate P r := by
  cases r with
  | A => exact lt_trans Nat.zero_lt_one P.a_gt_one
  | B => exact lt_trans Nat.zero_lt_one P.b_gt_one
  | C => exact P.c_pos

/-- A face is a three-arm selection of actual prime divisors.  The subset
fields make this a certified face of the full support simplex. -/
structure Face (P : PrimitiveABC) where
  support : Arm → Finset ℕ
  support_subset : ∀ r, support r ⊆ (coordinate P r).primeFactors

namespace Face

variable {P : PrimitiveABC}

/-- Faces are determined by their three selected support sets. -/
@[ext] theorem ext {F G : Face P}
    (h : ∀ r, F.support r = G.support r) : F = G := by
  cases F with
  | mk Fs hFs =>
    cases G with
    | mk Gs hGs =>
      have hs : Fs = Gs := funext h
      subst Gs
      rfl

/-- The empty face. -/
def empty (P : PrimitiveABC) : Face P where
  support := fun _ => ∅
  support_subset := by simp

/-- The top face containing every prime on every arm. -/
def full (P : PrimitiveABC) : Face P where
  support := fun r => (coordinate P r).primeFactors
  support_subset := by simp

/-- Coordinatewise union of two faces. -/
def union (F G : Face P) : Face P where
  support := fun r => F.support r ∪ G.support r
  support_subset := by
    intro r p hp
    rcases Finset.mem_union.mp hp with hp | hp
    · exact F.support_subset r hp
    · exact G.support_subset r hp

/-- Coordinatewise intersection of two faces. -/
def inter (F G : Face P) : Face P where
  support := fun r => F.support r ∩ G.support r
  support_subset := by
    intro r p hp
    exact F.support_subset r (Finset.mem_inter.mp hp).1

/-- The face relation, written without imposing an order instance. -/
def IsSubface (F G : Face P) : Prop :=
  ∀ r, F.support r ⊆ G.support r

theorem isSubface_refl (F : Face P) : F.IsSubface F := by
  intro r
  exact Finset.Subset.rfl

theorem isSubface_trans {F G H : Face P}
    (hFG : F.IsSubface G) (hGH : G.IsSubface H) : F.IsSubface H := by
  intro r
  exact (hFG r).trans (hGH r)

theorem isSubface_antisymm {F G : Face P}
    (hFG : F.IsSubface G) (hGF : G.IsSubface F) : F = G := by
  apply Face.ext
  intro r
  exact Finset.Subset.antisymm (hFG r) (hGF r)

theorem empty_isSubface (F : Face P) : (empty P).IsSubface F := by
  intro r
  simp [empty]

theorem isSubface_full (F : Face P) : F.IsSubface (full P) :=
  F.support_subset

theorem isSubface_union_left (F G : Face P) : F.IsSubface (F.union G) := by
  intro r
  exact Finset.subset_union_left

theorem isSubface_union_right (F G : Face P) : G.IsSubface (F.union G) := by
  intro r
  exact Finset.subset_union_right

theorem union_isSubface {F G H : Face P}
    (hF : F.IsSubface H) (hG : G.IsSubface H) : (F.union G).IsSubface H := by
  intro r
  exact Finset.union_subset (hF r) (hG r)

/-- Number of labeled prime vertices in a face. -/
def vertexCount (F : Face P) : ℕ :=
  ∑ r : Arm, (F.support r).card

/-- Natural-valued simplex dimension, with the empty face assigned zero. -/
def natDimension (F : Face P) : ℕ :=
  F.vertexCount - 1

/-- The actual `p`-adic exponent attached to an arm-labeled prime. -/
def valuation (P : PrimitiveABC) (r : Arm) (p : ℕ) : ℕ :=
  (coordinate P r).factorization p

/-- Selected radical on one arm. -/
def armRadical (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p

/-- Selected multiplicity defect on one arm. -/
def armDefect (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p ^ (valuation P r p - 1)

/-- Selected full prime-power modulus on one arm. -/
def armModulus (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p ^ valuation P r p

/-- Additive multiplicity defect used to filter the face simplex. -/
def defectDegree (F : Face P) (r : Arm) : ℕ :=
  ∑ p ∈ F.support r, (valuation P r p - 1)

/-- The six multiplicative tropical coordinates, grouped by arm. -/
def tropicalPoint (F : Face P) : Arm → ℕ × ℕ :=
  fun r => (F.armRadical r, F.armDefect r)

/-- Six real logarithmic coordinates underlying the tropical display.  The
exact arithmetic object remains `tropicalPoint`; no floating-point value is
used in any face or filtration predicate. -/
noncomputable def logarithmicPoint (F : Face P) : Arm → ℝ × ℝ :=
  fun r => (Real.log (F.armRadical r : ℝ),
    Real.log (F.armDefect r : ℝ))

/-- Every prime selected by a face is prime. -/
theorem prime_of_mem_support (F : Face P) {r : Arm} {p : ℕ}
    (hp : p ∈ F.support r) : p.Prime := by
  exact Nat.prime_of_mem_primeFactors (F.support_subset r hp)

/-- Every selected prime has positive valuation on its arm. -/
theorem valuation_pos_of_mem_support (F : Face P) {r : Arm} {p : ℕ}
    (hp : p ∈ F.support r) : 0 < valuation P r p := by
  have hprime := F.prime_of_mem_support hp
  have hdvd : p ∣ coordinate P r :=
    (Nat.mem_primeFactors.mp (F.support_subset r hp)).2.1
  exact hprime.factorization_pos_of_dvd (coordinate_pos P r).ne' hdvd

/-- Every selected arm radical is positive, including the empty product. -/
theorem armRadical_pos (F : Face P) (r : Arm) : 0 < F.armRadical r := by
  simp only [armRadical]
  exact Finset.prod_pos fun p hp => (F.prime_of_mem_support hp).pos

/-- Every selected defect coordinate is positive. -/
theorem armDefect_pos (F : Face P) (r : Arm) : 0 < F.armDefect r := by
  simp only [armDefect]
  exact Finset.prod_pos fun p hp =>
    pow_pos (F.prime_of_mem_support hp).pos _

/-- Radical coordinates divide upward along the face relation. -/
theorem armRadical_dvd_of_isSubface {F G : Face P}
    (hFG : F.IsSubface G) (r : Arm) : F.armRadical r ∣ G.armRadical r := by
  exact Finset.prod_dvd_prod_of_subset _ _ _ (hFG r)

/-- Radical coordinates are monotone along the face relation. -/
theorem armRadical_le_of_isSubface {F G : Face P}
    (hFG : F.IsSubface G) (r : Arm) : F.armRadical r ≤ G.armRadical r := by
  exact Nat.le_of_dvd (G.armRadical_pos r)
    (armRadical_dvd_of_isSubface hFG r)

/-- The selected radical times the selected defect is exactly the selected
prime-power modulus. -/
theorem armRadical_mul_armDefect (F : Face P) (r : Arm) :
    F.armRadical r * F.armDefect r = F.armModulus r := by
  rw [armRadical, armDefect, armModulus, ← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro p hp
  rw [← pow_succ']
  congr 1
  have hpos := F.valuation_pos_of_mem_support hp
  omega

/-- Every face modulus divides its ambient arm coordinate. -/
theorem armModulus_dvd_coordinate (F : Face P) (r : Arm) :
    F.armModulus r ∣ coordinate P r := by
  calc
    F.armModulus r ∣
        ∏ p ∈ (coordinate P r).primeFactors,
          p ^ valuation P r p := by
      exact Finset.prod_dvd_prod_of_subset _ _ _ (F.support_subset r)
    _ = coordinate P r := by
      simpa only [valuation, Nat.prod_factorization_eq_prod_primeFactors] using
        (Nat.prod_factorization_pow_eq_self (coordinate_pos P r).ne')

/-- The top-face arm modulus reconstructs the complete coordinate. -/
theorem full_armModulus (P : PrimitiveABC) (r : Arm) :
    (full P).armModulus r = coordinate P r := by
  simpa only [armModulus, full, valuation,
    Nat.prod_factorization_eq_prod_primeFactors] using
      (Nat.prod_factorization_pow_eq_self (coordinate_pos P r).ne')

/-- The top-face selected radical is the ordinary squarefree radical. -/
theorem full_armRadical (P : PrimitiveABC) (r : Arm) :
    (full P).armRadical r = radical (coordinate P r) := by
  rw [armRadical, full, Nat.radical_eq_prod_primeFactors]

/-- Exact armwise radical-defect factorization at the top face. -/
theorem full_radical_mul_defect (P : PrimitiveABC) (r : Arm) :
    radical (coordinate P r) * (full P).armDefect r = coordinate P r := by
  rw [← full_armRadical]
  exact (full P).armRadical_mul_armDefect r |>.trans (full_armModulus P r)

/-- Pairwise disjointness of faces on every arm. -/
def ArmwiseDisjoint (F G : Face P) : Prop :=
  ∀ r, Disjoint (F.support r) (G.support r)

/-- Radical coordinates multiply under disjoint face union. -/
theorem armRadical_union (F G : Face P) (h : F.ArmwiseDisjoint G) (r : Arm) :
    (F.union G).armRadical r = F.armRadical r * G.armRadical r := by
  simp only [armRadical, union]
  exact Finset.prod_union (h r)

/-- Defect coordinates multiply under disjoint face union. -/
theorem armDefect_union (F G : Face P) (h : F.ArmwiseDisjoint G) (r : Arm) :
    (F.union G).armDefect r = F.armDefect r * G.armDefect r := by
  simp only [armDefect, union]
  exact Finset.prod_union (h r)

/-- Full moduli multiply under disjoint face union. -/
theorem armModulus_union (F G : Face P) (h : F.ArmwiseDisjoint G) (r : Arm) :
    (F.union G).armModulus r = F.armModulus r * G.armModulus r := by
  simp only [armModulus, union]
  exact Finset.prod_union (h r)

/-- Defect degrees add under disjoint face union. -/
theorem defectDegree_union (F G : Face P) (h : F.ArmwiseDisjoint G) (r : Arm) :
    (F.union G).defectDegree r = F.defectDegree r + G.defectDegree r := by
  simp only [defectDegree, union]
  exact Finset.sum_union (h r)

/-- A three-arm additive defect budget. -/
abbrev Budget := Arm → ℕ

/-- The filtered subcomplex at a defect budget. -/
def IsBudgetFace (F : Face P) (budget : Budget) : Prop :=
  ∀ r, F.defectDegree r ≤ budget r

/-- The defect filtration is downward closed. -/
theorem isBudgetFace_of_isSubface {F G : Face P} {budget : Budget}
    (hGF : G.IsSubface F) (hF : F.IsBudgetFace budget) :
    G.IsBudgetFace budget := by
  intro r
  exact (Finset.sum_le_sum_of_subset (hGF r)).trans (hF r)

/-- The empty face occurs at every defect budget. -/
theorem empty_isBudgetFace (P : PrimitiveABC) (budget : Budget) :
    (empty P).IsBudgetFace budget := by
  intro r
  simp [defectDegree, empty]

/-- Exact description of the zero filtration level: it contains precisely
the faces whose selected vertices all have valuation one. -/
theorem zeroBudget_iff_valuation_one (F : Face P) :
    F.IsBudgetFace (fun _ => 0) ↔
      ∀ r p, p ∈ F.support r → valuation P r p = 1 := by
  constructor
  · intro h r p hp
    have hterm : valuation P r p - 1 ≤ F.defectDegree r := by
      simp only [defectDegree]
      exact Finset.single_le_sum
        (f := fun q => valuation P r q - 1)
        (fun q hq => Nat.zero_le _) hp
    have hzero : valuation P r p - 1 = 0 := by
      have hbudget := h r
      simp only at hbudget
      omega
    have hpos := F.valuation_pos_of_mem_support hp
    omega
  · intro h r
    have hzero : F.defectDegree r = 0 := by
      simp only [defectDegree]
      apply Finset.sum_eq_zero
      intro p hp
      rw [h r p hp]
      rfl
    rw [hzero]

/-- Disjoint union sends budget levels `u` and `v` into the pointwise sum
level. -/
theorem union_isBudgetFace (F G : Face P) (hdisj : F.ArmwiseDisjoint G)
    {u v : Budget} (hF : F.IsBudgetFace u) (hG : G.IsBudgetFace v) :
    (F.union G).IsBudgetFace (fun r => u r + v r) := by
  intro r
  rw [F.defectDegree_union G hdisj r]
  exact Nat.add_le_add (hF r) (hG r)

/-- The three exact local congruence signatures carried by every face:
`A` records `c = b`, `B` records `c = a`, and `C` records `a + b = 0`
modulo the corresponding selected prime-power modulus. -/
theorem localIncidenceSignature (F : Face P) :
    P.c ≡ P.b [MOD F.armModulus .A] ∧
      P.c ≡ P.a [MOD F.armModulus .B] ∧
      P.a + P.b ≡ 0 [MOD F.armModulus .C] := by
  have hA : F.armModulus .A ∣ P.a := by
    simpa [coordinate] using F.armModulus_dvd_coordinate Arm.A
  have hB : F.armModulus .B ∣ P.b := by
    simpa [coordinate] using F.armModulus_dvd_coordinate Arm.B
  have hC : F.armModulus .C ∣ P.c := by
    simpa [coordinate] using F.armModulus_dvd_coordinate Arm.C
  constructor
  · rw [← P.sum_eq]
    simpa using hA.modEq_zero_nat.add_right P.b
  constructor
  · rw [← P.sum_eq]
    simpa using hB.modEq_zero_nat.add_left P.a
  · rw [P.sum_eq]
    exact hC.modEq_zero_nat

/-- Face moduli on the first two arms are coprime. -/
theorem coprime_modulus_AB (F : Face P) :
    (F.armModulus .A).Coprime (F.armModulus .B) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.A)
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.B)
    P.coprime_ab

/-- Face moduli on the first and sum arms are coprime. -/
theorem coprime_modulus_AC (F : Face P) :
    (F.armModulus .A).Coprime (F.armModulus .C) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.A)
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.C)
    P.coprime_ac

/-- Face moduli on the second and sum arms are coprime. -/
theorem coprime_modulus_BC (F : Face P) :
    (F.armModulus .B).Coprime (F.armModulus .C) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.B)
    (by simpa [coordinate] using F.armModulus_dvd_coordinate Arm.C)
    P.coprime_bc

/-- The two summand-arm moduli form a reconstruction window when their
product is larger than `c`. -/
def ABReconstructing (F : Face P) : Prop :=
  P.c < F.armModulus .A * F.armModulus .B

/-- The top face is always an `A`/`B` reconstruction window on the nonunit
scope. -/
theorem full_ABReconstructing (P : PrimitiveABC) :
    (full P).ABReconstructing := by
  rw [ABReconstructing, full_armModulus, full_armModulus]
  simpa [coordinate] using P.c_lt_mul_ab

/-- CRT rigidity inside a reconstruction window.  The two local incidence
residues determine `c` uniquely below the product of the selected `A` and `B`
moduli. -/
theorem eq_c_of_ABReconstructing (F : Face P) (hrec : F.ABReconstructing)
    {x : ℕ} (hx : x < F.armModulus .A * F.armModulus .B)
    (hA : x ≡ P.b [MOD F.armModulus .A])
    (hB : x ≡ P.a [MOD F.armModulus .B]) : x = P.c := by
  have hsig := F.localIncidenceSignature
  have hxcA : x ≡ P.c [MOD F.armModulus .A] :=
    hA.trans hsig.1.symm
  have hxcB : x ≡ P.c [MOD F.armModulus .B] :=
    hB.trans hsig.2.1.symm
  have hxc : x ≡ P.c [MOD F.armModulus .A * F.armModulus .B] :=
    (Nat.modEq_and_modEq_iff_modEq_mul F.coprime_modulus_AB).1 ⟨hxcA, hxcB⟩
  rw [Nat.ModEq, Nat.mod_eq_of_lt hx, Nat.mod_eq_of_lt hrec] at hxc
  exact hxc

/-- Product of the three top-face radical coordinates. -/
noncomputable def complexRadical (P : PrimitiveABC) : ℕ :=
  (full P).armRadical .A * (full P).armRadical .B *
    (full P).armRadical .C

/-- The complex radical is the ordinary radical of `abc`. -/
theorem complexRadical_eq_abcRadical (P : PrimitiveABC) :
    complexRadical P = abcRadical P := by
  rw [complexRadical, full_armRadical, full_armRadical, full_armRadical,
    abcRadical]
  simp only [coordinate]
  have habc : (P.a * P.b).Coprime P.c :=
    P.coprime_ac.mul_left P.coprime_bc
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp habc)]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp P.coprime_ab)]

/-- Exact rational-power half-space equation at the tropical top face.  It
rewrites the usual height target as a bound on the `C`-arm defect. -/
theorem cPower_le_complexRadical_iff_sumArmDefect
    (P : PrimitiveABC) (m n : ℕ) :
    P.c ^ m ≤ complexRadical P ^ (m + n) ↔
      (full P).armDefect .C ^ m ≤
        ((full P).armRadical .A * (full P).armRadical .B) ^ (m + n) *
          (full P).armRadical .C ^ n := by
  let RA := (full P).armRadical Arm.A
  let RB := (full P).armRadical Arm.B
  let RC := (full P).armRadical Arm.C
  let DC := (full P).armDefect Arm.C
  have hc : RC * DC = P.c := by
    dsimp [RC, DC]
    rw [full_armRadical]
    simpa [coordinate] using full_radical_mul_defect P Arm.C
  have hRCpos : 0 < RC := by
    dsimp [RC]
    rw [full_armRadical]
    exact Nat.radical_pos P.c
  constructor
  · intro h
    have hmul : RC ^ m * DC ^ m ≤
        RC ^ m * ((RA * RB) ^ (m + n) * RC ^ n) := by
      calc
        RC ^ m * DC ^ m = P.c ^ m := by rw [← hc, mul_pow]
        _ ≤ complexRadical P ^ (m + n) := h
        _ = RC ^ m * ((RA * RB) ^ (m + n) * RC ^ n) := by
          simp only [complexRadical, pow_add]
          dsimp [RA, RB, RC]
          ring
    exact Nat.le_of_mul_le_mul_left hmul (pow_pos hRCpos m)
  · intro h
    calc
      P.c ^ m = RC ^ m * DC ^ m := by rw [← hc, mul_pow]
      _ ≤ RC ^ m * ((RA * RB) ^ (m + n) * RC ^ n) :=
        Nat.mul_le_mul_left _ h
      _ = complexRadical P ^ (m + n) := by
        simp only [complexRadical, pow_add]
        dsimp [RA, RB, RC]
        ring

/-- Ordinary-abc-radical form of the same exact equivalence. -/
theorem cPower_le_abcRadical_iff_sumArmDefect
    (P : PrimitiveABC) (m n : ℕ) :
    P.c ^ m ≤ abcRadical P ^ (m + n) ↔
      (full P).armDefect .C ^ m ≤
        ((full P).armRadical .A * (full P).armRadical .B) ^ (m + n) *
          (full P).armRadical .C ^ n := by
  rw [← complexRadical_eq_abcRadical]
  exact cPower_le_complexRadical_iff_sumArmDefect P m n

/-- A bound witnessed already on the `A` and `B` radical coordinates of an
arbitrary filtered face is a sufficient condition for the usual rational-
power height bound.  This implication does not assert that such a face
exists. -/
theorem filteredFaceBound_forces_cPower (P : PrimitiveABC) (F : Face P)
    (m n : ℕ)
    (hface :
      (full P).armDefect .C ^ m ≤
        (F.armRadical .A * F.armRadical .B) ^ (m + n) *
          (full P).armRadical .C ^ n) :
    P.c ^ m ≤ abcRadical P ^ (m + n) := by
  have hA : F.armRadical .A ≤ (full P).armRadical .A :=
    F.armRadical_le_of_isSubface (F.isSubface_full) Arm.A
  have hB : F.armRadical .B ≤ (full P).armRadical .B :=
    F.armRadical_le_of_isSubface (F.isSubface_full) Arm.B
  have hpairs : F.armRadical .A * F.armRadical .B ≤
      (full P).armRadical .A * (full P).armRadical .B :=
    Nat.mul_le_mul hA hB
  apply (cPower_le_abcRadical_iff_sumArmDefect P m n).2
  calc
    (full P).armDefect .C ^ m ≤
        (F.armRadical .A * F.armRadical .B) ^ (m + n) *
          (full P).armRadical .C ^ n := hface
    _ ≤ ((full P).armRadical .A * (full P).armRadical .B) ^ (m + n) *
          (full P).armRadical .C ^ n :=
      Nat.mul_le_mul_right _ (Nat.pow_le_pow_left hpairs (m + n))

end Face

/-! ## A complete-premise six-vertex example -/

/-- The primitive triple `12 + 833 = 845`, with factorizations
`12 = 2^2 * 3`, `833 = 7^2 * 17`, and `845 = 5 * 13^2`. -/
def twelveEightThirtyThreeEightFortyFive : PrimitiveABC where
  a := 12
  b := 833
  c := 845
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- Exact support of the first witness arm. -/
theorem witness_primeFactors_A : (12 : ℕ).primeFactors = {2, 3} := by
  norm_num [Nat.primeFactors, Nat.primeFactorsList]

/-- Exact support of the second witness arm. -/
theorem witness_primeFactors_B : (833 : ℕ).primeFactors = {7, 17} := by
  norm_num [Nat.primeFactors, Nat.primeFactorsList]

/-- Exact support of the sum witness arm. -/
theorem witness_primeFactors_C : (845 : ℕ).primeFactors = {5, 13} := by
  norm_num [Nat.primeFactors, Nat.primeFactorsList]

theorem witness_valuation_A_two : (12 : ℕ).factorization 2 = 2 := by
  rw [show (12 : ℕ) = 2 ^ 2 * 3 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime (2 ^ 2) 3)]
  rw [(by norm_num : Nat.Prime 2).factorization_pow]
  rw [(by norm_num : Nat.Prime 3).factorization]
  simp

theorem witness_valuation_A_three : (12 : ℕ).factorization 3 = 1 := by
  rw [show (12 : ℕ) = 2 ^ 2 * 3 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime (2 ^ 2) 3)]
  rw [(by norm_num : Nat.Prime 2).factorization_pow]
  rw [(by norm_num : Nat.Prime 3).factorization]
  simp

theorem witness_valuation_B_seven : (833 : ℕ).factorization 7 = 2 := by
  rw [show (833 : ℕ) = 7 ^ 2 * 17 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime (7 ^ 2) 17)]
  rw [(by norm_num : Nat.Prime 7).factorization_pow]
  rw [(by norm_num : Nat.Prime 17).factorization]
  simp

theorem witness_valuation_B_seventeen : (833 : ℕ).factorization 17 = 1 := by
  rw [show (833 : ℕ) = 7 ^ 2 * 17 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime (7 ^ 2) 17)]
  rw [(by norm_num : Nat.Prime 7).factorization_pow]
  rw [(by norm_num : Nat.Prime 17).factorization]
  simp

theorem witness_valuation_C_five : (845 : ℕ).factorization 5 = 1 := by
  rw [show (845 : ℕ) = 5 * 13 ^ 2 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime 5 (13 ^ 2))]
  rw [(by norm_num : Nat.Prime 5).factorization]
  rw [(by norm_num : Nat.Prime 13).factorization_pow]
  simp

theorem witness_valuation_C_thirteen : (845 : ℕ).factorization 13 = 2 := by
  rw [show (845 : ℕ) = 5 * 13 ^ 2 by norm_num]
  rw [Nat.factorization_mul_apply_of_coprime
    (by norm_num : Nat.Coprime 5 (13 ^ 2))]
  rw [(by norm_num : Nat.Prime 5).factorization]
  rw [(by norm_num : Nat.Prime 13).factorization_pow]
  simp

/-- Exact radicals of the three witness coordinates. -/
theorem witness_coordinate_radicals :
    radical (12 : ℕ) = 6 ∧ radical (833 : ℕ) = 119 ∧
      radical (845 : ℕ) = 65 := by
  simp only [Nat.radical_eq_prod_primeFactors, witness_primeFactors_A,
    witness_primeFactors_B, witness_primeFactors_C]
  norm_num

/-- Explicit enumeration of the three arm labels. -/
theorem arm_univ : (Finset.univ : Finset Arm) = {.A, .B, .C} := by
  decide

/-- Its full incidence face has six labeled prime vertices. -/
theorem witness_full_vertexCount :
    (Face.full twelveEightThirtyThreeEightFortyFive).vertexCount = 6 := by
  rw [Face.vertexCount]
  rw [arm_univ]
  simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
    witness_primeFactors_A, witness_primeFactors_B, witness_primeFactors_C]

/-- The complete support is therefore a genuine five-dimensional simplex. -/
theorem witness_full_natDimension :
    (Face.full twelveEightThirtyThreeEightFortyFive).natDimension = 5 := by
  rw [Face.natDimension, witness_full_vertexCount]

theorem witness_armDefects :
    (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .A = 2 ∧
      (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .B = 7 ∧
      (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .C = 13 := by
  constructor
  · simp [Face.armDefect, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_A,
      witness_valuation_A_two, witness_valuation_A_three]
  constructor
  · simp [Face.armDefect, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_B,
      witness_valuation_B_seven, witness_valuation_B_seventeen]
  · simp [Face.armDefect, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_C,
      witness_valuation_C_five, witness_valuation_C_thirteen]

/-- Its top-face tropical point is
`((6,2), (119,7), (65,13))`. -/
theorem witness_full_tropicalPoint :
    (Face.full twelveEightThirtyThreeEightFortyFive).tropicalPoint =
      fun r => match r with
        | .A => (6, 2)
        | .B => (119, 7)
        | .C => (65, 13) := by
  funext r
  fin_cases r
  · change ((Face.full twelveEightThirtyThreeEightFortyFive).armRadical .A,
      (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .A) = (6, 2)
    rw [Face.full_armRadical, witness_armDefects.1]
    simp [coordinate, twelveEightThirtyThreeEightFortyFive,
      witness_coordinate_radicals.1]
  · change ((Face.full twelveEightThirtyThreeEightFortyFive).armRadical .B,
      (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .B) = (119, 7)
    rw [Face.full_armRadical, witness_armDefects.2.1]
    simp [coordinate, twelveEightThirtyThreeEightFortyFive,
      witness_coordinate_radicals.2.1]
  · change ((Face.full twelveEightThirtyThreeEightFortyFive).armRadical .C,
      (Face.full twelveEightThirtyThreeEightFortyFive).armDefect .C) = (65, 13)
    rw [Face.full_armRadical, witness_armDefects.2.2]
    simp [coordinate, twelveEightThirtyThreeEightFortyFive,
      witness_coordinate_radicals.2.2]

/-- Every arm in the witness has nontrivial radical defect.  Thus defect need
not be concentrated on one or two arms. -/
theorem witness_everyArm_defective :
    ∀ r, 1 < (Face.full twelveEightThirtyThreeEightFortyFive).armDefect r := by
  intro r
  fin_cases r
  · rw [witness_armDefects.1]
    norm_num
  · rw [witness_armDefects.2.1]
    norm_num
  · rw [witness_armDefects.2.2]
    norm_num

/-- Every arm of the witness contains two primes with different valuation
exponents.  This refutes a rank-one-per-arm or uniform-exponent shortcut. -/
theorem witness_everyArm_has_mixedValuation :
    ∀ r, ∃ p ∈ (Face.full twelveEightThirtyThreeEightFortyFive).support r,
      ∃ q ∈ (Face.full twelveEightThirtyThreeEightFortyFive).support r,
        Face.valuation twelveEightThirtyThreeEightFortyFive r p ≠
          Face.valuation twelveEightThirtyThreeEightFortyFive r q := by
  intro r
  fin_cases r
  · refine ⟨2, ?_, 3, ?_, ?_⟩
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_A]
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_A]
    · simp [Face.valuation, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_valuation_A_two, witness_valuation_A_three]
  · refine ⟨7, ?_, 17, ?_, ?_⟩
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_B]
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_B]
    · simp [Face.valuation, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_valuation_B_seven, witness_valuation_B_seventeen]
  · refine ⟨5, ?_, 13, ?_, ?_⟩
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_C]
    · simp [Face.full, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_C]
    · simp [Face.valuation, coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_valuation_C_five, witness_valuation_C_thirteen]

/-- The full face has defect degree one on each arm. -/
theorem witness_full_defectDegree :
    ∀ r, (Face.full twelveEightThirtyThreeEightFortyFive).defectDegree r = 1 := by
  intro r
  fin_cases r
  · simp [Face.defectDegree, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_A,
      witness_valuation_A_two, witness_valuation_A_three]
  · simp [Face.defectDegree, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_B,
      witness_valuation_B_seven, witness_valuation_B_seventeen]
  · simp [Face.defectDegree, Face.full, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_primeFactors_C,
      witness_valuation_C_five, witness_valuation_C_thirteen]

/-- Therefore the full six-vertex face enters exactly by the pointwise
one-budget and is absent from the zero-budget filtration. -/
theorem witness_full_oneBudget_not_zeroBudget :
    (Face.full twelveEightThirtyThreeEightFortyFive).IsBudgetFace (fun _ => 1) ∧
      ¬(Face.full twelveEightThirtyThreeEightFortyFive).IsBudgetFace
        (fun _ => 0) := by
  constructor
  · intro r
    rw [witness_full_defectDegree]
  · intro h
    have hA : 1 ≤ 0 := by
      simpa [witness_full_defectDegree] using h Arm.A
    omega

/-- The squarefree vertices alone form a three-vertex zero-budget face. -/
def witnessSquarefreeFace : Face twelveEightThirtyThreeEightFortyFive where
  support
    | .A => {3}
    | .B => {17}
    | .C => {5}
  support_subset := by
    intro r
    fin_cases r
    · simp [coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_A]
    · simp [coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_B]
    · simp [coordinate, twelveEightThirtyThreeEightFortyFive,
        witness_primeFactors_C]

theorem witnessSquarefreeFace_vertexCount :
    witnessSquarefreeFace.vertexCount = 3 := by
  rw [Face.vertexCount]
  rw [arm_univ]
  simp [witnessSquarefreeFace]

theorem witnessSquarefreeFace_zeroBudget :
    witnessSquarefreeFace.IsBudgetFace (fun _ => 0) := by
  intro r
  fin_cases r
  · simp [witnessSquarefreeFace, Face.defectDegree, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_valuation_A_three]
  · simp [witnessSquarefreeFace, Face.defectDegree, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_valuation_B_seventeen]
  · simp [witnessSquarefreeFace, Face.defectDegree, Face.valuation, coordinate,
      twelveEightThirtyThreeEightFortyFive, witness_valuation_C_five]

end ABCValuationIncidenceComplex20260903
end IUTThreeClosures
