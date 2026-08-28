/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevOddQuotientGcdLedger
import Mathlib.Data.Nat.Squarefree

/-!
# Bennett--Walsh/Cohn exclusion and Granville odd valuation

This file kernel-checks the logical combination of accepted results used in
`FREY_PELL_CHEBYSHEV_BENNETT_WALSH_ODD_VALUATION.md`.

The accepted results are not reproved.  They are represented by transparent
`Prop` interfaces and must be supplied as hypotheses:

* Bennett--Walsh, Theorem 1.2;
* the odd-multiple occurrence fact used in the proof of their Lemma 3.3;
* Bennett--Walsh, Lemma 5.1 (with `0` representing infinite divisibility
  index);
* Bennett--Walsh, Theorem 1.1, quoting Cohn (1997);
* Granville, Corollary 5, after the already-audited specialization at the
  Lucas-cyclotomic index `2*p`.

No axiom or theorem constant for any of these inputs is declared.  Every
result below takes the relevant transparent proposition as an explicit
hypothesis.  The actual Chebyshev quotient is reused from
`FreyPellChebyshevOddQuotientGcdLedger`.
-/

namespace IUTThreeClosures
namespace BennettWalshOddValuation

/-! ## Transparent accepted-theorem interfaces -/

/-- Bennett--Walsh Theorem 1.2 in the form used here, for the Pell trace
sequence `T` of one fixed squarefree `d > 1`.  If a squarefree coefficient
`b > 1` occurs in `T n = b*x^2`, its index is the divisibility index
`alpha b`. -/
def BennettWalshTheoremOneTwo
    (T alpha : ℕ → ℕ) : Prop :=
  ∀ b n x : ℕ,
    Squarefree b → 1 < b → 0 < n → T n = b * x ^ 2 →
      n = alpha b

/-- The consequence of Bennett--Walsh Theorem 1.1 (Cohn 1997) needed here:
a square Pell trace coordinate can occur only at index one or two.  Strict
growth of the positive Pell trace sequence identifies the indices from
Cohn's two displayed coordinate values. -/
def Cohn1997TheoremOneOneConsequence (T : ℕ → ℕ) : Prop :=
  ∀ n x : ℕ, 0 < n → T n = x ^ 2 → n = 1 ∨ n = 2

/-- The occurrence fact explicitly used in the proof of Bennett--Walsh
Lemma 3.3: for squarefree `a > 1`, the indices at which `a` divides `T n`
are exactly the odd multiples of its divisibility index `alpha a`.

The convention `alpha a = 0` represents `alpha(a) = infinity`; at a positive
index the right side is then empty. -/
def BennettWalshOddMultipleOccurrence
    (T alpha : ℕ → ℕ) : Prop :=
  ∀ a n : ℕ, Squarefree a → 1 < a → 0 < n →
    (a ∣ T n ↔ ∃ t : ℕ, Odd t ∧ n = t * alpha a)

/-- Bennett--Walsh Lemma 5.1 for odd primes, with the Legendre-symbol value
expanded into its two possibilities.  For a prime `p > 2`, the lemma says:

* if `p ∣ d`, then `alpha(p) = infinity` (encoded by zero);
* if `p ∤ d`, then `alpha(p)` is infinite or divides
  `(p-1)/2` or `(p+1)/2`.

The latter disjunction is exactly the statement that a finite index divides
`(p-(d/p))/2`, since `(d/p)` is `1` or `-1`. -/
def BennettWalshLemmaFiveOne
    (d : ℕ) (alpha : ℕ → ℕ) : Prop :=
  ∀ p : ℕ, p.Prime → 2 < p →
    (p ∣ d → alpha p = 0) ∧
    (¬ p ∣ d →
      alpha p = 0 ∨
        alpha p ∣ (p - 1) / 2 ∨
        alpha p ∣ (p + 1) / 2)

