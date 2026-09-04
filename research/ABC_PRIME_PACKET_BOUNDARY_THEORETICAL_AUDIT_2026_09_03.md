# Theoretical adversarial audit of prime-packet boundary transport

**Author:** ChatGPT
**Date:** 2026-09-03
**Status:** ordinary proof of an unconditional complete-premise infinite
counterexample to the exact `(PBT)` gate; the standard abc conjecture is not
contradicted

## 1. Scope and conclusion

This note audits `UniformEndpointPrimePacketBound` from
`ABCPrimePacketBoundaryTransportSuccessor20260903`.  It does not modify that
module or its original report, and it does not assume the abc conjecture.

The outcome is decisive for the exact packet gate.

1.  The finite objective is a multiple-bin covering problem.  Its difference
    from the divisible scalar relaxation is an exact nonnegative
    *indivisibility gap*.  General reward, cardinality, singleton-sink, and
    greedy overshoot formulas are proved below.
2.  Linnik's theorem supplies an infinite family

    \[
                         (1,\ell,\ell+1),
    \]

    in which `ell+1` is divisible by the square of a product of arbitrarily
    many distinct primes, while `ell` itself is prime and is the sole
    external sink.  One indivisible sink can serve at most one of the many
    source packets.  The resulting optimal residual is a fixed positive
    proportion of the conductor along a subsequence, even though the scalar
    abc defect is identically zero.
3.  Consequently `(PBT)` is false.  This retires the exclusive-ownership
    packet gate only.  Every point in the counterexample family satisfies
    the slope-one abc inequality `height <= conductor`, so it gives no
    counterexample to abc.

No finite computation is used in the proof.

## 2. Exact finite bin-cover structure

Let `I` be a finite set of sources with weights `x_i >= 0`, and let `J` be a
finite set of indivisible sinks with weights `y_j >= 0`.  For an assignment
`o : J -> I union {unused}`, put

\[
 M_i(o)=\sum_{o(j)=i}y_j,\qquad
 R_i(o)=\max\{x_i-M_i(o),0\},\qquad
 R(o)=\sum_i R_i(o).
\]

Write

\[
 X=\sum_i x_i,\qquad Y=\sum_jy_j,\qquad
 R_*=\min_oR(o).
\]

The minimum exists because the assignment set is finite.

### Proposition 2.1 (clipped-reward identity)

For every assignment,

\[
 R(o)=X-\sum_i\min\{x_i,M_i(o)\}.                              \tag{2.1}
\]

Hence minimizing residual is exactly the problem of maximizing the clipped
covered mass.  Moreover

\[
             R_*\ge \Delta:=\max\{X-Y,0\}.                    \tag{2.2}
\]

### Proof

Both `x_i` and `M_i(o)` are nonnegative, so

\[
 \max\{x_i-M_i(o),0\}=x_i-\min\{x_i,M_i(o)\}.
\]

Summing proves (2.1).  The clipped covered mass is at most `X`.  It is also
at most the sum of all assigned sink weights, which is at most `Y` because
ownership is disjoint.  Thus `R(o) >= X-Y` and `R(o) >= 0`; minimize over
`o` to obtain (2.2).  QED.

### Proposition 2.2 (cardinality obstruction)

Let `t` be the number of positive-weight sinks.  Choose any `k` sources, and
write their weights in nonincreasing order

\[
                         z_1\ge z_2\ge\cdots\ge z_k.
\]

Every assignment satisfies

\[
                         R(o)\ge\sum_{i=t+1}^{k}z_i,            \tag{2.3}
\]

where the sum is zero when `t >= k`.

### Proof

A source has positive packet mass only if it owns at least one positive
sink.  Disjoint ownership therefore gives positive packet mass to at most
`t` of the selected sources.  Every other selected source contributes its
full weight to `R(o)`.  The smallest possible sum of at least `k-t` such
weights is the sum of the `k-t` smallest selected weights, namely the
right-hand side of (2.3).  QED.

This lower bound uses only exclusivity.  It is independent of how large the
sinks are.

### Proposition 2.3 (exact singleton-sink optimum)

Suppose there is one sink, of weight `y`.  Then

\[
                 R_*=X-\max_i\min\{x_i,y\}.                   \tag{2.4}
\]

In particular, if `y >= max_i x_i`, then

\[
                             R_*=X-\max_i x_i.                 \tag{2.5}
\]

