# Balanced multiplier energy and a sharper two-arm Mersenne gate

**Author:** ChatGPT

**Date:** 1 September 2026

**Status:** unconditional localization theorem and exact counterexamples;
the standard abc conjecture is neither proved nor disproved here.

## 1. Main result

For an odd prime $p$, write

\[
 d_p=\operatorname{ord}_p(2),\qquad
 w_p=v_p(2^{d_p}-1),\qquad
 r_p=\frac{p-1}{d_p}.
\tag{1.1}
\]

The multiplier $r_p$ is a positive integer, $p=1+d_pr_p$, and it is
injective on every fixed exact-order fibre.  Let

\[
 a_d=\sum_{d_p=d}(w_p-1)\log p
\tag{1.2}
\]

be the canonical exact-order loss.  The preceding checkpoint used the cutoff
$d^2/(\log(3m)(\log\log(3m))^2)$ and left two arms: the deep valuation
excess and repeated primes just beyond that cutoff.

This note sharpens the deep localization and gives a one-parameter family of
one-copy localizations.  Fix $k\in\mathbb Z_{>0}$ and a real $\eta>0$, and put

\[
 L_m=\log\log(3m),\qquad
 F_{m,\eta}=\log(3m)L_m^{1+\eta},\qquad
 H_{m,\eta}=\left\lfloor
   \sqrt{\frac{\log(3m)}{L_m^{1+\eta}}}
 \right\rfloor .
\tag{1.3}
\]

For $d\mid m$, split the one-copy repeated support into

\[
\begin{aligned}
 U_d^{(\eta)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge2\\
              p\le d^2/F_{m,\eta}}}\log p,\\
 B_d^{(\eta)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge2\\
              p>d^2/F_{m,\eta}}}\log p,
\end{aligned}
\tag{1.4}
\]

and split the deep excess by multiplier:

\[
\begin{aligned}
 V_d^{(\eta)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge3\\
              r_p<H_{m,\eta}}}(w_p-2)\log p,\\
 G_d^{(\eta)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge3\\
              r_p\ge H_{m,\eta}}}(w_p-2)\log p.
\end{aligned}
\tag{1.5}
\]

Prime by prime,

\[
 a_d=U_d^{(\eta)}(m)+B_d^{(\eta)}(m)
       +V_d^{(\eta)}(m)+G_d^{(\eta)}(m).
\tag{1.6}
\]

The two new unconditional estimates are

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d^{(\eta)}(m)=o(m)
\tag{1.7}
\]

and

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}V_d^{(\eta)}(m)=o(m).
\tag{1.8}
\]

Estimate (1.7) replaces the one-copy denominator $\log(3m)L_m^2$ by
$\log(3m)L_m^{1+\eta}$ for every fixed $\eta>0$.  This is a strict
improvement of the cutoff when $0<\eta<1$, recovers the old scale at
$\eta=1$, and remains a valid, weaker localization when $\eta>1$.
Estimate (1.8) is new in kind: it removes from the deep arm every multiplier below the growing scale
$H_{m,\eta}$.  Its input is Tomohiro Yamada's unconditional explicit upper
bound for $v_p(2^{p-1}-1)$, combined with triangular multiplier energy.

Consequently, failure of the Mersenne endpoint forces one of only two
surviving arms on a subsequence:

* linear deep mass on primes with $r_p\ge H_{m,\eta}\to\infty$; or
* linear repeated one-copy mass on primes satisfying
  \[
       d_p<\sqrt{pF_{m,\eta}}
       =\sqrt{p\log(3m)L_m^{1+\eta}}.
  \tag{1.9}
  \]

The route is not closed: neither surviving arm is presently known to be
$o(m)$.  The theorem strictly narrows both arms without assuming abc, a
Wieferich-density conjecture, or a hidden order-distribution estimate.

## 2. The adaptive one-copy cutoff

### Proposition 2.1 (arbitrarily small fixed log-log slack)

For every fixed $k\ge1$ and $\eta>0$, and all sufficiently large $m$,

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d^{(\eta)}(m)
 \le
 \frac{2m\log m}{F_{m,\eta}}(1+kL_m).
\tag{2.1}
\]

In particular, the left side is $O_{k,\eta}(m/L_m^\eta)=o(m)$.

#### Proof

Write $q=m/d$.  The window condition is equivalent to

\[
 q<(\log(3m))^k.
\tag{2.2}
\]