/-- Exact odd multiplicity of a prime factor of `N`, together with an
external predicate saying that the prime is new at the relevant index. -/
def HasOddMultiplicityFactor
    (isNew : ℕ → Prop) (N : ℕ) : Prop :=
  ∃ q e : ℕ,
    q.Prime ∧ isNew q ∧ Odd e ∧
      q ^ e ∣ N ∧ ¬ q ^ (e + 1) ∣ N

/-- Granville Corollary 5 after the audited specialization to the
Lucas-cyclotomic block `Phi_(2*p) = H_p(X)`, with `p >= 31`.  This packaged
interface also incorporates Corollary 3's statement that a characteristic
prime divides the term and its cyclotomic block to the same exact power.

At `n=2*p`, the prime in Granville's exceptional square class can only be
`2` or `p`.  Its numerical condition eliminates `2` for `p >= 31`, leaving
the two alternatives `H = square` and `H = p*square`. -/
def GranvilleCorollaryFiveAtTwicePrime
    (p H : ℕ) (isCharacteristic : ℕ → Prop) : Prop :=
  ¬ HasOddMultiplicityFactor isCharacteristic H →
    (∃ z : ℕ, H = z ^ 2) ∨
      ∃ z : ℕ, H = p * z ^ 2

/-- At the index `2*p` in the present Pell Lucas sequence, the audited
characteristic primes are primitive: `2` already occurs at index two, while
an odd discriminant prime first has its characteristic occurrence at its
own prime index, not at the composite index `2*p`. -/
def CharacteristicImpliesPrimitive
    (isCharacteristic isPrimitive : ℕ → Prop) : Prop :=
  ∀ q : ℕ, isCharacteristic q → isPrimitive q

/-! ## Elementary consequences of the accepted interfaces -/

/-- A prime which actually occurs in the Pell trace sequence has finite
divisibility index.  Bennett--Walsh Lemma 5.1 then makes that index coprime
to the prime.  The `p ∣ d` branch is explicitly discharged: Lemma 5.1 says
the index is infinite, contradicting occurrence at a positive index. -/
theorem lemmaFiveOne_coprime_of_occurrence
    {T alpha : ℕ → ℕ} {d p n : ℕ}
    (hOccurrence : BennettWalshOddMultipleOccurrence T alpha)
    (hFiveOne : BennettWalshLemmaFiveOne d alpha)
    (hp : p.Prime) (hpgt : 2 < p)
    (hn : 0 < n) (hpn : p ∣ T n) :
    (alpha p).Coprime p := by
  have hOccurs :=
    (hOccurrence p n hp.squarefree (by omega) hn).mp hpn
  rcases hOccurs with ⟨t, htOdd, hnt⟩
  have halpha_ne : alpha p ≠ 0 := by
    intro halpha
    rw [halpha] at hnt
    simp at hnt
    omega
  by_cases hpd : p ∣ d
  · have halpha := (hFiveOne p hp hpgt).1 hpd
    exact (halpha_ne halpha).elim
  · rcases (hFiveOne p hp hpgt).2 hpd with
      halpha | halphaMinus | halphaPlus
    · exact (halpha_ne halpha).elim
    · apply Nat.Coprime.of_dvd_left halphaMinus
      have hpos : 0 < (p - 1) / 2 := by omega
      have hlt : (p - 1) / 2 < p := by omega
      exact ((hp.coprime_iff_not_dvd).2
        (Nat.not_dvd_of_pos_of_lt hpos hlt)).symm
    · apply Nat.Coprime.of_dvd_left halphaPlus
      have hpos : 0 < (p + 1) / 2 := by omega
      have hlt : (p + 1) / 2 < p := by omega
      exact ((hp.coprime_iff_not_dvd).2
        (Nat.not_dvd_of_pos_of_lt hpos hlt)).symm

