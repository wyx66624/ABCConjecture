# Critical slow-slack compression of the two surviving Mersenne arms

**Author:** ChatGPT

**Date:** 1 September 2026

**Status:** unconditional localization and exact counterexample boundary;
the standard abc conjecture is neither proved nor disproved here.

## 1. Result and relation to the preceding gate

For an odd prime \(p\), retain the canonical data

\[
 d_p=\operatorname{ord}_p(2),\qquad
 w_p=v_p(2^{d_p}-1),\qquad
 r_p=\frac{p-1}{d_p}.
\tag{1.1}
\]

Write

\[
 L_m=\log\log(3m).
\tag{1.2}
\]

The preceding balanced-multiplier gate fixed \(\eta>0\), used

\[
 F_{m,\eta}=\log(3m)L_m^{1+\eta},\qquad
 H_{m,\eta}=\left\lfloor
   \sqrt{\frac{\log(3m)}{L_m^{1+\eta}}}
 \right\rfloor,
\tag{1.3}
\]

and left the high-multiplier deep arm (6.9) and the balanced one-copy arm
(6.10).  This note removes the fixed power of \(L_m\).

Call a positive function \(\sigma\) **slow-admissible** if, as \(m\to\infty\),

\[
 \sigma(m)\longrightarrow\infty,
 \qquad
 \frac{L_m\sigma(m)}{\log(3m)}\longrightarrow0.
\tag{1.4}
\]

Put

\[
 F_{m,\sigma}=\log(3m)L_m\sigma(m),\qquad
 H_{m,\sigma}=\left\lfloor
   \sqrt{\frac{\log(3m)}{L_m\sigma(m)}}
 \right\rfloor.
\tag{1.5}
\]

Condition (1.4) makes \(H_{m,\sigma}\to\infty\).  For \(d\mid m\), define

\[
\begin{aligned}
 U_d^{(\sigma)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge2\\
          p\le d^2/F_{m,\sigma}}}\log p,\\
 B_d^{(\sigma)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge2\\
          p>d^2/F_{m,\sigma}}}\log p,\\
 V_d^{(\sigma)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge3\\
          r_p<H_{m,\sigma}}}(w_p-2)\log p,\\
 G_d^{(\sigma)}(m)
 &=\sum_{\substack{d_p=d,\ w_p\ge3\\
          r_p\ge H_{m,\sigma}}}(w_p-2)\log p.
\end{aligned}
\tag{1.6}
\]

The decomposition is still exact:

\[
 a_d=U_d^{(\sigma)}(m)+B_d^{(\sigma)}(m)
       +V_d^{(\sigma)}(m)+G_d^{(\sigma)}(m).
\tag{1.7}
\]

The main theorem is the following simultaneous compression.

### Theorem 1.1 (critical slow-slack removal)

Let \(\sigma\) be slow-admissible.  For every fixed positive integer \(k\),

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d^{(\sigma)}(m)=o(m)
\tag{1.8}
\]

and

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}V_d^{(\sigma)}(m)=o(m).
\tag{1.9}
\]

If in addition

\[
 \sigma(m)=o(L_m^\eta)\quad\hbox{for every fixed }\eta>0,
\tag{1.10}
\]

then, for every fixed \(\eta>0\) and all sufficiently large \(m\),

\[
 B_d^{(\sigma)}(m)\le B_d^{(\eta)}(m),\qquad
 G_d^{(\sigma)}(m)\le G_d^{(\eta)}(m)
\tag{1.11}
\]

for every \(d\mid m\).  Thus both surviving supports are contained in
strictly narrower numerical cutoff regions than the corresponding
fixed-\(\eta\) supports.  The actual finite prime sets can of course coincide
when the newly removed band contains no prime.

An explicit choice is

\[
 \sigma_*(m)=\log(3+L_m).
\tag{1.12}
\]

It satisfies (1.4) and (1.10).  Consequently the new cutoff

