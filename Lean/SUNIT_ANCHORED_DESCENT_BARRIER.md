# Anchored descent for the rational S-unit equation: a strict audit

## 1. Question and boundary

Let

\[
 a+b=c,\qquad a,b,c>0,\qquad (a,b,c)\text{ pairwise coprime},
\]

and put

\[
 x=\frac ac,\qquad S=\operatorname{Supp}(abc),\qquad
 R_S=\prod_{p\in S}p,\qquad h=\log c,\qquad s=|S|.
\]

Then `x+(1-x)=1`, both summands are rational `S`-units, and the
previous rational-tripod module proves exactly

\[
 h(x)=\log c,\qquad
 \log R_S=\log\operatorname{rad}(abc).
\]

A fixed-`S` solution count does not by itself bound the largest height.  This
note tests a possible missing bridge: can one high solution canonically
generate sufficiently many further solutions on the same, or cheaply
enlarged, support?  The answer is negative for the standard tripod
symmetries, universal rational self-maps, Euclidean/continued-fraction
descent, elementary cross-ratio chains, and power chains.  The conclusion is
not that no arithmetic descent can exist.  It identifies the much stronger
output that a new descent would have to have.

No abc estimate, uniform S-unit height estimate, or descendant theorem is
assumed below.

## 2. The six tripod symmetries form a closed finite orbit

The automorphisms of the marked line

\[
 U=\mathbf P^1\setminus\{0,1,\infty\}
\]

give the six anharmonic coordinates

\[
 x,\quad 1-x,\quad x^{-1},\quad (1-x)^{-1},\quad
 \frac{x}{x-1},\quad\frac{x-1}{x}.
\]

At `x=a/c` they correspond to the following signed triples:

\[
\begin{array}{c|c}
f(x)&(A,B,C),\quad A+B=C\\ \hline
x&(a,b,c)\\
1-x&(b,a,c)\\
1/x&(c,-b,a)\\
1/(1-x)&(c,-a,b)\\
x/(x-1)&(-a,c,b)\\
(x-1)/x&(-b,c,a).
\end{array}
\]

Thus the prime support and the symmetric triple height
`max(|A|,|B|,|C|)=c` are unchanged.  Among positive triples, only the swap
of `a` and `b` remains.  More importantly, the two generators

\[
 s(x)=1-x,\qquad r(x)=x^{-1}
\]

permute this same six-element set.  Arbitrarily long words in `r,s` therefore
do not create a tree: their entire image has cardinality at most six.  Lean
formalizes this closure for every rational `x` different from `0,1`.

## 3. Rigidity of universal support-preserving rational maps

There is a geometric strengthening.  Let

\[
 f:\mathbf P^1\longrightarrow\mathbf P^1
\]

be a nonconstant rational map of degree `d`, and let

\[
 m=\#f^{-1}(\{0,1,\infty\})
\]

count distinct geometric points.  In each of the three fibers, the sum of
ramification indices is `d`; hence those fibers contribute

\[
 3d-m

\]

to the ramification divisor.  Riemann--Hurwitz gives

\[
 3d-m\le 2d-2,
 \qquad\text{so}\qquad m\ge d+2.                 \tag{3.1}
\]

Suppose now that `f` and `1-f` are both units in

\[
 \mathbf Q[t,t^{-1},(1-t)^{-1}].
\]

Equivalently, zeros and poles of `f` and `1-f` occur only at the original
tripod.  Then `m<=3`, and (3.1) forces `d=1`.  Such an `f` permutes
`0,1,infinity`, so it is one of the six transformations in Section 2.

For a genus-zero Belyi map all ramification occurs over the three marked
values, so equality holds in (3.1): its pulled-back puncture set has
`m=d+2` points, which is `d-1` more than a three-point tripod.  These points
need not contain the original domain tripod; the assertion is a cardinality
comparison, not a set inclusion.  After specializing `t=a/c`, the pulled-back
punctures become extra binary-form factors.  They cannot be silently treated
as primes from the original support.  This is the precise boundary between a
useful GenEll/Belyi construction and a same-support descendant construction.

## 4. Why a solution-dependent linear fractional map is not yet a descent

For

\[
 M=\begin{pmatrix}\alpha&\beta\\ \gamma&\delta\end{pmatrix}
 \in\operatorname{GL}_2(\mathbf Z),\qquad
 u=\frac{\alpha x+\beta}{\gamma x+\delta},
\]

the resulting integral forms are

\[
 A'=\alpha a+\beta c,\qquad
 C'=\gamma a+\delta c,\qquad
 B'=C'-A'.                                      \tag{4.1}
\]