If $p$ occurs in $U_d^{(\eta)}(m)$, then
$p=1+dr_p$ and

\[
 r_p=\frac{p-1}{d}<\frac p d
       \le\frac d{F_{m,\eta}}.
\tag{2.3}
\]

The multipliers are distinct positive integers.  Hence there are at most
$d/F_{m,\eta}$ such primes.  For sufficiently large $m$,
$F_{m,\eta}\ge1$; consequently $p\le d^2\le m^2$ and
$\log p\le2\log m$.  Thus

\[
 U_d^{(\eta)}(m)
 \le \frac{2d\log m}{F_{m,\eta}}.
\tag{2.4}
\]

Summing with $d=m/q$ and enlarging from divisors to all positive integers
below $(\log(3m))^k$ gives

\[
\begin{aligned}
 \sum U_d^{(\eta)}(m)
 &\le \frac{2m\log m}{F_{m,\eta}}
       \sum_{\substack{q\mid m\\q<(\log(3m))^k}}\frac1q\\
 &\le \frac{2m\log m}{F_{m,\eta}}(1+kL_m),
\end{aligned}
\tag{2.5}
\]

which is (2.1).  After division by $m$, the last expression is at most

\[
 2\frac{\log m}{\log(3m)}
 \frac{1+kL_m}{L_m^{1+\eta}}\longrightarrow0.
\tag{2.6}
\]

This proves the proposition.  $\square$

The previous denominator $\log(3m)L_m^2$ is the special case $\eta=1$.
Proposition 2.1 permits every fixed positive $\eta$, so the multiplier-only
argument approaches the critical denominator $\log(3m)L_m$ from above.
At $\eta=0$, (2.6) gives only an $O_k(1)$ normalized bound.  This failure of
the estimate is not a counterexample to the actual arithmetic statement, so
the critical route remains open.

## 3. Yamada's depth envelope

Set

\[
 C_Y=283\log3\log6.
\tag{3.1}
\]

Yamada's Theorem 1.2, equation (7), states for every prime $p$ that

\[
 v_p(2^{p-1}-1)
 \le
 \left\lfloor C_Y\frac{p-1}{(\log p)^2}\right\rfloor+4.
\tag{3.2}
\]

The paper is a published unconditional $p$-adic logarithm estimate.  Its
constant is large, but only its asymptotic dependence on $p$ matters here.

### Lemma 3.1 (exact-order Yamada envelope)

Let $p$ be an odd prime, $d=d_p$, $r=r_p$, and $w=w_p$, and suppose
$w\ge2$.  Then

\[
 (w-2)\log p
 \le C_Y\frac{dr}{\log p}+2\log p.
\tag{3.3}
\]

In particular, if $d>1$ and $r<H$, then

\[
 (w-2)\log p
 \le C_Y\frac{dr}{\log d}+2\log(1+dH).
\tag{3.4}
\]

#### Proof

Exact order gives $p-1=dr$.  Since $0<r<p$, one has $p\nmid r$.  Applying
LTE to $(2^d)^r-1$ gives

\[
 v_p(2^{p-1}-1)
 =v_p(2^{dr}-1)
 =v_p(2^d-1)+v_p(r)=w.
\tag{3.5}
\]

Insert (3.5) into (3.2), discard the floor, subtract two, and multiply by
$\log p>0$.  As $p-1=dr$, this gives (3.3).  Finally $p>d$ gives
$\log p>\log d$, while $p=1+dr<1+dH$ when $r<H$.  These two comparisons
give (3.4).  $\square$

The $O(p/\log^2p)$ valuation bound is much too large to control an arbitrary
exact-order fibre by itself.  The useful feature is its linear dependence on
$p-1=dr$ after multiplication by $\log p$.  Multiplier injectivity then
turns the sum of $r$ into a triangular number.

## 4. Triangular multiplier energy

### Lemma 4.1 (positive injective labels)

Let $S$ be a finite set and let $r:S\to\mathbb Z_{>0}$ be injective with
$r(x)<H$ for every $x\in S$, where $H$ is a positive integer.  Then

\[
 |S|\le H-1,
 \qquad
 \sum_{x\in S}r(x)\le\frac{H(H-1)}2.
\tag{4.1}
\]

#### Proof

The image is a subset of $\{1,2,\ldots,H-1\}$.  The cardinality statement is
immediate, and summing the image is maximized by the full set, whose sum is
$H(H-1)/2$.  $\square$

