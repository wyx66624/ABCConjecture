# Square-root smooth neighbours and sparse exceptional-set transfer

**Author:** ChatGPT  
**Date:** 28 August 2026  
**Status:** rigorous reduction and route audit; not a proof or disproof of the
abc conjecture.

## 1. Purpose

The smooth-neighbour route starts from a prime power

\[
  b=p^k
\]

and seeks an integer `c>b` for which

\[
  a=c-p^k
\]

is short while `rad(c)` is small.  The resulting primitive triple is
`a+b=c`, and deterministically

\[
  \operatorname{rad}(abc)
  \le a\,p\,\operatorname{rad}(c).
\]

Two recent types of analytic results are relevant but must not be conflated:

1. an **all-interval** theorem, which gives a smooth number after every centre;
2. an **almost-all** theorem, whose exceptional set may still contain every
   point of a sparse arithmetic subfamily such as the prime powers.

This note identifies the exact transfer conditions in both cases.

## 2. Current short-interval input

Jain, *Smooth Numbers in Short Intervals*, Theorem 1.2, proves that for

\[
 \exp\!\left(C(\log x)^{2/3}(\log\log x)^{4/3}\right)
 \le y\le x^{1/C},
\]

every sufficiently large interval `[x,x+h]` contains a `y`-smooth number once

\[
 h\ge \sqrt{x}\exp\!\left((1+\varepsilon)
 \left(\frac{11}{16}\widetilde u\log\widetilde u
       +2\log\log x\right)\right),
 \qquad
 \widetilde u=\frac{\log x}{\log y}.
\]

Thus the gap exponent is `1/2+o(1)`.  Younis obtains an asymptotic count in
all intervals of length `x^theta` for every fixed `theta>17/30` in a related
smoothness range.

These theorems produce smoothness.  They do **not** by themselves produce a
power saving for the radical.  In Jain's all-interval weights a represented
integer has the form

\[
 n=q_1q_2p_1\cdots p_Jmr,
\]

where both `m` and `r` range over smooth sets.  Their smoothness does not bound
the number of distinct prime factors.  A squarefree `y`-smooth integer still
satisfies `rad(n)=n`.  Therefore the extra low-`omega` or low-radical estimate
remains a separate theorem.

References:

- S. Jain, *Smooth Numbers in Short Intervals*, arXiv:2502.10530.
- K. Younis, *Asymptotics for smooth numbers in short intervals*,
  arXiv:2409.05761.

## 3. Exact square-root threshold

Assume along an unbounded family that

\[
 a\le b^{1/2+o(1)},
 \qquad p=b^{1/k},
 \qquad
 \operatorname{rad}(c)\le b^{\beta+o(1)}.
\]

Then

\[
 \log\operatorname{rad}(abc)
 \le
 \left(\frac12+\frac1k+\beta+o(1)\right)\log b.
\]

A fixed `epsilon>0` can contradict abc exactly when

\[
 (1+\epsilon)\left(\frac12+\frac1k+\beta\right)<1.
\]

Equivalently, before choosing a sufficiently small positive `epsilon`, the
necessary and sufficient strict slope condition is

\[
 \boxed{\ \beta<\frac12-\frac1k\ }.
\]

Consequences:

- `k=2` is impossible for every nonnegative radical slope;
- `k=3` requires `beta<1/6`;
- `k=4` requires `beta<1/4`;
- large `k` approaches, but never reaches, the threshold `beta<1/2`.

In particular, combining a square-root gap with only
`rad(c)<=b^(1/2+o(1))` is still supercritical because of the positive
prime-power term `1/k`.  The all-interval theorem therefore sharpens the
remaining target to a **strict sub-square-root radical theorem**; it does not
close the counterexample route.

If `c` is `y`-smooth and has at most `w` distinct prime factors, then

\[
 \operatorname{rad}(c)\le y^w.
\]

Writing `y=b^(1/u)`, the required statistic becomes

\[
 \boxed{\ \frac wu<\frac12-\frac1k\ }.
\]

This is the concrete analytic target for a tilted short-interval moment.

## 4. A precise tilted target

Let

\[
 S(b,h;y)=\{n\in(b,b+h]:P^+(n)\le y\}.
\]

