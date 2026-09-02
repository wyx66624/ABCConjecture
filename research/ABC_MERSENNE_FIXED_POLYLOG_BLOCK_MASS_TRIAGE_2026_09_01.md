# Fixed-Polylogarithmic Block-Mass Gate and Sharp Mersenne Triage

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional equivalence and obstruction theorem; this note does
not prove or disprove the standard abc conjecture.

## 1. Purpose and result

Put

\[
 M_m=2^m-1,
 \qquad W_m=\frac{M_m}{\operatorname{rad}(M_m)}.
\]

For every positive integer \(d\), let

\[
 E_d=\prod_{\substack{p\mid 2^d-1\\
             \operatorname{ord}_p(2)=d}}
       p^{v_p(2^d-1)-1},
 \qquad a_d=\log E_d.                                    \tag{1.1}
\]

Earlier modules prove

\[
 0\le a_d\le(\log 3)\varphi(d)                           \tag{1.2}
\]

and reduce the Mersenne endpoint exactly to

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 A(m):=\sum_{d\mid m}a_d=o(m).                            \tag{1.3}
\]

The preceding fixed-polylogarithmic gate localized *exceptional totient
mass* and retained an auxiliary threshold.  This note removes that threshold:
it localizes the actual logarithmic block mass itself.  If

\[
 L_m=\log\log(3m),                                       \tag{1.4}
\]

define, for a fixed positive integer \(k\),

\[
 P_k(m)=\sum_{\substack{d\mid m\\
                   \log(m/d)<kL_m}}a_d.                  \tag{1.5}
\]

The first theorem is the exact unconditional gate

\[
 \boxed{
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 \forall k\in\mathbb Z_{>0},\ P_k(m)=o(m).}              \tag{1.6}
\]

Consequently, failure of the endpoint forces positive linear actual block
mass in one fixed polylogarithmic co-divisor window.  In that window the
small repeated-prime support is already negligible.  Hence the previous
global three-arm constant \(1/6\) improves to every fixed constant
\(\gamma<1/3\).  The number \(1/3\) is the sharp algebraic ceiling for a
three-term nonnegative decomposition.  This improvement does not estimate
any of the three surviving arithmetic arms; it identifies the remaining
theorem needed to close the route.

## 2. Co-divisor form and exact finite split

The divisor involution \(d\mapsto q=m/d\) rewrites (1.5) as

\[
 P_k(m)=\sum_{\substack{q\mid m\\
            \log q<kL_m}}a_{m/q}
       =\sum_{\substack{q\mid m\\
            q<\{\log(3m)\}^{k}}}a_{m/q}.                 \tag{2.1}
\]

The equality of the two regions follows from
\(\exp(k\log\log(3m))=\{\log(3m)\}^k\).  Define the closed
complementary tail

\[
 F_k(m)=\sum_{\substack{d\mid m\\
                kL_m\le\log(m/d)}}a_d.                  \tag{2.2}
\]

The strict inequality in (1.5) and the non-strict inequality in (2.2)
give the exact finite identity

\[
                         A(m)=F_k(m)+P_k(m).              \tag{2.3}
\]

No boundary divisor is omitted or counted twice.

Let

\[
 T_k(m)=\sum_{\substack{d\mid m\\
                kL_m\le\log(m/d)}}\varphi(d).            \tag{2.4}
\]

The exact logarithmic-deficit moment and finite weighted Markov inequality,
proved in `MersennePolylogCodivisorGate20260901.lean`, give an absolute
constant \(C_0>0\) such that, eventually in \(m\), simultaneously for every
positive integer \(k\),

\[
                         T_k(m)\le \frac{C_0}{k}m.        \tag{2.5}
\]

Combining (1.2), (2.2), and (2.5) gives the actual-block estimate

\[
 0\le F_k(m)
 \le(\log3)T_k(m)
 \le\frac{(\log3)C_0}{k}m.                               \tag{2.6}
\]

The estimate is uniform in every fixed positive integer \(k\), but for a
single fixed \(k\) its normalized right side is a constant rather than
something tending to zero.  The proof below uses the quantifiers in the
only valid order: choose a sufficiently large fixed \(k\) from the requested
error and then let \(m\) tend to infinity.

## 3. Threshold-free fixed-polylogarithmic gate

### Theorem 3.1 (actual block-mass equivalence)

Let \((a_d)_{d\ge1}\) be any sequence satisfying

