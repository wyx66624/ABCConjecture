/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineExcessUpperBound20260831
import IUTThreeClosures.ABCTwoPrimeSupport20260831
import IUTThreeClosures.GeometryGlobalUniformGate20260830
import Mathlib.Data.Nat.PrimeFin

/-!
# The radical-step affine shear

The mathematical proofs formalized here precede this file in
`research/ABC_AFFINE_MATCHING_LOWER_GATE_2026_09_01.md`.

The old affine shear used the full seed product as its step.  Its elementary
arithmetic needs only a positive modulus containing every prime in the seed
product.  This file proves that generalization, including all three pair
injections and the primitive `ABCPoint` output.  It also proves that replacing
a minimal step `R` by a multiple `s * R` merely embeds the parameters into the
`R`-fibre by `(h,k) |-> (s*h,s*k)`.

The final section isolates the exact quantifier logic of the matching-lower
gate in a purely natural-number interface.  No analytic counting estimate is
postulated: an upper bound and divergence of the supplied growth function are
explicit hypotheses.  Conversely, bounded height makes an eventual lower
statement vacuous.
-/

namespace IUTThreeClosures
namespace AffineRadicalStep20260901

/-- The seed type already used by the original affine-shear module. -/
abbrev Seed := AffineShearAmplification20260831.Seed

/-- A positive shear modulus whose prime support contains the support of the
seed product.  Full prime powers of the seed need not divide `Q`. -/
structure SupportModulus (S : Seed) where
  Q : ℕ
  Q_pos : 0 < Q
  support : ∀ {p : ℕ}, p.Prime → p ∣ S.P → p ∣ Q

namespace SupportModulus

variable {S : Seed}

/-- Divisibility by the usual radical supplies exactly the support condition. -/
def of_radical_dvd (S : Seed) {Q : ℕ} (hQ : 0 < Q)
    (hrad : abcRadical S.P ∣ Q) : SupportModulus S where
  Q := Q
  Q_pos := hQ
  support := by
    intro p hp hpP
    have hP0 : S.P ≠ 0 := Nat.ne_of_gt S.P_pos
    have hmem : p ∈ S.P.primeFactors := hp.mem_primeFactors hpP hP0
    have hpRad : p ∣ abcRadical S.P := by
      exact Finset.dvd_prod_of_mem (fun q : ℕ => q) hmem
    exact hpRad.trans hrad

/-- First cofactor for a support-killing modulus. -/
def U (M : SupportModulus S) (h : ℕ) : ℕ := 1 + M.Q * h

/-- Second cofactor for a support-killing modulus. -/
def V (M : SupportModulus S) (h k : ℕ) : ℕ :=
  1 + M.Q * (h + S.c * k)

/-- Third cofactor for a support-killing modulus. -/
def W (M : SupportModulus S) (h k : ℕ) : ℕ :=
  1 + M.Q * (h + S.b * k)

/-- Every cofactor-shaped integer is coprime to the chosen modulus. -/
theorem one_add_Q_mul_coprime_Q (M : SupportModulus S) (x : ℕ) :
    Nat.Coprime (1 + M.Q * x) M.Q := by
  rw [Nat.mul_comm M.Q x]
  exact (Nat.coprime_add_mul_right_left (m := 1) (n := M.Q) (k := x)).2
    (Nat.coprime_one_left M.Q)

theorem U_coprime_Q (M : SupportModulus S) (h : ℕ) :
    Nat.Coprime (M.U h) M.Q := M.one_add_Q_mul_coprime_Q h

theorem V_coprime_Q (M : SupportModulus S) (h k : ℕ) :
    Nat.Coprime (M.V h k) M.Q :=
  M.one_add_Q_mul_coprime_Q (h + S.c * k)

theorem W_coprime_Q (M : SupportModulus S) (h k : ℕ) :
    Nat.Coprime (M.W h k) M.Q :=
  M.one_add_Q_mul_coprime_Q (h + S.b * k)

