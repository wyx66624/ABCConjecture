# Prime-packet boundary transport after the edge-cost obstructions

**Author:** ChatGPT
**Date:** 2026-09-03
**Status:** ordinary proof of a new conditional reduction; the proposed
uniform packet bound is not assumed or proved here and is refuted in the later
Linnik theoretical audit, while the standard abc conjecture remains open

## 1. Why another transport object is needed

Two exact counterexamples now constrain any successor to ordered prime
transport.

* At `(1,p^2-1,p^2)`, every external prime is below the unique source prime
  `p`.  A hard order on individual edges therefore leaves the whole source
  unmatched.
* Let `p=m^2+n^2` be a prime hypotenuse and put
  `X=m^2-n^2`, `Y=2mn`.  At the primitive point
  `(X^2,Y^2,p^2)`, every external prime `q` satisfies
  `q <= m+n <= sqrt(2p)`.  Consequently every model which charges a fixed
  positive proportion of transported mass whenever `q` is at square-root
  scale forces an energy of order `log p`.

Simply deleting every order and retaining a divisible fractional flow does
not solve the problem.  Its optimal unmatched mass is exactly

\[
 \max\{\log\operatorname{core}(c)-\log\operatorname{rad}(ab),0\}
 =\max\{h(P)-r(P),0\},
\]

so its uniform bound is just abc in different notation.

The construction below changes the combinatorics rather than weakening one
more edge coefficient.  It aggregates all excess layers at the same endpoint
prime into one source vertex, treats each distinct external radical prime as
an indivisible sink vertex, and assigns whole sink vertices to source
packets.  A source packet may contain many small primes.  There is no cost on
an individual source-sink edge; only the total logarithmic mass of the packet
matters.

The word *boundary* is literal finite-chain bookkeeping: assigned sink
vertices form disjoint stars, and the positive residual at their source
vertices is the remaining boundary.  No geometric or etale homology theorem
is asserted.

## 2. The finite packet problem

Let `I` and `J` be finite sets.  A source `i` has weight `x_i >= 0`, and a
sink `j` has weight `y_j >= 0`.  A prime-packet assignment is a function

\[
                         o:J\longrightarrow I\sqcup\{\varnothing\}.
\]

Thus a sink is unused or belongs, in its entirety, to exactly one source
packet.  Put

\[
 M_i(o)=\sum_{o(j)=i}y_j,
 \qquad
 R_i(o)=\max\{x_i-M_i(o),0\},
 \qquad
 R(o)=\sum_iR_i(o).
\]

Also let `A(o)` be the total weight of assigned sinks.  Since the packets are
disjoint,

\[
                  \sum_i M_i(o)=A(o)\le\sum_j y_j.             \tag{2.1}
\]

### Proposition 2.1 (packet boundary inequality)

For every packet assignment,

\[
             \sum_i x_i-\sum_jy_j\le R(o).                    \tag{2.2}
\]

### Proof

For each source, `x_i-M_i(o) <= R_i(o)`.  Sum this inequality and use
(2.1):

\[
 \sum_i x_i-\sum_jy_j
 \le \sum_i x_i-A(o)
 =\sum_i(x_i-M_i(o))
 \le R(o).
\]

QED.

The empty assignment exists for every finite system.  If there is just one
positive source `i_0`, assigning every sink to `i_0` gives the exact residual

\[
                 R=\max\{x_{i_0}-\sum_jy_j,0\}.               \tag{2.3}
\]

Equation (2.3), rather than an edge-size estimate, is what controls both
one-source counterexample families discussed below.

## 3. Actual endpoint prime packets

For a positive primitive abc point `P=(a,b,c)`, take one source vertex for
each prime `p|c`, with aggregate excess weight

\[
             x_p=(v_p(c)-1)\log p.
\]

Weights with `v_p(c)=1` are zero and cause no problem.  Take one sink vertex
for each prime `q|ab`, with weight

\[
             y_q=\log q.
\]

The exact prime-factorization identities give

\[
 \sum_{p|c}x_p=\log\operatorname{core}(c),
 \qquad
 \sum_{q|ab}y_q=\log\operatorname{rad}(ab).                  \tag{3.1}
\]

Together with

\[
 h(P)-r(P)=
 \log\operatorname{core}(c)-\log\operatorname{rad}(ab),      \tag{3.2}
\]

Proposition 2.1 yields the pointwise height bridge

\[
                         h(P)\le r(P)+R(o).                    \tag{3.3}
\]

Define the packet gate `(PBT)` by

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P\
 \ \exists o:\quad
 R(o)\le\varepsilon r(P)+C_\varepsilon.                       \tag{PBT}