\[
 F_{m,*}=\log(3m)L_m\log(3+L_m)
\tag{1.13}
\]

is smaller than \(F_{m,\eta}\) for every fixed \(\eta>0\), while

\[
 H_{m,*}=\left\lfloor
 \sqrt{\frac{\log(3m)}{L_m\log(3+L_m)}}
 \right\rfloor
\tag{1.14}
\]

is larger than \(H_{m,\eta}\), eventually by an unbounded factor.  Hence
Theorem 1.1 genuinely removes new portions of both (6.9) and (6.10); it is
not a change of notation.

## 2. One-copy estimate with a moving slack

Fix \(k\ge1\) and set

\[
 Q_m=(\log(3m))^k.
\tag{2.1}
\]

### Proposition 2.1 (slow-slack one-copy bound)

For every sufficiently large \(m\),

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d^{(\sigma)}(m)
 \le
 \frac{2m\log m}{F_{m,\sigma}}(1+kL_m).
\tag{2.2}
\]

#### Proof

Write \(q=m/d\).  The window condition gives \(q<Q_m\).  If \(p\) occurs
in \(U_d^{(\sigma)}(m)\), then \(p=1+d r_p\) and

\[
 r_p=\frac{p-1}{d}<\frac p d
       \le\frac d{F_{m,\sigma}}.
\tag{2.3}
\]

On a fixed exact-order fibre the positive integral multipliers are distinct.
There are therefore at most \(d/F_{m,\sigma}\) such primes.  Since
\(F_{m,\sigma}\ge1\) eventually, each such prime is at most \(d^2\le m^2\),
so

\[
 U_d^{(\sigma)}(m)
 \le\frac{2d\log m}{F_{m,\sigma}}.
\tag{2.4}
\]

Now sum over \(d=m/q\), enlarge the positive co-divisors to all integers
below \(Q_m\), and use the harmonic bound:

\[
 \sum U_d^{(\sigma)}(m)
 \le \frac{2m\log m}{F_{m,\sigma}}
       \sum_{q<Q_m}\frac1q
 \le \frac{2m\log m}{F_{m,\sigma}}(1+kL_m).
\tag{2.5}
\]

This proves (2.2).  After division by \(m\), its right side is

\[
 2\frac{\log m}{\log(3m)}
 \left(\frac1{L_m\sigma(m)}+\frac{k}{\sigma(m)}\right),
\tag{2.6}
\]

which tends to zero because \(\sigma(m)\to\infty\).  This proves (1.8).
\(\square\)

The key point in (2.6) is that no fixed power \(L_m^\eta\) is required.  A
single arbitrarily slowly divergent factor is enough.

## 3. Deep estimate with the same moving slack

Retain

\[
 C_Y=283\log3\log6.
\tag{3.1}
\]

Yamada's unconditional theorem gives, for every prime \(p\),

\[
 v_p(2^{p-1}-1)
 \le \left\lfloor C_Y\frac{p-1}{(\log p)^2}\right\rfloor+4.
\tag{3.2}
\]

Exact-order LTE transports this to the finite packet estimate already proved
in the preceding checkpoint: for \(d>1\) and integral \(H\ge2\),

\[
 \sum_{\substack{d_p=d,\ w_p\ge3\\r_p<H}}
 (w_p-2)\log p
 \le
 \frac{C_Yd}{\log d}\frac{H(H-1)}2
 +2(H-1)\log(1+dH).
\tag{3.3}
\]

### Proposition 3.1 (slow-slack low-depth bound)

For all sufficiently large \(m\), with \(H=H_{m,\sigma}\),

\[
\begin{aligned}
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}V_d^{(\sigma)}(m)
 \le{}&
 \frac{C_YmH(H-1)}{2\log(m/Q_m)}(1+kL_m)\\
 &+2H Q_m\log(1+mH).
\end{aligned}
\tag{3.4}
\]

#### Proof