/-- A number congruent to one modulo every seed prime is coprime to the seed
product. -/
theorem one_add_Q_mul_coprime_P (M : SupportModulus S) (x : ℕ) :
    Nat.Coprime (1 + M.Q * x) S.P := by
  apply Nat.coprime_of_dvd
  intro p hp hpU hpP
  have hpQ : p ∣ M.Q := M.support hp hpP
  have hpQx : p ∣ M.Q * x := dvd_mul_of_dvd_left hpQ x
  have hpOne : p ∣ 1 := (Nat.dvd_add_iff_left hpQx).2 hpU
  exact hp.not_dvd_one hpOne

theorem U_coprime_P (M : SupportModulus S) (h : ℕ) :
    Nat.Coprime (M.U h) S.P := M.one_add_Q_mul_coprime_P h

theorem V_coprime_P (M : SupportModulus S) (h k : ℕ) :
    Nat.Coprime (M.V h k) S.P :=
  M.one_add_Q_mul_coprime_P (h + S.c * k)

theorem W_coprime_P (M : SupportModulus S) (h k : ℕ) :
    Nat.Coprime (M.W h k) S.P :=
  M.one_add_Q_mul_coprime_P (h + S.b * k)

/-- Exact difference identity for `V-U`. -/
theorem V_eq_U_add (M : SupportModulus S) (h k : ℕ) :
    M.V h k = M.U h + M.Q * S.c * k := by
  simp [V, U]
  ring

/-- Exact difference identity for `W-U`. -/
theorem W_eq_U_add (M : SupportModulus S) (h k : ℕ) :
    M.W h k = M.U h + M.Q * S.b * k := by
  simp [W, U]
  ring

/-- Exact difference identity for `V-W`. -/
theorem V_eq_W_add (M : SupportModulus S) (h k : ℕ) :
    M.V h k = M.W h k + M.Q * S.a * k := by
  change 1 + M.Q * (h + S.c * k) =
    1 + M.Q * (h + S.b * k) + M.Q * S.a * k
  rw [← S.sum_eq]
  ring

/-- The generalized shear preserves the additive equation. -/
theorem shear_equation (M : SupportModulus S) (h k : ℕ) :
    S.a * M.U h + S.b * M.V h k = S.c * M.W h k := by
  change S.a * (1 + M.Q * h) +
    S.b * (1 + M.Q * (h + S.c * k)) =
      S.c * (1 + M.Q * (h + S.b * k))
  rw [← S.sum_eq]
  ring

/-- A positive admissible parameter pair for the generalized shear. -/
structure Parameter (M : SupportModulus S) where
  h : ℕ
  k : ℕ
  h_pos : 0 < h
  k_pos : 0 < k
  admissible : Nat.Coprime (M.U h) k

namespace Parameter

variable {M : SupportModulus S}

theorem V_coprime_k (q : Parameter M) :
    Nat.Coprime (M.V q.h q.k) q.k := by
  rw [M.V_eq_U_add]
  simpa [Nat.mul_assoc] using
    (Nat.coprime_add_mul_right_left
      (m := M.U q.h) (n := q.k) (k := M.Q * S.c)).2 q.admissible

theorem W_coprime_k (q : Parameter M) :
    Nat.Coprime (M.W q.h q.k) q.k := by
  rw [M.W_eq_U_add]
  simpa [Nat.mul_assoc] using
    (Nat.coprime_add_mul_right_left
      (m := M.U q.h) (n := q.k) (k := M.Q * S.b)).2 q.admissible

/-- The first two cofactors are coprime. -/
theorem U_coprime_V (q : Parameter M) :
    Nat.Coprime (M.U q.h) (M.V q.h q.k) := by
  have hUQ : Nat.Coprime (M.U q.h) M.Q := M.U_coprime_Q q.h
  have hUc : Nat.Coprime (M.U q.h) S.c :=
    (M.U_coprime_P q.h).of_dvd_right S.c_dvd_P
  have hUdiff : Nat.Coprime (M.U q.h) (M.Q * S.c * q.k) :=
    (hUQ.mul_right hUc).mul_right q.admissible
  rw [M.V_eq_U_add, Nat.coprime_self_add_right]
  exact hUdiff

