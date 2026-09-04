# Adversarial audit of bidirectional endpoint energy

**Author:** ChatGPT
**Date:** 2026-09-03
**Status:** ordinary proof of a complete-premise infinite counterexample to
the exact `(BEP)` gate; this does not prove or disprove the standard abc
conjecture

## 1. Scope and conclusion

This note audits the exact candidate
`UniformBidirectionalEndpointEnergyBound` (`BEP`) from
`ABCBidirectionalPrimeTransportSuccessor20260903`.  It does not alter the
underlying endpoint identities and it does not assume abc.

The audit has two conclusions.

1.  For arbitrary finite source and sink data, minimizing `BEP` energy is a
    finite maximum-reward transportation problem.  Its exact linear program,
    dual, saturation property, and the exact one-source greedy solution are
    given below.
2.  The exact uniform gate `(BEP)` is false.  An infinite family of squared
    primitive Pythagorean triples with prime hypotenuse forces every
    bidirectional flow to spend a fixed positive proportion of the conductor.
    All hypotheses of `(BEP)` are satisfied.  Thus the gate is retired by a
    counterexample, while the parent endpoint/incidence route remains open.

## 2. Exact finite optimization problem

Let the source tokens have positive weights `x_i` and keys `p_i>1`, and let
the sink tokens have positive capacities `y_j` and keys `q_j>1`.  Put

\[
 d_{ij}=\max\!\left\{0,
       {\log p_i-\log q_j\over\log p_i}\right\},
 \qquad
 \rho_{ij}=1-d_{ij}
       =\min\!\left\{1,{\log q_j\over\log p_i}\right\}.
\]

For a feasible fractional flow `f=(f_ij)`, write

\[
  S=\sum_i x_i,\qquad W(f)=\sum_{i,j}f_{ij}.
\]

The row and column constraints are

\[
 f_{ij}\ge0,qquad \sum_jf_{ij}\le x_i,qquad
 \sum_if_{ij}\le y_j.
\]

The unmatched mass and descent cost are

\[
 U(f)=S-W(f),\qquad D(f)=\sum_{i,j}d_{ij}f_{ij}.
\]

### Proposition 2.1 (reward identity)

For every feasible flow,

\[
 E(f)=U(f)+D(f)
     =S-\sum_{i,j}\rho_{ij}f_{ij}.
\]

Consequently

\[
 \min_f E(f)=S-\max_f\sum_{i,j}\rho_{ij}f_{ij}.                \tag{2.1}
\]

### Proof

Substitute `U=S-sum f_ij` and collect the coefficient
`1-d_ij=rho_ij` of each entry.  Since all keys exceed one,
`0<rho_ij<=1`.  The feasible polytope is nonempty and compact, so the maximum
is attained.  QED.

Because every reward is strictly positive, any maximizer transports
`min(S,T)` units, where `T=sum_j y_j`: if both an unsaturated source and an
unsaturated sink remained, increasing their common edge would increase the
reward.  This determines the optimized unmatched term exactly as
`max(S-T,0)`; only the descent allocation remains.

The exact primal reward program in (2.1) has the dual

\[
 \begin{split}
  \text{minimize }&\sum_i x_i u_i+\sum_j y_jv_j,\\
  \text{subject to }&u_i+v_j\ge\rho_{ij},\qquad u_i,v_j\ge0.
 \end{split}                                                     \tag{2.2}
\]

Finite-dimensional linear-programming duality therefore gives an exact
certificate for any claimed optimum.  Complementary slackness says that a
positive edge can occur only where its dual inequality is an equality.  This
is the reliable general algorithmic structure; the truncated ratio matrix is
not globally Monge, so an unqualified one-pass matching rule is not valid for
arbitrary multiple-source data.

### Proposition 2.2 (exact one-source greedy solution)

Suppose there is one source of capacity `A=log p`.  Order the sinks so that

\[
 \rho_1\ge\rho_2\ge\cdots\ge\rho_s,
\]