The determinant condition preserves primitivity of `(A',C')`, but it does
not make the three forms in (4.1) `S`-units.  Their new prime divisors are
exactly the missing arithmetic issue.

Moreover, `GL_2(Z)` acts transitively on primitive integer column vectors:
extend `(a,c)` and any target `(A',C')` to unimodular bases and compose the
two basis changes.  Hence choosing a matrix depending on the input and
requiring (4.1) to be another same-`S` solution is equivalent to already
choosing another same-`S` solution.  The group action alone has not generated
one.

## 5. Euclidean descent: height decrease versus support explosion

Assume first `a>b`.  One subtractive Euclidean step is

\[
 (a,b,a+b)\longmapsto(a-b,b,a),
 \qquad
 \frac a{a+b}\longmapsto\frac{a-b}{a}=2-\frac1x.       \tag{5.1}
\]

It genuinely lowers the largest entry, but introduces the new factor
`a-b`.  If an odd prime `q` divides `a-b`, coprimality shows that it divides
neither `a`, `b`, nor `a+b`: a common divisor with one of `a,b` would divide
both, while a common divisor with `a+b` divides `2a`; oddness then reduces to
the same contradiction.

There is an unbounded actual family, not an abstract countermodel:

\[
 (q+1,1,q+2)
 \quad\longmapsto\quad
 (q,1,q+1)                                    \tag{5.2}
\]

for every odd prime `q`.  The new prime `q` divides the descended product
`q(q+1)` but does not divide the ancestor product `(q+1)(q+2)`.  Lean proves
both divisibility assertions and the rational-coordinate identity in (5.1).
Thus even the first step is not supported on the old `S`, and its new prime
cannot be confined to any fixed smooth set.

The long-chain version displays a sharper dichotomy:

\[
 (1,N,N+1)\to(1,N-1,N)\to\cdots\to(1,1,2).       \tag{5.3}
\]

The expanded subtractive algorithm has `N` triples and `N-1` subtraction
steps, but their combined support is exactly all primes at most `N+1`,
because the triples collectively contain every integer from `1` through
`N+1`.  Its logarithmic radical is therefore `theta(N+1)`, asymptotic to
`N`, whereas the original support has

\[
 \log\operatorname{rad}(N(N+1))\le2\log(N+1).
\]

If one compresses the large quotient instead, then

\[
 \frac1{N+1}=[0;N+1]
\]

has only one continued-fraction step.  Expanding produces many points and
destroys the support budget; compressing respects the computational descent
but produces no height-dependent multiplicity.

The same issue affects simple addition chains.  For example

\[
 F(t)=\frac{t}{1+t},\qquad F^j(t)=\frac{t}{1+jt}
\]

sends `1/(N+1)` to `1/(N+1+j)`.  It creates a long chain only by scanning
new consecutive numerators and denominators, whose union has uncontrolled
prime support.

## 6. Power chains and primitive prime divisors

The power construction gives an honest new solution

\[
 x^n+(1-x^n)=1,
 \qquad
 1-x^n=\frac{c^n-a^n}{c^n},
\]

but

\[
 c^n-a^n=(c-a)
 \prod_{\substack{e\mid n\\e>1}}\Phi_e(c,a).       \tag{6.1}
\]

For coprime positive `c>a` and `n>=3`, Bang--Zsigmondy gives a prime divisor
of `c^n-a^n` which divides no earlier `c^j-a^j`, hence divides none of
`a,c,c-a`.  In the exceptional pair `(c,a,n)=(2,1,6)`, the value `63`
still supplies `3` and `7`, both outside the old support `{2}`.  Thus every
power level `n>=3` introduces an old-support-external prime.

At `n=2`,

\[
 c^2-a^2=(c-a)(c+a).
\]

Since `gcd(c+a,ac)=1` and `gcd(c+a,c-a)` divides `2`, squaring preserves the
old support exactly when `c+a` is a power of `2`.  This explains isolated
examples such as

\[
 1+2=3\leadsto1+8=9,
 \qquad
 3+2=5\leadsto9+16=25,
\]

but gives no universal iteration.

If the first `K` power points are placed in one enlarged support, primitive
prime divisors at all but the classical exceptional levels give

\[
 |S^*\setminus S|\ge K-O(1).
\]

An exponential fixed-support count then says only
`K <= exp(O(K))`, which is vacuous.  The construction creates points and
support rank at the same time.