Slow-admissibility gives \(H\to\infty\), so \(H\ge2\) eventually.  In the
window \(q=m/d<Q_m\), one has \(d>m/Q_m\).  Apply (3.3) fibre by fibre.  The
terms involving \(d/\log d\) satisfy

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
\tag{3.5}
\]

There are fewer than \(Q_m\) possible co-divisors and \(d\le m\), so the
remaining terms total at most

\[
 2H Q_m\log(1+mH).
\tag{3.6}
\]

This proves (3.4).  By the definition of \(H\),

\[
 H^2\le\frac{\log(3m)}{L_m\sigma(m)}.
\tag{3.7}
\]

Also \(\log(m/Q_m)=\log m-kL_m\sim\log m\).  After division by \(m\),
the first line of (3.4) is

\[
 O_k\!\left(
 \frac{1+kL_m}{L_m\sigma(m)}
 \right)=O_k(\sigma(m)^{-1})=o(1).
\tag{3.8}
\]

Eventually \(L_m\sigma(m)\ge1\), so \(H\le\sqrt{\log(3m)}\).  For fixed
\(k\), (3.6) is therefore

\[
 O_k\bigl((\log m)^{k+3/2}\bigr)=o(m).
\tag{3.9}
\]

Equations (3.8)--(3.9) prove (1.9).  \(\square\)

## 4. Strict compression against every fixed power

Assume (1.10), and fix \(\eta>0\).  Directly from the definitions,

\[
 \frac{F_{m,\sigma}}{F_{m,\eta}}
 =\frac{\sigma(m)}{L_m^\eta}\longrightarrow0.
\tag{4.1}
\]

Thus \(F_{m,\sigma}<F_{m,\eta}\) eventually, so

\[
 \frac{d^2}{F_{m,\sigma}}>
 \frac{d^2}{F_{m,\eta}}.
\tag{4.2}
\]

The one-copy support that remains above the first threshold is consequently
a subset of the support that remains above the second threshold.  This gives
the first inequality in (1.11).

Before taking floors, the ratio of multiplier cutoffs is

\[
 \frac{
 \sqrt{\log(3m)/(L_m\sigma(m))}}
 {
 \sqrt{\log(3m)/L_m^{1+\eta}}}
 =\sqrt{\frac{L_m^\eta}{\sigma(m)}}
 \longrightarrow\infty.
\tag{4.3}
\]

Both raw cutoffs tend to infinity, so (4.3) also implies
\(H_{m,\sigma}>H_{m,\eta}\) for all sufficiently large \(m\).  Hence the
high-multiplier support for \(\sigma\) is a subset of the old one, proving the
second inequality in (1.11).

For \(\sigma_*(m)=\log(3+L_m)\), the standard limits

\[
 \log(3+L_m)=o(L_m^\eta)\quad(\eta>0),
 \qquad
 L_m\log(3+L_m)=o(\log(3m))
\tag{4.4}
\]

verify every hypothesis.  In particular, the newly controlled bands are

\[
 \frac{d^2}{F_{m,\eta}}<p\le
 \frac{d^2}{F_{m,*}}
\tag{4.5}
\]

in the repeated one-copy arm and

\[
 H_{m,\eta}\le r_p<H_{m,*}
\tag{4.6}
\]

in the deep arm.  Their window sums are \(o(m)\), since they are differences
of nested nonnegative controlled sums.

## 5. New two-arm gate

Let

\[
 P_k(m)=\sum_{\substack{d\mid m\\
                 \log(m/d)<kL_m}}a_d.
\tag{5.1}
\]

### Theorem 5.1 (critical slow-slack alternative)

Suppose the Mersenne endpoint fails:

\[
 \log\frac{2^m-1}{\operatorname{rad}(2^m-1)}\ne o(m).
\tag{5.2}
\]

Let \(\sigma\) satisfy (1.4).  Then there are fixed \(k\ge1\),
\(\epsilon>0\), and an unbounded sequence \(m_j\) for which
\(P_k(m_j)\ge\epsilon m_j\).  For every fixed \(0<\gamma<1/2\), after
passing to a subsequence, one same alternative holds for all sufficiently
large \(j\):