/-- Bennett--Walsh uniqueness, with Cohn's `b=1` theorem supplying the
missing coefficient-one case, excludes a square quotient between Pell
trace coordinates at indices `k` and `k*p`. -/
theorem pellTraceQuotient_not_square
    {T alpha : ℕ → ℕ}
    {p k b u H : ℕ}
    (hBW : BennettWalshTheoremOneTwo T alpha)
    (hCohn : Cohn1997TheoremOneOneConsequence T)
    (hp : p.Prime) (hpgt : 2 < p)
    (hk : 0 < k) (hb : 0 < b) (hbsf : Squarefree b)
    (hTk : T k = b * u ^ 2)
    (hTkp : T (k * p) = T k * H) :
    ¬ ∃ z : ℕ, H = z ^ 2 := by
  rintro ⟨z, hHz⟩
  have hTkpSquare : T (k * p) = b * (u * z) ^ 2 := by
    rw [hTkp, hTk, hHz]
    ring
  by_cases hb1 : b = 1
  · have hkpSquare : T (k * p) = (u * z) ^ 2 := by
      simpa [hb1] using hTkpSquare
    have hkpCohn := hCohn (k * p) (u * z)
      (Nat.mul_pos hk hp.pos) hkpSquare
    have hthree : 3 ≤ k * p := by
      calc
        3 = 1 * 3 := by omega
        _ ≤ k * p := Nat.mul_le_mul (Nat.succ_le_iff.mpr hk) (by omega)
    rcases hkpCohn with hkp1 | hkp2 <;> omega
  · have hbgt : 1 < b := by omega
    have hkIndex : k = alpha b := hBW b k u hbsf hbgt hk hTk
    have hkpIndex : k * p = alpha b :=
      hBW b (k * p) (u * z) hbsf hbgt
        (Nat.mul_pos hk hp.pos) hTkpSquare
    have hklt : k < k * p :=
      lt_mul_of_one_lt_right hk (by omega)
    omega

/-- The prime-times-square alternative is impossible for every positive
index `k`, with no parity assumption on `k`.

The proof splits according to whether `p` divides the squarefree part `b`
of `T k`.

* If `p ∣ b`, write `b=p*c`.  If `c>1`, the `c`-square at index `k*p`
  has index `alpha(c)`, while `c ∣ T k` forces `alpha(c) ≤ k`.  If
  `c=b/p=1`, Cohn excludes the square coordinate at index `k*p`.
* If `p ∤ b`, Lemma 5.1 and the odd-multiple occurrence fact force
  `p ∣ T k`.  Hence `b*p ∣ T k`, although Theorem 1.2 identifies the
  first `b*p` occurrence with the larger index `k*p`.