/-- The first and third cofactors are coprime. -/
theorem U_coprime_W (q : Parameter M) :
    Nat.Coprime (M.U q.h) (M.W q.h q.k) := by
  have hUQ : Nat.Coprime (M.U q.h) M.Q := M.U_coprime_Q q.h
  have hUb : Nat.Coprime (M.U q.h) S.b :=
    (M.U_coprime_P q.h).of_dvd_right S.b_dvd_P
  have hUdiff : Nat.Coprime (M.U q.h) (M.Q * S.b * q.k) :=
    (hUQ.mul_right hUb).mul_right q.admissible
  rw [M.W_eq_U_add, Nat.coprime_self_add_right]
  exact hUdiff

/-- The second and third cofactors are coprime. -/
theorem V_coprime_W (q : Parameter M) :
    Nat.Coprime (M.V q.h q.k) (M.W q.h q.k) := by
  have hWQ : Nat.Coprime (M.W q.h q.k) M.Q := M.W_coprime_Q q.h q.k
  have hWa : Nat.Coprime (M.W q.h q.k) S.a :=
    (M.W_coprime_P q.h q.k).of_dvd_right S.a_dvd_P
  have hWdiff : Nat.Coprime (M.W q.h q.k) (M.Q * S.a * q.k) :=
    (hWQ.mul_right hWa).mul_right q.W_coprime_k
  rw [M.V_eq_W_add, Nat.coprime_self_add_left]
  exact hWdiff.symm

/-- First scaled endpoint. -/
def A (q : Parameter M) : ℕ := S.a * M.U q.h

/-- Second scaled endpoint. -/
def B (q : Parameter M) : ℕ := S.b * M.V q.h q.k

/-- Third scaled endpoint. -/
def C (q : Parameter M) : ℕ := S.c * M.W q.h q.k

@[simp] theorem A_pos (q : Parameter M) : 0 < q.A :=
  mul_pos S.a_pos (by simp [SupportModulus.U])

@[simp] theorem B_pos (q : Parameter M) : 0 < q.B :=
  mul_pos S.b_pos (by simp [SupportModulus.V])

@[simp] theorem C_pos (q : Parameter M) : 0 < q.C :=
  mul_pos S.c_pos (by simp [SupportModulus.W])

theorem A_add_B_eq_C (q : Parameter M) : q.A + q.B = q.C := by
  simpa [A, B, C] using M.shear_equation q.h q.k

theorem A_coprime_B (q : Parameter M) : Nat.Coprime q.A q.B := by
  have haV : Nat.Coprime S.a (M.V q.h q.k) :=
    ((M.V_coprime_P q.h q.k).of_dvd_right S.a_dvd_P).symm
  have hUb : Nat.Coprime (M.U q.h) S.b :=
    (M.U_coprime_P q.h).of_dvd_right S.b_dvd_P
  exact (S.coprime.mul_right haV).mul_left (hUb.mul_right q.U_coprime_V)

theorem B_coprime_C (q : Parameter M) : Nat.Coprime q.B q.C := by
  have hbc : Nat.Coprime S.b S.c := by
    rw [← S.sum_eq]
    exact Nat.coprime_add_self_right.mpr S.coprime.symm
  have hbW : Nat.Coprime S.b (M.W q.h q.k) :=
    ((M.W_coprime_P q.h q.k).of_dvd_right S.b_dvd_P).symm
  have hVc : Nat.Coprime (M.V q.h q.k) S.c :=
    (M.V_coprime_P q.h q.k).of_dvd_right S.c_dvd_P
  exact (hbc.mul_right hbW).mul_left (hVc.mul_right q.V_coprime_W)

