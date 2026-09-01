# Independent review of the exact Frey isogeny Weil heights

Author: ChatGPT. Date: 2026-08-31.

**Verdict: pass.** All 27 public theorems and all three private
helpers were read and independently checked against the preceding
mathematical proofs. The actual rational-coordinate and height APIs
have the claimed meaning. The exact minima and uniqueness retain
the necessary \(n\geq1\) hypothesis. The paper uses a separate
entire-isogeny-class theorem; the Lean enumeration does not claim
to establish that theorem.

No source code, paper input, frozen mathematical report, PDF,
or acceptance snapshot was edited by this reviewer.

## 1. Exact reviewed files

| File | Bytes | SHA-256 |
|---|---:|---|
| research/FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md | 11440 | 0ed2d3d5915f23d4fc583af5d436722f1727169f0cad52f7b0c451ae1b28c729 |
| research/FREY_ISOGENY_WEIL_HEIGHT_FORMAL_PROOFS_2026_08_31.md | 10346 | 5a1e4525b307ca4318b1f2b3f40bb3264c35cb8170f01c6460d6e0730e7bba07 |
| Lean/IUTThreeClosures/FreyIsogenyWeilHeight20260831.lean | 17762 | 40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587 |
| paper/uniform_continuation_weil_height_2026.tex | 10583 | fa24fbcca18eafea6beb2d94ff40a6abca88f22ffff4c08d770854763e4e6ffe |

The imported actual-model module is unchanged from its earlier
independent review:
FreyEntireIsogenyArithmetic20260831.lean, SHA-256
d31d9a21e912da6d120280e38a97db82950756fae8e36a8ddbaeff3725fb00fe.
Its actual models, invariant formulas, ellipticity instance,
canonical-curve identifications and absolute-\(j\) lower bound
were checked again at the uses made here.

The final new module differs from its original version only in
two documentation strings. Restoring the two original strings
in memory exactly reproduces the original full-file SHA-256
eefb51c969574aacd347cf161025d700ba83b81ecb475f051cf06d55bf38d620.
Thus no theorem, proof, definition, import or option changed in
that correction.

## 2. Actual objects and library meanings

The curves are the existing values
\[
 \text{familyCurve }n\,i
   =\text{model }(1792n+2)\,i
   :\operatorname{WeierstrassCurve}(\mathbb Q).
\]
The old model theorem identifies them with the four existing
canonical Frey and two-isogeny equations of the actual
ABCPoint familyTriple. Their ellipticity comes from their
nonzero displayed discriminants. The new file uses their
actual library \(j\)-invariants.

The five new definitions only name the integer half-endpoint,
four integer polynomials, four signed coefficients, and candidate
integer numerators and denominators. None defines a substitute
curve, a substitute \(j\), or a substitute height.

The relevant dependency implementations were read directly:

- Mathlib/NumberTheory/Height/Basic.lean, lines 115--148:
  Height.mulHeight₁ is the product of contributions from the
  admissible absolute values, and Height.logHeight₁ is its
  real logarithm.
- Mathlib/NumberTheory/Height/NumberField.lean, lines 494--514:
  Rat.mulHeight₁_eq_max gives
  \(\max(q.\mathrm{num}.\mathrm{natAbs},q.\mathrm{den})\);
  the logarithmic theorem takes the logarithm of that maximum.
- Mathlib/Data/Rat/Lemmas.lean, lines 242--252:
  the canonical numerator and denominator theorems require a
  positive integer denominator and full coprimality of the
  absolute integers.
- The existing Heights/WeilHeight.lean defines
  \[
    \operatorname{normalizedLogHeight}_K(x)
       =\frac{\operatorname{logHeight}_1(x)}{[K:\mathbb Q]}.
  \]
  At \(K=\mathbb Q\) the denominator is one. The new bridge
  simply unfolds this definition and uses that fact.

The relevant installed package revisions are mathlib
81a5d257c8e410db227a6665ed08f64fea08e997 and heights
3539e2a12dd3470c057a4eb531dc3fd627d4c97b, as recorded in
the unchanged Lake manifest.

## 3. Independent arithmetic check

Put \(c=1792n+2=2u\), \(u=896n+1\), and
\[
 P=c^2-c+1,\quad Q=c^2-16c+16,\quad
 R=c^2+14c+1,\quad S=16c^2-16c+1.
\]
Direct substitution into the actual \(c_4^3/\Delta\)
formulas gives the signed fractions
\[
 \frac{64P^3}{u^2(c-1)^2},\qquad
 \frac{-Q^3}{(c-1)u^4},\qquad
 \frac{8R^3}{u(c-1)^4},\qquad
 \frac{8S^3}{u(c-1)}.
 \tag{3.1}
\]
In particular the zero-kernel numerator is \(-Q^3\),
not \(Q^3\). The code retains this sign even outside
the later positive-\(Q\) range.

