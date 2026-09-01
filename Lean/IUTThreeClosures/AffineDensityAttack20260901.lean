/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineRadicalStep20260901
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.Data.Nat.Squarefree
import Mathlib.Data.ZMod.Basic

/-!
# The affine density attack

The mathematical proofs precede this file in
`research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md`.

This module formalizes the deterministic and finite-residue core of that
report. It proves the exact common-gcd invariant of the three affine gaps,
recovers all three seed coordinates from normalized gaps, constructs the
coordinate equivalence behind the one-residue local count, and proves the
pointwise two-long-arm excess necessity.

It also records that squarefree natural numbers have radical equal to
themselves and unit repeated-prime excess. No asymptotic squarefree-density
statement, analytic counting estimate, matching lower bound, or abc statement
is introduced as an axiom.
-/

namespace IUTThreeClosures
namespace AffineDensityAttack20260901

open AffineRadicalStep20260901

/-- The seed and support-modulus types used by the minimal-radical shear. -/
abbrev Seed := AffineRadicalStep20260901.Seed
abbrev SupportModulus := AffineRadicalStep20260901.SupportModulus

/-! ## Exact support-closed gap recovery -/

namespace SupportModulus

variable {S : Seed}

/-- The common gcd of the two gaps from `U` is exactly the modulus times the
second affine parameter. For the minimal modulus this is `rad(abc) * k`. -/
theorem gap_gcd_eq_Q_mul_k (M : SupportModulus S) (h k : ℕ) :
    Nat.gcd (M.V h k - M.U h) (M.W h k - M.U h) = M.Q * k := by
  rw [M.V_eq_U_add, M.W_eq_U_add]
  simp only [Nat.add_sub_cancel_left]
  have hbc : Nat.Coprime S.b S.c := by
    rw [← S.sum_eq]
    exact Nat.coprime_add_self_right.mpr S.coprime.symm
  have hQc : M.Q * S.c * k = S.c * (M.Q * k) := by ac_rfl
  have hQb : M.Q * S.b * k = S.b * (M.Q * k) := by ac_rfl
  rw [hQc, hQb, Nat.gcd_mul_right, hbc.symm.gcd_eq_one, one_mul]

/-- The common gcd of the two consecutive cofactor gaps is the same exact
quantity `Q*k`. -/
theorem consecutive_gap_gcd_eq_Q_mul_k (M : SupportModulus S) (h k : ℕ) :
    Nat.gcd (M.V h k - M.W h k) (M.W h k - M.U h) = M.Q * k := by
  rw [M.V_eq_W_add, M.W_eq_U_add]
  simp only [Nat.add_sub_cancel_left]
  have hQa : M.Q * S.a * k = S.a * (M.Q * k) := by ac_rfl
  have hQb : M.Q * S.b * k = S.b * (M.Q * k) := by ac_rfl
  rw [hQa, hQb, Nat.gcd_mul_right, S.coprime.gcd_eq_one, one_mul]

/-- The first normalized consecutive gap recovers `a`. -/
theorem recover_a_from_gaps (M : SupportModulus S) (h k : ℕ) (hk : 0 < k) :
    (M.V h k - M.W h k) / (M.Q * k) = S.a := by
  rw [M.V_eq_W_add]
  simp only [Nat.add_sub_cancel_left]
  have hQk : 0 < M.Q * k := mul_pos M.Q_pos hk
  have hQa : M.Q * S.a * k = (M.Q * k) * S.a := by ac_rfl
  rw [hQa, Nat.mul_div_cancel_left S.a hQk]

/-- The second normalized consecutive gap recovers `b`. -/
theorem recover_b_from_gaps (M : SupportModulus S) (h k : ℕ) (hk : 0 < k) :
    (M.W h k - M.U h) / (M.Q * k) = S.b := by
  rw [M.W_eq_U_add]
  simp only [Nat.add_sub_cancel_left]
  have hQk : 0 < M.Q * k := mul_pos M.Q_pos hk
  have hQb : M.Q * S.b * k = (M.Q * k) * S.b := by ac_rfl
  rw [hQb, Nat.mul_div_cancel_left S.b hQk]

/-- The total normalized gap recovers `c`. -/
theorem recover_c_from_gaps (M : SupportModulus S) (h k : ℕ) (hk : 0 < k) :
    (M.V h k - M.U h) / (M.Q * k) = S.c := by
  rw [M.V_eq_U_add]
  simp only [Nat.add_sub_cancel_left]
  have hQk : 0 < M.Q * k := mul_pos M.Q_pos hk
  have hQc : M.Q * S.c * k = (M.Q * k) * S.c := by ac_rfl
  rw [hQc, Nat.mul_div_cancel_left S.c hQk]

