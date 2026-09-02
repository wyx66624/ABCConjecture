# An admissible-set repair for the LANA log-volume interface and an exact bridge from `StatementI` to integer abc

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** positive consistency theorem, exact fixed-point and finite-orbit no-go
theorems, and a sufficient uniform comparison bridge to the repository's integer
`ABCConjecture`; no proof or disproof of IUT or abc.

## Abstract

The public LANA snapshots `ddaddc274281adb5674d647e24fa478745ac6d40`
and `6e963070c73c5defd1012320deccc777e2555d22` impose a real-valued
log-volume translation law on every subset of a local packet.  Since every
preimage map fixes the empty set, a positive shift by `log p` makes this exact
interface inconsistent.  This note gives an explicit proof-carrying repair with
an inhabited region type, nonempty actual carriers, closure under the required
preimage, and an injective carrier representation.  Compact-open
valuation balls in `Q_p` give a concrete model, so the repair is consistent.

The same calculation yields sharp necessary conditions.  A nonzero logarithmic
shift admits no fixed or periodic admissible region; its forward orbit is
infinite.  Thus merely deleting the empty set while retaining a finite or cyclic
region universe is not a valid repair.  These are exact no-go theorems for those
interfaces, not objections to Haar log-volume or to IUT.

The second part replaces the black-box bridge proposition
`T.StatementI -> ABCConjecture` by explicit sufficient data.  Each positive
primitive integer triple must be encoded as a degree-at-most-one point of the
tripod.  The integer logarithmic height must be bounded above by the abstract
canonical height up to one uniform constant, and the abstract log-different plus
log-conductor must be bounded above by the logarithm of the integer radical up
to one uniform constant.  `T.StatementI` then proves the repository's exact
integer `ABCConjecture`, with the output constant calculated explicitly.
A full-premise counterexample to this package cannot exist because the
implication is proved.  In the isolated sequence-transfer schema used below,
countermodels show separately that each comparison, degree membership, and
uniformity of the errors is indispensable for that bare schema.

The repaired interface in this note is a new audit interface.  It is neither
Mochizuki's original IUT formalism nor a completed instance of LANA's
`LocalTheory`.

## 1. Public-source audit at the start of the repair

The source boundary matters because the names "ABC" and "log-volume" occur at
several different levels.