theorem C_coprime_A (q : Parameter M) : Nat.Coprime q.C q.A := by
  have hca : Nat.Coprime S.c S.a := by
    rw [← S.sum_eq]
    exact Nat.coprime_self_add_left.mpr S.coprime.symm
  have hcU : Nat.Coprime S.c (M.U q.h) :=
    ((M.U_coprime_P q.h).of_dvd_right S.c_dvd_P).symm
  have hWa : Nat.Coprime (M.W q.h q.k) S.a :=
    (M.W_coprime_P q.h q.k).of_dvd_right S.a_dvd_P
  exact (hca.mul_right hcU).mul_left (hWa.mul_right q.U_coprime_W.symm)

/-- Every admissible generalized shear is a primitive positive abc point. -/
def point (q : Parameter M) : ABCPoint where
  a := q.A
  b := q.B
  c := q.C
  a_pos := q.A_pos
  b_pos := q.B_pos
  c_pos := q.C_pos
  sum_eq := q.A_add_B_eq_C
  pairwise_coprime := ⟨q.A_coprime_B, q.B_coprime_C, q.C_coprime_A⟩

@[simp] theorem point_a (q : Parameter M) : q.point.a = q.A := rfl
@[simp] theorem point_b (q : Parameter M) : q.point.b = q.B := rfl
@[simp] theorem point_c (q : Parameter M) : q.point.c = q.C := rfl

end Parameter

