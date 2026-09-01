/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Separation and entropy for one affine divisibility template

This file formalizes the elementary arithmetic and finite combinatorics in
`research/ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md`.

For two affine parameters, write `x = h - h'` and `y = k - k'`.  Membership
in one fixed divisibility template gives divisibilities of

* `x`,
* `x + C*y`, and
* `x + B*y`.

When all three differences are nonzero their absolute product gives a cubic
determinant bound.  When one difference is zero, the appropriate coprimality
hypotheses cancel the affine coefficient and give a two-modulus divisor of
`|y|`.  The theorem `threeForm_separated` combines precisely these four
cases.  The last part gives the cell-packing and finite-union cardinality
bounds, and checks the corrected `dU = 31` example showing that the
determinant inequality alone does not handle a zero difference.

No statement here closes the affine route.  The numerical example refutes
only the strengthening obtained by deleting the `dU ≤ XU` cap from the
separation theorem.
-/

namespace IUTThreeClosures
namespace AffineTemplateEntropy20260901

/-! ## Divisibility and absolute-value helpers -/

/-- Forgetting an integer cast takes an integral divisibility to divisibility
of the natural absolute value. -/
theorem nat_dvd_natAbs_of_intCast_dvd {m : ℕ} {z : ℤ}
    (h : (m : ℤ) ∣ z) :
    m ∣ z.natAbs := by
  rcases h with ⟨k, rfl⟩
  refine ⟨k.natAbs, ?_⟩
  simp [Int.natAbs_mul]

/-- The first zero branch: if `x = 0`, the two long-arm moduli divide
`C*y` and `B*y`; coefficient coprimality cancels `C` and `B`. -/
theorem zeroFirstFactor_cancellation
    {dV dW B C : ℕ} {x y : ℤ}
    (hVW : Nat.Coprime dV dW)
    (hVC : Nat.Coprime dV C) (hWB : Nat.Coprime dW B)
    (hx : x = 0)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y) :
    dV * dW ∣ y.natAbs := by
  have hVCyInt : (dV : ℤ) ∣ (C : ℤ) * y := by
    simpa [hx] using hV
  have hWByInt : (dW : ℤ) ∣ (B : ℤ) * y := by
    simpa [hx] using hW
  have hVCy : dV ∣ C * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hVCyInt
  have hWBy : dW ∣ B * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hWByInt
  exact hVW.mul_dvd_of_dvd_of_dvd
    (hVC.dvd_of_dvd_mul_left hVCy)
    (hWB.dvd_of_dvd_mul_left hWBy)

/-- The second zero branch: from `x + C*y = 0`, the remaining two forms
become multiples of `C*y` and `(C-B)*y`. -/
theorem zeroSecondFactor_cancellation
    {dU dW B C : ℕ} {x y : ℤ}
    (hBC : B ≤ C)
    (hUW : Nat.Coprime dU dW)
    (hUC : Nat.Coprime dU C)
    (hWCB : Nat.Coprime dW (C - B))
    (hzero : x + (C : ℤ) * y = 0)
    (hU : (dU : ℤ) ∣ x)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y) :
    dU * dW ∣ y.natAbs := by
  have hx : x = -(C : ℤ) * y := by
    linarith
  have hUCyInt : (dU : ℤ) ∣ (C : ℤ) * y := by
    rw [hx] at hU
    simpa only [dvd_neg, neg_mul] using hU
  have hWCBInt : (dW : ℤ) ∣ ((C - B : ℕ) : ℤ) * y := by
    have hCBcast : ((C - B : ℕ) : ℤ) = (C : ℤ) - (B : ℤ) := by
      exact Nat.cast_sub hBC
    rw [hx] at hW
    have hneg : -(C : ℤ) * y + (B : ℤ) * y =
        -(((C - B : ℕ) : ℤ) * y) := by
      rw [hCBcast]
      ring
    rw [hneg] at hW
    simpa only [dvd_neg] using hW
  have hUCy : dU ∣ C * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hUCyInt
  have hWCBy : dW ∣ (C - B) * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hWCBInt
  exact hUW.mul_dvd_of_dvd_of_dvd
    (hUC.dvd_of_dvd_mul_left hUCy)
    (hWCB.dvd_of_dvd_mul_left hWCBy)

/-- The third zero branch: from `x + B*y = 0`, the remaining two forms
become multiples of `B*y` and `(C-B)*y`. -/
theorem zeroThirdFactor_cancellation
    {dU dV B C : ℕ} {x y : ℤ}
    (hBC : B ≤ C)
    (hUV : Nat.Coprime dU dV)
    (hUB : Nat.Coprime dU B)
    (hVCB : Nat.Coprime dV (C - B))
    (hzero : x + (B : ℤ) * y = 0)
    (hU : (dU : ℤ) ∣ x)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y) :
    dU * dV ∣ y.natAbs := by
  have hx : x = -(B : ℤ) * y := by
    linarith
  have hUByInt : (dU : ℤ) ∣ (B : ℤ) * y := by
    rw [hx] at hU
    simpa only [dvd_neg, neg_mul] using hU
  have hVCBInt : (dV : ℤ) ∣ ((C - B : ℕ) : ℤ) * y := by
    have hCBcast : ((C - B : ℕ) : ℤ) = (C : ℤ) - (B : ℤ) := by
      exact Nat.cast_sub hBC
    rw [hx] at hV
    have hform : -(B : ℤ) * y + (C : ℤ) * y =
        ((C - B : ℕ) : ℤ) * y := by
      rw [hCBcast]
      ring
    rw [hform] at hV
    exact hV
  have hUBy : dU ∣ B * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hUByInt
  have hVCBy : dV ∣ (C - B) * y.natAbs := by
    simpa [Int.natAbs_mul] using
      nat_dvd_natAbs_of_intCast_dvd hVCBInt
  exact hUV.mul_dvd_of_dvd_of_dvd
    (hUB.dvd_of_dvd_mul_left hUBy)
    (hVCB.dvd_of_dvd_mul_left hVCBy)