\]

### Theorem 3.1 (conditional implication)

`(PBT)` implies the standard logarithmic abc conjecture.

### Proof

Choose the packet assignment supplied by `(PBT)`.  Equation (3.3) gives

\[
 h(P)\le r(P)+R(o)
      \le(1+\varepsilon)r(P)+C_\varepsilon.
\]

For positive `a+b=c`, the maximum coordinate is `c`, so this is precisely the
repository's `ABCConjecture`.  QED.

Nothing in this argument assumes `(PBT)`.

## 4. Why this is not the scalar fractional relaxation

Indivisibility prevents the exact scalar collapse.  Consider two sources of
weight one and a single sink of weight two.  Total source and sink masses are
both two, so the fully divisible unordered relaxation has optimum residual
zero.  A packet assignment can give the sole sink to at most one source.
The other source retains residual one.  Hence

\[
                \min_o R(o)=1
       \quad\hbox{while}\quad
                \max\{\sum x_i-\sum y_j,0\}=0.                \tag{4.1}
\]

The Lean module proves both inequalities in (4.1), including the exact
attaining assignment.  Thus the packet objective is not pointwise a function
of the two total masses.  Whether the *uniform arithmetic gate* `(PBT)` is
logically equivalent to abc by a deeper theorem is unknown; this note does
not claim independence from abc.

Aggregating all layers at a fixed prime is essential.  If the `v_p(c)-1`
layers were separate source bins, a single large external prime could serve
only one layer, creating an artificial fixed-base obstruction.  The aggregate
source instead records the actual prime-power direction as one labelled
vertex.

## 5. Audit against the two decisive families

Suppose `c=p^2` with `p` prime.  The endpoint has exactly one source packet,
at `p`, and its weight is `log p`.  Assigning every external radical prime to
that packet gives

\[
             R=\max\{\log p-\log\operatorname{rad}(ab),0\}.   \tag{5.1}
\]

The formal module proves the singleton source statement and the abstract
all-sinks formula used in (5.1).

* For `(1,p^2-1,p^2)`, every prime divisor of `p^2-1` is allowed in the same
  packet.  The fact that each is less than `p` creates neither a forbidden
  edge nor an extra cost.
* For `(X^2,Y^2,p^2)` with prime Pythagorean hypotenuse, all primes dividing
  `XY` likewise occupy the same packet.  The estimate
  `q <= sqrt(2p)` for every individual `q` creates no positive packet charge.

These observations do **not** prove a small bound in (5.1).  The two earlier
no-edge and fixed per-edge-gap arguments alone do not refute this successor.
The later report
`ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md` gives a different
complete counterexample: a Linnik prime-neighbour family with many compulsory
sources and one exclusive sink.

## 6. Exact surviving bottleneck

The positive problem is now an indivisible logarithmic bin-covering theorem:
partition the distinct primes of `ab` among the distinct powerful primes of
`c` so that the sum of uncovered aggregate excess weights is
`o(log rad(abc))`, uniformly up to an additive constant.

A plausible arithmetic input must correlate different endpoint prime powers
through `a+b=c`; estimates applied independently to each source prime cannot
control the packet competition.  Natural next tests are:

1. exact dynamic programming on finite triples, recording the optimal packet
   residual rather than a fractional-flow surrogate;
2. adversarial fixed-base and smooth-neighbour families, because they stress
   the number and sizes of source packets;
3. congruence-labelled refinements in which a packet also carries the local
   relation `a+b=0 mod p^e`, if the bare bin-covering gate survives those
   tests.

The Lean files are

* `Lean/IUTThreeClosures/ABCPrimePacketBoundaryTransportSuccessor20260903.lean`;
* `Lean/IUTThreeClosures/ABCPrimePacketBoundaryTransportSuccessor20260903AxiomAudit.lean`.

They formalize the finite boundary inequality, the endpoint identities, the
conditional implication to `ABCConjecture`, the exact two-source/one-sink
noncollapse example, and the singleton `p^2` source-packet calculation.  They
introduce no axiom and do not assert `(PBT)`.  The implementation has 39
public declarations and the audit has exactly 39 corresponding
`#print axioms` queries.  Both files compile with
`-DwarningAsError=true`; the audit union is only Lean's standard
`propext`, `Classical.choice`, and `Quot.sound`.

The exact PBT gate is now retired by the later Linnik audit.  Its finite
boundary identity and conditional implication remain reusable, and the parent
transport route continues through shared CRT incidence rather than exclusive
ownership.