/-- All three normalized gap coordinates recover the original seed at once. -/
theorem recover_seed_from_gaps (M : SupportModulus S) (h k : ℕ) (hk : 0 < k) :
    ((M.V h k - M.W h k) / (M.Q * k),
      (M.W h k - M.U h) / (M.Q * k),
      (M.V h k - M.U h) / (M.Q * k)) = (S.a, S.b, S.c) := by
  rw [M.recover_a_from_gaps h k hk, M.recover_b_from_gaps h k hk,
    M.recover_c_from_gaps h k hk]

end SupportModulus

/-! ## The strict positive-parameter boundary -/

/-- In the reverse direction, the strict inequality `1 < U` forces the first
affine parameter to be positive. -/
theorem first_parameter_pos_of_strict_U {R h U : ℕ}
    (hU : U = 1 + R * h) (hstrict : 1 < U) : 0 < h := by
  by_contra hnot
  have hz : h = 0 := Nat.eq_zero_of_not_pos hnot
  subst h
  simp at hU
  omega

/-- A positive common gap forces the second affine parameter to be positive. -/
theorem second_parameter_pos_of_positive_gap {R k g : ℕ}
    (hg : g = R * k) (hgpos : 0 < g) : 0 < k := by
  by_contra hnot
  have hz : k = 0 := Nat.eq_zero_of_not_pos hnot
  subst k
  simp at hg
  omega

/-- The row `(U,W,V)=(1,3,5)` satisfies every arithmetic condition in the
weak reverse statement with `1 ≤ U`, but reconstructs `h=0`.  Thus `1<U` is
necessary when the affine parameters are required to be positive. -/
theorem weak_reverse_first_boundary :
    let U : ℕ := 1
    let W : ℕ := 3
    let V : ℕ := 5
    let g := Nat.gcd (V - U) (W - U)
    let a := (V - W) / g
    let b := (W - U) / g
    let c := (V - U) / g
    let R := abcRadical (a * b * c)
    1 ≤ U ∧ U < W ∧ W < V ∧
      g = 2 ∧ (a, b, c) = (1, 1, 2) ∧ R = 2 ∧
      R ∣ g ∧ R ∣ U - 1 ∧ Nat.Coprime U (g / R) ∧
      (U - 1) / R = 0 := by
  norm_num [abcRadical]

/-! ## The exact finite-residue coordinate change -/

section LocalCoordinate

variable {A : Type*} [CommRing A]

/-- If `Q` is a unit, the affine change
`(h,k) |-> (1 + Q*(h + L*k), k)` is an equivalence over any commutative ring.
This is the algebraic reason one divisibility condition occupies one residue
class in `h` for each fixed `k`. -/
noncomputable def affineCoordinateEquiv (Q L : A) (hQ : IsUnit Q) :
    A × A ≃ A × A where
  toFun x := (1 + Q * (x.1 + L * x.2), x.2)
  invFun y := ((((hQ.unit)⁻¹ : Aˣ) : A) * (y.1 - 1) - L * y.2, y.2)
  left_inv x := by
    have hInv : (((hQ.unit)⁻¹ : Aˣ) : A) * Q = 1 := by
      calc
        (((hQ.unit)⁻¹ : Aˣ) : A) * Q =
            (((hQ.unit)⁻¹ : Aˣ) : A) * (hQ.unit : A) := by
              exact congrArg (fun z : A => (((hQ.unit)⁻¹ : Aˣ) : A) * z)
                hQ.unit_spec.symm
        _ = 1 := Units.inv_mul hQ.unit
    apply Prod.ext
    · change (((hQ.unit)⁻¹ : Aˣ) : A) *
          ((1 + Q * (x.1 + L * x.2)) - 1) - L * x.2 = x.1
      rw [add_sub_cancel_left]
      calc
        (((hQ.unit)⁻¹ : Aˣ) : A) * (Q * (x.1 + L * x.2)) - L * x.2 =
            ((((hQ.unit)⁻¹ : Aˣ) : A) * Q) *
              (x.1 + L * x.2) - L * x.2 := by ring
        _ = x.1 := by rw [hInv]; ring
    · rfl
  right_inv y := by
    have hInv : Q * (((hQ.unit)⁻¹ : Aˣ) : A) = 1 := by
      calc
        Q * (((hQ.unit)⁻¹ : Aˣ) : A) =
            (hQ.unit : A) * (((hQ.unit)⁻¹ : Aˣ) : A) := by
              exact congrArg (fun z : A => z * (((hQ.unit)⁻¹ : Aˣ) : A))
                hQ.unit_spec.symm
        _ = 1 := Units.mul_inv hQ.unit
    apply Prod.ext
    · change 1 + Q *
          ((((hQ.unit)⁻¹ : Aˣ) : A) * (y.1 - 1) - L * y.2 + L * y.2) = y.1
      rw [sub_add_cancel]
      calc
        1 + Q * ((((hQ.unit)⁻¹ : Aˣ) : A) * (y.1 - 1)) =
            1 + (Q * (((hQ.unit)⁻¹ : Aˣ) : A)) * (y.1 - 1) := by ring
        _ = y.1 := by rw [hInv]; ring
    · rfl

