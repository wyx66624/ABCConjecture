/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HigherCongruenceDepthBarrier

/-!
# A Selmer--regulator audit for the full-two-torsion Frey curve

This file separates two very different kinds of information.

* A `2`-descent records a bad place and the parity of a valuation.  The
  actual primitive family `(3^(2n+2), 2, 3^(2n+2)+2)` has one fixed such
  local profile at `3`, while its Frey discriminant exponent is unbounded.
* The logarithmic BSD formula can recover an archimedean period, but only
  through the full quotient made from a regulator, Tate--Shafarevich order,
  Tamagawa product, leading `L`-value, and torsion order.  The coefficient
  needed for abc is exactly one half before converting the period into the
  source height.

Only elementary natural-number and real-number bookkeeping is formalized.
In particular, this file does **not** construct a Selmer group, a
Cassels--Tate pairing, a canonical or Faltings height, a regulator, an
`L`-function, a Neron period, BSD, or abc.  All arithmetic interpretations
of the real variables in the final section remain explicit paper inputs.
-/

namespace IUTThreeClosures

/-! ## The exact finite profile seen by a coarse local `2`-descent -/

/-- The coarse local profile consisting of the support bit and valuation
parity.  For a squareclass in `Q_p^*/Q_p^{*2}`, these are the two pieces of
valuation data which survive; unit squareclass data is deliberately not
modeled here. -/
def twoDescentLocalValuationProfile (e : ℕ) : ℕ × ℕ :=
  (if e = 0 then 0 else 1, e % 2)

@[simp]
theorem twoDescentLocalValuationProfile_zero :
    twoDescentLocalValuationProfile 0 = (0, 0) := by
  simp [twoDescentLocalValuationProfile]