/-! ## The cubic product and four-case separation -/

/-- Sup norm of the signed parameter difference. -/
def signedSupNorm (x y : ℤ) : ℕ := max x.natAbs y.natAbs

/-- Each affine difference is bounded by `(C+1)` times the sup norm. -/
theorem secondForm_natAbs_le
    {C : ℕ} (x y : ℤ) :
    (x + (C : ℤ) * y).natAbs ≤
      (C + 1) * signedSupNorm x y := by
  calc
    (x + (C : ℤ) * y).natAbs ≤
        x.natAbs + ((C : ℤ) * y).natAbs := Int.natAbs_add_le _ _
    _ = x.natAbs + C * y.natAbs := by
      simp only [Int.natAbs_mul, Int.natAbs_natCast]
    _ ≤ signedSupNorm x y + C * signedSupNorm x y := by
      exact Nat.add_le_add (Nat.le_max_left _ _)
        (Nat.mul_le_mul_left C (Nat.le_max_right _ _))
    _ = (C + 1) * signedSupNorm x y := by ring

/-- The shorter third affine form has the same `(C+1)` sup-norm bound. -/
theorem thirdForm_natAbs_le
    {B C : ℕ} (hBC : B ≤ C) (x y : ℤ) :
    (x + (B : ℤ) * y).natAbs ≤
      (C + 1) * signedSupNorm x y := by
  calc
    (x + (B : ℤ) * y).natAbs ≤
        (B + 1) * signedSupNorm x y := secondForm_natAbs_le x y
    _ ≤ (C + 1) * signedSupNorm x y := by
      exact Nat.mul_le_mul_right _ (Nat.add_le_add_right hBC 1)

/-- In the nonzero branch the product of the three template moduli is at
most the cubic product of the three affine differences, and hence at most
`(C+1)^2 H^3`.  Pairwise coprimality is not needed for this particular
estimate because each modulus divides a different factor. -/
theorem modulusProduct_dvd_affineDifferenceProduct
    {dU dV dW B C : ℕ} {x y : ℤ}
    (hU : (dU : ℤ) ∣ x)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y) :
    dU * dV * dW ∣
      x.natAbs * (x + (C : ℤ) * y).natAbs *
        (x + (B : ℤ) * y).natAbs := by
  exact Nat.mul_dvd_mul
    (Nat.mul_dvd_mul
      (nat_dvd_natAbs_of_intCast_dvd hU)
      (nat_dvd_natAbs_of_intCast_dvd hV))
    (nat_dvd_natAbs_of_intCast_dvd hW)

/-- In the nonzero branch the product of the three template moduli is at
most `(C+1)^2 H^3`. -/
theorem nonzero_cubicProduct_bound
    {dU dV dW B C : ℕ} {x y : ℤ}
    (hBC : B ≤ C)
    (hU : (dU : ℤ) ∣ x)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y)
    (hx : x ≠ 0)
    (hVzero : x + (C : ℤ) * y ≠ 0)
    (hWzero : x + (B : ℤ) * y ≠ 0) :
    dU * dV * dW ≤
      (C + 1) ^ 2 * (signedSupNorm x y) ^ 3 := by
  have hprodDvd : dU * dV * dW ∣
      x.natAbs * (x + (C : ℤ) * y).natAbs *
        (x + (B : ℤ) * y).natAbs :=
    modulusProduct_dvd_affineDifferenceProduct hU hV hW
  have hprodPos : 0 <
      x.natAbs * (x + (C : ℤ) * y).natAbs *
        (x + (B : ℤ) * y).natAbs := by
    exact mul_pos (mul_pos (Int.natAbs_pos.mpr hx)
      (Int.natAbs_pos.mpr hVzero)) (Int.natAbs_pos.mpr hWzero)
  have hfirst : x.natAbs ≤ signedSupNorm x y := Nat.le_max_left _ _
  have hsecond := secondForm_natAbs_le (C := C) x y
  have hthird := thirdForm_natAbs_le (B := B) (C := C) hBC x y
  calc
    dU * dV * dW ≤
        x.natAbs * (x + (C : ℤ) * y).natAbs *
          (x + (B : ℤ) * y).natAbs :=
      Nat.le_of_dvd hprodPos hprodDvd
    _ ≤ signedSupNorm x y *
        ((C + 1) * signedSupNorm x y) *
          ((C + 1) * signedSupNorm x y) := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hfirst hsecond) hthird
    _ = (C + 1) ^ 2 * (signedSupNorm x y) ^ 3 := by ring