equivalently, so that their prime keys are nonincreasing.  Let
`M=min(A,T)`, `B_k=sum_{j<=k}y_j`, and let `h` be the first index with
`B_h>=M`.  Then an optimum fills sinks `1,...,h-1`, sends
`M-B_{h-1}` to sink `h`, and sends nothing to later sinks.  Hence

\[
 E_{\min}=A-
 \left(\sum_{j<h}y_j\rho_j+(M-B_{h-1})\rho_h\right).             \tag{2.3}
\]

If `M=0`, the parenthesis is zero.  Multiple source layers with the same key
can first be aggregated and obey the same formula.

### Proof

The saturation observation fixes total flow at `M`.  If a lower-reward sink
receives positive flow while a higher-reward sink has unused capacity,
moving their minimum residual amount to the higher-reward sink preserves all
constraints and weakly increases reward, strictly if the rewards differ.
Iteration gives the stated prefix form and formula.  QED.

For the old prime-square points `(1,p^2-1,p^2)`, (2.3) is the complete exact
answer.  Proving or refuting an asymptotic bound from it requires information
about all prime factors of both `p-1` and `p+1`.  A theorem giving one large
prime factor on an infinite subsequence cannot establish the uniform
all-points assertion in `(BEP)`, and a finite search cannot refute it.  The
family below avoids both problems.

## 3. Prime-hypotenuse Pythagorean-square family

There are arbitrarily large primes `p` with \(p\equiv1\pmod 4\).  By
Fermat's two-square theorem, write

\[
                    p=m^2+n^2,\qquad m>n>0.
\]

Primality forces `gcd(m,n)=1`; since `p` is odd, `m,n` have opposite parity.
Set

\[
 X=m^2-n^2,\qquad Y=2mn.
\]

Euclid's identity gives `X^2+Y^2=p^2`, and the coprimality and parity
conditions give `gcd(X,Y)=1`.  Therefore

\[
                         P_p=(X^2,Y^2,p^2)                       \tag{3.1}
\]

is a positive pairwise-coprime `ABCPoint` for every such prime.

### Lemma 3.1 (all external primes are at square-root scale)

If a prime `q` divides `X Y`, then

\[
                         q\le m+n\le\sqrt{2p}.                  \tag{3.2}
\]

### Proof

Use

\[
 X=(m-n)(m+n),\qquad Y=2mn.
\]

A prime divisor of `X` divides `m-n` or `m+n`; a prime divisor of `Y`
equals two or divides `m` or `n`.  Each resulting factor is at most `m+n`.
Finally

\[
 (m+n)^2=m^2+n^2+2mn\le2(m^2+n^2)=2p.
\]

QED.

## 4. Uniform lower bound for every flow

At (3.1), `c=p^2`.  Its endpoint excess-token set therefore consists of one
token at key `p`, of capacity

\[
                              L=\log p.
\]

Every sink prime divides `X^2Y^2`, hence divides `XY`.  Lemma 3.1 and
`p>=5` give the purely integral comparison

\[
 q^4\le (2p)^2=4p^2\le p^3.
\]

Taking logarithms yields `4 log q <= 3 log p`.  Thus every edge has descent
charge

\[
 d(p,q)\ge 1- {\log q\over\log p}\ge {1\over4}.
\]

If `W` is the mass carried by an arbitrary bidirectional endpoint flow, its
row capacity gives `0<=W<=L`, while

\[
 U=L-W,\qquad D\ge {W\over4}.
\]

It follows that

\[
 E\ge L-W+{W\over4}\ge {L\over4}.                               \tag{4.1}
\]

This is a bound on **every** feasible flow, hence on the optimized energy.  It
does not depend on the factorization pattern of the two legs.

The conductor has the elementary upper bound

\[
 \operatorname{rad}(X^2Y^2p^2)\le XYp\le p^3,
 \qquad r(P_p)\le3L,                                             \tag{4.2}
\]

