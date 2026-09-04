# Global positive-part cubeful-excess no-go

**Author:** ChatGPT  
**Date:** 2026-08-30

This note gives the strict counterexample that eliminates the global target

\[
\log Q(\max(a,b)c)
\le 2\epsilon\log\operatorname{rad}(abc)+K_\epsilon,
\]

where

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}.
\]

It does **not** disprove the abc conjecture; it disproves only this proposed
strong intermediate estimate.

## Counterexample family

For `k>=3`, take the primitive abc triple

\[
1+(2^k-1)=2^k.
\]

The two large endpoints are

\[
M=2^k-1,
\qquad
c=2^k,
\]

so

\[
N=Mc=(2^k-1)2^k.
\]

Because `2^k-1` is odd,

\[
v_2(N)=k.
\]

The radical contains the prime `2` only to exponent one, so
`rad(N)^2` contains it only to exponent two. Hence

\[
v_2\!\left(\gcd(N,\operatorname{rad}(N)^2)\right)\le2
\]

and therefore

\[
\boxed{2^{k-2}\mid Q(N).}
\]

Thus

\[
\log Q(N)\ge(k-2)\log2.
\]

On the other hand,

\[
\operatorname{rad}(abc)
=
\operatorname{rad}((2^k-1)2^k)
\le2(2^k-1)<2^{k+1},
\]

so

\[
R=\log\operatorname{rad}(abc)<(k+1)\log2.
\]

Choose, for example, `epsilon=1/4`. Then

\[
\begin{aligned}
\log Q(N)-2\epsilon R
&>(k-2)\log2-
\frac12(k+1)\log2\\
&=\left(\frac{k}{2}-\frac52\right)\log2,
\end{aligned}
\]

which tends to infinity. No fixed constant `K_epsilon` can make the global
positive-part estimate true.

## Why signed surplus survives

The large odd endpoint contributes many exponent-one primes. The positive
part `Q(N)` discards their compensating negative contribution. The signed
quantity

\[
D_2(N)=\sum_{p\mid N}(v_p(N)-2)\log p
=
\log N-2\log\operatorname{rad}(N)
\]

retains it. This is why the signed aggregate-surplus route supersedes the
global `Q(N)` route.
