# Radical-excess obstruction for synchronized divisor packets

**Author:** ChatGPT  
**Date:** 2026-09-03  
**Status:** exact structural identities and an infinite obstruction are Lean-closed; the standard $abc$ conjecture remains open  
**Scope:** primitive positive triples $a+b=c$, $\gcd(a,b)=1$, $a,b>1$, with the synchronized packets of `ABC_SYNCHRONIZED_DIVISOR_PACKET_SPECTRUM_2026_09_03.md`

## 1. Result and correction of the route boundary

Write

\[
 R=\operatorname{rad}(abc),\qquad
 E=\frac{abc}{R},
\]

and let $B(Q)$ be the pair-max envelope of a synchronized packet $Q$.  The
previous packet report proposed the following sufficient gate:

\[
 \text{for every }\varepsilon>0,\quad
 B(Q)\le R^{1+\varepsilon}
 \quad\text{for some packet }Q
\tag{1.1}
\]

for all but finitely many primitive triples.  This note proves that (1.1) is
false.  At $\varepsilon=1/3$, infinitely many complete-premise triples have

\[
 B(Q)^3>R^4
\tag{1.2}
\]

for every packet $Q$ in their spectrum.

This is a counterexample to the exact packet gate, not to $abc$.  The reason
is already visible in the unconditional inequality $abc\le B(Q)$: (1.1)
tries to bound the full product $abc$ at radical scale, whereas $abc$ only
asks to bound the sum arm $c$ at that scale.

The packet structure remains useful and is not abandoned.  Section 6 isolates
the correctly compensated sufficient estimate.  That replacement is open;
its pointwise version has finite counterexamples, but no all-but-finitely-many
counterexample is proved here.

## 2. Exact order-statistic geometry of $B(Q)$

Let $Q=(x,y,z)$, and put

\[
 m(Q)=\min(x,y,z),\qquad T(Q)=\max(x,y,z),
\]

\[
 L(Q)=\max(y,z)\max(x,z)\max(x,y).
\]

By definition $B(Q)=L(Q)^2$.

### Theorem 2.1 (symmetric shape identity)

Every triple of nonnegative integers, and hence every synchronized packet,
satisfies

\[
 m(Q)L(Q)=xyzT(Q)
\tag{2.1}
\]

and therefore

\[
 m(Q)^2B(Q)=\bigl(xyzT(Q)\bigr)^2.
\tag{2.2}
\]

**Proof.**  Sort the three coordinates as $r\le s\le t$, allowing equalities.
The three pair maxima are $s,t,t$.  Thus $m=r$, $T=t$,
$L=st^2$, and

\[
 mL=rst^2=(rst)t=xyzT.
\]

Squaring proves (2.2).  The formula is symmetric, so it is independent of the
chosen sorting permutation.  \(\square\)

This gives an exact shape decomposition rather than the coarse inequality
$B\le T^6$.  In particular, the minimum coordinate records precisely the
loss between the coordinate product and the pair-max root.

### Proposition 2.2 (full packet is an envelope maximum)

For every synchronized packet $Q$,

\[
 B(Q)\le B(a,b,c).
\tag{2.3}
\]

**Proof.**  The divisor and positivity assumptions give
$x\le a, y\le b, z\le c$.  Hence each pair maximum for $Q$ is no larger
than the corresponding pair maximum for $(a,b,c)$.  Square and multiply the
three inequalities.  \(\square\)

The finite audit found no proper packet attaining equality in (2.3) through
$c\le3000$.  This null result is not a proof, so strictness for proper packets
is retained as an open strengthening.

## 3. Coordinate support and radical excess

### Proposition 3.1 (support containment)

For every synchronized packet,

\[
 xyz\mid abc,
 \qquad
 \operatorname{rad}(xyz)\mid R.
\tag{3.1}
\]

**Proof.**  Multiply $x\mid a, y\mid b, z\mid c$.  Radical divisibility is
monotone under divisibility for nonzero natural numbers.  \(\square\)

The equality strengthening is false.  The complete-premise packet

\[
 (a,b,c)=(5,7,12),\qquad Q=(5,7,2)
\]

has $\operatorname{rad}(xyz)=70$ and $R=210$.