1. **critical high-multiplier deep lifts**
   \[
    \sum_{\substack{d\mid m_j\\
       \log(m_j/d)<kL_{m_j}}}G_d^{(\sigma)}(m_j)
       \ge\gamma\epsilon m_j,
   \tag{5.3}
   \]
   and every counted multiplier satisfies
   \[
       r_p\ge H_{m_j,\sigma};
   \tag{5.4}
   \]

2. **critical near-square-root one-copy lifts**
   \[
    \sum_{\substack{d\mid m_j\\
       \log(m_j/d)<kL_{m_j}}}B_d^{(\sigma)}(m_j)
       \ge\gamma\epsilon m_j,
   \tag{5.5}
   \]
   and every counted prime satisfies
   \[
       d_p<\sqrt{p\log(3m_j)L_{m_j}\sigma(m_j)}.
   \tag{5.6}
   \]

#### Proof

The already formalized fixed-window equivalence supplies \(k\), \(\epsilon\),
and the sequence.  Sum (1.7) over the window.  Theorem 1.1 removes the \(U\)
and \(V\) sums, leaving

\[
 \sum G_d^{(\sigma)}(m_j)+\sum B_d^{(\sigma)}(m_j)
 \ge(\epsilon-o(1))m_j.
\tag{5.7}
\]

If both surviving sums were below \(\gamma\epsilon m_j\), their total would
be below \(2\gamma\epsilon m_j\), contradicting (5.7) for large \(j\).
Infinite pigeonhole fixes one arm on a subsequence.  Formula (5.4) is the
definition.  Finally, \(p>d_p^2/F_{m_j,\sigma}\) rearranges to (5.6).
\(\square\)

For the explicit choice (1.12), the surviving conditions become

\[
 r_p\ge
 \left\lfloor\sqrt{\frac{\log(3m)}
 {L_m\log(3+L_m)}}\right\rfloor
\tag{5.8}
\]

or

\[
 d_p<\sqrt{p\log(3m)L_m\log(3+L_m)}.
\tag{5.9}
\]

These replace every fixed \(L_m^\eta\) loss by one iterated logarithm.

## 6. Exact quadratic-character filter on multipliers

The slow-slack proof uses only injectivity.  Exact order supplies an additional
unconditional residue filter that is useful for subsequent refinements.

### Proposition 6.1 (Euler-character identity)

Let \(p\) be an odd prime, let \(d=\operatorname{ord}_p(2)\), and write
\(p-1=dr\).  Then

\[
 \left(\frac2p\right)=(-1)^r.
\tag{6.1}
\]

#### Proof

If \(d\) is odd, divisibility \(d\mid p-1\) forces \(r\) even.  Hence

\[
 2^{(p-1)/2}=2^{d(r/2)}\equiv1\pmod p.
\tag{6.2}
\]

If \(d\) is even, exactness of the order gives
\(2^{d/2}\not\equiv1\pmod p\), while its square is one.  In the field
\(\mathbb F_p\), whose characteristic is odd, the only roots of
\(X^2-1\) are \(1\) and \(-1\).  Therefore
\(2^{d/2}\equiv-1\pmod p\), and

\[
 2^{(p-1)/2}=(2^{d/2})^r\equiv(-1)^r\pmod p.
\tag{6.3}
\]

Euler's criterion proves (6.1).  \(\square\)

Combining (6.1) with the supplementary law

\[
 \left(\frac2p\right)=(-1)^{(p^2-1)/8}
\tag{6.4}
\]

and \(p\equiv1+dr\pmod8\) gives the complete allowed-residue table:

| \(d\bmod8\) | allowed \(r\bmod8\) |
|---:|:---|
| 0 | \(0,2,4,6\) |
| 1 | \(0,6\) |
| 2 | \(0,1,4,5\) |
| 3 | \(0,2\) |
| 4 | \(0,1,2,3,4,5,6,7\) |
| 5 | \(0,6\) |
| 6 | \(0,3,4,7\) |
| 7 | \(0,2\) |