### Proof

Leaving the sink unused gives reward zero in (2.1).  Giving it to source
`i` gives reward `min{x_i,y}` and changes no other source.  Maximizing over
these exhaustive choices proves (2.4), and (2.5) follows immediately.  QED.

### Proposition 2.4 (general greedy overshoot upper bound)

Let `n` be the number of positive sources, and order the positive sink
weights as

\[
                         y_{[1]}\ge y_{[2]}\ge\cdots\ge y_{[t]}.
\]

Then

\[
 R_*\le \Delta+
       \sum_{j=1}^{\min\{n-1,t\}}y_{[j]}.                     \tag{2.6}
\]

### Proof

Process the sources in any order.  Put whole unused sinks into the current
source until its demand is met, then move to the next source.  If every
source is met, the residual is zero.  Otherwise all sinks are exhausted
after at most `n-1` sources have been completed.

For each completed source, call the amount by which its last sink crosses
the demand its overshoot.  The sum `O` of the overshoots is bounded by the
sum of at most `n-1` distinct sink weights, hence by the last term of (2.6).
All sink mass other than these overshoots contributes clipped reward.  Thus
the constructed assignment has

\[
                         R=X-Y+O\le\Delta+O.
\]

This proves (2.6).  QED.

The lower bound (2.3) and upper bound (2.6) identify two different losses:
too few sinks leave whole source bins untouched, while crossing a source
boundary can waste a whole final sink.  Neither loss exists in a divisible
flow.

## 3. Exact relation to the scalar abc defect

For an abc point `P`, let `R_*(P)` be the optimal endpoint packet residual.
The source and sink identities in the original PBT module give

\[
 X(P)=\log\operatorname{core}(c),\qquad
 Y(P)=\log\operatorname{rad}(ab).
\]

Consequently

\[
 \Delta(P)=\max\{X(P)-Y(P),0\}
           =\max\{h(P)-r(P),0\}.                              \tag{3.1}
\]

Define the exact indivisibility gap

\[
                         G(P)=R_*(P)-\Delta(P)\ge0.            \tag{3.2}
\]

### Proposition 3.1 (logical decomposition of PBT)

The uniform packet gate is equivalent to the conjunction of

1. the logarithmic abc bound, equivalently a uniform sublinear bound for
   `Delta(P)`; and
2. the uniform estimate

   \[
    \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P:
             G(P)\le\varepsilon r(P)+C_\varepsilon.           \tag{IG}
   \]

### Proof

By (3.2), `R_* = Delta+G`, and both summands are nonnegative.  A PBT bound
therefore bounds each summand separately.  The bound for `Delta`, together
with (3.1), is the standard logarithmic abc inequality.

Conversely, apply the two asserted bounds with `epsilon/2` and add them.
Enlarging either additive constant to be nonnegative handles the positive
part in (3.1).  The sum is the PBT estimate for `R_*`.  QED.

Thus PBT does split exactly into abc plus an indivisibility-loss statement.
The next section proves that the second statement is false: this loss is not
uniformly sublinear.

## 4. The Linnik prime-neighbour construction

We use the following established unconditional theorem.

### Theorem 4.1 (Linnik)

There are absolute constants `C >= 1` and `L >= 1` such that, whenever
`gcd(a,Q)=1`, the least prime \(\ell\equiv a\pmod Q\) satisfies

\[
                              \ell\le C Q^L.                   \tag{4.1}
\]