\[
                 0\le a_d\le C\varphi(d)                 \tag{3.1}
\]

for one fixed \(C\ge0\).  Define \(A,F_k,P_k\) as above.  Then

\[
 A(m)=o(m)
 \quad\Longleftrightarrow\quad
 \forall k\in\mathbb Z_{>0},\ P_k(m)=o(m).               \tag{3.2}
\]

For the canonical Mersenne masses, (1.3) turns (3.2) into (1.6).

#### Proof

If \(A=o(m)\), nonnegativity and \(0\le P_k\le A\) imply
\(P_k=o(m)\) for each fixed \(k\).

Conversely, suppose every fixed positive-integer \(P_k\) is \(o(m)\).
Let \(\eta>0\).  Choose a positive integer \(k\), now fixed, so large that

\[
                         \frac{CC_0}{k}<\frac\eta2.       \tag{3.3}
\]

The hypothesis for this fixed \(k\) supplies \(M_1\) such that

\[
                         P_k(m)<\frac\eta2m
                         \qquad(m\ge M_1).                \tag{3.4}
\]

Equations (2.3), (2.5), and (3.1) supply \(M_2\) such that

\[
 A(m)=F_k(m)+P_k(m)
 \le \frac{CC_0}{k}m+P_k(m)<\eta m                       \tag{3.5}
\]

for \(m\ge\max(M_1,M_2)\).  Since \(A\ge0\) and \(\eta\) was arbitrary,
\(A=o(m)\).  For (1.6), take \(C=\log3\) and use (1.3).  ∎

This equivalence is strictly more direct than an exceptional-set criterion:
there is no normalized threshold \(a_d>\epsilon\varphi(d)\) left in the
statement.  It is nevertheless an equivalent gate, not a proof of its
right-hand side.

## 4. Exact-order Wieferich decomposition inside the window

For an odd prime \(p\), put

\[
 d_p=\operatorname{ord}_p(2),
 \qquad w_p=v_p(2^{d_p}-1).                              \tag{4.1}
\]

LTE gives

\[
 v_p(2^{p-1}-1)=v_p(2^{d_p}-1)=w_p,                     \tag{4.2}
\]

so \(w_p\ge2\) is exactly the base-two Wieferich condition.  Fix
\(\delta>0\) and let

\[
 Y_d=\frac{\varphi(d)^2}{\log\log(3d)}.                  \tag{4.3}
\]

For each exact-order block define

\[
\begin{aligned}
 S_d&=\sum_{\substack{d_p=d,\ w_p\ge2\\p\le Y_d}}\log p,\\
 T_{d,\delta}
   &=\sum_{\substack{d_p=d,\ w_p\ge2\\
                 Y_d<p\le d^{2+\delta}}}\log p,\\
 X_{d,\delta}
   &=\sum_{\substack{d_p=d,\ w_p\ge2\\
                 p>d^{2+\delta}}}\log p,\\
 G_d&=\sum_{\substack{d_p=d\\w_p\ge3}}(w_p-2)\log p.
                                                               \tag{4.4}
\end{aligned}
\]

Prime by prime, \(w_p-1=1+(w_p-2)\) when \(w_p\ge2\).  The three size
ranges partition the one-copy repeated support.  Therefore

\[
                  a_d=S_d+T_{d,\delta}+X_{d,\delta}+G_d  \tag{4.5}
\]

exactly, with every summand nonnegative.

The previously proved Brun--Titchmarsh estimate is

\[
                         S_d=o(\varphi(d)).               \tag{4.6}
\]

For a fixed \(k\), every divisor in (1.5) satisfies

\[
 d>\frac{m}{\{\log(3m)\}^{k}}\longrightarrow\infty.     \tag{4.7}
\]

Writing \(r(d)=S_d/\varphi(d)\), (4.6), (4.7), and
\(\sum_{d\mid m}\varphi(d)=m\) yield

\[
\begin{aligned}
 \sum_{\substack{d\mid m\\\log(m/d)<kL_m}}S_d
 &\le
 \left(\sup_{d>m/\{\log(3m)\}^{k}}r(d)\right)
 \sum_{d\mid m}\varphi(d)\\
 &=o(m).                                                  \tag{4.8}
\end{aligned}
\]

Thus the small arm is uniformly negligible in each fixed polylogarithmic
window.  This is stronger for the present purpose than first embedding the
window in the larger \(L_m^2\) near-diagonal region.

## 5. Sharp fixed-window three-arm obstruction

