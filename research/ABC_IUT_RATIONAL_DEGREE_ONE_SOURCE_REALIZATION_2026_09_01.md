# A source-faithful degree-one realization of the rational tripod

**Author:** ChatGPT

**Date:** 2026-09-01

**Status:** unconditional source-level realization and transport theorem for the
rational degree-one tripod; no proof or disproof of IUT, Corollary 3.12, or abc.

## 1. Exact source boundary

This checkpoint separates three layers that must not be identified.

1. Shinichi Mochizuki's *Arithmetic Elliptic Curves in General Position*
   defines the genuine arithmetic point, degree, height, different, and
   conductor objects used in its Theorem 2.1.
2. The pinned `genl` commit
   [`6e9a6543b46a2a02fd7fe7ec8ab203d878f32859`](https://github.com/LANA-Project/genl/tree/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859)
   provides an abstract record with fields bearing those names.  It does not
   construct an arithmetic instance of the record.
3. The pinned `lana-agents/iut` commit
   [`ddaddc274281adb5674d647e24fa478745ac6d40`](https://github.com/lana-agents/iut/tree/ddaddc274281adb5674d647e24fa478745ac6d40)
   does not connect its Corollary 3.12 variant to `Genl.HeightTheory` at all.
   A later audited public snapshot,
   [`6e963070c73c5defd1012320deccc777e2555d22`](https://github.com/lana-agents/iut/tree/6e963070c73c5defd1012320deccc777e2555d22),
   has a conditional path to `T.StatementI`, but still takes `T`, its
   `ProofPackage`, and the remaining IUT and analytic inputs as premises.

The primary arithmetic source is Mochizuki's author-hosted
[*Arithmetic Elliptic Curves in General Position*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf).
The relevant printed locations are:

| Object | Arithmetic source | Pinned Lean source |
|---|---|---|
| algebraic point | `X(\overline{\mathbb Q})`, discussion preceding Definition 1.2, printed pp. 4--5 | `HeightTheory.Pt`, [`HeightTheory.lean`, lines 61--62](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L61-L62) |
| degree `<=d` and `=d` | Example 1.3(i), printed p. 5; minimal field in Definition 1.5(i), printed p. 8 | `ptLE`, `ptEQ`, and only their recurrence, [lines 67--76](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L67-L76) |
| height | Definition 1.2(i), printed p. 5; BD classes in Definition 1.2(ii); Proposition 1.4(iii), printed p. 6 | `htCan`, [lines 77--80](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L77-L80) |
| log-different | Definition 1.5(iii), printed p. 8 | `logDiff`, [lines 81--83](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L81-L83) |
| log-conductor | Definition 1.5(iv), printed p. 8; model independence up to BD in Remark 1.5.1 | `logCond`, [lines 84--86](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L84-L86) |
| tripod | `(P^1_Q,{0,1,infinity})`, Theorem 2.1(ii), printed p. 11 | `tripod`, [lines 87--95](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L87-L95) |
| Statement I | Theorem 2.1(i), printed p. 11 | `StatementI`, [lines 101--110](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean#L101-L110) |

The pinned [`genl` README, lines 18--24](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/README.md#L18-L24)
says explicitly that the proof is relative to the abstract height formalism
and `ProofPackage` and that their instantiation remains blueprint work.  Its
[`Heights.lean` blueprint chapter, lines 12--17](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/blueprint/GenlBlueprint/Chapters/Heights.lean#L12-L17)
marks the geometric layer of arithmetic line bundles and heights as future
work.  A source search at the pinned commit finds no declaration of the form
`HeightTheory where` other than the record declaration itself.  The pinned IUT
README likewise says that it does not verify IUT and that its Corollary 3.12
strand is a specification project.  In the detached current snapshot,
[`Iut/Abc/Target.lean`, lines 24--38](https://github.com/lana-agents/iut/blob/6e963070c73c5defd1012320deccc777e2555d22/Iut/Abc/Target.lean#L24-L38)
still says that the concrete height formalism is delegated to `genl`, while
[`Concrete/Main.lean`, lines 84--93](https://github.com/lana-agents/iut/blob/6e963070c73c5defd1012320deccc777e2555d22/Iut/Concrete/Main.lean#L84-L93)
states only the fully conditional implication.

The upstream IUT comparison itself is Mochizuki's author-hosted
[*Inter-universal Teichmuller Theory III*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
especially Corollary 3.12 on printed pp. 173--174 and its proof on
pp. 174--185, with the decisive Step (xi) on pp. 181--185.  The public
LANA team's pinned
[*Project LANA Interim Report on IUT Theory*](https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex#L2415-L2423)
reserves judgment on the same-pilot comparison and records it as unresolved.
Neither source supplies the concrete `HeightTheory` realization proved
mathematically below, and the present checkpoint makes no inference from their
disputed or unresolved upstream claims.

## 2. The genuine rational degree-one chart

Let

\[
 P=\mathbb P^1_{\mathbb Q},\qquad
 C=\{0,1,\infty\},\qquad U=P\setminus C,
\]

and let

\[
 U_{(0,1)}(\mathbb Q)=\{x\in\mathbb Q:0<x<1\}.
\]

For `x` in this set, put

\[
 j(x)=[x:1]\in U(\mathbb Q)\subset U(\overline{\mathbb Q}).
\]

Write `h(x)` for the normalized logarithmic Weil height on `P^1(Q)`, and
write `n(x)` for the truncated three-point count used in the companion
rational-tripod formalization:

\[
 n(x)=\sum_{p\in\operatorname{supp}(x)\cup
                    \operatorname{supp}(1-x)}\log p.
\]

### Proposition 2.1 (point object and exact degree)

The map `j` is injective, and every `j(x)` has minimal field of definition
`Q`.  Hence

\[
 j(x)\in U(\overline{\mathbb Q})^{=1}
       =U(\overline{\mathbb Q})^{\le 1}.
\]

#### Proof

The affine coordinate on `P^1 minus infinity` recovers `x` from `[x:1]`, so
`j` is injective.  Since `x` is rational, `j(x)` is defined over `Q`.  Every
number field contains `Q`, so no proper subfield can be a field of definition;
the minimal field is exactly `Q`, of degree one.

Example 1.3(i) defines the degree-at-most-one locus as the union over fields
of degree at most one and the exact-degree-one locus as the difference between
the degree-at-most-one and degree-at-most-zero loci.  There are no degree-zero
number fields.  Thus the two loci agree at degree one.  ∎

There is also a purely formal version of the last sentence.

### Proposition 2.2 (the LANA recurrence forces exact degree one)

For every `T : Genl.HeightTheory` and every curve `X`,

\[
 T.\mathrm{ptLE}(X,1)=T.\mathrm{ptEQ}(X,1).
\]

#### Proof

The two record laws give

\[
 \mathrm{ptLE}(X,1)
 =\mathrm{ptLE}(X,0)\cup\mathrm{ptEQ}(X,1)
 =\varnothing\cup\mathrm{ptEQ}(X,1).
\]

This proves the equality.  In particular, the degree-at-most-one field in the
earlier `OpenUnitTripodComparison` was already exact-degree-one; it was not a
weaker degree statement.  ∎

### Proposition 2.3 (log-canonical height normalization)

For any arithmetic representative of the height of `omega_P(C)`, there are
constants `A_+` and `A_-`, independent of `x`, such that

\[
 \operatorname{ht}_{\omega_P(C)}(j(x))\le h(x)+A_+,
 \qquad
 h(x)\le \operatorname{ht}_{\omega_P(C)}(j(x))+A_-.
 \tag{2.1}
\]

#### Proof

On `P^1`, the canonical sheaf is `O(-2)`, while `C` has degree three.  Hence

\[
 \omega_P(C)\cong\mathcal O_{\mathbb P^1}(1).
\]

The standard normalized Weil height is a height for `O(1)`.  Proposition
1.4(iii) states that the BD class of a height depends only on the isomorphism
class of the generic-fibre line bundle.  Therefore the two height functions
differ by a globally bounded function on `P(Qbar)`, and in particular on the
displayed rational subset.  Unpacking the BD equivalence gives (2.1).  ∎

This is a bounded-discrepancy statement, not a canonical equality of chosen
real-valued representatives.  Replacing it by exact equality without fixing
the integral model and archimedean metric would overstate the source.

### Proposition 2.4 (different and conductor normalization)

For every `x` in `U_(0,1)(Q)`,

\[
 \log\operatorname{-diff}_{P}(j(x))=0.                  \tag{2.2}
\]

For the standard integral model `P^1_Z` with the three disjoint sections
`0,1,infinity`,

\[
 \log\operatorname{-cond}_{C}(j(x))=n(x).              \tag{2.3}
\]

For any other model allowed by Remark 1.5.1, the two sides of (2.3) are
BD-equivalent uniformly in `x`.

#### Proof

By Proposition 2.1 the minimal field of definition is `Q`.  The different
ideal of `Q/Q` is the unit ideal.  Its arithmetic divisor and normalized
degree are zero, proving (2.2) directly from Definition 1.5(iii).

Write `x=m/n` in lowest terms with `0<m<n`.  The primitive pair `(m,n)`
defines a section of `P^1_Z`.  Pulling back the sections `0`, `1`, and
`infinity` gives the divisors of `m`, `n-m`, and `n`, respectively.  The
pullback of `C`, after applying the reduction required in Definition 1.5(iv),
therefore has coefficient one at precisely the rational primes dividing

\[
 m(n-m)n.
\]

Consequently its arithmetic degree is

\[
 \sum_{p\mid m(n-m)n}\log p.
\]

The reduced coordinates of `x` and `1-x` are `m/n` and `(n-m)/n` because
`gcd(m,n)=gcd(n-m,n)=1`.  Their truncated support is exactly the same set of
primes.  This proves (2.3).  Remark 1.5.1 says that changing the proper flat
model changes `log-cond` only by bounded discrepancy, proving the final
assertion.  ∎

Propositions 2.1--2.4 prove the genuine arithmetic source realization.  They
do not prove Statement I; they identify what Statement I says after restriction
to these points.

## 3. A source-faithful abstract realization

Let `T : Genl.HeightTheory`.  A **rational degree-one source realization** is
the following data, with all quantifiers global over
`U_(0,1)(Q)`:

1. a point map
   `j : U_(0,1)(Q) -> T.Pt T.tripod`;
2. `j(x) in T.ptEQ T.tripod 1` for every `x`;
3. the pulled-back `T.htCan` is BD-equivalent to `h`;
4. the pulled-back `T.logDiff` is identically zero;
5. the pulled-back `T.logCond` is BD-equivalent to `n`.

The genuine map of Proposition 2.1 is injective.  Injectivity is deliberately
not a field of this minimal transport interface because neither direction of
the theorem below uses it; adding that independently proved semantic property
would not strengthen the numerical conclusion.

Thus there are constants `A_+,A_-,B_+,B_-` such that

\[
\begin{aligned}
 H_T(x)&\le h(x)+A_+,& h(x)&\le H_T(x)+A_-,\\
 N_T(x)&\le n(x)+B_+,& n(x)&\le N_T(x)+B_-,
\end{aligned}                                                   \tag{3.1}
\]

where

\[
 H_T(x)=T.\mathrm{htCan}(j(x)),\quad
 N_T(x)=T.\mathrm{logCond}(j(x)),\quad
 T.\mathrm{logDiff}(j(x))=0.
\]

This interface is strictly closer to the source than the earlier one-sided
`OpenUnitTripodComparison`: it uses exact degree one, separates different from
conductor, and records both directions of the two BD identifications.  The
one-sided earlier interface is recovered by taking errors `A_-` and `B_+`.

Define the **degree-one restriction of Statement I** by

\[
 \operatorname{RStmtI}(T,j):\Longleftrightarrow
 \forall\epsilon>0\ \exists C_\epsilon\in\mathbb R\ \forall x,
 H_T(x)\le(1+\epsilon)
   \bigl(T.\mathrm{logDiff}(j(x))+N_T(x)\bigr)+C_\epsilon.
 \tag{3.2}
\]

### Theorem 3.1 (exact transport boundary)

For every `T` equipped with a rational degree-one source realization,

\[
 \operatorname{RStmtI}(T,j)\quad\Longleftrightarrow\quad
 \mathrm{ABCConjecture}.                                      \tag{3.3}
\]

#### Proof

Assume first `RStmtI`.  Fix `epsilon>0` and choose `C_epsilon` from (3.2).
By (3.1), (3.2), and `logDiff=0`,

\[
\begin{aligned}
 h(x)
 &\le H_T(x)+A_-\\
 &\le (1+\epsilon)N_T(x)+C_\epsilon+A_-\\
 &\le (1+\epsilon)n(x)
      +C_\epsilon+A_-+(1+\epsilon)B_+.
\end{aligned}
\]

The final additive term is independent of `x`.  This is the uniform rational
tripod formulation already proved equivalent in the repository to integer abc.
Hence `ABCConjecture` follows.

Conversely assume `ABCConjecture`.  Its uniform rational-tripod formulation
gives, for each `epsilon>0`, a constant `C_epsilon` such that

\[
 h(x)\le(1+\epsilon)n(x)+C_\epsilon.
\]

Using the other two directions in (3.1),

\[
\begin{aligned}
 H_T(x)
 &\le h(x)+A_+\\
 &\le(1+\epsilon)n(x)+C_\epsilon+A_+\\
 &\le(1+\epsilon)N_T(x)
       +C_\epsilon+A_++(1+\epsilon)B_-.
\end{aligned}
\]

Again the final term is uniform in `x`, and `logDiff=0`, so this is (3.2).
This proves (3.3).  ∎

### Corollary 3.2 (full Statement I transports to integer abc)

If `T.StatementI` and `T` has a rational degree-one source realization, then
`ABCConjecture`.

#### Proof

Proposition 2.2 turns exact-degree-one membership into degree-at-most-one
membership.  Apply `T.StatementI` with the tripod, `d=1`, and the given
positive `epsilon`, then restrict its discrepancy bound along `j`.  This gives
`RStmtI(T,j)`.  The forward implication of Theorem 3.1 finishes the proof. ∎

The corollary closes the *semantic transport* from an intended arithmetic
`T.StatementI` to this repository's integer formulation.  It does not provide
`T.StatementI` or an intended arithmetic Lean instance `T`.

## 4. Full-premise pressure tests

Each test below rejects only the exact weakened implication displayed.  None
is a counterexample to the genuine arithmetic computations in Section 2, IUT,
or abc.

### 4.1 Degree membership is not automatic

The already formalized `degreeEmptyHeightTheory` has an inhabited point type,
all degree loci empty, and all numerical functions zero.  It satisfies every
field of `HeightTheory` and satisfies `StatementI` vacuously.  No image of the
nonempty rational chart lies in `ptEQ 1=ptLE 1=empty`.  Thus the complete claim

\[
 \forall T,\quad T.\mathrm{StatementI}\Longrightarrow
 \text{degree-one rational realization for }T
\]

is false for the current abstract record.  The repaired route supplies degree
membership from the actual minimal field `Q`, as in Proposition 2.1.

This countermodel survives the addition of the entire abstract
`T.ProofPackage`.  For its `covering` field, take the unique curve and map;
both source and target degree loci are empty, so surjectivity and all BD
comparisons are vacuous.  For its `belyi` field, the required input includes
the negation of a BD inequality on an empty exact-degree locus, but that
inequality always holds vacuously.  Elimination of this contradictory input
supplies the field.  Hence even

\[
 T.\mathrm{StatementI}\ \wedge\
 \operatorname{Nonempty}(T.\mathrm{ProofPackage})
\]

does not force a degree-one rational realization in the present abstract API.

### 4.2 The lower height comparison needed in the forward direction

The formalized `heightZeroShadow` keeps the actual rational points, exact
degree-one loci, zero different, and exact conductor count, but sets `htCan=0`.
It satisfies Statement I.  The rational height is unbounded, so there is no
constant `A_-` with

\[
 h(x)\le H_T(x)+A_-.
\]

This is a full-premise countermodel to deriving the forward height comparison
from all the retained fields.  It does not refute Proposition 2.3, whose input
is the actual line bundle `omega_P(C)`.

It too admits the full abstract `ProofPackage`.  Use the identity covering.
Its different comparison is `0<=0+n(x)`, its height comparison is `0<=0`, and
the negated Belyi premise is impossible because `0` is BD-dominated by `0` on
every exact-degree locus.  Thus adding `ProofPackage` does not repair the
missing height semantics.

### 4.3 The upper conductor comparison needed in the forward direction

On the actual rational point set and exact degree loci, put

\[
 H_T=h,\qquad \log\operatorname{-diff}_T=0,\qquad
 N_T=n+\exp(2h).
\]

Since `h>=0` and `exp(2h)>=1+2h>=h`, this shadow satisfies Statement I with
constant zero for every positive `epsilon`.  It retains exact height and exact
zero different.  If a uniform `B_+` satisfied `N_T<=n+B_+`, then
`exp(2h)<=B_+` everywhere, contradicting unboundedness of `h`.  Hence the bare
record does not force the conductor comparison.

The complete premise set refuted here is exactly `HeightTheory`, `StatementI`,
the displayed actual point and exact-degree data, exact height, and zero
different.  No `ProofPackage` instance is asserted for this conductor-inflated
model.  Thus this test must not be combined with the stronger `ProofPackage`
claims in Sections 4.1, 4.2, and 4.4.

### 4.4 Exact zero different is source semantics, not a hidden record law

Replace the preceding source different by the constant function one while
keeping actual points, degree, height, and conductor.  This is again a valid
`HeightTheory`; its `logDiff` is not zero.  Thus exact zero does not follow from
the record fields.  This does not obstruct transport, because a bounded
different can be absorbed into `C_epsilon`.  Exact zero is retained in the
source-faithful interface because Definition 1.5(iii) proves it for points with
minimal field `Q`, not because it is logically necessary in its strongest form.

The stronger already formalized choice
`logDiff=exp(2h)`, `logCond=n`, `htCan=h` also admits a full abstract
`ProofPackage`: the identity covering satisfies its comparisons, while
`h<=(1+epsilon)exp(2h)` makes the negated Belyi premise impossible.  Therefore
even `ProofPackage` does not force the rational different to be the different
ideal of the actual minimal field.

These `ProofPackage` instances satisfy every formal field, but their curves
and maps are audit models rather than geometric coverings or Belyi maps.  They
therefore refute automatic semantic extraction from the abstract record, not
the cited arithmetic-geometric theorems.

### 4.5 Both reverse BD directions are needed for the equivalence

The necessity can be tested without assuming or denying abc.  On `N`, let
`UB(H,R)` denote

\[
 \forall\epsilon>0\ \exists C_\epsilon\ \forall k,
 H(k)\le(1+\epsilon)R(k)+C_\epsilon.
\]

* Take target `(H,R)=(0,0)` and source `(H_T,N_T)=(k,0)`.  The target bound
  holds and the radical comparison is exact, but the source bound fails.  This
  refutes reverse transport when `H_T<=H+O(1)` is omitted.
* Take target `(H,R)=(k,k)` and source `(H_T,N_T)=(k,0)`.  The target bound
  and height equality hold, but the source bound fails.  This refutes reverse
  transport when `R<=N_T+O(1)` is omitted.

Together with the two forward countermodels already formalized in the earlier
bridge module, these are full-premise countermodels for each missing
orientation of the abstract two-sided transport theorem.  They justify the BD
equivalences in (3.1) when claiming the biconditional (3.3).

## 5. What is and is not now closed

The following mathematical work is complete.

* The rational point object is explicitly `[x:1]` on the genuine open tripod.
* Its minimal field is `Q`, so its degree is exactly one.
* `omega_P(C)` is `O(1)`, giving the required two-sided height BD comparison.
* The log-different is exactly zero for these points.
* The standard-model conductor is exactly the truncated tripod count; every
  allowed model has the same BD class.
* A source realization makes restricted Statement I exactly equivalent to
  integer abc, with all constants and quantifiers explicit.

The following source inputs remain absent from Lean.

1. A concrete arithmetic `Genl.HeightTheory` whose `Curve`, `Pt`, degree loci,
   and functions are the objects of Definitions 1.2 and 1.5.
2. A proof that the fields of that concrete instance satisfy the source
   realization just proved mathematically.  Current Mathlib/genl does not yet
   contain the needed integral model, arithmetic line bundle height, minimal
   field, different, and pullback-conductor implementation in one instance.
3. A concrete `T.ProofPackage` and the IUT-side hypotheses needed to prove
   `T.StatementI`.  The pinned IUT repository has no such connection; the
   detached current connection is conditional and does not discharge it.
4. The disputed same-pilot/Corollary 3.12 input remains upstream of this
   transport theorem.

Thus this checkpoint advances the active IUT route by closing the elementary
source semantics of its rational degree-one target.  It does not use an abc or
IUT conclusion as an axiom, and it does not retire the route because the
remaining upstream work is difficult.

## 6. Formalization plan and trust boundary

The companion module
`Lean/IUTThreeClosures/IUTRationalDegreeOneSourceRealization20260901.lean`
formalizes only results whose mathematical proofs appear above:

* `ptLE 1 = ptEQ 1` for every abstract height theory;
* the source-realization record and its extraction to the earlier one-sided
  comparison;
* the exact equivalence between restricted Statement I and integer abc;
* the implication from full `T.StatementI`;
* an unconditional realization by the already constructed rational shadow;
* the new conductor-inflated full-premise model and the two reverse sequence
  countermodels;
* explicit `ProofPackage` instances for the degree-empty, height-zero, and
  different-inflated pressure models.

It does not postulate the missing concrete arithmetic `HeightTheory`, an IUT
comparison, `StatementI`, or abc.  It uses no `sorry`, `admit`, custom axiom, or
`native_decide`.