This is Linnik's least-prime theorem, not a conjectural distribution
estimate.  See [Linnik's original basic theorem
(1944)](https://www.mathnet.ru/eng/sm/v57/i2/p139) and the modern statement
and quantitative refinement in [Xylouris, *On Linnik's constant*
(2009)](https://arxiv.org/abs/0906.2749).  Only the existence of some
absolute `C,L` is used below; no claimed best numerical exponent is needed.

Let

\[
 p_1<p_2<\cdots<p_k,\qquad M_k=\prod_{i=1}^{k}p_i,
 \qquad Q_k=M_k^2,
\]

where the `p_i` are the first `k` primes.  Since `gcd(Q_k-1,Q_k)=1`, choose
by Theorem 4.1 a prime

\[
 \ell_k\equiv-1\pmod{Q_k},\qquad
 \ell_k\le C M_k^{2L}.                                       \tag{4.2}
\]

Put

\[
                         P_k=(1,\ell_k,\ell_k+1).              \tag{4.3}
\]

These are positive primitive abc points.  They are an infinite family:
`M_k -> infinity`, while the congruence forces `ell_k+1 >= M_k^2`.

### Lemma 4.2 (one sink and many compulsory sources)

At `P_k`, the external sink set consists of the single prime `ell_k`.  For
every `i <= k`, the endpoint source at `p_i` has weight at least `log p_i`.
Every packet assignment therefore satisfies

\[
                     R(P_k)\ge\log M_k-\log p_k.               \tag{4.4}
\]

### Proof

The external product is `1*ell_k`, so its prime support is the singleton
`{ell_k}`.  On the endpoint side, (4.2) gives

\[
                         M_k^2\mid \ell_k+1.
\]

Hence `v_{p_i}(ell_k+1) >= 2`, and the aggregate source weight

\[
       (v_{p_i}(\ell_k+1)-1)\log p_i
\]

is at least `log p_i`.  The sole sink can belong to at most one source
packet.  All the other selected sources retain their complete weights.
Discarding the largest of the `k` guaranteed lower bounds gives (4.4).
QED.

There is also an exact singleton formula here.  If `r^e` is the exact prime
power in `ell_k+1`, then

\[
 r^{e-1}\le {\ell_k+1\over r}
            \le {\ell_k+1\over2}\le\ell_k.
\]

Thus every source weight is at most `log ell_k`; the unique sink can cover
whichever one source receives it.  Proposition 2.3 gives

\[
 R_*(P_k)=\log\operatorname{core}(\ell_k+1)
          -\max_{r\mid\ell_k+1}(v_r(\ell_k+1)-1)\log r.        \tag{4.5}
\]

The coarser bound (4.4) is uniform in the unknown cofactor of
`ell_k+1` and is all that the refutation needs.

### Lemma 4.3 (the scalar defect vanishes)

For every `k >= 2`,

\[
                            h(P_k)\le r(P_k),                  \tag{4.6}
\]

so `Delta(P_k)=0` and `G(P_k)=R_*(P_k)`.

### Proof

The integer `ell_k+1` is divisible by `M_k^2`, hence is even.  Therefore
its radical is at least two.  Since `ell_k` and `ell_k+1` are coprime,

\[
 \operatorname{rad}(\ell_k(\ell_k+1))
   =\ell_k\operatorname{rad}(\ell_k+1)
   \ge2\ell_k\ge\ell_k+1.
\]

Take logarithms.  QED.

### Lemma 4.4 (conductor is only logarithmic in the forced square divisor)

There is an absolute constant `B` such that

\[
                         r(P_k)\le4L\log M_k+B.                \tag{4.7}
\]

### Proof

The elementary radical bound and `ell_k+1 <= 2 ell_k` give

\[
 r(P_k)
 \le\log(\ell_k(\ell_k+1))
 \le2\log\ell_k+\log2.
\]

Apply (4.2) and take `B=2 log C+log 2`.  QED.

### Lemma 4.5 (no single guaranteed source dominates)

\[
                         {\log p_k\over\log M_k}\longrightarrow0. \tag{4.8}
\]

### Proof

Bertrand's postulate gives `p_k < 2^k`.  Also `p_i >= i+1`, so

\[
 M_k\ge(k+1)!.
\]

The last half of the factors in `(k+1)!` already give
`log((k+1)!) >= (k/2) log(k/2)` for large `k`.  Therefore

\[
 0\le {\log p_k\over\log M_k}
 \le {k\log2\over (k/2)\log(k/2)}\longrightarrow0.
\]

QED.

## 5. Complete-premise refutation of PBT

### Theorem 5.1

`UniformEndpointPrimePacketBound` is false.

### Proof

Use the absolute exponent `L` in Theorem 4.1 and set

\[
                              \varepsilon_0={1\over8L}>0.
\]

By Lemmas 4.2 and 4.4,

\[
 \begin{aligned}
 R_*(P_k)-\varepsilon_0r(P_k)
 &\ge \log M_k-\log p_k
       -{1\over8L}(4L\log M_k+B)\\
 &= {1\over2}\log M_k-\log p_k-{B\over8L}.
 \end{aligned}                                                \tag{5.1}
\]

Lemma 4.5 says that the right-hand side tends to infinity.  Therefore, for
every proposed additive constant `C_epsilon0`, some `P_k` satisfies

\[
                         R_*(P_k)>
                         \varepsilon_0r(P_k)+C_{\varepsilon_0}.
\]

Since `R_*` is the minimum over all packet assignments, no assignment at
that point can satisfy the PBT conclusion.  The family is infinite,
positive, primitive, and uses the actual endpoint source and sink weights.
All premises and all quantifiers of PBT have therefore been met.  QED.

By Lemma 4.3, the same family has zero scalar defect.  It refutes the
indivisibility estimate `(IG)` while satisfying the sharp slope-one abc
inequality.  The standard abc conjecture is untouched.

## 6. Audit of the requested family types

### 6.1 Fixed-base powers

For

\[
                         (1,A^N-1,A^N),
\]

the source primes are the fixed primes dividing `A`, with weights

\[
                         (N v_p(A)-1)\log p.
\]

If `A` is a prime power there is only one positive source.  Assigning every
sink to that source reduces the packet optimum to the scalar positive-part
deficit, as in the original module's one-source formula.  There is no pure
indivisibility obstruction.

When `A` has several prime factors, a packet obstruction would require
detailed information about the complete prime support and sizes in
`A^N-1`.  Primitive-divisor results supply new sink primes for many
exponents, but do not by themselves prove the required packet balance or an
infinite failure.  No fixed-base power family is used to retire PBT.

### 6.2 Smooth-neighbour and prime-neighbour triples

The Linnik family is a rigorous prime-neighbour replacement for the usually
unproved demand that both neighbours have prescribed smoothness.  It does
not require `ell_k+1` itself to be smooth.  The congruence forces only the
large square divisor `M_k^2`, while Linnik supplies a prime neighbour of
polynomial size.  Unknown additional prime factors of `ell_k+1` can add
sources but cannot reduce the lower bound (4.4).

### 6.3 Endpoints with several powerful primes

Proposition 2.2 gives a reusable obstruction.  If `c` contains a square
divisor

\[
                              M^2=\prod_{p\in S}p^2
\]

and `ab` has only `t` distinct prime divisors, then every packet assignment
leaves at least the sum of the `|S|-t` smallest values `log p`, `p in S`.
More generally, a forced divisor `M^d`, `d >= 2`, multiplies these guaranteed
weights by `d-1`.

This statement isolates the actual arithmetic correlation needed for a
counterexample: many powerful endpoint primes, few external radical primes,
and a polynomial relation between their total logarithmic sizes.  Linnik's
theorem supplies all three with `t=1`.

## 7. Consequences for a positive successor

The exact PBT gate must be retired.  Its failure is caused by exclusive
ownership, not by a shortage of external logarithmic mass.  In the Linnik
family, the one prime `ell_k` simultaneously satisfies

\[
                         \ell_k\equiv-1\pmod{p_i^2}
                         \quad(1\le i\le k).
\]

Arithmetic information from one external prime can therefore interact with
many endpoint prime powers at once, while a PBT sink is allowed to serve
only one of them.  The packet rule discards this Chinese-remainder
correlation.

A viable successor would have to allow a single external prime to carry
several congruence incidences, or replace ownership by a structure that
records the simultaneous residues.  Simply making sinks divisible returns
to the scalar relaxation and hence to the abc defect itself.  Before any
such successor is proposed as an abc gate, it needs both:

1. a pointwise height bridge that remains valid under shared incidence; and
2. an audit against the Linnik family showing that one prime congruent to
   `-1` modulo a large squarefull modulus does not create an artificial
   linear loss.

The complete refutation above is an ordinary proof relying on the
established analytic theorem (4.1).  The companion module
`ABCPrimePacketBoundaryLinnikObstruction20260903` formalizes the clipped-reward
identity, the unique-sink lower bound, the actual point `(1,ell,ell+1)`, the
square-divisor endpoint sources, the conductor and zero-scalar-defect bounds,
and the implication

```
LinnikPrimeNeighborEscape -> not UniformEndpointPrimePacketBound.
```

Here `LinnikPrimeNeighborEscape` is a transparent arithmetic proposition
containing only primes, a finite prime set, square divisibility, a cap, and an
explicit logarithmic escape.  Its derivation from Linnik's theorem remains the
source-dependent paper step because the current Mathlib tree contains no
formalization of that analytic theorem.  The module and its audit expose 27
public declarations and 27 ordered axiom queries; no project axiom is inserted
and no unconditional Lean refutation is claimed.