The latter argument handles `b=1` without alteration. -/
theorem pellTraceQuotient_not_prime_mul_square
    {T alpha : ℕ → ℕ}
    {d p k b u H : ℕ}
    (hBW : BennettWalshTheoremOneTwo T alpha)
    (hCohn : Cohn1997TheoremOneOneConsequence T)
    (hOccurrence : BennettWalshOddMultipleOccurrence T alpha)
    (hFiveOne : BennettWalshLemmaFiveOne d alpha)
    (hp : p.Prime) (hpgt : 2 < p)
    (hk : 0 < k) (hb : 0 < b) (hbsf : Squarefree b)
    (hTk : T k = b * u ^ 2)
    (hTkp : T (k * p) = T k * H) :
    ¬ ∃ z : ℕ, H = p * z ^ 2 := by
  rintro ⟨z, hHz⟩
  by_cases hpb : p ∣ b
  · let c := b / p
    have hbc : b = p * c := by
      simpa [c, Nat.mul_comm] using (Nat.div_mul_cancel hpb).symm
    have hcpos : 0 < c := by
      by_contra hc
      have hc0 : c = 0 := Nat.eq_zero_of_not_pos hc
      rw [hc0] at hbc
      simp at hbc
      omega
    have hc_dvd_b : c ∣ b := by
      refine ⟨p, ?_⟩
      simpa [Nat.mul_comm] using hbc
    have hcsf : Squarefree c := hbsf.squarefree_of_dvd hc_dvd_b
    have hTkpC : T (k * p) = c * (p * u * z) ^ 2 := by
      rw [hTkp, hTk, hHz, hbc]
      ring
    by_cases hc1 : c = 1
    · have hTkpOne : T (k * p) = (p * u * z) ^ 2 := by
        simpa [hc1] using hTkpC
      have hC := hCohn (k * p) (p * u * z)
        (Nat.mul_pos hk hp.pos) hTkpOne
      have hthree : 3 ≤ k * p := by
        calc
          3 = 1 * 3 := by omega
          _ ≤ k * p := Nat.mul_le_mul (Nat.succ_le_iff.mpr hk) (by omega)
      rcases hC with hC | hC <;> omega
    · have hcgt : 1 < c := by omega
      have hIndex : k * p = alpha c :=
        hBW c (k * p) (p * u * z) hcsf hcgt
          (Nat.mul_pos hk hp.pos) hTkpC
      have hcTk : c ∣ T k := by
        refine ⟨p * u ^ 2, ?_⟩
        rw [hTk, hbc]
        ring
      rcases (hOccurrence c k hcsf hcgt hk).mp hcTk with
        ⟨s, hsOdd, hks⟩
      have hAlphaDvd : alpha c ∣ k := by
        refine ⟨s, ?_⟩
        simpa [Nat.mul_comm] using hks
      have hAlphaLe : alpha c ≤ k := Nat.le_of_dvd hk hAlphaDvd
      have hklt : k < k * p :=
        lt_mul_of_one_lt_right hk (by omega)
      rw [← hIndex] at hAlphaLe
      omega
  · have hbpCoprime : b.Coprime p :=
      ((hp.coprime_iff_not_dvd).2 hpb).symm
    have hbMulPSf : Squarefree (b * p) :=
      (Nat.squarefree_mul hbpCoprime).2 ⟨hbsf, hp.squarefree⟩
    have hbpgt : 1 < b * p := by
      have := Nat.mul_pos hb hp.pos
      nlinarith
    have hTkpBP : T (k * p) = (b * p) * (u * z) ^ 2 := by
      rw [hTkp, hTk, hHz]
      ring
    have hIndex : k * p = alpha (b * p) :=
      hBW (b * p) (k * p) (u * z) hbMulPSf hbpgt
        (Nat.mul_pos hk hp.pos) hTkpBP
    have hpTkp : p ∣ T (k * p) := by
      refine ⟨b * (u * z) ^ 2, ?_⟩
      rw [hTkpBP]
      ring
    rcases (hOccurrence p (k * p) hp.squarefree (by omega)
      (Nat.mul_pos hk hp.pos)).mp hpTkp with
      ⟨t, htOdd, hkpt⟩
    have hAlphaCoprime : (alpha p).Coprime p :=
      lemmaFiveOne_coprime_of_occurrence hOccurrence hFiveOne
        hp hpgt (Nat.mul_pos hk hp.pos) hpTkp
    have hAlphaDvdKP : alpha p ∣ k * p := by
      refine ⟨t, ?_⟩
      simpa [Nat.mul_comm] using hkpt
    have hAlphaDvdK : alpha p ∣ k :=
      hAlphaCoprime.dvd_of_dvd_mul_right hAlphaDvdKP
    rcases hAlphaDvdK with ⟨s, hks⟩
    have hAlphaPos : 0 < alpha p := by
      by_contra ha
      have ha0 : alpha p = 0 := Nat.eq_zero_of_not_pos ha
      rw [ha0] at hkpt
      simp at hkpt
      omega
    have hsp : s * p = t := by
      apply Nat.eq_of_mul_eq_mul_left hAlphaPos
      calc
        alpha p * (s * p) = (alpha p * s) * p := by ring
        _ = k * p := by rw [← hks]
        _ = t * alpha p := hkpt
        _ = alpha p * t := by ring
    have hsOdd : Odd s := by
      have hspOdd : Odd (s * p) := by simpa [hsp] using htOdd
      exact (Nat.odd_mul.mp hspOdd).1
    have hpTk : p ∣ T k :=
      (hOccurrence p k hp.squarefree (by omega) hk).mpr
        ⟨s, hsOdd, by simpa [Nat.mul_comm] using hks⟩
    have hbTk : b ∣ T k := by
      refine ⟨u ^ 2, ?_⟩
      exact hTk
    have hbpTk : b * p ∣ T k :=
      hbpCoprime.mul_dvd_of_dvd_of_dvd hbTk hpTk
    rcases (hOccurrence (b * p) k hbMulPSf hbpgt hk).mp hbpTk with
      ⟨w, hwOdd, hkw⟩
    have hIndexDvdK : alpha (b * p) ∣ k := by
      refine ⟨w, ?_⟩
      simpa [Nat.mul_comm] using hkw
    have hIndexLe : alpha (b * p) ≤ k := Nat.le_of_dvd hk hIndexDvdK
    have hklt : k < k * p :=
      lt_mul_of_one_lt_right hk (by omega)
    rw [← hIndex] at hIndexLe
    omega

