# Canonical gain surfaces and defect flags for primitive abc triples

**Author:** ChatGPT  
**Date:** 3 September 2026  
**Status:** unconditional structural checkpoint; the standard abc conjecture remains open in both directions.

## 1. Purpose and source boundary

Müller and Taktikos introduce an *approximation gain* and a *power gain* for
abc equations arising from rational approximations to algebraic roots. Their
paper suggests attacking abc by bounding the two gains separately. The
primary source fixed for this audit is arXiv:2601.11376v2; immutable hashes and
a searchable extraction are in
`research/sources/abc_gain_surface_2026_09_03/`.

The useful algebraic idea is an exact factorization of a height-to-radical
ratio through an intermediate scale. A fixed bound for each factor, however,
does not by itself give the quantifier and coefficient required by the
standard abc conjecture. This note isolates the exact missing correlation and
then chooses the canonical intermediate scale $N=abc$. The resulting
two-dimensional gain surface has a universal open corridor, and its additive
coordinates extend to an arbitrary-dimensional defect flag.

No theorem from the source is imported as an axiom. In particular, the
arguments below do not depend on the printed claims concerning all continued
fraction convergents.

## 2. Source audit

Three distinctions are needed before using the proposed gain split.

1. On page 13, Definition 2.6 prints, in the $d_n>0$ case, the numerator
   $\log(q_n^s k)$. The proof of Theorem 2.7 on the same page instead uses
   $\log(p_n^3)$. For $p_n^3=kq_n^3+d_n$ with $d_n>0$, the latter is the
   logarithm of the height of the associated abc triple. The two displayed
   definitions are not identical. This checkpoint therefore defines its own
   height factor explicitly.
2. The printed proof of Theorem 2.8 passes from a one-sided asymptotic upper
   estimate to a claimed limiting equality and then invokes a finite check
   below an unspecified index $N$. That text is not, on its own, a
   reproducible proof of the theorem. This observation does not assert that
   the theorem is false.
3. If $q=AP$, bounds $A\le A_0$ and $P\le P_0$ yield only
   $q\le A_0P_0$. The proposed constants $A_0=3/2$ and $P_0=3$ give
   $q\le 9/2$, a fixed weak exponent. Standard abc requires an eventual
   coefficient $1+\varepsilon$ for every $\varepsilon>0$, with an additive
   constant in logarithmic form. A correlation barrier, rather than two
   unrelated fixed bounds, is therefore necessary.

The third point is a logical audit of the strategy. It does not refute a
domain-specific theorem that supplies additional correlation.

## 3. The gain surface

Let $H,N,R>1$, and put

\[
 h=\log H,\qquad n=\log N,\qquad r=\log R.
\]

Define

\[
 q(H,R)=\frac{h}{r},\qquad
 A(H,N)=\frac{h}{n},\qquad
 P(N,R)=\frac{n}{r}.
\]

### Proposition 3.1 (exact gain surface)

For $H,N,R>1$,

\[
 \boxed{q(H,R)=A(H,N)P(N,R).}
\]

**Proof.** Both $n$ and $r$ are positive. Cancelling $n$ gives

\[
 \frac{h}{n}\frac{n}{r}=\frac{h}{r}.
\]

The identity is exact for every intermediate scale $N$; it contains no
arithmetic estimate. $\square$

The level set $q=1+\varepsilon$ is the hyperbola
$AP=1+\varepsilon$ in gain coordinates. An axis-aligned rectangle
$A\le A_0$, $P\le P_0$ stays below this hyperbola only when
$A_0P_0\le 1+\varepsilon$.

### Proposition 3.2 (complete scale countermodel to independent bounds)

There exist $1<R<H<N$ such that

\[
 A(H,N)<\frac32,\qquad P(N,R)<3,
 \qquad q(H,R)>\frac32.
\]

**Proof.** Take $R=4$, $H=16$, $N=32$, and write $L=\log 2>0$. Then

\[
 r=2L,\quad h=4L,\quad n=5L,
\]

so

\[
 A=\frac45<\frac32,\qquad
 P=\frac52<3,\qquad
 q=2>\frac32.
\]

All positivity and ordering premises hold. This is an exact counterexample
to the abstract implication from the two separate bounds, not an abc triple
and not an abc counterexample. $\square$

## 4. Canonical arithmetic gain coordinates

Let $a,b,c$ be pairwise coprime positive integers satisfying $a+b=c$, and
assume $a,b>1$. Put

\[
 M=abc,\qquad R=\operatorname{rad}(abc),\qquad
 h=\log c,\quad m=\log M,\quad r=\log R.
\]

The **canonical approximation gain** and **canonical power gain** are

\[
 A_{\rm can}=\frac{h}{m},\qquad
 P_{\rm can}=\frac{m}{r}.
\]

The standard quality is $q_{\rm abc}=h/r$.

### Lemma 4.1 (strict product corridor)

For every primitive nonunit abc triple,

\[
 \boxed{c^2<abc<c^3.}
\]

