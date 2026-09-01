/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Arithmetic restrictions on inherited CRT and square-completion amplification

The mathematical proofs were written first in
`research/ANALYTIC_AMPLIFICATION_CONTINUATION_2026_08_30.md`.

This file proves a logarithmic count for actual primitive positive pairs
subject to three inherited divisibilities and their elementary radical
budget. It also checks the integer conic parametrization and the elementary
height constraint for square-certified descendants. No analytic density
estimate, conic lattice count, asymptotic divisor bound, or abc conjecture
is assumed as an axiom or claimed to have been fully formalized here.
-/

namespace IUTThreeClosures
namespace AnalyticAmplificationContinuation20260830

open UniqueFactorizationMonoid
open scoped BigOperators

/-- Submultiplicativity for the actual natural-number radical. -/
theorem radical_mul_le (m n : ℕ) :
    radical (m * n) ≤ radical m * radical n := by
  exact Nat.le_of_dvd (mul_pos (Nat.radical_pos m) (Nat.radical_pos n))
    (radical_mul_dvd (a := m) (b := n))

/-- The explicit radical bound used by the inherited-prime-power construction. -/
theorem inherited_radical_bound {U V W u v w : ℕ}
    (hu : 0 < u) (hv : 0 < v) (hw : 0 < w) :
    radical ((U * u) * (V * v) * (W * w)) ≤
      radical (U * V * W) * u * v * w := by
  have hnonzero : u * v * w ≠ 0 := ne_of_gt (mul_pos (mul_pos hu hv) hw)
  calc
    radical ((U * u) * (V * v) * (W * w)) =
        radical ((U * V * W) * (u * v * w)) := by congr 1; ring
    _ ≤ radical (U * V * W) * radical (u * v * w) := radical_mul_le _ _
    _ ≤ radical (U * V * W) * (u * v * w) :=
      Nat.mul_le_mul_left _ (Nat.radical_le_self_iff.mpr hnonzero)
    _ = radical (U * V * W) * u * v * w := by ring

/-- A cofactor certificate bounded by the output height implies the natural
pair budget used in the finite CRT counting theorem. -/
theorem inherited_cofactor_certificate_budget {U V W u v w : ℕ}
    (hw : 0 < w)
    (hcert : radical (U * V * W) * u * v * w ≤ W * w) :
    radical (U * V * W) * (U * u) * (V * v) ≤ U * V * W := by
  have hbase : radical (U * V * W) * u * v ≤ W := by nlinarith
  nlinarith [Nat.mul_le_mul_left (U * V) hbase]

/-- The height-independent consequence of the elementary CRT certificate
`radical (U*V*W) * A*B*C/(U*V*W) ≤ C^μ`, for `0 < μ ≤ 1`.
The original divisibilities and primitivity are part of the predicate. -/
structure IsCRTCertificate (U V W : ℕ) (p : ℕ × ℕ) : Prop where
  fst_pos : 0 < p.1
  snd_pos : 0 < p.2
  coprime : Nat.Coprime p.1 p.2
  dvd_fst : U ∣ p.1
  dvd_snd : V ∣ p.2
  dvd_sum : W ∣ p.1 + p.2
  budget : radical (U * V * W) * p.1 * p.2 ≤ U * V * W

