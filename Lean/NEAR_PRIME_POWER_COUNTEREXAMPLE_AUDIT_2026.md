# Near-prime-power counterexample route: corrected exponent and extraction gates

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** rigorous audit and conditional reduction; no claim that abc is false

## 1. Candidate construction

Let

\[
x=p^k,\qquad c=x+a,\qquad 0<a\le x^\theta,
\]

where `p` is prime and `p\nmid c`.  Assume that the radical of `c` obeys

\[
\log \operatorname{rad}(c)\le (\eta+o(1))\log x.
\]

Then

\[
\operatorname{rad}(a p^k c)
 \le a\,p\,\operatorname{rad}(c)
 \le x^{\theta+1/k+\eta+o(1)}.
\]

Consequently, to defeat the exponent `1+epsilon` one needs

\[
\boxed{(1+\varepsilon)(\theta+1/k+\eta)<1.}
\]

This is the correct logarithmic slope condition.

## 2. A distinct exponent error

A recent proposed construction instead displays a condition of the form

\[
(\theta+1/k)^{1+\varepsilon}<1.
\]

This does not control the exponent appearing after raising the radical to
`1+epsilon`.  An exact counterexample is

\[
\theta=\frac35,\qquad k=5,\qquad\varepsilon=1.
\]

Then

\[
\left(\frac35+\frac15\right)^2=\frac{16}{25}<1,
\]

but

\[
(1+1)\left(\frac35+\frac15\right)=\frac85>1.
\]

Thus the displayed power condition can hold while the required logarithmic
gap is negative.  Lean theorem:

```lean
displayed_power_condition_is_insufficient
```

## 3. Exact `theta=3/5` threshold

For positive real `k`, elementary algebra gives

\[
(1+\varepsilon)\left(\frac35+\frac1k\right)<1
\quad\Longleftrightarrow\quad
5(1+\varepsilon)<k(2-3\varepsilon).
\]

Hence:

- if `epsilon >= 2/3`, no positive `k` works even before the radical of `c`
  is charged;
- if `0<epsilon<2/3`, `k` must be chosen larger than

\[
\frac{5(1+\varepsilon)}{2-3\varepsilon};
\]

- every positive smooth-radical slope `eta` increases this threshold.

For example, `epsilon=1/10` and `k=4` give

\[
\left(1+\frac1{10}\right)
\left(\frac35+\frac14\right)=\frac{187}{200}<1.
\]

The Lean module proves the equivalence and these concrete ledgers without any
number-theory hypothesis.

## 4. Remaining extraction gate

For the short-interval smooth-number strategy, let

\[
S_x=\{n\in[x,x+h]:P^+(n)\le y\}
\]

and let

\[
B_x=\{n\in S_x:\omega(n)>w\}.
\]

The smooth-number asymptotic has main term

\[
\#S_x\sim h\rho(u),\qquad \rho(u)\to0.
\]

To extract a usable `c`, one must prove

\[
\#B_x<\#S_x,
\]

and an asymptotic sufficient condition is

\[
\boxed{\#B_x=o(h\rho(u)).}
\]

The weaker estimate `#B_x=o(h)` is not sufficient because the smooth main
term itself has vanishing density in the ambient interval.  This logical gap
is formalized separately in

```lean
SmoothMainTermScaleAudit.lean
```

## 5. Correct conditional disproof theorem

Fix `theta`, an integer `k>=2`, and `epsilon>0`.  Suppose there are infinitely
many primes `p` for which an integer `c` satisfies

\[
p^k<c\le p^k+(p^k)^\theta,
\qquad p\nmid c,
\]

and

\[
\log\operatorname{rad}(c)\le(\eta+o(1))\log(p^k),
\]

where

\[
(1+\varepsilon)(\theta+1/k+\eta)<1.
\]

Then the triples

\[
(a,b,c)=(c-p^k,p^k,c)
\]

form an unbounded primitive family for which

\[
\frac{c}{\operatorname{rad}(abc)^{1+\varepsilon}}
\to\infty.
\]

Therefore the logarithmic `ABCConjecture` is false.  The generic final
implication is formalized in

```lean
SubcriticalRadicalSlopeDisproofGate.lean
```

The unresolved analytic-number-theory problem is the construction of the
required low-radical smooth integer `c` on an infinite prime-power subsequence.

## 6. Route verdict

The near-prime-power route remains mathematically viable after replacing the
incorrect exponent condition and the ambient-scale extraction argument.  It
has not produced an unconditional counterexample family.  Future work must
attack the relative local distribution

\[
\#\{n\in[x,x+h]:P^+(n)\le y,\ \omega(n)>w\}
=o(h\rho(u))
\]

or find a different mechanism that directly controls
`rad(c)` rather than only the largest prime factor of `c`.