/-- Abstract full separation theorem in its direct integer form.  It includes
the nonzero cubic branch and all three zero branches.  These four strict
integer bounds are exactly what follows from the paper's real threshold
`cubic, L*XU, L*XV, L*XW < T < dU*dV*dW`; no integral representative of
`T` is needed. -/
theorem threeForm_separated_of_direct_bounds
    {dU dV dW B C L XU XV XW : ℕ} {x y : ℤ}
    (hBC : B ≤ C)
    (hpair : x ≠ 0 ∨ y ≠ 0)
    (hUV : Nat.Coprime dU dV)
    (hUW : Nat.Coprime dU dW)
    (hVW : Nat.Coprime dV dW)
    (hVC : Nat.Coprime dV C) (hWB : Nat.Coprime dW B)
    (hUC : Nat.Coprime dU C)
    (hWCB : Nat.Coprime dW (C - B))
    (hUB : Nat.Coprime dU B)
    (hVCB : Nat.Coprime dV (C - B))
    (hU : (dU : ℤ) ∣ x)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y)
    (hUcap : dU ≤ XU) (hVcap : dV ≤ XV) (hWcap : dW ≤ XW)
    (hcubic : (C + 1) ^ 2 * L ^ 3 < dU * dV * dW)
    (hUthreshold : L * XU < dU * dV * dW)
    (hVthreshold : L * XV < dU * dV * dW)
    (hWthreshold : L * XW < dU * dV * dW) :
    L < signedSupNorm x y := by
  by_contra hnot
  have hHL : signedSupNorm x y ≤ L := Nat.le_of_not_gt hnot
  by_cases hx : x = 0
  · have hy : y ≠ 0 := by aesop
    have hdiv := zeroFirstFactor_cancellation hVW hVC hWB hx hV hW
    have hsmall : dV * dW ≤ signedSupNorm x y := by
      have hypos : 0 < y.natAbs := Int.natAbs_pos.mpr hy
      exact (Nat.le_of_dvd hypos hdiv).trans (Nat.le_max_right _ _)
    have hbound : dU * dV * dW ≤ L * XU := by
      calc
        dU * dV * dW = dU * (dV * dW) := by ring
        _ ≤ XU * L := Nat.mul_le_mul hUcap (hsmall.trans hHL)
        _ = L * XU := by ring
    omega
  by_cases hsecond : x + (C : ℤ) * y = 0
  · have hy : y ≠ 0 := by
      intro hy
      apply hx
      simpa [hy] using hsecond
    have hdiv := zeroSecondFactor_cancellation hBC hUW hUC hWCB
      hsecond hU hW
    have hsmall : dU * dW ≤ signedSupNorm x y := by
      have hypos : 0 < y.natAbs := Int.natAbs_pos.mpr hy
      exact (Nat.le_of_dvd hypos hdiv).trans (Nat.le_max_right _ _)
    have hbound : dU * dV * dW ≤ L * XV := by
      calc
        dU * dV * dW = dV * (dU * dW) := by ring
        _ ≤ XV * L := Nat.mul_le_mul hVcap (hsmall.trans hHL)
        _ = L * XV := by ring
    omega
  by_cases hthird : x + (B : ℤ) * y = 0
  · have hy : y ≠ 0 := by
      intro hy
      apply hx
      simpa [hy] using hthird
    have hdiv := zeroThirdFactor_cancellation hBC hUV hUB hVCB
      hthird hU hV
    have hsmall : dU * dV ≤ signedSupNorm x y := by
      have hypos : 0 < y.natAbs := Int.natAbs_pos.mpr hy
      exact (Nat.le_of_dvd hypos hdiv).trans (Nat.le_max_right _ _)
    have hbound : dU * dV * dW ≤ L * XW := by
      calc
        dU * dV * dW = dW * (dU * dV) := by ring
        _ ≤ XW * L := Nat.mul_le_mul hWcap (hsmall.trans hHL)
        _ = L * XW := by ring
    omega
  · have hcubound := nonzero_cubicProduct_bound hBC hU hV hW
      hx hsecond hthird
    have hpow : (signedSupNorm x y) ^ 3 ≤ L ^ 3 :=
      Nat.pow_le_pow_left hHL 3
    have hbound : dU * dV * dW ≤ (C + 1) ^ 2 * L ^ 3 :=
      hcubound.trans (Nat.mul_le_mul_left _ hpow)
    omega

/-- Natural-threshold wrapper for the direct theorem.  The mathematical
paper permits a real threshold; its two strict comparisons imply the direct
integer bounds above in exactly the same way. -/
theorem threeForm_separated
    {dU dV dW B C L T XU XV XW : ℕ} {x y : ℤ}
    (hBC : B ≤ C)
    (hpair : x ≠ 0 ∨ y ≠ 0)
    (hUV : Nat.Coprime dU dV)
    (hUW : Nat.Coprime dU dW)
    (hVW : Nat.Coprime dV dW)
    (hVC : Nat.Coprime dV C) (hWB : Nat.Coprime dW B)
    (hUC : Nat.Coprime dU C)
    (hWCB : Nat.Coprime dW (C - B))
    (hUB : Nat.Coprime dU B)
    (hVCB : Nat.Coprime dV (C - B))
    (hU : (dU : ℤ) ∣ x)
    (hV : (dV : ℤ) ∣ x + (C : ℤ) * y)
    (hW : (dW : ℤ) ∣ x + (B : ℤ) * y)
    (hUcap : dU ≤ XU) (hVcap : dV ≤ XV) (hWcap : dW ≤ XW)
    (hdet : T < dU * dV * dW)
    (hcubic : (C + 1) ^ 2 * L ^ 3 < T)
    (hUthreshold : L * XU < T)
    (hVthreshold : L * XV < T)
    (hWthreshold : L * XW < T) :
    L < signedSupNorm x y := by
  apply threeForm_separated_of_direct_bounds hBC hpair hUV hUW hVW
    hVC hWB hUC hWCB hUB hVCB hU hV hW hUcap hVcap hWcap
  · exact hcubic.trans hdet
  · exact hUthreshold.trans hdet
  · exact hVthreshold.trans hdet
  · exact hWthreshold.trans hdet