/-- The two Bennett--Walsh/Cohn exclusions bundled together. -/
theorem pellTraceQuotient_not_square_or_prime_mul_square
    {T alpha : ℕ → ℕ}
    {d p k b u H : ℕ}
    (hBW : BennettWalshTheoremOneTwo T alpha)
    (hCohn : Cohn1997TheoremOneOneConsequence T)
    (hOccurrence : BennettWalshOddMultipleOccurrence T alpha)
    (hFiveOne : BennettWalshLemmaFiveOne d alpha)
    (hp : p.Prime) (hpgt : 2 < p)
    (hk : 0 < k) (hb : 0 < b) (hbsf : Squarefree b)
    (hTk : T k = b * u ^ 2)
    (hTkp : T (k * p) = T k * H) :
    (¬ ∃ z : ℕ, H = z ^ 2) ∧
      ¬ ∃ z : ℕ, H = p * z ^ 2 := by
  exact ⟨
    pellTraceQuotient_not_square hBW hCohn hp hpgt hk hb hbsf hTk hTkp,
    pellTraceQuotient_not_prime_mul_square
      hBW hCohn hOccurrence hFiveOne hp hpgt hk hb hbsf hTk hTkp⟩

/-! ## Connection to the repository's Chebyshev quotient -/

/-- Natural-number view of the repository's exact integer polynomial
`pellOddChebyshevQuotient`.  The accepted Pell-orbit bridge below guarantees
that this value is the positive trace quotient in the application. -/
def pellOddChebyshevQuotientNat (m X : ℕ) : ℕ :=
  Int.toNat (pellOddChebyshevQuotient m (X : ℤ))

/-- Accepted Pell-orbit certificate data for one Chebyshev base.  The
elementary factorization `X=b*u^2` chooses the squarefree part of `X`; `T` is
intended to be instantiated by the trace sequence of the fundamental unit of
the squarefree kernel `d` of `X^2-1`; and `k` is the (arbitrary-parity)
exponent satisfying `T k = X`.  Chebyshev composition gives the final
displayed equality.  This type does not itself encode the Pell recurrence or
construct such a package for every `X`.

The remaining conjuncts are precisely the four accepted literature
interfaces used by the proof. -/
def AcceptedPellOrbit
    (p m X : ℕ) : Prop :=
  ∃ (d k b u : ℕ) (T alpha : ℕ → ℕ),
    p = 2 * m + 1 ∧
      1 < d ∧ Squarefree d ∧
      1 < X ∧
      0 < k ∧ 0 < b ∧ Squarefree b ∧
      T k = b * u ^ 2 ∧
      T k = X ∧
      T (k * p) = T k * pellOddChebyshevQuotientNat m X ∧
      BennettWalshTheoremOneTwo T alpha ∧
      Cohn1997TheoremOneOneConsequence T ∧
      BennettWalshOddMultipleOccurrence T alpha ∧
      BennettWalshLemmaFiveOne d alpha