The residues of \(P,Q,R,S\) modulo \(u\) are
\(1,16,1,1\), and modulo \(c-1\) are \(1,1,16,1\).
The explicit identities
\[
 2(-448n)+u=1,\qquad 2(-896n)+(c-1)=1
\]
make 2 coprime to both denominator factors.
The polynomial residue identities therefore establish
full integer coprimality for every fraction (3.1),
including all powers of 2. They are not merely
odd-prime gcd arguments.

Both denominator factors are positive for every \(n\geq0\).
The actual Rat numerator and denominator consequently are
the signed integers in (3.1); the library canonical-coordinate
theorems are applied with all their required hypotheses.

For \(n\geq1\), \(c\geq1794>32\), and
\[
 \frac{c^2}{2}<Q<c^2,\qquad P>Q,\quad R>Q,\quad S>Q.
 \tag{3.2}
\]
The old actual-model bound \(|j|\geq2c\) implies that
each absolute numerator exceeds its denominator.
Hence the four multiplicative heights are precisely
\[
 64P^3,\quad Q^3,\quad 8R^3,\quad 8S^3.
 \tag{3.3}
\]
Their logarithms are the stated height table.
Strict positivity and the three strict polynomial
comparisons make the zero-kernel height smaller than
each of the other three. This proves the attained
minimum, rather than merely a common lower bound.
The strict comparisons also prove uniqueness of its
label.

The \(n\geq1\) restriction is material. At \(n=0\),
\(c=2,u=1,P=3,Q=-12\), and the first two fractions
both equal 1728. Unique minimization by the zero-kernel
label would be false there. The module permits \(n=0\)
only for the signed rational identities, gcd statements
and normalization bridge, where it is valid.

## 4. All public statements and private helpers reviewed

All names in this table lie in
IUTThreeClosures.FreyIsogenyWeilHeight20260831.

| Public theorem | Independent check |
|---|---|
| endpoint_eq_two_half | Exact identity \(1792n+2=2(896n+1)\). |
| halfEndpoint_pos | Positive for all natural \(n\). |
| reducedDenominator_pos | Uses positive \(u\) and \(c-1\); valid at \(n=0\). |
| two_coprime_halfEndpoint | Explicit Bezout identity above. |
| two_coprime_endpoint_sub_one | Second explicit Bezout identity above. |
| corePolynomial_coprime_halfEndpoint | The four exact residue identities modulo \(u\). |
| corePolynomial_coprime_endpoint_sub_one | The four exact residue identities modulo \(c-1\). |
| reduced_coprime | Powers, products, the signed unit \(-1\), and the powers of 2 are all handled. |
| familyCurve_j_eq_reduced | Expands the actual elliptic curve invariant and proves the signed identities (3.1). |
| familyCurve_j_num | Positive denominator plus full integer gcd gives the actual stored numerator. |
| familyCurve_j_den | The same hypotheses give the actual positive stored denominator. |
| familyCurve_den_le_num_natAbs | Uses the actual rational absolute-\(j\) lower bound for \(n\geq1\). |
| familyCurve_mulHeight_eq_abs_reducedNumerator | Applies the actual rational height maximum theorem, then the actual numerator identity. |
| corePolynomial_pos | Positive for every real \(c\geq32\), including \(c=32\). |
| zeroKernel_corePolynomial_lt | All three comparisons are strict; the excluded label is explicit. |
| familyCurve_mulHeight | Exact table (3.3), with \(n\geq1\). |
| familyCurve_logHeight | Takes logarithms of positive factors in (3.3); no logarithm of a nonpositive factor is used. |
| zeroKernel_mulHeight_lt | Strict cube comparison and positive factors 64 or 8. |
| zeroKernel_logHeight_lt | Strict monotonicity of log on positive multiplicative heights. |
| familyCurve_logHeight_isLeast | Supplies the zero-kernel witness in the Set.range and a lower-bound proof for every range element. |
| familyCurve_mulHeight_isLeast | Same attained-minimum proof for multiplicative heights. |
| familyCurve_logHeight_eq_min_iff | Equality excludes every other label by the strict comparison; the reverse direction uses the exact table. |
| familyCurve_normalizedLogHeight | Equality of the existing two APIs at degree-one field \(\mathbb Q\), for all \(n\). |
| familyCurve_normalizedLogHeight_isLeast | Transports the already attained minimum through that equality. |
| familyCurve_normalizedLogHeight_eq_min_iff | Transports the exact uniqueness assertion. |
| zeroKernel_corePolynomial_bounds | \(Q-c^2/2=c(c-32)/2+16>0\) and \(c^2-Q=16c-16>0\). |
| zeroKernel_logHeight_bounds | Applies log monotonicity to the preceding strict positive bounds and multiplies by 3. |