For an exact-order fibre, Lemma 4.1 applies because $p\mapsto r_p$ is
injective and positive.  Combining it with (3.4) gives the following exact
finite estimate.

### Proposition 4.2 (low-multiplier deep packet)

For $d>1$ and an integer $H\ge2$, define

\[
 V_d(H)=\sum_{\substack{d_p=d,\ w_p\ge3\\r_p<H}}
               (w_p-2)\log p.
\tag{4.2}
\]

Then

\[
 V_d(H)
 \le
 \frac{C_Yd}{\log d}\frac{H(H-1)}2
 +2(H-1)\log(1+dH).
\tag{4.3}
\]

#### Proof

Apply (3.4) to each prime in (4.2).  The primes form a subset of the
exact-order fibre, so their positive multipliers are distinct.  Lemma 4.1
bounds the sum of those multipliers by $H(H-1)/2$ and their number by
$H-1$.  Summing (3.4) proves (4.3).  $\square$

The quadratic dependence on $H$ is intrinsic to these displayed premises.
For every integer $H\ge1$, the complete packet
$S_H=\{1,\ldots,H-1\}$ is injective and positive, all its labels are below
$H$, and

\[
 \sum_{r\in S_H}r=\frac{H(H-1)}2.
\tag{4.4}
\]

If a fixed constant $C$ satisfied $\sum r\le CH$ for every such packet,
choose an integer $H>2C+1$; then (4.4) gives
$H(H-1)/2>CH$, a contradiction.  Thus injectivity and a pointwise linear
envelope alone do not yield a uniform $O(H)$ energy bound.  The member
$H=4$ already refutes the coefficient-one inequality $\sum r\le H$ because
$1+2+3=6>4$.  This parameterized family has every displayed algebraic
premise, but it is not a Mersenne prime packet.

## 5. Window summation of the low deep arm

### Theorem 5.1 (low-multiplier deep removal)

For every fixed $k\ge1$ and $\eta>0$,

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}V_d^{(\eta)}(m)=o(m).
\tag{5.1}
\]

More explicitly, put

\[
 Q_m=(\log(3m))^k,\qquad H=H_{m,\eta}.
\tag{5.2}
\]

For all sufficiently large $m$,

\[
\begin{aligned}
 \sum V_d^{(\eta)}(m)
 \le{}&
 \frac{C_YmH(H-1)}{2\log(m/Q_m)}(1+kL_m)\\
 &+2H Q_m\log(1+mH).
\end{aligned}
\tag{5.3}
\]

#### Proof

In the fixed window, write again $q=m/d$.  Then $q<Q_m$, so
$d>m/Q_m$.  In particular, $d>1$ and
$\log d\ge\log(m/Q_m)>0$ for all sufficiently large $m$.
Apply Proposition 4.2 with the common integer threshold $H$ and sum over the
window.  For the first term,

\[
\begin{aligned}
 \sum_{\substack{d\mid m\\q<Q_m}}
   \frac{C_YdH(H-1)}{2\log d}
 &\le
 \frac{C_YmH(H-1)}{2\log(m/Q_m)}
   \sum_{\substack{q\mid m\\q<Q_m}}\frac1q\\
 &\le
 \frac{C_YmH(H-1)}{2\log(m/Q_m)}(1+kL_m).
\end{aligned}
\tag{5.4}
\]

There are fewer than $Q_m$ positive integral co-divisors in the window, and
$d\le m$.  The second term in (4.3) therefore has total at most

\[
 2H Q_m\log(1+mH).
\tag{5.5}
\]

Equations (5.4)--(5.5) prove (5.3).

By definition,

\[
 H^2\le\frac{\log(3m)}{L_m^{1+\eta}}.
\tag{5.6}
\]

Moreover,
$\log(m/Q_m)=\log m-kL_m\sim\log m$.  After division by $m$, the first
line of (5.3) is therefore

\[
 O_k\!\left(\frac{1+L_m}{L_m^{1+\eta}}\right)
 =O_k(L_m^{-\eta})=o(1).
\tag{5.7}
\]

The second line is a fixed power of $\log m$ times a power of $L_m^{-1}$;
it is $o(m)$.  This proves (5.1).  $\square$

The same slack $L_m^\eta$ balances the two elementary losses: the normalized
one-copy estimate (2.6) and the normalized triangular-depth estimate (5.7)
are both $O_k(L_m^{-\eta})$.