/-! ## Sup-cell packing -/

/-- Sup distance for pairs of natural parameters. -/
def pairSupDist (p q : ℕ × ℕ) : ℕ :=
  max (Nat.dist p.1 q.1) (Nat.dist p.2 q.2)

/-- Product cell of side length `L+1`. -/
def supCell (L : ℕ) (p : ℕ × ℕ) : ℕ × ℕ :=
  (p.1 / (L + 1), p.2 / (L + 1))

/-- Two natural numbers in the same length-`L+1` cell differ by at most
`L`. -/
theorem dist_le_of_same_cell {a b L : ℕ}
    (hcell : a / (L + 1) = b / (L + 1)) :
    Nat.dist a b ≤ L := by
  have hs : 0 < L + 1 := by omega
  have ha := Nat.mod_add_div a (L + 1)
  have hb := Nat.mod_add_div b (L + 1)
  have har := Nat.mod_lt a hs
  have hbr := Nat.mod_lt b hs
  rw [hcell] at ha
  by_cases hab : a ≤ b
  · rw [Nat.dist_eq_sub_of_le hab]
    omega
  · have hba : b ≤ a := Nat.le_of_not_ge hab
    rw [Nat.dist_comm, Nat.dist_eq_sub_of_le hba]
    omega

/-- Equality of product cells forces the two-coordinate sup distance to be
at most the cell parameter. -/
theorem pairSupDist_le_of_same_cell {p q : ℕ × ℕ} {L : ℕ}
    (hcell : supCell L p = supCell L q) :
    pairSupDist p q ≤ L := by
  have hfirst : p.1 / (L + 1) = q.1 / (L + 1) :=
    congrArg Prod.fst hcell
  have hsecond : p.2 / (L + 1) = q.2 / (L + 1) :=
    congrArg Prod.snd hcell
  exact (max_le_iff.mpr ⟨dist_le_of_same_cell hfirst,
    dist_le_of_same_cell hsecond⟩)

/-- A set separated by more than `L` has an injective cell map. -/
theorem supCell_injectiveOn_of_separated
    (S : Finset (ℕ × ℕ)) (L : ℕ)
    (hsep : ∀ p ∈ S, ∀ q ∈ S, p ≠ q → L < pairSupDist p q) :
    Set.InjOn (supCell L) (S : Set (ℕ × ℕ)) := by
  intro p hp q hq heq
  by_contra hpq
  have hfar := hsep p hp q hq hpq
  have hnear := pairSupDist_le_of_same_cell heq
  omega

/-- Sup-cell packing in the box `0 ≤ h,k ≤ M`.  The right side is the
paper's convenient upper bound `(M/(L+1)+1)^2`. -/
theorem supSeparated_card_le
    (S : Finset (ℕ × ℕ)) (M L : ℕ)
    (hbox : ∀ p ∈ S, p.1 ≤ M ∧ p.2 ≤ M)
    (hsep : ∀ p ∈ S, ∀ q ∈ S, p ≠ q → L < pairSupDist p q) :
    S.card ≤ (M / (L + 1) + 1) ^ 2 := by
  classical
  let cells : Finset (ℕ × ℕ) :=
    Finset.range (M / (L + 1) + 1) ×ˢ
      Finset.range (M / (L + 1) + 1)
  have hmaps : Set.MapsTo (supCell L) (S : Set (ℕ × ℕ))
      (cells : Set (ℕ × ℕ)) := by
    intro p hp
    rw [Finset.coe_product, Set.mem_prod, Finset.mem_coe,
      Finset.mem_range, Finset.mem_coe, Finset.mem_range]
    constructor
    · exact Nat.lt_succ_of_le (Nat.div_le_div_right (hbox p hp).1)
    · exact Nat.lt_succ_of_le (Nat.div_le_div_right (hbox p hp).2)
  have hcard := Finset.card_le_card_of_injOn (supCell L) hmaps
    (supCell_injectiveOn_of_separated S L hsep)
  simpa [cells, pow_two] using hcard

/-! ## Finite-union entropy -/

/-- A union of `N` templates of cardinality at most `K` has cardinality at
most `N*K`, with no disjointness hypothesis. -/
theorem finiteTemplateUnion_card_le
    {ι α : Type*} [DecidableEq α]
    (I : Finset ι) (template : ι → Finset α) (K : ℕ)
    (hcard : ∀ i ∈ I, (template i).card ≤ K) :
    (I.biUnion template).card ≤ I.card * K := by
  calc
    (I.biUnion template).card ≤ ∑ i ∈ I, (template i).card :=
      Finset.card_biUnion_le
    _ ≤ ∑ _i ∈ I, K := by
      exact Finset.sum_le_sum fun i hi ↦ hcard i hi
    _ = I.card * K := by simp