/-- The pair `(U,V)` recovers both parameters. -/
theorem pair_UV_injective (M : SupportModulus S) :
    Function.Injective (fun hk : ℕ × ℕ => (M.U hk.1, M.V hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hU : M.U h = M.U h' := congrArg Prod.fst heq
  have hQh : M.Q * h = M.Q * h' := by simpa [U] using hU
  have hh : h = h' := Nat.mul_left_cancel M.Q_pos hQh
  subst h'
  have hV : M.V h k = M.V h k' := congrArg Prod.snd heq
  have hQck : M.Q * S.c * k = M.Q * S.c * k' := by
    simpa [M.V_eq_U_add] using hV
  have hk : k = k' :=
    Nat.mul_left_cancel (mul_pos M.Q_pos S.c_pos) hQck
  subst k'
  rfl

/-- The pair `(U,W)` recovers both parameters. -/
theorem pair_UW_injective (M : SupportModulus S) :
    Function.Injective (fun hk : ℕ × ℕ => (M.U hk.1, M.W hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hU : M.U h = M.U h' := congrArg Prod.fst heq
  have hQh : M.Q * h = M.Q * h' := by simpa [U] using hU
  have hh : h = h' := Nat.mul_left_cancel M.Q_pos hQh
  subst h'
  have hW : M.W h k = M.W h k' := congrArg Prod.snd heq
  have hQbk : M.Q * S.b * k = M.Q * S.b * k' := by
    simpa [M.W_eq_U_add] using hW
  have hk : k = k' :=
    Nat.mul_left_cancel (mul_pos M.Q_pos S.b_pos) hQbk
  subst k'
  rfl

/-- The pair `(V,W)` also recovers both parameters. -/
theorem pair_VW_injective (M : SupportModulus S) :
    Function.Injective (fun hk : ℕ × ℕ => (M.V hk.1 hk.2, M.W hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hV : M.V h k = M.V h' k' := congrArg Prod.fst heq
  have hW : M.W h k = M.W h' k' := congrArg Prod.snd heq
  have hsum : M.W h k + M.Q * S.a * k =
      M.W h k + M.Q * S.a * k' := by
    calc
      M.W h k + M.Q * S.a * k = M.V h k := (M.V_eq_W_add h k).symm
      _ = M.V h' k' := hV
      _ = M.W h' k' + M.Q * S.a * k' := M.V_eq_W_add h' k'
      _ = M.W h k + M.Q * S.a * k' := by rw [hW]
  have hQak : M.Q * S.a * k = M.Q * S.a * k' := Nat.add_left_cancel hsum
  have hk : k = k' :=
    Nat.mul_left_cancel (mul_pos M.Q_pos S.a_pos) hQak
  subst k'
  have hinside : h + S.c * k = h' + S.c * k := by
    apply Nat.mul_left_cancel M.Q_pos
    simpa [V] using hV
  have hh : h = h' := Nat.add_right_cancel hinside
  subst h'
  rfl

/-- The ordered primitive endpoint map is injective. -/
theorem point_injective (M : SupportModulus S) :
    Function.Injective
      (fun q : Parameter M => (q.point.a, q.point.b, q.point.c)) := by
  intro q r heq
  have hA : S.a * M.U q.h = S.a * M.U r.h := by
    simpa [Parameter.A] using congrArg (fun x => x.1) heq
  have hU : M.U q.h = M.U r.h := Nat.mul_left_cancel S.a_pos hA
  have hB : S.b * M.V q.h q.k = S.b * M.V r.h r.k := by
    simpa [Parameter.B] using congrArg (fun x => x.2.1) heq
  have hV : M.V q.h q.k = M.V r.h r.k := Nat.mul_left_cancel S.b_pos hB
  have hhk : (q.h, q.k) = (r.h, r.k) :=
    M.pair_UV_injective (Prod.ext hU hV)
  cases q
  cases r
  simp_all

/-- Multiplying a support modulus by a positive integer preserves its support. -/
def scale (R : SupportModulus S) (s : ℕ) (hs : 0 < s) : SupportModulus S where
  Q := s * R.Q
  Q_pos := mul_pos hs R.Q_pos
  support := by
    intro p hp hpP
    exact dvd_mul_of_dvd_right (R.support hp hpP) s

@[simp] theorem scale_Q (R : SupportModulus S) (s : ℕ) (hs : 0 < s) :
    (R.scale s hs).Q = s * R.Q := rfl

/-- A multiple-step `U` is the minimal-step `U` at the scaled parameter. -/
theorem scale_U (R : SupportModulus S) (s : ℕ) (hs : 0 < s) (h : ℕ) :
    (R.scale s hs).U h = R.U (s * h) := by
  simp [scale, U]
  ring

/-- A multiple-step `V` is the minimal-step `V` at scaled parameters. -/
theorem scale_V (R : SupportModulus S) (s : ℕ) (hs : 0 < s) (h k : ℕ) :
    (R.scale s hs).V h k = R.V (s * h) (s * k) := by
  simp [scale, V]
  ring

/-- A multiple-step `W` is the minimal-step `W` at scaled parameters. -/
theorem scale_W (R : SupportModulus S) (s : ℕ) (hs : 0 < s) (h k : ℕ) :
    (R.scale s hs).W h k = R.W (s * h) (s * k) := by
  simp [scale, W]
  ring

/-- The integer canonical-box bound for a multiple step embeds into the
corresponding base-step bound.  This is the floor inequality
`s * floor(N/(sR)) <= floor(N/R)`. -/
theorem scale_parameterBound_le (R : SupportModulus S) (s : ℕ) (hs : 0 < s)
    (N : ℕ) :
    s * (N / (R.scale s hs).Q) ≤ N / R.Q := by
  rw [scale_Q]
  apply (Nat.le_div_iff_mul_le R.Q_pos).2
  calc
    s * (N / (s * R.Q)) * R.Q = (N / (s * R.Q)) * (s * R.Q) := by ring
    _ ≤ N := Nat.div_mul_le_self N (s * R.Q)

/-- Admissibility is preserved under the parameter embedding
`(h,k) |-> (s*h,s*k)`. -/
def embedParameter (R : SupportModulus S) (s : ℕ) (hs : 0 < s)
    (q : Parameter (R.scale s hs)) : Parameter R where
  h := s * q.h
  k := s * q.k
  h_pos := mul_pos hs q.h_pos
  k_pos := mul_pos hs q.k_pos
  admissible := by
    have hUs : Nat.Coprime ((R.scale s hs).U q.h) s :=
      ((R.scale s hs).U_coprime_Q q.h).of_dvd_right
        (by exact dvd_mul_right s R.Q)
    have hUsk : Nat.Coprime ((R.scale s hs).U q.h) (s * q.k) :=
      hUs.mul_right q.admissible
    simpa [scale_U] using hUsk

@[simp] theorem embedParameter_h (R : SupportModulus S) (s : ℕ) (hs : 0 < s)
    (q : Parameter (R.scale s hs)) : (R.embedParameter s hs q).h = s * q.h := rfl

@[simp] theorem embedParameter_k (R : SupportModulus S) (s : ℕ) (hs : 0 < s)
    (q : Parameter (R.scale s hs)) : (R.embedParameter s hs q).k = s * q.k := rfl

/-- The multiple-step parameter map is an actual injection into the base-step
parameter space. -/
theorem embedParameter_injective (R : SupportModulus S) (s : ℕ) (hs : 0 < s) :
    Function.Injective (R.embedParameter s hs) := by
  intro q r heq
  have hhScaled : s * q.h = s * r.h := congrArg Parameter.h heq
  have hkScaled : s * q.k = s * r.k := congrArg Parameter.k heq
  have hh : q.h = r.h := Nat.mul_left_cancel hs hhScaled
  have hk : q.k = r.k := Nat.mul_left_cancel hs hkScaled
  cases q
  cases r
  simp_all

/-- The parameter embedding preserves all three unscaled cofactors. -/
theorem embedParameter_cofactors (R : SupportModulus S) (s : ℕ) (hs : 0 < s)
    (q : Parameter (R.scale s hs)) :
    (R.U (R.embedParameter s hs q).h,
      R.V (R.embedParameter s hs q).h (R.embedParameter s hs q).k,
      R.W (R.embedParameter s hs q).h (R.embedParameter s hs q).k) =
    ((R.scale s hs).U q.h, (R.scale s hs).V q.h q.k,
      (R.scale s hs).W q.h q.k) := by
  simp [embedParameter, scale_U, scale_V, scale_W]

end SupportModulus

/-! ## Abstract quantifier form of the matching-lower gate -/

section MatchingGate

variable {ι : Type*}

/-- A uniform upper estimate with a positive common weight. -/
def UniformUpper (eligible : ι → Prop) (count weight : ι → ℕ) : Prop :=
  ∃ C : ℕ, ∀ i : ι, eligible i → count i ≤ C * weight i

/-- An eventual matching lower estimate.  `growth` is the factor which is
strictly larger than the upper constant at large height. -/
def EventualMatchingLower (eligible : ι → Prop)
    (height count weight : ι → ℕ) (growth : ℕ → ℕ) : Prop :=
  ∃ A : ℕ, 0 < A ∧ ∃ c0 : ℕ, ∀ i : ι,
    eligible i → c0 ≤ height i →
      A * growth (height i) * weight i ≤ count i

/-- Boundedness of the eligible height locus. -/
def BoundedLocus (eligible : ι → Prop) (height : ι → ℕ) : Prop :=
  ∃ B : ℕ, ∀ i : ι, eligible i → height i ≤ B

/-- Quantitative divergence sufficient to separate a matching lower estimate
from a uniform upper estimate. -/
def DivergesAgainstConstants (growth : ℕ → ℕ) : Prop :=
  ∀ A C : ℕ, 0 < A → ∃ N : ℕ, ∀ n : ℕ, N ≤ n → C < A * growth n

/-- A uniform upper bound plus an eventual matching lower bound forces the
eligible height locus to be bounded once the extra growth factor diverges. -/
theorem boundedLocus_of_matchingLower
    {eligible : ι → Prop} {height count weight : ι → ℕ} {growth : ℕ → ℕ}
    (hweight : ∀ i : ι, eligible i → 0 < weight i)
    (hupper : UniformUpper eligible count weight)
    (hdiv : DivergesAgainstConstants growth)
    (hlower : EventualMatchingLower eligible height count weight growth) :
    BoundedLocus eligible height := by
  rcases hupper with ⟨C, hC⟩
  rcases hlower with ⟨A, hA, c0, hlow⟩
  rcases hdiv A C hA with ⟨N, hN⟩
  refine ⟨max c0 N, ?_⟩
  intro i hi
  by_contra hbound
  have hgt : max c0 N < height i := Nat.lt_of_not_ge hbound
  have hc0 : c0 ≤ height i := le_trans (le_max_left c0 N) hgt.le
  have hNN : N ≤ height i := le_trans (le_max_right c0 N) hgt.le
  have hchain : A * growth (height i) * weight i ≤ C * weight i :=
    (hlow i hi hc0).trans (hC i hi)
  have hcancel : A * growth (height i) ≤ C :=
    Nat.le_of_mul_le_mul_right hchain (hweight i hi)
  exact (Nat.not_lt_of_ge hcancel) (hN (height i) hNN)

/-- If the eligible locus is bounded, every eventual matching-lower shape is
true above a sufficiently large threshold by vacuity. -/
theorem eventualMatchingLower_of_boundedLocus
    {eligible : ι → Prop} {height count weight : ι → ℕ} {growth : ℕ → ℕ}
    (hbounded : BoundedLocus eligible height) :
    EventualMatchingLower eligible height count weight growth := by
  rcases hbounded with ⟨B, hB⟩
  refine ⟨1, by norm_num, B + 1, ?_⟩
  intro i hi hlarge
  have hsmall : height i ≤ B := hB i hi
  omega

/-- Exact abstract equivalence: under a uniform upper bound, positive common
weights, and divergence of the extra factor, an eventual matching lower bound
is equivalent to boundedness of the eligible height locus. -/
theorem eventualMatchingLower_iff_boundedLocus
    {eligible : ι → Prop} {height count weight : ι → ℕ} {growth : ℕ → ℕ}
    (hweight : ∀ i : ι, eligible i → 0 < weight i)
    (hupper : UniformUpper eligible count weight)
    (hdiv : DivergesAgainstConstants growth) :
    EventualMatchingLower eligible height count weight growth ↔
      BoundedLocus eligible height := by
  constructor
  · exact boundedLocus_of_matchingLower hweight hupper hdiv
  · exact eventualMatchingLower_of_boundedLocus

end MatchingGate

/-! ## Exact square rows from the finite audit -/

/-- The first audited row has three square cofactors and is admissible. -/
theorem square_row_step_six :
    1 + 6 * 840 = 71 ^ 2 ∧
    1 + 6 * (840 + 9 * 60) = 91 ^ 2 ∧
    1 + 6 * (840 + 8 * 60) = 89 ^ 2 ∧
    Nat.Coprime (1 + 6 * 840) 60 := by
  norm_num

/-- The same cofactor triple occurs in the step-72 sublattice. -/
theorem square_row_step_seventy_two :
    1 + 72 * 70 = 71 ^ 2 ∧
    1 + 72 * (70 + 9 * 5) = 91 ^ 2 ∧
    1 + 72 * (70 + 8 * 5) = 89 ^ 2 ∧
    Nat.Coprime (1 + 72 * 70) 5 := by
  norm_num

/-- A second step-72 row includes a fourth-power first cofactor. -/
theorem powerful_square_row_step_seventy_two :
    1 + 72 * 1160 = 17 ^ 4 ∧
    1 + 72 * (1160 + 9 * 798) = 775 ^ 2 ∧
    1 + 72 * (1160 + 8 * 798) = 737 ^ 2 ∧
    Nat.Coprime (1 + 72 * 1160) 798 := by
  norm_num

/-- The exact radical of the first square-row output
`(5041, 8 * 8281, 9 * 7921)`. -/
theorem square_row_output_radical :
    abcRadical (5041 * (8 * 8281) * (9 * 7921)) = 3450174 := by
  have hprod :
      5041 * (8 * 8281) * (9 * 7921) = 72 * (71 * 91 * 89) ^ 2 := by
    norm_num
  rw [hprod, abcRadical_eq_natRadical,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  rw [UniqueFactorizationMonoid.radical_mul
    (Nat.coprime_iff_isRelPrime.mp (by norm_num))]
  have h72 : UniqueFactorizationMonoid.radical (72 : ℕ) = 6 := by
    simpa [abcRadical_eq_natRadical] using
      ABCTwoPrimeSupport20260831.radical_seventy_two
  rw [h72]
  have hs : 71 * 91 * 89 = 71 * (7 * 13) * 89 := by norm_num
  rw [hs]
  rw [UniqueFactorizationMonoid.radical_mul
    (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 71).prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 7).prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 13).prime),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 89).prime)]
  norm_num

/-- The first square-row output fails the strict three-quarter radical test. -/
theorem square_row_not_threeQuarter_exceptional :
    ¬ (3450174 : ℕ) ^ 4 < 71289 ^ 3 := by
  norm_num

/-- The exact radical of the second audited square-row output. -/
theorem powerful_square_row_output_radical :
    abcRadical (83521 * (8 * 600625) * (9 * 543169)) = 11651970 := by
  have hprod :
      83521 * (8 * 600625) * (9 * 543169) =
        72 * (17 ^ 2 * 775 * 737) ^ 2 := by
    norm_num
  rw [hprod, abcRadical_eq_natRadical,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  have h17 :
      72 * (17 ^ 2 * 775 * 737) = (72 * 775 * 737) * 17 ^ 2 := by
    ring
  rw [h17,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  have h5 :
      (72 * 775 * 737) * 17 = (72 * 31 * 737 * 17) * 5 ^ 2 := by
    norm_num
  rw [h5,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  have h72 :
      (72 * 31 * 737 * 17) * 5 = (31 * 737 * 17 * 5 * 2) * 6 ^ 2 := by
    ring
  rw [h72,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  have h12 :
      (31 * 737 * 17 * 5 * 2) * 6 =
        (31 * 737 * 17 * 5 * 3) * 2 ^ 2 := by
    ring
  rw [h12,
    GeometryGlobalUniformGate.radical_mul_square (by norm_num) (by norm_num)]
  have hdistinct :
      (31 * 737 * 17 * 5 * 3) * 2 =
        31 * 11 * 67 * 17 * 5 * 3 * 2 := by
    norm_num
  rw [hdistinct]
  repeat'
    rw [UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num))]
  rw [UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 31).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 11).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 67).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 17).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 5).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 3).prime),
      UniqueFactorizationMonoid.radical_of_prime
        (by exact (by norm_num : Nat.Prime 2).prime)]
  norm_num