1. The current public head of [`lana-agents/iut`](https://github.com/lana-agents/iut/tree/6e963070c73c5defd1012320deccc777e2555d22)
   is `6e963070c73c5defd1012320deccc777e2555d22`.  Its README says both that
   the repository does not verify IUT and that the Corollary 3.12 strand is a
   project-owner-specified variant which must not silently be identified with
   Mochizuki's printed Corollary 3.12.  Its theorem
   `Iut.cor312Variant_implies_abc_concrete` is conditional on a height-theory
   proof package, concrete theta-data existence, analytic prime bounds, and the
   Corollary 3.12 variant for every concrete bundle.
2. In that snapshot, [`Iut/Abc/Target.lean`](https://github.com/lana-agents/iut/blob/6e963070c73c5defd1012320deccc777e2555d22/Iut/Abc/Target.lean)
   defines `Iut.ABC T` to be `T.StatementI`.  It does not construct the concrete
   height formalism or identify this proposition with the integer statement in
   the present repository.
3. The public [`LANA-Project/genl`](https://github.com/LANA-Project/genl/tree/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859)
   head remains `6e9a6543b46a2a02fd7fe7ec8ab203d878f32859`.
   It proves the general-position implication relative to an abstract
   `Genl.HeightTheory` and a `ProofPackage`; its README explicitly leaves
   instantiation of those interfaces to later work.  The definition used here is
   [`Genl/GeneralPosition/HeightTheory.lean`](https://github.com/LANA-Project/genl/blob/6e9a6543b46a2a02fd7fe7ec8ab203d878f32859/Genl/GeneralPosition/HeightTheory.lean).
4. The latest public [`lana-agents/padic-log-volume`](https://github.com/lana-agents/padic-log-volume/tree/850e89cffde3ae20cd725806cd0188b94c058640)
   head is `850e89cffde3ae20cd725806cd0188b94c058640`.  Its README lists
   normalized additive Haar log-volume as a goal, but its only source module,
   [`PadicLogVolume/Basic.lean`](https://github.com/lana-agents/padic-log-volume/blob/850e89cffde3ae20cd725806cd0188b94c058640/PadicLogVolume/Basic.lean),
   is explicitly a six-line placeholder.  Therefore the delegation mentioned by
   `LocalTheory` is not presently a public construction of that structure.
5. The July 2026 [Project LANA interim report](https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex)
   isolates the unresolved comparison as a same-pilot/identity problem and
   records no final judgment on IUT.  Its main eta-map goal is not implemented in
   the public `iut` snapshot.
6. The original mathematical references used to locate the intended statements
   are Mochizuki's [*Inter-universal Teichmuller Theory III*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
   especially Remark 3.9.5 and Corollary 3.12, and
   [*Arithmetic Elliptic Curves in General Position*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf),
   especially Theorem 2.1.  The author's [paper index](https://www.kurims.kyoto-u.ac.jp/~motizuki/papers-english.html)
   identifies the public May 2020 version of IUT III and the February 2009
   general-position paper.

This source audit has two consequences.  First, the repaired structure below
must be labelled as a new interface rather than an amendment already accepted
upstream.  Second, a theorem from `T.StatementI` to integer abc must exhibit the
missing concrete comparison data instead of hiding it in a one-field implication.

## 2. The exact defect retained by the latest concrete snapshot

At `6e963070`, the field

```lean
componentVol_prime_preimage : forall p c U,
  componentVol ((fun x => p * x) \u207b\u00b9' U)
    = componentVol U + Real.log p
```

is quantified over every set `U`.  The codomain is the ordinary real numbers.
For `U = empty`, preimage fixes `U`, so the equation gives

\[
 V(\varnothing)=V(\varnothing)+\log p.
\]

Every rational prime satisfies `p > 1`, hence `log p > 0`, a contradiction.
The companion current-snapshot audit proves this directly for `LocalTheory K`.

The defect is not that normalized Haar measure has the wrong scaling law.  If
`mu` is normalized additive Haar measure on `Q_p`, then

\[
 \mu(p^{-1}U)=p\,\mu(U)
 \quad\Longrightarrow\quad
 \log\mu(p^{-1}U)=\log\mu(U)+\log p
\]

whenever both measures are finite and strictly positive.  The defect is the
extension of a finite real logarithm to zero-volume and infinite-volume sets
while retaining the same equality without a domain hypothesis.

## 3. An extensional admissible-region interface

Fix a type `X`, a scaling map `s : X -> X`, and a real shift `delta`.  An
**extensional admissible preimage log-volume** consists of:

1. a nonempty type `R` of regions;
2. a carrier map `C : R -> Set X` which is injective;
3. a proof that every `C(U)` is nonempty;
4. an operation `P : R -> R` satisfying
   `C(P(U)) = s^{-1}(C(U))`;
5. a function `V : R -> Real` satisfying
   `V(P(U)) = V(U) + delta`.

The nonemptiness of `R` prevents a completely vacuous interface with no
admissible regions.  The carrier injection prevents a fake repair in which the same underlying set
is assigned several region labels with different volumes.  Nonemptiness removes
the empty set.  The typed operation `P` supplies the missing closure proof:
preimage is not merely claimed to preserve an informal class; it returns an
element of that class.

Measurability and finite positive measure are required in an analytic
implementation, but they are not needed for the logical repair itself.  They
can be added as fields or derived by defining `R` to be the subtype of sets with
those properties.  The five kinds of data above, including the inhabitance
witness in item 1, form a sufficient elementary layer at which the empty-set
contradiction is removed without sacrificing set extensionality or the requested
inverse-image equation.  No universal minimality claim about all possible
repairs is intended.

### Theorem 3.1 (a genuine `Q_p`-ball model)

For every rational prime `p`, the repaired interface with

\[
 X=\mathbb Q_p,\qquad s(x)=px,\qquad \delta=\log p
\]

is inhabited.

#### Proof

For `k in Z`, let

\[
 B_k=\{x\in\mathbb Q_p:\lVert x\rVert_p\le p^{-k}\}.
\]

Use the integers as the region type, with `C(k)=B_k`,
`P(k)=k-1`, and

\[
 V(k)=-k\log p.
\]

Every `B_k` is nonempty because it contains zero.  Since
`|p|_p=p^{-1}`,

\[
 px\in B_k
 \iff p^{-1}\lVert x\rVert_p\le p^{-k}
 \iff \lVert x\rVert_p\le p^{-(k-1)},
\]

so `s^{-1}(B_k)=B_{k-1}`.  The balls are extensional in the index:
`B_k subset B_m` if and only if `m <= k`; equality in both directions therefore
implies `k=m`.  Finally,

\[
 V(P(k))=-(k-1)\log p=-k\log p+\log p=V(k)+\log p.
\]

All five interface fields hold.  In particular, the repair is consistent and
retains the intended prime-preimage normalization.  \(\square\)

The Lean model below formalizes the actual subsets `B_k` of `Q_p` and the exact
function `V(k)=-k log p`.  It does not separately formalize Haar measurability,
compactness, openness, or the theorem identifying `V(k)` with the logarithm of
a chosen Haar measure; those analytic facts are outside the five-field audit
interface.

This is a model of the repaired local scaling layer.  It is not a construction
of LANA's tensor packets, least hulls, theta regions, or full `LocalTheory`.

## 4. Exact consistency conditions and no-go theorems

The empty set is one instance of a more general obstruction.

### Theorem 4.1 (fixed-point obstruction)

If `delta != 0`, then `P(U) != U` for every admissible region `U`.

#### Proof

If `P(U)=U`, applying `V` and the shift law gives

\[
 V(U)=V(P(U))=V(U)+\delta,
\]

so `delta=0`, a contradiction. \(\square\)

Thus a corrected domain must exclude every region fixed by the preimage
operation, not only the empty set.  In the `Q_p` model, the family of compact
open balls has no such fixed point.

### Theorem 4.2 (iterate formula and periodic-point obstruction)

For every natural number `n`,

\[
 V(P^n(U))=V(U)+n\delta.
\]

If `delta != 0` and `n>0`, then `P^n(U) != U`.

#### Proof

The formula follows by induction.  The case `n=0` is immediate.  If it holds
for `n`, then

\[
 V(P^{n+1}(U))=V(P(P^n(U)))
 =V(P^n(U))+\delta
 =V(U)+(n+1)\delta.
\]

If `P^n(U)=U`, cancellation gives `n delta=0`.  In the reals, `n>0` and
`delta!=0` make this impossible. \(\square\)

### Corollary 4.3 (infinite-orbit condition)

If `delta != 0`, the map `n |-> P^n(U)` from the natural numbers to the region
type is injective.  Hence the region type cannot be finite.

#### Proof

If `P^m(U)=P^n(U)`, Theorem 4.2 and application of `V` give
`m delta=n delta`.  Cancellation of the nonzero factor `delta` gives `m=n`.
An injection from the natural numbers into a finite type is impossible.
\(\square\)

These results provide a full-premise counterexample test for proposed repairs.
Before imposing item 1, the completely empty region type was a vacuous model;
that exact candidate is now excluded by the interface.  A candidate that
includes a fixed "zero region," a positive-period cycle, or only finitely many
admissible region states is refuted.  A candidate with an
infinite valuation lattice, such as Theorem 3.1, passes these tests.

## 5. The exact integer abc target

The present repository defines

\[
 \operatorname{rad}(n)=\prod_{q\mid n}q
\]

and

\[
 \begin{aligned}
 \mathrm{ABCConjecture}:\quad
 &\forall\epsilon>0\ \exists C\ \forall a,b,c\in\mathbb N_{>0},\\
 &a+b=c,\quad (a,b,c)\text{ pairwise coprime}\quad\Longrightarrow\\
 &\log\max(a,b,c)
 \le (1+\epsilon)\log\operatorname{rad}(abc)+C.
 \end{aligned}
\]

By contrast, `T.StatementI` says that for every abstract hyperbolic curve `X`,
degree bound `d`, and `epsilon>0`, there is a bounded-discrepancy constant on
`T.ptLE X d`:

\[
 h_{\mathrm{can},X}(x)
 \le (1+\epsilon)
   (\log\mathrm{Diff}_X(x)+\log\mathrm{Cond}_X(x))+C.
\]

Taking `X=T.tripod` and `d=1` is not by itself enough.  One still needs the
following concrete comparison package.

## 6. A sufficient non-tautological `StatementI` bridge

Let `P` be the type of positive pairwise-coprime integer triples satisfying
`a+b=c`.  Put

\[
 H(t)=\log\max(a,\max(b,c)),\qquad
 R(t)=\log\operatorname{rad}(abc).
\]

A **uniform tripod comparison package** for `T` consists of:

1. an encoding `iota : P -> T.Pt T.tripod`;
2. degree membership `iota(t) in T.ptLE T.tripod 1` for every `t`;
3. a single real constant `A_H` such that
   \[
   H(t)\le T.htCan(T.tripod)(iota(t))+A_H;
   \]
4. a single real constant `A_R` such that
   \[
   T.logDiff(T.tripod)(iota(t))+T.logCond(T.tripod)(iota(t))
   \le R(t)+A_R.
   \]

No sign condition on `A_H` or `A_R` is needed.  What matters is that each is
uniform over all primitive triples.

### Theorem 6.1 (exact bounded-discrepancy transfer)

For every `T : Genl.HeightTheory`, `T.StatementI` together with a uniform
tripod comparison package implies the repository's `ABCConjecture`.

#### Proof

Fix `epsilon>0`.  Apply `T.StatementI` to the tripod, its supplied
hyperbolicity proof, degree bound one, and `epsilon`.  By the definition of
bounded discrepancy, there is a real `C_epsilon` such that every encoded point
satisfies

\[
 h_T(iota(t))\le(1+\epsilon)(d_T(iota(t))+c_T(iota(t)))+C_\epsilon.
\]

The coefficient `1+epsilon` is positive.  The two uniform comparisons give

\[
\begin{aligned}
H(t)
&\le h_T(iota(t))+A_H\\
&\le(1+\epsilon)(d_T(iota(t))+c_T(iota(t)))+C_\epsilon+A_H\\
&\le(1+\epsilon)(R(t)+A_R)+C_\epsilon+A_H\\
&=(1+\epsilon)R(t)
  +\bigl(C_\epsilon+A_H+(1+\epsilon)A_R\bigr).
\end{aligned}
\]

Thus the integer abc constant may be chosen as

\[
 C=C_\epsilon+A_H+(1+\epsilon)A_R,
\]

uniformly over all triples.  This is exactly `ABCConjecture`. \(\square\)

The theorem isolates the remaining arithmetic work.  One must construct the
intended tripod point (normally represented by a rational coordinate such as
`a/c` with its marked complement), prove it has degree one, and prove the two
normalization comparisons.  None of those constructions is present in the
current `genl` abstract interface.

## 7. Counterexample search against weakened bridge candidates

Theorem 6.1 rules out a full-premise counterexample in ordinary real
arithmetic.  To test the necessity of individual premises within a bare
sequence-transfer schema, let an abstract source inequality for functions
`h,k : N -> Real` mean

\[
 \forall\epsilon>0\ \exists C\ \forall n,\quad
 h(n)\le(1+\epsilon)k(n)+C. \tag{7.1}
\]

The target has the same form for `H,R`.  The following counterexamples satisfy
all displayed premises of this sequence schema except the named missing one.
They are not claimed to instantiate a `Genl.HeightTheory` or the arithmetic
tripod.

### 7.1 Omitting the height comparison

Take

\[
 h(n)=k(n)=R(n)=0,\qquad H(n)=n.
\]

The source bound (7.1) holds with `C=0`, and the conductor comparison
`k(n)<=R(n)` is equality.  The target fails: for `epsilon=1` it would require
`n<=C` for every natural `n`.  Thus Statement I and conductor control do not
bound the integer height without a uniform height comparison.

### 7.2 Omitting the conductor/radical comparison

Take

\[
 h(n)=k(n)=H(n)=n,\qquad R(n)=0.
\]

For every positive `epsilon`, `n <= (1+epsilon)n`, so (7.1) holds with
`C=0`.  The height comparison is equality.  The target again says that every
natural number is at most one constant.  Hence the conductor/radical comparison
cannot be dropped.

### 7.3 Omitting degree-set membership

Let the epsilon-uniform source discrepancy inequality be asserted only on the
empty subset of `N`; it is then true for arbitrary functions, for every positive
`epsilon`.  Encode the target sequence
outside that set and take `h=H=n`, `k=R=0`.  Both function comparisons are
equalities, but the target is false.  Therefore the proof that every integer
triple lands in `ptLE tripod 1` is logically essential.

### 7.4 Replacing uniform errors by triple-dependent errors

Take the data of 7.1, retain the exact conductor/radical comparison, and permit
`A_H(n)=n`.  Then

\[
 H(n)\le h(n)+A_H(n)
\]

holds exactly, but it gives no uniform target constant.  Dually, take the data
of 7.2, retain the exact height comparison, and use the triple-dependent
conductor error `A_R(n)=n`.  Bounded-discrepancy transfer requires constants
independent of the encoded triple.

### 7.5 Scope of these counterexamples

These examples refute only the corresponding weakened statements in the
sequence-transfer schema (7.1).  They are not integer abc triples of unbounded
quality, not models of `Genl.HeightTheory`, not instances of LANA's theta-data,
and not counterexamples to `T.StatementI`.  No weakened projection is used to
abandon the IUT route.

## 8. Interaction with the IUT/same-pilot route

The admissible-region repair addresses one primitive inconsistency.  It does
not provide the q-pilot realization, theta-pilot output family, determinant
normalization, hull monotonicity, or pointed same-pilot identity needed for the
Corollary 3.12 comparison.  The July LANA report's eta-map equality remains a
live object-level route.

Likewise, Theorem 6.1 begins only after `T.StatementI` has been obtained.  The
latest public conditional implication still requires:

* a concrete and inhabited corrected `LocalTheory`;
* `ThetaLocalData`, `QPilotInputs`, and `ArithmeticInputs` on each required
  branch;
* the Corollary 3.12 variant for those bundles;
* `ConcreteThetaDataExistence`, `ChebyshevBound`, and `PrimeCountingBound`;
* an instantiated `Genl.HeightTheory` and `ProofPackage`;
* the uniform tripod comparison package of Section 6.

The first item cannot presently be delegated to the public
`padic-log-volume` repository because its source is still a placeholder.  The
valuation-ball construction of Theorem 3.1 is a rigorous local seed for that
work, not a substitute for the remaining fields.

## 9. Formalization boundary

The companion module
`Lean/IUTThreeClosures/IUTAdmissibleVolumeIntegerBridge20260901.lean`
formalizes, after the mathematical proofs above:

* the extensional admissible-region interface;
* exclusion of the empty carrier;
* the fixed-point, iterate, periodic-point, injection, and finite-region
  no-go theorems;
* the actual `Q_p` valuation-ball model;
* the positive primitive triple type and uniform tripod comparison package;
* Theorem 6.1 with its explicit output constant;
* the full-premise sequence-schema counterexamples of Sections 7.1--7.4.

It imports the existing valuation-ball mathematics and `Genl.HeightTheory`.
It does not import the detached latest `LocalTheory`, postulate any upstream
field, or alter the repository pin.  Whether it is imported by the aggregate
root is a separate repository-integration choice.

## 10. Route disposition

| Exact route or statement | Result |
|---|---|
| Total real-valued prime-preimage law on all sets | **Closed:** empty-set contradiction. |
| Extensional nonempty preimage-closed region interface | **Active and consistent:** inhabited by `Q_p` valuation balls. |
| Repaired interface with a fixed point or positive-period orbit and nonzero shift | **Closed:** exact contradiction. |
| Repaired interface with finitely many regions and nonzero shift | **Closed:** every orbit must be infinite. |
| `T.StatementI` plus the uniform tripod comparison package | **Positive theorem:** implies the exact integer `ABCConjecture`. |
| Bare sequence-transfer schema without height control, radical control, domain membership, or uniform errors | **Each exact weakening closed by a full-premise counterexample within that schema.** |
| Construction of the comparison package for the intended arithmetic height theory | **Open.** |
| Corrected LANA `LocalTheory`, same-pilot theorem, Corollary 3.12, IUT, and integer abc | **Open; neither proved nor refuted here.** |
