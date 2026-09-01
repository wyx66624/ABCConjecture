import IUTThreeClosures.AffineDensityAttack20260901

/-!
# A two-arm CRT packet for the affine density attack

This module isolates two rigorous facts about the affine family from
`AffineDensityAttack20260901`.

* Simultaneous long-arm exceptional inequalities force two coprime divisors of
  the corresponding powerful parts.
* The diagonal subfamily attached to the seed `(1, 242, 243)` contains an
  explicit CRT packet of positive density within that diagonal on which both
  long-arm inequalities hold.  The first member is nevertheless not a
  three-quarter exception.  Thus the two inequalities alone are not a
  sufficient criterion for exceptionality.

The mathematical proofs and the exact integer factorisations used to discover
the certificate are recorded in
`research/ABC_AFFINE_TWO_ARM_CRT_PACKET_2026_09_01.md`.
-/

namespace IUTThreeClosures
namespace AffineTwoArmCRTPacket20260901

open UniqueFactorizationMonoid

/-- A square divisor contributes its prime to the powerful part. -/
theorem prime_dvd_powerfulPart_of_square_dvd {p n : ℕ}
    (hp : p.Prime) (hn : 0 < n) (hpn : p ^ 2 ∣ n) :
    p ∣ abcPowerfulPart n := by
  have hfactor := abcRadical_mul_abcPowerfulPart n
  have hr : abcRadical n ≠ 0 := by
    intro hz
    rw [hz, zero_mul] at hfactor
    omega
  have hq : abcPowerfulPart n ≠ 0 := by
    intro hz
    rw [hz, mul_zero] at hfactor
    omega
  have hnfac : 2 ≤ n.factorization p :=
    (hp.pow_dvd_iff_le_factorization hn.ne').mp hpn
  have hsf : Squarefree (abcRadical n) := by
    rw [abcRadical_eq_natRadical]
    exact UniqueFactorizationMonoid.squarefree_radical
  have hrfac : (abcRadical n).factorization p ≤ 1 :=
    hsf.natFactorization_le_one p
  have heq := congrArg (fun z : ℕ => z.factorization p) hfactor
  rw [Nat.factorization_mul hr hq] at heq
  change (abcRadical n).factorization p +
    (abcPowerfulPart n).factorization p = n.factorization p at heq
  apply (hp.dvd_iff_one_le_factorization hq).2
  omega

/-- Every squarefree `D` with `D² ∣ n` divides the powerful part of `n`. -/
theorem squarefree_dvd_powerfulPart_of_square_dvd {D n : ℕ}
    (hD : Squarefree D) (hn : 0 < n) (hDn : D ^ 2 ∣ n) :
    D ∣ abcPowerfulPart n := by
  have hq : abcPowerfulPart n ≠ 0 := by
    intro hz
    have hfactor := abcRadical_mul_abcPowerfulPart n
    rw [hz, mul_zero] at hfactor
    omega
  rw [← Nat.factorization_prime_le_iff_dvd hD.ne_zero hq]
  intro p hp
  have hDfac : D.factorization p ≤ 1 := hD.natFactorization_le_one p
  by_cases hz : D.factorization p = 0
  · simp [hz]
  have hpD : p ∣ D :=
    (hp.dvd_iff_one_le_factorization hD.ne_zero).2
      (Nat.one_le_iff_ne_zero.mpr hz)
  have hp2D2 : p ^ 2 ∣ D ^ 2 := pow_dvd_pow_of_dvd hpD 2
  have hpq : p ∣ abcPowerfulPart n :=
    prime_dvd_powerfulPart_of_square_dvd hp hn (hp2D2.trans hDn)
  have hqfac : 1 ≤ (abcPowerfulPart n).factorization p :=
    (hp.dvd_iff_one_le_factorization hq).mp hpq
  omega

/-- The seed `(1, 242, 243)` has radical `66`. -/
theorem seed_radical_1_242_243 : abcRadical (1 * 242 * 243) = 66 := by
  rw [show 1 * 242 * 243 = 2 * (3 ^ 5 * 11 ^ 2) by norm_num,
    abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_of_prime
      (by exact (by norm_num : Nat.Prime 2).prime),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 3).prime) (by norm_num),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 11).prime) (by norm_num)]
  norm_num