This table follows by checking the 64 pairs modulo eight after imposing that
\(p\) is odd.  In particular, odd exact orders allow only two multiplier
classes modulo eight.  The class \(d\equiv4\pmod8\), however, has no
quadratic-character saving.

## 7. Counterexample search and exact retirement boundary

The arithmetic row

\[
 p=1093,\qquad d_p=364,\qquad
 1093^2\mid2^{364}-1,\qquad
 1093^3\nmid2^{364}-1,
\tag{7.1}
\]

has

\[
 r_p=\frac{1092}{364}=3.
\tag{7.2}
\]

Thus it is a full-premise counterexample to the proposed pointwise
strengthening

> every repeated base-two exact-order prime has even multiplier.

That exact assertion is retired.  The row lies in
\(d\equiv4\pmod8\), precisely the unrestricted line of the proven table, so
it does not refute Proposition 6.1 or either slow-slack estimate.  The second
known row \((p,d,r,w)=(3511,1755,2,2)\) lies in the allowed odd-order class.

The deterministic replay in
`research/computation/2026_09_01_mersenne_critical_slow_slack/` rechecks
primality, exact order, square divisibility, failure of cube divisibility,
the multiplier, the Euler-character identity, and the complete residue table.
It also scans every prime through \(100000\); the only base-two Wieferich
hits are \(1093\) and \(3511\).  This finite no-hit result says nothing about
the asymptotic arms and retires no further statement.

There is also a sharp abstract boundary at \(\sigma\equiv1\).  In one fibre,
take all labels \(r=1,\ldots,H-1\) and weights \(x_r=r\).  They satisfy
positivity, injectivity, the cutoff \(r<H\), and the pointwise affine envelope
\(x_r\le r\), but

\[
 \sum_{r=1}^{H-1}x_r=\frac{H(H-1)}2.
\tag{7.3}
\]

Across co-divisors \(q\le Q\), the weights \(x_{q,r}=r/q\) have total

\[
\frac{H(H-1)}2\sum_{q\le Q}\frac1q.
\tag{7.4}
\]

More precisely, this is a full-premise counterexample to the abstract claim
that every family with injective positive labels below \(H\) and pointwise
bounds \(0\le x_{q,r}\le r/q\) has total
\(o(H^2\sum_{q\le Q}1/q)\): the ratio in (7.4) tends to \(1/2\).
At the critical balance \(H^2\asymp\log m/L_m\), the harmonic factor in
(7.4) exactly removes the remaining \(L_m\) saving.  Hence positivity,
multiplier injectivity, and Yamada's pointwise affine envelope alone do not
prove the \(\sigma\equiv1\) little-oh statement.  This is a full-premise
counterexample to that *abstract inference*, not an exact-order prime packet
and not a counterexample to the arithmetic critical target.  The target with
\(\sigma=1\) remains active.

## 8. Primary-source audit and exact quantifiers

The source audit was refreshed on 1 September 2026.

