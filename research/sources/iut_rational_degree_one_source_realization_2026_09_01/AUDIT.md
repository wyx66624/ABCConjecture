# Independent audit of the rational degree-one source realization

**Auditor:** ChatGPT (independent subagent)

**Date:** 2026-09-01

**Verdict:** **PASS after the documentary correction recorded below.**  The
mathematical transport theorem, its Lean formalization, and the full-premise
countermodel boundaries pass.  I found no counterexample to any positive claim
with all of its stated premises.  Integration corrected the incomplete page
range for IUT III, Corollary 3.12 and its proof; no theorem changed.

This audit does **not** prove or disprove IUT, Corollary 3.12, or the standard
abc conjecture.  It verifies only the source realization and conditional
transport claimed in the three audited files.

## 1. Audited snapshot and provenance

The audited repository files had the following SHA-256 values:

| file | SHA-256 |
|---|---|
| `research/ABC_IUT_RATIONAL_DEGREE_ONE_SOURCE_REALIZATION_2026_09_01.md` | `8096c9b8a7d166141c065eb1b49b08f2067813416c6733f2aab4b4b1ff9ab449` |
| `Lean/IUTThreeClosures/IUTRationalDegreeOneSourceRealization20260901.lean` | `c3dc1ac88fe628c8a0e13fd156e7398557dc6b86976a4374887f8de1524b4378` |
| `paper/iut_rational_degree_one_source_realization_2026.tex` | `ae2fa1586213a465b2bf7d61ccd6eef8ba0380ad4ed0878daf6c1e6697507678` |

The author-hosted PDFs were downloaded again from the URLs cited in the
report.  Their bytes agree with the local archived copies:

| primary source | local/archive SHA-256 | result |
|---|---|---|
| [Mochizuki, *Arithmetic Elliptic Curves in General Position*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf) | `b9dc115af61dca7fe434332ebafddf6a376a9e2926dad4e1ea2dcc0d2441f768` | live author PDF = local PDF |
| [Mochizuki, *Inter-universal Teichmuller Theory III*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf) | `9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9` | live author PDF = local PDF |

The Lake dependency is clean at
`LANA-Project/genl@6e9a6543b46a2a02fd7fe7ec8ab203d878f32859`.
The relevant pinned source hashes are:

| pinned source | SHA-256 |
|---|---|
| `Genl/GeneralPosition/HeightTheory.lean` | `f1cb29c91429ff433a799ee2b6db5f9ffa9406f53df0cb5f05027a5bb7e98075` |
| `Genl/GeneralPosition/ProofPackage.lean` | `684c9f2fa97944be9a7ffddfc745b0386a499a926d54923d69b7704d2ee0d69f` |
| `Genl/Mathlib/Order/BoundedDiscrepancy.lean` | `727f2da829f0e4ee99dd09a281a26ca76ad6ed88f2bf585354e6cf7518f0ab01` |

The pinned `lana-agents/iut` dependency is clean at
`ddaddc274281adb5674d647e24fa478745ac6d40`.  A source-wide search confirms
that this pin contains no reference to `Genl`, `HeightTheory`, `StatementI`, or
`ProofPackage`; its README calls the Corollary 3.12 strand a specification
project and says that the repository does not verify IUT.

The detached later public snapshot was checked at
`lana-agents/iut@6e963070c73c5defd1012320deccc777e2555d22`.
Its `Iut/Abc/Target.lean` (SHA-256
`ae179e6da5b1fdce17b78b8fd5e70adec82685c9df942f67ef0cc092d1afacc9`)
defines `ABC T` to be `T.StatementI` and explicitly delegates the concrete
height formalism to `genl`.  Its `Iut/Concrete/Main.lean` (SHA-256
`71a04da72984ec6a980dda5da15526e121acad15990a8ebf70ef33b9dc7de6a0`)
proves only a conditional implication: `T`, `T.ProofPackage`, the
Corollary-2.2 input family, concrete theta-data existence, Chebyshev and
prime-counting bounds, and the Corollary-3.12 variant are all premises.  The
research report's source boundary is therefore accurate.

## 2. Documentary correction applied during integration

The audited snapshot said that the relevant IUT source was
"Corollary 3.12 and its proof on printed pp. 181--185."  The author PDF shows:

* the statement of Corollary 3.12 begins on printed p. 173 and continues on
  p. 174;
* its proof begins on printed p. 174;
* printed pp. 181--185 contain the decisive final Step (xi), including the
  same-container/log-volume comparison.

The integrated report now says:

> Corollary 3.12, printed pp. 173--174, and its proof on pp. 174--185,
> especially Step (xi) on pp. 181--185.