/-- Two coprime long arms satisfying the same exceptional gate carry
coprime powerful parts whose product has a quadratic lower bound. -/
theorem joint_long_arm_carrier {V W T K : ℕ}
    (hVW : Nat.Coprime V W)
    (hV : T < K * abcPowerfulPart V)
    (hW : T < K * abcPowerfulPart W) :
    Nat.Coprime (abcPowerfulPart V) (abcPowerfulPart W) ∧
      abcPowerfulPart V * abcPowerfulPart W ∣ V * W ∧
      T ^ 2 < K ^ 2 * (abcPowerfulPart V * abcPowerfulPart W) := by
  refine ⟨Nat.Coprime.of_dvd (abcPowerfulPart_dvd V)
    (abcPowerfulPart_dvd W) hVW, Nat.mul_dvd_mul
      (abcPowerfulPart_dvd V) (abcPowerfulPart_dvd W), ?_⟩
  by_cases hT : T = 0
  · subst T
    have hKV : 0 < K * abcPowerfulPart V := by omega
    have hKW : 0 < K * abcPowerfulPart W := by omega
    have hp : 0 < (K * abcPowerfulPart V) *
        (K * abcPowerfulPart W) := mul_pos hKV hKW
    change 0 < K ^ 2 * (abcPowerfulPart V * abcPowerfulPart W)
    calc
      0 < (K * abcPowerfulPart V) * (K * abcPowerfulPart W) := hp
      _ = K ^ 2 * (abcPowerfulPart V * abcPowerfulPart W) := by ring
  have hTpos : 0 < T := Nat.pos_of_ne_zero hT
  calc
    T ^ 2 = T * T := by ring
    _ < (K * abcPowerfulPart V) * (K * abcPowerfulPart W) :=
      mul_lt_mul hV hW.le hTpos (Nat.zero_le _)
    _ = K ^ 2 * (abcPowerfulPart V * abcPowerfulPart W) := by ring

/-- If a coefficient is a unit modulo a nonzero modulus, its affine translate
`1 + alpha * r` has a root represented inside the standard residue interval. -/
theorem exists_local_root {alpha m : ℕ} (hm : m ≠ 0)
    (h : alpha.Coprime m) :
    ∃ r : ℕ, r < m ∧ m ∣ 1 + alpha * r := by
  letI : NeZero m := ⟨hm⟩
  let u : (ZMod m)ˣ := ZMod.unitOfCoprime alpha h
  let x : ZMod m := -(u⁻¹ : ZMod m)
  refine ⟨x.val, ZMod.val_lt x, (ZMod.natCast_eq_zero_iff _ _).mp ?_⟩
  rw [Nat.cast_add, Nat.cast_one, Nat.cast_mul]
  simp only [ZMod.natCast_zmod_val]
  dsimp only [x, u]
  rw [← ZMod.coe_unitOfCoprime alpha h]
  rw [mul_neg]
  change 1 + -((((ZMod.unitOfCoprime alpha h) *
    (ZMod.unitOfCoprime alpha h)⁻¹ : (ZMod m)ˣ) : ZMod m)) = 0
  simp