/-- Conditional only on the transparent accepted Pell-orbit package, the
actual odd Chebyshev quotient is neither a square nor `p` times a square.
No assumption on the parity of the fundamental-unit exponent `k` occurs. -/
theorem pellOddChebyshevQuotientNat_not_square_or_prime_mul_square
    {p m X : ℕ}
    (hp : p.Prime) (hp31 : 31 ≤ p)
    (hOrbit : AcceptedPellOrbit p m X) :
    (¬ ∃ z : ℕ, pellOddChebyshevQuotientNat m X = z ^ 2) ∧
      ¬ ∃ z : ℕ,
        pellOddChebyshevQuotientNat m X = p * z ^ 2 := by
  rcases hOrbit with
    ⟨d, k, b, u, T, alpha, hpIndex, hd, hdsf, hX, hk, hb, hbsf,
      hTk, hTX, hTkp, hBW, hCohn, hOccurrence, hFiveOne⟩
  exact pellTraceQuotient_not_square_or_prime_mul_square
    hBW hCohn hOccurrence hFiveOne hp (by omega)
      hk hb hbsf hTk hTkp

/-! ## Granville combination -/

/-- Contraposition of Granville's two-shape classification, followed by the
audited characteristic-to-primitive implication. -/
theorem granville_oddMultiplicityPrimitive_of_no_shapes
    {p H : ℕ}
    {isCharacteristic isPrimitive : ℕ → Prop}
    (hNoSquare : ¬ ∃ z : ℕ, H = z ^ 2)
    (hNoPrimeSquare : ¬ ∃ z : ℕ, H = p * z ^ 2)
    (hGranville :
      GranvilleCorollaryFiveAtTwicePrime p H isCharacteristic)
    (hPrimitive :
      CharacteristicImpliesPrimitive isCharacteristic isPrimitive) :
    HasOddMultiplicityFactor isPrimitive H := by
  have hCharacteristic :
      HasOddMultiplicityFactor isCharacteristic H := by
    by_contra hnone
    rcases hGranville hnone with hSquare | hPrimeSquare
    · exact hNoSquare hSquare
    · exact hNoPrimeSquare hPrimeSquare
  rcases hCharacteristic with ⟨q, e, hq, hqChar, he, hqe, hqe1⟩
  exact ⟨q, e, hq, hPrimitive q hqChar, he, hqe, hqe1⟩

/-- The uniform accepted-interface conclusion.  For every prime `p >= 31`
and `X > 1`, the actual quotient `H_p(X)` has a primitive prime divisor of
odd exact multiplicity, once the Bennett--Walsh/Cohn Pell-orbit package and
Granville's audited classification are supplied.

This theorem makes no claim about the shifted square
`y^2 = 4*T_p(X)+5` and no claim about the norm equation in `Q(sqrt(5))`. -/
theorem pellOddChebyshevQuotientNat_has_oddMultiplicityPrimitive
    {p m X : ℕ}
    {isCharacteristic isPrimitive : ℕ → Prop}
    (hp : p.Prime) (hp31 : 31 ≤ p)
    (hOrbit : AcceptedPellOrbit p m X)
    (hGranville : GranvilleCorollaryFiveAtTwicePrime p
      (pellOddChebyshevQuotientNat m X) isCharacteristic)
    (hPrimitive :
      CharacteristicImpliesPrimitive isCharacteristic isPrimitive) :
    HasOddMultiplicityFactor isPrimitive
      (pellOddChebyshevQuotientNat m X) := by
  have hNoShapes :=
    pellOddChebyshevQuotientNat_not_square_or_prime_mul_square
      hp hp31 hOrbit
  exact granville_oddMultiplicityPrimitive_of_no_shapes
    hNoShapes.1 hNoShapes.2 hGranville hPrimitive

#print axioms lemmaFiveOne_coprime_of_occurrence
#print axioms pellTraceQuotient_not_square
#print axioms pellTraceQuotient_not_prime_mul_square
#print axioms pellTraceQuotient_not_square_or_prime_mul_square
#print axioms pellOddChebyshevQuotientNat_not_square_or_prime_mul_square
#print axioms granville_oddMultiplicityPrimitive_of_no_shapes
#print axioms pellOddChebyshevQuotientNat_has_oddMultiplicityPrimitive

end BennettWalshOddValuation
end IUTThreeClosures
