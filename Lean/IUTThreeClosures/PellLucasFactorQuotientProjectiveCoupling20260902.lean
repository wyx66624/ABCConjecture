/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellLucasCorrelatedAllOrderExclusion20260901
import IUTThreeClosures.PellOddKernelThirdOrderPacket20260901

/-!
# Factor quotients and endpoint curvature in the Pell--Lucas packet

The ordinary mathematical proofs precede this module in
`research/ABC_PELL_LUCAS_FACTOR_QUOTIENT_PROJECTIVE_COUPLING_2026_09_02.md`.

This file kernel-checks the new algebraic interface:

* the cubic elementary-symmetric fingerprint of a quotient repeated three
  times;
* the fourth-modulus companion jets read from the two third-order
  factor-quotient ledgers;
* the exact highest-adjacent projective determinant;
* coprimality and sharpness of its `U^2` divisor; and
* exact finite certificates for the local-ledger and index-seven boundary
  counterexamples.

No Lucas multiplication theorem, rank theorem, perfect-power theorem,
squarefull packet, character-incidence theorem, or abc statement is added as
an axiom.  Arithmetic realization data enter generic results only as explicit
hypotheses.
-/

namespace IUTThreeClosures
namespace PellLucasFactorQuotientProjectiveCoupling20260902

open PellOddKernelThirdOrderPacket20260901

/-! ## A depth-three carrier's cubic fingerprint -/

/-- Repeating one factor quotient three times contributes a fixed cubic
fingerprint to the first three elementary-symmetric coefficients.  Extra
copies, or all other factor quotients, remain in `rest`. -/
theorem tripleCarrier_coefficients (t : ℤ) (rest : List ℤ) :
    ((t :: t :: t :: rest).sum,
      pairCoefficient (t :: t :: t :: rest),
      tripleCoefficient (t :: t :: t :: rest)) =
    (3 * t + rest.sum,
      3 * t ^ 2 + 3 * t * rest.sum + pairCoefficient rest,
      t ^ 3 + 3 * t ^ 2 * rest.sum +
        3 * t * pairCoefficient rest + tripleCoefficient rest) := by
  simp only [List.sum_cons, pairCoefficient, tripleCoefficient]
  ring_nf

/-- The minimal positive-channel depth-three carrier has coefficient triple
`(3*k,3*k^2,k^3)`. -/
theorem positiveCarrier_minimal_coefficients (k : ℤ) :
    (([k, k, k] : List ℤ).sum,
      pairCoefficient [k, k, k], tripleCoefficient [k, k, k]) =
      (3 * k, 3 * k ^ 2, k ^ 3) := by
  simpa [pairCoefficient, tripleCoefficient] using
    tripleCarrier_coefficients k []

/-- For an opposite residue `r = -1 + 2*ell*h`, the normalized quotient is
`-h`; its minimal cubic fingerprint has alternating signs. -/
theorem negativeCarrier_minimal_coefficients (h : ℤ) :
    (([-h, -h, -h] : List ℤ).sum,
      pairCoefficient [-h, -h, -h], tripleCoefficient [-h, -h, -h]) =
      (-3 * h, 3 * h ^ 2, -h ^ 3) := by
  norm_num [pairCoefficient, tripleCoefficient]
  ring_nf
  simp

/-! ## The companion value as a fourth-modulus quotient jet -/

/-- The `A`-channel expression for the companion through the third quotient
digit. -/
def companionAJet (x K C H : ℤ) : ℤ :=
  6 + 8 * x * K + x ^ 2 * (8 * C + 4 * K ^ 2) +
    x ^ 3 * (8 * H + 8 * K * C)

/-- The normalized `B`-channel expression for the same companion. -/
def companionBJet (x K C H : ℤ) : ℤ :=
  6 + 16 * x * K + x ^ 2 * (16 * C + 8 * K ^ 2) +
    x ^ 3 * (16 * H + 16 * K * C)

/-- The complete third-order coefficient ledger obtained from the two
factor-quotient channels. -/
def completeThirdOrderLedger
    (ell KA KB CA CB HA HB : ℤ) : ℤ :=
  KA - 2 * KB + ell * (KA ^ 2 - 2 * KB ^ 2) +
    2 * ell * (CA - 2 * CB) +
    4 * ell ^ 2 * (HA - 2 * HB + KA * CA - 2 * KB * CB) +
    4 * ell ^ 3 * (CA ^ 2 - 2 * CB ^ 2)

