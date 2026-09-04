# An infinite prime-square obstruction to ordered prime transport

**Author:** ChatGPT

**Date:** 2026-09-03

**Status:** the exact endpoint gate `UniformEndpointPrimeFlowBound` (EPF) and
the exact three-arm gate `UniformThreeArmComplementTransportBound` (CT-3C)
are both rigorously refuted.  The standard \(abc\) conjecture is neither
proved nor refuted.

## 1. Scope

This note independently audits the ordered transports introduced in
`ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md` and
`ABC_THREE_ARM_INCIDENCE_SUCCESSOR_2026_09_03.md`.  Both transports permit a
source at a prime \(r\) to use a sink at a prime \(q\) only when \(r\le q\).
That order condition creates a complete-premise infinite obstruction which
was not visible in the earlier bounded searches.

No finite computation is used in the proof.  The counterexample is the
family
\[
 P_p=(1,p^2-1,p^2)
\]
over arbitrarily large odd primes \(p\).

## 2. Arithmetic of the family

**Lemma 2.1.**  For every prime \(p\), \(P_p\) is a positive primitive
\(abc\) point.

**Proof.**  Positivity follows from \(p\ge2\), and
\[
 1+(p^2-1)=p^2.
\]
The unit is coprime to both other coordinates.  Moreover
\(\gcd(p^2-1,p^2)=1\), since any common divisor divides their difference
one.  Thus the three coordinates are pairwise coprime. \(\square\)

**Lemma 2.2.**  If \(p\) is an odd prime and \(q\) is a prime divisor of
\(p^2-1\), then \(q<p\).

**Proof.**  The factorization
\[
 p^2-1=(p-1)(p+1)
\]
and primality of \(q\) imply \(q\mid p-1\) or \(q\mid p+1\).  The first case
gives \(q\le p-1<p\).  In the second case, suppose \(q\ge p\).  Since
\(q\le p+1\), either \(q=p\) or \(q=p+1\).  The equality \(q=p\) is
impossible because \(p\nmid p+1\).  The equality \(q=p+1\) is also
impossible: \(p+1\) is even and greater than two, so it is not prime.
Therefore \(q<p\). \(\square\)

**Lemma 2.3.**  The conductor of \(P_p\) satisfies
\[
 \operatorname{cond}(P_p)\le 3\log p.
\]

**Proof.**  Pairwise coprimality and
\(\operatorname{rad}(p^2)=p\) give
\[
 \operatorname{rad}\bigl(1\cdot(p^2-1)\cdot p^2\bigr)
 =p\operatorname{rad}(p^2-1)
 \le p(p^2-1)\le p^3.
\]
Taking logarithms proves the claim. \(\square\)

## 3. Exact upper-tail formula

Let \(F\) be a three-arm face.  Write \(e_r\) for the valuation attached to
an arm-labelled prime vertex \(r\).  For an integer threshold \(m\), define
\[
 \begin{aligned}
 M_{>m}(F)&=\prod_{\substack{r\in F\\r>m}}r^{e_r},\\
 R_{>m}(P)&=\prod_{\substack{r\mid abc\\r>m}}r.
 \end{aligned}
\]
The products are arm-labelled; primitivity ensures that their underlying
rational primes are distinct across arms.  Let \(D_{>m}(F)\) be the selected
defect product and \(\overline R_{>m}(F)\) the unselected radical product.
Then
\[
 M_{>m}(F)=R^{\rm sel}_{>m}(F)D_{>m}(F),\qquad
 R_{>m}(P)=R^{\rm sel}_{>m}(F)\overline R_{>m}(F).
\]
Consequently the source-minus-sink upper-tail deficit has the exact two
equivalent forms
\[
 \begin{aligned}
 S_{>m}(F)-Q_{>m}(F)
 &=\log D_{>m}(F)-\log\overline R_{>m}(F)\\
 &=\log M_{>m}(F)-\log R_{>m}(P).
 \end{aligned}
\]
This is the requested selected-full-modulus-tail versus total-radical-tail
expression.  There is no asymptotic estimate in this identity.