1. **Yamada (2010).**  Theorem 1.2, equation (7), is pointwise and
   unconditional for every prime \(p\), and is exactly (3.2).  It supplies no
   density theorem.  Primary manuscript:
   [arXiv:math/0607072](https://arxiv.org/abs/math/0607072); published record:
   [Journal of Number Theory 130 (2010), 1889--1897](https://doi.org/10.1016/j.jnt.2010.02.018).

2. **Murty--S\'eguin (2019).**  Proposition 2.5 identifies the valuation of
   the unique exact-order cyclotomic factor.  Theorem 2.4 is a weighted
   Brun--Titchmarsh estimate with fixed \(\theta<1\), modulus
   \(d<x^\theta\), and sufficiently large \(x\).  Lemmas 4.2--4.3 give the
   exact square/higher-power Wieferich dictionary.  Their Theorem 1.1 assumes
   a uniform bound on all canonical valuations, and Theorem 4.1 assumes only
   finitely many super-Wieferich primes; neither hypothesis is available
   here.  Primary article:
   [author-hosted PDF](https://mast.queensu.ca/~murty/murty-seguin.pdf) and
   [DOI record](https://doi.org/10.1016/j.jnt.2019.02.016).

3. **Pomerance (2025).**  The primitive part of \(\Phi_d(2)\) is described
   exactly, and Theorem 1 proves that many such values are composite.  For
   \(d\equiv4\pmod8\) an Aurifeuillean factorization gives two factors of
   comparable square-root size.  None of these results bounds the repeated
   logarithmic mass in one exact-order fibre.  The stronger distinct-factor
   result, Theorem 2, assumes abc.  Primary manuscript:
   [author final PDF](https://math.dartmouth.edu/~carlp/cyclotomicprimesfinal.pdf);
   [DOI record](https://doi.org/10.1016/j.jnt.2025.02.013).

4. **Li--Zhao (2026).**  Their Theorem 1.1 first fixes a prime ideal
   \(\mathfrak p\) and a non-torsion \(\alpha\), and then produces an integer
   \(v=v(\mathfrak p,\alpha)\) such that the transition kernels have the
   stated periodic size for all \(r>v\).  In the unramified case this excludes
   higher Wieferich behavior only beyond that prime-dependent initial depth.
   It gives no uniform estimate as the rational prime varies.  Primary
   manuscript: [arXiv:2601.12753v1](https://arxiv.org/abs/2601.12753v1).

5. **Fellini--Murty (2026).**  Their introduction explicitly records that no
   unconditional almost-all non-Wieferich theorem is known for a fixed
   integral base.  Their quantitative conclusions use either number-field
   abc or finiteness of the relevant super-Wieferich primes, and so cannot be
   inserted into an unconditional abc proof.  Primary preprint:
   [arXiv:2508.08472v2](https://arxiv.org/abs/2508.08472v2); published record:
   [Journal of Number Theory 285 (2026), 209--229](https://doi.org/10.1016/j.jnt.2026.01.002).

6. **Erd\H{o}s--Murty and large-sieve Fermat-quotient work.**  The former is
   an almost-all-primes, unweighted order lower bound after one prescribes a
   function \(\epsilon(p)\to0\).  Shparlinski's Fermat-quotient estimates
   average over the base variable, and sometimes also over primes.  Neither
   controls the fixed base \(2\), exact-order, square-divisible intersection
   in (5.3)--(5.5).  Primary records:
   [Erd\H{o}s--Murty author scan](https://mast.queensu.ca/~murty/erdos-ram.pdf)
   and [Shparlinski arXiv:1104.3909](https://arxiv.org/abs/1104.3909).

No audited source supplies (6.9), (6.10), or the \(\sigma=1\) endpoint.  The
new result uses only Yamada's pointwise theorem, exact-order LTE, multiplier
injectivity, and elementary asymptotics.

## 9. Formalization boundary

The companion module
`IUTThreeClosures/MersenneCriticalSlowSlackGate20260901.lean` is written only
after the proofs above.  It formalizes:

1. monotone shrinkage of high-multiplier and above-size surviving supports;
2. monotonicity of their nonnegative weighted masses;
3. the exact real-algebra balance between the cutoff product
   \(A L\sigma\) and the squared multiplier scale \(A/(L\sigma)\);
4. comparison of two slack parameters;
5. the finite four-arm ledger after the two larger controlled supports are
   removed;
6. the exact Euler half-power and Legendre-character core on an actual
   exact-order prime fibre;
7. quadratic saturation of the abstract multiplier packet; and
8. the actual \(1093\) repeated exact-order, odd-multiplier counterexample.

The real logarithmic limits, Yamada's analytic theorem, and the moving
arithmetic mass definitions remain paper mathematics.  They are not inserted
as axioms.  The module contains no `sorry`, `admit`, custom axiom, or asserted
open estimate.