No formula or inference in the report depended on the incorrect abbreviated
range.  This was the only required correction found.

## 3. Arithmetic source definitions

I visually inspected printed pp. 4--11 of *Arithmetic Elliptic Curves in
General Position*, including Definition 1.2, Example 1.3(i), Proposition 1.4,
Definition 1.5, Remark 1.5.1, and Theorem 2.1.  The report uses their
normalizations correctly.

### 3.1 Point and degree

For `x ∈ ℚ` with `0 < x < 1`, the affine coordinate recovers `x`
from `[x:1]`, so the displayed map is injective and lands in
`ℙ¹ ∖ {0,1,∞}`.  Since the point is defined over
`ℚ`, its minimal field of definition is `ℚ`, hence its
degree is one.  Example 1.3(i) defines the exact-degree locus by subtracting
the preceding at-most-degree locus, so degree-at-most one and exact degree one
agree.

The abstract Genl recurrence has exactly the same consequence:

\[
 \operatorname{ptLE}(X,1)
 =\operatorname{ptLE}(X,0)\cup\operatorname{ptEQ}(X,1)
 =\operatorname{ptEQ}(X,1).
\]

The source theorem quantifies over positive integers `d`.  The Lean record
uses `d : Nat`, hence formally also admits `d = 0`; `ptLE_zero = empty` makes
that additional case vacuous.  The audited transport uses `d = 1`, so there is
no quantifier mismatch.

### 3.2 Height and both BD directions

On `ℙ¹`,

\[
 \omega_{\mathbb P^1}(0+1+\infty)
 \cong \mathcal O_{\mathbb P^1}(-2+3)
 \cong \mathcal O_{\mathbb P^1}(1).
\]

The normalized logarithmic Weil height is a height for
`O(1)`.  Proposition 1.4(iii) says that the BD class depends only
on the generic-fibre line-bundle isomorphism class.  Thus the source height
and the repository height dominate each other up to global additive
constants.  The report correctly avoids claiming equality of arbitrary
chosen representatives.

The Genl definitions agree with the report's orientation.  If
`sourceHeight ≈ targetHeight`, `.le` means
`sourceHeight <= targetHeight + O(1)`, while `.ge` means
`targetHeight <= sourceHeight + O(1)`.  The Lean proof uses `.ge` in the
forward-to-abc direction and `.le` in the reverse direction, exactly as
required.

### 3.3 Different

Definition 1.5(iii) uses the normalized arithmetic degree of the different
ideal of the minimal field.  For a rational point the minimal field is
`ℚ`, whose different over `ℚ` is the unit ideal.  Its
arithmetic divisor and normalized degree are zero.  The report's exact
identity `logDiff = 0` is correct; it is source semantics, not a law of the
abstract `HeightTheory` record.

### 3.4 Conductor

For `x = m/n` with `0 < m < n` and `gcd(m,n) = 1`, the primitive pair
`(m,n)` extends to a section of `ℙ¹_Z`.  Pullback of
the horizontal sections `0,1,∞` gives the divisors of
`m,n-m,n`, respectively (the sign in `m-n` is immaterial).  Reducing the
pullback divisor therefore gives coefficient one precisely at primes dividing
`m(n-m)n`.  Its normalized degree over `ℚ` is

\[
 \sum_{p\mid m(n-m)n}\log p.
\]

This is exactly the union of the reduced numerator/denominator supports of
`x` and `1-x`, hence the repository's truncated tripod count.  The
standard-model equality is correct.  Remark 1.5.1 says that the BD class of
the conductor depends only on the generic pair `(X_Q,D_Q)`; consequently any
allowed model differs from the standard model by a
uniform bounded discrepancy on all algebraic points, and hence on the
rational chart.

The checks `x = 1/2, 2/3, 3/5` give supports
`{2}`, `{2,3}`, `{2,3,5}`, respectively, on both sides.  These
are sanity checks; the pullback argument proves the identity for every
reduced `m/n`.

## 4. Statement I and transport constants

Pinned `Genl.HeightTheory.StatementI` is

\[
 \forall X\;\text{hyperbolic},\ \forall d,\ \forall\epsilon>0,
 \quad h_X\lesssim_{\operatorname{ptLE}(X,d)}
 (1+\epsilon)(\operatorname{diff}_X+\operatorname{cond}_X).
\]

Specializing to the hyperbolic tripod and `d = 1`, then restricting to the
realized points, gives the report's `RStmtI`.  The additive discrepancy may
depend on `X,d,epsilon`, which are fixed at this specialization, but not on
the rational point.  The Lean theorem preserves this quantifier order.

The four BD constants are used in the only valid orientations:

