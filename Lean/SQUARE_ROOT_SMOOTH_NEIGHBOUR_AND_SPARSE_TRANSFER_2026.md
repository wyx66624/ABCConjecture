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

Two analytic inputs must be distinguished:

1. an **all-interval smoothness theorem**, which gives a smooth number after
   every centre but does not control its radical;
2. an **almost-all theorem**, whose exceptional set may still contain every
   point of a sparse arithmetic subfamily such as the prime powers.

A third obstruction is now decisive: integers with genuinely small radical
are themselves sparse.  Therefore a subcritical low-radical statement cannot
hold after every integer centre.  The surviving target must be formulated on
prime-power centres or on a still sparser unbounded subsequence.

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

These theorems produce smoothness, not a power saving for the radical.  In
Jain's all-interval weights a represented integer has the form

\[
 n=q_1q_2p_1\cdots p_Jmr,
\]

where both `m` and `r` range over smooth sets.  Their smoothness does not bound
the number of distinct prime factors.  A squarefree `y`-smooth integer still
satisfies `rad(n)=n`.  Therefore the extra low-`omega` or low-radical estimate
is a separate theorem.

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

A fixed `epsilon>0` can contradict abc precisely when

\[
 (1+\epsilon)\left(\frac12+\frac1k+\beta\right)<1.
\]

Before choosing a sufficiently small positive `epsilon`, the strict slope
condition is therefore

\[
 \boxed{\ \beta<\frac12-\frac1k\ }.
\]

Consequences:

- `k=2` is impossible for every nonnegative radical slope;
- `k=3` requires `beta<1/6`;
- `k=4` requires `beta<1/4`;
- large `k` approaches, but never reaches, the threshold `beta<1/2`.

If `c` is `y`-smooth and has at most `w` distinct prime factors, then

\[
 \operatorname{rad}(c)\le y^w.
\]

Writing `y=b^(1/u)`, the required statistic becomes

\[
 \boxed{\ \frac wu<\frac12-\frac1k\ }.
\]

## 4. Low-radical density changes the target

The companion note `LOW_RADICAL_DENSITY_BARRIER_2026.md` proves the Rankin
bound

\[
 \#\{n\le X:\operatorname{rad}(n)\le R\}
 \ll_\eta R X^\eta
\]

for every fixed `eta>0`.  Hence a theorem asserting, after every centre in
`[X,2X]`, a gap at most `X^theta` and a candidate radical at most `X^beta`
requires

\[
 \theta+\beta\ge1.
\]

This is incompatible with the abc-disproof budget

\[
 \theta+\beta+\frac1k<1.
\]

Thus the earlier proposed **all-centres tilted low-radical theorem is
impossible**.  Jain's all-interval theorem may supply the geometric gap, but
the low-radical strengthening must be restricted to a thin arithmetic locus.

For all prime-power centres `p^k`, or for a fixed positive proportion of them,
the same counting theorem and the prime number theorem force

\[
 \beta\ge\frac1k.
\]

At square-root gap scale this combines with the strict abc budget to give

\[
 \frac12+\frac2k<1,
\]

so a positive-density/all-primes route requires

\[
 \boxed{k\ge5}.
\]

For `k>=5` the feasible exponent window is

\[
 \frac1k\le\beta<\frac12-\frac1k.
\]

The universal test value `beta=1/4` lies in this window for every `k>=5`.
A zero-density unbounded subsequence is not constrained by the lower bound
`beta>=1/k`; consequently sparse `k=3` or `k=4` constructions remain logically
possible.

## 5. Correct tilted targets

Let

\[
 S(b,h;y)=\{n\in(b,b+h]:P^+(n)\le y\}.
\]

The existing Lean extraction theorem shows that

\[
 \sum_{n\in S(b,h;y)} e^{-t\omega(n)}
   > |S(b,h;y)|e^{-tw}
\]