**Proof.** Since $a,b>1$ and $\gcd(a,b)=1$, the pair cannot be
$(2,2)$. Thus at least one of $a-1,b-1$ is at least $2$, while the
other is at least $1$. Hence

\[
 (a-1)(b-1)>1.
\]

Expanding and using $a+b=c$ gives $ab-c>0$, so $c<ab$. Multiplication
by $c>0$ proves $c^2<abc$. Also $a<c$ and $b<c$, whence
$ab<c^2$; multiplying by $c$ gives $abc<c^3$. $\square$

### Theorem 4.2 (canonical gain corridor)

For every primitive nonunit abc triple,

\[
 \boxed{\frac13<A_{\rm can}<\frac12},\qquad
 \boxed{q_{\rm abc}=A_{\rm can}P_{\rm can}},
\]

and consequently

\[
 \boxed{\frac13P_{\rm can}<q_{\rm abc}<\frac12P_{\rm can}}.
\]

**Proof.** Lemma 4.1 and monotonicity of the logarithm give

\[
 2h<m<3h.
\]

Here $h,m,r>0$: $c>1$, $M>1$, and $R>1$. Dividing the two strict
inequalities by the positive quantity $m$ yields
$1/3<h/m<1/2$. Proposition 3.1 with
$H=c$, $N=M$, and $R=\operatorname{rad}(M)$ gives the factorization.
Finally $P_{\rm can}>0$, so multiplication of the gain corridor by
$P_{\rm can}$ preserves both strict inequalities. $\square$

### Corollary 4.3 (necessary power concentration for a transgression)

For $\varepsilon>-1$, if

\[
 q_{\rm abc}\ge 1+\varepsilon,
\]

then

\[
 \boxed{P_{\rm can}>2(1+\varepsilon).}
\]

Conversely, the bound

\[
 P_{\rm can}\le 2(1+\varepsilon)
\]

implies $q_{\rm abc}<1+\varepsilon$.

**Proof.** The upper corridor in Theorem 4.2 gives
$q_{\rm abc}<P_{\rm can}/2$. Both assertions follow by transitivity.
$\square$

This is the canonical coefficient-two gate already visible from symmetric
product estimates, now expressed as a factor on an exact gain surface. The
gain formulation additionally exposes the correlation term below.

## 5. Linearized defect coordinates

Define the normalized **power excess** and **approximation slack**

\[
 X=\frac{m-r}{r},\qquad
 Y=\frac{m-h}{r}.
\]

Both are nonnegative in the canonical setting. The hyperbolic gain surface
becomes an affine plane.

### Theorem 5.1 (exact cancellation identity)

\[
 \boxed{q_{\rm abc}=1+X-Y.}
\]

**Proof.** Direct subtraction gives

\[
 1+X-Y
 =1+\frac{m-r}{r}-\frac{m-h}{r}
 =\frac{h}{r}.
\]
$\square$

Thus the standard logarithmic abc inequality

\[
 h\le (1+\varepsilon)r+C
\]

is equivalent to the correlation barrier

\[
 \boxed{X-Y\le\varepsilon+\frac{C}{r}.}
\]

The large repeated-prime mass $X$ is harmless when it is compensated by the
product-to-height slack $Y$. Bounding $X$ and $Y$ independently by
fixed constants discards precisely this cancellation.

## 6. Higher-dimensional defect flags

Choose any finite chain of positive logarithmic scales

\[
 r=s_0,s_1,\ldots,s_k=m
\]

and define its local defect increments

\[
 d_i=s_i-s_{i-1}\quad(1\le i\le k).
\]

The chain may separate prime-exponent depth, congruence packets, local
heights, archimedean costs, or other arithmetic mechanisms. It is called a
**defect flag**. Unlike a verbal decomposition, it has an invariant total.

There is a small but useful algebraic structure behind this definition. Let

\[
 \delta(x,y)=y-x.
\]

Regarding real scale coordinates as the objects of the pair groupoid,
$\delta$ is an additive $1$-cocycle:

\[
 \delta(x,x)=0,\qquad
 \delta(x,z)=\delta(x,y)+\delta(y,z).
\]

Likewise, on nonzero coordinates,

\[
 g(x,y)=\frac{y}{x}
\]

is a multiplicative cocycle:

\[
 g(x,x)=1,\qquad g(x,z)=g(x,y)g(y,z).
\]

Both identities follow by cancellation. Thus a defect flag is a path in a
scale groupoid, its additive cost is the integral of an exact cocycle, and its
gain is the corresponding multiplicative transport. The resulting holonomy
around every closed flag is trivial. This is more than terminology: it proves
that inserting intermediate theories or invariants cannot change the endpoint
defect unless those theories restrict which arithmetic paths are admissible.
The needed abc input must therefore be an arithmetic path constraint or a
cost bound, rather than the existence of a finer factorization alone.

### Proposition 6.1 (flag path independence)

For every finite defect flag,

\[
 \boxed{\sum_{i=1}^k d_i=m-r}
\]

and therefore

\[
 \boxed{q_{\rm abc}
 =1+\frac{\sum_i d_i-(m-h)}{r}.}
\]

**Proof.** The first identity is the telescoping sum