The three private helpers were checked separately:

1. isCoprime_of_residue: if \(x=r+yk\) and \(Ar+By=1\),
   then \(Ax+(B-Ak)y=1\). This is exactly its constructed
   Bezout witness over \(\mathbb Z\).
2. rat_den_le_num_natAbs: the canonical denominator is positive,
   and \(|q|=|q.\mathrm{num}|/q.\mathrm{den}\). Multiplying
   \(1\leq|q|\) by that denominator gives the required inequality.
3. corePolynomial_int_cast: integer casting preserves each
   displayed polynomial in every commutative ring. No
   characteristic-zero assumption is needed for this identity.

The Set.range in the minimum statements is expressly a range over
ModelLabel. There is no formal quantifier over all rationally
isogenous elliptic curves hidden behind that type.

## 5. Paper and whole-class boundary

The English input was read in full against the mathematical report.
Its three complex-absolute-value ratios to the zero-kernel model are
\[
 \frac{16c^2}{c-1}(P/Q)^3,\qquad
 \left(\frac{cR}{(c-1)Q}\right)^3,\qquad
 \left(\frac{cS}{Q}\right)^3.
\]
All are strictly greater than one by (3.2).
Together with the already proved entire-class theorem this
establishes the two unique minimizing rational isomorphism classes
claimed in the paper. The isogeny-class theorem, including its
cyclic-isogeny and Frobenius inputs, is explicitly cited; the
finite label enumeration is not offered as its proof.

The finite-place contribution of a reduced rational \(N/D\) is
\(\log D\). Consequently the exact gap at the common minimizer is
\[
 \log((c-1)u^4)
   =5\log c-\log16+\log(1-1/c).
\]
The limits, the bounded gain
\(\log64+3\log(P/Q)\in(6\log2,9\log2)\),
and the two quantified obstruction statements follow from the
displayed formulas. In particular the quantifier order is
\(\forall\delta>0\,\forall C\,\exists n\,\forall F\in\mathcal I_{c_n}\);
the selected \(n\) can be chosen once for the entire class.

These paper conclusions are not all asserted as Lean theorems.
The paper correctly leaves the strict complex minimum, finite-place
identity, limits, bounded-gain formula and entire-class quantified
obstruction outside the new module's formal scope.
Its small-radical disclaimer is also necessary and retained:
the family has not been shown to violate any height--radical
bound, modified Szpiro statement or ABC.

## 6. Independent verification performed

From the Lean project the reviewer independently ran

    lake env lean IUTThreeClosures/FreyIsogenyWeilHeight20260831.lean

against the final 40421af9... source. It returned exit code 0,
with no warnings or errors.

A separate temporary audit imports the compiled module and
executes both a type check and an axiom inspection for each
of the 27 public theorems. It also enumerates the three actual
private helper declarations from the Lean environment and uses
Lean.collectAxioms on each, asserting that exactly three were
found. This final audit returned exit code 0 with no warnings.
All 30 dependency lists are subsets of
\[
 \{\text{propext},\ \text{Classical.choice},\ \text{Quot.sound}\}.
\]
No conjectural axiom or sorryAx occurs.

Audit artifacts are in
tmp/lean_audits/frey_weil_height_cross_review_2026_08_31/:

- Audit.lean and declarations.json: the complete statement lists
  and private-helper inspection.
- direct.stdout.log, direct.stderr.log and direct-result.json:
  the independent check of the actual final source.
- final-audit.stdout.log, final-audit.stderr.log and
  final-audit-result.json: all 27 public and three private
  declaration inspections.
- review-validation.json: exact reviewed hashes, counts, allowed
  axiom union, the comment-only reconstruction check, and exit codes.

An initial temporary attempt to discover private names used an
unsupported prefix lookup and failed after the 27 public checks
had passed. It was replaced by explicit environment enumeration;
the initial logs are retained separately. This was an audit-script
error, not a failure of the reviewed source.

This independent direct invocation does not itself run every
project style linter. The author's separate final targeted Lake
build, recorded in the companion, covers that additional scope.
No claim that all imported dependencies are warning-free is made.

There are no remaining required corrections to the reviewed
mathematical statements, their formal representation, or the
English input's stated formalization boundary.