/-- Exact comparison between the difference of the two companion jets and
the complete third-order ledger.  This equality records the factor of eight
that would be lost by trying to reverse the jet congruence. -/
theorem companionJets_difference_exact
    (ell KA KB CA CB HA HB : ℤ) :
    companionAJet (2 * ell) KA CA HA -
        companionBJet (2 * ell) KB CB HB =
      16 * ell * completeThirdOrderLedger ell KA KB CA CB HA HB -
        64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2) := by
  simp only [companionAJet, companionBJet, completeThirdOrderLedger]
  ring

/-- The complete ledger modulo `8*ell^3` implies equality of the companion
jets modulo `(2*ell)^4`. -/
theorem companionJets_modEq_of_completeThirdOrderLedger
    (ell KA KB CA CB HA HB : ℤ)
    (hledger : completeThirdOrderLedger ell KA KB CA CB HA HB ≡ 0
      [ZMOD 8 * ell ^ 3]) :
    companionAJet (2 * ell) KA CA HA ≡
      companionBJet (2 * ell) KB CB HB [ZMOD (2 * ell) ^ 4] := by
  apply Int.modEq_of_dvd
  rcases hledger.dvd with ⟨k, hk⟩
  refine ⟨8 * k + 4 * (CA ^ 2 - 2 * CB ^ 2), ?_⟩
  have hdiff := companionJets_difference_exact ell KA KB CA CB HA HB
  have hk' : -completeThirdOrderLedger ell KA KB CA CB HA HB =
      8 * ell ^ 3 * k := by
    simpa using hk
  calc
    companionBJet (2 * ell) KB CB HB -
        companionAJet (2 * ell) KA CA HA =
      -(companionAJet (2 * ell) KA CA HA -
        companionBJet (2 * ell) KB CB HB) := by ring
    _ = -(16 * ell * completeThirdOrderLedger ell KA KB CA CB HA HB -
        64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2)) := by rw [hdiff]
    _ = 16 * ell *
        (-completeThirdOrderLedger ell KA KB CA CB HA HB) +
        64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2) := by ring
    _ = (2 * ell) ^ 4 *
        (8 * k + 4 * (CA ^ 2 - 2 * CB ^ 2)) := by rw [hk']; ring

/-- Reversing the jet congruence recovers only the ledger modulo `ell^3`.
The nonzero-index hypothesis is necessary for cancellation. -/
theorem completeThirdOrderLedger_modEllCube_of_companionJets
    (ell KA KB CA CB HA HB : ℤ) (hell : ell ≠ 0)
    (hjets : companionAJet (2 * ell) KA CA HA ≡
      companionBJet (2 * ell) KB CB HB [ZMOD (2 * ell) ^ 4]) :
    completeThirdOrderLedger ell KA KB CA CB HA HB ≡ 0
      [ZMOD ell ^ 3] := by
  apply Int.modEq_of_dvd
  rcases hjets.dvd with ⟨k, hk⟩
  have hdiff := companionJets_difference_exact ell KA KB CA CB HA HB
  have hscaled :
      16 * ell * completeThirdOrderLedger ell KA KB CA CB HA HB =
        16 * ell * (ell ^ 3 *
          (4 * (CA ^ 2 - 2 * CB ^ 2) - k)) := by
    calc
      16 * ell * completeThirdOrderLedger ell KA KB CA CB HA HB =
        (companionAJet (2 * ell) KA CA HA -
          companionBJet (2 * ell) KB CB HB) +
          64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2) := by rw [hdiff]; ring
      _ = -(companionBJet (2 * ell) KB CB HB -
          companionAJet (2 * ell) KA CA HA) +
          64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2) := by ring
      _ = -((2 * ell) ^ 4 * k) +
          64 * ell ^ 4 * (CA ^ 2 - 2 * CB ^ 2) := by rw [hk]
      _ = 16 * ell * (ell ^ 3 *
          (4 * (CA ^ 2 - 2 * CB ^ 2) - k)) := by ring
  have hscale0 : (16 : ℤ) * ell ≠ 0 := mul_ne_zero (by norm_num) hell
  have hledgerExact :
      completeThirdOrderLedger ell KA KB CA CB HA HB =
        ell ^ 3 * (4 * (CA ^ 2 - 2 * CB ^ 2) - k) :=
    mul_left_cancel₀ hscale0 hscaled
  refine ⟨-(4 * (CA ^ 2 - 2 * CB ^ 2) - k), ?_⟩
  rw [hledgerExact]
  ring