/-- Consequently a lower bound for the covered set forces the corresponding
product lower bound for the number and size of templates. -/
theorem finiteTemplateUnion_entropy
    {ι α : Type*} [DecidableEq α]
    (I : Finset ι) (template : ι → Finset α) (K target : ℕ)
    (hcard : ∀ i ∈ I, (template i).card ≤ K)
    (hcovered : target ≤ (I.biUnion template).card) :
    target ≤ I.card * K :=
  hcovered.trans (finiteTemplateUnion_card_le I template K hcard)

/-! ## Canonical affine constants -/

/-- The subcritical assumptions `6 ≤ c` and `R < c` imply the ratio bound
used in the constant-12 packing estimate. -/
theorem radical_ratio_bound {c R : ℕ} (hc : 6 ≤ c) (hR : R < c) :
    36 * R ≤ 5 * c ^ 2 := by
  by_cases hc8 : 8 ≤ c
  · have h36 : 36 ≤ 5 * c := by omega
    calc
      36 * R ≤ 36 * c := Nat.mul_le_mul_left 36 hR.le
      _ ≤ (5 * c) * c := Nat.mul_le_mul_right c h36
      _ = 5 * c ^ 2 := by ring
  · have hcCases : c = 6 ∨ c = 7 := by omega
    rcases hcCases with rfl | rfl <;> norm_num at hR ⊢ <;> omega

/-- Exact cross-multiplied cubic threshold for
`L = floor (c^4/13)`.  The premise `6 ≤ R` is automatic for the primitive
positive seed in the paper. -/
theorem canonical_cubicThreshold_scale13 {c R : ℕ}
    (hc : 6 ≤ c) (hR : 6 ≤ R) :
    8192 * (c + 1) ^ 2 * (c ^ 4 / 13) ^ 3 < R * c ^ 14 := by
  let L := c ^ 4 / 13
  have hside : 6 * (c + 1) ≤ 7 * c := by omega
  have hsidesq : (6 * (c + 1)) ^ 2 ≤ (7 * c) ^ 2 :=
    Nat.pow_le_pow_left hside 2
  have hL : 13 * L ≤ c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hL3 : (13 * L) ^ 3 ≤ (c ^ 4) ^ 3 :=
    Nat.pow_le_pow_left hL 3
  have hprod :
      (6 * (c + 1)) ^ 2 * (13 * L) ^ 3 ≤
        (7 * c) ^ 2 * (c ^ 4) ^ 3 :=
    Nat.mul_le_mul hsidesq hL3
  have hcore : 36 * 13 ^ 3 * ((c + 1) ^ 2 * L ^ 3) ≤
      49 * c ^ 14 := by
    nlinarith [hprod]
  have hconst : 49 * 8192 < 36 * 13 ^ 3 * R := by
    nlinarith
  have hc14pos : 0 < c ^ 14 := pow_pos (by omega) _
  have hconstScaled : (49 * 8192) * c ^ 14 <
      (36 * 13 ^ 3 * R) * c ^ 14 :=
    (Nat.mul_lt_mul_right hc14pos).2 hconst
  have hleft : (36 * 13 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) ≤
      (49 * 8192) * c ^ 14 := by
    nlinarith [hcore]
  have hchain : (36 * 13 ^ 3) *
      (8192 * ((c + 1) ^ 2 * L ^ 3)) <
      (36 * 13 ^ 3) * (R * c ^ 14) := by
    calc
      _ ≤ (49 * 8192) * c ^ 14 := hleft
      _ < (36 * 13 ^ 3 * R) * c ^ 14 := hconstScaled
      _ = (36 * 13 ^ 3) * (R * c ^ 14) := by ring
  have hfactor : 0 < 36 * 13 ^ 3 := by norm_num
  exact (Nat.mul_lt_mul_left hfactor).1
    (by simpa [L, mul_assoc] using hchain)

/-- Exact cross-multiplied weakest size-cap threshold. -/
theorem canonical_longCapThreshold_scale13 {c R : ℕ}
    (hc : 6 ≤ c) (hR : 6 ≤ R) :
    8192 * (c ^ 4 / 13) * c ^ 7 < R * c ^ 14 := by
  let L := c ^ 4 / 13
  have hL : 13 * L ≤ c ^ 4 := by
    dsimp [L]
    exact Nat.mul_div_le _ _
  have hc3 : 6 ^ 3 ≤ c ^ 3 := Nat.pow_le_pow_left hc 3
  have hconst : 8192 < 13 * R * c ^ 3 := by
    nlinarith
  have hc11pos : 0 < c ^ 11 := pow_pos (by omega) _
  have hconstScaled : 8192 * c ^ 11 <
      (13 * R * c ^ 3) * c ^ 11 :=
    (Nat.mul_lt_mul_right hc11pos).2 hconst
  have hleft : 13 * (8192 * L * c ^ 7) ≤ 8192 * c ^ 11 := by
    calc
      13 * (8192 * L * c ^ 7) = 8192 * (13 * L) * c ^ 7 := by ring
      _ ≤ 8192 * c ^ 4 * c ^ 7 :=
        Nat.mul_le_mul_right (c ^ 7) (Nat.mul_le_mul_left 8192 hL)
      _ = 8192 * c ^ 11 := by ring
  have hchain : 13 * (8192 * L * c ^ 7) <
      13 * (R * c ^ 14) := by
    calc
      _ ≤ 8192 * c ^ 11 := hleft
      _ < (13 * R * c ^ 3) * c ^ 11 := hconstScaled
      _ = 13 * (R * c ^ 14) := by ring
  exact (Nat.mul_lt_mul_left (by norm_num : 0 < 13)).1
    (by simpa [L] using hchain)