/-- Two coprime square moduli and two invertible affine coefficients determine
one simultaneous-root residue class modulo their product. -/
theorem simultaneous_affine_roots {alpha beta D F : ℕ}
    (hD : 0 < D) (hF : 0 < F) (hDF : D.Coprime F)
    (ha : alpha.Coprime D) (hb : beta.Coprime F) :
    ∃ k0 : ℕ, k0 < D ^ 2 * F ^ 2 ∧ ∀ k : ℕ,
      (D ^ 2 ∣ 1 + alpha * k ∧ F ^ 2 ∣ 1 + beta * k) ↔
        k ≡ k0 [MOD D ^ 2 * F ^ 2] := by
  have hD0 : D ^ 2 ≠ 0 := pow_ne_zero 2 hD.ne'
  have hF0 : F ^ 2 ≠ 0 := pow_ne_zero 2 hF.ne'
  have ha2 : alpha.Coprime (D ^ 2) := ha.pow_right 2
  have hb2 : beta.Coprime (F ^ 2) := hb.pow_right 2
  rcases exists_local_root hD0 ha2 with ⟨rD, _hrDlt, hrD⟩
  rcases exists_local_root hF0 hb2 with ⟨rF, _hrFlt, hrF⟩
  have hDF2 : (D ^ 2).Coprime (F ^ 2) := hDF.pow 2 2
  let z := Nat.chineseRemainder hDF2 rD rF
  refine ⟨z, Nat.chineseRemainder_lt_mul hDF2 rD rF hD0 hF0, ?_⟩
  intro k
  constructor
  · rintro ⟨hkD, hkF⟩
    have hformD : 1 + alpha * k ≡ 1 + alpha * rD [MOD D ^ 2] :=
      (Nat.modEq_zero_iff_dvd.mpr hkD).trans
        (Nat.modEq_zero_iff_dvd.mpr hrD).symm
    have hmulD : alpha * k ≡ alpha * rD [MOD D ^ 2] :=
      Nat.ModEq.add_left_cancel' 1 hformD
    have hkD' : k ≡ rD [MOD D ^ 2] :=
      Nat.ModEq.cancel_left_of_coprime ha2.symm hmulD
    have hformF : 1 + beta * k ≡ 1 + beta * rF [MOD F ^ 2] :=
      (Nat.modEq_zero_iff_dvd.mpr hkF).trans
        (Nat.modEq_zero_iff_dvd.mpr hrF).symm
    have hmulF : beta * k ≡ beta * rF [MOD F ^ 2] :=
      Nat.ModEq.add_left_cancel' 1 hformF
    have hkF' : k ≡ rF [MOD F ^ 2] :=
      Nat.ModEq.cancel_left_of_coprime hb2.symm hmulF
    exact Nat.chineseRemainder_modEq_unique hDF2 hkD' hkF'
  · intro hk
    have hkD0 : k ≡ z [MOD D ^ 2] :=
      hk.of_dvd (dvd_mul_right (D ^ 2) (F ^ 2))
    have hkF0 : k ≡ z [MOD F ^ 2] :=
      hk.of_dvd (dvd_mul_left (F ^ 2) (D ^ 2))
    have hkD' : k ≡ rD [MOD D ^ 2] := hkD0.trans z.prop.1
    have hkF' : k ≡ rF [MOD F ^ 2] := hkF0.trans z.prop.2
    constructor
    · apply Nat.modEq_zero_iff_dvd.mp
      exact ((hkD'.mul_left alpha).add_left 1).trans
        (Nat.modEq_zero_iff_dvd.mpr hrD)
    · apply Nat.modEq_zero_iff_dvd.mp
      exact ((hkF'.mul_left beta).add_left 1).trans
        (Nat.modEq_zero_iff_dvd.mpr hrF)

/-- The first affine coefficient on the diagonal `h = k`. -/
def diagonalU (R k : ℕ) : ℕ := 1 + R * k

/-- The second affine coefficient on the diagonal `h = k`. -/
def diagonalV (R c k : ℕ) : ℕ := 1 + (R * (c + 1)) * k

/-- The third affine coefficient on the diagonal `h = k`. -/
def diagonalW (R b k : ℕ) : ℕ := 1 + (R * (b + 1)) * k

/-- Diagonal parameters are automatically admissible. -/
theorem diagonal_admissible (R k : ℕ) : Nat.Coprime (diagonalU R k) k := by
  rw [diagonalU]
  exact (Nat.coprime_add_mul_right_left (m := 1) (n := k) (k := R)).2
    (Nat.coprime_one_left k)

/-- The affine `abc` equation restricted to the diagonal. -/
theorem diagonal_equation {a b c R k : ℕ} (hsum : a + b = c) :
    a * diagonalU R k + b * diagonalV R c k =
      c * diagonalW R b k := by
  simp only [diagonalU, diagonalV, diagonalW]
  rw [← hsum]
  ring

/-- General diagonal CRT packet: the two prescribed square-divisor conditions
hold exactly on one residue class. -/
theorem diagonal_crt_packet {R b c D F : ℕ}
    (hD : 0 < D) (hF : 0 < F) (hDF : D.Coprime F)
    (hVunit : (R * (c + 1)).Coprime D)
    (hWunit : (R * (b + 1)).Coprime F) :
    ∃ k0 : ℕ, k0 < D ^ 2 * F ^ 2 ∧ ∀ k : ℕ,
      (D ^ 2 ∣ diagonalV R c k ∧ F ^ 2 ∣ diagonalW R b k) ↔
        k ≡ k0 [MOD D ^ 2 * F ^ 2] := by
  simpa only [diagonalV, diagonalW] using
    simultaneous_affine_roots hD hF hDF hVunit hWunit

/-- The CRT progression forcing `5² ∣ V` and `7² ∣ W`. -/
def packetK (t : ℕ) : ℕ := 356 + 1225 * t

theorem packet_identities (t : ℕ) :
    diagonalV 66 243 (packetK t) = 25 * (229321 + 789096 * t) ∧
      diagonalW 66 242 (packetK t) = 49 * (116521 + 400950 * t) := by
  simp only [diagonalV, diagonalW, packetK]
  constructor <;> ring

theorem packet_square_divisors (t : ℕ) :
    25 ∣ diagonalV 66 243 (packetK t) ∧
      49 ∣ diagonalW 66 242 (packetK t) := by
  rcases packet_identities t with ⟨hV, hW⟩
  rw [hV, hW]
  exact ⟨dvd_mul_right 25 _, dvd_mul_right 49 _⟩

theorem powerfulPart_pos {n : ℕ} (hn : 0 < n) : 0 < abcPowerfulPart n := by
  have hfactor := abcRadical_mul_abcPowerfulPart n
  by_contra hz
  have hzero : abcPowerfulPart n = 0 := Nat.eq_zero_of_not_pos hz
  rw [hzero, mul_zero] at hfactor
  omega

theorem squarefree_carrier_le_powerfulPart {D n : ℕ}
    (hD : Squarefree D) (hn : 0 < n) (hDn : D ^ 2 ∣ n) :
    D ≤ abcPowerfulPart n :=
  Nat.le_of_dvd (powerfulPart_pos hn)
    (squarefree_dvd_powerfulPart_of_square_dvd hD hn hDn)

/-- On the unique diagonal CRT class, admissibility is automatic and both
squarefree carriers divide their respective powerful parts. -/
theorem diagonal_crt_excess_packet {R b c D F : ℕ}
    (hDpos : 0 < D) (hFpos : 0 < F) (hDF : D.Coprime F)
    (hDsf : Squarefree D) (hFsf : Squarefree F)
    (hVunit : (R * (c + 1)).Coprime D)
    (hWunit : (R * (b + 1)).Coprime F) :
    ∃ k0 : ℕ, k0 < D ^ 2 * F ^ 2 ∧ ∀ k : ℕ,
      k ≡ k0 [MOD D ^ 2 * F ^ 2] →
        Nat.Coprime (diagonalU R k) k ∧
          D ∣ abcPowerfulPart (diagonalV R c k) ∧
          F ∣ abcPowerfulPart (diagonalW R b k) := by
  rcases diagonal_crt_packet hDpos hFpos hDF hVunit hWunit with
    ⟨k0, hk0, hclass⟩
  refine ⟨k0, hk0, fun k hk => ?_⟩
  have hsquares := (hclass k).2 hk
  exact ⟨diagonal_admissible R k,
    squarefree_dvd_powerfulPart_of_square_dvd hDsf
      (by simp [diagonalV]) hsquares.1,
    squarefree_dvd_powerfulPart_of_square_dvd hFsf
      (by simp [diagonalW]) hsquares.2⟩

/-- Every point of the packet has simultaneous lower bounds on the two
powerful parts. -/
theorem packet_two_arm_excess (t : ℕ) :
    5 ≤ abcPowerfulPart (diagonalV 66 243 (packetK t)) ∧
      7 ≤ abcPowerfulPart (diagonalW 66 242 (packetK t)) := by
  have hs := packet_square_divisors t
  constructor
  · apply squarefree_carrier_le_powerfulPart
      (by exact (by norm_num : Nat.Prime 5).squarefree) (by simp [diagonalV])
    simpa using hs.1
  · apply squarefree_carrier_le_powerfulPart
      (by exact (by norm_num : Nat.Prime 7).squarefree) (by simp [diagonalW])
    simpa using hs.2

/-- Both necessary long-arm gates from the exponent-three/four analysis hold
throughout the CRT packet. -/
theorem packet_two_arm_gate (t : ℕ) :
    66 * 243 < 8192 * abcPowerfulPart (diagonalV 66 243 (packetK t)) ∧
      66 * 243 < 8192 * abcPowerfulPart
        (diagonalW 66 242 (packetK t)) := by
  have h := packet_two_arm_excess t
  constructor <;> omega

/-- Exact characterization of the indices whose packet values lie in the
canonical upper-half interval. -/
theorem packet_in_upper_half_iff (t : ℕ) :
    (779890651873 / 2 < packetK t ∧ packetK t ≤ 779890651873) ↔
      318322715 ≤ t ∧ t ≤ 636645429 := by
  simp only [packetK]
  omega

/-- The indicated contiguous index interval supplies `318322715` packet
members in the canonical upper-half parameter box. -/
theorem packet_in_upper_half {t : ℕ}
    (hlo : 318322715 ≤ t) (hi : t ≤ 636645429) :
    779890651873 / 2 < packetK t ∧ packetK t ≤ 779890651873 := by
  exact (packet_in_upper_half_iff t).2 ⟨hlo, hi⟩

theorem packetK_injective : Function.Injective packetK := by
  intro t₁ t₂ h
  simp only [packetK] at h
  omega

theorem packet_index_count :
    (Finset.Icc 318322715 636645429).card = 318322715 := by
  norm_num

/-- The actual packet values in the canonical interval are distinct and have
the asserted exact cardinality. -/
def canonicalPacket : Finset ℕ :=
  (Finset.Icc 318322715 636645429).image packetK

theorem canonicalPacket_card : canonicalPacket.card = 318322715 := by
  rw [canonicalPacket,
    Finset.card_image_of_injective _ packetK_injective,
    packet_index_count]

/-- The first canonical member of the packet, packaged as a primitive
`ABCPoint`. -/
def counterexamplePoint : ABCPoint where
  a := 25736391531247
  b := 1519682447137014050
  c := 1519708183528545297
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by norm_num [PairwiseCoprimeABC]

theorem short_carrier_squarefree :
    Squarefree (139267 * 2119433 * 17431) := by
  rw [Nat.squarefree_mul_iff, Nat.squarefree_mul_iff]
  constructor
  · norm_num
  constructor
  · constructor
    · norm_num
    constructor
    · exact (by norm_num : Nat.Prime 139267).squarefree
    · exact (by norm_num : Nat.Prime 2119433).squarefree
  · exact (by norm_num : Nat.Prime 17431).squarefree

theorem short_carrier_dvd_counterexample :
    139267 * 2119433 * 17431 ∣
      counterexamplePoint.a * counterexamplePoint.b * counterexamplePoint.c := by
  norm_num [counterexamplePoint]

theorem squarefree_dvd_abcRadical {D n : ℕ}
    (hD : Squarefree D) (hn : n ≠ 0) (hDn : D ∣ n) :
    D ∣ abcRadical n := by
  rw [abcRadical_eq_natRadical]
  exact (UniqueFactorizationMonoid.dvd_radical_iff hD.isRadical hn).2 hDn

/-- A short squarefree divisor of the output radical already makes the
three-quarter exceptional inequality impossible. -/
theorem counterexample_not_threeQuarter :
    ¬ abcRadical
        (counterexamplePoint.a * counterexamplePoint.b * counterexamplePoint.c) ^ 4 <
        counterexamplePoint.c ^ 3 := by
  let D : ℕ := 139267 * 2119433 * 17431
  let N : ℕ := counterexamplePoint.a * counterexamplePoint.b *
    counterexamplePoint.c
  have hD : Squarefree D := short_carrier_squarefree
  have hDN : D ∣ N := short_carrier_dvd_counterexample
  have hN : N ≠ 0 := by norm_num [N, counterexamplePoint]
  have hDrad : D ∣ abcRadical N := squarefree_dvd_abcRadical hD hN hDN
  have hDle : D ≤ abcRadical N := Nat.le_of_dvd (abcRadical_pos N) hDrad
  have hpow : D ^ 4 ≤ abcRadical N ^ 4 := Nat.pow_le_pow_left hDle 4
  have hsep : counterexamplePoint.c ^ 3 < D ^ 4 := by
    norm_num [counterexamplePoint, D]
  exact Nat.not_lt_of_ge (hsep.le.trans hpow)

/-- Complete formal certificate: this canonical admissible affine point meets
both two-arm gates but is not a three-quarter exception. -/
theorem counterexample_full_data :
    let h : ℕ := 389945326231
    let k : ℕ := 389945326231
    let U := 1 + 66 * h
    let V := 1 + 66 * (h + 243 * k)
    let W := 1 + 66 * (h + 242 * k)
    abcRadical (1 * 242 * 243) = 66 ∧
      1 + 242 = 243 ∧ Nat.Coprime 1 242 ∧
      66 < 243 ∧ 243 ^ 6 / (4 * 66) = 779890651873 ∧
      779890651873 / 2 < h ∧ h ≤ 779890651873 ∧
      779890651873 / 2 < k ∧ k ≤ 779890651873 ∧
      Nat.Coprime U k ∧
      U = counterexamplePoint.a ∧
      242 * V = counterexamplePoint.b ∧
      243 * W = counterexamplePoint.c ∧
      U ≤ 243 ^ 6 ∧ V ≤ 243 ^ 7 ∧ W ≤ 243 ^ 7 ∧
      counterexamplePoint.c < 243 ^ 8 ∧
      66 * 243 < 8192 * abcPowerfulPart V ∧
      66 * 243 < 8192 * abcPowerfulPart W ∧
      ¬ abcRadical
          (counterexamplePoint.a * counterexamplePoint.b * counterexamplePoint.c) ^ 4 <
          counterexamplePoint.c ^ 3 := by
  dsimp only
  refine ⟨seed_radical_1_242_243, by norm_num, by norm_num,
    by norm_num, by norm_num, by norm_num, by norm_num, by norm_num,
    by norm_num, by norm_num,
    by norm_num [counterexamplePoint], by norm_num [counterexamplePoint],
    by norm_num [counterexamplePoint], by norm_num, by norm_num, by norm_num,
    by norm_num [counterexamplePoint], ?_, ?_, counterexample_not_threeQuarter⟩
  · have h := (packet_two_arm_gate 318322715).1
    norm_num [packetK, diagonalV] at h ⊢
    exact h
  · have h := (packet_two_arm_gate 318322715).2
    norm_num [packetK, diagonalW] at h ⊢
    exact h

#print axioms squarefree_dvd_powerfulPart_of_square_dvd
#print axioms joint_long_arm_carrier
#print axioms simultaneous_affine_roots
#print axioms diagonal_crt_excess_packet
#print axioms packet_two_arm_gate
#print axioms packet_in_upper_half_iff
#print axioms packet_index_count
#print axioms canonicalPacket_card
#print axioms counterexample_full_data
#print axioms prime_dvd_powerfulPart_of_square_dvd
#print axioms seed_radical_1_242_243
#print axioms exists_local_root
#print axioms diagonal_admissible
#print axioms diagonal_equation
#print axioms diagonal_crt_packet
#print axioms packet_identities
#print axioms packet_square_divisors
#print axioms powerfulPart_pos
#print axioms squarefree_carrier_le_powerfulPart
#print axioms packet_two_arm_excess
#print axioms packet_in_upper_half
#print axioms packetK_injective
#print axioms short_carrier_squarefree
#print axioms short_carrier_dvd_counterexample
#print axioms squarefree_dvd_abcRadical
#print axioms counterexample_not_threeQuarter

end AffineTwoArmCRTPacket20260901
end IUTThreeClosures