Since $R\mid abc$, the radical excess

\[
 E=\frac{abc}{R}\in\mathbf Z_{>0}
\tag{3.2}
\]

satisfies the exact factorization

\[
 RE=abc.
\tag{3.3}
\]

## 4. A packet-independent necessary condition

### Theorem 4.1 (rational compression forces radical-excess control)

Let $m,n\ge0$.  If a synchronized packet satisfies

\[
 B(Q)^m\le R^{m+n},
\tag{4.1}
\]

then

\[
 E^m\le R^n.
\tag{4.2}
\]

Equivalently,

\[
 R^n<E^m
 \quad\Longrightarrow\quad
 R^{m+n}<B(Q)^m
\tag{4.3}
\]

for every synchronized packet $Q$.

**Proof.**  The synchronized product theorem gives $abc\le B(Q)$.  Raise to
the $m$-th power and use (3.3):

\[
 R^mE^m=(abc)^m\le B(Q)^m\le R^{m+n}=R^mR^n.
\]

Since $R>0$, cancel $R^m$.  This proves (4.2); (4.3) is its
contrapositive.  \(\square\)

This theorem separates two tasks that had been conflated in the former gate.
No choice of a clever packet can overcome a failure of (4.2), because the
obstruction depends only on the underlying triple.

## 5. Infinite complete-premise obstruction at exponent $4/3$

For every $k\ge0$, set

\[
 A_k=2^{k+4},\qquad
 P_k=(A_k,3,A_k+3).
\tag{5.1}
\]

These are positive primitive nonunit triples: $A_k+3=c_k$ and
$\gcd(A_k,3)=1$.  Distinct $k$ give distinct first arms.

### Theorem 5.1 (dyadic radical-excess obstruction)

For every $k\ge0$, if $R_k=\operatorname{rad}(A_k\cdot3\cdot(A_k+3))$
and $E_k=3A_k(A_k+3)/R_k$, then

\[
 R_k<E_k^3.
\tag{5.2}
\]

Consequently every synchronized packet over $P_k$ satisfies

\[
 R_k^4<B(Q)^3.
\tag{5.3}
\]

The locus of primitive triples satisfying (5.3) for every packet is infinite.

**Proof.**  Put $h=2^{k+3}$, so $A_k=2h$ and $h\ge8$.  Submultiplicativity
of the radical, $\operatorname{rad}(2^{k+4})=2$, and
$\operatorname{rad}(A_k+3)\le A_k+3$ give

\[
 R_k\le 2\cdot3\cdot(A_k+3)=6(2h+3).
\tag{5.4}
\]

From $R_kE_k=6h(A_k+3)$ and (5.4), cancellation of the positive $R_k$
gives

\[
 h\le E_k.
\tag{5.5}
\]

For $h\ge8$,

\[
 6(2h+3)=12h+18<64h\le h^3\le E_k^3.
\]

Together with (5.4), this proves (5.2).  Apply Theorem 4.1 with
$(m,n)=(3,1)$ to obtain (5.3).  The map $k\mapsto P_k$ is injective, so
its range is an infinite subset of the obstruction locus.  \(\square\)

For positive real numbers, $B\le R^{4/3}$ implies $B^3\le R^4$.  Hence
Theorem 5.1 rigorously refutes the all-but-finitely-many gate (1.1) at the
single value $\varepsilon=1/3$.  Only this exact gate is retired.  The theorem
neither supplies nor contradicts an infinite family with
$c>R^{1+\varepsilon}$.

## 6. Forward replacement: a compensated packet gate

The factor $ab$ is exactly what must be removed from the overly strong
product bound.

### Theorem 6.1 (compensated compression implies the target $c$-bound)

For $m,n\ge0$, if a synchronized packet satisfies

\[
 B(Q)^m\le (ab)^mR^{m+n},
\tag{6.1}
\]

then

\[
 c^m\le R^{m+n}.
\tag{6.2}
\]

**Proof.**  From $abc\le B(Q)$,

\[
 (ab)^mc^m=(abc)^m\le B(Q)^m
 \le (ab)^mR^{m+n}.
\]

Cancel the positive factor $(ab)^m$.  \(\square\)