/-- The rational estimate
`(13/4 + R/c^2)^2 < 12`, encoded without division. -/
theorem canonical_cellConstant_twelve {c R cells : ℕ}
    (hratio : 36 * R ≤ 5 * c ^ 2)
    (hcell : 4 * (cells * R) < 13 * c ^ 2 + 4 * R) :
    cells ^ 2 * R ^ 2 < 12 * c ^ 4 := by
  have hscaled : 18 * (13 * c ^ 2 + 4 * R) ≤ 244 * c ^ 2 := by
    nlinarith
  have hlinear : 72 * (cells * R) < 244 * c ^ 2 := by
    nlinarith
  have hhalf : 36 * (cells * R) < 122 * c ^ 2 := by omega
  have hsquare : (36 * (cells * R)) ^ 2 < (122 * c ^ 2) ^ 2 :=
    Nat.pow_lt_pow_left hhalf (by norm_num)
  have hconst : 3721 < 12 * 324 := by norm_num
  nlinarith [hsquare]

/-- Composition of a cell-cardinality bound with the constant-12 arithmetic
estimate.  The separate box lemma supplies `hcard`, while the elementary
floor comparison supplies `hcell`. -/
theorem canonical_templateCard_mul_radicalSq_lt
    (S : Finset (ℕ × ℕ)) {c R cells : ℕ}
    (hcard : S.card ≤ cells ^ 2)
    (hratio : 36 * R ≤ 5 * c ^ 2)
    (hcell : 4 * (cells * R) < 13 * c ^ 2 + 4 * R) :
    S.card * R ^ 2 < 12 * c ^ 4 := by
  exact (Nat.mul_le_mul_right (R ^ 2) hcard).trans_lt
    (canonical_cellConstant_twelve hratio hcell)

/-- Canonical parameter-box side length. -/
def canonicalBoxM (c R : ℕ) : ℕ := c ^ 6 / (4 * R)

/-- Enlarged separation scale used in the sharpened paper theorem. -/
def canonicalSeparationL (c : ℕ) : ℕ := c ^ 4 / 13

/-- Number of coordinate cells in the convenient floor-plus-one packing
bound. -/
def canonicalCellCount (c R : ℕ) : ℕ :=
  canonicalBoxM c R / (canonicalSeparationL c + 1) + 1

/-- Exact floor arithmetic behind
`M/(L+1) + 1 < 13*c^2/(4*R) + 1`. -/
theorem canonicalCellCount_scaled_lt {c R : ℕ}
    (hc : 1 ≤ c) (hR : 0 < R) :
    4 * (canonicalCellCount c R * R) < 13 * c ^ 2 + 4 * R := by
  let M := c ^ 6 / (4 * R)
  let L := c ^ 4 / 13
  let q := M / (L + 1)
  have hM : (4 * R) * M ≤ c ^ 6 := by
    dsimp [M]
    exact Nat.mul_div_le _ _
  have hq : q * (L + 1) ≤ M := by
    dsimp [q]
    exact Nat.div_mul_le_self _ _
  have hqscaled : (4 * q * R) * (L + 1) ≤ c ^ 6 := by
    calc
      (4 * q * R) * (L + 1) = (4 * R) * (q * (L + 1)) := by ring
      _ ≤ (4 * R) * M := Nat.mul_le_mul_left _ hq
      _ ≤ c ^ 6 := hM
  have hL : c ^ 4 < 13 * (L + 1) := by
    simpa [L] using Nat.lt_mul_div_succ (c ^ 4) (by norm_num : 0 < 13)
  by_cases hq0 : q = 0
  · change 4 * ((q + 1) * R) < 13 * c ^ 2 + 4 * R
    rw [hq0]
    have hc2 : 0 < c ^ 2 := pow_pos (by omega) _
    nlinarith
  have hfactor : 0 < 4 * q * R := by positivity
  have hLscaled : (4 * q * R) * c ^ 4 <
      (4 * q * R) * (13 * (L + 1)) :=
    (Nat.mul_lt_mul_left hfactor).2 hL
  have hchain : (4 * q * R) * c ^ 4 < 13 * c ^ 6 := by
    calc
      _ < (4 * q * R) * (13 * (L + 1)) := hLscaled
      _ = 13 * ((4 * q * R) * (L + 1)) := by ring
      _ ≤ 13 * c ^ 6 := Nat.mul_le_mul_left 13 hqscaled
  have hc4 : 0 < c ^ 4 := pow_pos (by omega) _
  have hcancel : 4 * q * R < 13 * c ^ 2 := by
    apply (Nat.mul_lt_mul_right hc4).1
    calc
      (4 * q * R) * c ^ 4 < 13 * c ^ 6 := hchain
      _ = (13 * c ^ 2) * c ^ 4 := by ring
  change 4 * ((q + 1) * R) < 13 * c ^ 2 + 4 * R
  nlinarith