because `X<=p`, `Y<=p`, and the radical of a nonzero square is at most its
base.

### Theorem 4.2 (complete-premise refutation of `(BEP)`)

`UniformBidirectionalEndpointEnergyBound` is false.

### Proof

Assume `(BEP)` and specialize it to `epsilon=1/24`.  Let `C` be the asserted
uniform constant.  For every point (3.1), it supplies a flow with

\[
 E\le {1\over24}r(P_p)+C\le {1\over8}L+C.                        \tag{4.3}
\]

Combining (4.1) and (4.3) yields

\[
                              {1\over8}L\le C.                   \tag{4.4}
\]

But primes congruent to one modulo four are unbounded.  Choose one with
`log p>8C`; then (4.4) is impossible.  Every point used above is
positive and primitive, and (4.1) quantifies over every admissible flow.
This is therefore a complete-premise infinite counterexample to the exact
uniform gate.  QED.

The standard abc conjecture is not contradicted: (4.2) only gives
`height=2L` and `conductor<=3L`, and the family has no demonstrated
unbounded abc quality.  What fails is the additional demand that a single
prime-scale source be transported to square-root-scale leg primes at
sublinear relative-drop energy.

## 5. Audit of the other requested families

* **Prime-square family `(1,p^2-1,p^2)`.**  The exact optimum is (2.3).  Its
  asymptotic behavior depends on the complete shifted-prime factorization.
  The simple fact `q<p` gives only a constant lower bound and is insufficient
  for a fixed-epsilon refutation.  This route was not used to retire `(BEP)`.
* **Fixed-base power families such as `(1,2^N-1,2^N)`.**  All source keys are
  two and every sink key is at least two, so their downward cost is zero.
  They test only unmatched scalar mass and do not refute `(BEP)` unless they
  already refute abc.
* **Pythagorean squares.**  The unrestricted one-parameter family does not by
  itself force a large source key.  Restricting to the infinite
  prime-hypotenuse subfamily is decisive and gives the proof above.
* **Known high-quality abc examples.**  High scalar defect forces unmatched
  energy through `E>=max(height-conductor,0)`, but all known finite examples
  remain finite and cannot refute a statement with an arbitrary additive
  constant.  No inference from a finite table is used here.

## 6. Formal boundary and surviving successor

The companion Lean files are

* `Lean/IUTThreeClosures/ABCBidirectionalEnergyPythagoreanObstruction20260903.lean`;
* `Lean/IUTThreeClosures/ABCBidirectionalEnergyPythagoreanObstruction20260903AxiomAudit.lean`.

They formalize the prime-hypotenuse construction, its positivity and
primitivity, the square-root bound for every sink prime, the lower energy
bound for every bidirectional flow, the conductor bound, unbounded primes
congruent to one modulo four, and the final negation of `(BEP)`.

The main module exposes 40 public declarations.  The companion audit contains
40 one-for-one `#print axioms` queries.  Its only reported foundations are
Mathlib's standard `propext`, `Classical.choice`, and `Quot.sound`; it introduces
no project axiom.  The finite linear program, its dual, and Proposition 2.2 are
ordinary mathematical analysis in this note.  The Lean module formalizes the
complete infinite obstruction used in Theorem 4.2.

The counterexample retires only the exact relative-drop energy.  A surviving
positive question must change the normalization rather than merely remove
the order condition.  One concrete next gate is a **quadratic-drop energy**
whose edge charge is

\[
 \max\left\{0,{\log p-2\log q\over\log p}\right\}.
\]

It vanishes at the natural Pythagorean square-root scale and still records a
cost for sinks genuinely below `p^{1/2}`.  Before treating it as a candidate,
one must first prove a new height inequality from this weaker energy; the old
argument `height<=conductor+U` alone does not use the modified charge and
would again collapse to the scalar abc defect.  This is the next positive
lemma, not a theorem claimed here.