The existing Lean extraction theorem shows that a bound of the form

\[
 \sum_{n\in S(b,h;y)} e^{-t\omega(n)}
   > |S(b,h;y)|e^{-tw}
\]

forces some `n` in the interval to satisfy `omega(n)<w`.  Hence one viable
continuation is not another unweighted smooth-number count, but an
**all-centres lower bound for a tilted friable sum** with a threshold satisfying
`w/u<1/2-1/k`.

The unresolved point is analytic: presently cited short-interval theorems do
not provide this inequality in the required parameter range.

## 5. Sparse exceptional-set transfer

For an almost-all theorem, let `C_X` be the finite set of arithmetic centres
of interest and let `E_X` contain all failed centres.  A good arithmetic centre
is guaranteed by the exact relative condition

\[
 |E_X\cap C_X|<|C_X|.
\]

An ambient estimate `|E_X|=o(X)` is not enough.  A proper sparse set may itself
be the entire exceptional set while still having zero ambient density.

For prime-power centres

\[
 C_{X,k}=\{p^k:X<p^k\le2X\},
\]

the prime number theorem gives size of order

\[
 \frac{X^{1/k}}{\log X}.
\]

Thus a black-box cardinality transfer would need, for example,

\[
 |E_X\cap C_{X,k}|=o\!\left(\frac{X^{1/k}}{\log X}\right),
\]

or a theorem formulated directly along prime-power centres.  Jain's
almost-all bound is an ambient `o(X)` statement and therefore cannot be
specialized to prime powers by cardinality alone.  The all-interval theorem
avoids this obstruction, but still leaves the radical-statistic problem in
Section 3.

The Lean module `SparseExceptionalTransfer.lean` kernel-formalizes both the
positive relative-cardinality transfer and the countermodel showing why a
mere ambient-density saving is insufficient.

## 6. Parallel consequences for other abc routes

### 6.1 Frey--Szpiro

Recent almost-all Szpiro theorems for elliptic curves with prescribed torsion
are valuable distribution results, but abc needs a uniform estimate on every
Frey curve attached to a primitive triple.  The same sparse-transfer theorem
applies: one needs an exceptional-set estimate **on the Frey locus**, or an
amplification fibre attached to every source triple that is larger than its
intersection with the exceptional set.  An ambient density-one result in the
full parameter box does not by itself give the uniform modified-Szpiro
inequality.

Reference:

- S. Chan, *Almost all elliptic curves with prescribed torsion have Szpiro
  ratio close to the expected value*, arXiv:2407.13850.

### 6.2 IUT

The current repository already proves that unrestricted inhabitation of its
abstract downstream IUT-IV bridge is equivalent to `ABCConjecture`.  Therefore
that record cannot be populated as a substitute for the missing mathematics.
The surviving route remains the construction of a genuinely reachable theta
possible-image output with its native q-pilot normalization, followed by a
uniformly quantified global estimate.

## 7. Formal additions

This research increment adds:

- `SparseExceptionalTransfer.lean`:
  relative exceptional-set extraction, sparse-family countermodel, and fibre
  amplification;
- `SquareRootSmoothNeighbourThreshold.lean`:
  the equivalence between a strict square-root budget and
  `primeSlope+smoothLoss<1/2`, the `k=2` no-go, and a specialization of the
  exact repository disproof gate;
- an expanded `SmoothCounterexampleProgram.lean` umbrella.

All statements are deterministic.  No short-interval theorem, Szpiro bound,
IUT source object, or abc-equivalent hypothesis is inserted as an axiom.

## 8. Research priority after this audit

The strongest currently exposed counterexample target is:

> Construct, for an unbounded sequence of prime powers `p^k`, an integer
> `c` in a square-root-sized interval to the right of `p^k` such that
> `rad(c)<(p^k)^(1/2-1/k-delta)` for one fixed `delta>0`.

Equivalent smooth-statistic form:

> Prove an all-centres tilted friable lower bound that extracts
> `omega(c)/u<1/2-1/k-delta`.

For the proof direction, the highest-priority independent target remains a
uniform Frey-locus modified-Szpiro estimate of slope `6+epsilon`; for the IUT
direction it remains a genuine source-level theta output and quantifier-correct
global bridge.