/-- The second square-row output also fails the strict three-quarter test. -/
theorem powerful_square_row_not_threeQuarter_exceptional :
    ¬ (11651970 : ℕ) ^ 4 < 4888521 ^ 3 := by
  norm_num

#print axioms SupportModulus.of_radical_dvd
#print axioms SupportModulus.one_add_Q_mul_coprime_P
#print axioms SupportModulus.shear_equation
#print axioms SupportModulus.Parameter.U_coprime_V
#print axioms SupportModulus.Parameter.U_coprime_W
#print axioms SupportModulus.Parameter.V_coprime_W
#print axioms SupportModulus.Parameter.point
#print axioms SupportModulus.pair_UV_injective
#print axioms SupportModulus.pair_UW_injective
#print axioms SupportModulus.pair_VW_injective
#print axioms SupportModulus.point_injective
#print axioms SupportModulus.scale_parameterBound_le
#print axioms SupportModulus.embedParameter
#print axioms SupportModulus.embedParameter_injective
#print axioms eventualMatchingLower_iff_boundedLocus
#print axioms square_row_step_six
#print axioms powerful_square_row_step_seventy_two
#print axioms square_row_output_radical
#print axioms square_row_not_threeQuarter_exceptional
#print axioms powerful_square_row_output_radical
#print axioms powerful_square_row_not_threeQuarter_exceptional

end AffineRadicalStep20260901
end IUTThreeClosures