forces some `n` in the packet to satisfy `omega(n)<w`.

The viable analytic targets are now:

1. **Prime-power thin-locus target:** for one fixed `k>=5`, prove the tilted
   lower bound directly for a positive proportion of centres `b=p^k`, with
   asymptotic threshold

   \[
   \frac1k\le\frac wu<\frac12-\frac1k.
   \]

2. **Sparse subsequence target:** construct an unbounded sequence of
   prime-power centres, possibly with `k=3` or `4`, for which the tilted packet
   extracts

   \[
   \frac wu<\frac12-\frac1k.
   \]

3. **Improved-gap target:** replace the exponent `1/2` by a smaller `theta`
   and re-optimize

   \[
   \theta+\frac1k+\beta<1
   \]

   while respecting the corresponding low-radical counting restriction.

No presently cited short-interval theorem supplies any of these
prime-power-specific low-radical estimates.

## 6. Sparse exceptional-set transfer

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

or a theorem formulated directly along prime-power centres.  An ambient
`o(X)` statement cannot be specialized to prime powers by cardinality alone.

## 7. Parallel consequences for proof routes

### 7.1 Frey--Szpiro

Almost-all Szpiro theorems are valuable distribution results, but abc needs a
uniform estimate on every Frey curve attached to a primitive triple.  The
same sparse-transfer theorem applies: one needs an exceptional-set estimate
**on the Frey locus**, or a source-dependent amplification fibre whose
intersection with the exceptional set is strictly smaller than the fibre.
Ambient density one in the full elliptic-curve parameter box does not imply a
uniform modified-Szpiro inequality on the thin Frey family.

Reference:

- S. Chan, *Almost all elliptic curves with prescribed torsion have Szpiro
  ratio close to the expected value*, arXiv:2407.13850.

### 7.2 IUT

The repository proves that unrestricted inhabitation of its abstract
downstream IUT-IV bridge is equivalent to `ABCConjecture`.  That record cannot
be populated as a substitute for the missing mathematics.  The surviving
route is the construction of a genuinely reachable theta possible-image
output with its native q-pilot normalization, followed by a uniformly
quantified global estimate.

## 8. Formal additions

This research increment adds:

- `SparseExceptionalTransfer.lean`: relative exceptional-set extraction,
  sparse-family countermodel, and finite fibre amplification;
- `SquareRootSmoothNeighbourThreshold.lean`: the exact square-root slope
  threshold, the `k=2` no-go, and the bridge to the repository disproof gate;
- `TiltedSmoothNeighbourPacketGate.lean`: composition of tilted extraction
  with the smooth low-omega neighbour gate;
- `LowRadicalDensityBarrier.lean`: finite selection and exact exponent
  consequences, including the `k>=5` positive-density threshold;
- `FreySparseExceptionalAmplification.lean`: the precise Frey-fibre
  amplification interface;
- the expanded `SmoothCounterexampleProgram.lean` umbrella.

All Lean statements are deterministic.  No short-interval theorem, Szpiro
bound, IUT source object, or abc-equivalent hypothesis is inserted as an
axiom.  The infinite Euler-product convergence used in the paper proof of the
Rankin bound remains explicitly outside the Lean kernel package pending a
full analytic formalization.

## 9. Research priority after this audit

The strongest surviving counterexample targets are:

> For one fixed `k>=5`, prove directly on a positive-density set of prime
> centres `p` the existence of
> `p^k<c<=p^k+(p^k)^(1/2+o(1))` with
> `rad(c)<(p^k)^(1/2-1/k-delta)` for one fixed `delta>0`;

or

> Construct an unbounded sparse sequence of prime powers satisfying the same
> strict radical budget, without requiring positive density.

For the proof direction, the highest-priority independent target remains a
uniform Frey-locus modified-Szpiro estimate of slope `6+epsilon`; for the IUT
direction it remains a genuine source-level theta output and a
quantifier-correct global bridge.