### Theorem 5.1 (failure forces one fixed arithmetic arm)

Fix \(\delta>0\).  If \(\log W_m\ne o(m)\), then there are a fixed
positive integer \(k\), a fixed \(\epsilon>0\), and an unbounded sequence
\(m_j\) such that

\[
 P_k(m_j)\ge\epsilon m_j.                                \tag{5.1}
\]

For every fixed \(\gamma\) with \(0<\gamma<1/3\), after passage to a
subsequence one of the following same alternatives holds for every
sufficiently large \(j\):

1. **localized deep lifts**
   \[
    \sum_{\substack{d\mid m_j\\
           \log(m_j/d)<kL_{m_j}}}G_d
       \ge\gamma\epsilon m_j;                            \tag{5.2}
   \]
2. **localized transition clustering:** there are at least
   \[
    \frac{\gamma\epsilon m_j}
         {(2+\delta)\log m_j}                             \tag{5.3}
   \]
   distinct base-two Wieferich primes \(p\) satisfying
   \[
   \begin{gathered}
     d_p\mid m_j,
     \qquad \log(m_j/d_p)<kL_{m_j},\\
     Y_{d_p}<p\le d_p^{2+\delta};                        \tag{5.4}
   \end{gathered}
   \]
3. **localized extreme small order**
   \[
    \sum_{\substack{d\mid m_j\\
           \log(m_j/d)<kL_{m_j}}}X_{d,\delta}
       \ge\gamma\epsilon m_j,                            \tag{5.5}
   \]
   and every prime counted there satisfies
   \[
                  \operatorname{ord}_p(2)
                    <p^{1/(2+\delta)}.                   \tag{5.6}
   \]

One may take the clean numerical value \(\gamma=1/4\).

#### Proof

Theorem 3.1 and its contrapositive give a fixed \(k\) for which
\(P_k\ne o(m)\).  Since \(P_k\ge0\), failure of little-oh supplies
\(\epsilon>0\) and an unbounded sequence satisfying (5.1).

Sum (4.5) only over the window in (1.5).  Equation (4.8) shows that its
small contribution is \(o(m_j)\), so

\[
 \sum_{\substack{d\mid m_j\\
         \log(m_j/d)<kL_{m_j}}}
   \bigl(G_d+T_{d,\delta}+X_{d,\delta}\bigr)
 \ge (\epsilon-o(1))m_j.                                \tag{5.7}
\]

Because \(3\gamma<1\), for every sufficiently large \(j\) at least one of
the three sums in (5.7) is at least \(\gamma\epsilon m_j\).  Infinite
pigeonhole fixes the same arm on a subsequence.  This proves (5.2) or
(5.5), or gives the transition mass lower bound.

In the transition case, every counted prime satisfies
\(p\le d_p^{2+\delta}\le m_j^{2+\delta}\), hence
\(\log p\le(2+\delta)\log m_j\).  Prime sets belonging to different
\(d\)'s are disjoint because a prime has one multiplicative order.  Dividing
the total logarithmic mass by this pointwise cap proves (5.3).  Equation
(4.2) supplies the Wieferich condition.  In the extreme case,
\(p>d_p^{2+\delta}\) is equivalent to (5.6).  ∎

The earlier \(1/6\) theorem paid one quarter of the target for a far arm
and another quarter for the small arm.  Theorem 3.1 chooses a window in
which the counterexample mass is already linear, so there is no far-arm
subtraction.  Only the \(o(m)\) small arm remains.

## 6. Exact closure target

The preceding argument also gives a threshold-free sufficient condition.
For any one fixed \(\delta>0\), it suffices to prove, for every fixed
positive integer \(k\),

\[
 \sum_{\substack{d\mid m\\\log(m/d)<kL_m}}G_d=o(m),      \tag{6.1}
\]

\[
 \#\left\{p:\begin{array}{l}
       d_p\mid m,\ \log(m/d_p)<kL_m,\\
       w_p\ge2,\ Y_{d_p}<p\le d_p^{2+\delta}
       \end{array}\right\}
      =o\!\left(\frac m{\log m}\right),                 \tag{6.2}
\]

and

\[
 \sum_{\substack{d\mid m\\\log(m/d)<kL_m}}
          X_{d,\delta}=o(m).                             \tag{6.3}
\]