/-- Three pairwise coprime congruence moduli force the cross-products
to agree modulo their product. This is the determinant divisibility step. -/
theorem crt_cross_modEq {U V W A B A' B' : ℕ}
    (hUV : Nat.Coprime U V) (hUW : Nat.Coprime U W)
    (hVW : Nat.Coprime V W)
    (hUA : U ∣ A) (hUA' : U ∣ A')
    (hVB : V ∣ B) (hVB' : V ∣ B')
    (hWC : W ∣ A + B) (hWC' : W ∣ A' + B') :
    Nat.ModEq (U * V * W) (A * B') (A' * B) := by
  have hU : Nat.ModEq U (A * B') (A' * B) :=
    (Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_left hUA B')).trans
      (Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_left hUA' B)).symm
  have hV : Nat.ModEq V (A * B') (A' * B) :=
    (Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hVB' A)).trans
      (Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hVB A')).symm
  have hW : Nat.ModEq W (A * B') (A' * B) := by
    apply Nat.ModEq.add_left_cancel' (A * A')
    have hleft : Nat.ModEq W (A * (A' + B')) 0 :=
      Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hWC' A)
    have hright : Nat.ModEq W (A' * (A + B)) 0 :=
      Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hWC A')
    simpa only [mul_add, mul_comm A' A] using hleft.trans hright.symm
  exact (Nat.modEq_and_modEq_iff_modEq_mul (hUW.mul_left hVW)).mp
    ⟨(Nat.modEq_and_modEq_iff_modEq_mul hUV).mp ⟨hU, hV⟩, hW⟩

/-- Positive primitive rational pairs are uniquely determined by their ratio. -/
theorem primitive_pair_eq_of_cross_mul_eq {A B A' B' : ℕ}
    (hA : 0 < A) (hab : Nat.Coprime A B) (hab' : Nat.Coprime A' B')
    (hcross : A * B' = A' * B) : (A, B) = (A', B') := by
  have hAA' : A ∣ A' := hab.dvd_mul_right.mp ⟨B', hcross.symm⟩
  have hA'A : A' ∣ A := hab'.dvd_mul_right.mp ⟨B, hcross⟩
  have heq : A = A' := Nat.dvd_antisymm hAA' hA'A
  subst A'
  have hBB' : B = B' := by nlinarith
  exact Prod.ext rfl hBB'

/-- The actual radical budget implies `2*A*B ≤ U*V*W` for modulus at least two. -/
theorem IsCRTCertificate.two_mul_le {U V W : ℕ} {p : ℕ × ℕ}
    (hp : IsCRTCertificate U V W p) (hM : 2 ≤ U * V * W) :
    2 * p.1 * p.2 ≤ U * V * W := by
  have hR : 2 ≤ radical (U * V * W) := Nat.two_le_radical_iff.mpr hM
  exact (Nat.mul_le_mul_right p.2 (Nat.mul_le_mul_right p.1 hR)).trans hp.budget

/-- The exceptional modulus-one boundary contributes only `(1,1)`.
If the modulus is zero the hypotheses are inconsistent, so this is harmless. -/
theorem IsCRTCertificate.eq_one_pair_of_modulus_le_one
    {U V W : ℕ} {p : ℕ × ℕ} (hp : IsCRTCertificate U V W p)
    (hM : U * V * W ≤ 1) : p = (1, 1) := by
  have hR : 1 ≤ radical (U * V * W) := Nat.radical_pos _
  have hprod : p.1 * p.2 ≤ 1 := by
    calc
      p.1 * p.2 ≤ radical (U * V * W) * p.1 * p.2 := by
        simpa using Nat.mul_le_mul_right p.2 (Nat.mul_le_mul_right p.1 hR)
      _ ≤ 1 := hp.budget.trans hM
  have hfst : p.1 ≤ p.1 * p.2 := by
    simpa using Nat.mul_le_mul_left p.1 hp.snd_pos
  have hsnd : p.2 ≤ p.1 * p.2 := by
    simpa using Nat.mul_le_mul_right p.2 hp.fst_pos
  have hp1 := hp.fst_pos
  have hp2 := hp.snd_pos
  apply Prod.ext <;> simp only
  · omega
  · omega

/-- One dyadic strip contains at most one certified primitive output.
No counting or existence assumption about CRT lattice points is used. -/
theorem crt_certificate_unique_in_strip {U V W L : ℕ} {p q : ℕ × ℕ}
    (hUV : Nat.Coprime U V) (hUW : Nat.Coprime U W)
    (hVW : Nat.Coprime V W)
    (hp : IsCRTCertificate U V W p) (hq : IsCRTCertificate U V W q)
    (hM : 2 ≤ U * V * W)
    (hpL : L ≤ p.1) (hpU : p.1 < 2 * L)
    (hqL : L ≤ q.1) (hqU : q.1 < 2 * L) : p = q := by
  have hcross₁ : p.1 * q.2 < U * V * W := by
    calc
      p.1 * q.2 < (2 * L) * q.2 :=
        Nat.mul_lt_mul_of_pos_right hpU hq.snd_pos
      _ ≤ 2 * q.1 * q.2 :=
        Nat.mul_le_mul_right q.2 (Nat.mul_le_mul_left 2 hqL)
      _ ≤ U * V * W := hq.two_mul_le hM
  have hcross₂ : q.1 * p.2 < U * V * W := by
    calc
      q.1 * p.2 < (2 * L) * p.2 :=
        Nat.mul_lt_mul_of_pos_right hqU hp.snd_pos
      _ ≤ 2 * p.1 * p.2 :=
        Nat.mul_le_mul_right p.2 (Nat.mul_le_mul_left 2 hpL)
      _ ≤ U * V * W := hp.two_mul_le hM
  have hcross := crt_cross_modEq hUV hUW hVW
    hp.dvd_fst hq.dvd_fst hp.dvd_snd hq.dvd_snd hp.dvd_sum hq.dvd_sum
  exact primitive_pair_eq_of_cross_mul_eq hp.fst_pos hp.coprime hq.coprime
    (hcross.eq_of_lt_of_lt hcross₁ hcross₂)

/-- The dyadic index is injective on the actual certified output set. -/
theorem crt_certificate_eq_of_log_eq {U V W : ℕ} {p q : ℕ × ℕ}
    (hUV : Nat.Coprime U V) (hUW : Nat.Coprime U W)
    (hVW : Nat.Coprime V W)
    (hp : IsCRTCertificate U V W p) (hq : IsCRTCertificate U V W q)
    (hlog : Nat.log 2 p.1 = Nat.log 2 q.1) : p = q := by
  by_cases hM : 2 ≤ U * V * W
  · apply crt_certificate_unique_in_strip hUV hUW hVW hp hq hM
        (L := 2 ^ Nat.log 2 p.1)
    · exact Nat.pow_log_le_self 2 hp.fst_pos.ne'
    · simpa only [pow_succ, mul_comm] using
        Nat.lt_pow_succ_log_self (by decide : 1 < 2) p.1
    · rw [hlog]
      exact Nat.pow_log_le_self 2 hq.fst_pos.ne'
    · rw [hlog]
      simpa only [pow_succ, mul_comm] using
        Nat.lt_pow_succ_log_self (by decide : 1 < 2) q.1
  · exact (hp.eq_one_pair_of_modulus_le_one (by omega)).trans
      (hq.eq_one_pair_of_modulus_le_one (by omega)).symm

/-- The full finite CRT logarithmic counting bound, with actual divisibilities,
actual gcds, and the actual natural-number radical in its assumptions. -/
theorem crt_certificate_packet_card_le {U V W T : ℕ} (s : Finset (ℕ × ℕ))
    (hUV : Nat.Coprime U V) (hUW : Nat.Coprime U W)
    (hVW : Nat.Coprime V W)
    (hcert : ∀ p ∈ s, IsCRTCertificate U V W p)
    (hheight : ∀ p ∈ s, p.1 + p.2 ≤ T) :
    s.card ≤ Nat.log 2 T + 1 := by
  classical
  have hcard : s.card ≤ (Finset.range (Nat.log 2 T + 1)).card := by
    apply Finset.card_le_card_of_injOn (fun p : ℕ × ℕ => Nat.log 2 p.1)
    · intro p hp
      apply Finset.mem_range.mpr
      have hpT : p.1 ≤ T := (Nat.le_add_right p.1 p.2).trans (hheight p hp)
      exact Nat.lt_succ_of_le (Nat.log_mono_right hpT)
    · intro p hp q hq hlog
      exact crt_certificate_eq_of_log_eq hUV hUW hVW (hcert p hp) (hcert q hq) hlog
  simpa using hcard

/-- A zero height bound makes the positive candidate set empty. -/
theorem crt_certificate_packet_eq_empty_of_height_zero {U V W : ℕ}
    (s : Finset (ℕ × ℕ))
    (hcert : ∀ p ∈ s, IsCRTCertificate U V W p)
    (hheight : ∀ p ∈ s, p.1 + p.2 ≤ 0) : s = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have hpos := (hcert p hp).fst_pos
  have hbound := hheight p hp
  omega

/-- A concrete finite set of all CRT-certified primitive positive pairs up
to height `T`. Both coordinates and their sum are bounded by the height. -/
noncomputable def crtCertifiedUpTo (U V W T : ℕ) : Finset (ℕ × ℕ) := by
  classical
  exact ((Finset.Icc 1 T) ×ˢ (Finset.Icc 1 T)).filter
    (fun p => IsCRTCertificate U V W p ∧ p.1 + p.2 ≤ T)

theorem crtCertifiedUpTo_card_le {U V W T : ℕ}
    (hUV : Nat.Coprime U V) (hUW : Nat.Coprime U W)
    (hVW : Nat.Coprime V W) :
    (crtCertifiedUpTo U V W T).card ≤ Nat.log 2 T + 1 := by
  classical
  apply crt_certificate_packet_card_le _ hUV hUW hVW
  · intro p hp
    exact ((Finset.mem_filter.mp hp).2).1
  · intro p hp
    exact ((Finset.mem_filter.mp hp).2).2

/-- Taking the union over every inherited divisor template multiplies the
logarithmic bound only by the three actual divisor counts. -/
theorem inherited_template_union_card_le {a b c T : ℕ}
    (hab : Nat.Coprime a b) (hac : Nat.Coprime a c) (hbc : Nat.Coprime b c) :
    (((a.divisors ×ˢ b.divisors) ×ˢ c.divisors).biUnion
      (fun d => crtCertifiedUpTo d.1.1 d.1.2 d.2 T)).card ≤
      a.divisors.card * b.divisors.card * c.divisors.card * (Nat.log 2 T + 1) := by
  classical
  calc
    _ ≤ ∑ d ∈ ((a.divisors ×ˢ b.divisors) ×ˢ c.divisors),
        (crtCertifiedUpTo d.1.1 d.1.2 d.2 T).card := Finset.card_biUnion_le
    _ ≤ ∑ _d ∈ ((a.divisors ×ˢ b.divisors) ×ˢ c.divisors),
        (Nat.log 2 T + 1) := by
      apply Finset.sum_le_sum
      intro d hd
      rcases Finset.mem_product.mp hd with ⟨hpair, hc'⟩
      rcases Finset.mem_product.mp hpair with ⟨ha', hb'⟩
      have hdA := (Nat.mem_divisors.mp ha').1
      have hdB := (Nat.mem_divisors.mp hb').1
      have hdC := (Nat.mem_divisors.mp hc').1
      exact crtCertifiedUpTo_card_le (hab.of_dvd hdA hdB)
        (hac.of_dvd hdA hdC) (hbc.of_dvd hdB hdC)
    _ = _ := by simp

/-- The radical bound for the square-completion construction uses actual
squares, and is stronger than merely charging the full cofactor sizes. -/
theorem square_completion_radical_bound {a b c x y z : ℕ}
    (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) ≤
      radical (a * b * c) * x * y * z := by
  have hnonzero : x * y * z ≠ 0 := ne_of_gt (mul_pos (mul_pos hx hy) hz)
  calc
    radical ((a * x ^ 2) * (b * y ^ 2) * (c * z ^ 2)) =
        radical ((a * b * c) * (x * y * z) ^ 2) := by congr 1; ring
    _ ≤ radical (a * b * c) * radical ((x * y * z) ^ 2) := radical_mul_le _ _
    _ = radical (a * b * c) * radical (x * y * z) := by
      rw [radical_pow _ (by decide : 2 ≠ 0)]
    _ ≤ radical (a * b * c) * (x * y * z) :=
      Nat.mul_le_mul_left _ (Nat.radical_le_self_iff.mpr hnonzero)
    _ = radical (a * b * c) * x * y * z := by ring

/-- The degree-two integer parametrization of the actual seed conic. -/
theorem square_completion_parameter_identity (a b m n : ℤ) :
    a * (a * n ^ 2 + b * m ^ 2 - 2 * n * (a * n + b * m)) ^ 2 +
      b * (a * n ^ 2 + b * m ^ 2 - 2 * m * (a * n + b * m)) ^ 2 =
      (a + b) * (a * n ^ 2 + b * m ^ 2) ^ 2 := by
  ring

/-- On the positive conic the multiplier product is at least `z²`.
This is the arithmetic source of the square-certificate height cutoff. -/
theorem square_completion_sq_le_product {a b c x y z : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hx : 0 < x) (hy : 0 < y)
    (hab : a + b = c) (hconic : a * x ^ 2 + b * y ^ 2 = c * z ^ 2) :
    z ^ 2 ≤ x * y * z := by
  have hmax : z ≤ max x y := by
    by_contra h
    have hxz : x < z := lt_of_le_of_lt (le_max_left x y) (by omega)
    have hyz : y < z := lt_of_le_of_lt (le_max_right x y) (by omega)
    have hx2 : x ^ 2 < z ^ 2 := by nlinarith
    have hy2 : y ^ 2 < z ^ 2 := by nlinarith
    have hax := Nat.mul_lt_mul_of_pos_left hx2 ha
    have hby := Nat.mul_lt_mul_of_pos_left hy2 hb
    rw [← hab] at hconic
    nlinarith
  have hxy : max x y ≤ x * y := by
    apply max_le
    · simpa using Nat.mul_le_mul_left x hy
    · simpa using Nat.mul_le_mul_right y hx
  simpa only [pow_two] using Nat.mul_le_mul_right z (hmax.trans hxy)

/-- A genuine square-completion certificate forces the stated height inequality.
The real exponent is unrestricted here because only the certificate is used. -/
theorem square_completion_certificate_height {a b c x y z R : ℕ} {μ : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hx : 0 < x) (hy : 0 < y)
    (hab : a + b = c) (hconic : a * x ^ 2 + b * y ^ 2 = c * z ^ 2)
    (hcert : ((R * x * y * z : ℕ) : ℝ) ≤ ((c * z ^ 2 : ℕ) : ℝ) ^ μ) :
    (R : ℝ) * (c * z ^ 2 : ℕ) ≤ (c : ℝ) * ((c * z ^ 2 : ℕ) : ℝ) ^ μ := by
  have hprod : (z ^ 2 : ℕ) ≤ x * y * z :=
    square_completion_sq_le_product ha hb hx hy hab hconic
  have hnat : R * (c * z ^ 2) ≤ c * (R * x * y * z) := by
    nlinarith [Nat.mul_le_mul_left (R * c) hprod]
  have hreal : (R : ℝ) * (c * z ^ 2 : ℕ) ≤ (c : ℝ) * (R * x * y * z : ℕ) := by
    exact_mod_cast hnat
  exact hreal.trans (mul_le_mul_of_nonneg_left hcert (Nat.cast_nonneg c))

/-- The seed radical times `abc` dominates `c²`, with no abc hypothesis. -/
theorem seed_radical_product_ge_sq {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hab : a + b = c) :
    c ^ 2 ≤ radical (a * b * c) * (a * b * c) := by
  have hc : 2 ≤ c := by omega
  have hablower : c ≤ a * b + 1 := by
    have ha' : (1 : ℤ) ≤ a := by exact_mod_cast ha
    have hb' : (1 : ℤ) ≤ b := by exact_mod_cast hb
    have hnonneg : 0 ≤ (a - 1 : ℤ) * (b - 1 : ℤ) :=
      mul_nonneg (by omega) (by omega)
    zify at hab ⊢
    nlinarith
  have htwo : c ≤ 2 * (a * b) := by
    have habpos : 0 < a * b := Nat.mul_pos ha hb
    omega
  have hP : 2 ≤ a * b * c := by nlinarith
  have hR : 2 ≤ radical (a * b * c) := Nat.two_le_radical_iff.mpr hP
  have hbound := Nat.mul_le_mul_right (a * b * c) hR
  nlinarith [Nat.mul_le_mul_right c htwo]

/-- Each of the currently available BBLT exponents exceeds the square-fibre
certificate exponent `μ/2` throughout the exceptional range. -/
theorem half_lt_bblt_exponent {μ : ℝ} (hμ : 0 < μ) (hμ1 : μ < 1) :
    μ / 2 < min (2 * μ / 3) (min ((23 * μ + 3) / 40) (3 / 5)) := by
  simp only [lt_min_iff]
  constructor
  · linarith
  constructor <;> linarith

#print axioms crt_cross_modEq
#print axioms inherited_radical_bound
#print axioms inherited_cofactor_certificate_budget
#print axioms crt_certificate_unique_in_strip
#print axioms crt_certificate_packet_card_le
#print axioms crtCertifiedUpTo_card_le
#print axioms inherited_template_union_card_le
#print axioms square_completion_radical_bound
#print axioms square_completion_parameter_identity
#print axioms square_completion_sq_le_product
#print axioms square_completion_certificate_height
#print axioms seed_radical_product_ge_sq

end AnalyticAmplificationContinuation20260830
end IUTThreeClosures