## 6. The refined two-arm obstruction

Let

\[
 P_k(m)=\sum_{\substack{d\mid m\\
                 \log(m/d)<kL_m}}a_d.
\tag{6.1}
\]

The preceding formalized gate proves that the Mersenne endpoint is equivalent
to $P_k(m)=o(m)$ for every fixed positive integer $k$.

### Theorem 6.1 (balanced high-multiplier alternative)

Suppose

\[
 \log\frac{2^m-1}{\operatorname{rad}(2^m-1)}\ne o(m).
\tag{6.2}
\]

Fix any $\eta>0$.  Then there are fixed $k\ge1$, $\epsilon>0$, and an
unbounded sequence $m_j$ for which $P_k(m_j)\ge\epsilon m_j$.  For every
fixed $0<\gamma<1/2$, after passing to a subsequence, one same alternative
holds for all sufficiently large $j$:

1. **high-multiplier deep lifts**
   \[
    \sum_{\substack{d\mid m_j\\
       \log(m_j/d)<kL_{m_j}}}G_d^{(\eta)}(m_j)
       \ge\gamma\epsilon m_j,
   \tag{6.3}
   \]
   where every counted prime satisfies
   \[
      r_p\ge H_{m_j,\eta},\qquad
      p\ge1+d_pH_{m_j,\eta};
   \tag{6.4}
   \]

2. **balanced near-square-root small order**
   \[
    \sum_{\substack{d\mid m_j\\
       \log(m_j/d)<kL_{m_j}}}B_d^{(\eta)}(m_j)
       \ge\gamma\epsilon m_j,
   \tag{6.5}
   \]
   where every counted prime satisfies
   \[
       d_p<\sqrt{p\log(3m_j)L_{m_j}^{1+\eta}}.
   \tag{6.6}
   \]

#### Proof

The contrapositive of the fixed-window equivalence supplies $k$, $\epsilon$,
and $m_j$.  Sum the exact decomposition (1.6) over that window.  Proposition
2.1 and Theorem 5.1 remove the $U$ and $V$ sums as $o(m_j)$, leaving

\[
 \sum G_d^{(\eta)}(m_j)+\sum B_d^{(\eta)}(m_j)
 \ge(\epsilon-o(1))m_j.
\tag{6.7}
\]

If both surviving sums were less than $\gamma\epsilon m_j$, their total
would be less than $2\gamma\epsilon m_j$, contradicting (6.7) for large $j$.
Infinite pigeonhole fixes one arm on a subsequence.  Condition (6.4) is the
definition of the high deep arm together with $p=1+d_pr_p$.  For the second
arm, $p>d_p^2/F_{m_j,\eta}$ rearranges to (6.6).  $\square$

The coefficient one half remains exact at the algebraic level.  Under every
displayed nonnegative mass premise after the two controlled arms vanish,

\[
 (\text{target},U,V,G,B)=(2,0,0,1,1)
\tag{6.8}
\]

defeats both conclusions with any coefficient strictly larger than one half.
This counterexample closes only a stronger coefficient claim.

### Corollary 6.2 (remaining unconditional closure targets)

For one fixed $\eta>0$, it is enough to prove, for every fixed $k\ge1$,

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}G_d^{(\eta)}(m)=o(m)
\tag{6.9}
\]

and

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}B_d^{(\eta)}(m)=o(m).
\tag{6.10}
\]

These are actual arithmetic statements, not Lean assumptions.  Current
literature does not prove either estimate.

## 7. Counterexample pressure and route-retirement boundary

The sealed base-two scan already proves

\[
 \operatorname{ord}_{3511}(2)=1755,\qquad
 v_{3511}(2^{1755}-1)=2,\qquad
 \frac{3511-1}{1755}=2.
\tag{7.1}
\]

Thus $3511$ is a complete full-premise counterexample to the universal
finite assertion

> every repeated base-two exact-order prime has multiplier at least three.

Likewise $1093$ has exact order $364$, depth two, and multiplier three.  These
rows show that small multipliers really occur and justify proving an
aggregate little-oh theorem rather than deleting the range pointwise.  They
do not refute (1.7) or (1.8): both are finite rows and neither is deep.

The complete family $S_H=\{1,\ldots,H-1\}$ closes the attempted *algebraic*
replacement of triangular energy by a uniform linear-$H$ bound; the member
$H=4$ separately closes the coefficient-one bound.  These are not
exact-order prime packets.  The mass assignment (6.8) closes coefficients
greater than one half from the two-arm ledger alone.  No actual
counterexample to (6.9) or (6.10) is known, so both arithmetic routes remain
active.  Finite absence of super-Wieferich primes is not used as evidence
for an asymptotic assertion.