For finite sources and sinks with admissible edges \(r\le q\), the standard
nested-neighbourhood Hall argument gives
\[
 U_{\min}(F)=
 \max_{m\ge0}\bigl(S_{>m}(F)-Q_{>m}(F)\bigr)_+
 =\max_{m\ge0}
 \left(\log\frac{M_{>m}(F)}{R_{>m}(P)}\right)_+.
\]
The lower bound follows because sources above \(m\) can use only sinks above
\(m\).  For the converse, process all keys from largest to smallest, retain
unused sink capacity, and match the current source mass greedily.  If
\(\Delta_j\) is cumulative source capacity minus cumulative sink capacity
after the first \(j\) key groups and \(U_j\) is cumulative unmatched mass,
then
\[
 U_j=\max(U_{j-1},\Delta_j).
\]
Induction proves that the final greedy value is the largest positive
upper-tail deficit.  This is a finite exact theorem, not evidence from a
finite search.

For \(P_p\), the decisive threshold is \(m=p-1\).  Whenever the endpoint
vertex is selected,
\[
 M_{>p-1}=p^2,\qquad R_{>p-1}=p,
\]
so the exact tail deficit is \(\log p\).

## 4. Refutation of endpoint prime flow

The endpoint construction has one excess token for every valuation layer of
\(c\) beyond its first radical copy, and uses the distinct primes of \(ab\)
as sinks.  For \(P_p\), the endpoint is \(c=p^2\).  It therefore has exactly
one excess token at key \(p\), of mass \(\log p\).

All external sinks are prime divisors of \(p^2-1\).  Lemma 2.2 says that
every one of their keys is less than \(p\).  The admissibility rule
\(p\le q\) therefore forbids every edge from the endpoint token.  Thus every
actual endpoint flow \(f\) satisfies
\[
 U(f)\ge\log p.
\]

**Theorem 4.1.**  `UniformEndpointPrimeFlowBound` is false.

**Proof.**  Assume the gate at \(\varepsilon=1/4\), and let \(C\) be its
uniform constant.  Choose an odd prime \(p\) with \(\log p>4C\).  Such primes
exist because the primes are unbounded.  The gate supplies an endpoint flow
on \(P_p\), but the preceding lower bound and Lemma 2.3 give
\[
 \log p\le U(f)
 \le\frac14\operatorname{cond}(P_p)+C
 \le\frac34\log p+C.
\]
Hence \(\frac14\log p\le C\), contradicting \(\log p>4C\).
\(\square\)

Every premise is present: \(P_p\) is positive and primitive, an endpoint
flow is an actual nonnegative capacitated matrix with the stated order rule,
and the lower bound holds for every such matrix.  EPF is therefore retired in
its exact quantified form.

## 5. Refutation of three-arm complement transport

Consider any three-arm face \(F\) on \(P_p\).  If \(F\) omits the unique
prime \(p\) on the \(c\)-arm, its selected modulus divides
\(1\cdot(p^2-1)\), and hence
\[
 M(F)\le p^2-1<p^2=c.
\]
It cannot cover the endpoint.  Every covering face must therefore select
the \(c\)-arm vertex \(p\).  Its valuation is two, so this selection creates
one source of mass \(\log p\) at key \(p\).

Any complementary prime is either on the unit arm, where no prime exists, on
the \(b\)-arm, where Lemma 2.2 makes it smaller than \(p\), or on the
\(c\)-arm.  The last possibility cannot occur because the only \(c\)-prime
\(p\) is selected.  Hence every complementary sink has key less than \(p\),
and every complement transport on every covering face satisfies
\[
 U(f)\ge\log p.
\]

**Theorem 5.1.**  `UniformThreeArmComplementTransportBound` is false.

**Proof.**  Repeat the proof of Theorem 4.1.  At
\(\varepsilon=1/4\), the putative gate must supply a covering face and a
transport for every \(P_p\).  The universal lower bound and conductor bound
again yield
\[
 \log p\le\frac34\log p+C,
\]
contradicting an odd prime with \(\log p>4C\). \(\square\)

This counterexample quantifies over every face and every legal transport.  It
therefore retires CT-3C itself, not merely one choice rule or one optimizer.

## 6. Logical strength relative to \(abc\)

Both old implication theorems remain correct:
\[
 \mathrm{EPF}\Longrightarrow abc,
 \qquad
 \mathrm{CT\text{-}3C}\Longrightarrow abc.
\]
The new result shows that neither ordered gate is a synonymous reformulation
of \(abc\).  Each adds a prime-order condition that is incompatible with the
unconditional family \(P_p\).  It is therefore unsafe to describe either
gate as a surviving strengthening.

