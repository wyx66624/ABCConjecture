# Frey / modified-Szpiro route (offline mathematical audit)

## 1. Scope and status

Let (a,b,c\in \mathbf Z_{>0}) be pairwise coprime and satisfy
(a+b=c).  Put

\[
  H=a^2+ab+b^2,
  \qquad
  E:y^2=x(x-a)(x+b).
\]

This note separates three statements which must not be conflated.

1. The invariants and all height corridors below are unconditional.
2. A modified-Szpiro estimate of slope (6+\delta) for the displayed,
   source-derived Frey height implies abc by an elementary scalar argument.
3. That modified-Szpiro estimate is **not proved here**.  It is the remaining
   global arithmetic input on this route.  No Lean structure below contains it
   as a field, and no unconditional declaration asserts abc.

The note also gives strict endpoint-family obstructions to two tempting
shortcuts.  They rule out only direct use of the displayed discriminants; they
do not rule out Szpiro itself, changes elsewhere in an isogeny class, or other
global constructions.

## 2. A concrete modified Frey height

The integral Frey equation has

\[
 c_4(E)=16H,
 \qquad
 \Delta(E)=16(abc)^2.
\]

Define the positive integer and its logarithmic height

\[
 \mathcal M(E)
   =\max\bigl\{|c_4(E)|^3,|\Delta(E)|\bigr\}
   =\max\bigl\{4096H^3,16(abc)^2\bigr\},
 \qquad
 h_{\rm mod}(E)=\log \mathcal M(E).
\]

This is an actual invariant expression of the integral model, not a freely
chosen real function.  It obeys the following two-sided corridor.

**Proposition 2.1.**

\[
 6\log c\le h_{\rm mod}(E)
   \le 6\log c+\log 4096.
\]

**Proof.**  The already elementary identity (H=c^2-ab), together with
(ab\ge0), gives (H\le c^2).  Also
(c^2=(a+b)^2\le2(a^2+ab+b^2)=2H), so
(c^6\le8H^3\le4096H^3\le\mathcal M(E)).
For the reverse direction, (a,b\le c), hence
(16(abc)^2\le16c^6\le4096c^6), while
(4096H^3\le4096c^6).  Thus
(\mathcal M(E)\le4096c^6).  All quantities are positive, so applying
the increasing function (log) and using
(\log(c^6)=6\log c) proves the claim. (square)

The canonical rational Weil height (h(j(E))), already formalized elsewhere,
also satisfies (h(j(E))=6\log c+O(1)).  The present choice is useful because
its lower corridor has no error term.

## 3. Exact conditional reduction of abc

Let

\[
 N_\Delta(E)=\operatorname{rad}\bigl(16(abc)^2\bigr),
 \qquad n_\Delta(E)=\log N_\Delta(E).
\]

Its point-dependent prime support is exactly that of (abc), and the only
possible extra prime is (2).  Consequently

\[
 \log\operatorname{rad}(abc)
 \le n_\Delta(E)
 \le \log\operatorname{rad}(abc)+\log 2.
\]

The earlier module used the valid but coarser constant (log16); the Lean
module accompanying this note proves the sharpened (log2) bound directly
from radicals.

Fix (\varepsilon\ge0).  Suppose, for the particular Frey curve constructed
from the point, that the following explicit modified-Szpiro estimate is known:

\[
 h_{\rm mod}(E)
 \le (6+6\varepsilon)n_\Delta(E)+C.
 \tag{MS}_{\varepsilon,C}
\]

Then Proposition 2.1 and the conductor comparison give

\[
\begin{aligned}
 \log c
 &\le \frac16 h_{\rm mod}(E)\\
 &\le (1+\varepsilon)n_\Delta(E)+\frac C6\\
 &\le (1+\varepsilon)\log\operatorname{rad}(abc)
      +(1+\varepsilon)\log2+\frac C6.
\end{aligned}
\]

This is exactly the pointwise abc inequality.  If one constant (C) works
uniformly for all primitive triples, it gives the usual uniform abc statement.
The scalar implication is fully formalized; ((\mathrm{MS})_{\varepsilon,C})
itself remains the hard conjectural input.

## 4. Why the one-model discriminant shortcut loses a coefficient

Positive integers (a,b) satisfy

\[
 c=a+b\le2ab.
\]

It follows that

\[
 4c^4\le16(abc)^2=|\Delta(E)|.
\]

Thus a direct exponent-(6+\delta) upper bound on this discriminant yields,
using only this size comparison, a coefficient
((6+\delta)/4), tending to (3/2), rather than (1).
The exponent (4) is optimal uniformly: on the primitive endpoint family

\[
 (a,b,c)=(1,N,N+1)
\]

one has

\[
 |\Delta(E)|=16N^2(N+1)^2<16(N+1)^4.
\]

More sharply, for every proposed constant (K\in\mathbf Z_{\ge0}), choosing
(c=16K+2), (a=1), (b=c-1) gives

\[
 K|\Delta(E)|<c^5.
\]

Therefore no uniform lower estimate (c^5\le K|\Delta(E)|) can repair this
direct specialization.  This is a genuine counterexample to that shortcut,
not a counterexample to the global Szpiro conjecture.

## 5. The rational (2)-isogeny and its exact discriminant

Write the Frey equation as

\[
 y^2=x^3+Ax^2+Bx,
 \qquad A=b-a,\quad B=-ab.
\]

The rational point ((0,0)) has order two.  The standard degree-two quotient
model is

\[
 E':y^2=x^3-2Ax^2+(A^2-4B)x
    =x^3+2(a-b)x^2+c^2x.
\]

Away from the kernel, the rational map is

\[
 X=\frac{y^2}{x^2},
 \qquad
 Y=\frac{y(B-x^2)}{x^2}.
\]

Substitution, followed by use of
(y^2=x^3+Ax^2+Bx), gives

\[
 Y^2=X^3-2AX^2+(A^2-4B)X.
\]

The Lean file checks the cleared-denominator identity and independently
computes all Weierstrass invariants of the target model.  They are

\[
\begin{aligned}
 b_2(E')&=8(a-b),& b_4(E')&=2c^2,& b_6(E')&=0,& b_8(E')&=-c^4,\\
 c_4(E')&=16(a^2-14ab+b^2),
 &\Delta(E')&=-256abc^4.
\end{aligned}
\]

In particular, (E') is nonsingular.  The sign of the discriminant is part
of the exact calculation; its absolute value is

\[
 D_2=256abc^4.
\]

Since (c\le2ab),

\[
 128c^5\le D_2.
\]

So the analogous direct exponent-(6+\delta) argument improves the limiting
coefficient from (3/2) to (6/5), but still not to (1).  Again this is
optimal for this displayed quotient model: on ((1,N,N+1)),

\[
 D_2=256N(N+1)^4<256(N+1)^5,
\]

and for every (K\ge0), taking (c=256K+2) gives

\[
 K D_2<c^6.
\]

Thus there is no uniform sixth-power lower bound for this (2)-isogenous
discriminant.  The quotient improves, but does not close, the direct
coefficient gap.

## 6. Precise remaining target

The non-IUT Frey route is now reduced to a clean global estimate: prove a
uniform version of ((\mathrm{MS})_{\varepsilon,C}) for the actual quantity
(mathcal M(E)) (or equivalently a suitable canonical-height variant) and an
actual elliptic conductor.  The local radical proxy is already within the
absolute factor (2).  Neither the original displayed discriminant nor the
single rational (2)-isogenous displayed discriminant can replace that
modified-height estimate by a bare size argument, as the explicit primitive
endpoint family proves.