## 8. Primary-literature audit and exact quantifiers

1. **Yamada (2010).**  Theorem 1.2 is unconditional and pointwise for every
   prime $p$; equation (7) is exactly (3.2).  It is an upper bound on the
   valuation, not a density theorem.  The published record is
   [Journal of Number Theory 130 (2010), 1889--1897](https://doi.org/10.1016/j.jnt.2010.02.018),
   and the primary manuscript is
   [arXiv:math/0607072](https://arxiv.org/abs/math/0607072).

2. **Erdős--Murty (1999).**  For each prescribed positive function
   $\epsilon(p)\to0$, all but $o(x/\log x)$ primes $p\le x$ satisfy
   \[
       \operatorname{ord}_p(2)
       \ge p^{1/(2+\epsilon(p))}.
   \tag{8.1}
   \]
   The exceptional set depends on the prescribed function.  This global,
   unweighted statement does not bound the fixed-window intersection with
   $p^2\mid2^{d_p}-1$.

3. **Murty--Séguin (2019).**  Their valuation dictionary identifies the
   unique exact-order cyclotomic value carrying $p^j$ and their weighted
   Brun--Titchmarsh theorem controls the initial prime range.  It does not
   bound the high multipliers or the deep valuation sum in (6.9).

4. **Li--Zhao (2026).**  Their Theorem 1.1 says that for each *fixed* prime
   ideal and fixed non-torsion $\alpha$, the kernels between successive
   prime-power levels eventually have a prescribed periodic size; in the
   unramified case, the prime is not $\alpha$-Wieferich at sufficiently high
   levels.  The threshold $v$ depends on the prime ideal and on $\alpha$.
   For $K=\mathbb Q$ this describes stabilization after the initial
   valuation; it gives no bound uniform in the varying rational prime $p$
   and therefore does not imply (6.9).  Primary record:
   [arXiv:2601.12753v1](https://arxiv.org/abs/2601.12753v1).

5. **Shparlinski (2011).**  The large-sieve results average Fermat quotient
   values over intervals of the *base variable* and, in some statements,
   over primes.  They do not specialize to a fixed base $2$ with the
   simultaneous exact-order, divisor-window, and square-divisibility
   restrictions here.  Primary record:
   [arXiv:1104.3909](https://arxiv.org/abs/1104.3909).

6. **Fellini--Murty (2026).**  Their quantitative non-Wieferich conclusions
   require either Masser's number-field abc conjecture or finiteness of the
   relevant super-Wieferich primes.  Neither may enter an unconditional abc
   proof, and their lower count does not give the weighted localized upper
   bounds (6.9)--(6.10).

The local source archive for the two newly used 2026/valuation papers is
`research/sources/mersenne_balanced_multiplier_depth_2026_09_01/`.  The
earlier primary copies of Erdős--Murty, Murty--Séguin, Pomerance, and
Fellini--Murty remain in
`research/sources/mersenne_prime_layer_radical_2026_09_01/`.

## 9. Formalization boundary

The companion Lean module
`IUTThreeClosures/MersenneBalancedMultiplierDepthLocalization20260901.lean`
formalizes, after the mathematical proofs above:

1. the triangular sum of injective multipliers below a finite threshold;
2. the sharpened positive-label cardinality $H-1$;
3. the exact LTE transport from the Fermat exponent $p-1$ to the canonical
   exact-order valuation;
4. the finite affine-envelope weighted-mass inequality;
5. those bounds on the actual exact-order fibre;
6. composition of two controlled arms with the two surviving arms;
7. the sharp coefficient counterexample, the complete triangular-energy
   family, and failure of every fixed natural linear coefficient; and
8. the actual prime/order/square-divisibility/multiplier-two certificate at
   $3511$, including formal negation of the overstrong multiplier-three
   assertion.

Yamada's $p$-adic logarithm theorem, real logarithmic asymptotics, the
arithmetic definitions of the moving $U,V,G,B$ masses, and subsequence
extraction remain paper mathematics.  They are not inserted into Lean as
axioms.  Direct compilation with `-DwarningAsError=true` reports only
`propext`, `Classical.choice`, and `Quot.sound` for every printed theorem.