\[
 (s_1-s_0)+(s_2-s_1)+\cdots+(s_k-s_{k-1})=s_k-s_0=m-r.
\]

Substitution into Theorem 5.1 proves the second identity. $\square$

### Corollary 6.2 (defect-budget half-space)

Suppose the total flag cost and the total arithmetic budget satisfy

\[
 \sum_i d_i\le\sum_i B_i
\]

and

\[
 \sum_i B_i\le (m-h)+\varepsilon r+C.
\]

Then

\[
 h\le (1+\varepsilon)r+C.
\]

**Proof.** The first hypothesis and Proposition 6.1 give

\[
 m-r\le (m-h)+\varepsilon r+C.
\]

Cancellation of $m$ and rearrangement yield the asserted inequality.
$\square$

For fixed total budget, the admissible vectors $(B_1,\ldots,B_k)$ form a
half-space cut out by one sum inequality. Without sign constraints it is not a
simplex; its intersection with the nonnegative orthant is a simplex when the
right-hand side is nonnegative. This is the useful higher-dimensional
object: different mathematical routes may control different coordinates, but the
global theorem needs their summed cost to remain below the approximation
slack plus the abc allowance. Adding layers cannot create a saving by
itself, because the total defect is path-independent.

## 7. Counterexample boundary inside actual abc data

The natural universal strengthening $P_{\rm can}\le 3$ is false, even on a
primitive nonunit abc hit.

### Proposition 7.1 (complete arithmetic counterexample to the power-three cap)

For

\[
 3+125=128
\]

we have $\gcd(3,125)=1$,

\[
 M=3\cdot 125\cdot 128=48000,\qquad
 R=\operatorname{rad}(M)=30,
\]

and

\[
 P_{\rm can}=\frac{\log 48000}{\log 30}>3.
\]

**Proof.** The prime support of $M=2^7\cdot 3\cdot 5^3$ is
$\{2,3,5\}$, so $R=30$. Since

\[
 48000>27000=30^3,
\]

strict monotonicity of $\log$ gives
$\log 48000>3\log 30$; division by $\log 30>0$ proves the result.
$\square$

This counterexample retires only the universal power-three cap. It does not
retire the canonical gain route, the correlation barrier, any eventual
coefficient-two estimate, or the standard abc conjecture.

## 8. Reproducible finite search

`research/computation/2026_09_03_canonical_gain_surface/search_gain_surface.py`
enumerates every unordered primitive nonunit triple with $c\le 6000$. The
frozen run contains 5,465,583 triples. It found:

* zero failures of $1/3<A_{\rm can}<1/2$;
* 65 triples of quality greater than one;
* 14 triples with $P_{\rm can}>3$;
* maximum observed power gain about $3.78565$, at
  $(625,2048,2673)$;
* maximum observed quality about $1.42657$, at
  $(3,125,128)$.

All membership, coprimality, radical, and integer comparisons for the named
counterexample are exact. Floating-point values are descriptive only. The
finite search proves no asymptotic statement.

## 9. Exact open gate

The route remains active at the following unconditional arithmetic target.
For every $\varepsilon>0$, find a constant $C_\varepsilon$ such that every
primitive nonunit abc triple satisfies

\[
 \boxed{
   \sum_i d_i
   \le (m-h)+\varepsilon r+C_\varepsilon.
 }
\]

Equivalently, prove

\[
 X-Y\le\varepsilon+\frac{C_\varepsilon}{r}.
\]

This is exactly the standard abc inequality in the new coordinates, so the
coordinate change alone cannot solve the problem. Its value is structural:
it tells every proposed local, IUT, packet, Pell, or analytic contribution
where its cost must be placed and prevents unrelated constant bounds from
being mistaken for a coefficient-one theorem. No route is abandoned merely
because this correlation estimate is difficult.

For completeness, extend the flag definition to every positive pairwise
coprime abc point, including a unit arm. Let $h$ be its usual logarithmic
height, $r$ its radical log, and require a flag beginning at $r$ and ending
at $m=\log(abc)$. Call the **uniform defect-flag budget** the assertion that
for every $\varepsilon>0$ there is one constant $C_\varepsilon$, valid for
all such points, for which

\[
 \operatorname{cost}(\mathcal F)
 \le (m-h)+\varepsilon r+C_\varepsilon.
\]

### Proposition 9.1 (exact goal equivalence)

The uniform defect-flag budget is equivalent to the repository's logarithmic
`ABCConjecture`.

**Proof.** If the flag budget holds, path independence replaces its cost by
$m-r$. Cancelling $m$ gives
$h\le (1+\varepsilon)r+C_\varepsilon$, which is `ABCConjecture` after the
elementary identity $\max(a,b,c)=c$. Conversely, assume this logarithmic abc
inequality. Use the one-edge flag from $r$ to $m$. Its cost is $m-r$,
and rearranging the abc inequality gives exactly the required budget. The
constant and quantifiers are unchanged. $\square$

This equivalence is deliberately formalized: it prevents the new geometry
from being advertised as a proof. Progress on the route must establish the
uniform budget from independent arithmetic input.