/-- Fully composed canonical packing constant: a set in the canonical box
separated by more than `floor(c^4/13)` satisfies the paper's strict
cross-multiplied bound `|S| R^2 < 12 c^4`. -/
theorem canonical_supSeparated_card_mul_radicalSq_lt
    (S : Finset (ℕ × ℕ)) {c R : ℕ}
    (hc : 6 ≤ c) (hRpos : 0 < R) (hRsub : R < c)
    (hbox : ∀ p ∈ S,
      p.1 ≤ canonicalBoxM c R ∧ p.2 ≤ canonicalBoxM c R)
    (hsep : ∀ p ∈ S, ∀ q ∈ S, p ≠ q →
      canonicalSeparationL c < pairSupDist p q) :
    S.card * R ^ 2 < 12 * c ^ 4 := by
  have hcard : S.card ≤ (canonicalCellCount c R) ^ 2 := by
    simpa [canonicalCellCount] using
      supSeparated_card_le S (canonicalBoxM c R)
        (canonicalSeparationL c) hbox hsep
  exact canonical_templateCard_mul_radicalSq_lt S hcard
    (radical_ratio_bound hc hRsub)
    (canonicalCellCount_scaled_lt (by omega) hRpos)

/-! ## Exact determinant-only counterexample -/

def affineU (Q : ℕ) (p : ℕ × ℕ) : ℕ := 1 + Q * p.1

def affineV (Q C : ℕ) (p : ℕ × ℕ) : ℕ :=
  1 + Q * (p.1 + C * p.2)

def affineW (Q B : ℕ) (p : ℕ × ℕ) : ℕ :=
  1 + Q * (p.1 + B * p.2)

/-- Cancel the common affine step from a signed divisibility when the
template modulus is coprime to that step. -/
theorem cancel_coprime_affineStep {d Q : ℕ} {z : ℤ}
    (hcop : Nat.Coprime d Q) (h : (d : ℤ) ∣ (Q : ℤ) * z) :
    (d : ℤ) ∣ z := by
  have hnat : d ∣ Q * z.natAbs := by
    have habs : d ∣ ((Q : ℤ) * z).natAbs :=
      nat_dvd_natAbs_of_intCast_dvd h
    simpa [Int.natAbs_mul] using habs
  have hz : d ∣ z.natAbs := hcop.dvd_of_dvd_mul_left hnat
  exact Int.dvd_natAbs.1 (Int.natCast_dvd_natCast.2 hz)

/-- Two members of one affine template give precisely the three signed
difference divisibilities used by the separation theorem.  This is the
paper's cancellation of the common radical step `Q`. -/
theorem affineTemplate_membership_gives_differenceDivisibilities
    {Q dU dV dW B C : ℕ} {p q : ℕ × ℕ}
    (hUQ : Nat.Coprime dU Q)
    (hVQ : Nat.Coprime dV Q)
    (hWQ : Nat.Coprime dW Q)
    (hUp : dU ∣ affineU Q p) (hUq : dU ∣ affineU Q q)
    (hVp : dV ∣ affineV Q C p) (hVq : dV ∣ affineV Q C q)
    (hWp : dW ∣ affineW Q B p) (hWq : dW ∣ affineW Q B q) :
    (dU : ℤ) ∣ (p.1 : ℤ) - q.1 ∧
      (dV : ℤ) ∣ ((p.1 : ℤ) - q.1) +
        (C : ℤ) * ((p.2 : ℤ) - q.2) ∧
      (dW : ℤ) ∣ ((p.1 : ℤ) - q.1) +
        (B : ℤ) * ((p.2 : ℤ) - q.2) := by
  have diff_dvd {d n m : ℕ} (hn : d ∣ n) (hm : d ∣ m) :
      (d : ℤ) ∣ (n : ℤ) - m := by
    exact dvd_sub (by exact_mod_cast hn) (by exact_mod_cast hm)
  constructor
  · apply cancel_coprime_affineStep hUQ
    have hd := diff_dvd hUp hUq
    have heq : ((affineU Q p : ℕ) : ℤ) - affineU Q q =
        (Q : ℤ) * ((p.1 : ℤ) - q.1) := by
      simp only [affineU, Nat.cast_add, Nat.cast_one, Nat.cast_mul]
      ring
    rw [heq] at hd
    exact hd
  constructor
  · apply cancel_coprime_affineStep hVQ
    have hd := diff_dvd hVp hVq
    have heq : ((affineV Q C p : ℕ) : ℤ) - affineV Q C q =
        (Q : ℤ) * (((p.1 : ℤ) - q.1) +
          (C : ℤ) * ((p.2 : ℤ) - q.2)) := by
      simp only [affineV, Nat.cast_add, Nat.cast_one, Nat.cast_mul]
      ring
    rw [heq] at hd
    exact hd
  · apply cancel_coprime_affineStep hWQ
    have hd := diff_dvd hWp hWq
    have heq : ((affineW Q B p : ℕ) : ℤ) - affineW Q B q =
        (Q : ℤ) * (((p.1 : ℤ) - q.1) +
          (B : ℤ) * ((p.2 : ℤ) - q.2)) := by
      simp only [affineW, Nat.cast_add, Nat.cast_one, Nat.cast_mul]
      ring
    rw [heq] at hd
    exact hd