One must phrase the possible reverse implication carefully.  Since the
ordered gates are false, a theorem \(abc\Rightarrow\mathrm{EPF}\), or
\(abc\Rightarrow\mathrm{CT\text{-}3C}\), would combine with the present
counterexample to prove \(\neg abc\).  The repository has no such disproof.
Thus the standard \(abc\) inequality cannot presently be claimed to imply
either ordered gate.  If \(abc\) is true, both reverse implications are
false; if \(abc\) is false, they are vacuously true as material implications.

There is, however, an exact diagnostic equivalence after deleting the order
constraint.  In the unrestricted endpoint transport, all source mass may use
all external radical capacity.  A finite greedy transport leaves exactly
\[
 \left(\log\operatorname{core}(c)-
       \log\operatorname{rad}(ab)\right)_+
 =\bigl(h(P)-\operatorname{cond}(P)\bigr)_+
\]
unmatched.  Therefore the uniform unrestricted-flow bound is equivalent to
the logarithmic \(abc\) conjecture: the forward direction is the usual
height accounting, and the reverse direction applies \(abc\) to the displayed
identity, enlarging the additive constant to be nonnegative.  This isolates
the failed extra content precisely: it is the monotone prime order, not the
scalar radical accounting.

## 7. Positive statements that survive

The following unconditional statements remain useful and can be formalized
without asserting a new global gate.

1. **Exact Hall/min-cut theorem.**  For any fixed face, the optimized ordered
   unmatched mass is the maximum positive upper-tail deficit displayed in
   Section 3.

2. **Zero-flow criterion.**  A fixed face admits a zero-unmatched ordered
   transport if and only if
   \[
     M_{>m}(F)\le R_{>m}(P)
   \]
   for every integer threshold \(m\).  This is simply the exact Hall theorem
   written multiplicatively.

3. **Initial-segment lemma.**  Suppose the selected primes form an initial
   segment of the ordered global prime support: every selected prime is
   smaller than every unselected prime.  Then every proper upper tail has no
   larger deficit than the total tail, and
   \[
     U_{\min}(F)=
     \left(\log M(F)-\log\operatorname{rad}(abc)\right)_+.
   \]
   Thus an initial-segment covering face whose multiplicative overshoot is
   uniformly \(\varepsilon\)-small would imply \(abc\).  The prime-square
   family explains why such overshoot control is a real new obligation: the
   last vertex may be \(p^2\).

4. **Unrestricted transport equivalence.**  The order-free endpoint gate is
   exactly equivalent to \(abc\), as proved above.  It is a clean normal form
   for the scalar obstruction, though it does not by itself advance the
   conjecture.

The next incidence successor must permit the mass at a large repeated prime
to interact with smaller complementary primes.  Plausible structures include
an unordered transport equipped with an independent arithmetic
correspondence, a bidirectional signed transport, a multi-face averaged
complex, or a homological boundary in which opposite orientations cancel.
No such global bound is asserted here.  Any candidate must first pass the
prime-square family and must still imply the unchanged standard
`ABCConjecture` without using it as a premise.

## 8. Lean trust boundary

The companion module is
`Lean/IUTThreeClosures/ABCThreeArmComplementTransportObstruction20260903.lean`.
It formalizes both complete-premise counterexamples, including the unbounded
prime choice.  Its one-to-one audit is
`Lean/IUTThreeClosures/ABCThreeArmComplementTransportObstruction20260903AxiomAudit.lean`.

The formal countertheorems are:

- `not_uniformEndpointPrimeFlowBound`;
- `not_uniformThreeArmComplementTransportBound`.

There are \(37\) public declarations and exactly \(37\) corresponding
`#print axioms` queries.  The main module and audit both compile with warnings
treated as errors.  Across all declarations the reported foundational-axiom
union is exactly `propext`, `Classical.choice`, and `Quot.sound`.  There is no
`sorry`, `admit`, custom axiom, `unsafe` declaration, or `native_decide`.

The module does not assume or prove `ABCConjecture`, and it does not infer any
asymptotic statement from a bounded search.