| transport direction | height comparison | conductor comparison |
|---|---|---|
| `RStmtI -> abc` | `h <= H_T + A_-` | `N_T <= n + B_+` |
| `abc -> RStmtI` | `H_T <= h + A_+` | `n <= N_T + B_-` |

Because `epsilon > 0`, `1 + epsilon > 0`, so multiplying either conductor
inequality preserves its direction.  The constants

\[
 C_\epsilon+A_-+(1+\epsilon)B_+,
 \qquad
 C_\epsilon+A_++(1+\epsilon)B_-
\]

are uniform in the point.  The already formalized equivalence between the
uniform rational-tripod inequality and the repository's integer
`ABCConjecture` then proves the biconditional.  No occurrence of
`ABCConjecture` is assumed in the forward theorem.

## 5. Countermodel boundary audit

I checked every field of the pressure models against the actual definitions
of `HeightTheory`, `Covering`, `BelyiDescent`, and `ProofPackage`.

1. **Degree-empty model:** all `ptLE` and `ptEQ` loci are empty.  Statement I,
   covering surjectivity, and the covering BD inequalities are vacuous.  The
   Belyi input is the negation of a BD inequality on an empty set and is
   contradictory.  Thus the model really has a full `ProofPackage` but cannot
   have even the weaker `OpenUnitTripodComparison`; it therefore cannot have a
   source realization.
2. **Height-zero model:** the identity covering preserves every degree locus;
   `0 <= 0 + n` and `0 <= (1+epsilon)0` supply its two comparisons.  The Belyi
   negated premise is again impossible because zero is BD-dominated by zero.
   The actual rational height is unbounded, so no uniform lower comparison
   `h <= H_T + O(1)` exists.  This model has a full `ProofPackage`.
3. **Conductor-inflated model:** with
   `N_T = n + exp(2h)`, nonnegativity of `h,n` and
   `exp(2h) >= 1+2h` make Statement I true with constant zero.  Unboundedness
   of `h` rules out `N_T <= n + O(1)`.  The report and paper correctly state
   that no `ProofPackage` is claimed for this model.
4. **Different-inflated model:** the identity covering satisfies
   `exp(2h) <= exp(2h) + n` and
   `h <= (1+epsilon)h`.  The global inequality
   `h <= (1+epsilon)exp(2h)` contradicts the Belyi failure premise.  Hence
   this model really has a full `ProofPackage` while its different is nowhere
   zero.
5. **Reverse-direction sequence models:** `(sourceHeight, sourceRadical) =
   (k,0)` has no uniform epsilon bound.  Pairing it first with target `(0,0)`
   and then with target `(k,k)` gives, respectively, exact radical equality
   without the needed source-height upper comparison and exact height equality
   without the needed target-radical upper comparison.  The claimed missing
   orientations are therefore individually necessary.

These are full-premise counterexamples only to the exact weakened extraction
or transport claims stated in the report.  They do not instantiate the
arithmetic objects of Definitions 1.2 and 1.5 and do not refute the genuine
rational calculation, IUT, Corollary 3.12, or abc.  The route remains active.

## 6. Lean and paper checks

The following commands succeeded:

```text
cd Lean
lake env lean -DwarningAsError=true \
  IUTThreeClosures/IUTRationalDegreeOneSourceRealization20260901.lean
lake build IUTThreeClosures.IUTRationalDegreeOneSourceRealization20260901
```

The direct warning-as-error compilation produced no warning.  The targeted
Lake build completed all 8,762 jobs; it replayed pre-existing warnings from
unrelated imported modules, while the audited target itself replayed
successfully.

All fourteen `#print axioms` declarations report exactly the standard set

```text
propext, Classical.choice, Quot.sound
```

and no custom axiom.  The Lean source contains no `sorry`, `admit`, axiom
declaration, or `native_decide`.  The theorem bodies match the research proof:
the degree recurrence is kernel checked, the two BD directions are selected
correctly, full Statement I is specialized at `d = 1`, and every pressure
model has the advertised fields.

The paper fragment states the same conditional theorem, uses the same four
transport constants, and gives the conductor-inflated model the necessary
no-`ProofPackage` caveat.  It does not claim an arithmetic `HeightTheory`
instance, `T.StatementI`, an IUT comparison, or abc.

## 7. Final conclusion

After the page-range correction in Section 2 above, the checkpoint is
source-faithful within its stated boundary.  The elementary rational
degree-one source normalization is mathematically correct, and the Lean
module correctly proves the abstract transport and countermodel statements.
The remaining gates are exactly the ones listed in the report: construction
of the genuine arithmetic `HeightTheory` and its source-realization proofs,
the genuine `ProofPackage`, and the upstream IUT hypotheses needed to obtain
`T.StatementI`.
