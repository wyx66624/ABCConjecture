# Bidirectional prime transport with relative logarithmic drop

**Author:** ChatGPT

**Date:** 2026-09-03

**Status:** ordinary proof and Lean-checked conditional successor; no proof or
disproof of the standard abc conjecture

## 1. Purpose and logical boundary

The ordered endpoint-flow proposal required an excess layer at a prime `p` to
move only to a radical token at a prime `q >= p`.  The complete-premise family

\[
        (a,b,c)=(1,p^2-1,p^2),\qquad p\ \text{an odd prime},
\]

shows that this hard order is too rigid: every external prime is smaller than
`p`, so the unique excess layer at `p` has no legal outgoing edge.  This note
keeps the prime-token geometry but replaces the hard prohibition by a
quantitative charge for downward transport.

The replacement is a candidate, not an assumption.  We prove that a uniform
bound for its energy would imply the repository's unchanged
`ABCConjecture`.  We do **not** prove that the bound holds.  In particular, we
make no assertion that the prime-square family has uniformly small energy.
The precise point is only that this family no longer fails because all its
outgoing edges are forbidden.

## 2. Why completely unordered transport collapses

Let `I` and `J` be finite sets with nonnegative source weights `x_i` and sink
capacities `y_j`.  Put

\[
 S=\sum_{i\in I}x_i,\qquad T=\sum_{j\in J}y_j.
\]

An unordered fractional flow is a matrix `f_ij >= 0` satisfying

\[
 \sum_j f_{ij}\le x_i,\qquad \sum_i f_{ij}\le y_j.
\]

Its unmatched source mass is

\[
 U(f)=S-\sum_{i,j}f_{ij}.
\]

### Proposition 2.1 (exact unordered optimum)

For arbitrary finite nonnegative weights,

\[
             \min_f U(f)=\max\{S-T,0\}.
\]

### Proof

Every feasible flow carries at most `S` by the row inequalities and at most
`T` by the column inequalities.  Hence

\[
 U(f)\ge S-\min(S,T)=\max(S-T,0).
\]

The lower bound is attained.  If `0 < S <= T`, set

\[
                  f_{ij}=\frac{x_i y_j}{T}.
\]

Every row is saturated, while column `j` receives `(S/T)y_j <= y_j`.
If `0 < T <= S`, set instead

\[
                  f_{ij}=\frac{x_i y_j}{S}.
\]

Then every column is saturated and row `i` emits `(T/S)x_i <= x_i`.
If `S=0` or `T=0`, the zero flow handles the corresponding degenerate case.
Thus the carried mass is exactly `min(S,T)` in every case.  QED.

For endpoint prime tokens,

\[
 S=\log\operatorname{core}(c),\qquad
 T=\log\operatorname{rad}(ab).
\]

The exact endpoint identity gives

\[
 S-T=h(P)-r(P),
\]

where `h(P)=log c` and `r(P)=log rad(abc)`.  Consequently the unordered
optimum is

\[
               \max\{h(P)-r(P),0\}.
\]

A uniform epsilon bound for this number is equivalent to abc after enlarging
the additive constant to be nonnegative.  Unordered matching therefore
relabels the desired height defect and supplies no independent arithmetic
mechanism.  This is a degeneration diagnosis, not a route to close abc.

The Lean module below checks the scalar optimum exactly, maps every finite
bidirectional matrix flow to that scalar relaxation, proves the endpoint
formula, and proves the equivalence of the resulting unordered endpoint gate
with `ABCConjecture`.  The explicit proportional matrices above are retained
as the ordinary finite-dimensional proof of attainability.

## 3. Relative logarithmic downward displacement

For an edge from source prime `p` to sink prime `q`, define

\[
 d(p,q)=\max\left\{0,
       \frac{\log p-\log q}{\log p}\right\}.
\]

All actual source primes satisfy `p >= 2`, so the denominator is positive.
Thus `d(p,q)=0` when `q >= p`; when `q<p`, it records the relative loss on the
logarithmic prime scale.  This choice is scale-sensitive in the useful way:
moving from `p` to a fixed fraction of `p` costs only `O(1/log p)` per unit of
mass, whereas moving to a genuinely tiny prime has cost close to one.