/-- Every positive even exponent has the same coarse local descent
profile. -/
theorem twoDescentLocalValuationProfile_even
    (e : ℕ) (he : 0 < e) :
    twoDescentLocalValuationProfile (2 * e) = (1, 0) := by
  simp [twoDescentLocalValuationProfile, he.ne']

/-- Adding an even amount preserves the valuation-parity channel. -/
theorem twoDescentValuationParity_add_two_mul (e k : ℕ) :
    (e + 2 * k) % 2 = e % 2 := by
  omega

/-! ## An actual primitive Frey family with a constant local profile -/

/-- The even-depth subfamily of the already constructed primitive family:
`(a,b,c)=(3^(2n+2),2,3^(2n+2)+2)`. -/
def evenDepthThreeFreyPoint (n : ℕ) : ABCPoint :=
  nonsplitThreeFreyPoint (2 * n + 1)

@[simp]
theorem evenDepthThreeFreyPoint_a (n : ℕ) :
    (evenDepthThreeFreyPoint n).a = 3 ^ (2 * n + 2) := by
  simp [evenDepthThreeFreyPoint]

@[simp]
theorem evenDepthThreeFreyPoint_b (n : ℕ) :
    (evenDepthThreeFreyPoint n).b = 2 := by
  simp [evenDepthThreeFreyPoint]

@[simp]
theorem evenDepthThreeFreyPoint_c (n : ℕ) :
    (evenDepthThreeFreyPoint n).c = 3 ^ (2 * n + 2) + 2 := by
  simp [evenDepthThreeFreyPoint]

/-- At `3`, the exponent of the abc product is the positive even integer
`2(n+1)`. -/
theorem evenDepthThreeFreyPoint_abc_factorization_three (n : ℕ) :
    ((evenDepthThreeFreyPoint n).a *
      (evenDepthThreeFreyPoint n).b *
      (evenDepthThreeFreyPoint n).c).factorization 3 =
        2 * (n + 1) := by
  simp only [evenDepthThreeFreyPoint]
  rw [nonsplitThreeFreyPoint_abc_factorization_three]
  omega

/-- Consequently the support/parity part of the `3`-local descent profile
is literally constant throughout the family. -/
theorem evenDepthThreeFreyPoint_three_descentProfile (n : ℕ) :
    twoDescentLocalValuationProfile
      (((evenDepthThreeFreyPoint n).a *
        (evenDepthThreeFreyPoint n).b *
        (evenDepthThreeFreyPoint n).c).factorization 3) =
      (1, 0) := by
  rw [evenDepthThreeFreyPoint_abc_factorization_three]
  exact twoDescentLocalValuationProfile_even (n + 1) (by omega)

/-- The minimal-discriminant exponent shadow at `3` is instead `4(n+1)`.
The actual minimality and Kodaira statements remain in the paper audit; the
quantity here is the already formalized Frey discriminant exponent. -/
theorem evenDepthThreeFreyPoint_freyDelta_factorization_three (n : ℕ) :
    (evenDepthThreeFreyPoint n).freyDeltaNat.factorization 3 =
      4 * (n + 1) := by
  simp only [evenDepthThreeFreyPoint]
  rw [nonsplitThreeFreyPoint_freyDelta_factorization_three]
  omega

/-- Fully quantified obstruction: no function of the support/parity profile
alone can bound the local Frey discriminant exponent, even on actual
primitive abc points. -/
theorem no_freyDeltaExponent_bound_from_twoDescentLocalValuationProfile
    (F : (ℕ × ℕ) → ℕ) :
    ∃ n : ℕ,
      F (twoDescentLocalValuationProfile
          (((evenDepthThreeFreyPoint n).a *
            (evenDepthThreeFreyPoint n).b *
            (evenDepthThreeFreyPoint n).c).factorization 3)) <
        (evenDepthThreeFreyPoint n).freyDeltaNat.factorization 3 := by
  refine ⟨F (1, 0), ?_⟩
  rw [evenDepthThreeFreyPoint_three_descentProfile,
    evenDepthThreeFreyPoint_freyDelta_factorization_three]
  omega

/-! ## The visible rational two-torsion has unbounded coordinate scale -/

/-- The `x`-coordinate of the visible point `(a,0)`.  On paper this point
has order two, hence Neron--Tate height zero.  This definition records only
its integral coordinate scale and does not pretend to formalize a canonical
height. -/
def visibleTwoTorsionXNat (P : ABCPoint) : ℕ := P.a

/-- The coordinate scale of that visible torsion point is unbounded on the
same actual primitive family. -/
theorem evenDepthThreeFreyPoint_visibleTwoTorsionX_unbounded (B : ℕ) :
    B < visibleTwoTorsionXNat (evenDepthThreeFreyPoint B) := by
  rw [visibleTwoTorsionXNat, evenDepthThreeFreyPoint_a]
  have hB : B < 2 ^ B := B.lt_two_pow_self
  have hbase : 2 ^ B ≤ 3 ^ B :=
    Nat.pow_le_pow_left (by omega : 2 ≤ 3) B
  have hexponent : 3 ^ B ≤ 3 ^ (2 * B + 2) :=
    Nat.pow_le_pow_right (by norm_num : 0 < 3) (by omega)
  exact (hB.trans_le hbase).trans_le hexponent

/-! ## The signed local-height ledger on three nonzero two-torsion points -/

/-- The scalar shadow of the Tate local-height calculation at an odd
multiplicative place of type `I_(2e)`: the identity-component two-torsion
contributes `e/6 * log p`, and the two points on the opposite component each
contribute `-e/12 * log p`.  Their signed sum is exactly zero.

This theorem proves only the displayed real-number identity.  Identifying
its terms with Neron local heights is deliberately left to the paper audit. -/
theorem tateTwoTorsionLocalHeightLedger_conservation
    (e primeLog : ℝ) :
    (e / 6) * primeLog +
        2 * ((-e / 12) * primeLog) = 0 := by
  ring

/-- For positive exponent and positive prime logarithm, the conserved
ledger has one strictly positive entry and two strictly negative entries.
Thus replacing the signed sum by positive parts is a genuine change of
functional. -/
theorem tateTwoTorsionLocalHeightLedger_signs
    {e primeLog : ℝ} (he : 0 < e) (hlog : 0 < primeLog) :
    0 < (e / 6) * primeLog ∧
      (-e / 12) * primeLog < 0 := by
  constructor
  · positivity
  · have hpos : 0 < (e / 12) * primeLog := by positivity
    nlinarith

/-! ## What the ordinary Selmer dimension bound actually says -/

/-- For full rational two-torsion, the Kummer injection gives
`rank + 2 <= dim Sel_2`.  If the latter is embedded in two copies of the
`S`-unit squareclass group over `Q`, the coarse ambient bound is
`dim Sel_2 <= 2(support+1)`.  Their only scalar consequence is the displayed
support-count rank bound. -/
theorem rank_le_two_mul_support_of_fullTwoTorsionSelmerBounds
    {rank selmerDim support : ℕ}
    (hkummer : rank + 2 ≤ selmerDim)
    (hambient : selmerDim ≤ 2 * (support + 1)) :
    rank ≤ 2 * support := by
  omega

/-- A support-count rank bound by itself places no upper bound on a separate
height variable.  This is a quantifier-level countermodel, not a statement
about existence of elliptic curves with prescribed invariants. -/
theorem rankSupportBound_does_not_formally_bound_height
    (rank support : ℕ) (hrank : rank ≤ 2 * support)
    (F : ℕ → ℕ) :
    ∃ height : ℕ,
      rank ≤ 2 * support ∧ F support < height := by
  exact ⟨F support + 1, hrank, by omega⟩

/-! ## The exact logarithmic BSD quotient and the half-slope target -/

/-- Logarithm of the BSD arithmetic quotient

`Reg * |Sha| * Tam / (leadingL * |tors|^2)`.

All arguments are logarithms. -/
def bsdArithmeticQuotientLog
    (leadingLog regulatorLog shaLog tamagawaLog torsionLog : ℝ) : ℝ :=
  regulatorLog + shaLog + tamagawaLog - leadingLog - 2 * torsionLog

/-- The logarithmic BSD leading-term identity says exactly that the
arithmetic quotient is the reciprocal-period logarithm. -/
theorem bsdArithmeticQuotientLog_eq_neg_periodLog
    (leadingLog periodLog regulatorLog shaLog tamagawaLog torsionLog : ℝ)
    (hBSD :
      leadingLog =
        periodLog + regulatorLog + shaLog + tamagawaLog -
          2 * torsionLog) :
    bsdArithmeticQuotientLog leadingLog regulatorLog shaLog
        tamagawaLog torsionLog = -periodLog := by
  unfold bsdArithmeticQuotientLog
  linarith

/-- Combining an explicit period-to-source-height corridor with the BSD
identity transfers the source height to twice the arithmetic quotient. -/
theorem sourceHeight_le_two_bsdArithmeticQuotientLog
    (sourceHeight shapeError : ℝ)
    (leadingLog periodLog regulatorLog shaLog tamagawaLog torsionLog : ℝ)
    (hperiod : sourceHeight ≤ -2 * periodLog + shapeError)
    (hBSD :
      leadingLog =
        periodLog + regulatorLog + shaLog + tamagawaLog -
          2 * torsionLog) :
    sourceHeight ≤
      2 * bsdArithmeticQuotientLog leadingLog regulatorLog shaLog
        tamagawaLog torsionLog + shapeError := by
  rw [bsdArithmeticQuotientLog_eq_neg_periodLog
    leadingLog periodLog regulatorLog shaLog tamagawaLog torsionLog hBSD]
  linarith

/-- The exact coefficient target for this route: a half-slope bound for the
BSD quotient becomes the `1 + eps` source-height slope. -/
theorem bsdArithmeticQuotient_halfSlope_to_sourceBudget
    (sourceHeight conductorLog shapeError eps C : ℝ)
    (quotientLog : ℝ)
    (hperiodBSD : sourceHeight ≤ 2 * quotientLog + shapeError)
    (hquotient :
      quotientLog ≤ ((1 + eps) / 2) * conductorLog + C) :
    sourceHeight ≤
      (1 + eps) * conductorLog + 2 * C + shapeError := by
  linarith

/-- With an exact period corridor, the half-slope quotient estimate and the
source-height estimate are equivalent.  Thus invoking the latter as an
unproved bound on the BSD quotient would merely relocate the hard global
inequality. -/
theorem bsdArithmeticQuotient_halfSlope_iff_sourceBudget
    (sourceHeight conductorLog shapeError eps C quotientLog : ℝ)
    (hcorridor : sourceHeight = 2 * quotientLog + shapeError) :
    quotientLog ≤ ((1 + eps) / 2) * conductorLog + C ↔
      sourceHeight ≤
        (1 + eps) * conductorLog + 2 * C + shapeError := by
  rw [hcorridor]
  constructor <;> intro h <;> linarith

/-- Merely knowing that all logarithmic BSD factors are nonnegative does
not bound their sum.  This elementary witness isolates why finiteness of
`Sha` and finite Selmer dimensions supply no numerical quotient estimate. -/
theorem nonnegative_bsdFactors_do_not_bound_quotient
    (B : ℝ) :
    ∃ regulatorLog shaLog tamagawaLog : ℝ,
      0 ≤ regulatorLog ∧ 0 ≤ shaLog ∧ 0 ≤ tamagawaLog ∧
        B < regulatorLog + shaLog + tamagawaLog := by
  refine ⟨max 0 B + 1, 0, 0, ?_, by norm_num, by norm_num, ?_⟩
  · exact add_nonneg (le_max_left _ _) (by norm_num)
  · have hB : B ≤ max 0 B := le_max_right _ _
    linarith

end IUTThreeClosures