/-- The corrected `dU=31` example.  Every coprimality and template premise
of determinant-only separation holds, `D=31>9`, but the two points have sup
distance one. -/
theorem determinantOnlySeparation_counterexample :
    let B : ℕ := 1
    let C : ℕ := 2
    let L : ℕ := 1
    let T : ℕ := 10
    let dU : ℕ := 31
    let dV : ℕ := 1
    let dW : ℕ := 1
    let XU : ℕ := 1
    let XV : ℕ := 1
    let XW : ℕ := 1
    let Q : ℕ := 1
    let p : ℕ × ℕ := (30, 1)
    let q : ℕ × ℕ := (30, 2)
    p ≠ q ∧ B < C ∧
      Nat.Coprime dU dV ∧ Nat.Coprime dU dW ∧ Nat.Coprime dV dW ∧
      Nat.Coprime dV C ∧ Nat.Coprime dW B ∧
      Nat.Coprime dU C ∧ Nat.Coprime dW (C - B) ∧
      Nat.Coprime dU B ∧ Nat.Coprime dV (C - B) ∧
      dU ∣ affineU Q p ∧ dU ∣ affineU Q q ∧
      dV ∣ affineV Q C p ∧ dV ∣ affineV Q C q ∧
      dW ∣ affineW Q B p ∧ dW ∣ affineW Q B q ∧
      T < dU * dV * dW ∧ (C + 1) ^ 2 * L ^ 3 < T ∧
      dV ≤ XV ∧ dW ≤ XW ∧
      L * XU < T ∧ L * XV < T ∧ L * XW < T ∧
      ¬dU ≤ XU ∧
      pairSupDist p q = L := by
  have hdist : Nat.dist 1 2 = 1 := by
    rw [Nat.dist_eq_sub_of_le (by norm_num : 1 ≤ 2)]
  norm_num [affineU, affineV, affineW, pairSupDist, hdist]

/-- Written directly in the variables of `threeForm_separated`, the same
example satisfies every premise except `dU ≤ XU`, while its asserted strict
separation is false.  Thus this is a counterexample to deleting only that
one cap hypothesis. -/
theorem omitting_Ucap_breaks_threeForm_separation :
    let B : ℕ := 1
    let C : ℕ := 2
    let L : ℕ := 1
    let T : ℕ := 10
    let dU : ℕ := 31
    let dV : ℕ := 1
    let dW : ℕ := 1
    let XU : ℕ := 1
    let XV : ℕ := 1
    let XW : ℕ := 1
    let x : ℤ := 0
    let y : ℤ := -1
    B ≤ C ∧ (x ≠ 0 ∨ y ≠ 0) ∧
      Nat.Coprime dU dV ∧ Nat.Coprime dU dW ∧ Nat.Coprime dV dW ∧
      Nat.Coprime dV C ∧ Nat.Coprime dW B ∧
      Nat.Coprime dU C ∧ Nat.Coprime dW (C - B) ∧
      Nat.Coprime dU B ∧ Nat.Coprime dV (C - B) ∧
      (dU : ℤ) ∣ x ∧
      (dV : ℤ) ∣ x + (C : ℤ) * y ∧
      (dW : ℤ) ∣ x + (B : ℤ) * y ∧
      dV ≤ XV ∧ dW ≤ XW ∧
      T < dU * dV * dW ∧
      (C + 1) ^ 2 * L ^ 3 < T ∧
      L * XU < T ∧ L * XV < T ∧ L * XW < T ∧
      ¬dU ≤ XU ∧
      ¬L < signedSupNorm x y := by
  norm_num [signedSupNorm]

#print axioms zeroFirstFactor_cancellation
#print axioms zeroSecondFactor_cancellation
#print axioms zeroThirdFactor_cancellation
#print axioms nat_dvd_natAbs_of_intCast_dvd
#print axioms modulusProduct_dvd_affineDifferenceProduct
#print axioms nonzero_cubicProduct_bound
#print axioms secondForm_natAbs_le
#print axioms thirdForm_natAbs_le
#print axioms threeForm_separated_of_direct_bounds
#print axioms threeForm_separated
#print axioms dist_le_of_same_cell
#print axioms pairSupDist_le_of_same_cell
#print axioms supCell_injectiveOn_of_separated
#print axioms supSeparated_card_le
#print axioms finiteTemplateUnion_entropy
#print axioms finiteTemplateUnion_card_le
#print axioms radical_ratio_bound
#print axioms canonical_cubicThreshold_scale13
#print axioms canonical_longCapThreshold_scale13
#print axioms canonical_cellConstant_twelve
#print axioms canonical_templateCard_mul_radicalSq_lt
#print axioms canonicalCellCount_scaled_lt
#print axioms canonical_supSeparated_card_mul_radicalSq_lt
#print axioms cancel_coprime_affineStep
#print axioms affineTemplate_membership_gives_differenceDivisibilities
#print axioms determinantOnlySeparation_counterexample
#print axioms omitting_Ucap_breaks_threeForm_separation

end AffineTemplateEntropy20260901
end IUTThreeClosures
