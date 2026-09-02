# The rational-tripod shadow comparison: exact zero-error arithmetic and full-premise interface pressure tests

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional construction of the degree-at-most-one encoding and
the two zero-error integer comparisons in a rational-tripod shadow height
theory; exact equivalence of its `StatementI` with integer abc; no proof or
disproof of IUT or abc.

## 1. Source boundary and objective

The repository manifest pins
[`Genl.HeightTheory`](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean)
at `6e9a6543b46a2a02fd7fe7ec8ab203d878f32859` and
[`lana-agents/iut`](https://github.com/lana-agents/iut/tree/ddaddc274281adb5674d647e24fa478745ac6d40)
at `ddaddc274281adb5674d647e24fa478745ac6d40`.  The pinned IUT README says
explicitly that it does not verify IUT and that its Corollary 3.12 variant is a
specification left without proof or axiom.  The separately audited
[public IUT head](https://github.com/lana-agents/iut/tree/6e963070c73c5defd1012320deccc777e2555d22)
`6e963070c73c5defd1012320deccc777e2555d22` adds a conditional path to
`T.StatementI`; it still requires its stated height-theory, theta-data, analytic,
and Corollary 3.12 inputs.

The pinned
`Genl.HeightTheory`
contains types of curves and points, degree loci, three real-valued functions,
and a distinguished tripod.  Apart from the recurrence for the degree loci, it
does not require these fields to be the actual arithmetic objects described in
their comments.  Consequently a theorem using this structure must distinguish
formal interface consequences from arithmetic semantics.

The previous comparison report isolated four inputs needed to pass from
`T.StatementI` to the repository's integer `ABCConjecture`:

1. an encoding of every positive primitive triple in `T.Pt T.tripod`;
2. membership of each encoded point in `T.ptLE T.tripod 1`;
3. a uniform upper comparison from the integer height to `T.htCan`;
4. a uniform upper comparison from `T.logDiff+T.logCond` to the integer
   radical term.

This note attacks those inputs on the actual rational tripod.  It constructs a
fully explicit shadow height theory in which all four inputs hold with error
zero.  It then proves that Statement I for this shadow is exactly abc, rather
than claiming the shadow to be the intended arithmetic `Genl.HeightTheory` or
an IUT object.

The arithmetic ingredients already proved in the repository are:

* `ABCPoint.lambda`, `lambda_pos`, and `lambda_lt_one` in
  `ABCPointLegendreCurve.lean`;
* `normalizedLogHeight_lambda` in `TripodWeilHeight.lean`;
* `rationalTripodCounting_lambda` and the inverse construction `ABCPoint.ofRat`
  in `SUnitUniformTripod.lean`;
* `tripodTruncatedCounting_eq_conductor` in
  `ArakelovFermatLogCanonical.lean`.

The pinned and detached-current LANA snapshots therefore leave different
explicit interfaces open.  Nothing below asserts that either snapshot's local
containers instantiate the shadow or the intended arithmetic height theory.

For the mathematical normalization, the source statements are Definitions
1.2 and 1.5 and Theorem 2.1 of Mochizuki's
[*Arithmetic Elliptic Curves in General Position*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf).
The later IUT input remains the comparison represented by Corollary 3.12 of
[*Inter-universal Teichmuller Theory III*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf).
The present theorem concerns the elementary rational-tripod realization at the
target of those interfaces; it does not claim to derive that target from
Corollary 3.12.

## 2. Exact arithmetic on the open rational tripod

Put

\[
 U(\mathbb Q)=\{x\in\mathbb Q:0<x<1\}.
\]

For a positive primitive triple `t=(a,b,c)` with `a+b=c`, define

\[
 \lambda(t)=a/c\in U(\mathbb Q).
\]

Conversely, if `x=m/n` is in lowest terms and `0<x<1`, then

\[
 t(x)=(m,n-m,n)
\]

is a positive primitive triple.  Indeed `0<m<n`; coprimality of `m,n`
implies the three pairwise coprimality statements for `m,n-m,n`; and
`m+(n-m)=n`.  Reduction of `a/c` and uniqueness of numerator and denominator
show that these constructions are inverse.

Define the rational-tripod height and count by

\[
 H_{\rm tr}(x)=h_{\mathbb P^1}(x),\qquad
 N_{\rm tr}(x)=\log\prod_{p\in
   \operatorname{supp}(x)\cup\operatorname{supp}(1-x)}p.
\]

### Theorem 2.1 (zero-error normalization)

For every positive primitive triple `t=(a,b,c)`,

\[
 H_{\rm tr}(\lambda(t))=\log c
   =\log\max(a,b,c)
\]

and

\[
 N_{\rm tr}(\lambda(t))=\log\operatorname{rad}(abc).
\]

#### Proof

Since `gcd(a,c)=1`, the reduced numerator and denominator of `a/c` are `a`
and `c`.  Positivity and `a+b=c` give `0<a<c`, so the rational logarithmic
Weil height is `log max(a,c)=log c`.  The same inequalities give
`max(a,b,c)=c`.

The reduced coordinates are

\[
 x=a/c,\qquad 1-x=b/c.
\]

Pairwise coprimality makes the union of the prime supports of the two reduced
coordinates exactly the prime support of `abc`.  Taking the product once over
this union gives `rad(abc)`.  Taking logarithms proves the second identity.
\(\square\)

Thus the arithmetic part of both comparison inequalities already has error
zero.  The unresolved issue for a general `T` is the semantic identification
of these rational points and functions with `T.Pt`, `T.htCan`, `T.logDiff`,
and `T.logCond`.

## 3. The rational-tripod shadow height theory

Define a `Genl.HeightTheory` `T_rat` as follows.

* There is one curve, which is the distinguished tripod.
* Its point type is `U(Q)`.
* The degree-at-most-zero locus is empty.  Every point belongs to the
  degree-at-most-`d` locus for `d>=1`; the exact-degree-one locus is all of
  `U(Q)` and all other exact-degree loci are empty.
* `htCan=H_tr`, `logDiff=0`, and `logCond=N_tr`.
* The tripod is declared hyperbolic; the unused divisor-free and compact-set
  fields receive elementary witnesses.

The degree recurrence is exact: at `d=0`, empty union the exact-degree-one
locus is the full degree-at-most-one locus; after that the degree-at-most locus
is already universal.

### Theorem 3.1 (unconditional zero-error comparison package)

`T_rat` admits the uniform tripod comparison package with encoding
`t |-> lambda(t)`, degree bound one, and

\[
 A_H=A_R=0.
\]

#### Proof

Membership is built into the degree-one locus.  The two comparison
inequalities are equalities by Theorem 2.1. \(\square\)

This is a positive compatibility theorem: the four requested fields do not
contradict one another and have a canonical exact arithmetic realization.  It
is not yet an instantiation of the intended arithmetic geometry hidden behind
the comments of `Genl.HeightTheory`.

### Theorem 3.2 (exact logical boundary)

\[
 T_{\rm rat}.\mathrm{StatementI}
 \quad\Longleftrightarrow\quad
 \mathrm{ABCConjecture}.
\]

#### Proof

In the forward direction, apply the comparison transfer theorem with the
zero-error package of Theorem 3.1.

In the reverse direction, integer abc is equivalent to the uniform rational
tripod inequality already proved in `SUnitUniformTripod.lean`.  That inequality
is precisely Statement I for the only curve of `T_rat`: degree zero is vacuous,
and every positive degree bound has domain all of `U(Q)`. \(\square\)

The theorem prevents a false breakthrough claim.  Constructing the exact
comparison fields in the shadow does not prove Statement I; proving Statement I
there is exactly the original abc problem.

## 4. A semantic realization interface and equivalence with integer triples

For an arbitrary `T : Genl.HeightTheory`, define an **open-rational tripod
comparison** to consist of

* a map `j : U(Q) -> T.Pt T.tripod`;
* `j(x) in T.ptLE T.tripod 1` for every `x`;
* constants `A_H,A_R` such that
  \[
  H_{\rm tr}(x)\le T.htCan(j(x))+A_H
  \]
  and
  \[
  T.logDiff(j(x))+T.logCond(j(x))\le N_{\rm tr}(x)+A_R.
  \]

### Theorem 4.1 (no loss between rational and integer packages)

An open-rational tripod comparison constructs the integer
`StatementIIntegerComparison`.  Conversely, an integer comparison constructs an
open-rational comparison by applying it to `t(x)=(m,n-m,n)`.  Both conversions
preserve the two error constants.

#### Proof

The forward conversion composes `j` with `lambda(t)` and uses Theorem 2.1.
The reverse conversion composes the integer encoding with `t(x)` and uses the
inverse identity `lambda(t(x))=x`, followed again by Theorem 2.1. \(\square\)

This identifies the smallest semantic target exposed by the present work: an
actual rational-point realization together with the two standard
normalizations.  It does not identify that target with any current LANA
container.

## 5. Full-premise pressure tests

The following models test exact proposed implications.  Each negative result
retires only the displayed implication, not the repaired IUT/same-pilot route.

### 5.1 Degree membership is not supplied by the current abstract interface

Let `T_empty` have one point on one curve but declare every degree locus empty;
put all three height functions equal to zero.  It satisfies every field of
`Genl.HeightTheory`, including its degree recurrence, and its `StatementI` is
vacuously true.  Nevertheless no map from the nonempty set `U(Q)` can land in
`ptLE tripod 1=empty`.

Therefore the complete proposition

\[
 \forall T,\quad T.\mathrm{StatementI}\Longrightarrow
 \text{an open-rational tripod comparison for }T
\]

is false.  This is a counterexample to automatic degree realization from the
current interface, not to the intended arithmetic degree statement.

### 5.2 Height normalization is independent even when the other data survive

On the same point space `U(Q)` and the same degree loci as `T_rat`, define

\[
 htCan=0,\qquad logDiff=0,\qquad logCond=N_{\rm tr}.
\]

Call this `T_H`.  Since `N_tr>=0`, Statement I holds with constant zero.  The
identity encoding has degree one and its radical comparison is equality.
Pointwise height comparison is possible with the input-dependent error
`E_H(x)=H_tr(x)`.

There is, however, no constant `A_H` with `H_tr(x)<=A_H` for every `x`.  Indeed
the points `x=1/(n+1)` have height `log(n+1)`, which is unbounded.  Thus
`T_H` satisfies Statement I, degree membership, exact radical comparison, and
pointwise height errors, but refutes the complete claim that these retained
premises force a uniform height error.

### 5.3 Radical normalization is independent even when the other data survive

Define `T_R` on `U(Q)` by

\[
 htCan=H_{\rm tr},\qquad
 logDiff=\exp(2H_{\rm tr}),\qquad
 logCond=N_{\rm tr}.
\]

The identity encoding has degree one and exact height comparison.  Since
`H_tr>=0`,

\[
 e^{2H_{\rm tr}}\ge 1+2H_{\rm tr}\ge H_{\rm tr};
\]

therefore Statement I holds with constant zero for every positive epsilon.
The radical comparison holds pointwise with the input-dependent error
`E_R(x)=exp(2H_tr(x))`.

No uniform radical error exists.  If

\[
 e^{2H_{\rm tr}(x)}+N_{\rm tr}(x)
 \le N_{\rm tr}(x)+A_R
\]

held for all `x`, then `e^{2H_tr(x)}<=A_R` would be uniform, contradicting the
unboundedness of `H_tr`.  Thus `T_R` preserves Statement I, degree membership,
and exact height comparison while refuting precisely the uniform radical
normalization claim.

### 5.4 What the tests establish

The three models give a strict boundary.

* The zero-error comparison is unconditionally realized in `T_rat`.
* `StatementI` and the bare `HeightTheory` fields do not manufacture rational
  degree-one points.
* Even with actual rational points and the other comparison exact, neither
  uniform height normalization nor uniform radical normalization follows from
  the present structural axioms.
* Allowing input-dependent errors makes both failed comparisons tautologically
  true in the countermodels and still does not yield uniform constants.

These are full-premise counterexamples to the named interface implications.
They are deliberately artificial height theories, not counterexamples to the
standard arithmetic normalization, IUT, `StatementI` for the intended height
theory, or integer abc.

## 6. Consequence for the active IUT route

The arithmetic half of the uniform tripod comparison is now exact in a
canonical rational shadow.  The remaining positive IUT task is a semantic
realization theorem from the intended LANA/Genl arithmetic objects to this
shadow:

1. construct the rational point `a/c` in the intended `T.Pt T.tripod`;
2. prove it belongs to `ptLE tripod 1`;
3. compare the intended canonical height with the standard rational Weil
   height by a triple-independent constant;
4. compare the intended different plus conductor with the truncated tripod
   count by a triple-independent constant.

The pressure models prove that none of these semantic steps can be extracted
from the current bare fields by definitional reduction.  They do not show that
the intended arithmetic realization is false.  Accordingly the IUT/same-pilot
route remains active.

## 7. Formalization boundary

The companion module
`Lean/IUTThreeClosures/IUTRationalTripodShadowComparison20260901.lean`
formalizes the preceding arithmetic conversions, the rational shadow height
theory, its zero-error comparison, the exact `StatementI`/abc equivalence, the
unboundedness lemma, and all three pressure models.  It introduces no axiom,
`sorry`, `admit`, or `native_decide`.