There is one limited positive direction.  If `x=A^n/C^n` is already a common
power, taking the root `A/C` does not enlarge support because
`C-A` divides `C^n-A^n`.  This removes a common exponent layer, but stops at
the point where the nonzero numerator/denominator valuation exponents have no
common divisor greater than one; in particular, any exponent-one place blocks
it.  Repeated root extraction has length at most `O(log log c)`, not the
exponential-in-excess multiplicity required here.  It is not the missing
varying-support estimate.

In characteristic `p`, by contrast,

\[
 1-t^{p^k}=(1-t)^{p^k}.
\]

Frobenius really does preserve the tripod while multiplying height.  The
inseparable-power exception in function-field abc is exactly the degeneration
which has no characteristic-zero analogue; Sections 3 and 6 explain the two
ways it is blocked in characteristic zero.

## 7. Gap and Thue--Mahler counts still need an anchor

A gap principle is an upper bound on how densely distinct solutions can
occupy a height interval.  A Thue--Mahler or S-unit theorem bounds how many
solutions a fixed support can have.  Neither assertion constructs a second
solution below an isolated high one.  The six symmetries provide only a
bounded equal-height cluster, and Euclidean descent exits the support.

For a concrete scale, the Beukers--Schlickewei theorem bounds solutions of
`u+v=1` in a multiplicative group of rank `r` by `2^(8(r+1))`.  For
`U_S x U_S`, whose rank is `2s`, this gives the schematic sharp-enough form

\[
 \#\mathcal T(S)\le 2^{16s+8},                    \tag{7.1}
\]

where `T(S)` denotes positive primitive triples supported in `S`.  The exact
constant is not the obstruction; the relevant feature is `exp(O(s))`.

A chain whose length is only proportional to `log c` combines with (7.1) to
give at best `log c <= exp(O(s))`, far too large.  To deduce
`log c <= log R_S+O(s)+o(log R_S)`, the number of descendants must instead be
linear in the multiplicative excess `c/R_S`, equivalently exponential in the
logarithmic excess `h-log R_S`.

## 8. The surviving count-to-height bridge

Within this strategy, a clean sufficient open proposition is the following.
There should be fixed constants `A>=1` and `B>=0` such that every
`(a,b,c)` in `T(S)` forces

\[
 \#\mathcal T(S)\ \ge\
 \frac{c}{R_S L(S)},
 \qquad
 L(S)=A^s\prod_{p\in S}(1+\log p)^B.             \tag{8.1}
\]

Combining (8.1) with (7.1) gives

\[
 c\le R_S\,2^8(2^{16}A)^s
       \prod_{p\in S}(1+\log p)^B.               \tag{8.2}
\]

After logarithms, every loss beyond `log R_S` is a sum of constant or
`log(1+log p)` local costs.  The smooth/rough support-entropy lemma absorbs
these into `epsilon log R_S+C_epsilon`, giving the abc coefficient
`1+epsilon`.

A more constructive sufficient version is a bounded additive descent.  Put
`D(S)=R_S L(S)`.  For every point `(a,b,c)` in `T(S)` with `c>D(S)`, construct
a distinct point of `T(S)` with height `c'` satisfying

\[
 0<c-c'\le D(S).                                  \tag{8.3}
\]

Strict integral height decrease makes iteration terminate.  If it takes `m`
steps to reach `c_m<=D(S)`, then `c-c_m<=mD(S)`; including the initial and
terminal points gives `m+1>=c/D(S)` distinct solutions, exactly (8.1).
Notice that (8.3) is a bound in multiplicative height.  A bounded decrement
of `log c` yields only `O(log c)` descendants and is insufficient.

Equation (8.1), or a mechanism proving it, is not established here.  It is
the minimal favorable interface for combining an `exp(O(s))` solution count
with the already formalized support-entropy optimizer.  The audit shows that
it cannot come from iterating the standard geometric or Euclidean formulas:
it would have to use new arithmetic information depending on the exponent
vector while still controlling every newly introduced prime.

## 9. Formal ledger

`IUTThreeClosures/SUnitAnchoredDescentBarrier.lean` proves:

1. the explicit rational tripod orbit has cardinality at most six;
2. complementation and inversion preserve that orbit;
3. every finite word in those generators remains in the same orbit;
4. the exact Euclidean-coordinate identity for the prime family (5.2);
5. `q` divides the descended product but, for odd prime `q`, not the ancestor
   product, and hence belongs only to the descended prime-factor support;
6. the numerical implication from exponential descendant proliferation and
   an exponential rank count to a linear excess bound.

The Riemann--Hurwitz, Zsigmondy, prime-number, and published S-unit-count
inputs are kept paper-side.  In particular, the Lean module contains no
field or hypothesis asserting a uniform S-unit theorem or abc.