end LocalCoordinate

section ZeroFiber

variable {A : Type*} [Zero A]

/-- The zero fibre of the first coordinate of a plane equivalence is itself
equivalent to the free second coordinate. -/
def zeroFirstFiberEquiv (e : A × A ≃ A × A) :
    A ≃ {x : A × A // (e x).1 = 0} where
  toFun k := ⟨e.symm (0, k), by simp⟩
  invFun x := (e x.1).2
  left_inv k := by simp
  right_inv x := by
    apply Subtype.ext
    change e.symm (0, (e x.1).2) = x.1
    apply e.injective
    rw [e.apply_symm_apply]
    exact Prod.ext x.2.symm rfl

/-- Cardinal form of the zero-fibre equivalence. -/
theorem zeroFirstFiber_card (e : A × A ≃ A × A) :
    Nat.card {x : A × A // (e x).1 = 0} = Nat.card A := by
  exact (Nat.card_congr (zeroFirstFiberEquiv e)).symm

end ZeroFiber

/-- The affine coordinate equivalence over `ZMod n`, under exactly the
coprimality condition that makes `Q` a unit. -/
noncomputable def zmodAffineCoordinateEquiv (n Q L : ℕ) (hQ : Q.Coprime n) :
    ZMod n × ZMod n ≃ ZMod n × ZMod n :=
  affineCoordinateEquiv (Q : ZMod n) (L : ZMod n)
    ((ZMod.isUnit_iff_coprime Q n).2 hQ)

/-- Exactly `n` residue pairs modulo `n` make one affine cofactor vanish. -/
theorem zmod_affine_zero_fiber_card (n Q L : ℕ) [NeZero n]
    (hQ : Q.Coprime n) :
    Nat.card {x : ZMod n × ZMod n //
      (zmodAffineCoordinateEquiv n Q L hQ x).1 = 0} = n := by
  rw [zeroFirstFiber_card, Nat.card_eq_fintype_card]
  exact ZMod.card n

/-! ## Squarefree cofactors and repeated-prime excess -/

/-- The elementary radical fixes a squarefree natural number. -/
theorem abcRadical_eq_self_of_squarefree {n : ℕ} (hn : Squarefree n) :
    abcRadical n = n := by
  simpa [abcRadical] using Nat.prod_primeFactors_of_squarefree hn

/-- A squarefree natural has unit repeated-prime excess. -/
theorem abcPowerfulPart_eq_one_of_squarefree {n : ℕ} (hn : Squarefree n) :
    abcPowerfulPart n = 1 := by
  rw [abcPowerfulPart, abcRadical_eq_self_of_squarefree hn,
    Nat.div_self (Nat.pos_of_ne_zero hn.ne_zero)]

/-- Three squarefree cofactors have total repeated-prime excess one. -/
theorem squarefree_triple_unit_excess {U V W : ℕ}
    (hU : Squarefree U) (hV : Squarefree V) (hW : Squarefree W) :
    abcPowerfulPart U * abcPowerfulPart V * abcPowerfulPart W = 1 := by
  simp [abcPowerfulPart_eq_one_of_squarefree hU,
    abcPowerfulPart_eq_one_of_squarefree hV,
    abcPowerfulPart_eq_one_of_squarefree hW]

/-- Thus a squarefree cofactor triple cannot meet any excess threshold at
least one with a strict inequality. -/
theorem squarefree_triple_not_above_one {U V W T : ℕ}
    (hU : Squarefree U) (hV : Squarefree V) (hW : Squarefree W)
    (hT : 1 ≤ T) :
    ¬ T < abcPowerfulPart U * abcPowerfulPart V * abcPowerfulPart W := by
  rw [squarefree_triple_unit_excess hU hV hW]
  exact Nat.not_lt_of_ge hT

/-- The repeated-prime excess never exceeds a positive integer itself. -/
theorem abcPowerfulPart_le_self {n : ℕ} (hn : 0 < n) :
    abcPowerfulPart n ≤ n :=
  Nat.le_of_dvd hn (abcPowerfulPart_dvd n)

/-! ## Pointwise two-long-arm necessity -/

/-- Cancelling the short-arm and third-arm size caps from the full excess
threshold forces a linear-in-`c` excess lower bound in the `V` arm. -/
theorem longV_excess_of_product_threshold {R c EU EV EW : ℕ}
    (hU : EU ≤ c ^ 6) (hW : EW ≤ c ^ 7)
    (hex : R * c ^ 14 < 8192 * EU * EV * EW) :
    R * c < 8192 * EV := by
  have hupper : 8192 * EU * EV * EW ≤ 8192 * c ^ 6 * EV * c ^ 7 := by
    gcongr
  have hchain : R * c ^ 14 < 8192 * c ^ 6 * EV * c ^ 7 :=
    hex.trans_le hupper
  have hleft : R * c ^ 14 = c ^ 13 * (R * c) := by ring
  have hright : 8192 * c ^ 6 * EV * c ^ 7 = c ^ 13 * (8192 * EV) := by ring
  rw [hleft, hright] at hchain
  exact Nat.lt_of_mul_lt_mul_left hchain

/-- The symmetric cancellation forces the same bound in the `W` arm. -/
theorem longW_excess_of_product_threshold {R c EU EV EW : ℕ}
    (hU : EU ≤ c ^ 6) (hV : EV ≤ c ^ 7)
    (hex : R * c ^ 14 < 8192 * EU * EV * EW) :
    R * c < 8192 * EW := by
  have hupper : 8192 * EU * EV * EW ≤ 8192 * c ^ 6 * c ^ 7 * EW := by
    gcongr
  have hchain : R * c ^ 14 < 8192 * c ^ 6 * c ^ 7 * EW :=
    hex.trans_le hupper
  have hleft : R * c ^ 14 = c ^ 13 * (R * c) := by ring
  have hright : 8192 * c ^ 6 * c ^ 7 * EW = c ^ 13 * (8192 * EW) := by ring
  rw [hleft, hright] at hchain
  exact Nat.lt_of_mul_lt_mul_left hchain

/-- Natural-number specialization to actual repeated-prime excesses. -/
theorem affine_two_long_arms
    {R c U V W : ℕ}
    (hUpos : 0 < U) (hVpos : 0 < V) (hWpos : 0 < W)
    (hU : U ≤ c ^ 6) (hV : V ≤ c ^ 7) (hW : W ≤ c ^ 7)
    (hex : R * c ^ 14 <
      8192 * abcPowerfulPart U * abcPowerfulPart V * abcPowerfulPart W) :
    R * c < 8192 * abcPowerfulPart V ∧
      R * c < 8192 * abcPowerfulPart W := by
  have hEU : abcPowerfulPart U ≤ c ^ 6 :=
    (abcPowerfulPart_le_self hUpos).trans hU
  have hEV : abcPowerfulPart V ≤ c ^ 7 :=
    (abcPowerfulPart_le_self hVpos).trans hV
  have hEW : abcPowerfulPart W ≤ c ^ 7 :=
    (abcPowerfulPart_le_self hWpos).trans hW
  exact ⟨longV_excess_of_product_threshold hEU hEW hex,
    longW_excess_of_product_threshold hEU hEV hex⟩

#print axioms SupportModulus.gap_gcd_eq_Q_mul_k
#print axioms SupportModulus.consecutive_gap_gcd_eq_Q_mul_k
#print axioms SupportModulus.recover_seed_from_gaps
#print axioms first_parameter_pos_of_strict_U
#print axioms second_parameter_pos_of_positive_gap
#print axioms weak_reverse_first_boundary
#print axioms affineCoordinateEquiv
#print axioms zmod_affine_zero_fiber_card
#print axioms abcRadical_eq_self_of_squarefree
#print axioms abcPowerfulPart_eq_one_of_squarefree
#print axioms squarefree_triple_not_above_one
#print axioms longV_excess_of_product_threshold
#print axioms longW_excess_of_product_threshold
#print axioms affine_two_long_arms

end AffineDensityAttack20260901
end IUTThreeClosures