Thus an eventual version of (6.1), for rational exponents
$1+n/m>1$, would have the correct $abc$ scale.  No eventual estimate of
this kind is proved.  Its pointwise $(m,n)=(3,1)$ form already fails at
$(2,3,5)$, and in the exhaustive range only 371 of 1,365,095 triples admit a
packet meeting it.  These finite failures do not refute an all-but-finitely
statement, so the compensated direction remains active but empirically
adverse.

Possible forward work must change or refine the packet observable rather than
reassert (1.1).  Candidates include a signed orientation cost, a quotient of
the gap product before taking pair maxima, or a local prime-power allocation
term that can pay for the $ab$ compensator.  None is assumed here.

## 7. Exact exhaustive search

The independent script

`research/computation/2026_09_03_packet_radical_excess_obstruction/search_packet_radical_excess.py`

was run as

```powershell
python research/computation/2026_09_03_packet_radical_excess_obstruction/search_packet_radical_excess.py `
  --limit 3000 --dyadic-limit 20 `
  --output research/computation/2026_09_03_packet_radical_excess_obstruction/OUTPUT.json
```

It uses exact Python integers only.  It exhausts every normalized primitive
nonunit triple $2\le a\le b, a+b=c, c\le3000$, every divisor triple, and
every synchronized packet satisfying all premises.  The totals are

| item | exact count |
|---|---:|
| primitive triples | 1,365,095 |
| synchronized packets | 1,366,531 |
| proper packets | 1,436 |
| separately factored dyadic rows $0\le k\le20$ | 21 |

Every enumerated packet checks (2.1)--(2.3), (3.1), Theorem 4.1 for five
exponent pairs, Theorem 6.1 for those pairs, and the previously proved
synchronized-product bounds.  The dyadic audit enumerates the whole packet
spectrum for each tested row and checks (5.2)--(5.3).  All 21 tested spectra
happen to contain only the full packet; this finite observation is not used by
the proof of Theorem 5.1.

The largest exact ratio $\min_Q B(Q)^3/R^4$ in the finite normalized scan is
attained at $(625,2048,2673)$, which has radical $330$, one packet, and

\[
 \min_QB(Q)=214119262883848126464.
\]

The archived JSON stores the numerator and denominator as exact integers.

### Candidate ledger

| candidate | result | action |
|---|---|---|
| Eventual $B(Q)\le R^{1+\varepsilon}$ for every $\varepsilon>0$ | Infinite complete-premise counterfamily at $\varepsilon=1/3$ | **Retire this exact gate** |
| Pointwise existence of $B^3\le R^4$ or $B^2\le R^3$ | Full-premise counterexample $(2,3,5)$, whose only packet is full in the exhaustive enumeration | **Retire pointwise statements** |
| Every proper packet captures all radical support | Counterexample $(5,7,12), Q=(5,7,2)$ | **Retire equality; retain divisibility** |
| Every proper packet strictly lowers the full $B$ | No counterexample through $c\le3000$ | **Retain; unproved** |
| Every exact-gap packet minimizes $B$ | No counterexample through $c\le3000$ | **Retain; unproved** |
| If an exact-gap packet exists, some $B$-minimizer is exact | No counterexample through $c\le3000$ | **Retain; unproved** |
| Eventual compensated estimate (6.1) | Pointwise and extensive finite failures, but no infinite complete-premise refutation | **Retain; open** |

Null searches are evidence only about the stated finite domain.  They are not
used to prove any universal assertion.

## 8. Lean boundary

The independent Lean module is

`Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903.lean`.

It formalizes Theorem 2.1, Proposition 2.2, Theorems 4.1, 5.1, and 6.1, the support and exact
factorization propositions, injectivity of the dyadic family, inclusion of its
range in the obstruction locus, and infinitude of that locus.  Its companion

`Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903AxiomAudit.lean`

prints the axioms of every new declaration.  Direct compilation with
`-DwarningAsError=true` succeeds.  The axiom union is exactly
`propext`, `Classical.choice`, and `Quot.sound`.

There is no declaration of an $abc$ conclusion, no finite-search oracle, and
no assumed compression estimate.  The exact formal conclusion is an infinite
counterexample family to a packet-level sufficient gate, together with a
replacement implication whose hypothesis remains open.