A bidirectional flow has no edge-order restriction.  Its downward cost and
energy are

\[
 D(f)=\sum_{i,j} f_{ij}d(p_i,q_j),\qquad
 E(f)=U(f)+D(f).
\]

Both summands are nonnegative.  Old upward edges have zero cost, while the
previously forbidden downward edges are present and charged.

## 4. Actual endpoint candidate

Sources are the exponent layers above the first copy of each prime dividing
`c`; every such layer at `p` has capacity `log p`.  Sinks are the distinct
prime-support tokens of `ab`; a sink at `q` has capacity `log q`.  A
bidirectional endpoint flow is any nonnegative matrix obeying the source and
sink capacities.  The zero matrix proves that this type is nonempty for every
positive primitive abc point.

Define the new gate `(BEP)` by

\[
 \begin{split}
  \forall\varepsilon>0\;\exists C_\varepsilon\;\forall P\;
  \exists f:\quad
  E(f)\le \varepsilon r(P)+C_\varepsilon.
 \end{split}
\]

This gate contains genuinely more data than the unordered scalar defect: it
asks that the mass imbalance and the total relative logarithmic descent be
small simultaneously.

### Theorem 4.1 (conditional implication)

`(BEP)` implies the standard logarithmic abc conjecture.

### Proof

For every capacitated flow, independently of its edge directions,

\[
 \begin{aligned}
 U(f)
   &=S-\sum_{i,j}f_{ij}\\
   &\ge S-T\\
   &=h(P)-r(P).
 \end{aligned}
\]

Hence `h(P) <= r(P)+U(f)`.  Since `D(f)>=0`,

\[
 h(P)\le r(P)+U(f)
       \le r(P)+E(f)
       \le (1+\varepsilon)r(P)+C_\varepsilon.
\]

This is exactly `ABCConjecture` after the elementary fact that the maximum of
the three positive coordinates is `c=a+b`.  QED.

## 5. What the prime-square obstruction does and does not say

At `P_p=(1,p^2-1,p^2)`, the single source token has key `p` and every sink key
is smaller than `p`.  In the ordered model this forced `U>=log p` before any
capacity calculation.  In the bidirectional model every source-sink pair is
legal.  Proposition 2.1 says that its best unmatched mass is only

\[
 \max\{\log p-\log\operatorname{rad}(p^2-1),0\}.
\]

Whether one can also make the descent cost uniformly small depends on the
distribution and sizes of the prime divisors of `(p-1)(p+1)`.  The mere
inequalities `q<p` do not settle that question.  Accordingly this note neither
claims that `P_p` satisfies `(BEP)` nor claims that it refutes `(BEP)`.

## 6. Lean realization

The formal module is

`Lean/IUTThreeClosures/ABCBidirectionalPrimeTransportSuccessor20260903.lean`.

It contains:

1. a generic finite bidirectional flow, encoded as a capacitated flow with
   constant order keys, so every matrix entry is allowed;
2. exact source, sink, carried, and unmatched accounting;
3. the scalar unordered relaxation, its sharp positive-part optimum, and the
   lower-bound map from every matrix flow;
4. the actual endpoint specialization and the identity between its scalar
   optimum and the positive part of `height - conductor`;
5. the equivalence between the completely unordered endpoint gate and
   `ABCConjecture`;
6. relative logarithmic drop, its nonnegativity, total downward cost, endpoint
   energy, and a zero-flow inhabitant;
7. the conditional theorem
   `abc_of_uniformBidirectionalEndpointEnergyBound`.

The paired file

`Lean/IUTThreeClosures/ABCBidirectionalPrimeTransportSuccessor20260903AxiomAudit.lean`

prints the axioms of every public declaration one for one.  Neither module
uses `sorry`, a new `axiom`, `unsafe`, or `native_decide`.

## 7. Surviving bottleneck

The exact next problem is to construct, for every abc point, a capacitated
bidirectional endpoint flow whose total unmatched mass plus logarithmically
normalized descent is `o(r(P))` uniformly.  A proof must exploit arithmetic
relations among the three coordinates, because unrestricted capacity alone
reduces to the abc height defect.  A counterexample must lower-bound the full
optimized energy, not merely observe that all external primes lie below an
endpoint prime.