Indeed, (6.2) bounds the transition mass by
\((2+\delta)\log m\) times the cardinality; (4.8) handles the small arm;
then (4.5) gives \(P_k=o(m)\) for every fixed \(k\), and Theorem 3.1 closes
the endpoint.  The remaining gap is therefore a localized, weighted,
exact-order theorem about repeated prime factors.  A global unweighted
statement about multiplicative orders does not by itself imply any of
(6.1)--(6.3).

## 7. Counterexample pressure and exact scope

The finite ordered-ring statement behind the convenient quarter constant
is

\[
\begin{gathered}
  R\le S+G+T+X,
  \qquad S\le R/4\\
  \Longrightarrow\quad
  R/4\le G\ \ \text{or}\ \ R/4\le T\ \ \text{or}\ \ R/4\le X.
                                                               \tag{7.1}
\end{gathered}
\]

The coefficient \(1/4\) is sharp under exactly these premises.  Take

\[
             (R,S,G,T,X)=(4,1,1,1,1).                   \tag{7.2}
\]

All five masses are nonnegative, equality holds in the decomposition, and
\(S=R/4\).  For every \(c>1/4\), all three conclusions
\(cR\le G,T,X\) fail.  Thus no larger uniform coefficient follows from the
finite quarter-budget premises.

The asymptotic ceiling \(1/3\) is also exact at the level of a three-arm
mass ledger.  Take

\[
             (R,S,G,T,X)=(3,0,1,1,1).                   \tag{7.3}
\]

For every \(\gamma>1/3\), all three conclusions
\(\gamma R\le G,T,X\) fail despite the exact nonnegative decomposition and
zero small arm.  This explains why Theorem 5.1 states every strict
\(\gamma<1/3\), rather than a uniform \(1/3\).

The examples (7.2)--(7.3) are **abstract mass assignments**.  They are not
values of actual cyclotomic blocks, do not satisfy any unstated
prime-order realization property, and do not disprove (6.1), (6.2), or
(6.3).  No full-premise actual Mersenne counterexample to the direct gate or
to any of the three arithmetic arms was found.  Accordingly, none of those
routes is retired.

### 7.1 Actual arithmetic counterexample scan

The archived deterministic scan in
`research/computation/2026_09_01_mersenne_super_wieferich_depth/`
checked every prime \(p\le10{,}000{,}000\); the independent segmented-sieve
verifier recomputes all 664,579 primality positions, Fermat congruences,
exact-order certificates, and prime-power depths.  The two rows below are the
complete projection of that stronger sealed scan to \(p\le2{,}000{,}000\).
For each prime it first tested

\[
                     2^{p-1}\equiv1\pmod {p^2}.          \tag{7.4}
\]

For every hit, it factored \(p-1\), repeatedly divided a candidate order
by a prime factor \(r\) precisely when
\(2^{d/r}\equiv1\pmod p\), and finally tested the resulting exact order
modulo \(p^2,p^3,\ldots\).  This is an exhaustive finite computation in the
displayed range, not a probabilistic primality or order test.  It found:

| \(p\) | \(d=\operatorname{ord}_p(2)\) | \(w_p\) | \(\varphi(d)\) | \(Y_d\) (decimal) | \(p/Y_d\) | \(p/d^2\) |
|---:|---:|---:|---:|---:|---:|---:|
| 1093 | 364 | 2 | 144 | 10659.510257 | 0.10253754 | 0.00824931 |
| 3511 | 1755 | 2 | 864 | 347509.378973 | 0.01010332 | 0.00113993 |

These two rows give exact full-premise counterexamples to several tempting
but overstrong **finite** assertions:

* `P_k(m)=0` for every \(m\) and fixed \(k>0\) is false.  Take
  \(m=d=364\).  Then \(d\mid m\),
  \(\log(m/d)=0<kL_m\), and the prime 1093 contributes
  \(\log1093>0\) to \(P_k(364)\).
* A localized repeated exact-order prime need not be deep: both rows have
  the full Wieferich premise \(w_p\ge2\) but satisfy \(w_p=2\), hence
  contribute nothing to \(G_d\).
* A localized repeated exact-order prime need not be transition or extreme:
  both satisfy \(p<Y_d\), and even \(p<d^2<d^{2+\delta}\) for every
  \(\delta>0\).  They lie in the explicitly retained small arm.

These are not counterexamples to `P_k=o(m)`, to (4.8), or to any alternative
of Theorem 5.1: two isolated indices do not violate an asymptotic statement,
and the theorem deliberately permits a finite small-arm contribution.  The
scan found no depth \(w_p\ge3\) in its finite range, but that absence proves
nothing beyond the range and is not a reason to delete the deep route.