/-- The loss of the factor eight in the reverse implication is genuine at
the coefficient level.  This tuple is not asserted to be Pell-realizable. -/
theorem jetEquality_losesEight_counterexample :
    completeThirdOrderLedger 3 27 0 0 0 0 0 = 2214 ∧
      companionAJet 6 27 0 0 ≡ companionBJet 6 0 0 0 [ZMOD 6 ^ 4] ∧
      ¬completeThirdOrderLedger 3 27 0 0 0 0 0 ≡ 0
        [ZMOD 8 * 3 ^ 3] := by
  norm_num [completeThirdOrderLedger, companionAJet, companionBJet, Int.ModEq]

/-- Substitution of the third-order `A`-channel quotient expansion into
`v = 4*A^2+2`. -/
theorem companionAJet_modEq
    (x a A v K C H : ℤ)
    (hA : A = 1 + x * a)
    (hv : v = 4 * A ^ 2 + 2)
    (ha : a ≡ K + x * C + x ^ 2 * H [ZMOD x ^ 3]) :
    v ≡ companionAJet x K C H [ZMOD x ^ 4] := by
  let a0 : ℤ := K + x * C + x ^ 2 * H
  have hlin : 8 * x * a ≡ 8 * x * a0 [ZMOD x ^ 4] := by
    apply Int.modEq_of_dvd
    rcases ha.dvd with ⟨k, hk⟩
    refine ⟨8 * k, ?_⟩
    have hk' : a0 - a = x ^ 3 * k := by simpa [a0] using hk
    rw [show 8 * x * a0 - 8 * x * a = 8 * x * (a0 - a) by ring, hk']
    ring
  have hquad : 4 * x ^ 2 * a ^ 2 ≡ 4 * x ^ 2 * a0 ^ 2 [ZMOD x ^ 4] := by
    apply Int.modEq_of_dvd
    rcases ha.dvd with ⟨k, hk⟩
    refine ⟨4 * x * k * (a0 + a), ?_⟩
    have hk' : a0 - a = x ^ 3 * k := by simpa [a0] using hk
    calc
      4 * x ^ 2 * a0 ^ 2 - 4 * x ^ 2 * a ^ 2 =
          4 * x ^ 2 * (a0 - a) * (a0 + a) := by ring
      _ = 4 * x ^ 2 * (x ^ 3 * k) * (a0 + a) := by rw [hk']
      _ = x ^ 4 * (4 * x * k * (a0 + a)) := by ring
  calc
    v = 6 + (8 * x * a + 4 * x ^ 2 * a ^ 2) := by rw [hv, hA]; ring
    _ ≡ 6 + (8 * x * a0 + 4 * x ^ 2 * a0 ^ 2) [ZMOD x ^ 4] :=
      (hlin.add hquad).add_left 6
    _ ≡ companionAJet x K C H [ZMOD x ^ 4] := by
      apply Int.modEq_of_dvd
      refine ⟨-(8 * K * H + 4 * C ^ 2 +
        8 * x * C * H + 4 * x ^ 2 * H ^ 2), ?_⟩
      simp [a0, companionAJet]
      ring

/-- Substitution of the third-order normalized `B`-channel quotient expansion
into `v = 8*B^2-2`.  The equality `hBsq` packages the sign-square
normalization `(s*B)^2=B^2`. -/
theorem companionBJet_modEq
    (x b B v K C H : ℤ)
    (hBsq : B ^ 2 = (1 + x * b) ^ 2)
    (hv : v = 8 * B ^ 2 - 2)
    (hb : b ≡ K + x * C + x ^ 2 * H [ZMOD x ^ 3]) :
    v ≡ companionBJet x K C H [ZMOD x ^ 4] := by
  let b0 : ℤ := K + x * C + x ^ 2 * H
  have hlin : 16 * x * b ≡ 16 * x * b0 [ZMOD x ^ 4] := by
    apply Int.modEq_of_dvd
    rcases hb.dvd with ⟨k, hk⟩
    refine ⟨16 * k, ?_⟩
    have hk' : b0 - b = x ^ 3 * k := by simpa [b0] using hk
    rw [show 16 * x * b0 - 16 * x * b = 16 * x * (b0 - b) by ring, hk']
    ring
  have hquad : 8 * x ^ 2 * b ^ 2 ≡ 8 * x ^ 2 * b0 ^ 2 [ZMOD x ^ 4] := by
    apply Int.modEq_of_dvd
    rcases hb.dvd with ⟨k, hk⟩
    refine ⟨8 * x * k * (b0 + b), ?_⟩
    have hk' : b0 - b = x ^ 3 * k := by simpa [b0] using hk
    calc
      8 * x ^ 2 * b0 ^ 2 - 8 * x ^ 2 * b ^ 2 =
          8 * x ^ 2 * (b0 - b) * (b0 + b) := by ring
      _ = 8 * x ^ 2 * (x ^ 3 * k) * (b0 + b) := by rw [hk']
      _ = x ^ 4 * (8 * x * k * (b0 + b)) := by ring
  calc
    v = 6 + (16 * x * b + 8 * x ^ 2 * b ^ 2) := by rw [hv, hBsq]; ring
    _ ≡ 6 + (16 * x * b0 + 8 * x ^ 2 * b0 ^ 2) [ZMOD x ^ 4] :=
      (hlin.add hquad).add_left 6
    _ ≡ companionBJet x K C H [ZMOD x ^ 4] := by
      apply Int.modEq_of_dvd
      refine ⟨-(16 * K * H + 8 * C ^ 2 +
        16 * x * C * H + 8 * x ^ 2 * H ^ 2), ?_⟩
      simp [b0, companionBJet]
      ring

/-- Direct `A`-factor-list form: the finite-product theorem supplies the
third quotient digit, and the companion identity reads it modulo `x^4`. -/
theorem companionAJet_of_factorProduct
    (x a A v : ℤ) (ts : List ℤ)
    (hx : x ≠ 0)
    (hA : A = 1 + x * a)
    (hprod : 1 + x * a = (ts.map fun t => 1 + x * t).prod)
    (hv : v = 4 * A ^ 2 + 2) :
    v ≡ companionAJet x ts.sum (pairCoefficient ts) (tripleCoefficient ts)
      [ZMOD x ^ 4] := by
  exact companionAJet_modEq x a A v ts.sum (pairCoefficient ts)
    (tripleCoefficient ts) hA hv
    (quotient_thirdOrder_of_product x a ts hx hprod)

/-- Direct normalized `B`-factor-list form of the companion jet. -/
theorem companionBJet_of_factorProduct
    (x b B v : ℤ) (ts : List ℤ)
    (hx : x ≠ 0)
    (hBsq : B ^ 2 = (1 + x * b) ^ 2)
    (hprod : 1 + x * b = (ts.map fun t => 1 + x * t).prod)
    (hv : v = 8 * B ^ 2 - 2) :
    v ≡ companionBJet x ts.sum (pairCoefficient ts) (tripleCoefficient ts)
      [ZMOD x ^ 4] := by
  exact companionBJet_modEq x b B v ts.sum (pairCoefficient ts)
    (tripleCoefficient ts) hBsq hv
    (quotient_thirdOrder_of_product x b ts hx hprod)

/-- Since both factor lists read the same companion, their fourth-modulus
jets agree. -/
theorem twoChannel_companionJets
    (x a b A B v KA KB CA CB HA HB : ℤ)
    (hA : A = 1 + x * a)
    (hBsq : B ^ 2 = (1 + x * b) ^ 2)
    (hvA : v = 4 * A ^ 2 + 2)
    (hvB : v = 8 * B ^ 2 - 2)
    (ha : a ≡ KA + x * CA + x ^ 2 * HA [ZMOD x ^ 3])
    (hb : b ≡ KB + x * CB + x ^ 2 * HB [ZMOD x ^ 3]) :
    companionAJet x KA CA HA ≡ companionBJet x KB CB HB [ZMOD x ^ 4] :=
  (companionAJet_modEq x a A v KA CA HA hA hvA ha).symm.trans
    (companionBJet_modEq x b B v KB CB HB hBsq hvB hb)

/-! ## Exact highest-adjacent projective curvature -/

/-- The unit quotient left after removing the projective factor `U^2`. -/
def endpointCurvature (v top : ℤ) : ℤ := 2 * v * top ^ 2

/-- The highest two adjacent correlated tails have an exact determinant,
not merely a congruence modulo `U^2`. -/
theorem endpointProjectiveCurvature_exact
    (ell U v aPrev aTop bPrev TPrev TTop : ℤ)
    (hPrev : (ell - 2) * aPrev = ell * bPrev)
    (hTPrev : TPrev = v * (bPrev + aTop * U ^ 2))
    (hTTop : TTop = v * aTop) :
    TPrev * (ell * aTop) -
        TTop * ((ell - 2) * (aPrev + aTop * U ^ 2)) =
      endpointCurvature v aTop * U ^ 2 := by
  rw [hTPrev, hTTop]
  unfold endpointCurvature
  calc
    v * (bPrev + aTop * U ^ 2) * (ell * aTop) -
        v * aTop * ((ell - 2) * (aPrev + aTop * U ^ 2)) =
      v * aTop * (ell * bPrev - (ell - 2) * aPrev) +
        2 * v * aTop ^ 2 * U ^ 2 := by ring
    _ = 2 * v * aTop ^ 2 * U ^ 2 := by rw [hPrev]; ring

/-- Multiplying the companion congruence by the endpoint coefficient reads
the third-order factor quotient jet directly from the curvature quotient. -/
theorem endpointCurvature_modEq_of_companion
    (x v top V : ℤ) (hv : v ≡ V [ZMOD x ^ 4]) :
    endpointCurvature v top ≡ 2 * top ^ 2 * V [ZMOD x ^ 4] := by
  simpa [endpointCurvature, mul_assoc, mul_left_comm, mul_comm] using
    hv.mul_left (2 * top ^ 2)

/-- The norm identity and oddness of `U` force the companion to be a unit at
every prime of `U`. -/
theorem normIdentity_gives_companion_coprime
    (U v : ℤ) (h2 : IsCoprime 2 U)
    (hnorm : v ^ 2 - 32 * U ^ 2 = 4) :
    IsCoprime v U := by
  rcases h2 with ⟨c, d, hcd⟩
  refine ⟨c ^ 2 * v,
    4 * c * d + U * d ^ 2 - 32 * c ^ 2 * U, ?_⟩
  calc
    (c ^ 2 * v) * v +
        (4 * c * d + U * d ^ 2 - 32 * c ^ 2 * U) * U =
      c ^ 2 * (v ^ 2 - 32 * U ^ 2) +
        4 * c * d * U + d ^ 2 * U ^ 2 := by ring
    _ = 4 * c ^ 2 + 4 * c * d * U + d ^ 2 * U ^ 2 := by
      rw [hnorm]
      ring
    _ = (c * 2 + d * U) ^ 2 := by ring
    _ = 1 := by rw [hcd]; norm_num

/-- Coprimality of each factor makes the endpoint curvature a support unit. -/
theorem endpointCurvature_coprime
    (U v top : ℤ)
    (h2 : IsCoprime 2 U)
    (hv : IsCoprime v U)
    (htop : IsCoprime top U) :
    IsCoprime (endpointCurvature v top) U := by
  exact (h2.mul_left hv).mul_left htop.pow_left

/-- If `delta = curvature*U^2` and the curvature is a support unit, then the
projective modulus is exactly `U^2`: a nonunit `U` cannot divide `delta` to
the third power. -/
theorem endpointProjectiveModulus_sharp
    (U curvature delta : ℤ)
    (hU0 : U ≠ 0)
    (hUnonunit : ¬U ∣ (1 : ℤ))
    (hcop : IsCoprime curvature U)
    (hdelta : delta = curvature * U ^ 2) :
    U ^ 2 ∣ delta ∧ ¬U ^ 3 ∣ delta := by
  constructor
  · refine ⟨curvature, ?_⟩
    rw [hdelta]
    ring
  · intro hthree
    rcases hthree with ⟨k, hk⟩
    have hmul : curvature * U ^ 2 = (U * k) * U ^ 2 := by
      calc
        curvature * U ^ 2 = delta := hdelta.symm
        _ = U ^ 3 * k := hk
        _ = (U * k) * U ^ 2 := by ring
    have hcurv : curvature = U * k :=
      mul_right_cancel₀ (pow_ne_zero 2 hU0) hmul
    have hUcurv : U ∣ curvature := ⟨k, hcurv⟩
    rcases hcop with ⟨c, d, hcd⟩
    apply hUnonunit
    rw [← hcd]
    exact dvd_add (dvd_mul_of_dvd_right hUcurv c)
      (dvd_mul_of_dvd_right (dvd_refl U) d)

/-- The exact endpoint formula plus the norm and support-unit hypotheses gives
the sharp `U^2` conclusion in one reusable statement. -/
theorem endpointProjectiveCurvature_and_sharpness
    (ell U v aPrev aTop bPrev TPrev TTop delta : ℤ)
    (hPrev : (ell - 2) * aPrev = ell * bPrev)
    (hTPrev : TPrev = v * (bPrev + aTop * U ^ 2))
    (hTTop : TTop = v * aTop)
    (hdelta : delta = TPrev * (ell * aTop) -
      TTop * ((ell - 2) * (aPrev + aTop * U ^ 2)))
    (hU0 : U ≠ 0)
    (hUnonunit : ¬U ∣ (1 : ℤ))
    (h2 : IsCoprime 2 U)
    (hnorm : v ^ 2 - 32 * U ^ 2 = 4)
    (htop : IsCoprime aTop U) :
    delta = endpointCurvature v aTop * U ^ 2 ∧
      U ^ 2 ∣ delta ∧ ¬U ^ 3 ∣ delta := by
  have hexact := endpointProjectiveCurvature_exact ell U v aPrev aTop bPrev
    TPrev TTop hPrev hTPrev hTTop
  have hdeltaExact : delta = endpointCurvature v aTop * U ^ 2 := by
    rw [hdelta, hexact]
  have hvCop := normIdentity_gives_companion_coprime U v h2 hnorm
  have hcurvCop := endpointCurvature_coprime U v aTop h2 hvCop htop
  exact ⟨hdeltaExact,
    endpointProjectiveModulus_sharp U (endpointCurvature v aTop) delta
      hU0 hUnonunit hcurvCop hdeltaExact⟩

/-! ## Full-premise finite boundary certificates -/

/-- The exact arithmetic, residue, kernel-quotient, carrier, and complete
third-order-ledger data for the local-only counterexample
`(ell,q,r)=(3,7,797)`. -/
theorem localLedgerCounterexample_arithmetic :
    Nat.Prime 3 ∧ Nat.Prime 7 ∧ Nat.Prime 797 ∧
      (7 : ℤ) = 1 + 6 * 1 ∧
      (797 : ℤ) = -1 + 6 * 133 ∧
      (7 : ℤ) % 8 = 7 ∧ (797 : ℤ) % 8 = 5 ∧
      (1 : ℤ) % 4 = 1 ∧ (133 : ℤ) % 4 = 1 ∧
      ((3 : ℤ) - 2 * (-399) +
        3 * ((3 : ℤ) ^ 2 - 2 * (-399) ^ 2) +
        2 * 3 * ((3 : ℤ) - 2 * 53067) +
        4 * 3 ^ 2 * ((1 : ℤ) - 2 * (-2352637) +
          3 * 3 - 2 * (-399) * 53067) +
        4 * 3 ^ 3 * ((3 : ℤ) ^ 2 - 2 * 53067 ^ 2)) ≡
          0 [ZMOD 8 * 3 ^ 3] ∧
      (7 : ℤ) ^ 6 - 2 * (797 : ℤ) ^ 6 + 1 =
        -512601560592751008 := by
  norm_num [Int.ModEq]

set_option maxHeartbeats 0 in
-- Kernel evaluation of three modular powers of exponent 398 needs an
-- unbounded heartbeat budget; this remains ordinary `decide`.
set_option maxRecDepth 100000 in
/-- Euler-criterion certificates for the three negative character edges in
the local-only counterexample. -/
theorem localLedgerCounterexample_characterPowers :
    (7 : ZMod 797) ^ 398 = -1 ∧
      (3 : ZMod 7) ^ 3 = -1 ∧
      (3 : ZMod 797) ^ 398 = -1 := by
  decide

/-- The index-seven factor lists produce the quoted third-order triples. -/
theorem indexSeven_factorQuotientTriples :
    (([17] : List ℤ).sum, pairCoefficient [17], tripleCoefficient [17],
      ([-1, -1] : List ℤ).sum, pairCoefficient [-1, -1],
      tripleCoefficient [-1, -1]) =
      ((17 : ℤ), 0, 0, -2, 1, 0) := by
  norm_num [pairCoefficient, tripleCoefficient]

/-- Both quotient channels at index seven read the same companion modulo
`14^4`, and hence the same endpoint-curvature residue. -/
theorem indexSeven_companionAndCurvatureJets :
    companionAJet 14 17 0 0 ≡ 228486 [ZMOD 14 ^ 4] ∧
      companionBJet 14 (-2) 1 0 ≡ 228486 [ZMOD 14 ^ 4] ∧
      endpointCurvature 228486 32768 ≡ 26416 [ZMOD 14 ^ 4] := by
  norm_num [companionAJet, companionBJet, endpointCurvature, Int.ModEq]

/-- Exact top-tail and determinant values at the genuine Pell index seven. -/
theorem indexSeven_endpointDeterminant :
    let U : ℤ := 40391
    let v : ℤ := 228486
    let aPrev : ℤ := 7168
    let aTop : ℤ := 32768
    let bPrev : ℤ := 5120
    let EPrev := aPrev + aTop * U ^ 2
    let FPrev := bPrev + aTop * U ^ 2
    let TPrev := v * FPrev
    let TTop := v * aTop
    EPrev = 53458792651776 ∧
      FPrev = 53458792649728 ∧
      TPrev = 12214585697365751808 ∧
      TTop = 7487029248 ∧
      TPrev * (7 * aTop) - TTop * (5 * EPrev) =
        800495088185894730989568 := by
  norm_num

/-- The actual index-seven endpoint determinant has exact `U^2` depth and
is not divisible by `U^3`; this refutes the stronger claim P3 with every
actual-Pell premise instantiated. -/
theorem indexSeven_refutes_endpointCubeDivisibility :
    let U : ℤ := 40391
    let curvature : ℤ := 490669948796928
    let delta : ℤ := 800495088185894730989568
    delta = curvature * U ^ 2 ∧
      IsCoprime curvature U ∧
      U ^ 2 ∣ delta ∧
      ¬U ^ 3 ∣ delta ∧
      delta % U ^ 3 = 24354030047568 := by
  dsimp
  constructor
  · norm_num
  constructor
  · refine ⟨5912, -71818987826185, ?_⟩
    norm_num
  constructor
  · norm_num
  constructor <;> norm_num

#check tripleCarrier_coefficients
#check positiveCarrier_minimal_coefficients
#check negativeCarrier_minimal_coefficients
#check companionJets_difference_exact
#check companionJets_modEq_of_completeThirdOrderLedger
#check completeThirdOrderLedger_modEllCube_of_companionJets
#check jetEquality_losesEight_counterexample
#check companionAJet_modEq
#check companionBJet_modEq
#check companionAJet_of_factorProduct
#check companionBJet_of_factorProduct
#check twoChannel_companionJets
#check endpointProjectiveCurvature_exact
#check endpointCurvature_modEq_of_companion
#check normIdentity_gives_companion_coprime
#check endpointCurvature_coprime
#check endpointProjectiveModulus_sharp
#check endpointProjectiveCurvature_and_sharpness
#check localLedgerCounterexample_arithmetic
#check localLedgerCounterexample_characterPowers
#check indexSeven_factorQuotientTriples
#check indexSeven_companionAndCurvatureJets
#check indexSeven_endpointDeterminant
#check indexSeven_refutes_endpointCubeDivisibility

end PellLucasFactorQuotientProjectiveCoupling20260902
end IUTThreeClosures
