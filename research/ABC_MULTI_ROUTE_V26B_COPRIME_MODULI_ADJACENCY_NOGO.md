# ABC multi-route research note v26b: coprime power moduli can still be adjacent

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. General Bezout construction

Let `R,S` be coprime positive integers.  Choose integers `x,y` with

\[
Rx+Sy=1.
\]

For every integer parameter `t`, set

\[
M_t=R(-x+tS),
\qquad
C_t=S(y+tR).
\]

Then

\[
\boxed{R\mid M_t},
\qquad
\boxed{S\mid C_t},
\]

and a direct expansion gives

\[
\boxed{C_t-M_t=1.}
\]

For all sufficiently large `t`, both endpoints are positive.  Thus every pair
of coprime divisibility moduli occurs on an infinite affine family of positive
adjacent multiples.

## 2. Consequence for extracted power divisors

Suppose a proposed endpoint proof has extracted

\[
A^r\mid M,
\qquad
B^s\mid c,
\qquad
\gcd(A,B)=1.
\]

Taking

\[
R=A^r,
\qquad
S=B^s
\]

in the Bezout construction shows that such divisibility data alone are
compatible with gap one, regardless of how large `A`, `B`, `r`, and `s` are.

Therefore none of the following facts is, by itself, a pointwise obstruction:

- both endpoints contain large square divisors;
- one endpoint contains a large cube or higher-power divisor;
- the prescribed power moduli are coprime;
- the additive endpoint is extremely short.

The missing information is precisely the arithmetic of the residual
coefficients

\[
M/A^r,
\qquad
c/B^s.
\]

In the Bezout family these coefficients absorb the congruence and can carry a
large radical.  Any successful abc closure must bound or correlate that
residual radical rather than merely increase the extracted power depth.

## 3. Lean formalization

The construction is formalized over the integers in

```text
Lean/IUTThreeClosures/CoprimeModuliAdjacentNoGo.lean
```

with theorems

```lean
bezout_adjacent_multiples
bezout_adjacent_divisibility
bezout_adjacent_family
bezout_adjacent_positive
```

The module contains no `axiom`, `sorry`, or `admit` and assumes no abc
statement.