## 8. What current primary literature supplies

The following source check was made against primary papers available on
1 September 2026.

1. Carl Pomerance, [*Cyclotomic primes*](https://arxiv.org/html/2411.04213v2),
   arXiv:2411.04213v2; *Journal of Number Theory* **276** (2025), 198--208.
   Section 2 records that a primitive prime divisor of \(\Phi_m(2)\) is
   characterized by \(\operatorname{ord}_p(2)=m\), and equation (2) gives
   \[
        2^{\varphi(m)-1}\le\Phi_m(2)<2^{\varphi(m)+1}.
   \]
   This can slightly improve the ambient cyclotomic constant in finite
   estimates.  Theorem 1 counts many composite normalized cyclotomic
   values, and the discussion after the conditional section says that
   asymptotically almost all normalized values are not square-full.  The
   latter guarantees some non-repeated factor, not a weighted bound for
   all repeated exact-order factors.  It therefore does not prove
   (6.1)--(6.3).

2. Andrew Granville,
   [*Primitive prime factors in second-order linear recurrence sequences*](https://arxiv.org/html/1212.6306v1),
   arXiv:1212.6306v1.  Theorem 1 proves that \(2^n-1\) has a primitive prime
   factor of odd valuation for every \(n>1\), except \(n=6\).  The paper
   explicitly notes immediately before the theorem that it cannot prove
   valuation exactly one.  An odd valuation may be \(3,5,\ldots\), so the
   result supplies a primitive odd-valuation anchor but does not eliminate
   the deep arm \(G_d\), let alone its sum over a moving divisor window.

3. P. Erdős and M. Ram Murty, *On the order of a modulo p*, CRM Proc.
   Lecture Notes **19** (1999), 87--97.  Their almost-all-primes lower bound
   for multiplicative order is used explicitly in Section 3 of Pomerance's
   paper.  It concerns globally ordered primes without Wieferich weights.
   The exceptional set required here is selected simultaneously by
   \(\operatorname{ord}_p(2)\mid m\), a short co-divisor window, and
   \(p^2\mid2^{\operatorname{ord}_p(2)}-1\); the global almost-all theorem
   does not control that weighted intersection.

4. Nicolo Fellini and M. Ram Murty,
   [*Wieferich primes in number fields and the conjectures of
   Ankeny--Artin--Chowla and Mordell*](https://arxiv.org/abs/2508.08472),
   arXiv:2508.08472v2, final version (11 February 2026).  Their lower bound
   for non-Wieferich prime ideals is conditional either on Masser's
   number-field abc conjecture or on finiteness of super-Wieferich primes.
   Neither condition may be imported into an unconditional attempt to prove
   abc, and even the resulting count is not the localized weighted
   exact-order estimate in (6.1)--(6.3).

5. Daniel Falk, Cameron Harrington, and Lenny Jones,
   [*Generalized Wieferich primes and monogenic trinomials*](https://arxiv.org/html/2607.29329v1),
   arXiv:2607.29329v1 (31 July 2026).  Corollary 1.7 identifies, for bases
   \(2\) and \(3\), nonmonogenicity of a specified trinomial with the
   base-\(b\) Wieferich congruence.  This is a useful structural
   reformulation but supplies no density, multiplicity, or exact-order
   weighted bound.

The literature therefore supports the exact-order language, the ambient
cyclotomic size cap, and several structural or global-order facts.  It does
not currently close the localized repeated-mass gate isolated here.

## 9. Formalization boundary

The companion module
`Lean/IUTThreeClosures/MersenneFixedPolylogBlockMassTriage20260901.lean`
formalizes:

* the strict local and closed far actual block masses;
* their exact finite split and nonnegativity;
* the cyclotomic-cap comparison with the already formalized far totient
  mass;
* the generic and actual Mersenne little-oh equivalences;
* the finite three-arm subtraction theorem and its exact composition over
  the strict fixed-polylogarithmic divisor window;
* the transition-cardinality consequence and the exact examples proving the
  \(1/4\) and \(1/3\) algebraic ceilings.

The analytic Brun--Titchmarsh estimate (4.6) and the arithmetic realization
of the four terms in (4.5) remain in the preceding mathematical reports;
the new Lean module does not turn them into axioms.  Consequently every
formal theorem in the module has only proved repository inputs or explicit
finite ordered-ring hypotheses.
